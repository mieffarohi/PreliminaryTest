-- Status tables
CREATE TABLE ku_user_status (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE ku_user_location_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE ku_user_location_status (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE ku_order_status (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE ku_order_detail_status (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE ku_product_status (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

-- Core tables
CREATE TABLE ku_user (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    password_hash TEXT,
    salt TEXT,
    photo TEXT,
    status INT REFERENCES ku_user_status(id),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE ku_user_location (
    id SERIAL PRIMARY KEY,
    type INT REFERENCES ku_user_location_type(id),
    status INT REFERENCES ku_user_location_status(id),
    user_id INT REFERENCES ku_user(id),
    location VARCHAR(100),
    address TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE ku_order (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES ku_user(id),
    status INT REFERENCES ku_order_status(id),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE ku_product (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    effective_date DATE,
    effective_until DATE,
    photo TEXT,
    price DECIMAL(10,2),
    status INT REFERENCES ku_product_status(id),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE ku_category (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE ku_product_category (
    id SERIAL PRIMARY KEY,
    product_id INT REFERENCES ku_product(id),
    category_id INT REFERENCES ku_category(id),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE ku_order_detail (
    id SERIAL PRIMARY KEY,
    user_location_id INT REFERENCES ku_user_location(id),
    order_id INT REFERENCES ku_order(id),
    product_id INT REFERENCES ku_product(id),
    quantity INT,
    delivery_date DATE,
    status INT REFERENCES ku_order_detail_status(id),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);