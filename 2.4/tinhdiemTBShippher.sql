DELIMITER //

DROP FUNCTION IF EXISTS f_TinhDiemTBShipper //

CREATE FUNCTION f_TinhDiemTBShipper(input_maShipper INT) 
RETURNS DECIMAL(3,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE diem INT;
    DECLARE tongDiem INT DEFAULT 0;
    DECLARE soLuongDanhGia INT DEFAULT 0;
    DECLARE diemTB DECIMAL(3,2) DEFAULT 0.00;
    
    DECLARE cur_shipper CURSOR FOR 
        SELECT diemSoShipper FROM DANHGIA_SHIPPER WHERE maShipper = input_maShipper;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur_shipper;
    
    read_loop: LOOP
        FETCH cur_shipper INTO diem;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Cộng dồn điểm và số lượng
        SET tongDiem = tongDiem + diem;
        SET soLuongDanhGia = soLuongDanhGia + 1;
    END LOOP;
    
    CLOSE cur_shipper;
    
    -- Tính trung bình
    IF soLuongDanhGia > 0 THEN
        SET diemTB = tongDiem / soLuongDanhGia;
    ELSE
        SET diemTB = 0;
    END IF;
    
    RETURN diemTB;
END //

DELIMITER ;