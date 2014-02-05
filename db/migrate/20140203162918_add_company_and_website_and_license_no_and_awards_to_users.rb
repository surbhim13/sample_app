class AddCompanyAndWebsiteAndLicenseNoAndAwardsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :company, :string
    add_column :users, :website, :string
    add_column :users, :license_no, :string
    add_column :users, :awards, :string
  end
end
