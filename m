Return-Path: <linux-integrity+bounces-3463-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EABC096DE14
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Sep 2024 17:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9F1281991
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Sep 2024 15:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC25216F908;
	Thu,  5 Sep 2024 15:26:47 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5107FBAC;
	Thu,  5 Sep 2024 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550007; cv=none; b=MKT62V04wrnhQ7XefkYLK1R4p4pyFbS25UiAtgKP+fsqo5M8SPVT6miDzK+WAom2xp7f8SgSP7T4AU80hQPQRRWlEh3CfDrkZAeDy198AFaSPuNGzyGbIwXaEhrq8U2lSm8y40SFSNUarA8N7y9M8rm4i1w+9PtCfSzj0RLADfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550007; c=relaxed/simple;
	bh=ozW7kpxyH1OPqoT1CaVy0yB2Mni/IEGpUAC53vHMXiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c9OoJl9/BicnjureFuGKk5o9LN9G157jqCcGeJDw3OiqAgCoqPddWIsPPYmofI5zd0UbkNhqynSCWz9wbfXcvYeUBmD9+fUNuIT3u9fICoU94SKPAwV3jdt7Xf4aPkyElN5ybDpysK59ehAUv3zeIEWq5qmF+FS23cMWm7e0DWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4X02lb0Jhqz9v7NF;
	Thu,  5 Sep 2024 23:07:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 0DF86140595;
	Thu,  5 Sep 2024 23:26:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDXGjJrzdlmK4RUAA--.19788S6;
	Thu, 05 Sep 2024 16:26:32 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	wufan@linux.microsoft.com,
	pbrobinson@gmail.com,
	zbyszek@in.waw.pl,
	hch@lst.de,
	mjg59@srcf.ucam.org,
	pmatilai@redhat.com,
	jannh@google.com,
	dhowells@redhat.com,
	jikos@kernel.org,
	mkoutny@suse.com,
	ppavlu@suse.com,
	petr.vorel@gmail.com,
	mzerqung@0pointer.de,
	kgold@linux.ibm.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v3 04/10] ima: Add digest_cache_measure/appraise boot-time built-in policies
Date: Thu,  5 Sep 2024 17:25:06 +0200
Message-Id: <20240905152512.3781098-5-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905152512.3781098-1-roberto.sassu@huaweicloud.com>
References: <20240905152512.3781098-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwDXGjJrzdlmK4RUAA--.19788S6
X-Coremail-Antispam: 1UD129KBjvJXoWxtF1kKr1UWF13Zr1DWw48Zwb_yoW7CF13pa
	9rWFyYyrZ8XF9xCw47Ca4xuF4Fy3s2ga13Gws8G34jy3Z8Zr1q9w1Fy3W3ZrZ8Ar10q3Wx
	XF4Ygr4jkw1qqaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZV
	WrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x
	07jhXo7UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQARBGbZE3MLWgACsY

From: Roberto Sassu <roberto.sassu@huawei.com>

Specify the 'digest_cache_measure' boot-time policy with 'ima_policy=' in
the kernel command line to add the following rule at the beginning of the
IMA policy, before other rules:

measure func=DIGEST_LIST_CHECK pcr=12

which will measure digest lists into PCR 12 (or the value in
CONFIG_IMA_DIGEST_CACHE_MEASURE_PCR_IDX).

Specify 'digest_cache_appraise' to add the following rule at the beginning,
before other rules:

appraise func=DIGEST_LIST_CHECK appraise_type=imasig|modsig

which will appraise digest lists with IMA signatures or module-style
appended signatures.

Adding those rule at the beginning rather than at the end is necessary to
ensure that digest lists are measured and appraised in the initial ram
disk, which would be otherwise prevented by the dont_ rules.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .../admin-guide/kernel-parameters.txt         | 10 +++++-
 security/integrity/ima/Kconfig                | 10 ++++++
 security/integrity/ima/ima_policy.c           | 35 +++++++++++++++++++
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 09126bb8cc9f..afaaf125a237 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2077,7 +2077,8 @@
 	ima_policy=	[IMA]
 			The builtin policies to load during IMA setup.
 			Format: "tcb | appraise_tcb | secure_boot |
-				 fail_securely | critical_data"
+				 fail_securely | critical_data |
+				 digest_cache_measure | digest_cache_appraise"
 
 			The "tcb" policy measures all programs exec'd, files
 			mmap'd for exec, and all files opened with the read
