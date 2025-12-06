
-- ----------------------------------------------------------------------
-- PHẦN A: TEST FUNCTION f_TinhDiemTBShipper
-- ----------------------------------------------------------------------
SELECT '=== PHẦN A: KIỂM TRA ĐIỂM SHIPPER ===' AS Phan_Test;

-- Test 1: Shipper có đánh giá cao
-- Shipper ID: 1
-- Kỳ vọng: 5.00 (Do có 1 đánh giá 5 sao trong Mockdata)
SELECT 
    1 AS MaShipper, 
    'Shipper A' AS Ten, 
    f_TinhDiemTBShipper(1) AS DiemTB_KetQua
UNION ALL

-- Test 2: Shipper có đánh giá trung bình
-- Shipper ID: 4
-- Kỳ vọng: 3.00 (Do có 1 đánh giá 3 sao trong Mockdata)
SELECT 
    4, 
    'Shipper D', 
    f_TinhDiemTBShipper(4)
UNION ALL

-- Test 3: Shipper chưa có đánh giá nào
-- Shipper ID: 10 (Giả sử shipper mới)
-- Kỳ vọng: 0.00
SELECT 
    10, 
    'Shipper New', 
    f_TinhDiemTBShipper(10);


-- ----------------------------------------------------------------------
-- PHẦN B: TEST FUNCTION f_TinhTongTienSauGiam
-- ----------------------------------------------------------------------
SELECT '=== PHẦN B: KIỂM TRA TỔNG TIỀN ĐƠN HÀNG ===' AS Phan_Test;

-- Test 1: Đơn hàng ĐÃ GIAO (Tính tiền thật)
-- Đơn hàng ID: 4
-- Trạng thái: 'da_giao'
-- Chi tiết: 22tr (Phone) + 400k (Áo) + 600k (Quần) = 23,000,000
-- Giảm giá: 100,000 (Mã KM 5)
-- Kỳ vọng: 22,900,000.00
SELECT 
    4 AS MaDonHang, 
    'da_giao' AS TrangThai, 
    f_TinhTongTienSauGiam(4) AS TongTien_SauGiam,
    CASE WHEN f_TinhTongTienSauGiam(4) = 22900000 THEN 'PASS' ELSE 'FAIL' END AS Check_Valid;


-- Test 2: Đơn hàng CHƯA GIAO (Trả về 0)
-- Đơn hàng ID: 1
-- Trạng thái: 'cho_xac_nhan'
-- Kỳ vọng: 0.00 (Do chưa giao nên chưa tính doanh thu thực tế)
SELECT 
    1 AS MaDonHang, 
    'cho_xac_nhan' AS TrangThai, 
    f_TinhTongTienSauGiam(1) AS TongTien_SauGiam,
    CASE WHEN f_TinhTongTienSauGiam(1) = 0 THEN 'PASS' ELSE 'FAIL' END AS Check_Valid;


-- Test 3: Đơn hàng ĐANG GIAO (Trả về 0)
-- Đơn hàng ID: 3
-- Trạng thái: 'dang_giao'
-- Kỳ vọng: 0.00 (Chưa hoàn tất giao hàng)
SELECT 
    3 AS MaDonHang, 
    'dang_giao' AS TrangThai, 
    f_TinhTongTienSauGiam(3) AS TongTien_SauGiam,
    CASE WHEN f_TinhTongTienSauGiam(3) = 0 THEN 'PASS' ELSE 'FAIL' END AS Check_Valid;