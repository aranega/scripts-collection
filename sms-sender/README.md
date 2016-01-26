# Send SMS

`sms` is a very simple script to send SMS using command line. The SMS is sent
with your phone through [mySMS](http://www.mysms.com/). Contacts are stored
in file on your local FS (the script could fetch contacts using the mySMS API,
but... meh).

## Requirements

This script uses a lot of bash associative arrays (2) so `Bash >= 4` is
required. Calls to send the SMS are performed using `cURL`, sooooo I guess
you need `cURL`. Also, you need the [mySMS App](https://play.google.com/store/apps/details?id=com.mysms.android.sms) (this
link is for Android, I'm sure you can find the one for iPhone on your own).
To sum up:

* Bash >= 4,
* cURL,
* mySMS app on your phone.

## Installation & Configuration

Installation is quite simple:

1. clone the repository (or copy the `sms` file content)
1. set execution right
1. put the file `.phone-contacts` into your `$HOME`

Now, you need to edit the `sms` script in order to enter your
API key and auth token:

    AUTHTOKEN=  # Put your auth token here    (line 4)
    APIKEY=     # Put you API Key here        (line 5)

That's all!

### Add Contacts

In order to add new contacts (basically `name=num` mapping), you have to
edit your `~/.phone-contacts` and manually add them. Each number must have
the international format (e.g., `+IDxxxxxxx`).

## Usage

Syntax is this: `sms CONTACT "MESSAGE"`. Example, assuming I entered a "me" contact
with my phone number:

    $ sms me "Hello World :)"
    Sending SMS to 'me (+33xxxxxxxxx)'... OK

## Command Line Auto-completion

If typing the whole name of your contact is like a kick in the nuts, you can
relies on the bash autocomplete. In order to enable it, simply copy the
`autocomplete/sms` file in your `/etc/bash_completion.d/` and restart your
terminal:

    $ cp autocomplete/sms /etc/bash_completion.d/
    $ # restart your terminal or 'exec bash'

Enjoy!

    $ sms [TAB][TAB]
    me  cill_blinton  the_dude_i_never_remember_his_name  jack
    ... etc
