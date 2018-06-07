package.moonpath = "./src/?.moon;" .. package.moonpath
require "collection"
require "array_list"
require "set"
require "util.class"


describe "instance_of", ->
	it "works", ->
		list = ArrayList!
		assert.truthy instance_of list, ArrayList

	it "works with inheritance", ->
		list = ArrayList!
		assert.truthy instance_of list, Collection

	it "works with inheritance", ->
		set = Set!
		assert.truthy instance_of set, ArrayList

	it "works with inheritance", ->
		set = Set!
		assert.truthy instance_of set, Collection

