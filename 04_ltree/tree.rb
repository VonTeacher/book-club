$tree_dataset = [
  { path: "1.4", position: 1 },
  { path: "1.2.22", position: 0 },
  { path: "1.3", position: 2 },
  { path: "1.4.8", position: 1 },
  { path: "1.2.22.10", position: 0 },
  { path: "1.5", position: 3 },
  { path: "1", position: 0 },
  { path: "1.4.9", position: 2 },
  { path: "1.2", position: 0 },
  { path: "1.5.11", position: 0 },
  { path: "1.2.7", position: 1 },
  { path: "1.3.12", position: 0 },
  { path: "1.6", position: 4 },
  { path: "1.4.8.13", position: 0 },
  { path: "1.2.22.10.14", position: 0 },
  { path: "1.5.11.15", position: 0 },
  { path: "1.6.16", position: 0 },
  { path: "1.3.12.17", position: 0 },
  { path: "1.6.16.18", position: 0 },
  { path: "1.4.9.19", position: 0 }
]

# The above data represents a tree structure, nodes are uniquely identified through a path of IDs,
# starting from the root down to the specific node. This path is a string format consisting of IDs separated
# by dots (.), where the leftmost ID represents the root, and each subsequent ID indicates a child node as
# one descends through the tree.

# For example, the path "19.56.45" corresponds to a node with ID 45, which is a child of node 56, itself a
# child of the root node 19.

# Your task is to implement the following in ruby:

# You may use any string methods and array/hash methods to help you solve the problem (map, sort, filter, ...).
# All functions must be pure (do not modify the original data)

# 1. self_and_descendants
# Signature: selfAndDescendants(path: string): Array<number>
# Input: path - a string representing the path of IDs from the root to a specific node.
# Output: A list of IDs for the node identified by path and all its descendants, starting with the ID of the
# node specified by path, followed by the IDs of its descendants in no particular order.
# If the path does not lead to a valid node, return an empty list.
def self_and_descendants(path)
  # sad_results = []
  # $tree_dataset.each do |item|
  #   if item[:path].include?(path.to_s)
  #     sad_results << item[:path]
  #   end
  # end
  # sad_results

  $tree_dataset.select do |item|
    item[:path].include?(path.to_s)
  end.map { |e| e[:path] }
end

# 2. move_node
# Signature: moveNode(currentPath: string, newPath: string): Array<Hash>
# Operation: Moves the node identified by currentPath to the path identified by newPath.
# Inputs:
# currentPath - the current path string that identifies the node to be moved.
# newPath - the path string that identifies the new path of the node.
# position - the new position of the node relative to it's new siblings.
# Output: An array of hashes representing the new tree structure after the move operation.
# array should contain the path and position of the node.
def move_node(current_path, new_path, position)
  throw('ID must stay the same') if current_path.split(".").last != new_path.split(".").last

  moved_set = []

  $tree_dataset.each do |item|
    # anything matching current_path
    if item[:path].include?(current_path)
      new_node = { path: item[:path].gsub(current_path, new_path), position: position }
      moved_set << new_node
    # gotta shift the other nodes' positions on the new_path level (x.y in this case)
    elsif item[:path].split(".").length == new_path.split(".").length
      moved_node = { path: item[:path], position: item[:position] + 1 }
      moved_set << moved_node
    # don't care about sub-levels
    else
      moved_set << item
    end
  end
  moved_set
end

# 3. children
# Signature: children(path: string): Array<Hash>
# Input: path - a string representing the path of IDs from the root to a specific node.
# Output: An array of hashes representing the children of the node identified by path ORDERED BY POSITION.
def children(path)
  # child_set = []
  # $tree_dataset.each do |item|
  #   # children have one more node length than parent path
  #   # '1' as parent has children with only '1.x' path
  #   if (item[:path].split(".").length == path.split(".").length + 1)
  #     child_set[item[:position]] = item
  #   end
  # end
  # child_set

  parent_level = path.split(".").length

  $tree_dataset.select do |item|
    item[:path].split(".").length == parent_level + 1 # ['1', '2'].length = ['1'].length + 1
  end.sort_by { |e| e[:position] }
end

raise 'self_and_descendants failed' unless self_and_descendants('1.2').sort == ["1.2", "1.2.22", "1.2.22.10", "1.2.22.10.14", "1.2.7"]
moved = [{:path=>"1.4", :position=>2}, {:path=>"1.22", :position=>0}, {:path=>"1.3", :position=>3}, {:path=>"1.4.8", :position=>1}, {:path=>"1.22.10", :position=>0}, {:path=>"1.5", :position=>4}, {:path=>"1", :position=>0}, {:path=>"1.4.9", :position=>2}, {:path=>"1.2", :position=>1}, {:path=>"1.5.11", :position=>0}, {:path=>"1.2.7", :position=>1}, {:path=>"1.3.12", :position=>0}, {:path=>"1.6", :position=>5}, {:path=>"1.4.8.13", :position=>0}, {:path=>"1.22.10.14", :position=>0}, {:path=>"1.5.11.15", :position=>0}, {:path=>"1.6.16", :position=>0}, {:path=>"1.3.12.17", :position=>0}, {:path=>"1.6.16.18", :position=>0}, {:path=>"1.4.9.19", :position=>0}]
raise 'move_node failed' unless move_node('1.2.22', '1.22', 0).map(&:to_s).sort == moved.map(&:to_s).sort
raise 'children failed' unless children('1') == [{path:"1.2", position: 0}, {path:"1.4", position: 1}, {path:"1.3", position: 2}, {path:"1.5", position: 3},{path:"1.6", position: 4}]
