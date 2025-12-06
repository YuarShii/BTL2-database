
SELECT '--- TEST 1: Shop 1 (Có doanh thu tháng 12/2025) ---' AS TieuDe_Test;
CALL sp_ThongKeDoanhThuTheoDanhMuc(1, 12, 2025);


-- TRƯỜNG HỢP 2: Cửa hàng bán được hàng nhưng khác danh mục (Cross-check)
-- Cửa hàng: Shop 2 (Đạt Fashion)
-- Thời gian: Tháng 12/2025
-- Lý do kỳ vọng có dữ liệu: Đơn hàng #4 cũng chứa 'Áo sơ mi nam' của Shop 2.
SELECT '--- TEST 2: Shop 2 (Có doanh thu tháng 12/2025) ---' AS TieuDe_Test;
CALL sp_ThongKeDoanhThuTheoDanhMuc(2, 12, 2025);


-- TRƯỜNG HỢP 3: Cửa hàng KHÔNG có doanh thu thực tế (Empty Case)
-- Cửa hàng: Shop 3 (Phú Electronics)
-- Lý do: Shop 3 có sản phẩm trong Đơn #2 và #3, nhưng 2 đơn này CHƯA giao thành công ('dang_chuan_bi', 'dang_giao').
SELECT '--- TEST 3: Shop 3 (Chưa có đơn thành công) ---' AS TieuDe_Test;
CALL sp_ThongKeDoanhThuTheoDanhMuc(3, 12, 2025);


-- TRƯỜNG HỢP 4: Sai thời gian (Wrong Time)
-- Cửa hàng: Shop 1
-- Thời gian: Tháng 01/2025 (Dữ liệu mẫu toàn ở tháng 12)
SELECT '--- TEST 4: Shop 1 (Tra cứu sai tháng - T1/2025) ---' AS TieuDe_Test;
CALL sp_ThongKeDoanhThuTheoDanhMuc(1, 1, 2025);