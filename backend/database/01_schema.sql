-- Demo Project Database Schema
-- This file contains the table structure for the demo application

-- Create Users table
CREATE TABLE users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    email NVARCHAR(255) NOT NULL UNIQUE,
    role NVARCHAR(50) NOT NULL DEFAULT 'user',
    created_at DATETIME2 DEFAULT GETDATE(),
    updated_at DATETIME2 DEFAULT GETDATE()
);

-- Create index on email for faster lookups
CREATE INDEX IX_users_email ON users(email);

-- Create index on role for filtering
CREATE INDEX IX_users_role ON users(role);

-- Create Projects table (example of related data)
CREATE TABLE projects (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(200) NOT NULL,
    description NVARCHAR(MAX),
    owner_id INT NOT NULL,
    status NVARCHAR(50) NOT NULL DEFAULT 'active',
    created_at DATETIME2 DEFAULT GETDATE(),
    updated_at DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (owner_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Create index on owner_id for faster joins
CREATE INDEX IX_projects_owner_id ON projects(owner_id);

-- Create index on status for filtering
CREATE INDEX IX_projects_status ON projects(status);

-- Create User Sessions table (example of app-specific data)
CREATE TABLE user_sessions (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    session_token NVARCHAR(255) NOT NULL UNIQUE,
    expires_at DATETIME2 NOT NULL,
    created_at DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Create index on session_token for auth lookups
CREATE INDEX IX_user_sessions_token ON user_sessions(session_token);

-- Create index on user_id
CREATE INDEX IX_user_sessions_user_id ON user_sessions(user_id);

-- Create index on expires_at for cleanup jobs
CREATE INDEX IX_user_sessions_expires_at ON user_sessions(expires_at);

PRINT 'Schema created successfully!';