DELIMITER //

DROP FUNCTION IF EXISTS f_TinhTongTienSauGiam //

CREATE FUNCTION f_TinhTongTienSauGiam(input_maDonHang INT) 
RETURNS DECIMAL(15,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE thanhTien DECIMAL(15,2);
    DECLARE tongTienTam DECIMAL(15,2) DEFAULT 0;
    DECLARE giamGia DECIMAL(15,2) DEFAULT 0;
    DECLARE tongTienCuoi DECIMAL(15,2);
    DECLARE trangThaiHienTai VARCHAR(50); -- Biến lưu trạng thái

    DECLARE cur_details CURSOR FOR 
        SELECT (soLuongMua * giaLucMua) 
        FROM CHI_TIET_DONHANG 
        WHERE maDonHang = input_maDonHang;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    SELECT trangThaiDonHang INTO trangThaiHienTai 
    FROM DONHANG 
    WHERE maDonHang = input_maDonHang;
    
    IF trangThaiHienTai != 'da_giao' THEN
        RETURN 0;
    END IF;
    
    OPEN cur_details;
    
    tinh_tong_loop: LOOP
        FETCH cur_details INTO thanhTien;
        IF done THEN
            LEAVE tinh_tong_loop;
        END IF;
        SET tongTienTam = tongTienTam + thanhTien;
    END LOOP;
    
    CLOSE cur_details;
    
    -- Tính tổng tiền giảm giá 
    SELECT COALESCE(SUM(soTienGiamThucTe), 0) INTO giamGia 
    FROM AP_DUNG_KHUYENMAI 
    WHERE maDonHang = input_maDonHang;
    
    SET tongTienCuoi = tongTienTam - giamGia;
    
    -- Đảm bảo không âm
    IF tongTienCuoi < 0 THEN
        SET tongTienCuoi = 0;
    END IF;
    
    RETURN tongTienCuoi;
END //

DELIMITER ;