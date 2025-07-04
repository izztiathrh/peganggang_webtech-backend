<?php
// backend/config/database.php

class Database {
    private $host;
    private $db_name;
    private $username;
    private $password;
    private $charset = 'utf8mb4';
    private $port;
    
    public function __construct() {
        // Check for various environment configurations
        
        // 1. Check for DATABASE_URL (Render, Heroku style)
        if ($database_url = getenv('DATABASE_URL')) {
            $url = parse_url($database_url);
            $this->host = $url['host'];
            $this->db_name = ltrim($url['path'], '/');
            $this->username = $url['user'];
            $this->password = $url['pass'];
            $this->port = $url['port'] ?? 5432;
        } 
        // 2. Check for individual environment variables
        elseif (getenv('DB_HOST')) {
            $this->host = getenv('DB_HOST');
            $this->db_name = getenv('DB_NAME') ?: 'flexstock_inventory';
            $this->username = getenv('DB_USER');
            $this->password = getenv('DB_PASS');
            $this->port = getenv('DB_PORT') ?: 3306;
        }
        // 3. Fallback to local development
        else {
            $this->host = 'localhost';
            $this->db_name = 'flexstock_inventory';
            $this->username = 'root';
            $this->password = '';
            $this->port = 3306;
        }
    }
    
    public function getConnection() {
        $this->conn = null;
        
        try {
            // Determine if PostgreSQL or MySQL
            if (getenv('DATABASE_URL') || $this->port == 5432) {
                // PostgreSQL (Render)
                $dsn = "pgsql:host=" . $this->host . ";port=" . $this->port . ";dbname=" . $this->db_name;
            } else {
                // MySQL (local, other hosts)
                $dsn = "mysql:host=" . $this->host . ";port=" . $this->port . ";dbname=" . $this->db_name . ";charset=" . $this->charset;
            }
            
            $options = [
                PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES   => false,
            ];
            
            $this->conn = new PDO($dsn, $this->username, $this->password, $options);
            
        } catch(PDOException $exception) {
            error_log("Database connection error: " . $exception->getMessage());
            return null;
        }
        
        return $this->conn;
    }
    
    public function closeConnection() {
        $this->conn = null;
    }
    
    public function testConnection() {
        $connection = $this->getConnection();
        return $connection !== null;
    }
}
?>