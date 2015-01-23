Coinbase API with Ruby -- The Basics
====================================

The other day I became super interested in the Implementation Engineer [role](https://www.coinbase.com/careers/) over at [Coinbase](https://www.coinbase.com/). I figured the best way to know if this was a good fit was to first test their product from a development standpoint. I'll go ahead and show the end result of a few minutes of dabbling:

<img src="coinbase-with-ruby-4.png">

All this can become yours! Just keep reading.

I had used Bitcoin across other apps and had a Bitcoin account before, but I'd never really traded much. I certainly hadn't dove into the backend of how a bitcoin API functions.

Bitcoin's API is incredibly straightforward and easy to use. What do I love most? It's [well supported with Ruby](https://github.com/coinbase/coinbase-ruby)! This made my life a lot easier as this (Ruby) is where my comfort zone is developing.

Let me walk you through some of the basic take-aways I had from exposing myself to Coinbase's API.

### Background on Coinbase API ###

First, you should check out the API docs for yourself. Go [here](https://www.coinbase.com/docs/api/overview) to get started. At a high level, the Coinbase API is a simple REST API that supports all of the core bitcoin operations, such as:

* Buying / selling 
* Sending / Requsting via email / BTC address
* Exchanging to local currency
* Accept payments
* Storing securely
* Wallet creation & management
* Access raw network data, including blocks, transactions and addresses
* Manage micro-transactions and recurring payments

### Working with Ruby ###

* [Signup](https://www.coinbase.com/) for a Coinbase account.
* [Enable an API Key](https://www.coinbase.com/settings/api) on your CoinBase Account

<img src="coinbase-with-ruby-1.png">

* Get your machine started with:

    gem install coinbase

### [HMAC](http://en.wikipedia.org/wiki/Hash-based_message_authentication_code) Auth: ###

First off, HMAC is wicked cool and in my humble view a bit complicated to wrap your head around at first. A great deep dive on the content is on [security exchange](http://security.stackexchange.com/questions/20129/how-when-do-i-use-hmac) -- which is definitely worht the time if you have it. Coinbase [talks security](https://www.coinbase.com/docs/api/authentication) in their API docs as well. 

For the purposes of this simple tutorial, however, you just need to know that in order to clear HMAC auth you'll need to [go to your account settings](https://www.coinbase.com/settings/api) and setup an API Key. If you're unsure which type of key to use, here's a quick reference:

<img src="coinbase-with-ruby-2.png">

Now you can start using some Ruby to play with Coinbase. First, create a client instance and pass it the API key and Secret from your Coinbase account. 

    coinbase = Coinbase::Client.new(ENV['COINBASE_API_KEY'], ENV['COINBASE_API_SECRET'])

Make sure not to share your API Key or Secret with ANYONE! The reason we use environment variables (and the [Ruby accessor](http://www.ruby-doc.org/core-2.2.0/ENV.html)) instead of hard coding it in is because you could expose your account to mailicious users. It's generally a good security practice to hide your API Keys -- read more [here](https://www.coinbase.com/docs/api/authentication#security).

In practice for most Ruby apps or lightweight apps (ie Sinatra) this would be easy to implement by adding the Key and Secret to your config YAML file. Make sure to ```.gitignore``` this file so you don't end up pushing it to your public repository.

Here's what your process flow for that might look like if you're operating from CL:

    cd [your-coinbase-script-directory]
    git init
    touch config.yaml
    echo "COINBASE_API_KEY: abcdefg12345" >> config.yaml
    echo "COINBASE_API_SECRET: abcdefg12345abcdefg12345" >> config.yaml
    touch .gitignore
    echo "config.yaml" >> .gitignore
    git add .


Now you can store your variables locally and load them up in your script. Here's a snippet from the script I've been playing with to give you a sense of how this might work:

    #!/usr/bin/env ruby

    require 'yaml'
    require 'coinbase'

    secrets = YAML::load(File.open('data.yml'))

    # Test to make sure your secrets are working
    # puts secrets['COINBASE_API_KEY']
    # puts secrets['COINBASE_API_SECRET']

    coinbase = Coinbase::Client.new(secrets['COINBASE_API_KEY'], secrets['COINBASE_API_SECRET'])
    balance = coinbase.balance.to_s


As you can see, the implementation is very basic and super powerful. There are tons of other options that you can implement on the Coinbase Github [Repo](https://github.com/coinbase/coinbase-ruby) alongside great resource materials as well. I cannot recommend enough the utility of this page! 

### Coinbase Tip Implementation: ###

So if all this API implementation stuff is too much to handle and you just want a super easy and quick solution to get bitcoin on your personal website, then look no further. Coinbase has an elegant solution for that.

Visit the [Coinbase Tip](https://www.coinbase.com/tip#tip-creation-form) page and enter your custom URL. Coinbase does the dirty work and spits out an integrated JS script for drag and drop functionality in most major websites. This is very similar to the drag and drop functionality of most major web-apps: such as instagram, twitter, strava, facebook, etc.

Here's a sample of what the code might look like:


	<div class="cb-tip-button" data-content-location="http://austinhay.com" data-href="//www.coinbase.com/tip_buttons/show_tip" data-to-user-id="54b2fbcb0c639c8be50000c5"></div>
	<script>!function(d,s,id) {var js,cjs=d.getElementsByTagName(s)[0],e=d.getElementById(id);if(e){return;}js=d.createElement(s);js.id=id;js.src="https://www.coinbase.com/assets/tips.js";cjs.parentNode.insertBefore(js,cjs);}(document, 'script', 'coinbase-tips');</script>


### Issues: ###

1.) Broken/defunct link referenced as, "api reference," on the Github Coinbase-Ruby page. 

The dead link is this:

https://coinbase.com/api/doc

Possible new links could be:

* <a href="https://www.coinbase.com/docs/api/overview">https://www.coinbase.com/docs/api/overview</a>
* <a href="https://developers.coinbase.com/api">https://developers.coinbase.com/api</a>

2.) Broken/defunct links for the Python, Ruby and Java examples in the [API docs](https://www.coinbase.com/docs/api/authentication#) for authentication:

<img src="coinbase-with-ruby-3.png">

After these two, I started hitting some other dead, redirect links. It would be good for them to crawl their API docs and check for these, but otherwise this was a solid showing and I thought everything was very well wwritten and intuitive.

### Need More? ###

Beyond personal implementation the next accomplishment is merchant setup. There are some great [examples](https://www.coinbase.com/docs/merchant_tools/examples) with some well known names that can demonstrate OAuth and merchant setup using the API. There's even an [OAuth tutorial](https://www.coinbase.com/docs/api/oauth_tutorial)! If you needed more, this would be the best place to start.