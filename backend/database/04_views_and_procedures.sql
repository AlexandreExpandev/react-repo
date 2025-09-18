-- Demo Project - Views and Stored Procedures
-- This file contains useful views and procedures for the demo application

-- Create view for user project summary
CREATE VIEW user_project_summary AS
SELECT
    u.id as user_id,
    u.name as user_name,
    u.email,
    u.role,
    COUNT(p.id) as total_projects,
    COUNT(CASE WHEN p.status = 'active' THEN 1 END) as active_projects,
    COUNT(CASE WHEN p.status = 'completed' THEN 1 END) as completed_projects,
    COUNT(CASE WHEN p.status = 'planning' THEN 1 END) as planning_projects
FROM users u
LEFT JOIN projects p ON u.id = p.owner_id
GROUP BY u.id, u.name, u.email, u.role;

-- Create view for project details with owner info
CREATE VIEW project_details AS
SELECT
    p.id as project_id,
    p.name as project_name,
    p.description,
    p.status,
    p.created_at as project_created,
    p.updated_at as project_updated,
    u.id as owner_id,
    u.name as owner_name,
    u.email as owner_email,
    u.role as owner_role
FROM projects p
INNER JOIN users u ON p.owner_id = u.id;

-- Stored procedure to get user statistics
CREATE PROCEDURE GetUserStatistics
    @user_id INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF @user_id IS NULL
    BEGIN
        -- Return stats for all users
        SELECT
            'All Users' as scope,
            COUNT(*) as total_users,
            COUNT(CASE WHEN role = 'admin' THEN 1 END) as admin_users,
            COUNT(CASE WHEN role = 'user' THEN 1 END) as regular_users,
            (SELECT COUNT(*) FROM projects) as total_projects,
            (SELECT COUNT(*) FROM projects WHERE status = 'active') as active_projects
        FROM users;
    END
    ELSE
    BEGIN
        -- Return stats for specific user
        SELECT
            u.name as user_name,
            u.email,
            u.role,
            u.created_at as user_since,
            ups.total_projects,
            ups.active_projects,
            ups.completed_projects,
            ups.planning_projects
        FROM users u
        LEFT JOIN user_project_summary ups ON u.id = ups.user_id
        WHERE u.id = @user_id;
    END
END;

-- Stored procedure to cleanup expired sessions
CREATE PROCEDURE CleanupExpiredSessions
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @deleted_count INT;

    DELETE FROM user_sessions
    WHERE expires_at < GETDATE();

    SET @deleted_count = @@ROWCOUNT;

    PRINT 'Cleaned up ' + CAST(@deleted_count AS NVARCHAR(10)) + ' expired sessions.';

    SELECT @deleted_count as sessions_deleted;
END;

-- Function to check if user is admin
CREATE FUNCTION IsUserAdmin(@user_id INT)
RETURNS BIT
AS
BEGIN
    DECLARE @is_admin BIT = 0;

    SELECT @is_admin = CASE WHEN role = 'admin' THEN 1 ELSE 0 END
    FROM users
    WHERE id = @user_id;

    RETURN ISNULL(@is_admin, 0);
END;

PRINT 'Views and procedures created successfully!';