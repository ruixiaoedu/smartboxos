OTA_VERSION = 0.0.6
OTA_SITE = https://github.com/ruixiaoedu/ota/archive
OTA_SOURCE = $(OTA_VERSION).tar.gz

OTA_TAGS = autogen
OTA_BUILD_TARGETS = cmd/ota
OTA_GOMOD = github.com/ruixiaoedu/ota

define OTA_INSTALL_CONFIG_FILES
	$(INSTALL) -d -m 755 $(TARGET_DIR)/etc/ota

	$(INSTALL) -D -m 0644 $(OTA_PKGDIR)/ota.conf \
		$(TARGET_DIR)/etc/ota/ota.conf
	$(INSTALL) -D -m 0644 $(OTA_PKGDIR)/ota.crt \
		$(TARGET_DIR)/etc/ota/ota.crt
endef

OTA_POST_INSTALL_TARGET_HOOKS += OTA_INSTALL_CONFIG_FILES

define OTA_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 $(OTA_PKGDIR)/ota.service \
		$(TARGET_DIR)/usr/lib/systemd/system/ota.service
endef

$(eval $(golang-package))