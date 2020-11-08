unit class HarfBuzz::Subset::Input;

use HarfBuzz::Raw;
use HarfBuzz::Subset::Raw;
use HarfBuzz::Subset::Tables;
has hb_subset_input $.raw .= new();

submethod TWEAK(|c) {
    self.set-options(|c);
}

method set-options(:$drop-hints, :$desubroutinize, :$retain-gids, :$name-legacy, :@unicode, :@drop-tables) {

     $!raw.set-drop-hints(.so) with $drop-hints;
     $!raw.set-desubroutinize(.so) with $desubroutinize;
     $!raw.set-retain-gids(.so) with $retain-gids;
     $!raw.set-name-legacy(.so) with $name-legacy;

     if @unicode {
         my $unicodes = $!raw.unicodes;
         $unicodes.add($_) for  @unicode;
     }

     self.drop-tables.add: $_ for @drop-tables;
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
