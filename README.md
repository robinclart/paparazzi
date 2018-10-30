# Paparazzi

Paparazzi allows you to browse a website or web application and take nice looking screenshots using macOS's `screencapture` tool which is what is used when you run the `Cmd-Shift-4, Space, Click` combo. Paparazzi can currently take
screenshots using Firefox and Safari on macOS.

## Prerequisites

For **Firefox** you'll need the following components installed before being able to run this utility:

- Firefox (can be installed using `brew cask install firefox`)
- `geckodriver` (can be installed using `brew install geckodriver`)

And for **Safari** you'll need the following done:

- Run `safaridriver --enable` to allow safari to be controlled remotely.

## Installation

Clone this repo, then cd into it and run the following to install the executable:

```
$ bundle
$ rake install
```

Once this is done you'll be able to run a playbook like so:

```
$ paparazzi playbook.rb
```

You can also omit the playbook extension.

## Playbook

A playbook is a ruby script that describe the steps before taking screenshots. You can directly `goto` some page, fill some inputs, submits forms, click on specific elements, etc.

Most of the methods are defined by the Watir gem. [Read their guides](http://watir.com/guides/) to learn more about how to navigate and interact with site and apps. **Note** that all the methods in the playbook will be forwarded to an instance of `Watir::Browser` automatically for convenience sake.

## API

This gem adds 3 additional methods on top of all the methods provided by `watir`:

### Use

`use(browser_name, width:, height:)`

Select which browser to use. This currently can be `:firefox` or `:safari`. Chrome is currently not supported due to the fact there's no reliable way to find the `CGWindowID` of Chrome.

### Snap

`snap(name)`

Take a snapshot of the window itself with shadows and save it as `snap_name-browser_name.png` in the directory from which this command is being run.

### Run

`run(playbook_name)`

Runs another playbook relative to the directory in which the first playbook was played. Note that you can omit the `.rb` extension.
