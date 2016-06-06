class VoteController < ApplicationController
	def index
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
		return redirect_to root_url, notice: 'Captcha ou código de verificação inválidos' unless resp
		v = Voto.find_by_nusp(resp[:nusp])
		if v
			# TODO: Test this
			v.update(voto: (params[:vote].to_i != 0))
			status = 'alterado'
		else
			@vote = Voto.create(name: resp[:name], vote: (params[:vote].to_i != 0), nusp: resp[:nusp], rg: resp[:rg])
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

end
