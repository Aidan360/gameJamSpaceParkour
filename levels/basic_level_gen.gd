extends Node3D
#painfullly large array;
# every section has a number of paths 
# every paths has a number of obstacles saved 
var levelDat = []

var objectPath = "res://levels/objectGen/simpleObjectGen.tscn"

func _ready():
	#generateObstacle(Vector3(randi_range(-10,10),randi_range(-10,10),randi_range(-10,10)))
	#generateLevel()
	#generateObstacle(Vector3(0,0,0),false) 
	#generateSection(Vector3(0,10,0))
	generatePath(2,Vector3(10,0,0),50)
	#genPolarVector(Vector3(0,1,0),5,10) # cylinder of 5 radius and 10 height
#generates a level 
func generateLevel():
	for item in 2:
		var num = item * 30 + 1
		generatePath(5,Vector3(10,0,0),50)
	#	generateSection(Vector3(0,5,0))
#	for item in 5:
#		generateObstacle(Vector3(randi_range(0,10),randi_range(0,10),randi_range(0,10)))
#	pass


func generatePath(nodes,location,sectionLength):	
	var pathCoords = []
	pathCoords.append(location)
	for item in nodes: # generates a series of coordinates first
		# offsets
		var xO = pathCoords[-1][0]
		var yO = pathCoords[-1][1]
		var zO = pathCoords[-1][2]
		var sectionRadius = sqrt(3 * pow(sectionLength,2))/2
		var newX = randi_range(xO - sectionRadius,xO + sectionRadius)
		var newY = randi_range(yO,yO + sectionRadius)
		var newZ = randi_range(zO - sectionRadius,zO + sectionRadius)
		pathCoords.append(Vector3(newX,newY,newZ))
		pass
	
	# now actually generating the path
	for item in pathCoords:
		var orient
		if item == pathCoords[-1]: 
			orient = Vector3(0,0,0)
		else:
			var num = pathCoords.find(item)
			print(num)
			orient = pathCoords[num + 1]
			print(orient)
		generateSection(item,orient)
		


#generates a section with a checkpoint, maybe seperate things via themeing? 
func generateSection(location,orientation):
	var newSectionData = []
	#generateObstacle(location,false) 
	var newNode = Node3D.new()
	newNode.global_position = Vector3(0,0,0)
	$".".add_child(newNode)
	for item in 100: # 3 checkpoints   wper section?? could be randomized
#		var i = randVector(location,0,50)
		var i = genPolarVector(1,5,50)
		var newObj = load(objectPath).instantiate()
		newObj.position = i
		newNode.add_child(newObj)
	pass
	newNode.position = location
	newNode.look_at(-orientation,Vector3(0,1,0))
func randVector(offset,rangeL,rangeH):
	var vectorX = randf_range(offset[0] + rangeL, offset[0] + rangeH)
	var vectorY = randf_range(offset[1] + rangeL, offset[1] + rangeH)
	var vectorZ = randf_range(offset[2] + rangeL, offset[2] + rangeH)
	return(Vector3(vectorX,vectorY,vectorZ))


func genPolarVector(offset,radius,height): # FAHHHHH
	# to basically explain, a random polar coordinate is generated within a cylindrical planar system
	# a random theta value is chosen. 
	var randTheta = randf_range(0,2*PI)
	var randRadius = randf_range(0,radius)
	var lZ = randf_range(0,height)
	var lX = randRadius * cos(randTheta)
	var lY = randRadius * sin(randTheta)
	#var lZ = 0
	#var lX = 0
	#var lY = 1
	var localVector = Vector3(lX,lY,lZ)
	
	
	# code chunk of shame
	
	
	# FUCK I NEED LIENAR ALGEBRA AHHHHHHHHHHHHHHHHHHHHHHHHHHH
	# uhhh fuck fuck fuck fuck fuck fuck fuck fuck
	# so first we gotta rotate it along a vector direction??? 
	# so it goes from one line then it rotates it to another direction to sorta think about it?? 
	## nvm no linear algebra 
	## aidan lock in remember odometry 
	## shift cartesain coodrinate of each object into two polar spaces, 
	## two polar systems of xy, and xz, then rotate the angle to match new vector 
	## new vector back into cartesian. 
	## add Vector origin as offset after cartesian angle 
	## should work??
	#
	## also i do technically need to do the radial cylinder  -> cartesian -> spherical -> cartesian 
	#var tempAdjustVector = Vector3(1,1,1) # should generate an angle of 45 along the xz plane
	##okay so spherical coordinate transfer for r,theta,phi. 
	##sR = Spherical Radial, sT = Spherical theta, sP = Spherical phi
	#var sR = localVector.length()
	#var sT = atan2(lX,lY)
	#var sP = acos(lZ/sR)
	#if sT < -PI:  #so we found out that angles have to be between -PI and PI for Theta but not PHI??
		#print("ntrue")
	##if sP < 0.1: # phi has ranges of pi/2 - 0?? larger then 1
	##	print("true")
	##print("theta: " + str(sT) + " phi: " + str(sP))
	##tranfer Theta tT, transfer Phi tP. 
	#var tT = atan2(tempAdjustVector[0],tempAdjustVector[1])
	#var tR = tempAdjustVector.length()
	#var tP = acos(tempAdjustVector[2]/tR)
	##print("theta Adjust: " + str(tT) + " phi Adjust: " + str(tP))
	## new Theta, new Phi (nT, nP)
	#var nT = sT 
	#var nP = sP 
	# nt has a range of PI, -PI
	#if nT > PI: # if an angle is more than PI  - 2PI
		#nT = nT - 2*PI
		#print("fix Upper nT")
	#elif nT < -PI: # if its less then PI  add two pi 
		#nT = nT + 2*PI
		#print("fix lower nT")
	## nP has a range of PI/2 - 0??? /
	#if nP > PI:
		#nP = nP - 2*PI
		#print("fix upper nP")
	#elif nP < 0:
		#nP = nP + 2*PI
		#print("fix lower nP")
	#print("theta New: " + str(nT) + " phi Phi: " + str(nP))
	## final x,y,z is just x,y,z
	#var x = sR*sin(nP)*cos(nT)
	#var y = sR*sin(nP)*sin(nT)
	#var z = sR*cos(nP) 
	##print("X angles combined: " + str(sin(nP)*cos(nT)))
	#var returnVector = Vector3(x,y,z)
	#return(returnVector)
	# i can't beleive how badly i fucked up lmaoooo



	return(localVector)
#generates a basic obstacled
func generateObstacle(loc,randSize):
	var newObj = load(objectPath).instantiate()
	newObj.position = loc
	if randSize == true:
		var uniform = randf_range(1,1.1)
		newObj.setSize(Vector3(uniform,uniform,uniform))
	else:
		newObj.setSize(Vector3(0.5,0.5,0.5))
	#levelDat.append(newObj)
	#$".".add_child(newObj)
	return newObj
	pass
	
