-- PostgreSQL version for Render deployment
CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock INTEGER NOT NULL DEFAULT 0,
    reorder_level INTEGER NOT NULL DEFAULT 10,
    image_url VARCHAR(255) DEFAULT '',
    sold INTEGER NOT NULL DEFAULT 0,
    sales DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS inventory_updates (
    id SERIAL PRIMARY KEY,
    product_id INTEGER,
    old_quantity INTEGER,
    new_quantity INTEGER,
    type VARCHAR(50) NOT NULL CHECK (type IN ('sale', 'restock', 'name_change', 'price_change', 'category_change', 'reorder_change', 'add', 'delete', 'update')),
    user_name VARCHAR(100) DEFAULT 'admin',
    old_name VARCHAR(255),
    new_name VARCHAR(255),
    old_price DECIMAL(10, 2),
    new_price DECIMAL(10, 2),
    old_category VARCHAR(100),
    new_category VARCHAR(100),
    old_reorder_level INTEGER,
    new_reorder_level INTEGER,
    product_name VARCHAR(255),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE SET NULL
);

-- Insert sample data
INSERT INTO products (name, category, price, stock, reorder_level, image_url, sold, sales) VALUES
('Wireless Headphones', 'Electronics', 89.99, 5, 10, 'headphones.jpg', 35, 3149.65),
('Smartphone Case', 'Accessories', 19.99, 128, 30, 'case.jpg', 105, 2098.95),
('4K Smart TV', 'Electronics', 699.99, 12, 5, 'tv.jpg', 8, 5599.92),
('Bluetooth Speaker', 'Electronics', 79.99, 32, 8, 'speaker.jpg', 42, 3359.58),
('Gaming Mouse', 'Gaming', 49.99, 0, 15, 'mouse.jpg', 55, 2749.45),
('Mechanical Keyboard', 'Gaming', 129.99, 3, 7, 'keyboard.jpg', 24, 3119.76),
('Tablet Stand', 'Accessories', 24.99, 85, 20, 'stand.jpg', 77, 1924.23)
ON CONFLICT (id) DO NOTHING;