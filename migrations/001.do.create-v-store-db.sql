BEGIN;

DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS buyer;
DROP TABLE IF EXISTS shop_products;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS shop;
DROP TABLE IF EXISTS users;
DROP TYPE IF EXISTS service_type_enum;
DROP TYPE IF EXISTS user_type_enum;
DROP TYPE IF EXISTS availability_enum;

CREATE TYPE user_type_enum AS ENUM(
    'shop',
    'buyer'
);

CREATE TABLE users(
    id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    username TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    avatar_url TEXT DEFAULT 'default' NOT NULL,
    user_type user_type_enum NOT NULL
);

CREATE TYPE service_type_enum AS ENUM(
    'food and drinks',
    'clothing and accessories',
    'home and party decor',
    'educational',
    'body healing',
    'tattoo and piercing',
    'sports and hobbies',
    'toys and leisure',
    'bath and body'
);

CREATE TABLE shop(
    id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    login_id INTEGER REFERENCES users(id) NOT NULL UNIQUE,
    shop_name TEXT NOT NULL,
    address TEXT NOT NULL,
    description TEXT, 
    start_date DATE DEFAULT NOW(),
    end_date DATE DEFAULT NOW(),
    opening_time TIME DEFAULT '00:00:00',
    closing_time TIME DEFAULT '00:00:00',
    service_type service_type_enum NOT NULL,
    image_url TEXT DEFAULT 'no_url' NOT NULL
);

CREATE TABLE products(
    id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    item TEXT NOT NULL,
    price NUMERIC(9,2) DEFAULT 0.0,
    description TEXT NOT NUll,
    image_url TEXT DEFAULT 'no_url' NOT NULL
);

CREATE TYPE availability_enum AS ENUM(
    'available',
    'sold out'
);

CREATE TABLE shop_products(
    shop_id INTEGER REFERENCES shop(id) NOT NULL,
    product_id INTEGER REFERENCES products(id) NOT NULL,
    availability availability_enum DEFAULT 'available' NOT NULL,
    PRIMARY KEY (shop_id, product_id)
);

CREATE TABLE buyer(
    id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    login_id INTEGER REFERENCES users(id) NOT NULL UNIQUE,
    image_url TEXT DEFAULT 'no_url' NOT NULL,
    name TEXT NOT NULL
);

CREATE TABLE reviews(
    id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    review TEXT NOT NULL,
    rating NUMERIC(3,2) NOT NUll,
    shop_id INTEGER REFERENCES shop(id) NOT NULL,
    buyer_id INTEGER REFERENCES buyer(id) NOT NULL
);

INSERT INTO users (username, password, user_type) VALUES 
    ('shopuser01', '$2a$12$fN64sChSm6YICplSHtc70eM8v3auCG6cdzSjZyP5bCLDE9kDsQQPe', 'shop'),
    ('shopuser02', '$2a$12$fN64sChSm6YICplSHtc70eM8v3auCG6cdzSjZyP5bCLDE9kDsQQPe', 'shop'),
    ('shopuser03', '$2a$12$fN64sChSm6YICplSHtc70eM8v3auCG6cdzSjZyP5bCLDE9kDsQQPe', 'shop'),
    ('shopuser04', '$2a$12$fN64sChSm6YICplSHtc70eM8v3auCG6cdzSjZyP5bCLDE9kDsQQPe', 'shop'),
    ('shopuser05', '$2a$12$fN64sChSm6YICplSHtc70eM8v3auCG6cdzSjZyP5bCLDE9kDsQQPe', 'shop'),
    ('shopuser06', '$2a$12$fN64sChSm6YICplSHtc70eM8v3auCG6cdzSjZyP5bCLDE9kDsQQPe', 'shop');

INSERT INTO shop(login_id, shop_name, address, start_date, end_date, opening_time, closing_time, service_type, description, image_url) VALUES
    (1, 'Flipflops USA', '90 Kent Ave, East River State Park, Brooklyn, NY 11211', CURRENT_DATE-5, CURRENT_DATE+2,  '10:00:00', '22:00:00', 'clothing and accessories', 'Since 2004, we’ve been curating quality flip flops and casual footwear for the beach and beyond. Whatever your mood or style, you’ll find the product to match it.', 'flipflops.png'),
    (2, 'Tullys Coffee', '657C Gates St., Rialto, CA 92376', CURRENT_DATE+1,CURRENT_DATE+3, '12:00:00', '18:00:00', 'food and drinks', 'This "slow and low" ideology is shared by our four handpicked artists, who believe in the craft and care of their work. Follow our journey from San Francisco to Seattle as we meet four artists who add their own special spark to our Tully’s camper.', 'tully.png'  ),
    (3, 'Custom Boards', '9556 James Dr., Romeoville, IL 60446', CURRENT_DATE+1,CURRENT_DATE+3, '12:00:00', '18:00:00', 'sports and hobbies', 'Custom made skateboards has been selling beautifully designed boards for decoration or to even shred if you want. You can even come in with a design and we will try our best to replicate it.', 'customboards.png'  ),
    (4, 'The Toy Barn', '2 Arch Rd., Norman, OK 73072', CURRENT_DATE+1,CURRENT_DATE+3, '12:00:00', '18:00:00', 'toys and leisure', 'From custom made to store brand toys, discover toys you did not know existed!', 'thetoybarn.png'  ),
    (5, 'The Soap Shop', '34 Circle Ave., San Lorenzo, CA 94580', CURRENT_DATE+1,CURRENT_DATE+3, '12:00:00', '18:00:00', 'bath and body', 'Custom made all natural soap. Ranges from many scents such as Lavender, Rosemary, Mangos, and more. Come find your perfect soap!', 'thesoapshop.png'  );
    (6, 'Burgerlicious', '22 Howard Ave., Clinton, MD 20735', CURRENT_DATE+1,CURRENT_DATE+3, '12:00:00', '18:00:00', 'food and drinks', 'Best burgers you can ever try, Made with my family secret ingredients, the taste will leave you speechless!', 'burgerlicious.png'  );


-- INSERT INTO buyer(login_id, name) VALUES
 -- add a buyer profile

INSERT INTO products (item, price, description, image_url) VALUES
    ('Flip Flop 1', 20.00, 'Classic water-resistant flip flops', 'flipflop-1.jpg'),
    ('Flip Flop 2', 30.00, 'Classic water-resistant flip flops', 'flipflop-1.jpg'),
    ('Flip Flop 3', 10.00, 'Classic water-resistant flip flops', 'flipflop-1.jpg'),
    ('Flip Flop 4', 12.00, 'Classic water-resistant flip flops', 'flipflop-1.jpg'),
    ('Flip Flop 5', 14.00, 'Classic water-resistant flip flops', 'flipflop-1.jpg'),
    ('Flip Flop 6', 15.00, 'Classic water-resistant flip flops', 'flipflop-1.jpg'),
    ('Flip Flop 7', 21.00, 'Classic water-resistant flip flops', 'flipflop-1.jpg'),
    ('Hot Blended Coffee', 3.00, 'Green Mountain Coffee Roasters® Breakfast Blend Coffee', 'coffee-1.png'),
    ('Dark Magic', 14.99, 'Green Mountain Coffee Roasters® Dark Magic® Coffee', 'coffee-2.png');

INSERT INTO shop_products (shop_id, product_id) VALUES
    (1,1),
    (1,2),
    (1,3),
    (1,4),
    (1,5),
    (1,6),
    (1,7),
    (2,8),
    (2,9);

COMMIT;