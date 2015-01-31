module HeightHelper

	def height_cm(data)
		nums = data.split("'")
		return (30.48 * nums[0].to_i + 0.394 * nums[1].to_i).round(2)
	end

end