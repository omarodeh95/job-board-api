class CreateJobPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :job_posts do |t|
      t.belongs_to :user, foreign_key: true
      t.string :title, limit: 50, null: false 
      t.string :description, limit: 500, null: false
      
      t.timestamps
    end
  end
end
