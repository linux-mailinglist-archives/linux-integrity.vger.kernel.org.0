Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7755F421B2A
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Oct 2021 02:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhJEAfO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Oct 2021 20:35:14 -0400
Received: from mail-mw2nam12on2065.outbound.protection.outlook.com ([40.107.244.65]:56673
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229486AbhJEAfN (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Oct 2021 20:35:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0h1KF37GztJljwJRNpg52Q0X8tgRG3eW9/BLnbIhOnvQKsf1bZNG8blY+jyxZtWcdGGEDWfQGKdAwbwOVGWZ5bL8RWCdZ/KC/bEanuA6YnJ8A3zPEJ5sAOd5Y0Xs7UrDEXkIf9WAqQIhfqdxiKHtnOM2Z6SaiJsOoCXAydAKY6pdeYlI4RlfgO7074kdKhGbn7nd5Hja1JMtkhvG2/Aask/mFp6MpqhwMGtnmra1nf5i825Z6/vhRr7QnaqMjLbIzOkdq+pztke1mVFSB4mIHQ/lB4iBurmy+KWxfyAb62GBftn+hbLl1ZutXpuOKD/N88/0yxJYQ7dPQtrinMz3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zs8qww58dQeoQnqPaMEBR6XAldTplDRUJFTo/vgu57k=;
 b=iIO0c6pRSTePDIMywZboXJLwzFWH12U8B2A8JsPIAVgoINRjMmDQZWE1wKaZJZEOj3jqzr/YNuDoNuMZ4YUJPXSaTH7wJqpyGvXgPO7tST3LnihgQQXhRWVQCUakyqaFXfRhVXtaN8re2krEgsgkJkcxkw89dQeyGK+eT2hND9oGryhM4g7kNaP0UorRUvEVTaduGdWYQmEBcBzELFma7tQS2Hxh1b8H/HaH18AzV14ycJWcyJ1QKLARqsgOuOLMBB7GuhdRDKq9pZR7hyvBkxtMtTV+Ru2rXETQmg4jxSbsAsGZgT8EyE/iM7M6ZdQOLGvU0eaI9Af+znf8nj8blQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vpitech.com; dmarc=pass action=none header.from=vpitech.com;
 dkim=pass header.d=vpitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vpitech.onmicrosoft.com; s=selector2-vpitech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zs8qww58dQeoQnqPaMEBR6XAldTplDRUJFTo/vgu57k=;
 b=iVXdwZTKEPb8A1eVIAxwwrjyviK3SEBMfI149ID1l/gfS90OkucevBWuNCj9+ECL2RkaPsMSrzSr3avtB3PLw5LIm2Dn27lm8JwhNEGTtalpTAavWdtn3Wrk5oO9kRhoEw9tb2u0hdsBfs4uCDLGOuaNmUN5SuSFndd07M9crDc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=vpitech.com;
Received: from MW2PR07MB3980.namprd07.prod.outlook.com (2603:10b6:907:a::32)
 by MW4PR07MB8684.namprd07.prod.outlook.com (2603:10b6:303:109::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 00:33:22 +0000
Received: from MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014]) by MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014%4]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 00:33:21 +0000
From:   Alex Henrie <alexh@vpitech.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        pvorel@suse.cz, alexhenrie24@gmail.com
Cc:     Curtis Veit <veit@vpieng.com>, Alex Henrie <alexh@vpitech.com>
Subject: [PATCH v2] ima: add gid support
Date:   Mon,  4 Oct 2021 18:32:37 -0600
Message-Id: <20211005003237.501882-1-alexh@vpitech.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CO2PR05CA0099.namprd05.prod.outlook.com
 (2603:10b6:104:1::25) To MW2PR07MB3980.namprd07.prod.outlook.com
 (2603:10b6:907:a::32)
