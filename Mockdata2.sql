USE testdbbk;


-- 1. THÊM DANH MỤC MỚI 

INSERT INTO DANHMUC (tenDanhMuc, parentDanhMuc) VALUES
('Sách', NULL), 
('Nhà cửa', NULL),    
('Laptop', 3),             
('Tiểu thuyết', 6),             
('Sách giáo khoa', 6),           
('Dụng cụ nhà bếp', 7),         
('Trang trí nhà cửa', 7),      
('Macbook', 8),                  
('Laptop Gaming', 8),            
('Phụ kiện máy tính', 8);        


-- 2. THÊM 20 NGƯỜI DÙNG MỚI 

INSERT INTO NGUOIDUNG (hoTen, email, matKhau, sdt, ngaySinh, soNha, duong, phuongXa, quanHuyen, tinhThanh, daXacThucSDT) VALUES
('Phạm Văn Mạnh', 'manhpham@email.com', 'pass123', '0900000011', '1995-01-15', '11', 'Lê Văn Sỹ', 'Phường 14', 'Quận 3', 'TP.HCM', TRUE),
('Trần Thị Bích', 'bichtran@email.com', 'pass123', '0900000012', '1998-05-20', '22', 'Cách Mạng Tháng 8', 'Phường 5', 'Tân Bình', 'TP.HCM', TRUE),
('Lê Quốc Tuấn', 'tuanle@email.com', 'pass123', '0900000013', '1992-12-12', '33', 'Hoàng Văn Thụ', 'Phường 4', 'Tân Bình', 'TP.HCM', TRUE),
('Ngô Thanh Vân', 'vanngo@email.com', 'pass123', '0900000014', '1990-08-08', '44', 'Trường Chinh', 'Phường 12', 'Tân Bình', 'TP.HCM', TRUE),
('Đỗ Hùng Dũng', 'dunghung@email.com', 'pass123', '0900000015', '1997-02-28', '55', 'Cộng Hòa', 'Phường 13', 'Tân Bình', 'TP.HCM', TRUE),
-- Người mua (16-25)
('Bùi Tấn Trường', 'truongbui@email.com', 'pass123', '0900000016', '2000-01-01', '66', 'Phạm Văn Đồng', 'Hiệp Bình Chánh', 'Thủ Đức', 'TP.HCM', TRUE),
('Nguyễn Công Phượng', 'phuongnguyen@email.com', 'pass123', '0900000017', '1996-03-03', '77', 'Kha Vạn Cân', 'Linh Chiểu', 'Thủ Đức', 'TP.HCM', TRUE),
('Nguyễn Quang Hải', 'hainguyen@email.com', 'pass123', '0900000018', '1999-09-09', '88', 'Võ Văn Ngân', 'Bình Thọ', 'Thủ Đức', 'TP.HCM', TRUE),
('Đoàn Văn Hậu', 'haudoan@email.com', 'pass123', '0900000019', '2001-10-10', '99', 'Tô Ngọc Vân', 'Linh Tây', 'Thủ Đức', 'TP.HCM', TRUE),
('Quế Ngọc Hải', 'haique@email.com', 'pass123', '0900000020', '1994-04-04', '100', 'Đặng Văn Bi', 'Trường Thọ', 'Thủ Đức', 'TP.HCM', TRUE),
('User Mới 1', 'user21@email.com', 'pass123', '0900000021', '1995-01-01', '1', 'Đường A', 'Phường A', 'Quận 1', 'TP.HCM', TRUE),
('User Mới 2', 'user22@email.com', 'pass123', '0900000022', '1995-01-01', '1', 'Đường A', 'Phường A', 'Quận 1', 'TP.HCM', TRUE),
('User Mới 3', 'user23@email.com', 'pass123', '0900000023', '1995-01-01', '1', 'Đường A', 'Phường A', 'Quận 1', 'TP.HCM', TRUE),
('User Mới 4', 'user24@email.com', 'pass123', '0900000024', '1995-01-01', '1', 'Đường A', 'Phường A', 'Quận 1', 'TP.HCM', TRUE),
('User Mới 5', 'user25@email.com', 'pass123', '0900000025', '1995-01-01', '1', 'Đường A', 'Phường A', 'Quận 1', 'TP.HCM', TRUE),
-- Shipper mới (26-30)
('Shipper X', 'shipperx@email.com', 'pass123', '0900000026', '1990-01-01', '2', 'Đường B', 'Phường B', 'Quận 3', 'TP.HCM', TRUE),
('Shipper Y', 'shippery@email.com', 'pass123', '0900000027', '1990-01-01', '2', 'Đường B', 'Phường B', 'Quận 3', 'TP.HCM', TRUE),
('Shipper Z', 'shipperz@email.com', 'pass123', '0900000028', '1990-01-01', '2', 'Đường B', 'Phường B', 'Quận 3', 'TP.HCM', TRUE),
('Shipper W', 'shipperw@email.com', 'pass123', '0900000029', '1990-01-01', '2', 'Đường B', 'Phường B', 'Quận 3', 'TP.HCM', TRUE),
('Shipper K', 'shipperk@email.com', 'pass123', '0900000030', '1990-01-01', '2', 'Đường B', 'Phường B', 'Quận 3', 'TP.HCM', TRUE);


