-- 0. Tạo Danh mục (Để tránh lỗi khóa ngoại khi tạo sản phẩm)
INSERT INTO DANHMUC (maDanhMuc, tenDanhMuc) VALUES (36, 'Danh Muc Test Trigger');


-- =================================================================
-- 1. TẠO NGƯỜI BÁN (ID 15)
-- =================================================================
-- B1: Tạo thông tin cơ bản
INSERT INTO NGUOIDUNG (maNguoiDung, hoTen, email, matKhau, sdt, ngaySinh, soNha, duong, phuongXa, quanHuyen, tinhThanh, daXacThucSDT) 
VALUES 
(99, 'Chu Shop Uy Tin', 'seller15@test.com', '123456', '0901111115', '1990-01-01', '15A', 'Duong Kinh Doanh', 'Phuong 1', 'Quan 1', 'TP.HCM', 1);

-- B2: [QUAN TRỌNG] Cấp quyền Người Bán (Thiếu dòng này là lỗi ngay)
INSERT INTO NGUOIBAN (maNguoiDung) VALUES (99);

-- B3: Tạo Cửa hàng (Lưu ý: cột maNguoiBan)
INSERT INTO CUAHANG (maCuaHang, tenCuaHang, moTa, maNguoiBan, ngayTao) 
VALUES (99, 'Shop Trigger Demo', 'Shop chuyen ban do test', 99, NOW());


-- =================================================================
-- 2. TẠO SẢN PHẨM (ID 99)
-- =================================================================
INSERT INTO SANPHAM (maSanPham, tenSanPham, moTaChiTiet, giaGoc, giaBan, soLuongCon, maDanhMuc, maCuaHang) 
VALUES (99, 'Ao Thun Test Trigger', 'Ao test logic he thong', 100000, 50000, 10, 36, 99);




USE testdbbk;

-- ======================================================================================
-- BƯỚC 1: TẠO DANH MỤC (Dùng INSERT IGNORE để không lỗi nếu chạy nhiều lần)
-- ======================================================================================
INSERT IGNORE INTO DANHMUC (tenDanhMuc) VALUES 
('Điện Thoại'), 
('Laptop'), 
('Thời Trang Nam'), 
('Thời Trang Nữ'), 
('Phụ Kiện Công Nghệ');

-- Lấy ID vào biến (Safe mode)
SET @dm_dienthoai = (SELECT maDanhMuc FROM DANHMUC WHERE tenDanhMuc = 'Điện Thoại' LIMIT 1);
SET @dm_laptop = (SELECT maDanhMuc FROM DANHMUC WHERE tenDanhMuc = 'Laptop' LIMIT 1);
SET @dm_tt_nam = (SELECT maDanhMuc FROM DANHMUC WHERE tenDanhMuc = 'Thời Trang Nam' LIMIT 1);
SET @dm_tt_nu = (SELECT maDanhMuc FROM DANHMUC WHERE tenDanhMuc = 'Thời Trang Nữ' LIMIT 1);
SET @dm_phukien = (SELECT maDanhMuc FROM DANHMUC WHERE tenDanhMuc = 'Phụ Kiện Công Nghệ' LIMIT 1);


-- ======================================================================================
-- BƯỚC 2: TẠO NGƯỜI BÁN & CỬA HÀNG
-- ======================================================================================
-- Tạo User
INSERT IGNORE INTO NGUOIDUNG (hoTen, email, matKhau, sdt, daXacThucSDT) VALUES 
('Mr. Công Nghệ', 'tech@demo.com', '123', '0991112223', 1),
('Ms. Thời Trang', 'fashion@demo.com', '123', '0991112224', 1),
('Mr. Sale Sập Sàn', 'sale@demo.com', '123', '0991112225', 1);

-- Lấy ID
SET @u_tech = (SELECT maNguoiDung FROM NGUOIDUNG WHERE email = 'tech@demo.com');
SET @u_fashion = (SELECT maNguoiDung FROM NGUOIDUNG WHERE email = 'fashion@demo.com');
SET @u_sale = (SELECT maNguoiDung FROM NGUOIDUNG WHERE email = 'sale@demo.com');

-- Cấp quyền Bán
INSERT IGNORE INTO NGUOIBAN (maNguoiDung) VALUES (@u_tech), (@u_fashion), (@u_sale);

-- Tạo Shop
INSERT IGNORE INTO CUAHANG (tenCuaHang, maNguoiBan, ngayTao) VALUES 
('TechZone Official', @u_tech, NOW()),
('Fashionista SaiGon', @u_fashion, NOW()),
('Kho Giá Rẻ Vô Địch', @u_sale, NOW());

SET @shop_tech = (SELECT maCuaHang FROM CUAHANG WHERE tenCuaHang = 'TechZone Official');
SET @shop_fashion = (SELECT maCuaHang FROM CUAHANG WHERE tenCuaHang = 'Fashionista SaiGon');
SET @shop_sale = (SELECT maCuaHang FROM CUAHANG WHERE tenCuaHang = 'Kho Giá Rẻ Vô Địch');


-- ======================================================================================
-- BƯỚC 3: TẠO SẢN PHẨM (Dữ liệu Search Demo)
-- ======================================================================================

