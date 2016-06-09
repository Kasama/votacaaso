class VoteController < ApplicationController
	def index
		@saved = params
	end

	def help
	end

	def results
		@votes = Voto.all
	end

	def vote
		cookie = session[:current_user_id]
		captcha = params[:chars].strip
		resp = USP.verify(cookie, captcha, params[:code].chomp.strip)
		return redirect_to root_url(params.permit(:code, :reason, :vote)),
			notice: 'Captcha ou código de verificação inválidos' unless resp
		vote =  case params[:vote].to_i
						when 0
							false
						when 1
							true
						else
							nil
						end
		v = Voto.find_by_nusp(resp[:nusp])
		if v
			update = {vote: vote}
			reason = params[:reason].chomp.strip
			update[:reason] = reason unless reason.nil? || reason.empty?
			v.update(update)
			status = 'alterado'
		else
			@vote = Voto.create(
					name: resp[:name],
					nusp: resp[:nusp],
					rg: mask_rg(resp[:rg]),
					course: resp[:course],
					institute: resp[:institute],
					reason: params[:reason].chomp.strip,
					vote: vote
			)
			status = 'computado'
		end
		redirect_to results_url, notice: "Seu voto foi #{status} com sucesso! Obrigado"
	end

	def captcha
		cookie = USP.cookie
		session[:current_user_id] = cookie
		captcha = USP.captcha(cookie)

		send_data captcha, type: 'image/png', disposition: 'inline'
	end

		private

	include VoteHelper
end
