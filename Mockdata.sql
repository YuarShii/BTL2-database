USE testdbbk;
-- 1. Insert sample data into DANHMUC (5 records, hierarchical)
INSERT INTO DANHMUC (tenDanhMuc, parentDanhMuc) VALUES
('Điện thoại', NULL),
('Thời trang', NULL),
('Điện tử', NULL),
('Điện thoại Samsung', 1),
('Thời trang nam', 2);

-- 2. Insert sample data into NGUOIDUNG (10 records)
INSERT INTO NGUOIDUNG (hoTen, email, matKhau, sdt, ngaySinh, soNha, duong, phuongXa, quanHuyen, tinhThanh, daXacThucSDT) VALUES
('Trịnh Minh Chủ', 'chutrinh@email.com', 'pass123', '0123456781', '1990-01-01', '123', 'Nguyễn Huệ', 'Bến Nghé', 'Quận 1', 'TP.HCM', TRUE),
('Nguyễn Tuấn Đạt', 'datnguyen@email.com', 'pass123', '0123456782', '1992-02-02', '456', 'Lê Lợi', 'Bến Nghé', 'Quận 1', 'TP.HCM', TRUE),
('Nguyễn Đức Gia Phú', 'phunguyen@email.com', 'pass123', '0123456783', '1995-03-03', '789', 'Pasteur', 'Bến Nghé', 'Quận 1', 'TP.HCM', TRUE),
('Nguyễn Hữu Hưng', 'hungnguyen@email.com', 'pass123', '0123456784', '1993-04-04', '101', 'Hàm Nghi', 'Bến Nghé', 'Quận 1', 'TP.HCM', TRUE),
('Lê Thị Hoa', 'hoale@email.com', 'pass123', '0123456785', '1991-05-05', '202', 'Nguyễn Thị Minh Khai', 'Bến Thành', 'Quận 1', 'TP.HCM', TRUE),
('Shipper A', 'shippera@email.com', 'pass123', '0123456786', '1985-06-06', '303', 'Lê Thánh Tôn', 'Bến Nghé', 'Quận 1', 'TP.HCM', TRUE),
('Shipper B', 'shipperb@email.com', 'pass123', '0123456787', '1986-07-07', '404', 'Nguyễn Đình Chiểu', 'Bến Thành', 'Quận 1', 'TP.HCM', TRUE),
('Shipper C', 'shipperc@email.com', 'pass123', '0123456788', '1987-08-08', '505', 'Lý Tự Trọng', 'Bến Thành', 'Quận 1', 'TP.HCM', TRUE),
('Shipper D', 'shipperd@email.com', 'pass123', '0123456789', '1988-09-09', '606', 'Hồ Tùng Mậu', 'Phú Nhuận', 'Quận Phú Nhuận', 'TP.HCM', TRUE),
('Shipper E', 'shippere@email.com', 'pass123', '0123456790', '1989-10-10', '707', 'Cao Thắng', 'Phú Nhuận', 'Quận Phú Nhuận', 'TP.HCM', TRUE);

-- [QUAN TRỌNG] 3. Insert NGUOIBAN & NGUOIMUA (Để tránh lỗi khóa ngoại)
-- Users 1-5 đóng vai trò là Người Bán (Chủ shop)
INSERT INTO NGUOIBAN (maNguoiDung) VALUES (1), (2), (3), (4), (5);

-- Users 1-5 cũng đóng vai trò là Người Mua (Có giỏ hàng, đặt hàng)
INSERT INTO NGUOIMUA (maNguoiDung) VALUES (1), (2), (3), (4), (5);


-- 4. Insert sample data into CUAHANG (5 records, linked to NGUOIBAN 1-5)
INSERT INTO CUAHANG (tenCuaHang, moTa, diaChiLayHangSoNha, diaChiLayHangDuong, diaChiLayHangPhuongXa, diaChiLayHangQuanHuyen, diaChiLayHangTinhThanh, ngayTao, maNguoiBan) VALUES
('Shop Chủ Tech', 'Cửa hàng điện thoại', '123', 'Nguyễn Huệ', 'Bến Nghé', 'Quận 1', 'TP.HCM', '2025-01-01', 1),
('Đạt Fashion', 'Thời trang cao cấp', '456', 'Lê Lợi', 'Bến Nghé', 'Quận 1', 'TP.HCM', '2025-01-02', 2),
('Phú Electronics', 'Điện tử giá rẻ', '789', 'Pasteur', 'Bến Nghé', 'Quận 1', 'TP.HCM', '2025-01-03', 3),
('Hưng Store', 'Đa dạng sản phẩm', '101', 'Hàm Nghi', 'Bến Nghé', 'Quận 1', 'TP.HCM', '2025-01-04', 4),
('Hoa Boutique', 'Thời trang nữ', '202', 'Nguyễn Thị Minh Khai', 'Bến Thành', 'Quận 1', 'TP.HCM', '2025-01-05', 5);

