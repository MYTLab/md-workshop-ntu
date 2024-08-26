# 設置輸入文件路徑,如檔案不同須於下方 "  " 中更改檔案名稱
#請特別注意此處的附檔名為 ".veldcd "
set trajFile "ubq_wb_eq.veldcd"  
set psfFile "ubq_wb.psf"

# 打開分子結構和軌跡文件
mol new $psfFile
mol addfile $trajFile type dcd waitfor all


# 打開輸出文件
set outputFile [open "my_atoms_velocity_vector_.txt" w]
set outputFile2 [open "my_atoms_mass_.txt" w]

# Get the total number of frames
set numFrames [molinfo top get numframes]

# 循環處理每一幀
for {set frame 0} {$frame <  $numFrames } {incr frame} {
    animate goto $frame
    # select all
    set sel_all [atomselect top all]
    
    # 獲取選取的原子的 velocity vector
    set atom_velocity_vector [$sel_all  get {x y z}]
    # 獲取選取的原子的 mass
    set atom_mass [$sel_all  get mass]

    # 將資訊輸出到文件
    puts $outputFile "Frame $frame: $atom_velocity_vector"
    puts $outputFile2 "Frame $frame: $atom_mass"

    # 關閉選取
    $sel_all  delete
}

# 關閉輸出文件
close $outputFile