MIME-Version: 1.0
Received: from demeter.ad.vpitech.com (66.60.105.30) by CO2PR05CA0099.namprd05.prod.outlook.com (2603:10b6:104:1::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.7 via Frontend Transport; Tue, 5 Oct 2021 00:33:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fba1a006-9e20-48e5-6488-08d98797bb9c
X-MS-TrafficTypeDiagnostic: MW4PR07MB8684:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW4PR07MB8684FCB690FECC55C12DA600B8AF9@MW4PR07MB8684.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oCunXt5DZoBxSqTWlDp5J6eZGbiu1GNOaMGWUU+TJyWToJfxTBp/S2BS9mE4Dwi0wifqgclzuhcHTo6cedUU0SDwOzs2bSH5XP1DbwaVV6DLySevaTysearLPtw0ROSqyZr1k0wO0jFLyhYcLUmjVaaV9JyMWNbbxTuXSlEBL6f2JCgDouI813QZl7svFh0SDcvq+Hs3zZBW+HORSj8+O88PaBtcS/pi02ktlndyPMeaWcRCR0UoUDy0N+KWtyb8jpSaz7Y9T0Vni6J58wILh+76RiH6hJx8x9pXzhAI/LintsPxMA8rvrv/6FdjFMPO+IWuQmP5Hlc7rT5UABazpejTtIcHG3NqzzeoSnQsTjO0QxpoSVDa/QDuU/lkafe4npSXFbbnVnMxyic3+xd8XBWHIY2fFsGhxhjoQDXJuKvtoyNaSVK8UpJqLXJmNXsb7n9fCEjFEPZgB22DbvELpyytYCvGVCE1QTOqarjVhsrgHdwFt60YVsQAj4yJKxOhZBBqOULq4qLQlOlQ9YvWlaPtTuT5KRwxmpgPm3TspHAWFqp0ChWjm1XW3nXxK5dHr7fbjInvVdsvG39bKgZ/G5vQcDCb55KXZ1z9xERIcA3xq5X5aUkRSYF4y8OUrN9iwuyhLjC+Mg2jj0Ec6tixKvNj2twBDTeZ9eY7OhtL77yoiLLZTZg+d6mBUIg27iGCDsRRWMemxXAE1JGSbFzCEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR07MB3980.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(376002)(346002)(396003)(136003)(366004)(26005)(6486002)(38350700002)(4326008)(508600001)(2616005)(66946007)(1076003)(38100700002)(5660300002)(66556008)(66476007)(956004)(83380400001)(86362001)(107886003)(8676002)(54906003)(7696005)(36756003)(52116002)(316002)(186003)(2906002)(8936002)(6666004)(30864003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VgnUslwmNr/ukgA5YLateiVe6TbwTePvIH5uPkEQ2dNCwyndQGyKSvy87+i3?=
 =?us-ascii?Q?S56dN+j9hCYCkL46tGLrow7TDL19zXOmTQfqrNehtGYkyo+92PwwfV2j/lf+?=
 =?us-ascii?Q?ovFcOBqzCOcyAcoWZnAJUUApOpDThCoOjeUAvOaI97aArA0uR1nNRVwv/Gpz?=
 =?us-ascii?Q?ek9/nuJGSswXonsT6Bi1ur9caBflWQOWjkF8qFiMlSdDA4sQ/ETfz8KpK0Mn?=
 =?us-ascii?Q?fTQpwubxwfpdXhRnAMsFERPi9ydWA0DSUvMXwHyH/pzXZSsK4Rc3BMpNhKQD?=
 =?us-ascii?Q?i8YVtSYZhRDoIByLKC4dIq+6z4nqwj1vp6x5pqEeNjX2XWnZL3sWnKI7ICvH?=
 =?us-ascii?Q?ywJfJ9jW5UIrw3PFBDy6/af9wWz9IHxLnlr7uvLxlDORw3vMI2VW5l+9p8sV?=
 =?us-ascii?Q?kM/DtJitBKommEinp8MJDgfkkqqbAogIBKYVOz0FOthg/hUigekefcVOAcX/?=
 =?us-ascii?Q?JgIxzJoAlYatK1aKyEyXdiBBMKpzSoqiLMX4Fyoj8RIZk9LlJmsvToWwg4X5?=
 =?us-ascii?Q?rnCb6GWHB90rf0FiYfGhDj1uHoFsWA3QVNiBUaYFAptcI5YE607QOqYdv1r6?=
 =?us-ascii?Q?WYQlzjGVXO4p+gJZrqvwnDfi0UAvaoZMCgT5NvPVN42bubSo+jUd5fJKGMiC?=
 =?us-ascii?Q?y/QTRWd+K2MjdxQvM2o/dSDEHKgiI/8aXZqgI1haNvYZqwut0SLVsBYr781Z?=
 =?us-ascii?Q?JWZNRiwJkkZ28be3SHHMfiXMOVAoeduI9zViio6aP3bCq5w+eBi3dJnFuOdP?=
 =?us-ascii?Q?j3NI13X3/dW7hjWgOJj+ugi/BBSe7bWxSW0NhRZtRxR6qNt+Lf8nKFDkk+QA?=
 =?us-ascii?Q?XjISc9Yg8ZNzZ1W2gS0oCYHZovQb8I3YFCCIS36VeAi1oNfFrBeyKeElwUIb?=
 =?us-ascii?Q?c5qJ2/kDeMpZAJUTwzkPwGekuJypmIwtUKw3YRgqkixCQ+VStmHju5a7kgE8?=
 =?us-ascii?Q?S4jJNdMuKRBX8W2MaOMJRydO2lMX/W7w8WKqOvnFmgUxvcXkeqJWIxWOISjs?=
 =?us-ascii?Q?LZDhta86hklhWNef2GJNLq7g0NCx55U3dcXes2JJsyZD0T9cBMvrT8lclts9?=
 =?us-ascii?Q?Km42aeC2S6lzmjO4yz2Nej6cvAU4zbJOFB2XXZ7djCBMkBj3n148Mp0C9692?=
 =?us-ascii?Q?5FIKZYNq4xUc6+F2pm67F9Cwfkx7loynUanOt9UTzhKW+uENLW0/rWafD5uO?=
 =?us-ascii?Q?ioAVxvOKaR4pvlM01Bzv/O+nwfMVAU56D2/gaeGEgeGIDf9+tb0GLLDY1cF4?=
 =?us-ascii?Q?sTwD4VZ/FDhxElpyd8JYlUynC190oLa1cREn3DPndk/8O906GOJCGdk7OXtg?=
 =?us-ascii?Q?5HoRtman1Uw8CFt7h3a/qtSO?=
X-OriginatorOrg: vpitech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fba1a006-9e20-48e5-6488-08d98797bb9c
X-MS-Exchange-CrossTenant-AuthSource: MW2PR07MB3980.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 00:33:20.9694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 130d6264-38b7-4474-a9bf-511ff1224fac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nVWymnMwoh6CY6CYF5eASbqIX/yR4J+0v06ZdAzwr5bcQij4JoY8QzLX3b/H9Lf+9fWtBdfwddWapMdJNbNbAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR07MB8684
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Curtis Veit <veit@vpieng.com>

IMA currently supports the concept of rules based on uid where the rule
is based on the uid of the file owner or the uid of the user accessing
the file. It is useful to have similar rules based on gid. This patch
provides that ability.

Signed-off-by: Curtis Veit <veit@vpieng.com>
Co-developed-by: Alex Henrie <alexh@vpitech.com>
Signed-off-by: Alex Henrie <alexh@vpitech.com>
---
v2: Trivial changes that Mimi requested
---
 Documentation/ABI/testing/ima_policy |   8 +-
 security/integrity/ima/ima_policy.c  | 201 +++++++++++++++++++++++----
 2 files changed, 180 insertions(+), 29 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 5c2798534950..e1a04bd3b9e5 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -22,8 +22,9 @@ Description:
 		  action: measure | dont_measure | appraise | dont_appraise |
 			  audit | hash | dont_hash
 		  condition:= base | lsm  [option]
-			base:	[[func=] [mask=] [fsmagic=] [fsuuid=] [uid=]
-				[euid=] [fowner=] [fsname=]]
+			base:	[[func=] [mask=] [fsmagic=] [fsuuid=] [fsname=]
+				[uid=] [euid=] [gid=] [egid=]
+				[fowner=] [fgroup=]]
 			lsm:	[[subj_user=] [subj_role=] [subj_type=]
 				 [obj_user=] [obj_role=] [obj_type=]]
 			option:	[[appraise_type=]] [template=] [permit_directio]
@@ -40,7 +41,10 @@ Description:
 			fsuuid:= file system UUID (e.g 8bcbe394-4f13-4144-be8e-5aa9ea2ce2f6)
 			uid:= decimal value
 			euid:= decimal value
+			gid:= decimal value
+			egid:= decimal value
 			fowner:= decimal value
+			fgroup:= decimal value
 		  lsm:  are LSM specific
 		  option:
 			appraise_type:= [imasig] [imasig|modsig]
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 87b9b71cb820..a056823c41a9 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -36,6 +36,9 @@
 #define IMA_KEYRINGS	0x0400
 #define IMA_LABEL	0x0800
 #define IMA_VALIDATE_ALGOS	0x1000
+#define IMA_GID		0x2000
+#define IMA_EGID	0x4000
+#define IMA_FGROUP	0x8000
 
 #define UNKNOWN		0
 #define MEASURE		0x0001	/* same as IMA_MEASURE */
@@ -78,9 +81,13 @@ struct ima_rule_entry {
 	unsigned long fsmagic;
 	uuid_t fsuuid;
 	kuid_t uid;
+	kgid_t gid;
 	kuid_t fowner;
+	kgid_t fgroup;
 	bool (*uid_op)(kuid_t, kuid_t);    /* Handlers for operators       */
+	bool (*gid_op)(kgid_t, kgid_t);
 	bool (*fowner_op)(kuid_t, kuid_t); /* uid_eq(), uid_gt(), uid_lt() */
+	bool (*fgroup_op)(kgid_t, kgid_t); /* gid_eq(), gid_gt(), gid_lt() */
 	int pcr;
 	unsigned int allowed_algos; /* bitfield of allowed hash algorithms */
 	struct {
@@ -104,7 +111,8 @@ static_assert(
 
 /*
  * Without LSM specific knowledge, the default policy can only be
- * written in terms of .action, .func, .mask, .fsmagic, .uid, and .fowner
+ * written in terms of .action, .func, .mask, .fsmagic, .uid, .gid,
+ * .fowner, and .fgroup
  */
 
 /*
@@ -582,10 +590,23 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		} else if (!rule->uid_op(cred->euid, rule->uid))
 			return false;
 	}
-
+	if ((rule->flags & IMA_GID) && !rule->gid_op(rule->gid, cred->gid))
+		return false;
+	if (rule->flags & IMA_EGID) {
+		if (has_capability_noaudit(current, CAP_SETGID)) {
+			if (!rule->gid_op(cred->egid, rule->gid)
+			    && !rule->gid_op(cred->sgid, rule->gid)
+			    && !rule->gid_op(cred->gid, rule->gid))
+				return false;
+		} else if (!rule->gid_op(cred->egid, rule->gid))
+			return false;
+	}
 	if ((rule->flags & IMA_FOWNER) &&
 	    !rule->fowner_op(i_uid_into_mnt(mnt_userns, inode), rule->fowner))
 		return false;
+	if ((rule->flags & IMA_FGROUP) &&
+	    !rule->fgroup_op(i_gid_into_mnt(mnt_userns, inode), rule->fgroup))
+		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
 		u32 osid;
@@ -987,16 +1008,19 @@ void ima_update_policy(void)
 }
 
 /* Keep the enumeration in sync with the policy_tokens! */
-enum {
+enum policy_opt {
 	Opt_measure, Opt_dont_measure,
 	Opt_appraise, Opt_dont_appraise,
 	Opt_audit, Opt_hash, Opt_dont_hash,
 	Opt_obj_user, Opt_obj_role, Opt_obj_type,
 	Opt_subj_user, Opt_subj_role, Opt_subj_type,
-	Opt_func, Opt_mask, Opt_fsmagic, Opt_fsname,
-	Opt_fsuuid, Opt_uid_eq, Opt_euid_eq, Opt_fowner_eq,
-	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
-	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
+	Opt_func, Opt_mask, Opt_fsmagic, Opt_fsname, Opt_fsuuid,
+	Opt_uid_eq, Opt_euid_eq, Opt_gid_eq, Opt_egid_eq,
+	Opt_fowner_eq, Opt_fgroup_eq,
+	Opt_uid_gt, Opt_euid_gt, Opt_gid_gt, Opt_egid_gt,
+	Opt_fowner_gt, Opt_fgroup_gt,
+	Opt_uid_lt, Opt_euid_lt, Opt_gid_lt, Opt_egid_lt,
+	Opt_fowner_lt, Opt_fgroup_lt,
 	Opt_appraise_type, Opt_appraise_flag, Opt_appraise_algos,
 	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
 	Opt_label, Opt_err
@@ -1023,13 +1047,22 @@ static const match_table_t policy_tokens = {
 	{Opt_fsuuid, "fsuuid=%s"},
 	{Opt_uid_eq, "uid=%s"},
 	{Opt_euid_eq, "euid=%s"},
+	{Opt_gid_eq, "gid=%s"},
+	{Opt_egid_eq, "egid=%s"},
 	{Opt_fowner_eq, "fowner=%s"},
+	{Opt_fgroup_eq, "fgroup=%s"},
 	{Opt_uid_gt, "uid>%s"},
 	{Opt_euid_gt, "euid>%s"},
+	{Opt_gid_gt, "gid>%s"},
+	{Opt_egid_gt, "egid>%s"},
 	{Opt_fowner_gt, "fowner>%s"},
+	{Opt_fgroup_gt, "fgroup>%s"},
 	{Opt_uid_lt, "uid<%s"},
 	{Opt_euid_lt, "euid<%s"},
+	{Opt_gid_lt, "gid<%s"},
+	{Opt_egid_lt, "egid<%s"},
 	{Opt_fowner_lt, "fowner<%s"},
+	{Opt_fgroup_lt, "fgroup<%s"},
 	{Opt_appraise_type, "appraise_type=%s"},
 	{Opt_appraise_flag, "appraise_flag=%s"},
 	{Opt_appraise_algos, "appraise_algos=%s"},
@@ -1073,22 +1106,36 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 }
 
 static void ima_log_string_op(struct audit_buffer *ab, char *key, char *value,
-			      bool (*rule_operator)(kuid_t, kuid_t))
+			      enum policy_opt rule_operator)
 {
 	if (!ab)
 		return;
 
-	if (rule_operator == &uid_gt)
+	switch (rule_operator) {
+	case Opt_uid_gt:
+	case Opt_euid_gt:
+	case Opt_gid_gt:
+	case Opt_egid_gt:
+	case Opt_fowner_gt:
+	case Opt_fgroup_gt:
 		audit_log_format(ab, "%s>", key);
-	else if (rule_operator == &uid_lt)
+		break;
+	case Opt_uid_lt:
+	case Opt_euid_lt:
+	case Opt_gid_lt:
+	case Opt_egid_lt:
+	case Opt_fowner_lt:
+	case Opt_fgroup_lt:
 		audit_log_format(ab, "%s<", key);
-	else
+		break;
+	default:
 		audit_log_format(ab, "%s=", key);
+	}
 	audit_log_format(ab, "%s ", value);
 }
 static void ima_log_string(struct audit_buffer *ab, char *key, char *value)
 {
-	ima_log_string_op(ab, key, value, NULL);
+	ima_log_string_op(ab, key, value, Opt_err);
 }
 
 /*
@@ -1163,7 +1210,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 		if (entry->flags & ~(IMA_FUNC | IMA_MASK | IMA_FSMAGIC |
 				     IMA_UID | IMA_FOWNER | IMA_FSUUID |
 				     IMA_INMASK | IMA_EUID | IMA_PCR |
-				     IMA_FSNAME | IMA_DIGSIG_REQUIRED |
+				     IMA_FSNAME | IMA_GID | IMA_EGID |
+				     IMA_FGROUP | IMA_DIGSIG_REQUIRED |
 				     IMA_PERMIT_DIRECTIO | IMA_VALIDATE_ALGOS))
 			return false;
 
@@ -1174,7 +1222,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 		if (entry->flags & ~(IMA_FUNC | IMA_MASK | IMA_FSMAGIC |
 				     IMA_UID | IMA_FOWNER | IMA_FSUUID |
 				     IMA_INMASK | IMA_EUID | IMA_PCR |
-				     IMA_FSNAME | IMA_DIGSIG_REQUIRED |
+				     IMA_FSNAME | IMA_GID | IMA_EGID |
+				     IMA_FGROUP | IMA_DIGSIG_REQUIRED |
 				     IMA_PERMIT_DIRECTIO | IMA_MODSIG_ALLOWED |
 				     IMA_CHECK_BLACKLIST | IMA_VALIDATE_ALGOS))
 			return false;
@@ -1186,7 +1235,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 
 		if (entry->flags & ~(IMA_FUNC | IMA_FSMAGIC | IMA_UID |
 				     IMA_FOWNER | IMA_FSUUID | IMA_EUID |
-				     IMA_PCR | IMA_FSNAME))
+				     IMA_PCR | IMA_FSNAME | IMA_GID | IMA_EGID |
+				     IMA_FGROUP))
 			return false;
 
 		break;
@@ -1194,7 +1244,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 		if (entry->action & ~(MEASURE | DONT_MEASURE))
 			return false;
 
-		if (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_PCR |
+		if (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_GID | IMA_PCR |
 				     IMA_KEYRINGS))
 			return false;
 
@@ -1206,7 +1256,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 		if (entry->action & ~(MEASURE | DONT_MEASURE))
 			return false;
 
-		if (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_PCR |
+		if (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_GID | IMA_PCR |
 				     IMA_LABEL))
 			return false;
 
@@ -1276,7 +1326,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	struct audit_buffer *ab;
 	char *from;
 	char *p;
-	bool uid_token;
+	bool eid_token; /* either euid or egid */
 	struct ima_template_desc *template_desc;
 	int result = 0;
 
@@ -1284,9 +1334,13 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				       AUDIT_INTEGRITY_POLICY_RULE);
 
 	entry->uid = INVALID_UID;
+	entry->gid = INVALID_GID;
 	entry->fowner = INVALID_UID;
+	entry->fgroup = INVALID_GID;
 	entry->uid_op = &uid_eq;
+	entry->gid_op = &gid_eq;
 	entry->fowner_op = &uid_eq;
+	entry->fgroup_op = &gid_eq;
 	entry->action = UNKNOWN;
 	while ((p = strsep(&rule, " \t")) != NULL) {
 		substring_t args[MAX_OPT_ARGS];
@@ -1504,12 +1558,12 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			fallthrough;
 		case Opt_uid_eq:
 		case Opt_euid_eq:
-			uid_token = (token == Opt_uid_eq) ||
-				    (token == Opt_uid_gt) ||
-				    (token == Opt_uid_lt);
+			eid_token = (token == Opt_euid_eq) ||
+				    (token == Opt_euid_gt) ||
+				    (token == Opt_euid_lt);
 
-			ima_log_string_op(ab, uid_token ? "uid" : "euid",
-					  args[0].from, entry->uid_op);
+			ima_log_string_op(ab, eid_token ? "euid" : "uid",
+					  args[0].from, token);
 
 			if (uid_valid(entry->uid)) {
 				result = -EINVAL;
@@ -1524,8 +1578,43 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				    (uid_t)lnum != lnum)
 					result = -EINVAL;
 				else
-					entry->flags |= uid_token
-					    ? IMA_UID : IMA_EUID;
+					entry->flags |= eid_token
+					    ? IMA_EUID : IMA_UID;
+			}
+			break;
+		case Opt_gid_gt:
+		case Opt_egid_gt:
+			entry->gid_op = &gid_gt;
+			fallthrough;
+		case Opt_gid_lt:
+		case Opt_egid_lt:
+			if ((token == Opt_gid_lt) || (token == Opt_egid_lt))
+				entry->gid_op = &gid_lt;
+			fallthrough;
+		case Opt_gid_eq:
+		case Opt_egid_eq:
+			eid_token = (token == Opt_egid_eq) ||
+				    (token == Opt_egid_gt) ||
+				    (token == Opt_egid_lt);
+
+			ima_log_string_op(ab, eid_token ? "egid" : "gid",
+					  args[0].from, token);
+
+			if (gid_valid(entry->gid)) {
+				result = -EINVAL;
+				break;
+			}
+
+			result = kstrtoul(args[0].from, 10, &lnum);
+			if (!result) {
+				entry->gid = make_kgid(current_user_ns(),
+						       (gid_t)lnum);
+				if (!gid_valid(entry->gid) ||
+				    (((gid_t)lnum) != lnum))
+					result = -EINVAL;
+				else
+					entry->flags |= eid_token
+					    ? IMA_EGID : IMA_GID;
 			}
 			break;
 		case Opt_fowner_gt:
@@ -1536,8 +1625,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->fowner_op = &uid_lt;
 			fallthrough;
 		case Opt_fowner_eq:
-			ima_log_string_op(ab, "fowner", args[0].from,
-					  entry->fowner_op);
+			ima_log_string_op(ab, "fowner", args[0].from, token);
 
 			if (uid_valid(entry->fowner)) {
 				result = -EINVAL;
@@ -1553,6 +1641,32 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 					entry->flags |= IMA_FOWNER;
 			}
 			break;
+		case Opt_fgroup_gt:
+			entry->fgroup_op = &gid_gt;
+			fallthrough;
+		case Opt_fgroup_lt:
+			if (token == Opt_fgroup_lt)
+				entry->fgroup_op = &gid_lt;
+			fallthrough;
+		case Opt_fgroup_eq:
+			ima_log_string_op(ab, "fgroup", args[0].from, token);
+
+			if (gid_valid(entry->fgroup)) {
+				result = -EINVAL;
+				break;
+			}
+
+			result = kstrtoul(args[0].from, 10, &lnum);
+			if (!result) {
+				entry->fgroup = make_kgid(current_user_ns(),
+							  (gid_t)lnum);
+				if (!gid_valid(entry->fgroup) ||
+				    (((gid_t)lnum) != lnum))
+					result = -EINVAL;
+				else
+					entry->flags |= IMA_FGROUP;
+			}
+			break;
 		case Opt_obj_user:
 			ima_log_string(ab, "obj_user", args[0].from);
 			result = ima_lsm_rule_init(entry, args,
@@ -1936,6 +2050,28 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, " ");
 	}
 
+	if (entry->flags & IMA_GID) {
+		snprintf(tbuf, sizeof(tbuf), "%d", __kgid_val(entry->gid));
+		if (entry->gid_op == &gid_gt)
+			seq_printf(m, pt(Opt_gid_gt), tbuf);
+		else if (entry->gid_op == &gid_lt)
+			seq_printf(m, pt(Opt_gid_lt), tbuf);
+		else
+			seq_printf(m, pt(Opt_gid_eq), tbuf);
+		seq_puts(m, " ");
+	}
+
+	if (entry->flags & IMA_EGID) {
+		snprintf(tbuf, sizeof(tbuf), "%d", __kgid_val(entry->gid));
+		if (entry->gid_op == &gid_gt)
+			seq_printf(m, pt(Opt_egid_gt), tbuf);
+		else if (entry->gid_op == &gid_lt)
+			seq_printf(m, pt(Opt_egid_lt), tbuf);
+		else
+			seq_printf(m, pt(Opt_egid_eq), tbuf);
+		seq_puts(m, " ");
+	}
+
 	if (entry->flags & IMA_FOWNER) {
 		snprintf(tbuf, sizeof(tbuf), "%d", __kuid_val(entry->fowner));
 		if (entry->fowner_op == &uid_gt)
@@ -1947,6 +2083,17 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, " ");
 	}
 
+	if (entry->flags & IMA_FGROUP) {
+		snprintf(tbuf, sizeof(tbuf), "%d", __kgid_val(entry->fgroup));
+		if (entry->fgroup_op == &gid_gt)
+			seq_printf(m, pt(Opt_fgroup_gt), tbuf);
+		else if (entry->fgroup_op == &gid_lt)
+			seq_printf(m, pt(Opt_fgroup_lt), tbuf);
+		else
+			seq_printf(m, pt(Opt_fgroup_eq), tbuf);
+		seq_puts(m, " ");
+	}
+
 	if (entry->flags & IMA_VALIDATE_ALGOS) {
 		seq_puts(m, "appraise_algos=");
 		ima_policy_show_appraise_algos(m, entry->allowed_algos);
-- 
2.33.0

