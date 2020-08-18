Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1ECC248A5C
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 17:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgHRPrH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 11:47:07 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2646 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726919AbgHRPqz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 11:46:55 -0400
Received: from lhreml722-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 1F9E3230D78712014B70;
        Tue, 18 Aug 2020 16:46:54 +0100 (IST)
Received: from kstruczy-linux-box (10.204.65.138) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 16:46:52 +0100
Received: by kstruczy-linux-box (sSMTP sendmail emulation); Tue, 18 Aug 2020 17:46:55 +0200
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
Subject: [RFC PATCH 23/30] keys: Add domain tag to the keyring search criteria
Date:   Tue, 18 Aug 2020 17:42:23 +0200
Message-ID: <20200818154230.14016-14-krzysztof.struczynski@huawei.com>
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

Add keyring_search_tag() version of keyring_search(), that allows to
specify the key domain tag.

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 include/linux/key.h     | 17 +++++++++++++----
 security/keys/keyring.c | 15 +++++++++------
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index 0f2e24f13c2b..223ab9d76d15 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -416,10 +416,11 @@ extern int restrict_link_reject(struct key *keyring,
 
 extern int keyring_clear(struct key *keyring);
 
-extern key_ref_t keyring_search(key_ref_t keyring,
-				struct key_type *type,
-				const char *description,
-				bool recurse);
+extern key_ref_t keyring_search_tag(key_ref_t keyring,
+				    struct key_type *type,
+				    const char *description,
+				    struct key_tag *domain_tag,
+				    bool recurse);
 
 extern int keyring_add_key(struct key *keyring,
 			   struct key *key);
@@ -429,6 +430,14 @@ extern int keyring_restrict(key_ref_t keyring, const char *type,
 
 extern struct key *key_lookup(key_serial_t id);
 
+static inline key_ref_t keyring_search(key_ref_t keyring,
+				       struct key_type *type,
+				       const char *description,
+				       bool recurse)
+{
+	return keyring_search_tag(keyring, type, description, NULL, recurse);
+}
+
 static inline key_serial_t key_serial(const struct key *key)
 {
 	return key ? key->serial : 0;
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 14abfe765b7e..12583241ff63 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -925,22 +925,25 @@ key_ref_t keyring_search_rcu(key_ref_t keyring_ref,
 }
 
 /**
- * keyring_search - Search the supplied keyring tree for a matching key
+ * keyring_search_tag - Search the supplied keyring tree for a matching key
  * @keyring: The root of the keyring tree to be searched.
  * @type: The type of keyring we want to find.
  * @description: The name of the keyring we want to find.
+ * @domain_tag: The domain_tag of the key we want to find.
  * @recurse: True to search the children of @keyring also
  *
  * As keyring_search_rcu() above, but using the current task's credentials and
  * type's default matching function and preferred search method.
  */
-key_ref_t keyring_search(key_ref_t keyring,
-			 struct key_type *type,
-			 const char *description,
-			 bool recurse)
+key_ref_t keyring_search_tag(key_ref_t keyring,
+			     struct key_type *type,
+			     const char *description,
+			     struct key_tag *domain_tag,
+			     bool recurse)
 {
 	struct keyring_search_context ctx = {
 		.index_key.type		= type,
+		.index_key.domain_tag   = domain_tag,
 		.index_key.description	= description,
 		.index_key.desc_len	= strlen(description),
 		.cred			= current_cred(),
@@ -968,7 +971,7 @@ key_ref_t keyring_search(key_ref_t keyring,
 		type->match_free(&ctx.match_data);
 	return key;
 }
-EXPORT_SYMBOL(keyring_search);
+EXPORT_SYMBOL(keyring_search_tag);
 
 static struct key_restriction *keyring_restriction_alloc(
 	key_restrict_link_func_t check)
-- 
2.20.1

