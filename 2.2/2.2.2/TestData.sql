-- 0. Tạo Danh mục (Để tránh lỗi khóa ngoại khi tạo sản phẩm)
INSERT INTO DANHMUC (maDanhMuc, tenDanhMuc) VALUES (36, 'Danh Muc Test Trigger');


-- =================================================================
-- 1. TẠO NGƯỜI BÁN (ID 15)
-- =================================================================
-- B1: Tạo thông tin cơ bản
INSERT INTO NGUOIDUNG (maNguoiDung, hoTen, email, matKhau, sdt, ngaySinh, soNha, duong, phuongXa, quanHuyen, tinhThanh, daXacThucSDT) 
VALUES 
(15, 'Chu Shop Uy Tin', 'seller15@test.com', '123456', '0901111115', '1990-01-01', '15A', 'Duong Kinh Doanh', 'Phuong 1', 'Quan 1', 'TP.HCM', 1);

-- B2: [QUAN TRỌNG] Cấp quyền Người Bán (Thiếu dòng này là lỗi ngay)
INSERT INTO NGUOIBAN (maNguoiDung) VALUES (15);

-- B3: Tạo Cửa hàng (Lưu ý: cột maNguoiBan)
INSERT INTO CUAHANG (maCuaHang, tenCuaHang, moTa, maNguoiBan, ngayTao) 
VALUES (15, 'Shop Trigger Demo', 'Shop chuyen ban do test', 15, NOW());


-- =================================================================
-- 2. TẠO SẢN PHẨM (ID 99)
-- =================================================================
INSERT INTO SANPHAM (maSanPham, tenSanPham, moTaChiTiet, giaGoc, giaBan, soLuongCon, maDanhMuc, maCuaHang) 
VALUES (99, 'Ao Thun Test Trigger', 'Ao test logic he thong', 100000, 50000, 10, 36, 15);
