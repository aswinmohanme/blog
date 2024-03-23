// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"

let Hooks = {}
Hooks.PrependHashesToHeadings = {
  updated() {
    this.prependHashes()
  },
  mounted() {
    this.prependHashes()
  },
  prependHashes() {
    let h1Tags = this.el.querySelectorAll('h1');
    h1Tags.forEach(tag => {
      let span = document.createElement('span');
      span.textContent = 'ooo';
      span.classList.add("mr-2","md:-ml-10", "text-yellow-600")
      tag.insertBefore(span, tag.firstChild);
    });

    let h2Tags = this.el.querySelectorAll('h2');
    h2Tags.forEach(tag => {
      let span = document.createElement('span');
      span.textContent = 'oo';
      span.classList.add("mr-2", "md:-ml-7", "text-yellow-600")
      tag.insertBefore(span, tag.firstChild);
    });

    let h3Tags = this.el.querySelectorAll('h3');
    h3Tags.forEach(tag => {
      let span = document.createElement('span');
      span.textContent = 'o';
      span.classList.add("mr-2", "text-yellow-600")
      tag.insertBefore(span, tag.firstChild);
    });
  }

}


let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {hooks: Hooks, params: {_csrf_token: csrfToken}})

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: "#fde047" }, shadowColor: "rgba(0, 0, 0, .3)" })
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

