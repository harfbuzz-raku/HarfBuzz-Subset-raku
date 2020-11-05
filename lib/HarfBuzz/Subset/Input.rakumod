unit class HarfBuzz::Subset::Input;

use HarfBuzz::Subset::Raw;
has hb_subset_input $.raw .= new();

submethod TWEAK(|c) {
    self.set-options(|c);
}

method set-options(:$drop-hints, :$desubroutinize, :$retain-gids, :$name-legacy, :@unicode) {
     $!raw.set-drop-hints(.so) with $drop-hints;
     $!raw.set-desubroutinize(.so) with $desubroutinize;
     $!raw.set-retain-gids(.so) with $retain-gids;
     $!raw.set-name-legacy(.so) with $name-legacy;
     if @unicode {
         my $unicodes = $!raw.unicodes;
         $unicodes.add($_) for  @unicode;
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
