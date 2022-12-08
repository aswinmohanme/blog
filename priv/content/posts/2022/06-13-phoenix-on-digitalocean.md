
%{
  title: "How to Deploy your Phoenix LiveView 1.6 app on Digital Ocean with Docker",
  tags: ~w(phoenix liveview javascript),
  description: "Learn how you can deploy your Phoenix and LiveView based Elixir apps on the Digital Ocean App platform with Docker.
",
}
---

<section>
      <p>
        One of my clients had a requirement that the LiveView app that I was
        building for them be hosted on Digital Ocean. I had never hosted an
        entire app on Digital Ocean, although I had experience with Spaces an S3
        alternative from Digital Ocean. Turns out, with the new App Platform it
        is easy to wire up the github repo and deploy the app as a docker
        container.
      </p>
      <p>
        This post outlines the steps required to host your existing Phoenix
        LiveView apps on the Digital Ocean App platform.
      </p>
      <h2>Setting up and Configuring Phoenix</h2>
      <p>
        Assuming you have a Phoenix 1.6 let's dockerize it and host it on the
        <a href="https://www.digitalocean.com/products/app-platform"
          >Digital Ocean App Platform</a
        >. Phoenix 1.6 ships with a <code>phx.gen.release</code> mix task to
        generate the files to dockerize the app, run migrations and start the
        server.
      </p>
      <h3>0️⃣ Phoenix LiveView or Vanilla App</h3>
      <p>
        You should have an existing Phoenix 1.6 app. This guide works for both
        Vanilla and Liveview based app.
      </p>
      <h3>1️⃣ Dockerize the application</h3>
      <p>
        In the root directory of the project run
        <code>mix phx.gen.release --docker</code> which generates the required
        files to dockerize the app.
      </p>
      <pre>
* creating rel/overlays/bin/server
* creating rel/overlays/bin/server.bat
* creating rel/overlays/bin/migrate
* creating rel/overlays/bin/migrate.bat
* creating lib/digital_ocean_deploy/release.ex
* creating Dockerfile
* creating .dockerignore
        </pre
      >
      <ul>
        <li><code>server</code> : Starts the server in production</li>
        <li>
          <code>migrate</code> : Runs the database migrations in production
        </li>
        <li>
          <code>release.ex</code> : Once the application is compiled and built
          we won't have access to mix tasks on the server. This file includes
          code to performs migrations and rollbacks on the database without
          invoking mix. This function is called in the
          <code> migrate </code> file.
        </li>
        <li>
          <code> Dockerfile </code> : Dockerfile to build and deploy the app as
          a container.
        </li>
        <li>
          <code> .dockerignore </code> : Standard files to be ignored by docker.
        </li>
      </ul>
      <h3>2️⃣ Configure SSL connection to Database</h3>
      <p>
        DigitalOcean only allows encrypted SSL connection between the
        application and the database. Ecto supports SSL based connection , but
        it is disabled out of the box.
      </p>
      <p>
        Open up <code>runtime.exs</code>. This file contains the runtime
        configuration of the language. Configuration here is not compiled into
        the release.
      </p>
      <pre>
maybe_ipv6 = if System.get_env("ECTO_IPV6"), do: [:inet6], else: []

config :digital_ocean_deploy, DigitalOceanDeploy.Repo,
  ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  socket_options: maybe_ipv6
      </pre>
      <p>
        Uncomment <code>ssl: true</code>. If you have
        <code>socket_options: [:inet6]</code> instead of the
        <code>maybe_ipv6</code> shown here, you have to replace it with
        <code>socket_options: [ ]</code>. Doing so makes Ecto connect to the
        database through SSL.
      </p>
      <p>
        Since connections to the database happen over SSL, we have to make sure
        SSL is started in the migrate function. In the
        <code> release.ex </code> file.
      </p>
      <pre>
  defp load_app do
    Application.ensure_all_started(:ssl)
    Application.load(@app)
  end
      </pre>
      <h3>3️⃣ Run Migrations before Server start</h3>
      <p>
        In the current setup, we have to manually run the migration script after
        pushing any updates to the server. This is tedious, error prone and
        unneccessary. We will update the script to run the migration before
        every server start.
      </p>
      <p>Replace the last line of <code>Dockerfile</code>.</p>
      <pre>
USER nobody

CMD ["/app/bin/start"]
      </pre>
      <p>
        Create a <code>start</code> script in
        <code>rel/overlays/bin/start</code> to run the migration first and then
        start the server.
      </p>
      <pre>
#!/bin/sh
cd -P -- "$(dirname -- "$0")"
./migrate && ./server
      </pre>
      <p>Now make it executable with</p>
      <pre>
