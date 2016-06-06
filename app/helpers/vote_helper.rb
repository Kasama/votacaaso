module VoteHelper
	def mask_nusp(nusp)
		n = nusp.to_s
		n[2] = '*'
		n[3] = '*'
		n[4] = '*'
		n
	end

	def mask_rg(rg)
		r = rg.to_s
		puts "RG IS : #{rg}"
		r[2] = '*'
		r[3] = '*'
		r[4] = '*'
		r[5] = '*'
		r[6] = '*'
		r
	end
end
