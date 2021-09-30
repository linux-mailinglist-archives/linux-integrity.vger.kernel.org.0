Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A8A41D92A
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Sep 2021 13:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350621AbhI3L5b (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Sep 2021 07:57:31 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3897 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350576AbhI3L5a (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Sep 2021 07:57:30 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HKs773cbdz67t01;
        Thu, 30 Sep 2021 19:52:35 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 30 Sep 2021 13:55:46 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <mchehab+huawei@kernel.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 3/7] ima: Introduce diglim and appraise_diglim policies
Date:   Thu, 30 Sep 2021 13:55:29 +0200
Message-ID: <20210930115533.878169-4-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210930115533.878169-1-roberto.sassu@huawei.com>
References: <20210930115533.878169-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Introduce two new hardcoded policies, 'diglim' and 'appraise_diglim' to
measure and appraise digest lists and related files.

In particular, the 'diglim' policy adds the new rule:

measure func=DIGEST_LIST_CHECK pcr=<PCR value> use_diglim

where PCR value is 11 or the one chosen with the ima_diglim_pcr= kernel
option. It also adds the use_diglim directive to existing selected rules
with hooks BPRM_CHECK, CREDS_CHECK, MMAP_CHECK, FILE_CHECK, MODULE_CHECK,
FIRMWARE_CHECK and DIGEST_LIST_CHECK.

A rule with the DIGEST_LIST_CHECK hook is sufficient to cover all aspects
of the digest list loading process. For direct upload, the kernel reads the
file with type READING_DIGEST_LIST, which is mapped to that hook. For
upload by a user space parser, DIGLIM LSM performs a second read for every
file opened by the parser (including the executable), also with type
READING_DIGEST_LIST.

The 'appraise_diglim' policy adds the new rule:

appraise func=DIGEST_LIST_CHECK appraise_type=imasig|modsig use_diglim

and, like for the 'diglim' policy, adds the use_diglim directive for the
selected IMA rules with action appraise.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .../admin-guide/kernel-parameters.txt         |  19 +++-
 security/integrity/ima/ima_policy.c           | 102 +++++++++++++++++-
 2 files changed, 119 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e0db162ba202..fa4959a321d8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1835,6 +1835,13 @@
 			Use the canonical format for the binary runtime
 			measurements, instead of host native format.
 
+	ima_diglim_pcr=
+			[IMA]
+			Format: 0 - 23
+			default: 11
+			Define the PCR to be used for measurement entries
+			created with the diglim IMA policy.
+
 	ima_hash=	[IMA]
 			Format: { md5 | sha1 | rmd160 | sha256 | sha384
 				   | sha512 | ... }
@@ -1846,7 +1853,8 @@
 	ima_policy=	[IMA]
 			The builtin policies to load during IMA setup.
 			Format: "tcb | appraise_tcb | secure_boot |
-				 fail_securely | critical_data"
+				 fail_securely | critical_data | diglim |
+				 appraise_diglim"
 
 			The "tcb" policy measures all programs exec'd, files
 			mmap'd for exec, and all files opened with the read
@@ -1860,6 +1868,11 @@
 			the tmpfs filesystem, for the "ima_tcb", "tcb" and
 			"exec_tcb" policies.
 
+			The "diglim" policy enables measurement of
+			DIGLIM-related files (e.g. digest lists, parsers) and
+			usage of DIGLIM for measurement (exec, mmap, open,
+			firmware and module loading).
+
 			The "appraise_tcb" policy appraises the integrity of
 			all files owned by root.
 
@@ -1876,6 +1889,10 @@
 			rule for the tmpfs and ramfs filesystems for the
 			"appraise_tcb" and "appraise_exec_tcb" policies.
 
+			The "appraise_diglim" policy enables appraisal of
+			DIGLIM-related files and usage of DIGLIM for appraisal
+			(exec, mmap, open, firmware and module loading).
+
 			The "secure_boot" policy appraises the integrity
 			of files (eg. kexec kernel image, kernel modules,
 			firmware, policy, etc) based on file signatures.
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index dfab21aeb7e1..5e1532abca5d 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -162,6 +162,10 @@ static struct ima_rule_entry default_measurement_rules[] __ro_after_init = {
 	{.action = MEASURE, .func = POLICY_CHECK, .flags = IMA_FUNC},
 };
 
+static struct ima_rule_entry diglim_measure_rule __ro_after_init = {
+	.action = MEASURE, .func = DIGEST_LIST_CHECK, .flags = IMA_FUNC
+};
+
 static struct ima_rule_entry default_appraise_rules[] __ro_after_init = {
 	{.action = DONT_APPRAISE, .fsmagic = PROC_SUPER_MAGIC, .flags = IMA_FSMAGIC},
 	{.action = DONT_APPRAISE, .fsmagic = SYSFS_MAGIC, .flags = IMA_FSMAGIC},
@@ -228,6 +232,11 @@ static struct ima_rule_entry secure_boot_rules[] __ro_after_init = {
 	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
 };
 
+static struct ima_rule_entry diglim_appraise_rule __ro_after_init = {
+	.action = APPRAISE, .func = DIGEST_LIST_CHECK,
+	.flags = IMA_FUNC | IMA_DIGSIG_REQUIRED | IMA_MODSIG_ALLOWED
+};
+
 static struct ima_rule_entry critical_data_rules[] __ro_after_init = {
 	{.action = MEASURE, .func = CRITICAL_DATA, .flags = IMA_FUNC},
 };
@@ -253,9 +262,12 @@ static int __init default_measure_policy_setup(char *str)
 __setup("ima_tcb", default_measure_policy_setup);
 
 static unsigned int ima_measure_skip_flags __initdata;
+static unsigned int ima_measure_diglim __initdata;
 static unsigned int ima_appraise_skip_flags __initdata;
+static unsigned int ima_diglim_pcr __initdata = 11;
 static bool ima_use_appraise_tcb __initdata;
 static bool ima_use_appraise_exec_immutable __initdata;
+static bool ima_use_appraise_diglim __initdata;
 static bool ima_use_secure_boot __initdata;
 static bool ima_use_critical_data __initdata;
 static bool ima_fail_unverifiable_sigs __ro_after_init;
@@ -273,7 +285,9 @@ static int __init policy_setup(char *str)
 		else if ((strcmp(p, "exec_tcb") == 0) && !ima_policy) {
 			ima_policy = DEFAULT_TCB;
 			ima_measure_skip_flags |= IMA_SKIP_OPEN;
-		} else if (strcmp(p, "appraise_tcb") == 0)
+		} else if (strcmp(p, "diglim") == 0)
+			ima_measure_diglim = true;
+		else if (strcmp(p, "appraise_tcb") == 0)
 			ima_use_appraise_tcb = true;
 		else if ((strcmp(p, "appraise_tmpfs") == 0))
 			ima_appraise_skip_flags |= IMA_SKIP_TMPFS;
@@ -282,6 +296,8 @@ static int __init policy_setup(char *str)
 			ima_appraise_skip_flags |= IMA_SKIP_OPEN;
 		} else if (strcmp(p, "appraise_exec_immutable") == 0)
 			ima_use_appraise_exec_immutable = true;
