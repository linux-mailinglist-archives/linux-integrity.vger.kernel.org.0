Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C7656A61C
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jul 2022 16:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbiGGOtR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jul 2022 10:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236024AbiGGOsh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jul 2022 10:48:37 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218772ACF;
        Thu,  7 Jul 2022 07:48:37 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267EMf5u005799;
        Thu, 7 Jul 2022 14:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=2xO8/nJ3ytajOj89UUyS+ueaPpiG9WVzTZm7GBACuUc=;
 b=bdgii+TlfKiiLSaDUg18J4LY3JHkkwHdn1rU1DBSxVmXNCmiZHbNg3jp9V42HWUAzXgU
 hoshMz1gl4h2zBK2olQHoTUJdbHWPMPWvNjP52Z88/920n4DsgTdF9EE3x2CGnLgKfXH
 u8Q9moBGF3oDN6CsjZod15ZefCPgVuofLOHkLi4sTgzEJ/T1HaidkZtV0ogQuzSHw1qB
 5+pnM4lB6kee5AyQzmpveqhp+npSq2OVmWAKy4EjvAL8FOPMUK7ppNEtvOEQSMJq7/74
 SyM9gfw2JNvyNzkzyo1SmWv/7XPOFN7/wCMHl0hnRNnsFYS5QCkicx72eerweYSsopVh 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h611nha9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:08 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 267ENTg4009373;
        Thu, 7 Jul 2022 14:48:08 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h611nha8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:08 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 267EipG7015616;
        Thu, 7 Jul 2022 14:48:06 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04dal.us.ibm.com with ESMTP id 3h4uqy6sfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:06 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 267Em5Md33489294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jul 2022 14:48:05 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 552F3112065;
        Thu,  7 Jul 2022 14:48:05 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 405FF112062;
        Thu,  7 Jul 2022 14:48:05 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jul 2022 14:48:05 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v13 09/26] ima: Move ima_lsm_policy_notifier into ima_namespace
Date:   Thu,  7 Jul 2022 10:47:43 -0400
Message-Id: <20220707144800.828288-10-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707144800.828288-1-stefanb@linux.ibm.com>
References: <20220707144800.828288-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oR7AKB66Bf2f8uTN9cWmoa8e2nEtuczD
X-Proofpoint-ORIG-GUID: zfMJ3F3bW3bHplA5e4owU9u_q3O81Nol
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_12,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207070055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
v11:
 - Renamed 'rc' to 'ret'
 - Use pr_warn_ratelimited('rule for LSM...') for IMA namespaces

v10:
 - Only call pr_warn('rule for LSM <label> is undefined`) for init_ima_ns
---
 security/integrity/ima/ima.h             |  2 ++
 security/integrity/ima/ima_init_ima_ns.c | 14 +++++++++++++
 security/integrity/ima/ima_main.c        |  6 +-----
 security/integrity/ima/ima_policy.c      | 26 ++++++++++++++++--------
 4 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index b35c8504ef87..c68b5117d034 100644
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
index d27454d029e2..789415f65204 100644
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
@@ -1089,7 +1085,7 @@ static int __init init_ima(void)
 	if (error)
 		return error;
 
-	error = register_blocking_lsm_notifier(&ima_lsm_policy_notifier);
+	error = register_blocking_lsm_notifier(&ns->ima_lsm_policy_notifier);
 	if (error)
 		pr_warn("Couldn't register LSM notifier, error %d\n", error);
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index fe1096fd2703..d1e8a3d22e2b 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -368,7 +368,8 @@ static void ima_free_rule(struct ima_rule_entry *entry)
 	kfree(entry);
 }
 
-static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
+static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_namespace *ns,
+						struct ima_rule_entry *entry)
 {
 	struct ima_rule_entry *nentry;
 	int i;
@@ -399,18 +400,25 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
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
 	struct ima_rule_entry *nentry;
 
-	nentry = ima_lsm_copy_rule(entry);
+	nentry = ima_lsm_copy_rule(ns, entry);
 	if (!nentry)
 		return -ENOMEM;
 
@@ -453,7 +461,7 @@ static void ima_lsm_update_rules(struct ima_namespace *ns)
 		if (!ima_rule_contains_lsm_cond(entry))
 			continue;
 
-		result = ima_lsm_update_rule(entry);
+		result = ima_lsm_update_rule(ns, entry);
 		if (result) {
 			pr_err("lsm rule update error %d\n", result);
 			return;
@@ -464,12 +472,14 @@ static void ima_lsm_update_rules(struct ima_namespace *ns)
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
 
-- 
2.36.1

