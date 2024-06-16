USE taskdb;

CREATE TABLE mentee_task (
    rollno INT AUTO_INCREMENT PRIMARY KEY,
    task_name VARCHAR(255) NOT NULL,
    submission_status VARCHAR(255) NOT NULL,
    domain_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO menteetask (rollno,task_name,submission_status,domain_name) VALUES
('10206322', 'Task 1', 'submitted', 'webdev'),
('10823344', 'Task 2', 'pending', 'sysad');
