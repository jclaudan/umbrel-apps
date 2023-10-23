"""empty message

Revision ID: d73fc7833958
Revises: 1a89015d90bd
Create Date: 2017-01-30 00:42:05.089748

"""

# revision identifiers, used by Alembic.
revision = 'd73fc7833958'
down_revision = '1a89015d90bd'

from alembic import op
import sqlalchemy as sa
import sqlalchemy_utils


def upgrade():
    ### commands auto generated by Alembic - please adjust! ###
    op.add_column('speaker', sa.Column('gender', sa.String(), nullable=True))
    ### end Alembic commands ###


def downgrade():
    ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('speaker', 'gender')
    ### end Alembic commands ###
