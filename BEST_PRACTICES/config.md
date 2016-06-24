# Habitat Configuration Best Practices

Configuration files are templatized using Mustache and stored in the plans **config/** directory.  The values are filled in from the plans **default.toml** file.

The following is an example **default.toml**:

```
# Example TOML

threads = 4
enabled = "yes"

[http]
workers = 128
cgi_enabled = "yes"
```

Here would be a matching **config**:

```
something: hardcoded
threads: {{cfg.threads}}
x_enabled: {{cfg.enabled}}

http_workers: {{cfg.http.workers}}
http_cgi?: {{cfg.http.cgi_enabled}}
```

Note that in TOML square-brackets denote a "table" (hash) and the following entries fill it.  The equivalent form in Mustache is achieved via dot-notation, hence why all config variables are wrapped in **cfg.**

You can also include variables from the plan.sh using the prefix **pkg**. (also there are maps for bldr, sys, and svc)

_WARNING!!!  Tables in TOML continue until the next table is found or EOF is reached._ See [TOML Docs](https://github.com/toml-lang/toml#user-content-table) for more details.

Here is a real example, the **config.toml**:

```
# Lighttpd Config Tuning

server-port = 3000
```

And here is the **config/lighttpd.conf** to go with it:

```
# Reference: 
# http://redmine.lighttpd.net/projects/lighttpd/wiki/WikiStart#Reference-Documentation

server.document-root = "/opt/bldr/srvc/lighttpd/data"

server.port = {{cfg.server-port}}

mimetype.assign = (
  ".html" => "text/html",
  ".txt" => "text/plain",
  ".jpg" => "image/jpeg",
  ".png" => "image/png"
)

index-file.names = ( "index.html", "index.htm" )
```

# Primers

## Mustache Basics

[Mustache(5) Man Page](https://mustache.github.io/mustache.5.html)

```
# This is an example Template

Hello, {{user}}.  
If you include HTML, the {{content}} will be escaped by default, use {{{content}}} to not escape.

{{section}}
  You can define sections.
  {{#shhh}}  
     When a # is used, this will be shown if the key exists, is true, or has a value.
     You can include {{multiple_keys}} in an array to loop.
  {{/shhh}}
{{/section}}


{{^inverted_section}}
  Inverted sections these are the opposite of {{#sections}}, this will show if the key doesn't exist, is empty or false.  
  Use a section, plus both a #section and ^section together to create a "if/else" situation.
{{/inverted_section}}
```

## TOML Basics

[TOML Documentation](https://github.com/toml-lang/toml)

```
# This is a TOML document.

title = "TOML Example"  ## String, use common esc seq's like \n, \", \\, etc.
copyright = """
 This is a multi
 line string"""            ## Multiline strings are triple-quoted.
quote = 'To my "Parents"'  ## Literal strings are in single quotes, you can also triple-quote multiline literals

[owner]
name = "Tom Preston-Werner"
dob = 1979-05-27T07:32:00-08:00     ## First class dates

[database]                          ## Tables (Hash Tables or Dictionaries) continue until next Table or EOF.
server = "192.168.1.1"
ports = [ 8001, 8001, 8002 ]        ## Arrays, you can not mix types.  Multiline is OK, a trailing comma is also OK.
connection_max = 5000               ## Ints and Floats are bare (unquoted)
enabled = true                      ## Booleans are bare "true or false", must be lowercase.

[servers]                   

  # Indentation (tabs and/or spaces) is allowed but not required
  [servers.alpha]            # Nested table, renders as { "servers": { "alpha": { "ip": "10.0.0.1", ... } } }
  ip = "10.0.0.1"
  dc = "eqdc10"

  [servers.beta]
  ip = "10.0.0.2"
  dc = "eqdc10"

[clients]
data = [ ["gamma", "delta"], [1, 2] ]   ## 

# Line breaks are OK when inside arrays
hosts = [
  "alpha",
  "omega"
]

[[customers]]       ### Array of Tables, renders as: 
name = "Bob"          #     { "customers": [ { "name": "Bob", "age": 45 } ],
age = 45              #                    [ { "name": "Alice", "age": 6 } ]   }

[[customers]]
name = "Alice"
age = 6
```
