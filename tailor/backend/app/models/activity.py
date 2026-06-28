from app import db
from datetime import datetime


class UserActivity(db.Model):
    __tablename__ = 'user_activities'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    activity_type = db.Column(db.String(20), nullable=False)  # login, logout, order
    description = db.Column(db.String(255), nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

    user = db.relationship('User', backref=db.backref('activities', lazy=True))

    def to_dict(self):
        return {
            'id': self.id,
            'user_id': self.user_id,
            'activity_type': self.activity_type,
            'description': self.description,
            'created_at': self.created_at.isoformat() if self.created_at else None,
        }

    @staticmethod
    def log(user_id: int, activity_type: str, description: str = None):
        activity = UserActivity(
            user_id=user_id,
            activity_type=activity_type,
            description=description,
        )
        db.session.add(activity)
        db.session.commit()
