class loja_virtual::db{
    include loja_virtual
    include mysql::server
    include loja_virtual::params
    loja_virtual::db {$loja_virtual::params::db['user']:
        schema      =>  $loja_virtual::params::db['schema'],
        password    =>  $loja_virtual::params::db['password'],
    }   
}

define loja_virtual::db($schema, $user = $title, $password){
    Class['mysql::server'] -> Mysql::Db[$title]
    exec { "$title-schema":
        unless  =>  "mysql -uroot $schema",
        command =>  "mysqladmin -uroot create $schema",
        path        =>  "/usr/bin/",
        require =>  Class["mysql::server"],
    }
    exec { "$title-user":
        unless  =>  "mysql -u$user -p$password $schema",
        command =>  "mysql -uroot -e \"GRANT ALL PRIVILEGES ON \
                                       $schema.* TO $user \
                                       IDENTIFIED BY '$password';\"",
        path    =>  "/usr/bin/",
        require =>  Exec["$title-schema"],
    }
}