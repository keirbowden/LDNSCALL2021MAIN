# London's Calling 21 - Packages for the Masses

Repository for the "Happy Soup" demonstrated in my London's Calling 2021 session.

## Installation

If you are using a scratch org, simply push the metadata using the following command :

`sfdx force:source:push -u <username>`

or for a developer edition, deploy the metadata using the command :

`sfdx force:source:deploy -p force-app -u <username>`

where `<username>` is the username for the org you want to install the package into, that you have previously authenticated using the CLI.

Then install the org-dependent package - you can find details of this in the package repo : bobbuzz.me.uk/LC2021PKG