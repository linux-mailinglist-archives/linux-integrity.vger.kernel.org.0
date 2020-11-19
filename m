Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82AD2B9E47
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Nov 2020 00:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgKSX0i (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Nov 2020 18:26:38 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33002 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgKSX00 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Nov 2020 18:26:26 -0500
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 94B1F20B8005;
        Thu, 19 Nov 2020 15:26:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 94B1F20B8005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605828385;
        bh=uk4x4LQiWntk6528VOlokJxBRGx63RfP1GrYurFa5OI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qEZd7tyFxy6Hzpyvftyyglq0YHDh6WKPkmyzcSyI4JZCdGKJ0J3/YPV6L2iMDYBWz
         7DTsQuz9XNOb7JLLg74Q5ZVpqqnMCuhsgcNsvU4/oVtFX7OD4MYi250SWEXB7TuGJc
         QQ8BPP/Mb+wuewh7tm72NOYej0SpBDWctJcWzO2o=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v6 7/8] IMA: add a built-in policy rule for critical data measurement
Date:   Thu, 19 Nov 2020 15:26:10 -0800
Message-Id: <20201119232611.30114-8-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119232611.30114-1-tusharsu@linux.microsoft.com>
References: <20201119232611.30114-1-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

The IMA hook to measure kernel critical data, namely
ima_measure_critical_data(), could be called before a custom IMA policy
is loaded. Define a new critical data builtin policy to allow measuring
early kernel integrity critical data before a custom IMA policy is
loaded.

Add critical data to built-in IMA rules if the kernel command line
contains "ima_policy=critical_data".

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_policy.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index c9e52dab0638..119604a3efa0 100644
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
@@ -875,6 +882,11 @@ void __init ima_init_policy(void)
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

