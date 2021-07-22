Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003AF3D20BA
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Jul 2021 11:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhGVIik (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Jul 2021 04:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbhGVIiL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Jul 2021 04:38:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B13C0613D5
        for <linux-integrity@vger.kernel.org>; Thu, 22 Jul 2021 02:18:42 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1m6UqE-0001NM-VX; Thu, 22 Jul 2021 11:18:06 +0200
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1m6UqC-0001Cr-FA; Thu, 22 Jul 2021 11:18:04 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Song Liu <song@kernel.org>, Richard Weinberger <richard@nod.at>
Cc:     kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        keyrings@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [RFC PATCH v1 2/4] dm: crypt: use new key_extract_material helper
Date:   Thu, 22 Jul 2021 11:18:00 +0200
Message-Id: <7ac4a9ae0a3c2dfdf41611f3fe78fe63a6e57b94.1626945419.git-series.a.fatoum@pengutronix.de>
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

There is a common function now to extract key material out of a few
different key types, which includes all types currently supported by
dm-crypt. Make use of it.

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
Cc: linux-kernel@vger.kernel.org
Cc: linux-raid@vger.kernel.org
Cc: keyrings@vger.kernel.org
Cc: linux-mtd@lists.infradead.org
Cc: linux-security-module@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
---
 drivers/md/dm-crypt.c | 65 ++++++--------------------------------------
 1 file changed, 9 insertions(+), 56 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 50f4cbd600d5..576d6b7ce231 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -2421,61 +2421,14 @@ static bool contains_whitespace(const char *str)
 	return false;
 }
 
-static int set_key_user(struct crypt_config *cc, struct key *key)
-{
-	const struct user_key_payload *ukp;
-
-	ukp = user_key_payload_locked(key);
-	if (!ukp)
-		return -EKEYREVOKED;
-
-	if (cc->key_size != ukp->datalen)
-		return -EINVAL;
-
-	memcpy(cc->key, ukp->data, cc->key_size);
-
-	return 0;
-}
-
-static int set_key_encrypted(struct crypt_config *cc, struct key *key)
-{
-	const struct encrypted_key_payload *ekp;
-
-	ekp = key->payload.data[0];
-	if (!ekp)
-		return -EKEYREVOKED;
-
-	if (cc->key_size != ekp->decrypted_datalen)
-		return -EINVAL;
-
-	memcpy(cc->key, ekp->decrypted_data, cc->key_size);
-
-	return 0;
-}
-
-static int set_key_trusted(struct crypt_config *cc, struct key *key)
-{
-	const struct trusted_key_payload *tkp;
-
-	tkp = key->payload.data[0];
-	if (!tkp)
-		return -EKEYREVOKED;
-
-	if (cc->key_size != tkp->key_len)
-		return -EINVAL;
-
-	memcpy(cc->key, tkp->key, cc->key_size);
-
-	return 0;
-}
-
 static int crypt_set_keyring_key(struct crypt_config *cc, const char *key_string)
 {
 	char *new_key_string, *key_desc;
 	int ret;
+	unsigned int len;
 	struct key_type *type;
 	struct key *key;
-	int (*set_key)(struct crypt_config *cc, struct key *key);
+	const void *key_material;
 
 	/*
 	 * Reject key_string with whitespace. dm core currently lacks code for
@@ -2493,18 +2446,14 @@ static int crypt_set_keyring_key(struct crypt_config *cc, const char *key_string
 
 	if (!strncmp(key_string, "logon:", key_desc - key_string + 1)) {
 		type = &key_type_logon;
-		set_key = set_key_user;
 	} else if (!strncmp(key_string, "user:", key_desc - key_string + 1)) {
 		type = &key_type_user;
-		set_key = set_key_user;
 	} else if (IS_ENABLED(CONFIG_ENCRYPTED_KEYS) &&
 		   !strncmp(key_string, "encrypted:", key_desc - key_string + 1)) {
 		type = &key_type_encrypted;
-		set_key = set_key_encrypted;
 	} else if (IS_ENABLED(CONFIG_TRUSTED_KEYS) &&
 	           !strncmp(key_string, "trusted:", key_desc - key_string + 1)) {
 		type = &key_type_trusted;
-		set_key = set_key_trusted;
 	} else {
 		return -EINVAL;
 	}
@@ -2521,14 +2470,18 @@ static int crypt_set_keyring_key(struct crypt_config *cc, const char *key_string
 
 	down_read(&key->sem);
 
-	ret = set_key(cc, key);
-	if (ret < 0) {
+	key_material = key_extract_material(key, &len);
+	if (!IS_ERR(key_material) && len != cc->key_size)
+		key_material = ERR_PTR(-EINVAL);
+	if (IS_ERR(key_material)) {
 		up_read(&key->sem);
 		key_put(key);
 		kfree_sensitive(new_key_string);
-		return ret;
+		return PTR_ERR(key_material);
 	}
 
+	memcpy(cc->key, key_material, len);
+
 	up_read(&key->sem);
 	key_put(key);
 
-- 
git-series 0.9.1
