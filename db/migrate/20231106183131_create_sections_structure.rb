class CreateSectionsStructure < ActiveRecord::Migration[6.0]
  def change
    create_table :classrooms do |t|
      t.string :number, null: false

      t.timestamps

      t.index :number
    end

    create_table :students do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false, unique: true

      t.timestamps

      t.index :last_name
      t.index :email
    end

    create_table :sections do |t|
      t.string :name
      t.references :teacher, foreign_key: true, null: false
      t.references :subject, foreign_key: true, null: false
      t.references :classroom, foreign_key: true, null: false

      t.timestamps
    end

    create_table :student_sections do |t|
      t.references :student, foreign_key: true, null: false
      t.references :section, foreign_key: true, null: false

      t.timestamps
      t.index [:student_id, :section_id], unique: true
    end

    create_table :section_schedules do |t|
      t.references :section, foreign_key: true, null: false
      t.time :start_at, null: false
      t.time :end_at, null: false
      t.string :week_day

      t.timestamps
    end
  end
end
