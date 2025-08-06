-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: task_management
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task` (
  `task_name` varchar(50) DEFAULT NULL,
  `created_dt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(1) DEFAULT '0',
  `priority` int DEFAULT '1',
  `id` int NOT NULL AUTO_INCREMENT,
  `userid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user` (`userid`),
  CONSTRAINT `fk_user` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT INTO `task` VALUES ('admin','2025-06-19 14:33:49',1,3,9,1),('newuser','2025-06-19 14:45:09',1,0,10,2),('user1','2025-06-19 14:45:24',1,1,11,3),('newusertask2','2025-06-20 11:14:35',1,3,12,2),('user1task2','2025-06-20 11:15:42',0,2,13,3),('admintask2','2025-06-20 11:16:19',0,2,14,1),('use3','2025-06-20 11:46:24',0,1,15,5),('newtask','2025-06-26 10:09:06',0,0,17,5);
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `username` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `passwd` varchar(255) DEFAULT NULL,
  `full_name` varchar(150) DEFAULT NULL,
  `userid` int NOT NULL AUTO_INCREMENT,
  `is_admin` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`userid`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('Harish','harish@gmai.com','scrypt:32768:8:1$3WhAAkDqw0W3Go4C$a265cbcccccf8ffb032e69663190055322ccd062e30a6680642d3bc50c710b65b6b892d5781cf9bea8025b04a34e758ac30d0d2803143f6aef006ce5e83b0ca6','Harish K',1,1),('newuser','new@emai.com','scrypt:32768:8:1$deZhV2PkJhxaPgMv$6ef0578e5fc2f7f3ec45536733768ab660cdb8866bfc91338fc8a049677bf2a78f7fdabbbfddaacebf659753b974542258435348396fb1b25df9eee99995ffa2','newuser',2,0),('user1','u@g.in','scrypt:32768:8:1$zF5GHaU2Or5H9SfA$ac185988f28b7caaf130ec7b521328ff094e2c45ca091110ce2ad5ec10c91fbb2db57d7a222f25bd18435bd0b00203bbec757b31aa661cb848c984ee8ccace34','q3f',3,0),('user2','1@g.in','scrypt:32768:8:1$hZcSNYEC9cAg1AHt$64c349eb6c816d1224aad0b783eed852899f7a416bf1033a7db43188b2a1507bb897be5577071aa77a8f97f4fcbd12edd186334bab78c41d6b813eaf9a045414','wqq',4,0),('user3','user@gmail.com','scrypt:32768:8:1$f2UDAZzXrjr5bKrh$eb35b81aa0fe7b4b565bb5df56ede635279681f39eac56a96913134e2fbaf7e4df1b5ea0db06a8c82c2bc5deee183bd6b5cb05c7326d8bc32c702cab839d6f3e','name',5,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-26 23:23:31
