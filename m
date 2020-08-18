Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E963E248AE4
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 18:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgHRP5x (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 11:57:53 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2645 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727078AbgHRPqy (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 11:46:54 -0400
Received: from lhreml722-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id B4D0FC3716F45B9B5797;
        Tue, 18 Aug 2020 16:46:51 +0100 (IST)
Received: from kstruczy-linux-box (10.204.65.138) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 16:46:49 +0100
Received: by kstruczy-linux-box (sSMTP sendmail emulation); Tue, 18 Aug 2020 17:46:52 +0200
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
Subject: [RFC PATCH 22/30] ima: Remap IDs of subject based rules if necessary
Date:   Tue, 18 Aug 2020 17:42:22 +0200
Message-ID: <20200818154230.14016-13-krzysztof.struczynski@huawei.com>
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

If subject based rule is added to the policy before the user namespace
uid mapping is defined, ID has to be recalculated.

It can happen if the new user namespace is created alongside the new
ima namespace. The default policy rules are loaded when the first
process is born into the new ima namespace. In that case, user has no
chance to define the mapping. It can also happen for the custom policy
rules loaded from within the new ima namespace, before the mapping is
created.

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 security/integrity/ima/ima_policy.c | 83 ++++++++++++++++++++++++-----
 1 file changed, 70 insertions(+), 13 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index d4774eab6a98..bc1a4bb10bd0 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -18,6 +18,7 @@
 #include <linux/genhd.h>
 #include <linux/seq_file.h>
 #include <linux/ima.h>
+#include <linux/user_namespace.h>
 
 #include "ima.h"
 
@@ -78,6 +79,10 @@ struct ima_rule_entry {
 	char *fsname;
 	char *keyrings; /* Measure keys added to these keyrings */
 	struct ima_template_desc *template;
+	bool remap_uid; /* IDs of all subject oriented rules, added before the
+			 * user namespace mapping is defined,
+			 * have to be remapped.
+			 */
 };
 
 /*
@@ -484,6 +489,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 			    const char *keyring)
 {
 	int i;
+	kuid_t remapped_kuid;
+	struct ima_namespace *current_ima_ns = get_current_ns();
 
 	if (func == KEY_CHECK) {
 		return (rule->flags & IMA_FUNC) && (rule->func == func) &&
@@ -507,21 +514,45 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	if ((rule->flags & IMA_FSUUID) &&
 	    !uuid_equal(&rule->fsuuid, &inode->i_sb->s_uuid))
 		return false;
-	if ((rule->flags & IMA_UID) && !rule->uid_op(cred->uid, rule->uid))
-		return false;
+	if (rule->flags & IMA_UID) {
+		if (rule->remap_uid) {
+			remapped_kuid = make_kuid(current_ima_ns->user_ns,
+						  __kuid_val(rule->uid));
+			if (!uid_valid(remapped_kuid))
+				return false;
+		} else
+			remapped_kuid = rule->uid;
+		if (!rule->uid_op(cred->uid, remapped_kuid))
+			return false;
+	}
 	if (rule->flags & IMA_EUID) {
+		if (rule->remap_uid) {
+			remapped_kuid = make_kuid(current_ima_ns->user_ns,
+						  __kuid_val(rule->uid));
+			if (!uid_valid(remapped_kuid))
+				return false;
+		} else
+			remapped_kuid = rule->uid;
 		if (has_capability_noaudit(current, CAP_SETUID)) {
-			if (!rule->uid_op(cred->euid, rule->uid)
-			    && !rule->uid_op(cred->suid, rule->uid)
-			    && !rule->uid_op(cred->uid, rule->uid))
+			if (!rule->uid_op(cred->euid, remapped_kuid)
+			    && !rule->uid_op(cred->suid, remapped_kuid)
+			    && !rule->uid_op(cred->uid, remapped_kuid))
 				return false;
-		} else if (!rule->uid_op(cred->euid, rule->uid))
+		} else if (!rule->uid_op(cred->euid, remapped_kuid))
 			return false;
 	}
 
-	if ((rule->flags & IMA_FOWNER) &&
-	    !rule->fowner_op(inode->i_uid, rule->fowner))
-		return false;
+	if (rule->flags & IMA_FOWNER) {
+		if (rule->remap_uid) {
+			remapped_kuid = make_kuid(current_ima_ns->user_ns,
+						  __kuid_val(rule->fowner));
+			if (!uid_valid(remapped_kuid))
+				return false;
+		} else
+			remapped_kuid = rule->fowner;
+		if (!rule->fowner_op(inode->i_uid, remapped_kuid))
+			return false;
+	}
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
 		u32 osid;
@@ -701,6 +732,9 @@ static void add_rules(struct ima_namespace *ima_ns,
 
 	for (i = 0; i < count; i++) {
 		struct ima_rule_entry *entry;
+		bool set_uidmap;
+
+		set_uidmap = userns_set_uidmap(ima_ns->user_ns);
 
 		if (policy_rule & IMA_DEFAULT_POLICY) {
 			entry = &entries[i];
@@ -709,6 +743,9 @@ static void add_rules(struct ima_namespace *ima_ns,
 						GFP_KERNEL);
 				if (!entry)
 					continue;
+
+				if (!set_uidmap)
+					entry->remap_uid = true;
 			}
 
 			list_add_tail(&entry->list,
@@ -721,6 +758,9 @@ static void add_rules(struct ima_namespace *ima_ns,
 			if (!entry)
 				continue;
 
+			if (ima_ns != &init_ima_ns && !set_uidmap)
+				entry->remap_uid = true;
+
 			list_add_tail(&entry->list,
 				      &ima_ns->policy_data->ima_policy_rules);
 		}
@@ -1165,6 +1205,10 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry,
 	ab = integrity_audit_log_start(audit_context(), GFP_KERNEL,
 				       AUDIT_INTEGRITY_POLICY_RULE);
 
+	if ((ima_ns != &init_ima_ns) &&
+	    (!userns_set_uidmap(ima_ns->user_ns)))
+		entry->remap_uid = true;
+
 	entry->uid = INVALID_UID;
 	entry->fowner = INVALID_UID;
 	entry->uid_op = &uid_eq;
@@ -1396,8 +1440,13 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry,
 
 			result = kstrtoul(args[0].from, 10, &lnum);
 			if (!result) {
-				entry->uid = make_kuid(current_user_ns(),
-						       (uid_t) lnum);
+				if (!entry->remap_uid)
+					entry->uid =
+						make_kuid(current_user_ns(),
+							  (uid_t) lnum);
+				else
+					entry->uid = KUIDT_INIT((uid_t) lnum);
+
 				if (!uid_valid(entry->uid) ||
 				    (uid_t)lnum != lnum)
 					result = -EINVAL;
@@ -1424,8 +1473,16 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry,
 
 			result = kstrtoul(args[0].from, 10, &lnum);
 			if (!result) {
-				entry->fowner = make_kuid(current_user_ns(), (uid_t)lnum);
-				if (!uid_valid(entry->fowner) || (((uid_t)lnum) != lnum))
+				if (!entry->remap_uid)
+					entry->fowner =
+						make_kuid(current_user_ns(),
+							  (uid_t) lnum);
+				else
+					entry->fowner =
+						KUIDT_INIT((uid_t) lnum);
+
+				if (!uid_valid(entry->fowner) ||
+				    (((uid_t)lnum) != lnum))
 					result = -EINVAL;
 				else
 					entry->flags |= IMA_FOWNER;
-- 
2.20.1

