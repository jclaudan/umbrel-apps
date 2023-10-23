"""empty message

Revision ID: e73500f7f7d9
Revises: 54f963bee31a
Create Date: 2021-07-04 18:58:12.247483

"""

from alembic import op
import sqlalchemy as sa
import sqlalchemy_utils


# revision identifiers, used by Alembic.
revision = 'e73500f7f7d9'
down_revision = '54f963bee31a'


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('events', sa.Column('is_oneclick_signup_enabled', sa.Boolean(), nullable=True, server_default='False'))
    op.add_column('events_version', sa.Column('is_oneclick_signup_enabled', sa.Boolean(), autoincrement=False, nullable=True))
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('events_version', 'is_oneclick_signup_enabled')
    op.drop_column('events', 'is_oneclick_signup_enabled')
    # ### end Alembic commands ###
