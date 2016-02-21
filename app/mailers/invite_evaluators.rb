class InviteEvaluators < ApplicationMailer

	def invite(emails, user)
		@evaluators = emails
		@user = user
		@evaluators.split(", ").each do |email|
			mail(from: @user.email, to: email, subject: "Todo Timer Invitation")
		end
	end

end