chmod +x rel/overlays/bin/start
      </pre>
      <h2>Setup Digital Ocean App</h2>
      <p>
        Now it's time to setup the server on Digital Ocean App platform. Unlike
        bare metal servers, Apps are managed by Digital Ocean akin to Heroku. We
        are going to create a new app that connects to our Github repo, builds
        our app and releases a new version on every update.
      </p>
      <h3>4️⃣ Create a Github or Gitlab repo and upload your code</h3>
      <p>
        Upload your code to Github or Gitab. We are going to connect this repo
        to Digital Ocean.
      </p>
      <h3>5️⃣ Create a new Digital Ocean App and deploy</h3>
      <p>
        Create a new app and link it to the repo we created in the last step.
      </p>
      <ul>
        <li>
          <p>
            Go to
            <a href="https://cloud.digitalocean.com/projects">Digital Ocean</a>
            and click Apps button from the Create dropdown.
          </p>
          <img
            src="../images/create-app.jpg"
            alt="Create a new app by clicking on Create, Apps link"
          />
        </li>
        <li>
          <p>
            Connect Github or Gitlab where you have hosted the repo.Give Digital
            Ocean read access to the repo.
          </p>
          <img
            src="../images/manage-access.jpg"
            alt="Create a new app by clicking on Create, Apps link"
          />
          <img
            src="../images/github-connect.jpg"
            alt="Create a new app by clicking on Create, Apps link"
          />
        </li>
        <li>
          <p>
            Set the branch which you want to build from. When building
            production apps, I create two apps. One to deploy from the
            <code>develop</code> branch for the staging environment, and
            <code>master</code> for production. Make sure
            <code>Autodeploy</code> is checked, so when you push to the repo the
            app gets rebuilt automatically.
          </p>
          <img
            src="../images/setup-autodeploy.jpg"
            alt="Create a new app by clicking on Create, Apps link"
          />
        </li>
        <li>
          <p>
            You can click the <code>Edit Plan</code> button to change the
            pricing of the instance. If you're building a test system, you can
            provision a smaller instance for $5.00. Click the
            <code>Add Resource</code> button to create a database.
          </p>
          <img
            src="../images/add-db.jpg"
            alt="Create a new app by clicking on Create, Apps link"
          />
        </li>
        <li>
          <p>
            Remember the name that you give your database, we'll need that
            later. Create and Attach that database to our app.
          </p>
          <img
            src="../images/attach-db.jpg"
            alt="Create a new app by clicking on Create, Apps link"
          />
        </li>
        <li>
          <p>
            We can skip configuring the Environment for now. This will cause our
            first deployment to fail, but we'll fix it later. Click Next.
          </p>
          <img
            src="../images/skip-env-vars.jpg"
            alt="Create a new app by clicking on Create, Apps link"
          />
        </li>
        <li>
          <p>
            You can change the region and the name of app here. Changing the
            name changes the free subdomain Digital Ocean gives you. It's best
            to host the app in the region closest to your users for best
            performance.
          </p>
          <img
            src="../images/info.jpg"
            alt="Create a new app by clicking on Create, Apps link"
          />
        </li>
        <li>
          <p>
            Once you have confirmed the cost of the app, click Create Resource.
            Digital Ocean will then clone your repo and start building.
          </p>
          <img
            src="../images/create-resource.jpg"
            alt="Create a new app by clicking on Create, Apps link"
          />
        </li>
      </ul>
      <h3>6️⃣ Setup Environment</h3>
      <p>
        The first deployment of our app will fail since we haven't setup the
        Environment variables.
      </p>
      <p>
        Go to the settings page and click on the server component. Also note the
        name of the database we have setup.
      </p>
      <img src="../images/settings.jpg" alt="Settings page for the app" />
      <p>
        Scroll down to the Environment Variables section and click
        <code>Edit</code>
      </p>
      <img
        src="../images/env-vars-empty.jpg"
        alt="Settings page for the app"
      />
      <p>
        For a LiveView app to function properly we need three environment
        secrets that we need to provide.
      </p>
      <ul>
        <li>
          <code>SECRET_KEY_BASE</code> : Used by Phoenix to sign your assets.
          Generate the value by running <code>mix phx.gen.secret</code> in the
          root of your project.
        </li>
        <li>
          <code>DATABASE_URL</code> : Used by Phoenix to communicate with the
          database. Since we are provisioning a database with the app from
          Digital Ocean itself, we can connect it through Digital Ocean. In the
          values field add <code>${db.DATABASE_URL}</code> replacing
          <code>db</code> with the name of your database.
        </li>
      </ul>
      <p>Click Save and wait for the app to finish building.</p>
      <img
        src="../images/env-vars-filled.jpg"
        alt="Settings page for the app"
      />
      <p>
        Once the App has finished buildling, it will be deployed with a Digitial
        Ocean subdomain. You have to add that domain or your custom domain to
        the <code>PHX_HOST</code> variable.
      </p>
      <img src="../images/phx-host.jpg" alt="Settings page for the app" />
      <p>
        Without adding this, your LiveView Websocket will not be connected.
        Adding a new variable will rebulid the site and redeploy it.
      </p>
      <h2>Wrapping Up</h2>
      <p>
        With Docker and managed platforms such as Digital Ocean it is really
        easy to deploy your Phoenix app to the cloud easily.
      </p>
      <h3>Production Tips</h3>
      <ul>
        <li>
          Upgrade Database to a Production version: Currently we are running a
          development database with no backups and standby nodes. Digital Ocean
          has managed Postgres databases.
        </li>
        <li>
          Setup a Staging Environment: Create an identical app, but deploy it
          from the <code>develop</code> branch to have a staging environment.
          Keep <code>master</code> as the branch that holds the production code.
        </li>
      </ul>
      <p>Happy Deploying.</p>
      <h3>References</h3>
      <ul>
        <li>
          <a
            href="https://blog.miguelcoba.com/deploying-an-elixir-release-using-docker-on-digitalocean"
          >
            Deploying an Elixir Release using Docker on DigitalOcean
          </a>
        </li>
      </ul>
</section>
