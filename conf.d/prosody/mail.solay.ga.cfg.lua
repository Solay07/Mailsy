-- Section for solaymsg.ga

VirtualHost "mail.solay.ga"
        enabled = true

        -- Assign this host a certificate for TLS, otherwise it would use the one
        -- set in the global section (if any).
        -- Note that old-style SSL on port 5223 only supports one certificate, and will always
        -- use the global one.
        ssl = {
                key = "/opt/prosody-0.11.1/etc/prosody/certs/mail.solay.ga.key";
                certificate = "/opt/prosody-0.11.1/etc/prosody/certs/mail.solay.ga.crt";
                protocol = "sslv23";
              }

------ Components ------
-- You can specify components to add hosts that provide special services,
-- like multi-user conferences, and transports.
-- For more information on components, see http://prosody.im/doc/components

-- Set up a MUC (multi-user chat) room server on conference.solaymsg.ga:
-- Component "conference.solaymsg.ga" "muc"

-- Set up a SOCKS5 bytestream proxy for server-proxied file transfers:
--Component "proxy.solaymsg.ga" "proxy65"

---Set up an external component (default component port is 5347)
--Component "gateway.solaymsg.ga"
--      component_secret = "password"