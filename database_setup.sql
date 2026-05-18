-- MySQL dump 10.13  Distrib 9.7.0, for macos15 (arm64)
--
-- Host: localhost    Database: BOOKLEAFPROJECT_db
-- ------------------------------------------------------
-- Server version	9.7.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '063a0f3e-40df-11f1-a9f7-975e134522d8:1-620';

--
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authors` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `bio` text,
  `created_at` datetime(6) DEFAULT NULL,
  `image_url` varchar(500) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_m8xy00x64fkvxt9g4u1pfrmmr` (`user_id`),
  CONSTRAINT `FK6g6ireq6qd4nxohq9ldidxfin` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authors`
--

LOCK TABLES `authors` WRITE;
/*!40000 ALTER TABLE `authors` DISABLE KEYS */;
INSERT INTO `authors` VALUES (1,'The father of modern Sinhala literature, known for his realistic fiction and cultural essays.',NULL,NULL,'Martin Wickramasinghe',NULL),(2,'A legendary Sri Lankan playwright, novelist, and poet who revived Sinhala drama.',NULL,NULL,'Ediriweera Sarachchandra',NULL),(3,'A pioneer linguist, grammarian, and writer who founded the Hela Havula movement.',NULL,NULL,'Kumaratunga Munidasa',NULL),(4,'Renowned children\'s book author and illustrator, famous for \"Kuda Hora\".',NULL,NULL,'Sybil Wettasinghe',NULL),(5,'A beloved novelist and politician known for portraying rural life in Sri Lanka.',NULL,NULL,'T. B. Ilangaratne',NULL),(6,'A prominent contemporary novelist, poet, and social critic.',NULL,NULL,'Gunadasa Amarasekara',NULL),(8,'ghj','2026-05-12 17:45:03.644644',NULL,'du',6),(9,'','2026-05-12 17:56:15.537213',NULL,'ag',7),(10,'hj','2026-05-14 09:34:55.141566','https://boroktimes.com/wp-content/uploads/2023/07/channels4_profile.jpeg','gaya',8),(11,'','2026-05-15 07:04:11.739099',NULL,'ASDADA',12),(12,'sa','2026-05-17 07:42:36.719755','','sas',NULL),(14,'','2026-05-18 01:13:55.942927',NULL,'assas',15);
/*!40000 ALTER TABLE `authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `category` varchar(50) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `description` text,
  `has_ebook` bit(1) DEFAULT NULL,
  `image_url` varchar(500) DEFAULT NULL,
  `isbn` varchar(20) DEFAULT NULL,
  `price` double NOT NULL,
  `quantity` int NOT NULL,
  `title` varchar(200) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `author_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKfjixh2vym2cvfj3ufxj91jem7` (`author_id`),
  CONSTRAINT `FKfjixh2vym2cvfj3ufxj91jem7` FOREIGN KEY (`author_id`) REFERENCES `authors` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (1,'Classic',NULL,'A masterpiece depicting the breakdown of the traditional village life and the rise of the middle class.',_binary '','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQmLwGj9RRfWeS7gz58WuzIyJCFekwqVzG6Q&s','978-9551096001',850,36,'Gamperaliyaa','2026-05-18 08:14:11.229943',1),(2,'Adventure',NULL,'The classic adventure story of Upali and Jinna in a deserted island in Koggala.',_binary '','https://upload.wikimedia.org/wikipedia/en/5/5c/MadolDoova.jpg','978-9551096056',450,86,'Madol Doova','2026-05-18 01:05:57.929734',1),(3,'Novel',NULL,'A philosophical novel exploring human relationships and isolation in a Japanese setting.',_binary '\0','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR90GrtRXCdeOC6sY7A-UPh3T7aIWD5UagRKw&s','978-9551096100',600,26,'Malagiya Attho','2026-05-18 01:06:23.558335',4),(4,'Children',NULL,'A humorous and educational story written for children to improve their language skills.',_binary '','https://storage.googleapis.com/cdn_ashirwada/AshirwadaBooks/Product%20Images/9789556974911-9789556974911-9789556974911-hath-pana-cover.webp','978-9551234567',350,59,'Hath Pana','2026-05-17 16:12:04.483663',3),(5,'Children',NULL,'The internationally acclaimed children\'s story about an umbrella thief.',_binary '','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjErz861vwwjAFSwuUohWzUUrZDGtO3uPz6Q&s','978-9559511112',400,80,'Kuda Hora',NULL,4),(6,'Fiction',NULL,'A heartwarming story about the friendship between Sunil and Nimal amidst social struggles.',_binary '','https://upload.wikimedia.org/wikipedia/en/thumb/a/a6/Amba_Yaluwo.jpg/250px-Amba_Yaluwo.jpg','978-9555990101',550,50,'Amba Yaluwo','2026-05-17 16:12:42.895742',5),(7,'Drama',NULL,'A realistic portrayal of the hardships and complexities of rural farming life.',_binary '\0','https://cms.sarasavi.lk/storage/product/9%20789550%20955596.jpg','978-9559000021',700,25,'Karumakkarayo','2026-05-17 16:12:56.773122',6),(8,'Classic',NULL,'Considered the greatest psychological novel in Sinhala literature, focusing on the character Aravinda.',_binary '','https://upload.wikimedia.org/wikipedia/en/3/3e/Viragaya_novel.jpg','978-9551096002',950,35,'Viragaya','2026-05-17 16:13:11.364437',1);
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discounts`
--

DROP TABLE IF EXISTS `discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discounts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `active` bit(1) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `description` text,
  `discount_type` enum('SEASONAL','NEW_USER_BONUS','PRICE_CAP') NOT NULL,
  `end_date` date DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `percentage` double NOT NULL,
  `price_cap` double DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discounts`
--

LOCK TABLES `discounts` WRITE;
/*!40000 ALTER TABLE `discounts` DISABLE KEYS */;
INSERT INTO `discounts` VALUES (2,_binary '','2026-05-12 10:20:50.648649','','SEASONAL','2026-05-06','msasasdds',50,NULL,NULL,'2026-05-17 07:43:30.479280'),(3,_binary '','2026-05-12 10:21:13.441774','d','PRICE_CAP',NULL,'dsds',50,1000,NULL,'2026-05-12 10:21:13.441805'),(4,_binary '','2026-05-15 07:05:59.495052','ws','PRICE_CAP',NULL,'saa',60,500,NULL,'2026-05-15 07:05:59.495163'),(5,_binary '','2026-05-17 07:43:56.755675','ds','SEASONAL','2026-05-17','dsds',3,NULL,'2026-05-15','2026-05-17 07:43:56.755801');
/*!40000 ALTER TABLE `discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `is_read` bit(1) NOT NULL,
  `message` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `user_id` bigint NOT NULL,
  `target_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9y21adhxn0ayjhfocscqox7bh` (`user_id`),
  CONSTRAINT `FK9y21adhxn0ayjhfocscqox7bh` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,'2026-05-14 19:31:17.104077',_binary '','Admin has replied to your review for \'Gamperaliyaa\'.','REVIEW_REPLY',1,NULL),(2,'2026-05-14 19:31:38.050215',_binary '','Admin has replied to your review for \'Gamperaliyaa\'.','REVIEW_REPLY',1,NULL),(3,'2026-05-14 19:32:55.284020',_binary '','Admin has replied to your query regarding \'hdid\'.','QUERY_REPLY',1,NULL),(4,'2026-05-14 20:06:28.198719',_binary '\0','Admin has replied to your query regarding \'jj\'.','QUERY_REPLY',9,'/queries'),(5,'2026-05-14 20:06:32.548527',_binary '\0','Admin has replied to your query regarding \'jj\'.','QUERY_REPLY',9,'/queries'),(6,'2026-05-14 20:06:38.249977',_binary '\0','Admin has replied to your query regarding \'jj\'.','QUERY_REPLY',9,'/queries'),(7,'2026-05-14 20:06:44.148777',_binary '','Admin has replied to your review for \'Madol Doova\'.','REVIEW_REPLY',1,'/book/2'),(8,'2026-05-14 20:06:47.783567',_binary '','Admin has replied to your review for \'Madol Doova\'.','REVIEW_REPLY',1,'/book/2'),(9,'2026-05-14 20:06:53.416246',_binary '','Admin has replied to your review for \'Madol Doova\'.','REVIEW_REPLY',1,'/book/2'),(10,'2026-05-14 20:18:42.694305',_binary '','Admin has replied to your query regarding \'j\'.','QUERY_REPLY',11,'/queries'),(11,'2026-05-15 07:02:40.817779',_binary '','Your order #7 is now PROCESSING.','ORDER_UPDATE',1,'/orders'),(12,'2026-05-15 07:02:53.045295',_binary '','Your order #7 is now EMAIL_SENT.','ORDER_UPDATE',1,'/orders'),(13,'2026-05-15 07:04:41.624086',_binary '','Admin has replied to your review for \'Madol Doova\'.','REVIEW_REPLY',1,'/book/2'),(14,'2026-05-15 07:05:22.699702',_binary '','Admin has replied to your review for \'Madol Doova\'.','REVIEW_REPLY',1,'/book/2'),(15,'2026-05-17 07:42:44.685950',_binary '','Your order #6 is now CANCELLED.','ORDER_UPDATE',1,'/orders'),(16,'2026-05-17 07:42:44.954492',_binary '','Your order #6 is now CANCELLED.','ORDER_UPDATE',1,'/orders'),(17,'2026-05-17 07:42:47.720795',_binary '','Your order #7 is now OUT_FOR_DELIVERY.','ORDER_UPDATE',1,'/orders'),(18,'2026-05-17 07:43:06.836997',_binary '','Admin has replied to your review for \'Madol Doova\'.','REVIEW_REPLY',1,'/book/2'),(19,'2026-05-17 07:43:13.465283',_binary '','Admin has replied to your review for \'Madol Doova\'.','REVIEW_REPLY',1,'/book/2'),(20,'2026-05-17 07:44:04.024272',_binary '','Admin has replied to your query regarding \'hi \'.','QUERY_REPLY',1,'/queries'),(21,'2026-05-17 08:35:18.718400',_binary '','Admin has replied to your review for \'prema dadayamaaa\'.','REVIEW_REPLY',1,'/book/9'),(22,'2026-05-18 01:10:38.531514',_binary '\0','Your order #1 is now SHIPPED.','ORDER_UPDATE',1,'/orders'),(23,'2026-05-18 01:10:41.637934',_binary '\0','Your order #12 is now OUT_FOR_DELIVERY.','ORDER_UPDATE',1,'/orders'),(24,'2026-05-18 01:10:48.288894',_binary '\0','Your order #11 is now DELIVERED.','ORDER_UPDATE',1,'/orders'),(25,'2026-05-18 08:00:50.338739',_binary '\0','Admin has replied to your query regarding \'payment issue \'.','QUERY_REPLY',16,'/queries'),(26,'2026-05-18 08:02:38.894919',_binary '\0','Admin has replied to your query regarding \'payment issue \'.','QUERY_REPLY',16,'/queries'),(27,'2026-05-18 08:09:12.500589',_binary '\0','Admin has replied to your query regarding \'pdowidk\'.','QUERY_REPLY',17,'/queries'),(28,'2026-05-18 08:11:46.720082',_binary '\0','Your order #13 is now PROCESSING.','ORDER_UPDATE',17,'/orders'),(29,'2026-05-18 08:12:06.967134',_binary '\0','Your order #13 is now SHIPPED.','ORDER_UPDATE',17,'/orders'),(30,'2026-05-18 08:12:19.260548',_binary '\0','Your order #13 is now EMAIL_SENT.','ORDER_UPDATE',17,'/orders'),(31,'2026-05-18 08:12:26.950778',_binary '\0','Your order #13 is now CANCELLED.','ORDER_UPDATE',17,'/orders'),(32,'2026-05-18 08:12:37.688607',_binary '\0','Your order #13 is now EMAIL_SENT.','ORDER_UPDATE',17,'/orders'),(33,'2026-05-18 08:15:12.854741',_binary '\0','Your order #14 is now DELIVERED.','ORDER_UPDATE',17,'/orders'),(34,'2026-05-18 09:28:25.578614',_binary '\0','Admin has replied to your query regarding \'fdf\'.','QUERY_REPLY',1,'/queries');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `format` varchar(20) DEFAULT NULL,
  `quantity` int NOT NULL,
  `unit_price` double NOT NULL,
  `book_id` bigint NOT NULL,
  `order_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKi4ptndslo2pyfp9r1x0eulh9g` (`book_id`),
  KEY `FKbioxgbv59vetrxe0ejfubep1w` (`order_id`),
  CONSTRAINT `FKbioxgbv59vetrxe0ejfubep1w` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `FKi4ptndslo2pyfp9r1x0eulh9g` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,'HARDCOPY',3,14.99,3,1),(2,'HARDCOPY',1,18.99,5,1),(3,'HARDCOPY',1,22.99,8,2),(4,'HARDCOPY',1,600,3,3),(5,'HARDCOPY',1,850,1,4),(6,'HARDCOPY',7,450,2,5),(7,'EBOOK',2,280,4,6),(8,'HARDCOPY',2,600,3,7),(9,'HARDCOPY',4,450,2,8),(10,'EBOOK',1,320,5,8),(11,'HARDCOPY',1,350,4,9),(12,'HARDCOPY',3,450,2,10),(13,'HARDCOPY',1,600,3,11),(14,'HARDCOPY',1,850,1,12),(15,'HARDCOPY',1,850,1,13),(16,'HARDCOPY',1,850,1,14);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `order_status` varchar(50) DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `total_amount` double NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK32ql8ubntj5uh44ph9659tiih` (`user_id`),
  CONSTRAINT `FK32ql8ubntj5uh44ph9659tiih` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'2026-05-02 05:14:22.813931','SHIPPED','CARD',63.959999999999994,1),(2,'2026-05-02 05:15:03.179244','DELIVERED','BANK_SLIP',22.99,1),(3,'2026-05-12 10:20:11.696044','PENDING','CARD',570,4),(4,'2026-05-13 15:03:32.599073','CANCELLED','BANK_SLIP',850,1),(5,'2026-05-14 09:41:26.910072','CONFIRMED','CARD',1575,1),(6,'2026-05-14 10:52:45.791720','CANCELLED','BANK_SLIP',560,1),(7,'2026-05-15 07:01:20.225743','OUT_FOR_DELIVERY','CARD',600,1),(8,'2026-05-17 13:53:29.426438','CONFIRMED','CARD',848,1),(9,'2026-05-17 13:53:53.386711','CONFIRMED','BANK_SLIP',339.5,1),(10,'2026-05-18 01:05:57.952945','CONFIRMED','CARD',540,1),(11,'2026-05-18 01:06:23.577945','DELIVERED','CARD',240,1),(12,'2026-05-18 01:10:00.162228','OUT_FOR_DELIVERY','CARD',340,1),(13,'2026-05-18 08:11:13.305204','EMAIL_SENT','CARD',340,17),(14,'2026-05-18 08:14:11.260003','DELIVERED','CARD',340,17);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queries`
