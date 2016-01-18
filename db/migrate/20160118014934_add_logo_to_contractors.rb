class AddLogoToContractors < ActiveRecord::Migration
  def change
    add_attachment :contractors, :logo
  end
end
