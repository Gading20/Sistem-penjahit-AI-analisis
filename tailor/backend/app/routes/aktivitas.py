from flask import Blueprint, jsonify
from flask_jwt_extended import get_jwt_identity, jwt_required
from app import db
from app.models.activity import UserActivity
from datetime import datetime, timedelta

aktivitas_bp = Blueprint('aktivitas', __name__)


@aktivitas_bp.route('/api/aktivitas', methods=['GET'])
@jwt_required()
def get_aktivitas():
    user_id = int(get_jwt_identity())
    limit = 50
    activities = UserActivity.query.filter_by(user_id=user_id)\
        .order_by(UserActivity.created_at.desc())\
        .limit(limit)\
        .all()
    return jsonify({
        "msg": "OK",
        "data": [a.to_dict() for a in activities],
    }), 200
