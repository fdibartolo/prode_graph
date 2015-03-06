class Team < ActiveRecord::Base
  def create_node! neo
    node = Neography::Node.create("team_id" => self.id, "name" => self.name)
    neo.add_label(node, "Team")
    node.add_to_index("team_index", "name", self.name)
    node
  end
end