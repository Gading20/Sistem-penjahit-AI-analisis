# Copyright © 2026 Gading Ilham Saputra. All rights reserved.
# This code is proprietary and confidential. Unauthorized copying, modification,
# distribution, or use of this code is strictly prohibited without written permission.

from dotenv import load_dotenv
load_dotenv()

from app import create_app

app = create_app()

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
