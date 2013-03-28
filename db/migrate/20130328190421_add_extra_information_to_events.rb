class AddExtraInformationToEvents < ActiveRecord::Migration
  def change
    add_column :events, :more_info, :text
  end
end
