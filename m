Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A04248A64
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 17:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgHRPsV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 11:48:21 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2649 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728218AbgHRPsC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 11:48:02 -0400
Received: from lhreml722-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 582E3AB7CD1EE9FB02EE;
        Tue, 18 Aug 2020 16:48:01 +0100 (IST)
Received: from kstruczy-linux-box (10.204.65.138) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 16:47:59 +0100
Received: by kstruczy-linux-box (sSMTP sendmail emulation); Tue, 18 Aug 2020 17:48:02 +0200
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
Subject: [RFC PATCH 26/30] ima: Add key domain to the ima namespace
Date:   Tue, 18 Aug 2020 17:42:26 +0200
Message-ID: <20200818154230.14016-17-krzysztof.struczynski@huawei.com>
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

Add key domain to the ima namespace. This will allow to bind the
appraisal keys with the namespace and store all appraisal keys in the
ima system keyring.

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 include/linux/ima.h               |  3 +++
 security/integrity/ima/ima_init.c |  8 ++++++++
 security/integrity/ima/ima_ns.c   | 14 ++++++++++++++
 security/keys/key.c               | 10 +++++++---
 4 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 158028834747..7db4995c66cf 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -208,6 +208,9 @@ struct ima_namespace {
 	char *policy_path_for_children;
 	char *x509_path_for_children;
 	struct ima_policy_setup_data *policy_setup_for_children;
+#ifdef CONFIG_KEYS
+	struct key_tag *key_domain;
+#endif
 } __randomize_layout;
 
 extern struct ima_namespace init_ima_ns;
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index d14c6689f422..1668edf3ed32 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -18,6 +18,7 @@
 #include <linux/kref.h>
 #include <linux/proc_ns.h>
 #include <linux/user_namespace.h>
+#include <linux/key.h>
 
 #include "ima.h"
 
@@ -25,6 +26,10 @@
 const char boot_aggregate_name[] = "boot_aggregate";
 struct tpm_chip *ima_tpm_chip;
 
+#ifdef CONFIG_KEYS
+static struct key_tag init_ima_key_domain = { .usage = REFCOUNT_INIT(1) };
+#endif
+
 struct ima_namespace init_ima_ns = {
 	.kref = KREF_INIT(2),
 	.user_ns = &init_user_ns,
@@ -41,6 +46,9 @@ struct ima_namespace init_ima_ns = {
 	.measurements = &ima_measurements,
 	.ml_len = ATOMIC_LONG_INIT(0),
 	.violations = ATOMIC_LONG_INIT(0),
+#ifdef CONFIG_KEYS
+	.key_domain = &init_ima_key_domain,
+#endif
 };
 EXPORT_SYMBOL(init_ima_ns);
 
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index ec3abc803c82..872dc6a96a96 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -28,6 +28,7 @@
 #include <linux/mutex.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
+#include <linux/key.h>
 
 #include "ima.h"
 
@@ -65,8 +66,16 @@ static struct ima_namespace *ima_ns_alloc(void)
 	if (!ima_ns->iint_tree)
 		goto policy_free;
 
+#ifdef CONFIG_KEYS
+	ima_ns->key_domain = kzalloc(sizeof(struct key_tag), GFP_KERNEL);
+	if (!ima_ns->key_domain)
+		goto iint_free;
+#endif
+
 	return ima_ns;
 
+iint_free:
+	kfree(ima_ns->iint_tree);
 policy_free:
 	kfree(ima_ns->policy_data);
 ns_free:
@@ -171,6 +180,9 @@ static struct ima_namespace *clone_ima_ns(struct user_namespace *user_ns,
 	rwlock_init(&ns->iint_tree->lock);
 	ns->iint_tree->root = RB_ROOT;
 
+#ifdef CONFIG_KEYS
+	refcount_set(&ns->key_domain->usage, 1);
+#endif
 	ns->policy_path_for_children = NULL;
 	ns->x509_path_for_children = NULL;
 	ns->policy_setup_for_children = NULL;
@@ -184,6 +196,7 @@ static struct ima_namespace *clone_ima_ns(struct user_namespace *user_ns,
 fail_free:
 	kfree(ns->iint_tree);
 	kfree(ns->policy_data);
+	kfree(ns->key_domain);
 	kfree(ns);
 fail_dec:
 	dec_ima_namespaces(ucounts);
@@ -239,6 +252,7 @@ static void destroy_ima_ns(struct ima_namespace *ns)
 	bool is_init_ns = (ns == &init_ima_ns);
 
 	dec_ima_namespaces(ns->ucounts);
+	key_remove_domain(ns->key_domain);
 	put_user_ns(ns->user_ns);
 	ns_free_inum(&ns->ns);
 	integrity_iint_tree_free(ns->iint_tree);
diff --git a/security/keys/key.c b/security/keys/key.c
index 1b0183d33bbc..fca0d12f5c71 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -285,10 +285,14 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 
 		/* set domain tag if it's not predefined for the key type */
 		if ((!type->flags) && (flags & KEY_ALLOC_DOMAIN_IMA))
-			/* Set it to something meaningful after adding a key
-			 * domain to the ima namespace.
+			/* Use ima_ns_for_children, not ima_ns. ima_ns_for
+			 * children is equal to ima_ns, unless ima namespace was
+			 * unshared and the new namespace is being configured.
+			 * In that case, new keys should be associated with the
+			 * new ima namespace.
 			 */
-			key->index_key.domain_tag = NULL;
+			key->index_key.domain_tag =
+				current->nsproxy->ima_ns_for_children->key_domain;
 	}
 
 	key->index_key.desc_len = desclen;
-- 
2.20.1

