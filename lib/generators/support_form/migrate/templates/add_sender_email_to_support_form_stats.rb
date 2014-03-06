class AddSenderEmailToSupportFormStats < ActiveRecord::Migration
  def change
    add_column :support_form_stats, :sender_email, :string
  end
end
