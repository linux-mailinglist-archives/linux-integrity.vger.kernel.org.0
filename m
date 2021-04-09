Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9411E359DA1
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Apr 2021 13:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhDILoA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Apr 2021 07:44:00 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2821 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbhDILn6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Apr 2021 07:43:58 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FGwy82K94z680Yb;
        Fri,  9 Apr 2021 19:34:08 +0800 (CST)
Received: from fraphisprd00473.huawei.com (7.182.8.141) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 9 Apr 2021 13:43:44 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 3/7] ima: Introduce exec_tcb and tmpfs policies
Date:   Fri, 9 Apr 2021 13:43:09 +0200
Message-ID: <20210409114313.4073-4-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210409114313.4073-1-roberto.sassu@huawei.com>
References: <20210409114313.4073-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [7.182.8.141]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch introduces two new hard-coded policies, named exec_tcb and
tmpfs. The first excludes the FILE_CHECK rules to measure only files
executed and mmapped. The second excludes the dont_measure rule for the
tmpfs filesystem for the ima_tcb, tcb and exec_tcb policies, as this could
be used as a way for an attacker to hide his actions. The new policies can
be selected by specifying them as a value of ima_policy= in the kernel
command line.

The benefit of using the exec_tcb policy, as opposed to the tcb policy, is
that most likely the measurement list will contain only immutable files,
recognizable from a set of reference values from software vendors. However,
this policy provides a less accurate view of the integrity of the system,
as opened files are excluded from measurement.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .../admin-guide/kernel-parameters.txt         |  7 ++++
 security/integrity/ima/ima_policy.c           | 42 ++++++++++++-------
 2 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04545725f187..88c2ba679c92 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1765,6 +1765,13 @@
 			mode bit set by either the effective uid (euid=0) or
 			uid=0.
 
+			The "exec_tcb" policy is similar to the "tcb" policy
+			except for opened files, which are not measured.
+
+			The "tmpfs" policy excludes the dont_measure rule for
+			the tmpfs filesystem, for the "ima_tcb", "tcb" and
+			"exec_tcb" policies.
+
 			The "appraise_tcb" policy appraises the integrity of
 			all files owned by root.
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 33b5133645b3..fff178abb004 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -35,6 +35,8 @@
 #define IMA_FSNAME	0x0200
 #define IMA_KEYRINGS	0x0400
 #define IMA_LABEL	0x0800
+#define IMA_SKIP_TMPFS	0x1000
+#define IMA_SKIP_OPEN	0x2000
 
 #define UNKNOWN		0
 #define MEASURE		0x0001	/* same as IMA_MEASURE */
@@ -105,7 +107,8 @@ static struct ima_rule_entry dont_measure_rules[] __ro_after_init = {
 	{.action = DONT_MEASURE, .fsmagic = PROC_SUPER_MAGIC, .flags = IMA_FSMAGIC},
 	{.action = DONT_MEASURE, .fsmagic = SYSFS_MAGIC, .flags = IMA_FSMAGIC},
 	{.action = DONT_MEASURE, .fsmagic = DEBUGFS_MAGIC, .flags = IMA_FSMAGIC},
-	{.action = DONT_MEASURE, .fsmagic = TMPFS_MAGIC, .flags = IMA_FSMAGIC},
+	{.action = DONT_MEASURE, .fsmagic = TMPFS_MAGIC,
+	 .flags = IMA_FSMAGIC | IMA_SKIP_TMPFS},
 	{.action = DONT_MEASURE, .fsmagic = DEVPTS_SUPER_MAGIC, .flags = IMA_FSMAGIC},
 	{.action = DONT_MEASURE, .fsmagic = BINFMTFS_MAGIC, .flags = IMA_FSMAGIC},
 	{.action = DONT_MEASURE, .fsmagic = SECURITYFS_MAGIC, .flags = IMA_FSMAGIC},
@@ -126,7 +129,7 @@ static struct ima_rule_entry original_measurement_rules[] __ro_after_init = {
 	 .flags = IMA_FUNC | IMA_MASK},
 	{.action = MEASURE, .func = FILE_CHECK, .mask = MAY_READ,
 	 .uid = GLOBAL_ROOT_UID, .uid_op = &uid_eq,
-	 .flags = IMA_FUNC | IMA_MASK | IMA_UID},
+	 .flags = IMA_FUNC | IMA_MASK | IMA_UID | IMA_SKIP_OPEN},
 	{.action = MEASURE, .func = MODULE_CHECK, .flags = IMA_FUNC},
 	{.action = MEASURE, .func = FIRMWARE_CHECK, .flags = IMA_FUNC},
 };
@@ -138,10 +141,10 @@ static struct ima_rule_entry default_measurement_rules[] __ro_after_init = {
 	 .flags = IMA_FUNC | IMA_MASK},
 	{.action = MEASURE, .func = FILE_CHECK, .mask = MAY_READ,
 	 .uid = GLOBAL_ROOT_UID, .uid_op = &uid_eq,
-	 .flags = IMA_FUNC | IMA_INMASK | IMA_EUID},
+	 .flags = IMA_FUNC | IMA_INMASK | IMA_EUID | IMA_SKIP_OPEN},
 	{.action = MEASURE, .func = FILE_CHECK, .mask = MAY_READ,
 	 .uid = GLOBAL_ROOT_UID, .uid_op = &uid_eq,
-	 .flags = IMA_FUNC | IMA_INMASK | IMA_UID},
+	 .flags = IMA_FUNC | IMA_INMASK | IMA_UID | IMA_SKIP_OPEN},
 	{.action = MEASURE, .func = MODULE_CHECK, .flags = IMA_FUNC},
 	{.action = MEASURE, .func = FIRMWARE_CHECK, .flags = IMA_FUNC},
 	{.action = MEASURE, .func = POLICY_CHECK, .flags = IMA_FUNC},
