# Copyright © 2026 Gading Ilham Saputra. All rights reserved.
# This code is proprietary and confidential. Unauthorized copying, modification,
# distribution, or use of this code is strictly prohibited without written permission.

import os
from dotenv import load_dotenv
from sqlalchemy import create_engine, text

load_dotenv()

DB_HOST = os.getenv('DB_HOST', 'localhost')
DB_PORT = os.getenv('DB_PORT', '3306')
DB_NAME = os.getenv('DB_NAME', 'tailorlink_db')
DB_USER = os.getenv('DB_USER', 'root')
DB_PASSWORD = os.getenv('DB_PASSWORD', '')

engine = create_engine(f'mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}')

with engine.connect() as conn:
    result = conn.execute(
        text("SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA=:db AND TABLE_NAME='user_activities'"),
        {'db': DB_NAME}
    )
    count = result.scalar()
    if count == 0:
        conn.execute(text("""
            CREATE TABLE user_activities (
                id INT AUTO_INCREMENT PRIMARY KEY,
                user_id INT NOT NULL,
                activity_type VARCHAR(20) NOT NULL,
                description VARCHAR(255) NULL,
                created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (user_id) REFERENCES users(id)
            )
        """))
        conn.execute(text("CREATE INDEX idx_activities_user_id ON user_activities(user_id)"))
        conn.execute(text("CREATE INDEX idx_activities_created_at ON user_activities(created_at)"))
        conn.commit()
        print('Tabel user_activities berhasil dibuat!')
    else:
        print('Tabel user_activities sudah ada.')

print('Done.')
