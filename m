Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2CAC2FEF91
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Jan 2021 16:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731794AbhAUP5C (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 Jan 2021 10:57:02 -0500
Received: from smtp-1909.mail.infomaniak.ch ([185.125.25.9]:47597 "EHLO
        smtp-1909.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728354AbhAUP4Y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Jan 2021 10:56:24 -0500
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DM6Rd4TrPzMr5H6;
        Thu, 21 Jan 2021 16:55:25 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4DM6Rd2K7fzlh8TL;
        Thu, 21 Jan 2021 16:55:25 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v4 02/10] certs: Check that builtin blacklist hashes are valid
Date:   Thu, 21 Jan 2021 16:55:05 +0100
Message-Id: <20210121155513.539519-3-mic@digikod.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121155513.539519-1-mic@digikod.net>
References: <20210121155513.539519-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

Add and use a check-blacklist-hashes.awk script to make sure that the
builtin blacklist hashes set with CONFIG_SYSTEM_BLACKLIST_HASH_LIST will
effectively be taken into account as blacklisted hashes.  This is useful
to debug invalid hash formats, and it make sure that previous hashes
which could have been loaded in the kernel, but silently ignored, are
now noticed and deal with by the user at kernel build time.

This also prevent stricter blacklist key description checking (provided
by following commits) to failed for builtin hashes.

Update CONFIG_SYSTEM_BLACKLIST_HASH_LIST help to explain the content of
a hash string and how to generate certificate ones.

Cc: David Howells <dhowells@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
---

Changes since v3:
* Improve commit description.
* Update CONFIG_SYSTEM_BLACKLIST_HASH_LIST help.
* Remove Acked-by Jarkko Sakkinen because of the above changes.

Changes since v2:
* Add Jarkko's Acked-by.

Changes since v1:
* Prefix script path with $(scrtree)/ (suggested by David Howells).
* Fix hexadecimal number check.
---
 MAINTAINERS                        |  1 +
 certs/.gitignore                   |  1 +
 certs/Kconfig                      |  7 ++++--
 certs/Makefile                     | 15 +++++++++++-
 scripts/check-blacklist-hashes.awk | 37 ++++++++++++++++++++++++++++++
 5 files changed, 58 insertions(+), 3 deletions(-)
 create mode 100755 scripts/check-blacklist-hashes.awk

diff --git a/MAINTAINERS b/MAINTAINERS
index 773a362e807f..a18fd3d283c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4118,6 +4118,7 @@ L:	keyrings@vger.kernel.org
 S:	Maintained
 F:	Documentation/admin-guide/module-signing.rst
 F:	certs/
+F:	scripts/check-blacklist-hashes.awk
 F:	scripts/extract-cert.c
 F:	scripts/sign-file.c
 F:	tools/certs/
diff --git a/certs/.gitignore b/certs/.gitignore
index 2a2483990686..42cc2ac24b93 100644
--- a/certs/.gitignore
+++ b/certs/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
+blacklist_hashes_checked
 x509_certificate_list
diff --git a/certs/Kconfig b/certs/Kconfig
index c94e93d8bccf..6d09dec4a9e3 100644
--- a/certs/Kconfig
+++ b/certs/Kconfig
@@ -80,7 +80,10 @@ config SYSTEM_BLACKLIST_HASH_LIST
 	help
 	  If set, this option should be the filename of a list of hashes in the
 	  form "<hash>", "<hash>", ... .  This will be included into a C
-	  wrapper to incorporate the list into the kernel.  Each <hash> should
-	  be a string of hex digits.
+	  wrapper to incorporate the list into the kernel.  Each <hash> must be a
+	  string starting with a prefix ("tbs" or "bin"), then a colon (":"), and
+	  finally an even number of hexadecimal lowercase characters (up to 128).
+	  Certificate hashes can be generated with
+	  tools/certs/print-cert-tbs-hash.sh .
 
 endmenu
diff --git a/certs/Makefile b/certs/Makefile
index f4c25b67aad9..eb45407ff282 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -6,7 +6,20 @@
 obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) += system_keyring.o system_certificates.o
 obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist.o
 ifneq ($(CONFIG_SYSTEM_BLACKLIST_HASH_LIST),"")
+
+quiet_cmd_check_blacklist_hashes = CHECK   $(patsubst "%",%,$(2))
+      cmd_check_blacklist_hashes = $(AWK) -f $(srctree)/scripts/check-blacklist-hashes.awk $(2); touch $@
+
+$(eval $(call config_filename,SYSTEM_BLACKLIST_HASH_LIST))
+
+$(obj)/blacklist_hashes.o: $(obj)/blacklist_hashes_checked
+
+targets += blacklist_hashes_checked
+$(obj)/blacklist_hashes_checked: $(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX)$(SYSTEM_BLACKLIST_HASH_LIST_FILENAME) scripts/check-blacklist-hashes.awk FORCE
+	$(call if_changed,check_blacklist_hashes,$(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX)$(CONFIG_SYSTEM_BLACKLIST_HASH_LIST))
+
 obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_hashes.o
+
 else
 obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_nohashes.o
 endif
@@ -29,7 +42,7 @@ $(obj)/x509_certificate_list: scripts/extract-cert $(SYSTEM_TRUSTED_KEYS_SRCPREF
 	$(call if_changed,extract_certs,$(SYSTEM_TRUSTED_KEYS_SRCPREFIX)$(CONFIG_SYSTEM_TRUSTED_KEYS))
 endif # CONFIG_SYSTEM_TRUSTED_KEYRING
 
-clean-files := x509_certificate_list .x509.list
+clean-files := x509_certificate_list .x509.list blacklist_hashes_checked
 
 ifeq ($(CONFIG_MODULE_SIG),y)
 ###############################################################################
diff --git a/scripts/check-blacklist-hashes.awk b/scripts/check-blacklist-hashes.awk
new file mode 100755
index 000000000000..107c1d3204d4
--- /dev/null
+++ b/scripts/check-blacklist-hashes.awk
@@ -0,0 +1,37 @@
+#!/usr/bin/awk -f
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright © 2020, Microsoft Corporation. All rights reserved.
+#
+# Author: Mickaël Salaün <mic@linux.microsoft.com>
+#
+# Check that a CONFIG_SYSTEM_BLACKLIST_HASH_LIST file contains a valid array of
+# hash strings.  Such string must start with a prefix ("tbs" or "bin"), then a
+# colon (":"), and finally an even number of hexadecimal lowercase characters
+# (up to 128).
+
+BEGIN {
+	RS = ","
+}
+{
+	if (!match($0, "^[ \t\n\r]*\"([^\"]*)\"[ \t\n\r]*$", part1)) {
+		print "Not a string (item " NR "):", $0;
+		exit 1;
+	}
+	if (!match(part1[1], "^(tbs|bin):(.*)$", part2)) {
+		print "Unknown prefix (item " NR "):", part1[1];
+		exit 1;
+	}
+	if (!match(part2[2], "^([0-9a-f]+)$", part3)) {
+		print "Not a lowercase hexadecimal string (item " NR "):", part2[2];
+		exit 1;
+	}
+	if (length(part3[1]) > 128) {
+		print "Hash string too long (item " NR "):", part3[1];
+		exit 1;
+	}
+	if (length(part3[1]) % 2 == 1) {
+		print "Not an even number of hexadecimal characters (item " NR "):", part3[1];
+		exit 1;
+	}
+}
-- 
2.30.0

