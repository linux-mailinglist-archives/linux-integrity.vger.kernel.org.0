Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C902EEC4A
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Jan 2021 05:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbhAHEIz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jan 2021 23:08:55 -0500
Received: from linux.microsoft.com ([13.77.154.182]:59260 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbhAHEIq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jan 2021 23:08:46 -0500
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 273D920B6C46;
        Thu,  7 Jan 2021 20:07:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 273D920B6C46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1610078846;
        bh=NblfeM4gSvMTuDUnr/Ywi4/vYvY7tsPtE6p51c4jjrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KTB1yGAbNVHfWJR6Tw/kNYwCDj3hdE5krKuPj5C0Oa9QiOhpDKgjTAdxK3p4WgctB
         mSavfFsrZhphARf9DfRA4Uxl2dtO2recLkn8EkoSltEOvBuOgPMO+hb++vE7ebbGrc
         0oZNB2q722hUNtT2HzykKzKtltHC0O+2hnJrD84g=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v10 7/8] IMA: define a builtin critical data measurement policy
Date:   Thu,  7 Jan 2021 20:07:07 -0800
Message-Id: <20210108040708.8389-8-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210108040708.8389-1-tusharsu@linux.microsoft.com>
References: <20210108040708.8389-1-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

Define a new critical data builtin policy to allow measuring
early kernel integrity critical data before a custom IMA policy
is loaded.

Update the documentation on kernel parameters to document
the new critical data builtin policy.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 ++++-
 security/integrity/ima/ima_policy.c             | 12 ++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 526d65d8573a..6034d75c3ca0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1746,7 +1746,7 @@
 	ima_policy=	[IMA]
 			The builtin policies to load during IMA setup.
 			Format: "tcb | appraise_tcb | secure_boot |
-				 fail_securely"
+				 fail_securely | critical_data"
 
 			The "tcb" policy measures all programs exec'd, files
 			mmap'd for exec, and all files opened with the read
@@ -1765,6 +1765,9 @@
 			filesystems with the SB_I_UNVERIFIABLE_SIGNATURE
 			flag.
 
+			The "critical_data" policy measures kernel integrity
+			critical data.
+
 	ima_tcb		[IMA] Deprecated.  Use ima_policy= instead.
 			Load a policy which meets the needs of the Trusted
 			Computing Base.  This means IMA will measure all
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 2c9db2d0b434..9b45d064a87d 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -206,6 +206,10 @@ static struct ima_rule_entry secure_boot_rules[] __ro_after_init = {
 	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
 };
 
+static struct ima_rule_entry critical_data_rules[] __ro_after_init = {
+	{.action = MEASURE, .func = CRITICAL_DATA, .flags = IMA_FUNC},
+};
+
 /* An array of architecture specific rules */
 static struct ima_rule_entry *arch_policy_entry __ro_after_init;
 
@@ -228,6 +232,7 @@ __setup("ima_tcb", default_measure_policy_setup);
 
 static bool ima_use_appraise_tcb __initdata;
 static bool ima_use_secure_boot __initdata;
+static bool ima_use_critical_data __initdata;
 static bool ima_fail_unverifiable_sigs __ro_after_init;
 static int __init policy_setup(char *str)
 {
@@ -242,6 +247,8 @@ static int __init policy_setup(char *str)
 			ima_use_appraise_tcb = true;
 		else if (strcmp(p, "secure_boot") == 0)
 			ima_use_secure_boot = true;
+		else if (strcmp(p, "critical_data") == 0)
+			ima_use_critical_data = true;
 		else if (strcmp(p, "fail_securely") == 0)
 			ima_fail_unverifiable_sigs = true;
 		else
@@ -871,6 +878,11 @@ void __init ima_init_policy(void)
 			  ARRAY_SIZE(default_appraise_rules),
 			  IMA_DEFAULT_POLICY);
 
+	if (ima_use_critical_data)
+		add_rules(critical_data_rules,
+			  ARRAY_SIZE(critical_data_rules),
+			  IMA_DEFAULT_POLICY);
+
 	ima_update_policy_flag();
 }
 
-- 
2.17.1

