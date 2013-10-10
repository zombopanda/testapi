class CreateOptIns < ActiveRecord::Migration
  def change
    create_table :opt_ins do |t|
      t.string :email
      t.string :mobile
      t.string :first_name
      t.string :last_name
      t.string :permission_type
      t.string :channel
      t.string :company_name
      t.timestamps
    end

    add_index :opt_ins, [:channel, :company_name], unique: true
  end
end
