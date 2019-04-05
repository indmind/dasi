-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 05 Apr 2019 pada 16.14
-- Versi server: 10.1.37-MariaDB
-- Versi PHP: 7.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dasi`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `id_sekolah` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `level` varchar(255) NOT NULL DEFAULT 'admin',
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `admin`
--

INSERT INTO `admin` (`id`, `id_sekolah`, `nama`, `email`, `level`, `password`) VALUES
(1, 1, 'admin', 'admin@mail.com', 'admin', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9');

-- --------------------------------------------------------

--
-- Struktur dari tabel `donation`
--

CREATE TABLE `donation` (
  `id` int(11) NOT NULL,
  `id_sekolah` int(11) NOT NULL,
  `judul` varchar(255) NOT NULL,
  `deskripsi` longtext NOT NULL,
  `posted_by` int(11) NOT NULL COMMENT 'id admin',
  `target_donasi` bigint(20) NOT NULL,
  `terkumpul` bigint(20) NOT NULL DEFAULT '0',
  `donator` int(11) NOT NULL,
  `status` enum('open','close') NOT NULL DEFAULT 'open'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `qrcode`
--

CREATE TABLE `qrcode` (
  `id` int(11) NOT NULL,
  `id_sekolah` int(11) NOT NULL,
  `unique_id` varchar(255) NOT NULL COMMENT 'Nilai QR',
  `judul` varchar(255) NOT NULL,
  `tetap` tinyint(1) NOT NULL,
  `generated_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_toko` int(11) NOT NULL,
  `nilai` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `schools`
--

CREATE TABLE `schools` (
  `id` int(11) NOT NULL,
  `npsn` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL COMMENT 'Negeri / Swasta',
  `bentuk_pendidikan` varchar(255) NOT NULL COMMENT 'SMK / SMA',
  `nama_sekolah` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `toko`
--

CREATE TABLE `toko` (
  `id` int(11) NOT NULL,
  `id_sekolah` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `deskripsi` mediumtext NOT NULL,
  `saldo` bigint(20) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `toko_transaction`
--

CREATE TABLE `toko_transaction` (
  `id` int(11) NOT NULL,
  `id_sekolah` int(11) NOT NULL,
  `tanggal` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `toko_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `qr_id` int(11) NOT NULL,
  `jumlah` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `id_sekolah` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `kelamin` enum('laki-laki','perempuan') NOT NULL,
  `email` varchar(255) NOT NULL,
  `level` varchar(255) NOT NULL DEFAULT 'siswa',
  `tingkatan` enum('I','II','III','IV','V','VI','VII','VIII','IX','X','XI','XII','XIII') NOT NULL,
  `kelas` varchar(255) NOT NULL,
  `jurusan` varchar(255) NOT NULL,
  `nisn` varchar(255) NOT NULL,
  `saldo` bigint(20) NOT NULL DEFAULT '0',
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `id_sekolah`, `nama`, `kelamin`, `email`, `level`, `tingkatan`, `kelas`, `jurusan`, `nisn`, `saldo`, `password`) VALUES
(3, 1, 'Tio Irawan', 'laki-laki', 'tioirawan063@gmail.com', 'siswa', 'X', 'A', 'RPL', '1234567890', 526443, 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f'),
(4, 1, 'Abdillahi Aufal Mustachaq', 'laki-laki', 'dillah@aufal.com', 'siswa', 'X', 'A', 'RPL', '0014225574533', 228955, 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3'),
(5, 1, 'Rifky Alif Fadillah', 'laki-laki', 'rifkyalif@gmail.com', 'siswa', 'X', 'A', 'RPL', '00162538727', 250000, '64bb4031c2bbc1b4eeddfec0f701a3d1ea350dad9ad98b27a3242cbd54bf31d7'),
(6, 1, 'Ardiva Lali Lali', 'perempuan', 'ardiva@lali.lali', 'siswa', 'II', 'D', 'Kosek WC', '0000000001', 46226000, '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5'),
(12, 1, 'Adecya Jalu Mahadwija', 'laki-laki', 'jaludwija37@gmail.com', 'siswa', 'X', 'A', 'RPL', '00162538723', 9010000, '81aac574d13d4f8333f7dde8097a92b2d374c429735875db01b3cac6529fdf40'),
(13, 1, 'Unun Tri Suntari', 'perempuan', 'unun@gmail.com', 'siswa', 'X', 'A', 'RPL', '0012312312', 770000, '52ae304cc402178f0babdf9fa281f74bfe95621f7d271c96603948d438142ca0'),
(14, 1, 'Melinda Gates', 'perempuan', 'melinda@gates.com', 'siswa', 'XI', 'A', 'TKJ', '003214123123', 1000000000, '239a75ee654d20b41ae55b689923dbe0478df7e83543bea148ec35a5039e3a56'),
(15, 1, 'Anjab', 'laki-laki', 'anjab@gmail.com', 'siswa', 'X', 'A', 'RPL', '0013231238', 500000, '393037787237af6cb15710444b63829e4e68f758e8b609bb91f13604c7049904');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users_donation`
--

CREATE TABLE `users_donation` (
  `id` int(11) NOT NULL,
  `id_sekolah` int(11) NOT NULL,
  `tanggal` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `donation_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `jumlah` bigint(20) NOT NULL,
  `private` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users_transaction`
--

CREATE TABLE `users_transaction` (
  `id` bigint(20) NOT NULL,
  `id_sekolah` int(11) NOT NULL,
  `kredit` bigint(20) NOT NULL,
  `debit` bigint(20) NOT NULL,
  `tipe` varchar(255) NOT NULL COMMENT 'tipe transasi (spp/donasi/dll)',
  `jenis` enum('masuk','keluar') NOT NULL,
  `tanggal` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'tanggal transaksi',
  `user_id` int(11) NOT NULL,
  `metode` varchar(255) NOT NULL COMMENT 'metode pembayaran (transfer nisn/qrcode)',
  `deskripsi` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_sekolah` (`id_sekolah`);

--
-- Indeks untuk tabel `donation`
--
ALTER TABLE `donation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `posted_by` (`posted_by`),
  ADD KEY `id_sekolah` (`id_sekolah`);

--
-- Indeks untuk tabel `qrcode`
--
ALTER TABLE `qrcode`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_id` (`unique_id`),
  ADD KEY `generated_by` (`generated_by`),
  ADD KEY `id_toko` (`id_toko`),
  ADD KEY `id_sekolah` (`id_sekolah`);

--
-- Indeks untuk tabel `schools`
--
ALTER TABLE `schools`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `toko`
--
ALTER TABLE `toko`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_sekolah` (`id_sekolah`);

--
-- Indeks untuk tabel `toko_transaction`
--
ALTER TABLE `toko_transaction`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_sekolah` (`id_sekolah`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nisn` (`nisn`),
  ADD KEY `id_sekolah` (`id_sekolah`);

--
-- Indeks untuk tabel `users_donation`
--
ALTER TABLE `users_donation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `donation_id` (`donation_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `id_sekolah` (`id_sekolah`);

--
-- Indeks untuk tabel `users_transaction`
--
ALTER TABLE `users_transaction`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `id_sekolah` (`id_sekolah`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `donation`
--
ALTER TABLE `donation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `qrcode`
--
ALTER TABLE `qrcode`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `schools`
--
ALTER TABLE `schools`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `toko`
--
ALTER TABLE `toko`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `toko_transaction`
--
ALTER TABLE `toko_transaction`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT untuk tabel `users_donation`
--
ALTER TABLE `users_donation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `users_transaction`
--
ALTER TABLE `users_transaction`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`id_sekolah`) REFERENCES `schools` (`id`);

--
-- Ketidakleluasaan untuk tabel `donation`
--
ALTER TABLE `donation`
  ADD CONSTRAINT `donation_ibfk_1` FOREIGN KEY (`posted_by`) REFERENCES `admin` (`id`),
  ADD CONSTRAINT `donation_ibfk_2` FOREIGN KEY (`id_sekolah`) REFERENCES `schools` (`id`);

--
-- Ketidakleluasaan untuk tabel `qrcode`
--
ALTER TABLE `qrcode`
  ADD CONSTRAINT `qrcode_ibfk_1` FOREIGN KEY (`id_toko`) REFERENCES `toko` (`id`),
  ADD CONSTRAINT `qrcode_ibfk_2` FOREIGN KEY (`generated_by`) REFERENCES `admin` (`id`),
  ADD CONSTRAINT `qrcode_ibfk_3` FOREIGN KEY (`id_sekolah`) REFERENCES `schools` (`id`);

--
-- Ketidakleluasaan untuk tabel `toko`
--
ALTER TABLE `toko`
  ADD CONSTRAINT `toko_ibfk_1` FOREIGN KEY (`id_sekolah`) REFERENCES `schools` (`id`);

--
-- Ketidakleluasaan untuk tabel `toko_transaction`
--
ALTER TABLE `toko_transaction`
  ADD CONSTRAINT `toko_transaction_ibfk_1` FOREIGN KEY (`id_sekolah`) REFERENCES `schools` (`id`);

--
-- Ketidakleluasaan untuk tabel `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`id_sekolah`) REFERENCES `schools` (`id`);

--
-- Ketidakleluasaan untuk tabel `users_donation`
--
ALTER TABLE `users_donation`
  ADD CONSTRAINT `users_donation_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `users_donation_ibfk_2` FOREIGN KEY (`donation_id`) REFERENCES `donation` (`id`),
  ADD CONSTRAINT `users_donation_ibfk_3` FOREIGN KEY (`id_sekolah`) REFERENCES `schools` (`id`);

--
-- Ketidakleluasaan untuk tabel `users_transaction`
--
ALTER TABLE `users_transaction`
  ADD CONSTRAINT `users_transaction_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `users_transaction_ibfk_2` FOREIGN KEY (`id_sekolah`) REFERENCES `schools` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
