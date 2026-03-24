extends Node3D
#painfullly large array;
# every section has a number of paths 
# every paths has a number of obstacles saved 
var levelDat = []

var objectPath = "res://levels/objectGen/simpleObjectGen.tscn"

func _ready():
	#generateObstacle(Vector3(randi_range(-10,10),randi_range(-10,10),randi_range(-10,10)))
	#generateLevel()
	generateSection(Vector3(0,1,0))
	genPolarVector(Vector3(0,1,0),5,10) # cylinder of 5 radius and 10 height
#generates a level 
func generateLevel():
	for item in 5:
		var num = item * 30 + 1
		generateSection(Vector3(num,0,0))
#	for item in 5:
#		generateObstacle(Vector3(randi_range(0,10),randi_range(0,10),randi_range(0,10)))
#	pass
#generates a section with a checkpoint, maybe seperate things via themeing? 
func generateSection(location):
	var newSectionData = []
	generateObstacle(location,false) 
	for item in 500: # 3 checkpoints   wper section?? could be randomized
#		var i = randVector(location,0,50)
		var i = genPolarVector(1,15,20)
		generateObstacle(Vector3(i[0],i[1],i[2]),true)
	pass
func randVector(offset,rangeL,rangeH):
	var vectorX = randf_range(offset[0] + rangeL, offset[0] + rangeH)
	var vectorY = randf_range(offset[1] + rangeL, offset[1] + rangeH)
	var vectorZ = randf_range(offset[2] + rangeL, offset[2] + rangeH)
	return(Vector3(vectorX,vectorY,vectorZ))


func genPolarVector(offset,radius,height): # FAHHHHH
	# to basically explain, a random polar coordinate is generated within a cylindrical planar system
	# a random theta value is chosen. 
	var randTheta = randf_range(0,2*PI)
	print(randTheta)
	var randRadius = randf_range(0,radius)
	print(randRadius*180/PI) 
	var localY = randf_range(0,height)
	var localX = randRadius * cos(randTheta)
	var localZ = randRadius * sin(randTheta)
	print("x: " + str(localX) + " y:" +str(localY) + " z: " + str(localZ))
	var localVector = Vector3(localX,localY,localZ)
	# FUCK I NEED LIENAR ALGEBRA AHHHHHHHHHHHHHHHHHHHHHHHHHHH
	# uhhh fuck fuck fuck fuck fuck fuck fuck fuck
	# so first we gotta rotate it along a vector direction??? 
	# so it goes from one line then it rotates it to another direction to sorta think about it?? 
	# 



#generates a basic obstacled
func generateObstacle(loc,randSize):
	var newObj = load(objectPath).instantiate()
	newObj.position = loc
	if randSize == true:
		var uniform = randf_range(1,1.1)
		newObj.setSize(Vector3(uniform,uniform,uniform))
	else:
		newObj.setSize(Vector3(0.5,0.5,0.5))
	levelDat.append(newObj)
	$".".add_child(newObj)
	
	pass
	