@@ -2099,6 +2100,13 @@
 			The "critical_data" policy measures kernel integrity
 			critical data.
 
+			The "digest_cache_measure" policy measures digest lists
+			into PCR 12 (can be changed with kernel config).
+
+			The "digest_cache_appraise" policy appraises digest
+			lists with IMA signatures or module-style appended
+			signatures.
+
 	ima_tcb		[IMA] Deprecated.  Use ima_policy= instead.
 			Load a policy which meets the needs of the Trusted
 			Computing Base.  This means IMA will measure all
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 475c32615006..d2d79185f714 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -321,4 +321,14 @@ config IMA_DISABLE_HTABLE
 	help
 	   This option disables htable to allow measurement of duplicate records.
 
+config IMA_DIGEST_CACHE_MEASURE_PCR_IDX
+	int
+	range 8 14
+	default 12
+	help
+	  This option determines the TPM PCR register index that IMA uses to
+	  maintain the integrity aggregate of the measurement list, when the
+	  Integrity Digest Cache is used (different measurement style).
+	  If unsure, use the default 12.
+
 endif
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index eb3bfe01782d..c2bf58010b89 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -254,6 +254,21 @@ static struct ima_rule_entry critical_data_rules[] __ro_after_init = {
 	{.action = MEASURE, .func = CRITICAL_DATA, .flags = IMA_FUNC},
 };
 
+static struct ima_rule_entry measure_digest_cache_rule __ro_after_init = {
+#ifdef CONFIG_INTEGRITY_DIGEST_CACHE
+	.action = MEASURE, .func = DIGEST_LIST_CHECK,
+	.pcr = CONFIG_IMA_DIGEST_CACHE_MEASURE_PCR_IDX,
+	.flags = IMA_FUNC | IMA_PCR
+#endif
+};
+
+static struct ima_rule_entry appraise_digest_cache_rule __ro_after_init = {
+#ifdef CONFIG_INTEGRITY_DIGEST_CACHE
+	.action = APPRAISE, .func = DIGEST_LIST_CHECK,
+	.flags = IMA_FUNC | IMA_DIGSIG_REQUIRED | IMA_MODSIG_ALLOWED,
+#endif
+};
+
 /* An array of architecture specific rules */
 static struct ima_rule_entry *arch_policy_entry __ro_after_init;
 
@@ -278,6 +293,8 @@ static bool ima_use_appraise_tcb __initdata;
 static bool ima_use_secure_boot __initdata;
 static bool ima_use_critical_data __initdata;
 static bool ima_fail_unverifiable_sigs __ro_after_init;
+static bool ima_digest_cache_measure __ro_after_init;
+static bool ima_digest_cache_appraise __ro_after_init;
 static int __init policy_setup(char *str)
 {
 	char *p;
@@ -295,6 +312,10 @@ static int __init policy_setup(char *str)
 			ima_use_critical_data = true;
 		else if (strcmp(p, "fail_securely") == 0)
 			ima_fail_unverifiable_sigs = true;
+		else if (strcmp(p, "digest_cache_measure") == 0)
+			ima_digest_cache_measure = true;
+		else if (strcmp(p, "digest_cache_appraise") == 0)
+			ima_digest_cache_appraise = true;
 		else
 			pr_err("policy \"%s\" not found", p);
 	}
@@ -983,6 +1004,20 @@ void __init ima_init_policy(void)
 {
 	int build_appraise_entries, arch_entries;
 
+	/*
+	 * We need to load digest cache rules at the beginning, to avoid dont_
+	 * rules causing ours to not be reached.
+	 */
+	if (IS_ENABLED(CONFIG_INTEGRITY_DIGEST_CACHE)) {
+		if (ima_digest_cache_measure)
+			add_rules(&measure_digest_cache_rule, 1,
+				  IMA_DEFAULT_POLICY);
+
+		if (ima_digest_cache_appraise)
+			add_rules(&appraise_digest_cache_rule, 1,
+				  IMA_DEFAULT_POLICY);
+	}
+
 	/* if !ima_policy, we load NO default rules */
 	if (ima_policy)
 		add_rules(dont_measure_rules, ARRAY_SIZE(dont_measure_rules),
-- 
2.34.1