+		else if (strcmp(p, "appraise_diglim") == 0)
+			ima_use_appraise_diglim = true;
 		else if (strcmp(p, "secure_boot") == 0)
 			ima_use_secure_boot = true;
 		else if (strcmp(p, "critical_data") == 0)
@@ -303,6 +319,28 @@ static int __init default_appraise_policy_setup(char *str)
 }
 __setup("ima_appraise_tcb", default_appraise_policy_setup);
 
+static int __init default_diglim_pcr_setup(char *str)
+{
+	unsigned int pcr;
+	int ret;
+
+	ret = kstrtouint(str, 10, &pcr);
+	if (ret < 0 || pcr > 23) {
+		pr_err("Invalid value for ima_diglim_pcr=\n");
+		return 1;
+	}
+
+	/* Using the default IMA PCR is forbidden. */
+	if (ret == CONFIG_IMA_MEASURE_PCR_IDX) {
+		pr_err("Default IMA PCR cannot be used for ima_diglim_pcr=\n");
+		return 1;
+	}
+
+	ima_diglim_pcr = pcr;
+	return 1;
+}
+__setup("ima_diglim_pcr=", default_diglim_pcr_setup);
+
 static struct ima_rule_opt_list *ima_alloc_rule_opt_list(const substring_t *src)
 {
 	struct ima_rule_opt_list *opt_list;
@@ -812,6 +850,61 @@ void ima_update_policy_flags(void)
 	ima_policy_flag = new_policy_flag;
 }
 
+/*
+ * Add the IMA_USE_DIGLIM_MEASURE and IMA_USE_DIGLIM_APPRAISE flags to the
+ * initial policy depending on the options in the kernel command line, and set
+ * the correct PCR for the measure rules.
+ */
+static void __init ima_add_diglim_flag(void)
+{
+	struct ima_rule_entry *entry;
+
+	if (!IS_ENABLED(CONFIG_DIGLIM))
+		return;
+
+	if (!ima_measure_diglim && !ima_use_appraise_diglim)
+		return;
+
+	list_for_each_entry(entry, ima_rules, list) {
+		if (entry->action != IMA_MEASURE &&
+		    entry->action != IMA_APPRAISE)
+			continue;
+
+		if (entry->action == IMA_MEASURE && !ima_measure_diglim)
+			continue;
+
+		if (entry->action == IMA_APPRAISE &&
+		    !ima_use_appraise_diglim)
+			continue;
+
+		switch (entry->func) {
+		case BPRM_CHECK:
+			fallthrough;
+		case CREDS_CHECK:
+			fallthrough;
+		case MMAP_CHECK:
+			fallthrough;
+		case FILE_CHECK:
+			fallthrough;
+		case MODULE_CHECK:
+			fallthrough;
+		case FIRMWARE_CHECK:
+			fallthrough;
+		case DIGEST_LIST_CHECK:
+			if (entry->action == IMA_MEASURE) {
+				entry->flags |= IMA_USE_DIGLIM_MEASURE;
+				entry->flags |= IMA_PCR;
+				entry->pcr = ima_diglim_pcr;
+			} else {
+				entry->flags |= IMA_USE_DIGLIM_APPRAISE;
+			}
+			break;
+		default:
+			break;
+		}
+	}
+}
+
 static int ima_appraise_flag(enum ima_hooks func)
 {
 	if (func == MODULE_CHECK)
@@ -989,7 +1082,14 @@ void __init ima_init_policy(void)
 
 	atomic_set(&ima_setxattr_allowed_hash_algorithms, 0);
 
+	if (ima_measure_diglim)
+		add_rules(&diglim_measure_rule, 1, IMA_DEFAULT_POLICY, 0);
+
+	if (ima_use_appraise_diglim)
+		add_rules(&diglim_appraise_rule, 1, IMA_DEFAULT_POLICY, 0);
+
 	ima_update_policy_flags();
+	ima_add_diglim_flag();
 }
 
 /* Make sure we have a valid policy, at least containing some rules. */
-- 
2.32.0

