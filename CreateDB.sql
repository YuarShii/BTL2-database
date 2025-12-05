-- Tạo cơ sở dữ liệu
CREATE DATABASE IF NOT EXISTS testdbbk;
USE testdbbk;

-- Bảng DANHMUC (Danh mục sản phẩm, hỗ trợ đệ quy)
CREATE TABLE DANHMUC (
    maDanhMuc INT PRIMARY KEY AUTO_INCREMENT,
    tenDanhMuc VARCHAR(255) NOT NULL,
    parentDanhMuc INT,
    FOREIGN KEY (parentDanhMuc) REFERENCES DANHMUC(maDanhMuc)
);

-- Bảng NGUOIDUNG (Người dùng)
CREATE TABLE NGUOIDUNG (
    maNguoiDung INT PRIMARY KEY AUTO_INCREMENT,
    hoTen VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    matKhau VARCHAR(255) NOT NULL,
    sdt VARCHAR(20) UNIQUE NOT NULL,
    ngaySinh DATE,
    soNha VARCHAR(50),
    duong VARCHAR(255),
    phuongXa VARCHAR(100),
    quanHuyen VARCHAR(100),
    tinhThanh VARCHAR(100),
    daXacThucSDT BOOLEAN DEFAULT FALSE -- Để hỗ trợ ràng buộc 6
);

-- Bảng NGUOIBAN (Người bán - Kế thừa từ NGUOIDUNG)
CREATE TABLE NGUOIBAN (
    maNguoiDung INT PRIMARY KEY,
    FOREIGN KEY (maNguoiDung) REFERENCES NGUOIDUNG(maNguoiDung) ON DELETE CASCADE
);

-- Bảng NGUOIMUA (Người mua - Kế thừa từ NGUOIDUNG)
CREATE TABLE NGUOIMUA (
    maNguoiDung INT PRIMARY KEY,
    FOREIGN KEY (maNguoiDung) REFERENCES NGUOIDUNG(maNguoiDung) ON DELETE CASCADE
);

-- Bảng CUAHANG (Cửa hàng)
CREATE TABLE CUAHANG (
    maCuaHang INT PRIMARY KEY AUTO_INCREMENT,
    tenCuaHang VARCHAR(255) NOT NULL,
    moTa TEXT,
    diaChiLayHangSoNha VARCHAR(50),
    diaChiLayHangDuong VARCHAR(255),
    diaChiLayHangPhuongXa VARCHAR(100),
    diaChiLayHangQuanHuyen VARCHAR(100),
    diaChiLayHangTinhThanh VARCHAR(100),
    ngayTao DATE NOT NULL,
    maNguoiBan INT UNIQUE, 
    FOREIGN KEY (maNguoiBan) REFERENCES NGUOIBAN(maNguoiDung) -- Trỏ về bảng NGUOIBAN
);

-- Bảng SHIPPER (Người giao hàng, 1:1 với NGUOIDUNG)
CREATE TABLE SHIPPER (
    maShipper INT PRIMARY KEY AUTO_INCREMENT,
    kvGiaoHang VARCHAR(255) NOT NULL, -- Khu vực giao hàng
    ngayThamGia DATE NOT NULL,
    trangThaiHoatDong ENUM('dang_hoat_dong', 'tam_ngung', 'da_nghi') DEFAULT 'dang_hoat_dong',
    diemDanhGiaTrungBinh DECIMAL(3,2) DEFAULT 0, -- FIX: Removed GENERATED; use triggers to update
    maNguoiDung INT UNIQUE, -- 1:1
    FOREIGN KEY (maNguoiDung) REFERENCES NGUOIDUNG(maNguoiDung)
);

-- Bảng SANPHAM (Sản phẩm)
CREATE TABLE SANPHAM (
    maSanPham INT PRIMARY KEY AUTO_INCREMENT,
    tenSanPham VARCHAR(255) NOT NULL,
    moTaChiTiet TEXT,
    giaGoc DECIMAL(15,2) NOT NULL CHECK (giaGoc >= 0), -- Ràng buộc 1 phần: >=0
    giaBan DECIMAL(15,2) NOT NULL CHECK (giaBan >= 0), -- Ràng buộc 1: <= giaGoc
    soLuongCon INT NOT NULL DEFAULT 0 CHECK (soLuongCon >= 0), -- Ràng buộc 7
    phanTramGiamGia DECIMAL(5,2) GENERATED ALWAYS AS ( -- Derived (this is fine, no subquery)
        CASE WHEN giaGoc > 0 THEN ((giaGoc - giaBan) / giaGoc * 100) ELSE 0 END
    ) VIRTUAL,
    maDanhMuc INT NOT NULL,
    maCuaHang INT NOT NULL,
    FOREIGN KEY (maDanhMuc) REFERENCES DANHMUC(maDanhMuc),
    FOREIGN KEY (maCuaHang) REFERENCES CUAHANG(maCuaHang),
    -- ĐƯA RÀNG BUỘC SO SÁNH 2 CỘT XUỐNG DƯỚI CÙNG NÀY MỚI ĐÚNG:
    CONSTRAINT chk_GiaBanHopLe CHECK (giaBan <= giaGoc)
);

