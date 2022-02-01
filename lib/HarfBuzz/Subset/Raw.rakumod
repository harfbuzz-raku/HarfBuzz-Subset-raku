unit module HarfBuzz::Subset::Raw;

use HarfBuzz::Raw;
use HarfBuzz::Raw::Defs :types;
use HarfBuzz::Subset::Raw::Defs :$HB-SUBSET;
use NativeCall;

class hb_subset_input is repr('CPointer') is export {
    our sub create(--> hb_subset_input) is native($HB-SUBSET) is symbol('hb_subset_input_create_or_fail') {*}
    method new { create() }

    method input-set(uint32 --> hb_set) is native($HB-SUBSET) is symbol('hb_subset_input_set') {*}

    method get-flags(--> uint32) is native($HB-SUBSET) is symbol('hb_subset_input_get_flags') {*}

    method set-flags(uint32) is native($HB-SUBSET) is symbol('hb_subset_input_set_flags') {*}

    method reference(--> hb_subset_input) is native($HB-SUBSET) is symbol('hb_subset_input_reference') {*}
    method destroy() is native($HB-SUBSET) is symbol('hb_subset_input_destroy')  {*}
}

sub hb_subset_or_fail(hb_face, hb_subset_input --> hb_face) is export is native($HB-SUBSET) {*}
