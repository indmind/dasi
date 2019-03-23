<?php

require __DIR__."/../process/utils.php";

class Database
{
    private $contHost = 'localhost';
    private $contnama = 'dasi';
    private $contUsernama = 'root';
    private $contUserPassword = '';

    private $cont  = null;

    public function __construct()
    {
        if ($this->cont == null) {

            try {
                $this->cont =  new PDO(
                    "mysql:host=" . $this->contHost .
                        ";" . "dbname=" . $this->contnama,
                    $this->contUsernama,
                    $this->contUserPassword
                );
                $this->cont->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            } catch (PDOException $e) {
                die($e->getMessage());
            }
        }

        return $this->cont;
    }

    public function registerAdmin($nama, $email, $password)
    {
        try {
            $query = $this->cont->prepare(
                "INSERT INTO admin(nama, email, level, password) 
                VALUES (:nama,:email,'admin',:password)"
            );

            $enc_password = hash('sha256', $password);

            $query->bindParam("nama", $nama, PDO::PARAM_STR);
            $query->bindParam("email", $email, PDO::PARAM_STR);
            $query->bindParam("password", $enc_password, PDO::PARAM_STR);

            $query->execute();

            return $this->cont->lastInsertId();
        } catch (PDOException $e) {
            exit($e->getMessage());
        }
    }


    public function loginAdmin($email, $password)
    {
        try {
            $query = $this->cont->prepare(
                "SELECT id FROM admin 
                WHERE email=:email
                AND password=:password"
            );

            $query->bindParam("email", $email, PDO::PARAM_STR);
            $enc_password = hash('sha256', $password);
            $query->bindParam("password", $enc_password, PDO::PARAM_STR);

            $query->execute();

            if ($query->rowCount() > 0) {
                $result = $query->fetch(PDO::FETCH_OBJ);
                return $result->id;
            } else {
                return false;
            }
        } catch (PDOException $e) {
            exit($e->getMessage());
        }
    }


    public function getAdminById($id, $rettype)
    {
        try {
            $query = $this->cont->prepare(
                "SELECT id, nama, email, level
                FROM admin WHERE id=:id"
            );

            $query->bindParam("id", $id, PDO::PARAM_STR);

            $query->execute();

            if ($query->rowCount() > 0) {
                return $query->fetch($rettype);
            }
        } catch (PDOException $e) {
            exit($e->getMessage());
        }
    }

