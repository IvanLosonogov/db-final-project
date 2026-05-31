WITH RECURSIVE SubordinateHierarchy AS (
    -- Базовый уровень: все сотрудники (как менеджеры)
    SELECT
        ManagerID AS EmployeeID,
        EmployeeID AS SubordinateID
    FROM Employees
    WHERE ManagerID IS NOT NULL

    UNION ALL

    -- Рекурсивный уровень: подчинённые подчинённых
    SELECT
        sh.EmployeeID,
        e.EmployeeID AS SubordinateID
    FROM SubordinateHierarchy sh
    JOIN Employees e ON sh.SubordinateID = e.ManagerID
),
ManagerSubordinateCount AS (
    SELECT
        EmployeeID,
        COUNT(DISTINCT SubordinateID) AS TotalSubordinates
    FROM SubordinateHierarchy
    GROUP BY EmployeeID
),
EmployeeProjects AS (
    SELECT
        e.EmployeeID,
        GROUP_CONCAT(DISTINCT p.ProjectName ORDER BY p.ProjectName SEPARATOR ', ') AS ProjectNames
    FROM Employees e
    LEFT JOIN Projects p ON e.DepartmentID = p.DepartmentID
    GROUP BY e.EmployeeID
),
EmployeeTasks AS (
    SELECT
        e.EmployeeID,
        GROUP_CONCAT(DISTINCT t.TaskName ORDER BY t.TaskName SEPARATOR ', ') AS TaskNames
    FROM Employees e
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
    et.TaskNames,
    msc.TotalSubordinates
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
JOIN Roles r ON e.RoleID = r.RoleID
LEFT JOIN EmployeeProjects ep ON e.EmployeeID = ep.EmployeeID
LEFT JOIN EmployeeTasks et ON e.EmployeeID = et.EmployeeID
JOIN ManagerSubordinateCount msc ON e.EmployeeID = msc.EmployeeID
WHERE r.RoleName = 'Менеджер'
  AND msc.TotalSubordinates > 0
ORDER BY e.Name;