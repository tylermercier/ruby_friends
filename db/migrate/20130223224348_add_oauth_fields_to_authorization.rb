class AddOauthFieldsToAuthorization < ActiveRecord::Migration
  def up
    add_column :authorizations, :token, :string
    add_column :authorizations, :secret, :string
  end

  def down
    remove_column :authorizations, :token
    remove_column :authorizations, :secret
  end
end
