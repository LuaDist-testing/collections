package.moonpath = "./src/?.moon;" .. package.moonpath
require "set"


describe "Set", ->
	describe "#new", ->
		it "accepts missing initial contents", ->
			assert.not.nil Set!

		it "accepts an initial array", ->
			assert.not.nil Set { 1, 2, 3 }

		it "accepts an initial Set", ->
			assert.not.nil Set(ArrayList { 1, 2, 3 })


	describe "#insert", ->
		context "with a nil item", ->
			it "errors", ->
				list = Set!
				assert.errors -> list\insert 1, nil

		context "with a non-nil item", ->
			context "with a valid index", ->
				it "works", ->
					list = Set!
					list\insert 1, 5
					assert.equal 5, list\get 1
					assert.same { 1 }, list.indices[5]

				it "works", ->
					list = Set { 1, 2, 4 }
					list\insert 3, 3
					assert.equal 3, list\get 3
					assert.equal 4, list\get 4

				it "pushes indices back one", ->
					list = Set { 1, 2, 4 }
					list\insert 3, 3
					assert.same { 3 }, list.indices[3]
					assert.same { 4 }, list.indices[4]

				it "doesn't allow duplicate items", ->
					list = Set { 1, 2, 3, 4 }
					list\insert 1, 3
					assert.same { 3 }, list.indices[3]

			context "with an invalid index", ->
				context "less than 1", ->
					it "errors", ->
						list = Set!
						assert.errors -> list\insert 0, 5

				context "greater than list's size plus 1", ->
					it "errors", ->
						list = Set!
						assert.errors -> list\insert 2, 5


	describe "#add", ->
		context "with a nil item", ->
			it "errors", ->
				list = Set!
				assert.errors -> list\add nil

		context "with a non-nil item", ->
			it "works", ->
				list = Set!
				list\add 5
				assert.equal 5, list\get 1
				assert.same { 1 }, list.indices[5]

			it "works", ->
				list = Set { 1, 2, 3 }
				list\add 4
				assert.equal 4, list\get 4
				assert.same { 4 }, list.indices[4]


	describe "#add_all", ->
		context "with a nil collection", ->
			it "errors", ->
				list = Set!
				assert.errors -> list\add_all nil

		context "with an array", ->
			it "works", ->
				list = Set!
				list\add_all { 1, 2, 3 }
				assert.equal 1, list\get 1
				assert.equal 2, list\get 2
				assert.equal 3, list\get 3

		context "with an ArrayList", ->
			it "works", ->
				list = Set!
				list\add_all ArrayList { 1, 2, 3 }
				assert.equal 1, list\get 1
				assert.equal 2, list\get 2
				assert.equal 3, list\get 3


	describe "#index_of", ->
		context "with a nil item", ->
			it "errors", ->
				list = Set { 1, 2, 3 }
				assert.errors -> list\index_of nil

		context "with an invalid item", ->
			it "returns nil", ->
				list = Set { 1, 2, 3 }
				assert.nil list\index_of 5

		context "with a valid singular item", ->
			it "works", ->
				list = Set { 1, 2, 3 }
				assert.equal 2, list\index_of 2

		context "with a valid duplicate item", ->
			it "works", ->
				list = Set { 1, 2, 3, 2 }
				assert.equal 2, list\index_of 2


	describe "#indices_of", ->
		context "with a nil item", ->
			it "errors", ->
				list = Set { 1, 2, 3 }
				assert.errors -> list\indices_of nil

		context "with an invalid item", ->
			it "returns nil", ->
				list = Set { 1, 2, 3 }
				assert.nil list\indices_of 5

		context "with a valid singular item", ->
			it "works", ->
				list = Set { 1, 2, 3 }
				assert.same { 2 }, list\indices_of 2


	describe "#contains", ->
		context "with a nil item", ->
			it "errors", ->
				list = Set { 1, 2, 3 }
				assert.errors -> list\contains nil

		context "with a non-nil item in the Set", ->
			it "returns true", ->
				list = Set { 1, 2, 3 }
				assert.true list\contains 3

		context "with a non-nil item not in the Set", ->
			it "returns false", ->
				list = Set { 1, 2, 3 }
				assert.false list\contains 5
				

	describe "#remove_at", ->
		context "with a nil index", ->
			it "errors", ->
				list = Set { 1, 2, 3 }
				assert.errors -> list\remove_at nil

		context "with an out-of-range index", ->
			it "errors", ->
				list = Set { 1, 2, 3 }
				assert.errors -> list\remove_at 4

		context "with a valid index", ->
			it "works", ->
				list = Set { 1, 2, 3 }
				list\remove_at 2
				assert.equal 1, list\get 1
				assert.equal 3, list\get 2

			it "decrements indices", ->
				list = Set { 1, 2, 3 }
				list\remove_at 2
				assert.same { 2 }, list.indices[3]


	describe "#remove", ->
		context "with a nil item", ->
			it "errors", ->
				list = Set { 1, 2, 3 }
				assert.errors -> list\remove nil

		context "with an item not in the Set", ->
			it "errors", ->
				list = Set { 1, 2, 3 }
				assert.errors -> list\remove 4

		context "with a valid item in the Set", ->
			it "works", ->
				list = Set { 1, 2, 3 }
				list\remove 2
				assert.equal 1, list\get 1
				assert.equal 3, list\get 2

			it "deletes relevant indices", ->
				list = Set { 1, 2, 3 }
				list\remove 2
				assert.same nil, list.indices[2]

			it "decrements indices", ->
				list = Set { 1, 2, 3 }
				list\remove 2
				assert.same { 2 }, list.indices[3]


	describe "#remove_all", ->
		context "with a nil collection", ->
			it "errors", ->
				list = Set { 1, 2, 3 }
				assert.errors -> list\remove_all nil

		context "with an array", ->
			it "works", ->
				list = Set { 1, 2, 3 }
				list\remove_all { 1, 3 }
				assert.equals 1, list\size!
				assert.equals 2, list\get 1

		context "with an ArrayList", ->
			it "works", ->
				list = Set { 1, 2, 3 }
				list\remove_all ArrayList { 1, 3 }
				assert.equals 1, list\size!
				assert.equals 2, list\get 1
	

	describe "#map", ->
		context "with a nil function", ->
			it "errors", ->
				list = Set { 1, 2, 3 }
				assert.errors -> list\map nil

		context "with a non-function", ->
			it "errors", ->
				list = Set { 1, 2, 3 }
				assert.errors -> list\map 5

		context "with a function", ->
			it "works", ->
				list = Set { 1, 2, 3 }
				result = list\map (item) -> 5
				assert.equal 5, result\get(1), result\get(2), result\get(3)


	describe "#filter", ->
		context "with a nil predicate", ->
			it "errors", ->
				list = Set { 1, 2, 3 }
				assert.errors -> list\filter nil

		context "with a non-function", ->
			it "errors", ->
				list = Set { 1, 2, 3 }
				assert.errors -> list\filter 5

		context "with a function", ->
			it "works", ->
				list = Set { 1, 2, 3 }
				result = list\filter (item) -> item == 2
				assert.equal 1, result\size!
				assert.equal 2, result\get 1


	describe "#unique", ->
		it "works", ->
			list = Set { 1, 2, 1, 3, 2, 3 }
			result = list\unique!
			assert.equal 3, result\size!
			assert.equal 1, result\get 1
			assert.equal 2, result\get 2
			assert.equal 3, result\get 3


	describe "#foreach", ->
		context "with a nil consumer", ->
			it "errors", ->
				list = Set { 1, 2, 3 }
				assert.errors -> list\foreach nil

		context "with a non-function consumer", ->
			it "errors", ->
				list = Set { 1, 2, 3 }
				assert.errors -> list\foreach 5

		context "with a valid consumer", ->
			it "works", ->
				list = Set { 1, 2, 3 }
				value = 0
				list\foreach (item) -> value += item
				assert.equal 6, value

