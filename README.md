# Thăm Viếng Đúng Tuyến - Flutter Material 3

Ứng dụng quản lý tuyến bán hàng và hoạt động thăm viếng cửa hàng (SFA / DMS) được phát triển bằng Flutter theo hệ thống thiết kế Material 3 từ Figma.

## Các tính năng chính

- **Danh sách cửa hàng thăm viếng**: Phân loại theo 3 trạng thái với màu sắc trực quan (Đã thăm viếng, Lỡ viếng thăm, Chưa thăm viếng).
- **M3 App Bar & Search**: Tích hợp thanh tìm kiếm sản phẩm / cửa hàng, bộ lọc và avatar người dùng.
- **Speed Dial FAB Menu**: Menu mở rộng với hiệu ứng nền mờ (Scrim) hỗ trợ các tác vụ nhanh:
  - Viếng thăm trái tuyến
  - Tạo khách hàng
  - Tạo chi nhánh
- **Modal Bottom Sheet Chi tiết & Pin Map**:
  - Xem thông tin chi nhánh (Kênh, Loại khách hàng, Phương thức thanh toán).
  - Khoảng cách đến điểm bán (50.00m).
  - Bản đồ mini định vị vị trí hiện tại và điểm ghé thăm, hỗ trợ nút "Mở Google Map".
- **Màn hình Hoạt động thăm viếng**: Danh sách 5 bước checklist nghiệp vụ chuẩn SFA và nút hoàn thành viếng thăm.

## Chạy trên GitHub Pages (Tự động)

Repository này đã được cấu hình sẵn **GitHub Actions** (`.github/workflows/deploy.yml`). Khi bạn push code lên nhánh `main`, hệ thống sẽ tự động:
1. Build Flutter Web phiên bản Release.
2. Tự động deploy lên **GitHub Pages** để chạy demo online miễn phí.