-- Bảng GIOHANG (Giỏ hàng)
CREATE TABLE GIOHANG (
    maGioHang INT PRIMARY KEY AUTO_INCREMENT,
    soLuong INT NOT NULL DEFAULT 0 CHECK (soLuong >= 0),
    ngayThemVaoGio TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    tongTienGioHang DECIMAL(15,2) DEFAULT 0,
    maNguoiDung INT UNIQUE, 
    FOREIGN KEY (maNguoiDung) REFERENCES NGUOIMUA(maNguoiDung) -- Trỏ về bảng NGUOIMUA
);

-- Bảng CHI_TIET_GIOHANG (Chi tiết giỏ hàng, weak entity)
CREATE TABLE CHI_TIET_GIOHANG (
    maGioHang INT NOT NULL,
    maSanPham INT NOT NULL,
    soLuongGio INT NOT NULL CHECK (soLuongGio > 0),
    giaLucThemGio DECIMAL(15,2) NOT NULL CHECK (giaLucThemGio >= 0),
    ngayThemVaoGio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (maGioHang, maSanPham),
    FOREIGN KEY (maGioHang) REFERENCES GIOHANG(maGioHang) ON DELETE CASCADE,
    FOREIGN KEY (maSanPham) REFERENCES SANPHAM(maSanPham) ON DELETE CASCADE
);

-- Bảng DONHANG (Đơn hàng)
CREATE TABLE DONHANG (
    maDonHang INT PRIMARY KEY AUTO_INCREMENT,
    ngayDatHang TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tongTien DECIMAL(15,2) NOT NULL CHECK (tongTien >= 0),
    trangThaiDonHang ENUM('cho_xac_nhan', 'dang_chuan_bi', 'dang_giao', 'da_giao', 'da_huy') DEFAULT 'cho_xac_nhan',
    diaChiGiaoHangSoNha VARCHAR(50),
    diaChiGiaoHangDuong VARCHAR(255),
    diaChiGiaoHangPhuongXa VARCHAR(100),
    diaChiGiaoHangQuanHuyen VARCHAR(100),
    diaChiGiaoHangTinhThanh VARCHAR(100),
    phuongThucThanhToan ENUM('tien_mat', 'the_tin_dung', 'vi_dien_tu') NOT NULL,
    ngayThanhToan TIMESTAMP NULL,
    tongTienSauGiam DECIMAL(15,2) DEFAULT 0,
    maGioHang INT,
    maNguoiDung INT NOT NULL, 
    FOREIGN KEY (maGioHang) REFERENCES GIOHANG(maGioHang),
    FOREIGN KEY (maNguoiDung) REFERENCES NGUOIMUA(maNguoiDung) -- Trỏ về bảng NGUOIMUA
);

-- Bảng CHI_TIET_DONHANG (Chi tiết đơn hàng)
CREATE TABLE CHI_TIET_DONHANG (
    maDonHang INT NOT NULL,
    maSanPham INT NOT NULL,
    soLuongMua INT NOT NULL CHECK (soLuongMua > 0), -- Ràng buộc 2 sẽ dùng trigger
    giaLucMua DECIMAL(15,2) NOT NULL CHECK (giaLucMua >= 0),
    PRIMARY KEY (maDonHang, maSanPham),
    FOREIGN KEY (maDonHang) REFERENCES DONHANG(maDonHang) ON DELETE CASCADE,
    FOREIGN KEY (maSanPham) REFERENCES SANPHAM(maSanPham)
);

