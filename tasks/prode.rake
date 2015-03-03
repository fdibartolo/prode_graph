require 'active_record'
require 'neography'
Dir['./models/*.rb'].each {|f| require f}

configuration = YAML::load(IO.read('config/database.yml'))
ActiveRecord::Base.establish_connection(configuration['development'])

@neo = Neography::Rest.new

namespace :graph do
  desc "build graph with users and groups playing in"
  task :build do
    group_nodes = {}
    User.all.each do |user|
      user_node = user.create_node! @neo
      user.groups.each do |group|
        if group_nodes.keys.include? group.id
          group_node = group_nodes[group.id]
        else
          group_node = group.create_node! @neo
          group_nodes[group.id] = group_node
        end
        
        @neo.create_relationship("PLAYS_IN", user_node, group_node)
      end

      print_progress if user.id % 100 == 0
    end
  end

  desc "clean all nodes and relationships"
  task :clean_all do
    @neo.execute_query("MATCH (n) OPTIONAL MATCH (n)-[r]-() DELETE n,r")
  end
end

def print_progress
  print '.'
  $stdout.flush
end