# docker-chef

Docker image for chefdk. Allows to run Chef from Docker. Enables local Chef cookbook development without installing Chef.

## Using chef-solo

	$ docker run -v $PWD/config.json:/tmp/config.json -v $PWD/solo.rb:/tmp/solo.rb chef-solo chef-solo -c /tmp/solo.rb -j /tmp/config.json

### docker-compose

	$ docker-compose run chefsolo -c solo.rb -j config.json

## Using Berkshelf

Creating a cookbook:

	$ docker run -v $PWD/src:/src chefdk berks cookbook test_cookbook /src

Installing dependencies:

	$ docker run -v $PWD/src:/src chefdk berks install -b /src/Berksfile
	Resolving cookbook dependencies...
	Fetching 'test_cookbook' from source at .
	Fetching cookbook index from https://supermarket.chef.io...
	Using test_cookbook (0.1.0) from source at .

### docker-compose

	$ docker-compose run berks cookbook test_cookbook /src

	$ docker-compose run berks install -b /src/Berksfile

## Using Test Kitchen

This image also allows to run integration test with the help of Test Kitchen and Docker.

	$ docker run -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):$(which docker) -v $PWD/.kitchen.yml:/src/.kitchen.yml chefdk kitchen converge

### docker-compose

	$ docker-compose run kitchen converge

## Using chef-client

If you use Chef server pass **validation.pem** and **client.rb** as a volume:

	$ docker run -v $PWD/validation.pem:/etc/chef/validation.pem -v $PWD/client.rb:/etc/chef/client.rb chefdk chef-client
	[2015-03-20T07:33:57+00:00] INFO: Forking chef instance to converge...
	[2015-03-20T07:33:57+00:00] WARN:
	* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	SSL validation of HTTPS requests is disabled. HTTPS connections are still
	encrypted, but chef is not able to detect forged replies or man in the middle
	attacks.

	To fix this issue add an entry like this to your configuration file:

	```
	# Verify all HTTPS connections (recommended)
	ssl_verify_mode :verify_peer

	# OR, Verify only connections to chef-server
	verify_api_cert true
	```

	To check your SSL configuration, or troubleshoot errors, you can use the
	`knife ssl check` command like so:

	```
	knife ssl check -c /etc/chef/client.rb
	```

	* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	[2015-03-20T07:33:57+00:00] INFO: *** Chef 11.18.0 ***
	[2015-03-20T07:33:57+00:00] INFO: Chef-client pid: 6
	[2015-03-20T07:33:58+00:00] INFO: Client key /etc/chef/client.pem is not present - registering
	[2015-03-20T07:33:59+00:00] INFO: HTTP Request Returned 404 Not Found: Cannot load node 0562ea72145e
	[2015-03-20T07:33:59+00:00] INFO: Run List is []
	[2015-03-20T07:33:59+00:00] INFO: Run List expands to []
	[2015-03-20T07:33:59+00:00] INFO: Starting Chef Run for 0562ea72145e
	[2015-03-20T07:33:59+00:00] INFO: Running start handlers
	[2015-03-20T07:33:59+00:00] INFO: Start handlers complete.
	[2015-03-20T07:33:59+00:00] INFO: HTTP Request Returned 404 Not Found: No routes match the request: /reports/nodes/0562ea72145e/runs
	[2015-03-20T07:34:00+00:00] INFO: Loading cookbooks []
	[2015-03-20T07:34:00+00:00] WARN: Node 0562ea72145e has an empty run list.
	[2015-03-20T07:34:00+00:00] INFO: Chef Run complete in 0.900438874 seconds
	[2015-03-20T07:34:00+00:00] INFO: Running report handlers
	[2015-03-20T07:34:00+00:00] INFO: Report handlers complete

### docker-compose

	$ docker-compose run chefclient
