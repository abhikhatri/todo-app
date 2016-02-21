class AddIsEvaluatorAndInvitationCodeInUsers < ActiveRecord::Migration
  def change
  	add_column :users, :reffered_by_id, :integer
  	add_column :users, :is_evaluator, :boolean, default: false
  	add_column :users, :invitation_code, :string
  	add_column :users, :invite_accepted, :boolean, default: false
  end
end
