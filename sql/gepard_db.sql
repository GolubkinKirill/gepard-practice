CREATE DATABASE IF NOT EXISTS gepard_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE gepard_db;

CREATE TABLE roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    login VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(150) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    role_id INT NOT NULL,
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
);

CREATE TABLE clients (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    address VARCHAR(255)
);

CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    position VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE services (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    service_name VARCHAR(150) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE requests (
    request_id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    employee_id INT NOT NULL,
    service_id INT NOT NULL,
    request_date DATE NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'Новая',
    comment TEXT,
    FOREIGN KEY (client_id) REFERENCES clients(client_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (service_id) REFERENCES services(service_id)
);

CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    request_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATE,
    payment_status VARCHAR(50) NOT NULL DEFAULT 'Не оплачено',
    FOREIGN KEY (request_id) REFERENCES requests(request_id)
);

INSERT INTO roles (role_name) VALUES
('Администратор'), ('Сотрудник'), ('Пользователь');

INSERT INTO clients (full_name, phone, email, address) VALUES
('Иванов Сергей Петрович', '+79001112233', 'ivanov@mail.ru', 'г. Нижний Новгород'),
('Смирнова Ольга Викторовна', '+79004445566', 'smirnova@mail.ru', 'г. Нижний Новгород'),
('Морозов Дмитрий Андреевич', '+79007778899', 'morozov@mail.ru', 'г. Нижний Новгород');

INSERT INTO employees (full_name, position, phone, email) VALUES
('Петрова Анна Игоревна', 'Менеджер по работе с клиентами', '+79000000001', 'petrova@gepard.ru'),
('Кузнецов Андрей Павлович', 'Специалист по обработке заявок', '+79000000002', 'kuznetsov@gepard.ru');

INSERT INTO services (service_name, description, price) VALUES
('Консультация', 'Первичная консультация клиента', 1500.00),
('Подготовка документов', 'Оформление комплекта документов', 3500.00),
('Сопровождение заявки', 'Сопровождение заявки клиента до завершения', 5000.00);
