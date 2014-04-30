class AddPostImageToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :image_uid, :string
    add_column :articles, :image_name, :string
  end
end
