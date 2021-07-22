Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625E83D20B1
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Jul 2021 11:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhGVIiE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Jul 2021 04:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbhGVIh6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Jul 2021 04:37:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0B6C0613C1
        for <linux-integrity@vger.kernel.org>; Thu, 22 Jul 2021 02:18:33 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1m6UqF-0001NO-DL; Thu, 22 Jul 2021 11:18:07 +0200
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1m6UqC-0001D1-HE; Thu, 22 Jul 2021 11:18:04 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Song Liu <song@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-raid@vger.kernel.org, keyrings@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [RFC PATCH v1 4/4] ubifs: auth: consult encrypted and trusted keys if no logon key was found
Date:   Thu, 22 Jul 2021 11:18:02 +0200
Message-Id: <f5891611f329583baef32089c8b322850d81166a.1626945419.git-series.a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.b2fdd70b830d12853b12a12e32ceb0c8162c1346.1626945419.git-series.a.fatoum@pengutronix.de>
References: <cover.b2fdd70b830d12853b12a12e32ceb0c8162c1346.1626945419.git-series.a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Currently, UBIFS auth_key can only be a logon key: This is a user key
that's provided to the kernel in plaintext and that then remains within
the kernel. Linux also supports trusted and encrypted keys, which have
stronger guarantees: They are only exposed to userspace in encrypted
form and, in the case of trusted keys, can be directly rooted to a trust
source like a TPM chip.

Add support for auth_key to be either a logon, encrypted or trusted key.
At mount time, the keyring will be searched for a key with the supplied
name in that order.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
To: David Howells <dhowells@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
To: James Morris <jmorris@namei.org>
To: "Serge E. Hallyn" <serge@hallyn.com>
To: Alasdair Kergon <agk@redhat.com>
To: Mike Snitzer <snitzer@redhat.com>
To: dm-devel@redhat.com
To: Song Liu <song@kernel.org>
To: Richard Weinberger <richard@nod.at>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-raid@vger.kernel.org
Cc: keyrings@vger.kernel.org
Cc: linux-mtd@lists.infradead.org
Cc: linux-security-module@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
---
 Documentation/filesystems/ubifs.rst |  2 +-
 fs/ubifs/auth.c                     | 19 ++++++++++++-------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/Documentation/filesystems/ubifs.rst b/Documentation/filesystems/ubifs.rst
index e6ee99762534..12d08458b3d7 100644
--- a/Documentation/filesystems/ubifs.rst
+++ b/Documentation/filesystems/ubifs.rst
@@ -101,7 +101,7 @@ compr=zlib              override default compressor and set it to "zlib"
 auth_key=		specify the key used for authenticating the filesystem.
 			Passing this option makes authentication mandatory.
 			The passed key must be present in the kernel keyring
-			and must be of type 'logon'
+			and must be of type 'logon', 'encrypted' or 'trusted'.
 auth_hash_name=		The hash algorithm used for authentication. Used for
 			both hashing and for creating HMACs. Typical values
 			include "sha256" or "sha512"
diff --git a/fs/ubifs/auth.c b/fs/ubifs/auth.c
index 6a0b8d858d81..af8e9eb58a60 100644
--- a/fs/ubifs/auth.c
+++ b/fs/ubifs/auth.c
@@ -14,6 +14,8 @@
 #include <crypto/hash.h>
 #include <crypto/algapi.h>
 #include <keys/user-type.h>
+#include <keys/trusted-type.h>
+#include <keys/encrypted-type.h>
 #include <keys/asymmetric-type.h>
 
 #include "ubifs.h"
@@ -256,9 +258,10 @@ out_destroy:
 int ubifs_init_authentication(struct ubifs_info *c)
 {
 	struct key *keyring_key;
-	const struct user_key_payload *ukp;
 	int err;
+	unsigned int len;
 	char hmac_name[CRYPTO_MAX_ALG_NAME];
+	const void *key_material;
 
 	if (!c->auth_hash_name) {
 		ubifs_err(c, "authentication hash name needed with authentication");
@@ -277,6 +280,10 @@ int ubifs_init_authentication(struct ubifs_info *c)
 		 c->auth_hash_name);
 
 	keyring_key = request_key(&key_type_logon, c->auth_key_name, NULL);
+	if (IS_ERR(keyring_key) && IS_REACHABLE(CONFIG_ENCRYPTED_KEYS))
+		keyring_key = request_key(&key_type_encrypted, c->auth_key_name, NULL);
+	if (IS_ERR(keyring_key) && IS_REACHABLE(CONFIG_TRUSTED_KEYS))
+		keyring_key = request_key(&key_type_trusted, c->auth_key_name, NULL);
 
 	if (IS_ERR(keyring_key)) {
 		ubifs_err(c, "Failed to request key: %ld",
@@ -286,12 +293,10 @@ int ubifs_init_authentication(struct ubifs_info *c)
 
 	down_read(&keyring_key->sem);
 
-	ukp = user_key_payload_locked(keyring_key);
-	if (!ukp) {
-		/* key was revoked before we acquired its semaphore */
-		err = -EKEYREVOKED;
+	key_material = key_extract_material(keyring_key, &len);
+	err = PTR_ERR_OR_ZERO(key_material);
+	if (err < 0)
 		goto out;
-	}
 
 	c->hash_tfm = crypto_alloc_shash(c->auth_hash_name, 0, 0);
 	if (IS_ERR(c->hash_tfm)) {
@@ -324,7 +329,7 @@ int ubifs_init_authentication(struct ubifs_info *c)
 		goto out_free_hmac;
 	}
 
-	err = crypto_shash_setkey(c->hmac_tfm, ukp->data, ukp->datalen);
+	err = crypto_shash_setkey(c->hmac_tfm, key_material, len);
 	if (err)
 		goto out_free_hmac;
 
-- 
git-series 0.9.1
