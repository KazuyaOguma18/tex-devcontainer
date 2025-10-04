# Default to XeLaTeX but allow switching via LATEXMK_ENGINE/TEX_ENGINE
$pdf_mode = 1;
my $requested_engine = $ENV{LATEXMK_ENGINE} // $ENV{TEX_ENGINE};
my $engine;
if (defined $requested_engine && length $requested_engine) {
    my %aliases = (
        'xelatex' => 'xelatex',
        'xetex'   => 'xelatex',
        'xe'      => 'xelatex',
        'pdflatex'=> 'pdflatex',
        'pdftex'  => 'pdflatex',
        'pdf'     => 'pdflatex',
    );
    my $normalized = lc $requested_engine;
    die "Unsupported LATEXMK_ENGINE '$requested_engine'" unless exists $aliases{$normalized};
    $engine = $aliases{$normalized};
} else {
    $engine = 'xelatex';
}

if ($engine eq 'xelatex') {
    $pdflatex = 'xelatex %O %S';
    $clean_ext .= ' %R.xdv';
} else {
    $pdflatex = 'pdflatex %O %S';
}

# Ensure latexmk runs TeX from the source directory so relative \input paths work
$do_cd = 1;

# Place all build artifacts under ./out relative to repository root
use File::Basename qw(dirname);
use Cwd qw(abs_path);
my $repo_root = dirname(abs_path(__FILE__));
$aux_dir = "$repo_root/out";
$out_dir = "$repo_root/out";
