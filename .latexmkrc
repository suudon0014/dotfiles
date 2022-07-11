#!/usr/bin/env perl
$pdf_mode         = 3;
$latex            = 'uplatex %O -kanji=utf8 -no-guess-input-enc -interaction=nonstopmode -file-line-error %S';
$bibtex           = 'upbibtex %O %B';
$dvipdf           = 'dvipdfmx %O -o %D %S';
$makeindex        = 'mendex %O -o %D %S';

$biber = 'biber %O --bblencoding=utf8 -u -U --output_safechars %S';
$makeindex = 'mendex %O -o %D %S';

$pvc_view_file_via_temporary = 0;
$pdf_previewer = 'SumatraPDF -reuse-instance'
