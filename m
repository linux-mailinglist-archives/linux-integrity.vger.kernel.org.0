Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A20248AE1
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 17:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgHRP5y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 11:57:54 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2643 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726896AbgHRPqs (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 11:46:48 -0400
Received: from lhreml722-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 4971565230692438BF5F;
        Tue, 18 Aug 2020 16:46:47 +0100 (IST)
Received: from kstruczy-linux-box (10.204.65.138) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 16:46:45 +0100
Received: by kstruczy-linux-box (sSMTP sendmail emulation); Tue, 18 Aug 2020 17:46:48 +0200
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
Subject: [RFC PATCH 20/30] ima: Parse per ima namespace policy file
Date:   Tue, 18 Aug 2020 17:42:20 +0200
Message-ID: <20200818154230.14016-11-krzysztof.struczynski@huawei.com>
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

Parse per ima namespace policy file if the file path is set.

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 security/integrity/ima/ima.h        |  7 ++++---
 security/integrity/ima/ima_fs.c     | 17 +++++++++++------
 security/integrity/ima/ima_ns.c     | 18 ++++++++++++++++--
 security/integrity/ima/ima_policy.c | 25 +++++++++++--------------
 4 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 48d09efaffbe..b55d25c2bf63 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -309,10 +309,10 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 void ima_init_policy(void);
 void ima_init_ns_policy(struct ima_namespace *ima_ns,
 			const struct ima_policy_setup_data *policy_setup_data);
-void ima_update_policy(void);
+void ima_update_policy(struct ima_namespace *ima_ns);
 void ima_update_policy_flag(struct ima_namespace *ima_ns);
-ssize_t ima_parse_add_rule(char *);
-void ima_delete_rules(void);
+ssize_t ima_parse_add_rule(char *rule, struct ima_namespace *ima_ns);
+void ima_delete_rules(struct ima_namespace *ima_ns);
 int ima_check_policy(const struct ima_namespace *ima_ns);
 void *ima_policy_start(struct seq_file *m, loff_t *pos);
 void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos);
@@ -439,6 +439,7 @@ static inline struct ima_namespace *get_current_ns(void)
 
 void ima_delete_ns_rules(struct ima_policy_data *policy_data,
 			 bool is_root_ns);
+ssize_t ima_read_ns_policy(char *path, struct ima_namespace *ima_ns);
 
 ssize_t ima_ns_write_policy_for_children(struct ima_namespace *ima_ns,
 					 char *policy_path);
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 6c033857f521..7b93c338a478 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -343,7 +343,7 @@ static const struct file_operations ima_ascii_measurements_ops = {
 	.release = seq_release,
 };
 
-static ssize_t ima_read_policy(char *path)
+static ssize_t ima_read_policy(char *path, struct ima_namespace *ima_ns)
 {
 	void *data;
 	char *datap;
@@ -365,7 +365,7 @@ static ssize_t ima_read_policy(char *path)
 	datap = data;
 	while (size > 0 && (p = strsep(&datap, "\n"))) {
 		pr_debug("rule: %s\n", p);
-		rc = ima_parse_add_rule(p);
+		rc = ima_parse_add_rule(p, ima_ns);
 		if (rc < 0)
 			break;
 		size -= rc;
@@ -406,7 +406,7 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 		goto out_free;
 
 	if (data[0] == '/') {
-		result = ima_read_policy(data);
+		result = ima_read_policy(data, ima_ns);
 	} else if (ima_ns->policy_data->ima_appraise & IMA_APPRAISE_POLICY) {
 		pr_err("signed policy file (specified as an absolute pathname) required\n");
 		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
@@ -414,7 +414,7 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 				    1, 0);
 		result = -EACCES;
 	} else {
-		result = ima_parse_add_rule(data);
+		result = ima_parse_add_rule(data, ima_ns);
 	}
 	mutex_unlock(&ima_write_mutex);
 out_free:
@@ -502,13 +502,13 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 			    "policy_update", cause, !valid_policy, 0);
 
 	if (!valid_policy) {
-		ima_delete_rules();
+		ima_delete_rules(ima_ns);
 		valid_policy = 1;
 		clear_bit(IMA_FS_BUSY, &ima_fs_flags);
 		return 0;
 	}
 
-	ima_update_policy();
+	ima_update_policy(ima_ns);
 #if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)
 	securityfs_remove(ima_policy);
 	ima_policy = NULL;
@@ -629,6 +629,11 @@ static const struct file_operations ima_kcmd_for_children_ops = {
 	.open = ima_open_for_children,
 	.write = ima_write_kcmd_for_children,
 };
+
+ssize_t ima_read_ns_policy(char *path, struct ima_namespace *ima_ns)
+{
+	return ima_read_policy(path, ima_ns);
+}
 #endif /* CONFIG_IMA_NS */
 
 int __init ima_fs_init(void)
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index dd0328ee715f..ec3abc803c82 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -91,10 +91,24 @@ static int ima_set_ns_policy(struct ima_namespace *ima_ns)
 		setup_data.ima_appraise = IMA_APPRAISE_ENFORCE;
 #endif
 		ima_init_ns_policy(ima_ns, &setup_data);
