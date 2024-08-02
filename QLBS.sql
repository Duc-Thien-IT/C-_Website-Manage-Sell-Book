use master
go
create database QLBS
go
use QLBS

go
create table KhachHang
(
	MaKH int,
	HoTen nvarchar(50),
	NgaySinh datetime,
	GioiTinh nvarchar(5),
	DienThoai nvarchar(11),
	TaiKhoan varchar(50),
	MatKhau varchar(50),
	Email nvarchar(100),
	DiaChi nvarchar(100),
	constraint pk_kh primary key (MaKH)
)

create table ChuDe
(
	MaChuDe int IDENTITY ( 1, 1),
	TenChuDe nvarchar(50),
	constraint pk_cd primary key(MaChuDe)
)

create table NhaXuatBan
(
	MaNXB int IDENTITY(1,1),
	TenNXB nvarchar(50),
	DiaChi nvarchar(100),
	DienThoai varchar(11),
	constraint pk_nxb primary key(MaNXB)
)

create table Sach
(
	MaSach int identity(1,1),
	TenSach nvarchar(200),
	GiaBan decimal(18,0),
	MoTa nvarchar(Max),
	AnhBia varchar(Max),
	NgayCapNhat datetime,
	SoLuongTon int,
	MaChuDe int, 
	MaNXB int,
	constraint pk_s primary key(MaSach),
	constraint fk_s_nxs foreign key (MaNXB) references NhaXuatBan(MaNXB),
	constraint fk_s_cd foreign key (MaChuDe) references ChuDe(MaChuDe)
)

create table TacGia
(
	MaTacGia int Identity(1,1),
	TenTacGia nvarchar(50),
	DiaChi nvarchar(100),
	TieuSu nvarchar(MAX),
	DienThoai varchar(11),
	constraint pk_tg primary key(MaTacGia)
)

create table DonHang
(
	MaDonHang int identity(1,1),
	NgayDat datetime,
	NgayGiao datetime,
	DaThanhToan int,
	TinhTrangGiaoHang int,
	MaKH int,
	constraint pk_dh primary key(MaDonHang),
	constraint fk_dh_kh foreign key (MaKH) references KhachHang(MaKH)
)

create table ThamGia
(
	MaSach int,
	MaTacGia int,
	
	constraint pk_thamgia primary key(MaSach, MaTacGia),
	constraint fk_thg_s foreign key (MaSach) references Sach(MaSach),
	constraint fk_thg_tg foreign key (MaTacGia) references TacGia(MaTacGia)
)

create table ChiTietDonHang
(
	MaDonHang int,
	MaSach int,
	SoLuong int, 
	DonGia decimal(18, 0),
	constraint pk_ctdh primary key(MaDonHang, MaSach),
	constraint fk_ctdh_s foreign key (MaSach) references Sach(MaSach),
	constraint fk_ctdh_dh foreign key (MaDonHang) references DonHang(MaDonHang)
)
go





insert into ChuDe
values
	(N'Chính trị'),
	(N'Truyện ngắn'),
	(N'Marketing'),
	(N'Kĩ năng sống'),
	(N'Tiểu thuyết'),
	(N'Tâm lý');





insert into TacGia
values
	(N'Nguyễn Nhật Ánh','Q.Tân Bình','Chuyên sáng tác truyện ngắn','0971091912'),
	(N'Tô Hoài','Q.Tân Phú','Chuyên sáng tác truyện ngắn','0971091912'),
	(N'Tố Hữu','H.Bình Chánh','Chuyên sáng tác văn xuôi','0971091912'),
	(N'Nguyễn Ngọc Tư','Quận 12','Chuyên sáng tác truyện ngắn','0971091912'),
	(N'Xuân Diệu','Quận 11','Chuyên sáng tác thơ','0971091912'),
	(N'Ngô Tất Tố','Quận 10','Chuyên sáng tác truyện dài','0971091912');




