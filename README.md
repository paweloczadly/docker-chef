1. Run chefdk container:

	docker run --name chefdk -ti chefdk

2. Download cookbooks:

	docker run --name cookbooks -v $PWD/Berkshelf:/tmp/Berkshelf -v /tmp/cookbooks --volumes-from chefdk debian:wheezy /opt/chefdk/bin/berks vendor -b /tmp/Berkshelf/Berksfile /tmp/cookbooks

3. Execute chef-solo:

	docker run --name jenkins -v $PWD/chef-solo:/tmp/chef-solo --volumes-from chefdk --volumes-from cookbooks debian:wheezy /opt/chefdk/bin/chef-solo -o jenkins::master -c /tmp/chef-solo/solo.rb