-		return result;
+	} else {
+		ima_init_ns_policy(ima_ns, ima_ns->policy_setup_for_children);
 	}
 
-	ima_init_ns_policy(ima_ns, ima_ns->policy_setup_for_children);
+	if (ima_ns->policy_path_for_children) {
+		result = ima_read_ns_policy(ima_ns->policy_path_for_children,
+					    ima_ns);
+		if ((result >= 0) && !ima_check_policy(ima_ns)) {
+			integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
+					    "policy_update", "completed", 0, 0);
+			ima_update_policy(ima_ns);
+		} else {
+			ima_delete_rules(ima_ns);
+			ima_delete_ns_rules(ima_ns->policy_data, false);
+			integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
+					    "policy_update", "failed", 1, 0);
+		}
+	}
 
 	return result;
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 3d712c062ed0..d4774eab6a98 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -735,7 +735,8 @@ static void add_rules(struct ima_namespace *ima_ns,
 	}
 }
 
-static int ima_parse_rule(char *rule, struct ima_rule_entry *entry);
+static int ima_parse_rule(char *rule, struct ima_rule_entry *entry,
+			  struct ima_namespace *ima_ns);
 
 static int __init ima_init_arch_policy(void)
 {
@@ -765,7 +766,8 @@ static int __init ima_init_arch_policy(void)
 		result = strlcpy(rule, *rules, sizeof(rule));
 
 		INIT_LIST_HEAD(&arch_policy_entry[i].list);
-		result = ima_parse_rule(rule, &arch_policy_entry[i]);
+		result = ima_parse_rule(rule, &arch_policy_entry[i],
+					&init_ima_ns);
 		if (result) {
 			pr_warn("Skipping unknown architecture policy rule: %s\n",
 				rule);
@@ -895,10 +897,8 @@ int ima_check_policy(const struct ima_namespace *ima_ns)
  * Policy rules are never deleted so ima_policy_flag gets zeroed only once when
  * we switch from the default policy to user defined.
  */
-void ima_update_policy(void)
+void ima_update_policy(struct ima_namespace *ima_ns)
 {
-	/* Update only the current ima namespace */
-	struct ima_namespace *ima_ns = get_current_ns();
 	struct list_head *policy = &ima_ns->policy_data->ima_policy_rules;
 
 	list_splice_tail_init_rcu(&ima_ns->policy_data->ima_temp_rules,
@@ -1151,7 +1151,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 	return true;
 }
 
-static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
+static int ima_parse_rule(char *rule, struct ima_rule_entry *entry,
+			  struct ima_namespace *ima_ns)
 {
 	struct audit_buffer *ab;
 	char *from;
@@ -1160,7 +1161,6 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	struct ima_template_desc *template_desc;
 	int result = 0;
 	size_t keyrings_len;
-	struct ima_namespace *ima_ns = get_current_ns();
 
 	ab = integrity_audit_log_start(audit_context(), GFP_KERNEL,
 				       AUDIT_INTEGRITY_POLICY_RULE);
@@ -1547,19 +1547,18 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 /**
  * ima_parse_add_rule - add a rule to ima_policy_rules
  * @rule - ima measurement policy rule
+ * @ima_ns - pointer to the ima namespace the rule will be added to
  *
  * Avoid locking by allowing just one writer at a time in ima_write_policy()
  * Returns the length of the rule parsed, an error code on failure
  */
-ssize_t ima_parse_add_rule(char *rule)
+ssize_t ima_parse_add_rule(char *rule, struct ima_namespace *ima_ns)
 {
 	static const char op[] = "update_policy";
 	char *p;
 	struct ima_rule_entry *entry;
 	ssize_t result, len;
 	int audit_info = 0;
-	/* Add rules only to the current ima namespace */
-	struct ima_namespace *ima_ns = get_current_ns();
 
 	p = strsep(&rule, "\n");
 	len = strlen(p) + 1;
@@ -1577,7 +1576,7 @@ ssize_t ima_parse_add_rule(char *rule)
 
 	INIT_LIST_HEAD(&entry->list);
 
-	result = ima_parse_rule(p, entry);
+	result = ima_parse_rule(p, entry, ima_ns);
 	if (result) {
 		ima_free_rule(entry);
 		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL,
@@ -1597,10 +1596,8 @@ ssize_t ima_parse_add_rule(char *rule)
  * different from the active one.  There is also only one user of
  * ima_delete_rules() at a time.
  */
-void ima_delete_rules(void)
+void ima_delete_rules(struct ima_namespace *ima_ns)
 {
-	/* Delete rules only from the current ima namespace */
-	struct ima_namespace *ima_ns = get_current_ns();
 	struct ima_rule_entry *entry, *tmp;
 
 	ima_ns->policy_data->temp_ima_appraise = 0;
-- 
2.20.1

