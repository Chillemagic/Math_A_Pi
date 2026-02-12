class CreateChallenges < ActiveRecord::Migration[8.1]
  def change
    create_table :challenges do |t|
      t.string :name
      t.string :module
      t.string :content
      t.string :system_prompt

      t.timestamps
    end
  end
end
