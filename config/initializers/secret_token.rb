if Rails.env == 'production'
  Suitor::Application.config.secret_key_base = ENV.fetch 'SUITOR_SECRET_KEY_BASE'
else
  Suitor::Application.config.secret_key_base = ENV.fetch 'SUITOR_SECRET_KEY_BASE', '1cf3d43d206f19a51542ca9900519fa0d69504d9ec7211151c16d2cfb7e7de8432db26443b86d254ff228a6fb77cab8f7e0a919ca27adeedd089ebca716d2e44'
end
