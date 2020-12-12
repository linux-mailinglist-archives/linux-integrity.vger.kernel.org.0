Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656192D890E
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Dec 2020 19:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439667AbgLLSEH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 12 Dec 2020 13:04:07 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51054 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439663AbgLLSD5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 12 Dec 2020 13:03:57 -0500
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9F04A20B7189;
        Sat, 12 Dec 2020 10:03:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9F04A20B7189
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607796196;
        bh=PfDARVAS1GIpJVAfXgLjtlaaRUoNmQtwBqytx3LZwSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BMHhkbUyMmGkW2ZofHjwvRCdfJYHG7X6YGhxpMHetHplLzZH/56SfJDXMoU5eaAmc
         taej8NJu/+ItlsY2LRDX/iXTGtU1nv2sOkq0+/tXygWBDl+v/12PQR4AWWEi6nL2Ag
         zKZWqudmoogY6xAJcBA0x0UR7T+g+X1PVVkjb71w=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v9 4/8] IMA: add policy rule to measure critical data
Date:   Sat, 12 Dec 2020 10:02:47 -0800
Message-Id: <20201212180251.9943-5-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201212180251.9943-1-tusharsu@linux.microsoft.com>
References: <20201212180251.9943-1-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

A new IMA policy rule is needed for the IMA hook
ima_measure_critical_data() and the corresponding func CRITICAL_DATA for
measuring the input buffer. The policy rule should ensure the buffer
would get measured only when the policy rule allows the action. The
policy rule should also support the necessary constraints (flags etc.)
for integrity critical buffer data measurements.

Add a policy rule to define the constraints for restricting integrity
critical data measurements.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 Documentation/ABI/testing/ima_policy |  2 +-
 security/integrity/ima/ima_policy.c  | 29 ++++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index e35263f97fc1..6ec7daa87cba 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -32,7 +32,7 @@ Description:
 			func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK]MODULE_CHECK]
 			        [FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
-				[KEXEC_CMDLINE] [KEY_CHECK]
+				[KEXEC_CMDLINE] [KEY_CHECK] [CRITICAL_DATA]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
 			       [[^]MAY_EXEC]
 			fsmagic:= hex value
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index a09d1a41a290..d45c2dbb6d45 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -479,6 +479,8 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
 
 		opt_list = rule->keyrings;
 		break;
+	case CRITICAL_DATA:
+		return true;
 	default:
 		return false;
 	}
@@ -515,13 +517,19 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 {
 	int i;
 
-	if (func == KEY_CHECK) {
-		return (rule->flags & IMA_FUNC) && (rule->func == func) &&
-			ima_match_rule_data(rule, func_data, cred);
-	}
 	if ((rule->flags & IMA_FUNC) &&
 	    (rule->func != func && func != POST_SETATTR))
 		return false;
+
+	switch (func) {
+	case KEY_CHECK:
+	case CRITICAL_DATA:
+		return ((rule->func == func) &&
+			ima_match_rule_data(rule, func_data, cred));
+	default:
+		break;
+	}
+
 	if ((rule->flags & IMA_MASK) &&
 	    (rule->mask != mask && func != POST_SETATTR))
 		return false;
@@ -1116,6 +1124,17 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 		if (ima_rule_contains_lsm_cond(entry))
 			return false;
 
+		break;
+	case CRITICAL_DATA:
+		if (entry->action & ~(MEASURE | DONT_MEASURE))
+			return false;
+
+		if (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_PCR))
+			return false;
+
+		if (ima_rule_contains_lsm_cond(entry))
+			return false;
+
 		break;
 	default:
 		return false;
@@ -1248,6 +1267,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			else if (IS_ENABLED(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) &&
 				 strcmp(args[0].from, "KEY_CHECK") == 0)
 				entry->func = KEY_CHECK;
+			else if (strcmp(args[0].from, "CRITICAL_DATA") == 0)
+				entry->func = CRITICAL_DATA;
 			else
 				result = -EINVAL;
 			if (!result)
-- 
2.17.1

