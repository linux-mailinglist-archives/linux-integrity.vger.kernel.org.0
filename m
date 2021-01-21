Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4872FEFA4
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Jan 2021 17:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbhAUP7R (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 Jan 2021 10:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732424AbhAUP6j (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Jan 2021 10:58:39 -0500
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [IPv6:2001:1600:3:17::190b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CA5C0613D6
        for <linux-integrity@vger.kernel.org>; Thu, 21 Jan 2021 07:55:40 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DM6Rt3tfRzMr6Zf;
        Thu, 21 Jan 2021 16:55:38 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4DM6Rs17JVzlh8Tg;
        Thu, 21 Jan 2021 16:55:37 +0100 (CET)
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
Subject: [PATCH v4 10/10] certs: Allow root user to append signed hashes to the blacklist keyring
Date:   Thu, 21 Jan 2021 16:55:13 +0100
Message-Id: <20210121155513.539519-11-mic@digikod.net>
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

Add a kernel option SYSTEM_BLACKLIST_AUTH_UPDATE to enable the root user
to dynamically add new keys to the blacklist keyring.  This enables to
invalidate new certificates, either from being loaded in a keyring, or
from being trusted in a PKCS#7 certificate chain.  This also enables to
add new file hashes to be denied by the integrity infrastructure.

Being able to untrust a certificate which could have normaly been
trusted is a sensitive operation.  This is why adding new hashes to the
blacklist keyring is only allowed when these hashes are signed and
vouched by the builtin trusted keyring.  A blacklist hash is stored as a
key description.  The PKCS#7 signature of this description must be
provided as the key payload.

Marking a certificate as untrusted should be enforced while the system
is running.  It is then forbiden to remove such blacklist keys.

Update blacklist keyring and blacklist key access rights:
* allows the root user to search for a specific blacklisted hash, which
  make sense because the descriptions are already viewable;
* forbids key update;
* restricts kernel rights on the blacklist keyring to align with the
  root user rights.

See help in tools/certs/print-cert-tbs-hash.sh .

Cc: David Howells <dhowells@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
---

Changes since v3:
* Update commit message for print-cert-tbs-hash.sh .

Changes since v2:
* Add comment for blacklist_key_instantiate().
---
 certs/Kconfig     | 10 ++++++
 certs/blacklist.c | 90 +++++++++++++++++++++++++++++++++++++----------
 2 files changed, 81 insertions(+), 19 deletions(-)

diff --git a/certs/Kconfig b/certs/Kconfig
index 6d09dec4a9e3..16003ce65b0a 100644
--- a/certs/Kconfig
+++ b/certs/Kconfig
@@ -86,4 +86,14 @@ config SYSTEM_BLACKLIST_HASH_LIST
 	  Certificate hashes can be generated with
 	  tools/certs/print-cert-tbs-hash.sh .
 
+config SYSTEM_BLACKLIST_AUTH_UPDATE
+	bool "Allow root to add signed blacklist keys"
+	depends on SYSTEM_BLACKLIST_KEYRING
+	depends on SYSTEM_DATA_VERIFICATION
+	help
+	  If set, provide the ability to load new blacklist keys at run time if
+	  they are signed and vouched by a certificate from the builtin trusted
+	  keyring.  The PKCS#7 signature of the description is set in the key
+	  payload.  Blacklist keys cannot be removed.
+
 endmenu
diff --git a/certs/blacklist.c b/certs/blacklist.c
index 1e63971bea94..07c592ae5307 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <linux/seq_file.h>
 #include <linux/uidgid.h>
+#include <linux/verification.h>
 #include <keys/system_keyring.h>
 #include "blacklist.h"
 
@@ -25,6 +26,9 @@
  */
 #define MAX_HASH_LEN	128
 
+#define BLACKLIST_KEY_PERM (KEY_POS_SEARCH | KEY_POS_VIEW | \
+			    KEY_USR_SEARCH | KEY_USR_VIEW)
+
 static const char tbs_prefix[] = "tbs";
 static const char bin_prefix[] = "bin";
 
@@ -74,19 +78,51 @@ static int blacklist_vet_description(const char *desc)
 	return 0;
 }
 
-/*
- * The hash to be blacklisted is expected to be in the description.  There will
- * be no payload.
- */
-static int blacklist_preparse(struct key_preparsed_payload *prep)
+static int blacklist_key_instantiate(struct key *key,
+		struct key_preparsed_payload *prep)
 {
-	if (prep->datalen > 0)
-		return -EINVAL;
-	return 0;
+#ifdef CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE
+	int err;
+#endif
+
+	/* Sets safe default permissions for keys loaded by user space. */
+	key->perm = BLACKLIST_KEY_PERM;
+
+	/*
+	 * Skips the authentication step for builtin hashes, they are not
+	 * signed but still trusted.
+	 */
+	if (key->flags & (1 << KEY_FLAG_BUILTIN))
+		goto out;
+
+#ifdef CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE
+	/*
+	 * Verifies the description's PKCS#7 signature against the builtin
+	 * trusted keyring.
+	 */
+	err = verify_pkcs7_signature(key->description,
+			strlen(key->description), prep->data, prep->datalen,
+			NULL, VERIFYING_UNSPECIFIED_SIGNATURE, NULL, NULL);
+	if (err)
+		return err;
+#else
+	/*
+	 * It should not be possible to come here because the keyring doesn't
+	 * have KEY_USR_WRITE and the only other way to call this function is
+	 * for builtin hashes.
+	 */
+	WARN_ON_ONCE(1);
+	return -EPERM;
+#endif
+
+out:
+	return generic_key_instantiate(key, prep);
 }
 
-static void blacklist_free_preparse(struct key_preparsed_payload *prep)
+static int blacklist_key_update(struct key *key,
+		struct key_preparsed_payload *prep)
 {
+	return -EPERM;
 }
 
 static void blacklist_describe(const struct key *key, struct seq_file *m)
@@ -97,9 +133,8 @@ static void blacklist_describe(const struct key *key, struct seq_file *m)
 static struct key_type key_type_blacklist = {
 	.name			= "blacklist",
 	.vet_description	= blacklist_vet_description,
-	.preparse		= blacklist_preparse,
-	.free_preparse		= blacklist_free_preparse,
-	.instantiate		= generic_key_instantiate,
+	.instantiate		= blacklist_key_instantiate,
+	.update			= blacklist_key_update,
 	.describe		= blacklist_describe,
 };
 
@@ -148,8 +183,7 @@ static int mark_raw_hash_blacklisted(const char *hash)
 				   hash,
 				   NULL,
 				   0,
-				   ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
-				    KEY_USR_VIEW),
+				   BLACKLIST_KEY_PERM,
 				   KEY_ALLOC_NOT_IN_QUOTA |
 				   KEY_ALLOC_BUILT_IN);
 	if (IS_ERR(key)) {
@@ -208,25 +242,43 @@ int is_binary_blacklisted(const u8 *hash, size_t hash_len)
 }
 EXPORT_SYMBOL_GPL(is_binary_blacklisted);
 
