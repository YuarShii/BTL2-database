-- B1. Khách (ID 20) thêm 2 áo vào giỏ
-- Kỳ vọng: Tổng tiền = 100.000 (2 * 50k)
INSERT INTO CHI_TIET_GIOHANG (maGioHang, maSanPham, soLuongGio, giaLucThemGio) VALUES (20, 99, 2, 50000);
SELECT maGioHang, tongTienGioHang FROM GIOHANG WHERE maGioHang = 20;

-- B2. Khách sửa số lượng lên 5 áo
-- Kỳ vọng: Tổng tiền = 250.000 (5 * 50k)
UPDATE CHI_TIET_GIOHANG SET soLuongGio = 5 WHERE maGioHang = 20 AND maSanPham = 99;
SELECT maGioHang, tongTienGioHang FROM GIOHANG WHERE maGioHang = 20;

-- B3. Chủ Shop (ID 15) Tăng giá áo lên 200k
-- Kỳ vọng: Giỏ hàng khách tự nhảy tiền lên 500.000 (5 * 100k)
UPDATE SANPHAM SET GiaBan = 100000 WHERE maSanPham = 99;
SELECT maGioHang, tongTienGioHang FROM GIOHANG WHERE maGioHang = 20;

-- B4. Chủ Shop (ID 15) Báo cháy kho, cập nhật kho chỉ còn 2 cái
-- Kỳ vọng: Giỏ hàng khách (đang chọn 5) tự giảm xuống 2. Tiền giảm còn 200.000 (2 * 100k)
UPDATE SANPHAM SET SoLuongCon = 2 WHERE maSanPham = 99;
SELECT maGioHang, tongTienGioHang FROM GIOHANG WHERE maGioHang = 20;

-- B5. Chủ Shop Xóa luôn sản phẩm
-- Kỳ vọng: Tổng tiền giỏ hàng về 0 (Không bị lỗi tiền ảo)
DELETE FROM SANPHAM WHERE maSanPham = 99;
SELECT maGioHang, tongTienGioHang FROM GIOHANG WHERE maGioHang = 20;