%{
  title: "Page Specific Javascript with Phoenix LiveView and Esbuild",
  rating: 1,
  tags: ~w(phoenix liveview javascript),
  description: "Learn how to split your LiveView Javascript pagewise with esbuild, so your main app.js file stays small and people only download and execute the javascript they require.",
}
---


<section>
      <p>
        LiveView has a minimal Javascript footprint, but if you're building a
        client heavy app it can change. While building IndiePaper I implemented
        the realtime editor using JS hooks. This caused the
        <code> app.js </code> file to be around 1.4 MB. Since this file is
        loaded on every page, it wasted bandwidth and CPU time even when people
        didn't use the editor. This post outlines the technique I used to split
        the JS code and only load the required parts for each page.
      </p>
        <h2>Code Splitting and Dynamic Imports</h2>
        <p>
          Phoenix uses <code>esbuild</code> to bundle assets. Bundling is the
          process of taking code in separate modules and combining it into a
          single file, minifying and converting it to standard Javascript in the
          process. This is why <code>app.js</code> increases in size when we
          import more node modules. We can reduce the size by splitting the
          files based on the pages that require it and dynamically load the
          required parts only when needed.
        </p>

        <h3>Starting point</h3>
        <p>
          Consider that we have a LiveView app with two pages, one being a JS
          heavy text editor using <a href="https://tiptap.dev">TipTap</a> .
          Initially we are going to have all the code reside in the
          <code> app.js </code> file.
        </p>
        <pre>
import { Editor } from "@tiptap/core";
import StarterKit from "@tiptap/starter-kit";

...

let Hooks = {};
Hooks.SimpleTipTapHtmlEditor = {
  mounted() {
    const contentHTMLElementId = this.el.dataset.contentHtmlElementId;
    const editorElementId = this.el.dataset.editorElementId;

    window.tipTapHtmlEditor = new Editor({
      element: editorElement,
      content: contentHTMLElement.value,
    };
};

let liveSocket = new LiveSocket(socketHost, Socket, {
  params: { _csrf_token: csrfToken },
  hooks: Hooks});
        </pre>
        <p>
          This increases the size of the <code> app.js </code> file. Even though
          the code is only required in the editor page, it is downloaded and
          executed on every page.
        </p>

        <h3>Refactor to Modules</h3>
        <p>
          First step is to extract the code for the editor to a new function,
          export it from a new file <code> simple-editor.js </code> and include
          that in <code>app.js</code>.
        </p>
        <pre>
# simple-editor.js
import { Editor } from "@tiptap/core";
import StarterKit from "@tiptap/starter-kit";

export function setupSimpleTipTapHtmlEditor(
  contentHTMLElementId,
  editorElementId
) {
  const contentHTMLElement = document.getElementById(contentHTMLElementId);
  const editorElement = document.getElementById(editorElementId);

  window.tipTapHtmlEditor = new Editor({
    element: editorElement,
    content: contentHTMLElement.value,
  });
}
        </pre>
        <h3>Setup Dynamic Import</h3>
        <p>
          Import that file in <code> app.js </code> and replace with the hook
          with the dynamic function call, and remove the old imports from the
          top.
        </p>
        <pre>
# app.js
let Hooks = {};
Hooks.SimpleTipTapHtmlEditor = {
  mounted() {
    const contentHTMLElementId = this.el.dataset.contentHtmlElementId;
    const editorElementId = this.el.dataset.editorElementId;

    import("./simple-editor").then(
      ({ setupSimpleTipTapHtmlEditor }) => {
        setupSimpleTipTapHtmlEditor(contentHTMLElementId, editorElementId);
      }
    );
  },
};
        </pre>
        <p>
          The <code> import </code> statement has a different promise based form
          here. When the import is encountered, the chunk of code is fetched
          dynamically and then executed.
        </p>

        <h3>Setup Esbuild Chunking</h3>
        <p>
          When we enable Esbuild chunks, rather than bundling everything
          together, Esbuild creates different <code> chunk </code> files.
          Esbuild in Phoenix is configured with editing
          <code> config/config.exs </code>
        </p>
        <pre>
# config.exs
...

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.0",
  default: [
    args: ~w(js/app.js js/simple-editor.js
        --chunk-names=chunks/[name]-[hash] --splitting --format=esm --bundle --target=es2017 --minify
        --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

        </pre>
        <p>
          We have added the file <code> js/simple-editor.js </code> to list of
          files, and added a set of options to enable splitting.
        </p>
        <pre>
--chunk-names=chunks/[name]-[hash] --splitting --format=esm --bundle --target=es2017 --minify
        </pre>
        <h3>Import as module</h3>
        <p>
          Finally you have to set the import of <code> app.js </code> in your
          <code> root.html.heex </code> as a module.
        </p>
        <pre>
&lt;script type=&quot;module&quot; defer phx-track-static type=&quot;text/javascript&quot; src={Routes.static_path(@conn, &quot;/assets/app.js&quot;)}&gt;&lt;/script&gt;
        </pre>
      </section>
      <section>
        <h2>Extra bits</h2>
        <p>
          When you load JS files dynamically, there are some gotchas that you
          have to look out for.
        </p>
        <h3>Loading Delay</h3>
        <p>
          Dynamically loaded modules will only start fetching after
          <code> app.js </code> file has started executing. This leads to a
          slight delay, so it's better to inline critical parts in the file
          itself.
        </p>
        <p>
          If you prefer, you can show a loading indicator while the file is
          being downloaded. The example setup requires
          <a href="https://alpinejs.dev/">AlpineJS</a>. We declare
          <code> isLoading </code> on the element where the hook is added and
          set it to true. We use that Alpine variable to show a loading
          indicator. We disable the loading indicator when we recieve an event
          through <code> x-on:hook-loaded </code>
        </p>
        <pre>
# Element where Hook is loaded
&lt;div id=&quot;hook_element&quot;
  phx-hook=&quot;SimpleHook&quot;
  x-data=&quot;{isLoading: true}&quot;
  x-on:hook-loaded=&quot;isLoading = false&quot;&gt;
  &lt;p x-show=&quot;isLoading&quot;&gt;Loading Indicator&lt;/p&gt;
  ...
&lt;/div&gt;
        </pre>
        <p>
          When mounting the Hook, we have to sent a
          <code> hook-loaded </code> event to Alpine.
        </p>
        <pre>
# simple-editor.js
function sendEditorLoaded() {
  let event = new CustomEvent("hook-loaded", {});
  context.el.dispatchEvent(event);
}

export function setupSimpleTipTapHtmlEditor(
  contentHTMLElementId,
  editorElementId
) {
  ...

  sendEditorLoaded();
}
        </pre>
      </section>
      <section>
        <h2>Conclusion</h2>
        <p>
          With this setup, whenever you include a new Hook in a LiveView page,
          the corresponding module gets dynamically imported. The modules are
          chunked automatically and loaded on demand. This leads to only the
          pages that require the Javascript downloading and executing it.
        </p>
</section>
