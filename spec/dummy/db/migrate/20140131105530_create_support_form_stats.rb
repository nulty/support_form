class CreateSupportFormStats < ActiveRecord::Migration
  def change
    create_table :support_form_stats do |t|
      t.string :stats
      t.string :recipient_email

      t.timestamps
    end
  end

end