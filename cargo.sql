-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 10, 2023 at 09:55 AM
-- Server version: 8.0.30
-- PHP Version: 7.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cargo`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add content type', 4, 'add_contenttype'),
(14, 'Can change content type', 4, 'change_contenttype'),
(15, 'Can delete content type', 4, 'delete_contenttype'),
(16, 'Can view content type', 4, 'view_contenttype'),
(17, 'Can add session', 5, 'add_session'),
(18, 'Can change session', 5, 'change_session'),
(19, 'Can delete session', 5, 'delete_session'),
(20, 'Can view session', 5, 'view_session'),
(21, 'Can add user', 6, 'add_user'),
(22, 'Can change user', 6, 'change_user'),
(23, 'Can delete user', 6, 'delete_user'),
(24, 'Can view user', 6, 'view_user'),
(25, 'Can add category', 7, 'add_category'),
(26, 'Can change category', 7, 'change_category'),
(27, 'Can delete category', 7, 'delete_category'),
(28, 'Can view category', 7, 'view_category'),
(29, 'Can add profile', 8, 'add_profile'),
(30, 'Can change profile', 8, 'change_profile'),
(31, 'Can delete profile', 8, 'delete_profile'),
(32, 'Can view profile', 8, 'view_profile'),
(33, 'Can add biaya', 9, 'add_biaya'),
(34, 'Can change biaya', 9, 'change_biaya'),
(35, 'Can delete biaya', 9, 'delete_biaya'),
(36, 'Can view biaya', 9, 'view_biaya'),
(37, 'Can add biaya jarak', 10, 'add_biayajarak'),
(38, 'Can change biaya jarak', 10, 'change_biayajarak'),
(39, 'Can delete biaya jarak', 10, 'delete_biayajarak'),
(40, 'Can view biaya jarak', 10, 'view_biayajarak'),
(41, 'Can add payment status', 11, 'add_paymentstatus'),
(42, 'Can change payment status', 11, 'change_paymentstatus'),
(43, 'Can delete payment status', 11, 'delete_paymentstatus'),
(44, 'Can view payment status', 11, 'view_paymentstatus');

-- --------------------------------------------------------

--
-- Table structure for table `cargo_app_biaya`
--

CREATE TABLE `cargo_app_biaya` (
  `id` bigint NOT NULL,
  `name` varchar(50) NOT NULL,
  `nominal` decimal(10,2) NOT NULL,
  `status` varchar(15) NOT NULL,
  `created_on` datetime(6) NOT NULL,
  `last_modified` datetime(6) NOT NULL,
  `user_create_id` bigint DEFAULT NULL,
  `user_update_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `cargo_app_biaya`
--

