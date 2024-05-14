db.createUser(
    {
      user: "siteUserAdmin",
      pwd: "sAEncuz7ftjVZYFh-2QTRR",
      roles: [ { role: "userAdminAnyDatabase", db: "admin" } ]
    }
  )