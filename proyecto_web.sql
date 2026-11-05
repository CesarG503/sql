-- ====================================================================
-- Script SQL: Inicialización de Base de Datos para Sitio Web Empresarial
-- Base de Datos: proyecto_web
-- ====================================================================

-- 1. Crear base de datos (por si no ha sido creada)
CREATE DATABASE IF NOT EXISTS proyecto_web CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE proyecto_web;

-- 2. Tabla para el contador global de visitas del sitio web
CREATE TABLE IF NOT EXISTS contador_visitas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    total_visitas INT NOT NULL DEFAULT 0,
    ultima_visita TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Inicializar el contador en 0 si la tabla está vacía
INSERT INTO contador_visitas (id, total_visitas) 
VALUES (1, 0)
ON DUPLICATE KEY UPDATE id = id;

-- 3. Tabla para el registro de personas (visitantes con Nombre y Carnet)
CREATE TABLE IF NOT EXISTS personas_registradas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_completo VARCHAR(150) NOT NULL,
    carnet VARCHAR(30) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- (Opcional) Tabla para el historial detallado de accesos por IP
CREATE TABLE IF NOT EXISTS historial_accesos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    ip_visitante VARCHAR(45) NOT NULL,
    user_agent TEXT,
    fecha_visita TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ====================================================================
-- NOTA PARA SERVIDOR DE BASE DE DATOS INDEPENDIENTE:
-- Si el servidor web y el servidor SQL están en diferentes máquinas (remotas),
-- ejecuta también estos comandos en el servidor SQL cambiando 'localhost' por '%'
-- o por la IP del servidor web:
--
-- CREATE USER IF NOT EXISTS 'admin_web'@'%' IDENTIFIED BY 'admin.123';
-- GRANT ALL PRIVILEGES ON proyecto_web.* TO 'admin_web'@'%';
-- FLUSH PRIVILEGES;
--
-- Además, en /etc/mysql/mariadb.conf.d/50-server.cnf asegúrate de configurar:
-- bind-address = 0.0.0.0
-- y reiniciar MariaDB con: systemctl restart mariadb
-- ====================================================================

