unit class HarfBuzz::Subset::Input;

use HarfBuzz::Raw;
use HarfBuzz::Subset::Raw;
use HarfBuzz::Subset::Tables;
has hb_subset_input $.raw .= new();

submethod TWEAK(|c) { self.set-options: |c; }

multi method COERCE(%opts) { self.new: |%opts; }

method set-options(:@unicodes, :@glyphs, :@drop-tables, *%flags) {

    if @unicodes {
         my $unicode-set = $!raw.unicodes;
         $unicode-set.add: $_ for @unicodes;
     }

    if @glyphs {
         my $glyph-set = $!raw.glyphs;
         $glyph-set.add: $_ for @glyphs;
     }

     self.drop-tables.add: $_ for @drop-tables;

    for %flags.pairs {
        if .key ~~ 'drop-hints'|'desubroutinize'|'retain-gids'|'name-legacy' {
            $!raw."set-{.key}"(.value.so);
        }
        else {
            warn "ignoring {.key} option";
        }
    }
}

method drop-hints is rw {
    Proxy.new(
        FETCH => { ? $!raw.get-drop-hints },
        STORE => -> $, $_ {
            $!raw.set-drop-hints(.so)
        }
    );
}

has HarfBuzz::Subset::Tables $!drop-tables;
method drop-tables(Any:D $subset:) {
    $!drop-tables //= do {
        my hb_set $raw = $!raw.drop-tables;
        HarfBuzz::Subset::Tables.new: :$subset, :$raw;
    }
}

method desubroutinize is rw {
    Proxy.new(
        FETCH => { ? $!raw.get-desubroutinize },
        STORE => -> $, $_ {
            $!raw.set-desubroutinize(.so)
        }
    );
}

method retain-gids is rw {
    Proxy.new(
        FETCH => { ? $!raw.get-retain-gids },
        STORE => -> $, $_ {
            $!raw.set-retain-gids(.so)
        }
    );
}

method name-legacy is rw {
    Proxy.new(
        FETCH => { ? $!raw.get-name-legacy },
        STORE => -> $, $_ {
            $!raw.set-name-legacy(.so)
        }
    );
}