-- NHÓM 1: ĐIỆN THOẠI
INSERT INTO SANPHAM (tenSanPham, moTaChiTiet, giaGoc, giaBan, soLuongCon, maDanhMuc, maCuaHang) VALUES 
('iPhone 15 Pro Max 256GB', 'Titan Tự nhiên', 35000000, 33000000, 50, @dm_dienthoai, @shop_tech),
('iPhone 14 Plus 128GB', 'Màu Tím mộng mơ', 20000000, 18000000, 20, @dm_dienthoai, @shop_tech),
('Samsung Galaxy S24 Ultra', 'AI Phone mới nhất', 32000000, 30000000, 30, @dm_dienthoai, @shop_tech),
('Samsung Galaxy A54 5G', 'Điện thoại tầm trung', 8000000, 7500000, 100, @dm_dienthoai, @shop_tech),
('Xiaomi Redmi Note 13', 'Ngon bổ rẻ', 5000000, 4500000, 200, @dm_dienthoai, @shop_sale); 

-- NHÓM 2: LAPTOP
INSERT INTO SANPHAM (tenSanPham, moTaChiTiet, giaGoc, giaBan, soLuongCon, maDanhMuc, maCuaHang) VALUES 
('MacBook Air M2 2023', 'Siêu mỏng nhẹ', 28000000, 26000000, 15, @dm_laptop, @shop_tech),
('Laptop Gaming Asus TUF', 'Cấu hình khủng', 25000000, 22000000, 10, @dm_laptop, @shop_tech),
('Laptop Dell Vostro Văn Phòng', 'Bền bỉ', 15000000, 12000000, 20, @dm_laptop, @shop_sale);

-- NHÓM 3: THỜI TRANG
INSERT INTO SANPHAM (tenSanPham, moTaChiTiet, giaGoc, giaBan, soLuongCon, maDanhMuc, maCuaHang) VALUES 
('Áo Thun Nam Cotton', 'Thoáng mát mùa hè', 200000, 150000, 500, @dm_tt_nam, @shop_fashion),
('Quần Jean Nam Slimfit', 'Ống côn thời trang', 500000, 450000, 100, @dm_tt_nam, @shop_fashion),
('Váy Đầm Dự Tiệc', 'Sang trọng quý phái', 1200000, 900000, 50, @dm_tt_nu, @shop_fashion),
('Áo Khoác Blazer Nữ', 'Phong cách Hàn Quốc', 800000, 600000, 60, @dm_tt_nu, @shop_fashion),
('Áo Phông In Hình', 'Hàng tồn kho giá rẻ', 100000, 50000, 1000, @dm_tt_nam, @shop_sale);

-- NHÓM 4: PHỤ KIỆN
INSERT INTO SANPHAM (tenSanPham, moTaChiTiet, giaGoc, giaBan, soLuongCon, maDanhMuc, maCuaHang) VALUES 
('Tai Nghe Bluetooth AirPods', 'Rep 1:1', 500000, 300000, 200, @dm_phukien, @shop_sale),
('Chuột Không Dây Logitech', 'Silent Click', 400000, 350000, 50, @dm_phukien, @shop_tech),
('Bàn Phím Cơ Keychron', 'Gõ siêu sướng', 2000000, 1800000, 20, @dm_phukien, @shop_tech),
('Ốp Lưng iPhone 15', 'Chống sốc', 100000, 80000, 500, @dm_phukien, @shop_fashion),
('Sạc Dự Phòng 20000mAh', 'Sạc nhanh 22.5W', 600000, 450000, 100, @dm_phukien, @shop_sale),
('Cáp Sạc Type-C', 'Dây dù siêu bền', 50000, 30000, 1000, @dm_phukien, @shop_sale);


-- ======================================================================================
-- BƯỚC 4: TẠO DỮ LIỆU ĐỂ ĐÁNH GIÁ (Phần bạn thiếu)
-- ======================================================================================

-- 1. Tạo User Mua Hàng (ID 20)
INSERT IGNORE INTO NGUOIDUNG (maNguoiDung, hoTen, email, matKhau, sdt, daXacThucSDT) 
VALUES (20, 'Khach Test Review', 'review@test.com', '123', '0999888777', 1);

INSERT IGNORE INTO NGUOIMUA (maNguoiDung) VALUES (20);

-- 2. Tạo Giỏ hàng cho User 20 (Bắt buộc để tạo đơn)
INSERT IGNORE INTO GIOHANG (maGioHang, maNguoiDung) VALUES (20, 20);

-- 3. Tạo Đơn hàng giả định (ID 4) đã Giao thành công
-- (Để vượt qua Trigger kiểm tra trạng thái 'da_giao')
INSERT IGNORE INTO DONHANG (maDonHang, ngayDatHang, tongTien, trangThaiDonHang, maNguoiDung, maGioHang, phuongThucThanhToan)
VALUES (4, NOW(), 0, 'da_giao', 20, 20, 'tien_mat');

-- ======================================================================================
-- BƯỚC 5: INSERT ĐÁNH GIÁ (Chạy mượt mà)
-- ======================================================================================
INSERT INTO DANHGIA (diemSo, binhLuan, maNguoiDung, maSanPham, maDonHang)
SELECT 
    FLOOR(3 + (RAND() * 3)), -- Random điểm 3-5
    'Đánh giá tự động cho demo',
    20, -- User 20
    maSanPham,
    4   -- Đơn hàng 4 (Đã giao)
FROM SANPHAM 
WHERE maSanPham NOT IN (SELECT maSanPham FROM DANHGIA);