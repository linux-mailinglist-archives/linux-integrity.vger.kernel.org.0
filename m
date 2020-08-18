Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4EF4248A83
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 17:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgHRPvg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 11:51:36 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2648 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727826AbgHRPsA (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 11:48:00 -0400
Received: from lhreml722-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id E729ED50D5FCC4DDD013;
        Tue, 18 Aug 2020 16:47:58 +0100 (IST)
Received: from kstruczy-linux-box (10.204.65.138) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 16:47:56 +0100
Received: by kstruczy-linux-box (sSMTP sendmail emulation); Tue, 18 Aug 2020 17:47:59 +0200
From:   <krzysztof.struczynski@huawei.com>
To:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <containers@lists.linux-foundation.org>,
        <linux-security-module@vger.kernel.org>
CC:     <zohar@linux.ibm.com>, <stefanb@linux.vnet.ibm.com>,
        <sunyuqiong1988@gmail.com>, <mkayaalp@cs.binghamton.edu>,
        <dmitry.kasatkin@gmail.com>, <serge@hallyn.com>,
        <jmorris@namei.org>, <christian@brauner.io>,
        <silviu.vlasceanu@huawei.com>, <roberto.sassu@huawei.com>,
        Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
Subject: [RFC PATCH 25/30] keys: Allow to set key domain tag separately from the key type
Date:   Tue, 18 Aug 2020 17:42:25 +0200
Message-ID: <20200818154230.14016-16-krzysztof.struczynski@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200818154230.14016-1-krzysztof.struczynski@huawei.com>
References: <20200818154230.14016-1-krzysztof.struczynski@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.65.138]
X-ClientProxiedBy: fraeml707-chm.china.huawei.com (10.206.15.35) To
 lhreml722-chm.china.huawei.com (10.201.108.73)
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>

Add KEY_ALLOC_DOMAIN_* flags so that the key domain tag can be
specified on the key creation. This is done to separate the
key domain setting from the key type.

If applied to the keyring, it will set the requested domain tag for
every key added to that keyring.

IMA uses the existing key_type_asymmetric for appraisal, but also has
to specify the key domain to bind appraisal key with the ima namespace.

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 include/linux/key.h | 10 ++++++++++
 security/keys/key.c | 16 ++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/key.h b/include/linux/key.h
index 223ab9d76d15..47430cd7fbc6 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -272,6 +272,12 @@ struct key {
 	 * restriction.
 	 */
 	struct key_restriction *restrict_link;
+
+	/* This is set on a keyring to indicate that every key added to this
+	 * keyring should be tagged with a given key domain tag. It is ignored
+	 * for the non-keyring keys and can be overridden by the key-type flags.
+	 */
+	unsigned long key_alloc_domain;
 };
 
 extern struct key *key_alloc(struct key_type *type,
@@ -290,6 +296,10 @@ extern struct key *key_alloc(struct key_type *type,
 #define KEY_ALLOC_BYPASS_RESTRICTION	0x0008	/* Override the check on restricted keyrings */
 #define KEY_ALLOC_UID_KEYRING		0x0010	/* allocating a user or user session keyring */
 
+/* Only one domain can be set */
+#define KEY_ALLOC_DOMAIN_IMA		0x0100  /* add IMA domain tag, based on the "current" */
+#define KEY_ALLOC_DOMAIN_MASK		0xFF00
+
 extern void key_revoke(struct key *key);
 extern void key_invalidate(struct key *key);
 extern void key_put(struct key *key);
diff --git a/security/keys/key.c b/security/keys/key.c
index e282c6179b21..1b0183d33bbc 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -278,6 +278,19 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	if (!key)
 		goto no_memory_2;
 
+	if (flags & KEY_ALLOC_DOMAIN_MASK) {
+		/* set alloc domain for all keys added to this keyring */
+		if (type == &key_type_keyring)
+			key->key_alloc_domain = (flags & KEY_ALLOC_DOMAIN_MASK);
+
+		/* set domain tag if it's not predefined for the key type */
+		if ((!type->flags) && (flags & KEY_ALLOC_DOMAIN_IMA))
+			/* Set it to something meaningful after adding a key
+			 * domain to the ima namespace.
+			 */
+			key->index_key.domain_tag = NULL;
+	}
+
 	key->index_key.desc_len = desclen;
 	key->index_key.description = kmemdup(desc, desclen + 1, GFP_KERNEL);
 	if (!key->index_key.description)
@@ -925,6 +938,9 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 			perm |= KEY_POS_WRITE;
 	}
 
+	if (keyring->key_alloc_domain)
+		flags |= keyring->key_alloc_domain;
+
 	/* allocate a new key */
 	key = key_alloc(index_key.type, index_key.description,
 			cred->fsuid, cred->fsgid, cred, perm, flags, NULL);
-- 
2.20.1