INSERT INTO `cargo_app_biaya` (`id`, `name`, `nominal`, `status`, `created_on`, `last_modified`, `user_create_id`, `user_update_id`) VALUES
(1, 'Biaya Berat', '10.00', 'Aktif', '2023-05-10 05:43:11.733470', '2023-05-10 05:57:02.644406', 1, 1),
(2, 'Asuransi Barang', '0.35', 'Aktif', '2023-05-10 05:43:25.786886', '2023-05-10 05:43:25.786886', 1, 1),
(3, 'Biaya Berkas & Lain-lain', '50000.00', 'Aktif', '2023-05-10 05:43:43.605209', '2023-05-10 05:43:43.605209', 1, 1),
(4, 'Biaya PPn', '0.11', 'Aktif', '2023-05-10 05:43:58.395248', '2023-05-10 05:43:58.395248', 1, 1),
(5, 'Profit', '0.15', 'Aktif', '2023-05-10 05:44:10.306589', '2023-05-10 05:44:10.306589', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `cargo_app_biayajarak`
--

CREATE TABLE `cargo_app_biayajarak` (
  `id` bigint NOT NULL,
  `status_layanan` varchar(15) NOT NULL,
  `batas_awal` decimal(10,2) NOT NULL,
  `batas_akhir` decimal(10,2) NOT NULL,
  `nominal` decimal(10,2) NOT NULL,
  `status` varchar(50) NOT NULL,
  `created_on` datetime(6) NOT NULL,
  `last_modified` datetime(6) NOT NULL,
  `user_create_id` bigint DEFAULT NULL,
  `user_update_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `cargo_app_biayajarak`
--

INSERT INTO `cargo_app_biayajarak` (`id`, `status_layanan`, `batas_awal`, `batas_akhir`, `nominal`, `status`, `created_on`, `last_modified`, `user_create_id`, `user_update_id`) VALUES
(1, 'Reguler', '1.00', '5.00', '73500.00', 'Aktif', '2023-05-10 05:42:51.312337', '2023-05-10 06:04:21.121038', 1, 1),
(2, 'Tomorrow', '1.00', '5.00', '75000.00', 'Aktif', '2023-05-10 06:05:34.159707', '2023-05-10 06:05:34.159707', 1, 1),
(3, 'SameDay', '1.00', '5.00', '80000.00', 'Aktif', '2023-05-10 06:05:59.122184', '2023-05-10 06:05:59.122184', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `cargo_app_category`
--

CREATE TABLE `cargo_app_category` (
  `id` bigint NOT NULL,
  `name` varchar(100) NOT NULL,
  `status` varchar(15) NOT NULL,
  `created_on` datetime(6) NOT NULL,
  `last_modified` datetime(6) NOT NULL,
  `user_create_id` bigint DEFAULT NULL,
  `user_update_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cargo_app_paymentstatus`
--

CREATE TABLE `cargo_app_paymentstatus` (
  `id` bigint NOT NULL,
  `code` int NOT NULL,
  `name` varchar(20) NOT NULL,
  `created_on` datetime(6) NOT NULL,
  `last_modified` datetime(6) NOT NULL,
  `user_create_id` bigint DEFAULT NULL,
  `user_update_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `cargo_app_paymentstatus`
--

INSERT INTO `cargo_app_paymentstatus` (`id`, `code`, `name`, `created_on`, `last_modified`, `user_create_id`, `user_update_id`) VALUES
(1, 0, 'Belum Dibayar', '2023-05-10 09:44:43.690429', '2023-05-10 09:44:43.690429', 1, 1),
(2, 2, 'Success Payment', '2023-05-10 09:44:57.554622', '2023-05-10 09:44:57.554622', 1, 1),
(3, 7, 'Pay Expired', '2023-05-10 09:45:08.113258', '2023-05-10 09:45:08.113258', 1, 1),
(4, 8, 'Pay Cancelled', '2023-05-10 09:45:36.908434', '2023-05-10 09:45:36.908434', 1, 1),
(5, 10, 'Proses Refund', '2023-05-10 09:46:10.706635', '2023-05-10 09:46:10.706635', 1, 1),
(6, 11, 'Berhasil Refund', '2023-05-10 09:46:20.325110', '2023-05-10 09:46:20.325110', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `cargo_app_profile`
--

CREATE TABLE `cargo_app_profile` (
  `id` bigint NOT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  `bio` longtext NOT NULL,
  `status` varchar(15) NOT NULL,
  `created_on` datetime(6) NOT NULL,
  `last_modified` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  `user_create_id` bigint DEFAULT NULL,
  `user_update_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cargo_app_user`
--

CREATE TABLE `cargo_app_user` (
  `id` bigint NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `is_operational` tinyint(1) NOT NULL,
  `is_accounting` tinyint(1) NOT NULL,
  `is_customerservice` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `cargo_app_user`
--

INSERT INTO `cargo_app_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `is_operational`, `is_accounting`, `is_customerservice`) VALUES
(1, 'pbkdf2_sha256$600000$rlinztAjSj2qsM1EtNoCK8$CVtpdiY6OdqrFR+cIhdETyEWqvFQbIGDLWHiYOK0G9g=', '2023-05-10 05:42:33.211379', 1, 'admin', '', '', 'admin@gmail.com', 1, 1, '2023-05-10 05:04:35.280969', 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `cargo_app_user_groups`
--

CREATE TABLE `cargo_app_user_groups` (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cargo_app_user_user_permissions`
--

CREATE TABLE `cargo_app_user_user_permissions` (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL
) ;

--
-- Dumping data for table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2023-05-10 05:42:51.313335', '1', 'Batas Awal : 1 | Batas Akhir : 5 = 73500', 1, '[{\"added\": {}}]', 10, 1),
(2, '2023-05-10 05:43:11.736466', '1', 'Biaya Berat | 100', 1, '[{\"added\": {}}]', 9, 1),
(3, '2023-05-10 05:43:25.787891', '2', 'Asuransi Barang | 0.35', 1, '[{\"added\": {}}]', 9, 1),
(4, '2023-05-10 05:43:43.606209', '3', 'Biaya Berkas & Lain-lain | 50000', 1, '[{\"added\": {}}]', 9, 1),
(5, '2023-05-10 05:43:58.396245', '4', 'Biaya PPn | 0.11', 1, '[{\"added\": {}}]', 9, 1),
(6, '2023-05-10 05:44:10.307491', '5', 'Profit | 0.15', 1, '[{\"added\": {}}]', 9, 1),
(7, '2023-05-10 05:57:02.646401', '1', 'Biaya Berat | 10', 2, '[{\"changed\": {\"fields\": [\"Nominal\"]}}]', 9, 1),
(8, '2023-05-10 06:04:21.124030', '1', 'Batas Awal : 1.00 | Batas Akhir : 5.00 = 73500.00', 2, '[]', 10, 1),
(9, '2023-05-10 06:05:34.161725', '2', 'Batas Awal : 1 | Batas Akhir : 5 = 75000', 1, '[{\"added\": {}}]', 10, 1),
(10, '2023-05-10 06:05:59.123181', '3', 'Batas Awal : 1 | Batas Akhir : 5 = 80000', 1, '[{\"added\": {}}]', 10, 1),
(11, '2023-05-10 09:44:43.693421', '1', 'Belum Dibayar', 1, '[{\"added\": {}}]', 11, 1),
(12, '2023-05-10 09:44:57.556616', '2', 'Success Payment', 1, '[{\"added\": {}}]', 11, 1),
(13, '2023-05-10 09:45:08.117246', '3', 'Pay Expired', 1, '[{\"added\": {}}]', 11, 1),
(14, '2023-05-10 09:45:36.913421', '4', 'Pay Cancelled', 1, '[{\"added\": {}}]', 11, 1),
(15, '2023-05-10 09:46:10.707633', '5', 'Proses Refund', 1, '[{\"added\": {}}]', 11, 1),
(16, '2023-05-10 09:46:20.326107', '6', 'Berhasil Refund', 1, '[{\"added\": {}}]', 11, 1);

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(9, 'cargo_app', 'biaya'),
(10, 'cargo_app', 'biayajarak'),
(7, 'cargo_app', 'category'),
(11, 'cargo_app', 'paymentstatus'),
(8, 'cargo_app', 'profile'),
(6, 'cargo_app', 'user'),
(4, 'contenttypes', 'contenttype'),
(5, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2023-05-10 05:04:19.137995'),
(2, 'contenttypes', '0002_remove_content_type_name', '2023-05-10 05:04:19.223761'),
(3, 'auth', '0001_initial', '2023-05-10 05:04:19.402436'),
(4, 'auth', '0002_alter_permission_name_max_length', '2023-05-10 05:04:19.461279'),
(5, 'auth', '0003_alter_user_email_max_length', '2023-05-10 05:04:19.467264'),
(6, 'auth', '0004_alter_user_username_opts', '2023-05-10 05:04:19.476240'),
(7, 'auth', '0005_alter_user_last_login_null', '2023-05-10 05:04:19.483220'),
(8, 'auth', '0006_require_contenttypes_0002', '2023-05-10 05:04:19.485216'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2023-05-10 05:04:19.493194'),
(10, 'auth', '0008_alter_user_username_max_length', '2023-05-10 05:04:19.502170'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2023-05-10 05:04:19.510149'),
(12, 'auth', '0010_alter_group_name_max_length', '2023-05-10 05:04:19.531093'),
(13, 'auth', '0011_update_proxy_permissions', '2023-05-10 05:04:19.540069'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2023-05-10 05:04:19.548048'),
(15, 'cargo_app', '0001_initial', '2023-05-10 05:04:19.900253'),
(16, 'admin', '0001_initial', '2023-05-10 05:04:20.052966'),
(17, 'admin', '0002_logentry_remove_auto_add', '2023-05-10 05:04:20.071671'),
(18, 'admin', '0003_logentry_add_action_flag_choices', '2023-05-10 05:04:20.117325'),
(19, 'cargo_app', '0002_profile_biaya', '2023-05-10 05:04:20.385719'),
(20, 'cargo_app', '0003_biayajarak', '2023-05-10 05:04:20.488761'),
(21, 'sessions', '0001_initial', '2023-05-10 05:04:20.535291'),
(22, 'cargo_app', '0004_paymentstatus', '2023-05-10 09:42:30.258113');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('tyfa7fjinehp1wwhjak8ba7stb3a6k4w', '.eJxVjEEOwiAQRe_C2hCgMIBL956BDDMgVdMmpV0Z765NutDtf-_9l0i4rS1tvSxpZHEWWpx-t4z0KNMO-I7TbZY0T-syZrkr8qBdXmcuz8vh_h007O1be6WCdpqB6wA2YnSWwYPK2VXCooA8BFaDM1CDAWORQiZLsYToo7Li_QHE1jco:1pwcav:D07YioLHOiGRc-HDuWoOxGtlCJbIqSOu0o1Frr4au24', '2023-05-24 05:42:33.215368');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `cargo_app_biaya`
--
ALTER TABLE `cargo_app_biaya`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cargo_app_biaya_user_create_id_6a6aefa5_fk_cargo_app_user_id` (`user_create_id`),
  ADD KEY `cargo_app_biaya_user_update_id_84f8f125_fk_cargo_app_user_id` (`user_update_id`);

--
-- Indexes for table `cargo_app_biayajarak`
--
ALTER TABLE `cargo_app_biayajarak`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cargo_app_biayajarak_user_create_id_b43155aa_fk_cargo_app` (`user_create_id`),
  ADD KEY `cargo_app_biayajarak_user_update_id_12d29fa2_fk_cargo_app` (`user_update_id`);

--
-- Indexes for table `cargo_app_category`
--
ALTER TABLE `cargo_app_category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cargo_app_category_user_create_id_22388f1e_fk_cargo_app_user_id` (`user_create_id`),
  ADD KEY `cargo_app_category_user_update_id_82e622fb_fk_cargo_app_user_id` (`user_update_id`);

--
-- Indexes for table `cargo_app_paymentstatus`
--
ALTER TABLE `cargo_app_paymentstatus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cargo_app_paymentsta_user_create_id_a1ca5e26_fk_cargo_app` (`user_create_id`),
  ADD KEY `cargo_app_paymentsta_user_update_id_d3f24a79_fk_cargo_app` (`user_update_id`);

--
-- Indexes for table `cargo_app_profile`
--
ALTER TABLE `cargo_app_profile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD KEY `cargo_app_profile_user_create_id_00e7c243_fk_cargo_app_user_id` (`user_create_id`),
  ADD KEY `cargo_app_profile_user_update_id_956bf8bc_fk_cargo_app_user_id` (`user_update_id`);

--
-- Indexes for table `cargo_app_user`
--
ALTER TABLE `cargo_app_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `cargo_app_user_groups`
--
ALTER TABLE `cargo_app_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cargo_app_user_groups_user_id_group_id_d4ecab7f_uniq` (`user_id`,`group_id`),
  ADD KEY `cargo_app_user_groups_group_id_cad9e9f9_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `cargo_app_user_user_permissions`
--
ALTER TABLE `cargo_app_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cargo_app_user_user_perm_user_id_permission_id_8b90c451_uniq` (`user_id`,`permission_id`),
  ADD KEY `cargo_app_user_user__permission_id_ee8b5f84_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_cargo_app_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `cargo_app_biaya`
--
ALTER TABLE `cargo_app_biaya`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `cargo_app_biayajarak`
--
ALTER TABLE `cargo_app_biayajarak`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cargo_app_category`
--
ALTER TABLE `cargo_app_category`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cargo_app_paymentstatus`
--
ALTER TABLE `cargo_app_paymentstatus`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `cargo_app_profile`
--
ALTER TABLE `cargo_app_profile`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cargo_app_user`
--
ALTER TABLE `cargo_app_user`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cargo_app_user_groups`
--
ALTER TABLE `cargo_app_user_groups`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cargo_app_user_user_permissions`
--
ALTER TABLE `cargo_app_user_user_permissions`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `cargo_app_biaya`
--
ALTER TABLE `cargo_app_biaya`
  ADD CONSTRAINT `cargo_app_biaya_user_create_id_6a6aefa5_fk_cargo_app_user_id` FOREIGN KEY (`user_create_id`) REFERENCES `cargo_app_user` (`id`),
  ADD CONSTRAINT `cargo_app_biaya_user_update_id_84f8f125_fk_cargo_app_user_id` FOREIGN KEY (`user_update_id`) REFERENCES `cargo_app_user` (`id`);

--
-- Constraints for table `cargo_app_biayajarak`
--
ALTER TABLE `cargo_app_biayajarak`
  ADD CONSTRAINT `cargo_app_biayajarak_user_create_id_b43155aa_fk_cargo_app` FOREIGN KEY (`user_create_id`) REFERENCES `cargo_app_user` (`id`),
  ADD CONSTRAINT `cargo_app_biayajarak_user_update_id_12d29fa2_fk_cargo_app` FOREIGN KEY (`user_update_id`) REFERENCES `cargo_app_user` (`id`);

--
-- Constraints for table `cargo_app_category`
--
ALTER TABLE `cargo_app_category`
  ADD CONSTRAINT `cargo_app_category_user_create_id_22388f1e_fk_cargo_app_user_id` FOREIGN KEY (`user_create_id`) REFERENCES `cargo_app_user` (`id`),
  ADD CONSTRAINT `cargo_app_category_user_update_id_82e622fb_fk_cargo_app_user_id` FOREIGN KEY (`user_update_id`) REFERENCES `cargo_app_user` (`id`);

--
-- Constraints for table `cargo_app_paymentstatus`
--
ALTER TABLE `cargo_app_paymentstatus`
  ADD CONSTRAINT `cargo_app_paymentsta_user_create_id_a1ca5e26_fk_cargo_app` FOREIGN KEY (`user_create_id`) REFERENCES `cargo_app_user` (`id`),
  ADD CONSTRAINT `cargo_app_paymentsta_user_update_id_d3f24a79_fk_cargo_app` FOREIGN KEY (`user_update_id`) REFERENCES `cargo_app_user` (`id`);

--
-- Constraints for table `cargo_app_profile`
--
ALTER TABLE `cargo_app_profile`
  ADD CONSTRAINT `cargo_app_profile_user_create_id_00e7c243_fk_cargo_app_user_id` FOREIGN KEY (`user_create_id`) REFERENCES `cargo_app_user` (`id`),
  ADD CONSTRAINT `cargo_app_profile_user_id_45cfd3d6_fk_cargo_app_user_id` FOREIGN KEY (`user_id`) REFERENCES `cargo_app_user` (`id`),
  ADD CONSTRAINT `cargo_app_profile_user_update_id_956bf8bc_fk_cargo_app_user_id` FOREIGN KEY (`user_update_id`) REFERENCES `cargo_app_user` (`id`);

--
-- Constraints for table `cargo_app_user_groups`
--
ALTER TABLE `cargo_app_user_groups`
  ADD CONSTRAINT `cargo_app_user_groups_group_id_cad9e9f9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `cargo_app_user_groups_user_id_edb1caa7_fk_cargo_app_user_id` FOREIGN KEY (`user_id`) REFERENCES `cargo_app_user` (`id`);

--
-- Constraints for table `cargo_app_user_user_permissions`
--
ALTER TABLE `cargo_app_user_user_permissions`
  ADD CONSTRAINT `cargo_app_user_user__permission_id_ee8b5f84_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `cargo_app_user_user__user_id_91c5927f_fk_cargo_app` FOREIGN KEY (`user_id`) REFERENCES `cargo_app_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_cargo_app_user_id` FOREIGN KEY (`user_id`) REFERENCES `cargo_app_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
