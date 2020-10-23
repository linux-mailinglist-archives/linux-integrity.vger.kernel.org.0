Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA7D29757F
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Oct 2020 19:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752985AbgJWRF1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Oct 2020 13:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464587AbgJWRF0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Oct 2020 13:05:26 -0400
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CF6C0613CE
        for <linux-integrity@vger.kernel.org>; Fri, 23 Oct 2020 10:05:26 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CHrFt53RpzlhypJ;
        Fri, 23 Oct 2020 19:05:22 +0200 (CEST)
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4CHrFt26Xvzlh8TG;
        Fri, 23 Oct 2020 19:05:22 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>,
        Milan Broz <gmazyland@gmail.com>, dm-devel@redhat.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v3] dm verity: Add support for signature verification with 2nd keyring
Date:   Fri, 23 Oct 2020 19:05:12 +0200
Message-Id: <20201023170512.201124-1-mic@digikod.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

Add a new configuration DM_VERITY_VERIFY_ROOTHASH_SIG_SECONDARY_KEYRING
to enable dm-verity signatures to be verified against the secondary
trusted keyring.  Instead of relying on the builtin trusted keyring
(with hard-coded certificates), the second trusted keyring can include
certificate authorities from the builtin trusted keyring and child
certificates loaded at run time.  Using the secondary trusted keyring
enables to use dm-verity disks (e.g. loop devices) signed by keys which
did not exist at kernel build time, leveraging the certificate chain of
trust model.  In practice, this makes it possible to update certificates
without kernel update and reboot, aligning with module and kernel
(kexec) signature verification which already use the secondary trusted
keyring.

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Milan Broz <gmazyland@gmail.com>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
---

Previous version:
https://lore.kernel.org/lkml/20201015150504.1319098-1-mic@digikod.net/

Changes since v2:
* Add documentation about the builtin and the secondary trusted keyrings
  (requested by Mike Snitzer).

Changes since v1:
* Extend the commit message (asked by Jarkko Sakkinen).
* Rename the Kconfig "help" keyword according to commit 84af7a6194e4
  ("checkpatch: kconfig: prefer 'help' over '---help---'").
---
 Documentation/admin-guide/device-mapper/verity.rst |  7 ++++++-
 drivers/md/Kconfig                                 | 13 ++++++++++++-
 drivers/md/dm-verity-verify-sig.c                  |  9 +++++++--
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/device-mapper/verity.rst b/Documentation/admin-guide/device-mapper/verity.rst
index 66f71f0dab1b..b088a647acb7 100644
--- a/Documentation/admin-guide/device-mapper/verity.rst
+++ b/Documentation/admin-guide/device-mapper/verity.rst
@@ -134,7 +134,12 @@ root_hash_sig_key_desc <key_description>
     the pkcs7 signature of the roothash. The pkcs7 signature is used to validate
     the root hash during the creation of the device mapper block device.
     Verification of roothash depends on the config DM_VERITY_VERIFY_ROOTHASH_SIG
-    being set in the kernel.
+    being set in the kernel.  The signatures are checked against the builtin
+    trusted keyring by default, or the secondary trusted keyring if
+    DM_VERITY_VERIFY_ROOTHASH_SIG_SECONDARY_KEYRING is set.  The secondary
+    trusted keyring includes by default the builtin trusted keyring, and it can
+    also gain new certificates at run time if they are signed by a certificate
+    already in the secondary trusted keyring.
 
 Theory of operation
 ===================
diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index 30ba3573626c..1d68935e45ef 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -530,11 +530,22 @@ config DM_VERITY_VERIFY_ROOTHASH_SIG
 	bool "Verity data device root hash signature verification support"
 	depends on DM_VERITY
 	select SYSTEM_DATA_VERIFICATION
-	  help
+	help
 	  Add ability for dm-verity device to be validated if the
 	  pre-generated tree of cryptographic checksums passed has a pkcs#7
 	  signature file that can validate the roothash of the tree.
 
+	  By default, rely on the builtin trusted keyring.
+
+	  If unsure, say N.
+
+config DM_VERITY_VERIFY_ROOTHASH_SIG_SECONDARY_KEYRING
+	bool "Verity data device root hash signature verification with secondary keyring"
+	depends on DM_VERITY_VERIFY_ROOTHASH_SIG
+	depends on SECONDARY_TRUSTED_KEYRING
+	help
+	  Rely on the secondary trusted keyring to verify dm-verity signatures.
+
 	  If unsure, say N.
 
 config DM_VERITY_FEC
diff --git a/drivers/md/dm-verity-verify-sig.c b/drivers/md/dm-verity-verify-sig.c
index 614e43db93aa..29385dc470d5 100644
--- a/drivers/md/dm-verity-verify-sig.c
+++ b/drivers/md/dm-verity-verify-sig.c
@@ -119,8 +119,13 @@ int verity_verify_root_hash(const void *root_hash, size_t root_hash_len,
 	}
 
 	ret = verify_pkcs7_signature(root_hash, root_hash_len, sig_data,
-				sig_len, NULL, VERIFYING_UNSPECIFIED_SIGNATURE,
-				NULL, NULL);
+				sig_len,
+#ifdef CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG_SECONDARY_KEYRING
+				VERIFY_USE_SECONDARY_KEYRING,
+#else
+				NULL,
+#endif
+				VERIFYING_UNSPECIFIED_SIGNATURE, NULL, NULL);
 
 	return ret;
 }

base-commit: bbf5c979011a099af5dc76498918ed7df445635b
-- 
2.28.0

