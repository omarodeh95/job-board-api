class CreateJobApplications < ActiveRecord::Migration[6.1]
  def change
    create_table :job_applications do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :job_post, foreign_key: true
      t.string :status, default: 'Not Seen'
      t.index [:user_id, :post_id]

      t.timestamps
    end
  end
end
