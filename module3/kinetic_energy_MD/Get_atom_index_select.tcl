# 設置輸入文件路徑,如檔案不同須於下方 "  " 中更改檔案名稱
set trajFile "ubq_wb_eq.dcd"
set psfFile "ubq_wb.psf"

# 打開分子結構和軌跡文件
mol new $psfFile
mol addfile $trajFile waitfor all

# 打開輸出文件
set outputFile [open "my_atom_indexs_select.txt" w]

# Get the total number of frames
set numFrames [molinfo top get numframes]

# 循環處理每一幀
for {set frame 0} {$frame < $numFrames} {incr frame} {
    animate goto $frame
    # 在每一幀中選取指定原子(此部分以 protein 為例),透過更改下方 "  " 改變選取範圍
    set atom_selection [atomselect top "protein"]
    
    # 獲取選取的原子索引
    set atom_indices [$atom_selection get index]
    
    # 將原子索引輸出到文件
    puts $outputFile "Frame $frame: $atom_indices"
    
    # 關閉原子選取
    $atom_selection delete
}

# 關閉輸出文件
close $outputFile