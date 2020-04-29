Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF731BDE8A
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2020 15:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgD2NjG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Apr 2020 09:39:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728309AbgD2NjF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Apr 2020 09:39:05 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03TDWSQZ066065;
        Wed, 29 Apr 2020 09:39:01 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mh9ptm4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 09:39:00 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03TDXQGG070497;
        Wed, 29 Apr 2020 09:39:00 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mh9ptm2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 09:39:00 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03TDU9O9003299;
        Wed, 29 Apr 2020 13:38:58 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 30mcu8duh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 13:38:57 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03TDbkmg63177042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 13:37:47 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 683A3AE058;
        Wed, 29 Apr 2020 13:38:55 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DE48AE051;
        Wed, 29 Apr 2020 13:38:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.162.91])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 29 Apr 2020 13:38:54 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Mickael Salaun <mic@digikod.net>,
        Steve Grubb <sgrubb@redhat.com>, Jann Horn <jannh@google.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ima: add policy support for the new file open MAY_OPENEXEC flag
Date:   Wed, 29 Apr 2020 09:38:43 -0400
Message-Id: <1588167523-7866-3-git-send-email-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1588167523-7866-1-git-send-email-zohar@linux.ibm.com>
References: <1588167523-7866-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-29_05:2020-04-29,2020-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=1 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290110
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The kernel has no way of differentiating between a file containing data
or code being opened by an interpreter.  The proposed RESOLVE_MAYEXEC
openat2(2) flag bridges this gap by defining and enabling the MAY_OPENEXEC
flag.

This patch adds IMA policy support for the new MAY_OPENEXEC flag.

Example:
measure func=FILE_CHECK mask=^MAY_OPENEXEC
appraise func=FILE_CHECK appraise_type=imasig mask=^MAY_OPENEXEC

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 Documentation/ABI/testing/ima_policy |  2 +-
 security/integrity/ima/ima_main.c    |  3 ++-
 security/integrity/ima/ima_policy.c  | 15 +++++++++++----
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index a12e784cee31..aa8e4b6181e0 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -31,7 +31,7 @@ Description:
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
 				[KEXEC_CMDLINE] [KEY_CHECK]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
-			       [[^]MAY_EXEC]
+			       [[^]MAY_EXEC] [[^]MAY_OPENEXEC]
 			mode:= [IXUGO]
 			fsmagic:= hex value
 			fsuuid:= file system UUID (e.g 8bcbe394-4f13-4144-be8e-5aa9ea2ce2f6)
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f96f151294e6..b644eda68e9e 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -438,7 +438,8 @@ int ima_file_check(struct file *file, int mask)
 
 	security_task_getsecid(current, &secid);
 	return process_measurement(file, current_cred(), secid, NULL, 0,
-				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
+				   mask & (MAY_READ | MAY_WRITE |
+					   MAY_EXEC | MAY_OPENEXEC |
 					   MAY_APPEND), FILE_CHECK);
 }
 EXPORT_SYMBOL_GPL(ima_file_check);
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 28b68e076638..8c29d1b01964 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -407,7 +407,8 @@ static bool ima_match_keyring(struct ima_rule_entry *rule,
  * @cred: a pointer to a credentials structure for user validation
  * @secid: the secid of the task to be validated
  * @func: LIM hook identifier
- * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
+ * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC |
+ *			    MAY_OPENEXEC)
  * @keyring: keyring name to check in policy for KEY_CHECK func
  *
  * Returns true on rule match, false on failure.
@@ -531,7 +532,8 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  *        being made
  * @secid: LSM secid of the task to be validated
  * @func: IMA hook identifier
- * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
+ * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC |
+ *			    MAY_OPENEXEC)
  * @pcr: set the pcr to extend
  * @template_desc: the template that should be used for this rule
  * @keyring: the keyring name, if given, to be used to check in the policy.
@@ -1097,6 +1099,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->mask = MAY_READ;
 			else if (strcmp(from, "MAY_APPEND") == 0)
 				entry->mask = MAY_APPEND;
+			else if (strcmp(from, "MAY_OPENEXEC") == 0)
+				entry->mask = MAY_OPENEXEC;
 			else
 				result = -EINVAL;
 			if (!result)
@@ -1434,14 +1438,15 @@ const char *const func_tokens[] = {
 
 #ifdef	CONFIG_IMA_READ_POLICY
 enum {
-	mask_exec = 0, mask_write, mask_read, mask_append
+	mask_exec = 0, mask_write, mask_read, mask_append, mask_openexec
 };
 
 static const char *const mask_tokens[] = {
 	"^MAY_EXEC",
 	"^MAY_WRITE",
 	"^MAY_READ",
-	"^MAY_APPEND"
+	"^MAY_APPEND",
+	"^MAY_OPENEXEC"
 };
 
 void *ima_policy_start(struct seq_file *m, loff_t *pos)
@@ -1530,6 +1535,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 			seq_printf(m, pt(Opt_mask), mt(mask_read) + offset);
 		if (entry->mask & MAY_APPEND)
 			seq_printf(m, pt(Opt_mask), mt(mask_append) + offset);
+		if (entry->mask & MAY_OPENEXEC)
+			seq_printf(m, pt(Opt_mask), mt(mask_openexec) + offset);
 		seq_puts(m, " ");
 	}
 
-- 
2.7.5

