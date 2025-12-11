USE testdbbk;
-- 1. TEST CASE 1: HỦY ĐƠN HỢP LỆ (Thành công)
-- Tạo đơn hàng mới đặt cách đây 1 giờ (trong khoảng 2h cho phép)
INSERT INTO DONHANG (maDonHang, tongTien, trangThaiDonHang, maNguoiDung, phuongThucThanhToan, ngayDatHang) 
VALUES (101, 700000, 'cho_xac_nhan', 1, 'tien_mat', DATE_SUB(NOW(), INTERVAL 1 HOUR));

-- Gắn sản phẩm vào đơn 101 (Khách mua 5 cái của sản phẩm 101)
INSERT INTO CHI_TIET_DONHANG (maDonHang, maSanPham, soLuongMua, giaLucMua) 
VALUES (101, 1, 5, 140000);

-- Kiểm tra kho trước khi hủy (để so sánh)
SELECT maSanPham, soLuongCon  FROM SANPHAM WHERE maSanPham = 1;

-- Thực hiện HỦY ĐƠN 101
UPDATE DONHANG SET trangThaiDonHang = 'da_huy' WHERE maDonHang = 101;

-- Kiểm tra thông báo từ hệ thống
SELECT @thong_bao as 'KetQua_ThongBao';

-- Kiểm tra kho sau khi hủy (Phải tăng lên 5 đơn vị)
SELECT maSanPham, soLuongCon  FROM SANPHAM WHERE maSanPham = 1;


-- 2. TEST CASE 2: LỖI THỜI GIAN (Quá 2 giờ)
-- Tạo đơn hàng đặt cách đây 5 giờ
INSERT INTO DONHANG (maDonHang, tongTien, trangThaiDonHang, maNguoiDung, phuongThucThanhToan, ngayDatHang) 
VALUES (102, 200000, 'cho_xac_nhan', 1, 'tien_mat', DATE_SUB(NOW(), INTERVAL 5 HOUR));

-- Cố tình hủy đơn hàng 102 -> Mong đợi lỗi đỏ
UPDATE DONHANG SET trangThaiDonHang = 'da_huy' WHERE maDonHang = 102;


-- 3. TEST CASE 3: LỖI TRẠNG THÁI (Đang giao hàng)
-- Tạo đơn hàng đang ở trạng thái 'dang_giao'
INSERT INTO DONHANG (maDonHang, tongTien, trangThaiDonHang, maNguoiDung, phuongThucThanhToan, ngayDatHang) 
VALUES (103, 300000, 'dang_giao', 1, 'tien_mat', NOW());

-- Cố tình hủy đơn hàng 103 -> Mong đợi lỗi đỏ
UPDATE DONHANG SET trangThaiDonHang = 'da_huy' WHERE maDonHang = 103;