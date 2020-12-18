HarfBuzz-Subset-raku
=============

Description
-----
Bindings to the HarfBuzz Subset font subsetting library.

This module is classed as *Experimental*, just because the `harfbuzz-subset` library is not commonly packaged yet, and needs to be built from source.

Synopsis
-----

```raku
use HarfBuzz::Face;
use HarfBuzz::Subset;

# load face to be subsetted
my $file = "t/fonts/NimbusRoman-Regular.otf";
my HarfBuzz::Face $face .= new: :$file;

my @unicodes = 'Hello, World!'.ords;
my HarfBuzz::Subset $subsetter .= new: :$face, :input{ :@unicodes };
my Blob() $buf = $subsetter.subset-face;
'/tmp/my-nimbus-subset.otf'.IO.spurt: :bin, $buf;
```

Description
----
This module binds to the HarfBuzz library's subsetting capability and allows a font to be compacted to a smaller set of glyphs.

Subsetting is useful in a number of domains, including

- embedded PDF fonts, and
- fast loading Web-Fonts (you'll need additional external tools to then package as WOFF or EOT format).

Installation
----
As of late 2020, HarfBuzz's font subsetting capability is not commonly packaged yet and you'll mostly likely need to build HarfBuzz from source.

Please download and build from https://github.com/harfbuzz/harfbuzz.