-- 3. PHÂN QUYỀN (NGUOIBAN, NGUOIMUA, SHIPPER)

-- 5 Người bán mới 
INSERT INTO NGUOIBAN (maNguoiDung) VALUES (11), (12), (13), (14), (15);

-- Tất cả người dùng mới đều là Người mua
INSERT INTO NGUOIMUA (maNguoiDung) VALUES 
(11), (12), (13), (14), (15), (16), (17), (18), (19), (20),
(21), (22), (23), (24), (25), (26), (27), (28), (29), (30);

-- 5 Shipper mới 
INSERT INTO SHIPPER (kvGiaoHang, ngayThamGia, trangThaiHoatDong, maNguoiDung) VALUES
('Tân Bình', '2025-06-01', 'dang_hoat_dong', 26),
('Thủ Đức', '2025-06-02', 'dang_hoat_dong', 27),
('Gò Vấp', '2025-06-03', 'dang_hoat_dong', 28),
('Bình Thạnh', '2025-06-04', 'tam_ngung', 29),
('Quận 12', '2025-06-05', 'dang_hoat_dong', 30);


-- 4. THÊM CỬA HÀNG MỚI 

INSERT INTO CUAHANG (tenCuaHang, moTa, diaChiLayHangSoNha, diaChiLayHangDuong, diaChiLayHangPhuongXa, diaChiLayHangQuanHuyen, diaChiLayHangTinhThanh, ngayTao, maNguoiBan) VALUES
('Mạnh Books', 'Chuyên sách ngoại văn', '11', 'Lê Văn Sỹ', 'Phường 14', 'Quận 3', 'TP.HCM', '2025-06-01', 11),
('Bích Decor', 'Trang trí nội thất', '22', 'CMT8', 'Phường 5', 'Tân Bình', 'TP.HCM', '2025-06-02', 12),
('Tuấn Gaming Gear', 'Chuột, phím cơ', '33', 'Hoàng Văn Thụ', 'Phường 4', 'Tân Bình', 'TP.HCM', '2025-06-03', 13),
('Vân Laptop', 'Laptop cũ giá rẻ', '44', 'Trường Chinh', 'Phường 12', 'Tân Bình', 'TP.HCM', '2025-06-04', 14),
('Dũng Kitchen', 'Đồ gia dụng thông minh', '55', 'Cộng Hòa', 'Phường 13', 'Tân Bình', 'TP.HCM', '2025-06-05', 15);


-- 5. THÊM SẢN PHẨM MỚI (Khoảng 20 sản phẩm)

-- 5. THÊM SẢN PHẨM MỚI

-- Shop Mạnh Books (ID CuaHang 6)
INSERT INTO SANPHAM (tenSanPham, moTaChiTiet, giaGoc, giaBan, soLuongCon, maDanhMuc, maCuaHang) VALUES
('Harry Potter trọn bộ', 'Bìa cứng, tiếng Anh', 2000000, 1800000, 50, 9, 6),
('Đắc Nhân Tâm', 'Sách kỹ năng sống', 100000, 80000, 100, 6, 6),
('Toán Cao Cấp tập 1', 'Giáo trình đại học', 150000, 150000, 200, 10, 6); 
-- Lưu ý: Kết thúc bằng dấu chấm phẩy (;) ở đây

