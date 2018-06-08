#!/bin/bash

# Constants {{{1
################################################################

SCRIPT_PATH=$(dirname $BASH_SOURCE)
WRAPPER=$SCRIPT_PATH/../galaxy/nmrml2isa/wrapper.py
RESDIR=$SCRIPT_PATH/res
TESTDATA=$SCRIPT_PATH/../galaxy/nmrml2isa/test-data

# Test wrapper empty fields {{{1
################################################################

test_wrapper_empty_fields() {

	local inputzip="$TESTDATA/metabolomics_study.zip"
	local name_of_study=MYSTUDY
	local htmlfile="index.html"
	local outdir="$SCRIPT_PATH/test_wrapper_empty_fields.output"

    expect_success python "$WRAPPER" -inputzip "$inputzip"\
               -jsontxt ""\
               -html_file "$htmlfile"\
               -out_dir "$outdir"\
               -study_title "$name_of_study" || return 1
	expect_non_empty_file "$SCRIPT_PATH/$htmlfile" || return 1
	expect_folder "$outdir" || return 1
	expect_folder "$outdir/$name_of_study" || return 1
	expect_non_empty_file "$outdir/$name_of_study/i_Investigation.txt" || return 1
	expect_non_empty_file "$outdir/$name_of_study/s_$name_of_study.txt" || return 1
	expect_files_in_folder "$outdir/$name_of_study" 'a_.*\.txt' || return 1
}

# Main {{{1
################################################################

# wrapper tests
test_context "Testing wrapper.py"
test_that "We can set all fields to empty values." test_wrapper_empty_fields
