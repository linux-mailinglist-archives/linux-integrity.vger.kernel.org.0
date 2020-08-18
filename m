Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA0E2489CE
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 17:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgHRP0z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 11:26:55 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2627 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726904AbgHRP0Q (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 11:26:16 -0400
Received: from lhreml722-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 19CE374562B957EF2E99;
        Tue, 18 Aug 2020 16:26:15 +0100 (IST)
Received: from kstruczy-linux-box (10.204.65.138) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 16:26:13 +0100
Received: by kstruczy-linux-box (sSMTP sendmail emulation); Tue, 18 Aug 2020 17:26:15 +0200
From:   <krzysztof.struczynski@huawei.com>
To:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <containers@lists.linux-foundation.org>,
        <linux-security-module@vger.kernel.org>
CC:     Krzysztof Struczynski <krzysztof.struczynski@huawei.com>,
        <zohar@linux.ibm.com>, <stefanb@linux.vnet.ibm.com>,
        <sunyuqiong1988@gmail.com>, <mkayaalp@cs.binghamton.edu>,
        <dmitry.kasatkin@gmail.com>, <serge@hallyn.com>,
        <jmorris@namei.org>, <christian@brauner.io>,
        <silviu.vlasceanu@huawei.com>, <roberto.sassu@huawei.com>
Subject: [RFC PATCH 04/30] ima: Add ima policy related data to the ima namespace
Date:   Tue, 18 Aug 2020 17:20:11 +0200
Message-ID: <20200818152037.11869-5-krzysztof.struczynski@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200818152037.11869-1-krzysztof.struczynski@huawei.com>
References: <N>
 <20200818152037.11869-1-krzysztof.struczynski@huawei.com>
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

Collate global variables describing the ima policy in one structure and
add it to the ima namespace. Collate setup data (parsed kernel boot
parameters) in a separate structure.

Per namespace policy is not yet properly set and it is not used. This
will be done in the following patches.

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 include/linux/ima.h                 |  2 ++
 security/integrity/ima/ima.h        | 24 +++++++++++++++++
 security/integrity/ima/ima_init.c   |  3 ++-
 security/integrity/ima/ima_ns.c     | 41 +++++++++++++++++++++++++++--
 security/integrity/ima/ima_policy.c | 26 ++++++++++++++++++
 5 files changed, 93 insertions(+), 3 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 3954cef57c00..d61c9c21ffb9 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -16,6 +16,7 @@ struct nsproxy;
 struct task_struct;
 struct list_head;
 struct llist_node;
+struct ima_policy_data;
 
 #ifdef CONFIG_IMA
 extern int ima_bprm_check(struct linux_binprm *bprm);
@@ -188,6 +189,7 @@ struct ima_namespace {
 	struct llist_node cleanup_list; /* namespaces on a death row */
 	atomic_t inactive; /* set only when ns is added to the cleanup list */
 	bool frozen;
+	struct ima_policy_data *policy_data;
 } __randomize_layout;
 
 extern struct ima_namespace init_ima_ns;
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 092e87190c6d..0d88222e3500 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -60,6 +60,14 @@ extern int ima_appraise;
 extern struct tpm_chip *ima_tpm_chip;
 extern const char boot_aggregate_name[];
 
+/* IMA policy setup data */
+struct ima_policy_setup_data {
+	int ima_policy;
+	int ima_appraise;
+	bool ima_use_secure_boot;
+	bool ima_use_appraise_tcb;
+};
+
 /* IMA event related data */
 struct ima_event_data {
 	struct integrity_iint_cache *iint;
@@ -286,6 +294,8 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		     struct ima_template_desc **template_desc,
 		     const char *keyring);
 void ima_init_policy(void);
+void ima_init_ns_policy(struct ima_namespace *ima_ns,
+			const struct ima_policy_setup_data *policy_setup_data);
 void ima_update_policy(void);
 void ima_update_policy_flag(void);
 ssize_t ima_parse_add_rule(char *);
@@ -372,6 +382,20 @@ static inline int ima_read_xattr(struct dentry *dentry,
 
 #endif /* CONFIG_IMA_APPRAISE */
 
+struct ima_policy_data {
+	struct list_head ima_default_rules;
+	struct list_head ima_policy_rules;
+	struct list_head ima_temp_rules;
+	struct list_head *ima_rules;
+	bool ima_fail_unverifiable_sigs;
+	int ima_policy_flag; /* current content of the policy */
+	int ima_appraise;
+	int temp_ima_appraise;
+};
+
+extern struct ima_policy_data init_policy_data;
+extern struct ima_policy_setup_data init_policy_setup_data;
+
 extern struct list_head ima_ns_list;
 extern struct rw_semaphore ima_ns_list_lock;
 
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 0ba04a1a68cc..ea5ff42eb7fe 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -32,7 +32,8 @@ struct ima_namespace init_ima_ns = {
 #ifdef CONFIG_IMA_NS
 	.ns.ops = &imans_operations,
 #endif
-	.frozen = true
+	.frozen = true,
+	.policy_data = &init_policy_data,
 };
 EXPORT_SYMBOL(init_ima_ns);
 
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index 3a98cd536d05..1aeb9cfeb3a2 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -51,9 +51,38 @@ static struct ima_namespace *ima_ns_alloc(void)
 
 	ima_ns = kzalloc(sizeof(*ima_ns), GFP_KERNEL);
 	if (!ima_ns)
-		return NULL;
+		goto out;
+
+	ima_ns->policy_data = kzalloc(sizeof(struct ima_policy_data),
+				      GFP_KERNEL);
+	if (!ima_ns->policy_data)
+		goto out_free;
 
 	return ima_ns;
+
+out_free:
+	kfree(ima_ns);
+out:
+	return NULL;
+}
+
+static void ima_set_ns_policy(struct ima_namespace *ima_ns,
+			      char *policy_setup_str)
+{
+	struct ima_policy_setup_data setup_data;
+
+#ifdef CONFIG_IMA_APPRAISE
+	setup_data.ima_appraise = IMA_APPRAISE_ENFORCE;
+#endif
+	/* Configuring IMA namespace will be implemented in the following
+	 * patches. When it is done, parse configuration string and store result
+	 * in setup_data. Temporarily use init_policy_setup_data.
+	 */
+	setup_data = init_policy_setup_data;
+	ima_ns->policy_data->ima_fail_unverifiable_sigs =
+		init_ima_ns.policy_data->ima_fail_unverifiable_sigs;
+
+	ima_init_ns_policy(ima_ns, &setup_data);
 }
 
 /**
@@ -64,7 +93,7 @@ static struct ima_namespace *ima_ns_alloc(void)
  * Return:	ERR_PTR(-ENOMEM) on error (failure to kmalloc), new ns otherwise
  */
 static struct ima_namespace *clone_ima_ns(struct user_namespace *user_ns,
-					   struct ima_namespace *old_ns)
+					  struct ima_namespace *old_ns)
 {
 	struct ima_namespace *ns;
 	struct ucounts *ucounts;
@@ -91,9 +120,14 @@ static struct ima_namespace *clone_ima_ns(struct user_namespace *user_ns,
 	ns->ucounts = ucounts;
 	ns->frozen = false;
 
+	INIT_LIST_HEAD(&ns->policy_data->ima_default_rules);
+	INIT_LIST_HEAD(&ns->policy_data->ima_policy_rules);
+	INIT_LIST_HEAD(&ns->policy_data->ima_temp_rules);
+
 	return ns;
 
 fail_free:
+	kfree(ns->policy_data);
 	kfree(ns);
 fail_dec:
 	dec_ima_namespaces(ucounts);
@@ -139,6 +173,7 @@ static void destroy_ima_ns(struct ima_namespace *ns)
 	dec_ima_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
 	ns_free_inum(&ns->ns);
+	kfree(ns->policy_data);
 	kfree(ns);
 }
 
@@ -238,6 +273,8 @@ static int imans_activate(struct ima_namespace *ima_ns)
 	if (ima_ns->frozen)
 		goto out;
 
+	ima_set_ns_policy(ima_ns, NULL);
+
 	ima_ns->frozen = true;
 
 	down_write(&ima_ns_list_lock);
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 07f033634b27..6b56741ec1c9 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -212,6 +212,17 @@ static size_t ima_keyrings_len;
 
 static int ima_policy __initdata;
 
+struct ima_policy_setup_data init_policy_setup_data = {
+#ifdef CONFIG_IMA_APPRAISE
+	.ima_appraise = IMA_APPRAISE_ENFORCE,
+#endif
+};
+struct ima_policy_data init_policy_data = {
+	.ima_default_rules = LIST_HEAD_INIT(init_policy_data.ima_default_rules),
+	.ima_policy_rules = LIST_HEAD_INIT(init_policy_data.ima_policy_rules),
+	.ima_temp_rules = LIST_HEAD_INIT(init_policy_data.ima_temp_rules),
+};
+
 static int __init default_measure_policy_setup(char *str)
 {
 	if (ima_policy)
@@ -715,6 +726,21 @@ static int __init ima_init_arch_policy(void)
 	return i;
 }
 
+/**
+ * ima_init_ns_policy - initialize the default measure rules.
+ * @ima_ns: pointer to the namespace whose rules are being initialized
+ * @setup_data: pointer to the policy setup data
+ */
+void ima_init_ns_policy(struct ima_namespace *ima_ns,
+			const struct ima_policy_setup_data *setup_data)
+{
+	/* Set policy rules to the empty set of default rules. The rest will be
+	 * implemented after namespacing policy.
+	 */
+	ima_ns->policy_data->ima_rules =
+		&ima_ns->policy_data->ima_default_rules;
+}
+
 /**
  * ima_init_policy - initialize the default measure rules.
  *
-- 
2.20.1

