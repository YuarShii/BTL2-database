DELIMITER //

DROP PROCEDURE IF EXISTS sp_ThongKeDoanhThuTheoDanhMuc //

CREATE PROCEDURE sp_ThongKeDoanhThuTheoDanhMuc(
    IN input_maCuaHang INT,
    IN input_thang INT,
    IN input_nam INT
)
BEGIN
    -- Thống kê tổng doanh thu theo từng danh mục của một cửa hàng trong tháng/năm chỉ định
    SELECT 
        dm.tenDanhMuc,
        SUM(ct.soLuongMua) AS SoLuongDaBan, 
        -- Tính tổng doanh thu
        SUM(ct.soLuongMua * ct.giaLucMua) AS TongDoanhThu
    FROM DONHANG dh
    JOIN CHI_TIET_DONHANG ct ON dh.maDonHang = ct.maDonHang
    JOIN SANPHAM sp ON ct.maSanPham = sp.maSanPham
    JOIN DANHMUC dm ON sp.maDanhMuc = dm.maDanhMuc
    WHERE 
        sp.maCuaHang = input_maCuaHang
        AND MONTH(dh.ngayDatHang) = input_thang
        AND YEAR(dh.ngayDatHang) = input_nam
        AND dh.trangThaiDonHang = 'da_giao' -- Chỉ tính đơn hàng thành công
    GROUP BY dm.tenDanhMuc
    HAVING TongDoanhThu > 0
    ORDER BY TongDoanhThu DESC;
END //

DELIMITER ;