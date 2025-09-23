# ============================
# calc_concentration.tcl
# 在 VMD 計算目前離子濃度 (mol/L)
# 使用方法:
#   vmd -dispdev text -e calc_concentration.tcl -args my.psf my.pdb
# 或在 VMD TkConsole 中輸入:
#   source calc_concentration.tcl
#   calc_concentration my.psf my.pdb
# ============================

proc calc_concentration {psf_file pdb_file} {
    # 載入分子
    mol new $psf_file type psf waitfor all
    mol addfile $pdb_file type pdb waitfor all

    # 計算水分子數 (TIP3/TIP4P/SPC 等需依力場水氧原子命名修改)
    set sel_water [atomselect top "resname TIP3 and name OH2"]
    set nwater [$sel_water num]
    $sel_water delete

    # 計算陽離子與陰離子數 (Na+, Cl-)
    set sel_cation [atomselect top "resname SOD POT MG CAL CES ZN2"]
    set ncation [$sel_cation num]
    $sel_cation delete

    set sel_anion [atomselect top "resname CLA"]
    set nanion [$sel_anion num]
    $sel_anion delete

    # 計算體積 (L)，假設 1 L 水 ≈ 55.5 mol ≈ 55.5 * 6.022e23 水分子
    set NA 6.022e23
    set mol_water [expr {$nwater / $NA}]
    set volume_L [expr {$mol_water / 55.5}]

    # 離子濃度 (mol/L) - 取陽離子/陰離子數的平均作為離子對數
    set n_pairs [expr {min($ncation,$nanion)}]
    set mol_pairs [expr {$n_pairs / $NA}]
    set conc_M [expr {$mol_pairs / $volume_L}]

    puts "=================================="
    puts "Water molecules: $nwater"
    puts "Cations: $ncation"
    puts "Anions:  $nanion"
    puts "Estimated volume: $volume_L L"
    puts "Ion pairs: $n_pairs"
    puts "Salt concentration: $conc_M M"
    puts "=================================="
}

# 如果有傳參數，直接計算
if {$argc == 2} {
    set psf_file [lindex $argv 0]
    set pdb_file [lindex $argv 1]
    calc_concentration $psf_file $pdb_file
}