@@ -230,6 +233,7 @@ static int __init default_measure_policy_setup(char *str)
 }
 __setup("ima_tcb", default_measure_policy_setup);
 
+static unsigned int ima_measure_skip_flags __initdata;
 static bool ima_use_appraise_tcb __initdata;
 static bool ima_use_secure_boot __initdata;
 static bool ima_use_critical_data __initdata;
@@ -243,7 +247,12 @@ static int __init policy_setup(char *str)
 			continue;
 		if ((strcmp(p, "tcb") == 0) && !ima_policy)
 			ima_policy = DEFAULT_TCB;
-		else if (strcmp(p, "appraise_tcb") == 0)
+		else if ((strcmp(p, "tmpfs") == 0))
+			ima_measure_skip_flags |= IMA_SKIP_TMPFS;
+		else if ((strcmp(p, "exec_tcb") == 0) && !ima_policy) {
+			ima_policy = DEFAULT_TCB;
+			ima_measure_skip_flags |= IMA_SKIP_OPEN;
+		} else if (strcmp(p, "appraise_tcb") == 0)
 			ima_use_appraise_tcb = true;
 		else if (strcmp(p, "secure_boot") == 0)
 			ima_use_secure_boot = true;
@@ -739,13 +748,16 @@ static int ima_appraise_flag(enum ima_hooks func)
 }
 
 static void add_rules(struct ima_rule_entry *entries, int count,
-		      enum policy_rule_list policy_rule)
+		      enum policy_rule_list policy_rule, int skip_flags)
 {
 	int i = 0;
 
 	for (i = 0; i < count; i++) {
 		struct ima_rule_entry *entry;
 
+		if (entries[i].flags & skip_flags)
+			continue;
+
 		if (policy_rule & IMA_DEFAULT_POLICY)
 			list_add_tail(&entries[i].list, &ima_default_rules);
 
@@ -824,18 +836,18 @@ void __init ima_init_policy(void)
 	/* if !ima_policy, we load NO default rules */
 	if (ima_policy)
 		add_rules(dont_measure_rules, ARRAY_SIZE(dont_measure_rules),
-			  IMA_DEFAULT_POLICY);
+			  IMA_DEFAULT_POLICY, ima_measure_skip_flags);
 
 	switch (ima_policy) {
 	case ORIGINAL_TCB:
 		add_rules(original_measurement_rules,
 			  ARRAY_SIZE(original_measurement_rules),
-			  IMA_DEFAULT_POLICY);
+			  IMA_DEFAULT_POLICY, ima_measure_skip_flags);
 		break;
 	case DEFAULT_TCB:
 		add_rules(default_measurement_rules,
 			  ARRAY_SIZE(default_measurement_rules),
-			  IMA_DEFAULT_POLICY);
+			  IMA_DEFAULT_POLICY, ima_measure_skip_flags);
 	default:
 		break;
 	}
@@ -851,7 +863,7 @@ void __init ima_init_policy(void)
 		pr_info("No architecture policies found\n");
 	else
 		add_rules(arch_policy_entry, arch_entries,
-			  IMA_DEFAULT_POLICY | IMA_CUSTOM_POLICY);
+			  IMA_DEFAULT_POLICY | IMA_CUSTOM_POLICY, 0);
 
 	/*
 	 * Insert the builtin "secure_boot" policy rules requiring file
@@ -859,7 +871,7 @@ void __init ima_init_policy(void)
 	 */
 	if (ima_use_secure_boot)
 		add_rules(secure_boot_rules, ARRAY_SIZE(secure_boot_rules),
-			  IMA_DEFAULT_POLICY);
+			  IMA_DEFAULT_POLICY, 0);
 
 	/*
 	 * Insert the build time appraise rules requiring file signatures
@@ -871,21 +883,21 @@ void __init ima_init_policy(void)
 	if (build_appraise_entries) {
 		if (ima_use_secure_boot)
 			add_rules(build_appraise_rules, build_appraise_entries,
-				  IMA_CUSTOM_POLICY);
+				  IMA_CUSTOM_POLICY, 0);
 		else
 			add_rules(build_appraise_rules, build_appraise_entries,
-				  IMA_DEFAULT_POLICY | IMA_CUSTOM_POLICY);
+				  IMA_DEFAULT_POLICY | IMA_CUSTOM_POLICY, 0);
 	}
 
 	if (ima_use_appraise_tcb)
 		add_rules(default_appraise_rules,
 			  ARRAY_SIZE(default_appraise_rules),
-			  IMA_DEFAULT_POLICY);
+			  IMA_DEFAULT_POLICY, 0);
 
 	if (ima_use_critical_data)
 		add_rules(critical_data_rules,
 			  ARRAY_SIZE(critical_data_rules),
-			  IMA_DEFAULT_POLICY);
+			  IMA_DEFAULT_POLICY, 0);
 
 	ima_update_policy_flag();
 }
-- 
2.26.2

