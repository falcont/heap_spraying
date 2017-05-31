class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.references :votable, polymorphic: true, index: true
      t.column :rating, :integer, default: 0
      t.references :user, index: true
      t.timestamps
    end
  end
end