%{
  title: "MacOS like Fonts on Manjaro/Arch Linux",
  tags: ~w(linux typography),
  description: "Learn how to setup Manjaro/Arch to get MacOS like fonts in the interface and Chrome.",
  rating: 3,
}

---

Either you love gorgeous typography or just don't care. If you are the
former read ahead on how to make the font rendering on your Linux look
just as awesome as that on macOS, else read on to find out what beauty
you have been missing.

I switched to a hackintosh for a while and fell in love with how
beautiful the typography was. After returning to Linux and some
fiddiling around I came across a not so ugly setup that looked close
enough to macOS. So if you want to make your Linux Distro a tad bit
typographically better, follow along.


## Results

This is how the fonts look on the default installation of Manjaro Linux.

![Search before font change](../images/before_macosfont.png)

![Wikipedia before font
change](../images/wikipedia_beforefonts.png)

This is how they would look after we are done.

![Search after font change](../images/after_macos.png)

![Wikipedia after font change](../images/wikipedia_afterfonts.png)



## Some Pointers

Rather than copy pasting everything on here, let's try to understand why
the fonts on macOS looks better than the ones we have on Linux.

Fonts belong to certain types.

-   `sans-serif` : Well the sans fonts on your computer. The regular
    plain fonts.
-   `serif` : The fonts that look like they came out of a 14th century
    Bible. You know with the curves and they look like showoffs.
-   `monospace` : The typical code font. The ones where every character
    is the same width.

The reason fonts look way better on macOS is because Steve Jobs loved
typography, and he went the extra mile and licensed some great typefaces
for each font type, and recently Apple put in the extra effort to make
their custom fonts even better. Well fret not Linux has some free fonts
that are metric compatible(means they look awfully similar), and better
that we can substitute for fonts.




## Installation

Step one is installing the fonts that look similar or better than the
ones on macOS. All the fonts that are used here can be found on the Arch
Repositories, and on Google Fonts. You are free to replace everything
with the ones you find great.

-   `sans-serif` : tex-gyre-fonts, free alternative to Helvetica and
    Arial and looks really really similar
-   `serif` : Libertinus Serif, suprisingly looks really great
-   `monospace` : DM Mono from Google Fonts, for monospace fonts that
    look great
-   `emoji` : noto-fonts-emoji, get some colorful emojis

If you are using Manjaro or Arch here is the command to get all fonts in
one go.

    yay -S tex-gyre-fonts otf-libertinus noto-fonts-emoji
            




## Font Setup

Everything about fonts can be configured from a single file located at
`/etc/fonts/local.conf` if the file doesn't exist create it. You do
require `sudo` for it.

    sudo nvim /etc/fonts/local.conf
            