-- 5. Insert sample data into SHIPPER (5 records, linked to users 6-10)
INSERT INTO SHIPPER (kvGiaoHang, ngayThamGia, trangThaiHoatDong, maNguoiDung) VALUES
('Quận 1', '2025-01-01', 'dang_hoat_dong', 6),
('Quận 3', '2025-01-02', 'dang_hoat_dong', 7),
('Quận 7', '2025-01-03', 'dang_hoat_dong', 8),
('Bình Thạnh', '2025-01-04', 'tam_ngung', 9),
('Quận 10', '2025-01-05', 'dang_hoat_dong', 10);

-- 6. Insert sample data into SANPHAM (5 records)
INSERT INTO SANPHAM (tenSanPham, moTaChiTiet, giaGoc, giaBan, soLuongCon, maDanhMuc, maCuaHang) VALUES
('iPhone 15', 'Điện thoại Apple', 25000000.00, 22000000.00, 10, 1, 1),
('Áo sơ mi nam', 'Thời trang cotton', 500000.00, 400000.00, 20, 2, 2),
('Tai nghe Sony', 'Tai nghe không dây', 2000000.00, 1800000.00, 15, 3, 3),
('Samsung Galaxy S24', 'Điện thoại Samsung', 20000000.00, 19000000.00, 8, 4, 1),
('Quần jeans', 'Quần jeans nam', 800000.00, 600000.00, 25, 5, 4);

-- 7. Insert sample data into GIOHANG (Linked to NGUOIMUA 1-5)
INSERT INTO GIOHANG (soLuong, ngayThemVaoGio, maNguoiDung) VALUES
(2, '2025-12-01 10:00:00', 1),
(1, '2025-12-01 11:00:00', 2),
(3, '2025-12-01 12:00:00', 3),
(0, '2025-12-01 13:00:00', 4),
(4, '2025-12-01 14:00:00', 5);

-- 8. Insert sample data into CHI_TIET_GIOHANG
INSERT INTO CHI_TIET_GIOHANG (maGioHang, maSanPham, soLuongGio, giaLucThemGio, ngayThemVaoGio) VALUES
(1, 1, 1, 22000000.00, '2025-12-01 10:00:00'),
(1, 2, 1, 400000.00, '2025-12-01 10:30:00'),
(2, 3, 1, 1800000.00, '2025-12-01 11:00:00'),
(3, 4, 2, 19000000.00, '2025-12-01 12:00:00'),
(3, 5, 1, 600000.00, '2025-12-01 12:30:00');

-- 9. Insert sample data into DONHANG (Linked to NGUOIMUA 1-5)
INSERT INTO DONHANG (ngayDatHang, tongTien, trangThaiDonHang, diaChiGiaoHangSoNha, diaChiGiaoHangDuong, diaChiGiaoHangPhuongXa, diaChiGiaoHangQuanHuyen, diaChiGiaoHangTinhThanh, phuongThucThanhToan, ngayThanhToan, maGioHang, maNguoiDung) VALUES
('2025-12-01 15:00:00', 22400000.00, 'cho_xac_nhan', '123', 'Nguyễn Huệ', 'Bến Nghé', 'Quận 1', 'TP.HCM', 'vi_dien_tu', NULL, 1, 1),
('2025-12-01 16:00:00', 1800000.00, 'dang_chuan_bi', '456', 'Lê Lợi', 'Bến Nghé', 'Quận 1', 'TP.HCM', 'the_tin_dung', '2025-12-01 16:05:00', 2, 2),
('2025-12-01 17:00:00', 40000000.00, 'dang_giao', '789', 'Pasteur', 'Bến Nghé', 'Quận 1', 'TP.HCM', 'tien_mat', NULL, 3, 3),
('2025-12-01 18:00:00', 300000.00, 'da_giao', '101', 'Hàm Nghi', 'Bến Nghé', 'Quận 1', 'TP.HCM', 'vi_dien_tu', '2025-12-01 18:05:00', 4, 4),
('2025-12-01 19:00:00', 600000.00, 'da_huy', '202', 'Nguyễn Thị Minh Khai', 'Bến Thành', 'Quận 1', 'TP.HCM', 'the_tin_dung', NULL, 5, 5);

