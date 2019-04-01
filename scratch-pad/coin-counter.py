from SimpleCV import Image, Blob, Display
import numpy as np
disp = Display(displaytype='notebook')
image_url ="https://s3.amazonaws.com/skarlekar-ffmpeg/raw/53_cents_small.jpg"
coin_diameter_values = np.array([
[ 19.05, 0.01],
[ 21.21, 0.05],
[ 17.7, 0.10],
[ 24.26, 0.25]]);
img = Image(image_url)
img.save(disp)
coins = img.invert().findBlobs(minsize = 500)
px2mm = coin_diameter_values[3,0] / max([c.radius()*2 for c in coins])
i=0
value = 0.0
for c in coins:
    i=i+1
    # Find the diameter of this coin blob & normalize to the calibration factor
    # ie., find the diameter in millimeter of this coin.
    diameter_in_mm = c.radius() * 2 * px2mm
    # Get an array of values for difference between this coin and all the US Mint coins.
    distance = np.abs(diameter_in_mm - coin_diameter_values[:,0])
    #print "Coin diameter: " , diameter_in_mm, " Distance: ", distance
    # Find the coin with the smallest difference. This is our best guess on the coin type.
    index = np.where(distance == np.min(distance))[0][0]
    # Get the value of the coin and add it to the total amount
    coinValue = coin_diameter_values[index, 1]
    value += coinValue
    coinImg = c.crop()
    print "Coin value is ${0}".format(coinValue)
    # coinImg.drawText(str(coinValue))
    coinImg.save(disp)
message = "The total value of the coins is ${0}".format(value)
print message
