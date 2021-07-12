Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B983C61B4
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Jul 2021 19:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbhGLRQS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Jul 2021 13:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhGLRQS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Jul 2021 13:16:18 -0400
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [IPv6:2001:1600:3:17::190f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656F4C0613E9
        for <linux-integrity@vger.kernel.org>; Mon, 12 Jul 2021 10:13:29 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4GNqpy4r1ZzMppR6;
        Mon, 12 Jul 2021 19:03:38 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4GNqpy2cvhzlh8TR;
        Mon, 12 Jul 2021 19:03:38 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v8 2/5] certs: Check that builtin blacklist hashes are valid
Date:   Mon, 12 Jul 2021 19:03:10 +0200
Message-Id: <20210712170313.884724-3-mic@digikod.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210712170313.884724-1-mic@digikod.net>
References: <20210712170313.884724-1-mic@digikod.net>
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
Cc: Eric Snowberg <eric.snowberg@oracle.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20210712170313.884724-3-mic@digikod.net
---

Changes since v7:
* Rebase and fix trivial .gitignore conflict.

Changes since v5:
* Rebase on keys-next and fix conflict as previously done by David
  Howells.
* Enable to use a file path relative to the kernel source directory.
  This align with the handling of CONFIG_SYSTEM_TRUSTED_KEYS,
  CONFIG_MODULE_SIG_KEY and CONFIG_SYSTEM_REVOCATION_KEYS.

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
 certs/Makefile                     | 17 +++++++++++++-
 scripts/check-blacklist-hashes.awk | 37 ++++++++++++++++++++++++++++++
 5 files changed, 60 insertions(+), 3 deletions(-)
 create mode 100755 scripts/check-blacklist-hashes.awk

diff --git a/MAINTAINERS b/MAINTAINERS
index 0b3be78d27ef..04b8fb5dcdac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4299,6 +4299,7 @@ L:	keyrings@vger.kernel.org
 S:	Maintained
 F:	Documentation/admin-guide/module-signing.rst
 F:	certs/
+F:	scripts/check-blacklist-hashes.awk
 F:	scripts/extract-cert.c
 F:	scripts/sign-file.c
 F:	tools/certs/
diff --git a/certs/.gitignore b/certs/.gitignore
index 8c3763f80be3..01de9442e4e2 100644
--- a/certs/.gitignore
+++ b/certs/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
+/blacklist_hashes_checked
 /x509_certificate_list
 /x509_revocation_list
diff --git a/certs/Kconfig b/certs/Kconfig
index f4e61116f94e..0fbe184ceca5 100644
--- a/certs/Kconfig
+++ b/certs/Kconfig
@@ -80,8 +80,11 @@ config SYSTEM_BLACKLIST_HASH_LIST
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
 
 config SYSTEM_REVOCATION_LIST
 	bool "Provide system-wide ring of revocation certificates"
diff --git a/certs/Makefile b/certs/Makefile
index 359239a0ee9e..e43c1a8032de 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -7,7 +7,22 @@ obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) += system_keyring.o system_certificates.o c
 obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist.o common.o
 obj-$(CONFIG_SYSTEM_REVOCATION_LIST) += revocation_certificates.o
 ifneq ($(CONFIG_SYSTEM_BLACKLIST_HASH_LIST),"")
+
+quiet_cmd_check_blacklist_hashes = CHECK   $(patsubst "%",%,$(2))
+      cmd_check_blacklist_hashes = $(AWK) -f $(srctree)/scripts/check-blacklist-hashes.awk $(2); touch $@
+
+$(eval $(call config_filename,SYSTEM_BLACKLIST_HASH_LIST))
+
+$(obj)/blacklist_hashes.o: $(obj)/blacklist_hashes_checked
+
+CFLAGS_blacklist_hashes.o += -I$(srctree)
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
@@ -30,7 +45,7 @@ $(obj)/x509_certificate_list: scripts/extract-cert $(SYSTEM_TRUSTED_KEYS_SRCPREF
 	$(call if_changed,extract_certs,$(SYSTEM_TRUSTED_KEYS_SRCPREFIX)$(CONFIG_SYSTEM_TRUSTED_KEYS))
 endif # CONFIG_SYSTEM_TRUSTED_KEYRING
 
-clean-files := x509_certificate_list .x509.list x509_revocation_list
+clean-files := x509_certificate_list .x509.list x509_revocation_list blacklist_hashes_checked
 
 ifeq ($(CONFIG_MODULE_SIG),y)
 	SIGN_KEY = y
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
2.32.0

