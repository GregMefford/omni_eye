use Mix.Config

# To simplify the training, we will use the same SSH keys that were used in the pre-burned firmware.
# In your own projects, you should manage your own SSH keys and keep them private - don't check them
# into GitHub like this.
key = Path.join([Mix.Project.deps_path(), "..", "training_keys", "id_rsa.pub"])

config :nerves_firmware_ssh,
  authorized_keys: [File.read!(key)]

# Configure nerves_init_gadget.
# See https://hexdocs.pm/nerves_init_gadget/readme.html for more information.

# Setting the node_name will enable Erlang Distribution.
# Only enable this for prod if you understand the risks.
node_name = if Mix.env() != :prod, do: "eye_fw"

config :nerves_init_gadget,
  ifname: "usb0",
  address_method: :dhcpd,
  mdns_domain: "nerves.local",
  node_name: node_name,
  node_host: :mdns_domain

# Import target specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
# Uncomment to use target specific configurations

# import_config "#{Mix.target()}.exs"