-- 10. Insert sample data into CHI_TIET_DONHANG
INSERT INTO CHI_TIET_DONHANG (maDonHang, maSanPham, soLuongMua, giaLucMua) VALUES
(1, 1, 1, 22000000.00),
(1, 2, 1, 400000.00),
(2, 3, 1, 1800000.00),
(3, 4, 2, 19000000.00),
(3, 5, 1, 600000.00),
(4, 1, 1, 22000000.00), 
(4, 2, 1, 400000.00),    
(4, 5, 1, 600000.00); 

-- 11. Insert sample data into KHUYENMAI
INSERT INTO KHUYENMAI (moTa, soTienGiam, giaTriDonHangToiThieu, soLanSuDungToiDa, tinhTrang, hanSuDung, maCuaHang) VALUES
('Giảm 10% cho đơn đầu', 1000000.00, 5000000.00, 10, 'active', '2025-12-31', NULL),
('Khuyến mãi shop Chủ', 500000.00, 2000000.00, 5, 'active', '2025-12-15', 1),
('Flash sale thời trang', 200000.00, 1000000.00, 20, 'active', '2025-12-10', 2),
('Giảm giá điện tử', 300000.00, 3000000.00, 8, 'inactive', '2025-12-05', 3),
('Mã shipper đặc biệt', 100000.00, 0.00, 50, 'active', '2025-12-31', NULL);

-- 12. Insert sample data into AP_DUNG_KHUYENMAI
INSERT INTO AP_DUNG_KHUYENMAI (maDonHang, maKhuyenMai, soTienGiamThucTe) VALUES
(1, 1, 1000000.00),
(2, 5, 100000.00),
(3, 3, 200000.00),
(4, 5, 100000.00),
(5, 5, 100000.00);

-- 13. Insert sample data into DANHGIA (Linked to NGUOIMUA 1-5)
INSERT INTO DANHGIA (diemSo, binhLuan, ngayDanhGia, maNguoiDung, maSanPham, maDonHang) VALUES
(3, 'Bình thường', '2025-12-02 13:00:00', 1, 3, 4),  
(5, 'Rất tốt', '2025-12-02 14:00:00', 2, 3, 4),
(4, 'Ổn', '2025-12-02 15:00:00', 3, 5, 4),  
(2, 'Kém chất lượng', '2025-12-02 16:00:00', 4, 1, 4),  
(1, 'Không hài lòng', '2025-12-02 17:00:00', 5, 2, 4);


-- 14. Insert sample data into GIAO_HANG
INSERT INTO GIAO_HANG (maDonHang, maShipper, thoiGianNhanDon, thoiGianLayHang, thoiGianGiaoKhach, trangThaiGiaoHang, ghiChu) VALUES
(1, 1, '2025-12-01 15:30:00', NULL, NULL, 'dang_lay_hang', 'Giao nhanh'),
(2, 2, '2025-12-01 16:30:00', '2025-12-01 17:00:00', NULL, 'dang_van_chuyen', 'OK'),
(3, 3, '2025-12-01 17:30:00', '2025-12-01 18:00:00', '2025-12-01 19:00:00', 'da_giao_thanh_cong', 'Thành công'),
(4, 4, '2025-12-01 18:30:00', '2025-12-01 19:00:00', '2025-12-01 20:00:00', 'da_giao_thanh_cong', 'Hoàn tất'),
(5, 5, NULL, NULL, NULL, 'huy_giao', 'Hủy do khách');

-- 15. Insert sample data into DANHGIA_SHIPPER (Linked to NGUOIMUA 1-5)
INSERT INTO DANHGIA_SHIPPER (diemSoShipper, binhLuanShipper, ngayDanhGiaShipper, maNguoiDung, maShipper, maDonHang) VALUES
(5, 'Shipper thân thiện', '2025-12-02 10:30:00', 1, 1, 1),
(4, 'Giao đúng giờ', '2025-12-02 11:30:00', 2, 2, 2),
(5, 'Nhanh chóng', '2025-12-02 12:30:00', 3, 3, 3),
(3, 'Chậm một chút', '2025-12-02 13:30:00', 4, 4, 4),
(2, 'Không hài lòng', '2025-12-02 14:30:00', 5, 5, 5);