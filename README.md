# FlexStock Inventory Management API

RESTful API for inventory management system built with PHP.

## API Endpoints

- `GET /backend/api/` - API information
- `GET /backend/api/products` - Get all products  
- `GET /backend/api/products?id=1` - Get single product
- `POST /backend/api/products` - Create product
- `PUT /backend/api/products?id=1` - Update product
- `DELETE /backend/api/products?id=1` - Delete product
- `GET /backend/api/updates` - Get inventory updates

## Environment Variables

- `DATABASE_URL` - Full database connection string
- `DB_HOST` - Database host
- `DB_NAME` - Database name  
- `DB_USER` - Database user
- `DB_PASS` - Database password

## Deployment

Supports deployment to:
- Render (PostgreSQL)
- Railway (MySQL/PostgreSQL)
- Traditional hosting (MySQL)