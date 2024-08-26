puts "Enter the output file name:"
set outputname [gets stdin]
set sel [atomselect top all]
$sel writepdb ${outputname}.pdb
$sel writepsf ${outputname}.psf
