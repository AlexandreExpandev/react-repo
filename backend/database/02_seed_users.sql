-- Demo Project - Initial Users Data
-- This file contains sample users for the demo application

-- Insert demo users
INSERT INTO users (name, email, role) VALUES
('João Silva', 'joao.silva@example.com', 'admin'),
('Maria Santos', 'maria.santos@example.com', 'user'),
('Pedro Oliveira', 'pedro.oliveira@example.com', 'user'),
('Ana Costa', 'ana.costa@example.com', 'user'),
('Carlos Mendes', 'carlos.mendes@example.com', 'admin'),
('Lucia Fernandes', 'lucia.fernandes@example.com', 'user'),
('Roberto Lima', 'roberto.lima@example.com', 'user'),
('Sofia Almeida', 'sofia.almeida@example.com', 'user'),
('Miguel Torres', 'miguel.torres@example.com', 'user'),
('Isabel Rocha', 'isabel.rocha@example.com', 'admin');

PRINT 'Users seeded successfully! Inserted ' + CAST(@@ROWCOUNT AS NVARCHAR(10)) + ' users.';