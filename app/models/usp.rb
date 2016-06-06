class USP
	class << self

		def cookie
			resp = get(path)
			resp.response['set-cookie']
		end

		def captcha(cookie)
			header = {
				'Cookie' => cookie,
				'Referer' => "#{host}#{path}"
			}
			resp = get(captcha_path, header)
			resp.body
		end

		def verify(cookie, captcha, code)
			code = parse_code code
			return false unless code
			resp = {
				chars: captcha,
				codctl1: code[0], codctl2: code[1],
				codctl3: code[2], codctl4: code[3]
			}
			header = {
				'Cookie' => cookie,
				'Referer' => "#{host}#{path}",
				'Content-Type' => 'application/x-www-form-urlencoded'
			}
			resp = post(path, resp.to_query, header)
			if /pdf/.match resp.content_type
				ret = parse_pdf resp.body
				return false unless ret
				ret
			else
				false
			end
		end

			private

		def parse_code(code)
			code = code.gsub(/[-|_]/, '')
			ret = code.scan(/.{4}/m)
			return false unless ret.size == 4
			ret
		end

		def parse_pdf(pdf)
			ret = {}
			text = read_pdf pdf
			return false unless %r{atestado(:?\s+de\s+matr[i|Í]cula)?}i =~ text

			name_regex = %r{,\s+que\s+([^,]+),}ix
			name = name_regex.match(text).captures.first
			ret[:name] = name

			rg_regex = %r{RG\s+([^,]+)}ix
			rg = rg_regex.match(text).captures
			rg = rg.first.gsub(/\D/, '')
			ret[:rg] = rg

			nusp_regex = %r{USP\s+([^,]+)}ix
			nusp = nusp_regex.match(text).captures.first
			ret[:nusp] = nusp

			puts "-----------------"
			puts text
			puts "-----------------"

			course_regex = %r{curso\s+d.\s+([^,]+),}ix
			course = course_regex.match(text).captures.first
			ret[:course] = course

			ret
		end

		def read_pdf(pdf)
			io = StringIO.new pdf
			reader = PDF::Reader.new(io)
			text = ''
			reader.pages.each do |p|
				text << p.text
			end
			text
		end

		def gen_http
			http = Net::HTTP.new(host, 443)
			http.use_ssl = true
			http
		end

		def post(path, data = {}, header = nil)
			http = gen_http
			http.post(path, data, header)
		end

		def get(path, header = nil)
			http = gen_http
			http.get(path, header)
		end

		def host
			'uspdigital.usp.br'
		end

		def path
			'/webdoc/mostradocweb'
		end

		def captcha_path
			'/webdoc/CriarImagemTuring'
		end
	end
end
