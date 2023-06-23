[[Raku HarfBuzz Project]](https://harfbuzz-raku.github.io)
 / [[HarfBuzz-Subset Module]](https://harfbuzz-raku.github.io/HarfBuzz-Subset-raku)

HarfBuzz-Subset-raku
=============

Description
-----
Bindings to the HarfBuzz Subset font subsetting library.

Synopsis
-----

```raku
use HarfBuzz::Subset;

# face to be subsetted
my $file = "t/fonts/NimbusRoman-Regular.otf";

my @unicodes = 'Hello, World!'.ords;
my HarfBuzz::Subset $subset .= new: :face{ :$file }, :input{ :@unicodes };
my Blob() $buf = $subset;
'/tmp/my-nimbus-subset.otf'.IO.spurt: :bin, $buf;
```

Description
----
This module binds to the HarfBuzz library's subsetting capability and allows a font to be compacted to a smaller set of glyphs.

Subsetting is useful in a number of domains, including

- embedded PDF fonts, and
- fast loading Web-Fonts (you'll need additional external tools to then package as WOFF or EOT format).

class HarfBuzz::Subset Methods
----

### new

   method new(
       HarfBuzz::Font() :$font!,
       HarfBuzz::Subset::Input :$input()
   ) returns HarfBuzz::Subset:D;

- `:$font` is either a HarfBuzz::Font object or a hash of coerceable options.
- `:$input` is either a HarfBuzz::Subset::Input object or a hash of coerceable options.

### Blob

Binary image of the subsetted font. This can be saved to a file with the same extension as the input font (typically `.ttf` or `.otf`) or embedded somehow (for example in a PDF file).

HarfBuzz subsetting currently works on TrueType, and OpenType font formats. It also accepts TrueType Collections (typically with file extension `.ttc`). In this case, the subsetted font id converted to TrueType format, which should be saved with file extension `.ttf`.

HarfBuzz::Subset::Input Methods
---

### new

    method new(
        UInt :@unicodes,      # unicode code-points to include
        UInt :@glyphs,        # glyph identifiers to include
        Str  :@drop-tables,   # additional SFnt tables to drop
        Bool :$hints=True,    # retain font hinting
        Bool :$retain-gids,   # retain glyph identifiers
        Bool :$subroutines=True,
    ) returns HarfBuzz::Subset::Input:D;

Creates a font subsetting profile. Only the characters specified in `:@unicodes` and/or the glyph identifiers specified in `:@glyphs` are retained.

### COERCE

    method COERCE( %(
        :@unicodes, :@glyphs, :@drop-tables,
        :$hints, :$retain-gids, :$subroutines,
    ) returns HarfBuzz::Subset::Input:D;

An object can be coerced from a Hash of options.

Installation and Dependencies
----

### Debian

Debian version 12+ is required:

```
$ cat /etc/debian_version # 12.0 or better
$ sudo apt install libharfbuzz-dev
$ zef install HarfBuzz::Subset
```

On other platforms, HarfBuzz 3.0+ is required. HarfBuzz font shaping and subsetting libraries can be downloaded and built from https://github.com/harfbuzz/harfbuzz.


