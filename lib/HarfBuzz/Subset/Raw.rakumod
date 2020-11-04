unit module HarfBuzz::Subset::Raw;

use HarfBuzz::Raw;
use HarfBuzz::Raw::Defs :types;
use HarfBuzz::Subset::Raw::Defs :$HB-SUBSET;
use NativeCall;

class hb_subset_input is repr('CPointer') is export {
    our sub create(--> hb_subset_input) is native($HB-SUBSET) is symbol('hb_subset_input_create_or_fail') {*}
    method new { create() }

    method unicodes(--> hb_set) is native($HB-SUBSET) is symbol('hb_subset_input_unicode_set') {*}
    method tables(--> hb_set) is native($HB-SUBSET) is symbol('hb_subset_input_table_set') {*}

    method set-drop-hints(hb_bool) is native($HB-SUBSET) is symbol('hb_subset_input_set_drop_hints') {*}
    method get-drop-hints(--> hb_bool) is native($HB-SUBSET) is symbol('hb_subset_input_get_drop_hints') {*}

    method set-desubroutinize(hb_bool) is native($HB-SUBSET) is symbol('hb_subset_input_set_desubroutinize') {*}
    method get-desubroutinize(--> hb_bool) is native($HB-SUBSET) is symbol('hb_subset_input_get_desubroutinize') {*}

    method set-retain-gids(hb_bool) is native($HB-SUBSET) is symbol('hb_subset_input_set_retain_gids') {*}
    method get-retain-gids(--> hb_bool) is native($HB-SUBSET) is symbol('hb_subset_input_get_retain_gids') {*}

    method set-name-legacy(hb_bool) is native($HB-SUBSET) is symbol('hb_subset_input_set_name_legacy') {*}
    method get-name-legacy(--> hb_bool) is native($HB-SUBSET) is symbol('hb_subset_input_get_name_legacy') {*}

    method reference(--> hb_subset_input) is native($HB-SUBSET) is symbol('hb_subset_input_reference') {*}
    method destroy() is native($HB-SUBSET) is symbol('hb_subset_input_destroy')  {*}
}

sub hb_subset(hb_face, hb_subset_input --> hb_face) is export is native($HB-SUBSET) {*}
