"""empty message

Revision ID: 414c776ae509
Revises: 24271525a263
Create Date: 2023-08-10 00:00:08.837497

"""

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '414c776ae509'
down_revision = '24271525a263'


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('orders', sa.Column('access_code_id', sa.Integer(), nullable=True))
    op.create_foreign_key(u'orders_access_code_id_fkey', 'orders', 'access_codes', ['access_code_id'], ['id'], ondelete='SET NULL')
    op.add_column('ticket_holders', sa.Column('is_discount_applied', sa.Boolean(), nullable=True))
    op.add_column('ticket_holders', sa.Column('is_access_code_applied', sa.Boolean(), nullable=True))
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('ticket_holders', 'is_access_code_applied')
    op.drop_column('ticket_holders', 'is_discount_applied')
    op.drop_constraint(u'orders_access_code_id_fkey', 'orders', type_='foreignkey')
    op.drop_column('orders', 'access_code_id')
    # ### end Alembic commands ###

