Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7F8248AAF
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 17:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgHRPve (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 11:51:34 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2650 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728236AbgHRPsF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 11:48:05 -0400
Received: from lhreml722-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 9C8BD5D5C87FB618FA08;
        Tue, 18 Aug 2020 16:48:03 +0100 (IST)
Received: from kstruczy-linux-box (10.204.65.138) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 16:48:01 +0100
Received: by kstruczy-linux-box (sSMTP sendmail emulation); Tue, 18 Aug 2020 17:48:04 +0200
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
Subject: [RFC PATCH 27/30] integrity: Add key domain tag to the search criteria
Date:   Tue, 18 Aug 2020 17:42:27 +0200
Message-ID: <20200818154230.14016-18-krzysztof.struczynski@huawei.com>
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

Add key domain tag to the search criteria in digsig module. If the
domain tag is not set for the keys from the given keyring, it is set to
NULL and the behaviour is unchanged.

The key domain tag is added to the ima appraisal keys loaded to the
system ima keyring.

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 include/linux/digsig.h                 | 11 ++++---
 lib/digsig.c                           | 11 +++----
 security/integrity/digsig.c            | 40 ++++++++++++++++++++++----
 security/integrity/digsig_asymmetric.c | 20 ++++++++-----
 security/integrity/integrity.h         | 11 ++++---
 5 files changed, 67 insertions(+), 26 deletions(-)

diff --git a/include/linux/digsig.h b/include/linux/digsig.h
index 2ace69e41088..9e4121253899 100644
--- a/include/linux/digsig.h
+++ b/include/linux/digsig.h
@@ -44,13 +44,16 @@ struct signature_hdr {
 
 #if defined(CONFIG_SIGNATURE) || defined(CONFIG_SIGNATURE_MODULE)
 
-int digsig_verify(struct key *keyring, const char *sig, int siglen,
-					const char *digest, int digestlen);
+int digsig_verify(struct key *keyring, struct key_tag *domain_tag,
+		  const char *sig, int siglen, const char *digest,
+		  int digestlen);
 
 #else
 
-static inline int digsig_verify(struct key *keyring, const char *sig,
-				int siglen, const char *digest, int digestlen)
+static inline int digsig_verify(struct key *keyring,
+				struct key_tag *domain_tag,
+				const char *sig, int siglen, const char *digest,
+				int digestlen)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/lib/digsig.c b/lib/digsig.c
index e0627c3e53b2..bd234b1abb4f 100644
--- a/lib/digsig.c
+++ b/lib/digsig.c
@@ -196,8 +196,8 @@ static int digsig_verify_rsa(struct key *key,
  * Normally hash of the content is used as a data for this function.
  *
  */
-int digsig_verify(struct key *keyring, const char *sig, int siglen,
-						const char *data, int datalen)
+int digsig_verify(struct key *keyring, struct key_tag *domain_tag,
+		  const char *sig, int siglen, const char *data, int datalen)
 {
 	int err = -ENOMEM;
 	struct signature_hdr *sh = (struct signature_hdr *)sig;
@@ -217,14 +217,15 @@ int digsig_verify(struct key *keyring, const char *sig, int siglen,
 	if (keyring) {
 		/* search in specific keyring */
 		key_ref_t kref;
-		kref = keyring_search(make_key_ref(keyring, 1UL),
-				      &key_type_user, name, true);
+		kref = keyring_search_tag(make_key_ref(keyring, 1UL),
+					  &key_type_user, name,
+					  domain_tag, true);
 		if (IS_ERR(kref))
 			key = ERR_CAST(kref);
 		else
 			key = key_ref_to_ptr(kref);
 	} else {
-		key = request_key(&key_type_user, name, NULL);
+		key = request_key_tag(&key_type_user, name, domain_tag, NULL);
 	}
 	if (IS_ERR(key)) {
 		pr_err("key not found, id: %s\n", name);
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index e9cbadade74b..523fc786c4d7 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -15,6 +15,7 @@
 #include <linux/vmalloc.h>
 #include <crypto/public_key.h>
 #include <keys/system_keyring.h>
+#include <linux/ima.h>
 
 #include "integrity.h"
 
@@ -31,6 +32,16 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
 	".platform",
 };
 
+static unsigned long keyring_alloc_flags[INTEGRITY_KEYRING_MAX] = {
+	KEY_ALLOC_NOT_IN_QUOTA,
+#ifdef CONFIG_IMA_NS
+	KEY_ALLOC_NOT_IN_QUOTA | KEY_ALLOC_DOMAIN_IMA,
+#else
+	KEY_ALLOC_NOT_IN_QUOTA,
+#endif
+	KEY_ALLOC_NOT_IN_QUOTA,
+};
+
 #ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
 #define restrict_link_to_ima restrict_link_by_builtin_and_secondary_trusted
 #else
@@ -56,10 +67,22 @@ static struct key *integrity_keyring_from_id(const unsigned int id)
 	return keyring[id];
 }
 
+static struct key_tag *domain_tag_from_id(const unsigned int id)
+{
+	if (id >= INTEGRITY_KEYRING_MAX)
+		return ERR_PTR(-EINVAL);
+
+	if (id == INTEGRITY_KEYRING_IMA)
+		return current->nsproxy->ima_ns->key_domain;
+
+	return NULL;
+}
+
 int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
 			    const char *digest, int digestlen)
 {
 	struct key *keyring;
+	struct key_tag *domain_tag;
 
 	if (siglen < 2)
 		return -EINVAL;
@@ -68,14 +91,18 @@ int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
 	if (IS_ERR(keyring))
 		return PTR_ERR(keyring);
 
+	domain_tag = domain_tag_from_id(id);
+	if (IS_ERR(domain_tag))
+		return PTR_ERR(domain_tag);
+
 	switch (sig[1]) {
 	case 1:
 		/* v1 API expect signature without xattr type */
-		return digsig_verify(keyring, sig + 1, siglen - 1, digest,
-				     digestlen);
+		return digsig_verify(keyring, domain_tag,
+				     sig + 1, siglen - 1, digest, digestlen);
 	case 2:
-		return asymmetric_verify(keyring, sig, siglen, digest,
-					 digestlen);
+		return asymmetric_verify(keyring, domain_tag, sig, siglen,
+					 digest, digestlen);
 	}
 
 	return -EOPNOTSUPP;
@@ -101,7 +128,8 @@ static int __init __integrity_init_keyring(const unsigned int id,
 
 	keyring[id] = keyring_alloc(keyring_name[id], KUIDT_INIT(0),
 				    KGIDT_INIT(0), cred, perm,
-				    KEY_ALLOC_NOT_IN_QUOTA, restriction, NULL);
+				    keyring_alloc_flags[id],
+				    restriction, NULL);
 	if (IS_ERR(keyring[id])) {
 		err = PTR_ERR(keyring[id]);
 		pr_info("Can't allocate %s keyring (%d)\n",
@@ -153,7 +181,7 @@ int __init integrity_add_key(const unsigned int id, const void *data,
 
 	key = key_create_or_update(make_key_ref(keyring[id], 1), "asymmetric",
 				   NULL, data, size, perm,
-				   KEY_ALLOC_NOT_IN_QUOTA);
+				   keyring_alloc_flags[id]);
 	if (IS_ERR(key)) {
 		rc = PTR_ERR(key);
 		pr_err("Problem loading X.509 certificate %d\n", rc);
diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index cfa4127d0518..4994a9773247 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -19,7 +19,9 @@
 /*
  * Request an asymmetric key.
  */
-static struct key *request_asymmetric_key(struct key *keyring, uint32_t keyid)
+static struct key *request_asymmetric_key(struct key *keyring,
+					  struct key_tag *domain_tag,
+					  uint32_t keyid)
 {
 	struct key *key;
 	char name[12];
@@ -44,14 +46,16 @@ static struct key *request_asymmetric_key(struct key *keyring, uint32_t keyid)
 		/* search in specific keyring */
 		key_ref_t kref;
 
-		kref = keyring_search(make_key_ref(keyring, 1),
-				      &key_type_asymmetric, name, true);
+		kref = keyring_search_tag(make_key_ref(keyring, 1),
+					  &key_type_asymmetric, name,
+					  domain_tag, true);
 		if (IS_ERR(kref))
 			key = ERR_CAST(kref);
 		else
 			key = key_ref_to_ptr(kref);
 	} else {
-		key = request_key(&key_type_asymmetric, name, NULL);
+		key = request_key_tag(&key_type_asymmetric,
+				      name, domain_tag, NULL);
 	}
 
 	if (IS_ERR(key)) {
@@ -73,8 +77,9 @@ static struct key *request_asymmetric_key(struct key *keyring, uint32_t keyid)
 	return key;
 }
 
-int asymmetric_verify(struct key *keyring, const char *sig,
-		      int siglen, const char *data, int datalen)
+int asymmetric_verify(struct key *keyring, struct key_tag *domain_tag,
+		      const char *sig, int siglen,
+		      const char *data, int datalen)
 {
 	struct public_key_signature pks;
 	struct signature_v2_hdr *hdr = (struct signature_v2_hdr *)sig;
@@ -92,7 +97,8 @@ int asymmetric_verify(struct key *keyring, const char *sig,
 	if (hdr->hash_algo >= HASH_ALGO__LAST)
 		return -ENOPKG;
 
-	key = request_asymmetric_key(keyring, be32_to_cpu(hdr->keyid));
+	key = request_asymmetric_key(keyring, domain_tag,
+				     be32_to_cpu(hdr->keyid));
 	if (IS_ERR(key))
 		return PTR_ERR(key);
 
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index c2981a98547e..207a1aef28e4 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -212,11 +212,14 @@ static inline int __init integrity_load_cert(const unsigned int id,
 #endif /* CONFIG_INTEGRITY_SIGNATURE */
 
 #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
-int asymmetric_verify(struct key *keyring, const char *sig,
-		      int siglen, const char *data, int datalen);
+int asymmetric_verify(struct key *keyring, struct key_tag *domain_tag,
+		      const char *sig, int siglen,
+		      const char *data, int datalen);
 #else
-static inline int asymmetric_verify(struct key *keyring, const char *sig,
-				    int siglen, const char *data, int datalen)
+static inline int asymmetric_verify(struct key *keyring,
+				    struct key_tag *domain_tag,
+				    const char *sig, int siglen,
+				    const char *data, int datalen)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.20.1

