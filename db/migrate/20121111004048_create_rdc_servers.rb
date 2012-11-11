class CreateRdcServers < ActiveRecord::Migration
  def change
    create_table :rdc_servers do |t|
      t.string :typename
      t.string :spec
      t.integer :cost1
      t.integer :cost2
      t.integer :num

      t.timestamps
    end
  end
end
