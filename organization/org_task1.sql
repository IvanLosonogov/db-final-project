WITH RECURSIVE EmployeeHierarchy AS (
    -- Базовый уровень: сам Иван Иванов
    SELECT
        EmployeeID,
        Name,
        ManagerID,
        DepartmentID,
        RoleID
    FROM Employees
    WHERE EmployeeID = 1

    UNION ALL

    -- Рекурсивный уровень: подчинённые
    SELECT
        e.EmployeeID,
        e.Name,
        e.ManagerID,
        e.DepartmentID,
        e.RoleID
    FROM Employees e
    INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
),
EmployeeProjects AS (
    SELECT
        e.EmployeeID,
        GROUP_CONCAT(DISTINCT p.ProjectName ORDER BY p.ProjectName SEPARATOR ', ') AS ProjectNames
    FROM EmployeeHierarchy e
    LEFT JOIN Projects p ON e.DepartmentID = p.DepartmentID
    GROUP BY e.EmployeeID
),
EmployeeTasks AS (
    SELECT
        e.EmployeeID,
        GROUP_CONCAT(DISTINCT t.TaskName ORDER BY t.TaskName SEPARATOR ', ') AS TaskNames
    FROM EmployeeHierarchy e
    LEFT JOIN Tasks t ON e.EmployeeID = t.AssignedTo
    GROUP BY e.EmployeeID
)
SELECT
    e.EmployeeID,
    e.Name AS EmployeeName,
    e.ManagerID,
    d.DepartmentName,
    r.RoleName,
    ep.ProjectNames,
    et.TaskNames
FROM EmployeeHierarchy e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
JOIN Roles r ON e.RoleID = r.RoleID
LEFT JOIN EmployeeProjects ep ON e.EmployeeID = ep.EmployeeID
LEFT JOIN EmployeeTasks et ON e.EmployeeID = et.EmployeeID
ORDER BY e.Name;