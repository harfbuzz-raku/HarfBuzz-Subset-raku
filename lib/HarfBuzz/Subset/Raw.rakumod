use HarfBuzz::Raw;
use HarfBuzz::Subset::Raw::Defs :$HB-SUBSET;
use NativeCall;
class hb_subset_input is repr('CPointer') is export {
    our sub create(--> hb_subset_input) is native($HB-SUBSET) is symbol('hb_subset_input_create_or_fail') {*}
    method new { create() }
    method unicode(--> hb_set) is native($HB-SUBSET) is symbol('hb_subset_input_unicode_set') {*}
    method reference(--> hb_subset_input) is native($HB-SUBSET) is symbol('hb_subset_input_reference') {*}
    method destroy() is native($HB-SUBSET) is symbol('hb_subset_input_destroy')  {*}
}

sub hb_subset(hb_face, hb_subset_input --> hb_face) is export is native($HB-SUBSET) {*}
