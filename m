Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2CF2D7F04
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Dec 2020 20:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391666AbgLKTEm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Dec 2020 14:04:42 -0500
Received: from smtp-190c.mail.infomaniak.ch ([185.125.25.12]:46055 "EHLO
        smtp-190c.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388518AbgLKTEi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Dec 2020 14:04:38 -0500
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Ct0Yv1GTxzlhLNB;
        Fri, 11 Dec 2020 20:03:47 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Ct0Yt670Fzlh8T5;
        Fri, 11 Dec 2020 20:03:46 +0100 (CET)
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
        "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v2 3/5] certs: Check that builtin blacklist hashes are valid
Date:   Fri, 11 Dec 2020 20:03:28 +0100
Message-Id: <20201211190330.2586116-4-mic@digikod.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201211190330.2586116-1-mic@digikod.net>
References: <20201211190330.2586116-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

Add and use a check-blacklist-hashes.awk script to make sure that the
builtin blacklist hashes will be approved by the run time blacklist
description checks.  This is useful to debug invalid hash formats, and
it make sure that previous hashes which could have been loaded in the
kernel (but ignored) are now noticed and deal with by the user.

Cc: David Howells <dhowells@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
---

Changes since v1:
* Prefix script path with $(scrtree)/ (suggested by David Howells).
* Fix hexadecimal number check.
---
 MAINTAINERS                        |  1 +
 certs/.gitignore                   |  1 +
 certs/Makefile                     | 15 +++++++++++-
 scripts/check-blacklist-hashes.awk | 37 ++++++++++++++++++++++++++++++
 4 files changed, 53 insertions(+), 1 deletion(-)
 create mode 100755 scripts/check-blacklist-hashes.awk

diff --git a/MAINTAINERS b/MAINTAINERS
index a008b70f3c16..e9d4453caf5d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4080,6 +4080,7 @@ L:	keyrings@vger.kernel.org
 S:	Maintained
 F:	Documentation/admin-guide/module-signing.rst
 F:	certs/
+F:	scripts/check-blacklist-hashes.awk
 F:	scripts/extract-cert.c
 F:	scripts/sign-file.c
 
diff --git a/certs/.gitignore b/certs/.gitignore
index 2a2483990686..42cc2ac24b93 100644
--- a/certs/.gitignore
+++ b/certs/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
+blacklist_hashes_checked
 x509_certificate_list
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
2.29.2