-- Bảng KHUYENMAI (Khuyến mãi)
CREATE TABLE KHUYENMAI (
    maKhuyenMai INT PRIMARY KEY AUTO_INCREMENT,
    moTa TEXT,
    soTienGiam DECIMAL(15,2) NOT NULL CHECK (soTienGiam >= 0),
    giaTriDonHangToiThieu DECIMAL(15,2) NOT NULL CHECK (giaTriDonHangToiThieu >= 0), -- Ràng buộc 8 phần
    soLanSuDungToiDa INT NOT NULL CHECK (soLanSuDungToiDa > 0),
    soLanDaDung INT DEFAULT 0, -- FIX: Removed GENERATED; use triggers to update
    tinhTrang ENUM('active', 'inactive', 'expired') DEFAULT 'active',
    hanSuDung DATE NOT NULL, -- Ràng buộc 5 sẽ dùng trigger khi áp dụng
    maCuaHang INT NULL, -- NULL cho hệ thống
    FOREIGN KEY (maCuaHang) REFERENCES CUAHANG(maCuaHang)
);

-- Bảng AP_DUNG_KHUYENMAI (Áp dụng khuyến mãi, weak entity)
CREATE TABLE AP_DUNG_KHUYENMAI (
    maApDung INT PRIMARY KEY AUTO_INCREMENT,
    maDonHang INT NOT NULL,
    maKhuyenMai INT NOT NULL,
    soTienGiamThucTe DECIMAL(15,2) NOT NULL CHECK (soTienGiamThucTe >= 0),
    FOREIGN KEY (maDonHang) REFERENCES DONHANG(maDonHang) ON DELETE CASCADE,
    FOREIGN KEY (maKhuyenMai) REFERENCES KHUYENMAI(maKhuyenMai),
    UNIQUE KEY (maDonHang, maKhuyenMai) -- Một đơn chỉ áp một mã
);

-- Bảng DANHGIA (Đánh giá sản phẩm)
CREATE TABLE DANHGIA (
    maDanhGia INT PRIMARY KEY AUTO_INCREMENT,
    diemSo INT CHECK (diemSo BETWEEN 1 AND 5),
    binhLuan TEXT,
    ngayDanhGia TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    maNguoiDung INT NOT NULL, -- Người mua đánh giá
    maSanPham INT NOT NULL,
    maDonHang INT NOT NULL,
    FOREIGN KEY (maNguoiDung) REFERENCES NGUOIMUA(maNguoiDung), -- Trỏ về NGUOIMUA
    FOREIGN KEY (maSanPham) REFERENCES SANPHAM(maSanPham) ON DELETE CASCADE,
    FOREIGN KEY (maDonHang) REFERENCES DONHANG(maDonHang),
    UNIQUE KEY (maNguoiDung, maSanPham, maDonHang)
);

-- Bảng GIAO_HANG (Giao hàng, weak entity)
CREATE TABLE GIAO_HANG (
    maGiaoHang INT PRIMARY KEY AUTO_INCREMENT,
    maDonHang INT NOT NULL UNIQUE, -- Một đơn chỉ một giao hàng
    maShipper INT NOT NULL,
    thoiGianNhanDon TIMESTAMP NULL,
    thoiGianLayHang TIMESTAMP NULL,
    thoiGianGiaoKhach TIMESTAMP NULL,
    trangThaiGiaoHang ENUM('dang_lay_hang', 'dang_van_chuyen', 'da_giao_thanh_cong', 'huy_giao') DEFAULT 'dang_lay_hang',
    ghiChu TEXT,
    FOREIGN KEY (maDonHang) REFERENCES DONHANG(maDonHang) ON DELETE CASCADE,
    FOREIGN KEY (maShipper) REFERENCES SHIPPER(maShipper)
);

-- Bảng DANHGIA_SHIPPER (Đánh giá shipper)
CREATE TABLE DANHGIA_SHIPPER (
    maDanhGiaShipper INT PRIMARY KEY AUTO_INCREMENT,
    diemSoShipper INT CHECK (diemSoShipper BETWEEN 1 AND 5),
    binhLuanShipper TEXT,
    ngayDanhGiaShipper TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    maNguoiDung INT NOT NULL, -- Người mua đánh giá
    maShipper INT NOT NULL,
    maDonHang INT NOT NULL,
    FOREIGN KEY (maNguoiDung) REFERENCES NGUOIMUA(maNguoiDung), -- Trỏ về NGUOIMUA
    FOREIGN KEY (maShipper) REFERENCES SHIPPER(maShipper),
    FOREIGN KEY (maDonHang) REFERENCES DONHANG(maDonHang),
    UNIQUE KEY (maNguoiDung, maShipper, maDonHang)
);

-- Các Trigger cho ràng buộc ngữ nghĩa không thể dùng CHECK

