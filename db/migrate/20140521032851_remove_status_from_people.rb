class RemoveStatusFromPeople < ActiveRecord::Migration
  def change
    remove_column :people, :status, :string
  end
end
