class User < ActiveRecord::Base
  has_and_belongs_to_many :groups

  def create_node! neo
    node = Neography::Node.create("user_id" => self.id, "nick_name" => self.nick_name)
    neo.add_label(node, "Person")
    node.add_to_index("person_index", "nick_name", self.nick_name)
    node
  end
end