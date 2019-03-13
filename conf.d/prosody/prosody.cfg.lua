-- Prosody Example Configuration File
--
-- Information on configuring Prosody can be found on our
-- website at http://prosody.im/doc/configure
--
-- Tip: You can check that the syntax of this file is correct
-- when you have finished by running: luac -p prosody.cfg.lua
-- If there are any errors, it will let you know what and where
-- they are, otherwise it will keep quiet.
--
-- The only thing left to do is rename this file to remove the .dist ending, and fill in the
-- blanks. Good luck, and happy Jabbering!

---------- Server-wide settings ----------
-- Settings in this section apply to the whole server and are the default settings
-- for any virtual hosts

-- This is a (by default, empty) list of accounts that are admins
-- for the server. Note that you must create the accounts separately
-- (see http://prosody.im/doc/creating_accounts for info)
-- Example: admins = { "user1@example.com", "user2@example.net" }
admins = { "admin@mail.solay.ga" }

-- These paths are searched in the order specified, and before the default path
plugin_paths = { "/opt/prosody-0.11.1/lib/prosody/prosody-community" }

-- Enable use of libevent for better performance under high load
-- For more information see: http://prosody.im/doc/libevent
--use_libevent = true;

-- This is the list of modules Prosody will load on startup.
-- It looks for mod_modulename.lua in the plugins folder, so make sure that exists too.
-- Documentation on modules can be found at: http://prosody.im/doc/modules
modules_enabled = {

  -- Generally required
    "roster"; -- Allow users to have a roster. Recommended ;)
    "saslauth"; -- Authentication for clients and servers. Recommended if you want to log in.
    "tls"; -- Add support for secure TLS on c2s/s2s connections
    "dialback"; -- s2s dialback support
    "disco"; -- Service discovery

  -- Not essential, but recommended
    "private";       -- Private XML storage (for room bookmarks, etc.)
    "profile";       --
    "vcard4"; -- Perfiles de usuarios (guardado en PEP)
    "vcard_legacy"; -- Convierte entre legacy vCard y PEP Avatar, vcard
    --"vcard";       -- Allow users to set vCards
    --"privacy";     -- Support privacy lists
    --"compression"; -- Stream compression

  -- Nice to have
    --"legacyauth"; -- Legacy authentication. Only used by some old clients and bots.
    "version"; -- Replies to server version requests
    "uptime"; -- Report how long server has been running
    "time"; -- Let others know the time here on this server
    "ping"; -- Replies to XMPP pings with pongs
    "register"; -- Allow users to register on this server using a client and change passwords
    "adhoc"; -- Support for "ad-hoc commands" that can be executed with an XMPP client
    "server_contact_info"; -- Añade información de contacto en caso de incidencias con el servidor

  -- Admin interfaces
    "admin_adhoc"; -- Allows administration via an XMPP client that supports ad-hoc commands
    --"admin_telnet"; -- Opens telnet console interface on localhost port 5582

    -- HTTP modules
    -- "http";             -- Enable the HTTP server
    -- "register_web";     -- Enable web registration
    -- "http_files";       -- Serve static files from a directory over HTTP
    -- "http_upload";         -- XEP-0363, HTTP File Upload
    "http_upload_external";
    -- "websocket";        -- RFC-7395, XMPP over WebSockets (0.10+)
    -- "http_altconnect";  -- XEP-0156, Discovering Alternative XMPP Connection Methods



  -- Other specific functionality
    "bosh";               -- Enable BOSH clients, aka "Jabber over HTTP"
    --"httpserver";         -- Serve static files from a directory over HTTP
    --"groups";             -- Shared roster support
    --"announce";           -- Send announcement to all online users
    --"welcome";            -- Welcome users who register accounts
    --"watchregistrations"; -- Alert admins of registrations
    --"motd";               -- Send a message to users when they log in
    "pep";                -- Enables users to publish their mood, activity, playing music and more

  -- Debian: do not remove this module, or you lose syslog
  -- support
    "posix"; -- POSIX functionality, sends server to background, enables syslog, etc.

    -- Modern XEPs
    "smacks";              -- XEP-0198, Stream Management
    "smacks_offline";      -- XEP-0198, Stream Management
    "mam";                 -- XEP-0313, Message Archive Management (MAM)
    "blocking";            -- XEP-0191, Blocking Command
    "carbons";             -- XEP-0280, Message Carbons
    --"cloud_notify";        -- XEP-0357, Push Notifications
    "csi";                 -- XEP-0352, Client State Indication
    "filter_chatstates";   -- XEP-0352, Client State Indication
    "throttle_presence";   -- XEP-0352, Client State Indication

};

