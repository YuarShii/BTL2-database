USE testdbbk;
DELIMITER //

DROP PROCEDURE IF EXISTS sp_TimKiemSanPhamNangCao //

CREATE PROCEDURE sp_TimKiemSanPhamNangCao(
    IN p_tuKhoa VARCHAR(255),       -- Từ khóa tìm kiếm
    IN p_giaMin DECIMAL(15,2),      -- Giá thấp nhất
    IN p_giaMax DECIMAL(15,2),      -- Giá cao nhất
    IN p_tenDanhMuc VARCHAR(255),   -- Tên danh mục
    IN p_soSaoToiThieu DECIMAL(2,1),-- Số sao tối thiểu
    IN p_sapXep INT,                -- 1: Giá tăng, 2: Giá giảm, 0: Mới nhất, 3: Sao cao nhất
    IN p_soTrang INT,               -- Trang số mấy
    IN p_kichThuocTrang INT         -- Số dòng trên 1 trang
)
BEGIN
    DECLARE v_offset INT;

    -- =============================================
    -- 1. VALIDATE DỮ LIỆU
    -- =============================================
    IF p_soTrang < 1 THEN SET p_soTrang = 1; END IF;
    IF p_kichThuocTrang < 1 THEN SET p_kichThuocTrang = 10; END IF;
    
    -- Kiểm tra logic giá
    IF p_giaMin IS NOT NULL AND p_giaMax IS NOT NULL AND p_giaMin > p_giaMax THEN
        SET p_giaMin = NULL; 
        SET p_giaMax = NULL;
    END IF;

    SET v_offset = (p_soTrang - 1) * p_kichThuocTrang;

    -- =============================================
    -- 2. TRUY VẤN (Đã sửa lỗi #1247)
    -- =============================================
    SELECT 
        s.maSanPham, 
        s.tenSanPham, 
        s.giaBan, 
        s.soLuongCon, 
        d.tenDanhMuc, 
        c.tenCuaHang,
        s.phanTramGiamGia,
        -- Tính toán hiển thị
        ROUND(IFNULL(AVG(dg.diemSo), 0), 1) AS diemDanhGiaTB,
        COUNT(dg.maDanhGia) AS soLuotDanhGia
    FROM SANPHAM s
    JOIN DANHMUC d ON s.maDanhMuc = d.maDanhMuc
    JOIN CUAHANG c ON s.maCuaHang = c.maCuaHang
    LEFT JOIN DANHGIA dg ON s.maSanPham = dg.maSanPham
    WHERE 
        (p_tuKhoa IS NULL OR s.tenSanPham LIKE CONCAT('%', p_tuKhoa, '%'))
        AND (p_giaMin IS NULL OR s.giaBan >= p_giaMin)
        AND (p_giaMax IS NULL OR s.giaBan <= p_giaMax)
        AND (p_tenDanhMuc IS NULL OR d.tenDanhMuc LIKE CONCAT('%', p_tenDanhMuc, '%'))
    GROUP BY s.maSanPham, s.tenSanPham, s.giaBan, s.soLuongCon, d.tenDanhMuc, c.tenCuaHang, s.phanTramGiamGia
    HAVING 
        -- SỬA LỖI: Dùng lại công thức tính toán thay vì Alias
        (p_soSaoToiThieu IS NULL OR ROUND(IFNULL(AVG(dg.diemSo), 0), 1) >= p_soSaoToiThieu)
    ORDER BY
        CASE WHEN p_sapXep = 1 THEN s.giaBan END ASC,
        CASE WHEN p_sapXep = 2 THEN s.giaBan END DESC,
        -- SỬA LỖI: Dùng lại công thức tính toán trong ORDER BY
        CASE WHEN p_sapXep = 3 THEN ROUND(IFNULL(AVG(dg.diemSo), 0), 1) END DESC, 
        CASE WHEN p_sapXep = 0 OR p_sapXep IS NULL THEN s.maSanPham END DESC, -- Mặc định mới nhất
        s.maSanPham DESC -- Fallback sort
    LIMIT p_kichThuocTrang OFFSET v_offset;
    
END //

DELIMITER ;