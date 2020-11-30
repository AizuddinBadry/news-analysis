Redis.current = Redis.new(url:  'redis://postgres-db.apps.fasttrade.my',
                          port: '6379',
                          db:   0)