Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0B82A221E
	for <lists+linux-integrity@lfdr.de>; Sun,  1 Nov 2020 23:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgKAW0q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 1 Nov 2020 17:26:46 -0500
Received: from linux.microsoft.com ([13.77.154.182]:42048 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbgKAW0j (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 1 Nov 2020 17:26:39 -0500
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id A228920C1713;
        Sun,  1 Nov 2020 14:26:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A228920C1713
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1604269599;
        bh=zb4UDSBV3isYH/aJEYYnL9CuQ4SANzldEATSI7kIE8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=prDJDlJxIbH1nch3ZcUMxWUbZ3DzeVuFknKMVmEC1Gp0FJjl+W3PZ3r5g7v/66aa8
         DsrQjEpiHGV39tndV6Kx/gsB7C2mWj/aAjl5V2guE7vsOnIn596jsn2+CfeDDVd0mm
         ur5s2sMTgBuuyAL9YwLZ5ZRG32jGUykmhrs48pDM=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v5 6/7] IMA: add critical_data to the built-in policy rules
Date:   Sun,  1 Nov 2020 14:26:25 -0800
Message-Id: <20201101222626.6111-7-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201101222626.6111-1-tusharsu@linux.microsoft.com>
References: <20201101222626.6111-1-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

The IMA hook to measure kernel critical data, namely
ima_measure_critical_data(), could be called before a custom IMA policy
is loaded. For example, SELinux calls ima_measure_critical_data() to
measure its state and policy when they are initialized. This occurs
before a custom IMA policy is loaded, and hence IMA hook will not
measure the data. A built-in policy is therefore needed to measure
critical data provided by callers before a custom IMA policy is loaded.

Add CRITICAL_DATA to built-in IMA rules if the kernel command line
contains "ima_policy=critical_data". Set the IMA template for this rule
to "ima-buf" since ima_measure_critical_data() measures a buffer.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_policy.c | 32 +++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index ec99e0bb6c6f..dc8fe969d3fe 100644
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
+static bool ima_use_critical_data __ro_after_init;
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
@@ -813,6 +820,8 @@ static int __init ima_init_arch_policy(void)
 void __init ima_init_policy(void)
 {
 	int build_appraise_entries, arch_entries;
+	struct ima_template_desc *template = NULL;
+	int ret = 0;
 
 	/* if !ima_policy, we load NO default rules */
 	if (ima_policy)
@@ -875,6 +884,29 @@ void __init ima_init_policy(void)
 			  ARRAY_SIZE(default_appraise_rules),
 			  IMA_DEFAULT_POLICY);
 
+	if (ima_use_critical_data) {
+		template = lookup_template_desc("ima-buf");
+		if (!template) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		ret = template_desc_init_fields(template->fmt,
+						&(template->fields),
+						&(template->num_fields));
+		if (ret)
+			goto out;
+
+		critical_data_rules[0].template = template;
+		add_rules(critical_data_rules,
+			  ARRAY_SIZE(critical_data_rules),
+			  IMA_DEFAULT_POLICY);
+	}
+
+out:
+	if (ret)
+		pr_err("%s failed, result: %d\n", __func__, ret);
+
 	ima_update_policy_flag();
 }
 
-- 
2.17.1

