Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394B2425CFE
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Oct 2021 22:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbhJGUN3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Oct 2021 16:13:29 -0400
Received: from mail-bn8nam11on2044.outbound.protection.outlook.com ([40.107.236.44]:50833
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230009AbhJGUN2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Oct 2021 16:13:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4Klwyd389PE+Yt1gzAkGzVb1JJ6Ztvdnzp7LkyISN2NkbEt4Sddj88BigSwclm/xJVTD+e9Vz2tdx2hIGgphpYWKDPPcOrcRR/iehGPU3a4WIZud7/uU929IqL6aKAModP00own3CIAjaizJdklmL4Llt0V0xVYcmM53UFm+seAy5KU7NbGkFbuKF+aH8YiyrYiBFMH0tX2G2Z/iryR+qbw+b4zPjZiVYxCgt7Qvb5U0ZV9wfaY4kw3YxMh0Iz9i9Z5R4wQJkT/+Cy1EX54DSwHedvqaB2eWjLjhIk1PIMJq5AfiLWm/6r7iKN2aeHZBRAcTTm5hJ6Sl+1k8QiaSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfOfa8cIVGfjBA82jtZ6ZRCrSGAS6ub7F3NVv36y6kE=;
 b=RHFd5SGiQXk+7Qe3cb3GGuVc776eyOK0nU6/O/pufGcvCTfkbZY6UvrmraYDKhHDGqDWcaIn6jbISbxIe/2KE2Wdfas+ntbDJnD6D30aPOeb5zPsIWKLzeyAYgag13CMxw6lvjRVvlMq3p/hvCccNYUQz6urv+EKgE05lXYzZUEP8/I8OgaJ2MeY8wSTZBjdOAHO6ek+5lJFetviFQg9ioN2hD/AbhYB3caNpwFZ0BH3mpO5IfdR61QSVa7bpR43X2sQecg6TI+KC2MjPnx7AjdjzliESDpzy77Kt91PxMCB387PZUdYjBhdBSO3DQq/IrGFGx9xmMi1UNL4kXp8Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vpitech.com; dmarc=pass action=none header.from=vpitech.com;
 dkim=pass header.d=vpitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vpitech.onmicrosoft.com; s=selector2-vpitech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfOfa8cIVGfjBA82jtZ6ZRCrSGAS6ub7F3NVv36y6kE=;
 b=A34WOrWn12Ej3zDqIe5Fspjh3n63GFWeREOvEMcQpYcYGK2NB3pFC1RjISu8gEvjf/j8/h63KiVFSxc6/nfMpMFNXJK11u0lC9R5sO/95VWGLHBnMSAUR4kFrM1GKv0HUYKHL7v5rO83HPd2a3WUBUc3yY8+g/KnV+vf9tlyJzI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=vpitech.com;
Received: from MW2PR07MB3980.namprd07.prod.outlook.com (2603:10b6:907:a::32)
 by MW2PR07MB3915.namprd07.prod.outlook.com (2603:10b6:907:2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Thu, 7 Oct
 2021 20:11:31 +0000
Received: from MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014]) by MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014%4]) with mapi id 15.20.4566.022; Thu, 7 Oct 2021
 20:11:31 +0000
From:   Alex Henrie <alexh@vpitech.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        pvorel@suse.cz, alexhenrie24@gmail.com
Cc:     Curtis Veit <veit@vpieng.com>, Alex Henrie <alexh@vpitech.com>
Subject: [PATCH v3 2/2] ima: add gid support
Date:   Thu,  7 Oct 2021 14:03:02 -0600
Message-Id: <20211007200302.187892-2-alexh@vpitech.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211007200302.187892-1-alexh@vpitech.com>
References: <20211007200302.187892-1-alexh@vpitech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0002.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::15) To MW2PR07MB3980.namprd07.prod.outlook.com
 (2603:10b6:907:a::32)