-- Shop Bích Decor (ID CuaHang 7)
INSERT INTO SANPHAM (tenSanPham, moTaChiTiet, giaGoc, giaBan, soLuongCon, maDanhMuc, maCuaHang) VALUES
('Đèn ngủ để bàn', 'Ánh sáng vàng ấm', 300000, 250000, 30, 12, 7),
('Thảm trải sàn', 'Lông cừu nhân tạo', 500000, 450000, 20, 12, 7),
('Khung tranh canvas', 'Bộ 3 tranh', 200000, 180000, 40, 12, 7);

-- Shop Tuấn Gaming (ID CuaHang 8)
INSERT INTO SANPHAM (tenSanPham, moTaChiTiet, giaGoc, giaBan, soLuongCon, maDanhMuc, maCuaHang) VALUES
('Bàn phím cơ Keychron', 'Switch Red, Led RGB', 2500000, 2200000, 15, 15, 8),
('Chuột Logitech G502', 'Gaming mouse', 1200000, 1000000, 25, 15, 8),
('Tai nghe HyperX', 'Âm thanh vòm 7.1', 1800000, 1600000, 20, 15, 8);

-- Shop Vân Laptop (ID CuaHang 9)
INSERT INTO SANPHAM (tenSanPham, moTaChiTiet, giaGoc, giaBan, soLuongCon, maDanhMuc, maCuaHang) VALUES
('Macbook Air M1 cũ', 'Pin 90%, ngoại hình 99%', 15000000, 14500000, 5, 13, 9),
('Dell XPS 13 9310', 'Core i7, Ram 16GB', 25000000, 24000000, 3, 8, 9),
('Asus TUF Gaming', 'RTX 3050, Ryzen 5', 18000000, 17500000, 8, 14, 9);

-- Shop Dũng Kitchen (ID CuaHang 10)
INSERT INTO SANPHAM (tenSanPham, moTaChiTiet, giaGoc, giaBan, soLuongCon, maDanhMuc, maCuaHang) VALUES
('Nồi chiên không dầu', 'Dung tích 5L', 1500000, 1200000, 50, 11, 10),
('Máy xay sinh tố', 'Công suất lớn', 800000, 700000, 40, 11, 10),
('Bộ dao nhà bếp', 'Thép không gỉ', 500000, 400000, 60, 11, 10),
('Chảo chống dính', 'Size 28cm', 300000, 250000, 50, 11, 10);


-- 6. TẠO KHUYẾN MÃI MỚI

INSERT INTO KHUYENMAI (moTa, soTienGiam, giaTriDonHangToiThieu, soLanSuDungToiDa, tinhTrang, hanSuDung, maCuaHang) VALUES
('Sale Hè Sách', 50000, 200000, 100, 'active', '2026-01-01', 6), -- Shop Mạnh
('Giảm giá Gaming Gear', 200000, 1000000, 50, 'active', '2026-01-01', 8), -- Shop Tuấn
('Voucher Sàn', 30000, 0, 1000, 'active', '2026-12-31', NULL);


-- 7. TẠO ĐƠN HÀNG VÀ DỮ LIỆU LIÊN QUAN (Phức tạp)

-- --- Đơn hàng 6: Mới đặt 
INSERT INTO DONHANG (ngayDatHang, tongTien, trangThaiDonHang, diaChiGiaoHangSoNha, diaChiGiaoHangDuong, phuongThucThanhToan, maNguoiDung) VALUES
('2025-12-05 08:00:00', 1800000, 'cho_xac_nhan', '66', 'Phạm Văn Đồng', 'tien_mat', 16);

INSERT INTO CHI_TIET_DONHANG (maDonHang, maSanPham, soLuongMua, giaLucMua) VALUES
(6, 6, 1, 1800000); -- Harry Potter

-- --- Đơn hàng 7: Đang giao 
INSERT INTO DONHANG (ngayDatHang, tongTien, trangThaiDonHang, diaChiGiaoHangSoNha, diaChiGiaoHangDuong, phuongThucThanhToan, maNguoiDung) VALUES
('2025-12-04 10:00:00', 3200000, 'dang_giao', '77', 'Kha Vạn Cân', 'vi_dien_tu', 17);

