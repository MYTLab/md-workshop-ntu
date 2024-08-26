#load nanomaterial
package require topotools 1.8
set midlist {}
set mol [mol new graphene.psf waitfor all]
mol addfile graphene.pdb

#load molecule in system
lappend midlist $mol
set mol [mol new phenol.psf waitfor all]
mol addfile phenol.pdb $mol

#moving molecule 
set sel [atomselect top all]
$sel moveby {0.0 0.0 15.0}
    lappend midlist $mol
#do the magic
set mol [::TopoTools::mergemols $midlist]

animate write psf graphene_sim_temp.psf $mol
animate write pdb graphene_sim_temp.pdb $mol