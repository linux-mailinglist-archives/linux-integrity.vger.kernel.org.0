Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7698359DA6
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Apr 2021 13:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbhDILoA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Apr 2021 07:44:00 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2822 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbhDILn7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Apr 2021 07:43:59 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FGx14533Hz67yjc;
        Fri,  9 Apr 2021 19:36:40 +0800 (CST)
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
Subject: [PATCH 4/7] ima: Introduce appraise_exec_tcb and appraise_tmpfs policies
Date:   Fri, 9 Apr 2021 13:43:10 +0200
Message-ID: <20210409114313.4073-5-roberto.sassu@huawei.com>
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

This patch introduces two new hard-coded policies, named appraise_exec_tcb
and appraise_tmpfs. The first appraises files executed or mmapped, as
opposed to files owned by root, requiring in addition a digital signature.
The second appraises files in the tmpfs and ramfs filesystems, to avoid
that an attacker copies files there to avoid appraisal. The new policies
can be selected by specifying them as a value of ima_policy= in the kernel
command line.

Similarly to the exec_tcb policy, the appraise_exec_tcb policy can be used
to appraise only immutable files and avoid appraisal of mutable files which
might not have an HMAC or digital signature.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .../admin-guide/kernel-parameters.txt         |  9 +++++
 security/integrity/ima/ima_policy.c           | 33 +++++++++++++++----
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 88c2ba679c92..93c5f78905e2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1775,6 +1775,15 @@
 			The "appraise_tcb" policy appraises the integrity of
 			all files owned by root.
 
+			The "appraise_exec_tcb" is similar to the "appraise_tcb"
+			policy except for files executed or mmapped, which are
+			appraised (with imasig requirement) instead of files
+			owned by root.
+
+			The "appraise_tmpfs" policy excludes the dont_appraise
+			rule for the tmpfs and ramfs filesystems for the
+			"appraise_tcb" and "appraise_exec_tcb" policies.
+
 			The "secure_boot" policy appraises the integrity
 			of files (eg. kexec kernel image, kernel modules,
 			firmware, policy, etc) based on file signatures.
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index fff178abb004..a45e494e06e8 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -154,8 +154,8 @@ static struct ima_rule_entry default_appraise_rules[] __ro_after_init = {
 	{.action = DONT_APPRAISE, .fsmagic = PROC_SUPER_MAGIC, .flags = IMA_FSMAGIC},
 	{.action = DONT_APPRAISE, .fsmagic = SYSFS_MAGIC, .flags = IMA_FSMAGIC},
 	{.action = DONT_APPRAISE, .fsmagic = DEBUGFS_MAGIC, .flags = IMA_FSMAGIC},
-	{.action = DONT_APPRAISE, .fsmagic = TMPFS_MAGIC, .flags = IMA_FSMAGIC},
-	{.action = DONT_APPRAISE, .fsmagic = RAMFS_MAGIC, .flags = IMA_FSMAGIC},
+	{.action = DONT_APPRAISE, .fsmagic = TMPFS_MAGIC, .flags = IMA_FSMAGIC | IMA_SKIP_TMPFS},
+	{.action = DONT_APPRAISE, .fsmagic = RAMFS_MAGIC, .flags = IMA_FSMAGIC | IMA_SKIP_TMPFS},
 	{.action = DONT_APPRAISE, .fsmagic = DEVPTS_SUPER_MAGIC, .flags = IMA_FSMAGIC},
 	{.action = DONT_APPRAISE, .fsmagic = BINFMTFS_MAGIC, .flags = IMA_FSMAGIC},
 	{.action = DONT_APPRAISE, .fsmagic = SECURITYFS_MAGIC, .flags = IMA_FSMAGIC},
@@ -171,14 +171,21 @@ static struct ima_rule_entry default_appraise_rules[] __ro_after_init = {
 #endif
 #ifndef CONFIG_IMA_APPRAISE_SIGNED_INIT
 	{.action = APPRAISE, .fowner = GLOBAL_ROOT_UID, .fowner_op = &uid_eq,
-	 .flags = IMA_FOWNER},
+	 .flags = IMA_FOWNER | IMA_SKIP_OPEN},
 #else
 	/* force signature */
 	{.action = APPRAISE, .fowner = GLOBAL_ROOT_UID, .fowner_op = &uid_eq,
-	 .flags = IMA_FOWNER | IMA_DIGSIG_REQUIRED},
+	 .flags = IMA_FOWNER | IMA_DIGSIG_REQUIRED | IMA_SKIP_OPEN},
 #endif
 };
 
+static struct ima_rule_entry appraise_exec_rules[] __ro_after_init = {
+	{.action = APPRAISE, .func = BPRM_CHECK,
+	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
+	{.action = APPRAISE, .func = MMAP_CHECK,
+	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
+};
+
 static struct ima_rule_entry build_appraise_rules[] __ro_after_init = {
 #ifdef CONFIG_IMA_APPRAISE_REQUIRE_MODULE_SIGS
 	{.action = APPRAISE, .func = MODULE_CHECK,
@@ -234,6 +241,7 @@ static int __init default_measure_policy_setup(char *str)
 __setup("ima_tcb", default_measure_policy_setup);
 
 static unsigned int ima_measure_skip_flags __initdata;
+static unsigned int ima_appraise_skip_flags __initdata;
 static bool ima_use_appraise_tcb __initdata;
 static bool ima_use_secure_boot __initdata;
 static bool ima_use_critical_data __initdata;
@@ -254,7 +262,12 @@ static int __init policy_setup(char *str)
 			ima_measure_skip_flags |= IMA_SKIP_OPEN;
 		} else if (strcmp(p, "appraise_tcb") == 0)
 			ima_use_appraise_tcb = true;
-		else if (strcmp(p, "secure_boot") == 0)
+		else if ((strcmp(p, "appraise_tmpfs") == 0))
+			ima_appraise_skip_flags |= IMA_SKIP_TMPFS;
+		else if (strcmp(p, "appraise_exec_tcb") == 0) {
+			ima_use_appraise_tcb = true;
+			ima_appraise_skip_flags |= IMA_SKIP_OPEN;
+		} else if (strcmp(p, "secure_boot") == 0)
 			ima_use_secure_boot = true;
 		else if (strcmp(p, "critical_data") == 0)
 			ima_use_critical_data = true;
@@ -889,10 +902,16 @@ void __init ima_init_policy(void)
 				  IMA_DEFAULT_POLICY | IMA_CUSTOM_POLICY, 0);
 	}
 
-	if (ima_use_appraise_tcb)
+	if (ima_use_appraise_tcb) {
 		add_rules(default_appraise_rules,
 			  ARRAY_SIZE(default_appraise_rules),
-			  IMA_DEFAULT_POLICY, 0);
+			  IMA_DEFAULT_POLICY, ima_appraise_skip_flags);
+
+		if (ima_appraise_skip_flags & IMA_SKIP_OPEN)
+			add_rules(appraise_exec_rules,
+				  ARRAY_SIZE(appraise_exec_rules),
+				  IMA_DEFAULT_POLICY, 0);
+	}
 
 	if (ima_use_critical_data)
 		add_rules(critical_data_rules,
-- 
2.26.2

