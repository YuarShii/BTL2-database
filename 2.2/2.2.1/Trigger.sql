DELIMITER //

-- TRIGGER 1: KIỂM TRA ĐIỀU KIỆN TRƯỚC KHI HỦY (Validation)
CREATE TRIGGER trg_BeforeUpdate_CheckHuy
BEFORE UPDATE ON DONHANG
FOR EACH ROW
BEGIN
    -- Chỉ kiểm tra khi người dùng muốn chuyển trạng thái sang 'da_huy'
    IF NEW.trangThaiDonHang = 'da_huy' AND OLD.trangThaiDonHang != 'da_huy' THEN

        -- TRƯỜNG HỢP 1: Kiểm tra trạng thái đơn hàng
        -- Chỉ cho phép hủy khi đang 'cho_xac_nhan' hoặc 'dang_chuan_bi'
        IF OLD.trangThaiDonHang NOT IN ('cho_xac_nhan', 'dang_chuan_bi') THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Lỗi: Đơn hàng đã được xử lý hoặc đang giao, không thể hủy lúc này.';
        END IF;

        -- TRƯỜNG HỢP 2: Kiểm tra thời gian (2 giờ = 120 phút)
        -- Nếu trạng thái ok nhưng đã quá 2 tiếng -> Báo lỗi thời gian
        IF TIMESTAMPDIFF(MINUTE, OLD.ngayDatHang, NOW()) > 120 THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Lỗi: Đã quá hạn 2 giờ kể từ khi đặt hàng, bạn không thể hủy đơn này nữa.';
        END IF;

    END IF;
END//

-- TRIGGER 2: HOÀN KHO & THÔNG BÁO SAU KHI HỦY (Action)
CREATE TRIGGER trg_AfterUpdate_HoanKho_ThongBao
AFTER UPDATE ON DONHANG
FOR EACH ROW
BEGIN
    IF NEW.trangThaiDonHang = 'da_huy' AND OLD.trangThaiDonHang != 'da_huy' THEN
        
        -- 1. Hoàn tồn kho (Cộng lại số lượng vào bảng SANPHAM)
        UPDATE SANPHAM s 
        JOIN CHI_TIET_DONHANG ctd ON s.maSanPham = ctd.maSanPham 
        SET s.soLuongCon = s.soLuongCon + ctd.soLuongMua 
        WHERE ctd.maDonHang = OLD.maDonHang;

        -- 2. Tạo thông báo Demo (Gán vào biến @thong_bao để xem kết quả)
        SET @thong_bao = CONCAT('THÀNH CÔNG: Đã hủy đơn hàng #', NEW.maDonHang, 
                                '. Hệ thống đã hoàn lại tồn kho.');
    END IF;
END//

DELIMITER ;