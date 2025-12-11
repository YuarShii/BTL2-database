USE testdbbk;

-- TẠO ĐƠN HÀNG MỚI

-- --- Đơn hàng 10:Dell XPS 
INSERT INTO DONHANG (ngayDatHang, tongTien, trangThaiDonHang, diaChiGiaoHangSoNha, diaChiGiaoHangDuong, phuongThucThanhToan, ngayThanhToan, maNguoiDung) VALUES
('2025-10-15 09:00:00', 24000000, 'da_giao', '11', 'Lê Văn Sỹ', 'vi_dien_tu', '2025-10-15 09:05:00', 11);

-- Dell XPS 
INSERT INTO CHI_TIET_DONHANG (maDonHang, maSanPham, soLuongMua, giaLucMua) VALUES
(10, 16, 1, 24000000); 

INSERT INTO GIAO_HANG (maDonHang, maShipper, thoiGianNhanDon, thoiGianLayHang, thoiGianGiaoKhach, trangThaiGiaoHang) VALUES
(10, 1, '2025-10-15 09:30:00', '2025-10-15 10:30:00', '2025-10-15 14:00:00', 'da_giao_thanh_cong');

-- --- Đơn hàng 11: Mua Gaming Gear 
INSERT INTO DONHANG (ngayDatHang, tongTien, trangThaiDonHang, diaChiGiaoHangSoNha, diaChiGiaoHangDuong, phuongThucThanhToan, ngayThanhToan, maNguoiDung) VALUES
('2025-11-11 10:00:00', 3200000, 'da_giao', '22', 'CMT8', 'vi_dien_tu', '2025-11-11 10:05:00', 12);

-- Phím(12), Chuột(13)
INSERT INTO CHI_TIET_DONHANG (maDonHang, maSanPham, soLuongMua, giaLucMua) VALUES
(11, 12, 1, 2200000), 
(11, 13, 1, 1000000);

INSERT INTO GIAO_HANG (maDonHang, maShipper, thoiGianNhanDon, thoiGianLayHang, thoiGianGiaoKhach, trangThaiGiaoHang) VALUES
(11, 2, '2025-11-11 10:30:00', '2025-11-11 11:30:00', '2025-11-11 15:00:00', 'da_giao_thanh_cong');

-- --- Đơn hàng 12: Mua Sách
INSERT INTO DONHANG (ngayDatHang, tongTien, trangThaiDonHang, diaChiGiaoHangSoNha, diaChiGiaoHangDuong, phuongThucThanhToan, ngayThanhToan, maNguoiDung) VALUES
('2025-11-20 08:00:00', 1900000, 'da_giao', '33', 'Hoàng Văn Thụ', 'tien_mat', '2025-11-20 16:00:00', 13);

-- Sách Harry Potter (6) và Đắc Nhân Tâm (7)
INSERT INTO CHI_TIET_DONHANG (maDonHang, maSanPham, soLuongMua, giaLucMua) VALUES
(12, 6, 1, 1800000),
(12, 7, 1, 100000); 

INSERT INTO GIAO_HANG (maDonHang, maShipper, thoiGianNhanDon, thoiGianLayHang, thoiGianGiaoKhach, trangThaiGiaoHang) VALUES
(12, 3, '2025-11-20 08:30:00', '2025-11-20 09:30:00', '2025-11-20 16:00:00', 'da_giao_thanh_cong');

-- --- Đơn hàng 13: Mua đồ gia dụng 
INSERT INTO DONHANG (ngayDatHang, tongTien, trangThaiDonHang, diaChiGiaoHangSoNha, diaChiGiaoHangDuong, phuongThucThanhToan, ngayThanhToan, maNguoiDung) VALUES
('2025-12-05 14:00:00', 1900000, 'da_giao', '44', 'Trường Chinh', 'the_tin_dung', '2025-12-05 14:05:00', 14);

-- Nồi chiên (18), Máy xay (19)
INSERT INTO CHI_TIET_DONHANG (maDonHang, maSanPham, soLuongMua, giaLucMua) VALUES
(13, 18, 1, 1200000),
(13, 19, 1, 700000);

INSERT INTO GIAO_HANG (maDonHang, maShipper, thoiGianNhanDon, thoiGianLayHang, thoiGianGiaoKhach, trangThaiGiaoHang) VALUES
(13, 4, '2025-12-05 14:30:00', '2025-12-05 15:30:00', '2025-12-05 17:00:00', 'da_giao_thanh_cong');

-- --- Đơn hàng 14: Macbook Air M1 
INSERT INTO DONHANG (ngayDatHang, tongTien, trangThaiDonHang, diaChiGiaoHangSoNha, diaChiGiaoHangDuong, phuongThucThanhToan, ngayThanhToan, maNguoiDung) VALUES
('2025-12-06 09:00:00', 14500000, 'dang_giao', '55', 'Cộng Hòa', 'vi_dien_tu', '2025-12-06 09:05:00', 15);

-- Macbook Air M1 (15)
INSERT INTO CHI_TIET_DONHANG (maDonHang, maSanPham, soLuongMua, giaLucMua) VALUES
(14, 15, 1, 14500000);

INSERT INTO GIAO_HANG (maDonHang, maShipper, thoiGianNhanDon, thoiGianLayHang, trangThaiGiaoHang) VALUES
(14, 5, '2025-12-06 09:30:00', '2025-12-06 10:30:00', 'dang_van_chuyen');

-- --- Đơn hàng 15:
INSERT INTO DONHANG (ngayDatHang, tongTien, trangThaiDonHang, diaChiGiaoHangSoNha, diaChiGiaoHangDuong, phuongThucThanhToan, maNguoiDung) VALUES
('2025-12-07 08:00:00', 17500000, 'da_huy', '66', 'Phạm Văn Đồng', 'tien_mat', 16);

-- Asus TUF (17)
INSERT INTO CHI_TIET_DONHANG (maDonHang, maSanPham, soLuongMua, giaLucMua) VALUES
(15, 17, 1, 17500000);