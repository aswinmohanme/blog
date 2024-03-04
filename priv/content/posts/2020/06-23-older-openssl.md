%{
  title: "Compiling OpenSSL 1.0 for older package versions",
  tags: ~w(code elixir python),
  description: "This post explains how to compile older openssl packages when you want to run old runtimes from ASDF.",
}
---

Running older versions of software is always a pain. There will be missing libraries, compilation errors and what not. These issues can be mitigated little by using a package manager that manages the different versions of the software. But most package managers such as `asdf` download the source (yea OSS) and compile on your machine.

Most of the tools and libraries work really good, but there is one error that keeps coming again and again.

## OpenSSL 1.0 to 1.1 Migration
OpenSSL is the defacto library for TLS and SSL protocols and is used by almost all programs that interact with the internet. They are a compile time dependency for a lot of programs and tools. For improved security OpenSSL migrated from 1.0 to 1.1 with a lot of breaking changes. Since OpenSSL handles critical security measures all the distros started pushing the latest version. This causes a new problem for older libraries.

For example python 3.5 requires OpenSSL 1.0 and it fails with the latest 1.1 release of it.

## Compiling OpenSSL 1.0 locallly
We need to compile OpenSSL ourselves and put it somewhere from which we can access it when required.

```
curl https://www.openssl.org/source/openssl-1.0.2r.tar.gz  | tar xfz - 
cd openssl-1.0.2r 
./config --prefix=/usr/local/openssl-1.0.2r -fpic 
make 
sudo make install 
cd .. 
rm -rf openssl-1.0.2r creates=/usr/local/openssl-1.0.2r
```

This downloads the 1.0.2 version of OpenSSL, compiles it and copies it into `/usr/local/openssl-1.0.2r`. This would help prevent your global install from being polluted.

## Using it
I only had issues with installing older Elixir and Python versions while using `asdf`.
- **Python** : `LDFLAGS="-L/usr/local/openssl-1.0.2r/lib" CFLAGS="-I/usr/local/openssl-1.0.2r/include" asdf install python 3.5.0`
- **Elixir** : `export KERL_CONFIGURE_OPTIONS="--disable-debug --without-javac --with-ssl=/usr/local/openssl-1.0.2r"`

Happy Legacy Hacking !
