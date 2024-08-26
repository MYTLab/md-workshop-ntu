proc get_total_mass {{molid top}} {
	eval "vecadd [[atomselect $molid protein] get mass]"
}