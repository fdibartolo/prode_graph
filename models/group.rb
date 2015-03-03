class Group < ActiveRecord::Base
  has_and_belongs_to_many :users

  def create_node! neo
    node = Neography::Node.create("group_id" => self.id, "name" => self.name)
    neo.add_label(node, "Group")
    node.add_to_index("group_index", "name", self.name)
    node
  end
end