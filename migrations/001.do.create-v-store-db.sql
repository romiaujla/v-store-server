BEGIN;

DROP TABLE IF EXISTS seller_products;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS seller;
DROP TABLE IF EXISTS users;
DROP TYPE IF EXISTS service_type_enum;
DROP TYPE IF EXISTS user_type_enum;

CREATE TYPE user_type_enum AS ENUM(
    'seller',
    'buyer'
);

CREATE TABLE users(
    id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    username TEXT NOT NULL,
    password TEXT NOT NULL,
    user_type user_type_enum NOT NULL
);

CREATE TYPE service_type_enum AS ENUM(
    'food & drink',
    'clothing and accessories',
    'tattoo service',
    'fortune telling',
    'body healing',
    'educational'
);

CREATE TABLE seller(
    id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    login_id INTEGER REFERENCES users(id) NOT NULL UNIQUE,
    shop_name TEXT NOT NULL,
    address TEXT NOT NULL,
    start_time TIMESTAMP DEFAULT NOW(),
    end_time TIMESTAMP DEFAULT NOW(),
    service_type service_type_enum NOT NULL 
);

CREATE TABLE products(
    id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    item TEXT NOT NULL,
    price NUMERIC(9,2) DEFAULT 0.0
);

CREATE TABLE seller_products(
    seller_id INTEGER REFERENCES seller(id) NOT NULL,
    product_id INTEGER REFERENCES products(id) NOT NULL,
    PRIMARY KEY (seller_id, product_id)
);

COMMIT;