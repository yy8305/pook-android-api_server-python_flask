/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 테이블 pook.pook_reserve 구조 내보내기
DROP TABLE IF EXISTS `pook_reserve`;
CREATE TABLE IF NOT EXISTS `pook_reserve` (
  `reserve_id` varchar(50) NOT NULL COMMENT '아이디',
  `store_id` varchar(50) DEFAULT NULL COMMENT '가게ID',
  `user_id` varchar(50) DEFAULT NULL COMMENT '예약한 사용자 ID',
  `reserve_people` varchar(10) DEFAULT NULL COMMENT '사람수',
  `reserve_date` varchar(10) DEFAULT NULL COMMENT '날짜',
  `reserve_time` varchar(30) DEFAULT NULL COMMENT '시간',
  PRIMARY KEY (`reserve_id`),
  KEY `store_id` (`store_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='예약';

-- 테이블 데이터 pook.pook_reserve:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `pook_reserve` DISABLE KEYS */;
INSERT INTO `pook_reserve` (`reserve_id`, `store_id`, `user_id`, `reserve_people`, `reserve_date`, `reserve_time`) VALUES
	('1', '1', 'af101280-e17f-35d7-b40d-0279887a6494', '2', '2019-12-8', '14:19');
/*!40000 ALTER TABLE `pook_reserve` ENABLE KEYS */;

-- 테이블 pook.pook_review 구조 내보내기
DROP TABLE IF EXISTS `pook_review`;
CREATE TABLE IF NOT EXISTS `pook_review` (
  `review_id` varchar(50) NOT NULL COMMENT '아이디',
  `user_id` varchar(50) NOT NULL COMMENT '사용자 아이디',
  `nickname` varchar(50) NOT NULL COMMENT '사용자 닉네임',
  `store_id` varchar(50) NOT NULL COMMENT '가게아이디',
  `score` varchar(5) NOT NULL COMMENT '점수',
  `review` varchar(500) NOT NULL COMMENT '후기',
  PRIMARY KEY (`review_id`),
  KEY `store_id` (`store_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='후기';

-- 테이블 데이터 pook.pook_review:~2 rows (대략적) 내보내기
/*!40000 ALTER TABLE `pook_review` DISABLE KEYS */;
INSERT INTO `pook_review` (`review_id`, `user_id`, `nickname`, `store_id`, `score`, `review`) VALUES
	('1', 'af101280-e17f-35d7-b40d-0279887a6494', '홍박사', '1', '5.0', '정말맛있습니다.'),
	('2', 'af101280-e17f-35d7-b40d-0279887a6494', '홍박사', '1', '2.0', '별로네요');
/*!40000 ALTER TABLE `pook_review` ENABLE KEYS */;

-- 테이블 pook.pook_store 구조 내보내기
DROP TABLE IF EXISTS `pook_store`;
CREATE TABLE IF NOT EXISTS `pook_store` (
  `store_id` varchar(50) NOT NULL COMMENT '가게 아이디',
  `name` varchar(100) DEFAULT NULL COMMENT '가게명',
  `contents` varchar(300) DEFAULT NULL COMMENT '가게설명',
  `addr` varchar(100) DEFAULT NULL COMMENT '가게주소',
  `phone` varchar(15) DEFAULT NULL COMMENT '가게 전화번호',
  `category` varchar(30) DEFAULT NULL COMMENT '가게 음식 종류',
  `open` varchar(100) DEFAULT NULL COMMENT '가게 영업시간',
  `breaktime` varchar(100) DEFAULT NULL COMMENT '가게 쉬는시간',
  `parking` varchar(50) DEFAULT NULL COMMENT '가게 주차 여부',
  `reserve_yn` char(1) DEFAULT 'Y' COMMENT '가게 예약 여부',
  `location_x` varchar(50) DEFAULT NULL COMMENT '가게 위도',
  `location_y` varchar(50) DEFAULT NULL COMMENT '가게 경도',
  `thumbnail_path` varchar(100) DEFAULT NULL COMMENT '썸네일 이미지 경로',
  PRIMARY KEY (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='맛집가게';

-- 테이블 데이터 pook.pook_store:~15 rows (대략적) 내보내기
/*!40000 ALTER TABLE `pook_store` DISABLE KEYS */;
INSERT INTO `pook_store` (`store_id`, `name`, `contents`, `addr`, `phone`, `category`, `open`, `breaktime`, `parking`, `reserve_yn`, `location_x`, `location_y`, `thumbnail_path`) VALUES
	('1', '코나야', '메뉴\r\n모찌 카레우동 8,500원\r\n에비 카레우동 9,500원\r\n텐동 9,500원\r\n키마 카레라이스 9,800\r\n원치카라 우동 8,500원', '서울시 강남구 삼성동 159-8', '	02-3453-3403', '돈부리 / 일본 카레 / 벤토', '	11:00 - 21:30', '없음', '유료주차 가능', 'Y', '37.509135', '127.060852', '/static/1.jpg'),
	('10', '안방마님 불고기백반', '상세설명없음', '서울시 서대문구 창천동 31-26', '없음', '한정식 / 백반 / 정통 한식', '09:00 ~ 22:00', '없음', '주차공간없음', 'Y', '37.557731', '126.937339', '/static/10.jpg'),
	('11', '재희키친', '상세설명없음', '서울시 강남구 삼성동 91-24', '02-3443-7577', '한정식 / 백반 / 정통 한식', '09:00 ~ 22:00', '없음', '주차공간없음', 'Y', '37.515336', '127.060647', '/static/11.jpg'),
	('12', '노브13', '상세설명없음', '서울시 종로구 체부동 18-9', '02-6941-1890', '이탈리안', '11:30 - 22:00', '없음', '주차공간없음', 'Y', '37.578565', '126.970643', '/static/12.jpg'),
	('13', '할아버지손칼국수', '상세설명없음', '서울시 중구 황학동 67', '010-6354-8999', '국수 / 면 요리', '월-금: 10:00 - 19:30 토-일: 10:00 - 20:10', '없음', '주차공간없음', 'Y', '37.570158', '127.019400', '/static/13.jpg'),
	('14', '키친우라와', '상세설명없음', '서울시 성동구 금호동1가 132-6', '010-3095-2352', '정통 일식 / 일반 일식', '12:00 - 20:30', '14:30 - 17:00', '주차공간없음', 'Y', '37.557758', '127.024362', '/static/14.jpg'),
	('15', '용삼계탕', '상세설명없음', '서울시 강남구 논현동 141-17', '02-548-2614', '탕 / 찌개 / 전골', '11:00 - 20:30', '없음', '주차공간없음', 'Y', '37.510904', '127.022926', '/static/15.jpg'),
	('16', '도취', '상세설명없음', '서울시 종로구 누상동 53-1', '02-723-1288', '퓨전 한식', '11:30 - 24:00', '16:00 - 18:00', '주차공간없음', 'Y', '37.580873', '126.967073', '/static/16.jpg'),
	('2', '까이식당', '메뉴\r\n치킨라이스 7,500원', '서울시 서대문구 대현동 53-9', '	070-7570-0871', '다국적 아시아 음식', '월- 금: 11:00 - 19:00 토: 11:00 - 14:00', '14:00 - 17:00', '주차공간없음', 'Y', '37.558432', '126.946245', '/static/2.jpg'),
	('3', '밥한끼', '상세설명없음', '서울시 용산구 한남동 72-17', '02-749-5999', '정통 일식 / 일반 일식', '11:30 - 21:30', '없음', '주차공간없음', 'Y', '37.533905', '127.007893', '/static/3.jpg'),
	('4', '장수보쌈', '상세설명없음', '서울시 중구 방산동 84-1', '02-2272-2971', '고기 요리', '11:30 - 22:30', '없음', '주차공간없음', 'Y', '37.568065', '127.002356', '/static/4.jpg'),
	('5', '형제돈부리', '상세설명없음', '서울시 강서구 마곡동 757', '02-6989-8686', '돈부리 / 일본 카레 / 벤토', '11:00 - 21:30', '없음', '유료주차 가능', 'Y', '37.568941', '126.827040', '/static/5.jpg'),
	('6', '홍릉각', '상세설명없음', '서울시 동대문구 제기동 838', '02-969-7787', '정통 중식 / 일반 중식', '12:00 - 17:00', '없음', '주차공간없음', 'Y', '37.582765', '127.040135', '/static/6.jpg'),
	('7', '잭슨피자', '상세설명없음', '서울시 강남구 신사동 574', '02-512-0717', '기타 양식', '09:00 ~ 22:00', '없음', '주차공간없음', 'Y', '37.524931', '127.024565', '/static/7.jpg'),
	('8', '닭꼬얌', '상세설명없음', '서울시 마포구 서교동 361-3', '02-322-3331', '한정식 / 백반 / 정통 한식', '11:30 - 24:00', '없음', '주차공간없음', 'Y', '37.551597', '126.923824', '/static/8.jpg'),
	('9', '멘텐', '상세설명없음', '서울시 중구 충무로2가 12-3', '없음', '라멘 / 소바 / 우동', '09:00 ~ 22:00', '없음', '주차공간없음', 'Y', '37.561956', '126.988575', '/static/9.jpg');
/*!40000 ALTER TABLE `pook_store` ENABLE KEYS */;

-- 테이블 pook.pook_user 구조 내보내기
DROP TABLE IF EXISTS `pook_user`;
CREATE TABLE IF NOT EXISTS `pook_user` (
  `user_id` varchar(100) NOT NULL COMMENT '사용자 ID',
  `nickname` varchar(100) DEFAULT NULL COMMENT '닉네임',
  `phone` varchar(15) DEFAULT NULL COMMENT '전화번호',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 pook.pook_user:~1 rows (대략적) 내보내기
/*!40000 ALTER TABLE `pook_user` DISABLE KEYS */;
INSERT INTO `pook_user` (`user_id`, `nickname`, `phone`) VALUES
	('af101280-e17f-35d7-b40d-0279887a6494', '홍박사', '010-0000-0000');
/*!40000 ALTER TABLE `pook_user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
