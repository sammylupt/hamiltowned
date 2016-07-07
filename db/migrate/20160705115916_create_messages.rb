class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :sender_first_name
      t.string :recipient_first_name
      t.string :recipient_email
      t.date   :date_to_send
      t.boolean :sent, default: false
      t.timestamps
    end
  end
end
