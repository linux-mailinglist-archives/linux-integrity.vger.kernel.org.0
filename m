Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47ECE68BF55
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Feb 2023 15:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjBFOEY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Feb 2023 09:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjBFOD6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Feb 2023 09:03:58 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D64193DC;
        Mon,  6 Feb 2023 06:03:47 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316DqOd9023216;
        Mon, 6 Feb 2023 14:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=CZP+InDTAq0So4cgPVablNaZRJXNzCvrDwoSplGTOys=;
 b=eQE+FC3cQyr8VDteDFdM+Nyu+GJH+nInDDEoEBe+WhtdlDRICQY0lbIt4RuPI8+oxYID
 o2yxpE2RAlc/9TU05BdrXn7Rrr9Sa8U5gYROpvsulmppQScVkdn/HBwSZQtutMtls/VI
 3N7Qst4AhO5jgFhLBVJtEAJYLFx+RW9kAQy/sNzzqGzvrrKE23Z0EumZjwMylaIdK4hV
 E4BNe1w/01akOeNJJATPSmyRyiMldfI0ucrqvjQOpQkuyvqs3sEKb85xfohNNxozPmco
 QwQg5RLypsw5ujSz1osOM6WWMygwgVQz0oB5xm3qm3O6F+xcN613uGsp4JuMEOgdvpJe vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk2tf0cha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:22 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 316DqRh5024552;
        Mon, 6 Feb 2023 14:03:22 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk2tf0cgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:21 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 316C0fjs001067;
        Mon, 6 Feb 2023 14:03:20 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3nhf072yhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:20 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 316E3JCe35455734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Feb 2023 14:03:19 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 796845805C;
        Mon,  6 Feb 2023 14:03:19 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0CFA5805B;
        Mon,  6 Feb 2023 14:03:17 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Feb 2023 14:03:17 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com, brauner@kernel.org,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v15 09/26] ima: Move ima_lsm_policy_notifier into ima_namespace
Date:   Mon,  6 Feb 2023 09:02:36 -0500
Message-Id: <20230206140253.3755945-10-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230206140253.3755945-1-stefanb@linux.ibm.com>
References: <20230206140253.3755945-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: z9p5hcknS4pyPIkYgBLchDHJASufR6qV
X-Proofpoint-ORIG-GUID: GUvVqS587z5HOXR2UFB4jpspTjLkX4FT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 mlxscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302060116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Move the ima_lsm_policy_notifier into the ima_namespace. Each IMA
namespace can now register its own LSM policy change notifier callback.
The policy change notifier for the init_ima_ns still remains in init_ima()
and therefore handle the registration of the callback for all other
namespaces in init_ima_namespace().

Rate-limit the kernel warning 'rule for LSM <label> is undefined` for
IMA namespace to avoid flooding the kernel log with this type of message.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Acked-by: Serge Hallyn <serge@hallyn.com>

---

v15:
 - Pass ima_namespace into ima_match_rules() to pass to ima_lsm_copy_rule()

v11:
 - Renamed 'rc' to 'ret'
 - Use pr_warn_ratelimited('rule for LSM...') for IMA namespaces