--

DROP TABLE IF EXISTS `queries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `queries` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `admin_reply` text,
  `message` text NOT NULL,
  `status` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKmukw2d0onfeb63a01yj56gov7` (`user_id`),
  CONSTRAINT `FKmukw2d0onfeb63a01yj56gov7` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queries`
--

LOCK TABLES `queries` WRITE;
/*!40000 ALTER TABLE `queries` DISABLE KEYS */;
INSERT INTO `queries` VALUES (1,'2026-05-14 19:32:38.589260','dsd','dd','ANSWERED','hdid',1),(5,'2026-05-18 07:58:23.515216',NULL,'dusdgsisbjchgs','ANSWERED','payment issue ',16),(6,'2026-05-18 08:07:12.140306',NULL,'isjdkha7sa','ANSWERED','pdowidk',17),(7,'2026-05-18 09:27:32.918065',NULL,'fd','ANSWERED','fdf',1);
/*!40000 ALTER TABLE `queries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `query_messages`
--

DROP TABLE IF EXISTS `query_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `query_messages` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `message` text NOT NULL,
  `query_id` bigint NOT NULL,
  `sender_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7l3vu8m6auijkht7shqdfbhep` (`query_id`),
  KEY `FKmoucevf28peabhtwys05nvvyq` (`sender_id`),
  CONSTRAINT `FK7l3vu8m6auijkht7shqdfbhep` FOREIGN KEY (`query_id`) REFERENCES `queries` (`id`),
  CONSTRAINT `FKmoucevf28peabhtwys05nvvyq` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `query_messages`
--

LOCK TABLES `query_messages` WRITE;
/*!40000 ALTER TABLE `query_messages` DISABLE KEYS */;
INSERT INTO `query_messages` VALUES (8,'2026-05-18 08:00:50.323016','hari ahriug',5,9),(9,'2026-05-18 08:02:30.169598','hiii',5,16),(10,'2026-05-18 08:02:38.889719','ijhih\r\n',5,9),(11,'2026-05-18 08:09:12.479145','ok\r\n',6,9),(12,'2026-05-18 09:28:25.538910','ewe',7,9);
/*!40000 ALTER TABLE `query_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `comment` text,
  `created_at` datetime(6) DEFAULT NULL,
  `rating` int NOT NULL,
  `book_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `admin_reply` text,
  PRIMARY KEY (`id`),
  KEY `FK6a9k6xvev80se5rreqvuqr7f9` (`book_id`),
  KEY `FKcgy7qjc1r99dp117y9en6lxye` (`user_id`),
  CONSTRAINT `FK6a9k6xvev80se5rreqvuqr7f9` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`),
  CONSTRAINT `FKcgy7qjc1r99dp117y9en6lxye` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,'amma meka supiri','2026-05-02 05:12:01.442043',5,2,1,'owow\r\nddssasaasa'),(2,'baya hithenawa','2026-05-02 05:12:52.321925',5,2,1,NULL),(5,'good','2026-05-15 07:05:06.534850',5,2,1,'thanks\r\nwqw');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `role` enum('ADMIN','CUSTOMER','AUTHOR') NOT NULL DEFAULT 'CUSTOMER',
  `updated_at` datetime(6) DEFAULT NULL,
  `approved` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_6dotkott2kjsp8vw4d0m25fb7` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'94/1 Sirisewana','2026-05-02 05:03:32.511030','danjanapersonal@gmail.com','eeeDulara Anjanaahaha','$2a$10$4hu1WQ5vZ9UtEXRPVDIq2.JkjmgFNnIMBSOk9XO4.DCYpHRnpPNJW','eew+94763834336','CUSTOMER','2026-05-17 13:59:38.687459',_binary '\0'),(2,'94/1 Sirisewana',NULL,'rashin@gmail.com','rashin','$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy','0763834336','CUSTOMER','2026-05-02 14:12:58.999064',_binary '\0'),(3,'sa','2026-05-02 05:29:44.937079','sasas@gmail.com','kaokal','$2a$10$tO87RKivsPR3bJEGU6WpAeXu.LOAaNt8T.ReVsA3mudRp2lscVkh6','019922','CUSTOMER','2026-05-02 05:29:44.937547',_binary '\0'),(4,'sasaa','2026-05-12 10:17:03.928219','anjana@gmail.com','anjana','$2a$10$t3470fJwyXO5MWW08lFAvuwfUYZFoSySjwCqIlQegr.53m4NwrcXm','9876678767','CUSTOMER','2026-05-12 10:17:03.928231',_binary '\0'),(6,'','2026-05-12 17:45:03.637626','du@gmail.com','du','$2a$10$4oEJtIVH7voEVi2y.7F3Y.ZfbIFMagmnIcfGPVfAGp7VVBrO7uooW','2345678','AUTHOR','2026-05-12 17:46:17.172300',_binary ''),(7,'','2026-05-12 17:56:15.532689','a@g.com','ag','$2a$10$O4QC/cB7zOZAwOx/RBZDhut8SAy/9jvkeGue2nhyIFvvU/J3XWcey','123456789','AUTHOR','2026-05-12 18:00:30.020500',_binary ''),(8,'hsd','2026-05-14 09:34:55.132181','gaya@gmail.com','gaya','$2a$10$BfkeEfTzXbxqR0B77DWnMOLKP.OfcjZ8B6uCxUUEJOlAXzv8lH1..','1234567890','AUTHOR','2026-05-14 09:35:55.642143',_binary ''),(9,NULL,'2026-05-14 20:02:03.286913','admin@gmail.com','Administrator','$2a$10$hcn0u/ha/em226z8ry6Qsu7IioRLTMa8J4BZaRPHQ8R4m5Z7ciQ1m',NULL,'ADMIN','2026-05-14 20:06:10.020848',_binary ''),(10,'6','2026-05-14 20:16:31.613042','g@gmail.com','uu','$2a$10$c2vAAQ6F.rVTrHOz4FfzEezWwoLaN6I23EeZUK3.LXGGRbC8gv1we','567','CUSTOMER','2026-05-14 20:16:31.613518',_binary ''),(11,'','2026-05-14 20:17:43.694671','11@gmail.com','sss','$2a$10$aJzeOsAG/XUqXxOX9OI/5eLF8VC.GGgP4VQoyrh0uwZ7HKI6U3MDG','12','CUSTOMER','2026-05-14 20:17:43.694685',_binary ''),(12,'','2026-05-15 07:04:11.733793','dd@gmail.com','ASDADA','$2a$10$hBWhRmJbzkpp8swK28L3hOB.2sFtjrLoD8EYYdbpKt5KOT1OhNWVW','22','AUTHOR','2026-05-17 07:43:01.168895',_binary ''),(13,'sa','2026-05-17 13:50:24.281491','sd@gmauk.vo','dsdsd','$2a$10$.rxdgm7cjh5HueiEVHCvKeOFuMbVuRajHpHwZZGVc2PgLaUrVm8Hq','sa2','CUSTOMER','2026-05-17 13:50:24.281531',_binary ''),(15,'','2026-05-18 01:13:55.933567','as@gmail.com','as','$2a$10$A6qPv5uc9NONnrux71UVt.nvU0mUa.PWgZB9nHugfn9HcNFGlcCSq','','AUTHOR','2026-05-18 01:14:15.289127',_binary ''),(16,'3','2026-05-18 07:57:08.264135','uda@gmial.com','udayangani','$2a$10$Wc04nsYDolV/gvArMrZrtesplmMVeq7cUOHNJla8vC7YJYJtGe.Kq','2','CUSTOMER','2026-05-18 07:57:08.264156',_binary ''),(17,'','2026-05-18 08:05:28.866869','gaya1@gmail.com','Gayathri','$2a$10$/thZ5RFApzySSF2IKan8m.YNnHM/6eeUIy4XB8A0tgMf3lepCdA6O','','CUSTOMER','2026-05-18 08:05:28.866888',_binary '');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlist_items`
--

DROP TABLE IF EXISTS `wishlist_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlist_items` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `added_at` datetime(6) DEFAULT NULL,
  `book_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK59s7r7fv02dh66lx97vvmg0xb` (`book_id`),
  KEY `FKmmj2k1i459yu449k3h1vx5abp` (`user_id`),
  CONSTRAINT `FK59s7r7fv02dh66lx97vvmg0xb` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`),
  CONSTRAINT `FKmmj2k1i459yu449k3h1vx5abp` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlist_items`
--

LOCK TABLES `wishlist_items` WRITE;
/*!40000 ALTER TABLE `wishlist_items` DISABLE KEYS */;
INSERT INTO `wishlist_items` VALUES (1,'2026-05-12 10:17:33.371347',1,4),(2,'2026-05-12 10:17:46.347324',3,4),(14,'2026-05-18 01:12:27.136944',4,11),(15,'2026-05-18 01:13:08.561395',2,1);
/*!40000 ALTER TABLE `wishlist_items` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-18 20:10:33
