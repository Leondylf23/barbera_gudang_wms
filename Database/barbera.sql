/*
 Navicat Premium Data Transfer

 Source Server         : localdocker
 Source Server Type    : MySQL
 Source Server Version : 80100
 Source Host           : localhost:3306
 Source Schema         : barbera

 Target Server Type    : MySQL
 Target Server Version : 80100
 File Encoding         : 65001

 Date: 13/12/2023 18:36:10
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cmt_master
-- ----------------------------
DROP TABLE IF EXISTS `cmt_master`;
CREATE TABLE `cmt_master`  (
  `id_cmt` bigint NOT NULL AUTO_INCREMENT,
  `nama_cmt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `alamat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `telp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `is_active` tinyint NULL DEFAULT 1,
  `created_date` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cmt`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`  (
  `id_customer` bigint NOT NULL AUTO_INCREMENT,
  `id_toko` bigint NULL DEFAULT NULL,
  `nama_customer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kota` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `alamat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `telp` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `cargo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nama_pic` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kontak_pic` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `keterangan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_date` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `is_active` tinyint NULL DEFAULT NULL,
  PRIMARY KEY (`id_customer`) USING BTREE,
  INDEX `cst_to_tko`(`id_toko` ASC) USING BTREE,
  CONSTRAINT `cst_to_tko` FOREIGN KEY (`id_toko`) REFERENCES `toko` (`id_toko`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for harga
-- ----------------------------
DROP TABLE IF EXISTS `harga`;
CREATE TABLE `harga`  (
  `id_harga` bigint NOT NULL AUTO_INCREMENT,
  `item_id` bigint NULL DEFAULT NULL,
  `harga` decimal(10, 2) NULL DEFAULT NULL,
  `created_date` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_harga`) USING BTREE,
  INDEX `hrg_to_item`(`item_id` ASC) USING BTREE,
  CONSTRAINT `hrg_to_item` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for item
-- ----------------------------
DROP TABLE IF EXISTS `item`;
CREATE TABLE `item`  (
  `item_id` bigint NOT NULL AUTO_INCREMENT,
  `jenis_id` int NULL DEFAULT NULL,
  `serial` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nama_item` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `harga_jual` double NULL DEFAULT NULL,
  `location` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `lot` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ukuran` tinyint NULL DEFAULT NULL,
  `created_date` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint NULL DEFAULT NULL,
  `modified_date` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `modified_by` bigint NULL DEFAULT NULL,
  `is_active` tinyint NULL DEFAULT 1,
  PRIMARY KEY (`item_id`) USING BTREE,
  INDEX `itm_to_jenis`(`jenis_id` ASC) USING BTREE,
  INDEX `itm_to_usr`(`created_by` ASC) USING BTREE,
  INDEX `itm_to_usr_mdf`(`modified_by` ASC) USING BTREE,
  CONSTRAINT `itm_to_jenis` FOREIGN KEY (`jenis_id`) REFERENCES `jenis` (`jenis_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `itm_to_usr` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `itm_to_usr_mdf` FOREIGN KEY (`modified_by`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for jenis
-- ----------------------------
DROP TABLE IF EXISTS `jenis`;
CREATE TABLE `jenis`  (
  `jenis_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `initial_jenis` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `is_active` tinyint NULL DEFAULT 1,
  `created_date` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`jenis_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for return_cmt_detail
-- ----------------------------
DROP TABLE IF EXISTS `return_cmt_detail`;
CREATE TABLE `return_cmt_detail`  (
  `id_return_cmt_detail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `id_cmt_return_header` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `id_item` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `qty` int NULL DEFAULT NULL,
  `harga_jual` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `harga_total` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for return_cmt_header
-- ----------------------------
DROP TABLE IF EXISTS `return_cmt_header`;
CREATE TABLE `return_cmt_header`  (
  `id_return_cmt` bigint NOT NULL AUTO_INCREMENT,
  `id_cmt` bigint NULL DEFAULT NULL,
  `no_nota` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `total_qty` int NULL DEFAULT NULL,
  `subtotal` double NULL DEFAULT NULL,
  `notes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `staff_1` bigint NULL DEFAULT NULL,
  `staff_2` bigint NULL DEFAULT NULL,
  `created_date` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint NULL DEFAULT NULL,
  `is_active` tinyint NULL DEFAULT 1,
  PRIMARY KEY (`id_return_cmt`) USING BTREE,
  INDEX `cmtrt_to_cmt`(`id_cmt` ASC) USING BTREE,
  INDEX `cmtrt_to_usr`(`created_by` ASC) USING BTREE,
  INDEX `cmtrt_to_usr_stf1`(`staff_1` ASC) USING BTREE,
  INDEX `cmtrt_to_usr_stf2`(`staff_2` ASC) USING BTREE,
  CONSTRAINT `cmtrt_to_cmt` FOREIGN KEY (`id_cmt`) REFERENCES `cmt_master` (`id_cmt`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cmtrt_to_usr` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cmtrt_to_usr_stf1` FOREIGN KEY (`staff_1`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cmtrt_to_usr_stf2` FOREIGN KEY (`staff_2`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for return_cust_detail
-- ----------------------------
DROP TABLE IF EXISTS `return_cust_detail`;
CREATE TABLE `return_cust_detail`  (
  `id_return_cust_detail` bigint NOT NULL AUTO_INCREMENT,
  `id_return_cust_header` bigint NULL DEFAULT NULL,
  `id_item` bigint NULL DEFAULT NULL,
  `qty` int NULL DEFAULT NULL,
  `harga_jual` double NULL DEFAULT NULL,
  `harga_total` double NULL DEFAULT NULL,
  PRIMARY KEY (`id_return_cust_detail`) USING BTREE,
  INDEX `rtncstdtl_to_rtncsthd`(`id_return_cust_header` ASC) USING BTREE,
  INDEX `rtncstdtl_to_rtncst`(`id_item` ASC) USING BTREE,
  CONSTRAINT `rtncstdtl_to_rtncst` FOREIGN KEY (`id_item`) REFERENCES `item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rtncstdtl_to_rtncsthd` FOREIGN KEY (`id_return_cust_header`) REFERENCES `return_cust_header` (`return_cust_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for return_cust_header
-- ----------------------------
DROP TABLE IF EXISTS `return_cust_header`;
CREATE TABLE `return_cust_header`  (
  `return_cust_id` bigint NOT NULL AUTO_INCREMENT,
  `id_toko` bigint NULL DEFAULT NULL,
  `id_customer` bigint NULL DEFAULT NULL,
  `customer_type` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `no_nota` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `total_qty` int NULL DEFAULT NULL,
  `subtotal` double NULL DEFAULT NULL,
  `notes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `staff_1` bigint NULL DEFAULT NULL,
  `staff_2` bigint NULL DEFAULT NULL,
  `created_by` bigint NULL DEFAULT NULL,
  `created_date` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `is_active` tinyint NULL DEFAULT 1,
  PRIMARY KEY (`return_cust_id`) USING BTREE,
  INDEX `rtncst_to_toko`(`id_toko` ASC) USING BTREE,
  INDEX `rtncst_to_cst`(`id_customer` ASC) USING BTREE,
  INDEX `rtncst_to_usr_stf1`(`staff_1` ASC) USING BTREE,
  INDEX `rtncst_to_usr_stf2`(`staff_2` ASC) USING BTREE,
  INDEX `rtncst_to_usr`(`created_by` ASC) USING BTREE,
  CONSTRAINT `rtncst_to_cst` FOREIGN KEY (`id_customer`) REFERENCES `customer` (`id_customer`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rtncst_to_toko` FOREIGN KEY (`id_toko`) REFERENCES `toko` (`id_toko`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rtncst_to_usr` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rtncst_to_usr_stf1` FOREIGN KEY (`staff_1`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rtncst_to_usr_stf2` FOREIGN KEY (`staff_2`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `permission` json NULL,
  `is_acitve` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_date` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for stock_track
-- ----------------------------
DROP TABLE IF EXISTS `stock_track`;
CREATE TABLE `stock_track`  (
  `id_stock_track` bigint NOT NULL AUTO_INCREMENT,
  `id_item` bigint NULL DEFAULT NULL,
  `id_stok` bigint NULL DEFAULT NULL,
  `qty` int NULL DEFAULT NULL,
  `stock_qty` int NULL DEFAULT NULL,
  `created_date` datetime NULL DEFAULT NULL,
  `is_active` tinyint NULL DEFAULT NULL,
  PRIMARY KEY (`id_stock_track`) USING BTREE,
  INDEX `stktrk_to_itm`(`id_item` ASC) USING BTREE,
  INDEX `stktrk_to_stk`(`id_stok` ASC) USING BTREE,
  CONSTRAINT `stktrk_to_itm` FOREIGN KEY (`id_item`) REFERENCES `item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stktrk_to_stk` FOREIGN KEY (`id_stok`) REFERENCES `stok_item` (`id_stok`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for stok_item
-- ----------------------------
DROP TABLE IF EXISTS `stok_item`;
CREATE TABLE `stok_item`  (
  `id_stok` bigint NOT NULL AUTO_INCREMENT,
  `id_item` bigint NULL DEFAULT NULL,
  `qty` int NULL DEFAULT NULL,
  `is_active` tinyint NULL DEFAULT 1,
  `created_date` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id_stok`) USING BTREE,
  INDEX `stk_to_itm`(`id_item` ASC) USING BTREE,
  CONSTRAINT `stk_to_itm` FOREIGN KEY (`id_item`) REFERENCES `item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for toko
-- ----------------------------
DROP TABLE IF EXISTS `toko`;
CREATE TABLE `toko`  (
  `id_toko` bigint NOT NULL AUTO_INCREMENT,
  `nama_toko` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `alamat_toko` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `telp` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `is_active` tinyint NULL DEFAULT 1,
  PRIMARY KEY (`id_toko`) USING BTREE,
  INDEX `id_toko`(`id_toko` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for transaksi_cmt_detail
-- ----------------------------
DROP TABLE IF EXISTS `transaksi_cmt_detail`;
CREATE TABLE `transaksi_cmt_detail`  (
  `id_transaksi_cmt_detail` bigint NOT NULL AUTO_INCREMENT,
  `id_transaksi_cmt_header` bigint NULL DEFAULT NULL,
  `id_item` bigint NULL DEFAULT NULL,
  `qty` int NULL DEFAULT NULL,
  `harga_jual` double NULL DEFAULT NULL,
  `total_harga` double NULL DEFAULT NULL,
  PRIMARY KEY (`id_transaksi_cmt_detail`) USING BTREE,
  INDEX `trxcmtdt_to_itm`(`id_item` ASC) USING BTREE,
  INDEX `trxcmtdt_to_trxtoko`(`id_transaksi_cmt_header` ASC) USING BTREE,
  CONSTRAINT `trxcmtdt_to_itm` FOREIGN KEY (`id_item`) REFERENCES `item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `trxcmtdt_to_trxtoko` FOREIGN KEY (`id_transaksi_cmt_header`) REFERENCES `transaksi_cmt_header` (`id_transaksi_cmt`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for transaksi_cmt_header
-- ----------------------------
DROP TABLE IF EXISTS `transaksi_cmt_header`;
CREATE TABLE `transaksi_cmt_header`  (
  `id_transaksi_cmt` bigint NOT NULL AUTO_INCREMENT,
  `id_cmt` bigint NULL DEFAULT NULL,
  `no_nota` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `total_qty` int NULL DEFAULT NULL,
  `subtotal_harga` double(10, 2) NULL DEFAULT NULL,
  `staff_1` bigint NULL DEFAULT NULL,
  `staff_2` bigint NULL DEFAULT NULL,
  `penerima` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_date` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint NULL DEFAULT NULL,
  `is_active` tinyint NULL DEFAULT NULL,
  PRIMARY KEY (`id_transaksi_cmt`) USING BTREE,
  INDEX `trxtoko_to_toko`(`id_cmt` ASC) USING BTREE,
  INDEX `trxcmt_to_usr`(`created_by` ASC) USING BTREE,
  INDEX `trxcmt_to_usr_stf1`(`staff_1` ASC) USING BTREE,
  INDEX `trxcmt_to_usr_stf2`(`staff_2` ASC) USING BTREE,
  CONSTRAINT `trxcmt_to_cmt` FOREIGN KEY (`id_cmt`) REFERENCES `cmt_master` (`id_cmt`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `trxcmt_to_usr` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `trxcmt_to_usr_stf1` FOREIGN KEY (`staff_1`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `trxcmt_to_usr_stf2` FOREIGN KEY (`staff_2`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for transaksi_cust_detail
-- ----------------------------
DROP TABLE IF EXISTS `transaksi_cust_detail`;
CREATE TABLE `transaksi_cust_detail`  (
  `id_transaksi_cust_detail` bigint NOT NULL AUTO_INCREMENT,
  `id_transaksi_cust_header` bigint NULL DEFAULT NULL,
  `id_item` bigint NULL DEFAULT NULL,
  `qty` int NULL DEFAULT NULL,
  `harga_jual` double NULL DEFAULT NULL,
  `total_harga` double NULL DEFAULT NULL,
  `total_markup_harga` double NULL DEFAULT NULL,
  PRIMARY KEY (`id_transaksi_cust_detail`) USING BTREE,
  INDEX `trxcstdtl_to_trxcsthd`(`id_transaksi_cust_header` ASC) USING BTREE,
  INDEX `trxcstdtl_to_itm`(`id_item` ASC) USING BTREE,
  CONSTRAINT `trxcstdtl_to_itm` FOREIGN KEY (`id_item`) REFERENCES `item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `trxcstdtl_to_trxcsthd` FOREIGN KEY (`id_transaksi_cust_header`) REFERENCES `transaksi_cust_header` (`id_transaksi_customer`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for transaksi_cust_header
-- ----------------------------
DROP TABLE IF EXISTS `transaksi_cust_header`;
CREATE TABLE `transaksi_cust_header`  (
  `id_transaksi_customer` bigint NOT NULL AUTO_INCREMENT,
  `id_toko` bigint NULL DEFAULT NULL,
  `id_customer` bigint NULL DEFAULT NULL,
  `customer_type` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `no_nota` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `total_qty` int NULL DEFAULT NULL,
  `subtotal_markup` double NULL DEFAULT NULL,
  `subtotal` double NULL DEFAULT NULL,
  `diskon` double NULL DEFAULT NULL,
  `tax` double NULL DEFAULT NULL,
  `total_retur` double NULL DEFAULT NULL,
  `pengirim` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `staff_1` bigint NULL DEFAULT NULL,
  `staff_2` bigint NULL DEFAULT NULL,
  `notes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_date` datetime NULL DEFAULT NULL,
  `created_by` bigint NULL DEFAULT NULL,
  `is_active` tinyint NULL DEFAULT NULL,
  PRIMARY KEY (`id_transaksi_customer`) USING BTREE,
  INDEX `trscst_to_cst`(`id_customer` ASC) USING BTREE,
  INDEX `trscst_to_tko`(`id_toko` ASC) USING BTREE,
  INDEX `trscst_to_usr_stf1`(`staff_1` ASC) USING BTREE,
  INDEX `trscst_to_usr_stf2`(`staff_2` ASC) USING BTREE,
  INDEX `trscst_to_usr`(`created_by` ASC) USING BTREE,
  CONSTRAINT `trscst_to_cst` FOREIGN KEY (`id_customer`) REFERENCES `customer` (`id_customer`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `trscst_to_tko` FOREIGN KEY (`id_toko`) REFERENCES `toko` (`id_toko`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `trscst_to_usr` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `trscst_to_usr_stf1` FOREIGN KEY (`staff_1`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `trscst_to_usr_stf2` FOREIGN KEY (`staff_2`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `role` int NULL DEFAULT NULL,
  `is_active` tinyint NULL DEFAULT 1,
  PRIMARY KEY (`user_id`) USING BTREE,
  INDEX `usr_to_role`(`role` ASC) USING BTREE,
  CONSTRAINT `usr_to_role` FOREIGN KEY (`role`) REFERENCES `roles` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
