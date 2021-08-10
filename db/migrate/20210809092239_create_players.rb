class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    # For making it simple, I'll add cryptography to the password
    # If I would, probably I would create a service to generate a HASH/KEY
    # and store it on MongoDB or Dynamo, then user will use such HASH/KEY
    # for validating all next requests.
    # or maybe use something like AuthZERO or AWS's COGNITO
    # even 'Login With <some social media SSO>' 
    create_table :players do |t|
      t.string :email, index: {unique: true}
      t.string :username, index: {unique: true}
      t.string :password, null: false

      t.timestamps
    end
  end
end
