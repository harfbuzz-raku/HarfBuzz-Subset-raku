unit class HarfBuzz::Subset::Input;

use HarfBuzz::Raw;
use HarfBuzz::Subset::Raw;
use HarfBuzz::Subset::Tables;
has hb_subset_input $.raw .= new();

submethod TWEAK(|c) { self.set-options: |c; }

multi method COERCE(%opts) { self.new: |%opts; }

method set-options(:@unicodes, :@glyphs, :@drop-tables, Bool :$hints, Bool :$subroutines, Bool :$retain-gids) {

    if @unicodes {
         my $unicode-set = $!raw.unicodes;
         $unicode-set.add: $_ for @unicodes;
     }

    if @glyphs {
         my $glyph-set = $!raw.glyphs;
         $glyph-set.add: $_ for @glyphs;
     }

    self.drop-tables.add: $_ for @drop-tables;
    self!set-hints: $_ with $hints;
    self!set-subroutines: $_ with $subroutines;
    $!raw.set-retain-gids: $_ with $retain-gids;
}

method !get-hints { ! $!raw.get-drop-hints } 
method !set-hints($_) { $!raw.set-drop-hints(!.so); }
method hints is rw {
    Proxy.new(
        FETCH => { self!get-hints },
        STORE => -> $, $_ { self!set-hints: $_ }
    );
}

has HarfBuzz::Subset::Tables $!drop-tables;
method drop-tables(Any:D $subset:) {
    $!drop-tables //= do {
        my hb_set $raw = $!raw.drop-tables;
        HarfBuzz::Subset::Tables.new: :$subset, :$raw;
    }
}

method !get-subroutines { ! $!raw.get-desubroutinize }
method !set-subroutines { $!raw.set-desubroutinize(!.so) }
method subroutines is rw {
    Proxy.new(
        FETCH => { self!get-subroutines },
        STORE => -> $, $_ { self!set-subroutines: $_ },
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