+static int restrict_link_for_blacklist(struct key *dest_keyring,
+		const struct key_type *type, const union key_payload *payload,
+		struct key *restrict_key)
+{
+	if (type != &key_type_blacklist)
+		return -EPERM;
+	return 0;
+}
+
 /*
  * Initialise the blacklist
  */
 static int __init blacklist_init(void)
 {
 	const char *const *bl;
+	struct key_restriction *restriction;
 
 	if (register_key_type(&key_type_blacklist) < 0)
 		panic("Can't allocate system blacklist key type\n");
 
+	restriction = kzalloc(sizeof(*restriction), GFP_KERNEL);
+	if (!restriction)
+		panic("Can't allocate blacklist keyring restriction\n");
+	restriction->check = restrict_link_for_blacklist;
+
 	blacklist_keyring =
 		keyring_alloc(".blacklist",
 			      GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, current_cred(),
-			      (KEY_POS_ALL & ~KEY_POS_SETATTR) |
-			      KEY_USR_VIEW | KEY_USR_READ |
-			      KEY_USR_SEARCH,
-			      KEY_ALLOC_NOT_IN_QUOTA |
+			      KEY_POS_VIEW | KEY_POS_READ | KEY_POS_SEARCH |
+			      KEY_POS_WRITE |
+			      KEY_USR_VIEW | KEY_USR_READ | KEY_USR_SEARCH
+#ifdef CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE
+			      | KEY_USR_WRITE
+#endif
+			      , KEY_ALLOC_NOT_IN_QUOTA |
 			      KEY_ALLOC_SET_KEEP,
-			      NULL, NULL);
+			      restriction, NULL);
 	if (IS_ERR(blacklist_keyring))
 		panic("Can't allocate system blacklist keyring\n");
 
-- 
2.30.0

