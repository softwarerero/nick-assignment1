Queries.allow
  insert: (userId, col) -> allow4User
  update: (userId, col) -> allow4User
  remove: (userId, col) -> allow4User
    
    
allow4User = (userId, col) -> query.userId is userId 