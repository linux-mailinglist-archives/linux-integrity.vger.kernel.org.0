Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AE8316617
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Feb 2021 13:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhBJMJq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Feb 2021 07:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhBJMHp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Feb 2021 07:07:45 -0500
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [IPv6:2001:1600:4:17::1908])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BBFC061797
        for <linux-integrity@vger.kernel.org>; Wed, 10 Feb 2021 04:04:03 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DbJMJ3SkwzMpnnY;
        Wed, 10 Feb 2021 13:03:56 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4DbJMJ1RH9zlh8TM;
        Wed, 10 Feb 2021 13:03:56 +0100 (CET)
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
Subject: [PATCH v6 5/5] certs: Allow root user to append signed hashes to the blacklist keyring
Date:   Wed, 10 Feb 2021 13:04:10 +0100
Message-Id: <20210210120410.471693-6-mic@digikod.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210120410.471693-1-mic@digikod.net>
References: <20210210120410.471693-1-mic@digikod.net>
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

Update blacklist keyring, blacklist key and revoked certificate access rights:
* allows the root user to search for a specific blacklisted hash, which
  make sense because the descriptions are already viewable;
* forbids key update (blacklist and asymmetric ones);
* restricts kernel rights on the blacklist keyring to align with the
  root user rights.

See help in tools/certs/print-cert-tbs-hash.sh .

Cc: David Howells <dhowells@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Eric Snowberg <eric.snowberg@oracle.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
---

Changes since v5:
* Rebase on keys-next, fix Kconfig conflict, and update the asymmetric
  key rights added to the blacklist keyring by the new
  add_key_to_revocation_list(): align with blacklist key rights by
  removing KEY_POS_WRITE as a safeguard, and add
  KEY_ALLOC_BYPASS_RESTRICTION to not be subject to
  restrict_link_for_blacklist() that only allows blacklist key types to
  be added to the keyring.
* Change the return code for restrict_link_for_blacklist() from -EPERM
  to -EOPNOTSUPP to align with asymmetric key keyrings.

Changes since v3:
* Update commit message for print-cert-tbs-hash.sh .

Changes since v2:
* Add comment for blacklist_key_instantiate().
---
 certs/Kconfig     | 10 +++++
 certs/blacklist.c | 96 ++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 85 insertions(+), 21 deletions(-)

diff --git a/certs/Kconfig b/certs/Kconfig
index 139940b54207..555491fdde0e 100644
--- a/certs/Kconfig
+++ b/certs/Kconfig
@@ -94,4 +94,14 @@ config SYSTEM_REVOCATION_KEYS
 	  containing X.509 certificates to be included in the default blacklist
 	  keyring.
 
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
index 9fe79597bda7..731e8e5bb6d8 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <linux/seq_file.h>
 #include <linux/uidgid.h>
+#include <linux/verification.h>
 #include <keys/system_keyring.h>
 #include "blacklist.h"
 #include "common.h"
@@ -26,6 +27,9 @@
  */
 #define MAX_HASH_LEN	128
 
+#define BLACKLIST_KEY_PERM (KEY_POS_SEARCH | KEY_POS_VIEW | \
+			    KEY_USR_SEARCH | KEY_USR_VIEW)
+
 static const char tbs_prefix[] = "tbs";
 static const char bin_prefix[] = "bin";
 
@@ -78,19 +82,51 @@ static int blacklist_vet_description(const char *desc)
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
@@ -101,9 +137,8 @@ static void blacklist_describe(const struct key *key, struct seq_file *m)
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
 
@@ -152,8 +187,7 @@ static int mark_raw_hash_blacklisted(const char *hash)
 				   hash,
 				   NULL,
 				   0,
-				   ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
-				    KEY_USR_VIEW),
+				   BLACKLIST_KEY_PERM,
 				   KEY_ALLOC_NOT_IN_QUOTA |
 				   KEY_ALLOC_BUILT_IN);
 	if (IS_ERR(key)) {
@@ -172,8 +206,10 @@ int add_key_to_revocation_list(const char *data, size_t size)
 				   NULL,
 				   data,
 				   size,
-				   ((KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW),
-				   KEY_ALLOC_NOT_IN_QUOTA | KEY_ALLOC_BUILT_IN);
+				   KEY_POS_VIEW | KEY_POS_READ | KEY_POS_SEARCH
+				   | KEY_USR_VIEW,
+				   KEY_ALLOC_NOT_IN_QUOTA | KEY_ALLOC_BUILT_IN
+				   | KEY_ALLOC_BYPASS_RESTRICTION);
 
 	if (IS_ERR(key)) {
 		pr_err("Problem with revocation key (%ld)\n", PTR_ERR(key));
@@ -247,25 +283,43 @@ int is_binary_blacklisted(const u8 *hash, size_t hash_len)
 }
 EXPORT_SYMBOL_GPL(is_binary_blacklisted);
 
+static int restrict_link_for_blacklist(struct key *dest_keyring,
+		const struct key_type *type, const union key_payload *payload,
+		struct key *restrict_key)
+{
+	if (type == &key_type_blacklist)
+		return 0;
+	return -EOPNOTSUPP;
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