    public function getAllUsers()
    {
        $stmt = $this->cont->prepare("SELECT * FROM users");

        $stmt->execute();

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function register($nama, $kelamin, $email, $tingkatan, $kelas, $jurusan, $nisn, $saldo)
    {
        try {
            $query = $this->cont->prepare(
                "INSERT INTO users(nama, kelamin, email, level, tingkatan, kelas, jurusan, nisn, saldo, password) 
                VALUES (:nama,:kelamin,:email,'siswa',:tingkatan,:kelas,:jurusan,:nisn,:saldo,:password)"
            );

            $password = generateRandom();

            
            $enc_password = hash('sha256', $password);

            echo $password."<br>";
            echo $enc_password."<br>";
            
            $query->bindParam("nama", $nama, PDO::PARAM_STR);
            $query->bindParam("kelamin", $kelamin, PDO::PARAM_STR);
            $query->bindParam("email", $email, PDO::PARAM_STR);
            $query->bindParam("tingkatan", $tingkatan, PDO::PARAM_STR);
            $query->bindParam("kelas", $kelas, PDO::PARAM_STR);
            $query->bindParam("jurusan", $jurusan, PDO::PARAM_STR);
            $query->bindParam("nisn", $nisn, PDO::PARAM_STR);
            $query->bindParam("saldo", $saldo, PDO::PARAM_INT);
            $query->bindParam("password", $enc_password, PDO::PARAM_STR);

            $query->execute();

            return Array($this->cont->lastInsertId(), $password);
        } catch (PDOException $e) {
            exit($e->getMessage());
        }
    }

    public function login($email, $password)
    {
        try {
            $query = $this->cont->prepare(
                "SELECT id FROM users 
                WHERE email=:email
                AND password=:password"
            );

            $enc_password = hash('sha256', $password);

            $query->bindParam("email", $email, PDO::PARAM_STR);
            $query->bindParam("password", $enc_password, PDO::PARAM_STR);

            $query->execute();

            // print_r($query->fetchAll(PDO::FETCH_ASSOC));

            if ($query->rowCount() > 0) {
                $result = $query->fetch(PDO::FETCH_OBJ);
                return $result->id;
            } else {
                return false;
            }
        } catch (PDOException $e) {
            exit($e->getMessage());
        }
    }

    public function validatePassword($id, $password)
    {
        try {
            $query = $this->cont->prepare(
                "SELECT id FROM users 
                WHERE id=:id
                AND password=:password"
            );

            $enc_password = hash('sha256', $password);

            $query->bindParam("id", $id, PDO::PARAM_STR);
            $query->bindParam("password", $enc_password, PDO::PARAM_STR);

            $query->execute();

            if ($query->rowCount() > 0) {
                return true;
            } else {
                return false;
            }
        } catch (PDOException $e) {
            exit($e->getMessage());
        }
    }

    public function searchUser($query)
    {
        try {
            $query = $this->cont->prepare(
                "SELECT id, nama, email, level, tingkatan, kelas, jurusan, nisn, saldo
                FROM users WHERE name LIKE '%:query%' OR email=':query' OR nisn=':query'"
            );

            $query->bindParam("query", $query, PDO::PARAM_STR);

            $query->execute();

            if ($query->rowCount() > 0) {
                return $query->fetchAll(PDO::FETCH_OBJ);
            } else {
                return false;
            }
        } catch (PDOException $e) {
            exit($e->getMessage());
        }
    }

    public function getUserById($id, $rettype)
    {
        try {
            $query = $this->cont->prepare(
                "SELECT id, nama, email, level, tingkatan, kelas, jurusan, nisn, saldo
                FROM users WHERE id=:id"
            );

            $query->bindParam("id", $id, PDO::PARAM_STR);

            $query->execute();

            if ($query->rowCount() > 0) {
                return $query->fetch($rettype);
            }
        } catch (PDOException $e) {
            exit($e->getMessage());
        }
    }

    public function getUserTransactionHistory($id, $rettype) {
        try {
            $query = $this->cont->prepare(
                "SELECT *
                 FROM users_transaction
                 WHERE user_id=:id
                 ORDER BY tanggal DESC"
            );

            $query->bindParam("id", $id, PDO::PARAM_STR);

            $query->execute();

            if ($query->rowCount() > 0) {
                return $query->fetchAll($rettype);
            }
        } catch (PDOException $e) {
            return false;
        }
    }

    public function createDonation($judul, $deskripsi, $target, $idposter)
    {
        try {
            $query = $this->cont->prepare(
                "INSERT INTO donation(judul, deskripsi, posted_by, target_donasi) 
                VALUES (:judul,:deskripsi,:idposter,:tgt)"
            );

            $query->bindParam("judul", $judul, PDO::PARAM_STR);
            $query->bindParam("deskripsi", $deskripsi, PDO::PARAM_STR);
            $query->bindParam("tgt", $target, PDO::PARAM_INT);
            $query->bindParam("idposter", $idposter, PDO::PARAM_STR);            

            $query->execute();

            return $this->cont->lastInsertId();
        } catch (PDOException $e) {
            exit($e->getMessage());
        }
    }

    public function getDonation($id, $rettype) {
        try {
            $query = $this->cont->prepare(
                "SELECT * FROM donation WHERE id=:id"
            );

            $query->bindParam("id", $id, PDO::PARAM_STR);

            $query->execute();

            if ($query->rowCount() > 0) {
                return $query->fetch($rettype);
            }
        } catch (PDOException $e) {
            return false;
        }
    }

    public function getDonatur($id, $rettype) {
        try {
            $query = $this->cont->prepare(
                "SELECT users.nama, users.tingkatan, users.kelas,
                 users.jurusan, users_donation.jumlah, users_donation.private
                 FROM users_donation INNER JOIN users
                 ON users_donation.user_id = users.id
                 WHERE users_donation.donation_id=:id
                 ORDER BY tanggal DESC"
            );

            $query->bindParam("id", $id, PDO::PARAM_STR);

            $query->execute();

            if ($query->rowCount() > 0) {
                return $query->fetchAll($rettype);
            }
        } catch (PDOException $e) {
            return false;
        }
    }

    public function getAllDonations($rettype) {
        try {
            $query = $this->cont->prepare(
                "SELECT * FROM donation"
            );

            $query->execute();

            if ($query->rowCount() > 0) {
                return $query->fetchAll($rettype);
            }
        } catch (PDOException $e) {
            exit($e->getMessage());
        }
    }

    public function fundDonation($donation_id, $user_id, $amount, $isprivate) {
        try {
            $query = $this->cont->prepare(
                "UPDATE donation
                SET terkumpul = terkumpul + :amount
                WHERE id=:donationid"
            );

            $query->bindParam("donationid", $donation_id, PDO::PARAM_STR);
            $query->bindParam("amount", $amount, PDO::PARAM_INT);

            $query->execute();

            if ($query->rowCount() < 0) {
                return false;
            } 

            $query = $this->cont->prepare(
                "UPDATE users
                SET saldo = saldo - :amount
                WHERE id=:userid"
            );

            $query->bindParam("userid", $user_id, PDO::PARAM_STR);
            $query->bindParam("amount", $amount, PDO::PARAM_INT);


            $query->execute();

            if ($query->rowCount() < 0) {
                return false;
            } 

            $query = $this->cont->prepare(
                "INSERT INTO users_donation(donation_id, user_id, jumlah, private) 
                VALUES (:donationid,:userid,:amount,:isprivate)"
            );

            $query->bindParam("donationid", $donation_id, PDO::PARAM_INT);
            $query->bindParam("userid", $user_id, PDO::PARAM_INT);
            $query->bindParam("amount", $amount, PDO::PARAM_INT);
            $query->bindParam("isprivate", $isprivate, PDO::PARAM_BOOL);

            $query->execute();

            return $this->cont->lastInsertId();
        } catch (PDOException $e) {
            exit($e->getMessage());
        }
    }

    public function addTransaction($amount, $type, $userid, $method, $description)
    {
        try {
            $query = $this->cont->prepare(
                "INSERT INTO users_transaction(jumlah, tipe, user_id, metode, deskripsi) 
                VALUES (:jumlah,:tipe,:userid,:metode,:deskripsi)"
            );


            $query->bindParam("jumlah", $amount, PDO::PARAM_INT);
            $query->bindParam("tipe", $type, PDO::PARAM_STR);
            $query->bindParam("userid", $userid, PDO::PARAM_STR);
            $query->bindParam("metode", $method, PDO::PARAM_STR);
            $query->bindParam("deskripsi", $description, PDO::PARAM_STR);

            $query->execute();

            return $this->cont->lastInsertId();
        } catch (PDOException $e) {
            exit($e->getMessage());
        }
    }

    public function disconnect()
    {
        $this->cont = null;
    }
}