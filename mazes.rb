class Maze

	attr_accessor :maze
	attr_accessor :visited
	attr_accessor :row
	attr_accessor :col
	attr_accessor :trace
#     Represent a n by m maze in an appropriately designed class called Maze. 
#     Each position in the maze can be designated by two coordinates, x (across) and y (down).
#     For a 4x5 maze the top row of positions (x,y) would be (0,0), (1,0), (2, 0) and (3,0).
#     The constructor of the Maze class should take two parameters for n and m. Note of course 
#     that you need to represent the walls between cells not just the cells.
	def initialize (n,m)
		@row = 2*m + 1
		@col = 2*n + 1
		@maze = []
		@visited = Array.new(row){Array.new(col) {|x| x = false}}
		@trace = []

	end


#     Implement a Maze load(arg) method that initializes the maze 
#     using a string of ones and zeros as above
	def load(s)
		(0..row-1).each do |i|
			x = []
			s[i*col..i*col+col-1].each_char {|j| x.push(j)}
			maze.push(x)
		end
	end

#     Implement a Maze display method that prints a diagram of the maze on the console. 
#     It can be just a simple character based printout like above or any other format you want.
	def display()
		maze.each do|x| 
			x.each {|j| print j}
			puts
		end
	end

#     Implement a Maze solve(begX, begY, endX, endY) method that determines if there’s a way to walk 
#     from a specified beginning position to a specified ending position. 
#     Of course it can return an error or false if there is now way.
	def solve(begX, begY, endX, endY)
		if begX == endX && begY == endY
			trace.push([endX, endY])
			return true
		else
			visited[begX][begY] = true
			#go up
			if  self.check(begX, begY + 1)
				trace.push([begX, begY + 1])
				if solve(begX, begY + 1, endX, endY)
					return true
				end
			end
			####check!!!!!!!!!!!!
			trace.pop()

			#go left
			if check(begX - 1, begY)
				trace.push([begX - 1, begY])
				if solve(begX - 1, begY, endX, endY)
					return true
				end
			end
			####check!!!!!!!!!!!!
			trace.pop()

			#go right
			if check(begX + 1, begY)
				trace.push([begX + 1, begY])
				if solve(begX + 1, begY, endX, endY)
					return true
				end
			end
			####check!!!!!!!!!!!!
			trace.pop()

			#go down
			if check(begX, begY - 1)
				trace.push([begX, begY - 1])
				if solve(begX, begY - 1, endX, endY)
					return true
				end
			end
			####check!!!!!!!!!!!!
			trace.pop()					

		end

		return false
	end

	def check(x,y)
		return maze[x][y] == "0" && !visited[x][y]
	end
#     Implement a Maze trace(begX, begY, endX, endY) method that is just like solve() 
#     but traces the positions that the solution visits.
	# def trace()
	# 	return trace
	# end

#     Implement a Maze redesign() which will reset all the cells and walls 
#     and come up with a random new maze of the same size. There are lots of algorithms out there to do this. 
#     	Feel free to google for ideas, but the code you hand in should be your own.
	def redesign()
		r_maze= maze {|r,c| r_maze[r][c].to_i}
		(1..row-2).each {|r| (1..col-2).each {|c| r_maze[r][c] = Random.rand(2).to_s}}
		return r_maze
	end


end

maze = Maze.new(4,4)
maze.load("111111111100010001111010101100010101101110101100000101111011101100000101111111111")
maze.display()
puts maze.solve(1,1,7,7)