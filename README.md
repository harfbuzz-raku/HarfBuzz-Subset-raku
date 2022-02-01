[[Raku HarfBuzz Project]](https://harfbuzz-raku.github.io)
 / [[HarfBuzz-Subset Module]](https://harfbuzz-raku.github.io/HarfBuzz-Subset-raku)

HarfBuzz-Subset-raku
=============

Description
-----
Bindings to the HarfBuzz Subset font subsetting library.

This module is classed as *Experimental*, just because a recent HarfBuzz 3.0.0+ library needs to be built
with the latest `harfbuzz-subset` library.

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

HarfBuzz subsetting currently works on TrueType, and OpenType font formats. It also accepts TrueType Collections (typically with file extension `.ttc`). In this case, the converted font will be a simple TrueType font, which should be saved with file extensyion `.ttf`.

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
- This module requires at least Rakudo 2020.11.

- As of late 2020, HarfBuzz's font subsetting capability is not packaged yet. It seems destined to be included with [HarfBuzz 2.8.0+](https://archlinux.org/packages/extra/x86_64/harfbuzz/) releases.

- In the meantime, HarfBuzz font shaping and subsetting libraries can be downloaded and built from https://github.com/harfbuzz/harfbuzz.


