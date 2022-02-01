Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30664A65DA
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Feb 2022 21:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240101AbiBAUiO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Feb 2022 15:38:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37748 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239785AbiBAUiM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Feb 2022 15:38:12 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211JSi8T019667;
        Tue, 1 Feb 2022 20:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=qViCd2p/WrlcFHWWU9idGH08e7/hcmsHgi9OMbAi6nk=;
 b=br7tzY4sXRFSnCk5/YgbQs8JG24PXa1muaUroO4zUO/owa6YO75DaEdoFaIJ1uwm+zh4
 hZUjBeW3qO7MsA2qkcL4ObZ8lfLN1a2qxaHYNXy22sBjaBB0hQzjqGKCO/LiMT9J5VXp
 ICCB9zezuYYGJVbvWP7kRtcwzYEmp5L96SVZhPj89BwDVy+Cd0l0kxfpxtEeiIInFP81
 KtVgbf+xgVGJojqGMKX3IyXfay7YVxqC58TJi2dRUPUyerIOQEu42/x5ZgkxRIjSnDUp
 28E2yK0WQv/XVhEWBbRTJTtaNJj6MghiHkPJP5i1ERMHGV2wthM11S2SgtyBiElX9zXk MQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dyb29h74m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:55 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 211JSuHQ019971;
        Tue, 1 Feb 2022 20:37:54 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dyb29h742-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:54 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 211KX69P024228;
        Tue, 1 Feb 2022 20:37:53 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03wdc.us.ibm.com with ESMTP id 3dvw7as4ct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:53 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 211KboY429425942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Feb 2022 20:37:50 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B46AB2066;
        Tue,  1 Feb 2022 20:37:50 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F6A6B2065;
        Tue,  1 Feb 2022 20:37:50 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  1 Feb 2022 20:37:50 +0000 (GMT)
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
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v10 11/27] ima: Move ima_lsm_policy_notifier into ima_namespace
Date:   Tue,  1 Feb 2022 15:37:19 -0500
Message-Id: <20220201203735.164593-12-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220201203735.164593-1-stefanb@linux.ibm.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: u06HKLqmP30nnyp_Lhy94ClNCPNAVNIS
X-Proofpoint-ORIG-GUID: ar9HveUr145gHYDur-OR6ot8iu2h9Rpp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_09,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010114
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Move the ima_lsm_policy_notifier into the ima_namespace. Each IMA
namespace can now register its own LSM policy change notifier callback.
The policy change notifier for the init_ima_ns still remains in init_ima()
and therefore handle the registration of the callback for all other
namespaces in init_ima_namespace().

Suppress the kernel warning 'rule for LSM <label> is undefined` for all
other IMA namespaces than the init_ima_ns.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

---
v10:
 - Only call pr_warn('rule for LSM <label> is undefined`) for init_ima_ns
---
 security/integrity/ima/ima.h             |  2 ++
 security/integrity/ima/ima_init_ima_ns.c | 14 ++++++++++++++
 security/integrity/ima/ima_main.c        |  6 +-----
 security/integrity/ima/ima_policy.c      | 16 ++++++++++------
 4 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 94c6e3a4d666..fb6bd054d899 100644
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
index 425eed1c6838..1cba545ae477 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -10,6 +10,8 @@
 
 static int ima_init_namespace(struct ima_namespace *ns)
 {
+	int rc;
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
+		rc = register_blocking_lsm_notifier
+						(&ns->ima_lsm_policy_notifier);
+		if (rc)
+			return rc;
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
index 2cd5cc90ab79..ae0e9b14554a 100644
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
@@ -1072,7 +1068,7 @@ static int __init init_ima(void)
 	if (error)
 		return error;
 
-	error = register_blocking_lsm_notifier(&ima_lsm_policy_notifier);
+	error = register_blocking_lsm_notifier(&ns->ima_lsm_policy_notifier);
 	if (error)
 		pr_warn("Couldn't register LSM notifier, error %d\n", error);
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 05b2bc06ab0c..148ff5a98a8e 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -369,7 +369,8 @@ static void ima_free_rule(struct ima_rule_entry *entry)
 	kfree(entry);
 }
 
-static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
+static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_namespace *ns,
+						struct ima_rule_entry *entry)
 {
 	struct ima_rule_entry *nentry;
 	int i;
@@ -400,18 +401,19 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 		ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
 				     nentry->lsm[i].args_p,
 				     &nentry->lsm[i].rule);
-		if (!nentry->lsm[i].rule)
+		if (!nentry->lsm[i].rule && ns == &init_ima_ns)
 			pr_warn("rule for LSM \'%s\' is undefined\n",
 				nentry->lsm[i].args_p);
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
 
@@ -454,7 +456,7 @@ static void ima_lsm_update_rules(struct ima_namespace *ns)
 		if (!ima_rule_contains_lsm_cond(entry))
 			continue;
 
-		result = ima_lsm_update_rule(entry);
+		result = ima_lsm_update_rule(ns, entry);
 		if (result) {
 			pr_err("lsm rule update error %d\n", result);
 			return;
@@ -465,12 +467,14 @@ static void ima_lsm_update_rules(struct ima_namespace *ns)
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
2.31.1

