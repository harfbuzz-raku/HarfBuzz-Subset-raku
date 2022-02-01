unit class HarfBuzz::Subset::Input;

use HarfBuzz::Raw;
use HarfBuzz::Raw::Defs :&hb-tag-enc;
use HarfBuzz::Subset::Raw;
use HarfBuzz::Subset::Raw::Defs :hb-subset-sets, :hb-subset-flags;
use HarfBuzz::Subset::Tables;
has hb_subset_input $.raw .= new();

submethod TWEAK(|c) { self.set-options: |c; }

multi method COERCE(%opts) { self.new: |%opts; }

method set-options(:@unicodes, :@glyphs, :@drop-tables, Bool :$hints, Bool :$subroutines, Bool :$retain-gids) {

    if @unicodes {
         my $set = $!raw.input-set(HB_SUBSET_SETS_UNICODE);
         $set.add: $_ for @unicodes;
    }

    if @glyphs {
         my $set = $!raw.input-set(HB_SUBSET_SETS_GLYPH_INDEX);
         $set.add: $_ for @glyphs;
    }

    if @drop-tables {
         my $set = $!raw.input-set(HB_SUBSET_SETS_DROP_TABLE_TAG);
         $set.add: hb-tag-enc($_) for @drop-tables;
    }

    self.hints       = $_ with $hints;
    self.subroutines = $_ with $subroutines;
    self.retain-gids = $_ with $retain-gids;
}

has HarfBuzz::Subset::Tables $!drop-tables;
method drop-tables(Any:D $subset:) {
    $!drop-tables //= do {
        my hb_set $raw = $!raw.input-set(HB_SUBSET_SETS_DROP_TABLE_TAG);
        HarfBuzz::Subset::Tables.new: :$subset, :$raw;
    }
}

method !update-flag(UInt $flag, Bool:D $_) {
    my $flags = $!raw.get-flags;
    if .so {
        $flags +|= $flag;
    }
    else {
        $flags = $flags +& (0xffffffff +^ $_)
            if $flags +& $flag;
    }
    $!raw.set-flags($flags);
}

method !flag-accessor(UInt $flag) is rw {
    Proxy.new(
        FETCH => { so $!raw.get-flags +& $flag },
        STORE => -> $, $_ {
            self!update-flag($flag, .so);
        }
    );
}

method !neg-flag-accessor(UInt $flag) is rw {
    Proxy.new(
        FETCH => { !so $!raw.get-flags +& $flag },
        STORE => -> $, $_ {
            self!update-flag($flag, !.so);
        }
    );
}

method hints is rw { self!neg-flag-accessor: HB_SUBSET_FLAGS_NO_HINTING }

method subroutines is rw { self!neg-flag-accessor: HB_SUBSET_FLAGS_DESUBROUTINIZE }

method retain-gids is rw { self!flag-accessor: HB_SUBSET_FLAGS_RETAIN_GIDS }