-- Trigger 2: Kiểm tra soLuongMua <= soLuongCon khi insert CHI_TIET_DONHANG, và cập nhật soLuongCon
DELIMITER //
CREATE TRIGGER check_sl_mua_before_insert
BEFORE INSERT ON CHI_TIET_DONHANG
FOR EACH ROW
BEGIN
    DECLARE sl_con INT;
    SELECT soLuongCon INTO sl_con FROM SANPHAM WHERE maSanPham = NEW.maSanPham;
    IF NEW.soLuongMua > sl_con THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Số lượng mua vượt quá tồn kho';
    END IF;
    -- Cập nhật tồn kho
    UPDATE SANPHAM SET soLuongCon = soLuongCon - NEW.soLuongMua WHERE maSanPham = NEW.maSanPham;
END//

CREATE TRIGGER check_sl_mua_before_update
BEFORE UPDATE ON CHI_TIET_DONHANG
FOR EACH ROW
BEGIN
    DECLARE sl_con INT;
    DECLARE sl_cu INT;
    SELECT soLuongCon INTO sl_con FROM SANPHAM WHERE maSanPham = NEW.maSanPham;
    SELECT soLuongMua INTO sl_cu FROM CHI_TIET_DONHANG WHERE maDonHang = OLD.maDonHang AND maSanPham = OLD.maSanPham;
    IF NEW.soLuongMua > sl_con + sl_cu THEN  -- + sl_cu vì sẽ hoàn tồn kho cũ
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Số lượng mua vượt quá tồn kho';
    END IF;
    -- Cập nhật tồn kho (giả sử update chỉ thay đổi số lượng, hoàn cũ trước)
    UPDATE SANPHAM SET soLuongCon = soLuongCon + sl_cu - NEW.soLuongMua WHERE maSanPham = NEW.maSanPham;
END//
DELIMITER ;

-- Trigger 3: Kiểm tra đã mua và giao thành công trước khi insert DANHGIA
DELIMITER //
CREATE TRIGGER check_danhgia_sp_before_insert
BEFORE INSERT ON DANHGIA
FOR EACH ROW
BEGIN
    DECLARE tt_dh ENUM('da_giao');
    SELECT trangThaiDonHang INTO tt_dh FROM DONHANG WHERE maDonHang = NEW.maDonHang;
    IF tt_dh != 'da_giao' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Chỉ đánh giá sau khi đơn hàng giao thành công';
    END IF;
END//
DELIMITER ;

-- Trigger 4: Kiểm tra chuyển trạng thái đơn hàng hợp lệ (ví dụ đơn giản: không quay ngược)
DELIMITER //
CREATE TRIGGER check_trangthai_dh_before_update
BEFORE UPDATE ON DONHANG
FOR EACH ROW
BEGIN
    -- Định nghĩa thứ tự: cho_xac_nhan=1, dang_chuan_bi=2, dang_giao=3, da_giao=4, da_huy=0
    DECLARE old_order INT DEFAULT 0;
    DECLARE new_order INT DEFAULT 0;
    IF OLD.trangThaiDonHang = 'cho_xac_nhan' THEN SET old_order = 1; END IF;
    IF OLD.trangThaiDonHang = 'dang_chuan_bi' THEN SET old_order = 2; END IF;
    IF OLD.trangThaiDonHang = 'dang_giao' THEN SET old_order = 3; END IF;
    IF OLD.trangThaiDonHang = 'da_giao' THEN SET old_order = 4; END IF;
    IF OLD.trangThaiDonHang = 'da_huy' THEN SET old_order = 0; END IF;
    
    IF NEW.trangThaiDonHang = 'cho_xac_nhan' THEN SET new_order = 1; END IF;
    IF NEW.trangThaiDonHang = 'dang_chuan_bi' THEN SET new_order = 2; END IF;
    IF NEW.trangThaiDonHang = 'dang_giao' THEN SET new_order = 3; END IF;
    IF NEW.trangThaiDonHang = 'da_giao' THEN SET new_order = 4; END IF;
    IF NEW.trangThaiDonHang = 'da_huy' THEN SET new_order = 0; END IF;
    
    IF new_order > old_order AND old_order != 0 THEN  -- Cho phép hủy bất kỳ lúc nào, nhưng không quay ngược
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Không thể chuyển trạng thái ngược quy trình';
    END IF;
END//
DELIMITER ;

