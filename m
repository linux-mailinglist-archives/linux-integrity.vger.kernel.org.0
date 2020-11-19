Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C4E2B9E2F
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Nov 2020 00:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgKSX01 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Nov 2020 18:26:27 -0500
Received: from linux.microsoft.com ([13.77.154.182]:32948 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgKSX0Y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Nov 2020 18:26:24 -0500
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id B8C1E20B7125;
        Thu, 19 Nov 2020 15:26:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B8C1E20B7125
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605828383;
        bh=sxVlLAkqjda0ZXj26t6BGZjCQWun9IH/OvCSStwtKOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=evICjJiYyEEAVnbZPLvH2k3cp2ZId1S4M7yN1pvKJnzRTwjpVmtENHoyn1Sov2Lwv
         0zO/bW/WET+7WOMSQZKYOKOeK0peizS6Yh73HfWylcBoXJ27xXOM1Ydt2IhCU9ygpO
         cttU8Nfnxf8HKu4zYCr/qccZ4CO3J7jEtAHJTsLM=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v6 4/8] IMA: add policy rule to measure critical data
Date:   Thu, 19 Nov 2020 15:26:07 -0800
Message-Id: <20201119232611.30114-5-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119232611.30114-1-tusharsu@linux.microsoft.com>
References: <20201119232611.30114-1-tusharsu@linux.microsoft.com>
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
 security/integrity/ima/ima_policy.c | 35 +++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 2a0c0603626e..583be7674f3e 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -34,6 +34,7 @@
 #define IMA_PCR		0x0100
 #define IMA_FSNAME	0x0200
 #define IMA_KEYRINGS	0x0400
+#define IMA_DATA_SOURCES	0x0800
 
 #define UNKNOWN		0
 #define MEASURE		0x0001	/* same as IMA_MEASURE */
@@ -85,6 +86,7 @@ struct ima_rule_entry {
 	} lsm[MAX_LSM_RULES];
 	char *fsname;
 	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyrings */
+	struct ima_rule_opt_list *data_sources; /* Measure data from these sources */
 	struct ima_template_desc *template;
 };
 
@@ -479,6 +481,12 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
 		else
 			opt_list = rule->keyrings;
 		break;
+	case CRITICAL_DATA:
+		if (!rule->data_sources)
+			return true;
+		else
+			opt_list = rule->data_sources;
+		break;
 	default:
 		break;
 	}
@@ -518,13 +526,19 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
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
@@ -1119,6 +1133,19 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 		if (ima_rule_contains_lsm_cond(entry))
 			return false;
 
+		break;
+	case CRITICAL_DATA:
+		if (entry->action & ~(MEASURE | DONT_MEASURE))
+			return false;
+
+		if (!(entry->flags & IMA_DATA_SOURCES) ||
+		    (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_PCR |
+		    IMA_DATA_SOURCES)))
+			return false;
+
+		if (ima_rule_contains_lsm_cond(entry))
+			return false;
+
 		break;
 	default:
 		return false;
-- 
2.17.1

