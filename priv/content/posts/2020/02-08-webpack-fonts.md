%{
  title: "Self Hosted NPM Fonts with Webpack",
  tags: ~w(webpack typography),
  description: "Outlines how I got self hosted fonts working with webpack."
}
---

Whenever I wanted new fonts Google Fonts was the defacto place I'd go to. It has a ton of great fonts and it's fairly easy to add to your projects. They are also hosted for free by Google which takes some load of your own webserver. I had a personal collection of favorite fonts that I cycle through on new projects. 

Everything was going nice when I found out Inter. It was free, looks really crisp and was not available on Google Fonts :(. A little digging and I found out about [Typefaces on NPM](https://github.com/KyleAMathews/typefaces) . They are normal NPM packages that you add to your project which contains all the fonts files that you require with some cool optimizations for page speed. These fonts will be bundled with your project on building.

## Using Fonts in Webpack
I am currently learning Elixir Phoenix which uses Webpack for asset management, it's only natural we use it for loading these fonts. This setup is tested to work with Phoenix project but should work on any webpack enabled project.

### Find the typeface you love
There are literally hundreds of free awesome typefaces on the web. Just search for the name with NPM and then install that into your assets folder.

```
cd assets
npm install --save circular-std
```

### Install needed Dependencies
Webpack is a modular build system and it requires extra modules to load these external font files correctly.

```
npm i --save file-loader
```

### Add font loading config
Open `webpack.config.js` and add the following config which would load the font files from `node_modules` and package to your static folder.

```
{
    test: /\.(woff(2)?|ttf|eot|svg)(\?v=\d+\.\d+\.\d+)?$/,
    use: [{
        loader: 'file-loader',
        options: {
            esModule: false,
            name: '[name].[ext]',
            outputPath: '../fonts'
        }
    }]
}
```

The `esModule: false` is a flag which is set to default to true. When it's kept that way the font files are not referenced correctly. The `name` key saves the fonts with the correct names and extensions instead of the default hash as name, and the output path saves the fonts to fonts directory.

### Import fonts on Javascript
In your `app.js` import the font package. This would load and build those Font files.

```
import "circular-std"
```

### Use it
In your `app.css` you can now start using these fonts.

Self hosting fonts have many advantages as offline loading in development, faster delivery and overall better performance. Ditch Google fonts and give self hosting a go.