INSERT INTO CHI_TIET_DONHANG (maDonHang, maSanPham, soLuongMua, giaLucMua) VALUES
(7, 12, 1, 2200000), -- Ban phim
(7, 13, 1, 1000000); -- Chuot

INSERT INTO GIAO_HANG (maDonHang, maShipper, thoiGianNhanDon, thoiGianLayHang, trangThaiGiaoHang) VALUES
(7, 6, '2025-12-04 10:30:00', '2025-12-04 11:00:00', 'dang_van_chuyen');

-- --- Đơn hàng 8: Đã giao thành công 
-- Đơn này áp dụng mã khuyến mãi
INSERT INTO DONHANG (ngayDatHang, tongTien, trangThaiDonHang, diaChiGiaoHangSoNha, diaChiGiaoHangDuong, phuongThucThanhToan, ngayThanhToan, tongTienSauGiam, maNguoiDung) VALUES
('2025-12-01 09:00:00', 1200000, 'da_giao', '88', 'Võ Văn Ngân', 'the_tin_dung', '2025-12-01 09:05:00', 1170000, 18);

INSERT INTO CHI_TIET_DONHANG (maDonHang, maSanPham, soLuongMua, giaLucMua) VALUES
(8, 16, 1, 1200000); -- Noi chien khong dau

INSERT INTO AP_DUNG_KHUYENMAI (maDonHang, maKhuyenMai, soTienGiamThucTe) VALUES
(8, 8, 30000); -- Voucher San

INSERT INTO GIAO_HANG (maDonHang, maShipper, thoiGianNhanDon, thoiGianLayHang, thoiGianGiaoKhach, trangThaiGiaoHang) VALUES
(8, 7, '2025-12-01 09:30:00', '2025-12-01 10:30:00', '2025-12-01 14:00:00', 'da_giao_thanh_cong');

-- --- Đơn hàng 9: Đã giao thành công 
INSERT INTO DONHANG (ngayDatHang, tongTien, trangThaiDonHang, diaChiGiaoHangSoNha, diaChiGiaoHangDuong, phuongThucThanhToan, ngayThanhToan, maNguoiDung) VALUES
('2025-12-02 14:00:00', 700000, 'da_giao', '99', 'Tô Ngọc Vân', 'tien_mat', '2025-12-02 16:00:00', 19);

INSERT INTO CHI_TIET_DONHANG (maDonHang, maSanPham, soLuongMua, giaLucMua) VALUES
(9, 9, 1, 250000), -- Den ngu
(9, 10, 1, 450000); -- Tham

INSERT INTO GIAO_HANG (maDonHang, maShipper, thoiGianNhanDon, thoiGianLayHang, thoiGianGiaoKhach, trangThaiGiaoHang) VALUES
(9, 8, '2025-12-02 14:30:00', '2025-12-02 15:00:00', '2025-12-02 16:00:00', 'da_giao_thanh_cong');

-- 8. TẠO ĐÁNH GIÁ 

INSERT INTO DANHGIA (diemSo, binhLuan, ngayDanhGia, maNguoiDung, maSanPham, maDonHang) VALUES
(5, 'Nồi dùng rất tốt, chiên gà giòn', '2025-12-02 08:00:00', 18, 16, 8);
INSERT INTO DANHGIA_SHIPPER (diemSoShipper, binhLuanShipper, ngayDanhGiaShipper, maNguoiDung, maShipper, maDonHang) VALUES
(4, 'Giao hàng hơi lâu nhưng thái độ tốt', '2025-12-02 08:05:00', 18, 7, 8);
INSERT INTO DANHGIA (diemSo, binhLuan, ngayDanhGia, maNguoiDung, maSanPham, maDonHang) VALUES
(4, 'Đèn đẹp, hơi nhỏ so với tưởng tượng', '2025-12-03 09:00:00', 19, 9, 9);
INSERT INTO DANHGIA (diemSo, binhLuan, ngayDanhGia, maNguoiDung, maSanPham, maDonHang) VALUES
(5, 'Thảm êm chân, màu sắc đúng hình', '2025-12-03 09:05:00', 19, 10, 9);