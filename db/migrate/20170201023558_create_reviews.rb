class CreateReviews < ActiveRecord::Migration
  def self.up
    create_table :reviews do |t|
      t.string :title, :limit => 50, :default => ""
      t.text :review
      t.references :reviewable, :polymorphic => true
      t.references  :reviewer,  :polymorphic => true
      t.integer :rating
      t.string :role, :default => "reviews"
      t.timestamps
    end

    add_index :reviews, :reviewer_id
    add_index :reviews, :reviewer_type
    add_index :reviews, [:reviewer_id, :reviewer_type]
    add_index :reviews, [:reviewable_id, :reviewable_type]
  end

  def self.down
    drop_table :reviews
  end
end
