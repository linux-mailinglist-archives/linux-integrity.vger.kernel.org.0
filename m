Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA3C2FF107
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Jan 2021 17:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733029AbhAUQvJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 Jan 2021 11:51:09 -0500
Received: from smtp-8fab.mail.infomaniak.ch ([83.166.143.171]:57787 "EHLO
        smtp-8fab.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731359AbhAUP6H (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Jan 2021 10:58:07 -0500
X-Greylist: delayed 102748 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jan 2021 10:57:08 EST
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DM6Rh3kCQzMr37d;
        Thu, 21 Jan 2021 16:55:28 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4DM6Rh1G3Pzlpq00;
        Thu, 21 Jan 2021 16:55:28 +0100 (CET)
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
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v4 04/10] certs: Fix blacklist flag type confusion
Date:   Thu, 21 Jan 2021 16:55:07 +0100
Message-Id: <20210121155513.539519-5-mic@digikod.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121155513.539519-1-mic@digikod.net>
References: <20210121155513.539519-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: David Howells <dhowells@redhat.com>

KEY_FLAG_KEEP is not meant to be passed to keyring_alloc() or
key_alloc(), as these only take KEY_ALLOC_* flags.  KEY_FLAG_KEEP has
the same value as KEY_ALLOC_BYPASS_RESTRICTION, but fortunately only
key_create_or_update() uses it.  LSMs using the key_alloc hook don't
check that flag.

KEY_FLAG_KEEP is then ignored but fortunately (again) the root user
cannot write to the blacklist keyring, so it is not possible to remove a
key/hash from it.

Fix this by adding a KEY_ALLOC_SET_KEEP flag that tells key_alloc() to
set KEY_FLAG_KEEP on the new key.  blacklist_init() can then, correctly,
pass this to keyring_alloc().

ima_mok_init() allocates another blacklist keyring (with different
properties) dedicated to IMA.  We can also use KEY_ALLOC_SET_KEEP in
ima_mok_init() rather than setting the flag manually.

Note that this doesn't fix an observable bug with the current
implementation but it is required to allow addition of new hashes to the
blacklist in the future without making it possible for them to be
removed or modified.

Fixes: 734114f8782f ("KEYS: Add a system blacklist keyring")
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Reported-by: Mickaël Salaün <mic@linux.microsoft.com>
Signed-off-by: David Howells <dhowells@redhat.com>
[mic@linux.microsoft.com: Fix argument bit-ORing in ima_mok_init() and
extend commit description]
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
---

Changes since v3:
* Extend ima_mok_init() description (suggested by Jarkko Sakkinen).
* Add Acked-by Jarkko Sakkinen.

Changes since v2:
* Cherry-pick rewritten v1 patch from
  https://lore.kernel.org/lkml/2659836.1607940186@warthog.procyon.org.uk/
  to rebase on v5.11-rc3 and fix ima_mok_init().
---
 certs/blacklist.c                | 2 +-
 include/linux/key.h              | 1 +
 security/integrity/ima/ima_mok.c | 4 +---
 security/keys/key.c              | 2 ++
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/certs/blacklist.c b/certs/blacklist.c
index 4e1a58170d5c..446818e90b54 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -162,7 +162,7 @@ static int __init blacklist_init(void)
 			      KEY_USR_VIEW | KEY_USR_READ |
 			      KEY_USR_SEARCH,
 			      KEY_ALLOC_NOT_IN_QUOTA |
-			      KEY_FLAG_KEEP,
+			      KEY_ALLOC_SET_KEEP,
 			      NULL, NULL);
 	if (IS_ERR(blacklist_keyring))
 		panic("Can't allocate system blacklist keyring\n");
diff --git a/include/linux/key.h b/include/linux/key.h
index 0f2e24f13c2b..eed3ce139a32 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -289,6 +289,7 @@ extern struct key *key_alloc(struct key_type *type,
 #define KEY_ALLOC_BUILT_IN		0x0004	/* Key is built into kernel */
 #define KEY_ALLOC_BYPASS_RESTRICTION	0x0008	/* Override the check on restricted keyrings */
 #define KEY_ALLOC_UID_KEYRING		0x0010	/* allocating a user or user session keyring */
+#define KEY_ALLOC_SET_KEEP		0x0020	/* Set the KEEP flag on the key/keyring */
 
 extern void key_revoke(struct key *key);
 extern void key_invalidate(struct key *key);
diff --git a/security/integrity/ima/ima_mok.c b/security/integrity/ima/ima_mok.c
index 36cadadbfba4..5594dd38ab04 100644
--- a/security/integrity/ima/ima_mok.c
+++ b/security/integrity/ima/ima_mok.c
@@ -38,13 +38,11 @@ __init int ima_mok_init(void)
 				(KEY_POS_ALL & ~KEY_POS_SETATTR) |
 				KEY_USR_VIEW | KEY_USR_READ |
 				KEY_USR_WRITE | KEY_USR_SEARCH,
-				KEY_ALLOC_NOT_IN_QUOTA,
+				KEY_ALLOC_NOT_IN_QUOTA | KEY_ALLOC_SET_KEEP,
 				restriction, NULL);
 
 	if (IS_ERR(ima_blacklist_keyring))
 		panic("Can't allocate IMA blacklist keyring.");
-
-	set_bit(KEY_FLAG_KEEP, &ima_blacklist_keyring->flags);
 	return 0;
 }
 device_initcall(ima_mok_init);
diff --git a/security/keys/key.c b/security/keys/key.c
index ebe752b137aa..c45afdd1dfbb 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -303,6 +303,8 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 		key->flags |= 1 << KEY_FLAG_BUILTIN;
 	if (flags & KEY_ALLOC_UID_KEYRING)
 		key->flags |= 1 << KEY_FLAG_UID_KEYRING;
+	if (flags & KEY_ALLOC_SET_KEEP)
+		key->flags |= 1 << KEY_FLAG_KEEP;
 
 #ifdef KEY_DEBUGGING
 	key->magic = KEY_DEBUG_MAGIC;
-- 
2.30.0

