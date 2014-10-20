#Require necessary files
require './ImageArray.rb'
#Set variables
convertCheck = 0
arrayForImage3 = []
#Get input from user and file
puts "What image would you like?(start with ./ and end with .jpg) (./test.jpg is a penguin)"
direc = gets.chomp
puts "How would you like to edit the image? (flip, rotate (Only works on squares), lines)"
changes = gets.chomp.downcase
imageRow = ImageArray.new(direc)
#Convert ImageArray to Array
arrayForImage = []
        imageRow.each do |pixelRow|
                arrayForImageRow = []
                pixelRow.each do |pixel|
                        arrayForImageRow.push(pixel)
                end
                arrayForImage.push(arrayForImageRow)
        end
#Run the correct program based on the input
if changes == "flip"
	#Flip the image
	pos = 0
	arrayForImage.each do |pixelRow|
                pos = pos + 1
        	arrayForImage3.push(pixelRow.reverse)
        end
	convertCheck = 1
elsif changes == "rotate"
	#Rotate the image
	pos = 0
	arrayForImage = arrayForImage.transpose
	arrayForImage.each do |pixelRow|
                pos = pos + 1
                arrayForImage3.push(pixelRow.reverse)
        end
	convertCheck = 1
elsif changes == "lines"
	#Set Variables
	maxIntensityPercent = 0.75
	col = 1
	#Insert lines of color across the image
	imageRow.each do |pixelRow|
		col = col + 1
		pixelRow.each do |pixel|
			maxIntensity = imageRow.max_intensity
			maxIntensity2 = (((maxIntensity * maxIntensityPercent)) / (arrayForImage.length)).to_f
			pixel.red = ((maxIntensity2 * col) - pixel.red)
                	pixel.blue = ((maxIntensity2 * col) - pixel.blue)
                	pixel.green = ((maxIntensity2 * col) - pixel.green)
		end
	end
else
	#Send out an error for not selecting a valid option
	puts "Error: no option chosen"
end
if convertCheck == 1
	#Convert the Array back to an ImageArray
	arrayForImage3.each.with_index do |arrayForImageRow, i|
		arrayForImageRow.each.with_index do |pixel, j|
			imageRow[i][j] = pixel
		end
	end
end
#Write back to a file
puts "The file is in your public html, to access it go to the url Https://cs.westport.k12.ct.us/~(your username)."
imageRow.write(File.expand_path("~/public_html/outputPhoto.jpg"))
