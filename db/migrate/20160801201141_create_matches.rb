class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string :x_player, null: false
      t.string :o_player, null: false
      t.string :channel, null: false
      t.timestamp :accepted_at
      t.string :board
      t.string :current_turn, default: 'x'
      t.integer :turns_taken_count, null: false, default: 0
      t.text :status
      t.string :winner_char
      t.text :winner_username

      t.timestamps null: false
    end
  end
end
