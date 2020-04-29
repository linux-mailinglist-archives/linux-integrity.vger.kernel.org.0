Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF971BDE92
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2020 15:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgD2NjN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Apr 2020 09:39:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727996AbgD2NjD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Apr 2020 09:39:03 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03TDYTlb066645;
        Wed, 29 Apr 2020 09:38:59 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30q9bc312p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 09:38:59 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03TDa02Y068913;
        Wed, 29 Apr 2020 09:38:58 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30q9bc311g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 09:38:58 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03TDUR1C029371;
        Wed, 29 Apr 2020 13:38:56 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 30mcu5rgk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 13:38:56 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03TDcsHv58655108
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 13:38:54 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51ADFAE055;
        Wed, 29 Apr 2020 13:38:54 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EE2BAE04D;
        Wed, 29 Apr 2020 13:38:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.162.91])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 29 Apr 2020 13:38:53 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Mickael Salaun <mic@digikod.net>,
        Steve Grubb <sgrubb@redhat.com>, Jann Horn <jannh@google.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ima: add policy support for identifying file execute mode bit
Date:   Wed, 29 Apr 2020 09:38:42 -0400
Message-Id: <1588167523-7866-2-git-send-email-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1588167523-7866-1-git-send-email-zohar@linux.ibm.com>
References: <1588167523-7866-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-29_05:2020-04-29,2020-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=999 suspectscore=1 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290110
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Extend the IMA policy language with "mode=IXUGO" to identify files with
the execute mode bit enabled.

Examples:
measure func=FILE_CHECK mode=IXUGO
appraise func=FILE_CHECK appraise_type=imasig mode=IXUGO

Suggested-by: Steve Grubb <sgrubb@redhat.com> (based on execute mode bit)
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 Documentation/ABI/testing/ima_policy |  5 +++--
 security/integrity/ima/ima_policy.c  | 18 ++++++++++++++++--
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index cd572912c593..a12e784cee31 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -20,8 +20,8 @@ Description:
 		action: measure | dont_measure | appraise | dont_appraise |
 			audit | hash | dont_hash
 		condition:= base | lsm  [option]
-			base:	[[func=] [mask=] [fsmagic=] [fsuuid=] [uid=]
-				[euid=] [fowner=] [fsname=]]
+			base:	[[func=] [mask=] [mode=] [fsmagic=] [fsuuid=]
+				[uid=] [euid=] [fowner=] [fsname=]]
 			lsm:	[[subj_user=] [subj_role=] [subj_type=]
 				 [obj_user=] [obj_role=] [obj_type=]]
 			option:	[[appraise_type=]] [template=] [permit_directio]
@@ -32,6 +32,7 @@ Description:
 				[KEXEC_CMDLINE] [KEY_CHECK]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
 			       [[^]MAY_EXEC]
+			mode:= [IXUGO]
 			fsmagic:= hex value
 			fsuuid:= file system UUID (e.g 8bcbe394-4f13-4144-be8e-5aa9ea2ce2f6)
 			uid:= decimal value
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index ef7f68cc935e..28b68e076638 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -33,6 +33,7 @@
 #define IMA_PCR		0x0100
 #define IMA_FSNAME	0x0200
 #define IMA_KEYRINGS	0x0400
+#define IMA_IXUGO	0x0800
 
 #define UNKNOWN		0
 #define MEASURE		0x0001	/* same as IMA_MEASURE */
@@ -435,6 +436,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	if ((rule->flags & IMA_INMASK) &&
 	    (!(rule->mask & mask) && func != POST_SETATTR))
 		return false;
+	if ((rule->flags & IMA_IXUGO) && !(inode->i_mode & S_IXUGO))
+		return false;
 	if ((rule->flags & IMA_FSMAGIC)
 	    && rule->fsmagic != inode->i_sb->s_magic)
 		return false;
@@ -459,6 +462,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	if ((rule->flags & IMA_FOWNER) &&
 	    !rule->fowner_op(inode->i_uid, rule->fowner))
 		return false;
+
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
 		u32 osid;
@@ -822,7 +826,7 @@ enum {
 	Opt_audit, Opt_hash, Opt_dont_hash,
 	Opt_obj_user, Opt_obj_role, Opt_obj_type,
 	Opt_subj_user, Opt_subj_role, Opt_subj_type,
-	Opt_func, Opt_mask, Opt_fsmagic, Opt_fsname,
+	Opt_func, Opt_mask, Opt_mode, Opt_fsmagic, Opt_fsname,
 	Opt_fsuuid, Opt_uid_eq, Opt_euid_eq, Opt_fowner_eq,
 	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
@@ -847,6 +851,7 @@ static const match_table_t policy_tokens = {
 	{Opt_subj_type, "subj_type=%s"},
 	{Opt_func, "func=%s"},
 	{Opt_mask, "mask=%s"},
+	{Opt_mode, "mode=%s"},
 	{Opt_fsmagic, "fsmagic=%s"},
 	{Opt_fsname, "fsname=%s"},
 	{Opt_fsuuid, "fsuuid=%s"},
@@ -1098,6 +1103,13 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->flags |= (*args[0].from == '^')
 				     ? IMA_INMASK : IMA_MASK;
 			break;
+		case Opt_mode:
+			ima_log_string(ab, "mode", args[0].from);
+			if ((strcmp(args[0].from, "IXUGO")) == 0)
+				entry->flags |= IMA_IXUGO;
+			else
+				result = -EINVAL;
+			break;
 		case Opt_fsmagic:
 			ima_log_string(ab, "fsmagic", args[0].from);
 
@@ -1185,7 +1197,6 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			uid_token = (token == Opt_uid_eq) ||
 				    (token == Opt_uid_gt) ||
 				    (token == Opt_uid_lt);
-
 			ima_log_string_op(ab, uid_token ? "uid" : "euid",
 					  args[0].from, entry->uid_op);
 
@@ -1522,6 +1533,9 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, " ");
 	}
 
+	if (entry->flags & IMA_IXUGO)
+		seq_puts(m, "mode=IXUGO ");
+
 	if (entry->flags & IMA_FSMAGIC) {
 		snprintf(tbuf, sizeof(tbuf), "0x%lx", entry->fsmagic);
 		seq_printf(m, pt(Opt_fsmagic), tbuf);
-- 
2.7.5

