class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.string :hostname
      t.string :ip_addr1

      t.timestamps
    end
  end
end