insert into NhaXuatBan
values
	(N'NXB Kim Đồng',N'Q.Tân Bình','0921321586'),
	(N'NXB Lao Động',N'Q.Tân Phú','0921321586'),
	(N'NXB Trẻ',N'Quận 12','0921321586'),
	(N'NXB Tổng hợp TPHCM',N'H.Binh Chánh','0921321586'),
	(N'NXB Hội Nhà Văn',N'H.Củ Chi','0921321586'),
	(N'NXB Văn Hóa',N'H.Củ Chi','0921321586');

	----------------------------------

set dateformat DMY
insert into Sach
values
	(N'Tự truyện benjamin franklin',100000,N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm.','1.jpg','19/02/2001',12,1,1),
	(N'Putin logic của quyền lực',100000,N'Khi trở thành thành viên của một nhóm nào đó thì vấn đề bạn cần băn khoăn không phải là “Có nên tham gia các hoạt động của nhóm không?” mà là “Những đóng góp của bạn có mang lại thành công cho nhóm không?” Các cá nhân không thể gắn kết với nhau là nguyên nhân làm tan rã nhóm. Một số người nghĩ rằng chìa khoá để thành công là nguyên tắc làm việc rõ ràng. Nhưng trên thực tế, có nhiều người rất siêng năng, khả năng làm việc độc lập rất tốt nhưng lại không thể làm việc cùng nhau để phát huy hết tiềm lực của họ. Thực chất, nhóm phải là nhóm những cá nhân luôn tương trợ, giúp đỡ lẫn nhau, tạo động lực cho nhau phát triển. Giữa các cá nhân phải có sự tương tác với nhau như một chuỗi phản ứng hoá học. Đó là cách thức để xây dựng nhóm của riêng bạn. ','2.jpg','19/02/2001',12,1,1),
	(N'Napoleon Đại Đế',100000,N'Khi trở thành thành viên của một nhóm nào đó thì vấn đề bạn cần băn khoăn không phải là “Có nên tham gia các hoạt động của nhóm không?” mà là “Những đóng góp của bạn có mang lại thành công cho nhóm không?” Các cá nhân không thể gắn kết với nhau là nguyên nhân làm tan rã nhóm. Một số người nghĩ rằng chìa khoá để thành công là nguyên tắc làm việc rõ ràng. Nhưng trên thực tế, có nhiều người rất siêng năng, khả năng làm việc độc lập rất tốt nhưng lại không thể làm việc cùng nhau để phát huy hết tiềm lực của họ. Thực chất, nhóm phải là nhóm những cá nhân luôn tương trợ, giúp đỡ lẫn nhau, tạo động lực cho nhau phát triển. Giữa các cá nhân phải có sự tương tác với nhau như một chuỗi phản ứng hoá học. Đó là cách thức để xây dựng nhóm của riêng bạn. ','3.jpg','19/02/2001',12,1,1),
	(N'Chính trị đảng phái tại Hoa Kỳ',100000,N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm.','4.jpg','19/02/2001',12,1,1),
	(N'Tinh hoa quyền lực',100000,N'Khi trở thành thành viên của một nhóm nào đó thì vấn đề bạn cần băn khoăn không phải là “Có nên tham gia các hoạt động của nhóm không?” mà là “Những đóng góp của bạn có mang lại thành công cho nhóm không?” Các cá nhân không thể gắn kết với nhau là nguyên nhân làm tan rã nhóm. Một số người nghĩ rằng chìa khoá để thành công là nguyên tắc làm việc rõ ràng. Nhưng trên thực tế, có nhiều người rất siêng năng, khả năng làm việc độc lập rất tốt nhưng lại không thể làm việc cùng nhau để phát huy hết tiềm lực của họ. Thực chất, nhóm phải là nhóm những cá nhân luôn tương trợ, giúp đỡ lẫn nhau, tạo động lực cho nhau phát triển. Giữa các cá nhân phải có sự tương tác với nhau như một chuỗi phản ứng hoá học. Đó là cách thức để xây dựng nhóm của riêng bạn. ','5.jpg','19/02/2001',12,1,1),
	(N'Justi Trudeau',100000,N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm.','6.jpg','19/02/2001',12,1,1),
	(N'Không bao giờ là đủ',100000,N'Trong lĩnh vực tin học văn phòng, Microsoft Word, Excel, PowerPoint, Visio là những chương trình thuộc bộ Microsoft Office đã và đang được ứng dụng rộng rãi trong nhiều lĩnh vực: kinh tế, kế toán, thương mại, quản lý, vẽ kỹ thuật và nhiều hơn nữa. Với Office 2010, bạn có trong tay đầy đủ các công cụ và lệnh để thực hiện các tiện ích trong diện toán văn phòng .','7.jpg','19/02/2001',12,1,1),
	(N'Nước Mỹ trong mắt Trump',100000,N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm.','8.jpg','19/02/2001',12,1,1),
	(N'Sợ hãi và tự do',100000,N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm.','9.jpg','19/02/2001',12,1,1),
	(N'Các đời tổng thống Hoa Kỳ',100000,N'Trong lĩnh vực tin học văn phòng, Microsoft Word, Excel, PowerPoint, Visio là những chương trình thuộc bộ Microsoft Office đã và đang được ứng dụng rộng rãi trong nhiều lĩnh vực: kinh tế, kế toán, thương mại, quản lý, vẽ kỹ thuật và nhiều hơn nữa. Với Office 2010, bạn có trong tay đầy đủ các công cụ và lệnh để thực hiện các tiện ích trong diện toán văn phòng .','10.jpg','19/02/2001',12,1,1);


insert into Sach
values
	(N'999 lá thư gửi cho chính mình',100000,N'Trong nửa thế kỷ qua, số người phương Tây thăm viếng phương Đông không phải là ít nhưng đã có mấy ai lĩnh hội được tinh hoa của phương Đông? ','11.jpg','19/02/2001',12,2,2),
	(N'Chuyện kể rằng có Nàng và Tôi',100000,N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm.','12.jpg','19/02/2001',12,2,2),
	(N'Chúng ta rồi sẽ hạnh phúc theo những cách khác nhau',100000,N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm.','13.jpg','19/02/2001',12,2,2),
	(N'Lạc giữa tăm tối không người nghe',100000,N'Trong nửa thế kỷ qua, số người phương Tây thăm viếng phương Đông không phải là ít nhưng đã có mấy ai lĩnh hội được tinh hoa của phương Đông? ','14.jpg','19/02/2001',12,2,2),
	(N'Mẹ làm gì có ước mơ',100000,N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm.','15.jpg','19/02/2001',12,2,2),
	(N'Trôi',100000,N'Lập Bản Đồ Tư Duy - Công Cụ Tư Duy Tối Ưu Sẽ Làm Thay Đổi Cuộc Sống Của Bạn','16.jpg','19/02/2001',12,2,2),
	(N'Có một ngày bô mẹ sẽ già đi',100000,N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm.','17.jpg','19/02/2001',12,2,2),
	(N'Cảm ơn anh đã đánh mất em',100000,N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm.','18.jpg','19/02/2001',12,2,2),
	(N'Tạm biệt tôi của nhiều năm về trước',100000,N'Lập Bản Đồ Tư Duy - Công Cụ Tư Duy Tối Ưu Sẽ Làm Thay Đổi Cuộc Sống Của Bạn:','19.jpg','19/02/2001',12,2,2),
	(N'Trở thành người phụ nữ ai cũng muốn lại gần',100000,N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm.','20.jpg','19/02/2001',12,2,2);


insert into Sach
values
	(N'Trải nghiệm khách hàng xuất sắc',100000,N'Hãy thử tưởng tượng xem mình sẽ làm gì nếu kết bạn với một chú rồng nhỏ? Chắc chắn sẽ có những điều rất thú vị phải không? Vậy công chúa Aurora đã làm những gì khi tình cờ gặp chú rồng nhỏ trên đường đi dạo cùng hoàng tử ?','21.jpg','19/02/2001',12,3,3),
	(N'Những đòn tâm lý trong bán hàng',100000,N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm.','22.jpg','19/02/2001',12,3,3),
	(N'Công thức livestream',100000,N'Hãy thử tưởng tượng xem mình sẽ làm gì nếu kết bạn với một chú rồng nhỏ? Chắc chắn sẽ có những điều rất thú vị phải không? Vậy công chúa Aurora đã làm những gì khi tình cờ gặp chú rồng nhỏ trên đường đi dạo cùng hoàng tử ?','23.jpg','19/02/2001',12,3,3),
	(N'Đừng cố gáng bán hãy giúp khách hàng mua',100000,N'Hãy thử tưởng tượng xem mình sẽ làm gì nếu kết bạn với một chú rồng nhỏ? Chắc chắn sẽ có những điều rất thú vị phải không? Vậy công chúa Aurora đã làm những gì khi tình cờ gặp chú rồng nhỏ trên đường đi dạo cùng hoàng tử ?','24.jpg','19/02/2001',12,3,3),
	(N'12 Tuyệt kỹ bán hàng',100000,N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm.','25.jpg','19/02/2001',12,3,3),
	(N'Chốt sales đàm phán thành công',100000,N'Nói đến Đạo Phật là nói đến giác ngộ, chủ trương của Đạo Phật là giác ngộ. Đạo Phật có mặt trên thế giới đến nay là 2556 năm (tính đến thời điểm hiện tại năm 2008). ','26.jpg','19/02/2001',12,3,3),
	(N'Nghệ thuật bán hàng bậc cao',100000,N'Nói đến Đạo Phật là nói đến giác ngộ, chủ trương của Đạo Phật là giác ngộ. Đạo Phật có mặt trên thế giới đến nay là 2556 năm (tính đến thời điểm hiện tại năm 2008). ','27.jpg','19/02/2001',12,3,3),
	(N'Truyền thông theo phong cách Win-Win',100000,N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm.','28.jpg','19/02/2001',12,3,3),
	(N'Làm chủ nghệ thuật bán hàng',100000,N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm.','29.jpg','19/02/2001',12,3,3),
	(N'Thu hút thế giới về với bạn trong môi trường trực tuyến',100000,N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm.','30.jpg','19/02/2001',12,3,3);





insert into Sach
values
	(N'Hiểu về trái tim',100000,N'Hãy thử tưởng tượng xem mình sẽ làm gì nếu kết bạn với một chú rồng nhỏ? Chắc chắn sẽ có những điều rất thú vị phải không? Vậy công chúa Aurora đã làm những gì khi tình cờ gặp chú rồng nhỏ trên đường đi dạo cùng hoàng tử ?','31.jpg','19/02/2001',12,4,4),
	(N'Dám nghĩ lại',100000,N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm.','32.jpg','19/02/2001',12,4,4),
	(N'Khéo ăn nói sẽ có được thiên hạ',100000,N'Hãy thử tưởng tượng xem mình sẽ làm gì nếu kết bạn với một chú rồng nhỏ? Chắc chắn sẽ có những điều rất thú vị phải không? Vậy công chúa Aurora đã làm những gì khi tình cờ gặp chú rồng nhỏ trên đường đi dạo cùng hoàng tử ?','33.jpg','19/02/2001',12,4,4),
	(N'Nóng giận là bản năng bình tĩnh là bản lĩnh',100000,N'Hãy thử tưởng tượng xem mình sẽ làm gì nếu kết bạn với một chú rồng nhỏ? Chắc chắn sẽ có những điều rất thú vị phải không? Vậy công chúa Aurora đã làm những gì khi tình cờ gặp chú rồng nhỏ trên đường đi dạo cùng hoàng tử ?','34.jpg','19/02/2001',12,4,4),
	(N'Yêu những điều không hoàn hảo',100000,N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm.','35.jpg','19/02/2001',12,4,4),
	(N'Mất kiểm soát',100000,N'Nói đến Đạo Phật là nói đến giác ngộ, chủ trương của Đạo Phật là giác ngộ. Đạo Phật có mặt trên thế giới đến nay là 2556 năm (tính đến thời điểm hiện tại năm 2008). ','36.jpg','19/02/2001',12,4,4),
	(N'Càng bình tĩnh càng hạnh phúc',100000,N'Nói đến Đạo Phật là nói đến giác ngộ, chủ trương của Đạo Phật là giác ngộ. Đạo Phật có mặt trên thế giới đến nay là 2556 năm (tính đến thời điểm hiện tại năm 2008). ','37.jpg','19/02/2001',12,4,4),
	(N'Rèn luyện tư duy phản biện',100000,N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm.','38.jpg','19/02/2001',12,4,4),
	(N'Thao túng tâm lý',100000,N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm.','39.jpg','19/02/2001',12,4,4),
	(N'Cẩm nang khám phá cơ thể người',100000,N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm.','40.jpg','19/02/2001',12,4,4);



insert into Sach
values
	(N'Nhà giả kim',100000,N'Hãy thử tưởng tượng xem mình sẽ làm gì nếu kết bạn với một chú rồng nhỏ? Chắc chắn sẽ có những điều rất thú vị phải không? Vậy công chúa Aurora đã làm những gì khi tình cờ gặp chú rồng nhỏ trên đường đi dạo cùng hoàng tử ?','41.jpg','19/02/2001',12,5,5),
	(N'Cây cam ngọt của tôi',100000,N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm.','42.jpg','19/02/2001',12,5,5),
	(N'Người đua diều',100000,N'Hãy thử tưởng tượng xem mình sẽ làm gì nếu kết bạn với một chú rồng nhỏ? Chắc chắn sẽ có những điều rất thú vị phải không? Vậy công chúa Aurora đã làm những gì khi tình cờ gặp chú rồng nhỏ trên đường đi dạo cùng hoàng tử ?','43.jpg','19/02/2001',12,5,5),
	(N'Đêm trắng',100000,N'Hãy thử tưởng tượng xem mình sẽ làm gì nếu kết bạn với một chú rồng nhỏ? Chắc chắn sẽ có những điều rất thú vị phải không? Vậy công chúa Aurora đã làm những gì khi tình cờ gặp chú rồng nhỏ trên đường đi dạo cùng hoàng tử ?','44.jpg','19/02/2001',12,5,5),
	(N'Có hai con mèo ngồi bên cửa sổ',100000,N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm.','45.jpg','19/02/2001',12,5,5),
	(N'Người bà tài giỏi Saga',100000,N'Nói đến Đạo Phật là nói đến giác ngộ, chủ trương của Đạo Phật là giác ngộ. Đạo Phật có mặt trên thế giới đến nay là 2556 năm (tính đến thời điểm hiện tại năm 2008). ','46.jpg','19/02/2001',12,5,5),
	(N'Con chim xanh biếc bay về',100000,N'Nói đến Đạo Phật là nói đến giác ngộ, chủ trương của Đạo Phật là giác ngộ. Đạo Phật có mặt trên thế giới đến nay là 2556 năm (tính đến thời điểm hiện tại năm 2008). ','47.jpg','19/02/2001',12,5,5),
	(N'Thất lạc cõi người',100000,N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm.','48.jpg','19/02/2001',12,5,5),
	(N'Rừng Nauy',100000,N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm.','49.jpg','19/02/2001',12,5,5),
	(N'Cho tôi xin một vé đi tuổi thơ',100000,N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm.','50.jpg','19/02/2001',12,5,5);



insert into Sach
values
	(N'Trò chơi tâm lý',100000,N'Hãy thử tưởng tượng xem mình sẽ làm gì nếu kết bạn với một chú rồng nhỏ? Chắc chắn sẽ có những điều rất thú vị phải không? Vậy công chúa Aurora đã làm những gì khi tình cờ gặp chú rồng nhỏ trên đường đi dạo cùng hoàng tử ?','51.jpg','19/02/2001',12,6,6),
	(N'Thiên tài bên trái kẻ điên bên phải',100000,N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm.','52.jpg','19/02/2001',12,6,6),
	(N'Kiếp nào ta cùng tìm thấy nhau',100000,N'Hãy thử tưởng tượng xem mình sẽ làm gì nếu kết bạn với một chú rồng nhỏ? Chắc chắn sẽ có những điều rất thú vị phải không? Vậy công chúa Aurora đã làm những gì khi tình cờ gặp chú rồng nhỏ trên đường đi dạo cùng hoàng tử ?','53.jpg','19/02/2001',12,6,6),
	(N'Sang chấn tâm lý hiểu để chữa lành',100000,N'Hãy thử tưởng tượng xem mình sẽ làm gì nếu kết bạn với một chú rồng nhỏ? Chắc chắn sẽ có những điều rất thú vị phải không? Vậy công chúa Aurora đã làm những gì khi tình cờ gặp chú rồng nhỏ trên đường đi dạo cùng hoàng tử ?','54.jpg','19/02/2001',12,6,6),
	(N'Câu chuyên đằng sau',100000,N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm.','55.jpg','19/02/2001',12,6,6),
	(N'Mặt lợi của góc tối',100000,N'Nói đến Đạo Phật là nói đến giác ngộ, chủ trương của Đạo Phật là giác ngộ. Đạo Phật có mặt trên thế giới đến nay là 2556 năm (tính đến thời điểm hiện tại năm 2008). ','55.jpg','19/02/2001',12,6,6),
	(N'Hiểu hết về tâm lý học',100000,N'Nói đến Đạo Phật là nói đến giác ngộ, chủ trương của Đạo Phật là giác ngộ. Đạo Phật có mặt trên thế giới đến nay là 2556 năm (tính đến thời điểm hiện tại năm 2008). ','57.jpg','19/02/2001',12,6,6),
	(N'Tâm lý về tiền',100000,N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm.','58.jpg','19/02/2001',12,6,6),
	(N'Tâm thần hay kẻ điên',100000,N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm.','59.jpg','19/02/2001',12,6,6),
	(N'Tâm lý học về rồi loạn nhân cách tránh né',100000,N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm.','60.jpg','19/02/2001',12,6,6);

insert into ThamGia
values
	(1, 1),
	(2, 2),
	(3, 3),
	(4, 4),
	(5, 5),
	(6, 1),
	(7, 2),
	(8, 3),
	(9, 4),
	(10, 5),
	(11, 1),
	(12, 2),
	(13, 3),
	(14, 4),
	(15, 5),
	(16, 1),
	(17, 2),
	(18, 3),
	(19, 4),
	(20, 5),
	(21, 1),
	(22, 2),
	(23, 3),
	(24, 4),
	(25, 5),
	(26, 1),
	(27, 2),
	(28, 3),
	(29, 4),
	(30, 5),
	(31, 1),
	(32, 2),
	(33, 3),
	(34, 4),
	(35, 5),
	(36, 1),
	(37, 2),
	(38, 3),
	(39, 4),
	(40, 5),
	(41, 1),
	(42, 2),
	(43, 3),
	(44, 4),
	(45, 5),
	(46, 1),
	(47, 2),
	(48, 3),
	(49, 4),
	(50, 5),
	(51, 1),
	(52, 2),
	(53, 3),
	(54, 4),
	(55, 5),
	(56, 1),
	(57, 2),
	(58, 3),
	(59, 4),
	(60, 5);


	



update sach
set AnhBia = '61.jpg', TenSach= N'Giờ tạm nghĩ tích cực'
where MaSach = 1


update sach
set AnhBia = '62.jpg', TenSach= N'Kỉ luật tích cực'
where MaSach = 7

update sach
set AnhBia = '63.jpg', TenSach= N'1000 Phát minh và khám phá vĩ đại'
where MaSach = 35