-- These modules are auto-loaded, should you
-- (for some mad reason) want to disable
-- them then uncomment them below
modules_disabled = {
  -- "presence"; -- Route user/contact status information
  -- "message"; -- Route messages
  -- "iq"; -- Route info queries
  -- "offline"; -- Store offline messages
};

certificates = "/opt/prosody-0.11.1/etc/prosody/certs"
ssl = {
  key = "/opt/prosody-0.11.1/etc/prosody/certs/mail.solay.ga.key";
  certificate = "/opt/prosody-0.11.1/etc/prosody/certs/mail.solay.ga.crt";
  protocol = "sslv23";
}

-- Disable account creation by default, for security
-- For more information see http://prosody.im/doc/creating_accounts
allow_registration = true -- Allow users to register new accounts
registration_blacklist = { "127.0.0.1", "123.123.123.123" } -- 2 IP addresses blacklisted
registration_whitelist = { } -- No IP addresses whitelisted
whitelist_registration_only = false -- Anyone can register apart from blacklisted IP addresses
min_seconds_between_registrations = 300 -- Clients must wait 5 minutes before they can register another account

-- 0.10+ example of max 1 registrations per minute
registration_throttle_max = 1
registration_throttle_period = 60

-- Debian:
--   send the server to background.
--
daemonize = false;

-- Debian:
--   Please, don't change this option since /var/run/prosody/
--   is one of the few directories Prosody is allowed to write to
--
pidfile = "/var/run/prosody/prosody.pid";


-- Force clients to use encrypted connections? This option will
-- prevent clients from authenticating unless they are using encryption.

c2s_require_encryption = true
-- s2s_require_encryption = true

-- Force certificate authentication for server-to-server connections?
-- This provides ideal security, but requires servers you communicate
-- with to support encryption AND present valid, trusted certificates.
-- NOTE: Your version of LuaSec must support certificate verification!
-- For more information see http://prosody.im/doc/s2s#security

s2s_secure_auth = true

-- Select the authentication backend to use. The 'internal' providers
-- use Prosody's configured data storage to store the authentication data.
-- To allow Prosody to offer secure authentication mechanisms to clients, the
-- default provider stores passwords in plaintext. If you do not trust your
-- server please see http://prosody.im/doc/modules/mod_auth_internal_hashed
-- for information about using the hashed backend.

authentication = "internal_hashed"


-- Select the storage backend to use. By default Prosody uses flat files
-- in its configured data directory, but it also supports more backends
-- through modules. An "sql" backend is included by default, but requires
-- additional dependencies. See http://prosody.im/doc/storage for more info.

storage = "sql"

-- For the "sql" backend, you can uncomment *one* of the below to configure:
sql = {
    driver    = "PostgreSQL"; -- May also be "MySQL" or "SQLite3" (case sensitive!)
    database  = "prosody"; -- The database name to use.
    username  = "prosody"; -- The username to authenticate to the database
    password  = "prosody"; -- The password to authenticate to the database
    host      = "db";      -- The address of the database server (delete this line for Postgres)
    port      = "5432";    -- For databases connecting over TCP
}

sql_manage_tables = true

-- Logging configuration
-- For advanced logging see http://prosody.im/doc/logging
--
-- Debian:
--  Logs info and higher to /var/log
--  Logs errors to syslog also
log = {
  -- Log files (change 'info' to 'debug' for debug logs):
  -- info  = "/var/log/prosody/prosody.log";
  warn  = "/var/log/prosody/prosody.warn";
  error = "/var/log/prosody/prosody.err";
  -- Syslog:
  -- { levels = { "error" }; to = "syslog";  };
  {levels = {min = "info"}, to = "console"};
}


-- Path to the external service. Ensure it ends with ‘/’.
http_upload_external_base_url = "https://reverseproxy/upload/"


-- This verify that the upload comes from mod_http_upload_external, and random strangers can’t upload to your server.
http_upload_external_secret = "mailsy_uploads_2516"


-- A maximum file size. Default 100M
http_upload_external_file_size_limit = 50000000 -- 50M


-- Inicia un proxy para intercambiar archivos grandes entre clientes
Component "proxy.solay.ga" "proxy65"
    proxy65_address = "mail.solay.ga"
    proxy65_acl = { "mail.solay.ga"}


consider_bosh_secure = true;
cross_domain_bosh = true;


------ Additional config files ------
-- For organizational purposes you may prefer to add VirtualHost and
-- Component definitions in their own config files. This line includes
-- all config files in /etc/prosody/conf.d/

Include "/opt/prosody-0.11.1/etc/prosody/conf.d/*.cfg.lua"