MIME-Version: 1.0
Received: from demeter.ad.vpitech.com (66.60.105.30) by BY5PR16CA0002.namprd16.prod.outlook.com (2603:10b6:a03:1a0::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 20:11:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1996fc8-cad0-4c5f-4c92-08d989cea743
X-MS-TrafficTypeDiagnostic: MW2PR07MB3915:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR07MB39154C1983139918792A3BF4B8B19@MW2PR07MB3915.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:121;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ImZx0OJdmXBjNOxrrsUdfYWpXVh4jtOg+z5xiMNwuJd+grkJWISBBV4dTl6/iymDMJ9WhhY8uAU5GkndLm0iGbNN2QlTYgJWzaWkjY128F173SW8ORf3hB91Dkc+3cRCUpK7xy7VWDlRHof1zxC9pmCJcicJ505jAhxs+APpMGBv0GdOtnPXShCGQPMU146v3GEh5l5p38dXizx+4KcFD/LLr4d7WWScW5YCZZFxCAObbTqdwcBCODt92JpYe/jsxPqVsZHcfEtwNPV9XR8shT+F3xShwGD5hbs0F0fHIG4khEh1gXcaLMbcloptpUmxB5sizlReemKafOzZtU25YS/PejYW8Gy9GQJ9JYJvZyGhfYqYar1X3p3PwqMsm3SXTf5ywGkJ37M+nGIqnACgjpMPkHZkBG8o1v6rDNPMpERkFYghPpZp3fwFTIVzFqkN6QO3Ck4f3tFHHrjDhLMqsVyO0seQ2GbWrlDbrHsc+hgFa4mQi+Qt4kITXCIUk9GzbCrA3KN7Isiv6X4Mn5L0855Jv3e5PNrRWyr0RdsSfZsDDyrt5YHrJjyzE2LNZPQmFKyucz0pM57IYzhbz/1/0fnQd4R+H3EaVZ5pYQul/cFvVPyOoatKXxjt9a7rPZhPWN6DcsMBjJfy8rQb2kO9dJSe0bAm87PDaM2oRJccYu/TwRUe88MVnTwcbKuPsngNzj3/Uw6/7J2ZOl2/zTFR0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR07MB3980.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(376002)(366004)(346002)(396003)(136003)(508600001)(83380400001)(38100700002)(2616005)(30864003)(36756003)(52116002)(956004)(4326008)(316002)(86362001)(6666004)(38350700002)(66476007)(66556008)(66946007)(2906002)(7696005)(8676002)(54906003)(186003)(1076003)(5660300002)(6486002)(8936002)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y/dNiJggRLairFzEQsm8NXEwN4GdckdYgJTXZ7d8JCIfRl5K7J1X/gZnVGrF?=
 =?us-ascii?Q?zevkNtOu0+lphLV7EbIiqwkgozt9NimzrHfH0UcxPv2EYLuYH8wereldamgI?=
 =?us-ascii?Q?DIycITuDrz4I83J9IDtaiq6XNgNzYgU8VLxpY91nhoDWaeISbXgY/KL/LEtp?=
 =?us-ascii?Q?oNphYQV3bxgZm1USvaO8Ttc/1h9YcVbmSFiO2pbAgmfJNrp3g0H/WwnTyoVh?=
 =?us-ascii?Q?BDh9wFb7IWMQRqyjmM8FyHgYTgLXE9jv7+/llzGQwYH2dnCC1xq4Nvw8nqfx?=
 =?us-ascii?Q?O6yFNEykq81eh0u1iT+cgTu0s2R+6si86TB5r2xTj/xW3o4ajEOLquV/ycf+?=
 =?us-ascii?Q?uOoy5wtSVgIL2LvadhVkLzfmFdu96Lk64dZkp9jsZIVrCYpBUMyrSLNqBM8W?=
 =?us-ascii?Q?mLpgS4AavxonyJWdp0XmOSB9qS0Li8hwW18fzuedClrLclUCZFfAbXyMgoXf?=
 =?us-ascii?Q?tvGZlmHfNcKNDLMPP4LfFraUqfKzJY5E1a6eApkhBQ6unsdqv9oQTz4790FO?=
 =?us-ascii?Q?YT8YbnrgFzrnGsmKcjMAZJjZnLJr16iQZrNEcp1+l9IEmTeWLJ06BWiduYIO?=
 =?us-ascii?Q?zwkcrfiEqtZ/4yNsdHdPVIa+YNa4s6Fuek0KOMSn+jcqw6448wRafLdqutUM?=
 =?us-ascii?Q?bCUFPBXjuybcppS7oaQYqrtCEHyqy2sUzjaGc7QA+W3os6/gX+ZX4ps9vyZ7?=
 =?us-ascii?Q?0el17wxZm1qCn55U1nIXikGpREZwFF55GTNe6NJrhWcxxYq4M+9hlIG9jDVD?=
 =?us-ascii?Q?E4BZoK4YTBd5UmnWAC+5eZJ8ltZZJExf854TRqQEqTa/OstMBhAoCLUjCNhV?=
 =?us-ascii?Q?lZl4lllJWWQBGWyyc0nBnwGbAgSSVjuO7GX6KOExvR0MwHgeaPXCQ10I6mPn?=
 =?us-ascii?Q?7jAiYirGNHC3N6OxTDQ6hCVWpaXI5T9b5grYgehwcXXGL2jsYBrZDvzuTb01?=
 =?us-ascii?Q?+wnNZmIEwRryi5rgL6ijgVQJaH0T2a9+Mh0b9oMxdm6PX5Qvye1bPTk/67us?=
 =?us-ascii?Q?HKlcNYy+2JDCAtnwO8rWm+wLE7nkc1fLrP3Qs2FMoBrA8NbX38kwvlpWNUft?=
 =?us-ascii?Q?5pIw74v2ISTawjwYoD/fi5EmzpCXVM7hAhvbmLXCzqTPvFHeOQ8YH5sZurc0?=
 =?us-ascii?Q?v9Kbyx9ZH4fGhvXMiDrS5l7hzvjxQFXbs52rBe5/dAhQNNQOopsEkrM5HzNT?=
 =?us-ascii?Q?bjnABKbVA1VMH1kOUaUVlNrxmPYZTYNoCRQMQPFi34UZeQS84lFZ+KHDWQlm?=
 =?us-ascii?Q?axUtmtbgBlR0ad4RPjAJ+PHHHoCsU4ANnrKGuiUJtgE2aOMsJxlUDXFXYsSa?=
 =?us-ascii?Q?RPxQqvN6LpwJIPOOWNdyVPyi?=
X-OriginatorOrg: vpitech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1996fc8-cad0-4c5f-4c92-08d989cea743
X-MS-Exchange-CrossTenant-AuthSource: MW2PR07MB3980.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 20:11:31.3808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 130d6264-38b7-4474-a9bf-511ff1224fac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cdk9Cnqy+1EGPeuY2ks9ha8s6gUB3BY8dLBadL3zJ1dVONCEoy7PzNh5JMBGXB8VwNAWQ8PPMqviDbajmlY4Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR07MB3915
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Curtis Veit <veit@vpieng.com>

IMA currently supports the concept of rules based on uid where the rule
is based on the uid of the file owner or the uid of the user accessing
the file. Provide the ability to have similar rules based on gid.

Signed-off-by: Curtis Veit <veit@vpieng.com>
Co-developed-by: Alex Henrie <alexh@vpitech.com>
Signed-off-by: Alex Henrie <alexh@vpitech.com>
---
v3:
- Give function arguments names
- Fix order of arguments to gid_op
- Shorten commit message
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
index 29741eaa0ed8..ad3c2af5f163 100644
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
 	bool (*uid_op)(kuid_t cred_uid, kuid_t rule_uid);    /* Handlers for operators       */
+	bool (*gid_op)(kgid_t cred_gid, kgid_t rule_gid);
 	bool (*fowner_op)(kuid_t cred_uid, kuid_t rule_uid); /* uid_eq(), uid_gt(), uid_lt() */
+	bool (*fgroup_op)(kgid_t cred_gid, kgid_t rule_gid); /* gid_eq(), gid_gt(), gid_lt() */
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
+	if ((rule->flags & IMA_GID) && !rule->gid_op(cred->gid, rule->gid))
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
@@ -1555,6 +1643,32 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
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
@@ -1938,6 +2052,28 @@ int ima_policy_show(struct seq_file *m, void *v)
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
@@ -1949,6 +2085,17 @@ int ima_policy_show(struct seq_file *m, void *v)
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

