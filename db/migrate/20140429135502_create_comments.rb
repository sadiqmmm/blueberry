class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :author_name
      t.string :email
      t.text :body
      t.references :article, index: true

      t.timestamps
    end
  end
end
