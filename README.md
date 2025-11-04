# 📱 QuizApp - Flutter + Firebase

Ứng dụng trắc nghiệm học tập cho học sinh tiểu học, được xây dựng bằng **Flutter** và **Firebase**.  
Bao gồm 2 phần chính:
- 👤 Ứng dụng người dùng (đăng ký, đăng nhập, làm bài trắc nghiệm)
- 🧑‍💼 Trang **Admin** (quản lý người dùng, tìm kiếm, cập nhật, xem hoạt động gần nhất)

---

## 🚀 Tính năng chính

### 👨‍🎓 Người dùng:
- Đăng ký bằng email và mật khẩu
- Chọn ảnh đại diện (lưu dạng Base64)
- Đăng nhập và lưu dữ liệu trên **Firestore**
- Làm bài trắc nghiệm học tập

### 🧑‍💼 Admin:
- Xem danh sách người dùng
- Thêm / Xóa / Tìm kiếm người dùng
- Cập nhật thông tin người dùng
- Theo dõi **thời gian hoạt động gần nhất (Last Login Time)**

---

## 🛠️ Công nghệ sử dụng

| Thành phần | Mô tả |
|-------------|--------|
| **Flutter** | Framework phát triển đa nền tảng |
| **Firebase Authentication** | Quản lý đăng nhập, đăng ký |
| **Firebase Firestore** | Lưu dữ liệu người dùng |
| **Base64 Encoding** | Lưu ảnh đại diện |
| **Dart** | Ngôn ngữ lập trình chính |

---

## 📂 Cấu trúc thư mục chính

lib/
┣ models/
┣ screens/
┣ widgets/
┣ main.dart
┗ firebase_options.dart

yaml
Sao chép mã

---

## 🔧 Cách chạy project

1. Clone repo:
   ```bash
   git clone https://github.com/<tên_tài_khoản>/<tên_repo>.git
Cài dependencies:

bash
Sao chép mã
flutter pub get
Chạy ứng dụng:

bash
Sao chép mã
flutter run
📅 Ghi chú
Để chạy được cần bật Firebase Authentication (Email/Password) và Cloud Firestore

Admin có thể đăng nhập bằng tài khoản được tạo thủ công trong Firebase Console

Khi người dùng đăng nhập, Last Login Time sẽ tự động cập nhật trên Firestore

❤️ Tác giả
Tên: Văn Duy
Mục tiêu: Xây dựng ứng dụng học tập thông minh và tiện lợi cho học sinh tiểu học.

💡 Project đang trong quá trình phát triển thêm tính năng Quiz và chấm điểm tự động.

yaml
Sao chép mã

---

## 🪄 Bước 3: Commit và push lên GitHub
Sau khi tạo xong file:

```bash
git add README.md
git commit -m "add: README mô tả dự án QuizApp Flutter"
git push
