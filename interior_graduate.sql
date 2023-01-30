-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th6 15, 2022 lúc 06:52 PM
-- Phiên bản máy phục vụ: 10.4.22-MariaDB
-- Phiên bản PHP: 8.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `interior_graduate`
--

DELIMITER $$
--
-- Thủ tục
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_bill_status` ()  BEGIN
select 
    COUNT(DISTINCT IF(STATUS=1, ID, NULL)) as "bill_new", 
    COUNT(DISTINCT IF(STATUS=2, ID, NULL)) as "bill_confirm",
    COUNT(DISTINCT IF(STATUS=3, ID, NULL)) as "bill_packing",
    COUNT(DISTINCT IF(STATUS=4, ID, NULL)) as "bill_shipping",
    COUNT(DISTINCT IF(STATUS=5, ID, NULL)) as "bill_shipped",
    COUNT(DISTINCT IF(STATUS=6, ID, NULL)) as "bill_complete",
    COUNT(DISTINCT IF(STATUS=7, ID, NULL)) as "bill_cancel",
    COUNT(ID) as "bill_total"
from bill_sell;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sum_by_month_in_year` ()  BEGIN
SELECT 
    SUM(IF(month = 'Jan', total, 0)) AS 'Jan',
    SUM(IF(month = 'Feb', total, 0)) AS 'Feb',
    SUM(IF(month = 'Mar', total, 0)) AS 'Mar',
    SUM(IF(month = 'Apr', total, 0)) AS 'Apr',
    SUM(IF(month = 'May', total, 0)) AS 'May',
    SUM(IF(month = 'Jun', total, 0)) AS 'Jun',
    SUM(IF(month = 'Jul', total, 0)) AS 'Jul',
    SUM(IF(month = 'Aug', total, 0)) AS 'Aug',
    SUM(IF(month = 'Sep', total, 0)) AS 'Sep',
    SUM(IF(month = 'Oct', total, 0)) AS 'Oct',
    SUM(IF(month = 'Nov', total, 0)) AS 'Nov',
    SUM(IF(month = 'Dec', total, 0)) AS 'Dec',
    SUM(IF(status = 6, total, 0)) AS total_yearly
    FROM (
SELECT DATE_FORMAT(created_at, "%b") AS month, SUM(total) as total,status
FROM bill_sell
WHERE created_at <= NOW() and created_at >= Date_add(Now(),interval - 12 month) and status = 6
GROUP BY DATE_FORMAT(created_at, "%m-%Y")) as sub;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `bill_sell`
--

CREATE TABLE `bill_sell` (
  `ID` int(11) NOT NULL,
  `buyer` int(11) NOT NULL,
  `seller` int(11) DEFAULT NULL,
  `payment_type` int(11) DEFAULT -1 COMMENT '0-Thành toán bằng thẻ \r\n1-Thanh toán bằng ví điện tử\r\n2-Thanh toán chuyển khoản\r\n3-Thanh toán bằng tiền mặt',
  `delivery_type` int(11) DEFAULT -1,
  `address` text NOT NULL DEFAULT '""',
  `receive_place_detail_1` text DEFAULT '\'\\\'\\\\\\\'\\\\\\\\\\\\\\\'""\\\\\\\\\\\\\\\'\\\\\\\'\\\'\'' COMMENT 'Nơi nhận',
  `receive_place_detail_2` text NOT NULL DEFAULT '\'""\'' COMMENT 'Nơi nhận 2',
  `recipient_firstname` text DEFAULT '\'""\'' COMMENT 'tên người nhận',
  `recipient_lastname` text NOT NULL DEFAULT '""',
  `receipent_phone_number` text NOT NULL COMMENT 'Số điện thoại',
  `latitute_end` double DEFAULT 0 COMMENT 'vĩ độ',
  `longitude_end` double DEFAULT 0 COMMENT 'kinh độ',
  `status` int(11) NOT NULL DEFAULT 1,
  `bill_type` int(11) NOT NULL DEFAULT 1 COMMENT '1-hóa đơn 2-cart',
  `promotion_title` text DEFAULT NULL COMMENT 'mã giảm giá',
  `total` int(11) NOT NULL DEFAULT 0 COMMENT 'Tổng tiền',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `bill_sell`
--

INSERT INTO `bill_sell` (`ID`, `buyer`, `seller`, `payment_type`, `delivery_type`, `address`, `receive_place_detail_1`, `receive_place_detail_2`, `recipient_firstname`, `recipient_lastname`, `receipent_phone_number`, `latitute_end`, `longitude_end`, `status`, `bill_type`, `promotion_title`, `total`, `updated_at`, `created_at`) VALUES
(46, 1, NULL, -1, -1, 't', 't', 't', 'nhéddd', 'Chào nhéddd', '1', 0, 0, 7, 1, NULL, 0, '2022-06-06 22:48:03', '2022-03-23 02:02:51'),
(47, 1, NULL, -1, -1, 't', 't', 't', 'nhéddd', 'Chào nhéddd', '1', 0, 0, 7, 1, 'BBB', 14950000, '2022-06-06 22:48:36', '2022-03-23 02:04:24'),
(48, 1, NULL, -1, -1, 't', 't', 't', 'nhéddd', 'Chào nhéddd', '1', 0, 0, 7, 1, NULL, 26000000, '2022-06-07 00:42:35', '2022-03-23 02:04:51'),
(49, 9, NULL, -1, -1, 'Xã tam hiệp phú thọ', NULL, 'cụm 1 xã tam hiệp phúc thọ ha nội', 'Nguyễn', 'Luân', '0941070588', 0, 0, 1, 1, 'CAThANGTU', 16500000, '2022-03-31 09:22:45', '2022-03-31 09:22:45'),
(50, 9, NULL, -1, -1, 'phúc thọ hà nọi', NULL, 'cụm 1 xã tam hiệp phúc thọ ha nội', 'Nguyễn', 'Luân', '0941070588', 0, 0, 6, 1, NULL, 121000000, '2022-06-01 10:26:10', '2022-03-31 09:24:04'),
(51, 1, NULL, -1, -1, 't', 't', 't', 'Nguyễn', 'Luân Nguyễn', '1', 0, 0, 1, 1, 'CAThANGTU', 1500000, '2022-03-31 19:15:13', '2022-03-31 19:15:13'),
(52, 1, NULL, -1, -1, 't', 't', 't', 'Nguyễn', 'Luân Nguyễn', '1', 0, 0, 6, 1, NULL, 39000000, '2022-06-01 10:30:20', '2022-03-31 19:17:56'),
(53, 1, NULL, -1, -1, 'Ham Noi', 'Thôn 1', 'cụm 1 xã tam hiệp phúc thọ ha nội', 'Nguyễn', 'Luân', '0941070588', 0, 0, 1, 1, NULL, 164000000, '2022-06-03 00:26:19', '2022-06-03 00:26:19'),
(54, 1, NULL, -1, -1, 't', 't', 't', 'Nguyễn', 'Luân Nguyễn', '1', 0, 0, 6, 1, 'CHAOMUNG2022', 11900000, '2022-06-06 22:50:01', '2022-06-06 22:47:30'),
(55, 1, NULL, -1, -1, 't', 't', 't', 'Nguyễn', 'Luân Nguyễn', '1', 0, 0, 7, 1, 'CHAOMUNG2022', 11900000, '2022-06-06 22:47:57', '2022-06-06 22:47:42'),
(56, 1, NULL, 1, -1, 'Hà Nội', 'Hà Nội', 'Hà Nội', 'Nguyễn', 'Luân Nguyễn', '0941070588', 0, 0, 1, 1, NULL, 86000000, '2022-06-06 22:50:35', '2022-06-06 22:50:35'),
(57, 1, NULL, 1, -1, 'Hà Nội', 'Hà Nội', 'Hà Nội', 'Nguyễn', 'Luân Nguyễn', '0941070588', 0, 0, 7, 1, NULL, 19000000, '2022-06-07 00:04:03', '2022-06-07 00:03:22'),
(58, 11, NULL, -1, -1, 'Hà Nội', 'Thôn 1', 'Cụm 2, tam hiệp, phúc thọ, hà nội', 'Luân', 'Nguyễn hữu', '0941070588', 0, 0, 1, 1, 'CHAOMUNG2022', 16150000, '2022-06-07 00:10:26', '2022-06-07 00:10:26'),
(59, 1, NULL, 2, -1, 'Hà Nội', 'Hà Nội', 'Hà Nội', 'Nguyễn', 'Luân Nguyễn', '0941070588', 0, 0, 1, 1, NULL, 19000000, '2022-06-07 00:11:25', '2022-06-07 00:11:25'),
(60, 1, NULL, 1, -1, 'Hà Nội', 'Hà Nội', 'Hà Nội', 'Nguyễn', 'Luân Nguyễn', '0941070588', 0, 0, 1, 1, NULL, 19000000, '2022-06-07 00:11:30', '2022-06-07 00:11:30'),
(61, 1, NULL, 1, -1, 'Hà Nội', 'Hà Nội', 'Hà Nội', 'Nguyễn', 'Luân Nguyễn', '0941070588', 0, 0, 1, 1, NULL, 36000000, '2022-06-07 00:17:42', '2022-06-07 00:17:42'),
(62, 1, NULL, 1, -1, 'Hà Nội', 'Hà Nội', 'Hà Nội', 'Nguyễn', 'Luân Nguyễn', '0941070588', 0, 0, 1, 1, NULL, 14000000, '2022-06-07 00:22:46', '2022-06-07 00:22:46'),
(63, 1, NULL, 1, -1, 'Hà Nội', 'Hà Nội', 'Hà Nội', 'Nguyễn', 'Luân Nguyễn', '0941070588', 0, 0, 1, 1, NULL, 21000000, '2022-06-07 01:19:52', '2022-06-07 01:19:52'),
(64, 11, NULL, 2, -1, 'Ha Noi', 'Thôn 1', 'Cụm 2, tam hiệp, phúc thọ, hà nội', 'Luân', 'Nguyễn hữu', '0941070588', 0, 0, 1, 1, NULL, 98000000, '2022-06-15 09:42:46', '2022-06-15 09:42:46');

--
-- Bẫy `bill_sell`
--
DELIMITER $$
CREATE TRIGGER `update customer total pay` AFTER INSERT ON `bill_sell` FOR EACH ROW UPDATE client_account SET client_account.totalpay = client_account.totalpay + New.total WHERE ID = New.buyer
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `bill_sell_detail`
--

CREATE TABLE `bill_sell_detail` (
  `ID` int(11) NOT NULL,
  `bill_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `price` double NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `bill_sell_detail`
--

INSERT INTO `bill_sell_detail` (`ID`, `bill_id`, `product_id`, `quantity`, `price`, `created_at`, `updated_at`) VALUES
(13, 46, 31, 1, 1000000, '2022-03-23 09:02:51', '2022-03-23 09:02:51'),
(14, 46, 35, 1, 25000000, '2022-03-23 09:02:51', '2022-03-23 09:02:51'),
(15, 47, 34, 1, 14000000, '2022-03-23 09:04:24', '2022-03-23 09:04:24'),
(16, 47, 30, 1, 1000000, '2022-03-23 09:04:24', '2022-03-23 09:04:24'),
(17, 48, 32, 1, 25000000, '2022-03-23 09:04:51', '2022-03-23 09:04:51'),
(18, 48, 31, 1, 1000000, '2022-03-23 09:04:51', '2022-03-23 09:04:51'),
(19, 49, 34, 1, 14000000, '2022-03-31 16:22:45', '2022-03-31 16:22:45'),
(20, 49, 30, 1, 1000000, '2022-03-31 16:22:45', '2022-03-31 16:22:45'),
(21, 49, 26, 1, 15000000, '2022-03-31 16:22:45', '2022-03-31 16:22:45'),
(22, 50, 31, 1, 1000000, '2022-03-31 16:24:04', '2022-03-31 16:24:04'),
(23, 50, 33, 1, 20000000, '2022-03-31 16:24:04', '2022-03-31 16:24:04'),
(24, 50, 36, 1, 100000000, '2022-03-31 16:24:04', '2022-03-31 16:24:04'),
(25, 51, 26, 1, 15000000, '2022-04-01 02:15:13', '2022-04-01 02:15:13'),
(26, 52, 34, 1, 14000000, '2022-04-01 02:17:56', '2022-04-01 02:17:56'),
(27, 52, 32, 1, 25000000, '2022-04-01 02:17:56', '2022-04-01 02:17:56'),
(28, 53, 87, 4, 36000000, '2022-06-03 07:26:19', '2022-06-03 07:26:19'),
(29, 53, 102, 1, 12000000, '2022-06-03 07:26:19', '2022-06-03 07:26:19'),
(30, 53, 100, 1, 8000000, '2022-06-03 07:26:19', '2022-06-03 07:26:19'),
(31, 56, 106, 2, 7000000, '2022-06-07 05:50:35', '2022-06-07 05:50:35'),
(32, 56, 104, 1, 12000000, '2022-06-07 05:50:35', '2022-06-07 05:50:35'),
(33, 56, 110, 5, 12000000, '2022-06-07 05:50:35', '2022-06-07 05:50:35'),
(34, 57, 110, 1, 12000000, '2022-06-07 07:03:22', '2022-06-07 07:03:22'),
(35, 57, 108, 1, 7000000, '2022-06-07 07:03:22', '2022-06-07 07:03:22'),
(36, 59, 110, 1, 12000000, '2022-06-07 07:11:25', '2022-06-07 07:11:25'),
(37, 59, 108, 1, 7000000, '2022-06-07 07:11:25', '2022-06-07 07:11:25'),
(38, 60, 110, 1, 12000000, '2022-06-07 07:11:30', '2022-06-07 07:11:30'),
(39, 60, 108, 1, 7000000, '2022-06-07 07:11:30', '2022-06-07 07:11:30'),
(40, 61, 102, 3, 12000000, '2022-06-07 07:17:42', '2022-06-07 07:17:42'),
(41, 62, 108, 1, 7000000, '2022-06-07 07:22:46', '2022-06-07 07:22:46'),
(42, 62, 106, 1, 7000000, '2022-06-07 07:22:46', '2022-06-07 07:22:46'),
(43, 63, 108, 3, 7000000, '2022-06-07 08:19:52', '2022-06-07 08:19:52'),
(44, 64, 108, 13, 7000000, '2022-06-15 16:42:46', '2022-06-15 16:42:46'),
(45, 64, 107, 1, 7000000, '2022-06-15 16:42:46', '2022-06-15 16:42:46');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `blog`
--

CREATE TABLE `blog` (
  `ID` int(11) NOT NULL,
  `author` int(11) NOT NULL,
  `title` text NOT NULL DEFAULT '""',
  `description` text NOT NULL,
  `content` text NOT NULL DEFAULT '""',
  `thumbnail` text NOT NULL DEFAULT '""',
  `slug` text NOT NULL DEFAULT '""',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `blog`
--

INSERT INTO `blog` (`ID`, `author`, `title`, `description`, `content`, `thumbnail`, `slug`, `created_at`, `updated_at`) VALUES
(1, 3, 'Ghế! Thật đẹp và tiết kiệm!', 'Một loại ghế rẻ và đẹp', '<p>Xung đột Nga - Ukraine l&agrave;m ảnh hưởng nguồn cung khiến gi&aacute; thực phẩm v&agrave; ph&acirc;n b&oacute;n leo thang, đe dọa đẩy thế giới v&agrave;o một cuộc khủng hoảng lương thực.</p>\r\n\r\n<p>Svein Tore Holsether, gi&aacute;m đốc điều h&agrave;nh tập đo&agrave;n ph&acirc;n b&oacute;n v&agrave; h&oacute;a chất Yara International, ng&agrave;y 13/3 cho biết h&atilde;ng n&agrave;y phải cắt giảm 45% c&ocirc;ng suất amoniac v&agrave; ph&acirc;n ure tại ch&acirc;u &Acirc;u do gi&aacute; kh&iacute; đốt tăng kỷ lục trong bối cảnh chiến sự Nga -&nbsp;<a href=\"https://vnexpress.net/chu-de/ukraine-692\">Ukraine</a>&nbsp;diễn ra.</p>\r\n\r\n<p>&Ocirc;ng Holsether n&oacute;i khi thiếu hai th&agrave;nh phần thiết yếu n&agrave;y, nguồn cung lương thực to&agrave;n cầu sẽ bị t&aacute;c động kh&ocirc;ng nhỏ, đồng thời cảnh b&aacute;o thế giới c&oacute; thể hứng chịu khủng hoảng lương thực ảnh hưởng đến h&agrave;ng triệu người.</p>\r\n\r\n<p>Gần ba tuần sau khi Nga ph&aacute;t động chiến dịch qu&acirc;n sự đặc biệt tại Ukraine, gi&aacute; c&aacute;c sản phẩm n&ocirc;ng nghiệp chủ chốt sản xuất trong khu vực tăng ch&oacute;ng mặt. Nga v&agrave; Ukraine đ&oacute;ng g&oacute;p tới 30% nguồn cung l&uacute;a m&igrave; to&agrave;n cầu, 19% nguồn cung ng&ocirc; v&agrave; 80% kim ngạch xuất khẩu dầu hướng dương.</p>\r\n\r\n<p>Vấn đề lớn kh&aacute;c l&agrave; nguồn cung ph&acirc;n b&oacute;n lớn từ Nga đang bị đ&igrave;nh trệ khiến mặt h&agrave;ng n&agrave;y tăng gi&aacute; nhanh ch&oacute;ng. Sản lượng ph&acirc;n b&oacute;n ở ch&acirc;u &Acirc;u cũng sụt giảm nghi&ecirc;m trọng do gi&aacute; kh&iacute; đốt tự nhi&ecirc;n tăng, vốn l&agrave; th&agrave;nh phần ch&iacute;nh trong nhiều loại ph&acirc;n b&oacute;n như ph&acirc;n ure.</p>\r\n\r\n<p><img alt=\"Thu hoạch lúa mì gần làng Krasne ở tỉnh Chernihiv Oblast, cách Kiev120 km về phía bắc, tháng 7/2019. Ảnh: KyivPost.\" src=\"https://i1-vnexpress.vnecdn.net/2022/03/14/food-crisis-1647276487-8703-1647276624.jpg?w=680&amp;h=0&amp;q=100&amp;dpr=1&amp;fit=crop&amp;s=H5kkkYpLIIBODk4ML6cUAQ\" /></p>\r\n\r\n<p>Thu hoạch l&uacute;a m&igrave; gần l&agrave;ng Krasne ở tỉnh Chernihiv Oblast, c&aacute;ch Kiev120 km về ph&iacute;a bắc, th&aacute;ng 7/2019. Ảnh:&nbsp;<em>KyivPost.</em></p>\r\n\r\n<p>C&aacute;c bộ trưởng n&ocirc;ng nghiệp G7 ng&agrave;y 18/2 cam kết &quot;l&agrave;m những g&igrave; cần thiết để ngăn chặn v&agrave; ứng ph&oacute; một cuộc khủng hoảng lương thực&quot;. Tuy nhi&ecirc;n, nhiều quốc gia ưu ti&ecirc;n thị trường nội địa trước lo ngại thiếu hụt lương thực, c&oacute; thể g&acirc;y ảnh hưởng tới an ninh lương thực thế giới.</p>\r\n\r\n<p>Ai Cập vừa cấm xuất khẩu l&uacute;a m&igrave;, bột m&igrave; v&agrave; c&aacute;c loại đậu do lo ngại về dự trữ lương thực ở quốc gia đ&ocirc;ng d&acirc;n nhất khối Arab. Nh&agrave; sản xuất dầu cọ h&agrave;ng đầu thế giới Indonesia cũng tuy&ecirc;n bố thắt chặt c&aacute;c hạn chế xuất khẩu đối với mặt h&agrave;ng n&agrave;y.</p>\r\n\r\n<p>Bộ trưởng n&ocirc;ng nghiệp c&aacute;c nước G7 k&ecirc;u gọi c&aacute;c nước &quot;duy tr&igrave; mở cửa đối với thị trường n&ocirc;ng sản v&agrave; thực phẩm, chấm dứt c&aacute;c biện ph&aacute;p hạn chế phi l&yacute; l&ecirc;n hoạt động xuất khẩu&quot;.</p>\r\n\r\n<p>&quot;Tăng gi&aacute; c&ugrave;ng biến động của thực phẩm tr&ecirc;n thị trường quốc tế c&oacute; thể đe dọa an ninh lương thực v&agrave; dinh dưỡng ở quy m&ocirc; to&agrave;n cầu, đặc biệt ảnh hưởng tới c&aacute;c khu vực đ&oacute;i k&eacute;m&quot;, c&aacute;c bộ trưởng n&ocirc;ng nghiệp G7 nhận định.</p>\r\n\r\n<p>Chiến dịch qu&acirc;n sự của Nga ở Ukraine đ&atilde; bước sang ng&agrave;y thứ 19. Lực lượng Nga c&ugrave;ng d&acirc;n qu&acirc;n ly khai hiện kiểm so&aacute;t th&agrave;nh phố Kherson v&agrave; một số th&agrave;nh phố nhỏ ở miền nam, đ&ocirc;ng nam Ukraine, bao v&acirc;y Mariupol, Kharkov v&agrave; đang nỗ lực tăng &aacute;p lực với c&aacute;c mục ti&ecirc;u lớn hơn.</p>\r\n\r\n<p>Bộ Quốc ph&ograve;ng Anh h&ocirc;m 12/3 cho biết lực lượng bộ binh Nga đang c&aacute;ch trung t&acirc;m Kiev khoảng 25 km, c&oacute; thể bao v&acirc;y thủ đ&ocirc; của Ukraine trong v&agrave;i ng&agrave;y tới.</p>\r\n\r\n<p>Nga v&agrave;i ng&agrave;y qua đ&atilde; mở rộng quy m&ocirc; kh&ocirc;ng k&iacute;ch sang ph&iacute;a t&acirc;y Ukraine, sau hơn hai tuần chỉ tập trung c&ocirc;ng k&iacute;ch c&aacute;c mục ti&ecirc;u ở miền bắc, miền nam v&agrave; miền đ&ocirc;ng. Nhiều nước phương T&acirc;y cấp tập chuyển vũ kh&iacute; hiện đại, với h&agrave;ng ngh&igrave;n t&ecirc;n lửa chống tăng v&agrave; ph&ograve;ng kh&ocirc;ng, cho Ukraine, chủ yếu qua cửa ng&otilde; ở ph&iacute;a t&acirc;y nước n&agrave;y.</p>', '/storage/files/10/chair2_1.jpg', 'xin-chao-viet-nam', '2022-03-14 18:11:59', '2022-03-14 18:11:59');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `category`
--

CREATE TABLE `category` (
  `ID` int(11) NOT NULL,
  `name` text NOT NULL,
  `description` text NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `category`
--

INSERT INTO `category` (`ID`, `name`, `description`, `parent_id`, `status`, `created_at`, `updated_at`) VALUES
(4, 'Sofa', 'Tất cả các loại sofa, sofa thu gọn, sofa hoàng gia,...', NULL, 1, '2022-03-01 01:29:53', '2022-03-01 01:29:53'),
(5, 'Ghế', 'Mọi loại ghế với các mức giá và độ hoàn thiện khác nhau', 9, 1, '2022-03-02 00:59:11', '2022-06-01 00:09:45'),
(6, 'Giường', 'Giường ngủ đủ mẫu mã và chất lườn sản phẩm tuyệt vời', NULL, 1, '2022-03-03 00:40:56', '2022-03-03 00:40:56'),
(9, 'Ghế', 'mọi loại ghế', NULL, 1, '2022-03-07 03:24:07', '2022-03-07 03:24:23'),
(11, 'Kệ', 'Mọi loại kệ trong phòng khách, với nhiều kiểu dáng, nhiều mẫu mã cho bạn lựa chọn', NULL, 1, '2022-06-02 01:56:02', '2022-06-02 01:56:02'),
(12, 'Tủ', 'Dù bạn sưu tầm hay thích ngắm nhìn, tủ trưng bày có nghĩa là bạn có thể trưng bày những thứ yêu thích của mình nhưng tránh xa bụi bẩn và các ngón tay dính vào. Hãy xem các tủ trưng bày bằng kính của chúng tôi.', NULL, 1, '2022-06-03 00:32:53', '2022-06-03 00:32:53'),
(13, 'Đèn', 'Hãy thắp sáng phòng khách của bạn theo phong cách đặc biệt', NULL, 1, '2022-06-07 07:16:35', '2022-06-07 07:16:35');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `category_promotion`
--

CREATE TABLE `category_promotion` (
  `ID` int(11) NOT NULL,
  `categoryID` int(11) NOT NULL,
  `promotionID` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `category_promotion`
--

INSERT INTO `category_promotion` (`ID`, `categoryID`, `promotionID`, `created_at`, `updated_at`) VALUES
(3, 5, 14, '2022-03-16 03:34:37', '2022-03-16 03:34:37'),
(4, 6, 14, '2022-03-16 03:44:52', '2022-03-16 03:44:52'),
(5, 4, 16, '2022-03-31 16:09:06', '2022-03-31 16:09:06');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `client_account`
--

CREATE TABLE `client_account` (
  `ID` int(11) NOT NULL,
  `belong_to` int(11) DEFAULT NULL,
  `username` text DEFAULT NULL,
  `password` text NOT NULL,
  `avatar` text DEFAULT NULL,
  `totalpay` double NOT NULL DEFAULT 0,
  `rank` text NOT NULL DEFAULT 'Thành viên mới' COMMENT 'pay < 100000 Thành viên mới',
  `verify_account` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `client_type` int(11) NOT NULL DEFAULT 0,
  `google_id` text DEFAULT NULL,
  `facebook_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `client_account`
--

INSERT INTO `client_account` (`ID`, `belong_to`, `username`, `password`, `avatar`, `totalpay`, `rank`, `verify_account`, `created_at`, `updated_at`, `client_type`, `google_id`, `facebook_id`) VALUES
(1, 2, 'client1', '$2a$12$PvGSEYAdLswoJJbqf.uIlOGFLxFNuF7deYOCt0RbJtWtoOwz.BwFe', NULL, 1442299999, 'Thành viên Kim Cương', 1, '2022-01-24 18:01:33', '2022-03-20 20:43:43', 0, '', NULL),
(9, 19, 'luan088', '$2y$10$.Y4qjx6SO94MGioyf5HNhORW5zk8TF5DloeTqGAmcbWrLRBrO6EAm', NULL, 137500000, 'Thành viên Kim Cương', 1, '2022-03-31 08:59:40', '2022-03-31 09:00:21', 0, '', NULL),
(10, 22, NULL, '$2y$10$3pu2s4I1XmUbJeTg8xCMeOl8lX0TyiTEH8M2ehgIjQuxgdv9iyXlu', NULL, 0, 'Thành viên mới', 1, '2022-05-05 08:33:08', '2022-05-05 08:33:47', 0, '101288389036694137636', NULL),
(11, 24, 'luan2k', '$2y$10$VcuzELyjdBqolMcziwRrg.VYHPdvTsyiXYTxJFAS8Ue85E5QF2kdO', NULL, 114150000, 'Thành viên Kim Cương', 1, '2022-06-07 00:08:21', '2022-06-07 00:08:58', 0, NULL, NULL);

--
-- Bẫy `client_account`
--
DELIMITER $$
CREATE TRIGGER `update Rank` BEFORE UPDATE ON `client_account` FOR EACH ROW IF (New.totalpay > 0 && New.totalpay < 10000000) THEN
	SET new.rank = 'Thành viên Bạc';
ELSEIF (New.totalpay > 10000000 && New.totalpay < 100000000) THEN
SET new.rank = 'Thành viên Vàng';
ELSEIF (New.totalpay > 100000000 && New.totalpay < 1000000000) THEN
 SET new.rank = 'Thành viên Kim Cương'; 
End IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `dashboard_img`
--

CREATE TABLE `dashboard_img` (
  `ID` int(11) NOT NULL,
  `file_path` text NOT NULL,
  `status` int(11) DEFAULT NULL,
  `title` text DEFAULT NULL,
  `subtitle` text DEFAULT NULL,
  `position` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `dashboard_img`
--

INSERT INTO `dashboard_img` (`ID`, `file_path`, `status`, `title`, `subtitle`, `position`, `created_at`, `updated_at`) VALUES
(7, 'localhost/storage/files/10/spacejoy-9M66C_w_ToM-unsplash.jpg', 1, NULL, NULL, 1, '2022-03-31 08:13:11', '2022-03-31 08:13:11'),
(8, 'localhost/storage/files/10/id-interiors-3B8t4vnkXt0-unsplash.jpg', 1, NULL, NULL, 2, '2022-03-31 08:14:10', '2022-03-31 08:14:10'),
(10, 'localhost/storage/files/10/jason-wang-NxAwryAbtIw-unsplash.jpg', 1, NULL, NULL, 3, '2022-03-31 08:15:33', '2022-03-31 08:15:33'),
(13, 'localhost/storage/files/10/roberto-nickson-emqnSQwQQDo-unsplash.jpg', 1, NULL, NULL, 6, '2022-03-31 08:18:17', '2022-03-31 08:18:17');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `employee`
--

CREATE TABLE `employee` (
  `ID` int(11) NOT NULL,
  `belong_to` int(11) DEFAULT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `role` int(11) NOT NULL DEFAULT 1,
  `token` text DEFAULT NULL,
  `remember_token` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `employee`
--

INSERT INTO `employee` (`ID`, `belong_to`, `username`, `password`, `role`, `token`, `remember_token`, `created_at`, `updated_at`) VALUES
(3, 1, 'thaodz', '$2y$10$WU8Hn1oyGup9ACc39TnDQ.TMQ1iWEQgvWvOUvl7z6WtPnbHQqPk0C', 1, NULL, 'uZhjNB9yhM787NcuMfegglB3kuWjPWzW5N0HpsSTL4yuuYRtxwq2AUrTjifR', '2022-01-25 08:27:26', '2022-01-25 08:27:26'),
(10, 15, 'luan08', '$2y$10$SRdta/1E.PPML6DQNzvm.uzGdJoccFCEcI/DEN7iD8n1unzxuQZPq', 1, NULL, NULL, '2022-03-31 07:59:36', '2022-03-31 07:59:36');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `material`
--

CREATE TABLE `material` (
  `name` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `material`
--

INSERT INTO `material` (`name`, `created_at`, `updated_at`, `ID`) VALUES
('Gỗ Cẩm Lai', '2022-03-03 07:26:21', '2022-03-24 07:26:21', 11),
('Gỗ Mun', '2022-03-02 07:27:20', '2022-03-02 07:27:20', 12),
('Gỗ Xưa', '2022-03-02 07:27:55', '2022-03-02 07:27:55', 13),
('Gỗ Đàn Hương', '2022-03-03 07:28:27', '2022-03-02 07:28:27', 14),
('Gỗ Thông', '2022-06-03 08:11:11', '2022-06-03 08:11:11', 15),
('Nhôm', '2022-06-07 14:23:04', '2022-06-07 14:23:04', 17),
('Thuỷ tinh', '2022-06-07 14:23:17', '2022-06-07 14:23:17', 20);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `person`
--

CREATE TABLE `person` (
  `ID` int(11) NOT NULL,
  `name` text DEFAULT NULL,
  `email` text DEFAULT NULL,
  `address` text DEFAULT NULL,
  `phone_number` text DEFAULT NULL,
  `born_place` text DEFAULT NULL,
  `date_of_birth` text DEFAULT NULL,
  `CCID` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `person`
--

INSERT INTO `person` (`ID`, `name`, `email`, `address`, `phone_number`, `born_place`, `date_of_birth`, `CCID`, `created_at`, `updated_at`) VALUES
(1, 'Nguyễn Hữu Thảo', 'hihi@gmail.com', 'Hà Nội', '0339111654', 'Hà Nội', '19-01-2000', '001200007925', '2022-01-25 08:27:26', '2022-01-25 08:27:26'),
(2, 'Luân Nguyễn', 'luan06022k@gmail.com', 'Hà Nội', '0941070588', 'Hà Nội', '25-01-2022', '001200013557', '2022-01-25 09:22:05', '2022-03-31 08:40:00'),
(15, 'Nguyễn Hữu Luân', 'luanson2014@gmail.com', 'Cụm 2, tam hiệp, phúc thọ, hà nội', '0941070588', 'Hà Nội', '06-02-2000', '1', '2022-03-31 07:59:36', '2022-03-31 07:59:36'),
(19, NULL, 'luan088@yopmail.com', NULL, NULL, NULL, NULL, NULL, '2022-03-31 08:59:40', '2022-03-31 08:59:40'),
(20, 'Hữu Luân', 'luanson2013@gmail.com', NULL, NULL, NULL, NULL, NULL, '2022-05-05 08:31:31', '2022-05-05 08:31:31'),
(21, 'Hữu Luân', 'luanson2013@gmail.com', NULL, NULL, NULL, NULL, NULL, '2022-05-05 08:32:35', '2022-05-05 08:32:35'),
(22, 'Hữu Luân', 'luanson2013@gmail.com', NULL, NULL, NULL, NULL, NULL, '2022-05-05 08:33:07', '2022-05-05 08:33:07'),
(23, 'Hữu Luân', 'huuluan2000th@gmail.com', NULL, NULL, NULL, NULL, NULL, '2022-05-05 19:16:02', '2022-05-05 19:16:02'),
(24, 'Nguyễn Luân', 'theulydau@gmail.com', NULL, NULL, NULL, NULL, NULL, '2022-06-07 00:08:21', '2022-06-07 00:09:33');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product`
--

CREATE TABLE `product` (
  `ID` int(11) NOT NULL,
  `name` text NOT NULL,
  `product_category` int(11) NOT NULL,
  `description` text DEFAULT NULL,
  `content_review` text DEFAULT NULL,
  `display_state` int(11) NOT NULL,
  `rate` int(11) DEFAULT NULL,
  `slug` text NOT NULL DEFAULT '""',
  `price_entry` double NOT NULL DEFAULT 0,
  `price_sale` int(11) NOT NULL DEFAULT 0,
  `price_sell` double NOT NULL DEFAULT 0,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `status` int(11) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  `product_parent` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `product`
--

INSERT INTO `product` (`ID`, `name`, `product_category`, `description`, `content_review`, `display_state`, `rate`, `slug`, `price_entry`, `price_sale`, `price_sell`, `quantity`, `status`, `created_at`, `updated_at`, `product_parent`) VALUES
(26, 'Sofa Vip 10', 4, 'Sofa, Grann / Bomstad đen. Đắm mình trong sự thoải mái êm ái của ghế sofa KIVIK. Kích thước rộng rãi, tay vịn thấp và mút hoạt tính thích ứng với các đường nét trên cơ thể bạn mang đến nhiều giờ chợp mắt, giao lưu và thư giãn.', '<p style=\"text-align:start\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">KIVIK l&agrave; d&ograve;ng ghế rộng r&atilde;i với mặt ngồi mềm, s&acirc;u v&agrave; hỗ trợ thoải m&aacute;i cho lưng của bạn.</span></span></span></span></p>\r\n\r\n<p style=\"text-align:start\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">C&aacute;c bề mặt tiếp x&uacute;c được phủ bằng GRANN - một loại da hạt mềm, mịn v&agrave; chắc chắn với c&aacute;c biến thể tự nhi&ecirc;n.&nbsp;C&aacute;c bề mặt kh&aacute;c c&oacute; BOMSTAD, một loại vải tr&aacute;ng c&oacute; kiểu d&aacute;ng v&agrave; cảm gi&aacute;c tương tự như da.</span></span></span></span></p>\r\n\r\n<div class=\"range-revamp-expander\" style=\"padding:0px; text-align:start; width:367px\">\r\n<div class=\"range-revamp-expander__content\" style=\"margin-bottom:24px; padding:0px\">\r\n<div style=\"padding:0px\">\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Đệm ngồi c&oacute; một lớp m&uacute;t hoạt t&iacute;nh mềm mại theo đường n&eacute;t của cơ thể bạn v&agrave; hỗ trợ thoải m&aacute;i khi cần thiết.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">C&oacute; thể dễ d&agrave;ng kết hợp sofa với một hoặc nhiều ghế d&agrave;i nhờ tay vịn c&oacute; thể th&aacute;o rời.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Bạn c&oacute; thể sử dụng tay vịn rộng v&agrave; d&agrave;i c&oacute; th&ecirc;m phần đệm vừa l&agrave;m chỗ ngồi th&ecirc;m vừa l&agrave; chỗ tựa đầu thoải m&aacute;i khi bạn nằm tr&ecirc;n ghế sofa.</span></span></span></span></p>\r\n</div>\r\n</div>\r\n</div>', 2, NULL, '\"\"', 6700000, 20895531, 15000000, 100, 1, '2022-03-02 00:54:44', '2022-03-02 00:54:44', NULL),
(30, 'Ghế Jokkmokk', 5, 'Ghế bar, bạch dương . Thưởng thức bữa ăn với tầm nhìn từ độ cao của quầy bar. Phong cách Scandinavian nhẹ nhàng kết hợp hoàn hảo với các đồ nội thất khác trong dòng RÖNNINGE và kết cấu chắc chắn là lý tưởng cho việc sử dụng gia đình và công cộng', '<p style=\"text-align:start\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Ghế cong v&agrave; c&oacute; k&iacute;ch thước rộng r&atilde;i mang lại sự thoải m&aacute;i khi ăn uống, chơi tr&ograve; chơi tr&ecirc;n b&agrave;n hoặc l&agrave;m c&aacute;c thủ tục giấy tờ.</span></span></span></span></p>\r\n\r\n<p style=\"text-align:start\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Kh&ocirc;ng c&oacute; tựa lưng n&ecirc;n bạn c&oacute; thể ngồi thoải m&aacute;i ở hai b&ecirc;n ghế quầy bar v&agrave; cất v&agrave;o gầm b&agrave;n quầy bar khi kh&ocirc;ng sử dụng.</span></span></span></span></p>\r\n\r\n<div class=\"range-revamp-expander\" style=\"padding:0px; text-align:start; width:367px\">\r\n<div class=\"range-revamp-expander__content\" style=\"margin-bottom:24px; padding:0px\">\r\n<div style=\"padding:0px\">\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Kết hợp một số ghế quầy bar c&ugrave;ng m&agrave;u để tạo ra một biểu hiện thống nhất hoặc kết hợp c&aacute;c m&agrave;u sắc để c&oacute; một c&aacute;i nh&igrave;n vui tươi.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Ghế bar R&Ouml;NNINGE được l&agrave;m bằng bạch dương mang lại cảm gi&aacute;c ch&acirc;n thực v&agrave; bề mặt cứng chắc sẽ tồn tại l&acirc;u d&agrave;i theo năm th&aacute;ng v&agrave; ng&agrave;y c&agrave;ng duy&ecirc;n d&aacute;ng hơn theo tuổi t&aacute;c</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Kết cấu ổn định bằng gỗ nguy&ecirc;n khối v&agrave; veneer gỗ cứng gi&uacute;p cho mỗi chiếc ghế đẩu thanh trở n&ecirc;n độc đ&aacute;o, với c&aacute;c kiểu v&acirc;n kh&aacute;c nhau v&agrave; sự thay đổi m&agrave;u sắc tự nhi&ecirc;n l&agrave; một phần n&eacute;t quyến rũ của gỗ.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Để c&oacute; một chiếc ghế &ecirc;m &aacute;i hơn hoặc tạo th&ecirc;m n&eacute;t c&aacute; t&iacute;nh cho căn ph&ograve;ng, h&atilde;y ho&agrave;n thiện với một chiếc đệm ghế theo phong c&aacute;ch v&agrave; m&agrave;u sắc bạn chọn.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Chỗ để ch&acirc;n tạo tư thế ngồi thoải m&aacute;i v&agrave; thư gi&atilde;n.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Kim loại tr&ecirc;n bệ để ch&acirc;n bảo vệ n&oacute; khỏi bị m&agrave;i m&ograve;n.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Th&iacute;ch hợp cho chiều cao b&agrave;n bar 39-42 &quot;</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">C&oacute; thể ho&agrave;n thiện với lớp bảo vệ s&agrave;n d&iacute;nh FIXA để bảo vệ bề mặt b&ecirc;n dưới chống m&agrave;i m&ograve;n.</span></span></span></span></p>\r\n</div>\r\n</div>\r\n</div>', 2, NULL, '\"\"', 500000, 1346228, 1000000, 1000, 1, '2022-03-03 00:33:20', '2022-03-03 00:33:20', NULL),
(31, 'Ghế Nilsolle', 5, 'Ghế bar, bạch dương', '<p style=\"text-align:start\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Dễ d&agrave;ng di chuyển nhờ lỗ tr&ecirc;n mặt ghế.</span></span></span></span></p>\r\n\r\n<p style=\"text-align:start\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Gỗ rắn l&agrave; một vật liệu tự nhi&ecirc;n bền.</span></span></span></span></p>\r\n\r\n<div class=\"range-revamp-expander\" style=\"padding:0px; text-align:start; width:367px\">\r\n<div class=\"range-revamp-expander__content\" style=\"margin-bottom:24px; padding:0px\">\r\n<div style=\"padding:0px\">\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Ghế bar n&agrave;y đ&atilde; được thử nghiệm để sử dụng c&ocirc;ng cộng v&agrave; đ&aacute;p ứng c&aacute;c y&ecirc;u cầu về an to&agrave;n, độ bền v&agrave; độ ổn định được quy định trong c&aacute;c ti&ecirc;u chuẩn sau: EN 16139-Level 1 v&agrave; ANSI / BIFMA x5.1</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Ph&ugrave; hợp với chiều cao thanh 43&frac14; &quot;.</span></span></span></span></p>\r\n</div>\r\n</div>\r\n</div>', 2, NULL, '\"\"', 500000, 2604455, 1000000, 1000, 1, '2022-03-03 00:38:08', '2022-03-03 00:38:08', NULL),
(32, 'Giường Malm', 6, 'Khung giường cao / 2 hộp đựng đồ, nâu đen. Một thiết kế sạch sẽ với veneer gỗ nguyên khối. Đặt giường dựa trên mặt đất hoặc đầu giường dựa vào tường. Bạn cũng có được các hộp lưu trữ rộng rãi có thể lăn bánh trơn tru.', '<p style=\"text-align:start\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Kh&ocirc;ng gian lưu trữ rộng r&atilde;i được giấu gọn g&agrave;ng dưới gầm giường trong 2 ngăn k&eacute;o lớn.&nbsp;Ho&agrave;n hảo để lưu trữ mền, gối v&agrave; khăn trải giường.</span></span></span></span></p>\r\n\r\n<p style=\"text-align:start\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">C&aacute;c hộp lưu trữ dễ d&agrave;ng cuộn ra v&agrave; v&agrave;o nhờ c&aacute;c b&aacute;nh xe tr&ecirc;n đế.</span></span></span></span></p>\r\n\r\n<div class=\"range-revamp-expander\" style=\"padding:0px; text-align:start; width:367px\">\r\n<div class=\"range-revamp-expander__content\" style=\"margin-bottom:24px; padding:0px\">\r\n<div style=\"padding:0px\">\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Hộp lưu trữ giường MALM hoạt động ho&agrave;n hảo với khung giường MALM.&nbsp;Ch&uacute;ng vừa kh&iacute;t với kh&ocirc;ng gian dưới giường v&agrave; sẽ nghi&ecirc;ng về hai ph&iacute;a.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">V&acirc;n gỗ mang đến cho bạn vẻ ngo&agrave;i, cảm nhận v&agrave; vẻ đẹp giống như gỗ nguy&ecirc;n khối với c&aacute;c biến thể độc đ&aacute;o về thớ, m&agrave;u sắc v&agrave; kết cấu.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Bạn c&oacute; thể ngồi thẳng tr&ecirc;n giường một c&aacute;ch thoải m&aacute;i nhờ đầu giường cao - chỉ cần k&ecirc; v&agrave;i chiếc gối sau lưng v&agrave; bạn sẽ c&oacute; một nơi thoải m&aacute;i để đọc hoặc xem TV.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Khung giường đa năng n&agrave;y sẽ tr&ocirc;ng tuyệt vời với sự lựa chọn h&agrave;ng dệt may v&agrave; đồ nội thất ph&ograve;ng ngủ của bạn.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Mặt giường c&oacute; thể điều chỉnh cho ph&eacute;p bạn sử dụng nệm c&oacute; độ d&agrave;y kh&aacute;c nhau.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Phần đế giường c&oacute; 17 lớp nan c&oacute; thể điều chỉnh theo trọng lượng cơ thể của bạn v&agrave; tăng độ mềm mại cho nệm.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">SKORVA midbeam được bao gồm trong gi&aacute; nhưng được đ&oacute;ng g&oacute;i ri&ecirc;ng.&nbsp;Cần c&oacute; sự ổn định của khung giường v&agrave; giữ đệm cố định.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Đế giường bằng gỗ slatted được bao gồm trong gi&aacute; nhưng được đ&oacute;ng g&oacute;i ri&ecirc;ng.</span></span></span></span></p>\r\n</div>\r\n</div>\r\n</div>', 2, NULL, '\"\"', 15000000, 50047952, 25000000, 100, 1, '2022-03-03 00:46:09', '2022-03-03 00:46:09', NULL),
(33, 'Giường Brimnes', 6, 'Khung giường có kho & đầu giường, màu xám. Khung giường với kho lưu trữ ẩn ở một số nơi - hoàn hảo nếu bạn sống trong một không gian nhỏ. Dòng BRIMNES có một số giải pháp thông minh giúp bạn tiết kiệm không gian.', '<p style=\"text-align:start\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Mọi thứ được giữ gần gũi với bộ lưu trữ t&iacute;ch hợp tr&ecirc;n đầu giường.</span></span></span></span></p>\r\n\r\n<p style=\"text-align:start\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Kh&ocirc;ng gian lưu trữ rộng r&atilde;i được giấu gọn g&agrave;ng dưới gầm giường trong 4 ngăn k&eacute;o lớn.&nbsp;Ho&agrave;n hảo để lưu trữ mền, gối v&agrave; khăn trải giường.</span></span></span></span></p>\r\n\r\n<div class=\"range-revamp-expander\" style=\"padding:0px; text-align:start; width:367px\">\r\n<div class=\"range-revamp-expander__content\" style=\"margin-bottom:24px; padding:0px\">\r\n<div style=\"padding:0px\">\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Giấu d&acirc;y c&aacute;p cho đ&egrave;n v&agrave; bộ sạc bằng c&aacute;ch cho ch&uacute;ng qua c&aacute;c lỗ tr&ecirc;n đầu giường.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Bạn c&oacute; thể thoải m&aacute;i ngồi tr&ecirc;n giường nhờ đầu giường cao;&nbsp;chỉ cần k&ecirc; v&agrave;i chiếc gối sau lưng v&agrave; bạn sẽ c&oacute; một nơi thoải m&aacute;i để đọc hoặc xem TV.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Khung giường đa năng n&agrave;y sẽ tr&ocirc;ng tuyệt vời với sự lựa chọn h&agrave;ng dệt may v&agrave; đồ nội thất ph&ograve;ng ngủ của bạn.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Mặt giường c&oacute; thể điều chỉnh cho ph&eacute;p bạn sử dụng nệm c&oacute; độ d&agrave;y kh&aacute;c nhau.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">17 thanh trượt được d&aacute;n lớp điều chỉnh theo trọng lượng cơ thể của bạn v&agrave; tăng độ dẻo dai cho nệm.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Gi&aacute; cho sự kết hợp n&agrave;y bao gồm SKORVA midbeam, nhưng n&oacute; l&agrave; một sản phẩm ri&ecirc;ng biệt m&agrave; bạn chọn từ kệ ri&ecirc;ng của n&oacute; tại cửa h&agrave;ng.&nbsp;Nếu bạn mua giường qua trang web, SKORVA midbeam được bao gồm trong giao h&agrave;ng.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Đế giường bằng gỗ slatted được bao gồm trong gi&aacute; nhưng được đ&oacute;ng g&oacute;i ri&ecirc;ng.</span></span></span></span></p>\r\n</div>\r\n</div>\r\n</div>', 2, NULL, '\"\"', 10000000, 38373083, 20000000, 1000, 1, '2022-03-03 00:51:00', '2022-03-03 00:51:00', NULL),
(34, 'Giường Songesand', 6, 'Khung giường với 2 hộc để đồ, màu trắng. Khung giường chắc chắn với các cạnh mềm mại và chân cao. Một hình dạng cổ điển sẽ tồn tại trong nhiều năm. Ngoài ra, dưới gầm giường còn có các hộc chứa đồ rộng rãi, nơi bạn có thể cất chăn ga gối đệm hoặc quần áo.', '<p style=\"text-align:start\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Khung giường cổ điển n&agrave;y sẽ tr&ocirc;ng tuyệt vời với sự lựa chọn của bạn về h&agrave;ng dệt v&agrave; đồ nội thất ph&ograve;ng ngủ.&nbsp;Bạn thậm ch&iacute; c&oacute; thể ho&agrave;n thiện giao diện với c&aacute;c sản phẩm kh&aacute;c từ d&ograve;ng SONGESAND.</span></span></span></span></p>\r\n\r\n<p style=\"text-align:start\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Kh&ocirc;ng gian lưu trữ rộng r&atilde;i được giấu gọn g&agrave;ng dưới gầm giường trong 2 ngăn k&eacute;o lớn.&nbsp;Ho&agrave;n hảo để lưu trữ mền, gối v&agrave; khăn trải giường.</span></span></span></span></p>\r\n\r\n<div class=\"range-revamp-expander\" style=\"padding:0px; text-align:start; width:367px\">\r\n<div class=\"range-revamp-expander__content\" style=\"margin-bottom:24px; padding:0px\">\r\n<div style=\"padding:0px\">\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Hộp lưu trữ giường SONGESAND hoạt động ho&agrave;n hảo với khung giường SONGESAND.&nbsp;Ch&uacute;ng vừa kh&iacute;t với kh&ocirc;ng gian dưới giường v&agrave; sẽ nghi&ecirc;ng về hai ph&iacute;a.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">C&aacute;c hộp lưu trữ dễ d&agrave;ng cuộn ra v&agrave; v&agrave;o nhờ c&aacute;c b&aacute;nh xe tr&ecirc;n đế.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Bạn c&oacute; thể t&aacute;ch khăn trải giường v&agrave; mền của m&igrave;nh v&igrave; sự kết hợp n&agrave;y bao gồm một hộp đựng đồ rộng v&agrave; hẹp.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Mặt giường c&oacute; thể điều chỉnh cho ph&eacute;p bạn sử dụng nệm c&oacute; độ d&agrave;y kh&aacute;c nhau.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Gi&aacute; cho sự kết hợp n&agrave;y bao gồm SKORVA midbeam, nhưng n&oacute; l&agrave; một sản phẩm ri&ecirc;ng biệt m&agrave; bạn chọn từ kệ ri&ecirc;ng của n&oacute; tại cửa h&agrave;ng.&nbsp;Nếu bạn mua giường qua trang web, SKORVA midbeam được bao gồm trong giao h&agrave;ng.</span></span></span></span></p>\r\n</div>\r\n</div>\r\n</div>', 2, NULL, '\"\"', 7000000, 19456129, 14000000, 1000, 1, '2022-03-03 01:00:27', '2022-03-03 01:00:27', NULL),
(35, 'Giường Nordli', 6, 'Khung giường có kho, màu trắng. Khung giường NORDLI không chỉ là một chiếc giường thoải mái. Nó cũng là một đơn vị lưu trữ với 6 ngăn kéo rộng rãi. Một giải pháp thiết thực cho quần áo, chăn bông và những giấc mơ ngọt ngào - tất cả trong một không gian nhỏ.', '<p style=\"text-align:start\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Thiết kế nhỏ gọn ho&agrave;n hảo cho kh&ocirc;ng gian chật hẹp hoặc dưới trần nh&agrave; thấp, v&igrave; vậy bạn c&oacute; thể tận dụng tối đa kh&ocirc;ng gian c&oacute; sẵn của m&igrave;nh.</span></span></span></span></p>\r\n\r\n<p style=\"text-align:start\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Kh&ocirc;ng gian lưu trữ rộng r&atilde;i được giấu gọn g&agrave;ng dưới gầm giường trong 6 ngăn k&eacute;o lớn.&nbsp;Ho&agrave;n hảo để lưu trữ mền, gối v&agrave; khăn trải giường.</span></span></span></span></p>\r\n\r\n<div class=\"range-revamp-expander\" style=\"padding:0px; text-align:start; width:367px\">\r\n<div class=\"range-revamp-expander__content\" style=\"margin-bottom:24px; padding:0px\">\r\n<div style=\"padding:0px\">\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">C&aacute;c ngăn k&eacute;o đ&oacute;ng mở &ecirc;m &aacute;i, chậm r&atilde;i v&agrave; kh&ocirc;ng g&acirc;y tiếng ồn.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Khung giường đa năng n&agrave;y sẽ tr&ocirc;ng tuyệt vời với sự lựa chọn h&agrave;ng dệt may v&agrave; đồ nội thất ph&ograve;ng ngủ của bạn.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Ph&ugrave; hợp với nệm rộng 59-63 &quot;v&agrave; d&agrave;i tới 79&frac12;&quot;.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Phối hợp với c&aacute;c đồ nội thất kh&aacute;c trong chuỗi NORDLI.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">C&oacute; thể ho&agrave;n thiện với lớp bảo vệ s&agrave;n d&iacute;nh FIXA để bảo vệ bề mặt b&ecirc;n dưới chống m&agrave;i m&ograve;n.</span></span></span></span></p>\r\n</div>\r\n</div>\r\n</div>', 2, NULL, '\"\"', 14000000, 38234226, 25000000, 1000, 1, '2022-03-03 01:08:53', '2022-03-03 01:08:53', NULL),
(36, 'Giường Hemnes', 6, 'Khung giường với 4 hộc để đồ, màu đen nâu. Vẻ đẹp vượt thời gian của gỗ nguyên khối trở thành tâm điểm trong phòng ngủ của bạn. Trong ngăn kéo lưu trữ dưới giường, bạn có thể đặt bộ đồ giường, gối phụ, chăn ủ hoặc bất cứ thứ gì khác mà bạn muốn gần đó.', '<p style=\"text-align:start\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Kho lưu trữ thực tế cho th&ecirc;m một chiếc gối, chăn b&ocirc;ng hoặc ga trải giường.</span></span></span></span></p>\r\n\r\n<p style=\"text-align:start\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Được l&agrave;m bằng gỗ nguy&ecirc;n khối, l&agrave; vật liệu tự nhi&ecirc;n bền v&agrave; ấm.</span></span></span></span></p>\r\n\r\n<div class=\"range-revamp-expander\" style=\"padding:0px; text-align:start; width:367px\">\r\n<div class=\"range-revamp-expander__content\" style=\"margin-bottom:24px; padding:0px\">\r\n<div style=\"padding:0px\">\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Mặt giường c&oacute; thể điều chỉnh cho ph&eacute;p bạn sử dụng nệm c&oacute; độ d&agrave;y kh&aacute;c nhau.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">4 ngăn k&eacute;o lớn gi&uacute;p bạn c&oacute; th&ecirc;m kh&ocirc;ng gian lưu trữ dưới gầm giường.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Gi&aacute; cho sự kết hợp n&agrave;y bao gồm SKORVA midbeam, nhưng n&oacute; l&agrave; một sản phẩm ri&ecirc;ng biệt m&agrave; bạn chọn từ kệ ri&ecirc;ng của n&oacute; tại cửa h&agrave;ng.&nbsp;Nếu bạn mua giường qua trang web, SKORVA midbeam được bao gồm trong giao h&agrave;ng.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Tổ hợp sản phẩm n&agrave;y c&oacute; c&aacute;c bộ phận với c&aacute;c điều kiện bảo h&agrave;nh giới hạn kh&aacute;c nhau, bạn c&oacute; thể t&igrave;m th&ecirc;m th&ocirc;ng tin về c&aacute;c bộ phận n&agrave;y trong t&agrave;i liệu bảo h&agrave;nh c&oacute; giới hạn tr&ecirc;n IKEA-USA.com.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,system-ui,sans-serif\"><span style=\"background-color:#ffffff\">Nệm v&agrave; khăn trải giường được b&aacute;n ri&ecirc;ng.</span></span></span></span></p>\r\n</div>\r\n</div>\r\n</div>', 2, NULL, '\"\"', 80000000, 147670227, 100000000, 100, 1, '2022-03-03 01:14:44', '2022-03-03 01:14:44', NULL),
(40, 'Ghế Strandmon', 9, 'Mang lại cuộc sống mới cho một yêu thích cũ. Lần đầu tiên chúng tôi giới thiệu chiếc ghế này vào những năm 1950. Khoảng 60 năm sau, chúng tôi đã đưa nó trở lại phạm vi với sự khéo léo, tiện nghi và vẻ ngoài như cũ.', '<p>Bạn thực sự c&oacute; thể thả lỏng người v&agrave; thư gi&atilde;n một c&aacute;ch thoải m&aacute;i v&igrave; phần lưng cao của chiếc ghế n&agrave;y hỗ trợ th&ecirc;m cho cổ của bạn.</p>\r\n\r\n<p>Lớp phủ của DJUPARP được l&agrave;m bằng nhung, th&ocirc;ng qua kỹ thuật dệt truyền thống tạo cho vải c&oacute; m&agrave;u trầm, ấm v&agrave; bề mặt mềm mại với một lớp d&agrave;y đặc v&agrave; &aacute;nh s&aacute;ng phản chiếu &aacute;nh s&aacute;ng.</p>\r\n\r\n<p>Lớp nhung được dệt từ visco v&agrave; polyester tạo độ bền cao.</p>\r\n\r\n<p>Bảo h&agrave;nh 10 năm c&oacute; giới hạn. Đọc về c&aacute;c điều khoản trong t&agrave;i liệu giới hạn bảo h&agrave;nh.</p>\r\n\r\n<p>Lớp nhung phản chiếu &aacute;nh s&aacute;ng theo một c&aacute;ch đặc trưng c&oacute; thể l&agrave;m cho m&agrave;u sắc xuất hiện như thể n&oacute; thay đổi.</p>\r\n\r\n<p>C&aacute;c vết ấn c&oacute; thể xuất hiện tr&ecirc;n nhung thường biến mất trong thời gian. D&ugrave;ng tay miết nhẹ theo chiều cọc hoặc d&ugrave;ng b&agrave;n chải quần &aacute;o. Bạn cũng c&oacute; thể sử dụng m&aacute;y h&uacute;t bụi với đầu h&uacute;t mềm.</p>\r\n\r\n<p>C&aacute;c sợi nhỏ c&oacute; thể xuất hiện tr&ecirc;n nhung. N&oacute; xảy ra một c&aacute;ch tự nhi&ecirc;n v&agrave; ch&uacute;ng biến mất theo thời gian v&agrave; cũng c&oacute; thể được loại bỏ bằng một con lăn xơ vải.</p>\r\n\r\n<p>Để đảm bảo nhung duy tr&igrave; được vẻ ngo&agrave;i v&agrave; cảm gi&aacute;c, n&oacute; cần được chăm s&oacute;c thường xuy&ecirc;n theo hướng dẫn chăm s&oacute;c k&egrave;m theo sản phẩm.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nIKEA của Thụy Điển</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<div class=\"pip-product-details__container\" style=\"margin-bottom:24px; padding:0px; text-align:left\">\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Khung:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">V&aacute;n &eacute;p, Bọt polyurethane 1,2 lb / cu.ft., Bọt polyurethane 1,5 lb / cu.ft., Bọt polyurethane 2,2 lb / cu.ft., Tấm l&oacute;t polyester, V&aacute;n dăm, Gỗ rắn</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Đệm ngồi:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Bọt polyurethane 2,2 lb / cu.ft., Tấm l&oacute;t Polyester, tấm l&oacute;t Polyester</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Ch&acirc;n:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Gỗ rắn, vết</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Vải v&oacute;c:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">38% viscose / rayon, 62% polyester (tối thiểu 90% t&aacute;i chế)</span></span></span></span></p>\r\n</div>\r\n</div>\r\n\r\n<div class=\"pip-product-details__container\" style=\"margin-bottom:24px; margin-top:16px; padding:0px; text-align:left\">\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Để đảm bảo nhung duy tr&igrave; được vẻ ngo&agrave;i v&agrave; cảm gi&aacute;c, n&oacute; cần được chăm s&oacute;c thường xuy&ecirc;n theo hướng dẫn chăm s&oacute;c k&egrave;m theo sản phẩm.</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__container\" style=\"margin-top:16px; padding:0px; text-align:left\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Khung, nắp kh&ocirc;ng thể th&aacute;o rời</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Loại bỏ bụi bằng chất tẩy xơ vải.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">C&aacute;c vết bẩn nhẹ c&oacute; thể được loại bỏ bằng một miếng bọt biển ẩm hoặc dung dịch x&agrave; ph&ograve;ng nhẹ.</span></span></span></span></p>\r\n</div>', 5, NULL, '40', 5000000, 5500000, 6000000, 1000, 1, '2022-06-01 00:45:35', '2022-06-01 08:05:03', 30),
(41, 'Ghế Strandmon Xanh', 9, 'Mang lại cuộc sống mới cho một yêu thích cũ. Lần đầu tiên chúng tôi giới thiệu chiếc ghế này vào những năm 1950. Khoảng 60 năm sau, chúng tôi đã đưa nó trở lại phạm vi với sự khéo léo, tiện nghi và vẻ ngoài như cũ.', '<p>Bạn thực sự c&oacute; thể thả lỏng người v&agrave; thư gi&atilde;n một c&aacute;ch thoải m&aacute;i v&igrave; phần lưng cao của chiếc ghế n&agrave;y hỗ trợ th&ecirc;m cho cổ của bạn.</p>\r\n\r\n<p>Lớp phủ của DJUPARP được l&agrave;m bằng nhung, th&ocirc;ng qua kỹ thuật dệt truyền thống tạo cho vải c&oacute; m&agrave;u trầm, ấm v&agrave; bề mặt mềm mại với một lớp d&agrave;y đặc v&agrave; &aacute;nh s&aacute;ng phản chiếu &aacute;nh s&aacute;ng.</p>\r\n\r\n<p>Lớp nhung được dệt từ visco v&agrave; polyester tạo độ bền cao.</p>\r\n\r\n<p>Bảo h&agrave;nh 10 năm c&oacute; giới hạn. Đọc về c&aacute;c điều khoản trong t&agrave;i liệu giới hạn bảo h&agrave;nh.</p>\r\n\r\n<p>Lớp nhung phản chiếu &aacute;nh s&aacute;ng theo một c&aacute;ch đặc trưng c&oacute; thể l&agrave;m cho m&agrave;u sắc xuất hiện như thể n&oacute; thay đổi.</p>\r\n\r\n<p>C&aacute;c vết ấn c&oacute; thể xuất hiện tr&ecirc;n nhung thường biến mất trong thời gian. D&ugrave;ng tay miết nhẹ theo chiều cọc hoặc d&ugrave;ng b&agrave;n chải quần &aacute;o. Bạn cũng c&oacute; thể sử dụng m&aacute;y h&uacute;t bụi với đầu h&uacute;t mềm.</p>\r\n\r\n<p>C&aacute;c sợi nhỏ c&oacute; thể xuất hiện tr&ecirc;n nhung. N&oacute; xảy ra một c&aacute;ch tự nhi&ecirc;n v&agrave; ch&uacute;ng biến mất theo thời gian v&agrave; cũng c&oacute; thể được loại bỏ bằng một con lăn xơ vải.</p>\r\n\r\n<p>Để đảm bảo nhung duy tr&igrave; được vẻ ngo&agrave;i v&agrave; cảm gi&aacute;c, n&oacute; cần được chăm s&oacute;c thường xuy&ecirc;n theo hướng dẫn chăm s&oacute;c k&egrave;m theo sản phẩm.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nIKEA của Thụy Điển</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>Khung:</strong></p>\r\n\r\n<p>V&aacute;n &eacute;p, Bọt polyurethane 1,2 lb / cu.ft., Bọt polyurethane 1,5 lb / cu.ft., Bọt polyurethane 2,2 lb / cu.ft., Tấm l&oacute;t polyester, V&aacute;n dăm, Gỗ rắn</p>\r\n\r\n<p><strong>Đệm ngồi:</strong></p>\r\n\r\n<p>Bọt polyurethane 2,2 lb / cu.ft., Tấm l&oacute;t Polyester, tấm l&oacute;t Polyester</p>\r\n\r\n<p><strong>Ch&acirc;n:</strong></p>\r\n\r\n<p>Gỗ rắn, vết</p>\r\n\r\n<p><strong>Vải v&oacute;c:</strong></p>\r\n\r\n<p>38% viscose / rayon, 62% polyester (tối thiểu 90% t&aacute;i chế)</p>\r\n\r\n<p>Để đảm bảo nhung duy tr&igrave; được vẻ ngo&agrave;i v&agrave; cảm gi&aacute;c, n&oacute; cần được chăm s&oacute;c thường xuy&ecirc;n theo hướng dẫn chăm s&oacute;c k&egrave;m theo sản phẩm.</p>\r\n\r\n<p><strong>Khung, nắp kh&ocirc;ng thể th&aacute;o rời</strong></p>\r\n\r\n<p>Loại bỏ bụi bằng chất tẩy xơ vải.</p>\r\n\r\n<p>C&aacute;c vết bẩn nhẹ c&oacute; thể được loại bỏ bằng một miếng bọt biển ẩm hoặc dung dịch x&agrave; ph&ograve;ng nhẹ.</p>', 2, NULL, '41', 5000000, 5500000, 6000000, 1000, 1, '2022-06-01 01:22:13', '2022-06-01 08:05:18', 40),
(42, 'Ghế Strandmon Ghi', 9, 'Bạn thực sự có thể thả lỏng người và thư giãn một cách thoải mái vì phần lưng cao của chiếc ghế này hỗ trợ thêm cho cổ của bạn.\r\n\r\nBảo hành 10 năm có giới hạn. Đọc về các điều khoản trong tài liệu giới hạn bảo hành.', '<p>Bạn thực sự c&oacute; thể thả lỏng người v&agrave; thư gi&atilde;n một c&aacute;ch thoải m&aacute;i v&igrave; phần lưng cao của chiếc ghế n&agrave;y hỗ trợ th&ecirc;m cho cổ của bạn.</p>\r\n\r\n<p>Lớp phủ của DJUPARP được l&agrave;m bằng nhung, th&ocirc;ng qua kỹ thuật dệt truyền thống tạo cho vải c&oacute; m&agrave;u trầm, ấm v&agrave; bề mặt mềm mại với một lớp d&agrave;y đặc v&agrave; &aacute;nh s&aacute;ng phản chiếu &aacute;nh s&aacute;ng.</p>\r\n\r\n<p>Lớp nhung được dệt từ visco v&agrave; polyester tạo độ bền cao.</p>\r\n\r\n<p>Bảo h&agrave;nh 10 năm c&oacute; giới hạn. Đọc về c&aacute;c điều khoản trong t&agrave;i liệu giới hạn bảo h&agrave;nh.</p>\r\n\r\n<p>Lớp nhung phản chiếu &aacute;nh s&aacute;ng theo một c&aacute;ch đặc trưng c&oacute; thể l&agrave;m cho m&agrave;u sắc xuất hiện như thể n&oacute; thay đổi.</p>\r\n\r\n<p>C&aacute;c vết ấn c&oacute; thể xuất hiện tr&ecirc;n nhung thường biến mất trong thời gian. D&ugrave;ng tay miết nhẹ theo chiều cọc hoặc d&ugrave;ng b&agrave;n chải quần &aacute;o. Bạn cũng c&oacute; thể sử dụng m&aacute;y h&uacute;t bụi với đầu h&uacute;t mềm.</p>\r\n\r\n<p>C&aacute;c sợi nhỏ c&oacute; thể xuất hiện tr&ecirc;n nhung. N&oacute; xảy ra một c&aacute;ch tự nhi&ecirc;n v&agrave; ch&uacute;ng biến mất theo thời gian v&agrave; cũng c&oacute; thể được loại bỏ bằng một con lăn xơ vải.</p>\r\n\r\n<p>Để đảm bảo nhung duy tr&igrave; được vẻ ngo&agrave;i v&agrave; cảm gi&aacute;c, n&oacute; cần được chăm s&oacute;c thường xuy&ecirc;n theo hướng dẫn chăm s&oacute;c k&egrave;m theo sản phẩm.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nIKEA của Thụy Điển</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>Khung:</strong></p>\r\n\r\n<p>V&aacute;n &eacute;p, Bọt polyurethane 1,2 lb / cu.ft., Bọt polyurethane 1,5 lb / cu.ft., Bọt polyurethane 2,2 lb / cu.ft., Tấm l&oacute;t polyester, V&aacute;n dăm, Gỗ rắn</p>\r\n\r\n<p><strong>Đệm ngồi:</strong></p>\r\n\r\n<p>Bọt polyurethane 2,2 lb / cu.ft., Tấm l&oacute;t Polyester, tấm l&oacute;t Polyester</p>\r\n\r\n<p><strong>Ch&acirc;n:</strong></p>\r\n\r\n<p>Gỗ rắn, vết</p>\r\n\r\n<p><strong>Vải v&oacute;c:</strong></p>\r\n\r\n<p>38% viscose / rayon, 62% polyester (tối thiểu 90% t&aacute;i chế)</p>\r\n\r\n<p>Để đảm bảo nhung duy tr&igrave; được vẻ ngo&agrave;i v&agrave; cảm gi&aacute;c, n&oacute; cần được chăm s&oacute;c thường xuy&ecirc;n theo hướng dẫn chăm s&oacute;c k&egrave;m theo sản phẩm.</p>\r\n\r\n<p><strong>Khung, nắp kh&ocirc;ng thể th&aacute;o rời</strong></p>\r\n\r\n<p>Loại bỏ bụi bằng chất tẩy xơ vải.</p>\r\n\r\n<p>C&aacute;c vết bẩn nhẹ c&oacute; thể được loại bỏ bằng một miếng bọt biển ẩm hoặc dung dịch x&agrave; ph&ograve;ng nhẹ.</p>', 2, NULL, '42', 5000000, 5500000, 6000000, 1000, 1, '2022-06-01 01:26:22', '2022-06-01 08:05:29', 40);
INSERT INTO `product` (`ID`, `name`, `product_category`, `description`, `content_review`, `display_state`, `rate`, `slug`, `price_entry`, `price_sale`, `price_sell`, `quantity`, `status`, `created_at`, `updated_at`, `product_parent`) VALUES
(43, 'Ghế Koarp', 9, 'Một món trang sức trong phòng khách, được đặt riêng hoặc cùng với các đồ nội thất khác. Màu sắc hoặc kín đáo - bạn chọn, nhưng sự thoải mái luôn được bao gồm. Cũng như túi lưu trữ bí mật…', '<p>Lớp bọt c&oacute; khả năng đ&agrave;n hồi cao gi&uacute;p ghế b&agrave;nh mềm mại v&agrave; thoải m&aacute;i khi ngồi, v&agrave; n&oacute; nhanh ch&oacute;ng lấy lại h&igrave;nh dạng khi bạn đứng dậy.</p>\r\n\r\n<p>Tay vịn chắc chắn v&agrave; thoải m&aacute;i, l&agrave; nơi ho&agrave;n hảo để tựa v&agrave;o, bất kể bạn th&iacute;ch ngồi tr&ecirc;n ghế b&agrave;nh như thế n&agrave;o.</p>\r\n\r\n<p>Ở b&ecirc;n ngo&agrave;i của tựa lưng, c&oacute; một t&uacute;i lưu trữ ẩn, nơi bạn c&oacute; thể giữ những thứ như tạp ch&iacute; hoặc m&aacute;y t&iacute;nh bảng.</p>\r\n\r\n<p>Vỏ dễ d&agrave;ng giữ sạch v&igrave; c&oacute; thể th&aacute;o rời v&agrave; c&oacute; thể giặt bằng m&aacute;y.</p>\r\n\r\n<p>Bảo h&agrave;nh 10 năm c&oacute; giới hạn. Đọc về c&aacute;c điều khoản trong t&agrave;i liệu giới hạn bảo h&agrave;nh.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nEhl&eacute;n Johansson</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<div class=\"pip-product-details__container\" style=\"margin-bottom:24px; padding:0px; text-align:left\">\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Khung:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Gỗ rắn, V&aacute;n &eacute;p, V&aacute;n dăm, Bọt polyurethane 2,0 lb / cu.ft., Bọt polyurethane 1,2 lb / cu.ft., Tấm l&oacute;t polyester, V&aacute;n sợi</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Đệm ngồi:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Bọt polyurethane c&oacute; khả năng đ&agrave;n hồi cao (bọt lạnh) 2,2 lb / cu.ft., Tấm l&oacute;t Polyester, tấm l&oacute;t Polyester</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Đệm sau:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Polyester kh&ocirc;ng dệt, b&oacute;ng sợi Polyester, tấm l&oacute;t Polyester</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Vải che bụi:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Polypropylene kh&ocirc;ng dệt</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Zig-zag m&ugrave;a xu&acirc;n:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Th&eacute;p</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">M&oacute;c v&agrave; d&acirc;y buộc v&ograve;ng lặp:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">100% nylon</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Lớp l&oacute;t chống h&ocirc;i / Lớp l&oacute;t chống h&ocirc;i:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Tấm l&oacute;t polyester</span></span></span></span></p>\r\n</div>\r\n</div>\r\n\r\n<div class=\"pip-product-details__container\" style=\"margin-bottom:24px; margin-top:16px; padding:0px; text-align:left\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Khung ch&acirc;n</span></strong></span></span></span></span>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Ch&acirc;n / Gi&aacute; đỡ:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Th&eacute;p, sơn tĩnh điện Epoxy / polyester</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Bộ phận nhựa:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Polypropylene</span></span></span></span></p>\r\n</div>\r\n</div>\r\n\r\n<div class=\"pip-product-details__container\" style=\"margin-bottom:24px; margin-top:16px; padding:0px; text-align:left\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">&Aacute;o ghế</span></strong></span></span></span></span>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Vải sau:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">100% polyester (100% t&aacute;i chế)</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Chủ đề / D&acirc;y k&eacute;o:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">100% polyester</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Vải v&oacute;c:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">100% polyester</span></span></span></span></p>\r\n</div>\r\n</div>\r\n\r\n<div class=\"pip-product-details__container\" style=\"margin-bottom:24px; margin-top:16px; padding:0px; text-align:left\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">L&oacute;t</span></strong><strong><span style=\"color:#484848\">Ghế b&agrave;nh</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">M&aacute;y h&uacute;t bụi.</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__container\" style=\"margin-bottom:24px; margin-top:16px; padding:0px; text-align:left\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Nắp c&oacute; thể th&aacute;o rời</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">M&aacute;y giặt ấm, chu kỳ b&igrave;nh thường.&nbsp;</span></span></span></span><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Kh&ocirc;ng tẩy.&nbsp;</span></span></span></span><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Kh&ocirc;ng sấy kh&ocirc;.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Sắt nhiệt độ trung b&igrave;nh, tối đa 300 &deg; F / 150 &deg; C.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">L&agrave;m kh&ocirc; mọi dung m&ocirc;i trừ trichloroethylene.</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__container\" style=\"margin-top:16px; padding:0px; text-align:left\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Khung ch&acirc;n</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Kh&ocirc;ng sử dụng bột cọ rửa, len th&eacute;p, dụng cụ cứng hoặc sắc nhọn c&oacute; thể l&agrave;m xước bề mặt.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Lau sạch bằng vải ẩm.</span></span></span></span></p>\r\n</div>', 2, NULL, '43', 5000000, 580000, 6000000, 10000, 1, '2022-06-01 01:35:10', '2022-06-01 08:07:28', 26),
(44, 'Ghế Koarp Đen', 9, 'Một món trang sức trong phòng khách, được đặt riêng hoặc cùng với các đồ nội thất khác. Màu sắc hoặc kín đáo - bạn chọn, nhưng sự thoải mái luôn được bao gồm. Cũng như túi lưu trữ bí mật…', '<p>Lớp bọt c&oacute; khả năng đ&agrave;n hồi cao gi&uacute;p ghế b&agrave;nh mềm mại v&agrave; thoải m&aacute;i khi ngồi, v&agrave; n&oacute; nhanh ch&oacute;ng lấy lại h&igrave;nh dạng khi bạn đứng dậy.</p>\r\n\r\n<p>Tay vịn chắc chắn v&agrave; thoải m&aacute;i, l&agrave; nơi ho&agrave;n hảo để tựa v&agrave;o, bất kể bạn th&iacute;ch ngồi tr&ecirc;n ghế b&agrave;nh như thế n&agrave;o.</p>\r\n\r\n<p>Ở b&ecirc;n ngo&agrave;i của tựa lưng, c&oacute; một t&uacute;i lưu trữ ẩn, nơi bạn c&oacute; thể giữ những thứ như tạp ch&iacute; hoặc m&aacute;y t&iacute;nh bảng.</p>\r\n\r\n<p>Vỏ dễ d&agrave;ng giữ sạch v&igrave; c&oacute; thể th&aacute;o rời v&agrave; c&oacute; thể giặt bằng m&aacute;y.</p>\r\n\r\n<p>Bảo h&agrave;nh 10 năm c&oacute; giới hạn. Đọc về c&aacute;c điều khoản trong t&agrave;i liệu giới hạn bảo h&agrave;nh.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nEhl&eacute;n Johansson</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>Khung:</strong></p>\r\n\r\n<p>Gỗ rắn, V&aacute;n &eacute;p, V&aacute;n dăm, Bọt polyurethane 2,0 lb / cu.ft., Bọt polyurethane 1,2 lb / cu.ft., Tấm l&oacute;t polyester, V&aacute;n sợi</p>\r\n\r\n<p><strong>Đệm ngồi:</strong></p>\r\n\r\n<p>Bọt polyurethane c&oacute; khả năng đ&agrave;n hồi cao (bọt lạnh) 2,2 lb / cu.ft., Tấm l&oacute;t Polyester, tấm l&oacute;t Polyester</p>\r\n\r\n<p><strong>Đệm sau:</strong></p>\r\n\r\n<p>Polyester kh&ocirc;ng dệt, b&oacute;ng sợi Polyester, tấm l&oacute;t Polyester</p>\r\n\r\n<p><strong>Vải che bụi:</strong></p>\r\n\r\n<p>Polypropylene kh&ocirc;ng dệt</p>\r\n\r\n<p><strong>Zig-zag m&ugrave;a xu&acirc;n:</strong></p>\r\n\r\n<p>Th&eacute;p</p>\r\n\r\n<p><strong>M&oacute;c v&agrave; d&acirc;y buộc v&ograve;ng lặp:</strong></p>\r\n\r\n<p>100% nylon</p>\r\n\r\n<p><strong>Lớp l&oacute;t chống h&ocirc;i / Lớp l&oacute;t chống h&ocirc;i:</strong></p>\r\n\r\n<p>Tấm l&oacute;t polyester</p>\r\n\r\n<p><strong>Khung ch&acirc;n</strong><strong>Ch&acirc;n / Gi&aacute; đỡ:</strong></p>\r\n\r\n<p>Th&eacute;p, sơn tĩnh điện Epoxy / polyester</p>\r\n\r\n<p><strong>Bộ phận nhựa:</strong></p>\r\n\r\n<p>Polypropylene</p>\r\n\r\n<p><strong>&Aacute;o ghế</strong><strong>Vải sau:</strong></p>\r\n\r\n<p>100% polyester (100% t&aacute;i chế)</p>\r\n\r\n<p><strong>Chủ đề / D&acirc;y k&eacute;o:</strong></p>\r\n\r\n<p>100% polyester</p>\r\n\r\n<p><strong>Vải v&oacute;c:</strong></p>\r\n\r\n<p>100% polyester</p>\r\n\r\n<p><strong>L&oacute;t</strong><strong>Ghế b&agrave;nh</strong></p>\r\n\r\n<p>M&aacute;y h&uacute;t bụi.</p>\r\n\r\n<p><strong>Nắp c&oacute; thể th&aacute;o rời</strong></p>\r\n\r\n<p>M&aacute;y giặt ấm, chu kỳ b&igrave;nh thường.&nbsp;Kh&ocirc;ng tẩy.&nbsp;Kh&ocirc;ng sấy kh&ocirc;.</p>\r\n\r\n<p>Sắt nhiệt độ trung b&igrave;nh, tối đa 300 &deg; F / 150 &deg; C.</p>\r\n\r\n<p>L&agrave;m kh&ocirc; mọi dung m&ocirc;i trừ trichloroethylene.</p>\r\n\r\n<p><strong>Khung ch&acirc;n</strong></p>\r\n\r\n<p>Kh&ocirc;ng sử dụng bột cọ rửa, len th&eacute;p, dụng cụ cứng hoặc sắc nhọn c&oacute; thể l&agrave;m xước bề mặt.</p>\r\n\r\n<p>Lau sạch bằng vải ẩm.</p>', 2, NULL, '44', 5000000, 5800000, 6000000, 1000, 1, '2022-06-01 01:38:44', '2022-06-01 08:07:43', 43),
(45, 'Ghế Koarp Xám', 9, 'Một món trang sức trong phòng khách, được đặt riêng hoặc cùng với các đồ nội thất khác. Màu sắc hoặc kín đáo - bạn chọn, nhưng sự thoải mái luôn được bao gồm. Cũng như túi lưu trữ bí mật…', '<p>Lớp bọt c&oacute; khả năng đ&agrave;n hồi cao gi&uacute;p ghế b&agrave;nh mềm mại v&agrave; thoải m&aacute;i khi ngồi, v&agrave; n&oacute; nhanh ch&oacute;ng lấy lại h&igrave;nh dạng khi bạn đứng dậy.</p>\r\n\r\n<p>Tay vịn chắc chắn v&agrave; thoải m&aacute;i, l&agrave; nơi ho&agrave;n hảo để tựa v&agrave;o, bất kể bạn th&iacute;ch ngồi tr&ecirc;n ghế b&agrave;nh như thế n&agrave;o.</p>\r\n\r\n<p>Ở b&ecirc;n ngo&agrave;i của tựa lưng, c&oacute; một t&uacute;i lưu trữ ẩn, nơi bạn c&oacute; thể giữ những thứ như tạp ch&iacute; hoặc m&aacute;y t&iacute;nh bảng.</p>\r\n\r\n<p>Vỏ dễ d&agrave;ng giữ sạch v&igrave; c&oacute; thể th&aacute;o rời v&agrave; c&oacute; thể giặt bằng m&aacute;y.</p>\r\n\r\n<p>Bảo h&agrave;nh 10 năm c&oacute; giới hạn. Đọc về c&aacute;c điều khoản trong t&agrave;i liệu giới hạn bảo h&agrave;nh.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nEhl&eacute;n Johansson</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>Khung:</strong></p>\r\n\r\n<p>Gỗ rắn, V&aacute;n &eacute;p, V&aacute;n dăm, Bọt polyurethane 2,0 lb / cu.ft., Bọt polyurethane 1,2 lb / cu.ft., Tấm l&oacute;t polyester, V&aacute;n sợi</p>\r\n\r\n<p><strong>Đệm ngồi:</strong></p>\r\n\r\n<p>Bọt polyurethane c&oacute; khả năng đ&agrave;n hồi cao (bọt lạnh) 2,2 lb / cu.ft., Tấm l&oacute;t Polyester, tấm l&oacute;t Polyester</p>\r\n\r\n<p><strong>Đệm sau:</strong></p>\r\n\r\n<p>Polyester kh&ocirc;ng dệt, b&oacute;ng sợi Polyester, tấm l&oacute;t Polyester</p>\r\n\r\n<p><strong>Vải che bụi:</strong></p>\r\n\r\n<p>Polypropylene kh&ocirc;ng dệt</p>\r\n\r\n<p><strong>Zig-zag m&ugrave;a xu&acirc;n:</strong></p>\r\n\r\n<p>Th&eacute;p</p>\r\n\r\n<p><strong>M&oacute;c v&agrave; d&acirc;y buộc v&ograve;ng lặp:</strong></p>\r\n\r\n<p>100% nylon</p>\r\n\r\n<p><strong>Lớp l&oacute;t chống h&ocirc;i / Lớp l&oacute;t chống h&ocirc;i:</strong></p>\r\n\r\n<p>Tấm l&oacute;t polyester</p>\r\n\r\n<p><strong>Khung ch&acirc;n</strong><strong>Ch&acirc;n / Gi&aacute; đỡ:</strong></p>\r\n\r\n<p>Th&eacute;p, sơn tĩnh điện Epoxy / polyester</p>\r\n\r\n<p><strong>Bộ phận nhựa:</strong></p>\r\n\r\n<p>Polypropylene</p>\r\n\r\n<p><strong>&Aacute;o ghế</strong><strong>Vải sau:</strong></p>\r\n\r\n<p>100% polyester (100% t&aacute;i chế)</p>\r\n\r\n<p><strong>Chủ đề / D&acirc;y k&eacute;o:</strong></p>\r\n\r\n<p>100% polyester</p>\r\n\r\n<p><strong>Vải v&oacute;c:</strong></p>\r\n\r\n<p>100% polyester</p>\r\n\r\n<p><strong>L&oacute;t</strong><strong>Ghế b&agrave;nh</strong></p>\r\n\r\n<p>M&aacute;y h&uacute;t bụi.</p>\r\n\r\n<p><strong>Nắp c&oacute; thể th&aacute;o rời</strong></p>\r\n\r\n<p>M&aacute;y giặt ấm, chu kỳ b&igrave;nh thường.&nbsp;Kh&ocirc;ng tẩy.&nbsp;Kh&ocirc;ng sấy kh&ocirc;.</p>\r\n\r\n<p>Sắt nhiệt độ trung b&igrave;nh, tối đa 300 &deg; F / 150 &deg; C.</p>\r\n\r\n<p>L&agrave;m kh&ocirc; mọi dung m&ocirc;i trừ trichloroethylene.</p>\r\n\r\n<p><strong>Khung ch&acirc;n</strong></p>\r\n\r\n<p>Kh&ocirc;ng sử dụng bột cọ rửa, len th&eacute;p, dụng cụ cứng hoặc sắc nhọn c&oacute; thể l&agrave;m xước bề mặt.</p>\r\n\r\n<p>Lau sạch bằng vải ẩm.</p>', 2, NULL, '45', 5000000, 5800000, 6000000, 1000, 1, '2022-06-01 01:41:49', '2022-06-01 08:07:53', 43),
(46, 'Ghế Ekero', 9, 'Hãy chọn những tông màu tối đầy phong cách hoặc làm bừng sáng ngôi nhà của bạn với những tấm bìa nhiều màu sắc. Ghế bành EKERÖ có kiểu dáng đẹp, hiện đại với hai miếng bên gặp nhau ở phía sau - và hỗ trợ thắt lưng để tăng thêm sự thoải mái!', '<p>Đệm lưng c&oacute; thể đảo ngược gi&uacute;p hỗ trợ mềm mại cho lưng của bạn v&agrave; hai b&ecirc;n kh&aacute;c nhau để đeo.</p>\r\n\r\n<p>Đệm lưng c&oacute; thể được di chuyển xung quanh để ph&ugrave; hợp với phong c&aacute;ch ngồi của bạn.</p>\r\n\r\n<p>B&igrave;a n&agrave;y được l&agrave;m từ vải polyester SKIFTEBO bền.&nbsp;N&oacute; c&oacute; độ b&oacute;ng đẹp v&agrave; hiệu ứng hai t&ocirc;ng m&agrave;u với kết cấu nhẹ tạo cảm gi&aacute;c chắc chắn khi chạm v&agrave;o.</p>\r\n\r\n<p>Bảo h&agrave;nh 10 năm c&oacute; giới hạn.&nbsp;Đọc về c&aacute;c điều khoản trong t&agrave;i liệu giới hạn bảo h&agrave;nh.</p>\r\n\r\n<p>Vui l&ograve;ng kiểm tra với ch&iacute;nh quyền địa phương của bạn để đảm bảo rằng sản phẩm tu&acirc;n thủ mọi y&ecirc;u cầu cụ thể để sử dụng cho mục đ&iacute;ch kinh doanh.</p>\r\n\r\n<p><strong>Nh&agrave; thiết kế</strong></p>\r\n\r\n<p>Eva Lilja L&ouml;wenhielm</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>Vải hỗ trợ:</strong></p>\r\n\r\n<p>100% polypropylene</p>\r\n\r\n<p><strong>Vải v&oacute;c:</strong></p>\r\n\r\n<p>100% polyester</p>\r\n\r\n<p><strong>Khung:</strong></p>\r\n\r\n<p>V&aacute;n dăm, V&aacute;n &eacute;p, Bọt polyurethane 1,5 lb / cu.ft., Tấm l&oacute;t polyester, Gỗ veneer nhiều lớp, Gỗ rắn, V&aacute;n sợi</p>\r\n\r\n<p><strong>Chỗ ngồi cố định:</strong></p>\r\n\r\n<p>Bọt polyurethane 2.0 lb / cu.ft., Tấm l&oacute;t polyester</p>\r\n\r\n<p><strong>Đệm rời:</strong></p>\r\n\r\n<p>Quả b&oacute;ng sợi polyester</p>\r\n\r\n<p><strong>Ch&acirc;n:</strong></p>\r\n\r\n<p>Th&eacute;p, sơn tĩnh điện</p>\r\n\r\n<p>M&aacute;y h&uacute;t bụi.</p>\r\n\r\n<p>Lau sạch bằng vải ẩm.</p>', 2, NULL, '46', 4000000, 4750000, 5000000, 1000, 1, '2022-06-01 01:46:30', '2022-06-01 07:56:09', 26),
(47, 'Ghế Ekero Đỏ', 9, 'Hãy chọn những tông màu tối đầy phong cách hoặc làm bừng sáng ngôi nhà của bạn với những tấm bìa nhiều màu sắc. Ghế bành EKERÖ có kiểu dáng đẹp, hiện đại với hai miếng bên gặp nhau ở phía sau - và hỗ trợ thắt lưng để tăng thêm sự thoải mái!', '<p style=\"text-align:start\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Đệm lưng c&oacute; thể đảo ngược gi&uacute;p hỗ trợ mềm mại cho lưng của bạn v&agrave; hai b&ecirc;n kh&aacute;c nhau để đeo.</span></span></span></span></p>\r\n\r\n<p style=\"text-align:start\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Đệm lưng c&oacute; thể được di chuyển xung quanh để ph&ugrave; hợp với phong c&aacute;ch ngồi của bạn.</span></span></span></span></p>\r\n\r\n<div class=\"pip-expander\" style=\"padding:0px; text-align:start; width:367px\">\r\n<div class=\"pip-expander__content\" style=\"margin-bottom:24px; padding:0px\">\r\n<div style=\"padding:0px\">\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">B&igrave;a n&agrave;y được l&agrave;m từ vải polyester SKIFTEBO bền.&nbsp;N&oacute; c&oacute; độ b&oacute;ng đẹp v&agrave; hiệu ứng hai t&ocirc;ng m&agrave;u với kết cấu nhẹ tạo cảm gi&aacute;c chắc chắn khi chạm v&agrave;o.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Bảo h&agrave;nh 10 năm c&oacute; giới hạn.&nbsp;Đọc về c&aacute;c điều khoản trong t&agrave;i liệu giới hạn bảo h&agrave;nh.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Vui l&ograve;ng kiểm tra với ch&iacute;nh quyền địa phương của bạn để đảm bảo rằng sản phẩm tu&acirc;n thủ mọi y&ecirc;u cầu cụ thể để sử dụng cho mục đ&iacute;ch kinh doanh.</span></span></span></span></p>\r\n\r\n<div style=\"padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong>Nh&agrave; thiết kế</strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Eva Lilja L&ouml;wenhielm</span></span></span></span></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<div class=\"pip-product-details__container\" style=\"margin-bottom:24px; padding:0px; text-align:left\">\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Vải hỗ trợ:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">100% polypropylene</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Vải v&oacute;c:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">100% polyester</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Khung:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">V&aacute;n dăm, V&aacute;n &eacute;p, Bọt polyurethane 1,5 lb / cu.ft., Tấm l&oacute;t polyester, Gỗ veneer nhiều lớp, Gỗ rắn, V&aacute;n sợi</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Chỗ ngồi cố định:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Bọt polyurethane 2.0 lb / cu.ft., Tấm l&oacute;t polyester</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Đệm rời:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Quả b&oacute;ng sợi polyester</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Ch&acirc;n:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Th&eacute;p, sơn tĩnh điện</span></span></span></span></p>\r\n</div>\r\n</div>\r\n\r\n<div class=\"pip-product-details__container\" style=\"margin-top:16px; padding:0px; text-align:left\">\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">M&aacute;y h&uacute;t bụi.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Lau sạch bằng vải ẩm.</span></span></span></span></p>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>', 2, NULL, '47', 4000000, 4750000, 5000000, 1000, 1, '2022-06-01 01:49:51', '2022-06-01 07:55:35', 46),
(48, 'Ghế Ekero Vàng', 9, 'Hãy chọn những tông màu tối đầy phong cách hoặc làm bừng sáng ngôi nhà của bạn với những tấm bìa nhiều màu sắc. Ghế bành EKERÖ có kiểu dáng đẹp, hiện đại với hai miếng bên gặp nhau ở phía sau - và hỗ trợ thắt lưng để tăng thêm sự thoải mái!', '<p>Đệm lưng c&oacute; thể đảo ngược gi&uacute;p hỗ trợ mềm mại cho lưng của bạn v&agrave; hai b&ecirc;n kh&aacute;c nhau để đeo.</p>\r\n\r\n<p>Đệm lưng c&oacute; thể được di chuyển xung quanh để ph&ugrave; hợp với phong c&aacute;ch ngồi của bạn.</p>\r\n\r\n<p>B&igrave;a n&agrave;y được l&agrave;m từ vải polyester SKIFTEBO bền.&nbsp;N&oacute; c&oacute; độ b&oacute;ng đẹp v&agrave; hiệu ứng hai t&ocirc;ng m&agrave;u với kết cấu nhẹ tạo cảm gi&aacute;c chắc chắn khi chạm v&agrave;o.</p>\r\n\r\n<p>Bảo h&agrave;nh 10 năm c&oacute; giới hạn.&nbsp;Đọc về c&aacute;c điều khoản trong t&agrave;i liệu giới hạn bảo h&agrave;nh.</p>\r\n\r\n<p>Vui l&ograve;ng kiểm tra với ch&iacute;nh quyền địa phương của bạn để đảm bảo rằng sản phẩm tu&acirc;n thủ mọi y&ecirc;u cầu cụ thể để sử dụng cho mục đ&iacute;ch kinh doanh.</p>\r\n\r\n<p><strong>Nh&agrave; thiết kế</strong></p>\r\n\r\n<p>Eva Lilja L&ouml;wenhielm</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>Vải hỗ trợ:</strong></p>\r\n\r\n<p>100% polypropylene</p>\r\n\r\n<p><strong>Vải v&oacute;c:</strong></p>\r\n\r\n<p>100% polyester</p>\r\n\r\n<p><strong>Khung:</strong></p>\r\n\r\n<p>V&aacute;n dăm, V&aacute;n &eacute;p, Bọt polyurethane 1,5 lb / cu.ft., Tấm l&oacute;t polyester, Gỗ veneer nhiều lớp, Gỗ rắn, V&aacute;n sợi</p>\r\n\r\n<p><strong>Chỗ ngồi cố định:</strong></p>\r\n\r\n<p>Bọt polyurethane 2.0 lb / cu.ft., Tấm l&oacute;t polyester</p>\r\n\r\n<p><strong>Đệm rời:</strong></p>\r\n\r\n<p>Quả b&oacute;ng sợi polyester</p>\r\n\r\n<p><strong>Ch&acirc;n:</strong></p>\r\n\r\n<p>Th&eacute;p, sơn tĩnh điện</p>\r\n\r\n<p>M&aacute;y h&uacute;t bụi.</p>\r\n\r\n<p>Lau sạch bằng vải ẩm.</p>', 2, NULL, '48', 4000000, 4750000, 5000000, 1000, 1, '2022-06-01 01:52:24', '2022-06-01 07:55:47', 46),
(49, 'Ghế Remsta', 9, 'Các góc được bo tròn mềm mại và các chi tiết đẹp mắt mang đến cho chiếc ghế bành REMSTA một dáng vẻ truyền thống. Vỏ bọc có cảm giác êm ái, hình dạng hỗ trợ thắt lưng - và bao bì nhỏ gọn làm giảm tác động của khí hậu trong quá trình vận chuyển.', '<p style=\"text-align:start\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">H&igrave;nh dạng của chiếc ghế b&agrave;nh gi&uacute;p hỗ trợ tốt cho v&ugrave;ng thắt lưng.</span></span></span></span></p>\r\n\r\n<p style=\"text-align:start\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Velvet l&agrave; một loại vải mềm, sang trọng, c&oacute; khả năng chống m&agrave;i m&ograve;n v&agrave; dễ d&agrave;ng l&agrave;m sạch bằng c&aacute;ch sử dụng phần đ&iacute;nh k&egrave;m b&agrave;n chải mềm tr&ecirc;n m&aacute;y h&uacute;t của bạn.</span></span></span></span></p>\r\n\r\n<div class=\"pip-expander\" style=\"padding:0px; text-align:start; width:367px\">\r\n<div class=\"pip-expander__content\" style=\"margin-bottom:24px; padding:0px\">\r\n<div style=\"padding:0px\">\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Lớp phủ của DJUPARP được l&agrave;m bằng nhung, th&ocirc;ng qua kỹ thuật dệt truyền thống tạo cho vải c&oacute; m&agrave;u trầm, ấm v&agrave; bề mặt mềm mại với một lớp d&agrave;y đặc v&agrave; &aacute;nh s&aacute;ng phản chiếu &aacute;nh s&aacute;ng.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Lớp nhung được dệt từ visco v&agrave; polyester tạo độ bền cao.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Bảo h&agrave;nh 10 năm c&oacute; giới hạn.&nbsp;Đọc về c&aacute;c điều khoản trong t&agrave;i liệu giới hạn bảo h&agrave;nh.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">B&igrave;a văn ph&ograve;ng phẩm.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Lớp nhung phản chiếu &aacute;nh s&aacute;ng theo một c&aacute;ch đặc trưng c&oacute; thể l&agrave;m cho m&agrave;u sắc xuất hiện như thể n&oacute; thay đổi.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">C&aacute;c vết ấn c&oacute; thể xuất hiện tr&ecirc;n nhung thường biến mất trong thời gian.&nbsp;D&ugrave;ng tay miết nhẹ theo chiều cọc hoặc d&ugrave;ng b&agrave;n chải quần &aacute;o.&nbsp;Bạn cũng c&oacute; thể sử dụng m&aacute;y h&uacute;t bụi với đầu h&uacute;t mềm.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">C&aacute;c sợi nhỏ c&oacute; thể xuất hiện tr&ecirc;n nhung.&nbsp;N&oacute; xảy ra một c&aacute;ch tự nhi&ecirc;n v&agrave; ch&uacute;ng biến mất theo thời gian v&agrave; cũng c&oacute; thể được loại bỏ bằng một con lăn xơ vải.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">C&oacute; thể ho&agrave;n thiện với lớp bảo vệ s&agrave;n tự d&iacute;nh FIXA để bảo vệ bề mặt b&ecirc;n dưới chống m&agrave;i m&ograve;n.</span></span></span></span></p>\r\n\r\n<div style=\"padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong>Nh&agrave; thiết kế</strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">IKEA của Thụy Điển</span></span></span></span></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<div class=\"pip-product-details__container\" style=\"margin-bottom:24px; padding:0px; text-align:left\">\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Khung ghế:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">V&aacute;n dăm, Bọt polyurethane 2.0 lb / cu.ft., Giấy b&igrave;a (100% t&aacute;i chế), V&aacute;n sợi</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Khung sau:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Gỗ rắn, V&aacute;n &eacute;p, Bọt polyurethane 2.0 lb / cu.ft., V&aacute;n sợi</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Ch&acirc;n:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Bạch dương rắn, Vết bẩn, Sơn m&agrave;i trong suốt</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Dấu ngoặc:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Th&eacute;p, sơn tĩnh điện Epoxy / polyester</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Vải v&oacute;c:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">38% viscose / rayon, 62% polyester (tối thiểu 90% t&aacute;i chế)</span></span></span></span></p>\r\n</div>\r\n</div>\r\n\r\n<div class=\"pip-product-details__container\" style=\"margin-bottom:24px; margin-top:16px; padding:0px; text-align:left\">\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Để c&oacute; chất lượng tối đa, h&atilde;y vặn chặt lại c&aacute;c v&iacute;t khi cần thiết.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Để đảm bảo nhung duy tr&igrave; được vẻ ngo&agrave;i v&agrave; cảm gi&aacute;c, n&oacute; cần được chăm s&oacute;c thường xuy&ecirc;n theo hướng dẫn chăm s&oacute;c k&egrave;m theo sản phẩm.</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__container\" style=\"margin-top:16px; padding:0px; text-align:left\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Th&ocirc;ng tin</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">L&agrave;m sạch bằng c&aacute;ch h&uacute;t bụi hoặc sử dụng con lăn xơ vải.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Kh&ocirc;ng rửa.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Kh&ocirc;ng tẩy.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Kh&ocirc;ng ủi.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Kh&ocirc;ng giặt kh&ocirc;.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">C&aacute;c vết ướt phải lu&ocirc;n được l&agrave;m kh&ocirc; c&agrave;ng sớm c&agrave;ng tốt để ngăn chặn sự x&acirc;m nhập của hơi ẩm.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">C&aacute;c vết bẩn nhẹ c&oacute; thể được loại bỏ bằng chất tẩy dệt hoặc miếng bọt biển ẩm v&agrave; dung dịch x&agrave; ph&ograve;ng nhẹ.</span></span></span></span></p>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>', 2, NULL, '49', 3000000, 3800000, 4000000, 1000, 1, '2022-06-01 02:00:04', '2022-06-01 07:57:10', 26);
INSERT INTO `product` (`ID`, `name`, `product_category`, `description`, `content_review`, `display_state`, `rate`, `slug`, `price_entry`, `price_sale`, `price_sell`, `quantity`, `status`, `created_at`, `updated_at`, `product_parent`) VALUES
(50, 'Ghế Remsta Be', 9, 'Các góc được bo tròn mềm mại và các chi tiết đẹp mắt mang đến cho chiếc ghế bành REMSTA một dáng vẻ truyền thống. Vỏ bọc có cảm giác êm ái, hình dạng hỗ trợ thắt lưng - và bao bì nhỏ gọn làm giảm tác động của khí hậu trong quá trình vận chuyển.', '<p>H&igrave;nh dạng của chiếc ghế b&agrave;nh gi&uacute;p hỗ trợ tốt cho v&ugrave;ng thắt lưng.</p>\r\n\r\n<p>Velvet l&agrave; một loại vải mềm, sang trọng, c&oacute; khả năng chống m&agrave;i m&ograve;n v&agrave; dễ d&agrave;ng l&agrave;m sạch bằng c&aacute;ch sử dụng phần đ&iacute;nh k&egrave;m b&agrave;n chải mềm tr&ecirc;n m&aacute;y h&uacute;t của bạn.</p>\r\n\r\n<p>Lớp phủ của DJUPARP được l&agrave;m bằng nhung, th&ocirc;ng qua kỹ thuật dệt truyền thống tạo cho vải c&oacute; m&agrave;u trầm, ấm v&agrave; bề mặt mềm mại với một lớp d&agrave;y đặc v&agrave; &aacute;nh s&aacute;ng phản chiếu &aacute;nh s&aacute;ng.</p>\r\n\r\n<p>Lớp nhung được dệt từ visco v&agrave; polyester tạo độ bền cao.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Lớp nhung phản chiếu &aacute;nh s&aacute;ng theo một c&aacute;ch đặc trưng c&oacute; thể l&agrave;m cho m&agrave;u sắc xuất hiện như thể n&oacute; thay đổi.</p>\r\n\r\n<p>C&aacute;c vết ấn c&oacute; thể xuất hiện tr&ecirc;n nhung thường biến mất trong thời gian.&nbsp;D&ugrave;ng tay miết nhẹ theo chiều cọc hoặc d&ugrave;ng b&agrave;n chải quần &aacute;o.&nbsp;Bạn cũng c&oacute; thể sử dụng m&aacute;y h&uacute;t bụi với đầu h&uacute;t mềm.</p>\r\n\r\n<p>C&aacute;c sợi nhỏ c&oacute; thể xuất hiện tr&ecirc;n nhung.&nbsp;N&oacute; xảy ra một c&aacute;ch tự nhi&ecirc;n v&agrave; ch&uacute;ng biến mất theo thời gian v&agrave; cũng c&oacute; thể được loại bỏ bằng một con lăn xơ vải.</p>\r\n\r\n<p>C&oacute; thể ho&agrave;n thiện với lớp bảo vệ s&agrave;n tự d&iacute;nh FIXA để bảo vệ bề mặt b&ecirc;n dưới chống m&agrave;i m&ograve;n.</p>\r\n\r\n<p><strong>Nh&agrave; thiết kế</strong></p>\r\n\r\n<p>IKEA của Thụy Điển</p>\r\n\r\n<p><strong>Khung ghế:</strong></p>\r\n\r\n<p>V&aacute;n dăm, Bọt polyurethane 2.0 lb / cu.ft., Giấy b&igrave;a (100% t&aacute;i chế), V&aacute;n sợi</p>\r\n\r\n<p><strong>Khung sau:</strong></p>\r\n\r\n<p>Gỗ rắn, V&aacute;n &eacute;p, Bọt polyurethane 2.0 lb / cu.ft., V&aacute;n sợi</p>\r\n\r\n<p><strong>Ch&acirc;n:</strong></p>\r\n\r\n<p>Bạch dương rắn, Vết bẩn, Sơn m&agrave;i trong suốt</p>\r\n\r\n<p><strong>Dấu ngoặc:</strong></p>\r\n\r\n<p>Th&eacute;p, sơn tĩnh điện Epoxy / polyester</p>\r\n\r\n<p><strong>Vải v&oacute;c:</strong></p>\r\n\r\n<p>38% viscose / rayon, 62% polyester (tối thiểu 90% t&aacute;i chế)</p>\r\n\r\n<p>Để c&oacute; chất lượng tối đa, h&atilde;y vặn chặt lại c&aacute;c v&iacute;t khi cần thiết.</p>\r\n\r\n<p>Để đảm bảo nhung duy tr&igrave; được vẻ ngo&agrave;i v&agrave; cảm gi&aacute;c, n&oacute; cần được chăm s&oacute;c thường xuy&ecirc;n theo hướng dẫn chăm s&oacute;c k&egrave;m theo sản phẩm.</p>\r\n\r\n<p><strong>Th&ocirc;ng tin</strong></p>\r\n\r\n<p>L&agrave;m sạch bằng c&aacute;ch h&uacute;t bụi hoặc sử dụng con lăn xơ vải. Kh&ocirc;ng rửa. Kh&ocirc;ng tẩy. Kh&ocirc;ng ủi. Kh&ocirc;ng giặt kh&ocirc;.</p>\r\n\r\n<p>C&aacute;c vết ướt phải lu&ocirc;n được l&agrave;m kh&ocirc; c&agrave;ng sớm c&agrave;ng tốt để ngăn chặn sự x&acirc;m nhập của hơi ẩm.</p>\r\n\r\n<p>C&aacute;c vết bẩn nhẹ c&oacute; thể được loại bỏ bằng chất tẩy dệt hoặc miếng bọt biển ẩm v&agrave; dung dịch x&agrave; ph&ograve;ng nhẹ.</p>', 2, NULL, '50', 3000000, 3800000, 4000000, 1000, 1, '2022-06-01 02:03:50', '2022-06-01 08:00:10', 49),
(51, 'Ghế Remsta Xám', 9, 'Các góc được bo tròn mềm mại và các chi tiết đẹp mắt mang đến cho chiếc ghế bành REMSTA một dáng vẻ truyền thống. Vỏ bọc có cảm giác êm ái, hình dạng hỗ trợ thắt lưng - và bao bì nhỏ gọn làm giảm tác động của khí hậu trong quá trình vận chuyển.', '<p>H&igrave;nh dạng của chiếc ghế b&agrave;nh gi&uacute;p hỗ trợ tốt cho v&ugrave;ng thắt lưng.</p>\r\n\r\n<p>Velvet l&agrave; một loại vải mềm, sang trọng, c&oacute; khả năng chống m&agrave;i m&ograve;n v&agrave; dễ d&agrave;ng l&agrave;m sạch bằng c&aacute;ch sử dụng phần đ&iacute;nh k&egrave;m b&agrave;n chải mềm tr&ecirc;n m&aacute;y h&uacute;t của bạn.</p>\r\n\r\n<p>Lớp phủ của DJUPARP được l&agrave;m bằng nhung, th&ocirc;ng qua kỹ thuật dệt truyền thống tạo cho vải c&oacute; m&agrave;u trầm, ấm v&agrave; bề mặt mềm mại với một lớp d&agrave;y đặc v&agrave; &aacute;nh s&aacute;ng phản chiếu &aacute;nh s&aacute;ng.</p>\r\n\r\n<p>Lớp nhung được dệt từ visco v&agrave; polyester tạo độ bền cao.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Lớp nhung phản chiếu &aacute;nh s&aacute;ng theo một c&aacute;ch đặc trưng c&oacute; thể l&agrave;m cho m&agrave;u sắc xuất hiện như thể n&oacute; thay đổi.</p>\r\n\r\n<p>C&aacute;c vết ấn c&oacute; thể xuất hiện tr&ecirc;n nhung thường biến mất trong thời gian.&nbsp;D&ugrave;ng tay miết nhẹ theo chiều cọc hoặc d&ugrave;ng b&agrave;n chải quần &aacute;o.&nbsp;Bạn cũng c&oacute; thể sử dụng m&aacute;y h&uacute;t bụi với đầu h&uacute;t mềm.</p>\r\n\r\n<p>C&aacute;c sợi nhỏ c&oacute; thể xuất hiện tr&ecirc;n nhung.&nbsp;N&oacute; xảy ra một c&aacute;ch tự nhi&ecirc;n v&agrave; ch&uacute;ng biến mất theo thời gian v&agrave; cũng c&oacute; thể được loại bỏ bằng một con lăn xơ vải.</p>\r\n\r\n<p>C&oacute; thể ho&agrave;n thiện với lớp bảo vệ s&agrave;n tự d&iacute;nh FIXA để bảo vệ bề mặt b&ecirc;n dưới chống m&agrave;i m&ograve;n.</p>\r\n\r\n<p><strong>Nh&agrave; thiết kế</strong></p>\r\n\r\n<p>IKEA của Thụy Điển</p>\r\n\r\n<p><strong>Khung ghế:</strong></p>\r\n\r\n<p>V&aacute;n dăm, Bọt polyurethane 2.0 lb / cu.ft., Giấy b&igrave;a (100% t&aacute;i chế), V&aacute;n sợi</p>\r\n\r\n<p><strong>Khung sau:</strong></p>\r\n\r\n<p>Gỗ rắn, V&aacute;n &eacute;p, Bọt polyurethane 2.0 lb / cu.ft., V&aacute;n sợi</p>\r\n\r\n<p><strong>Ch&acirc;n:</strong></p>\r\n\r\n<p>Bạch dương rắn, Vết bẩn, Sơn m&agrave;i trong suốt</p>\r\n\r\n<p><strong>Dấu ngoặc:</strong></p>\r\n\r\n<p>Th&eacute;p, sơn tĩnh điện Epoxy / polyester</p>\r\n\r\n<p><strong>Vải v&oacute;c:</strong></p>\r\n\r\n<p>38% viscose / rayon, 62% polyester (tối thiểu 90% t&aacute;i chế)</p>\r\n\r\n<p>Để c&oacute; chất lượng tối đa, h&atilde;y vặn chặt lại c&aacute;c v&iacute;t khi cần thiết.</p>\r\n\r\n<p>Để đảm bảo nhung duy tr&igrave; được vẻ ngo&agrave;i v&agrave; cảm gi&aacute;c, n&oacute; cần được chăm s&oacute;c thường xuy&ecirc;n theo hướng dẫn chăm s&oacute;c k&egrave;m theo sản phẩm.</p>\r\n\r\n<p><strong>Th&ocirc;ng tin</strong></p>\r\n\r\n<p>L&agrave;m sạch bằng c&aacute;ch h&uacute;t bụi hoặc sử dụng con lăn xơ vải. Kh&ocirc;ng rửa. Kh&ocirc;ng tẩy. Kh&ocirc;ng ủi. Kh&ocirc;ng giặt kh&ocirc;.</p>\r\n\r\n<p>C&aacute;c vết ướt phải lu&ocirc;n được l&agrave;m kh&ocirc; c&agrave;ng sớm c&agrave;ng tốt để ngăn chặn sự x&acirc;m nhập của hơi ẩm.</p>\r\n\r\n<p>C&aacute;c vết bẩn nhẹ c&oacute; thể được loại bỏ bằng chất tẩy dệt hoặc miếng bọt biển ẩm v&agrave; dung dịch x&agrave; ph&ograve;ng nhẹ.</p>', 2, NULL, '51', 3000000, 3800000, 4000000, 1000, 1, '2022-06-01 02:06:25', '2022-06-01 07:59:52', 49),
(52, 'Ghế Tullsta', 9, 'Một chiếc ghế bành nhỏ với trái tim lớn hoàn toàn phù hợp ngay cả khi không gian hạn chế.', '<p style=\"text-align:start\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Một loạt c&aacute;c lớp phủ được phối hợp gi&uacute;p bạn dễ d&agrave;ng tạo cho đồ nội thất của m&igrave;nh một diện mạo mới.</span></span></span></span></p>\r\n\r\n<p style=\"text-align:start\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Đường n&eacute;t mảnh mai, dễ d&agrave;ng đặt.</span></span></span></span></p>\r\n\r\n<div class=\"pip-expander\" style=\"padding:0px; text-align:start; width:367px\">\r\n<div class=\"pip-expander__content\" style=\"margin-bottom:24px; padding:0px\">\r\n<div style=\"padding:0px\">\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Nắp dễ d&agrave;ng giữ sạch v&igrave; c&oacute; thể th&aacute;o rời v&agrave; c&oacute; thể giặt bằng m&aacute;y.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Đệm đi k&egrave;m c&oacute; thể được sử dụng để hỗ trợ thắt lưng.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Bảo h&agrave;nh 10 năm c&oacute; giới hạn.&nbsp;Đọc về c&aacute;c điều khoản trong t&agrave;i liệu giới hạn bảo h&agrave;nh.</span></span></span></span></p>\r\n\r\n<div style=\"padding:0px\">\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong>Nh&agrave; thiết kế</strong></span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">IKEA của Thụy Điển</span></span></span></span></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<div class=\"pip-product-details__container\" style=\"margin-bottom:24px; padding:0px; text-align:left\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Khung ghế b&agrave;nh</span></strong></span></span></span></span>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Khung:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Gỗ rắn, V&aacute;n dăm, V&aacute;n sợi, 100% c&aacute;c t&ocirc;ng rắn t&aacute;i chế, bọt Polyurethane 1,5 lb / cu.ft., Tấm l&oacute;t polyester</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Đệm ngồi:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Bọt polyurethane 2,2 lb / cu.ft., Tấm l&oacute;t polyester</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Đệm sau:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Bọt polyurethane 1,2 lb / cu.ft., Tấm l&oacute;t polyester</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">M&oacute;c v&agrave; d&acirc;y buộc v&ograve;ng lặp:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">100% nylon</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Ch&acirc;n:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Sồi rắn, sơn m&agrave;i acrylic trong suốt</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Lớp l&oacute;t chống h&ocirc;i:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Tấm l&oacute;t polyester</span></span></span></span></p>\r\n</div>\r\n</div>\r\n\r\n<div class=\"pip-product-details__container\" style=\"margin-bottom:24px; margin-top:16px; padding:0px; text-align:left\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">&Aacute;o ghế</span></strong></span></span></span></span>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Tổng th&agrave;nh phần:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">100% polyester</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Vải sau:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">100% polypropylene</span></span></span></span></p>\r\n</div>\r\n</div>\r\n\r\n<div class=\"pip-product-details__container\" style=\"margin-bottom:24px; margin-top:16px; padding:0px; text-align:left\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Trải ra</span></strong><strong><span style=\"color:#484848\">&Aacute;o ghế</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">M&aacute;y giặt ấm, chu kỳ b&igrave;nh thường.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Lật nắp từ trong ra ngo&agrave;i v&agrave; n&eacute;n lại trước khi giặt.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Để được rửa ri&ecirc;ng.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Kh&ocirc;ng tẩy.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Kh&ocirc;ng sấy kh&ocirc;.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Sắt nhiệt độ trung b&igrave;nh, tối đa 300 &deg; F / 150 &deg; C.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Kh&ocirc;ng giặt kh&ocirc;.</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__container\" style=\"margin-top:16px; padding:0px; text-align:left\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">L&oacute;t</span></strong><strong><span style=\"color:#484848\">Khung ghế b&agrave;nh</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">M&aacute;y h&uacute;t bụi.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Lau kh&ocirc; bằng khăn sạch.</span></span></span></span></p>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>', 2, NULL, '52', 4500000, 5300000, 5500000, 1000, 1, '2022-06-01 02:11:06', '2022-06-01 08:03:00', 26),
(53, 'Ghế Tullsta Be', 9, 'Một chiếc ghế bành nhỏ với trái tim lớn hoàn toàn phù hợp ngay cả khi không gian hạn chế.', '<p>Một loạt c&aacute;c lớp phủ được phối hợp gi&uacute;p bạn dễ d&agrave;ng tạo cho đồ nội thất của m&igrave;nh một diện mạo mới.</p>\r\n\r\n<p>Đường n&eacute;t mảnh mai, dễ d&agrave;ng đặt.</p>\r\n\r\n<p>Nắp dễ d&agrave;ng giữ sạch v&igrave; c&oacute; thể th&aacute;o rời v&agrave; c&oacute; thể giặt bằng m&aacute;y.</p>\r\n\r\n<p>Đệm đi k&egrave;m c&oacute; thể được sử dụng để hỗ trợ thắt lưng.</p>\r\n\r\n<p>Bảo h&agrave;nh 10 năm c&oacute; giới hạn.&nbsp;Đọc về c&aacute;c điều khoản trong t&agrave;i liệu giới hạn bảo h&agrave;nh.</p>\r\n\r\n<p><strong>Nh&agrave; thiết kế</strong></p>\r\n\r\n<p>IKEA của Thụy Điển</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>Khung ghế b&agrave;nh</strong><strong>Khung:</strong></p>\r\n\r\n<p>Gỗ rắn, V&aacute;n dăm, V&aacute;n sợi, 100% c&aacute;c t&ocirc;ng rắn t&aacute;i chế, bọt Polyurethane 1,5 lb / cu.ft., Tấm l&oacute;t polyester</p>\r\n\r\n<p><strong>Đệm ngồi:</strong></p>\r\n\r\n<p>Bọt polyurethane 2,2 lb / cu.ft., Tấm l&oacute;t polyester</p>\r\n\r\n<p><strong>Đệm sau:</strong></p>\r\n\r\n<p>Bọt polyurethane 1,2 lb / cu.ft., Tấm l&oacute;t polyester</p>\r\n\r\n<p><strong>M&oacute;c v&agrave; d&acirc;y buộc v&ograve;ng lặp:</strong></p>\r\n\r\n<p>100% nylon</p>\r\n\r\n<p><strong>Ch&acirc;n:</strong></p>\r\n\r\n<p>Sồi rắn, sơn m&agrave;i acrylic trong suốt</p>\r\n\r\n<p><strong>Lớp l&oacute;t chống h&ocirc;i:</strong></p>\r\n\r\n<p>Tấm l&oacute;t polyester</p>\r\n\r\n<p><strong>&Aacute;o ghế</strong><strong>Tổng th&agrave;nh phần:</strong></p>\r\n\r\n<p>100% polyester</p>\r\n\r\n<p><strong>Vải sau:</strong></p>\r\n\r\n<p>100% polypropylene</p>\r\n\r\n<p><strong>Trải ra</strong><strong>&Aacute;o ghế</strong></p>\r\n\r\n<p>M&aacute;y giặt ấm, chu kỳ b&igrave;nh thường.</p>\r\n\r\n<p>Lật nắp từ trong ra ngo&agrave;i v&agrave; n&eacute;n lại trước khi giặt.</p>\r\n\r\n<p>Để được rửa ri&ecirc;ng.</p>\r\n\r\n<p>Kh&ocirc;ng tẩy.</p>\r\n\r\n<p>Kh&ocirc;ng sấy kh&ocirc;.</p>\r\n\r\n<p>Sắt nhiệt độ trung b&igrave;nh, tối đa 300 &deg; F / 150 &deg; C.</p>\r\n\r\n<p>Kh&ocirc;ng giặt kh&ocirc;.</p>\r\n\r\n<p><strong>L&oacute;t</strong><strong>Khung ghế b&agrave;nh</strong></p>\r\n\r\n<p>M&aacute;y h&uacute;t bụi.</p>\r\n\r\n<p>Lau kh&ocirc; bằng khăn sạch.</p>', 2, NULL, '53', 4500000, 5300000, 5500000, 1000, 1, '2022-06-01 02:14:18', '2022-06-01 08:03:13', 52),
(54, 'Ghế Tullsta Xám', 9, 'Một chiếc ghế bành nhỏ với trái tim lớn hoàn toàn phù hợp ngay cả khi không gian hạn chế.', '<p>Một loạt c&aacute;c lớp phủ được phối hợp gi&uacute;p bạn dễ d&agrave;ng tạo cho đồ nội thất của m&igrave;nh một diện mạo mới.</p>\r\n\r\n<p>Đường n&eacute;t mảnh mai, dễ d&agrave;ng đặt.</p>\r\n\r\n<p>Nắp dễ d&agrave;ng giữ sạch v&igrave; c&oacute; thể th&aacute;o rời v&agrave; c&oacute; thể giặt bằng m&aacute;y.</p>\r\n\r\n<p>Đệm đi k&egrave;m c&oacute; thể được sử dụng để hỗ trợ thắt lưng.</p>\r\n\r\n<p>Bảo h&agrave;nh 10 năm c&oacute; giới hạn.&nbsp;Đọc về c&aacute;c điều khoản trong t&agrave;i liệu giới hạn bảo h&agrave;nh.</p>\r\n\r\n<p><strong>Nh&agrave; thiết kế</strong></p>\r\n\r\n<p>IKEA của Thụy Điển</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>Khung ghế b&agrave;nh</strong><strong>Khung:</strong></p>\r\n\r\n<p>Gỗ rắn, V&aacute;n dăm, V&aacute;n sợi, 100% c&aacute;c t&ocirc;ng rắn t&aacute;i chế, bọt Polyurethane 1,5 lb / cu.ft., Tấm l&oacute;t polyester</p>\r\n\r\n<p><strong>Đệm ngồi:</strong></p>\r\n\r\n<p>Bọt polyurethane 2,2 lb / cu.ft., Tấm l&oacute;t polyester</p>\r\n\r\n<p><strong>Đệm sau:</strong></p>\r\n\r\n<p>Bọt polyurethane 1,2 lb / cu.ft., Tấm l&oacute;t polyester</p>\r\n\r\n<p><strong>M&oacute;c v&agrave; d&acirc;y buộc v&ograve;ng lặp:</strong></p>\r\n\r\n<p>100% nylon</p>\r\n\r\n<p><strong>Ch&acirc;n:</strong></p>\r\n\r\n<p>Sồi rắn, sơn m&agrave;i acrylic trong suốt</p>\r\n\r\n<p><strong>Lớp l&oacute;t chống h&ocirc;i:</strong></p>\r\n\r\n<p>Tấm l&oacute;t polyester</p>\r\n\r\n<p><strong>&Aacute;o ghế</strong><strong>Tổng th&agrave;nh phần:</strong></p>\r\n\r\n<p>100% polyester</p>\r\n\r\n<p><strong>Vải sau:</strong></p>\r\n\r\n<p>100% polypropylene</p>\r\n\r\n<p><strong>Trải ra</strong><strong>&Aacute;o ghế</strong></p>\r\n\r\n<p>M&aacute;y giặt ấm, chu kỳ b&igrave;nh thường.</p>\r\n\r\n<p>Lật nắp từ trong ra ngo&agrave;i v&agrave; n&eacute;n lại trước khi giặt.</p>\r\n\r\n<p>Để được rửa ri&ecirc;ng.</p>\r\n\r\n<p>Kh&ocirc;ng tẩy.</p>\r\n\r\n<p>Kh&ocirc;ng sấy kh&ocirc;.</p>\r\n\r\n<p>Sắt nhiệt độ trung b&igrave;nh, tối đa 300 &deg; F / 150 &deg; C.</p>\r\n\r\n<p>Kh&ocirc;ng giặt kh&ocirc;.</p>\r\n\r\n<p><strong>L&oacute;t</strong><strong>Khung ghế b&agrave;nh</strong></p>\r\n\r\n<p>M&aacute;y h&uacute;t bụi.</p>\r\n\r\n<p>Lau kh&ocirc; bằng khăn sạch.</p>', 2, NULL, '54', 4500000, 5300000, 5500000, 1000, 1, '2022-06-01 02:17:05', '2022-06-01 08:03:28', 52),
(55, 'Ghế Morabo', 9, 'Ấm áp và chào đón, gọn gàng và phong cách. Đệm ngồi hỗ trợ, lớp vỏ bọc mềm mại và độ ôm vừa vặn mang đến cho chiếc ghế sofa này sự cân bằng hoàn hảo giữa sự thoải mái, chức năng và vẻ ngoài của nó.', '<p>C&aacute;c vết ấn c&oacute; thể xuất hiện tr&ecirc;n nhung thường biến mất trong thời gian.&nbsp;D&ugrave;ng tay miết nhẹ theo chiều cọc hoặc d&ugrave;ng b&agrave;n chải quần &aacute;o.&nbsp;Bạn cũng c&oacute; thể sử dụng m&aacute;y h&uacute;t bụi với đầu h&uacute;t mềm.</p>\r\n\r\n<p>C&aacute;c sợi nhỏ c&oacute; thể xuất hiện tr&ecirc;n nhung.&nbsp;N&oacute; xảy ra một c&aacute;ch tự nhi&ecirc;n v&agrave; ch&uacute;ng biến mất theo thời gian v&agrave; cũng c&oacute; thể được loại bỏ bằng một con lăn xơ vải.</p>\r\n\r\n<p>Lớp nhung phản chiếu &aacute;nh s&aacute;ng theo một c&aacute;ch đặc trưng c&oacute; thể l&agrave;m cho m&agrave;u sắc xuất hiện như thể n&oacute; thay đổi.</p>\r\n\r\n<p><strong>Khung Ottoman</strong><strong>Vải v&oacute;c:</strong></p>\r\n\r\n<p>38% viscose / rayon, 62% polyester (tối thiểu 90% t&aacute;i chế)</p>\r\n\r\n<p><strong>Khung ghế:</strong></p>\r\n\r\n<p>V&aacute;n &eacute;p, Gỗ th&ocirc;ng rắn, Polypropylene kh&ocirc;ng dệt, Tấm l&oacute;t polyester, V&aacute;n dăm, V&aacute;n sợi</p>\r\n\r\n<p><strong>Đệm ngồi:</strong></p>\r\n\r\n<p>Tấm l&oacute;t polyester, bọt polyurethane c&oacute; khả năng đ&agrave;n hồi cao (bọt lạnh) 2,2 lb / cu.ft.</p>\r\n\r\n<p><strong>Lớp l&oacute;t chống h&ocirc;i:</strong></p>\r\n\r\n<p>Tấm l&oacute;t polyester</p>\r\n\r\n<p><strong>Ch&acirc;n</strong></p>\r\n\r\n<p>Gỗ nguy&ecirc;n khối, veneer sồi, sơn m&agrave;i trong suốt</p>\r\n\r\n<p><strong>Khung, nắp kh&ocirc;ng thể th&aacute;o rời</strong><strong>Khung Ottoman</strong></p>\r\n\r\n<p>C&aacute;c vết ướt phải lu&ocirc;n được l&agrave;m kh&ocirc; c&agrave;ng sớm c&agrave;ng tốt để ngăn chặn sự x&acirc;m nhập của hơi ẩm.</p>\r\n\r\n<p>Loại bỏ bụi bằng chất tẩy xơ vải.</p>\r\n\r\n<p>C&aacute;c vết bẩn nhẹ c&oacute; thể được loại bỏ bằng một miếng bọt biển ẩm hoặc dung dịch x&agrave; ph&ograve;ng nhẹ.</p>\r\n\r\n<p>Để đảm bảo nhung duy tr&igrave; được vẻ ngo&agrave;i v&agrave; cảm gi&aacute;c, n&oacute; cần được chăm s&oacute;c thường xuy&ecirc;n theo hướng dẫn chăm s&oacute;c k&egrave;m theo sản phẩm.</p>', 2, NULL, '55', 10000000, 11000000, 12000000, 1000, 1, '2022-06-01 02:24:22', '2022-06-01 07:50:16', 26),
(56, 'Ghê Morabo Xám', 9, 'Ấm áp và chào đón, gọn gàng và phong cách. Đệm ngồi hỗ trợ, lớp vỏ bọc mềm mại và độ ôm vừa vặn mang đến cho chiếc ghế sofa này sự cân bằng hoàn hảo giữa sự thoải mái, chức năng và vẻ ngoài của nó.', '<p>C&aacute;c vết ấn c&oacute; thể xuất hiện tr&ecirc;n nhung thường biến mất trong thời gian.&nbsp;D&ugrave;ng tay miết nhẹ theo chiều cọc hoặc d&ugrave;ng b&agrave;n chải quần &aacute;o.&nbsp;Bạn cũng c&oacute; thể sử dụng m&aacute;y h&uacute;t bụi với đầu h&uacute;t mềm.</p>\r\n\r\n<p>C&aacute;c sợi nhỏ c&oacute; thể xuất hiện tr&ecirc;n nhung.&nbsp;N&oacute; xảy ra một c&aacute;ch tự nhi&ecirc;n v&agrave; ch&uacute;ng biến mất theo thời gian v&agrave; cũng c&oacute; thể được loại bỏ bằng một con lăn xơ vải.</p>\r\n\r\n<p>Lớp nhung phản chiếu &aacute;nh s&aacute;ng theo một c&aacute;ch đặc trưng c&oacute; thể l&agrave;m cho m&agrave;u sắc xuất hiện như thể n&oacute; thay đổi.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>Khung Ottoman</strong><strong>Vải v&oacute;c:</strong></p>\r\n\r\n<p>38% viscose / rayon, 62% polyester (tối thiểu 90% t&aacute;i chế)</p>\r\n\r\n<p><strong>Khung ghế:</strong></p>\r\n\r\n<p>V&aacute;n &eacute;p, Gỗ th&ocirc;ng rắn, Polypropylene kh&ocirc;ng dệt, Tấm l&oacute;t polyester, V&aacute;n dăm, V&aacute;n sợi</p>\r\n\r\n<p><strong>Đệm ngồi:</strong></p>\r\n\r\n<p>Tấm l&oacute;t polyester, bọt polyurethane c&oacute; khả năng đ&agrave;n hồi cao (bọt lạnh) 2,2 lb / cu.ft.</p>\r\n\r\n<p><strong>Lớp l&oacute;t chống h&ocirc;i:</strong></p>\r\n\r\n<p>Tấm l&oacute;t polyester</p>\r\n\r\n<p><strong>Ch&acirc;n</strong></p>\r\n\r\n<p>Gỗ nguy&ecirc;n khối, veneer sồi, sơn m&agrave;i trong suốt</p>\r\n\r\n<p><strong>Khung, nắp kh&ocirc;ng thể th&aacute;o rời</strong><strong>Khung Ottoman</strong></p>\r\n\r\n<p>C&aacute;c vết ướt phải lu&ocirc;n được l&agrave;m kh&ocirc; c&agrave;ng sớm c&agrave;ng tốt để ngăn chặn sự x&acirc;m nhập của hơi ẩm.</p>\r\n\r\n<p>Loại bỏ bụi bằng chất tẩy xơ vải.</p>\r\n\r\n<p>C&aacute;c vết bẩn nhẹ c&oacute; thể được loại bỏ bằng một miếng bọt biển ẩm hoặc dung dịch x&agrave; ph&ograve;ng nhẹ.</p>\r\n\r\n<p>Để đảm bảo nhung duy tr&igrave; được vẻ ngo&agrave;i v&agrave; cảm gi&aacute;c, n&oacute; cần được chăm s&oacute;c thường xuy&ecirc;n theo hướng dẫn chăm s&oacute;c k&egrave;m theo sản phẩm.</p>', 2, NULL, '56', 10000000, 11000000, 12000000, 1000, 1, '2022-06-01 02:26:10', '2022-06-01 07:50:28', 55),
(57, 'Ghế Morabo Xanh', 9, 'Ấm áp và chào đón, gọn gàng và phong cách. Đệm ngồi hỗ trợ, lớp vỏ bọc mềm mại và độ ôm vừa vặn mang đến cho chiếc ghế sofa này sự cân bằng hoàn hảo giữa sự thoải mái, chức năng và vẻ ngoài của nó.', '<p style=\"text-align:start\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">C&aacute;c vết ấn c&oacute; thể xuất hiện tr&ecirc;n nhung thường biến mất trong thời gian.&nbsp;D&ugrave;ng tay miết nhẹ theo chiều cọc hoặc d&ugrave;ng b&agrave;n chải quần &aacute;o.&nbsp;Bạn cũng c&oacute; thể sử dụng m&aacute;y h&uacute;t bụi với đầu h&uacute;t mềm.</span></span></span></span></p>\r\n\r\n<p style=\"text-align:start\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">C&aacute;c sợi nhỏ c&oacute; thể xuất hiện tr&ecirc;n nhung.&nbsp;N&oacute; xảy ra một c&aacute;ch tự nhi&ecirc;n v&agrave; ch&uacute;ng biến mất theo thời gian v&agrave; cũng c&oacute; thể được loại bỏ bằng một con lăn xơ vải.</span></span></span></span></p>\r\n\r\n<div class=\"pip-expander\" style=\"padding:0px; text-align:start; width:384px\">\r\n<div class=\"pip-expander__content\" style=\"margin-bottom:24px; padding:0px\">\r\n<div style=\"padding:0px\">\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Lớp nhung phản chiếu &aacute;nh s&aacute;ng theo một c&aacute;ch đặc trưng c&oacute; thể l&agrave;m cho m&agrave;u sắc xuất hiện như thể n&oacute; thay đổi.</span></span></span></span></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<div class=\"pip-product-details__container\" style=\"margin-bottom:24px; padding:0px; text-align:left\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Khung Ottoman</span></strong></span></span></span></span>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Vải v&oacute;c:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">38% viscose / rayon, 62% polyester (tối thiểu 90% t&aacute;i chế)</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Khung ghế:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">V&aacute;n &eacute;p, Gỗ th&ocirc;ng rắn, Polypropylene kh&ocirc;ng dệt, Tấm l&oacute;t polyester, V&aacute;n dăm, V&aacute;n sợi</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Đệm ngồi:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Tấm l&oacute;t polyester, bọt polyurethane c&oacute; khả năng đ&agrave;n hồi cao (bọt lạnh) 2,2 lb / cu.ft.</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Lớp l&oacute;t chống h&ocirc;i:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Tấm l&oacute;t polyester</span></span></span></span></p>\r\n</div>\r\n</div>\r\n\r\n<div class=\"pip-product-details__container\" style=\"margin-bottom:24px; margin-top:16px; padding:0px; text-align:left\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Ch&acirc;n</span></strong></span></span></span></span>\r\n\r\n<div class=\"pip-product-details__section\" style=\"padding:0px\">\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Gỗ nguy&ecirc;n khối, veneer sồi, sơn m&agrave;i trong suốt</span></span></span></span></p>\r\n</div>\r\n</div>\r\n\r\n<div class=\"pip-product-details__container\" style=\"margin-top:16px; padding:0px; text-align:left\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Khung, nắp kh&ocirc;ng thể th&aacute;o rời</span></strong><strong><span style=\"color:#484848\">Khung Ottoman</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">C&aacute;c vết ướt phải lu&ocirc;n được l&agrave;m kh&ocirc; c&agrave;ng sớm c&agrave;ng tốt để ngăn chặn sự x&acirc;m nhập của hơi ẩm.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Loại bỏ bụi bằng chất tẩy xơ vải.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">C&aacute;c vết bẩn nhẹ c&oacute; thể được loại bỏ bằng một miếng bọt biển ẩm hoặc dung dịch x&agrave; ph&ograve;ng nhẹ.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Để đảm bảo nhung duy tr&igrave; được vẻ ngo&agrave;i v&agrave; cảm gi&aacute;c, n&oacute; cần được chăm s&oacute;c thường xuy&ecirc;n theo hướng dẫn chăm s&oacute;c k&egrave;m theo sản phẩm.</span></span></span></span></p>\r\n</div>\r\n</div>\r\n</div>\r\n</div>', 2, NULL, '57', 10000000, 11000000, 12000000, 1000, 1, '2022-06-01 02:29:57', '2022-06-01 07:49:23', 55),
(58, 'Ghế Pello', 9, 'Chỗ ngồi thoải mái trong suốt ngôi nhà mang lại cảm giác thư thái - và với ghế bành PELLO thoáng mát, bạn có thể dễ dàng tạo ra vùng thoải mái của mình ở mọi nơi. Bí quyết là hỗ trợ lưng tốt và một khung đàn hồi nhẹ!', '<p style=\"text-align:start\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Ghế b&agrave;nh PELLO c&oacute; h&igrave;nh dạng uốn cong c&oacute; thể đ&agrave;n hồi nhẹ khi bạn ngồi v&agrave; hỗ trợ lưng v&agrave; cổ thoải m&aacute;i.</span></span></span></span></p>\r\n\r\n<p style=\"text-align:start\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Một chiếc ghế b&agrave;nh nhẹ v&agrave; tho&aacute;ng m&aacute;t với thiết kế sạch sẽ ph&ugrave; hợp với mọi nơi v&agrave; gi&uacute;p bạn tạo chỗ ngồi thoải m&aacute;i trong suốt ng&ocirc;i nh&agrave;.</span></span></span></span></p>\r\n\r\n<div class=\"pip-expander\" style=\"padding:0px; text-align:start; width:367px\">\r\n<div class=\"pip-expander__content\" style=\"margin-bottom:24px; padding:0px\">\r\n<div style=\"padding:0px\">\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">M&agrave;u sắc v&agrave; vật liệu tự nhi&ecirc;n tạo n&ecirc;n sự tươi s&aacute;ng v&agrave; tươi mới cho ng&ocirc;i nh&agrave; của bạn.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">10 năm Bảo h&agrave;nh c&oacute; giới hạn.&nbsp;Đọc về c&aacute;c điều khoản trong t&agrave;i liệu bảo h&agrave;nh.</span></span></span></span></p>\r\n\r\n<div style=\"padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong>Nh&agrave; thiết kế</strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">IKEA của Thụy Điển</span></span></span></span></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<div class=\"pip-product-details__container\" style=\"margin-bottom:24px; padding:0px; text-align:left\">\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Khung tay vịn:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Bạch dương veneer, sơn m&agrave;i acrylic trong suốt</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Khung h&igrave;nh ống:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Th&eacute;p, sơn tĩnh điện Epoxy / polyester</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Vải hỗ trợ:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">100% polyetylen</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Vải v&oacute;c:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">100% chất liệu cotton</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Gối:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Tấm l&oacute;t polyester, bọt Polyurethane.</span></span></span></span></p>\r\n</div>\r\n</div>\r\n\r\n<div class=\"pip-product-details__container\" style=\"margin-bottom:24px; margin-top:16px; padding:0px; text-align:left\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Khung</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Lau sạch bằng khăn ẩm v&agrave; chất tẩy rửa nhẹ.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Lau kh&ocirc; bằng khăn sạch.</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__container\" style=\"margin-top:16px; padding:0px; text-align:left\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Gối</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Lau sạch bằng khăn thấm nước.</span></span></span></span></p>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>', 2, NULL, '58', 1000000, 1500000, 1700000, 1000, 1, '2022-06-01 02:35:00', '2022-06-01 07:52:27', 26);
INSERT INTO `product` (`ID`, `name`, `product_category`, `description`, `content_review`, `display_state`, `rate`, `slug`, `price_entry`, `price_sale`, `price_sell`, `quantity`, `status`, `created_at`, `updated_at`, `product_parent`) VALUES
(59, 'Ghế Poang', 9, 'Ghế bành POÄNG có các đường cong kiểu cách bằng gỗ uốn cong, giúp hỗ trợ tốt cho cổ và khả năng đàn hồi thoải mái. Nó đã ở trong phạm vi của chúng tôi trong vài thập kỷ và vẫn còn phổ biến. Bạn muốn thử nó ?', '<p style=\"text-align:start\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Khung gỗ uốn cong được d&aacute;n lớp mang lại cho chiếc ghế b&agrave;nh một khả năng đ&agrave;n hồi thoải m&aacute;i, khiến n&oacute; trở n&ecirc;n ho&agrave;n hảo để thư gi&atilde;n.</span></span></span></span></p>\r\n\r\n<p style=\"text-align:start\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Phần lưng cao hỗ trợ tốt cho cổ của bạn.</span></span></span></span></p>\r\n\r\n<div class=\"pip-expander\" style=\"padding:0px; text-align:start; width:367px\">\r\n<div class=\"pip-expander__content\" style=\"margin-bottom:24px; padding:0px\">\r\n<div style=\"padding:0px\">\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Mẫu m&atilde; đệm ngồi đa dạng gi&uacute;p bạn dễ d&agrave;ng thay đổi diện mạo cho chiếc ghế PO&Auml;NG v&agrave; ph&ograve;ng kh&aacute;ch của m&igrave;nh.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Để ngồi thoải m&aacute;i v&agrave; thư gi&atilde;n hơn nữa, bạn c&oacute; thể sử dụng ghế b&agrave;nh c&ugrave;ng với ghế d&agrave;i PO&Auml;NG.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Bảo h&agrave;nh 10 năm c&oacute; giới hạn.&nbsp;Đọc về c&aacute;c điều khoản trong t&agrave;i liệu giới hạn bảo h&agrave;nh.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">C&oacute; thể t&aacute;ch ra để t&aacute;i chế hoặc thu hồi năng lượng nếu c&oacute; trong cộng đồng của bạn.</span></span></span></span></p>\r\n\r\n<div style=\"padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong>Nh&agrave; thiết kế</strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Noboru Nakamura</span></span></span></span></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<div class=\"pip-product-details__container\" style=\"margin-bottom:24px; padding:0px; text-align:left\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Khung ghế b&agrave;nh</span></strong></span></span></span></span>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Vải hỗ trợ:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">100% polypropylene</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Khung:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">V&acirc;n gỗ d&aacute;n nhiều lớp, veneer bạch dương, vết bẩn, sơn m&agrave;i acrylic trong suốt</span></span></span></span></p>\r\n</div>\r\n</div>\r\n\r\n<div class=\"pip-product-details__container\" style=\"margin-bottom:24px; margin-top:16px; padding:0px; text-align:left\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Đệm ghế</span></strong></span></span></span></span>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Vải v&oacute;c:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">100% polyester (tối thiểu 90% t&aacute;i chế)</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Wadding:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">100% polyester (tối thiểu 80% t&aacute;i chế)</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"margin-bottom:16px; padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">L&agrave;m đầy thoải m&aacute;i:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Bọt polyurethane 2,0 lb / cu.ft.</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__section\" style=\"padding:0px\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Lớp l&oacute;t, mặt dưới:</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">100% polypropylene</span></span></span></span></p>\r\n</div>\r\n</div>\r\n\r\n<div class=\"pip-product-details__container\" style=\"margin-bottom:24px; margin-top:16px; padding:0px; text-align:left\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Gối</span></strong><strong><span style=\"color:#484848\">Đệm ghế</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">M&aacute;y h&uacute;t bụi.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Lau sạch bằng vải ẩm.</span></span></span></span></p>\r\n</div>\r\n\r\n<div class=\"pip-product-details__container\" style=\"margin-top:16px; padding:0px; text-align:left\"><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\"><strong><span style=\"color:#484848\">Khung</span></strong><strong><span style=\"color:#484848\">Khung ghế b&agrave;nh</span></strong></span></span></span></span>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Lau sạch bằng khăn ẩm v&agrave; chất tẩy rửa nhẹ.</span></span></span></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><span style=\"color:#484848\"><span style=\"font-family:&quot;Noto IKEA&quot;,&quot;Noto Sans&quot;,Roboto,&quot;Open Sans&quot;,-apple-system,sans-serif\"><span style=\"background-color:#ffffff\">Lau kh&ocirc; bằng khăn sạch.</span></span></span></span></p>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>', 2, NULL, '59', 2000000, 2200000, 2500000, 1000, 1, '2022-06-01 02:41:39', '2022-06-01 07:53:28', 26),
(60, 'Ghế Poang Xanh', 9, 'Ghế bành POÄNG có các đường cong kiểu cách bằng gỗ uốn cong, giúp hỗ trợ tốt cho cổ và khả năng đàn hồi thoải mái. Nó đã ở trong phạm vi của chúng tôi trong vài thập kỷ và vẫn còn phổ biến. Bạn muốn thử nó ?', '<p>Khung gỗ uốn cong được d&aacute;n lớp mang lại cho chiếc ghế b&agrave;nh một khả năng đ&agrave;n hồi thoải m&aacute;i, khiến n&oacute; trở n&ecirc;n ho&agrave;n hảo để thư gi&atilde;n.</p>\r\n\r\n<p>Phần lưng cao hỗ trợ tốt cho cổ của bạn.</p>\r\n\r\n<p>Mẫu m&atilde; đệm ngồi đa dạng gi&uacute;p bạn dễ d&agrave;ng thay đổi diện mạo cho chiếc ghế PO&Auml;NG v&agrave; ph&ograve;ng kh&aacute;ch của m&igrave;nh.</p>\r\n\r\n<p>Để ngồi thoải m&aacute;i v&agrave; thư gi&atilde;n hơn nữa, bạn c&oacute; thể sử dụng ghế b&agrave;nh c&ugrave;ng với ghế d&agrave;i PO&Auml;NG.</p>\r\n\r\n<p>Bảo h&agrave;nh 10 năm c&oacute; giới hạn.&nbsp;Đọc về c&aacute;c điều khoản trong t&agrave;i liệu giới hạn bảo h&agrave;nh.</p>\r\n\r\n<p>C&oacute; thể t&aacute;ch ra để t&aacute;i chế hoặc thu hồi năng lượng nếu c&oacute; trong cộng đồng của bạn.</p>\r\n\r\n<p><strong>Nh&agrave; thiết kế</strong></p>\r\n\r\n<p>Noboru Nakamura</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>Khung ghế b&agrave;nh</strong><strong>Vải hỗ trợ:</strong></p>\r\n\r\n<p>100% polypropylene</p>\r\n\r\n<p><strong>Khung:</strong></p>\r\n\r\n<p>V&acirc;n gỗ d&aacute;n nhiều lớp, veneer bạch dương, vết bẩn, sơn m&agrave;i acrylic trong suốt</p>\r\n\r\n<p><strong>Đệm ghế</strong><strong>Vải v&oacute;c:</strong></p>\r\n\r\n<p>100% polyester (tối thiểu 90% t&aacute;i chế)</p>\r\n\r\n<p><strong>Wadding:</strong></p>\r\n\r\n<p>100% polyester (tối thiểu 80% t&aacute;i chế)</p>\r\n\r\n<p><strong>L&agrave;m đầy thoải m&aacute;i:</strong></p>\r\n\r\n<p>Bọt polyurethane 2,0 lb / cu.ft.</p>\r\n\r\n<p><strong>Lớp l&oacute;t, mặt dưới:</strong></p>\r\n\r\n<p>100% polypropylene</p>\r\n\r\n<p><strong>Gối</strong><strong>Đệm ghế</strong></p>\r\n\r\n<p>M&aacute;y h&uacute;t bụi.</p>\r\n\r\n<p>Lau sạch bằng vải ẩm.</p>\r\n\r\n<p><strong>Khung</strong><strong>Khung ghế b&agrave;nh</strong></p>\r\n\r\n<p>Lau sạch bằng khăn ẩm v&agrave; chất tẩy rửa nhẹ.</p>\r\n\r\n<p>Lau kh&ocirc; bằng khăn sạch.</p>', 2, NULL, '60', 2000000, 22000000, 25000000, 1000, 1, '2022-06-01 02:43:32', '2022-06-01 07:53:41', 59),
(61, 'Ghế Poang Xám', 9, 'Ghế bành POÄNG có các đường cong kiểu cách bằng gỗ uốn cong, giúp hỗ trợ tốt cho cổ và khả năng đàn hồi thoải mái. Nó đã ở trong phạm vi của chúng tôi trong vài thập kỷ và vẫn còn phổ biến. Bạn muốn thử nó ?', '<p>Khung gỗ uốn cong được d&aacute;n lớp mang lại cho chiếc ghế b&agrave;nh một khả năng đ&agrave;n hồi thoải m&aacute;i, khiến n&oacute; trở n&ecirc;n ho&agrave;n hảo để thư gi&atilde;n.</p>\r\n\r\n<p>Phần lưng cao hỗ trợ tốt cho cổ của bạn.</p>\r\n\r\n<p>Mẫu m&atilde; đệm ngồi đa dạng gi&uacute;p bạn dễ d&agrave;ng thay đổi diện mạo cho chiếc ghế PO&Auml;NG v&agrave; ph&ograve;ng kh&aacute;ch của m&igrave;nh.</p>\r\n\r\n<p>Để ngồi thoải m&aacute;i v&agrave; thư gi&atilde;n hơn nữa, bạn c&oacute; thể sử dụng ghế b&agrave;nh c&ugrave;ng với ghế d&agrave;i PO&Auml;NG.</p>\r\n\r\n<p>Bảo h&agrave;nh 10 năm c&oacute; giới hạn.&nbsp;Đọc về c&aacute;c điều khoản trong t&agrave;i liệu giới hạn bảo h&agrave;nh.</p>\r\n\r\n<p>C&oacute; thể t&aacute;ch ra để t&aacute;i chế hoặc thu hồi năng lượng nếu c&oacute; trong cộng đồng của bạn.</p>\r\n\r\n<p><strong>Nh&agrave; thiết kế</strong></p>\r\n\r\n<p>Noboru Nakamura</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>Khung ghế b&agrave;nh</strong><strong>Vải hỗ trợ:</strong></p>\r\n\r\n<p>100% polypropylene</p>\r\n\r\n<p><strong>Khung:</strong></p>\r\n\r\n<p>V&acirc;n gỗ d&aacute;n nhiều lớp, veneer bạch dương, vết bẩn, sơn m&agrave;i acrylic trong suốt</p>\r\n\r\n<p><strong>Đệm ghế</strong><strong>Vải v&oacute;c:</strong></p>\r\n\r\n<p>100% polyester (tối thiểu 90% t&aacute;i chế)</p>\r\n\r\n<p><strong>Wadding:</strong></p>\r\n\r\n<p>100% polyester (tối thiểu 80% t&aacute;i chế)</p>\r\n\r\n<p><strong>L&agrave;m đầy thoải m&aacute;i:</strong></p>\r\n\r\n<p>Bọt polyurethane 2,0 lb / cu.ft.</p>\r\n\r\n<p><strong>Lớp l&oacute;t, mặt dưới:</strong></p>\r\n\r\n<p>100% polypropylene</p>\r\n\r\n<p><strong>Gối&nbsp;</strong><strong>Đệm ghế</strong></p>\r\n\r\n<p>M&aacute;y h&uacute;t bụi.</p>\r\n\r\n<p>Lau sạch bằng vải ẩm.</p>\r\n\r\n<p><strong>Khung</strong><strong>Khung ghế b&agrave;nh</strong></p>\r\n\r\n<p>Lau sạch bằng khăn ẩm v&agrave; chất tẩy rửa nhẹ.</p>\r\n\r\n<p>Lau kh&ocirc; bằng khăn sạch.</p>', 2, NULL, '61', 2000000, 2200000, 2500000, 1000, 1, '2022-06-01 02:46:01', '2022-06-01 07:53:55', 59),
(62, 'Ghê Poang Ngọc', 9, 'Ghế bành POÄNG có các đường cong kiểu cách bằng gỗ uốn cong, giúp hỗ trợ tốt cho cổ và khả năng đàn hồi thoải mái. Nó đã ở trong phạm vi của chúng tôi trong vài thập kỷ và vẫn còn phổ biến. Bạn muốn thử nó ?', '<p>Khung gỗ uốn cong được d&aacute;n lớp mang lại cho chiếc ghế b&agrave;nh một khả năng đ&agrave;n hồi thoải m&aacute;i, khiến n&oacute; trở n&ecirc;n ho&agrave;n hảo để thư gi&atilde;n.</p>\r\n\r\n<p>Phần lưng cao hỗ trợ tốt cho cổ của bạn.</p>\r\n\r\n<p>Mẫu m&atilde; đệm ngồi đa dạng gi&uacute;p bạn dễ d&agrave;ng thay đổi diện mạo cho chiếc ghế PO&Auml;NG v&agrave; ph&ograve;ng kh&aacute;ch của m&igrave;nh.</p>\r\n\r\n<p>Để ngồi thoải m&aacute;i v&agrave; thư gi&atilde;n hơn nữa, bạn c&oacute; thể sử dụng ghế b&agrave;nh c&ugrave;ng với ghế d&agrave;i PO&Auml;NG.</p>\r\n\r\n<p>Bảo h&agrave;nh 10 năm c&oacute; giới hạn.&nbsp;Đọc về c&aacute;c điều khoản trong t&agrave;i liệu giới hạn bảo h&agrave;nh.</p>\r\n\r\n<p>C&oacute; thể t&aacute;ch ra để t&aacute;i chế hoặc thu hồi năng lượng nếu c&oacute; trong cộng đồng của bạn.</p>\r\n\r\n<p><strong>Nh&agrave; thiết kế</strong></p>\r\n\r\n<p>Noboru Nakamura</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>Khung ghế b&agrave;nh</strong><strong>Vải hỗ trợ:</strong></p>\r\n\r\n<p>100% polypropylene</p>\r\n\r\n<p><strong>Khung:</strong></p>\r\n\r\n<p>V&acirc;n gỗ d&aacute;n nhiều lớp, veneer bạch dương, vết bẩn, sơn m&agrave;i acrylic trong suốt</p>\r\n\r\n<p><strong>Đệm ghế</strong><strong>Vải v&oacute;c:</strong></p>\r\n\r\n<p>100% polyester (tối thiểu 90% t&aacute;i chế)</p>\r\n\r\n<p><strong>Wadding:</strong></p>\r\n\r\n<p>100% polyester (tối thiểu 80% t&aacute;i chế)</p>\r\n\r\n<p><strong>L&agrave;m đầy thoải m&aacute;i:</strong></p>\r\n\r\n<p>Bọt polyurethane 2,0 lb / cu.ft.</p>\r\n\r\n<p><strong>Lớp l&oacute;t, mặt dưới:</strong></p>\r\n\r\n<p>100% polypropylene</p>\r\n\r\n<p><strong>Gối&nbsp;</strong><strong>Đệm ghế</strong></p>\r\n\r\n<p>M&aacute;y h&uacute;t bụi.</p>\r\n\r\n<p>Lau sạch bằng vải ẩm.</p>\r\n\r\n<p><strong>Khung</strong><strong>Khung ghế b&agrave;nh</strong></p>\r\n\r\n<p>Lau sạch bằng khăn ẩm v&agrave; chất tẩy rửa nhẹ.</p>\r\n\r\n<p>Lau kh&ocirc; bằng khăn sạch.</p>', 2, NULL, '62', 2000000, 2200000, 2500000, 1000, 1, '2022-06-01 02:48:01', '2022-06-01 07:54:09', 59),
(63, 'Ghế Poang Vàng', 9, 'Ghế bành POÄNG có các đường cong kiểu cách bằng gỗ uốn cong, giúp hỗ trợ tốt cho cổ và khả năng đàn hồi thoải mái. Nó đã ở trong phạm vi của chúng tôi trong vài thập kỷ và vẫn còn phổ biến. Bạn muốn thử nó ?', '<p>Khung gỗ uốn cong được d&aacute;n lớp mang lại cho chiếc ghế b&agrave;nh một khả năng đ&agrave;n hồi thoải m&aacute;i, khiến n&oacute; trở n&ecirc;n ho&agrave;n hảo để thư gi&atilde;n.</p>\r\n\r\n<p>Phần lưng cao hỗ trợ tốt cho cổ của bạn.</p>\r\n\r\n<p>Mẫu m&atilde; đệm ngồi đa dạng gi&uacute;p bạn dễ d&agrave;ng thay đổi diện mạo cho chiếc ghế PO&Auml;NG v&agrave; ph&ograve;ng kh&aacute;ch của m&igrave;nh.</p>\r\n\r\n<p>Để ngồi thoải m&aacute;i v&agrave; thư gi&atilde;n hơn nữa, bạn c&oacute; thể sử dụng ghế b&agrave;nh c&ugrave;ng với ghế d&agrave;i PO&Auml;NG.</p>\r\n\r\n<p>Bảo h&agrave;nh 10 năm c&oacute; giới hạn.&nbsp;Đọc về c&aacute;c điều khoản trong t&agrave;i liệu giới hạn bảo h&agrave;nh.</p>\r\n\r\n<p>C&oacute; thể t&aacute;ch ra để t&aacute;i chế hoặc thu hồi năng lượng nếu c&oacute; trong cộng đồng của bạn.</p>\r\n\r\n<p><strong>Nh&agrave; thiết kế</strong></p>\r\n\r\n<p>Noboru Nakamura</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>Khung ghế b&agrave;nh</strong><strong>Vải hỗ trợ:</strong></p>\r\n\r\n<p>100% polypropylene</p>\r\n\r\n<p><strong>Khung:</strong></p>\r\n\r\n<p>V&acirc;n gỗ d&aacute;n nhiều lớp, veneer bạch dương, vết bẩn, sơn m&agrave;i acrylic trong suốt</p>\r\n\r\n<p><strong>Đệm ghế</strong><strong>Vải v&oacute;c:</strong></p>\r\n\r\n<p>100% polyester (tối thiểu 90% t&aacute;i chế)</p>\r\n\r\n<p><strong>Wadding:</strong></p>\r\n\r\n<p>100% polyester (tối thiểu 80% t&aacute;i chế)</p>\r\n\r\n<p><strong>L&agrave;m đầy thoải m&aacute;i:</strong></p>\r\n\r\n<p>Bọt polyurethane 2,0 lb / cu.ft.</p>\r\n\r\n<p><strong>Lớp l&oacute;t, mặt dưới:</strong></p>\r\n\r\n<p>100% polypropylene</p>\r\n\r\n<p><strong>Gối&nbsp;</strong><strong>Đệm ghế</strong></p>\r\n\r\n<p>M&aacute;y h&uacute;t bụi.</p>\r\n\r\n<p>Lau sạch bằng vải ẩm.</p>\r\n\r\n<p><strong>Khung</strong><strong>Khung ghế b&agrave;nh</strong></p>\r\n\r\n<p>Lau sạch bằng khăn ẩm v&agrave; chất tẩy rửa nhẹ.</p>\r\n\r\n<p>Lau kh&ocirc; bằng khăn sạch.</p>', 2, NULL, '63', 2000000, 2200000, 2500000, 1000, 1, '2022-06-01 02:49:24', '2022-06-01 07:54:32', 59),
(64, 'Ghế Vedbo', 9, 'Các đường nét mềm mại nhưng khác biệt tạo ra một hồ sơ thanh lịch. Hoàn hảo khi bạn muốn không gian riêng của mình trong một môi trường cởi mở, nhưng vẫn giao lưu được với những người khác. Bìa màu xanh lam tăng thêm vẻ đẹp yên bình.', '<p><br />\r\nThiết kế vượt thời gian của VEDBO gi&uacute;p bạn dễ d&agrave;ng đặt trong c&aacute;c kh&ocirc;ng gian ph&ograve;ng kh&aacute;c nhau v&agrave; phối hợp với c&aacute;c đồ nội thất kh&aacute;c.</p>\r\n\r\n<p>Bảo h&agrave;nh 10 năm c&oacute; giới hạn. Đọc về c&aacute;c điều khoản trong t&agrave;i liệu giới hạn bảo h&agrave;nh.</p>\r\n\r\n<p>Ghế b&agrave;nh VEDBO l&yacute; tưởng khi bạn muốn thư gi&atilde;n trong kh&ocirc;ng gian ri&ecirc;ng của m&igrave;nh trong một m&ocirc;i trường cởi mở, nhưng vẫn muốn c&oacute; cơ hội giao lưu với những người kh&aacute;c khi bạn muốn.</p>\r\n\r\n<p>VEDBO c&oacute; 3 m&agrave;u đất kh&aacute;c nhau, t&ocirc;n th&ecirc;m vẻ đẹp cho bất kỳ căn ph&ograve;ng n&agrave;o.</p>\r\n\r\n<p>Sản phẩm n&agrave;y đ&atilde; được kiểm tra t&iacute;nh dễ ch&aacute;y v&agrave; tu&acirc;n theo ti&ecirc;u chuẩn TB-117</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nFrancis Cayouette</p>\r\n\r\n<p>Khung:<br />\r\nTh&eacute;p, 100% polyester (tối thiểu 70% t&aacute;i chế), Bọt polyurethane đ&agrave;n hồi cao (bọt lạnh)., Tấm sợi</p>\r\n\r\n<p>Đệm ngồi:<br />\r\nBọt polyurethane đ&agrave;n hồi cao (bọt lạnh).</p>\r\n\r\n<p>Ch&acirc;n:<br />\r\nBạch dương rắn, sơn m&agrave;i acrylic trong suốt</p>\r\n\r\n<p>Vải / Vải:<br />\r\n100% polyester</p>\r\n\r\n<p>Khung, nắp kh&ocirc;ng thể th&aacute;o rời<br />\r\nM&aacute;y h&uacute;t bụi.</p>\r\n\r\n<p>Lau sạch bằng vải ẩm.</p>\r\n\r\n<p>Vỏ đệm<br />\r\nKh&ocirc;ng rửa.</p>\r\n\r\n<p>Kh&ocirc;ng tẩy.</p>\r\n\r\n<p>Kh&ocirc;ng sấy kh&ocirc;.</p>\r\n\r\n<p>Kh&ocirc;ng ủi.<br />\r\n&nbsp;</p>', 2, NULL, '64', 5000000, 5800000, 6000000, 1000, 1, '2022-06-01 03:03:30', '2022-06-01 07:47:02', 26),
(65, 'Ghế Vedbo Xanh', 9, 'Các đường nét mềm mại nhưng khác biệt tạo ra một hồ sơ thanh lịch. Hoàn hảo khi bạn muốn không gian riêng của mình trong một môi trường cởi mở, nhưng vẫn giao lưu được với những người khác. Bìa màu xanh lam tăng thêm vẻ đẹp yên bình.', '<p><br />\r\nThiết kế vượt thời gian của VEDBO gi&uacute;p bạn dễ d&agrave;ng đặt trong c&aacute;c kh&ocirc;ng gian ph&ograve;ng kh&aacute;c nhau v&agrave; phối hợp với c&aacute;c đồ nội thất kh&aacute;c.</p>\r\n\r\n<p>Bảo h&agrave;nh 10 năm c&oacute; giới hạn. Đọc về c&aacute;c điều khoản trong t&agrave;i liệu giới hạn bảo h&agrave;nh.</p>\r\n\r\n<p>Ghế b&agrave;nh VEDBO l&yacute; tưởng khi bạn muốn thư gi&atilde;n trong kh&ocirc;ng gian ri&ecirc;ng của m&igrave;nh trong một m&ocirc;i trường cởi mở, nhưng vẫn muốn c&oacute; cơ hội giao lưu với những người kh&aacute;c khi bạn muốn.</p>\r\n\r\n<p>VEDBO c&oacute; 3 m&agrave;u đất kh&aacute;c nhau, t&ocirc;n th&ecirc;m vẻ đẹp cho bất kỳ căn ph&ograve;ng n&agrave;o.</p>\r\n\r\n<p>Sản phẩm n&agrave;y đ&atilde; được kiểm tra t&iacute;nh dễ ch&aacute;y v&agrave; tu&acirc;n theo ti&ecirc;u chuẩn TB-117</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nFrancis Cayouette</p>\r\n\r\n<p>Khung:<br />\r\nTh&eacute;p, 100% polyester (tối thiểu 70% t&aacute;i chế), Bọt polyurethane đ&agrave;n hồi cao (bọt lạnh)., Tấm sợi</p>\r\n\r\n<p>Đệm ngồi:<br />\r\nBọt polyurethane đ&agrave;n hồi cao (bọt lạnh).</p>\r\n\r\n<p>Ch&acirc;n:<br />\r\nBạch dương rắn, sơn m&agrave;i acrylic trong suốt</p>\r\n\r\n<p>Vải / Vải:<br />\r\n100% polyester</p>\r\n\r\n<p>Khung, nắp kh&ocirc;ng thể th&aacute;o rời<br />\r\nM&aacute;y h&uacute;t bụi.</p>\r\n\r\n<p>Lau sạch bằng vải ẩm.</p>\r\n\r\n<p>Vỏ đệm<br />\r\nKh&ocirc;ng rửa.</p>\r\n\r\n<p>Kh&ocirc;ng tẩy.</p>\r\n\r\n<p>Kh&ocirc;ng sấy kh&ocirc;.</p>\r\n\r\n<p>Kh&ocirc;ng ủi.<br />\r\n&nbsp;</p>', 2, NULL, '65', 5000000, 5800000, 6000000, 1000, 1, '2022-06-01 03:07:49', '2022-06-01 07:47:33', 64),
(66, 'Ghế Vedbo Hồng', 9, 'Các đường nét mềm mại nhưng khác biệt tạo ra một hồ sơ thanh lịch. Hoàn hảo khi bạn muốn không gian riêng của mình trong một môi trường cởi mở, nhưng vẫn giao lưu được với những người khác. Bìa màu xanh lam tăng thêm vẻ đẹp yên bình.', '<p><br />\r\nThiết kế vượt thời gian của VEDBO gi&uacute;p bạn dễ d&agrave;ng đặt trong c&aacute;c kh&ocirc;ng gian ph&ograve;ng kh&aacute;c nhau v&agrave; phối hợp với c&aacute;c đồ nội thất kh&aacute;c.</p>\r\n\r\n<p>Bảo h&agrave;nh 10 năm c&oacute; giới hạn. Đọc về c&aacute;c điều khoản trong t&agrave;i liệu giới hạn bảo h&agrave;nh.</p>\r\n\r\n<p>Ghế b&agrave;nh VEDBO l&yacute; tưởng khi bạn muốn thư gi&atilde;n trong kh&ocirc;ng gian ri&ecirc;ng của m&igrave;nh trong một m&ocirc;i trường cởi mở, nhưng vẫn muốn c&oacute; cơ hội giao lưu với những người kh&aacute;c khi bạn muốn.</p>\r\n\r\n<p>VEDBO c&oacute; 3 m&agrave;u đất kh&aacute;c nhau, t&ocirc;n th&ecirc;m vẻ đẹp cho bất kỳ căn ph&ograve;ng n&agrave;o.</p>\r\n\r\n<p>Sản phẩm n&agrave;y đ&atilde; được kiểm tra t&iacute;nh dễ ch&aacute;y v&agrave; tu&acirc;n theo ti&ecirc;u chuẩn TB-117</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nFrancis Cayouette</p>\r\n\r\n<p>Khung:<br />\r\nTh&eacute;p, 100% polyester (tối thiểu 70% t&aacute;i chế), Bọt polyurethane đ&agrave;n hồi cao (bọt lạnh)., Tấm sợi</p>\r\n\r\n<p>Đệm ngồi:<br />\r\nBọt polyurethane đ&agrave;n hồi cao (bọt lạnh).</p>\r\n\r\n<p>Ch&acirc;n:<br />\r\nBạch dương rắn, sơn m&agrave;i acrylic trong suốt</p>\r\n\r\n<p>Vải / Vải:<br />\r\n100% polyester</p>\r\n\r\n<p>Khung, nắp kh&ocirc;ng thể th&aacute;o rời<br />\r\nM&aacute;y h&uacute;t bụi.</p>\r\n\r\n<p>Lau sạch bằng vải ẩm.</p>\r\n\r\n<p>Vỏ đệm<br />\r\nKh&ocirc;ng rửa.</p>\r\n\r\n<p>Kh&ocirc;ng tẩy.</p>\r\n\r\n<p>Kh&ocirc;ng sấy kh&ocirc;.</p>\r\n\r\n<p>Kh&ocirc;ng ủi.<br />\r\n&nbsp;</p>', 2, NULL, '66', 5000000, 58000000, 6000000, 1000, 1, '2022-06-01 03:12:05', '2022-06-01 07:46:52', 64),
(67, 'Ghế Kloven', 9, 'Hãy tiếp tục và có một chỗ ngồi, thư giãn và tận hưởng - KLÖVEN được tạo ra để thư giãn. Một loạt đồ nội thất bằng gỗ bạch đàn bền cùng với đệm có thể đảo ngược làm cho cuộc sống ngoài trời vừa thoải mái vừa thiết thực.', NULL, 2, NULL, '67', 2000000, 2800000, 3000000, 1000, 1, '2022-06-01 08:12:49', '2022-06-01 08:12:49', 26),
(68, 'Sofa Applaryd', 4, 'Ghế sofa ÄPPLARYD sẽ là ốc đảo thoải mái của ngôi nhà bạn. Một cái bắt mắt phản ánh cá tính và phong cách của bạn. Tuyệt vời đểGhế sofa này có kiểu dáng dễ dàng và bên ngoài đơn giản với lớp vỏ mềm được thiết kế riêng và lò xo túi bên trong thoải mái. Đôi chân thon gọn càng làm tăng thêm vẻ thanh bình và thoáng đãng.', '<p>H&igrave;nh d&aacute;ng gọn g&agrave;ng v&agrave; c&acirc;n đối kết hợp với một c&aacute;i nh&igrave;n đầy biểu cảm l&agrave; một cơ sở ho&agrave;n hảo để l&agrave;m cho chiếc ghế sofa trở n&ecirc;n c&aacute; t&iacute;nh hơn với đệm v&agrave; n&eacute;m.</p>\r\n\r\n<p>Ch&uacute;ng t&ocirc;i đ&atilde; l&agrave;m cho ghế sofa &Auml;PPLARYD trở n&ecirc;n si&ecirc;u thoải m&aacute;i với lớp bọc mềm mại v&agrave; đệm xốp c&ugrave;ng với l&ograve; xo t&uacute;i theo cơ thể của bạn v&agrave; hỗ trợ c&aacute;c tư thế kh&aacute;c nhau - từ ngồi thẳng đến nằm v&agrave; thư gi&atilde;n.</p>\r\n\r\n<p>C&oacute; nhiều k&iacute;ch thước v&agrave; h&igrave;nh dạng kh&aacute;c nhau để ph&ugrave; hợp với cả kh&ocirc;ng gian nhỏ v&agrave; lớn.</p>\r\n\r\n<p>10 năm Bảo h&agrave;nh c&oacute; giới hạn. Đọc về c&aacute;c điều khoản trong t&agrave;i liệu bảo h&agrave;nh.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nMaja Ganszyniec ngồi, nằm xuống v&agrave; đi chơi. V&agrave; với nhiều kh&ocirc;ng gian cho cả gia đ&igrave;nh, năm n&agrave;y qua năm kh&aacute;c.</p>\r\n\r\n<p>Khung ghế:<br />\r\nGỗ veneer nhiều lớp, Gỗ rắn, V&aacute;n &eacute;p, V&aacute;n sợi, V&aacute;n dăm, Bọt polyurethane c&oacute; khả năng phục hồi cao (bọt lạnh) 2,2 lb / cu.ft.</p>\r\n\r\n<p>Đơn vị l&ograve; xo t&uacute;i:<br />\r\nTh&eacute;p</p>\r\n\r\n<p>Khung tay vịn:<br />\r\nV&aacute;n sợi, V&aacute;n &eacute;p, Bọt polyurethane 1,2 lb / cu.ft.</p>\r\n\r\n<p>Dưới khung / Ch&acirc;n:<br />\r\nTh&eacute;p, sơn tĩnh điện Epoxy / polyester</p>\r\n\r\n<p>Đệm tựa lưng:<br />\r\nBọt polyurethane 1,5 lb / cu.ft., Bọt polyurethane c&oacute; khả năng phục hồi cao (bọt lạnh) 2,2 lb / cu.ft.</p>\r\n\r\n<p>Vải v&oacute;c:<br />\r\n71% cotton, 8% viscose / rayon, 21% polyester (100% t&aacute;i chế)</p>\r\n\r\n<p>Nắp c&oacute; thể th&aacute;o rời<br />\r\nKh&ocirc;ng rửa. Kh&ocirc;ng tẩy. Kh&ocirc;ng sấy kh&ocirc;. Kh&ocirc;ng ủi. Kh&ocirc;ng giặt kh&ocirc;.</p>', 2, NULL, '68', 24000000, 25000000, 25500000, 1000, 1, '2022-06-02 00:27:22', '2022-06-02 00:27:41', 26),
(69, 'Sofa Applaryd Xanh', 4, 'Ghế sofa ÄPPLARYD sẽ là ốc đảo thoải mái của ngôi nhà bạn. Một cái bắt mắt phản ánh cá tính và phong cách của bạn. Tuyệt vời đểGhế sofa này có kiểu dáng dễ dàng và bên ngoài đơn giản với lớp vỏ mềm được thiết kế riêng và lò xo túi bên trong thoải mái. Đôi chân thon gọn càng làm tăng thêm vẻ thanh bình và thoáng đãng.', '<p>H&igrave;nh d&aacute;ng gọn g&agrave;ng v&agrave; c&acirc;n đối kết hợp với một c&aacute;i nh&igrave;n đầy biểu cảm l&agrave; một cơ sở ho&agrave;n hảo để l&agrave;m cho chiếc ghế sofa trở n&ecirc;n c&aacute; t&iacute;nh hơn với đệm v&agrave; n&eacute;m.</p>\r\n\r\n<p>Ch&uacute;ng t&ocirc;i đ&atilde; l&agrave;m cho ghế sofa &Auml;PPLARYD trở n&ecirc;n si&ecirc;u thoải m&aacute;i với lớp bọc mềm mại v&agrave; đệm xốp c&ugrave;ng với l&ograve; xo t&uacute;i theo cơ thể của bạn v&agrave; hỗ trợ c&aacute;c tư thế kh&aacute;c nhau - từ ngồi thẳng đến nằm v&agrave; thư gi&atilde;n.</p>\r\n\r\n<p>C&oacute; nhiều k&iacute;ch thước v&agrave; h&igrave;nh dạng kh&aacute;c nhau để ph&ugrave; hợp với cả kh&ocirc;ng gian nhỏ v&agrave; lớn.</p>\r\n\r\n<p>10 năm Bảo h&agrave;nh c&oacute; giới hạn. Đọc về c&aacute;c điều khoản trong t&agrave;i liệu bảo h&agrave;nh.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nMaja Ganszyniec ngồi, nằm xuống v&agrave; đi chơi. V&agrave; với nhiều kh&ocirc;ng gian cho cả gia đ&igrave;nh, năm n&agrave;y qua năm kh&aacute;c.</p>\r\n\r\n<p>Khung ghế:<br />\r\nGỗ veneer nhiều lớp, Gỗ rắn, V&aacute;n &eacute;p, V&aacute;n sợi, V&aacute;n dăm, Bọt polyurethane c&oacute; khả năng phục hồi cao (bọt lạnh) 2,2 lb / cu.ft.</p>\r\n\r\n<p>Đơn vị l&ograve; xo t&uacute;i:<br />\r\nTh&eacute;p</p>\r\n\r\n<p>Khung tay vịn:<br />\r\nV&aacute;n sợi, V&aacute;n &eacute;p, Bọt polyurethane 1,2 lb / cu.ft.</p>\r\n\r\n<p>Dưới khung / Ch&acirc;n:<br />\r\nTh&eacute;p, sơn tĩnh điện Epoxy / polyester</p>\r\n\r\n<p>Đệm tựa lưng:<br />\r\nBọt polyurethane 1,5 lb / cu.ft., Bọt polyurethane c&oacute; khả năng phục hồi cao (bọt lạnh) 2,2 lb / cu.ft.</p>\r\n\r\n<p>Vải v&oacute;c:<br />\r\n71% cotton, 8% viscose / rayon, 21% polyester (100% t&aacute;i chế)</p>\r\n\r\n<p>Nắp c&oacute; thể th&aacute;o rời<br />\r\nKh&ocirc;ng rửa. Kh&ocirc;ng tẩy. Kh&ocirc;ng sấy kh&ocirc;. Kh&ocirc;ng ủi. Kh&ocirc;ng giặt kh&ocirc;.</p>', 2, NULL, '69', 24000000, 25000000, 25500000, 1000, 1, '2022-06-02 00:29:19', '2022-06-02 00:30:44', 26),
(70, 'Sofa Applaryd Đỏ', 4, 'Ghế sofa ÄPPLARYD sẽ là ốc đảo thoải mái của ngôi nhà bạn. Một cái bắt mắt phản ánh cá tính và phong cách của bạn. Tuyệt vời đểGhế sofa này có kiểu dáng dễ dàng và bên ngoài đơn giản với lớp vỏ mềm được thiết kế riêng và lò xo túi bên trong thoải mái. Đôi chân thon gọn càng làm tăng thêm vẻ thanh bình và thoáng đãng.', '<p>H&igrave;nh d&aacute;ng gọn g&agrave;ng v&agrave; c&acirc;n đối kết hợp với một c&aacute;i nh&igrave;n đầy biểu cảm l&agrave; một cơ sở ho&agrave;n hảo để l&agrave;m cho chiếc ghế sofa trở n&ecirc;n c&aacute; t&iacute;nh hơn với đệm v&agrave; n&eacute;m.</p>\r\n\r\n<p>Ch&uacute;ng t&ocirc;i đ&atilde; l&agrave;m cho ghế sofa &Auml;PPLARYD trở n&ecirc;n si&ecirc;u thoải m&aacute;i với lớp bọc mềm mại v&agrave; đệm xốp c&ugrave;ng với l&ograve; xo t&uacute;i theo cơ thể của bạn v&agrave; hỗ trợ c&aacute;c tư thế kh&aacute;c nhau - từ ngồi thẳng đến nằm v&agrave; thư gi&atilde;n.</p>\r\n\r\n<p>C&oacute; nhiều k&iacute;ch thước v&agrave; h&igrave;nh dạng kh&aacute;c nhau để ph&ugrave; hợp với cả kh&ocirc;ng gian nhỏ v&agrave; lớn.</p>\r\n\r\n<p>10 năm Bảo h&agrave;nh c&oacute; giới hạn. Đọc về c&aacute;c điều khoản trong t&agrave;i liệu bảo h&agrave;nh.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nMaja Ganszyniec ngồi, nằm xuống v&agrave; đi chơi. V&agrave; với nhiều kh&ocirc;ng gian cho cả gia đ&igrave;nh, năm n&agrave;y qua năm kh&aacute;c.</p>\r\n\r\n<p>Khung ghế:<br />\r\nGỗ veneer nhiều lớp, Gỗ rắn, V&aacute;n &eacute;p, V&aacute;n sợi, V&aacute;n dăm, Bọt polyurethane c&oacute; khả năng phục hồi cao (bọt lạnh) 2,2 lb / cu.ft.</p>\r\n\r\n<p>Đơn vị l&ograve; xo t&uacute;i:<br />\r\nTh&eacute;p</p>\r\n\r\n<p>Khung tay vịn:<br />\r\nV&aacute;n sợi, V&aacute;n &eacute;p, Bọt polyurethane 1,2 lb / cu.ft.</p>\r\n\r\n<p>Dưới khung / Ch&acirc;n:<br />\r\nTh&eacute;p, sơn tĩnh điện Epoxy / polyester</p>\r\n\r\n<p>Đệm tựa lưng:<br />\r\nBọt polyurethane 1,5 lb / cu.ft., Bọt polyurethane c&oacute; khả năng phục hồi cao (bọt lạnh) 2,2 lb / cu.ft.</p>\r\n\r\n<p>Vải v&oacute;c:<br />\r\n71% cotton, 8% viscose / rayon, 21% polyester (100% t&aacute;i chế)</p>\r\n\r\n<p>Nắp c&oacute; thể th&aacute;o rời<br />\r\nKh&ocirc;ng rửa. Kh&ocirc;ng tẩy. Kh&ocirc;ng sấy kh&ocirc;. Kh&ocirc;ng ủi. Kh&ocirc;ng giặt kh&ocirc;.</p>', 2, NULL, '70', 24000000, 25000000, 25500000, 1000, 1, '2022-06-02 00:30:29', '2022-06-02 00:30:54', 26),
(71, 'Sofa Kivik', 4, 'Đắm mình trong sự thoải mái êm ái của ghế sofa KIVIK. Kích thước rộng rãi, tay vịn thấp và lò xo túi có bọt thích ứng với cơ thể mời bạn và khách của bạn đến với nhiều giờ giao lưu và thư giãn.\r\n\r\nHãy tận hưởng chiếc ghế sofa KIVIK siêu thoải mái với đệm ngồi sâu làm bằng lò xo túi, bọt có khả năng đàn hồi cao và sợi polyester - vừa hỗ trợ vững chắc vừa tạo sự mềm mại thư giãn.', '<p>K&iacute;ch thước v&agrave; chiều s&acirc;u của ghế sofa l&agrave; sự lựa chọn ho&agrave;n hảo cho một giấc ngủ ngắn hay khi cả gia đ&igrave;nh qu&acirc;y quần b&ecirc;n nhau. C&oacute; chỗ cho tất cả mọi người v&agrave; thậm ch&iacute; c&oacute; th&ecirc;m chỗ ngồi tr&ecirc;n tay vịn rộng r&atilde;i.</p>\r\n\r\n<p>Tay vịn rộng c&oacute; đủ chỗ cho mọi thứ, từ điện thoại di động đến b&aacute;t đồ ăn nhẹ xem phim v&agrave; rất thoải m&aacute;i để ngả đầu khi bạn nằm tr&ecirc;n ghế sofa để nghỉ ngơi.</p>\r\n\r\n<p>KIVIK sofa c&oacute; c&aacute; t&iacute;nh mạnh mẽ v&agrave; ng&ocirc;n ngữ thiết kế r&otilde; r&agrave;ng, trong khi c&aacute;c t&ugrave;y chọn c&oacute; nghĩa l&agrave; bạn c&oacute; thể dễ d&agrave;ng kết hợp n&oacute; với trang tr&iacute; nh&agrave; của m&igrave;nh.</p>\r\n\r\n<p>C&oacute; thể dễ d&agrave;ng kết hợp sofa với một hoặc nhiều ghế d&agrave;i nhờ tay vịn c&oacute; thể th&aacute;o rời.</p>\r\n\r\n<p>L&ograve; xo t&uacute;i l&agrave; một giải ph&aacute;p l&acirc;u bền gi&uacute;p ghế sofa giữ được h&igrave;nh dạng v&agrave; sự thoải m&aacute;i trong nhiều năm.</p>\r\n\r\n<p>B&igrave;a n&agrave;y được l&agrave;m bằng Tibbleby, một loại vải polyester nhuộm dope mềm với độ b&oacute;ng nhẹ v&agrave; họa tiết xương c&aacute; k&iacute;n đ&aacute;o.</p>\r\n\r\n<p>Nắp dễ d&agrave;ng giữ sạch v&igrave; n&oacute; c&oacute; thể được giặt bằng m&aacute;y v&agrave; dễ d&agrave;ng th&aacute;o ra v&agrave; đeo lại.</p>\r\n\r\n<p>Bảo h&agrave;nh 10 năm. Đọc về c&aacute;c điều khoản trong t&agrave;i liệu đảm bảo.</p>\r\n\r\n<p>Khung sofa<br />\r\nLớp l&oacute;t chống h&ocirc;i / Lớp l&oacute;t chống h&ocirc;i:<br />\r\nTấm l&oacute;t polyester</p>\r\n\r\n<p>Khung lưng v&agrave; ghế:<br />\r\nV&aacute;n sợi, V&aacute;n &eacute;p, Gỗ rắn, V&aacute;n dăm</p>\r\n\r\n<p>Khung tay vịn:<br />\r\nV&aacute;n sợi, Gỗ rắn, V&aacute;n &eacute;p, V&aacute;n dăm</p>\r\n\r\n<p>Đệm ngồi:<br />\r\nBọt polyurethane c&oacute; khả năng đ&agrave;n hồi cao (bọt lạnh) 2,2 lb / cu.ft., Bọt polyurethane 2,0 lb / cu.ft., L&oacute;t nỉ</p>\r\n\r\n<p>Đơn vị l&ograve; xo t&uacute;i:<br />\r\nTh&eacute;p</p>\r\n\r\n<p>Đệm sau:<br />\r\nB&oacute;ng sợi polyester</p>\r\n\r\n<p>Bọc ghế sofa<br />\r\nVải v&oacute;c:<br />\r\n100% polyester (tối thiểu 90% t&aacute;i chế)</p>\r\n\r\n<p>Vải sau:<br />\r\n100% polyester (100% t&aacute;i chế)</p>', 2, NULL, '71', 16000000, 17500000, 18000000, 1000, 1, '2022-06-02 00:41:17', '2022-06-02 00:45:44', 26),
(72, 'Sofa Kivik Xanh', 4, 'Đắm mình trong sự thoải mái êm ái của ghế sofa KIVIK. Kích thước rộng rãi, tay vịn thấp và lò xo túi có bọt thích ứng với cơ thể mời bạn và khách của bạn đến với nhiều giờ giao lưu và thư giãn.\r\n\r\nHãy tận hưởng chiếc ghế sofa KIVIK siêu thoải mái với đệm ngồi sâu làm bằng lò xo túi, bọt có khả năng đàn hồi cao và sợi polyester - vừa hỗ trợ vững chắc vừa tạo sự mềm mại thư giãn.', '<p>K&iacute;ch thước v&agrave; chiều s&acirc;u của ghế sofa l&agrave; sự lựa chọn ho&agrave;n hảo cho một giấc ngủ ngắn hay khi cả gia đ&igrave;nh qu&acirc;y quần b&ecirc;n nhau. C&oacute; chỗ cho tất cả mọi người v&agrave; thậm ch&iacute; c&oacute; th&ecirc;m chỗ ngồi tr&ecirc;n tay vịn rộng r&atilde;i.</p>\r\n\r\n<p>Tay vịn rộng c&oacute; đủ chỗ cho mọi thứ, từ điện thoại di động đến b&aacute;t đồ ăn nhẹ xem phim v&agrave; rất thoải m&aacute;i để ngả đầu khi bạn nằm tr&ecirc;n ghế sofa để nghỉ ngơi.</p>\r\n\r\n<p>KIVIK sofa c&oacute; c&aacute; t&iacute;nh mạnh mẽ v&agrave; ng&ocirc;n ngữ thiết kế r&otilde; r&agrave;ng, trong khi c&aacute;c t&ugrave;y chọn c&oacute; nghĩa l&agrave; bạn c&oacute; thể dễ d&agrave;ng kết hợp n&oacute; với trang tr&iacute; nh&agrave; của m&igrave;nh.</p>\r\n\r\n<p>C&oacute; thể dễ d&agrave;ng kết hợp sofa với một hoặc nhiều ghế d&agrave;i nhờ tay vịn c&oacute; thể th&aacute;o rời.</p>\r\n\r\n<p>L&ograve; xo t&uacute;i l&agrave; một giải ph&aacute;p l&acirc;u bền gi&uacute;p ghế sofa giữ được h&igrave;nh dạng v&agrave; sự thoải m&aacute;i trong nhiều năm.</p>\r\n\r\n<p>B&igrave;a n&agrave;y được l&agrave;m bằng Tibbleby, một loại vải polyester nhuộm dope mềm với độ b&oacute;ng nhẹ v&agrave; họa tiết xương c&aacute; k&iacute;n đ&aacute;o.</p>\r\n\r\n<p>Nắp dễ d&agrave;ng giữ sạch v&igrave; n&oacute; c&oacute; thể được giặt bằng m&aacute;y v&agrave; dễ d&agrave;ng th&aacute;o ra v&agrave; đeo lại.</p>\r\n\r\n<p>Bảo h&agrave;nh 10 năm. Đọc về c&aacute;c điều khoản trong t&agrave;i liệu đảm bảo.</p>\r\n\r\n<p>Khung sofa<br />\r\nLớp l&oacute;t chống h&ocirc;i / Lớp l&oacute;t chống h&ocirc;i:<br />\r\nTấm l&oacute;t polyester</p>\r\n\r\n<p>Khung lưng v&agrave; ghế:<br />\r\nV&aacute;n sợi, V&aacute;n &eacute;p, Gỗ rắn, V&aacute;n dăm</p>\r\n\r\n<p>Khung tay vịn:<br />\r\nV&aacute;n sợi, Gỗ rắn, V&aacute;n &eacute;p, V&aacute;n dăm</p>\r\n\r\n<p>Đệm ngồi:<br />\r\nBọt polyurethane c&oacute; khả năng đ&agrave;n hồi cao (bọt lạnh) 2,2 lb / cu.ft., Bọt polyurethane 2,0 lb / cu.ft., L&oacute;t nỉ</p>\r\n\r\n<p>Đơn vị l&ograve; xo t&uacute;i:<br />\r\nTh&eacute;p</p>\r\n\r\n<p>Đệm sau:<br />\r\nB&oacute;ng sợi polyester</p>\r\n\r\n<p>Bọc ghế sofa<br />\r\nVải v&oacute;c:<br />\r\n100% polyester (tối thiểu 90% t&aacute;i chế)</p>\r\n\r\n<p>Vải sau:<br />\r\n100% polyester (100% t&aacute;i chế)</p>', 2, NULL, '72', 16000000, 17500000, 18000000, 1000, 1, '2022-06-02 00:43:57', '2022-06-02 00:46:10', 26),
(73, 'Sofa Kivik Đen', 4, 'Đắm mình trong sự thoải mái êm ái của ghế sofa KIVIK. Kích thước rộng rãi, tay vịn thấp và lò xo túi có bọt thích ứng với cơ thể mời bạn và khách của bạn đến với nhiều giờ giao lưu và thư giãn.\r\n\r\nHãy tận hưởng chiếc ghế sofa KIVIK siêu thoải mái với đệm ngồi sâu làm bằng lò xo túi, bọt có khả năng đàn hồi cao và sợi polyester - vừa hỗ trợ vững chắc vừa tạo sự mềm mại thư giãn.', '<p>K&iacute;ch thước v&agrave; chiều s&acirc;u của ghế sofa l&agrave; sự lựa chọn ho&agrave;n hảo cho một giấc ngủ ngắn hay khi cả gia đ&igrave;nh qu&acirc;y quần b&ecirc;n nhau. C&oacute; chỗ cho tất cả mọi người v&agrave; thậm ch&iacute; c&oacute; th&ecirc;m chỗ ngồi tr&ecirc;n tay vịn rộng r&atilde;i.</p>\r\n\r\n<p>Tay vịn rộng c&oacute; đủ chỗ cho mọi thứ, từ điện thoại di động đến b&aacute;t đồ ăn nhẹ xem phim v&agrave; rất thoải m&aacute;i để ngả đầu khi bạn nằm tr&ecirc;n ghế sofa để nghỉ ngơi.</p>\r\n\r\n<p>KIVIK sofa c&oacute; c&aacute; t&iacute;nh mạnh mẽ v&agrave; ng&ocirc;n ngữ thiết kế r&otilde; r&agrave;ng, trong khi c&aacute;c t&ugrave;y chọn c&oacute; nghĩa l&agrave; bạn c&oacute; thể dễ d&agrave;ng kết hợp n&oacute; với trang tr&iacute; nh&agrave; của m&igrave;nh.</p>\r\n\r\n<p>C&oacute; thể dễ d&agrave;ng kết hợp sofa với một hoặc nhiều ghế d&agrave;i nhờ tay vịn c&oacute; thể th&aacute;o rời.</p>\r\n\r\n<p>L&ograve; xo t&uacute;i l&agrave; một giải ph&aacute;p l&acirc;u bền gi&uacute;p ghế sofa giữ được h&igrave;nh dạng v&agrave; sự thoải m&aacute;i trong nhiều năm.</p>\r\n\r\n<p>B&igrave;a n&agrave;y được l&agrave;m bằng Tibbleby, một loại vải polyester nhuộm dope mềm với độ b&oacute;ng nhẹ v&agrave; họa tiết xương c&aacute; k&iacute;n đ&aacute;o.</p>\r\n\r\n<p>Nắp dễ d&agrave;ng giữ sạch v&igrave; n&oacute; c&oacute; thể được giặt bằng m&aacute;y v&agrave; dễ d&agrave;ng th&aacute;o ra v&agrave; đeo lại.</p>\r\n\r\n<p>Bảo h&agrave;nh 10 năm. Đọc về c&aacute;c điều khoản trong t&agrave;i liệu đảm bảo.</p>\r\n\r\n<p>Khung sofa<br />\r\nLớp l&oacute;t chống h&ocirc;i / Lớp l&oacute;t chống h&ocirc;i:<br />\r\nTấm l&oacute;t polyester</p>\r\n\r\n<p>Khung lưng v&agrave; ghế:<br />\r\nV&aacute;n sợi, V&aacute;n &eacute;p, Gỗ rắn, V&aacute;n dăm</p>\r\n\r\n<p>Khung tay vịn:<br />\r\nV&aacute;n sợi, Gỗ rắn, V&aacute;n &eacute;p, V&aacute;n dăm</p>\r\n\r\n<p>Đệm ngồi:<br />\r\nBọt polyurethane c&oacute; khả năng đ&agrave;n hồi cao (bọt lạnh) 2,2 lb / cu.ft., Bọt polyurethane 2,0 lb / cu.ft., L&oacute;t nỉ</p>\r\n\r\n<p>Đơn vị l&ograve; xo t&uacute;i:<br />\r\nTh&eacute;p</p>\r\n\r\n<p>Đệm sau:<br />\r\nB&oacute;ng sợi polyester</p>\r\n\r\n<p>Bọc ghế sofa<br />\r\nVải v&oacute;c:<br />\r\n100% polyester (tối thiểu 90% t&aacute;i chế)</p>\r\n\r\n<p>Vải sau:<br />\r\n100% polyester (100% t&aacute;i chế)</p>', 2, NULL, '73', 16000000, 17500000, 18000000, 1000, 1, '2022-06-02 00:45:29', '2022-06-02 00:46:20', 26),
(74, 'Sofa Lidhult', 4, 'Một giấc ngủ ngắn xứng đáng vào ban ngày và thư giãn tuyệt vời bên gia đình và bạn bè vào buổi tối. Ghế sofa LIDHULT được thiết kế để tạo sự thoải mái tối đa với phần tựa lưng và cổ cao. Ôm ấp, mời gọi và hào phóng', '<p>Bạn ngồi thoải m&aacute;i nhờ l&ograve; xo t&uacute;i n&acirc;ng đỡ đ&uacute;ng vị tr&iacute; v&agrave; ch&iacute;nh x&aacute;c theo cơ thể. Ghế sofa tạo cảm gi&aacute;c mềm mại v&agrave; ấm c&uacute;ng hơn khi ngồi nhờ lớp sợi b&oacute;ng tr&ecirc;n c&ugrave;ng. Phần hỗ trợ lưng v&agrave; cổ cao gi&uacute;p tăng sự thoải m&aacute;i.</p>\r\n\r\n<p>Tay ghế c&oacute; th&ecirc;m h&igrave;nh quả tr&aacute;m được thiết kế để bạn c&oacute; thể tựa lưng hay tựa đầu thoải m&aacute;i khi nằm.</p>\r\n\r\n<p>Kh&ocirc;ng gian lưu trữ dưới ghế d&agrave;i. Nắp vẫn mở để bạn c&oacute; thể lấy đồ v&agrave;o v&agrave; lấy ra một c&aacute;ch an to&agrave;n v&agrave; dễ d&agrave;ng.</p>\r\n\r\n<p>B&igrave;a bằng vải cotton v&agrave; polyester được nhuộm c&aacute;c t&ocirc;ng m&agrave;u kh&aacute;c nhau, tạo hiệu ứng đẹp mắt. Chất lượng dệt chắc chắn v&agrave; bền mang lại cho sợi vải một kết cấu r&otilde; r&agrave;ng.</p>\r\n\r\n<p>Vỏ dễ d&agrave;ng giữ sạch v&igrave; c&oacute; thể th&aacute;o rời v&agrave; c&oacute; thể giặt bằng m&aacute;y.</p>\r\n\r\n<p>Bảo h&agrave;nh 10 năm c&oacute; giới hạn. Đọc về c&aacute;c điều khoản trong t&agrave;i liệu giới hạn bảo h&agrave;nh.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nHenrik Preutz</p>\r\n\r\n<p>Lớp l&oacute;t chống h&ocirc;i / Lớp l&oacute;t chống h&ocirc;i:<br />\r\nTấm l&oacute;t polyester</p>\r\n\r\n<p>L&ograve; xo zig-zag / Bộ l&ograve; xo t&uacute;i / C&aacute;c bộ phận kim loại:<br />\r\nTh&eacute;p</p>\r\n\r\n<p>C&aacute;i gối:<br />\r\nB&oacute;ng sợi polyester</p>\r\n\r\n<p>Đệm sau:<br />\r\nBọt polyurethane đ&agrave;n hồi cao (bọt lạnh), bọt Polyurethane 2,0 lb / cu.ft., Polypropylene kh&ocirc;ng dệt, tấm l&oacute;t Polyester, Quả b&oacute;ng sợi Polyester</p>\r\n\r\n<p>Đệm ngồi:<br />\r\nBọt polyurethane c&oacute; khả năng đ&agrave;n hồi cao (bọt lạnh) 2,2 lb / cu.ft., Polypropylene kh&ocirc;ng dệt, Tấm l&oacute;t polyester, Lớp l&oacute;t nỉ, Quả b&oacute;ng bằng sợi Polyester</p>\r\n\r\n<p>Khung:<br />\r\nGỗ rắn, V&aacute;n dăm, V&aacute;n &eacute;p, Bọt polyurethane 1,2 lb / cu.ft., Tấm l&oacute;t polyester, Polypropylene kh&ocirc;ng dệt, Polypropylene kh&ocirc;ng dệt, V&aacute;n sợi</p>\r\n\r\n<p>Ph&ugrave; hợp:<br />\r\nPolypropylene</p>\r\n\r\n<p>Chaise phần khung<br />\r\nLớp l&oacute;t chống h&ocirc;i / Lớp l&oacute;t chống h&ocirc;i:<br />\r\nTấm l&oacute;t polyester</p>\r\n\r\n<p>L&ograve; xo zig-zag / Bộ l&ograve; xo t&uacute;i:<br />\r\nTh&eacute;p</p>\r\n\r\n<p>C&aacute;i gối:<br />\r\nB&oacute;ng sợi polyester</p>\r\n\r\n<p>Đệm sau:<br />\r\nBọt polyurethane đ&agrave;n hồi cao (bọt lạnh), bọt Polyurethane 2,0 lb / cu.ft., Polypropylene kh&ocirc;ng dệt, tấm l&oacute;t Polyester, Quả b&oacute;ng sợi Polyester</p>\r\n\r\n<p>Khung:<br />\r\nGỗ đặc, V&aacute;n &eacute;p, V&aacute;n dăm, Tấm l&oacute;t polyester, Polypropylen kh&ocirc;ng dệt, V&aacute;n sợi, Bọt Polyurethane 1,2 lb / cu.ft., C&aacute;n melamine &aacute;p suất cao</p>\r\n\r\n<p>Bộ phận kim loại:<br />\r\nTh&eacute;p, sơn tĩnh điện Epoxy / polyester, mạ kẽm</p>\r\n\r\n<p>Đệm ngồi:<br />\r\nBọt polyurethane c&oacute; khả năng đ&agrave;n hồi cao (bọt lạnh) 2,2 lb / cu.ft., Polypropylene kh&ocirc;ng dệt, Tấm l&oacute;t polyester, Lớp l&oacute;t nỉ, Quả b&oacute;ng bằng sợi Polyester</p>\r\n\r\n<p>Khung tay vịn<br />\r\nLớp l&oacute;t chống h&ocirc;i / Lớp l&oacute;t chống h&ocirc;i:<br />\r\nTấm l&oacute;t polyester</p>\r\n\r\n<p>Khung:<br />\r\nGỗ rắn, V&aacute;n &eacute;p, V&aacute;n dăm, Tấm l&oacute;t polyester, Giấy chưa tẩy trắng, V&aacute;n sợi.</p>\r\n\r\n<p>Nắp cho phần ghế sofa / bọc cho phần ghế d&agrave;i<br />\r\nVải v&oacute;c:<br />\r\n71% cotton, 8% viscose / rayon, 21% polyester</p>\r\n\r\n<p>Vải sau:<br />\r\n100% polyester (100% t&aacute;i chế)</p>\r\n\r\n<p>Nắp cho tay vịn<br />\r\n71% cotton, 8% viscose / rayon, 21% polyester</p>\r\n\r\n<p>Trải raNắp cho phần ghế sofa / bọc cho phần ghế d&agrave;i / bọc cho tay vịn<br />\r\nM&aacute;y giặt ấm, chu kỳ b&igrave;nh thường.<br />\r\nKh&ocirc;ng tẩy. Kh&ocirc;ng sấy kh&ocirc;. Sắt thấp. Kh&ocirc;ng giặt kh&ocirc;.</p>', 2, NULL, '74', 30000000, 31000000, 32000000, 1000, 1, '2022-06-02 00:55:51', '2022-06-02 00:58:58', 26);
INSERT INTO `product` (`ID`, `name`, `product_category`, `description`, `content_review`, `display_state`, `rate`, `slug`, `price_entry`, `price_sale`, `price_sell`, `quantity`, `status`, `created_at`, `updated_at`, `product_parent`) VALUES
(75, 'Sofa Lidhult Ghi', 4, 'Một giấc ngủ ngắn xứng đáng vào ban ngày và thư giãn tuyệt vời bên gia đình và bạn bè vào buổi tối. Ghế sofa LIDHULT được thiết kế để tạo sự thoải mái tối đa với phần tựa lưng và cổ cao. Ôm ấp, mời gọi và hào phóng', '<p>Bạn ngồi thoải m&aacute;i nhờ l&ograve; xo t&uacute;i n&acirc;ng đỡ đ&uacute;ng vị tr&iacute; v&agrave; ch&iacute;nh x&aacute;c theo cơ thể. Ghế sofa tạo cảm gi&aacute;c mềm mại v&agrave; ấm c&uacute;ng hơn khi ngồi nhờ lớp sợi b&oacute;ng tr&ecirc;n c&ugrave;ng. Phần hỗ trợ lưng v&agrave; cổ cao gi&uacute;p tăng sự thoải m&aacute;i.</p>\r\n\r\n<p>Tay ghế c&oacute; th&ecirc;m h&igrave;nh quả tr&aacute;m được thiết kế để bạn c&oacute; thể tựa lưng hay tựa đầu thoải m&aacute;i khi nằm.</p>\r\n\r\n<p>Kh&ocirc;ng gian lưu trữ dưới ghế d&agrave;i. Nắp vẫn mở để bạn c&oacute; thể lấy đồ v&agrave;o v&agrave; lấy ra một c&aacute;ch an to&agrave;n v&agrave; dễ d&agrave;ng.</p>\r\n\r\n<p>B&igrave;a bằng vải cotton v&agrave; polyester được nhuộm c&aacute;c t&ocirc;ng m&agrave;u kh&aacute;c nhau, tạo hiệu ứng đẹp mắt. Chất lượng dệt chắc chắn v&agrave; bền mang lại cho sợi vải một kết cấu r&otilde; r&agrave;ng.</p>\r\n\r\n<p>Vỏ dễ d&agrave;ng giữ sạch v&igrave; c&oacute; thể th&aacute;o rời v&agrave; c&oacute; thể giặt bằng m&aacute;y.</p>\r\n\r\n<p>Bảo h&agrave;nh 10 năm c&oacute; giới hạn. Đọc về c&aacute;c điều khoản trong t&agrave;i liệu giới hạn bảo h&agrave;nh.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nHenrik Preutz</p>\r\n\r\n<p>Lớp l&oacute;t chống h&ocirc;i / Lớp l&oacute;t chống h&ocirc;i:<br />\r\nTấm l&oacute;t polyester</p>\r\n\r\n<p>L&ograve; xo zig-zag / Bộ l&ograve; xo t&uacute;i / C&aacute;c bộ phận kim loại:<br />\r\nTh&eacute;p</p>\r\n\r\n<p>C&aacute;i gối:<br />\r\nB&oacute;ng sợi polyester</p>\r\n\r\n<p>Đệm sau:<br />\r\nBọt polyurethane đ&agrave;n hồi cao (bọt lạnh), bọt Polyurethane 2,0 lb / cu.ft., Polypropylene kh&ocirc;ng dệt, tấm l&oacute;t Polyester, Quả b&oacute;ng sợi Polyester</p>\r\n\r\n<p>Đệm ngồi:<br />\r\nBọt polyurethane c&oacute; khả năng đ&agrave;n hồi cao (bọt lạnh) 2,2 lb / cu.ft., Polypropylene kh&ocirc;ng dệt, Tấm l&oacute;t polyester, Lớp l&oacute;t nỉ, Quả b&oacute;ng bằng sợi Polyester</p>\r\n\r\n<p>Khung:<br />\r\nGỗ rắn, V&aacute;n dăm, V&aacute;n &eacute;p, Bọt polyurethane 1,2 lb / cu.ft., Tấm l&oacute;t polyester, Polypropylene kh&ocirc;ng dệt, Polypropylene kh&ocirc;ng dệt, V&aacute;n sợi</p>\r\n\r\n<p>Ph&ugrave; hợp:<br />\r\nPolypropylene</p>\r\n\r\n<p>Chaise phần khung<br />\r\nLớp l&oacute;t chống h&ocirc;i / Lớp l&oacute;t chống h&ocirc;i:<br />\r\nTấm l&oacute;t polyester</p>\r\n\r\n<p>L&ograve; xo zig-zag / Bộ l&ograve; xo t&uacute;i:<br />\r\nTh&eacute;p</p>\r\n\r\n<p>C&aacute;i gối:<br />\r\nB&oacute;ng sợi polyester</p>\r\n\r\n<p>Đệm sau:<br />\r\nBọt polyurethane đ&agrave;n hồi cao (bọt lạnh), bọt Polyurethane 2,0 lb / cu.ft., Polypropylene kh&ocirc;ng dệt, tấm l&oacute;t Polyester, Quả b&oacute;ng sợi Polyester</p>\r\n\r\n<p>Khung:<br />\r\nGỗ đặc, V&aacute;n &eacute;p, V&aacute;n dăm, Tấm l&oacute;t polyester, Polypropylen kh&ocirc;ng dệt, V&aacute;n sợi, Bọt Polyurethane 1,2 lb / cu.ft., C&aacute;n melamine &aacute;p suất cao</p>\r\n\r\n<p>Bộ phận kim loại:<br />\r\nTh&eacute;p, sơn tĩnh điện Epoxy / polyester, mạ kẽm</p>\r\n\r\n<p>Đệm ngồi:<br />\r\nBọt polyurethane c&oacute; khả năng đ&agrave;n hồi cao (bọt lạnh) 2,2 lb / cu.ft., Polypropylene kh&ocirc;ng dệt, Tấm l&oacute;t polyester, Lớp l&oacute;t nỉ, Quả b&oacute;ng bằng sợi Polyester</p>\r\n\r\n<p>Khung tay vịn<br />\r\nLớp l&oacute;t chống h&ocirc;i / Lớp l&oacute;t chống h&ocirc;i:<br />\r\nTấm l&oacute;t polyester</p>\r\n\r\n<p>Khung:<br />\r\nGỗ rắn, V&aacute;n &eacute;p, V&aacute;n dăm, Tấm l&oacute;t polyester, Giấy chưa tẩy trắng, V&aacute;n sợi.</p>\r\n\r\n<p>Nắp cho phần ghế sofa / bọc cho phần ghế d&agrave;i<br />\r\nVải v&oacute;c:<br />\r\n71% cotton, 8% viscose / rayon, 21% polyester</p>\r\n\r\n<p>Vải sau:<br />\r\n100% polyester (100% t&aacute;i chế)</p>\r\n\r\n<p>Nắp cho tay vịn<br />\r\n71% cotton, 8% viscose / rayon, 21% polyester</p>\r\n\r\n<p>Trải raNắp cho phần ghế sofa / bọc cho phần ghế d&agrave;i / bọc cho tay vịn<br />\r\nM&aacute;y giặt ấm, chu kỳ b&igrave;nh thường.<br />\r\nKh&ocirc;ng tẩy. Kh&ocirc;ng sấy kh&ocirc;. Sắt thấp. Kh&ocirc;ng giặt kh&ocirc;.</p>', 2, NULL, '75', 30000000, 31000000, 32000000, 1000, 1, '2022-06-02 00:57:17', '2022-06-02 00:59:08', 26),
(76, 'Sofa Lidhult Đỏ', 4, 'Một giấc ngủ ngắn xứng đáng vào ban ngày và thư giãn tuyệt vời bên gia đình và bạn bè vào buổi tối. Ghế sofa LIDHULT được thiết kế để tạo sự thoải mái tối đa với phần tựa lưng và cổ cao. Ôm ấp, mời gọi và hào phóng', '<p>Bạn ngồi thoải m&aacute;i nhờ l&ograve; xo t&uacute;i n&acirc;ng đỡ đ&uacute;ng vị tr&iacute; v&agrave; ch&iacute;nh x&aacute;c theo cơ thể. Ghế sofa tạo cảm gi&aacute;c mềm mại v&agrave; ấm c&uacute;ng hơn khi ngồi nhờ lớp sợi b&oacute;ng tr&ecirc;n c&ugrave;ng. Phần hỗ trợ lưng v&agrave; cổ cao gi&uacute;p tăng sự thoải m&aacute;i.</p>\r\n\r\n<p>Tay ghế c&oacute; th&ecirc;m h&igrave;nh quả tr&aacute;m được thiết kế để bạn c&oacute; thể tựa lưng hay tựa đầu thoải m&aacute;i khi nằm.</p>\r\n\r\n<p>Kh&ocirc;ng gian lưu trữ dưới ghế d&agrave;i. Nắp vẫn mở để bạn c&oacute; thể lấy đồ v&agrave;o v&agrave; lấy ra một c&aacute;ch an to&agrave;n v&agrave; dễ d&agrave;ng.</p>\r\n\r\n<p>B&igrave;a bằng vải cotton v&agrave; polyester được nhuộm c&aacute;c t&ocirc;ng m&agrave;u kh&aacute;c nhau, tạo hiệu ứng đẹp mắt. Chất lượng dệt chắc chắn v&agrave; bền mang lại cho sợi vải một kết cấu r&otilde; r&agrave;ng.</p>\r\n\r\n<p>Vỏ dễ d&agrave;ng giữ sạch v&igrave; c&oacute; thể th&aacute;o rời v&agrave; c&oacute; thể giặt bằng m&aacute;y.</p>\r\n\r\n<p>Bảo h&agrave;nh 10 năm c&oacute; giới hạn. Đọc về c&aacute;c điều khoản trong t&agrave;i liệu giới hạn bảo h&agrave;nh.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nHenrik Preutz</p>\r\n\r\n<p>Lớp l&oacute;t chống h&ocirc;i / Lớp l&oacute;t chống h&ocirc;i:<br />\r\nTấm l&oacute;t polyester</p>\r\n\r\n<p>L&ograve; xo zig-zag / Bộ l&ograve; xo t&uacute;i / C&aacute;c bộ phận kim loại:<br />\r\nTh&eacute;p</p>\r\n\r\n<p>C&aacute;i gối:<br />\r\nB&oacute;ng sợi polyester</p>\r\n\r\n<p>Đệm sau:<br />\r\nBọt polyurethane đ&agrave;n hồi cao (bọt lạnh), bọt Polyurethane 2,0 lb / cu.ft., Polypropylene kh&ocirc;ng dệt, tấm l&oacute;t Polyester, Quả b&oacute;ng sợi Polyester</p>\r\n\r\n<p>Đệm ngồi:<br />\r\nBọt polyurethane c&oacute; khả năng đ&agrave;n hồi cao (bọt lạnh) 2,2 lb / cu.ft., Polypropylene kh&ocirc;ng dệt, Tấm l&oacute;t polyester, Lớp l&oacute;t nỉ, Quả b&oacute;ng bằng sợi Polyester</p>\r\n\r\n<p>Khung:<br />\r\nGỗ rắn, V&aacute;n dăm, V&aacute;n &eacute;p, Bọt polyurethane 1,2 lb / cu.ft., Tấm l&oacute;t polyester, Polypropylene kh&ocirc;ng dệt, Polypropylene kh&ocirc;ng dệt, V&aacute;n sợi</p>\r\n\r\n<p>Ph&ugrave; hợp:<br />\r\nPolypropylene</p>\r\n\r\n<p>Chaise phần khung<br />\r\nLớp l&oacute;t chống h&ocirc;i / Lớp l&oacute;t chống h&ocirc;i:<br />\r\nTấm l&oacute;t polyester</p>\r\n\r\n<p>L&ograve; xo zig-zag / Bộ l&ograve; xo t&uacute;i:<br />\r\nTh&eacute;p</p>\r\n\r\n<p>C&aacute;i gối:<br />\r\nB&oacute;ng sợi polyester</p>\r\n\r\n<p>Đệm sau:<br />\r\nBọt polyurethane đ&agrave;n hồi cao (bọt lạnh), bọt Polyurethane 2,0 lb / cu.ft., Polypropylene kh&ocirc;ng dệt, tấm l&oacute;t Polyester, Quả b&oacute;ng sợi Polyester</p>\r\n\r\n<p>Khung:<br />\r\nGỗ đặc, V&aacute;n &eacute;p, V&aacute;n dăm, Tấm l&oacute;t polyester, Polypropylen kh&ocirc;ng dệt, V&aacute;n sợi, Bọt Polyurethane 1,2 lb / cu.ft., C&aacute;n melamine &aacute;p suất cao</p>\r\n\r\n<p>Bộ phận kim loại:<br />\r\nTh&eacute;p, sơn tĩnh điện Epoxy / polyester, mạ kẽm</p>\r\n\r\n<p>Đệm ngồi:<br />\r\nBọt polyurethane c&oacute; khả năng đ&agrave;n hồi cao (bọt lạnh) 2,2 lb / cu.ft., Polypropylene kh&ocirc;ng dệt, Tấm l&oacute;t polyester, Lớp l&oacute;t nỉ, Quả b&oacute;ng bằng sợi Polyester</p>\r\n\r\n<p>Khung tay vịn<br />\r\nLớp l&oacute;t chống h&ocirc;i / Lớp l&oacute;t chống h&ocirc;i:<br />\r\nTấm l&oacute;t polyester</p>\r\n\r\n<p>Khung:<br />\r\nGỗ rắn, V&aacute;n &eacute;p, V&aacute;n dăm, Tấm l&oacute;t polyester, Giấy chưa tẩy trắng, V&aacute;n sợi.</p>\r\n\r\n<p>Nắp cho phần ghế sofa / bọc cho phần ghế d&agrave;i<br />\r\nVải v&oacute;c:<br />\r\n71% cotton, 8% viscose / rayon, 21% polyester</p>\r\n\r\n<p>Vải sau:<br />\r\n100% polyester (100% t&aacute;i chế)</p>\r\n\r\n<p>Nắp cho tay vịn<br />\r\n71% cotton, 8% viscose / rayon, 21% polyester</p>\r\n\r\n<p>Trải raNắp cho phần ghế sofa / bọc cho phần ghế d&agrave;i / bọc cho tay vịn<br />\r\nM&aacute;y giặt ấm, chu kỳ b&igrave;nh thường.<br />\r\nKh&ocirc;ng tẩy. Kh&ocirc;ng sấy kh&ocirc;. Sắt thấp. Kh&ocirc;ng giặt kh&ocirc;.</p>', 2, NULL, '76', 30000000, 31000000, 32000000, 1000, 1, '2022-06-02 00:58:39', '2022-06-02 00:59:17', 26),
(77, 'Sofa Vallentuna', 9, 'Một chiếc ghế sofa, rất nhiều khả năng. Bạn cần giường phụ, kho lưu trữ thông minh hoặc một góc đọc sách thoải mái? Không vấn đề gì. Chỉ cần chọn những mảnh bạn thích, kết hợp chúng theo ý muốn - và thay đổi khi bạn cảm thấy thích.', '<p>Tất cả c&aacute;c m&ocirc;-đun trong d&ograve;ng VALLENTUNA c&oacute; thể được sử dụng ri&ecirc;ng hoặc kết hợp với nhau để tạo ra một tổ hợp ghế sofa ở bất kỳ k&iacute;ch thước n&agrave;o ho&agrave;n to&agrave;n ph&ugrave; hợp với bạn.</p>\r\n\r\n<p>VALLENTUNA vẫn giữ được sự thoải m&aacute;i trong thời gian d&agrave;i với chỗ ngồi rộng r&atilde;i v&agrave; l&ograve; xo t&uacute;i &ocirc;m s&aacute;t cơ thể bạn.</p>\r\n\r\n<p>Sự kết hợp n&agrave;y bao gồm 3 m&ocirc;-đun chỗ ngồi với ngăn chứa cho ph&eacute;p bạn nhanh ch&oacute;ng dọn đồ đạc của m&igrave;nh nhưng vẫn c&oacute; ch&uacute;ng trong tầm tay.</p>\r\n\r\n<p>Nắp cố định MURUM được l&agrave;m bằng polyester với bề mặt polyurethane bảo vệ l&agrave;m cho n&oacute; vừa mềm mại vừa chắc chắn, đồng thời nắp rất bền v&agrave; dễ chăm s&oacute;c.</p>\r\n\r\n<p>Vỏ bọc dễ giữ sạch v&igrave; c&oacute; thể lau sạch bằng khăn ẩm.</p>\r\n\r\n<p>Bảo h&agrave;nh 10 năm c&oacute; giới hạn. Đọc về c&aacute;c điều khoản trong t&agrave;i liệu giới hạn bảo h&agrave;nh.</p>\r\n\r\n<p>5 đệm lưng được bao gồm.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nEhl&eacute;n Johansson</p>\r\n\r\n<p>Phần ghế ngồi<br />\r\nVải bọc:<br />\r\n100% polyester, 100% polyurethane</p>\r\n\r\n<p>Khung:<br />\r\nGỗ rắn, V&aacute;n &eacute;p, V&aacute;n dăm, Bọt polyurethane 2.0 lb / cu.ft.</p>\r\n\r\n<p>Đệm ngồi:<br />\r\nBọt polyurethane 2,0 lb / cu.ft., Bọt polyurethane c&oacute; khả năng đ&agrave;n hồi cao (bọt lạnh) 2,2 lb / cu.ft., L&oacute;t nỉ, tấm l&oacute;t polyester</p>\r\n\r\n<p>Trải ra:<br />\r\n60% polyester, 40% polyurethane</p>\r\n\r\n<p>Che phủ, c&aacute;c bề mặt kh&aacute;c:<br />\r\nPolyester kh&ocirc;ng dệt, tấm l&oacute;t Polyester</p>\r\n\r\n<p>Đơn vị l&ograve; xo t&uacute;i:<br />\r\nTh&eacute;p</p>\r\n\r\n<p>Phần ghế lưu trữ<br />\r\nVải bọc:<br />\r\n100% polyester, 100% polyurethane</p>\r\n\r\n<p>Khung:<br />\r\nGỗ rắn, V&aacute;n dăm, V&aacute;n sợi, V&aacute;n &eacute;p, Bọt polyurethane 2.0 lb / cu.ft., Laminate melamine &aacute;p lực cao, Sơn acrylic</p>\r\n\r\n<p>Đệm ngồi:<br />\r\nV&aacute;n dăm, Bọt polyurethane 2,0 lb / cu.ft., Bọt polyurethane c&oacute; khả năng phục hồi cao (bọt lạnh) 2,2 lb / cu.ft., Tấm l&oacute;t polyester, Lớp l&oacute;t nỉ</p>\r\n\r\n<p>Đơn vị l&ograve; xo t&uacute;i:<br />\r\nTh&eacute;p</p>\r\n\r\n<p>Tựa lưng / tay vịn<br />\r\nVải bọc:<br />\r\n100% polyester, 100% polyurethane</p>\r\n\r\n<p>Khung:<br />\r\nGỗ rắn, V&aacute;n &eacute;p, V&aacute;n sợi, V&aacute;n dăm, Bọt polyurethane 2.0 lb / cu.ft., Tấm l&oacute;t polyester</p>\r\n\r\n<p>Đệm sau<br />\r\nLớp l&oacute;t chống h&ocirc;i:<br />\r\nTấm l&oacute;t polyester</p>\r\n\r\n<p>Vải bọc:<br />\r\n100% polyester, 100% polyurethane</p>\r\n\r\n<p>Gối:<br />\r\nPolyester wadding, Polyester sợi b&oacute;ng</p>\r\n\r\n<p>Che phủ, c&aacute;c bề mặt kh&aacute;c:<br />\r\nPolypropylene kh&ocirc;ng dệt</p>\r\n\r\n<p>Nắp kh&ocirc;ng thể th&aacute;o rời<br />\r\nSofa g&oacute;c m&ocirc;-đun, 3 chỗ ngồi<br />\r\nKh&ocirc;ng rửa. Kh&ocirc;ng tẩy. Kh&ocirc;ng sấy kh&ocirc;. Kh&ocirc;ng ủi. Kh&ocirc;ng giặt kh&ocirc;.</p>\r\n\r\n<p>C&aacute;c vết bẩn nhẹ c&oacute; thể được loại bỏ bằng một miếng bọt biển ẩm hoặc dung dịch x&agrave; ph&ograve;ng nhẹ.</p>\r\n\r\n<p>Tr&aacute;nh &aacute;nh nắng trực tiếp để tr&aacute;nh bị kh&ocirc;.</p>', 2, NULL, '77', 43000000, 44000000, 45000000, 1000, 1, '2022-06-02 01:04:41', '2022-06-02 01:04:55', 26),
(78, 'Sofa Friheten', 4, 'Sau một đêm ngon giấc, bạn có thể dễ dàng chuyển đổi phòng ngủ hoặc phòng khách của mình thành phòng khách. Kho lưu trữ tích hợp dễ tiếp cận và đủ rộng rãi để lưu trữ bộ đồ giường, sách và PJ.', '<p>Dễ d&agrave;ng chuyển đổi th&agrave;nh giường ngủ.</p>\r\n\r\n<p>Kh&ocirc;ng gian chứa đồ thực dụng lớn dưới y&ecirc;n xe.</p>\r\n\r\n<p>10 năm Bảo h&agrave;nh c&oacute; giới hạn. Đọc về c&aacute;c điều khoản trong t&agrave;i liệu bảo h&agrave;nh.</p>\r\n\r\n<p>3 đệm lưng được bao gồm.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nIKEA của Thụy Điển</p>\r\n\r\n<p>Khung:<br />\r\nV&aacute;n &eacute;p, Bọt polyurethane 2.0 lb / cu.ft., Tấm l&oacute;t polyester, V&aacute;n dăm, Gỗ rắn</p>\r\n\r\n<p>Hộp giường:<br />\r\nV&aacute;n &eacute;p, V&aacute;n dăm, Sơn</p>\r\n\r\n<p>Đệm sau:<br />\r\nB&oacute;ng sợi polyester</p>\r\n\r\n<p>Vải v&oacute;c:<br />\r\n100% polyester</p>\r\n\r\n<p>Gối<br />\r\nKh&ocirc;ng rửa. Kh&ocirc;ng tẩy. Kh&ocirc;ng sấy kh&ocirc;. Kh&ocirc;ng ủi. Kh&ocirc;ng giặt kh&ocirc;.</p>\r\n\r\n<p>Khung<br />\r\nM&aacute;y h&uacute;t bụi.</p>\r\n\r\n<p>Lau sạch bằng vải ẩm.</p>', 2, NULL, '78', 17000000, 19000000, 20000000, 1000, 1, '2022-06-02 01:12:47', '2022-06-02 01:18:31', 26),
(79, 'Sofa Friheten Đen', 4, 'Sau một đêm ngon giấc, bạn có thể dễ dàng chuyển đổi phòng ngủ hoặc phòng khách của mình thành phòng khách. Kho lưu trữ tích hợp dễ tiếp cận và đủ rộng rãi để lưu trữ bộ đồ giường, sách và PJ.', '<p>Dễ d&agrave;ng chuyển đổi th&agrave;nh giường ngủ.</p>\r\n\r\n<p>Kh&ocirc;ng gian chứa đồ thực dụng lớn dưới y&ecirc;n xe.</p>\r\n\r\n<p>10 năm Bảo h&agrave;nh c&oacute; giới hạn. Đọc về c&aacute;c điều khoản trong t&agrave;i liệu bảo h&agrave;nh.</p>\r\n\r\n<p>3 đệm lưng được bao gồm.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nIKEA của Thụy Điển</p>\r\n\r\n<p>Khung:<br />\r\nV&aacute;n &eacute;p, Bọt polyurethane 2.0 lb / cu.ft., Tấm l&oacute;t polyester, V&aacute;n dăm, Gỗ rắn</p>\r\n\r\n<p>Hộp giường:<br />\r\nV&aacute;n &eacute;p, V&aacute;n dăm, Sơn</p>\r\n\r\n<p>Đệm sau:<br />\r\nB&oacute;ng sợi polyester</p>\r\n\r\n<p>Vải v&oacute;c:<br />\r\n100% polyester</p>\r\n\r\n<p>Gối<br />\r\nKh&ocirc;ng rửa. Kh&ocirc;ng tẩy. Kh&ocirc;ng sấy kh&ocirc;. Kh&ocirc;ng ủi. Kh&ocirc;ng giặt kh&ocirc;.</p>\r\n\r\n<p>Khung<br />\r\nM&aacute;y h&uacute;t bụi.</p>\r\n\r\n<p>Lau sạch bằng vải ẩm.</p>', 2, NULL, '79', 17000000, 19000000, 20000000, 1000, 1, '2022-06-02 01:14:26', '2022-06-02 01:18:41', 78),
(80, 'Sofa Friheten Ghi', 4, 'Sau một đêm ngon giấc, bạn có thể dễ dàng chuyển đổi phòng ngủ hoặc phòng khách của mình thành phòng khách. Kho lưu trữ tích hợp dễ tiếp cận và đủ rộng rãi để lưu trữ bộ đồ giường, sách và PJ.', '<p>Dễ d&agrave;ng chuyển đổi th&agrave;nh giường ngủ.</p>\r\n\r\n<p>Kh&ocirc;ng gian chứa đồ thực dụng lớn dưới y&ecirc;n xe.</p>\r\n\r\n<p>10 năm Bảo h&agrave;nh c&oacute; giới hạn. Đọc về c&aacute;c điều khoản trong t&agrave;i liệu bảo h&agrave;nh.</p>\r\n\r\n<p>3 đệm lưng được bao gồm.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nIKEA của Thụy Điển</p>\r\n\r\n<p>Khung:<br />\r\nV&aacute;n &eacute;p, Bọt polyurethane 2.0 lb / cu.ft., Tấm l&oacute;t polyester, V&aacute;n dăm, Gỗ rắn</p>\r\n\r\n<p>Hộp giường:<br />\r\nV&aacute;n &eacute;p, V&aacute;n dăm, Sơn</p>\r\n\r\n<p>Đệm sau:<br />\r\nB&oacute;ng sợi polyester</p>\r\n\r\n<p>Vải v&oacute;c:<br />\r\n100% polyester</p>\r\n\r\n<p>Gối<br />\r\nKh&ocirc;ng rửa. Kh&ocirc;ng tẩy. Kh&ocirc;ng sấy kh&ocirc;. Kh&ocirc;ng ủi. Kh&ocirc;ng giặt kh&ocirc;.</p>\r\n\r\n<p>Khung<br />\r\nM&aacute;y h&uacute;t bụi.</p>\r\n\r\n<p>Lau sạch bằng vải ẩm.</p>', 2, NULL, '80', 17000000, 19000000, 20000000, 1000, 1, '2022-06-02 01:16:19', '2022-06-02 01:18:51', 78),
(81, 'Sofa Friheten Xanh', 4, 'Sau một đêm ngon giấc, bạn có thể dễ dàng chuyển đổi phòng ngủ hoặc phòng khách của mình thành phòng khách. Kho lưu trữ tích hợp dễ tiếp cận và đủ rộng rãi để lưu trữ bộ đồ giường, sách và PJ.', '<p>Dễ d&agrave;ng chuyển đổi th&agrave;nh giường ngủ.</p>\r\n\r\n<p>Kh&ocirc;ng gian chứa đồ thực dụng lớn dưới y&ecirc;n xe.</p>\r\n\r\n<p>10 năm Bảo h&agrave;nh c&oacute; giới hạn. Đọc về c&aacute;c điều khoản trong t&agrave;i liệu bảo h&agrave;nh.</p>\r\n\r\n<p>3 đệm lưng được bao gồm.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nIKEA của Thụy Điển</p>\r\n\r\n<p>Khung:<br />\r\nV&aacute;n &eacute;p, Bọt polyurethane 2.0 lb / cu.ft., Tấm l&oacute;t polyester, V&aacute;n dăm, Gỗ rắn</p>\r\n\r\n<p>Hộp giường:<br />\r\nV&aacute;n &eacute;p, V&aacute;n dăm, Sơn</p>\r\n\r\n<p>Đệm sau:<br />\r\nB&oacute;ng sợi polyester</p>\r\n\r\n<p>Vải v&oacute;c:<br />\r\n100% polyester</p>\r\n\r\n<p>Gối<br />\r\nKh&ocirc;ng rửa. Kh&ocirc;ng tẩy. Kh&ocirc;ng sấy kh&ocirc;. Kh&ocirc;ng ủi. Kh&ocirc;ng giặt kh&ocirc;.</p>\r\n\r\n<p>Khung<br />\r\nM&aacute;y h&uacute;t bụi.</p>\r\n\r\n<p>Lau sạch bằng vải ẩm.</p>', 2, NULL, '81', 17000000, 19000000, 20000000, 1000, 1, '2022-06-02 01:18:16', '2022-06-02 01:18:58', 78),
(82, 'Sofa Holmsund', 4, 'Chiếc ghế sofa này nhanh chóng và dễ dàng biến thành một chiếc giường rộng rãi - và biến phòng khách thành phòng ngủ. Không gian lưu trữ dưới ghế ngồi dễ lấy và có chỗ cho bộ đồ giường, gối và một cuốn sách hay.', '<p>B&igrave;a l&agrave;m bằng polyester si&ecirc;u bền với kết cấu d&agrave;y đặc.</p>\r\n\r\n<p>Kh&ocirc;ng gian chứa đồ dưới y&ecirc;n xe.</p>\r\n\r\n<p>Bạn c&oacute; thể điều chỉnh g&oacute;c của đệm lưng lỏng lẻo theo bất kỳ c&aacute;ch n&agrave;o bạn muốn, v&agrave; điều chỉnh độ s&acirc;u của ghế v&agrave; hỗ trợ lưng cho ph&ugrave; hợp với nhu cầu của bạn.</p>\r\n\r\n<p>Nắp dễ d&agrave;ng giữ sạch v&igrave; c&oacute; thể th&aacute;o rời v&agrave; c&oacute; thể giặt bằng m&aacute;y.</p>\r\n\r\n<p>Ghế sofa n&agrave;y chuyển đổi th&agrave;nh một chiếc giường rộng r&atilde;i thực sự nhanh ch&oacute;ng v&agrave; dễ d&agrave;ng, khi bạn k&eacute;o khung dưới l&ecirc;n v&agrave; gấp phần tựa lưng xuống</p>\r\n\r\n<p>10 năm Bảo h&agrave;nh c&oacute; giới hạn. Đọc về c&aacute;c điều khoản trong t&agrave;i liệu bảo h&agrave;nh.</p>\r\n\r\n<p>Chiều s&acirc;u v&agrave; tổng chiều cao của ghế phụ thuộc v&agrave;o c&aacute;ch bạn đặt c&aacute;c đệm lưng lỏng lẻo.</p>\r\n\r\n<p>5 đệm lưng được bao gồm.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nK Hagberg / M Hagberg</p>\r\n\r\n<p>Khung sofa ngủ<br />\r\nKhung:<br />\r\nGỗ rắn, V&aacute;n dăm, V&aacute;n &eacute;p, Bọt polyurethane 2.0 lb / cu.ft., L&oacute;t nỉ</p>\r\n\r\n<p>Hộp giường:<br />\r\nV&aacute;n &eacute;p, V&aacute;n dăm, Sơn, Viền nhựa</p>\r\n\r\n<p>Đệm sau:<br />\r\nB&oacute;ng sợi polyester</p>\r\n\r\n<p>Lớp l&oacute;t chống h&ocirc;i / Lớp l&oacute;t chống h&ocirc;i:<br />\r\nTấm l&oacute;t polyester</p>\r\n\r\n<p>Bọc cho giường sofa<br />\r\n100% polyester</p>\r\n\r\n<p>Nắp c&oacute; thể th&aacute;o rời<br />\r\nBọc cho giường sofa<br />\r\nM&aacute;y giặt ấm, chu kỳ b&igrave;nh thường.</p>', 2, NULL, '82', 22000000, 24000000, 25000000, 1000, 1, '2022-06-02 01:26:00', '2022-06-02 01:31:45', 26),
(83, 'Sofa Holmsund Trắng', 4, 'Chiếc ghế sofa này nhanh chóng và dễ dàng biến thành một chiếc giường rộng rãi - và biến phòng khách thành phòng ngủ. Không gian lưu trữ dưới ghế ngồi dễ lấy và có chỗ cho bộ đồ giường, gối và một cuốn sách hay.', '<p>B&igrave;a l&agrave;m bằng polyester si&ecirc;u bền với kết cấu d&agrave;y đặc.</p>\r\n\r\n<p>Kh&ocirc;ng gian chứa đồ dưới y&ecirc;n xe.</p>\r\n\r\n<p>Bạn c&oacute; thể điều chỉnh g&oacute;c của đệm lưng lỏng lẻo theo bất kỳ c&aacute;ch n&agrave;o bạn muốn, v&agrave; điều chỉnh độ s&acirc;u của ghế v&agrave; hỗ trợ lưng cho ph&ugrave; hợp với nhu cầu của bạn.</p>\r\n\r\n<p>Nắp dễ d&agrave;ng giữ sạch v&igrave; c&oacute; thể th&aacute;o rời v&agrave; c&oacute; thể giặt bằng m&aacute;y.</p>\r\n\r\n<p>Ghế sofa n&agrave;y chuyển đổi th&agrave;nh một chiếc giường rộng r&atilde;i thực sự nhanh ch&oacute;ng v&agrave; dễ d&agrave;ng, khi bạn k&eacute;o khung dưới l&ecirc;n v&agrave; gấp phần tựa lưng xuống</p>\r\n\r\n<p>10 năm Bảo h&agrave;nh c&oacute; giới hạn. Đọc về c&aacute;c điều khoản trong t&agrave;i liệu bảo h&agrave;nh.</p>\r\n\r\n<p>Chiều s&acirc;u v&agrave; tổng chiều cao của ghế phụ thuộc v&agrave;o c&aacute;ch bạn đặt c&aacute;c đệm lưng lỏng lẻo.</p>\r\n\r\n<p>5 đệm lưng được bao gồm.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nK Hagberg / M Hagberg</p>\r\n\r\n<p>Khung sofa ngủ<br />\r\nKhung:<br />\r\nGỗ rắn, V&aacute;n dăm, V&aacute;n &eacute;p, Bọt polyurethane 2.0 lb / cu.ft., L&oacute;t nỉ</p>\r\n\r\n<p>Hộp giường:<br />\r\nV&aacute;n &eacute;p, V&aacute;n dăm, Sơn, Viền nhựa</p>\r\n\r\n<p>Đệm sau:<br />\r\nB&oacute;ng sợi polyester</p>\r\n\r\n<p>Lớp l&oacute;t chống h&ocirc;i / Lớp l&oacute;t chống h&ocirc;i:<br />\r\nTấm l&oacute;t polyester</p>\r\n\r\n<p>Bọc cho giường sofa<br />\r\n100% polyester</p>\r\n\r\n<p>Nắp c&oacute; thể th&aacute;o rời<br />\r\nBọc cho giường sofa<br />\r\nM&aacute;y giặt ấm, chu kỳ b&igrave;nh thường.</p>', 2, NULL, '83', 22000000, 24000000, 25000000, 1000, 1, '2022-06-02 01:27:46', '2022-06-02 01:31:54', 82),
(84, 'Sofa Holmsund Ghi', 4, 'Chiếc ghế sofa này nhanh chóng và dễ dàng biến thành một chiếc giường rộng rãi - và biến phòng khách thành phòng ngủ. Không gian lưu trữ dưới ghế ngồi dễ lấy và có chỗ cho bộ đồ giường, gối và một cuốn sách hay.', '<p>B&igrave;a l&agrave;m bằng polyester si&ecirc;u bền với kết cấu d&agrave;y đặc.</p>\r\n\r\n<p>Kh&ocirc;ng gian chứa đồ dưới y&ecirc;n xe.</p>\r\n\r\n<p>Bạn c&oacute; thể điều chỉnh g&oacute;c của đệm lưng lỏng lẻo theo bất kỳ c&aacute;ch n&agrave;o bạn muốn, v&agrave; điều chỉnh độ s&acirc;u của ghế v&agrave; hỗ trợ lưng cho ph&ugrave; hợp với nhu cầu của bạn.</p>\r\n\r\n<p>Nắp dễ d&agrave;ng giữ sạch v&igrave; c&oacute; thể th&aacute;o rời v&agrave; c&oacute; thể giặt bằng m&aacute;y.</p>\r\n\r\n<p>Ghế sofa n&agrave;y chuyển đổi th&agrave;nh một chiếc giường rộng r&atilde;i thực sự nhanh ch&oacute;ng v&agrave; dễ d&agrave;ng, khi bạn k&eacute;o khung dưới l&ecirc;n v&agrave; gấp phần tựa lưng xuống</p>\r\n\r\n<p>10 năm Bảo h&agrave;nh c&oacute; giới hạn. Đọc về c&aacute;c điều khoản trong t&agrave;i liệu bảo h&agrave;nh.</p>\r\n\r\n<p>Chiều s&acirc;u v&agrave; tổng chiều cao của ghế phụ thuộc v&agrave;o c&aacute;ch bạn đặt c&aacute;c đệm lưng lỏng lẻo.</p>\r\n\r\n<p>5 đệm lưng được bao gồm.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nK Hagberg / M Hagberg</p>\r\n\r\n<p>Khung sofa ngủ<br />\r\nKhung:<br />\r\nGỗ rắn, V&aacute;n dăm, V&aacute;n &eacute;p, Bọt polyurethane 2.0 lb / cu.ft., L&oacute;t nỉ</p>\r\n\r\n<p>Hộp giường:<br />\r\nV&aacute;n &eacute;p, V&aacute;n dăm, Sơn, Viền nhựa</p>\r\n\r\n<p>Đệm sau:<br />\r\nB&oacute;ng sợi polyester</p>\r\n\r\n<p>Lớp l&oacute;t chống h&ocirc;i / Lớp l&oacute;t chống h&ocirc;i:<br />\r\nTấm l&oacute;t polyester</p>\r\n\r\n<p>Bọc cho giường sofa<br />\r\n100% polyester</p>\r\n\r\n<p>Nắp c&oacute; thể th&aacute;o rời<br />\r\nBọc cho giường sofa<br />\r\nM&aacute;y giặt ấm, chu kỳ b&igrave;nh thường.</p>', 2, NULL, '84', 22000000, 24000000, 25000000, 1000, 1, '2022-06-02 01:29:33', '2022-06-02 01:32:01', 82),
(85, 'Sofa Soderhamn', 4, 'Nếu bạn thích cách nó trông, bạn phải thử nó! Ghế sâu, đệm lưng có thể di chuyển và vải treo làm cho chỗ ngồi này rất thoải mái. Tạo sự kết hợp của riêng bạn, ngồi lại và thư giãn.', '<p>D&ograve;ng ghế ngồi S&Ouml;DERHAMN cho ph&eacute;p bạn ngồi s&acirc;u, thấp v&agrave; mềm mại với đệm lưng rời để hỗ trợ th&ecirc;m.</p>\r\n\r\n<p>Bạn c&oacute; thể ngồi thoải m&aacute;i với độ đ&agrave;n hồi nhẹ, dễ chịu nhờ lớp dệt đ&agrave;n hồi ở ph&iacute;a dưới v&agrave; lớp m&uacute;t c&oacute; khả năng đ&agrave;n hồi cao ở đệm ngồi.</p>\r\n\r\n<p>Tất cả c&aacute;c phần trong loạt ghế sofa S&Ouml;DERHAMN c&oacute; thể được sử dụng ri&ecirc;ng hoặc gh&eacute;p lại với nhau th&agrave;nh một bộ ghế sofa ch&iacute;nh x&aacute;c m&agrave; bạn muốn v&agrave; cần - cả lớn v&agrave; nhỏ.</p>\r\n\r\n<p>B&igrave;a n&agrave;y được l&agrave;m từ vải FINNSTA pha b&ocirc;ng v&agrave; polyester, được nhuộm sợi. N&oacute; c&oacute; cấu tr&uacute;c r&otilde; r&agrave;ng, c&oacute; thể nh&igrave;n thấy được với hiệu ứng hai t&ocirc;ng m&agrave;u tạo độ s&acirc;u đẹp mắt.</p>\r\n\r\n<p>Nắp dễ d&agrave;ng giữ sạch v&igrave; c&oacute; thể th&aacute;o rời v&agrave; c&oacute; thể giặt bằng m&aacute;y.</p>\r\n\r\n<p>Bảo h&agrave;nh 10 năm c&oacute; giới hạn. Đọc về c&aacute;c điều khoản trong t&agrave;i liệu giới hạn bảo h&agrave;nh.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nOla Wihlborg</p>\r\n\r\n<p>Khung, phần 3 chỗ ngồi<br />\r\nKhung:<br />\r\nV&aacute;n &eacute;p, V&aacute;n sợi, V&aacute;n &eacute;p, L&oacute;t nỉ, Th&eacute;p, Gỗ rắn</p>\r\n\r\n<p>Đệm sau:<br />\r\nSợi polyester rỗng, Polypropylene kh&ocirc;ng dệt</p>\r\n\r\n<p>Vật liệu bọc:<br />\r\nBọt polyurethane 1,2 lb / cu.ft., Bọt polyurethane c&oacute; khả năng phục hồi cao (bọt lạnh) 2,2 lb / cu.ft.</p>\r\n\r\n<p>Wadding nhiều lớp:<br />\r\nTấm l&oacute;t polyester sợi rỗng, Polypropylene kh&ocirc;ng dệt</p>\r\n\r\n<p>Gi&aacute; đỡ thanh chắn giường:<br />\r\nPolypropylene</p>\r\n\r\n<p>Thanh giường:<br />\r\nVeneer gỗ d&aacute;n nhiều lớp, veneer bạch dương</p>\r\n\r\n<p>M&oacute;c v&agrave; d&acirc;y buộc v&ograve;ng lặp:<br />\r\n100% nylon</p>\r\n\r\n<p>Tổng th&agrave;nh phần:<br />\r\n100% polyester</p>\r\n\r\n<p>Lớp l&oacute;t chống h&ocirc;i / Lớp l&oacute;t chống h&ocirc;i:<br />\r\nTấm l&oacute;t polyester</p>\r\n\r\n<p>Khung tay vịn<br />\r\nKhung:<br />\r\nV&aacute;n sợi, gỗ rắn</p>\r\n\r\n<p>Vật liệu bọc:<br />\r\nBọt polyurethane 1,2 lb / cu.ft.</p>\r\n\r\n<p>M&oacute;c v&agrave; d&acirc;y buộc v&ograve;ng lặp:<br />\r\n100% nylon</p>\r\n\r\n<p>Khung phần g&oacute;c<br />\r\nKhung:<br />\r\nV&aacute;n &eacute;p, V&aacute;n sợi, Th&eacute;p, Gỗ rắn</p>\r\n\r\n<p>Đệm sau:<br />\r\nSợi polyester rỗng, Polypropylene kh&ocirc;ng dệt</p>\r\n\r\n<p>Vật liệu bọc:<br />\r\nBọt polyurethane 1,2 lb / cu.ft., Bọt polyurethane c&oacute; khả năng phục hồi cao (bọt lạnh) 2,2 lb / cu.ft.</p>\r\n\r\n<p>Wadding nhiều lớp:<br />\r\nTấm l&oacute;t polyester sợi rỗng, Polypropylene kh&ocirc;ng dệt</p>\r\n\r\n<p>M&oacute;c v&agrave; d&acirc;y buộc v&ograve;ng lặp:<br />\r\n100% nylon</p>\r\n\r\n<p>Tổng th&agrave;nh phần:<br />\r\n100% polyester</p>\r\n\r\n<p>Lớp l&oacute;t chống h&ocirc;i / Lớp l&oacute;t chống h&ocirc;i:<br />\r\nTấm l&oacute;t polyester</p>\r\n\r\n<p>Nắp cho phần ghế sofa / bọc cho phần tay vịn / bọc phần g&oacute;c<br />\r\n53% cotton, 47% polyester (tối thiểu 90% t&aacute;i chế)</p>\r\n\r\n<p>Nắp c&oacute; thể th&aacute;o rời<br />\r\nNắp cho phần ghế sofa / bọc cho phần tay vịn / bọc phần g&oacute;c<br />\r\nM&aacute;y giặt ấm, chu kỳ b&igrave;nh thường.</p>\r\n\r\n<p>Kh&ocirc;ng tẩy. Kh&ocirc;ng sấy kh&ocirc;. Sắt cao. Kh&ocirc;ng giặt kh&ocirc;.</p>', 2, NULL, '85', 34000000, 35000000, 36000000, 1000, 1, '2022-06-02 01:43:56', '2022-06-02 01:51:22', 26),
(86, 'Sofa Soderhamn Cam', 4, 'Nếu bạn thích cách nó trông, bạn phải thử nó! Ghế sâu, đệm lưng có thể di chuyển và vải treo làm cho chỗ ngồi này rất thoải mái. Tạo sự kết hợp của riêng bạn, ngồi lại và thư giãn.', '<p>D&ograve;ng ghế ngồi S&Ouml;DERHAMN cho ph&eacute;p bạn ngồi s&acirc;u, thấp v&agrave; mềm mại với đệm lưng rời để hỗ trợ th&ecirc;m.</p>\r\n\r\n<p>Bạn c&oacute; thể ngồi thoải m&aacute;i với độ đ&agrave;n hồi nhẹ, dễ chịu nhờ lớp dệt đ&agrave;n hồi ở ph&iacute;a dưới v&agrave; lớp m&uacute;t c&oacute; khả năng đ&agrave;n hồi cao ở đệm ngồi.</p>\r\n\r\n<p>Tất cả c&aacute;c phần trong loạt ghế sofa S&Ouml;DERHAMN c&oacute; thể được sử dụng ri&ecirc;ng hoặc gh&eacute;p lại với nhau th&agrave;nh một bộ ghế sofa ch&iacute;nh x&aacute;c m&agrave; bạn muốn v&agrave; cần - cả lớn v&agrave; nhỏ.</p>\r\n\r\n<p>B&igrave;a n&agrave;y được l&agrave;m từ vải FINNSTA pha b&ocirc;ng v&agrave; polyester, được nhuộm sợi. N&oacute; c&oacute; cấu tr&uacute;c r&otilde; r&agrave;ng, c&oacute; thể nh&igrave;n thấy được với hiệu ứng hai t&ocirc;ng m&agrave;u tạo độ s&acirc;u đẹp mắt.</p>\r\n\r\n<p>Nắp dễ d&agrave;ng giữ sạch v&igrave; c&oacute; thể th&aacute;o rời v&agrave; c&oacute; thể giặt bằng m&aacute;y.</p>\r\n\r\n<p>Bảo h&agrave;nh 10 năm c&oacute; giới hạn. Đọc về c&aacute;c điều khoản trong t&agrave;i liệu giới hạn bảo h&agrave;nh.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nOla Wihlborg</p>\r\n\r\n<p>Khung, phần 3 chỗ ngồi<br />\r\nKhung:<br />\r\nV&aacute;n &eacute;p, V&aacute;n sợi, V&aacute;n &eacute;p, L&oacute;t nỉ, Th&eacute;p, Gỗ rắn</p>\r\n\r\n<p>Đệm sau:<br />\r\nSợi polyester rỗng, Polypropylene kh&ocirc;ng dệt</p>\r\n\r\n<p>Vật liệu bọc:<br />\r\nBọt polyurethane 1,2 lb / cu.ft., Bọt polyurethane c&oacute; khả năng phục hồi cao (bọt lạnh) 2,2 lb / cu.ft.</p>\r\n\r\n<p>Wadding nhiều lớp:<br />\r\nTấm l&oacute;t polyester sợi rỗng, Polypropylene kh&ocirc;ng dệt</p>\r\n\r\n<p>Gi&aacute; đỡ thanh chắn giường:<br />\r\nPolypropylene</p>\r\n\r\n<p>Thanh giường:<br />\r\nVeneer gỗ d&aacute;n nhiều lớp, veneer bạch dương</p>\r\n\r\n<p>M&oacute;c v&agrave; d&acirc;y buộc v&ograve;ng lặp:<br />\r\n100% nylon</p>\r\n\r\n<p>Tổng th&agrave;nh phần:<br />\r\n100% polyester</p>\r\n\r\n<p>Lớp l&oacute;t chống h&ocirc;i / Lớp l&oacute;t chống h&ocirc;i:<br />\r\nTấm l&oacute;t polyester</p>\r\n\r\n<p>Khung tay vịn<br />\r\nKhung:<br />\r\nV&aacute;n sợi, gỗ rắn</p>\r\n\r\n<p>Vật liệu bọc:<br />\r\nBọt polyurethane 1,2 lb / cu.ft.</p>\r\n\r\n<p>M&oacute;c v&agrave; d&acirc;y buộc v&ograve;ng lặp:<br />\r\n100% nylon</p>\r\n\r\n<p>Khung phần g&oacute;c<br />\r\nKhung:<br />\r\nV&aacute;n &eacute;p, V&aacute;n sợi, Th&eacute;p, Gỗ rắn</p>\r\n\r\n<p>Đệm sau:<br />\r\nSợi polyester rỗng, Polypropylene kh&ocirc;ng dệt</p>\r\n\r\n<p>Vật liệu bọc:<br />\r\nBọt polyurethane 1,2 lb / cu.ft., Bọt polyurethane c&oacute; khả năng phục hồi cao (bọt lạnh) 2,2 lb / cu.ft.</p>\r\n\r\n<p>Wadding nhiều lớp:<br />\r\nTấm l&oacute;t polyester sợi rỗng, Polypropylene kh&ocirc;ng dệt</p>\r\n\r\n<p>M&oacute;c v&agrave; d&acirc;y buộc v&ograve;ng lặp:<br />\r\n100% nylon</p>\r\n\r\n<p>Tổng th&agrave;nh phần:<br />\r\n100% polyester</p>\r\n\r\n<p>Lớp l&oacute;t chống h&ocirc;i / Lớp l&oacute;t chống h&ocirc;i:<br />\r\nTấm l&oacute;t polyester</p>\r\n\r\n<p>Nắp cho phần ghế sofa / bọc cho phần tay vịn / bọc phần g&oacute;c<br />\r\n53% cotton, 47% polyester (tối thiểu 90% t&aacute;i chế)</p>\r\n\r\n<p>Nắp c&oacute; thể th&aacute;o rời<br />\r\nNắp cho phần ghế sofa / bọc cho phần tay vịn / bọc phần g&oacute;c<br />\r\nM&aacute;y giặt ấm, chu kỳ b&igrave;nh thường.</p>\r\n\r\n<p>Kh&ocirc;ng tẩy. Kh&ocirc;ng sấy kh&ocirc;. Sắt cao. Kh&ocirc;ng giặt kh&ocirc;.</p>', 2, NULL, '86', 34000000, 35000000, 36000000, 1000, 1, '2022-06-02 01:45:37', '2022-06-02 01:51:33', 85),
(87, 'Sofa Soderhamn Trắng', 4, 'Nếu bạn thích cách nó trông, bạn phải thử nó! Ghế sâu, đệm lưng có thể di chuyển và vải treo làm cho chỗ ngồi này rất thoải mái. Tạo sự kết hợp của riêng bạn, ngồi lại và thư giãn.', '<p>D&ograve;ng ghế ngồi S&Ouml;DERHAMN cho ph&eacute;p bạn ngồi s&acirc;u, thấp v&agrave; mềm mại với đệm lưng rời để hỗ trợ th&ecirc;m.</p>\r\n\r\n<p>Bạn c&oacute; thể ngồi thoải m&aacute;i với độ đ&agrave;n hồi nhẹ, dễ chịu nhờ lớp dệt đ&agrave;n hồi ở ph&iacute;a dưới v&agrave; lớp m&uacute;t c&oacute; khả năng đ&agrave;n hồi cao ở đệm ngồi.</p>\r\n\r\n<p>Tất cả c&aacute;c phần trong loạt ghế sofa S&Ouml;DERHAMN c&oacute; thể được sử dụng ri&ecirc;ng hoặc gh&eacute;p lại với nhau th&agrave;nh một bộ ghế sofa ch&iacute;nh x&aacute;c m&agrave; bạn muốn v&agrave; cần - cả lớn v&agrave; nhỏ.</p>\r\n\r\n<p>B&igrave;a n&agrave;y được l&agrave;m từ vải FINNSTA pha b&ocirc;ng v&agrave; polyester, được nhuộm sợi. N&oacute; c&oacute; cấu tr&uacute;c r&otilde; r&agrave;ng, c&oacute; thể nh&igrave;n thấy được với hiệu ứng hai t&ocirc;ng m&agrave;u tạo độ s&acirc;u đẹp mắt.</p>\r\n\r\n<p>Nắp dễ d&agrave;ng giữ sạch v&igrave; c&oacute; thể th&aacute;o rời v&agrave; c&oacute; thể giặt bằng m&aacute;y.</p>\r\n\r\n<p>Bảo h&agrave;nh 10 năm c&oacute; giới hạn. Đọc về c&aacute;c điều khoản trong t&agrave;i liệu giới hạn bảo h&agrave;nh.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nOla Wihlborg</p>\r\n\r\n<p>Khung, phần 3 chỗ ngồi<br />\r\nKhung:<br />\r\nV&aacute;n &eacute;p, V&aacute;n sợi, V&aacute;n &eacute;p, L&oacute;t nỉ, Th&eacute;p, Gỗ rắn</p>\r\n\r\n<p>Đệm sau:<br />\r\nSợi polyester rỗng, Polypropylene kh&ocirc;ng dệt</p>\r\n\r\n<p>Vật liệu bọc:<br />\r\nBọt polyurethane 1,2 lb / cu.ft., Bọt polyurethane c&oacute; khả năng phục hồi cao (bọt lạnh) 2,2 lb / cu.ft.</p>\r\n\r\n<p>Wadding nhiều lớp:<br />\r\nTấm l&oacute;t polyester sợi rỗng, Polypropylene kh&ocirc;ng dệt</p>\r\n\r\n<p>Gi&aacute; đỡ thanh chắn giường:<br />\r\nPolypropylene</p>\r\n\r\n<p>Thanh giường:<br />\r\nVeneer gỗ d&aacute;n nhiều lớp, veneer bạch dương</p>\r\n\r\n<p>M&oacute;c v&agrave; d&acirc;y buộc v&ograve;ng lặp:<br />\r\n100% nylon</p>\r\n\r\n<p>Tổng th&agrave;nh phần:<br />\r\n100% polyester</p>\r\n\r\n<p>Lớp l&oacute;t chống h&ocirc;i / Lớp l&oacute;t chống h&ocirc;i:<br />\r\nTấm l&oacute;t polyester</p>\r\n\r\n<p>Khung tay vịn<br />\r\nKhung:<br />\r\nV&aacute;n sợi, gỗ rắn</p>\r\n\r\n<p>Vật liệu bọc:<br />\r\nBọt polyurethane 1,2 lb / cu.ft.</p>\r\n\r\n<p>M&oacute;c v&agrave; d&acirc;y buộc v&ograve;ng lặp:<br />\r\n100% nylon</p>\r\n\r\n<p>Khung phần g&oacute;c<br />\r\nKhung:<br />\r\nV&aacute;n &eacute;p, V&aacute;n sợi, Th&eacute;p, Gỗ rắn</p>\r\n\r\n<p>Đệm sau:<br />\r\nSợi polyester rỗng, Polypropylene kh&ocirc;ng dệt</p>\r\n\r\n<p>Vật liệu bọc:<br />\r\nBọt polyurethane 1,2 lb / cu.ft., Bọt polyurethane c&oacute; khả năng phục hồi cao (bọt lạnh) 2,2 lb / cu.ft.</p>\r\n\r\n<p>Wadding nhiều lớp:<br />\r\nTấm l&oacute;t polyester sợi rỗng, Polypropylene kh&ocirc;ng dệt</p>\r\n\r\n<p>M&oacute;c v&agrave; d&acirc;y buộc v&ograve;ng lặp:<br />\r\n100% nylon</p>\r\n\r\n<p>Tổng th&agrave;nh phần:<br />\r\n100% polyester</p>\r\n\r\n<p>Lớp l&oacute;t chống h&ocirc;i / Lớp l&oacute;t chống h&ocirc;i:<br />\r\nTấm l&oacute;t polyester</p>\r\n\r\n<p>Nắp cho phần ghế sofa / bọc cho phần tay vịn / bọc phần g&oacute;c<br />\r\n53% cotton, 47% polyester (tối thiểu 90% t&aacute;i chế)</p>\r\n\r\n<p>Nắp c&oacute; thể th&aacute;o rời<br />\r\nNắp cho phần ghế sofa / bọc cho phần tay vịn / bọc phần g&oacute;c<br />\r\nM&aacute;y giặt ấm, chu kỳ b&igrave;nh thường.</p>\r\n\r\n<p>Kh&ocirc;ng tẩy. Kh&ocirc;ng sấy kh&ocirc;. Sắt cao. Kh&ocirc;ng giặt kh&ocirc;.</p>', 2, NULL, '87', 34000000, 35000000, 36000000, 1000, 1, '2022-06-02 01:47:18', '2022-06-02 01:51:41', 85),
(88, 'Sofa Soderhamn Ghi', 4, 'Nếu bạn thích cách nó trông, bạn phải thử nó! Ghế sâu, đệm lưng có thể di chuyển và vải treo làm cho chỗ ngồi này rất thoải mái. Tạo sự kết hợp của riêng bạn, ngồi lại và thư giãn.', '<p>D&ograve;ng ghế ngồi S&Ouml;DERHAMN cho ph&eacute;p bạn ngồi s&acirc;u, thấp v&agrave; mềm mại với đệm lưng rời để hỗ trợ th&ecirc;m.</p>\r\n\r\n<p>Bạn c&oacute; thể ngồi thoải m&aacute;i với độ đ&agrave;n hồi nhẹ, dễ chịu nhờ lớp dệt đ&agrave;n hồi ở ph&iacute;a dưới v&agrave; lớp m&uacute;t c&oacute; khả năng đ&agrave;n hồi cao ở đệm ngồi.</p>\r\n\r\n<p>Tất cả c&aacute;c phần trong loạt ghế sofa S&Ouml;DERHAMN c&oacute; thể được sử dụng ri&ecirc;ng hoặc gh&eacute;p lại với nhau th&agrave;nh một bộ ghế sofa ch&iacute;nh x&aacute;c m&agrave; bạn muốn v&agrave; cần - cả lớn v&agrave; nhỏ.</p>\r\n\r\n<p>B&igrave;a n&agrave;y được l&agrave;m từ vải FINNSTA pha b&ocirc;ng v&agrave; polyester, được nhuộm sợi. N&oacute; c&oacute; cấu tr&uacute;c r&otilde; r&agrave;ng, c&oacute; thể nh&igrave;n thấy được với hiệu ứng hai t&ocirc;ng m&agrave;u tạo độ s&acirc;u đẹp mắt.</p>\r\n\r\n<p>Nắp dễ d&agrave;ng giữ sạch v&igrave; c&oacute; thể th&aacute;o rời v&agrave; c&oacute; thể giặt bằng m&aacute;y.</p>\r\n\r\n<p>Bảo h&agrave;nh 10 năm c&oacute; giới hạn. Đọc về c&aacute;c điều khoản trong t&agrave;i liệu giới hạn bảo h&agrave;nh.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nOla Wihlborg</p>\r\n\r\n<p>Khung, phần 3 chỗ ngồi<br />\r\nKhung:<br />\r\nV&aacute;n &eacute;p, V&aacute;n sợi, V&aacute;n &eacute;p, L&oacute;t nỉ, Th&eacute;p, Gỗ rắn</p>\r\n\r\n<p>Đệm sau:<br />\r\nSợi polyester rỗng, Polypropylene kh&ocirc;ng dệt</p>\r\n\r\n<p>Vật liệu bọc:<br />\r\nBọt polyurethane 1,2 lb / cu.ft., Bọt polyurethane c&oacute; khả năng phục hồi cao (bọt lạnh) 2,2 lb / cu.ft.</p>\r\n\r\n<p>Wadding nhiều lớp:<br />\r\nTấm l&oacute;t polyester sợi rỗng, Polypropylene kh&ocirc;ng dệt</p>\r\n\r\n<p>Gi&aacute; đỡ thanh chắn giường:<br />\r\nPolypropylene</p>\r\n\r\n<p>Thanh giường:<br />\r\nVeneer gỗ d&aacute;n nhiều lớp, veneer bạch dương</p>\r\n\r\n<p>M&oacute;c v&agrave; d&acirc;y buộc v&ograve;ng lặp:<br />\r\n100% nylon</p>\r\n\r\n<p>Tổng th&agrave;nh phần:<br />\r\n100% polyester</p>\r\n\r\n<p>Lớp l&oacute;t chống h&ocirc;i / Lớp l&oacute;t chống h&ocirc;i:<br />\r\nTấm l&oacute;t polyester</p>\r\n\r\n<p>Khung tay vịn<br />\r\nKhung:<br />\r\nV&aacute;n sợi, gỗ rắn</p>\r\n\r\n<p>Vật liệu bọc:<br />\r\nBọt polyurethane 1,2 lb / cu.ft.</p>\r\n\r\n<p>M&oacute;c v&agrave; d&acirc;y buộc v&ograve;ng lặp:<br />\r\n100% nylon</p>\r\n\r\n<p>Khung phần g&oacute;c<br />\r\nKhung:<br />\r\nV&aacute;n &eacute;p, V&aacute;n sợi, Th&eacute;p, Gỗ rắn</p>\r\n\r\n<p>Đệm sau:<br />\r\nSợi polyester rỗng, Polypropylene kh&ocirc;ng dệt</p>\r\n\r\n<p>Vật liệu bọc:<br />\r\nBọt polyurethane 1,2 lb / cu.ft., Bọt polyurethane c&oacute; khả năng phục hồi cao (bọt lạnh) 2,2 lb / cu.ft.</p>\r\n\r\n<p>Wadding nhiều lớp:<br />\r\nTấm l&oacute;t polyester sợi rỗng, Polypropylene kh&ocirc;ng dệt</p>\r\n\r\n<p>M&oacute;c v&agrave; d&acirc;y buộc v&ograve;ng lặp:<br />\r\n100% nylon</p>\r\n\r\n<p>Tổng th&agrave;nh phần:<br />\r\n100% polyester</p>\r\n\r\n<p>Lớp l&oacute;t chống h&ocirc;i / Lớp l&oacute;t chống h&ocirc;i:<br />\r\nTấm l&oacute;t polyester</p>\r\n\r\n<p>Nắp cho phần ghế sofa / bọc cho phần tay vịn / bọc phần g&oacute;c<br />\r\n53% cotton, 47% polyester (tối thiểu 90% t&aacute;i chế)</p>\r\n\r\n<p>Nắp c&oacute; thể th&aacute;o rời<br />\r\nNắp cho phần ghế sofa / bọc cho phần tay vịn / bọc phần g&oacute;c<br />\r\nM&aacute;y giặt ấm, chu kỳ b&igrave;nh thường.</p>\r\n\r\n<p>Kh&ocirc;ng tẩy. Kh&ocirc;ng sấy kh&ocirc;. Sắt cao. Kh&ocirc;ng giặt kh&ocirc;.</p>', 2, NULL, '88', 34000000, 35000000, 36000000, 1000, 1, '2022-06-02 01:48:47', '2022-06-02 01:51:54', 85),
(89, 'Sofa Soderhamn Xanh', 4, 'Nếu bạn thích cách nó trông, bạn phải thử nó! Ghế sâu, đệm lưng có thể di chuyển và vải treo làm cho chỗ ngồi này rất thoải mái. Tạo sự kết hợp của riêng bạn, ngồi lại và thư giãn.', '<p>D&ograve;ng ghế ngồi S&Ouml;DERHAMN cho ph&eacute;p bạn ngồi s&acirc;u, thấp v&agrave; mềm mại với đệm lưng rời để hỗ trợ th&ecirc;m.</p>\r\n\r\n<p>Bạn c&oacute; thể ngồi thoải m&aacute;i với độ đ&agrave;n hồi nhẹ, dễ chịu nhờ lớp dệt đ&agrave;n hồi ở ph&iacute;a dưới v&agrave; lớp m&uacute;t c&oacute; khả năng đ&agrave;n hồi cao ở đệm ngồi.</p>\r\n\r\n<p>Tất cả c&aacute;c phần trong loạt ghế sofa S&Ouml;DERHAMN c&oacute; thể được sử dụng ri&ecirc;ng hoặc gh&eacute;p lại với nhau th&agrave;nh một bộ ghế sofa ch&iacute;nh x&aacute;c m&agrave; bạn muốn v&agrave; cần - cả lớn v&agrave; nhỏ.</p>\r\n\r\n<p>B&igrave;a n&agrave;y được l&agrave;m từ vải FINNSTA pha b&ocirc;ng v&agrave; polyester, được nhuộm sợi. N&oacute; c&oacute; cấu tr&uacute;c r&otilde; r&agrave;ng, c&oacute; thể nh&igrave;n thấy được với hiệu ứng hai t&ocirc;ng m&agrave;u tạo độ s&acirc;u đẹp mắt.</p>\r\n\r\n<p>Nắp dễ d&agrave;ng giữ sạch v&igrave; c&oacute; thể th&aacute;o rời v&agrave; c&oacute; thể giặt bằng m&aacute;y.</p>\r\n\r\n<p>Bảo h&agrave;nh 10 năm c&oacute; giới hạn. Đọc về c&aacute;c điều khoản trong t&agrave;i liệu giới hạn bảo h&agrave;nh.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nOla Wihlborg</p>\r\n\r\n<p>Khung, phần 3 chỗ ngồi<br />\r\nKhung:<br />\r\nV&aacute;n &eacute;p, V&aacute;n sợi, V&aacute;n &eacute;p, L&oacute;t nỉ, Th&eacute;p, Gỗ rắn</p>\r\n\r\n<p>Đệm sau:<br />\r\nSợi polyester rỗng, Polypropylene kh&ocirc;ng dệt</p>\r\n\r\n<p>Vật liệu bọc:<br />\r\nBọt polyurethane 1,2 lb / cu.ft., Bọt polyurethane c&oacute; khả năng phục hồi cao (bọt lạnh) 2,2 lb / cu.ft.</p>\r\n\r\n<p>Wadding nhiều lớp:<br />\r\nTấm l&oacute;t polyester sợi rỗng, Polypropylene kh&ocirc;ng dệt</p>\r\n\r\n<p>Gi&aacute; đỡ thanh chắn giường:<br />\r\nPolypropylene</p>\r\n\r\n<p>Thanh giường:<br />\r\nVeneer gỗ d&aacute;n nhiều lớp, veneer bạch dương</p>\r\n\r\n<p>M&oacute;c v&agrave; d&acirc;y buộc v&ograve;ng lặp:<br />\r\n100% nylon</p>\r\n\r\n<p>Tổng th&agrave;nh phần:<br />\r\n100% polyester</p>\r\n\r\n<p>Lớp l&oacute;t chống h&ocirc;i / Lớp l&oacute;t chống h&ocirc;i:<br />\r\nTấm l&oacute;t polyester</p>\r\n\r\n<p>Khung tay vịn<br />\r\nKhung:<br />\r\nV&aacute;n sợi, gỗ rắn</p>\r\n\r\n<p>Vật liệu bọc:<br />\r\nBọt polyurethane 1,2 lb / cu.ft.</p>\r\n\r\n<p>M&oacute;c v&agrave; d&acirc;y buộc v&ograve;ng lặp:<br />\r\n100% nylon</p>\r\n\r\n<p>Khung phần g&oacute;c<br />\r\nKhung:<br />\r\nV&aacute;n &eacute;p, V&aacute;n sợi, Th&eacute;p, Gỗ rắn</p>\r\n\r\n<p>Đệm sau:<br />\r\nSợi polyester rỗng, Polypropylene kh&ocirc;ng dệt</p>\r\n\r\n<p>Vật liệu bọc:<br />\r\nBọt polyurethane 1,2 lb / cu.ft., Bọt polyurethane c&oacute; khả năng phục hồi cao (bọt lạnh) 2,2 lb / cu.ft.</p>\r\n\r\n<p>Wadding nhiều lớp:<br />\r\nTấm l&oacute;t polyester sợi rỗng, Polypropylene kh&ocirc;ng dệt</p>\r\n\r\n<p>M&oacute;c v&agrave; d&acirc;y buộc v&ograve;ng lặp:<br />\r\n100% nylon</p>\r\n\r\n<p>Tổng th&agrave;nh phần:<br />\r\n100% polyester</p>\r\n\r\n<p>Lớp l&oacute;t chống h&ocirc;i / Lớp l&oacute;t chống h&ocirc;i:<br />\r\nTấm l&oacute;t polyester</p>\r\n\r\n<p>Nắp cho phần ghế sofa / bọc cho phần tay vịn / bọc phần g&oacute;c<br />\r\n53% cotton, 47% polyester (tối thiểu 90% t&aacute;i chế)</p>\r\n\r\n<p>Nắp c&oacute; thể th&aacute;o rời<br />\r\nNắp cho phần ghế sofa / bọc cho phần tay vịn / bọc phần g&oacute;c<br />\r\nM&aacute;y giặt ấm, chu kỳ b&igrave;nh thường.</p>\r\n\r\n<p>Kh&ocirc;ng tẩy. Kh&ocirc;ng sấy kh&ocirc;. Sắt cao. Kh&ocirc;ng giặt kh&ocirc;.</p>', 2, NULL, '89', 34000000, 35000000, 36000000, 1000, 1, '2022-06-02 01:50:59', '2022-06-02 01:52:34', 85),
(90, 'Kệ Besta', 11, 'Không chỉ có TV mới thông minh! Các đơn vị TV BESTÅ kết hợp ngoại hình đẹp hiện đại với chức năng thực tế. Bạn nhận được nhiều không gian lưu trữ và giảm bớt các dây cáp có xu hướng lộn xộn và bám bụi.', '<p>TV treo tường tạo cảm gi&aacute;c sạch sẽ, tho&aacute;ng m&aacute;t v&agrave; kh&ocirc;ng c&oacute; ch&acirc;n vướng v&agrave;o khi bạn h&uacute;t bụi s&agrave;n.</p>\r\n\r\n<p>Thật dễ d&agrave;ng để giữ d&acirc;y khỏi TV v&agrave; c&aacute;c thiết bị kh&aacute;c của bạn ở nơi khuất tầm nh&igrave;n nhưng h&atilde;y đ&oacute;ng lại trong tầm tay, v&igrave; c&oacute; một số ổ cắm d&acirc;y ở ph&iacute;a sau băng ghế TV.</p>\r\n\r\n<p>Ổ cắm c&aacute;p ở tr&ecirc;n c&ugrave;ng cho ph&eacute;p d&acirc;y dẫn xuống băng ghế TV trơn tru.</p>\r\n\r\n<p>C&aacute;c kệ c&oacute; thể điều chỉnh để bạn c&oacute; thể t&ugrave;y chỉnh lưu trữ của m&igrave;nh khi cần thiết.</p>\r\n\r\n<p>Bạn c&oacute; thể chọn sử dụng chức năng đ&oacute;ng mở nhẹ nh&agrave;ng hoặc mở đẩy. Bản lề đ&oacute;ng mở cho ph&eacute;p bạn mở cửa chỉ bằng một c&uacute; đẩy nhẹ, trong khi bản lề đ&oacute;ng &ecirc;m đảm bảo ch&uacute;ng đ&oacute;ng &ecirc;m v&agrave; nhẹ nh&agrave;ng.</p>\r\n\r\n<p>Tối ưu h&oacute;a v&agrave; tổ chức bộ nhớ TỐT NHẤT&Aring; của bạn với c&aacute;c hộp v&agrave; phụ trang m&agrave; bạn th&iacute;ch.</p>\r\n\r\n<p>Ch&uacute;ng t&ocirc;i khuy&ecirc;n bạn n&ecirc;n đặt một chiếc ghế d&agrave;i để TV rộng hơn một ch&uacute;t so với chiếc TV được đặt tr&ecirc;n đ&oacute;. Ghế d&agrave;i TV n&agrave;y ph&ugrave; hợp với TV l&ecirc;n đến 72 inch. Bạn c&oacute; thể chọn một chiếc TV lớn hơn nếu n&oacute; kh&ocirc;ng nặng hơn tải trọng tối đa được chỉ định cho đầu của băng ghế dự bị.</p>\r\n\r\n<p>Tấm tr&ecirc;n c&ugrave;ng của băng ghế dự bị TV d&agrave;nh cho TV c&oacute; trọng lượng tối đa l&agrave; 110 lbs.</p>\r\n\r\n<p>Nếu bạn chọn chức năng đ&oacute;ng nhẹ nh&agrave;ng cho TỐT NHẤT&Aring; của m&igrave;nh, ch&uacute;ng t&ocirc;i khuy&ecirc;n bạn n&ecirc;n bổ sung c&aacute;c n&uacute;t vặn / tay nắm ph&iacute;a trước để l&agrave;m cho c&aacute;c ngăn k&eacute;o / tủ được mở thuận tiện hơn.</p>\r\n\r\n<p>Tối đa. tải trọng cho một chiếc ghế d&agrave;i TV treo tường phụ thuộc v&agrave;o chất liệu tường.</p>\r\n\r\n<p>Vật liệu tường kh&aacute;c nhau đ&ograve;i hỏi c&aacute;c loại ốc v&iacute;t kh&aacute;c nhau. Sử dụng d&acirc;y buộc ph&ugrave; hợp với c&aacute;c bức tường trong nh&agrave; của bạn.</p>\r\n\r\n<p>Nếu bạn muốn tạo ra một c&aacute;i nh&igrave;n thống nhất trong to&agrave;n bộ ng&ocirc;i nh&agrave; của bạn, bạn c&oacute; thể kết hợp mặt trước SELSVIKEN với cửa FARDAL ph&ugrave; hợp cho PAX.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nIKEA của Thụy Điển</p>', 2, NULL, '90', 8000000, 9000000, 10000000, 1000, 1, '2022-06-02 02:04:18', '2022-06-02 02:08:32', 32),
(91, 'Kệ Besta Đen', 11, 'Không chỉ có TV mới thông minh! Các đơn vị TV BESTÅ kết hợp ngoại hình đẹp hiện đại với chức năng thực tế. Bạn nhận được nhiều không gian lưu trữ và giảm bớt các dây cáp có xu hướng lộn xộn và bám bụi.', '<p>TV treo tường tạo cảm gi&aacute;c sạch sẽ, tho&aacute;ng m&aacute;t v&agrave; kh&ocirc;ng c&oacute; ch&acirc;n vướng v&agrave;o khi bạn h&uacute;t bụi s&agrave;n.</p>\r\n\r\n<p>Thật dễ d&agrave;ng để giữ d&acirc;y khỏi TV v&agrave; c&aacute;c thiết bị kh&aacute;c của bạn ở nơi khuất tầm nh&igrave;n nhưng h&atilde;y đ&oacute;ng lại trong tầm tay, v&igrave; c&oacute; một số ổ cắm d&acirc;y ở ph&iacute;a sau băng ghế TV.</p>\r\n\r\n<p>Ổ cắm c&aacute;p ở tr&ecirc;n c&ugrave;ng cho ph&eacute;p d&acirc;y dẫn xuống băng ghế TV trơn tru.</p>\r\n\r\n<p>C&aacute;c kệ c&oacute; thể điều chỉnh để bạn c&oacute; thể t&ugrave;y chỉnh lưu trữ của m&igrave;nh khi cần thiết.</p>\r\n\r\n<p>Bạn c&oacute; thể chọn sử dụng chức năng đ&oacute;ng mở nhẹ nh&agrave;ng hoặc mở đẩy. Bản lề đ&oacute;ng mở cho ph&eacute;p bạn mở cửa chỉ bằng một c&uacute; đẩy nhẹ, trong khi bản lề đ&oacute;ng &ecirc;m đảm bảo ch&uacute;ng đ&oacute;ng &ecirc;m v&agrave; nhẹ nh&agrave;ng.</p>\r\n\r\n<p>Tối ưu h&oacute;a v&agrave; tổ chức bộ nhớ TỐT NHẤT&Aring; của bạn với c&aacute;c hộp v&agrave; phụ trang m&agrave; bạn th&iacute;ch.</p>\r\n\r\n<p>Ch&uacute;ng t&ocirc;i khuy&ecirc;n bạn n&ecirc;n đặt một chiếc ghế d&agrave;i để TV rộng hơn một ch&uacute;t so với chiếc TV được đặt tr&ecirc;n đ&oacute;. Ghế d&agrave;i TV n&agrave;y ph&ugrave; hợp với TV l&ecirc;n đến 72 inch. Bạn c&oacute; thể chọn một chiếc TV lớn hơn nếu n&oacute; kh&ocirc;ng nặng hơn tải trọng tối đa được chỉ định cho đầu của băng ghế dự bị.</p>\r\n\r\n<p>Tấm tr&ecirc;n c&ugrave;ng của băng ghế dự bị TV d&agrave;nh cho TV c&oacute; trọng lượng tối đa l&agrave; 110 lbs.</p>\r\n\r\n<p>Nếu bạn chọn chức năng đ&oacute;ng nhẹ nh&agrave;ng cho TỐT NHẤT&Aring; của m&igrave;nh, ch&uacute;ng t&ocirc;i khuy&ecirc;n bạn n&ecirc;n bổ sung c&aacute;c n&uacute;t vặn / tay nắm ph&iacute;a trước để l&agrave;m cho c&aacute;c ngăn k&eacute;o / tủ được mở thuận tiện hơn.</p>\r\n\r\n<p>Tối đa. tải trọng cho một chiếc ghế d&agrave;i TV treo tường phụ thuộc v&agrave;o chất liệu tường.</p>\r\n\r\n<p>Vật liệu tường kh&aacute;c nhau đ&ograve;i hỏi c&aacute;c loại ốc v&iacute;t kh&aacute;c nhau. Sử dụng d&acirc;y buộc ph&ugrave; hợp với c&aacute;c bức tường trong nh&agrave; của bạn.</p>\r\n\r\n<p>Nếu bạn muốn tạo ra một c&aacute;i nh&igrave;n thống nhất trong to&agrave;n bộ ng&ocirc;i nh&agrave; của bạn, bạn c&oacute; thể kết hợp mặt trước SELSVIKEN với cửa FARDAL ph&ugrave; hợp cho PAX.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nIKEA của Thụy Điển</p>', 2, NULL, '91', 8000000, 9000000, 10000000, 1000, 1, '2022-06-02 02:06:29', '2022-06-02 02:08:42', 90);
INSERT INTO `product` (`ID`, `name`, `product_category`, `description`, `content_review`, `display_state`, `rate`, `slug`, `price_entry`, `price_sale`, `price_sell`, `quantity`, `status`, `created_at`, `updated_at`, `product_parent`) VALUES
(92, 'Kệ Besta Nâu', 11, 'Không chỉ có TV mới thông minh! Các đơn vị TV BESTÅ kết hợp ngoại hình đẹp hiện đại với chức năng thực tế. Bạn nhận được nhiều không gian lưu trữ và giảm bớt các dây cáp có xu hướng lộn xộn và bám bụi.', '<p>TV treo tường tạo cảm gi&aacute;c sạch sẽ, tho&aacute;ng m&aacute;t v&agrave; kh&ocirc;ng c&oacute; ch&acirc;n vướng v&agrave;o khi bạn h&uacute;t bụi s&agrave;n.</p>\r\n\r\n<p>Thật dễ d&agrave;ng để giữ d&acirc;y khỏi TV v&agrave; c&aacute;c thiết bị kh&aacute;c của bạn ở nơi khuất tầm nh&igrave;n nhưng h&atilde;y đ&oacute;ng lại trong tầm tay, v&igrave; c&oacute; một số ổ cắm d&acirc;y ở ph&iacute;a sau băng ghế TV.</p>\r\n\r\n<p>Ổ cắm c&aacute;p ở tr&ecirc;n c&ugrave;ng cho ph&eacute;p d&acirc;y dẫn xuống băng ghế TV trơn tru.</p>\r\n\r\n<p>C&aacute;c kệ c&oacute; thể điều chỉnh để bạn c&oacute; thể t&ugrave;y chỉnh lưu trữ của m&igrave;nh khi cần thiết.</p>\r\n\r\n<p>Bạn c&oacute; thể chọn sử dụng chức năng đ&oacute;ng mở nhẹ nh&agrave;ng hoặc mở đẩy. Bản lề đ&oacute;ng mở cho ph&eacute;p bạn mở cửa chỉ bằng một c&uacute; đẩy nhẹ, trong khi bản lề đ&oacute;ng &ecirc;m đảm bảo ch&uacute;ng đ&oacute;ng &ecirc;m v&agrave; nhẹ nh&agrave;ng.</p>\r\n\r\n<p>Tối ưu h&oacute;a v&agrave; tổ chức bộ nhớ TỐT NHẤT&Aring; của bạn với c&aacute;c hộp v&agrave; phụ trang m&agrave; bạn th&iacute;ch.</p>\r\n\r\n<p>Ch&uacute;ng t&ocirc;i khuy&ecirc;n bạn n&ecirc;n đặt một chiếc ghế d&agrave;i để TV rộng hơn một ch&uacute;t so với chiếc TV được đặt tr&ecirc;n đ&oacute;. Ghế d&agrave;i TV n&agrave;y ph&ugrave; hợp với TV l&ecirc;n đến 72 inch. Bạn c&oacute; thể chọn một chiếc TV lớn hơn nếu n&oacute; kh&ocirc;ng nặng hơn tải trọng tối đa được chỉ định cho đầu của băng ghế dự bị.</p>\r\n\r\n<p>Tấm tr&ecirc;n c&ugrave;ng của băng ghế dự bị TV d&agrave;nh cho TV c&oacute; trọng lượng tối đa l&agrave; 110 lbs.</p>\r\n\r\n<p>Nếu bạn chọn chức năng đ&oacute;ng nhẹ nh&agrave;ng cho TỐT NHẤT&Aring; của m&igrave;nh, ch&uacute;ng t&ocirc;i khuy&ecirc;n bạn n&ecirc;n bổ sung c&aacute;c n&uacute;t vặn / tay nắm ph&iacute;a trước để l&agrave;m cho c&aacute;c ngăn k&eacute;o / tủ được mở thuận tiện hơn.</p>\r\n\r\n<p>Tối đa. tải trọng cho một chiếc ghế d&agrave;i TV treo tường phụ thuộc v&agrave;o chất liệu tường.</p>\r\n\r\n<p>Vật liệu tường kh&aacute;c nhau đ&ograve;i hỏi c&aacute;c loại ốc v&iacute;t kh&aacute;c nhau. Sử dụng d&acirc;y buộc ph&ugrave; hợp với c&aacute;c bức tường trong nh&agrave; của bạn.</p>\r\n\r\n<p>Nếu bạn muốn tạo ra một c&aacute;i nh&igrave;n thống nhất trong to&agrave;n bộ ng&ocirc;i nh&agrave; của bạn, bạn c&oacute; thể kết hợp mặt trước SELSVIKEN với cửa FARDAL ph&ugrave; hợp cho PAX.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nIKEA của Thụy Điển</p>', 2, NULL, '92', 8000000, 9000000, 10000000, 1000, 1, '2022-06-02 02:08:19', '2022-06-02 02:08:51', 90),
(93, 'Kệ Brimnes', 11, 'Khi được sắp xếp theo TV, bạn sẽ dễ dàng thưởng thức bộ phim truyền hình yêu thích của mình hơn. Giữ các trò chơi, điều khiển và phụ kiện của bạn trong các ngăn kéo lớn và nạp dây qua các ổ cắm ở phía sau.', '<p>Đơn vị TV n&agrave;y c&oacute; c&aacute;c ngăn k&eacute;o lớn gi&uacute;p bạn dễ d&agrave;ng sắp xếp điều khiển từ xa, bộ điều khiển tr&ograve; chơi v&agrave; c&aacute;c phụ kiện TV kh&aacute;c.</p>\r\n\r\n<p>Ổ cắm c&aacute;p gi&uacute;p bạn dễ d&agrave;ng luồn d&acirc;y c&aacute;p v&agrave; luồn d&acirc;y ra ph&iacute;a sau để ch&uacute;ng bị che khuất khỏi tầm nh&igrave;n nhưng c&oacute; thể đ&oacute;ng lại khi bạn cần.</p>\r\n\r\n<p>Ch&uacute;ng t&ocirc;i khuy&ecirc;n bạn n&ecirc;n đặt một chiếc ghế d&agrave;i để TV rộng hơn một ch&uacute;t so với chiếc TV được đặt tr&ecirc;n đ&oacute;. Ghế d&agrave;i TV n&agrave;y ph&ugrave; hợp với TV l&ecirc;n đến 72 inch. Bạn c&oacute; thể chọn một chiếc TV lớn hơn nếu n&oacute; kh&ocirc;ng nặng hơn tải trọng tối đa được chỉ định cho đầu của băng ghế dự bị.</p>\r\n\r\n<p>Mặt tr&ecirc;n của băng ghế dự bị TV d&agrave;nh cho TV c&oacute; trọng lượng tối đa l&agrave; 66 lbs.</p>\r\n\r\n<p>Vật liệu tường kh&aacute;c nhau đ&ograve;i hỏi c&aacute;c loại ốc v&iacute;t kh&aacute;c nhau. Sử dụng d&acirc;y buộc ph&ugrave; hợp với c&aacute;c bức tường trong nh&agrave; của bạn.</p>\r\n\r\n<p>Phối hợp với c&aacute;c đồ nội thất kh&aacute;c trong loạt BRIMNES.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nK Hagberg / M Hagberg</p>', 2, NULL, '93', 3500000, 4500000, 5000000, 1000, 1, '2022-06-02 02:17:33', '2022-06-02 02:19:01', 32),
(94, 'Kệ Brimnes Trắng', 11, 'Khi được sắp xếp theo TV, bạn sẽ dễ dàng thưởng thức bộ phim truyền hình yêu thích của mình hơn. Giữ các trò chơi, điều khiển và phụ kiện của bạn trong các ngăn kéo lớn và nạp dây qua các ổ cắm ở phía sau.', '<p>Đơn vị TV n&agrave;y c&oacute; c&aacute;c ngăn k&eacute;o lớn gi&uacute;p bạn dễ d&agrave;ng sắp xếp điều khiển từ xa, bộ điều khiển tr&ograve; chơi v&agrave; c&aacute;c phụ kiện TV kh&aacute;c.</p>\r\n\r\n<p>Ổ cắm c&aacute;p gi&uacute;p bạn dễ d&agrave;ng luồn d&acirc;y c&aacute;p v&agrave; luồn d&acirc;y ra ph&iacute;a sau để ch&uacute;ng bị che khuất khỏi tầm nh&igrave;n nhưng c&oacute; thể đ&oacute;ng lại khi bạn cần.</p>\r\n\r\n<p>Ch&uacute;ng t&ocirc;i khuy&ecirc;n bạn n&ecirc;n đặt một chiếc ghế d&agrave;i để TV rộng hơn một ch&uacute;t so với chiếc TV được đặt tr&ecirc;n đ&oacute;. Ghế d&agrave;i TV n&agrave;y ph&ugrave; hợp với TV l&ecirc;n đến 72 inch. Bạn c&oacute; thể chọn một chiếc TV lớn hơn nếu n&oacute; kh&ocirc;ng nặng hơn tải trọng tối đa được chỉ định cho đầu của băng ghế dự bị.</p>\r\n\r\n<p>Mặt tr&ecirc;n của băng ghế dự bị TV d&agrave;nh cho TV c&oacute; trọng lượng tối đa l&agrave; 66 lbs.</p>\r\n\r\n<p>Vật liệu tường kh&aacute;c nhau đ&ograve;i hỏi c&aacute;c loại ốc v&iacute;t kh&aacute;c nhau. Sử dụng d&acirc;y buộc ph&ugrave; hợp với c&aacute;c bức tường trong nh&agrave; của bạn.</p>\r\n\r\n<p>Phối hợp với c&aacute;c đồ nội thất kh&aacute;c trong loạt BRIMNES.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nK Hagberg / M Hagberg</p>', 2, NULL, '94', 3500000, 4500000, 5000000, 1000, 1, '2022-06-02 02:18:47', '2022-06-02 02:19:09', 93),
(95, 'Kệ Byas', 11, 'Với bộ nhớ mở, việc xem tổng quan dễ dàng hơn và với bộ lưu trữ đóng, bạn có thể giữ mọi thứ gọn gàng và đẹp mắt. Ghế dài TV này có cả hai và một kệ có thể điều chỉnh được ở mỗi phần.', '<p>Ngăn mở c&oacute; một kệ c&oacute; thể điều chỉnh được cho thiết bị đa phương tiện, m&aacute;y chơi game, v.v.</p>\r\n\r\n<p>Bạn c&oacute; thể t&ugrave;y chỉnh kh&ocirc;ng gian để sử dụng tối ưu, v&igrave; cả hai hộp đều c&oacute; kệ điều chỉnh b&ecirc;n trong.</p>\r\n\r\n<p>Ch&uacute;ng t&ocirc;i khuy&ecirc;n bạn n&ecirc;n đặt một chiếc ghế d&agrave;i để TV rộng hơn một ch&uacute;t so với chiếc TV được đặt tr&ecirc;n đ&oacute;. Ghế d&agrave;i TV n&agrave;y ph&ugrave; hợp với TV c&oacute; k&iacute;ch thước l&ecirc;n đến 63 inch. Bạn c&oacute; thể chọn một chiếc TV lớn hơn nếu n&oacute; kh&ocirc;ng nặng hơn tải trọng tối đa được chỉ định cho đầu của băng ghế dự bị.</p>\r\n\r\n<p>Tấm tr&ecirc;n c&ugrave;ng của băng ghế dự bị TV d&agrave;nh cho TV c&oacute; trọng lượng tối đa l&agrave; 110 lbs.</p>\r\n\r\n<p>Bao gồm tay cầm.</p>\r\n\r\n<p>Vật liệu tường kh&aacute;c nhau đ&ograve;i hỏi c&aacute;c loại ốc v&iacute;t kh&aacute;c nhau. Sử dụng d&acirc;y buộc ph&ugrave; hợp với c&aacute;c bức tường trong nh&agrave; của bạn.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nMarcus Arvonen&nbsp;&nbsp; &nbsp;</p>', 2, NULL, '95', 3500000, 4500000, 5000000, 1000, 1, '2022-06-02 02:23:43', '2022-06-02 02:23:55', 32),
(96, 'Kệ Lack', 11, 'Phần mở ở phía sau cho phép bạn dễ dàng tập hợp và sắp xếp tất cả các dây.', '<p>Phần mở ở ph&iacute;a sau cho ph&eacute;p bạn dễ d&agrave;ng tập hợp v&agrave; sắp xếp tất cả c&aacute;c d&acirc;y.</p>\r\n\r\n<p>Ch&uacute;ng t&ocirc;i khuy&ecirc;n bạn n&ecirc;n đặt một chiếc ghế d&agrave;i để TV rộng hơn một ch&uacute;t so với chiếc TV được đặt tr&ecirc;n đ&oacute;. Ghế d&agrave;i TV n&agrave;y ph&ugrave; hợp với TV c&oacute; k&iacute;ch thước l&ecirc;n đến 63 inch. Bạn c&oacute; thể chọn một chiếc TV lớn hơn nếu n&oacute; kh&ocirc;ng nặng hơn tải trọng tối đa được chỉ định cho đầu của băng ghế dự bị.</p>\r\n\r\n<p>Mặt tr&ecirc;n của băng ghế dự bị TV d&agrave;nh cho TV c&oacute; trọng lượng tối đa l&agrave; 66 lbs.</p>\r\n\r\n<p>Vật liệu tường kh&aacute;c nhau đ&ograve;i hỏi c&aacute;c loại ốc v&iacute;t kh&aacute;c nhau. Sử dụng d&acirc;y buộc ph&ugrave; hợp với c&aacute;c bức tường trong nh&agrave; của bạn.</p>\r\n\r\n<p>Phối hợp với c&aacute;c sản phẩm kh&aacute;c trong d&ograve;ng LACK.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nIKEA của Thụy Điển</p>', 2, NULL, '96', 1700000, 2500000, 3000000, 1000, 1, '2022-06-02 02:30:37', '2022-06-02 02:31:57', 32),
(97, 'Kệ Lack Trắng', 11, 'Phần mở ở phía sau cho phép bạn dễ dàng tập hợp và sắp xếp tất cả các dây.', '<p>Phần mở ở ph&iacute;a sau cho ph&eacute;p bạn dễ d&agrave;ng tập hợp v&agrave; sắp xếp tất cả c&aacute;c d&acirc;y.</p>\r\n\r\n<p>Ch&uacute;ng t&ocirc;i khuy&ecirc;n bạn n&ecirc;n đặt một chiếc ghế d&agrave;i để TV rộng hơn một ch&uacute;t so với chiếc TV được đặt tr&ecirc;n đ&oacute;. Ghế d&agrave;i TV n&agrave;y ph&ugrave; hợp với TV c&oacute; k&iacute;ch thước l&ecirc;n đến 63 inch. Bạn c&oacute; thể chọn một chiếc TV lớn hơn nếu n&oacute; kh&ocirc;ng nặng hơn tải trọng tối đa được chỉ định cho đầu của băng ghế dự bị.</p>\r\n\r\n<p>Mặt tr&ecirc;n của băng ghế dự bị TV d&agrave;nh cho TV c&oacute; trọng lượng tối đa l&agrave; 66 lbs.</p>\r\n\r\n<p>Vật liệu tường kh&aacute;c nhau đ&ograve;i hỏi c&aacute;c loại ốc v&iacute;t kh&aacute;c nhau. Sử dụng d&acirc;y buộc ph&ugrave; hợp với c&aacute;c bức tường trong nh&agrave; của bạn.</p>\r\n\r\n<p>Phối hợp với c&aacute;c sản phẩm kh&aacute;c trong d&ograve;ng LACK.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nIKEA của Thụy Điển</p>', 2, NULL, '97', 1700000, 2500000, 3000000, 1000, 1, '2022-06-02 02:31:46', '2022-06-02 02:32:03', 96),
(98, 'Kệ Hemnes', 11, 'Vẻ đẹp bền vững từ gỗ thông rắn có nguồn gốc bền vững, một loại vật liệu tự nhiên và có thể tái tạo trở nên đẹp hơn theo từng năm. Thích không? Kết hợp với các sản phẩm khác trong dòng HEMNES.', '<p>Gỗ rắn chắc c&oacute; cảm gi&aacute;c tự nhi&ecirc;n.</p>\r\n\r\n<p>C&aacute;c ngăn k&eacute;o lớn gi&uacute;p bạn dễ d&agrave;ng cất giữ đồ đạc ngăn nắp.</p>\r\n\r\n<p>Ch&uacute;ng t&ocirc;i khuy&ecirc;n bạn n&ecirc;n đặt một chiếc ghế d&agrave;i để TV rộng hơn một ch&uacute;t so với chiếc TV được đặt tr&ecirc;n đ&oacute;. Ghế d&agrave;i TV n&agrave;y ph&ugrave; hợp với TV c&oacute; k&iacute;ch thước l&ecirc;n đến 58 inch. Bạn c&oacute; thể chọn một chiếc TV lớn hơn nếu n&oacute; kh&ocirc;ng nặng hơn tải trọng tối đa được chỉ định cho đầu của băng ghế dự bị.</p>\r\n\r\n<p>Tấm tr&ecirc;n c&ugrave;ng của băng ghế dự bị TV d&agrave;nh cho TV c&oacute; trọng lượng tối đa l&agrave; 110 lbs.</p>\r\n\r\n<p>Bao gồm n&uacute;m.</p>\r\n\r\n<p>Phối hợp với c&aacute;c đồ nội thất kh&aacute;c trong chuỗi HEMNES.</p>\r\n\r\n<p>Vật liệu tường kh&aacute;c nhau đ&ograve;i hỏi c&aacute;c loại ốc v&iacute;t kh&aacute;c nhau. Sử dụng d&acirc;y buộc ph&ugrave; hợp với c&aacute;c bức tường trong nh&agrave; của bạn.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nCarina Bengs</p>', 2, NULL, '98', 6000000, 7000000, 8000000, 1000, 1, '2022-06-02 02:40:47', '2022-06-02 02:46:18', 32),
(99, 'Kệ Hemnes Trắng', 11, 'Vẻ đẹp bền vững từ gỗ thông rắn có nguồn gốc bền vững, một loại vật liệu tự nhiên và có thể tái tạo trở nên đẹp hơn theo từng năm. Thích không? Kết hợp với các sản phẩm khác trong dòng HEMNES.', '<p>Gỗ rắn chắc c&oacute; cảm gi&aacute;c tự nhi&ecirc;n.</p>\r\n\r\n<p>C&aacute;c ngăn k&eacute;o lớn gi&uacute;p bạn dễ d&agrave;ng cất giữ đồ đạc ngăn nắp.</p>\r\n\r\n<p>Ch&uacute;ng t&ocirc;i khuy&ecirc;n bạn n&ecirc;n đặt một chiếc ghế d&agrave;i để TV rộng hơn một ch&uacute;t so với chiếc TV được đặt tr&ecirc;n đ&oacute;. Ghế d&agrave;i TV n&agrave;y ph&ugrave; hợp với TV c&oacute; k&iacute;ch thước l&ecirc;n đến 58 inch. Bạn c&oacute; thể chọn một chiếc TV lớn hơn nếu n&oacute; kh&ocirc;ng nặng hơn tải trọng tối đa được chỉ định cho đầu của băng ghế dự bị.</p>\r\n\r\n<p>Tấm tr&ecirc;n c&ugrave;ng của băng ghế dự bị TV d&agrave;nh cho TV c&oacute; trọng lượng tối đa l&agrave; 110 lbs.</p>\r\n\r\n<p>Bao gồm n&uacute;m.</p>\r\n\r\n<p>Phối hợp với c&aacute;c đồ nội thất kh&aacute;c trong chuỗi HEMNES.</p>\r\n\r\n<p>Vật liệu tường kh&aacute;c nhau đ&ograve;i hỏi c&aacute;c loại ốc v&iacute;t kh&aacute;c nhau. Sử dụng d&acirc;y buộc ph&ugrave; hợp với c&aacute;c bức tường trong nh&agrave; của bạn.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nCarina Bengs</p>', 2, NULL, '99', 6000000, 7000000, 8000000, 1000, 1, '2022-06-02 02:42:10', '2022-06-02 02:46:27', 98),
(100, 'Kệ Hemnes Nâu Trắng', 11, 'Vẻ đẹp bền vững từ gỗ thông rắn có nguồn gốc bền vững, một loại vật liệu tự nhiên và có thể tái tạo trở nên đẹp hơn theo từng năm. Thích không? Kết hợp với các sản phẩm khác trong dòng HEMNES.', '<p>Gỗ rắn chắc c&oacute; cảm gi&aacute;c tự nhi&ecirc;n.</p>\r\n\r\n<p>C&aacute;c ngăn k&eacute;o lớn gi&uacute;p bạn dễ d&agrave;ng cất giữ đồ đạc ngăn nắp.</p>\r\n\r\n<p>Ch&uacute;ng t&ocirc;i khuy&ecirc;n bạn n&ecirc;n đặt một chiếc ghế d&agrave;i để TV rộng hơn một ch&uacute;t so với chiếc TV được đặt tr&ecirc;n đ&oacute;. Ghế d&agrave;i TV n&agrave;y ph&ugrave; hợp với TV c&oacute; k&iacute;ch thước l&ecirc;n đến 58 inch. Bạn c&oacute; thể chọn một chiếc TV lớn hơn nếu n&oacute; kh&ocirc;ng nặng hơn tải trọng tối đa được chỉ định cho đầu của băng ghế dự bị.</p>\r\n\r\n<p>Tấm tr&ecirc;n c&ugrave;ng của băng ghế dự bị TV d&agrave;nh cho TV c&oacute; trọng lượng tối đa l&agrave; 110 lbs.</p>\r\n\r\n<p>Bao gồm n&uacute;m.</p>\r\n\r\n<p>Phối hợp với c&aacute;c đồ nội thất kh&aacute;c trong chuỗi HEMNES.</p>\r\n\r\n<p>Vật liệu tường kh&aacute;c nhau đ&ograve;i hỏi c&aacute;c loại ốc v&iacute;t kh&aacute;c nhau. Sử dụng d&acirc;y buộc ph&ugrave; hợp với c&aacute;c bức tường trong nh&agrave; của bạn.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nCarina Bengs</p>', 2, NULL, '100', 6000000, 7000000, 8000000, 1000, 1, '2022-06-02 02:44:11', '2022-06-02 02:46:35', 98),
(101, 'Kệ Hemnes Xám', 11, 'Vẻ đẹp bền vững từ gỗ thông rắn có nguồn gốc bền vững, một loại vật liệu tự nhiên và có thể tái tạo trở nên đẹp hơn theo từng năm. Thích không? Kết hợp với các sản phẩm khác trong dòng HEMNES.', '<p>Gỗ rắn chắc c&oacute; cảm gi&aacute;c tự nhi&ecirc;n.</p>\r\n\r\n<p>C&aacute;c ngăn k&eacute;o lớn gi&uacute;p bạn dễ d&agrave;ng cất giữ đồ đạc ngăn nắp.</p>\r\n\r\n<p>Ch&uacute;ng t&ocirc;i khuy&ecirc;n bạn n&ecirc;n đặt một chiếc ghế d&agrave;i để TV rộng hơn một ch&uacute;t so với chiếc TV được đặt tr&ecirc;n đ&oacute;. Ghế d&agrave;i TV n&agrave;y ph&ugrave; hợp với TV c&oacute; k&iacute;ch thước l&ecirc;n đến 58 inch. Bạn c&oacute; thể chọn một chiếc TV lớn hơn nếu n&oacute; kh&ocirc;ng nặng hơn tải trọng tối đa được chỉ định cho đầu của băng ghế dự bị.</p>\r\n\r\n<p>Tấm tr&ecirc;n c&ugrave;ng của băng ghế dự bị TV d&agrave;nh cho TV c&oacute; trọng lượng tối đa l&agrave; 110 lbs.</p>\r\n\r\n<p>Bao gồm n&uacute;m.</p>\r\n\r\n<p>Phối hợp với c&aacute;c đồ nội thất kh&aacute;c trong chuỗi HEMNES.</p>\r\n\r\n<p>Vật liệu tường kh&aacute;c nhau đ&ograve;i hỏi c&aacute;c loại ốc v&iacute;t kh&aacute;c nhau. Sử dụng d&acirc;y buộc ph&ugrave; hợp với c&aacute;c bức tường trong nh&agrave; của bạn.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nCarina Bengs</p>', 2, NULL, '101', 6000000, 7000000, 8000000, 1000, 1, '2022-06-02 02:45:51', '2022-06-02 02:46:44', 98),
(102, 'Kệ Lommarp', 11, 'Loạt lưu trữ này được lấy cảm hứng từ nghề mộc truyền thống, kết hợp phong cách và chức năng cho lối sống đô thị ngày nay. Sử dụng nó bất cứ nơi nào bạn cần lưu trữ - và kết hợp với các đồ nội thất khác để có một cái nhìn cá nhân.', '<p><br />\r\nThiết kế gi&uacute;p m&oacute;n đồ nội thất n&agrave;y dễ d&agrave;ng đặt, dễ sử dụng cho nhiều nhu cầu kh&aacute;c nhau v&agrave; dễ kết hợp với c&aacute;c đồ nội thất kh&aacute;c.</p>\r\n\r\n<p>C&aacute;c ngăn kệ c&oacute; thể điều chỉnh gi&uacute;p bạn dễ d&agrave;ng t&ugrave;y chỉnh kh&ocirc;ng gian theo &yacute; muốn.</p>\r\n\r\n<p>Thật dễ d&agrave;ng để giữ d&acirc;y khỏi TV v&agrave; c&aacute;c thiết bị kh&aacute;c của bạn ở nơi khuất tầm nh&igrave;n nhưng h&atilde;y đ&oacute;ng lại trong tầm tay, v&igrave; c&oacute; một số ổ cắm d&acirc;y ở ph&iacute;a sau băng ghế TV.</p>\r\n\r\n<p>Ổ cắm c&aacute;p ở ph&iacute;a sau băng ghế TV gi&uacute;p bạn dễ d&agrave;ng tập hợp v&agrave; sắp xếp tất cả c&aacute;c d&acirc;y.</p>\r\n\r\n<p>Sự kết hợp giữa lưu trữ mở v&agrave; lưu trữ ẩn gi&uacute;p bạn dễ d&agrave;ng sắp xếp c&aacute;c điều khiển từ xa v&agrave; c&aacute;c phụ kiện TV kh&aacute;c.</p>\r\n\r\n<p>Ngăn k&eacute;o đ&oacute;ng &ecirc;m v&agrave; nhẹ nh&agrave;ng nhờ được t&iacute;ch hợp chức năng đ&oacute;ng mở nhẹ nh&agrave;ng.</p>\r\n\r\n<p>Bề mặt bền v&agrave; dễ d&agrave;ng giữ sạch.</p>\r\n\r\n<p>Ch&uacute;ng t&ocirc;i khuy&ecirc;n bạn n&ecirc;n đặt một chiếc ghế d&agrave;i để TV rộng hơn một ch&uacute;t so với chiếc TV được đặt tr&ecirc;n đ&oacute;. Ghế d&agrave;i TV n&agrave;y ph&ugrave; hợp với TV c&oacute; k&iacute;ch thước l&ecirc;n đến 63 inch. Bạn c&oacute; thể chọn một chiếc TV lớn hơn nếu n&oacute; kh&ocirc;ng nặng hơn tải trọng tối đa được chỉ định cho đầu của băng ghế dự bị.</p>\r\n\r\n<p>Tấm tr&ecirc;n c&ugrave;ng của băng ghế dự bị TV d&agrave;nh cho TV c&oacute; trọng lượng tối đa l&agrave; 110 lbs.</p>\r\n\r\n<p>Vật liệu tường kh&aacute;c nhau đ&ograve;i hỏi c&aacute;c loại ốc v&iacute;t kh&aacute;c nhau. Sử dụng d&acirc;y buộc ph&ugrave; hợp với c&aacute;c bức tường trong nh&agrave; của bạn.</p>\r\n\r\n<p>Cần c&oacute; hai người để lắp r&aacute;p đồ nội thất n&agrave;y.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nFrancis Cayouette</p>', 2, NULL, '102', 9500000, 11000000, 12000000, 1000, 1, '2022-06-02 02:53:52', '2022-06-02 02:58:16', 32),
(103, 'Kệ Lommarp Sữa', 11, 'Loạt lưu trữ này được lấy cảm hứng từ nghề mộc truyền thống, kết hợp phong cách và chức năng cho lối sống đô thị ngày nay. Sử dụng nó bất cứ nơi nào bạn cần lưu trữ - và kết hợp với các đồ nội thất khác để có một cái nhìn cá nhân.', '<p><br />\r\nThiết kế gi&uacute;p m&oacute;n đồ nội thất n&agrave;y dễ d&agrave;ng đặt, dễ sử dụng cho nhiều nhu cầu kh&aacute;c nhau v&agrave; dễ kết hợp với c&aacute;c đồ nội thất kh&aacute;c.</p>\r\n\r\n<p>C&aacute;c ngăn kệ c&oacute; thể điều chỉnh gi&uacute;p bạn dễ d&agrave;ng t&ugrave;y chỉnh kh&ocirc;ng gian theo &yacute; muốn.</p>\r\n\r\n<p>Thật dễ d&agrave;ng để giữ d&acirc;y khỏi TV v&agrave; c&aacute;c thiết bị kh&aacute;c của bạn ở nơi khuất tầm nh&igrave;n nhưng h&atilde;y đ&oacute;ng lại trong tầm tay, v&igrave; c&oacute; một số ổ cắm d&acirc;y ở ph&iacute;a sau băng ghế TV.</p>\r\n\r\n<p>Ổ cắm c&aacute;p ở ph&iacute;a sau băng ghế TV gi&uacute;p bạn dễ d&agrave;ng tập hợp v&agrave; sắp xếp tất cả c&aacute;c d&acirc;y.</p>\r\n\r\n<p>Sự kết hợp giữa lưu trữ mở v&agrave; lưu trữ ẩn gi&uacute;p bạn dễ d&agrave;ng sắp xếp c&aacute;c điều khiển từ xa v&agrave; c&aacute;c phụ kiện TV kh&aacute;c.</p>\r\n\r\n<p>Ngăn k&eacute;o đ&oacute;ng &ecirc;m v&agrave; nhẹ nh&agrave;ng nhờ được t&iacute;ch hợp chức năng đ&oacute;ng mở nhẹ nh&agrave;ng.</p>\r\n\r\n<p>Bề mặt bền v&agrave; dễ d&agrave;ng giữ sạch.</p>\r\n\r\n<p>Ch&uacute;ng t&ocirc;i khuy&ecirc;n bạn n&ecirc;n đặt một chiếc ghế d&agrave;i để TV rộng hơn một ch&uacute;t so với chiếc TV được đặt tr&ecirc;n đ&oacute;. Ghế d&agrave;i TV n&agrave;y ph&ugrave; hợp với TV c&oacute; k&iacute;ch thước l&ecirc;n đến 63 inch. Bạn c&oacute; thể chọn một chiếc TV lớn hơn nếu n&oacute; kh&ocirc;ng nặng hơn tải trọng tối đa được chỉ định cho đầu của băng ghế dự bị.</p>\r\n\r\n<p>Tấm tr&ecirc;n c&ugrave;ng của băng ghế dự bị TV d&agrave;nh cho TV c&oacute; trọng lượng tối đa l&agrave; 110 lbs.</p>\r\n\r\n<p>Vật liệu tường kh&aacute;c nhau đ&ograve;i hỏi c&aacute;c loại ốc v&iacute;t kh&aacute;c nhau. Sử dụng d&acirc;y buộc ph&ugrave; hợp với c&aacute;c bức tường trong nh&agrave; của bạn.</p>\r\n\r\n<p>Cần c&oacute; hai người để lắp r&aacute;p đồ nội thất n&agrave;y.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nFrancis Cayouette</p>', 2, NULL, '103', 9500000, 11000000, 12000000, 1000, 1, '2022-06-02 02:56:26', '2022-06-02 02:58:33', 102),
(104, 'Kệ Lommarp Xanh', 11, 'Loạt lưu trữ này được lấy cảm hứng từ nghề mộc truyền thống, kết hợp phong cách và chức năng cho lối sống đô thị ngày nay. Sử dụng nó bất cứ nơi nào bạn cần lưu trữ - và kết hợp với các đồ nội thất khác để có một cái nhìn cá nhân.', '<p><br />\r\nThiết kế gi&uacute;p m&oacute;n đồ nội thất n&agrave;y dễ d&agrave;ng đặt, dễ sử dụng cho nhiều nhu cầu kh&aacute;c nhau v&agrave; dễ kết hợp với c&aacute;c đồ nội thất kh&aacute;c.</p>\r\n\r\n<p>C&aacute;c ngăn kệ c&oacute; thể điều chỉnh gi&uacute;p bạn dễ d&agrave;ng t&ugrave;y chỉnh kh&ocirc;ng gian theo &yacute; muốn.</p>\r\n\r\n<p>Thật dễ d&agrave;ng để giữ d&acirc;y khỏi TV v&agrave; c&aacute;c thiết bị kh&aacute;c của bạn ở nơi khuất tầm nh&igrave;n nhưng h&atilde;y đ&oacute;ng lại trong tầm tay, v&igrave; c&oacute; một số ổ cắm d&acirc;y ở ph&iacute;a sau băng ghế TV.</p>\r\n\r\n<p>Ổ cắm c&aacute;p ở ph&iacute;a sau băng ghế TV gi&uacute;p bạn dễ d&agrave;ng tập hợp v&agrave; sắp xếp tất cả c&aacute;c d&acirc;y.</p>\r\n\r\n<p>Sự kết hợp giữa lưu trữ mở v&agrave; lưu trữ ẩn gi&uacute;p bạn dễ d&agrave;ng sắp xếp c&aacute;c điều khiển từ xa v&agrave; c&aacute;c phụ kiện TV kh&aacute;c.</p>\r\n\r\n<p>Ngăn k&eacute;o đ&oacute;ng &ecirc;m v&agrave; nhẹ nh&agrave;ng nhờ được t&iacute;ch hợp chức năng đ&oacute;ng mở nhẹ nh&agrave;ng.</p>\r\n\r\n<p>Bề mặt bền v&agrave; dễ d&agrave;ng giữ sạch.</p>\r\n\r\n<p>Ch&uacute;ng t&ocirc;i khuy&ecirc;n bạn n&ecirc;n đặt một chiếc ghế d&agrave;i để TV rộng hơn một ch&uacute;t so với chiếc TV được đặt tr&ecirc;n đ&oacute;. Ghế d&agrave;i TV n&agrave;y ph&ugrave; hợp với TV c&oacute; k&iacute;ch thước l&ecirc;n đến 63 inch. Bạn c&oacute; thể chọn một chiếc TV lớn hơn nếu n&oacute; kh&ocirc;ng nặng hơn tải trọng tối đa được chỉ định cho đầu của băng ghế dự bị.</p>\r\n\r\n<p>Tấm tr&ecirc;n c&ugrave;ng của băng ghế dự bị TV d&agrave;nh cho TV c&oacute; trọng lượng tối đa l&agrave; 110 lbs.</p>\r\n\r\n<p>Vật liệu tường kh&aacute;c nhau đ&ograve;i hỏi c&aacute;c loại ốc v&iacute;t kh&aacute;c nhau. Sử dụng d&acirc;y buộc ph&ugrave; hợp với c&aacute;c bức tường trong nh&agrave; của bạn.</p>\r\n\r\n<p>Cần c&oacute; hai người để lắp r&aacute;p đồ nội thất n&agrave;y.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nFrancis Cayouette</p>', 2, NULL, '104', 9500000, 11000000, 12000000, 1000, 1, '2022-06-02 02:58:00', '2022-06-02 03:01:23', 102),
(105, 'Tủ Rudsta', 12, 'Chiếc tủ cửa kính này giúp tăng gấp đôi cách trưng bày những thứ bạn yêu thích. Bạn có thể đặt các vật dụng trên giá và cố định những thứ như ảnh vào mặt sau bằng nam châm để lưu giữ những kỷ niệm thân yêu.', '<p><br />\r\nTận hưởng tủ c&aacute; nh&acirc;n chứa nhiều kỷ niệm - đặt những thứ bạn y&ecirc;u th&iacute;ch nhất l&ecirc;n gi&aacute; v&agrave; d&ugrave;ng nam ch&acirc;m để gắn ảnh, bản vẽ v&agrave; những thứ đ&aacute;ng y&ecirc;u kh&aacute;c v&agrave;o mặt sau của tủ.</p>\r\n\r\n<p>Bạn c&oacute; thể dễ d&agrave;ng bổ sung cho tủ cửa k&iacute;nh của m&igrave;nh với hệ thống chiếu s&aacute;ng t&iacute;ch hợp v&igrave; n&oacute; được chuẩn bị cho việc quản l&yacute; c&aacute;p.</p>\r\n\r\n<p>Tủ c&oacute; thể được kh&oacute;a bằng ổ kh&oacute;a ti&ecirc;u chuẩn để bạn c&oacute; thể cất giữ đồ đạc của m&igrave;nh một c&aacute;ch an to&agrave;n.</p>\r\n\r\n<p>Bạn c&oacute; thể gắn nam ch&acirc;m v&agrave;o bề mặt kim loại v&agrave; sử dụng n&oacute; như một bảng ghim.</p>\r\n\r\n<p>Ổn định tr&ecirc;n s&agrave;n kh&ocirc;ng bằng phẳng, nhờ v&agrave;o ch&acirc;n điều chỉnh.</p>\r\n\r\n<p>Vật liệu tường kh&aacute;c nhau đ&ograve;i hỏi c&aacute;c loại ốc v&iacute;t kh&aacute;c nhau. Sử dụng d&acirc;y buộc ph&ugrave; hợp với c&aacute;c bức tường trong nh&agrave; của bạn.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nH Preutz / F Wiersma</p>\r\n\r\n<p>Khung / Bảng tr&ecirc;n c&ugrave;ng / Mặt sau / Kệ cố định:<br />\r\nTh&eacute;p, sơn tĩnh điện Epoxy / polyester</p>\r\n\r\n<p>Gi&aacute; đỡ / Đai ốc ch&egrave;n / Tay cầm:<br />\r\nTh&eacute;p</p>\r\n\r\n<p>Bảng điều khiển b&ecirc;n / Cửa:<br />\r\nNh&ocirc;m, sơn tĩnh điện Epoxy / polyester, k&iacute;nh cường lực</p>\r\n\r\n<p>Kết nối:<br />\r\nTh&eacute;p mạ kẽm, th&eacute;p mạ kẽm</p>\r\n\r\n<p>Lớp bảo vệ:<br />\r\nCao su tổng hợp</p>\r\n\r\n<p>C&aacute;i kệ:<br />\r\nK&iacute;nh cường lực</p>\r\n\r\n<p>Nắp che:<br />\r\nPolypropylene</p>\r\n\r\n<p>Thủy tinh<br />\r\nLau sạch bằng vải ẩm. Chỉ sử dụng nước hoặc chất tẩy rửa cửa sổ.</p>\r\n\r\n<p>Lau kh&ocirc; bằng khăn sạch.</p>\r\n\r\n<p>Khung<br />\r\nLau sạch bằng khăn ẩm v&agrave; chất tẩy rửa nhẹ.</p>\r\n\r\n<p>Lau kh&ocirc; bằng khăn sạch.</p>', 2, NULL, '105', 3500000, 4500000, 5000000, 1000, 1, '2022-06-03 00:42:46', '2022-06-03 00:42:59', 33),
(106, 'Tủ Billy', 12, 'Người ta ước tính rằng cứ năm giây, một tủ sách BILLY được bán ở một nơi nào đó trên thế giới. Khá ấn tượng khi chúng tôi ra mắt BILLY vào năm 1979. Đó là sự lựa chọn của những người viết sách không bao giờ lỗi thời.', '<p>Tủ c&oacute; cửa k&iacute;nh gi&uacute;p những m&oacute;n đồ y&ecirc;u th&iacute;ch của bạn kh&ocirc;ng bị b&aacute;m bụi m&agrave; vẫn c&oacute; thể nh&igrave;n thấy được.</p>\r\n\r\n<p>Một đơn vị đơn giản c&oacute; thể đủ lưu trữ cho một kh&ocirc;ng gian hạn chế hoặc l&agrave; nền tảng cho giải ph&aacute;p lưu trữ lớn hơn nếu nhu cầu của bạn thay đổi.</p>\r\n\r\n<p>C&aacute;c kệ c&oacute; thể điều chỉnh c&oacute; thể được sắp xếp theo nhu cầu của bạn.</p>\r\n\r\n<p>5 kệ bao gồm.</p>\r\n\r\n<p>Vật liệu tường kh&aacute;c nhau đ&ograve;i hỏi c&aacute;c loại ốc v&iacute;t kh&aacute;c nhau. Sử dụng d&acirc;y buộc ph&ugrave; hợp với c&aacute;c bức tường trong nh&agrave; của bạn.</p>\r\n\r\n<p>Tối thiểu. chiều cao trần y&ecirc;u cầu: 80&frac34; &rdquo;.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nGillis Lundgren</p>\r\n\r\n<p>Phần ch&iacute;nh:<br />\r\nV&aacute;n dăm, giấy bạc</p>\r\n\r\n<p>Mặt sau:<br />\r\nV&aacute;n sợi, sơn acrylic in</p>\r\n\r\n<p>Khung cửa k&iacute;nh:<br />\r\nV&aacute;n sợi, Giấy bạc, Viền nhựa</p>\r\n\r\n<p>Tấm k&iacute;nh:<br />\r\nK&iacute;nh cường lực</p>\r\n\r\n<p>Khung<br />\r\nLau sạch bằng khăn ẩm v&agrave; chất tẩy rửa nhẹ.</p>\r\n\r\n<p>Lau kh&ocirc; bằng khăn sạch.</p>\r\n\r\n<p>Thủy tinh<br />\r\nLau sạch bằng vải ẩm. Chỉ sử dụng nước hoặc chất tẩy rửa cửa sổ.</p>\r\n\r\n<p>Lau kh&ocirc; bằng khăn sạch.</p>', 2, NULL, '106', 5000000, 6000000, 7000000, 1000, 1, '2022-06-03 01:00:40', '2022-06-03 01:03:57', 33),
(107, 'Tủ Billy Sữa', 12, 'Người ta ước tính rằng cứ năm giây, một tủ sách BILLY được bán ở một nơi nào đó trên thế giới. Khá ấn tượng khi chúng tôi ra mắt BILLY vào năm 1979. Đó là sự lựa chọn của những người viết sách không bao giờ lỗi thời.', '<p>Tủ c&oacute; cửa k&iacute;nh gi&uacute;p những m&oacute;n đồ y&ecirc;u th&iacute;ch của bạn kh&ocirc;ng bị b&aacute;m bụi m&agrave; vẫn c&oacute; thể nh&igrave;n thấy được.</p>\r\n\r\n<p>Một đơn vị đơn giản c&oacute; thể đủ lưu trữ cho một kh&ocirc;ng gian hạn chế hoặc l&agrave; nền tảng cho giải ph&aacute;p lưu trữ lớn hơn nếu nhu cầu của bạn thay đổi.</p>\r\n\r\n<p>C&aacute;c kệ c&oacute; thể điều chỉnh c&oacute; thể được sắp xếp theo nhu cầu của bạn.</p>\r\n\r\n<p>5 kệ bao gồm.</p>\r\n\r\n<p>Vật liệu tường kh&aacute;c nhau đ&ograve;i hỏi c&aacute;c loại ốc v&iacute;t kh&aacute;c nhau. Sử dụng d&acirc;y buộc ph&ugrave; hợp với c&aacute;c bức tường trong nh&agrave; của bạn.</p>\r\n\r\n<p>Tối thiểu. chiều cao trần y&ecirc;u cầu: 80&frac34; &rdquo;.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nGillis Lundgren</p>\r\n\r\n<p>Phần ch&iacute;nh:<br />\r\nV&aacute;n dăm, giấy bạc</p>\r\n\r\n<p>Mặt sau:<br />\r\nV&aacute;n sợi, sơn acrylic in</p>\r\n\r\n<p>Khung cửa k&iacute;nh:<br />\r\nV&aacute;n sợi, Giấy bạc, Viền nhựa</p>\r\n\r\n<p>Tấm k&iacute;nh:<br />\r\nK&iacute;nh cường lực</p>\r\n\r\n<p>Khung<br />\r\nLau sạch bằng khăn ẩm v&agrave; chất tẩy rửa nhẹ.</p>\r\n\r\n<p>Lau kh&ocirc; bằng khăn sạch.</p>\r\n\r\n<p>Thủy tinh<br />\r\nLau sạch bằng vải ẩm. Chỉ sử dụng nước hoặc chất tẩy rửa cửa sổ.</p>\r\n\r\n<p>Lau kh&ocirc; bằng khăn sạch.</p>', 2, NULL, '107', 5000000, 6000000, 7000000, 1000, 1, '2022-06-03 01:02:27', '2022-06-03 01:04:05', 106),
(108, 'Tủ Billy Xanh', 12, 'Người ta ước tính rằng cứ năm giây, một tủ sách BILLY được bán ở một nơi nào đó trên thế giới. Khá ấn tượng khi chúng tôi ra mắt BILLY vào năm 1979. Đó là sự lựa chọn của những người viết sách không bao giờ lỗi thời.', '<p>Tủ c&oacute; cửa k&iacute;nh gi&uacute;p những m&oacute;n đồ y&ecirc;u th&iacute;ch của bạn kh&ocirc;ng bị b&aacute;m bụi m&agrave; vẫn c&oacute; thể nh&igrave;n thấy được.</p>\r\n\r\n<p>Một đơn vị đơn giản c&oacute; thể đủ lưu trữ cho một kh&ocirc;ng gian hạn chế hoặc l&agrave; nền tảng cho giải ph&aacute;p lưu trữ lớn hơn nếu nhu cầu của bạn thay đổi.</p>\r\n\r\n<p>C&aacute;c kệ c&oacute; thể điều chỉnh c&oacute; thể được sắp xếp theo nhu cầu của bạn.</p>\r\n\r\n<p>5 kệ bao gồm.</p>\r\n\r\n<p>Vật liệu tường kh&aacute;c nhau đ&ograve;i hỏi c&aacute;c loại ốc v&iacute;t kh&aacute;c nhau. Sử dụng d&acirc;y buộc ph&ugrave; hợp với c&aacute;c bức tường trong nh&agrave; của bạn.</p>\r\n\r\n<p>Tối thiểu. chiều cao trần y&ecirc;u cầu: 80&frac34; &rdquo;.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nGillis Lundgren</p>\r\n\r\n<p>Phần ch&iacute;nh:<br />\r\nV&aacute;n dăm, giấy bạc</p>\r\n\r\n<p>Mặt sau:<br />\r\nV&aacute;n sợi, sơn acrylic in</p>\r\n\r\n<p>Khung cửa k&iacute;nh:<br />\r\nV&aacute;n sợi, Giấy bạc, Viền nhựa</p>\r\n\r\n<p>Tấm k&iacute;nh:<br />\r\nK&iacute;nh cường lực</p>\r\n\r\n<p>Khung<br />\r\nLau sạch bằng khăn ẩm v&agrave; chất tẩy rửa nhẹ.</p>\r\n\r\n<p>Lau kh&ocirc; bằng khăn sạch.</p>\r\n\r\n<p>Thủy tinh<br />\r\nLau sạch bằng vải ẩm. Chỉ sử dụng nước hoặc chất tẩy rửa cửa sổ.</p>\r\n\r\n<p>Lau kh&ocirc; bằng khăn sạch.</p>', 2, NULL, '108', 5000000, 6000000, 7000000, 1000, 1, '2022-06-03 01:03:44', '2022-06-03 01:04:11', 106),
(109, 'Tủ Syvde', 12, 'Nơi trưng bày những thứ tốt nhất của bạn, giữ chúng an toàn và không có bụi - và cửa trượt không chiếm bất kỳ không gian nào khi mở. Tủ SYVDE có cửa kính là người bạn đồng hành hoàn hảo cho tủ MALM 6 ngăn kéo.', '<p>Cửa k&iacute;nh cho ph&eacute;p bạn nh&igrave;n thấy những thứ của m&igrave;nh, đồng thời bảo vệ ch&uacute;ng khỏi bụi.</p>\r\n\r\n<p>Cửa trượt cho ph&eacute;p nhiều kh&ocirc;ng gian hơn cho đồ đạc v&igrave; ch&uacute;ng kh&ocirc;ng tốn bất kỳ kh&ocirc;ng gian n&agrave;o để mở.</p>\r\n\r\n<p>C&aacute;c ngăn kệ c&oacute; thể điều chỉnh gi&uacute;p bạn dễ d&agrave;ng t&ugrave;y chỉnh kh&ocirc;ng gian theo &yacute; muốn.</p>\r\n\r\n<p>Tủ SYVDE c&oacute; cửa k&iacute;nh l&agrave; người bạn đồng h&agrave;nh ho&agrave;n hảo cho tủ MALM 6 ngăn k&eacute;o.</p>\r\n\r\n<p>vật liệu tường kh&aacute;c nhau đ&ograve;i hỏi c&aacute;c loại kh&aacute;c nhau của việc sửa c&aacute;c thiết bị. Sử dụng c&aacute;c thiết bị cố định ph&ugrave; hợp với c&aacute;c bức tường trong nh&agrave; của bạn.</p>\r\n\r\n<p>Giữ tối thiểu 16 đ&ocirc;i gi&agrave;y.</p>\r\n\r\n<p>Một kệ chứa khoảng 20 chiếc quần gấp hoặc 40 chiếc &aacute;o ph&ocirc;ng.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nIKEA của Thụy Điển</p>\r\n\r\n<p>Bảng điều khiển tr&ecirc;n c&ugrave;ng / Bảng điều khiển dưới c&ugrave;ng / Gi&aacute;:<br />\r\nV&aacute;n dăm, Sơn acrylic, Giấy bạc, Viền nhựa</p>\r\n\r\n<p>Bảng điều khiển b&ecirc;n:<br />\r\nV&aacute;n dăm, Sơn acrylic, Viền nhựa</p>\r\n\r\n<p>Mặt sau / Thanh trước / Thanh sau / Khung cửa:<br />\r\nV&aacute;n sợi, sơn acrylic</p>\r\n\r\n<p>Mặt trước Plinth:<br />\r\nV&aacute;n dăm, sơn acrylic</p>\r\n\r\n<p>Plinth trở lại:<br />\r\nV&aacute;n dăm</p>\r\n\r\n<p>L&agrave;m đầy cửa:<br />\r\nK&iacute;nh cường lực</p>\r\n\r\n<p>Lau sạch bằng khăn ẩm v&agrave; chất tẩy rửa nhẹ.</p>\r\n\r\n<p>Lau kh&ocirc; bằng khăn sạch.</p>', 2, NULL, '109', 4500000, 5500000, 6000000, 1000, 1, '2022-06-03 01:08:10', '2022-06-03 01:08:25', 33),
(110, 'Tủ Idanas', 12, 'Dòng IDANÄS kết hợp thiết kế vượt thời gian với chức năng hiện đại. Tủ IDANÄS này có cửa kính hai lớp làm tăng thêm vẻ sang trọng cho ngôi nhà của bạn. Các chi tiết được thiết kế cẩn thận bằng gỗ nguyên khối và các góc cạnh tạo cho đồ nội thất một cảm giác chân thực.', '<p><br />\r\nTạo một ng&ocirc;i nh&agrave; phối hợp bằng c&aacute;ch kết hợp tủ n&agrave;y với c&aacute;c đồ nội thất kh&aacute;c từ d&ograve;ng IDAN&Auml;S.</p>\r\n\r\n<p>Lắp r&aacute;p nhanh ch&oacute;ng v&agrave; dễ d&agrave;ng, nhờ chốt n&ecirc;m c&oacute; thể nhấp v&agrave;o c&aacute;c lỗ đ&atilde; khoan sẵn.</p>\r\n\r\n<p>Cấu tr&uacute;c gấp gọn s&aacute;ng tạo gi&uacute;p bạn lắp r&aacute;p c&aacute;c ngăn k&eacute;o một c&aacute;ch nhanh ch&oacute;ng v&agrave; dễ d&agrave;ng.</p>\r\n\r\n<p>Cửa xếp gi&uacute;p bạn c&oacute; th&ecirc;m kh&ocirc;ng gian xung quanh đồ đạc v&igrave; ch&uacute;ng chiếm &iacute;t diện t&iacute;ch hơn khi mở.</p>\r\n\r\n<p>C&aacute;c ngăn kệ c&oacute; thể điều chỉnh gi&uacute;p bạn dễ d&agrave;ng t&ugrave;y chỉnh kh&ocirc;ng gian theo &yacute; muốn.</p>\r\n\r\n<p>Ch&acirc;n c&oacute; thể điều chỉnh gi&uacute;p bạn c&oacute; thể b&ugrave; đắp mọi bất thường tr&ecirc;n s&agrave;n.</p>\r\n\r\n<p>C&aacute;c ngăn k&eacute;o v&agrave; cửa đ&oacute;ng &ecirc;m v&agrave; nhẹ nh&agrave;ng nhờ được t&iacute;ch hợp chức năng đ&oacute;ng mở nhẹ nh&agrave;ng.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nFrancis Cayouette</p>\r\n\r\n<p>Bảng k&iacute;nh:<br />\r\nK&iacute;nh cường lực</p>\r\n\r\n<p>Đứng đầu:<br />\r\nGiấy phủ sợi v&agrave; giấy tổ ong (100% giấy t&aacute;i chế), sơn acrylic, sơn acrylic, sơn acrylic</p>\r\n\r\n<p>Bảng điều khiển / V&aacute;ch ngăn b&ecirc;n:<br />\r\nV&aacute;n dăm, Sơn acrylic, Viền nhựa</p>\r\n\r\n<p>Bảng điều khiển ph&iacute;a dưới / Bảng điều khiển giữa / Mặt trước kệ / Ngăn k&eacute;o:<br />\r\nV&aacute;n dăm, Sơn acrylic, Giấy bạc, Viền nhựa</p>\r\n\r\n<p>Đường sắt h&agrave;ng đầu:<br />\r\nV&aacute;n dăm, Giấy bạc, Viền nhựa</p>\r\n\r\n<p>Khung cửa / Khung dưới:<br />\r\nV&aacute;n sợi, sơn acrylic, sơn acrylic, sơn acrylic</p>\r\n\r\n<p>Ch&acirc;n:<br />\r\nGỗ rắn, keo, sơn acrylic</p>\r\n\r\n<p>Mặt sau / Mặt dưới ngăn k&eacute;o:<br />\r\nV&aacute;n sợi, giấy bạc</p>\r\n\r\n<p>Ngăn k&eacute;o b&ecirc;n / Ngăn trở lại:<br />\r\nTh&ocirc;ng rắn</p>\r\n\r\n<p>Lau sạch bằng vải ẩm.</p>\r\n\r\n<p>Lau kh&ocirc; bằng khăn sạch.</p>\r\n\r\n<p>Thường xuy&ecirc;n kiểm tra để đảm bảo rằng tất cả c&aacute;c d&acirc;y buộc lắp r&aacute;p đ&atilde; được siết chặt v&agrave; vặn lại khi cần thiết.</p>', 2, NULL, '110', 9500000, 11000000, 12000000, 1000, 1, '2022-06-03 01:14:33', '2022-06-03 01:14:46', 33),
(111, 'Đèn Floalt', 13, 'Bảng điều khiển ánh sáng mang ánh sáng đến những không gian tối nhất của bạn - kết nối một hoặc nhiều và điều khiển ánh sáng thông qua điều khiển từ xa hoặc điện thoại thông minh của bạn. Tăng hoặc giảm độ sáng và thiết lập cảnh để nấu ăn, đọc sách, xem TV hoặc làm việc.', '<p>Với bảng điều khiển &aacute;nh s&aacute;ng LED c&oacute; thể điều chỉnh độ s&aacute;ng, bạn c&oacute; thể điều chỉnh &aacute;nh s&aacute;ng của m&igrave;nh cho c&aacute;c hoạt động kh&aacute;c nhau, như &aacute;nh s&aacute;ng ấm hơn cho bữa tối v&agrave; &aacute;nh s&aacute;ng s&aacute;ng hơn, lạnh hơn để l&agrave;m việc.</p>\r\n\r\n<p>Bạn c&oacute; thể sử dụng điều khiển từ xa TR&Aring;DFRI để điều khiển tối đa 10 bảng đ&egrave;n LED, b&oacute;ng đ&egrave;n LED hoặc cửa s&aacute;ng LED sẽ phản ứng theo c&ugrave;ng một c&aacute;ch - l&agrave;m mờ, tắt, bật v&agrave; chuyển từ &aacute;nh s&aacute;ng ấm sang &aacute;nh s&aacute;ng lạnh trong 3 bước.</p>\r\n\r\n<p>Khi bạn th&ecirc;m cổng TR&Aring;DFRI v&agrave; ứng dụng th&ocirc;ng minh IKEA Home, bạn c&oacute; thể tạo một số nh&oacute;m nguồn s&aacute;ng v&agrave; điều khiển ch&uacute;ng theo c&aacute;c c&aacute;ch kh&aacute;c nhau.</p>\r\n\r\n<p>Tải xuống ứng dụng th&ocirc;ng minh IKEA Home miễn ph&iacute; qua Google Play hoặc App Store, t&ugrave;y thuộc v&agrave;o thiết bị di động bạn c&oacute;.</p>\r\n\r\n<p>Một sự lựa chọn tuyệt vời khi bạn kh&ocirc;ng c&oacute; đủ &aacute;nh s&aacute;ng tự nhi&ecirc;n ở nh&agrave; hoặc tại văn ph&ograve;ng.</p>\r\n\r\n<p>Quang th&ocirc;ng: 2800 lumen. C&ocirc;ng suất: 34 W.</p>\r\n\r\n<p>Ti&ecirc;u thụ năng lượng: 99,28 kWh / năm, nếu bảng đ&egrave;n LED s&aacute;ng l&ecirc;n đến 8hr / ng&agrave;y.</p>\r\n\r\n<p>Sản phẩm n&agrave;y cho ph&eacute;p l&agrave;m mờ kh&ocirc;ng d&acirc;y. Với Hệ thống chiếu s&aacute;ng th&ocirc;ng minh IKEA, bạn c&oacute; thể l&agrave;m mờ đ&egrave;n của m&igrave;nh m&agrave; kh&ocirc;ng cần lắp đặt c&oacute; d&acirc;y.</p>\r\n\r\n<p>Điều khiển từ xa TR&Aring;DFRI được b&aacute;n ri&ecirc;ng.</p>\r\n\r\n<p>Nguồn s&aacute;ng LED t&iacute;ch hợp c&oacute; tuổi thọ xấp xỉ. 25.000 giờ.</p>\r\n\r\n<p>Nhiệt độ m&agrave;u c&oacute; thể được chuyển đổi giữa 2200 Kelvin (s&aacute;ng ấm), 2700 Kelvin (trắng ấm) v&agrave; 4000 Kelvin (trắng lạnh).</p>\r\n\r\n<p>Hoạt động với IKEA Home th&ocirc;ng minh.</p>\r\n\r\n<p>C&oacute; thể được gắn tr&ecirc;n trần nh&agrave; hoặc tr&ecirc;n tường.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nMikael Warnhammar</p>', 3, NULL, '111', 3500000, 4500000, 5000000, 10, 1, '2022-06-07 07:39:56', '2022-06-07 07:40:11', 34),
(112, 'Đèn Lergryn', 13, 'Thông qua các lỗ của chiếc đèn đan bằng tay này, ánh sáng chiếu qua sẽ tạo ra hiệu ứng ánh sáng lan tỏa cảm giác ấm áp, êm dịu trong căn phòng.', '<p>Bạn c&oacute; thể chọn treo đ&egrave;n mặt d&acirc;y tr&ecirc;n b&agrave;n ăn hoặc gần trần nh&agrave; hơn để chiếu s&aacute;ng chung trong ph&ograve;ng.</p>\r\n\r\n<p>Dễ d&agrave;ng mang về nh&agrave; v&igrave; chao đ&egrave;n được đ&oacute;ng g&oacute;i dạng phẳng.</p>\r\n\r\n<p>Bộ d&acirc;y c&oacute; đĩa gi&uacute;p bạn dễ d&agrave;ng điều chỉnh độ d&agrave;i d&acirc;y để đ&egrave;n treo ở độ cao như &yacute; muốn.</p>\r\n\r\n<p>B&oacute;ng đ&egrave;n được b&aacute;n ri&ecirc;ng. IKEA đề xuất b&oacute;ng đ&egrave;n LED E26 m&agrave;u trắng opal to&agrave;n cầu.</p>\r\n\r\n<p>Sử dụng b&oacute;ng đ&egrave;n opal nếu bạn c&oacute; b&oacute;ng đ&egrave;n hoặc b&oacute;ng đ&egrave;n th&ocirc;ng thường v&agrave; muốn ph&acirc;n bổ &aacute;nh s&aacute;ng đồng đều, khuếch t&aacute;n.</p>\r\n\r\n<p>Xử l&yacute; chất thải đặc biệt c&oacute; thể được y&ecirc;u cầu. H&atilde;y li&ecirc;n hệ với ch&iacute;nh quyền địa phương của bạn để biết th&ecirc;m th&ocirc;ng tin.</p>\r\n\r\n<p>C&agrave;i đặt c&oacute; d&acirc;y.</p>\r\n\r\n<p>Được gắn bằng v&iacute;t.</p>\r\n\r\n<p>V&iacute;t kh&ocirc;ng được bao gồm.</p>', 3, NULL, '112', 1500000, 2500000, 300000, 100, 1, '2022-06-07 07:48:45', '2022-06-07 07:48:52', 34),
(113, 'Đèn Sodakra', 13, 'Hình dáng và ánh sáng hài hòa đẹp mắt. Đèn mặt dây chuyền theo phong cách Scandinavian này được làm bằng veneer bạch dương đúc với hình dạng mềm mại trong nhiều lớp. Cũng đẹp trên bàn ăn như trong hành lang hoặc phòng ngủ.', '<p><br />\r\nBạn c&oacute; thể chọn treo đ&egrave;n mặt d&acirc;y tr&ecirc;n b&agrave;n ăn hoặc gần trần nh&agrave; hơn để chiếu s&aacute;ng chung trong ph&ograve;ng.</p>\r\n\r\n<p>Đ&egrave;n n&agrave;y mang đến một bầu kh&ocirc;ng kh&iacute; dễ chịu cho bữa ăn, truyền &aacute;nh s&aacute;ng trực tiếp khắp b&agrave;n ăn hoặc quầy bar của bạn.</p>\r\n\r\n<p>Mỗi chiếc đ&egrave;n mặt d&acirc;y chuyền l&agrave; duy nhất v&igrave; n&oacute; được l&agrave;m bằng vật liệu tự nhi&ecirc;n bạch dương.</p>\r\n\r\n<p>B&oacute;ng đ&egrave;n được b&aacute;n ri&ecirc;ng. IKEA khuyến nghị b&oacute;ng đ&egrave;n LED E26.</p>\r\n\r\n<p>Được gắn bằng v&iacute;t.</p>\r\n\r\n<p>V&iacute;t kh&ocirc;ng được bao gồm.</p>\r\n\r\n<p>Xử l&yacute; chất thải đặc biệt c&oacute; thể được y&ecirc;u cầu. H&atilde;y li&ecirc;n hệ với ch&iacute;nh quyền địa phương của bạn để biết th&ecirc;m th&ocirc;ng tin.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nMonika Mulder</p>', 3, NULL, '113', 1500000, 2500000, 300000, 100, 1, '2022-06-07 07:54:50', '2022-06-07 07:55:03', 34),
(114, 'Đèn Regolit', 13, 'Chụp đèn tròn này được làm thủ công và lan tỏa ánh sáng đồng đều tạo cảm giác ấm cúng cho căn phòng. Một bộ dây phù hợp được bao gồm, vì vậy bạn chỉ cần hoàn thành với một bóng đèn LED.', '<p>Mỗi b&oacute;ng r&acirc;m thủ c&ocirc;ng l&agrave; duy nhất.</p>\r\n\r\n<p>Bạn c&oacute; thể tạo ra một bầu kh&ocirc;ng kh&iacute; nhẹ nh&agrave;ng, ấm c&uacute;ng trong ng&ocirc;i nh&agrave; của m&igrave;nh bằng một chiếc đ&egrave;n giấy thả đ&egrave;n khuếch t&aacute;n v&agrave; đ&egrave;n trang tr&iacute;.</p>\r\n\r\n<p>B&oacute;ng đ&egrave;n được b&aacute;n ri&ecirc;ng. IKEA khuyến nghị b&oacute;ng đ&egrave;n LED E26 m&agrave;u trắng opal to&agrave;n cầu.</p>\r\n\r\n<p>Được treo tr&ecirc;n m&oacute;c trần.</p>\r\n\r\n<p>Xử l&yacute; chất thải đặc biệt c&oacute; thể được y&ecirc;u cầu. H&atilde;y li&ecirc;n hệ với ch&iacute;nh quyền địa phương của bạn để biết th&ecirc;m th&ocirc;ng tin.i&aacute;c ấm c&uacute;ng cho căn ph&ograve;ng. Một bộ d&acirc;y ph&ugrave; hợp được bao gồm, v&igrave; vậy bạn chỉ cần ho&agrave;n th&agrave;nh với một b&oacute;ng đ&egrave;n LED.</p>', 3, NULL, '114', 3000000, 4000000, 5000000, 100, 1, '2022-06-07 07:59:32', '2022-06-07 07:59:43', 34),
(115, 'Đèn Solklint', 13, 'Giống như những viên ngọc nhỏ bằng đồng thau sáng bóng và thủy tinh trong suốt màu xám, các đèn thuộc dòng SOLKLINT lan tỏa ánh sáng theo tâm trạng dịu nhẹ, tạo ra những bóng tối thú vị trên tường và trần nhà - bất cứ nơi nào bạn chọn đặt chúng', '<p><br />\r\nĐ&egrave;n cho &aacute;nh s&aacute;ng dịu nhẹ v&agrave; tạo kh&ocirc;ng kh&iacute; ấm c&uacute;ng, gần gũi trong căn ph&ograve;ng của bạn.</p>\r\n\r\n<p>B&oacute;ng đ&egrave;n được b&aacute;n ri&ecirc;ng. IKEA khuyến nghị b&oacute;ng đ&egrave;n LED E26 h&igrave;nh cầu r&otilde; r&agrave;ng.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nIKEA của Thụy Điển</p>', 3, NULL, '115', 700000, 150000, 2000000, 100, 1, '2022-06-07 08:03:44', '2022-06-07 08:03:52', 34),
(116, 'Đèn Nymane', 13, 'Khi chúng tôi tạo ra đèn mặt dây chuyền NYMÅNE, chúng tôi đã mở rương kho báu của mình và tìm thấy đèn KLANG từ những năm 1960. Chúng tôi đã thêm một đèn LED tích hợp có thể điều chỉnh độ sáng và để nhà thiết kế của chúng tôi tạo cho nó một biểu hiện hiện đại phù hợp với dòng sản phẩm.', '<p>Bạn c&oacute; thể điều chỉnh &aacute;nh s&aacute;ng kh&ocirc;ng d&acirc;y v&agrave; dễ d&agrave;ng điều chỉnh &aacute;nh s&aacute;ng dựa tr&ecirc;n hoạt động.</p>\r\n\r\n<p>Bạn c&oacute; thể chọn treo đ&egrave;n mặt d&acirc;y tr&ecirc;n b&agrave;n ăn hoặc gần trần nh&agrave; hơn để chiếu s&aacute;ng chung trong ph&ograve;ng.</p>\r\n\r\n<p>Nguồn s&aacute;ng đi k&egrave;m sẽ tồn tại trong một thời gian d&agrave;i, nhưng nếu n&oacute; bị hỏng hoặc ngừng chiếu s&aacute;ng, bạn c&oacute; thể thay thế bằng nguồn s&aacute;ng mới.</p>\r\n\r\n<p>Bằng c&aacute;ch l&agrave;m mờ &aacute;nh s&aacute;ng, bạn thay đổi kh&ocirc;ng kh&iacute; trong ph&ograve;ng đồng thời tiết kiệm năng lượng.</p>\r\n\r\n<p>Sử dụng đ&egrave;n LED l&agrave;m nguồn s&aacute;ng c&oacute; nghĩa l&agrave; n&oacute; kh&ocirc;ng chỉ c&oacute; tuổi thọ cao hơn 20 lần so với b&oacute;ng đ&egrave;n sợi đốt m&agrave; c&ograve;n ti&ecirc;u thụ &iacute;t năng lượng hơn tới 85%.</p>\r\n\r\n<p>Đ&egrave;n n&agrave;y mang đến một bầu kh&ocirc;ng kh&iacute; dễ chịu cho bữa ăn, truyền &aacute;nh s&aacute;ng trực tiếp khắp b&agrave;n ăn hoặc quầy bar của bạn.</p>\r\n\r\n<p>Điều khiển từ xa được b&aacute;n ri&ecirc;ng.</p>\r\n\r\n<p>Sản phẩm n&agrave;y cho ph&eacute;p l&agrave;m mờ kh&ocirc;ng d&acirc;y. Với Hệ thống chiếu s&aacute;ng th&ocirc;ng minh IKEA, bạn c&oacute; thể l&agrave;m mờ đ&egrave;n của m&igrave;nh m&agrave; kh&ocirc;ng cần lắp đặt c&oacute; d&acirc;y.</p>\r\n\r\n<p>Nhiệt độ m&agrave;u c&oacute; thể được chuyển đổi giữa 2200 Kelvin (s&aacute;ng ấm), 2700 Kelvin (trắng ấm) v&agrave; 4000 Kelvin (trắng lạnh).</p>\r\n\r\n<p>Nguồn s&aacute;ng LED đi k&egrave;m c&oacute; thể thay thế được.</p>\r\n\r\n<p>Hoạt động với IKEA Home th&ocirc;ng minh.</p>\r\n\r\n<p>Kh&ocirc;ng th&iacute;ch hợp để sử dụng với bộ điều chỉnh độ s&aacute;ng c&oacute; d&acirc;y cứng.</p>\r\n\r\n<p>Chỉ c&oacute; thể được sử dụng với c&aacute;c sản phẩm chiếu s&aacute;ng th&ocirc;ng minh IKEA.</p>\r\n\r\n<p>Bạn cần c&oacute; cổng TR&Aring;DFRI để sử dụng ứng dụng th&ocirc;ng minh IKEA Home. Tải xuống ứng dụng miễn ph&iacute; qua Google Play hoặc App Store, t&ugrave;y thuộc v&agrave;o thiết bị di động bạn c&oacute;.</p>\r\n\r\n<p>Xử l&yacute; chất thải đặc biệt c&oacute; thể được y&ecirc;u cầu. H&atilde;y li&ecirc;n hệ với ch&iacute;nh quyền địa phương của bạn để biết th&ecirc;m th&ocirc;ng tin.</p>\r\n\r\n<p>Tải xuống ứng dụng th&ocirc;ng minh IKEA Home miễn ph&iacute; qua Google Play hoặc App Store, t&ugrave;y thuộc v&agrave;o thiết bị di động bạn c&oacute;.</p>\r\n\r\n<p>Được gắn bằng v&iacute;t.</p>\r\n\r\n<p>V&iacute;t kh&ocirc;ng được bao gồm.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nOla Wihlborg</p>', 3, NULL, '116', 2000000, 3000000, 4000000, 100, 1, '2022-06-07 08:07:17', '2022-06-07 08:07:29', 34),
(117, 'Đèn Tybble', 13, 'Chiếc đèn mặt dây kiểu cách này với bóng đèn thủy tinh rất phù hợp để treo trên bàn ăn lớn hoặc đảo bếp. Bạn cũng có thể làm mờ 5 bóng đèn LED tích hợp để tạo ra tâm trạng bạn muốn vào lúc này.', '<p>Bạn c&oacute; thể dễ d&agrave;ng điều chỉnh độ s&aacute;ng l&ecirc;n xuống bằng c&aacute;ch ấn v&agrave;o khung kim loại của đ&egrave;n.</p>\r\n\r\n<p>V&igrave; &aacute;nh s&aacute;ng c&oacute; thể được l&agrave;m mờ, bạn c&oacute; thể chọn &aacute;nh s&aacute;ng ph&ugrave; hợp cho mọi trường hợp.</p>\r\n\r\n<p>Nguồn s&aacute;ng LED ti&ecirc;u thụ năng lượng &iacute;t hơn đến 85% v&agrave; tuổi thọ cao hơn 20 lần so với b&oacute;ng đ&egrave;n sợi đốt.</p>\r\n\r\n<p>Đ&egrave;n n&agrave;y mang đến một bầu kh&ocirc;ng kh&iacute; dễ chịu cho bữa ăn, truyền &aacute;nh s&aacute;ng trực tiếp khắp b&agrave;n ăn hoặc quầy bar của bạn.</p>\r\n\r\n<p>Nguồn s&aacute;ng LED t&iacute;ch hợp.</p>\r\n\r\n<p>C&oacute; thể điều chỉnh độ s&aacute;ng.</p>\r\n\r\n<p>Nguồn s&aacute;ng c&oacute; tuổi thọ xấp xỉ. 25.000 giờ. Điều n&agrave;y tương ứng với khoảng 20 năm nếu đ&egrave;n được bật trong 3 giờ mỗi ng&agrave;y.</p>\r\n\r\n<p>M&agrave;u s&aacute;ng: trắng ấm (2700 Kelvin).</p>\r\n\r\n<p>Chỉ số ho&agrave;n m&agrave;u (CRI):&gt; 90.</p>\r\n\r\n<p>Kh&ocirc;ng thể sử dụng c&ocirc;ng tắc điều chỉnh độ s&aacute;ng gắn tr&ecirc;n tường cho đ&egrave;n n&agrave;y.</p>\r\n\r\n<p>Phụ t&ugrave;ng thay thế lu&ocirc;n c&oacute; sẵn để k&eacute;o d&agrave;i tuổi thọ cho sản phẩm của bạn. Để biết th&ecirc;m th&ocirc;ng tin, h&atilde;y li&ecirc;n hệ với Bộ phận Dịch vụ Kh&aacute;ch h&agrave;ng của IKEA tại cửa h&agrave;ng IKEA của bạn hoặc IKEA.com.</p>\r\n\r\n<p>Được gắn bằng v&iacute;t.</p>\r\n\r\n<p>V&iacute;t kh&ocirc;ng được bao gồm.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nCarl &Ouml;jerstam</p>', 3, NULL, '117', 3500000, 4000000, 5000000, 100, 1, '2022-06-07 08:13:06', '2022-06-07 08:13:16', 34),
(118, 'Đèn Simrishamn', 13, 'Kính và đèn crom phong cách của dòng SIMRISHAMN. Ánh sáng hiện đại cho toàn bộ ngôi nhà tạo ra một bầu không khí tốt đẹp. Sử dụng nó như một thiết bị bắt mắt độc lập hoặc kết hợp nó với các loại đèn khác trong sê-ri.', '<p>C&aacute;c tấm k&iacute;nh cung cấp &aacute;nh s&aacute;ng khuếch t&aacute;n v&agrave; trang tr&iacute; tr&ecirc;n b&agrave;n ăn.</p>\r\n\r\n<p>B&oacute;ng đ&egrave;n được b&aacute;n ri&ecirc;ng. IKEA khuyến nghị b&oacute;ng đ&egrave;n LED E12 m&agrave;u trắng opal to&agrave;n cầu (3 chiếc).</p>\r\n\r\n<p>Sử dụng b&oacute;ng đ&egrave;n opal nếu bạn c&oacute; b&oacute;ng đ&egrave;n hoặc b&oacute;ng đ&egrave;n th&ocirc;ng thường v&agrave; muốn ph&acirc;n bổ &aacute;nh s&aacute;ng đồng đều, khuếch t&aacute;n.</p>\r\n\r\n<p>Sử dụng b&oacute;ng đ&egrave;n trong nếu bạn c&oacute; b&oacute;ng đ&egrave;n hoặc đ&egrave;n c&oacute; hoa văn đục lỗ hoặc cắt lỗ hoặc thiết kế tho&aacute;ng, mở kh&aacute;c v&agrave; muốn hoa văn tạo hiệu ứng tr&ecirc;n tường v&agrave; trần nh&agrave;.</p>\r\n\r\n<p>C&oacute; thể được ho&agrave;n th&agrave;nh với c&aacute;c đ&egrave;n kh&aacute;c trong c&ugrave;ng một loạt.</p>\r\n\r\n<p>Được gắn bằng v&iacute;t.</p>\r\n\r\n<p>V&iacute;t kh&ocirc;ng được bao gồm.</p>\r\n\r\n<p>Nh&agrave; thiết kế<br />\r\nI Bermudez / H Dalrot / A Probyn</p>', 3, NULL, '118', 2000000, 3000000, 4000000, 100, 1, '2022-06-07 08:18:30', '2022-06-07 08:18:37', 34);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_promotion`
--

CREATE TABLE `product_promotion` (
  `ID` int(11) NOT NULL,
  `promotionID` int(11) NOT NULL,
  `productID` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_spec`
--

CREATE TABLE `product_spec` (
  `ID` int(11) NOT NULL,
  `productID` int(11) DEFAULT NULL,
  `specificationID` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `product_spec`
--

INSERT INTO `product_spec` (`ID`, `productID`, `specificationID`, `updated_at`, `created_at`) VALUES
(45, 17, 82, '2022-03-01 08:54:49', '2022-03-01 08:54:49'),
(46, 17, 83, '2022-03-01 08:54:49', '2022-03-01 08:54:49'),
(47, 17, 84, '2022-03-01 08:54:49', '2022-03-01 08:54:49'),
(48, 17, 85, '2022-03-01 08:54:49', '2022-03-01 08:54:49'),
(49, 17, 86, '2022-03-01 08:54:49', '2022-03-01 08:54:49'),
(50, 17, 87, '2022-03-01 08:54:49', '2022-03-01 08:54:49'),
(51, 17, 88, '2022-03-01 08:54:49', '2022-03-01 08:54:49'),
(52, 18, 89, '2022-03-02 06:59:41', '2022-03-02 06:59:41'),
(53, 18, 90, '2022-03-02 06:59:41', '2022-03-02 06:59:41'),
(54, 18, 91, '2022-03-02 06:59:41', '2022-03-02 06:59:41'),
(55, 18, 92, '2022-03-02 06:59:41', '2022-03-02 06:59:41'),
(56, 18, 93, '2022-03-02 06:59:41', '2022-03-02 06:59:41'),
(57, 18, 94, '2022-03-02 06:59:41', '2022-03-02 06:59:41'),
(58, 18, 95, '2022-03-02 06:59:41', '2022-03-02 06:59:41'),
(59, 19, 96, '2022-03-02 07:04:44', '2022-03-02 07:04:44'),
(60, 19, 97, '2022-03-02 07:04:44', '2022-03-02 07:04:44'),
(61, 19, 98, '2022-03-02 07:04:44', '2022-03-02 07:04:44'),
(62, 19, 99, '2022-03-02 07:04:44', '2022-03-02 07:04:44'),
(63, 19, 100, '2022-03-02 07:04:44', '2022-03-02 07:04:44'),
(64, 19, 101, '2022-03-02 07:04:44', '2022-03-02 07:04:44'),
(65, 19, 102, '2022-03-02 07:04:44', '2022-03-02 07:04:44'),
(66, 20, 103, '2022-03-02 07:14:23', '2022-03-02 07:14:23'),
(67, 20, 104, '2022-03-02 07:14:23', '2022-03-02 07:14:23'),
(68, 20, 105, '2022-03-02 07:14:23', '2022-03-02 07:14:23'),
(69, 20, 106, '2022-03-02 07:14:23', '2022-03-02 07:14:23'),
(70, 20, 107, '2022-03-02 07:14:23', '2022-03-02 07:14:23'),
(71, 20, 108, '2022-03-02 07:14:23', '2022-03-02 07:14:23'),
(72, 20, 109, '2022-03-02 07:14:23', '2022-03-02 07:14:23'),
(73, 21, 110, '2022-03-02 07:21:51', '2022-03-02 07:21:51'),
(74, 21, 111, '2022-03-02 07:21:51', '2022-03-02 07:21:51'),
(75, 21, 112, '2022-03-02 07:21:51', '2022-03-02 07:21:51'),
(76, 21, 113, '2022-03-02 07:21:51', '2022-03-02 07:21:51'),
(77, 21, 114, '2022-03-02 07:21:51', '2022-03-02 07:21:51'),
(78, 21, 115, '2022-03-02 07:21:51', '2022-03-02 07:21:51'),
(79, 21, 116, '2022-03-02 07:21:51', '2022-03-02 07:21:51'),
(80, 22, 117, '2022-03-02 07:34:39', '2022-03-02 07:34:39'),
(81, 22, 118, '2022-03-02 07:34:39', '2022-03-02 07:34:39'),
(82, 22, 119, '2022-03-02 07:34:39', '2022-03-02 07:34:39'),
(83, 22, 120, '2022-03-02 07:34:39', '2022-03-02 07:34:39'),
(84, 22, 121, '2022-03-02 07:34:39', '2022-03-02 07:34:39'),
(85, 22, 122, '2022-03-02 07:34:39', '2022-03-02 07:34:39'),
(86, 22, 123, '2022-03-02 07:34:39', '2022-03-02 07:34:39'),
(87, 23, 124, '2022-03-02 07:38:24', '2022-03-02 07:38:24'),
(88, 23, 125, '2022-03-02 07:38:24', '2022-03-02 07:38:24'),
(89, 23, 126, '2022-03-02 07:38:24', '2022-03-02 07:38:24'),
(90, 23, 127, '2022-03-02 07:38:24', '2022-03-02 07:38:24'),
(91, 23, 128, '2022-03-02 07:38:24', '2022-03-02 07:38:24'),
(92, 23, 129, '2022-03-02 07:38:24', '2022-03-02 07:38:24'),
(93, 23, 130, '2022-03-02 07:38:24', '2022-03-02 07:38:24'),
(94, 24, 131, '2022-03-02 07:43:18', '2022-03-02 07:43:18'),
(95, 24, 132, '2022-03-02 07:43:18', '2022-03-02 07:43:18'),
(96, 24, 133, '2022-03-02 07:43:18', '2022-03-02 07:43:18'),
(97, 24, 134, '2022-03-02 07:43:18', '2022-03-02 07:43:18'),
(98, 24, 135, '2022-03-02 07:43:18', '2022-03-02 07:43:18'),
(99, 24, 136, '2022-03-02 07:43:18', '2022-03-02 07:43:18'),
(100, 24, 137, '2022-03-02 07:43:18', '2022-03-02 07:43:18'),
(101, 25, 138, '2022-03-02 07:47:31', '2022-03-02 07:47:31'),
(102, 25, 139, '2022-03-02 07:47:31', '2022-03-02 07:47:31'),
(103, 25, 140, '2022-03-02 07:47:31', '2022-03-02 07:47:31'),
(104, 25, 141, '2022-03-02 07:47:31', '2022-03-02 07:47:31'),
(105, 25, 142, '2022-03-02 07:47:31', '2022-03-02 07:47:31'),
(106, 25, 143, '2022-03-02 07:47:31', '2022-03-02 07:47:31'),
(107, 25, 144, '2022-03-02 07:47:31', '2022-03-02 07:47:31'),
(108, 26, 145, '2022-03-02 07:54:44', '2022-03-02 07:54:44'),
(109, 26, 146, '2022-03-02 07:54:44', '2022-03-02 07:54:44'),
(110, 26, 147, '2022-03-02 07:54:44', '2022-03-02 07:54:44'),
(111, 26, 148, '2022-03-02 07:54:44', '2022-03-02 07:54:44'),
(112, 26, 149, '2022-03-02 07:54:44', '2022-03-02 07:54:44'),
(113, 26, 150, '2022-03-02 07:54:44', '2022-03-02 07:54:44'),
(114, 26, 151, '2022-03-02 07:54:44', '2022-03-02 07:54:44'),
(115, 27, 152, '2022-03-02 08:05:55', '2022-03-02 08:05:55'),
(116, 27, 153, '2022-03-02 08:05:55', '2022-03-02 08:05:55'),
(117, 27, 154, '2022-03-02 08:05:55', '2022-03-02 08:05:55'),
(118, 27, 155, '2022-03-02 08:05:55', '2022-03-02 08:05:55'),
(119, 27, 156, '2022-03-02 08:05:55', '2022-03-02 08:05:55'),
(120, 27, 157, '2022-03-02 08:05:55', '2022-03-02 08:05:55'),
(121, 27, 158, '2022-03-02 08:05:55', '2022-03-02 08:05:55'),
(122, 28, 159, '2022-03-03 07:13:34', '2022-03-03 07:13:34'),
(123, 28, 160, '2022-03-03 07:13:34', '2022-03-03 07:13:34'),
(124, 28, 161, '2022-03-03 07:13:34', '2022-03-03 07:13:34'),
(125, 28, 162, '2022-03-03 07:13:34', '2022-03-03 07:13:34'),
(126, 28, 163, '2022-03-03 07:13:34', '2022-03-03 07:13:34'),
(127, 28, 164, '2022-03-03 07:13:34', '2022-03-03 07:13:34'),
(128, 28, 165, '2022-03-03 07:13:34', '2022-03-03 07:13:34'),
(129, 29, 166, '2022-03-03 07:24:58', '2022-03-03 07:24:58'),
(130, 29, 167, '2022-03-03 07:24:58', '2022-03-03 07:24:58'),
(131, 29, 168, '2022-03-03 07:24:58', '2022-03-03 07:24:58'),
(132, 29, 169, '2022-03-03 07:24:58', '2022-03-03 07:24:58'),
(133, 29, 170, '2022-03-03 07:24:58', '2022-03-03 07:24:58'),
(134, 29, 171, '2022-03-03 07:24:58', '2022-03-03 07:24:58'),
(135, 29, 172, '2022-03-03 07:24:58', '2022-03-03 07:24:58'),
(136, 30, 173, '2022-03-03 07:33:20', '2022-03-03 07:33:20'),
(137, 30, 174, '2022-03-03 07:33:20', '2022-03-03 07:33:20'),
(138, 30, 175, '2022-03-03 07:33:20', '2022-03-03 07:33:20'),
(139, 30, 176, '2022-03-03 07:33:20', '2022-03-03 07:33:20'),
(140, 30, 177, '2022-03-03 07:33:20', '2022-03-03 07:33:20'),
(141, 30, 178, '2022-03-03 07:33:20', '2022-03-03 07:33:20'),
(142, 30, 179, '2022-03-03 07:33:20', '2022-03-03 07:33:20'),
(143, 31, 180, '2022-03-03 07:38:08', '2022-03-03 07:38:08'),
(144, 31, 181, '2022-03-03 07:38:08', '2022-03-03 07:38:08'),
(145, 31, 182, '2022-03-03 07:38:08', '2022-03-03 07:38:08'),
(146, 31, 183, '2022-03-03 07:38:08', '2022-03-03 07:38:08'),
(147, 31, 184, '2022-03-03 07:38:08', '2022-03-03 07:38:08'),
(148, 31, 185, '2022-03-03 07:38:08', '2022-03-03 07:38:08'),
(149, 31, 186, '2022-03-03 07:38:08', '2022-03-03 07:38:08'),
(150, 32, 187, '2022-03-03 07:46:09', '2022-03-03 07:46:09'),
(151, 32, 188, '2022-03-03 07:46:09', '2022-03-03 07:46:09'),
(152, 32, 189, '2022-03-03 07:46:09', '2022-03-03 07:46:09'),
(153, 32, 190, '2022-03-03 07:46:09', '2022-03-03 07:46:09'),
(154, 32, 191, '2022-03-03 07:46:09', '2022-03-03 07:46:09'),
(155, 32, 192, '2022-03-03 07:46:09', '2022-03-03 07:46:09'),
(156, 32, 193, '2022-03-03 07:46:09', '2022-03-03 07:46:09'),
(157, 33, 194, '2022-03-03 07:51:00', '2022-03-03 07:51:00'),
(158, 33, 195, '2022-03-03 07:51:00', '2022-03-03 07:51:00'),
(159, 33, 196, '2022-03-03 07:51:00', '2022-03-03 07:51:00'),
(160, 33, 197, '2022-03-03 07:51:00', '2022-03-03 07:51:00'),
(161, 33, 198, '2022-03-03 07:51:00', '2022-03-03 07:51:00'),
(162, 33, 199, '2022-03-03 07:51:00', '2022-03-03 07:51:00'),
(163, 33, 200, '2022-03-03 07:51:00', '2022-03-03 07:51:00'),
(164, 34, 201, '2022-03-03 08:00:27', '2022-03-03 08:00:27'),
(165, 34, 202, '2022-03-03 08:00:27', '2022-03-03 08:00:27'),
(166, 34, 203, '2022-03-03 08:00:27', '2022-03-03 08:00:27'),
(167, 34, 204, '2022-03-03 08:00:27', '2022-03-03 08:00:27'),
(168, 34, 205, '2022-03-03 08:00:27', '2022-03-03 08:00:27'),
(169, 34, 206, '2022-03-03 08:00:27', '2022-03-03 08:00:27'),
(170, 34, 207, '2022-03-03 08:00:27', '2022-03-03 08:00:27'),
(171, 35, 208, '2022-03-03 08:08:53', '2022-03-03 08:08:53'),
(172, 35, 209, '2022-03-03 08:08:53', '2022-03-03 08:08:53'),
(173, 35, 210, '2022-03-03 08:08:53', '2022-03-03 08:08:53'),
(174, 35, 211, '2022-03-03 08:08:53', '2022-03-03 08:08:53'),
(175, 35, 212, '2022-03-03 08:08:53', '2022-03-03 08:08:53'),
(176, 35, 213, '2022-03-03 08:08:53', '2022-03-03 08:08:53'),
(177, 35, 214, '2022-03-03 08:08:53', '2022-03-03 08:08:53'),
(178, 36, 215, '2022-03-03 08:14:44', '2022-03-03 08:14:44'),
(179, 36, 216, '2022-03-03 08:14:44', '2022-03-03 08:14:44'),
(180, 36, 217, '2022-03-03 08:14:44', '2022-03-03 08:14:44'),
(181, 36, 218, '2022-03-03 08:14:44', '2022-03-03 08:14:44'),
(182, 36, 219, '2022-03-03 08:14:44', '2022-03-03 08:14:44'),
(183, 36, 220, '2022-03-03 08:14:44', '2022-03-03 08:14:44'),
(184, 36, 221, '2022-03-03 08:14:44', '2022-03-03 08:14:44'),
(185, 39, 222, '2022-03-25 16:18:11', '2022-03-25 16:18:11'),
(186, 39, 223, '2022-03-25 16:18:11', '2022-03-25 16:18:11'),
(187, 39, 224, '2022-03-25 16:18:11', '2022-03-25 16:18:11'),
(188, 39, 225, '2022-03-25 16:18:11', '2022-03-25 16:18:11'),
(189, 39, 226, '2022-03-25 16:18:11', '2022-03-25 16:18:11'),
(190, 39, 227, '2022-03-25 16:18:11', '2022-03-25 16:18:11'),
(191, 39, 228, '2022-03-25 16:18:11', '2022-03-25 16:18:11'),
(192, 40, 229, '2022-06-01 07:45:35', '2022-06-01 07:45:35'),
(193, 40, 230, '2022-06-01 07:45:35', '2022-06-01 07:45:35'),
(194, 40, 231, '2022-06-01 07:45:35', '2022-06-01 07:45:35'),
(195, 40, 232, '2022-06-01 07:45:35', '2022-06-01 07:45:35'),
(196, 40, 233, '2022-06-01 07:45:35', '2022-06-01 07:45:35'),
(197, 40, 234, '2022-06-01 07:45:35', '2022-06-01 07:45:35'),
(198, 40, 235, '2022-06-01 07:45:35', '2022-06-01 07:45:35'),
(199, 41, 236, '2022-06-01 08:22:13', '2022-06-01 08:22:13'),
(200, 41, 237, '2022-06-01 08:22:13', '2022-06-01 08:22:13'),
(201, 41, 238, '2022-06-01 08:22:13', '2022-06-01 08:22:13'),
(202, 41, 239, '2022-06-01 08:22:13', '2022-06-01 08:22:13'),
(203, 41, 240, '2022-06-01 08:22:13', '2022-06-01 08:22:13'),
(204, 41, 241, '2022-06-01 08:22:13', '2022-06-01 08:22:13'),
(205, 41, 242, '2022-06-01 08:22:13', '2022-06-01 08:22:13'),
(206, 42, 243, '2022-06-01 08:26:22', '2022-06-01 08:26:22'),
(207, 42, 244, '2022-06-01 08:26:22', '2022-06-01 08:26:22'),
(208, 42, 245, '2022-06-01 08:26:22', '2022-06-01 08:26:22'),
(209, 42, 246, '2022-06-01 08:26:22', '2022-06-01 08:26:22'),
(210, 42, 247, '2022-06-01 08:26:22', '2022-06-01 08:26:22'),
(211, 42, 248, '2022-06-01 08:26:22', '2022-06-01 08:26:22'),
(212, 42, 249, '2022-06-01 08:26:22', '2022-06-01 08:26:22'),
(213, 43, 250, '2022-06-01 08:35:10', '2022-06-01 08:35:10'),
(214, 43, 251, '2022-06-01 08:35:10', '2022-06-01 08:35:10'),
(215, 43, 252, '2022-06-01 08:35:10', '2022-06-01 08:35:10'),
(216, 43, 253, '2022-06-01 08:35:10', '2022-06-01 08:35:10'),
(217, 43, 254, '2022-06-01 08:35:10', '2022-06-01 08:35:10'),
(218, 43, 255, '2022-06-01 08:35:10', '2022-06-01 08:35:10'),
(219, 43, 256, '2022-06-01 08:35:10', '2022-06-01 08:35:10'),
(220, 44, 257, '2022-06-01 08:38:44', '2022-06-01 08:38:44'),
(221, 44, 258, '2022-06-01 08:38:44', '2022-06-01 08:38:44'),
(222, 44, 259, '2022-06-01 08:38:44', '2022-06-01 08:38:44'),
(223, 44, 260, '2022-06-01 08:38:44', '2022-06-01 08:38:44'),
(224, 44, 261, '2022-06-01 08:38:44', '2022-06-01 08:38:44'),
(225, 44, 262, '2022-06-01 08:38:44', '2022-06-01 08:38:44'),
(226, 44, 263, '2022-06-01 08:38:44', '2022-06-01 08:38:44'),
(227, 45, 264, '2022-06-01 08:41:49', '2022-06-01 08:41:49'),
(228, 45, 265, '2022-06-01 08:41:49', '2022-06-01 08:41:49'),
(229, 45, 266, '2022-06-01 08:41:49', '2022-06-01 08:41:49'),
(230, 45, 267, '2022-06-01 08:41:49', '2022-06-01 08:41:49'),
(231, 45, 268, '2022-06-01 08:41:49', '2022-06-01 08:41:49'),
(232, 45, 269, '2022-06-01 08:41:49', '2022-06-01 08:41:49'),
(233, 45, 270, '2022-06-01 08:41:49', '2022-06-01 08:41:49'),
(234, 46, 271, '2022-06-01 08:46:30', '2022-06-01 08:46:30'),
(235, 46, 272, '2022-06-01 08:46:30', '2022-06-01 08:46:30'),
(236, 46, 273, '2022-06-01 08:46:30', '2022-06-01 08:46:30'),
(237, 46, 274, '2022-06-01 08:46:30', '2022-06-01 08:46:30'),
(238, 46, 275, '2022-06-01 08:46:30', '2022-06-01 08:46:30'),
(239, 46, 276, '2022-06-01 08:46:30', '2022-06-01 08:46:30'),
(240, 46, 277, '2022-06-01 08:46:30', '2022-06-01 08:46:30'),
(241, 47, 278, '2022-06-01 08:49:51', '2022-06-01 08:49:51'),
(242, 47, 279, '2022-06-01 08:49:51', '2022-06-01 08:49:51'),
(243, 47, 280, '2022-06-01 08:49:51', '2022-06-01 08:49:51'),
(244, 47, 281, '2022-06-01 08:49:51', '2022-06-01 08:49:51'),
(245, 47, 282, '2022-06-01 08:49:51', '2022-06-01 08:49:51'),
(246, 47, 283, '2022-06-01 08:49:51', '2022-06-01 08:49:51'),
(247, 47, 284, '2022-06-01 08:49:51', '2022-06-01 08:49:51'),
(248, 48, 285, '2022-06-01 08:52:24', '2022-06-01 08:52:24'),
(249, 48, 286, '2022-06-01 08:52:24', '2022-06-01 08:52:24'),
(250, 48, 287, '2022-06-01 08:52:24', '2022-06-01 08:52:24'),
(251, 48, 288, '2022-06-01 08:52:24', '2022-06-01 08:52:24'),
(252, 48, 289, '2022-06-01 08:52:24', '2022-06-01 08:52:24'),
(253, 48, 290, '2022-06-01 08:52:24', '2022-06-01 08:52:24'),
(254, 48, 291, '2022-06-01 08:52:24', '2022-06-01 08:52:24'),
(255, 49, 292, '2022-06-01 09:00:05', '2022-06-01 09:00:05'),
(256, 49, 293, '2022-06-01 09:00:05', '2022-06-01 09:00:05'),
(257, 49, 294, '2022-06-01 09:00:05', '2022-06-01 09:00:05'),
(258, 49, 295, '2022-06-01 09:00:05', '2022-06-01 09:00:05'),
(259, 49, 296, '2022-06-01 09:00:05', '2022-06-01 09:00:05'),
(260, 49, 297, '2022-06-01 09:00:05', '2022-06-01 09:00:05'),
(261, 49, 298, '2022-06-01 09:00:05', '2022-06-01 09:00:05'),
(262, 50, 299, '2022-06-01 09:03:50', '2022-06-01 09:03:50'),
(263, 50, 300, '2022-06-01 09:03:50', '2022-06-01 09:03:50'),
(264, 50, 301, '2022-06-01 09:03:50', '2022-06-01 09:03:50'),
(265, 50, 302, '2022-06-01 09:03:50', '2022-06-01 09:03:50'),
(266, 50, 303, '2022-06-01 09:03:50', '2022-06-01 09:03:50'),
(267, 50, 304, '2022-06-01 09:03:50', '2022-06-01 09:03:50'),
(268, 50, 305, '2022-06-01 09:03:50', '2022-06-01 09:03:50'),
(269, 51, 306, '2022-06-01 09:06:25', '2022-06-01 09:06:25'),
(270, 51, 307, '2022-06-01 09:06:25', '2022-06-01 09:06:25'),
(271, 51, 308, '2022-06-01 09:06:25', '2022-06-01 09:06:25'),
(272, 51, 309, '2022-06-01 09:06:25', '2022-06-01 09:06:25'),
(273, 51, 310, '2022-06-01 09:06:25', '2022-06-01 09:06:25'),
(274, 51, 311, '2022-06-01 09:06:25', '2022-06-01 09:06:25'),
(275, 51, 312, '2022-06-01 09:06:25', '2022-06-01 09:06:25'),
(276, 52, 313, '2022-06-01 09:11:06', '2022-06-01 09:11:06'),
(277, 52, 314, '2022-06-01 09:11:06', '2022-06-01 09:11:06'),
(278, 52, 315, '2022-06-01 09:11:06', '2022-06-01 09:11:06'),
(279, 52, 316, '2022-06-01 09:11:06', '2022-06-01 09:11:06'),
(280, 52, 317, '2022-06-01 09:11:06', '2022-06-01 09:11:06'),
(281, 52, 318, '2022-06-01 09:11:06', '2022-06-01 09:11:06'),
(282, 52, 319, '2022-06-01 09:11:06', '2022-06-01 09:11:06'),
(283, 53, 320, '2022-06-01 09:14:18', '2022-06-01 09:14:18'),
(284, 53, 321, '2022-06-01 09:14:18', '2022-06-01 09:14:18'),
(285, 53, 322, '2022-06-01 09:14:18', '2022-06-01 09:14:18'),
(286, 53, 323, '2022-06-01 09:14:18', '2022-06-01 09:14:18'),
(287, 53, 324, '2022-06-01 09:14:18', '2022-06-01 09:14:18'),
(288, 53, 325, '2022-06-01 09:14:18', '2022-06-01 09:14:18'),
(289, 53, 326, '2022-06-01 09:14:18', '2022-06-01 09:14:18'),
(290, 54, 327, '2022-06-01 09:17:05', '2022-06-01 09:17:05'),
(291, 54, 328, '2022-06-01 09:17:05', '2022-06-01 09:17:05'),
(292, 54, 329, '2022-06-01 09:17:05', '2022-06-01 09:17:05'),
(293, 54, 330, '2022-06-01 09:17:05', '2022-06-01 09:17:05'),
(294, 54, 331, '2022-06-01 09:17:05', '2022-06-01 09:17:05'),
(295, 54, 332, '2022-06-01 09:17:05', '2022-06-01 09:17:05'),
(296, 54, 333, '2022-06-01 09:17:05', '2022-06-01 09:17:05'),
(297, 55, 334, '2022-06-01 09:24:22', '2022-06-01 09:24:22'),
(298, 55, 335, '2022-06-01 09:24:22', '2022-06-01 09:24:22'),
(299, 55, 336, '2022-06-01 09:24:22', '2022-06-01 09:24:22'),
(300, 55, 337, '2022-06-01 09:24:22', '2022-06-01 09:24:22'),
(301, 55, 338, '2022-06-01 09:24:22', '2022-06-01 09:24:22'),
(302, 55, 339, '2022-06-01 09:24:22', '2022-06-01 09:24:22'),
(303, 55, 340, '2022-06-01 09:24:22', '2022-06-01 09:24:22'),
(304, 56, 341, '2022-06-01 09:26:10', '2022-06-01 09:26:10'),
(305, 56, 342, '2022-06-01 09:26:10', '2022-06-01 09:26:10'),
(306, 56, 343, '2022-06-01 09:26:10', '2022-06-01 09:26:10'),
(307, 56, 344, '2022-06-01 09:26:10', '2022-06-01 09:26:10'),
(308, 56, 345, '2022-06-01 09:26:10', '2022-06-01 09:26:10'),
(309, 56, 346, '2022-06-01 09:26:10', '2022-06-01 09:26:10'),
(310, 56, 347, '2022-06-01 09:26:10', '2022-06-01 09:26:10'),
(311, 57, 348, '2022-06-01 09:29:57', '2022-06-01 09:29:57'),
(312, 57, 349, '2022-06-01 09:29:57', '2022-06-01 09:29:57'),
(313, 57, 350, '2022-06-01 09:29:57', '2022-06-01 09:29:57'),
(314, 57, 351, '2022-06-01 09:29:57', '2022-06-01 09:29:57'),
(315, 57, 352, '2022-06-01 09:29:57', '2022-06-01 09:29:57'),
(316, 57, 353, '2022-06-01 09:29:57', '2022-06-01 09:29:57'),
(317, 57, 354, '2022-06-01 09:29:57', '2022-06-01 09:29:57'),
(318, 58, 355, '2022-06-01 09:35:00', '2022-06-01 09:35:00'),
(319, 58, 356, '2022-06-01 09:35:00', '2022-06-01 09:35:00'),
(320, 58, 357, '2022-06-01 09:35:00', '2022-06-01 09:35:00'),
(321, 58, 358, '2022-06-01 09:35:00', '2022-06-01 09:35:00'),
(322, 58, 359, '2022-06-01 09:35:00', '2022-06-01 09:35:00'),
(323, 58, 360, '2022-06-01 09:35:00', '2022-06-01 09:35:00'),
(324, 58, 361, '2022-06-01 09:35:00', '2022-06-01 09:35:00'),
(325, 59, 362, '2022-06-01 09:41:39', '2022-06-01 09:41:39'),
(326, 59, 363, '2022-06-01 09:41:39', '2022-06-01 09:41:39'),
(327, 59, 364, '2022-06-01 09:41:39', '2022-06-01 09:41:39'),
(328, 59, 365, '2022-06-01 09:41:39', '2022-06-01 09:41:39'),
(329, 59, 366, '2022-06-01 09:41:39', '2022-06-01 09:41:39'),
(330, 59, 367, '2022-06-01 09:41:39', '2022-06-01 09:41:39'),
(331, 59, 368, '2022-06-01 09:41:39', '2022-06-01 09:41:39'),
(332, 60, 369, '2022-06-01 09:43:32', '2022-06-01 09:43:32'),
(333, 60, 370, '2022-06-01 09:43:32', '2022-06-01 09:43:32'),
(334, 60, 371, '2022-06-01 09:43:32', '2022-06-01 09:43:32'),
(335, 60, 372, '2022-06-01 09:43:32', '2022-06-01 09:43:32'),
(336, 60, 373, '2022-06-01 09:43:32', '2022-06-01 09:43:32'),
(337, 60, 374, '2022-06-01 09:43:32', '2022-06-01 09:43:32'),
(338, 60, 375, '2022-06-01 09:43:32', '2022-06-01 09:43:32'),
(339, 61, 376, '2022-06-01 09:46:01', '2022-06-01 09:46:01'),
(340, 61, 377, '2022-06-01 09:46:01', '2022-06-01 09:46:01'),
(341, 61, 378, '2022-06-01 09:46:01', '2022-06-01 09:46:01'),
(342, 61, 379, '2022-06-01 09:46:01', '2022-06-01 09:46:01'),
(343, 61, 380, '2022-06-01 09:46:01', '2022-06-01 09:46:01'),
(344, 61, 381, '2022-06-01 09:46:01', '2022-06-01 09:46:01'),
(345, 61, 382, '2022-06-01 09:46:01', '2022-06-01 09:46:01'),
(346, 62, 383, '2022-06-01 09:48:01', '2022-06-01 09:48:01'),
(347, 62, 384, '2022-06-01 09:48:01', '2022-06-01 09:48:01'),
(348, 62, 385, '2022-06-01 09:48:01', '2022-06-01 09:48:01'),
(349, 62, 386, '2022-06-01 09:48:01', '2022-06-01 09:48:01'),
(350, 62, 387, '2022-06-01 09:48:01', '2022-06-01 09:48:01'),
(351, 62, 388, '2022-06-01 09:48:01', '2022-06-01 09:48:01'),
(352, 62, 389, '2022-06-01 09:48:01', '2022-06-01 09:48:01'),
(353, 63, 390, '2022-06-01 09:49:24', '2022-06-01 09:49:24'),
(354, 63, 391, '2022-06-01 09:49:24', '2022-06-01 09:49:24'),
(355, 63, 392, '2022-06-01 09:49:24', '2022-06-01 09:49:24'),
(356, 63, 393, '2022-06-01 09:49:24', '2022-06-01 09:49:24'),
(357, 63, 394, '2022-06-01 09:49:24', '2022-06-01 09:49:24'),
(358, 63, 395, '2022-06-01 09:49:24', '2022-06-01 09:49:24'),
(359, 63, 396, '2022-06-01 09:49:24', '2022-06-01 09:49:24'),
(360, 64, 397, '2022-06-01 10:03:30', '2022-06-01 10:03:30'),
(361, 64, 398, '2022-06-01 10:03:30', '2022-06-01 10:03:30'),
(362, 64, 399, '2022-06-01 10:03:30', '2022-06-01 10:03:30'),
(363, 64, 400, '2022-06-01 10:03:30', '2022-06-01 10:03:30'),
(364, 64, 401, '2022-06-01 10:03:30', '2022-06-01 10:03:30'),
(365, 64, 402, '2022-06-01 10:03:30', '2022-06-01 10:03:30'),
(366, 64, 403, '2022-06-01 10:03:30', '2022-06-01 10:03:30'),
(367, 65, 404, '2022-06-01 10:07:49', '2022-06-01 10:07:49'),
(368, 65, 405, '2022-06-01 10:07:49', '2022-06-01 10:07:49'),
(369, 65, 406, '2022-06-01 10:07:49', '2022-06-01 10:07:49'),
(370, 65, 407, '2022-06-01 10:07:49', '2022-06-01 10:07:49'),
(371, 65, 408, '2022-06-01 10:07:49', '2022-06-01 10:07:49'),
(372, 65, 409, '2022-06-01 10:07:49', '2022-06-01 10:07:49'),
(373, 65, 410, '2022-06-01 10:07:49', '2022-06-01 10:07:49'),
(374, 66, 411, '2022-06-01 10:12:05', '2022-06-01 10:12:05'),
(375, 66, 412, '2022-06-01 10:12:05', '2022-06-01 10:12:05'),
(376, 66, 413, '2022-06-01 10:12:05', '2022-06-01 10:12:05'),
(377, 66, 414, '2022-06-01 10:12:05', '2022-06-01 10:12:05'),
(378, 66, 415, '2022-06-01 10:12:05', '2022-06-01 10:12:05'),
(379, 66, 416, '2022-06-01 10:12:05', '2022-06-01 10:12:05'),
(380, 66, 417, '2022-06-01 10:12:05', '2022-06-01 10:12:05'),
(381, 67, 418, '2022-06-01 15:12:49', '2022-06-01 15:12:49'),
(382, 67, 419, '2022-06-01 15:12:49', '2022-06-01 15:12:49'),
(383, 67, 420, '2022-06-01 15:12:49', '2022-06-01 15:12:49'),
(384, 67, 421, '2022-06-01 15:12:49', '2022-06-01 15:12:49'),
(385, 67, 422, '2022-06-01 15:12:49', '2022-06-01 15:12:49'),
(386, 67, 423, '2022-06-01 15:12:49', '2022-06-01 15:12:49'),
(387, 67, 424, '2022-06-01 15:12:49', '2022-06-01 15:12:49'),
(388, 68, 425, '2022-06-02 07:27:22', '2022-06-02 07:27:22'),
(389, 68, 426, '2022-06-02 07:27:22', '2022-06-02 07:27:22'),
(390, 68, 427, '2022-06-02 07:27:22', '2022-06-02 07:27:22'),
(391, 68, 428, '2022-06-02 07:27:22', '2022-06-02 07:27:22'),
(392, 68, 429, '2022-06-02 07:27:22', '2022-06-02 07:27:22'),
(393, 68, 430, '2022-06-02 07:27:22', '2022-06-02 07:27:22'),
(394, 68, 431, '2022-06-02 07:27:22', '2022-06-02 07:27:22'),
(395, 69, 432, '2022-06-02 07:29:19', '2022-06-02 07:29:19'),
(396, 69, 433, '2022-06-02 07:29:19', '2022-06-02 07:29:19'),
(397, 69, 434, '2022-06-02 07:29:19', '2022-06-02 07:29:19'),
(398, 69, 435, '2022-06-02 07:29:19', '2022-06-02 07:29:19'),
(399, 69, 436, '2022-06-02 07:29:19', '2022-06-02 07:29:19'),
(400, 69, 437, '2022-06-02 07:29:19', '2022-06-02 07:29:19'),
(401, 69, 438, '2022-06-02 07:29:19', '2022-06-02 07:29:19'),
(402, 70, 439, '2022-06-02 07:30:29', '2022-06-02 07:30:29'),
(403, 70, 440, '2022-06-02 07:30:29', '2022-06-02 07:30:29'),
(404, 70, 441, '2022-06-02 07:30:29', '2022-06-02 07:30:29'),
(405, 70, 442, '2022-06-02 07:30:29', '2022-06-02 07:30:29'),
(406, 70, 443, '2022-06-02 07:30:29', '2022-06-02 07:30:29'),
(407, 70, 444, '2022-06-02 07:30:29', '2022-06-02 07:30:29'),
(408, 70, 445, '2022-06-02 07:30:29', '2022-06-02 07:30:29'),
(409, 71, 446, '2022-06-02 07:41:17', '2022-06-02 07:41:17'),
(410, 71, 447, '2022-06-02 07:41:17', '2022-06-02 07:41:17'),
(411, 71, 448, '2022-06-02 07:41:17', '2022-06-02 07:41:17'),
(412, 71, 449, '2022-06-02 07:41:17', '2022-06-02 07:41:17'),
(413, 71, 450, '2022-06-02 07:41:17', '2022-06-02 07:41:17'),
(414, 71, 451, '2022-06-02 07:41:17', '2022-06-02 07:41:17'),
(415, 71, 452, '2022-06-02 07:41:17', '2022-06-02 07:41:17'),
(416, 72, 453, '2022-06-02 07:43:57', '2022-06-02 07:43:57'),
(417, 72, 454, '2022-06-02 07:43:57', '2022-06-02 07:43:57'),
(418, 72, 455, '2022-06-02 07:43:57', '2022-06-02 07:43:57'),
(419, 72, 456, '2022-06-02 07:43:57', '2022-06-02 07:43:57'),
(420, 72, 457, '2022-06-02 07:43:57', '2022-06-02 07:43:57'),
(421, 72, 458, '2022-06-02 07:43:57', '2022-06-02 07:43:57'),
(422, 72, 459, '2022-06-02 07:43:57', '2022-06-02 07:43:57'),
(423, 73, 460, '2022-06-02 07:45:29', '2022-06-02 07:45:29'),
(424, 73, 461, '2022-06-02 07:45:29', '2022-06-02 07:45:29'),
(425, 73, 462, '2022-06-02 07:45:29', '2022-06-02 07:45:29'),
(426, 73, 463, '2022-06-02 07:45:29', '2022-06-02 07:45:29'),
(427, 73, 464, '2022-06-02 07:45:29', '2022-06-02 07:45:29'),
(428, 73, 465, '2022-06-02 07:45:29', '2022-06-02 07:45:29'),
(429, 73, 466, '2022-06-02 07:45:29', '2022-06-02 07:45:29'),
(430, 74, 467, '2022-06-02 07:55:51', '2022-06-02 07:55:51'),
(431, 74, 468, '2022-06-02 07:55:51', '2022-06-02 07:55:51'),
(432, 74, 469, '2022-06-02 07:55:51', '2022-06-02 07:55:51'),
(433, 74, 470, '2022-06-02 07:55:51', '2022-06-02 07:55:51'),
(434, 74, 471, '2022-06-02 07:55:51', '2022-06-02 07:55:51'),
(435, 74, 472, '2022-06-02 07:55:51', '2022-06-02 07:55:51'),
(436, 74, 473, '2022-06-02 07:55:51', '2022-06-02 07:55:51'),
(437, 75, 474, '2022-06-02 07:57:17', '2022-06-02 07:57:17'),
(438, 75, 475, '2022-06-02 07:57:17', '2022-06-02 07:57:17'),
(439, 75, 476, '2022-06-02 07:57:17', '2022-06-02 07:57:17'),
(440, 75, 477, '2022-06-02 07:57:17', '2022-06-02 07:57:17'),
(441, 75, 478, '2022-06-02 07:57:17', '2022-06-02 07:57:17'),
(442, 75, 479, '2022-06-02 07:57:17', '2022-06-02 07:57:17'),
(443, 75, 480, '2022-06-02 07:57:17', '2022-06-02 07:57:17'),
(444, 76, 481, '2022-06-02 07:58:39', '2022-06-02 07:58:39'),
(445, 76, 482, '2022-06-02 07:58:39', '2022-06-02 07:58:39'),
(446, 76, 483, '2022-06-02 07:58:39', '2022-06-02 07:58:39'),
(447, 76, 484, '2022-06-02 07:58:39', '2022-06-02 07:58:39'),
(448, 76, 485, '2022-06-02 07:58:39', '2022-06-02 07:58:39'),
(449, 76, 486, '2022-06-02 07:58:39', '2022-06-02 07:58:39'),
(450, 76, 487, '2022-06-02 07:58:39', '2022-06-02 07:58:39'),
(451, 77, 488, '2022-06-02 08:04:41', '2022-06-02 08:04:41'),
(452, 77, 489, '2022-06-02 08:04:41', '2022-06-02 08:04:41'),
(453, 77, 490, '2022-06-02 08:04:41', '2022-06-02 08:04:41'),
(454, 77, 491, '2022-06-02 08:04:41', '2022-06-02 08:04:41'),
(455, 77, 492, '2022-06-02 08:04:41', '2022-06-02 08:04:41'),
(456, 77, 493, '2022-06-02 08:04:41', '2022-06-02 08:04:41'),
(457, 77, 494, '2022-06-02 08:04:41', '2022-06-02 08:04:41'),
(458, 78, 495, '2022-06-02 08:12:47', '2022-06-02 08:12:47'),
(459, 78, 496, '2022-06-02 08:12:47', '2022-06-02 08:12:47'),
(460, 78, 497, '2022-06-02 08:12:47', '2022-06-02 08:12:47'),
(461, 78, 498, '2022-06-02 08:12:47', '2022-06-02 08:12:47'),
(462, 78, 499, '2022-06-02 08:12:47', '2022-06-02 08:12:47'),
(463, 78, 500, '2022-06-02 08:12:47', '2022-06-02 08:12:47'),
(464, 78, 501, '2022-06-02 08:12:47', '2022-06-02 08:12:47'),
(465, 79, 502, '2022-06-02 08:14:26', '2022-06-02 08:14:26'),
(466, 79, 503, '2022-06-02 08:14:26', '2022-06-02 08:14:26'),
(467, 79, 504, '2022-06-02 08:14:26', '2022-06-02 08:14:26'),
(468, 79, 505, '2022-06-02 08:14:26', '2022-06-02 08:14:26'),
(469, 79, 506, '2022-06-02 08:14:26', '2022-06-02 08:14:26'),
(470, 79, 507, '2022-06-02 08:14:26', '2022-06-02 08:14:26'),
(471, 79, 508, '2022-06-02 08:14:26', '2022-06-02 08:14:26'),
(472, 80, 509, '2022-06-02 08:16:19', '2022-06-02 08:16:19'),
(473, 80, 510, '2022-06-02 08:16:19', '2022-06-02 08:16:19'),
(474, 80, 511, '2022-06-02 08:16:19', '2022-06-02 08:16:19'),
(475, 80, 512, '2022-06-02 08:16:19', '2022-06-02 08:16:19'),
(476, 80, 513, '2022-06-02 08:16:19', '2022-06-02 08:16:19'),
(477, 80, 514, '2022-06-02 08:16:19', '2022-06-02 08:16:19'),
(478, 80, 515, '2022-06-02 08:16:19', '2022-06-02 08:16:19'),
(479, 81, 516, '2022-06-02 08:18:17', '2022-06-02 08:18:17'),
(480, 81, 517, '2022-06-02 08:18:17', '2022-06-02 08:18:17'),
(481, 81, 518, '2022-06-02 08:18:17', '2022-06-02 08:18:17'),
(482, 81, 519, '2022-06-02 08:18:17', '2022-06-02 08:18:17'),
(483, 81, 520, '2022-06-02 08:18:17', '2022-06-02 08:18:17'),
(484, 81, 521, '2022-06-02 08:18:17', '2022-06-02 08:18:17'),
(485, 81, 522, '2022-06-02 08:18:17', '2022-06-02 08:18:17'),
(486, 82, 523, '2022-06-02 08:26:00', '2022-06-02 08:26:00'),
(487, 82, 524, '2022-06-02 08:26:00', '2022-06-02 08:26:00'),
(488, 82, 525, '2022-06-02 08:26:00', '2022-06-02 08:26:00'),
(489, 82, 526, '2022-06-02 08:26:00', '2022-06-02 08:26:00'),
(490, 82, 527, '2022-06-02 08:26:00', '2022-06-02 08:26:00'),
(491, 82, 528, '2022-06-02 08:26:00', '2022-06-02 08:26:00'),
(492, 82, 529, '2022-06-02 08:26:00', '2022-06-02 08:26:00'),
(493, 83, 530, '2022-06-02 08:27:46', '2022-06-02 08:27:46'),
(494, 83, 531, '2022-06-02 08:27:46', '2022-06-02 08:27:46'),
(495, 83, 532, '2022-06-02 08:27:46', '2022-06-02 08:27:46'),
(496, 83, 533, '2022-06-02 08:27:46', '2022-06-02 08:27:46'),
(497, 83, 534, '2022-06-02 08:27:46', '2022-06-02 08:27:46'),
(498, 83, 535, '2022-06-02 08:27:46', '2022-06-02 08:27:46'),
(499, 83, 536, '2022-06-02 08:27:46', '2022-06-02 08:27:46'),
(500, 84, 537, '2022-06-02 08:29:33', '2022-06-02 08:29:33'),
(501, 84, 538, '2022-06-02 08:29:33', '2022-06-02 08:29:33'),
(502, 84, 539, '2022-06-02 08:29:33', '2022-06-02 08:29:33'),
(503, 84, 540, '2022-06-02 08:29:33', '2022-06-02 08:29:33'),
(504, 84, 541, '2022-06-02 08:29:33', '2022-06-02 08:29:33'),
(505, 84, 542, '2022-06-02 08:29:33', '2022-06-02 08:29:33'),
(506, 84, 543, '2022-06-02 08:29:33', '2022-06-02 08:29:33'),
(507, 85, 544, '2022-06-02 08:43:56', '2022-06-02 08:43:56'),
(508, 85, 545, '2022-06-02 08:43:56', '2022-06-02 08:43:56'),
(509, 85, 546, '2022-06-02 08:43:56', '2022-06-02 08:43:56'),
(510, 85, 547, '2022-06-02 08:43:56', '2022-06-02 08:43:56'),
(511, 85, 548, '2022-06-02 08:43:56', '2022-06-02 08:43:56'),
(512, 85, 549, '2022-06-02 08:43:56', '2022-06-02 08:43:56'),
(513, 85, 550, '2022-06-02 08:43:56', '2022-06-02 08:43:56'),
(514, 86, 551, '2022-06-02 08:45:37', '2022-06-02 08:45:37'),
(515, 86, 552, '2022-06-02 08:45:37', '2022-06-02 08:45:37'),
(516, 86, 553, '2022-06-02 08:45:37', '2022-06-02 08:45:37'),
(517, 86, 554, '2022-06-02 08:45:37', '2022-06-02 08:45:37'),
(518, 86, 555, '2022-06-02 08:45:37', '2022-06-02 08:45:37'),
(519, 86, 556, '2022-06-02 08:45:37', '2022-06-02 08:45:37'),
(520, 86, 557, '2022-06-02 08:45:37', '2022-06-02 08:45:37'),
(521, 87, 558, '2022-06-02 08:47:18', '2022-06-02 08:47:18'),
(522, 87, 559, '2022-06-02 08:47:18', '2022-06-02 08:47:18'),
(523, 87, 560, '2022-06-02 08:47:18', '2022-06-02 08:47:18'),
(524, 87, 561, '2022-06-02 08:47:18', '2022-06-02 08:47:18'),
(525, 87, 562, '2022-06-02 08:47:18', '2022-06-02 08:47:18'),
(526, 87, 563, '2022-06-02 08:47:18', '2022-06-02 08:47:18'),
(527, 87, 564, '2022-06-02 08:47:18', '2022-06-02 08:47:18'),
(528, 88, 565, '2022-06-02 08:48:47', '2022-06-02 08:48:47'),
(529, 88, 566, '2022-06-02 08:48:47', '2022-06-02 08:48:47'),
(530, 88, 567, '2022-06-02 08:48:47', '2022-06-02 08:48:47'),
(531, 88, 568, '2022-06-02 08:48:47', '2022-06-02 08:48:47'),
(532, 88, 569, '2022-06-02 08:48:47', '2022-06-02 08:48:47'),
(533, 88, 570, '2022-06-02 08:48:47', '2022-06-02 08:48:47'),
(534, 88, 571, '2022-06-02 08:48:47', '2022-06-02 08:48:47'),
(535, 89, 572, '2022-06-02 08:51:00', '2022-06-02 08:51:00'),
(536, 89, 573, '2022-06-02 08:51:00', '2022-06-02 08:51:00'),
(537, 89, 574, '2022-06-02 08:51:00', '2022-06-02 08:51:00'),
(538, 89, 575, '2022-06-02 08:51:00', '2022-06-02 08:51:00'),
(539, 89, 576, '2022-06-02 08:51:00', '2022-06-02 08:51:00'),
(540, 89, 577, '2022-06-02 08:51:00', '2022-06-02 08:51:00'),
(541, 89, 578, '2022-06-02 08:51:00', '2022-06-02 08:51:00'),
(542, 90, 579, '2022-06-02 09:04:18', '2022-06-02 09:04:18'),
(543, 90, 580, '2022-06-02 09:04:18', '2022-06-02 09:04:18'),
(544, 90, 581, '2022-06-02 09:04:18', '2022-06-02 09:04:18'),
(545, 90, 582, '2022-06-02 09:04:18', '2022-06-02 09:04:18'),
(546, 90, 583, '2022-06-02 09:04:18', '2022-06-02 09:04:18'),
(547, 90, 584, '2022-06-02 09:04:18', '2022-06-02 09:04:18'),
(548, 90, 585, '2022-06-02 09:04:18', '2022-06-02 09:04:18'),
(549, 91, 586, '2022-06-02 09:06:29', '2022-06-02 09:06:29'),
(550, 91, 587, '2022-06-02 09:06:29', '2022-06-02 09:06:29'),
(551, 91, 588, '2022-06-02 09:06:29', '2022-06-02 09:06:29'),
(552, 91, 589, '2022-06-02 09:06:29', '2022-06-02 09:06:29'),
(553, 91, 590, '2022-06-02 09:06:29', '2022-06-02 09:06:29'),
(554, 91, 591, '2022-06-02 09:06:29', '2022-06-02 09:06:29'),
(555, 91, 592, '2022-06-02 09:06:29', '2022-06-02 09:06:29'),
(556, 92, 593, '2022-06-02 09:08:19', '2022-06-02 09:08:19'),
(557, 92, 594, '2022-06-02 09:08:19', '2022-06-02 09:08:19'),
(558, 92, 595, '2022-06-02 09:08:19', '2022-06-02 09:08:19'),
(559, 92, 596, '2022-06-02 09:08:19', '2022-06-02 09:08:19'),
(560, 92, 597, '2022-06-02 09:08:19', '2022-06-02 09:08:19'),
(561, 92, 598, '2022-06-02 09:08:19', '2022-06-02 09:08:19'),
(562, 92, 599, '2022-06-02 09:08:19', '2022-06-02 09:08:19'),
(563, 93, 600, '2022-06-02 09:17:33', '2022-06-02 09:17:33'),
(564, 93, 601, '2022-06-02 09:17:33', '2022-06-02 09:17:33'),
(565, 93, 602, '2022-06-02 09:17:33', '2022-06-02 09:17:33'),
(566, 93, 603, '2022-06-02 09:17:33', '2022-06-02 09:17:33'),
(567, 93, 604, '2022-06-02 09:17:33', '2022-06-02 09:17:33'),
(568, 93, 605, '2022-06-02 09:17:33', '2022-06-02 09:17:33'),
(569, 93, 606, '2022-06-02 09:17:33', '2022-06-02 09:17:33'),
(570, 94, 607, '2022-06-02 09:18:47', '2022-06-02 09:18:47'),
(571, 94, 608, '2022-06-02 09:18:47', '2022-06-02 09:18:47'),
(572, 94, 609, '2022-06-02 09:18:47', '2022-06-02 09:18:47'),
(573, 94, 610, '2022-06-02 09:18:47', '2022-06-02 09:18:47'),
(574, 94, 611, '2022-06-02 09:18:47', '2022-06-02 09:18:47'),
(575, 94, 612, '2022-06-02 09:18:47', '2022-06-02 09:18:47'),
(576, 94, 613, '2022-06-02 09:18:47', '2022-06-02 09:18:47'),
(577, 95, 614, '2022-06-02 09:23:43', '2022-06-02 09:23:43'),
(578, 95, 615, '2022-06-02 09:23:43', '2022-06-02 09:23:43'),
(579, 95, 616, '2022-06-02 09:23:43', '2022-06-02 09:23:43'),
(580, 95, 617, '2022-06-02 09:23:43', '2022-06-02 09:23:43'),
(581, 95, 618, '2022-06-02 09:23:43', '2022-06-02 09:23:43'),
(582, 95, 619, '2022-06-02 09:23:43', '2022-06-02 09:23:43'),
(583, 95, 620, '2022-06-02 09:23:43', '2022-06-02 09:23:43'),
(584, 96, 621, '2022-06-02 09:30:37', '2022-06-02 09:30:37'),
(585, 96, 622, '2022-06-02 09:30:37', '2022-06-02 09:30:37'),
(586, 96, 623, '2022-06-02 09:30:37', '2022-06-02 09:30:37'),
(587, 96, 624, '2022-06-02 09:30:37', '2022-06-02 09:30:37'),
(588, 96, 625, '2022-06-02 09:30:37', '2022-06-02 09:30:37'),
(589, 96, 626, '2022-06-02 09:30:37', '2022-06-02 09:30:37'),
(590, 96, 627, '2022-06-02 09:30:37', '2022-06-02 09:30:37'),
(591, 97, 628, '2022-06-02 09:31:46', '2022-06-02 09:31:46'),
(592, 97, 629, '2022-06-02 09:31:46', '2022-06-02 09:31:46'),
(593, 97, 630, '2022-06-02 09:31:46', '2022-06-02 09:31:46'),
(594, 97, 631, '2022-06-02 09:31:46', '2022-06-02 09:31:46'),
(595, 97, 632, '2022-06-02 09:31:46', '2022-06-02 09:31:46'),
(596, 97, 633, '2022-06-02 09:31:46', '2022-06-02 09:31:46'),
(597, 97, 634, '2022-06-02 09:31:46', '2022-06-02 09:31:46'),
(598, 98, 635, '2022-06-02 09:40:47', '2022-06-02 09:40:47'),
(599, 98, 636, '2022-06-02 09:40:47', '2022-06-02 09:40:47'),
(600, 98, 637, '2022-06-02 09:40:47', '2022-06-02 09:40:47'),
(601, 98, 638, '2022-06-02 09:40:47', '2022-06-02 09:40:47'),
(602, 98, 639, '2022-06-02 09:40:47', '2022-06-02 09:40:47'),
(603, 98, 640, '2022-06-02 09:40:47', '2022-06-02 09:40:47'),
(604, 98, 641, '2022-06-02 09:40:47', '2022-06-02 09:40:47'),
(605, 99, 642, '2022-06-02 09:42:10', '2022-06-02 09:42:10'),
(606, 99, 643, '2022-06-02 09:42:10', '2022-06-02 09:42:10'),
(607, 99, 644, '2022-06-02 09:42:10', '2022-06-02 09:42:10'),
(608, 99, 645, '2022-06-02 09:42:10', '2022-06-02 09:42:10'),
(609, 99, 646, '2022-06-02 09:42:10', '2022-06-02 09:42:10'),
(610, 99, 647, '2022-06-02 09:42:10', '2022-06-02 09:42:10'),
(611, 99, 648, '2022-06-02 09:42:10', '2022-06-02 09:42:10'),
(612, 100, 649, '2022-06-02 09:44:11', '2022-06-02 09:44:11'),
(613, 100, 650, '2022-06-02 09:44:11', '2022-06-02 09:44:11'),
(614, 100, 651, '2022-06-02 09:44:11', '2022-06-02 09:44:11'),
(615, 100, 652, '2022-06-02 09:44:11', '2022-06-02 09:44:11'),
(616, 100, 653, '2022-06-02 09:44:11', '2022-06-02 09:44:11'),
(617, 100, 654, '2022-06-02 09:44:11', '2022-06-02 09:44:11'),
(618, 100, 655, '2022-06-02 09:44:11', '2022-06-02 09:44:11'),
(619, 101, 656, '2022-06-02 09:45:51', '2022-06-02 09:45:51'),
(620, 101, 657, '2022-06-02 09:45:51', '2022-06-02 09:45:51'),
(621, 101, 658, '2022-06-02 09:45:51', '2022-06-02 09:45:51'),
(622, 101, 659, '2022-06-02 09:45:51', '2022-06-02 09:45:51'),
(623, 101, 660, '2022-06-02 09:45:51', '2022-06-02 09:45:51'),
(624, 101, 661, '2022-06-02 09:45:51', '2022-06-02 09:45:51'),
(625, 101, 662, '2022-06-02 09:45:51', '2022-06-02 09:45:51'),
(626, 102, 663, '2022-06-02 09:53:52', '2022-06-02 09:53:52'),
(627, 102, 664, '2022-06-02 09:53:52', '2022-06-02 09:53:52'),
(628, 102, 665, '2022-06-02 09:53:52', '2022-06-02 09:53:52'),
(629, 102, 666, '2022-06-02 09:53:52', '2022-06-02 09:53:52'),
(630, 102, 667, '2022-06-02 09:53:52', '2022-06-02 09:53:52'),
(631, 102, 668, '2022-06-02 09:53:52', '2022-06-02 09:53:52'),
(632, 102, 669, '2022-06-02 09:53:52', '2022-06-02 09:53:52'),
(633, 103, 670, '2022-06-02 09:56:26', '2022-06-02 09:56:26'),
(634, 103, 671, '2022-06-02 09:56:26', '2022-06-02 09:56:26'),
(635, 103, 672, '2022-06-02 09:56:26', '2022-06-02 09:56:26'),
(636, 103, 673, '2022-06-02 09:56:26', '2022-06-02 09:56:26'),
(637, 103, 674, '2022-06-02 09:56:26', '2022-06-02 09:56:26'),
(638, 103, 675, '2022-06-02 09:56:26', '2022-06-02 09:56:26'),
(639, 103, 676, '2022-06-02 09:56:26', '2022-06-02 09:56:26'),
(640, 104, 677, '2022-06-02 09:58:00', '2022-06-02 09:58:00'),
(641, 104, 678, '2022-06-02 09:58:00', '2022-06-02 09:58:00'),
(642, 104, 679, '2022-06-02 09:58:00', '2022-06-02 09:58:00'),
(643, 104, 680, '2022-06-02 09:58:00', '2022-06-02 09:58:00'),
(644, 104, 681, '2022-06-02 09:58:00', '2022-06-02 09:58:00'),
(645, 104, 682, '2022-06-02 09:58:00', '2022-06-02 09:58:00'),
(646, 104, 683, '2022-06-02 09:58:00', '2022-06-02 09:58:00'),
(647, 105, 684, '2022-06-03 07:42:46', '2022-06-03 07:42:46'),
(648, 105, 685, '2022-06-03 07:42:46', '2022-06-03 07:42:46'),
(649, 105, 686, '2022-06-03 07:42:46', '2022-06-03 07:42:46'),
(650, 105, 687, '2022-06-03 07:42:46', '2022-06-03 07:42:46'),
(651, 105, 688, '2022-06-03 07:42:46', '2022-06-03 07:42:46'),
(652, 105, 689, '2022-06-03 07:42:46', '2022-06-03 07:42:46'),
(653, 105, 690, '2022-06-03 07:42:46', '2022-06-03 07:42:46'),
(654, 106, 691, '2022-06-03 08:00:40', '2022-06-03 08:00:40'),
(655, 106, 692, '2022-06-03 08:00:40', '2022-06-03 08:00:40'),
(656, 106, 693, '2022-06-03 08:00:40', '2022-06-03 08:00:40'),
(657, 106, 694, '2022-06-03 08:00:40', '2022-06-03 08:00:40'),
(658, 106, 695, '2022-06-03 08:00:40', '2022-06-03 08:00:40'),
(659, 106, 696, '2022-06-03 08:00:40', '2022-06-03 08:00:40'),
(660, 106, 697, '2022-06-03 08:00:40', '2022-06-03 08:00:40'),
(661, 107, 698, '2022-06-03 08:02:27', '2022-06-03 08:02:27'),
(662, 107, 699, '2022-06-03 08:02:27', '2022-06-03 08:02:27'),
(663, 107, 700, '2022-06-03 08:02:27', '2022-06-03 08:02:27'),
(664, 107, 701, '2022-06-03 08:02:27', '2022-06-03 08:02:27'),
(665, 107, 702, '2022-06-03 08:02:27', '2022-06-03 08:02:27'),
(666, 107, 703, '2022-06-03 08:02:27', '2022-06-03 08:02:27'),
(667, 107, 704, '2022-06-03 08:02:27', '2022-06-03 08:02:27'),
(668, 108, 705, '2022-06-03 08:03:44', '2022-06-03 08:03:44'),
(669, 108, 706, '2022-06-03 08:03:44', '2022-06-03 08:03:44'),
(670, 108, 707, '2022-06-03 08:03:44', '2022-06-03 08:03:44'),
(671, 108, 708, '2022-06-03 08:03:44', '2022-06-03 08:03:44'),
(672, 108, 709, '2022-06-03 08:03:44', '2022-06-03 08:03:44'),
(673, 108, 710, '2022-06-03 08:03:44', '2022-06-03 08:03:44'),
(674, 108, 711, '2022-06-03 08:03:44', '2022-06-03 08:03:44'),
(675, 109, 712, '2022-06-03 08:08:10', '2022-06-03 08:08:10'),
(676, 109, 713, '2022-06-03 08:08:10', '2022-06-03 08:08:10'),
(677, 109, 714, '2022-06-03 08:08:10', '2022-06-03 08:08:10'),
(678, 109, 715, '2022-06-03 08:08:10', '2022-06-03 08:08:10'),
(679, 109, 716, '2022-06-03 08:08:10', '2022-06-03 08:08:10'),
(680, 109, 717, '2022-06-03 08:08:10', '2022-06-03 08:08:10'),
(681, 109, 718, '2022-06-03 08:08:10', '2022-06-03 08:08:10'),
(682, 110, 719, '2022-06-03 08:14:33', '2022-06-03 08:14:33'),
(683, 110, 720, '2022-06-03 08:14:33', '2022-06-03 08:14:33'),
(684, 110, 721, '2022-06-03 08:14:33', '2022-06-03 08:14:33'),
(685, 110, 722, '2022-06-03 08:14:33', '2022-06-03 08:14:33'),
(686, 110, 723, '2022-06-03 08:14:33', '2022-06-03 08:14:33'),
(687, 110, 724, '2022-06-03 08:14:33', '2022-06-03 08:14:33'),
(688, 110, 725, '2022-06-03 08:14:33', '2022-06-03 08:14:33'),
(689, 111, 726, '2022-06-07 14:39:56', '2022-06-07 14:39:56'),
(690, 111, 727, '2022-06-07 14:39:56', '2022-06-07 14:39:56'),
(691, 111, 728, '2022-06-07 14:39:56', '2022-06-07 14:39:56'),
(692, 111, 729, '2022-06-07 14:39:56', '2022-06-07 14:39:56'),
(693, 111, 730, '2022-06-07 14:39:56', '2022-06-07 14:39:56'),
(694, 111, 731, '2022-06-07 14:39:56', '2022-06-07 14:39:56'),
(695, 111, 732, '2022-06-07 14:39:56', '2022-06-07 14:39:56'),
(696, 112, 733, '2022-06-07 14:48:45', '2022-06-07 14:48:45'),
(697, 112, 734, '2022-06-07 14:48:45', '2022-06-07 14:48:45'),
(698, 112, 735, '2022-06-07 14:48:45', '2022-06-07 14:48:45'),
(699, 112, 736, '2022-06-07 14:48:45', '2022-06-07 14:48:45'),
(700, 112, 737, '2022-06-07 14:48:45', '2022-06-07 14:48:45'),
(701, 112, 738, '2022-06-07 14:48:45', '2022-06-07 14:48:45'),
(702, 112, 739, '2022-06-07 14:48:45', '2022-06-07 14:48:45'),
(703, 113, 740, '2022-06-07 14:54:50', '2022-06-07 14:54:50'),
(704, 113, 741, '2022-06-07 14:54:50', '2022-06-07 14:54:50'),
(705, 113, 742, '2022-06-07 14:54:50', '2022-06-07 14:54:50'),
(706, 113, 743, '2022-06-07 14:54:50', '2022-06-07 14:54:50'),
(707, 113, 744, '2022-06-07 14:54:50', '2022-06-07 14:54:50'),
(708, 113, 745, '2022-06-07 14:54:50', '2022-06-07 14:54:50'),
(709, 113, 746, '2022-06-07 14:54:50', '2022-06-07 14:54:50'),
(710, 114, 747, '2022-06-07 14:59:32', '2022-06-07 14:59:32'),
(711, 114, 748, '2022-06-07 14:59:32', '2022-06-07 14:59:32'),
(712, 114, 749, '2022-06-07 14:59:32', '2022-06-07 14:59:32'),
(713, 114, 750, '2022-06-07 14:59:32', '2022-06-07 14:59:32'),
(714, 114, 751, '2022-06-07 14:59:32', '2022-06-07 14:59:32'),
(715, 114, 752, '2022-06-07 14:59:32', '2022-06-07 14:59:32'),
(716, 114, 753, '2022-06-07 14:59:32', '2022-06-07 14:59:32'),
(717, 115, 754, '2022-06-07 15:03:44', '2022-06-07 15:03:44'),
(718, 115, 755, '2022-06-07 15:03:44', '2022-06-07 15:03:44'),
(719, 115, 756, '2022-06-07 15:03:44', '2022-06-07 15:03:44'),
(720, 115, 757, '2022-06-07 15:03:44', '2022-06-07 15:03:44'),
(721, 115, 758, '2022-06-07 15:03:44', '2022-06-07 15:03:44'),
(722, 115, 759, '2022-06-07 15:03:44', '2022-06-07 15:03:44'),
(723, 115, 760, '2022-06-07 15:03:44', '2022-06-07 15:03:44'),
(724, 116, 761, '2022-06-07 15:07:17', '2022-06-07 15:07:17'),
(725, 116, 762, '2022-06-07 15:07:17', '2022-06-07 15:07:17'),
(726, 116, 763, '2022-06-07 15:07:17', '2022-06-07 15:07:17'),
(727, 116, 764, '2022-06-07 15:07:17', '2022-06-07 15:07:17'),
(728, 116, 765, '2022-06-07 15:07:17', '2022-06-07 15:07:17'),
(729, 116, 766, '2022-06-07 15:07:17', '2022-06-07 15:07:17'),
(730, 116, 767, '2022-06-07 15:07:17', '2022-06-07 15:07:17'),
(731, 117, 768, '2022-06-07 15:13:06', '2022-06-07 15:13:06'),
(732, 117, 769, '2022-06-07 15:13:06', '2022-06-07 15:13:06'),
(733, 117, 770, '2022-06-07 15:13:06', '2022-06-07 15:13:06'),
(734, 117, 771, '2022-06-07 15:13:06', '2022-06-07 15:13:06'),
(735, 117, 772, '2022-06-07 15:13:06', '2022-06-07 15:13:06'),
(736, 117, 773, '2022-06-07 15:13:06', '2022-06-07 15:13:06'),
(737, 117, 774, '2022-06-07 15:13:06', '2022-06-07 15:13:06'),
(738, 118, 775, '2022-06-07 15:18:30', '2022-06-07 15:18:30'),
(739, 118, 776, '2022-06-07 15:18:30', '2022-06-07 15:18:30'),
(740, 118, 777, '2022-06-07 15:18:30', '2022-06-07 15:18:30'),
(741, 118, 778, '2022-06-07 15:18:30', '2022-06-07 15:18:30'),
(742, 118, 779, '2022-06-07 15:18:30', '2022-06-07 15:18:30'),
(743, 118, 780, '2022-06-07 15:18:30', '2022-06-07 15:18:30'),
(744, 118, 781, '2022-06-07 15:18:30', '2022-06-07 15:18:30');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_specifications`
--

CREATE TABLE `product_specifications` (
  `ID` int(11) NOT NULL,
  `specification_type` int(11) NOT NULL COMMENT 'loại đặc trưng',
  `value` text DEFAULT NULL COMMENT 'giá trị',
  `unit` text DEFAULT NULL COMMENT 'đơn vị',
  `start_date` timestamp NULL DEFAULT NULL,
  `end_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `product_specifications`
--

INSERT INTO `product_specifications` (`ID`, `specification_type`, `value`, `unit`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES
(82, 3, 'localhost/storage/files/10/Sofa1_2.jpg', NULL, NULL, NULL, '2022-02-28 18:54:49', '2022-02-28 18:54:49'),
(83, 4, 'localhost/storage/files/10/Sofa1_3.jpg', NULL, NULL, NULL, '2022-02-28 18:54:49', '2022-02-28 18:54:49'),
(84, 5, 'localhost/storage/files/10/Sofa1_4.jpg', NULL, NULL, NULL, '2022-02-28 18:54:49', '2022-02-28 18:54:49'),
(85, 2, 'localhost/storage/files/10/Sofa1_5.jpg', NULL, NULL, NULL, '2022-02-28 18:54:49', '2022-02-28 18:54:49'),
(86, 6, 'localhost/storage/files/10/Sofa1_1.jpg', NULL, NULL, NULL, '2022-02-28 18:54:49', '2022-02-28 18:54:49'),
(87, 1, '#dcb6b6', NULL, NULL, NULL, '2022-02-28 18:54:49', '2022-02-28 18:54:49'),
(88, 7, '4', NULL, NULL, NULL, '2022-02-28 18:54:49', '2022-02-28 18:54:49'),
(89, 3, 'localhost/storage/files/10/sofa2_3.jpg', NULL, NULL, NULL, '2022-03-01 16:59:41', '2022-03-01 16:59:41'),
(90, 4, 'localhost/storage/files/10/sofa2_4.jpg', NULL, NULL, NULL, '2022-03-01 16:59:41', '2022-03-01 16:59:41'),
(91, 5, 'localhost/storage/files/10/sofa2_5.jpg', NULL, NULL, NULL, '2022-03-01 16:59:41', '2022-03-01 16:59:41'),
(92, 2, 'localhost/storage/files/10/sofa2_2.jpg', NULL, NULL, NULL, '2022-03-01 16:59:41', '2022-03-01 16:59:41'),
(93, 6, 'localhost/storage/files/10/sofa2_1.jpg', NULL, NULL, NULL, '2022-03-01 16:59:41', '2022-03-01 16:59:41'),
(94, 1, '#730b0b', NULL, NULL, NULL, '2022-03-01 16:59:41', '2022-03-01 16:59:41'),
(95, 7, '3', NULL, NULL, NULL, '2022-03-01 16:59:41', '2022-03-01 16:59:41'),
(96, 3, 'localhost/storage/files/10/sofa3_3.jpg', NULL, NULL, NULL, '2022-03-01 17:04:44', '2022-03-01 17:04:44'),
(97, 4, 'localhost/storage/files/10/sofa3_4.jpg', NULL, NULL, NULL, '2022-03-01 17:04:44', '2022-03-01 17:04:44'),
(98, 5, 'localhost/storage/files/10/sofa3_5.jpg', NULL, NULL, NULL, '2022-03-01 17:04:44', '2022-03-01 17:04:44'),
(99, 2, 'localhost/storage/files/10/sofa3_2.jpg', NULL, NULL, NULL, '2022-03-01 17:04:44', '2022-03-01 17:04:44'),
(100, 6, 'localhost/storage/files/10/sofa3_2.jpg', NULL, NULL, NULL, '2022-03-01 17:04:44', '2022-03-01 17:04:44'),
(101, 1, '#e48888', NULL, NULL, NULL, '2022-03-01 17:04:44', '2022-03-01 17:04:44'),
(102, 7, '4', NULL, NULL, NULL, '2022-03-01 17:04:44', '2022-03-01 17:04:44'),
(103, 3, 'localhost/storage/files/10/sf4_2.jpg', NULL, NULL, NULL, '2022-03-01 17:14:23', '2022-03-01 17:14:23'),
(104, 4, 'localhost/storage/files/10/sf4_3.jpg', NULL, NULL, NULL, '2022-03-01 17:14:23', '2022-03-01 17:14:23'),
(105, 5, 'localhost/storage/files/10/sf4_5.jpg', NULL, NULL, NULL, '2022-03-01 17:14:23', '2022-03-01 17:14:23'),
(106, 2, 'localhost/storage/files/10/sf4_4.jpg', NULL, NULL, NULL, '2022-03-01 17:14:23', '2022-03-01 17:14:23'),
(107, 6, 'localhost/storage/files/10/sf4_1.jpg', NULL, NULL, NULL, '2022-03-01 17:14:23', '2022-03-01 17:14:23'),
(108, 1, '#7d5a02', NULL, NULL, NULL, '2022-03-01 17:14:23', '2022-03-01 17:14:23'),
(109, 7, '4', NULL, NULL, NULL, '2022-03-01 17:14:23', '2022-03-01 17:14:23'),
(110, 3, 'localhost/storage/files/10/sf5_3.jpg', NULL, NULL, NULL, '2022-03-01 17:21:51', '2022-03-01 17:21:51'),
(111, 4, 'localhost/storage/files/10/sf5_4.jpg', NULL, NULL, NULL, '2022-03-01 17:21:51', '2022-03-01 17:21:51'),
(112, 5, 'localhost/storage/files/10/sf5_5.jpg', NULL, NULL, NULL, '2022-03-01 17:21:51', '2022-03-01 17:21:51'),
(113, 2, 'localhost/storage/files/10/sf5_2.jpg', NULL, NULL, NULL, '2022-03-01 17:21:51', '2022-03-01 17:21:51'),
(114, 6, 'localhost/storage/files/10/sf5_1.jpg', NULL, NULL, NULL, '2022-03-01 17:21:51', '2022-03-01 17:21:51'),
(115, 1, '#b45151', NULL, NULL, NULL, '2022-03-01 17:21:51', '2022-03-01 17:21:51'),
(116, 7, '3', NULL, NULL, NULL, '2022-03-01 17:21:51', '2022-03-01 17:21:51'),
(117, 3, 'localhost/storage/files/10/sf6_3.jpg', NULL, NULL, NULL, '2022-03-01 17:34:39', '2022-03-01 17:34:39'),
(118, 4, 'localhost/storage/files/10/sf6_4.jpg', NULL, NULL, NULL, '2022-03-01 17:34:39', '2022-03-01 17:34:39'),
(119, 5, 'localhost/storage/files/10/sf6_5.jpg', NULL, NULL, NULL, '2022-03-01 17:34:39', '2022-03-01 17:34:39'),
(120, 2, 'localhost/storage/files/10/sf6_2.jpg', NULL, NULL, NULL, '2022-03-01 17:34:39', '2022-03-01 17:34:39'),
(121, 6, 'localhost/storage/files/10/sf6_1.jpg', NULL, NULL, NULL, '2022-03-01 17:34:39', '2022-03-01 17:34:39'),
(122, 1, '#f3e7e7', NULL, NULL, NULL, '2022-03-01 17:34:39', '2022-03-01 17:34:39'),
(123, 7, '8', NULL, NULL, NULL, '2022-03-01 17:34:39', '2022-03-01 17:34:39'),
(124, 3, 'localhost/storage/files/10/sf7_3.jpg', NULL, NULL, NULL, '2022-03-01 17:38:24', '2022-03-01 17:38:24'),
(125, 4, 'localhost/storage/files/10/sf7_4.jpg', NULL, NULL, NULL, '2022-03-01 17:38:24', '2022-03-01 17:38:24'),
(126, 5, 'localhost/storage/files/10/sf7_5.jpg', NULL, NULL, NULL, '2022-03-01 17:38:24', '2022-03-01 17:38:24'),
(127, 2, 'localhost/storage/files/10/sf7_2.jpg', NULL, NULL, NULL, '2022-03-01 17:38:24', '2022-03-01 17:38:24'),
(128, 6, 'localhost/storage/files/10/sf7_1.jpg', NULL, NULL, NULL, '2022-03-01 17:38:24', '2022-03-01 17:38:24'),
(129, 1, 'black', NULL, NULL, NULL, '2022-03-01 17:38:24', '2022-03-01 17:38:24'),
(130, 7, '9', NULL, NULL, NULL, '2022-03-01 17:38:24', '2022-03-01 17:38:24'),
(131, 3, 'localhost/storage/files/10/sf8_4.jpg', NULL, NULL, NULL, '2022-03-01 17:43:18', '2022-03-01 17:43:18'),
(132, 4, 'localhost/storage/files/10/sf8_3.jpg', NULL, NULL, NULL, '2022-03-01 17:43:18', '2022-03-01 17:43:18'),
(133, 5, 'localhost/storage/files/10/sf8_1.jpg', NULL, NULL, NULL, '2022-03-01 17:43:18', '2022-03-01 17:43:18'),
(134, 2, 'localhost/storage/files/10/sf8_6.jpg', NULL, NULL, NULL, '2022-03-01 17:43:18', '2022-03-01 17:43:18'),
(135, 6, 'localhost/storage/files/10/sf8_5.jpg', NULL, NULL, NULL, '2022-03-01 17:43:18', '2022-03-01 17:43:18'),
(136, 1, 'black', NULL, NULL, NULL, '2022-03-01 17:43:18', '2022-03-01 17:43:18'),
(137, 7, '6', NULL, NULL, NULL, '2022-03-01 17:43:18', '2022-03-01 17:43:18'),
(138, 3, 'localhost/storage/files/10/sf9_3.jpg', NULL, NULL, NULL, '2022-03-01 17:47:31', '2022-03-01 17:47:31'),
(139, 4, 'localhost/storage/files/10/sf9_4.jpg', NULL, NULL, NULL, '2022-03-01 17:47:31', '2022-03-01 17:47:31'),
(140, 5, 'localhost/storage/files/10/sf9_5.jpg', NULL, NULL, NULL, '2022-03-01 17:47:31', '2022-03-01 17:47:31'),
(141, 2, 'localhost/storage/files/10/sf9_2.jpg', NULL, NULL, NULL, '2022-03-01 17:47:31', '2022-03-01 17:47:31'),
(142, 6, 'localhost/storage/files/10/sf9_1.jpg', NULL, NULL, NULL, '2022-03-01 17:47:31', '2022-03-01 17:47:31'),
(143, 1, 'black', NULL, NULL, NULL, '2022-03-01 17:47:31', '2022-03-01 17:47:31'),
(144, 7, '6', NULL, NULL, NULL, '2022-03-01 17:47:31', '2022-03-01 17:47:31'),
(145, 3, 'localhost/storage/files/10/sf10_2.jpg', NULL, NULL, NULL, '2022-03-01 17:54:44', '2022-03-01 17:54:44'),
(146, 4, 'localhost/storage/files/10/sf10_3.jpg', NULL, NULL, NULL, '2022-03-01 17:54:44', '2022-03-01 17:54:44'),
(147, 5, 'localhost/storage/files/10/sf10_4.jpg', NULL, NULL, NULL, '2022-03-01 17:54:44', '2022-03-01 17:54:44'),
(148, 2, 'localhost/storage/files/10/sf10_1.jpg', NULL, NULL, NULL, '2022-03-01 17:54:44', '2022-03-01 17:54:44'),
(149, 6, 'localhost/storage/files/10/sf10_5.jpg', NULL, NULL, NULL, '2022-03-01 17:54:44', '2022-03-01 17:54:44'),
(150, 1, 'black', NULL, NULL, NULL, '2022-03-01 17:54:44', '2022-03-01 17:54:44'),
(151, 7, '3', NULL, NULL, NULL, '2022-03-01 17:54:44', '2022-03-01 17:54:44'),
(152, 3, NULL, NULL, NULL, NULL, '2022-03-01 18:05:55', '2022-03-01 18:05:55'),
(153, 4, NULL, NULL, NULL, NULL, '2022-03-01 18:05:55', '2022-03-01 18:05:55'),
(154, 5, NULL, NULL, NULL, NULL, '2022-03-01 18:05:55', '2022-03-01 18:05:55'),
(155, 2, NULL, NULL, NULL, NULL, '2022-03-01 18:05:55', '2022-03-01 18:05:55'),
(156, 6, NULL, NULL, NULL, NULL, '2022-03-01 18:05:55', '2022-03-01 18:05:55'),
(157, 1, '#f7e6e6', NULL, NULL, NULL, '2022-03-01 18:05:55', '2022-03-01 18:05:55'),
(158, 7, '4', NULL, NULL, NULL, '2022-03-01 18:05:55', '2022-03-01 18:05:55'),
(159, 3, 'localhost/storage/files/10/chair3_5.jpg', NULL, NULL, NULL, '2022-03-02 17:13:34', '2022-03-02 17:13:34'),
(160, 4, 'localhost/storage/files/10/chair3_4.jpg', NULL, NULL, NULL, '2022-03-02 17:13:34', '2022-03-02 17:13:34'),
(161, 5, 'localhost/storage/files/10/chair3_3.jpg', NULL, NULL, NULL, '2022-03-02 17:13:34', '2022-03-02 17:13:34'),
(162, 2, 'localhost/storage/files/10/chair3_2.jpg', NULL, NULL, NULL, '2022-03-02 17:13:34', '2022-03-02 17:13:34'),
(163, 6, 'localhost/storage/files/10/chair3_1.jpg', NULL, NULL, NULL, '2022-03-02 17:13:34', '2022-03-02 17:13:34'),
(164, 1, 'black', NULL, NULL, NULL, '2022-03-02 17:13:34', '2022-03-02 17:13:34'),
(165, 7, '8', NULL, NULL, NULL, '2022-03-02 17:13:34', '2022-03-02 17:13:34'),
(166, 3, 'localhost/storage/files/10/chair4_3.jpg', NULL, NULL, NULL, '2022-03-02 17:24:58', '2022-03-02 17:24:58'),
(167, 4, 'localhost/storage/files/10/chair4_4.jpg', NULL, NULL, NULL, '2022-03-02 17:24:58', '2022-03-02 17:24:58'),
(168, 5, 'localhost/storage/files/10/chair4_5.jpg', NULL, NULL, NULL, '2022-03-02 17:24:58', '2022-03-02 17:24:58'),
(169, 2, 'localhost/storage/files/10/chair4_2.jpg', NULL, NULL, NULL, '2022-03-02 17:24:58', '2022-03-02 17:24:58'),
(170, 6, 'localhost/storage/files/10/chair4_1.jpg', NULL, NULL, NULL, '2022-03-02 17:24:58', '2022-03-02 17:24:58'),
(171, 1, '#fbf1f1', NULL, NULL, NULL, '2022-03-02 17:24:58', '2022-03-02 17:24:58'),
(172, 7, '9', NULL, NULL, NULL, '2022-03-02 17:24:58', '2022-03-02 17:24:58'),
(173, 3, 'localhost/storage/files/10/chair5_2.jpg', NULL, NULL, NULL, '2022-03-02 17:33:20', '2022-03-02 17:33:20'),
(174, 4, 'localhost/storage/files/10/chair5_3.png', NULL, NULL, NULL, '2022-03-02 17:33:20', '2022-03-02 17:33:20'),
(175, 5, 'localhost/storage/files/10/chair5_4.png', NULL, NULL, NULL, '2022-03-02 17:33:20', '2022-03-02 17:33:20'),
(176, 2, 'localhost/storage/files/10/chair5_5.png', NULL, NULL, NULL, '2022-03-02 17:33:20', '2022-03-02 17:33:20'),
(177, 6, 'localhost/storage/files/10/chair5_1.jpg', NULL, NULL, NULL, '2022-03-02 17:33:20', '2022-03-02 17:33:20'),
(178, 1, '#e9e467', NULL, NULL, NULL, '2022-03-02 17:33:20', '2022-03-02 17:33:20'),
(179, 7, '7', NULL, NULL, NULL, '2022-03-02 17:33:20', '2022-03-02 17:33:20'),
(180, 3, 'localhost/storage/files/10/chair6_2.png', NULL, NULL, NULL, '2022-03-02 17:38:08', '2022-03-02 17:38:08'),
(181, 4, 'localhost/storage/files/10/chair6_4.png', NULL, NULL, NULL, '2022-03-02 17:38:08', '2022-03-02 17:38:08'),
(182, 5, 'localhost/storage/files/10/chair6_5.png', NULL, NULL, NULL, '2022-03-02 17:38:08', '2022-03-02 17:38:08'),
(183, 2, 'localhost/storage/files/10/chair6_3.png', NULL, NULL, NULL, '2022-03-02 17:38:08', '2022-03-02 17:38:08'),
(184, 6, 'localhost/storage/files/10/chair6_1.png', NULL, NULL, NULL, '2022-03-02 17:38:08', '2022-03-02 17:38:08'),
(185, 1, '#fff6f6', NULL, NULL, NULL, '2022-03-02 17:38:08', '2022-03-02 17:38:08'),
(186, 7, '6', NULL, NULL, NULL, '2022-03-02 17:38:08', '2022-03-02 17:38:08'),
(187, 3, 'localhost/storage/files/10/g1_2.png', NULL, NULL, NULL, '2022-03-02 17:46:09', '2022-03-02 17:46:09'),
(188, 4, 'localhost/storage/files/10/g1_3.png', NULL, NULL, NULL, '2022-03-02 17:46:09', '2022-03-02 17:46:09'),
(189, 5, 'localhost/storage/files/10/g1_4.png', NULL, NULL, NULL, '2022-03-02 17:46:09', '2022-03-02 17:46:09'),
(190, 2, 'localhost/storage/files/10/g1_5.png', NULL, NULL, NULL, '2022-03-02 17:46:09', '2022-03-02 17:46:09'),
(191, 6, 'localhost/storage/files/10/g1_1.png', NULL, NULL, NULL, '2022-03-02 17:46:09', '2022-03-02 17:46:09'),
(192, 1, 'black', NULL, NULL, NULL, '2022-03-02 17:46:09', '2022-03-02 17:46:09'),
(193, 7, '9', NULL, NULL, NULL, '2022-03-02 17:46:09', '2022-03-02 17:46:09'),
(194, 3, 'localhost/storage/files/10/g2_3.png', NULL, NULL, NULL, '2022-03-02 17:51:00', '2022-03-02 17:51:00'),
(195, 4, 'localhost/storage/files/10/g2_4.png', NULL, NULL, NULL, '2022-03-02 17:51:00', '2022-03-02 17:51:00'),
(196, 5, 'localhost/storage/files/10/g2_5.png', NULL, NULL, NULL, '2022-03-02 17:51:00', '2022-03-02 17:51:00'),
(197, 2, 'localhost/storage/files/10/g2_2.png', NULL, NULL, NULL, '2022-03-02 17:51:00', '2022-03-02 17:51:00'),
(198, 6, 'localhost/storage/files/10/g2_!.png', NULL, NULL, NULL, '2022-03-02 17:51:00', '2022-03-02 17:51:00'),
(199, 1, 'black', NULL, NULL, NULL, '2022-03-02 17:51:00', '2022-03-02 17:51:00'),
(200, 7, '7', NULL, NULL, NULL, '2022-03-02 17:51:00', '2022-03-02 17:51:00'),
(201, 3, 'localhost/storage/files/10/g3_5.png', NULL, NULL, NULL, '2022-03-02 18:00:27', '2022-03-02 18:00:27'),
(202, 4, 'localhost/storage/files/10/g3_2.png', NULL, NULL, NULL, '2022-03-02 18:00:27', '2022-03-02 18:00:27'),
(203, 5, 'localhost/storage/files/10/g2_3.png', NULL, NULL, NULL, '2022-03-02 18:00:27', '2022-03-02 18:00:27'),
(204, 2, 'localhost/storage/files/10/g3_4.png', NULL, NULL, NULL, '2022-03-02 18:00:27', '2022-03-02 18:00:27'),
(205, 6, 'localhost/storage/files/10/g3_1.png', NULL, NULL, NULL, '2022-03-02 18:00:27', '2022-03-02 18:00:27'),
(206, 1, 'white', NULL, NULL, NULL, '2022-03-02 18:00:27', '2022-03-02 18:00:27'),
(207, 7, '4', NULL, NULL, NULL, '2022-03-02 18:00:27', '2022-03-02 18:00:27'),
(208, 3, 'localhost/storage/files/10/g4_2.png', NULL, NULL, NULL, '2022-03-02 18:08:53', '2022-03-02 18:08:53'),
(209, 4, 'localhost/storage/files/10/g4_3.png', NULL, NULL, NULL, '2022-03-02 18:08:53', '2022-03-02 18:08:53'),
(210, 5, 'localhost/storage/files/10/g4_5.png', NULL, NULL, NULL, '2022-03-02 18:08:53', '2022-03-02 18:08:53'),
(211, 2, 'localhost/storage/files/10/g4_4.png', NULL, NULL, NULL, '2022-03-02 18:08:53', '2022-03-02 18:08:53'),
(212, 6, 'localhost/storage/files/10/g4_1.png', NULL, NULL, NULL, '2022-03-02 18:08:53', '2022-03-02 18:08:53'),
(213, 1, 'white', NULL, NULL, NULL, '2022-03-02 18:08:53', '2022-03-02 18:08:53'),
(214, 7, '9', NULL, NULL, NULL, '2022-03-02 18:08:53', '2022-03-02 18:08:53'),
(215, 3, 'localhost/storage/files/10/g5_3.png', NULL, NULL, NULL, '2022-03-02 18:14:44', '2022-03-02 18:14:44'),
(216, 4, 'localhost/storage/files/10/g5_4.png', NULL, NULL, NULL, '2022-03-02 18:14:44', '2022-03-02 18:14:44'),
(217, 5, 'localhost/storage/files/10/g5_5.png', NULL, NULL, NULL, '2022-03-02 18:14:44', '2022-03-02 18:14:44'),
(218, 2, 'localhost/storage/files/10/g5_2.png', NULL, NULL, NULL, '2022-03-02 18:14:44', '2022-03-02 18:14:44'),
(219, 6, 'localhost/storage/files/10/g5_1.png', NULL, NULL, NULL, '2022-03-02 18:14:44', '2022-03-02 18:14:44'),
(220, 1, 'black', NULL, NULL, NULL, '2022-03-02 18:14:44', '2022-03-02 18:14:44'),
(221, 7, '6', NULL, NULL, NULL, '2022-03-02 18:14:44', '2022-03-02 18:14:44'),
(222, 3, '/storage/files/10/271652337_140325598404642_5815672151226454858_n.jpg', NULL, NULL, NULL, '2022-03-25 02:18:11', '2022-03-25 02:18:11'),
(223, 4, '/storage/files/10/chair2_1.jpg', NULL, NULL, NULL, '2022-03-25 02:18:11', '2022-03-25 02:18:11'),
(224, 5, '/storage/files/10/271652337_140325598404642_5815672151226454858_n.jpg', NULL, NULL, NULL, '2022-03-25 02:18:11', '2022-03-25 02:18:11'),
(225, 2, '/storage/files/10/chair2_4.jpg', NULL, NULL, NULL, '2022-03-25 02:18:11', '2022-03-25 02:18:11'),
(226, 6, '/storage/files/10/chair2_2.jpg', NULL, NULL, NULL, '2022-03-25 02:18:11', '2022-03-25 02:18:11'),
(227, 1, 'black', NULL, NULL, NULL, '2022-03-25 02:18:11', '2022-03-25 02:18:11'),
(228, 7, '7', NULL, NULL, NULL, '2022-03-25 02:18:11', '2022-03-25 02:18:11'),
(229, 3, '/storage/files/10/strandmon/strandmon5.jpg', NULL, NULL, NULL, '2022-06-01 00:45:35', '2022-06-01 00:45:35'),
(230, 4, '/storage/files/10/strandmon/stranfmon3.jpg', NULL, NULL, NULL, '2022-06-01 00:45:35', '2022-06-01 00:45:35'),
(231, 5, '/storage/files/10/strandmon/strandmon6.jpg', NULL, NULL, NULL, '2022-06-01 00:45:35', '2022-06-01 00:45:35'),
(232, 2, '/storage/files/10/strandmon/strandmon1 (1).jpg', NULL, NULL, NULL, '2022-06-01 00:45:35', '2022-06-01 00:45:35'),
(233, 6, '/storage/files/10/strandmon/standmon2.jpg', NULL, NULL, NULL, '2022-06-01 00:45:35', '2022-06-01 00:45:35'),
(234, 1, 'black', NULL, NULL, NULL, '2022-06-01 00:45:35', '2022-06-01 00:45:35'),
(235, 7, '14', NULL, NULL, NULL, '2022-06-01 00:45:35', '2022-06-01 00:45:35'),
(236, 3, '/storage/files/10/strandmon/strandmon-wing-chair-djuparp-dark-green__0739102_ph152847_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:22:13', '2022-06-01 01:22:13'),
(237, 4, '/storage/files/10/strandmon/strandmon-wing-chair-djuparp-dark-green__0739102_ph152847_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:22:13', '2022-06-01 01:22:13'),
(238, 5, '/storage/files/10/strandmon/strandmon6.jpg', NULL, NULL, NULL, '2022-06-01 01:22:13', '2022-06-01 01:22:13'),
(239, 2, '/storage/files/10/strandmon/strandmon-wing-chair-djuparp-dark-green__0531313_pe647261_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:22:13', '2022-06-01 01:22:13'),
(240, 6, '/storage/files/10/strandmon/strandmon-wing-chair-djuparp-dark-green__0841150_pe647266_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:22:13', '2022-06-01 01:22:13'),
(241, 1, '#04775e', NULL, NULL, NULL, '2022-06-01 01:22:13', '2022-06-01 01:22:13'),
(242, 7, '14', NULL, NULL, NULL, '2022-06-01 01:22:13', '2022-06-01 01:22:13'),
(243, 3, '/storage/files/10/strandmon/strandmon-wing-chair-nordvalla-dark-gray__0750991_ph159256_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:26:22', '2022-06-01 01:26:22'),
(244, 4, '/storage/files/10/strandmon/strandmon-wing-chair-nordvalla-dark-gray__0813424_ph166295_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:26:22', '2022-06-01 01:26:22'),
(245, 5, '/storage/files/10/strandmon/strandmon6.jpg', NULL, NULL, NULL, '2022-06-01 01:26:22', '2022-06-01 01:26:22'),
(246, 2, '/storage/files/10/strandmon/strandmon-wing-chair-nordvalla-dark-gray__0325432_pe517964_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:26:22', '2022-06-01 01:26:22'),
(247, 6, '/storage/files/10/strandmon/strandmon-wing-chair-nordvalla-dark-gray__0836849_pe601178_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:26:22', '2022-06-01 01:26:22'),
(248, 1, '#ddd6d6', NULL, NULL, NULL, '2022-06-01 01:26:22', '2022-06-01 01:26:22'),
(249, 7, '14', NULL, NULL, NULL, '2022-06-01 01:26:22', '2022-06-01 01:26:22'),
(250, 3, '/storage/files/10/koarp/koarp-armchair-gunnared-beige-black__0840399_pe643188_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:35:10', '2022-06-01 01:35:10'),
(251, 4, '/storage/files/10/koarp/koarp-armchair-gunnared-beige-black__0712902_pe729115_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:35:10', '2022-06-01 01:35:10'),
(252, 5, '/storage/files/10/koarp/koarp-armchair-gunnared-beige-black__0681595_pe720191_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:35:10', '2022-06-01 01:35:10'),
(253, 2, '/storage/files/10/koarp/koarp-armchair-gunnared-beige-black__0522280_pe643185_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:35:10', '2022-06-01 01:35:10'),
(254, 6, '/storage/files/10/koarp/koarp-armchair-gunnared-beige-black__0840395_pe643186_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:35:10', '2022-06-01 01:35:10'),
(255, 1, 'rgba(206,201,201,0.96)', NULL, NULL, NULL, '2022-06-01 01:35:10', '2022-06-01 01:35:10'),
(256, 7, '13', NULL, NULL, NULL, '2022-06-01 01:35:10', '2022-06-01 01:35:10'),
(257, 3, '/storage/files/10/koarp/koarp-armchair-saxemara-black-blue-black__0949813_pe800033_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:38:44', '2022-06-01 01:38:44'),
(258, 4, '/storage/files/10/koarp/koarp-armchair-saxemara-black-blue-black__0949811_pe800028_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:38:44', '2022-06-01 01:38:44'),
(259, 5, '/storage/files/10/koarp/koarp-armchair-gunnared-beige-black__0681595_pe720191_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:38:44', '2022-06-01 01:38:44'),
(260, 2, '/storage/files/10/koarp/koarp-armchair-saxemara-black-blue-black__0949810_pe800027_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:38:44', '2022-06-01 01:38:44'),
(261, 6, '/storage/files/10/koarp/koarp-armchair-saxemara-black-blue-black__0949812_pe800029_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:38:44', '2022-06-01 01:38:44'),
(262, 1, 'black', NULL, NULL, NULL, '2022-06-01 01:38:44', '2022-06-01 01:38:44'),
(263, 7, '13', NULL, NULL, NULL, '2022-06-01 01:38:44', '2022-06-01 01:38:44'),
(264, 3, '/storage/files/10/koarp/koarp-armchair-gunnared-medium-gray-black__0837283_pe643214_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:41:49', '2022-06-01 01:41:49'),
(265, 4, '/storage/files/10/koarp/koarp-armchair-gunnared-medium-gray-black__0837281_pe643213_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:41:49', '2022-06-01 01:41:49'),
(266, 5, '/storage/files/10/koarp/koarp-armchair-gunnared-beige-black__0681595_pe720191_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:41:49', '2022-06-01 01:41:49'),
(267, 2, '/storage/files/10/koarp/koarp-armchair-gunnared-medium-gray-black__0522305_pe643209_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:41:49', '2022-06-01 01:41:49'),
(268, 6, '/storage/files/10/koarp/koarp-armchair-gunnared-medium-gray-black__0837274_pe643210_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:41:49', '2022-06-01 01:41:49'),
(269, 1, 'rgba(0,0,0,0.62)', NULL, NULL, NULL, '2022-06-01 01:41:49', '2022-06-01 01:41:49'),
(270, 7, '13', NULL, NULL, NULL, '2022-06-01 01:41:49', '2022-06-01 01:41:49'),
(271, 3, '/storage/files/10/ekero/ekeroe-armchair-skiftebo-dark-blue__0815338_pe772866_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:46:30', '2022-06-01 01:46:30'),
(272, 4, '/storage/files/10/ekero/ekeroe-armchair-skiftebo-dark-blue__0837670_pe596451_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:46:30', '2022-06-01 01:46:30'),
(273, 5, '/storage/files/10/ekero/ekeroe-armchair-skiftebo-dark-blue__0629853_pe694518_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:46:30', '2022-06-01 01:46:30'),
(274, 2, '/storage/files/10/ekero/ekeroe-armchair-skiftebo-dark-blue__0204749_pe359788_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:46:30', '2022-06-01 01:46:30'),
(275, 6, '/storage/files/10/ekero/ekeroe-armchair-skiftebo-dark-blue__0837671_pe601048_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:46:30', '2022-06-01 01:46:30'),
(276, 1, '#113ff6', NULL, NULL, NULL, '2022-06-01 01:46:30', '2022-06-01 01:46:30'),
(277, 7, '11', NULL, NULL, NULL, '2022-06-01 01:46:30', '2022-06-01 01:46:30'),
(278, 3, '/storage/files/10/ekero/ekeroe-armchair-skiftebo-orange__0836450_pe596458_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:49:51', '2022-06-01 01:49:51'),
(279, 4, '/storage/files/10/ekero/ekeroe-armchair-skiftebo-orange__0836447_pe585553_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:49:51', '2022-06-01 01:49:51'),
(280, 5, '/storage/files/10/ekero/ekeroe-armchair-skiftebo-dark-blue__0629853_pe694518_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:49:51', '2022-06-01 01:49:51'),
(281, 2, '/storage/files/10/ekero/ekeroe-armchair-skiftebo-orange__0204751_pe359789_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:49:51', '2022-06-01 01:49:51'),
(282, 6, '/storage/files/10/ekero/ekeroe-armchair-skiftebo-orange__0836451_pe600874_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:49:51', '2022-06-01 01:49:51'),
(283, 1, '#ee0d16', NULL, NULL, NULL, '2022-06-01 01:49:51', '2022-06-01 01:49:51'),
(284, 7, '11', NULL, NULL, NULL, '2022-06-01 01:49:51', '2022-06-01 01:49:51'),
(285, 3, '/storage/files/10/ekero/ekeroe-armchair-skiftebo-yellow__0836444_pe596409_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:52:24', '2022-06-01 01:52:24'),
(286, 4, '/storage/files/10/ekero/ekeroe-armchair-skiftebo-yellow__0836443_pe585554_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:52:24', '2022-06-01 01:52:24'),
(287, 5, '/storage/files/10/ekero/ekeroe-armchair-skiftebo-dark-blue__0629853_pe694518_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:52:24', '2022-06-01 01:52:24'),
(288, 2, '/storage/files/10/ekero/ekeroe-armchair-skiftebo-yellow__0204753_pe359787_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:52:24', '2022-06-01 01:52:24'),
(289, 6, '/storage/files/10/ekero/ekeroe-armchair-skiftebo-yellow__0836445_pe600885_s5.jpg', NULL, NULL, NULL, '2022-06-01 01:52:24', '2022-06-01 01:52:24'),
(290, 1, '#f2ed0d', NULL, NULL, NULL, '2022-06-01 01:52:24', '2022-06-01 01:52:24'),
(291, 7, '11', NULL, NULL, NULL, '2022-06-01 01:52:24', '2022-06-01 01:52:24'),
(292, 3, '/storage/files/10/remsta/remsta-armchair-djuparp-dark-green-blue__0908609_pe783332_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:00:04', '2022-06-01 02:00:04'),
(293, 4, '/storage/files/10/remsta/remsta-armchair-djuparp-dark-green-blue__0908610_pe783327_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:00:04', '2022-06-01 02:00:04'),
(294, 5, '/storage/files/10/remsta/remsta-armchair-djuparp-dark-green-blue__0908520_pe783267_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:00:04', '2022-06-01 02:00:04'),
(295, 2, '/storage/files/10/remsta/remsta-armchair-djuparp-dark-green-blue__0908607_pe783330_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:00:04', '2022-06-01 02:00:04'),
(296, 6, '/storage/files/10/remsta/remsta-armchair-djuparp-dark-green-blue__0908608_pe783331_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:00:04', '2022-06-01 02:00:04'),
(297, 1, '#0224f2', NULL, NULL, NULL, '2022-06-01 02:00:04', '2022-06-01 02:00:04'),
(298, 7, '12', NULL, NULL, NULL, '2022-06-01 02:00:04', '2022-06-01 02:00:04'),
(299, 3, '/storage/files/10/remsta/remsta-armchair-hakebo-beige__0908601_pe783324_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:03:50', '2022-06-01 02:03:50'),
(300, 4, '/storage/files/10/remsta/remsta-armchair-hakebo-beige__0908602_pe783325_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:03:50', '2022-06-01 02:03:50'),
(301, 5, '/storage/files/10/remsta/remsta-armchair-djuparp-dark-green-blue__0908520_pe783267_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:03:50', '2022-06-01 02:03:50'),
(302, 2, '/storage/files/10/remsta/remsta-armchair-hakebo-beige__0908599_pe783322_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:03:50', '2022-06-01 02:03:50'),
(303, 6, '/storage/files/10/remsta/remsta-armchair-hakebo-beige__0908600_pe783323_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:03:50', '2022-06-01 02:03:50'),
(304, 1, 'black', NULL, NULL, NULL, '2022-06-01 02:03:50', '2022-06-01 02:03:50'),
(305, 7, '12', NULL, NULL, NULL, '2022-06-01 02:03:50', '2022-06-01 02:03:50'),
(306, 3, '/storage/files/10/remsta/remsta-armchair-hakebo-dark-gray__0908605_pe783328_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:06:25', '2022-06-01 02:06:25'),
(307, 4, '/storage/files/10/remsta/remsta-armchair-hakebo-dark-gray__0908606_pe783329_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:06:25', '2022-06-01 02:06:25'),
(308, 5, '/storage/files/10/remsta/remsta-armchair-djuparp-dark-green-blue__0908520_pe783267_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:06:25', '2022-06-01 02:06:25'),
(309, 2, '/storage/files/10/remsta/remsta-armchair-hakebo-dark-gray__0908603_pe783326_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:06:25', '2022-06-01 02:06:25'),
(310, 6, '/storage/files/10/remsta/remsta-armchair-hakebo-dark-gray__0908604_pe783333_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:06:25', '2022-06-01 02:06:25'),
(311, 1, 'rgba(0,0,0,0.6)', NULL, NULL, NULL, '2022-06-01 02:06:25', '2022-06-01 02:06:25'),
(312, 7, '12', NULL, NULL, NULL, '2022-06-01 02:06:25', '2022-06-01 02:06:25'),
(313, 3, '/storage/files/10/tullsta/tullsta-armchair-nordvalla-light-green__0869029_pe680496_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:11:06', '2022-06-01 02:11:06'),
(314, 4, '/storage/files/10/tullsta/tullsta-armchair-nordvalla-light-green__0869035_pe680499_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:11:06', '2022-06-01 02:11:06'),
(315, 5, '/storage/files/10/tullsta/tullsta-armchair-nordvalla-light-green__1059422_pe849630_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:11:06', '2022-06-01 02:11:06'),
(316, 2, '/storage/files/10/tullsta/tullsta-armchair-nordvalla-light-green__0602731_pe680497_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:11:06', '2022-06-01 02:11:06'),
(317, 6, '/storage/files/10/tullsta/tullsta-armchair-nordvalla-light-green__0869028_pe680495_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:11:06', '2022-06-01 02:11:06'),
(318, 1, 'rgba(24,196,179,0.93)', NULL, NULL, NULL, '2022-06-01 02:11:06', '2022-06-01 02:11:06'),
(319, 7, '13', NULL, NULL, NULL, '2022-06-01 02:11:06', '2022-06-01 02:11:06'),
(320, 3, '/storage/files/10/tullsta/tullsta-armchair-lofallet-beige__0869048_pe680493_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:14:18', '2022-06-01 02:14:18'),
(321, 4, '/storage/files/10/tullsta/tullsta-armchair-lofallet-beige__0869046_pe680492_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:14:18', '2022-06-01 02:14:18'),
(322, 5, '/storage/files/10/tullsta/tullsta-armchair-nordvalla-light-green__1059422_pe849630_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:14:18', '2022-06-01 02:14:18'),
(323, 2, '/storage/files/10/tullsta/tullsta-armchair-lofallet-beige__0602718_pe680490_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:14:18', '2022-06-01 02:14:18'),
(324, 6, '/storage/files/10/tullsta/tullsta-armchair-lofallet-beige__0869044_pe680489_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:14:18', '2022-06-01 02:14:18'),
(325, 1, 'rgba(146,124,124,0.4)', NULL, NULL, NULL, '2022-06-01 02:14:18', '2022-06-01 02:14:18'),
(326, 7, '12', NULL, NULL, NULL, '2022-06-01 02:14:18', '2022-06-01 02:14:18'),
(327, 3, '/storage/files/10/tullsta/tullsta-armchair-nordvalla-medium-gray__0837581_pe596466_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:17:05', '2022-06-01 02:17:05'),
(328, 4, '/storage/files/10/tullsta/tullsta-armchair-nordvalla-medium-gray__0837572_pe585809_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:17:05', '2022-06-01 02:17:05'),
(329, 5, '/storage/files/10/tullsta/tullsta-armchair-nordvalla-light-green__1059422_pe849630_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:17:05', '2022-06-01 02:17:05'),
(330, 2, '/storage/files/10/tullsta/tullsta-armchair-nordvalla-medium-gray__0386142_pe559174_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:17:05', '2022-06-01 02:17:05'),
(331, 6, '/storage/files/10/tullsta/tullsta-armchair-nordvalla-medium-gray__0837583_pe601029_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:17:05', '2022-06-01 02:17:05'),
(332, 1, 'rgba(0,0,0,0.61)', NULL, NULL, NULL, '2022-06-01 02:17:05', '2022-06-01 02:17:05'),
(333, 7, '12', NULL, NULL, NULL, '2022-06-01 02:17:05', '2022-06-01 02:17:05'),
(334, 3, '/storage/files/10/morabo/morabo-armchair-gunnared-light-green-wood__0837471_pe680161_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:24:22', '2022-06-01 02:24:22'),
(335, 4, '/storage/files/10/morabo/morabo-armchair-gunnared-light-green-wood__0813418_ph166262_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:24:22', '2022-06-01 02:24:22'),
(336, 5, '/storage/files/10/morabo/morabo-armchair-gunnared-light-green-wood__0815809_pe773039_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:24:22', '2022-06-01 02:24:22'),
(337, 2, '/storage/files/10/morabo/morabo-armchair-gunnared-light-green-wood__0602091_pe680160_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:24:22', '2022-06-01 02:24:22'),
(338, 6, '/storage/files/10/morabo/morabo-armchair-gunnared-light-green-wood__0812554_pe772023_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:24:22', '2022-06-01 02:24:22'),
(339, 1, 'rgba(8,169,90,0.79)', NULL, NULL, NULL, '2022-06-01 02:24:22', '2022-06-01 02:24:22'),
(340, 7, '14', NULL, NULL, NULL, '2022-06-01 02:24:22', '2022-06-01 02:24:22'),
(341, 3, '/storage/files/10/morabo/morabo-armchair-gunnared-dark-gray-wood__0825366_pe680169_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:26:10', '2022-06-01 02:26:10'),
(342, 4, '/storage/files/10/morabo/morabo-armchair-gunnared-dark-gray-wood__0840567_pe680156_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:26:10', '2022-06-01 02:26:10'),
(343, 5, '/storage/files/10/morabo/morabo-armchair-gunnared-light-green-wood__0815809_pe773039_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:26:10', '2022-06-01 02:26:10'),
(344, 2, '/storage/files/10/morabo/morabo-armchair-gunnared-dark-gray-wood__0602087_pe680155_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:26:10', '2022-06-01 02:26:10'),
(345, 6, '/storage/files/10/morabo/morabo-armchair-gunnared-dark-gray-wood__0812552_pe772029_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:26:10', '2022-06-01 02:26:10'),
(346, 1, 'rgba(0,0,0,0.55)', NULL, NULL, NULL, '2022-06-01 02:26:10', '2022-06-01 02:26:10'),
(347, 7, '14', NULL, NULL, NULL, '2022-06-01 02:26:10', '2022-06-01 02:26:10'),
(348, 3, '/storage/files/10/morabo/morabo-armchair-djuparp-dark-blue-wood__0990403_pe818922_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:29:57', '2022-06-01 02:29:57'),
(349, 4, '/storage/files/10/morabo/morabo-armchair-djuparp-dark-blue-wood__0990402_pe818921_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:29:57', '2022-06-01 02:29:57'),
(350, 5, '/storage/files/10/morabo/morabo-armchair-gunnared-light-green-wood__0815809_pe773039_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:29:57', '2022-06-01 02:29:57'),
(351, 2, '/storage/files/10/morabo/morabo-armchair-djuparp-dark-blue-wood__0990400_pe818919_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:29:57', '2022-06-01 02:29:57'),
(352, 6, '/storage/files/10/morabo/morabo-armchair-djuparp-dark-blue-wood__0990401_pe818920_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:29:57', '2022-06-01 02:29:57'),
(353, 1, 'rgba(9,27,246,0.99)', NULL, NULL, NULL, '2022-06-01 02:29:57', '2022-06-01 02:29:57'),
(354, 7, '14', NULL, NULL, NULL, '2022-06-01 02:29:57', '2022-06-01 02:29:57'),
(355, 3, '/storage/files/10/pello/pello-armchair-holmby-natural__0446408_pe596512_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:35:00', '2022-06-01 02:35:00'),
(356, 4, '/storage/files/10/pello/pello-armchair-holmby-natural__0841133_pe585630_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:35:00', '2022-06-01 02:35:00'),
(357, 5, '/storage/files/10/pello/pello-armchair-holmby-natural__0939999_pe794756_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:35:00', '2022-06-01 02:35:00'),
(358, 2, '/storage/files/10/pello/pello-armchair-holmby-natural__38296_pe130209_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:35:00', '2022-06-01 02:35:00'),
(359, 6, '/storage/files/10/pello/pello-armchair-holmby-natural__0841137_pe600889_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:35:00', '2022-06-01 02:35:00'),
(360, 1, 'rgba(246,237,237,0.93)', NULL, NULL, NULL, '2022-06-01 02:35:00', '2022-06-01 02:35:00'),
(361, 7, '11', NULL, NULL, NULL, '2022-06-01 02:35:00', '2022-06-01 02:35:00'),
(362, 3, '/storage/files/10/poang/poaeng-armchair-black-brown-knisa-black__0837331_pe666942_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:41:39', '2022-06-01 02:41:39'),
(363, 4, '/storage/files/10/poang/poaeng-armchair-black-brown-knisa-black__0837333_pe666943_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:41:39', '2022-06-01 02:41:39'),
(364, 5, '/storage/files/10/poang/poaeng-armchair-black-brown-knisa-black__0617563_pe688046_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:41:39', '2022-06-01 02:41:39'),
(365, 2, '/storage/files/10/poang/poaeng-armchair-black-brown-knisa-black__0571510_pe666941_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:41:39', '2022-06-01 02:41:39'),
(366, 6, '/storage/files/10/poang/poaeng-armchair-black-brown-knisa-black__0837335_pe666944_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:41:39', '2022-06-01 02:41:39'),
(367, 1, 'black', NULL, NULL, NULL, '2022-06-01 02:41:39', '2022-06-01 02:41:39'),
(368, 7, '13', NULL, NULL, NULL, '2022-06-01 02:41:39', '2022-06-01 02:41:39'),
(369, 3, '/storage/files/10/poang/poaeng-armchair-black-brown-hillared-dark-blue__0840369_pe628974_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:43:32', '2022-06-01 02:43:32'),
(370, 4, '/storage/files/10/poang/poaeng-armchair-black-brown-hillared-dark-blue__0840371_pe628975_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:43:32', '2022-06-01 02:43:32'),
(371, 5, '/storage/files/10/poang/poaeng-armchair-black-brown-knisa-black__0617563_pe688046_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:43:32', '2022-06-01 02:43:32'),
(372, 2, '/storage/files/10/poang/poaeng-armchair-black-brown-hillared-dark-blue__0497145_pe628972_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:43:32', '2022-06-01 02:43:32'),
(373, 6, '/storage/files/10/poang/poaeng-armchair-black-brown-hillared-dark-blue__0840372_pe629090_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:43:32', '2022-06-01 02:43:32'),
(374, 1, '#14f1db', NULL, NULL, NULL, '2022-06-01 02:43:32', '2022-06-01 02:43:32'),
(375, 7, '14', NULL, NULL, NULL, '2022-06-01 02:43:32', '2022-06-01 02:43:32'),
(376, 3, '/storage/files/10/poang/poaeng-armchair-black-brown-skiftebo-dark-gray__0937021_pe793541_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:46:01', '2022-06-01 02:46:01'),
(377, 4, '/storage/files/10/poang/poaeng-armchair-black-brown-skiftebo-dark-gray__0937020_pe793526_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:46:01', '2022-06-01 02:46:01'),
(378, 5, '/storage/files/10/poang/poaeng-armchair-black-brown-knisa-black__0617563_pe688046_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:46:01', '2022-06-01 02:46:01'),
(379, 2, '/storage/files/10/poang/poaeng-armchair-black-brown-skiftebo-dark-gray__0937018_pe793540_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:46:01', '2022-06-01 02:46:01'),
(380, 6, '/storage/files/10/poang/poaeng-armchair-black-brown-skiftebo-dark-gray__0937019_pe793527_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:46:01', '2022-06-01 02:46:01'),
(381, 1, 'rgba(0,0,0,0.35)', NULL, NULL, NULL, '2022-06-01 02:46:01', '2022-06-01 02:46:01'),
(382, 7, '14', NULL, NULL, NULL, '2022-06-01 02:46:01', '2022-06-01 02:46:01'),
(383, 3, '/storage/files/10/poang/poaeng-armchair-black-brown-knisa-light-beige__0837300_pe666946_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:48:01', '2022-06-01 02:48:01'),
(384, 4, '/storage/files/10/poang/poaeng-armchair-black-brown-knisa-light-beige__0837302_pe666947_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:48:01', '2022-06-01 02:48:01'),
(385, 5, '/storage/files/10/poang/poaeng-armchair-black-brown-knisa-black__0617563_pe688046_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:48:01', '2022-06-01 02:48:01'),
(386, 2, '/storage/files/10/poang/poaeng-armchair-black-brown-knisa-light-beige__0571514_pe666945_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:48:01', '2022-06-01 02:48:01'),
(387, 6, '/storage/files/10/poang/poaeng-armchair-black-brown-knisa-light-beige__0837314_pe666948_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:48:01', '2022-06-01 02:48:01'),
(388, 1, 'rgba(247,241,241,0.95)', NULL, NULL, NULL, '2022-06-01 02:48:01', '2022-06-01 02:48:01'),
(389, 7, '11', NULL, NULL, NULL, '2022-06-01 02:48:01', '2022-06-01 02:48:01'),
(390, 3, '/storage/files/10/poang/poaeng-armchair-black-brown-skiftebo-yellow__0936997_pe793509_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:49:24', '2022-06-01 02:49:24'),
(391, 4, '/storage/files/10/poang/poaeng-armchair-black-brown-skiftebo-yellow__0936996_pe793508_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:49:24', '2022-06-01 02:49:24'),
(392, 5, '/storage/files/10/poang/poaeng-armchair-black-brown-knisa-black__0617563_pe688046_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:49:24', '2022-06-01 02:49:24'),
(393, 2, '/storage/files/10/poang/poaeng-armchair-black-brown-skiftebo-yellow__0936994_pe793506_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:49:24', '2022-06-01 02:49:24'),
(394, 6, '/storage/files/10/poang/poaeng-armchair-black-brown-skiftebo-yellow__0936995_pe793507_s5.jpg', NULL, NULL, NULL, '2022-06-01 02:49:24', '2022-06-01 02:49:24'),
(395, 1, 'rgba(234,217,15,0.99)', NULL, NULL, NULL, '2022-06-01 02:49:24', '2022-06-01 02:49:24'),
(396, 7, '11', NULL, NULL, NULL, '2022-06-01 02:49:24', '2022-06-01 02:49:24'),
(397, 3, '/storage/files/10/vedbo/vedbo-armchair-gunnared-dark-gray__0837084_pe638857_s5.jpg', NULL, NULL, NULL, '2022-06-01 03:03:30', '2022-06-01 03:03:30'),
(398, 4, '/storage/files/10/vedbo/vedbo-armchair-gunnared-dark-gray__0707625_ph147021_s5.jpg', NULL, NULL, NULL, '2022-06-01 03:03:30', '2022-06-01 03:03:30'),
(399, 5, '/storage/files/10/vedbo/vedbo-armchair-gunnared-dark-gray__0632856_pe695638_s5.jpg', NULL, NULL, NULL, '2022-06-01 03:03:30', '2022-06-01 03:03:30'),
(400, 2, '/storage/files/10/vedbo/vedbo-armchair-gunnared-dark-gray__0512767_pe638683_s5.jpg', NULL, NULL, NULL, '2022-06-01 03:03:30', '2022-06-01 03:03:30'),
(401, 6, '/storage/files/10/vedbo/vedbo-armchair-gunnared-dark-gray__0708567_ph153038_s5.jpg', NULL, NULL, NULL, '2022-06-01 03:03:30', '2022-06-01 03:03:30'),
(402, 1, 'rgba(11,2,2,0.98)', NULL, NULL, NULL, '2022-06-01 03:03:30', '2022-06-01 03:03:30'),
(403, 7, '13', NULL, NULL, NULL, '2022-06-01 03:03:30', '2022-06-01 03:03:30'),
(404, 3, '/storage/files/10/vedbo/vedbo-armchair-gunnared-blue__0837381_pe696812_s5.jpg', NULL, NULL, NULL, '2022-06-01 03:07:49', '2022-06-01 03:07:49'),
(405, 4, '/storage/files/10/vedbo/vedbo-armchair-gunnared-blue__0837372_pe649529_s5.jpg', NULL, NULL, NULL, '2022-06-01 03:07:49', '2022-06-01 03:07:49'),
(406, 5, '/storage/files/10/vedbo/vedbo-armchair-gunnared-dark-gray__0632856_pe695638_s5.jpg', NULL, NULL, NULL, '2022-06-01 03:07:49', '2022-06-01 03:07:49'),
(407, 2, '/storage/files/10/vedbo/vedbo-armchair-gunnared-blue__0634896_pe696809_s5.jpg', NULL, NULL, NULL, '2022-06-01 03:07:49', '2022-06-01 03:07:49'),
(408, 6, '/storage/files/10/vedbo/vedbo-armchair-gunnared-blue__0837379_pe696808_s5.jpg', NULL, NULL, NULL, '2022-06-01 03:07:49', '2022-06-01 03:07:49'),
(409, 1, 'rgba(27,105,218,0.96)', NULL, NULL, NULL, '2022-06-01 03:07:49', '2022-06-01 03:07:49'),
(410, 7, '11', NULL, NULL, NULL, '2022-06-01 03:07:49', '2022-06-01 03:07:49'),
(411, 3, '/storage/files/10/vedbo/vedbo-armchair-gunnared-light-brown-pink__0837394_pe649534_s5.jpg', NULL, NULL, NULL, '2022-06-01 03:12:05', '2022-06-01 03:12:05'),
(412, 4, '/storage/files/10/vedbo/vedbo-armchair-gunnared-light-brown-pink__0837414_pe696818_s5.jpg', NULL, NULL, NULL, '2022-06-01 03:12:05', '2022-06-01 03:12:05'),
(413, 5, '/storage/files/10/vedbo/vedbo-armchair-gunnared-dark-gray__0632856_pe695638_s5.jpg', NULL, NULL, NULL, '2022-06-01 03:12:05', '2022-06-01 03:12:05'),
(414, 2, '/storage/files/10/vedbo/vedbo-armchair-gunnared-light-brown-pink__0634903_pe696815_s5.jpg', NULL, NULL, NULL, '2022-06-01 03:12:05', '2022-06-01 03:12:05'),
(415, 6, '/storage/files/10/vedbo/vedbo-armchair-gunnared-light-brown-pink__0837412_pe696814_s5.jpg', NULL, NULL, NULL, '2022-06-01 03:12:05', '2022-06-01 03:12:05'),
(416, 1, 'rgba(216,14,192,0.98)', NULL, NULL, NULL, '2022-06-01 03:12:05', '2022-06-01 03:12:05'),
(417, 7, '14', NULL, NULL, NULL, '2022-06-01 03:12:05', '2022-06-01 03:12:05'),
(418, 3, '/storage/files/10/kloven/kloeven-armchair-outdoor-brown-stained-froesoen-duvholmen-beige__0905808_pe617105_s5.jpg', NULL, NULL, NULL, '2022-06-01 08:12:49', '2022-06-01 08:12:49'),
(419, 4, '/storage/files/10/kloven/kloeven-armchair-outdoor-brown-stained-froesoen-duvholmen-beige__0947361_pe798515_s5.jpg', NULL, NULL, NULL, '2022-06-01 08:12:49', '2022-06-01 08:12:49'),
(420, 5, '/storage/files/10/kloven/kloeven-armchair-outdoor-brown-stained-froesoen-duvholmen-beige__0947362_pe798518_s5.jpg', NULL, NULL, NULL, '2022-06-01 08:12:49', '2022-06-01 08:12:49'),
(421, 2, '/storage/files/10/kloven/kloeven-armchair-outdoor-brown-stained-froesoen-duvholmen-beige__0729349_pe736951_s5.jpg', NULL, NULL, NULL, '2022-06-01 08:12:49', '2022-06-01 08:12:49'),
(422, 6, '/storage/files/10/kloven/kloeven-armchair-outdoor-brown-stained-froesoen-duvholmen-beige__0947357_pe798511_s5.jpg', NULL, NULL, NULL, '2022-06-01 08:12:49', '2022-06-01 08:12:49'),
(423, 1, 'black', NULL, NULL, NULL, '2022-06-01 08:12:49', '2022-06-01 08:12:49'),
(424, 7, '14', NULL, NULL, NULL, '2022-06-01 08:12:49', '2022-06-01 08:12:49'),
(425, 3, '/storage/files/10/applaryd/aepplaryd-loveseat-lejde-light-gray__1032003_pe836727_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:27:22', '2022-06-02 00:27:22'),
(426, 4, '/storage/files/10/applaryd/aepplaryd-loveseat-lejde-light-gray__1031506_pe836510_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:27:22', '2022-06-02 00:27:22'),
(427, 5, '/storage/files/10/applaryd/aepplaryd-loveseat-lejde-light-gray__1039251_pe840105_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:27:22', '2022-06-02 00:27:22'),
(428, 2, '/storage/files/10/applaryd/aepplaryd-loveseat-lejde-light-gray__0992863_pe820294_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:27:22', '2022-06-02 00:27:22'),
(429, 6, '/storage/files/10/applaryd/aepplaryd-loveseat-lejde-light-gray__1023706_pe833222_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:27:22', '2022-06-02 00:27:22'),
(430, 1, 'rgba(244,230,230,0.92)', NULL, NULL, NULL, '2022-06-02 00:27:22', '2022-06-02 00:27:22'),
(431, 7, '14', NULL, NULL, NULL, '2022-06-02 00:27:22', '2022-06-02 00:27:22'),
(432, 3, '/storage/files/10/applaryd/aepplaryd-loveseat-djuparp-dark-blue__1031503_pe836503_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:29:19', '2022-06-02 00:29:19'),
(433, 4, '/storage/files/10/applaryd/aepplaryd-loveseat-djuparp-dark-blue__1032002_pe836728_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:29:19', '2022-06-02 00:29:19'),
(434, 5, '/storage/files/10/applaryd/aepplaryd-loveseat-lejde-light-gray__1039251_pe840105_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:29:19', '2022-06-02 00:29:19'),
(435, 2, '/storage/files/10/applaryd/aepplaryd-loveseat-djuparp-dark-blue__0992860_pe820287_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:29:19', '2022-06-02 00:29:19'),
(436, 6, '/storage/files/10/applaryd/aepplaryd-loveseat-djuparp-dark-blue__1023703_pe833221_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:29:19', '2022-06-02 00:29:19'),
(437, 1, '#0a14dd', NULL, NULL, NULL, '2022-06-02 00:29:19', '2022-06-02 00:29:19'),
(438, 7, '14', NULL, NULL, NULL, '2022-06-02 00:29:19', '2022-06-02 00:29:19'),
(439, 3, '/storage/files/10/applaryd/aepplaryd-loveseat-djuparp-red-brown__1023708_pe833228_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:30:29', '2022-06-02 00:30:29'),
(440, 4, '/storage/files/10/applaryd/aepplaryd-loveseat-djuparp-red-brown__1031504_pe836504_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:30:29', '2022-06-02 00:30:29'),
(441, 5, '/storage/files/10/applaryd/aepplaryd-loveseat-lejde-light-gray__1039251_pe840105_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:30:29', '2022-06-02 00:30:29'),
(442, 2, '/storage/files/10/applaryd/aepplaryd-loveseat-djuparp-red-brown__0992861_pe820288_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:30:29', '2022-06-02 00:30:29'),
(443, 6, '/storage/files/10/applaryd/aepplaryd-loveseat-djuparp-red-brown__1023704_pe833224_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:30:29', '2022-06-02 00:30:29'),
(444, 1, '#e30c0c', NULL, NULL, NULL, '2022-06-02 00:30:29', '2022-06-02 00:30:29'),
(445, 7, '14', NULL, NULL, NULL, '2022-06-02 00:30:29', '2022-06-02 00:30:29'),
(446, 3, '/storage/files/10/kivik/kivik-sofa-tibbleby-beige-gray__1056136_pe848268_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:41:17', '2022-06-02 00:41:17'),
(447, 4, '/storage/files/10/kivik/kivik-sofa-tibbleby-beige-gray__1056140_pe848272_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:41:17', '2022-06-02 00:41:17'),
(448, 5, '/storage/files/10/kivik/kivik-sofa-tibbleby-beige-gray__0829362_pe776725_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:41:17', '2022-06-02 00:41:17'),
(449, 2, '/storage/files/10/kivik/kivik-sofa-tibbleby-beige-gray__1056144_pe848277_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:41:17', '2022-06-02 00:41:17'),
(450, 6, '/storage/files/10/kivik/kivik-sofa-tibbleby-beige-gray__1056143_pe848278_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:41:17', '2022-06-02 00:41:17'),
(451, 1, 'rgba(244,230,230,0.85)', NULL, NULL, NULL, '2022-06-02 00:41:17', '2022-06-02 00:41:17'),
(452, 7, '12', NULL, NULL, NULL, '2022-06-02 00:41:17', '2022-06-02 00:41:17'),
(453, 3, '/storage/files/10/kivik/kivik-sofa-kelinge-gray-turquoise__1055792_pe848103_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:43:57', '2022-06-02 00:43:57'),
(454, 4, '/storage/files/10/kivik/kivik-sofa-kelinge-gray-turquoise__1055795_pe848106_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:43:57', '2022-06-02 00:43:57'),
(455, 5, '/storage/files/10/kivik/kivik-sofa-tibbleby-beige-gray__0829362_pe776725_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:43:57', '2022-06-02 00:43:57'),
(456, 2, '/storage/files/10/kivik/kivik-sofa-kelinge-gray-turquoise__1055806_pe848110_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:43:57', '2022-06-02 00:43:57'),
(457, 6, '/storage/files/10/kivik/kivik-sofa-kelinge-gray-turquoise__1055805_pe848111_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:43:57', '2022-06-02 00:43:57'),
(458, 1, '#06fcbf', NULL, NULL, NULL, '2022-06-02 00:43:57', '2022-06-02 00:43:57'),
(459, 7, '12', NULL, NULL, NULL, '2022-06-02 00:43:57', '2022-06-02 00:43:57'),
(460, 3, '/storage/files/10/kivik/kivik-sofa-hillared-anthracite__0981342_ph167462_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:45:29', '2022-06-02 00:45:29'),
(461, 4, '/storage/files/10/kivik/kivik-sofa-hillared-anthracite__0777005_pe758394_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:45:29', '2022-06-02 00:45:29'),
(462, 5, '/storage/files/10/kivik/kivik-sofa-tibbleby-beige-gray__0829362_pe776725_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:45:29', '2022-06-02 00:45:29'),
(463, 2, '/storage/files/10/kivik/kivik-sofa-hillared-anthracite__0479959_pe619105_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:45:29', '2022-06-02 00:45:29'),
(464, 6, '/storage/files/10/kivik/kivik-sofa-hillared-anthracite__0788746_pe763718_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:45:29', '2022-06-02 00:45:29'),
(465, 1, 'black', NULL, NULL, NULL, '2022-06-02 00:45:29', '2022-06-02 00:45:29'),
(466, 7, 'NULL', NULL, NULL, NULL, '2022-06-02 00:45:29', '2022-06-02 00:45:29'),
(467, 3, '/storage/files/10/lidhult/lidhult-sectional-4-seat-with-chaise-gassebol-light-beige__0825551_pe705917_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:55:51', '2022-06-02 00:55:51'),
(468, 4, '/storage/files/10/lidhult/lidhult-sectional-4-seat-with-chaise-gassebol-light-beige__0825554_pe706076_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:55:51', '2022-06-02 00:55:51'),
(469, 5, '/storage/files/10/lidhult/lidhult-sectional-4-seat-with-chaise-gassebol-light-beige__0681724_pe720246_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:55:51', '2022-06-02 00:55:51');
INSERT INTO `product_specifications` (`ID`, `specification_type`, `value`, `unit`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES
(470, 2, '/storage/files/10/lidhult/lidhult-sectional-4-seat-with-chaise-gassebol-light-beige__0620231_pe689543_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:55:51', '2022-06-02 00:55:51'),
(471, 6, '/storage/files/10/lidhult/lidhult-sectional-4-seat-with-chaise-gassebol-light-beige__0825549_pe689542_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:55:51', '2022-06-02 00:55:51'),
(472, 1, 'rgba(244,214,214,0.76)', NULL, NULL, NULL, '2022-06-02 00:55:51', '2022-06-02 00:55:51'),
(473, 7, '13', NULL, NULL, NULL, '2022-06-02 00:55:51', '2022-06-02 00:55:51'),
(474, 3, '/storage/files/10/lidhult/lidhult-sectional-4-seat-with-chaise-lejde-gray-black__0825568_pe705908_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:57:17', '2022-06-02 00:57:17'),
(475, 4, '/storage/files/10/lidhult/lidhult-sectional-4-seat-with-chaise-lejde-gray-black__0825565_pe689450_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:57:17', '2022-06-02 00:57:17'),
(476, 5, '/storage/files/10/lidhult/lidhult-sectional-4-seat-with-chaise-gassebol-light-beige__0681724_pe720246_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:57:17', '2022-06-02 00:57:17'),
(477, 2, '/storage/files/10/lidhult/lidhult-sectional-4-seat-with-chaise-lejde-gray-black__0620235_pe689546_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:57:17', '2022-06-02 00:57:17'),
(478, 6, '/storage/files/10/lidhult/lidhult-sectional-4-seat-with-chaise-lejde-gray-black__0825570_pe710336_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:57:17', '2022-06-02 00:57:17'),
(479, 1, 'rgba(15,14,14,0.81)', NULL, NULL, NULL, '2022-06-02 00:57:17', '2022-06-02 00:57:17'),
(480, 7, '13', NULL, NULL, NULL, '2022-06-02 00:57:17', '2022-06-02 00:57:17'),
(481, 3, '/storage/files/10/lidhult/lidhult-sectional-4-seat-with-chaise-lejde-red-brown__0852942_pe705943_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:58:39', '2022-06-02 00:58:39'),
(482, 4, '/storage/files/10/lidhult/lidhult-sectional-4-seat-with-chaise-lejde-red-brown__0852946_pe706089_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:58:39', '2022-06-02 00:58:39'),
(483, 5, '/storage/files/10/lidhult/lidhult-sectional-4-seat-with-chaise-gassebol-light-beige__0681724_pe720246_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:58:39', '2022-06-02 00:58:39'),
(484, 2, '/storage/files/10/lidhult/lidhult-sectional-4-seat-with-chaise-lejde-red-brown__0667754_pe714048_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:58:39', '2022-06-02 00:58:39'),
(485, 6, '/storage/files/10/lidhult/lidhult-sectional-4-seat-with-chaise-lejde-red-brown__0826690_pe714049_s5.jpg', NULL, NULL, NULL, '2022-06-02 00:58:39', '2022-06-02 00:58:39'),
(486, 1, 'rgba(225,15,23,0.9)', NULL, NULL, NULL, '2022-06-02 00:58:39', '2022-06-02 00:58:39'),
(487, 7, '13', NULL, NULL, NULL, '2022-06-02 00:58:39', '2022-06-02 00:58:39'),
(488, 3, '/storage/files/10/Vallentuna/vallentuna-modular-corner-sofa-3-seat-with-storage-murum-white__0826295_pe691590_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:04:41', '2022-06-02 01:04:41'),
(489, 4, '/storage/files/10/Vallentuna/vallentuna-modular-corner-sofa-3-seat-with-storage-murum-white__0826297_pe691600_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:04:41', '2022-06-02 01:04:41'),
(490, 5, '/storage/files/10/Vallentuna/vallentuna-modular-corner-sofa-3-seat-with-storage-murum-white__0673845_pe717439_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:04:41', '2022-06-02 01:04:41'),
(491, 2, '/storage/files/10/Vallentuna/vallentuna-modular-corner-sofa-3-seat-with-storage-murum-white__0624041_pe691588_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:04:41', '2022-06-02 01:04:41'),
(492, 6, '/storage/files/10/Vallentuna/vallentuna-modular-corner-sofa-3-seat-with-storage-murum-white__0826293_pe691589_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:04:41', '2022-06-02 01:04:41'),
(493, 1, 'rgba(0,0,0,0)', NULL, NULL, NULL, '2022-06-02 01:04:41', '2022-06-02 01:04:41'),
(494, 7, '11', NULL, NULL, NULL, '2022-06-02 01:04:41', '2022-06-02 01:04:41'),
(495, 3, '/storage/files/10/friheten/friheten-sleeper-sofa-hyllie-beige__0690273_pe723196_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:12:47', '2022-06-02 01:12:47'),
(496, 4, '/storage/files/10/friheten/friheten-sleeper-sofa-hyllie-beige__0690271_pe723197_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:12:47', '2022-06-02 01:12:47'),
(497, 5, '/storage/files/10/friheten/friheten-sleeper-sofa-skiftebo-dark-gray__0733168_pe738879_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:12:47', '2022-06-02 01:12:47'),
(498, 2, '/storage/files/10/friheten/friheten-sleeper-sofa-hyllie-beige__0690274_pe723194_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:12:47', '2022-06-02 01:12:47'),
(499, 6, '/storage/files/10/friheten/friheten-sleeper-sofa-hyllie-beige__0690272_pe723195_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:12:47', '2022-06-02 01:12:47'),
(500, 1, 'rgba(246,206,206,0.67)', NULL, NULL, NULL, '2022-06-02 01:12:47', '2022-06-02 01:12:47'),
(501, 7, '13', NULL, NULL, NULL, '2022-06-02 01:12:47', '2022-06-02 01:12:47'),
(502, 3, '/storage/files/10/friheten/friheten-sleeper-sofa-bomstad-black__0325719_pe523062_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:14:26', '2022-06-02 01:14:26'),
(503, 4, '/storage/files/10/friheten/friheten-sleeper-sofa-bomstad-black__0371869_pe551236_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:14:26', '2022-06-02 01:14:26'),
(504, 5, '/storage/files/10/friheten/friheten-sleeper-sofa-skiftebo-dark-gray__0733168_pe738879_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:14:26', '2022-06-02 01:14:26'),
(505, 2, '/storage/files/10/friheten/friheten-sleeper-sofa-bomstad-black__0525511_pe644872_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:14:26', '2022-06-02 01:14:26'),
(506, 6, '/storage/files/10/friheten/friheten-sleeper-sofa-bomstad-black__0620065_pe689376_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:14:26', '2022-06-02 01:14:26'),
(507, 1, 'black', NULL, NULL, NULL, '2022-06-02 01:14:26', '2022-06-02 01:14:26'),
(508, 7, '13', NULL, NULL, NULL, '2022-06-02 01:14:26', '2022-06-02 01:14:26'),
(509, 3, '/storage/files/10/friheten/friheten-sleeper-sofa-skiftebo-dark-gray__0325780_pe523203_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:16:19', '2022-06-02 01:16:19'),
(510, 4, '/storage/files/10/friheten/friheten-sleeper-sofa-skiftebo-dark-gray__0829146_pe644659_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:16:19', '2022-06-02 01:16:19'),
(511, 5, '/storage/files/10/friheten/friheten-sleeper-sofa-skiftebo-dark-gray__0733168_pe738879_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:16:19', '2022-06-02 01:16:19'),
(512, 2, '/storage/files/10/friheten/friheten-sleeper-sofa-skiftebo-dark-gray__0525504_pe644868_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:16:19', '2022-06-02 01:16:19'),
(513, 6, '/storage/files/10/friheten/friheten-sleeper-sofa-skiftebo-dark-gray__0829149_pe644867_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:16:19', '2022-06-02 01:16:19'),
(514, 1, 'black', NULL, NULL, NULL, '2022-06-02 01:16:19', '2022-06-02 01:16:19'),
(515, 7, '13', NULL, NULL, NULL, '2022-06-02 01:16:19', '2022-06-02 01:16:19'),
(516, 3, '/storage/files/10/friheten/friheten-sleeper-sofa-skiftebo-blue__0690279_pe723202_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:18:17', '2022-06-02 01:18:17'),
(517, 4, '/storage/files/10/friheten/friheten-sleeper-sofa-skiftebo-blue__0690276_pe723199_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:18:17', '2022-06-02 01:18:17'),
(518, 5, '/storage/files/10/friheten/friheten-sleeper-sofa-skiftebo-dark-gray__0733168_pe738879_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:18:17', '2022-06-02 01:18:17'),
(519, 2, '/storage/files/10/friheten/friheten-sleeper-sofa-skiftebo-blue__0690280_pe723200_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:18:17', '2022-06-02 01:18:17'),
(520, 6, '/storage/files/10/friheten/friheten-sleeper-sofa-skiftebo-blue__0690278_pe723201_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:18:17', '2022-06-02 01:18:17'),
(521, 1, '#0814fb', NULL, NULL, NULL, '2022-06-02 01:18:17', '2022-06-02 01:18:17'),
(522, 7, '13', NULL, NULL, NULL, '2022-06-02 01:18:17', '2022-06-02 01:18:17'),
(523, 3, '/storage/files/10/holmsund/holmsund-sleeper-sofa-orrsta-light-blue__0727986_pe735990_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:26:00', '2022-06-02 01:26:00'),
(524, 4, '/storage/files/10/holmsund/holmsund-sleeper-sofa-orrsta-light-blue__0828703_pe647443_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:26:00', '2022-06-02 01:26:00'),
(525, 5, '/storage/files/10/holmsund/holmsund-sleeper-sofa-nordvalla-medium-gray__0733179_pe738885_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:26:00', '2022-06-02 01:26:00'),
(526, 2, '/storage/files/10/holmsund/holmsund-sleeper-sofa-orrsta-light-blue__0531611_pe647438_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:26:00', '2022-06-02 01:26:00'),
(527, 6, '/storage/files/10/holmsund/holmsund-sleeper-sofa-orrsta-light-blue__0828705_pe647445_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:26:00', '2022-06-02 01:26:00'),
(528, 1, 'rgba(27,212,228,0.89)', NULL, NULL, NULL, '2022-06-02 01:26:00', '2022-06-02 01:26:00'),
(529, 7, '14', NULL, NULL, NULL, '2022-06-02 01:26:00', '2022-06-02 01:26:00'),
(530, 3, '/storage/files/10/holmsund/holmsund-sleeper-sofa-orrsta-light-white-gray__0830012_pe647662_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:27:46', '2022-06-02 01:27:46'),
(531, 4, '/storage/files/10/holmsund/holmsund-sleeper-sofa-orrsta-light-white-gray__0727987_pe735991_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:27:46', '2022-06-02 01:27:46'),
(532, 5, '/storage/files/10/holmsund/holmsund-sleeper-sofa-nordvalla-medium-gray__0733179_pe738885_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:27:46', '2022-06-02 01:27:46'),
(533, 2, '/storage/files/10/holmsund/holmsund-sleeper-sofa-orrsta-light-white-gray__0531936_pe647656_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:27:46', '2022-06-02 01:27:46'),
(534, 6, '/storage/files/10/holmsund/holmsund-sleeper-sofa-orrsta-light-white-gray__0830014_pe647663_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:27:46', '2022-06-02 01:27:46'),
(535, 1, 'rgba(0,0,0,0)', NULL, NULL, NULL, '2022-06-02 01:27:46', '2022-06-02 01:27:46'),
(536, 7, '14', NULL, NULL, NULL, '2022-06-02 01:27:46', '2022-06-02 01:27:46'),
(537, 3, '/storage/files/10/holmsund/holmsund-sleeper-sofa-nordvalla-medium-gray__0834609_pe600206_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:29:33', '2022-06-02 01:29:33'),
(538, 4, '/storage/files/10/holmsund/holmsund-sleeper-sofa-nordvalla-medium-gray__0834614_pe602836_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:29:33', '2022-06-02 01:29:33'),
(539, 5, '/storage/files/10/holmsund/holmsund-sleeper-sofa-nordvalla-medium-gray__0733179_pe738885_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:29:33', '2022-06-02 01:29:33'),
(540, 2, '/storage/files/10/holmsund/holmsund-sleeper-sofa-nordvalla-medium-gray__0405557_pe577547_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:29:33', '2022-06-02 01:29:33'),
(541, 6, '/storage/files/10/holmsund/holmsund-sleeper-sofa-nordvalla-medium-gray__0834611_pe600340_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:29:33', '2022-06-02 01:29:33'),
(542, 1, 'black', NULL, NULL, NULL, '2022-06-02 01:29:33', '2022-06-02 01:29:33'),
(543, 7, '14', NULL, NULL, NULL, '2022-06-02 01:29:33', '2022-06-02 01:29:33'),
(544, 3, '/storage/files/10/Soderhamn/soederhamn-sectional-5-seat-samsta-dark-gray__0963370_ph171630_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:43:56', '2022-06-02 01:43:56'),
(545, 4, '/storage/files/10/Soderhamn/soederhamn-sectional-5-seat-samsta-dark-gray__0666155_pe713432_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:43:56', '2022-06-02 01:43:56'),
(546, 5, '/storage/files/10/Soderhamn/soederhamn-sectional-5-seat-samsta-dark-gray__0683128_pe720666_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:43:56', '2022-06-02 01:43:56'),
(547, 2, '/storage/files/10/Soderhamn/soederhamn-sectional-5-seat-samsta-dark-gray__0153975_pe312375_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:43:56', '2022-06-02 01:43:56'),
(548, 6, '/storage/files/10/Soderhamn/soederhamn-sectional-5-seat-samsta-dark-gray__0666479_pe713569_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:43:56', '2022-06-02 01:43:56'),
(549, 1, 'black', NULL, NULL, NULL, '2022-06-02 01:43:56', '2022-06-02 01:43:56'),
(550, 7, '14', NULL, NULL, NULL, '2022-06-02 01:43:56', '2022-06-02 01:43:56'),
(551, 3, '/storage/files/10/Soderhamn/soederhamn-sectional-5-seat-samsta-orange__0802706_pe768553_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:45:37', '2022-06-02 01:45:37'),
(552, 4, '/storage/files/10/Soderhamn/soederhamn-sectional-5-seat-samsta-orange__0814670_ph166248_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:45:37', '2022-06-02 01:45:37'),
(553, 5, '/storage/files/10/Soderhamn/soederhamn-sectional-5-seat-samsta-dark-gray__0683128_pe720666_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:45:37', '2022-06-02 01:45:37'),
(554, 2, '/storage/files/10/Soderhamn/soederhamn-sectional-5-seat-samsta-orange__0802768_pe768587_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:45:37', '2022-06-02 01:45:37'),
(555, 6, '/storage/files/10/Soderhamn/soederhamn-sectional-5-seat-samsta-orange__0802767_pe768583_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:45:37', '2022-06-02 01:45:37'),
(556, 1, 'rgba(242,113,11,0.96)', NULL, NULL, NULL, '2022-06-02 01:45:37', '2022-06-02 01:45:37'),
(557, 7, '14', NULL, NULL, NULL, '2022-06-02 01:45:37', '2022-06-02 01:45:37'),
(558, 3, '/storage/files/10/Soderhamn/soederhamn-sectional-5-seat-finnsta-white__0814745_ph165318_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:47:18', '2022-06-02 01:47:18'),
(559, 4, '/storage/files/10/Soderhamn/soederhamn-sectional-5-seat-finnsta-white__0821068_pe713427_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:47:18', '2022-06-02 01:47:18'),
(560, 5, '/storage/files/10/Soderhamn/soederhamn-sectional-5-seat-samsta-dark-gray__0683128_pe720666_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:47:18', '2022-06-02 01:47:18'),
(561, 2, '/storage/files/10/Soderhamn/soederhamn-sectional-5-seat-finnsta-white__0474758_pe615194_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:47:18', '2022-06-02 01:47:18'),
(562, 6, '/storage/files/10/Soderhamn/soederhamn-sectional-5-seat-finnsta-white__0821070_pe713571_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:47:18', '2022-06-02 01:47:18'),
(563, 1, 'rgba(0,0,0,0)', NULL, NULL, NULL, '2022-06-02 01:47:18', '2022-06-02 01:47:18'),
(564, 7, '14', NULL, NULL, NULL, '2022-06-02 01:47:18', '2022-06-02 01:47:18'),
(565, 3, '/storage/files/10/Soderhamn/soederhamn-sectional-5-seat-viarp-beige-brown__0814673_ph166247_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:48:47', '2022-06-02 01:48:47'),
(566, 4, '/storage/files/10/Soderhamn/soederhamn-sectional-5-seat-viarp-beige-brown__0803570_pe768913_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:48:47', '2022-06-02 01:48:47'),
(567, 5, '/storage/files/10/Soderhamn/soederhamn-sectional-5-seat-samsta-dark-gray__0683128_pe720666_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:48:47', '2022-06-02 01:48:47'),
(568, 2, '/storage/files/10/Soderhamn/soederhamn-sectional-5-seat-viarp-beige-brown__0802771_pe768584_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:48:47', '2022-06-02 01:48:47'),
(569, 6, '/storage/files/10/Soderhamn/soederhamn-sectional-5-seat-viarp-beige-brown__0802770_pe768586_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:48:47', '2022-06-02 01:48:47'),
(570, 1, 'rgba(0,0,0,0.39)', NULL, NULL, NULL, '2022-06-02 01:48:47', '2022-06-02 01:48:47'),
(571, 7, '14', NULL, NULL, NULL, '2022-06-02 01:48:47', '2022-06-02 01:48:47'),
(572, 3, '/storage/files/10/Soderhamn/soederhamn-sectional-5-seat-finnsta-turquoise__0823612_pe713426_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:50:59', '2022-06-02 01:50:59'),
(573, 4, '/storage/files/10/Soderhamn/soederhamn-sectional-5-seat-finnsta-turquoise__0648020_ph150668_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:51:00', '2022-06-02 01:51:00'),
(574, 5, '/storage/files/10/Soderhamn/soederhamn-sectional-5-seat-samsta-dark-gray__0683128_pe720666_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:51:00', '2022-06-02 01:51:00'),
(575, 2, '/storage/files/10/Soderhamn/soederhamn-sectional-5-seat-finnsta-turquoise__0474757_pe615193_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:51:00', '2022-06-02 01:51:00'),
(576, 6, '/storage/files/10/Soderhamn/soederhamn-sectional-5-seat-finnsta-turquoise__0827384_pe713570_s5.jpg', NULL, NULL, NULL, '2022-06-02 01:51:00', '2022-06-02 01:51:00'),
(577, 1, 'rgba(7,112,149,0.58)', NULL, NULL, NULL, '2022-06-02 01:51:00', '2022-06-02 01:51:00'),
(578, 7, 'NULL', NULL, NULL, NULL, '2022-06-02 01:51:00', '2022-06-02 01:51:00'),
(579, 3, '/storage/files/10/besta/besta-tv-unit-with-doors-white-selsviken-high-gloss-white__0995912_pe821938_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:04:18', '2022-06-02 02:04:18'),
(580, 4, '/storage/files/10/besta/besta-tv-unit-with-doors-white-selsviken-high-gloss-white__0720087_pe732402_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:04:18', '2022-06-02 02:04:18'),
(581, 5, '/storage/files/10/besta/besta-tv-unit-with-doors-white-selsviken-high-gloss-white__1026887_pe834619_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:04:18', '2022-06-02 02:04:18'),
(582, 2, '/storage/files/10/besta/besta-tv-unit-with-doors-white-selsviken-high-gloss-white__0719187_pe731907_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:04:18', '2022-06-02 02:04:18'),
(583, 6, '/storage/files/10/besta/besta-tv-unit-with-doors-white-selsviken-high-gloss-white__0723575_pe734046_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:04:18', '2022-06-02 02:04:18'),
(584, 1, 'rgba(0,0,0,0)', NULL, NULL, NULL, '2022-06-02 02:04:18', '2022-06-02 02:04:18'),
(585, 7, '12', NULL, NULL, NULL, '2022-06-02 02:04:18', '2022-06-02 02:04:18'),
(586, 3, '/storage/files/10/besta/besta-tv-bench-with-doors-black-brown-bjoerkoeviken-brown-stained-oak-veneer__0720089_pe732401_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:06:29', '2022-06-02 02:06:29'),
(587, 4, '/storage/files/10/besta/besta-tv-unit-with-doors-black-brown-hanviken-black-brown__0843024_pe535609_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:06:29', '2022-06-02 02:06:29'),
(588, 5, '/storage/files/10/besta/besta-tv-unit-with-doors-white-selsviken-high-gloss-white__1026887_pe834619_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:06:29', '2022-06-02 02:06:29'),
(589, 2, '/storage/files/10/besta/besta-tv-unit-with-doors-black-brown-hanviken-black-brown__0719190_pe731909_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:06:29', '2022-06-02 02:06:29'),
(590, 6, '/storage/files/10/besta/besta-tv-unit-with-doors-black-brown-hanviken-black-brown__0995886_pe821948_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:06:29', '2022-06-02 02:06:29'),
(591, 1, '#000000', NULL, NULL, NULL, '2022-06-02 02:06:29', '2022-06-02 02:06:29'),
(592, 7, 'NULL', NULL, NULL, NULL, '2022-06-02 02:06:29', '2022-06-02 02:06:29'),
(593, 3, '/storage/files/10/besta/besta-tv-bench-with-doors-black-brown-bjoerkoeviken-brown-stained-oak-veneer__0995920_pe821904_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:08:19', '2022-06-02 02:08:19'),
(594, 4, '/storage/files/10/besta/besta-tv-bench-with-doors-black-brown-bjoerkoeviken-brown-stained-oak-veneer__0720089_pe732401_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:08:19', '2022-06-02 02:08:19'),
(595, 5, '/storage/files/10/besta/besta-tv-unit-with-doors-white-selsviken-high-gloss-white__1026887_pe834619_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:08:19', '2022-06-02 02:08:19'),
(596, 2, '/storage/files/10/besta/besta-tv-bench-with-doors-black-brown-bjoerkoeviken-brown-stained-oak-veneer__0993133_pe820433_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:08:19', '2022-06-02 02:08:19'),
(597, 6, '/storage/files/10/besta/besta-tv-unit-with-doors-black-brown-hanviken-black-brown__0723581_pe734035_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:08:19', '2022-06-02 02:08:19'),
(598, 1, '#3f2503', NULL, NULL, NULL, '2022-06-02 02:08:19', '2022-06-02 02:08:19'),
(599, 7, '12', NULL, NULL, NULL, '2022-06-02 02:08:19', '2022-06-02 02:08:19'),
(600, 3, '/storage/files/10/brimnes/brimnes-tv-unit-black__0660699_ph153211_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:17:33', '2022-06-02 02:17:33'),
(601, 4, '/storage/files/10/brimnes/brimnes-tv-unit-black__0849973_pe725295_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:17:33', '2022-06-02 02:17:33'),
(602, 5, '/storage/files/10/brimnes/brimnes-tv-unit-black__0619470_pe689104_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:17:33', '2022-06-02 02:17:33'),
(603, 2, '/storage/files/10/brimnes/brimnes-tv-unit-black__0704610_pe725291_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:17:33', '2022-06-02 02:17:33'),
(604, 6, '/storage/files/10/brimnes/brimnes-tv-unit-black__0851278_pe725293_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:17:33', '2022-06-02 02:17:33'),
(605, 1, 'black', NULL, NULL, NULL, '2022-06-02 02:17:33', '2022-06-02 02:17:33'),
(606, 7, '12', NULL, NULL, NULL, '2022-06-02 02:17:33', '2022-06-02 02:17:33'),
(607, 3, '/storage/files/10/brimnes/brimnes-tv-unit-white__0850000_pe725296_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:18:47', '2022-06-02 02:18:47'),
(608, 4, '/storage/files/10/brimnes/brimnes-tv-unit-white__0658114_ph150586_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:18:47', '2022-06-02 02:18:47'),
(609, 5, '/storage/files/10/brimnes/brimnes-tv-unit-black__0619470_pe689104_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:18:47', '2022-06-02 02:18:47'),
(610, 2, '/storage/files/10/brimnes/brimnes-tv-unit-white__0601754_pe681623_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:18:47', '2022-06-02 02:18:47'),
(611, 6, '/storage/files/10/brimnes/brimnes-tv-unit-white__0850789_pe725297_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:18:47', '2022-06-02 02:18:47'),
(612, 1, 'rgba(0,0,0,0)', NULL, NULL, NULL, '2022-06-02 02:18:47', '2022-06-02 02:18:47'),
(613, 7, '13', NULL, NULL, NULL, '2022-06-02 02:18:47', '2022-06-02 02:18:47'),
(614, 3, '/storage/files/10/byas/byas-tv-unit-high-gloss-white__0849938_pe560742_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:23:43', '2022-06-02 02:23:43'),
(615, 4, '/storage/files/10/byas/besta-tv-unit-white-selsviken-high-gloss-white__0843389_pe535717_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:23:43', '2022-06-02 02:23:43'),
(616, 5, '/storage/files/10/byas/byas-tv-unit-high-gloss-white__0544140_pe654903_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:23:43', '2022-06-02 02:23:43'),
(617, 2, '/storage/files/10/byas/byas-tv-unit-high-gloss-white__0644411_pe702653_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:23:43', '2022-06-02 02:23:43'),
(618, 6, '/storage/files/10/byas/byas-tv-unit-high-gloss-white__0378189_pe322598_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:23:43', '2022-06-02 02:23:43'),
(619, 1, 'rgba(0,0,0,0)', NULL, NULL, NULL, '2022-06-02 02:23:43', '2022-06-02 02:23:43'),
(620, 7, '13', NULL, NULL, NULL, '2022-06-02 02:23:43', '2022-06-02 02:23:43'),
(621, 3, '/storage/files/10/lack/lack-tv-unit-black-brown__1092881_pe863120_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:30:37', '2022-06-02 02:30:37'),
(622, 4, '/storage/files/10/lack/lack-tv-unit-black-brown__1092880_pe863121_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:30:37', '2022-06-02 02:30:37'),
(623, 5, '/storage/files/10/lack/lack-tv-unit-black-brown__1009130_pe827481_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:30:37', '2022-06-02 02:30:37'),
(624, 2, '/storage/files/10/lack/lack-tv-unit-black-brown__0955264_pe803706_s5 (1).jpg', NULL, NULL, NULL, '2022-06-02 02:30:37', '2022-06-02 02:30:37'),
(625, 6, '/storage/files/10/lack/lack-tv-unit-black-brown__0955265_pe803705_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:30:37', '2022-06-02 02:30:37'),
(626, 1, 'black', NULL, NULL, NULL, '2022-06-02 02:30:37', '2022-06-02 02:30:37'),
(627, 7, '12', NULL, NULL, NULL, '2022-06-02 02:30:37', '2022-06-02 02:30:37'),
(628, 3, '/storage/files/10/lack/lack-tv-unit-white__1092886_pe863122_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:31:46', '2022-06-02 02:31:46'),
(629, 4, '/storage/files/10/lack/lack-tv-unit-white__1092885_pe863123_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:31:46', '2022-06-02 02:31:46'),
(630, 5, '/storage/files/10/lack/lack-tv-unit-black-brown__1009130_pe827481_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:31:46', '2022-06-02 02:31:46'),
(631, 2, '/storage/files/10/lack/lack-tv-unit-white__0955266_pe803708_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:31:46', '2022-06-02 02:31:46'),
(632, 6, '/storage/files/10/lack/lack-tv-unit-white__0955267_pe803707_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:31:46', '2022-06-02 02:31:46'),
(633, 1, 'black', NULL, NULL, NULL, '2022-06-02 02:31:46', '2022-06-02 02:31:46'),
(634, 7, '12', NULL, NULL, NULL, '2022-06-02 02:31:46', '2022-06-02 02:31:46'),
(635, 3, '/storage/files/10/hemnes/hemnes-tv-unit-black-brown__0803357_pe768854_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:40:47', '2022-06-02 02:40:47'),
(636, 4, '/storage/files/10/hemnes/hemnes-tv-unit-black-brown__0679554_pe719633_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:40:47', '2022-06-02 02:40:47'),
(637, 5, '/storage/files/10/hemnes/hemnes-tv-unit-white-stain-light-brown__0978642_pe814195_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:40:47', '2022-06-02 02:40:47'),
(638, 2, '/storage/files/10/hemnes/hemnes-tv-unit-black-brown__0625361_pe692211_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:40:47', '2022-06-02 02:40:47'),
(639, 6, '/storage/files/10/hemnes/hemnes-tv-unit-black-brown__0679553_pe719634_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:40:47', '2022-06-02 02:40:47'),
(640, 1, 'black', NULL, NULL, NULL, '2022-06-02 02:40:47', '2022-06-02 02:40:47'),
(641, 7, '14', NULL, NULL, NULL, '2022-06-02 02:40:47', '2022-06-02 02:40:47'),
(642, 3, '/storage/files/10/hemnes/hemnes-tv-unit-white-stain__0803358_pe768857_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:42:10', '2022-06-02 02:42:10'),
(643, 4, '/storage/files/10/hemnes/hemnes-tv-unit-white-stain__0164867_pe316751_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:42:10', '2022-06-02 02:42:10'),
(644, 5, '/storage/files/10/hemnes/hemnes-tv-unit-white-stain-light-brown__0978642_pe814195_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:42:10', '2022-06-02 02:42:10'),
(645, 2, '/storage/files/10/hemnes/hemnes-tv-unit-white-stain__0644455_pe702706_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:42:10', '2022-06-02 02:42:10'),
(646, 6, '/storage/files/10/hemnes/hemnes-tv-unit-white-stain__0679567_pe719638_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:42:10', '2022-06-02 02:42:10'),
(647, 1, 'rgba(0,0,0,0)', NULL, NULL, NULL, '2022-06-02 02:42:10', '2022-06-02 02:42:10'),
(648, 7, '14', NULL, NULL, NULL, '2022-06-02 02:42:10', '2022-06-02 02:42:10'),
(649, 3, '/storage/files/10/hemnes/hemnes-tv-unit-white-stain-light-brown__0803360_pe768855_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:44:11', '2022-06-02 02:44:11'),
(650, 4, '/storage/files/10/hemnes/hemnes-tv-unit-white-stain-light-brown__0164867_pe316751_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:44:11', '2022-06-02 02:44:11'),
(651, 5, '/storage/files/10/hemnes/hemnes-tv-unit-white-stain-light-brown__0978642_pe814195_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:44:11', '2022-06-02 02:44:11'),
(652, 2, '/storage/files/10/hemnes/hemnes-tv-unit-white-stain-light-brown__0583377_pe671187_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:44:11', '2022-06-02 02:44:11'),
(653, 6, '/storage/files/10/hemnes/hemnes-tv-unit-white-stain-light-brown__0850139_pe671188_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:44:11', '2022-06-02 02:44:11'),
(654, 1, 'rgba(98,36,7,0.74)', NULL, NULL, NULL, '2022-06-02 02:44:11', '2022-06-02 02:44:11'),
(655, 7, '14', NULL, NULL, NULL, '2022-06-02 02:44:11', '2022-06-02 02:44:11'),
(656, 3, '/storage/files/10/hemnes/hemnes-tv-unit-dark-gray-stained__0803359_pe768856_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:45:51', '2022-06-02 02:45:51'),
(657, 4, '/storage/files/10/hemnes/hemnes-tv-unit-dark-gray-stained__0850385_pe671757_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:45:51', '2022-06-02 02:45:51'),
(658, 5, '/storage/files/10/hemnes/hemnes-tv-unit-white-stain-light-brown__0978642_pe814195_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:45:51', '2022-06-02 02:45:51'),
(659, 2, '/storage/files/10/hemnes/hemnes-tv-unit-dark-gray-stained__0531274_pe647229_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:45:51', '2022-06-02 02:45:51'),
(660, 6, '/storage/files/10/hemnes/hemnes-tv-unit-dark-gray-stained__0851330_pe647231_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:45:51', '2022-06-02 02:45:51'),
(661, 1, 'rgba(0,0,0,0.71)', NULL, NULL, NULL, '2022-06-02 02:45:51', '2022-06-02 02:45:51'),
(662, 7, '14', NULL, NULL, NULL, '2022-06-02 02:45:51', '2022-06-02 02:45:51'),
(663, 3, '/storage/files/10/lommard/lommarp-tv-unit-black__1019794_pe831572_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:53:52', '2022-06-02 02:53:52'),
(664, 4, '/storage/files/10/lommard/lommarp-tv-unit-black__1019796_pe831574_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:53:52', '2022-06-02 02:53:52'),
(665, 5, '/storage/files/10/lommard/lommarp-tv-unit-dark-blue-green__0752805_pe747482_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:53:52', '2022-06-02 02:53:52'),
(666, 2, '/storage/files/10/lommard/lommarp-tv-unit-black__0964387_pe809023_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:53:52', '2022-06-02 02:53:52'),
(667, 6, '/storage/files/10/lommard/lommarp-tv-unit-black__1019793_pe831571_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:53:52', '2022-06-02 02:53:52'),
(668, 1, 'black', NULL, NULL, NULL, '2022-06-02 02:53:52', '2022-06-02 02:53:52'),
(669, 7, '14', NULL, NULL, NULL, '2022-06-02 02:53:52', '2022-06-02 02:53:52'),
(670, 3, '/storage/files/10/lommard/lommarp-tv-unit-light-beige__0740725_pe742117_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:56:26', '2022-06-02 02:56:26'),
(671, 4, '/storage/files/10/lommard/lommarp-tv-unit-light-beige__0740689_pe742109_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:56:26', '2022-06-02 02:56:26'),
(672, 5, '/storage/files/10/lommard/lommarp-tv-unit-dark-blue-green__0752805_pe747482_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:56:26', '2022-06-02 02:56:26'),
(673, 2, '/storage/files/10/lommard/lommarp-tv-unit-light-beige__0739337_pe741697_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:56:26', '2022-06-02 02:56:26'),
(674, 6, '/storage/files/10/lommard/lommarp-tv-unit-light-beige__0742806_pe742828_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:56:26', '2022-06-02 02:56:26'),
(675, 1, 'rgba(244,214,214,0.56)', NULL, NULL, NULL, '2022-06-02 02:56:26', '2022-06-02 02:56:26'),
(676, 7, '14', NULL, NULL, NULL, '2022-06-02 02:56:26', '2022-06-02 02:56:26'),
(677, 3, '/storage/files/10/lommard/lommarp-tv-unit-dark-blue-green__0740721_pe742113_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:58:00', '2022-06-02 02:58:00'),
(678, 4, '/storage/files/10/lommard/lommarp-tv-unit-dark-blue-green__0740683_pe742103_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:58:00', '2022-06-02 02:58:00'),
(679, 5, '/storage/files/10/lommard/lommarp-tv-unit-dark-blue-green__0752805_pe747482_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:58:00', '2022-06-02 02:58:00'),
(680, 2, '/storage/files/10/lommard/lommarp-tv-unit-dark-blue-green__0739335_pe741696_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:58:00', '2022-06-02 02:58:00'),
(681, 6, '/storage/files/10/lommard/lommarp-tv-unit-dark-blue-green__0742805_pe742829_s5.jpg', NULL, NULL, NULL, '2022-06-02 02:58:00', '2022-06-02 02:58:00'),
(682, 1, '#025235', NULL, NULL, NULL, '2022-06-02 02:58:00', '2022-06-02 02:58:00'),
(683, 7, '14', NULL, NULL, NULL, '2022-06-02 02:58:00', '2022-06-02 02:58:00'),
(684, 3, '/storage/files/10/rudsta/rudsta-glass-door-cabinet-anthracite__0954670_pe803425_s5.jpg', NULL, NULL, NULL, '2022-06-03 00:42:46', '2022-06-03 00:42:46'),
(685, 4, '/storage/files/10/rudsta/rudsta-glass-door-cabinet-anthracite__0974172_pe812299_s5.jpg', NULL, NULL, NULL, '2022-06-03 00:42:46', '2022-06-03 00:42:46'),
(686, 5, '/storage/files/10/rudsta/rudsta-glass-door-cabinet-anthracite__0958931_pe805516_s5.jpg', NULL, NULL, NULL, '2022-06-03 00:42:46', '2022-06-03 00:42:46'),
(687, 2, '/storage/files/10/rudsta/rudsta-glass-door-cabinet-anthracite__0939002_pe794384_s5.jpg', NULL, NULL, NULL, '2022-06-03 00:42:46', '2022-06-03 00:42:46'),
(688, 6, '/storage/files/10/rudsta/rudsta-glass-door-cabinet-anthracite__1052000_pe845871_s5.jpg', NULL, NULL, NULL, '2022-06-03 00:42:46', '2022-06-03 00:42:46'),
(689, 1, 'black', NULL, NULL, NULL, '2022-06-03 00:42:46', '2022-06-03 00:42:46'),
(690, 7, '12', NULL, NULL, NULL, '2022-06-03 00:42:46', '2022-06-03 00:42:46'),
(691, 3, '/storage/files/10/billy/billy-bookcase-with-glass-doors-dark-blue__0507345_pe635073_s5.jpg', NULL, NULL, NULL, '2022-06-03 01:00:40', '2022-06-03 01:00:40'),
(692, 4, '/storage/files/10/billy/billy-bookcase-with-glass-doors-dark-blue__0498154_ph137137_s5.jpg', NULL, NULL, NULL, '2022-06-03 01:00:40', '2022-06-03 01:00:40'),
(693, 5, '/storage/files/10/billy/billy-bookcase-with-glass-doors-dark-blue__0543816_pe654771_s5.jpg', NULL, NULL, NULL, '2022-06-03 01:00:40', '2022-06-03 01:00:40'),
(694, 2, '/storage/files/10/billy/billy-bookcase-with-glass-doors-dark-blue__0429309_pe584188_s5.jpg', NULL, NULL, NULL, '2022-06-03 01:00:40', '2022-06-03 01:00:40'),
(695, 6, '/storage/files/10/billy/billy-bookcase-with-glass-doors-dark-blue__0849265_pe646526_s5.jpg', NULL, NULL, NULL, '2022-06-03 01:00:40', '2022-06-03 01:00:40'),
(696, 1, '#0805fb', NULL, NULL, NULL, '2022-06-03 01:00:40', '2022-06-03 01:00:40'),
(697, 7, '13', NULL, NULL, NULL, '2022-06-03 01:00:40', '2022-06-03 01:00:40'),
(698, 3, '/storage/files/10/billy/billy-bookcase-with-glass-doors-gray-metallic-effect__1051937_pe845818_s5.jpg', NULL, NULL, NULL, '2022-06-03 01:02:27', '2022-06-03 01:02:27'),
(699, 4, '/storage/files/10/billy/billy-bookcase-with-glass-doors-gray-metallic-effect__1092820_pe863070_s5.jpg', NULL, NULL, NULL, '2022-06-03 01:02:27', '2022-06-03 01:02:27'),
(700, 5, '/storage/files/10/billy/billy-bookcase-with-glass-doors-dark-blue__0543816_pe654771_s5.jpg', NULL, NULL, NULL, '2022-06-03 01:02:27', '2022-06-03 01:02:27'),
(701, 2, '/storage/files/10/billy/billy-bookcase-with-glass-doors-gray-metallic-effect__0806974_pe770197_s5.jpg', NULL, NULL, NULL, '2022-06-03 01:02:27', '2022-06-03 01:02:27'),
(702, 6, '/storage/files/10/billy/billy-bookcase-with-glass-doors-gray-metallic-effect__0834401_pe778289_s5.jpg', NULL, NULL, NULL, '2022-06-03 01:02:27', '2022-06-03 01:02:27'),
(703, 1, 'rgba(247,212,212,0.55)', NULL, NULL, NULL, '2022-06-03 01:02:27', '2022-06-03 01:02:27'),
(704, 7, '14', NULL, NULL, NULL, '2022-06-03 01:02:27', '2022-06-03 01:02:27'),
(705, 3, '/storage/files/10/billy/billy-bookcase-with-glass-doors-gray-turquoise-white-stained-oak-veneer__1009257_ph176786_s5.jpg', NULL, NULL, NULL, '2022-06-03 01:03:44', '2022-06-03 01:03:44'),
(706, 4, '/storage/files/10/billy/billy-bookcase-with-glass-doors-gray-turquoise-white-stained-oak-veneer__0955293_pe803738_s5.jpg', NULL, NULL, NULL, '2022-06-03 01:03:44', '2022-06-03 01:03:44'),
(707, 5, '/storage/files/10/billy/billy-bookcase-with-glass-doors-dark-blue__0543816_pe654771_s5.jpg', NULL, NULL, NULL, '2022-06-03 01:03:44', '2022-06-03 01:03:44'),
(708, 2, '/storage/files/10/billy/billy-bookcase-with-glass-doors-gray-turquoise-white-stained-oak-veneer__1063149_pe851277_s5.jpg', NULL, NULL, NULL, '2022-06-03 01:03:44', '2022-06-03 01:03:44'),
(709, 6, '/storage/files/10/billy/billy-bookcase-with-glass-doors-gray-turquoise-white-stained-oak-veneer__1051934_pe845815_s5.jpg', NULL, NULL, NULL, '2022-06-03 01:03:44', '2022-06-03 01:03:44'),
(710, 1, 'rgba(4,86,66,0.98)', NULL, NULL, NULL, '2022-06-03 01:03:44', '2022-06-03 01:03:44'),
(711, 7, '14', NULL, NULL, NULL, '2022-06-03 01:03:44', '2022-06-03 01:03:44'),
(712, 3, '/storage/files/10/syvde/syvde-cabinet-with-glass-doors-white__0720835_pe740013_s5.jpg', NULL, NULL, NULL, '2022-06-03 01:08:10', '2022-06-03 01:08:10'),
(713, 4, '/storage/files/10/syvde/syvde-cabinet-with-glass-doors-white__0799665_ph165861_s5.jpg', NULL, NULL, NULL, '2022-06-03 01:08:10', '2022-06-03 01:08:10'),
(714, 5, '/storage/files/10/syvde/syvde-cabinet-with-glass-doors-white__0789906_pe764194_s5.jpg', NULL, NULL, NULL, '2022-06-03 01:08:10', '2022-06-03 01:08:10'),
(715, 2, '/storage/files/10/syvde/syvde-cabinet-with-glass-doors-white__0720837_pe740012_s5.jpg', NULL, NULL, NULL, '2022-06-03 01:08:10', '2022-06-03 01:08:10'),
(716, 6, '/storage/files/10/syvde/syvde-cabinet-with-glass-doors-white__0720836_pe740014_s5.jpg', NULL, NULL, NULL, '2022-06-03 01:08:10', '2022-06-03 01:08:10'),
(717, 1, 'rgba(0,0,0,0)', NULL, NULL, NULL, '2022-06-03 01:08:10', '2022-06-03 01:08:10'),
(718, 7, '13', NULL, NULL, NULL, '2022-06-03 01:08:10', '2022-06-03 01:08:10'),
(719, 3, '/storage/files/10/inadas/idanaes-cabinet-with-bi-fold-glass-doors-white__1060615_ph178642_s5.jpg', NULL, NULL, NULL, '2022-06-03 01:14:33', '2022-06-03 01:14:33'),
(720, 4, '/storage/files/10/inadas/idanaes-cabinet-with-bi-fold-glass-doors-white__0985315_pe816588_s5.jpg', NULL, NULL, NULL, '2022-06-03 01:14:33', '2022-06-03 01:14:33'),
(721, 5, '/storage/files/10/inadas/idanaes-cabinet-with-bi-fold-glass-doors-white__1022447_pe832732_s5.jpg', NULL, NULL, NULL, '2022-06-03 01:14:33', '2022-06-03 01:14:33'),
(722, 2, '/storage/files/10/inadas/idanaes-cabinet-with-bi-fold-glass-doors-white__1009038_pe827427_s5.jpg', NULL, NULL, NULL, '2022-06-03 01:14:33', '2022-06-03 01:14:33'),
(723, 6, '/storage/files/10/inadas/idanaes-cabinet-with-bi-fold-glass-doors-white__1106827_ph183941_s5.jpg', NULL, NULL, NULL, '2022-06-03 01:14:33', '2022-06-03 01:14:33'),
(724, 1, 'rgba(0,0,0,0)', NULL, NULL, NULL, '2022-06-03 01:14:33', '2022-06-03 01:14:33'),
(725, 7, '15', NULL, NULL, NULL, '2022-06-03 01:14:33', '2022-06-03 01:14:33'),
(726, 3, '/storage/files/10/floalt/floalt-led-light-panel-dimmable-white-spectrum__0795494_ph151890_s5.jpg', NULL, NULL, NULL, '2022-06-07 07:39:56', '2022-06-07 07:39:56'),
(727, 4, '/storage/files/10/floalt/floalt-led-light-panel-dimmable-white-spectrum__0795496_ph141914_s5.jpg', NULL, NULL, NULL, '2022-06-07 07:39:56', '2022-06-07 07:39:56'),
(728, 5, '/storage/files/10/floalt/floalt-led-light-panel-dimmable-white-spectrum__0879630_pe621598_s5.jpg', NULL, NULL, NULL, '2022-06-07 07:39:56', '2022-06-07 07:39:56'),
(729, 2, '/storage/files/10/floalt/floalt-led-light-panel-dimmable-white-spectrum__0685698_pe721474_s5.jpg', NULL, NULL, NULL, '2022-06-07 07:39:56', '2022-06-07 07:39:56'),
(730, 6, '/storage/files/10/floalt/floalt-led-light-panel-dimmable-white-spectrum__0740744_pe742130_s5.jpg', NULL, NULL, NULL, '2022-06-07 07:39:56', '2022-06-07 07:39:56'),
(731, 1, 'black', NULL, NULL, NULL, '2022-06-07 07:39:56', '2022-06-07 07:39:56'),
(732, 7, '17', NULL, NULL, NULL, '2022-06-07 07:39:56', '2022-06-07 07:39:56'),
(733, 3, '/storage/files/10/lergryn/lergryn-sunneby-pendant-lamp-beige-black__0995537_pe821769_s5.jpg', NULL, NULL, NULL, '2022-06-07 07:48:45', '2022-06-07 07:48:45'),
(734, 4, '/storage/files/10/lergryn/lergryn-sunneby-pendant-lamp-beige-black__0995541_pe821770_s5.jpg', NULL, NULL, NULL, '2022-06-07 07:48:45', '2022-06-07 07:48:45'),
(735, 5, '/storage/files/10/lergryn/lergryn-sunneby-pendant-lamp-beige-black__0664676_pe712848_s5.jpg', NULL, NULL, NULL, '2022-06-07 07:48:45', '2022-06-07 07:48:45'),
(736, 2, '/storage/files/10/lergryn/floalt-led-light-panel-dimmable-white-spectrum__0740740_pe742126_s5.jpg', NULL, NULL, NULL, '2022-06-07 07:48:45', '2022-06-07 07:48:45'),
(737, 6, '/storage/files/10/lergryn/lergryn-sunneby-pendant-lamp-beige-black__1009602_pe827682_s5.jpg', NULL, NULL, NULL, '2022-06-07 07:48:45', '2022-06-07 07:48:45'),
(738, 1, 'black', NULL, NULL, NULL, '2022-06-07 07:48:45', '2022-06-07 07:48:45'),
(739, 7, '17', NULL, NULL, NULL, '2022-06-07 07:48:45', '2022-06-07 07:48:45'),
(740, 3, '/storage/files/10/sodakra/soedakra-pendant-lamp-birch__1044008_pe843082_s5.jpg', NULL, NULL, NULL, '2022-06-07 07:54:50', '2022-06-07 07:54:50'),
(741, 4, '/storage/files/10/sodakra/soedakra-pendant-lamp-birch__1071292_ph183044_s5.jpg', NULL, NULL, NULL, '2022-06-07 07:54:50', '2022-06-07 07:54:50'),
(742, 5, '/storage/files/10/sodakra/soedakra-pendant-lamp-birch__1076719_ph182373_s5.jpg', NULL, NULL, NULL, '2022-06-07 07:54:50', '2022-06-07 07:54:50'),
(743, 2, '/storage/files/10/sodakra/vaexjoe-pendant-lamp-beige__0880492_pe653062_s5.jpg', NULL, NULL, NULL, '2022-06-07 07:54:50', '2022-06-07 07:54:50'),
(744, 6, '/storage/files/10/sodakra/soedakra-pendant-lamp-birch__1076713_pe856830_s5.jpg', NULL, NULL, NULL, '2022-06-07 07:54:50', '2022-06-07 07:54:50'),
(745, 1, 'black', NULL, NULL, NULL, '2022-06-07 07:54:50', '2022-06-07 07:54:50'),
(746, 7, '17', NULL, NULL, NULL, '2022-06-07 07:54:50', '2022-06-07 07:54:50'),
(747, 3, '/storage/files/10/regolit/regolit-hemma-pendant-lamp-white__0331379_pe522998_s5.jpg', NULL, NULL, NULL, '2022-06-07 07:59:32', '2022-06-07 07:59:32'),
(748, 4, '/storage/files/10/regolit/regolit-hemma-pendant-lamp-white__0610594_pe685036_s5.jpg', NULL, NULL, NULL, '2022-06-07 07:59:32', '2022-06-07 07:59:32'),
(749, 5, '/storage/files/10/regolit/regolit-hemma-pendant-lamp-white__1057450_ph178437_s5.jpg', NULL, NULL, NULL, '2022-06-07 07:59:32', '2022-06-07 07:59:32'),
(750, 2, '/storage/files/10/regolit/regolit-hemma-pendant-lamp-white__1045608_pe842669_s5.jpg', NULL, NULL, NULL, '2022-06-07 07:59:32', '2022-06-07 07:59:32'),
(751, 6, '/storage/files/10/regolit/regolit-hemma-pendant-lamp-white__1041794_pe841158_s5.jpg', NULL, NULL, NULL, '2022-06-07 07:59:32', '2022-06-07 07:59:32'),
(752, 1, 'black', NULL, NULL, NULL, '2022-06-07 07:59:32', '2022-06-07 07:59:32'),
(753, 7, '17', NULL, NULL, NULL, '2022-06-07 07:59:32', '2022-06-07 07:59:32'),
(754, 3, '/storage/files/10/solklint/solklint-pendant-lamp-brass-gray-clear-glass__0842308_pe778949_s5.jpg', NULL, NULL, NULL, '2022-06-07 08:03:44', '2022-06-07 08:03:44'),
(755, 4, '/storage/files/10/solklint/solklint-pendant-lamp-brass-gray-clear-glass__0955860_ph173391_s5.jpg', NULL, NULL, NULL, '2022-06-07 08:03:44', '2022-06-07 08:03:44'),
(756, 5, '/storage/files/10/solklint/solklint-pendant-lamp-brass-gray-clear-glass__0842307_pe778950_s5.jpg', NULL, NULL, NULL, '2022-06-07 08:03:44', '2022-06-07 08:03:44'),
(757, 2, '/storage/files/10/solklint/solklint-pendant-lamp-brass-gray-clear-glass__0842306_pe778948_s5.jpg', NULL, NULL, NULL, '2022-06-07 08:03:44', '2022-06-07 08:03:44'),
(758, 6, '/storage/files/10/solklint/solklint-pendant-lamp-brass-gray-clear-glass__0989197_ph172550_s5.jpg', NULL, NULL, NULL, '2022-06-07 08:03:44', '2022-06-07 08:03:44'),
(759, 1, 'black', NULL, NULL, NULL, '2022-06-07 08:03:44', '2022-06-07 08:03:44'),
(760, 7, '20', NULL, NULL, NULL, '2022-06-07 08:03:44', '2022-06-07 08:03:44'),
(761, 3, '/storage/files/10/nymane/nymane-led-pendant-lamp-wireless-dimmable-white-spectrum-white__1008046_pe826689_s5.jpg', NULL, NULL, NULL, '2022-06-07 08:07:17', '2022-06-07 08:07:17'),
(762, 4, '/storage/files/10/nymane/nymane-led-pendant-lamp-wireless-dimmable-white-spectrum-white__1008047_pe826688_s5.jpg', NULL, NULL, NULL, '2022-06-07 08:07:17', '2022-06-07 08:07:17'),
(763, 5, '/storage/files/10/nymane/nymane-led-pendant-lamp-wireless-dimmable-white-spectrum-white__1074991_pe856366_s5.jpg', NULL, NULL, NULL, '2022-06-07 08:07:17', '2022-06-07 08:07:17'),
(764, 2, '/storage/files/10/nymane/nymane-led-pendant-lamp-wireless-dimmable-white-spectrum-white__1008045_pe826687_s5.jpg', NULL, NULL, NULL, '2022-06-07 08:07:17', '2022-06-07 08:07:17'),
(765, 6, '/storage/files/10/nymane/nymane-led-pendant-lamp-wireless-dimmable-white-spectrum-white__1074986_pe856365_s5.jpg', NULL, NULL, NULL, '2022-06-07 08:07:17', '2022-06-07 08:07:17'),
(766, 1, 'black', NULL, NULL, NULL, '2022-06-07 08:07:17', '2022-06-07 08:07:17'),
(767, 7, '17', NULL, NULL, NULL, '2022-06-07 08:07:17', '2022-06-07 08:07:17'),
(768, 3, '/storage/files/10/tybble/tybble-led-pendant-lamp-with-5-lamps-nickel-plated-opal-glass__0794588_pe765658_s5.jpg', NULL, NULL, NULL, '2022-06-07 08:13:06', '2022-06-07 08:13:06'),
(769, 4, '/storage/files/10/tybble/tybble-led-pendant-lamp-with-5-lamps-nickel-plated-opal-glass__1076345_pe856773_s5.jpg', NULL, NULL, NULL, '2022-06-07 08:13:06', '2022-06-07 08:13:06'),
(770, 5, '/storage/files/10/tybble/tybble-led-pendant-lamp-with-5-lamps-nickel-plated-opal-glass__0794589_pe765661_s5.jpg', NULL, NULL, NULL, '2022-06-07 08:13:06', '2022-06-07 08:13:06'),
(771, 2, '/storage/files/10/tybble/tybble-led-pendant-lamp-with-5-lamps-nickel-plated-opal-glass__0918122_pe786075_s5.jpg', NULL, NULL, NULL, '2022-06-07 08:13:06', '2022-06-07 08:13:06'),
(772, 6, '/storage/files/10/tybble/tybble-led-pendant-lamp-with-5-lamps-nickel-plated-opal-glass__0794590_pe765660_s5.jpg', NULL, NULL, NULL, '2022-06-07 08:13:06', '2022-06-07 08:13:06'),
(773, 1, 'black', NULL, NULL, NULL, '2022-06-07 08:13:06', '2022-06-07 08:13:06'),
(774, 7, '20', NULL, NULL, NULL, '2022-06-07 08:13:06', '2022-06-07 08:13:06'),
(775, 3, '/storage/files/10/simrishamn/simrishamn-pendant-lamp-3-armed-chrome-plated-opal-glass__0888336_ph167979_s5.jpg', NULL, NULL, NULL, '2022-06-07 08:18:30', '2022-06-07 08:18:30'),
(776, 4, '/storage/files/10/simrishamn/simrishamn-pendant-lamp-3-armed-chrome-plated-opal-glass__0793570_pe765400_s5.jpg', NULL, NULL, NULL, '2022-06-07 08:18:30', '2022-06-07 08:18:30'),
(777, 5, '/storage/files/10/simrishamn/simrishamn-pendant-lamp-3-armed-chrome-plated-opal-glass__0939855_ph171920_s5.jpg', NULL, NULL, NULL, '2022-06-07 08:18:30', '2022-06-07 08:18:30'),
(778, 2, '/storage/files/10/simrishamn/simrishamn-pendant-lamp-3-armed-chrome-plated-opal-glass__0793571_pe765399_s5.jpg', NULL, NULL, NULL, '2022-06-07 08:18:30', '2022-06-07 08:18:30'),
(779, 6, '/storage/files/10/simrishamn/simrishamn-pendant-lamp-3-armed-chrome-plated-opal-glass__0888340_ph168817_s5.jpg', NULL, NULL, NULL, '2022-06-07 08:18:30', '2022-06-07 08:18:30'),
(780, 1, 'black', NULL, NULL, NULL, '2022-06-07 08:18:30', '2022-06-07 08:18:30'),
(781, 7, '20', NULL, NULL, NULL, '2022-06-07 08:18:30', '2022-06-07 08:18:30');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `promotion`
--

CREATE TABLE `promotion` (
  `ID` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` text NOT NULL,
  `discount_type` int(11) NOT NULL COMMENT '1-giảm theo % \r\n2 giảm tiền',
  `discount_value` int(11) NOT NULL,
  `promotion_apply` int(11) NOT NULL COMMENT '1-toàn bộ sản phẩm\r\n2-theo danh mục sp (loại sp) \r\n3- theo sản phẩm cụ thể',
  `status` int(11) NOT NULL DEFAULT 0 COMMENT '1- hoạt động \r\n0- không hoạt động',
  `promotion_condition` int(11) NOT NULL COMMENT '0- no condition\r\n1-lowest total price \r\n2 - lowest discount money\r\n3- minimum product get discount in bill',
  `condition_value` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL COMMENT 'số lượng mã giảm giá ',
  `start_date` timestamp NULL DEFAULT NULL,
  `end_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `promotion`
--

INSERT INTO `promotion` (`ID`, `title`, `description`, `discount_type`, `discount_value`, `promotion_apply`, `status`, `promotion_condition`, `condition_value`, `quantity`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES
(14, 'AAA', 'a', 2, 5000, 2, 1, 0, NULL, 100, '2022-03-03 17:00:00', '2022-03-25 17:00:00', '2022-03-15 20:34:37', '2022-03-15 20:34:37'),
(16, 'CAThANGTU', 'Mã giảm giá', 1, 90, 2, 1, 0, NULL, 100, '2022-03-30 17:00:00', '2022-04-01 17:00:00', '2022-03-31 09:09:06', '2022-03-31 09:09:06'),
(17, 'CHAOMUNG2022', 'Code giảm 15% cho toàn bộ sản phẩm chào mừng năm mới!!!', 1, 15, 1, 1, 0, NULL, 100, '2022-01-02 17:00:00', '2022-06-29 17:00:00', '2022-06-02 10:29:14', '2022-06-02 10:29:14');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `specification_type`
--

CREATE TABLE `specification_type` (
  `ID` int(11) NOT NULL,
  `name` text NOT NULL,
  `description` text NOT NULL,
  `type` text DEFAULT NULL,
  `start_date` timestamp NULL DEFAULT NULL,
  `end_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `specification_type`
--

INSERT INTO `specification_type` (`ID`, `name`, `description`, `type`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES
(1, 'color', 'Màu Sắc', 'color', NULL, NULL, '2022-01-20 08:57:22', '2022-01-20 08:57:22'),
(2, 'image_with_background', 'Ảnh sản phẩm không nền', 'image', NULL, NULL, '2022-01-20 08:57:22', '2022-01-20 08:57:22'),
(3, 'image_1', 'Ảnh 1', 'image', NULL, NULL, '2022-01-20 08:58:13', '2022-01-20 08:58:13'),
(4, 'image_2', 'Ảnh 2', 'image', NULL, NULL, '2022-01-20 08:58:13', '2022-01-20 08:58:13'),
(5, 'image_3', 'Ảnh 3', 'image', NULL, NULL, '2022-01-20 08:58:32', '2022-01-20 08:58:32'),
(6, 'image_no_background', 'Ảnh sản phẩm với nền', 'image', NULL, NULL, '2022-01-20 08:58:32', '2022-01-20 08:58:32'),
(7, 'material', 'Chất liệu', 'material', NULL, NULL, '2022-01-20 08:59:17', '2022-01-20 08:59:17');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `bill_sell`
--
ALTER TABLE `bill_sell`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `buyer` (`buyer`),
  ADD KEY `seller` (`seller`);

--
-- Chỉ mục cho bảng `bill_sell_detail`
--
ALTER TABLE `bill_sell_detail`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `bill_id` (`bill_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Chỉ mục cho bảng `blog`
--
ALTER TABLE `blog`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `slug` (`slug`) USING HASH,
  ADD KEY `author` (`author`);

--
-- Chỉ mục cho bảng `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `category_parent` (`parent_id`);

--
-- Chỉ mục cho bảng `category_promotion`
--
ALTER TABLE `category_promotion`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `categoryID` (`categoryID`),
  ADD KEY `promotionID` (`promotionID`);

--
-- Chỉ mục cho bảng `client_account`
--
ALTER TABLE `client_account`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `username` (`username`) USING HASH,
  ADD KEY `belongTo` (`belong_to`);

--
-- Chỉ mục cho bảng `dashboard_img`
--
ALTER TABLE `dashboard_img`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `position` (`position`);

--
-- Chỉ mục cho bảng `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `belong_to` (`belong_to`,`username`) USING HASH;

--
-- Chỉ mục cho bảng `material`
--
ALTER TABLE `material`
  ADD PRIMARY KEY (`ID`);

--
-- Chỉ mục cho bảng `person`
--
ALTER TABLE `person`
  ADD PRIMARY KEY (`ID`);

--
-- Chỉ mục cho bảng `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `product_category` (`product_category`);

--
-- Chỉ mục cho bảng `product_promotion`
--
ALTER TABLE `product_promotion`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `promotionID` (`promotionID`,`productID`),
  ADD KEY `productID` (`productID`);

--
-- Chỉ mục cho bảng `product_spec`
--
ALTER TABLE `product_spec`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `productID` (`productID`),
  ADD KEY `specificationID` (`specificationID`);

--
-- Chỉ mục cho bảng `product_specifications`
--
ALTER TABLE `product_specifications`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `specification_type` (`specification_type`);

--
-- Chỉ mục cho bảng `promotion`
--
ALTER TABLE `promotion`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `title` (`title`) USING HASH;

--
-- Chỉ mục cho bảng `specification_type`
--
ALTER TABLE `specification_type`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `bill_sell`
--
ALTER TABLE `bill_sell`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT cho bảng `bill_sell_detail`
--
ALTER TABLE `bill_sell_detail`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT cho bảng `blog`
--
ALTER TABLE `blog`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `category`
--
ALTER TABLE `category`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT cho bảng `category_promotion`
--
ALTER TABLE `category_promotion`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `client_account`
--
ALTER TABLE `client_account`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT cho bảng `dashboard_img`
--
ALTER TABLE `dashboard_img`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT cho bảng `employee`
--
ALTER TABLE `employee`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `material`
--
ALTER TABLE `material`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT cho bảng `person`
--
ALTER TABLE `person`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT cho bảng `product`
--
ALTER TABLE `product`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=119;

--
-- AUTO_INCREMENT cho bảng `product_promotion`
--
ALTER TABLE `product_promotion`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT cho bảng `product_spec`
--
ALTER TABLE `product_spec`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=745;

--
-- AUTO_INCREMENT cho bảng `product_specifications`
--
ALTER TABLE `product_specifications`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=782;

--
-- AUTO_INCREMENT cho bảng `promotion`
--
ALTER TABLE `promotion`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT cho bảng `specification_type`
--
ALTER TABLE `specification_type`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `bill_sell`
--
ALTER TABLE `bill_sell`
  ADD CONSTRAINT `bill_sell_ibfk_1` FOREIGN KEY (`buyer`) REFERENCES `client_account` (`ID`),
  ADD CONSTRAINT `bill_sell_ibfk_2` FOREIGN KEY (`seller`) REFERENCES `employee` (`ID`);

--
-- Các ràng buộc cho bảng `bill_sell_detail`
--
ALTER TABLE `bill_sell_detail`
  ADD CONSTRAINT `bill_sell_detail_ibfk_1` FOREIGN KEY (`bill_id`) REFERENCES `bill_sell` (`ID`),
  ADD CONSTRAINT `bill_sell_detail_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`ID`);

--
-- Các ràng buộc cho bảng `blog`
--
ALTER TABLE `blog`
  ADD CONSTRAINT `blog_ibfk_1` FOREIGN KEY (`author`) REFERENCES `employee` (`ID`);

--
-- Các ràng buộc cho bảng `category`
--
ALTER TABLE `category`
  ADD CONSTRAINT `category_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `category` (`ID`);

--
-- Các ràng buộc cho bảng `category_promotion`
--
ALTER TABLE `category_promotion`
  ADD CONSTRAINT `category_promotion_ibfk_1` FOREIGN KEY (`categoryID`) REFERENCES `category` (`ID`),
  ADD CONSTRAINT `category_promotion_ibfk_2` FOREIGN KEY (`promotionID`) REFERENCES `promotion` (`ID`);

--
-- Các ràng buộc cho bảng `client_account`
--
ALTER TABLE `client_account`
  ADD CONSTRAINT `client_account_ibfk_1` FOREIGN KEY (`belong_to`) REFERENCES `person` (`ID`);

--
-- Các ràng buộc cho bảng `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`product_category`) REFERENCES `category` (`ID`);

--
-- Các ràng buộc cho bảng `product_promotion`
--
ALTER TABLE `product_promotion`
  ADD CONSTRAINT `product_promotion_ibfk_1` FOREIGN KEY (`productID`) REFERENCES `product` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_promotion_ibfk_2` FOREIGN KEY (`promotionID`) REFERENCES `promotion` (`ID`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `product_specifications`
--
ALTER TABLE `product_specifications`
  ADD CONSTRAINT `product_specifications_ibfk_1` FOREIGN KEY (`specification_type`) REFERENCES `specification_type` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
