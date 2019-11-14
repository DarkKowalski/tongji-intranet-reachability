# Tongji University Intranet Reachability

I am bothered by the campus intranet which has many black hole routes, and whose VLANs may not be configured properly.

I wants to collect some actual data relating to its reachability.

## Simple and crude tool

Which  has only been tested on my own Debian buster machine.

Just `ping` and `nmap` with proper arguments.

Availability depends on CLI standard output, not portable to Windows.

Any problem? Read the code.

### Dependencies

- `nmap` 7.70 or later
- `ping` from iputils-ping (GNU/Linux)

### Usage

Modify `config.json` then run `ruby run.rb`

Results will be in `result.txt`