v10:
 - Only call pr_warn('rule for LSM <label> is undefined`) for init_ima_ns
---
 security/integrity/ima/ima.h             |  2 ++
 security/integrity/ima/ima_init_ima_ns.c | 14 ++++++++++
 security/integrity/ima/ima_main.c        |  6 +----
 security/integrity/ima/ima_policy.c      | 34 ++++++++++++++++--------
 4 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 75993ad061fa..db28d6d222a6 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -144,6 +144,8 @@ struct ima_namespace {
 	int valid_policy;
 
 	struct dentry *ima_policy;
+
+	struct notifier_block ima_lsm_policy_notifier;
 } __randomize_layout;
 extern struct ima_namespace init_ima_ns;
 
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index 425eed1c6838..c4fe8f3e9a73 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -10,6 +10,8 @@
 
 static int ima_init_namespace(struct ima_namespace *ns)
 {
+	int ret;
+
 	INIT_LIST_HEAD(&ns->ima_default_rules);
 	INIT_LIST_HEAD(&ns->ima_policy_rules);
 	INIT_LIST_HEAD(&ns->ima_temp_rules);
@@ -30,6 +32,15 @@ static int ima_init_namespace(struct ima_namespace *ns)
 	ns->valid_policy = 1;
 	ns->ima_fs_flags = 0;
 
+	if (ns != &init_ima_ns) {
+		ns->ima_lsm_policy_notifier.notifier_call =
+						ima_lsm_policy_change;
+		ret = register_blocking_lsm_notifier
+						(&ns->ima_lsm_policy_notifier);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -39,5 +50,8 @@ int __init ima_ns_init(void)
 }
 
 struct ima_namespace init_ima_ns = {
+	.ima_lsm_policy_notifier = {
+		.notifier_call = ima_lsm_policy_change,
+	},
 };
 EXPORT_SYMBOL(init_ima_ns);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index e3a3a54dc79e..c7a5f47b50fc 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -38,10 +38,6 @@ int ima_appraise;
 int __ro_after_init ima_hash_algo = HASH_ALGO_SHA1;
 static int hash_setup_done;
 
-static struct notifier_block ima_lsm_policy_notifier = {
-	.notifier_call = ima_lsm_policy_change,
-};
-
 static int __init hash_setup(char *str)
 {
 	struct ima_template_desc *template_desc = ima_template_desc_current();
@@ -1096,7 +1092,7 @@ static int __init init_ima(void)
 	if (error)
 		return error;
 
-	error = register_blocking_lsm_notifier(&ima_lsm_policy_notifier);
+	error = register_blocking_lsm_notifier(&ns->ima_lsm_policy_notifier);
 	if (error)
 		pr_warn("Couldn't register LSM notifier, error %d\n", error);
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 502b1e8021a6..8e71b28855a4 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -392,7 +392,8 @@ static void ima_free_rule(struct ima_rule_entry *entry)
 	kfree(entry);
 }
 
-static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
+static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_namespace *ns,
+						struct ima_rule_entry *entry)
 {
 	struct ima_rule_entry *nentry;
 	int i;
@@ -417,19 +418,26 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 		ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
 				     nentry->lsm[i].args_p,
 				     &nentry->lsm[i].rule);
-		if (!nentry->lsm[i].rule)
-			pr_warn("rule for LSM \'%s\' is undefined\n",
-				nentry->lsm[i].args_p);
+		if (!nentry->lsm[i].rule) {
+			if (ns == &init_ima_ns)
+				pr_warn("rule for LSM \'%s\' is undefined\n",
+					nentry->lsm[i].args_p);
+			else
+				pr_warn_ratelimited
+					("rule for LSM \'%s\' is undefined\n",
+					 nentry->lsm[i].args_p);
+		}
 	}
 	return nentry;
 }
 
-static int ima_lsm_update_rule(struct ima_rule_entry *entry)
+static int ima_lsm_update_rule(struct ima_namespace *ns,
+			       struct ima_rule_entry *entry)
 {
 	int i;
 	struct ima_rule_entry *nentry;
 
-	nentry = ima_lsm_copy_rule(entry);
+	nentry = ima_lsm_copy_rule(ns, entry);
 	if (!nentry)
 		return -ENOMEM;
 
@@ -473,7 +481,7 @@ static void ima_lsm_update_rules(struct ima_namespace *ns)
 		if (!ima_rule_contains_lsm_cond(entry))
 			continue;
 
-		result = ima_lsm_update_rule(entry);
+		result = ima_lsm_update_rule(ns, entry);
 		if (result) {
 			pr_err("lsm rule update error %d\n", result);
 			return;
@@ -484,12 +492,14 @@ static void ima_lsm_update_rules(struct ima_namespace *ns)
 int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 			  void *lsm_data)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns;
 
 	if (event != LSM_POLICY_CHANGE)
 		return NOTIFY_DONE;
 
+	ns = container_of(nb, struct ima_namespace, ima_lsm_policy_notifier);
 	ima_lsm_update_rules(ns);
+
 	return NOTIFY_OK;
 }
 
@@ -544,6 +554,7 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
 
 /**
  * ima_match_rules - determine whether an inode matches the policy rule.
+ * @ns: IMA namespace that has the policy
  * @rule: a pointer to a rule
  * @mnt_userns:	user namespace of the mount the inode was found from
  * @inode: a pointer to an inode
@@ -555,7 +566,8 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
  *
  * Returns true on rule match, false on failure.
  */
-static bool ima_match_rules(struct ima_rule_entry *rule,
+static bool ima_match_rules(struct ima_namespace *ns,
+			    struct ima_rule_entry *rule,
 			    struct user_namespace *mnt_userns,
 			    struct inode *inode, const struct cred *cred,
 			    u32 secid, enum ima_hooks func, int mask,
@@ -657,7 +669,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		}
 
 		if (rc == -ESTALE && !rule_reinitialized) {
-			lsm_rule = ima_lsm_copy_rule(rule);
+			lsm_rule = ima_lsm_copy_rule(ns, rule);
 			if (lsm_rule) {
 				rule_reinitialized = true;
 				goto retry;
@@ -747,7 +759,7 @@ int ima_match_policy(struct ima_namespace *ns,
 		if (!(entry->action & actmask))
 			continue;
 
-		if (!ima_match_rules(entry, mnt_userns, inode, cred, secid,
+		if (!ima_match_rules(ns, entry, mnt_userns, inode, cred, secid,
 				     func, mask, func_data))
 			continue;
 
-- 
2.37.3