-- Trigger 5: Kiểm tra mã khuyến mãi còn hạn khi áp dụng (insert AP_DUNG_KHUYENMAI)
DELIMITER //
CREATE TRIGGER check_khuyenmai_han_before_insert
BEFORE INSERT ON AP_DUNG_KHUYENMAI
FOR EACH ROW
BEGIN
    DECLARE hd DATE;
    DECLARE tt ENUM('active');
    DECLARE sl_da_dung INT;
    SELECT hanSuDung, tinhTrang, soLanDaDung INTO hd, tt, sl_da_dung 
    FROM KHUYENMAI WHERE maKhuyenMai = NEW.maKhuyenMai;
    IF CURDATE() > hd OR tt != 'active' OR sl_da_dung >= (SELECT soLanSuDungToiDa FROM KHUYENMAI WHERE maKhuyenMai = NEW.maKhuyenMai) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mã khuyến mãi hết hạn hoặc không hợp lệ';
    END IF;
END//
DELIMITER ;

-- Trigger 6: Kiểm tra xác thực SDT trước khi insert DONHANG
DELIMITER //
CREATE TRIGGER check_xacthuc_sdt_before_insert_dh
BEFORE INSERT ON DONHANG
FOR EACH ROW
BEGIN
    IF NOT (SELECT daXacThucSDT FROM NGUOIDUNG WHERE maNguoiDung = NEW.maNguoiDung) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tài khoản phải xác thực số điện thoại để đặt hàng';
    END IF;
END//
DELIMITER ;

-- Trigger 8: Kiểm tra tổng tiền >= giaTriDonHangToiThieu khi áp dụng khuyến mãi
DELIMITER //
CREATE TRIGGER check_giatri_toithieu_before_insert_ap
BEFORE INSERT ON AP_DUNG_KHUYENMAI
FOR EACH ROW
BEGIN
    DECLARE gt_tt DECIMAL(15,2);
    DECLARE gt_min DECIMAL(15,2);
    SELECT tongTien, giaTriDonHangToiThieu INTO gt_tt, gt_min 
    FROM DONHANG d JOIN KHUYENMAI k ON d.maDonHang = NEW.maDonHang AND k.maKhuyenMai = NEW.maKhuyenMai;
    IF gt_tt < gt_min THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tổng tiền đơn hàng chưa đạt giá trị tối thiểu';
    END IF;
END//
DELIMITER ;

-- Trigger 9: Người dùng không tự đánh giá sản phẩm cửa hàng mình
DELIMITER //
CREATE TRIGGER check_tu_danhgia_before_insert
BEFORE INSERT ON DANHGIA
FOR EACH ROW
BEGIN
    DECLARE ma_ch INT;
    SELECT maCuaHang INTO ma_ch FROM SANPHAM WHERE maSanPham = NEW.maSanPham;
    IF ma_ch IS NOT NULL AND (SELECT maNguoiBan FROM CUAHANG WHERE maCuaHang = ma_ch) = NEW.maNguoiDung THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Không thể tự đánh giá sản phẩm của cửa hàng mình';
    END IF;
END//
DELIMITER ;



-- Trigger cập nhật soLanDaDung sau khi insert AP_DUNG (nhưng vì derived, không cần nếu dùng GENERATED)
-- Tương tự cho derived khác, MySQL sẽ tự handle nếu STORED/VIRTUAL phù hợp.

DELIMITER $$

-- Trigger after INSERT
CREATE TRIGGER trg_update_shipper_avg_after_insert
AFTER INSERT ON DANHGIA_SHIPPER
FOR EACH ROW
BEGIN
    UPDATE SHIPPER
    SET diemDanhGiaTrungBinh = COALESCE((
        SELECT AVG(diemSoShipper)
        FROM DANHGIA_SHIPPER
        WHERE maShipper = NEW.maShipper
    ), 0)
    WHERE maShipper = NEW.maShipper;
END$$

-- Trigger after UPDATE (e.g., if diemSoShipper changes)
CREATE TRIGGER trg_update_shipper_avg_after_update
AFTER UPDATE ON DANHGIA_SHIPPER
FOR EACH ROW
BEGIN
    UPDATE SHIPPER
    SET diemDanhGiaTrungBinh = COALESCE((
        SELECT AVG(diemSoShipper)
        FROM DANHGIA_SHIPPER
        WHERE maShipper = NEW.maShipper
    ), 0)
    WHERE maShipper = NEW.maShipper;
END$$

-- Trigger after DELETE
CREATE TRIGGER trg_update_shipper_avg_after_delete
AFTER DELETE ON DANHGIA_SHIPPER
FOR EACH ROW
BEGIN
    UPDATE SHIPPER
    SET diemDanhGiaTrungBinh = COALESCE((
        SELECT AVG(diemSoShipper)
        FROM DANHGIA_SHIPPER
        WHERE maShipper = OLD.maShipper
    ), 0)
    WHERE maShipper = OLD.maShipper;
END$$

DELIMITER ;