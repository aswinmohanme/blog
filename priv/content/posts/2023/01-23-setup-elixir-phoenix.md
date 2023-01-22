%{
  title: "How to setup Elixir, Phoenix and Postgresql on MacOS",
  tags: ~w(tailwindcss design),
  description: "Learn how to setup Elixir, Phoenix and Postgres on your mac. We'll be using Homebrew and ASDF.",
  draft: true
}
---

Setting up your machine for development is the one tasks you do even before you start writing a single line of code. With the advent of package managers setting up your development environment has become considerably easier. In this post we'll look into how to setup your macOS machine for Elixir and Phoenix development using Homebrew and ASDF.

## Setup Tools
This guide assumes you have a fresh mac and we'll setup everything from the start. If you have already setup any of the tools mentioned feel free to skip that part. 

### Before installation
If you have your M1 mac setup with rosetta, make sure to run the installation process on a native terminal to prevent segmentation faults.

### Setup Homebrew
Homebrew is the de-facto package manager on macOS. You can install most packages required for development and other applications with a single command. Follow the official instructions at [brew.sh](https://brew.sh) and setup Homebrew on the machine. The script will install XCode Command Line tools and setup the Homebrew directory on `/opt/homebrew`.

### Setup ASDF
Development requires multiple language runtimes to be present on the system. Multiple projects also require multiple versions of the same environment to be present. Previously we had to setup multiple tools to manage multiple environments, like `rbenv` for ruby, `nvm` for nodejs, each with it's own configurations and usage syntax. This lead to a lot of conflicts between the tools. ASDF is a single package manager with a plugin interface that can handle multiple languages and thier versions. ASDF keeps the versions of the different tools used in a `.tool-versions` file in the directory. We are going to use ASDF to setup Elixir and Erlang globally.

Head on over to [asdf-vm.com/guide/getting-started.html](https://asdf-vm.com/guide/getting-started.html) and setup ASDF.

1. Use Homebrew to install the dependencies
2. Prefer the official git method for installation, as ASDF would then manage itself.
3. Select what Shell you use and setup the script properly. This sets the path correctly for the different tools.


## Setup Erlang and Elixir
Elixir is built on top of Erlang. So we have to setup Erlang first and then setup Elixir.

### Setup Erlang
* Install the Erlang plugin and dependencies for ASDF. Open your shell and type these commands.

    ```
    asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
    ```

* ASDF downloads source files and compiles Erlang on our machine. Install required dependencies for it. OpenSSL is required for secure communication and WxWidgets is needed for rendering out the debugger and observer. Even if you have OpenSSL installed, you need version `1.1`.

    ```
    brew install openssl@1.1 wxwidgets
    ```

* Optional: Since Erlang is compiled on our machine, it is recommended to set compile time flags to get an optimal binary. Erlang compile time flags are configured by setting the `KERL_CONFIGURE_OPTIONS` shell function. The below flags are used by [Jose Valim](https://twitter.com/josevalim/status/1507608988577316865?lang=en). These flags disable linking with Java, which is only required if you want to interface with Java.

    ```
    export KERL_CONFIGURE_OPTIONS="--disable-debug --disable-silent-rules --without-javac --enable-shared-zlib --enable-dynamic-ssl-lib --enable-threads --enable-kernel-poll --enable-wx --enable-webview --enable-darwin-64bit --enable-gettimeofday-as-os-system-time --with-ssl=$(brew --prefix openssl@1.1)" KERL_BUILD_DOCS="yes"
    ```

* Download and install the latest version of Erlang and set it as the default global version.

    ```
    # Downloads and installs the latest version
    asdf install erlang latest
    
    # Sets the global version of Erlang
    asdf global erlang latest
    ```

    You can install specific version of Erlang if you want to. This is useful when you want to install older versions of Elixir that are tied to specific OTP versions.

    ```
    # Lists all the erlang versions
    asdf list-all erlang
    
    asdf install erlang 25.2

    asdf global erlang 25.2
    ```
    

### Setup Elixir
Every Elixir version has a list of Erlang versions that it supports. ASDF Elixir downloads precompiled versions of the runtime. When installing Elixir version make sure you have a corresponding Erlang version installed first.

* Check which version of Erlang is installed on your system.
  ```
  asdf list erlang
  ```
  
  Take a note of the version number, which might come out as `25.2`. That means we have OTP version `25` installed by our system.


* List all available Elixir versions from ASDF

    ```
    asdf list-all elixir
    
    ...
    1.14.2-otp-23
    1.14.2-otp-24
    1.14.2-otp-25
    1.14.3
    1.14.3-otp-23
    1.14.3-otp-24
    1.14.3-otp-25
    main
    main-otp-22
    main-otp-23
    main-otp-24
    main-otp-25
    master
    master-otp-21
    master-otp-22
    master-otp-23
    master-otp-24
    ```

* Install Elixir

    Since we have the OTP version `25` installed, we'll select the latest version that has been compiled with the OTP release.
    ```
    asdf install elixir 1.14.3-otp-25

    asdf global elixir 1.14.3-otp-25
    ```
    
*  Validate if the installation has succeeded

    Run `iex` to make sure the installation is successful.


## Setting up Phoenix and Postgresql

Since we have setup Elixir we can setup Phoenix and Postgresql.


### Setup Phoenix

* Before setting up Phoenix, reshim ASDF so the binaries are all linked up properly.

    ```
    asdf reshim elixir
    ```

* Install Hex

    Hex is the package manager for Elixir and Erlang and `mix` is the tool for managing dependencies. You have to set it up to download Phoenix. Running this command installs or upgrades hex.
    
    ```
    mix local.hex
    ```

* Install Phoenix project generators.

    ```
    mix archive.install hex phx_new
    ```

### Setup Postgresql

Postgresql is the database of choice for new Phoenix apps. You have to set it up so you have access to a database on your developing machine.

* Install Postgresql using Homebrew. We are using the latest version of Postgres. This installs the Postgresql and starts the service that runs in the background.
  
    ```
    brew install postgresql@15
    ```
  
  Restart Postgres to make sure the service is running. You only have to do this once.
    ```
    brew services restart postgresql@15  
    ```

* Create the default postgres user. Phoenix expects a default Postgres user to be present. Run `createuser` to create the user, make sure to substitute the version of Postgres.

    ```
     /opt/homebrew/opt/postgresql@15/bin/createuser -d postgres
    ```

## Test Installation

To make sure we have everything installed properly, we are going to create a new test Phoenix project.

* Run `mix phx.new test` in any directory. Answer `y` when prompted to install dependencies.
* Change into the directory and run `mix ecto.setup` to setup the database.
* Run `mix phx.server` in the directory. You will have your Phoenix server running on [http://localhost:4000](http://localhost:4000).

Congrats, you just setup Elixir and Phoenix on your mac. Now it's time to make something with it.


## Bonus: Setup NodeJS

Even though we don't need NodeJS to get started with a Phoenix project, we may need it down the line to install Javascript dependencies from NPM. Since we already have ASDF setup, NodeJS is just two install commands away.

* Add NodeJS Plugin to ASDF

    ```
    asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    ```
    
* Install and set the latest LTS version. The LTS version will be the most stable and supported one.

    ```
    asdf install nodejs lts
    
    asdf global nodejs lts
    
    asdf reshim nodejs
    ```

That's it. You now have NodeJS setup in your system as well. You can now use `npm` to install new packages from NPM to your project.


### Resources

1. Homebrew - [https://brew.sh](https://brew.sh)
2. ASDF Setup - [https://asdf-vm.com/guide/getting-started.html](https://asdf-vm.com/guide/getting-started.html)
3. ASDF Erlang - [https://github.com/asdf-vm/asdf-erlang](https://github.com/asdf-vm/asdf-erlang)
4. ASDF Elixir - [https://github.com/asdf-vm/asdf-elixir](https://github.com/asdf-vm/asdf-elixir)
5. Phoenix Getting Started - [https://hexdocs.pm/phoenix/installation.html](https://hexdocs.pm/phoenix/installation.html)
6. ASDF NodeJS - [https://github.com/asdf-vm/asdf-nodejs](https://github.com/asdf-vm/asdf-nodejs)
