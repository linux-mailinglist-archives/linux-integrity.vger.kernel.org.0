Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8283D20B3
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Jul 2021 11:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhGVIiF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Jul 2021 04:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbhGVIh7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Jul 2021 04:37:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1103C0613D3
        for <linux-integrity@vger.kernel.org>; Thu, 22 Jul 2021 02:18:34 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1m6UqE-0001NL-VW; Thu, 22 Jul 2021 11:18:06 +0200
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1m6UqC-0001Cm-EB; Thu, 22 Jul 2021 11:18:04 +0200
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
Subject: [RFC PATCH v1 1/4] keys: introduce key_extract_material helper
Date:   Thu, 22 Jul 2021 11:17:59 +0200
Message-Id: <d3ae98bb8d00c2be4529694630132bdcabf383c0.1626945419.git-series.a.fatoum@pengutronix.de>
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

While keys of differing type have a common struct key definition, there is
no common scheme to the payload and key material extraction differs.

For kernel functionality that supports different key types,
this means duplicated code for key material extraction and because key type
is discriminated by a pointer to a global, users need to replicate
reachability checks as well, so builtin code doesn't depend on a key
type symbol offered by a module.

Make this easier by adding a common helper with initial support for
user, logon, encrypted and trusted keys. The code is taken from
dm-crypt, which is migrated to use the helper in a later commit.

The implementation must be partially in a header to support configurations
where the key type symbol is defined in a module, but key support in general
is built-in.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
I am not sure whether the chosen header and source file are the best
places for this. This could be made header-only too if that's preferred.

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
 include/linux/key.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
 security/keys/key.c | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/include/linux/key.h b/include/linux/key.h
index 7febc4881363..916612f5b313 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -20,6 +20,8 @@
 #include <linux/assoc_array.h>
 #include <linux/refcount.h>
 #include <linux/time64.h>
+#include <linux/err.h>
+#include <linux/kconfig.h>
 
 #ifdef __KERNEL__
 #include <linux/uidgid.h>
@@ -487,6 +489,48 @@ extern void key_fsuid_changed(struct cred *new_cred);
 extern void key_fsgid_changed(struct cred *new_cred);
 extern void key_init(void);
 
+/*
+ * internal use, so key core code need not link against
+ * all supported key types
+ * */
+enum __key_type {
+	KEY_TYPE_UNKNOWN, KEY_TYPE_USER, KEY_TYPE_ENCRYPTED, KEY_TYPE_TRUSTED
+};
+
+const void *__key_extract_material(const struct key *key, enum __key_type type,
+				   unsigned int *len);
+
+/**
+ * key_extract_material - Extract decrypted data out of a key
+ * @key: a logon, user, encrypted or trusted key
+ * @len: pointer to variable to store key size into
+ *
+ * Extract decrypted data out of supported key types
+ *
+ * Returns a pointer to the key material if successfull or an error
+ * pointer if key type is not compiled in, the buffer is too
+ * small or the key was revoked.
+ */
+static inline const void *key_extract_material(const struct key *key,
+					       unsigned int *len)
+{
+	extern struct key_type key_type_user;
+	extern struct key_type key_type_logon;
+	extern struct key_type key_type_encrypted;
+	extern struct key_type key_type_trusted;
+	enum __key_type type = KEY_TYPE_UNKNOWN;
+	const struct key_type *t = key->type;
+
+	if (t == &key_type_logon || t == &key_type_user)
+		type = KEY_TYPE_USER;
+	else if (IS_REACHABLE(CONFIG_ENCRYPTED_KEYS) && t == &key_type_encrypted)
+		type = KEY_TYPE_ENCRYPTED;
+	else if (IS_REACHABLE(CONFIG_TRUSTED_KEYS) && t == &key_type_trusted)
+		type = KEY_TYPE_TRUSTED;
+
+	return __key_extract_material(key, type, len);
+}
+
 #else /* CONFIG_KEYS */
 
 #define key_validate(k)			0
@@ -504,6 +548,7 @@ extern void key_init(void);
 #define key_init()			do { } while(0)
 #define key_free_user_ns(ns)		do { } while(0)
 #define key_remove_domain(d)		do { } while(0)
+#define key_extract_material(k, l)	ERR_PTR(-EINVAL)
 
 #endif /* CONFIG_KEYS */
 #endif /* __KERNEL__ */
diff --git a/security/keys/key.c b/security/keys/key.c
index c45afdd1dfbb..69cd1cb8c413 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -15,6 +15,9 @@
 #include <linux/random.h>
 #include <linux/ima.h>
 #include <linux/err.h>
+#include <keys/user-type.h>
+#include <keys/encrypted-type.h>
+#include <keys/trusted-type.h>
 #include "internal.h"
 
 struct kmem_cache *key_jar;
@@ -1140,6 +1143,43 @@ int generic_key_instantiate(struct key *key, struct key_preparsed_payload *prep)
 }
 EXPORT_SYMBOL(generic_key_instantiate);
 
+const void *__key_extract_material(const struct key *key,
+				   enum __key_type type, unsigned int *len)
+{
+	const struct encrypted_key_payload *ekp;
+	const struct trusted_key_payload *tkp;
+	const struct user_key_payload *ukp;
+
+	switch (type) {
+	case KEY_TYPE_USER:
+		ukp = user_key_payload_locked(key);
+		if (!ukp)
+			break;
+
+		*len = ukp->datalen;
+		return ukp->data;
+	case KEY_TYPE_ENCRYPTED:
+		ekp = key->payload.data[0];
+		if (!ekp)
+			break;
+
+		*len = ekp->decrypted_datalen;
+		return ekp->decrypted_data;
+	case KEY_TYPE_TRUSTED:
+		tkp = key->payload.data[0];
+		if (!tkp)
+			break;
+
+		*len = tkp->key_len;
+		return tkp->key;
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+
+	return ERR_PTR(-EKEYREVOKED);
+}
+EXPORT_SYMBOL(__key_extract_material);
+
 /**
  * register_key_type - Register a type of key.
  * @ktype: The new key type.
-- 
git-series 0.9.1
