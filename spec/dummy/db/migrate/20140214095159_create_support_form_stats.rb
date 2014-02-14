class CreateSupportFormStats < ActiveRecord::Migration
  def change
    create_table :support_form_stats do |t|
      t.string     :categories
      t.string     :recipient_email
      t.belongs_to :supportable, polymorphic: true

      t.timestamps
    end
  end

end