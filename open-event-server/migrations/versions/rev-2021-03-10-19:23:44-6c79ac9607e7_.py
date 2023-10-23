"""empty message

Revision ID: 6c79ac9607e7
Revises: a3b434b69b63
Create Date: 2021-03-10 19:23:44.897827

"""

from alembic import op
import sqlalchemy as sa
import sqlalchemy_utils


# revision identifiers, used by Alembic.
revision = '6c79ac9607e7'
down_revision = 'a3b434b69b63'


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('sessions', sa.Column('mastadon', sa.String(), nullable=True))
    op.add_column('speaker', sa.Column('mastadon', sa.String(), nullable=True))
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('speaker', 'mastadon')
    op.drop_column('sessions', 'mastadon')
    # ### end Alembic commands ###
