set outfile [open sample.dat w]

set nf [molinfo top get numframes]

set frame0 [atomselect top "protein and backbone and noh" frame 0]

set sel [atomselect top "protein and backbone and noh"]

for {set i 0} {$i < $nf} {incr i} {
    
    $sel frame $i

    $sel move [measure fit $sel $frame0]
    
    puts $outfile "[measure rmsd $sel $frame0]"
}

close $outfile