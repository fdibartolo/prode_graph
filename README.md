## POC Graph Database for ComunidadProde with ruby and [neo4j](http://neo4j.com/)

Install neo4j locally, for instance

  `$ rake neo4j:install[community,2.1.7]`

Build graph out of ComunidadProde local database (15000 users, 3000 user groups)

  `$ rake graph:build`