After you are editing the file copy paste everything here.

    <?xml version='1.0'?>
    <!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
    <fontconfig>

      <match target="font">
        <edit name="autohint" mode="assign">
          <bool>true</bool>
        </edit>
        <edit name="hinting" mode="assign">
          <bool>true</bool>
        </edit>
        <edit mode="assign" name="hintstyle">
          <const>hintslight</const>
        </edit>
        <edit mode="assign" name="lcdfilter">
          <const>lcddefault</const>
        </edit>
      </match>

      <!-- Default sans-serif font -->
      <match target="pattern">
        <test qual="any" name="family"><string>-apple-system</string></test>
        <!--<test qual="any" name="lang"><string>ja</string></test>-->
        <edit name="family" mode="prepend" binding="same"><string>Tex Gyre Heros</string></edit>
      </match>
      <match target="pattern">
        <test qual="any" name="family"><string>Helvetica Neue</string></test>
        <!--<test qual="any" name="lang"><string>ja</string></test>-->
        <edit name="family" mode="prepend" binding="same"><string>Tex Gyre Heros</string></edit>
      </match>
      <match target="pattern">
        <test qual="any" name="family"><string>Helvetica</string></test>
        <!--<test qual="any" name="lang"><string>ja</string></test>-->
        <edit name="family" mode="prepend" binding="same"><string>Tex Gyre Heros</string></edit>
      </match>
      <match target="pattern">
        <test qual="any" name="family"><string>arial</string></test>
        <!--<test qual="any" name="lang"><string>ja</string></test>-->
        <edit name="family" mode="prepend" binding="same"><string>Tex Gyre Heros</string></edit>
      </match>
      <match target="pattern">
        <test qual="any" name="family"><string>sans-serif</string></test>
        <!--<test qual="any" name="lang"><string>ja</string></test>-->
        <edit name="family" mode="prepend" binding="same"><string>Tex Gyre Heros</string></edit>
      </match>

      <!-- Default serif fonts -->
      <match target="pattern">
        <test qual="any" name="family"><string>serif</string></test>
        <edit name="family" mode="prepend" binding="same"><string>Libertinus Serif</string></edit>
        <edit name="family" mode="prepend" binding="same"><string>Noto Serif</string></edit>
        <edit name="family" mode="prepend" binding="same"><string>Noto Color Emoji</string></edit>
        <edit name="family" mode="append" binding="same"><string>IPAPMincho</string></edit>
        <edit name="family" mode="append" binding="same"><string>HanaMinA</string></edit>
      </match>

      <!-- Default monospace fonts -->
      <match target="pattern">
        <test qual="any" name="family"><string>SFMono-Regular</string></test>
        <edit name="family" mode="prepend" binding="same"><string>DM Mono</string></edit>
        <edit name="family" mode="prepend" binding="same"><string>Space Mono</string></edit>
        <edit name="family" mode="append" binding="same"><string>Inconsolatazi4</string></edit>
        <edit name="family" mode="append" binding="same"><string>IPAGothic</string></edit>
      </match>
      <match target="pattern">
        <test qual="any" name="family"><string>Menlo</string></test>
        <edit name="family" mode="prepend" binding="same"><string>DM Mono</string></edit>
        <edit name="family" mode="prepend" binding="same"><string>Space Mono</string></edit>
        <edit name="family" mode="append" binding="same"><string>Inconsolatazi4</string></edit>
        <edit name="family" mode="append" binding="same"><string>IPAGothic</string></edit>
      </match>
      <match target="pattern">
        <test qual="any" name="family"><string>monospace</string></test>
        <edit name="family" mode="prepend" binding="same"><string>DM Mono</string></edit>
        <edit name="family" mode="prepend" binding="same"><string>Space Mono</string></edit>
        <edit name="family" mode="append" binding="same"><string>Inconsolatazi4</string></edit>
        <edit name="family" mode="append" binding="same"><string>IPAGothic</string></edit>
      </match>

      <!-- Fallback fonts preference order -->
      <alias>
        <family>sans-serif</family>
        <prefer>
          <family>Noto Sans</family>
          <family>Noto Color Emoji</family>
          <family>Noto Emoji</family>
          <family>Open Sans</family>
          <family>Droid Sans</family>
          <family>Ubuntu</family>
          <family>Roboto</family>
          <family>NotoSansCJK</family>
          <family>Source Han Sans JP</family>
          <family>IPAPGothic</family>
          <family>VL PGothic</family>
          <family>Koruri</family>
        </prefer>
      </alias>
      <alias>
        <family>serif</family>
        <prefer>
          <family>Noto Serif</family>
          <family>Noto Color Emoji</family>
          <family>Noto Emoji</family>
          <family>Droid Serif</family>
          <family>Roboto Slab</family>
          <family>IPAPMincho</family>
        </prefer>
      </alias>
      <alias>
        <family>monospace</family>
        <prefer>
          <family>Noto Sans Mono</family>
          <family>Noto Color Emoji</family>
          <family>Noto Emoji</family>
          <family>Inconsolatazi4</family>
          <family>Ubuntu Mono</family>
          <family>Droid Sans Mono</family>
          <family>Roboto Mono</family>
          <family>IPAGothic</family>
        </prefer>
      </alias>
    </fontconfig>
            

What this file does that is it creates aliases for the common fonts used
on the web and uses the metric compatible fonts that we have. That way
we have way better looking fonts.

After you have done all this, restart your computer to see the changes.




## Chrome

If you are using chrome, you can do something more too.

-   Goto Settings
-   Select Customize Fonts under Appearences
-   Set Standard to `Libertinus Serif`
-   Set Serif to `Libertinus Serif`
-   Set Sans-serif to `TeX Gyre Heros`
-   Set Fixed-width to `Monospace`




## Interface Text

For Desktop Environments like Gnome and KDE, you could use
Tex-Gyre-Heros for the overall Helvetica look. I use Gnome 3.36 and use
`TeX Gyre Heros Regular 10` as my interface text.

That's all set, and keep in mind this guide will be improved.

