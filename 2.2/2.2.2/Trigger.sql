DELIMITER //

-- 1. Khi THÊM sản phẩm vào giỏ
CREATE TRIGGER if not EXISTS trg_GioHang_AfterInsert
AFTER INSERT ON CHI_TIET_GIOHANG
FOR EACH ROW
BEGIN
    UPDATE GIOHANG
    SET tongTienGioHang = (
        SELECT COALESCE(SUM(ct.soLuongGio * sp.GiaBan), 0)
        FROM CHI_TIET_GIOHANG ct
        JOIN SANPHAM sp ON ct.MaSanPham = sp.MaSanPham
        WHERE ct.MaGioHang = NEW.MaGioHang
    )
    WHERE MaGioHang = NEW.MaGioHang;
END//

-- 2. Khi CẬP NHẬT số lượng trong giỏ
CREATE TRIGGER trg_GioHang_AfterUpdate
AFTER UPDATE ON CHI_TIET_GIOHANG
FOR EACH ROW
BEGIN
    -- Chỉ tính lại nếu số lượng hoặc mã sản phẩm thay đổi
    IF NEW.soLuongGio != OLD.soLuongGio OR NEW.MaSanPham != OLD.MaSanPham THEN
        UPDATE GIOHANG
        SET tongTienGioHang = (
            SELECT COALESCE(SUM(ct.soLuongGio * sp.GiaBan), 0)
            FROM CHI_TIET_GIOHANG ct
            JOIN SANPHAM sp ON ct.MaSanPham = sp.MaSanPham
            WHERE ct.MaGioHang = NEW.MaGioHang
        )
        WHERE MaGioHang = NEW.MaGioHang;
    END IF;
END//

-- 3. Khi XÓA sản phẩm khỏi giỏ
CREATE TRIGGER trg_GioHang_AfterDelete
AFTER DELETE ON CHI_TIET_GIOHANG
FOR EACH ROW
BEGIN
    UPDATE GIOHANG
    SET tongTienGioHang = (
        SELECT COALESCE(SUM(ct.soLuongGio * sp.GiaBan), 0)
        FROM CHI_TIET_GIOHANG ct
        JOIN SANPHAM sp ON ct.MaSanPham = sp.MaSanPham
        WHERE ct.MaGioHang = OLD.MaGioHang
    )
    WHERE MaGioHang = OLD.MaGioHang;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_UpdateGia_DongBoGioHang
AFTER UPDATE ON SANPHAM
FOR EACH ROW
BEGIN
    IF NEW.GiaBan != OLD.GiaBan THEN
        -- Tìm và cập nhật lại tongTienGioHang cho các giỏ hàng bị ảnh hưởng
        UPDATE GIOHANG gh
        JOIN CHI_TIET_GIOHANG ct ON gh.MaGioHang = ct.MaGioHang
        SET gh.tongTienGioHang = (
            SELECT COALESCE(SUM(sub_ct.soLuongGio * sub_sp.GiaBan), 0)
            FROM CHI_TIET_GIOHANG sub_ct
            JOIN SANPHAM sub_sp ON sub_ct.MaSanPham = sub_sp.MaSanPham
            WHERE sub_ct.MaGioHang = gh.MaGioHang
        )
        WHERE ct.MaSanPham = NEW.MaSanPham; 
    END IF;
END//
DELIMITER ;

DELIMITER //

CREATE TRIGGER trg_GiamTonKho_DongBoGioHang
AFTER UPDATE ON SANPHAM
FOR EACH ROW
BEGIN
    -- 1. Kiểm tra: Chỉ chạy khi số lượng tồn kho bị giảm đi
    -- (Lưu ý: Bảng SANPHAM dùng cột 'SoLuongCon', không phải 'soLuongGio')
    IF NEW.SoLuongCon < OLD.SoLuongCon THEN
        
        -- 2. Thực hiện Update (SQL sẽ tự động quét qua từng giỏ hàng)
        UPDATE CHI_TIET_GIOHANG
        SET soLuongGio = NEW.SoLuongCon -- Cập nhật lại bằng số tồn kho mới
        WHERE MaSanPham = NEW.MaSanPham -- Chỉ tìm đúng sản phẩm này
          AND soLuongGio > NEW.SoLuongCon; -- ĐIỀU KIỆN QUAN TRỌNG NHẤT
          
    END IF;
END//

DELIMITER ;