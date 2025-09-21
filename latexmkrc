# Force latexmk to use XeLaTeX for PDF generation
$pdf_mode = 1;
$pdflatex = 'xelatex %O %S';
$clean_ext .= ' %R.xdv';

# Place all build artifacts under ./out relative to repository root
use File::Basename qw(dirname);
use Cwd qw(abs_path);
my $repo_root = dirname(abs_path(__FILE__));
$aux_dir = "$repo_root/out";
$out_dir = "$repo_root/out";
