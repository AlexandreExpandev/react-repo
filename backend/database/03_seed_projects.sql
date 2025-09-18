-- Demo Project - Initial Projects Data
-- This file contains sample projects for the demo application

-- Insert demo projects
INSERT INTO projects (name, description, owner_id, status) VALUES
('Website Redesign', 'Complete redesign of the company website with modern UI/UX', 1, 'active'),
('Mobile App Development', 'Native mobile app for iOS and Android platforms', 5, 'active'),
('Database Migration', 'Migrate legacy database to Azure SQL Database', 1, 'completed'),
('API Documentation', 'Create comprehensive API documentation using Swagger', 3, 'active'),
('User Authentication System', 'Implement OAuth2 and JWT authentication', 2, 'active'),
('Performance Optimization', 'Optimize application performance and reduce load times', 5, 'planning'),
('Security Audit', 'Complete security audit and vulnerability assessment', 10, 'active'),
('Cloud Migration', 'Migrate on-premises infrastructure to Azure cloud', 1, 'planning'),
('Data Analytics Dashboard', 'Business intelligence dashboard with real-time analytics', 5, 'active'),
('Automated Testing Suite', 'Implement comprehensive automated testing framework', 3, 'completed');

PRINT 'Projects seeded successfully! Inserted ' + CAST(@@ROWCOUNT AS NVARCHAR(10)) + ' projects.';