OTA_VERSION = 0.0.3
OTA_SITE = https://github.com/ruixiaoedu/ota/archive
OTA_SOURCE = $(OTA_VERSION).tar.gz

OTA_BUILD_TARGETS = cmd/ota
OTA_GOMOD = github.com/ruixiaoedu/ota

define OTA_INSTALL_CONFIG_FILES
	$(INSTALL) -d -m 755 $(TARGET_DIR)/etc/ota

	$(INSTALL) -D -m 0644 $(OTA_PKGDIR)/ota \
		$(TARGET_DIR)/etc/ota/ota.conf
	$(INSTALL) -D -m 0644 $(OTA_PKGDIR)/server.crt \
		$(TARGET_DIR)/etc/ota/server.crt

endef

define OTA_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 $(OTA_PKGDIR)/ota.service \
		$(TARGET_DIR)/usr/lib/systemd/system/ota.service
endef

$(eval $(golang-package))