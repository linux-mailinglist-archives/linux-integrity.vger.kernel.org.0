Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1479405B53
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Sep 2021 18:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238789AbhIIQwr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Sep 2021 12:52:47 -0400
Received: from mail-dm6nam12on2082.outbound.protection.outlook.com ([40.107.243.82]:12507
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237092AbhIIQwq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Sep 2021 12:52:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXEbmq7sy4NWTruNRtrJyvK0iELJmsHqxKObaEZoM66E4AUvELByPtSu9JEPJOiIAcR25BBbA9k2GoQfzFJwu+DN/LlsNzEB6TT6324matgxeM/+qDknFVw2/AUj9An9bg73wj7/KDwVmf0QjcFUlCQgknuYvzyHml66J3ohE8UK2yIzmpocJVWVvR7WgaWwQNMZcDGzT1Trw/HjrPqJAE/cjKshiPLvy2+z0msWO7cLztOgG6KLNbN3v80mdkWRqUG7WxI4GE2xR7wTeGNu4i+5tXQxXsWBjk5fOAJ9EMNzQdruXSp0e//NO+VrBxaCmbRQl3sz4pi9OSA9uQMD4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QYQumQ4ZdaNYYy9B/N0s3SS/83jreo6m4Hs4uAlW+zY=;
 b=fsbE086kwNpwEDxD6JvWZSWxE1wRA/1PX8U/iaPr/4kq4AjTJNTVsIZB6OpRGhRqtrqvzZpPBEggzbX0Whux+lb0lKi3ONo/cdu2INDN055KSHbVyfqp4CAQWCVSFkvm0A/62RRRCqjh6xjyNGNohwjX/D6920nwwMnnT3WFYyDEHwoAnA72zM0jfw2BpcDghTq71mX7yvLYyBAq17s+a4LNrjP07vHNSVLSVBmGhx/DU1LgViAi14at1uIeghpDs9ZZAxXTOIvXEcbnfFO9+ndyqNmwH87DQl2MpXNdmPNwYtE2popSToqJ4O+5xTHDBpJXu5knVm3Vij955kzAmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vpitech.com; dmarc=pass action=none header.from=vpitech.com;
 dkim=pass header.d=vpitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vpitech.onmicrosoft.com; s=selector2-vpitech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYQumQ4ZdaNYYy9B/N0s3SS/83jreo6m4Hs4uAlW+zY=;
 b=Zn4AAeiAVrvRmTUCTNLJQ8wc+5tOff6G6sZTtJyyTfcaPauXiq6pcdlTf7rQLiZPCJ+JadMcM4Lk2pD8q34FDeoeFfDWo7fcT5wIZt+N/kASDoeZKuNJhZwayFKNHv1POmLYGntrfxlBqf0EczEnDHjFETUFhLseJo7BbmldIvE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=vpitech.com;
Received: from MW2PR07MB3980.namprd07.prod.outlook.com (2603:10b6:907:a::32)
 by MW4PR07MB8667.namprd07.prod.outlook.com (2603:10b6:303:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Thu, 9 Sep
 2021 16:51:34 +0000
Received: from MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014]) by MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014%4]) with mapi id 15.20.4478.026; Thu, 9 Sep 2021
 16:51:34 +0000
From:   Alex Henrie <alexh@vpitech.com>
To:     linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        zohar@linux.ibm.com, pvorel@suse.cz, alexhenrie24@gmail.com
Cc:     Curtis Veit <veit@vpieng.com>, Alex Henrie <alexh@vpitech.com>
Subject: [PATCH linux rebase] ima: add gid support
Date:   Thu,  9 Sep 2021 10:51:10 -0600
Message-Id: <20210909165111.51038-1-alexh@vpitech.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR22CA0050.namprd22.prod.outlook.com
 (2603:10b6:300:12a::12) To MW2PR07MB3980.namprd07.prod.outlook.com
 (2603:10b6:907:a::32)
MIME-Version: 1.0
Received: from demeter.ad.vpitech.com (66.60.105.30) by MWHPR22CA0050.namprd22.prod.outlook.com (2603:10b6:300:12a::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 16:51:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27196135-dd4e-4018-4349-08d973b214cb
X-MS-TrafficTypeDiagnostic: MW4PR07MB8667:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW4PR07MB86671CED23A1A21C4D4B475CB8D59@MW4PR07MB8667.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NiGANSHx80YrhY67/Y0dbxpk/KUWiFXr+Cy3msF4WReHC9BLJShbDYurx1iRA6zg51uhCB9gaHdItrYjXseVCxHFDUCgmImMQSxebFcN+JvJ9X73K+IfMPySZ6+/XocN+3h6oJvwFzZ9yLrKz+EbJheI3Y1VDeID678FJOpslrpA7rOeJTMJZHrvJ/9mwjtSCAdsOHx99j1vK09SEV1enBaZ18O23XZu1iOTxOiSAKlcmssfyrYgVE5JUw2/mJuZFba2Wqj0ZzI0Y+0YWMSRKj9l0oLauOuT+66B9/e3ovmcwwotQlNLElNUKe37tePnyZ256mShUADL75MD8uVpBrpWiKk69sdWcQfXvVrPL7/E4OK5itFchC2fQsHurBjv2CUuhVDSbBMZji3wOIZHFEUFRUuuOCpi1guqDQT7LR3x05jkYFYWlQkuaYyx2D0YkSbcpohYiqevGqV4O+YVrEJ1bVjA3nMahYxftEegwjZ+/eij1ABhTXw01nnEJeIxj+6c3Exwmasp6JDqv8JpRuPOcBjDHoP3wgJjQTMXnOWRq/48DTTydkBUs3QInN7tQEXQ/uWqviczRmbfrSWHv5RFUDP0hC+XeHuKi94m2vCyEq6lCC84dS1pJqXH4w1DMeWfxObW8TFVKVrHq+MIWsbKW7+IeBH/2H0yn5Abr8RPzyF3KuzKDG0A8FeKjeGJ8kemGdUgxzyk6tetRx1SXBk46XNa9B7oXlBXHAum90I4J6/NGAyz8Gz3/lr8i+1rY2wXuLbQW8HGEy1kgR1Ao2xdMzemLtZkAg4iuJbl91Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR07MB3980.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(376002)(39840400004)(396003)(30864003)(2616005)(2906002)(36756003)(66476007)(66556008)(52116002)(86362001)(6666004)(478600001)(1076003)(8936002)(66946007)(956004)(7696005)(5660300002)(8676002)(966005)(6486002)(107886003)(38350700002)(38100700002)(186003)(54906003)(4326008)(316002)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NBlkzXMkj7ll0wVQ2rmZ9V89Y0D9CSoPRtJYO2IJFF4oe+JuYAY+cKp6RnkP?=
 =?us-ascii?Q?l77xNsR/TWJct16UJybl7t6SU7ixQraMfF9Sgn1W90DHIX5+K1hD9h+Ulm1D?=
 =?us-ascii?Q?5a6hnsFhKL8MN2imvJDadClKSGKqgt/UIseQxXixV38lJpXIKrtpHNi6FD0B?=
 =?us-ascii?Q?AxdzlOWVEoWTWJLDPaMuCJ7nC4LkKxm+9R6kF3jdlYJqdxCdBuO+WyfE7pU6?=
 =?us-ascii?Q?47Y+Vylv8/dzT7sLuJZyRKeXIkQ93rvy8LAFbt6tmLjX4GFtLm450UTl9rto?=
 =?us-ascii?Q?3/P6MRciwBV4lbC1K38KVJJ+donZ3sJYRJxW5XrRJe3JzjZfswjqFjPRiVtZ?=
 =?us-ascii?Q?5D0DQVKvECOd2m2ZMSo7VNuaNgsNKpjTBXXOatZNyXjDOZtglDWdhOQddysA?=
 =?us-ascii?Q?sRReY6J4sgCpNGtZuXmQASw4qwmtppMt3mw7rnUjvon4TjztIdLoOD8q6By0?=
 =?us-ascii?Q?TU+m47D1pgZsoIZQvxttSe21bUXDwhsjT9aW1X1r5d8FsZaTiYtUM/3dT7CS?=
 =?us-ascii?Q?nS6evzdzZKB1Vz/jado5zZdfvcmYuy8d/3ryowUqyaWyNvYO5VxCybuNJTDa?=
 =?us-ascii?Q?AHeXzezLFtz25c7foo4UXO5cRjMhBDD/ztcwdJjN6ZEmVkT8HzCVQerOKLy1?=
 =?us-ascii?Q?EKov6g3oRSNanrVP1TYrKmQBl6yNSdW+7D3+1wJwk1DNx+UW3+irLK1tbb3q?=
 =?us-ascii?Q?NZGXnGBh56Wew48eP8EaM2YPuyqXzQeV/xpYRnQ/YpvA7luQUkSLlg6NgtbJ?=
 =?us-ascii?Q?y1HTgIwNE4PH8+ZjwHMdyABknL4oJd34B1RCzTEhjR+frp+xUnT9dDgTCTZ+?=
 =?us-ascii?Q?N4n93SftRTf1A968sPjkeys2BbrW2ja3amQSdW8OIPoHVh/DCp0efdA4jSL4?=
 =?us-ascii?Q?EOHekwXyBW6+yLpLOFuHQ/BkfvjVzfoaDLsJ0gVywy2W6XN3fFT4woi1XSyS?=
 =?us-ascii?Q?7kATHGnM9JZmQfJVwiIa4RE2EUqXG2H6Z2dIiv2av+n9eRIrfQeqZ7nhioiT?=
 =?us-ascii?Q?UC4onGVmzC/4ULh3439MhBBJWlUV9TtSz5hR2bgoh+B7Q1gYEMa4l3K9XEhj?=
 =?us-ascii?Q?Mdh9JfHny3LaS6vFV3k9LFKOIsJWR8jQCAV+inNkmS1LS4LFWs9rg8zi3YKz?=
 =?us-ascii?Q?+lo9IDttPrnNAUkf6fhqhQgEwAeD+uP/7tZn6DTtRfCgXLVVz5xa4YB+JbU8?=
 =?us-ascii?Q?2Tv3clD5Y+wBl1Q+wKj2LQm9CngawfTTWecMkkzRL1BvFQwcbcyjCcQkkzUx?=
 =?us-ascii?Q?LbWJ0S7qQhu5xQAkowOLj9jURt43XvrFECYY5yN0TqItdxM9bUt34uyPTZml?=
 =?us-ascii?Q?3cOxZJRV3sAP4/9+Rp18RCbP?=
X-OriginatorOrg: vpitech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27196135-dd4e-4018-4349-08d973b214cb
X-MS-Exchange-CrossTenant-AuthSource: MW2PR07MB3980.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 16:51:34.1153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 130d6264-38b7-4474-a9bf-511ff1224fac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udSBF3Vmq5YNNMT45Vr5mgy/1fho7N0FoJgvkDipyyUjokibFsg1C/7sYeT5+Yjh8g2ARuP/cnshaXEH7NEU0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR07MB8667
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
This is the patch that Curtis sent in 2015,[1] rebased and with support
for effective GID and the new greater-than and less-than operators.
Moreover, the policy_opt enum is now in the same order as the
policy_tokens array, which I'm guessing is the bug that prevented the
patch from being accepted before.

[1] https://sourceforge.net/p/linux-ima/mailman/message/34210250/
---
 Documentation/ABI/testing/ima_policy |   5 +-
 security/integrity/ima/ima_policy.c  | 197 +++++++++++++++++++++++----
 2 files changed, 174 insertions(+), 28 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 5c2798534950..f8e5b5598548 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -23,7 +23,7 @@ Description:
 			  audit | hash | dont_hash
 		  condition:= base | lsm  [option]
 			base:	[[func=] [mask=] [fsmagic=] [fsuuid=] [uid=]
-				[euid=] [fowner=] [fsname=]]
+				[euid=] [gid=] [egid=] [fowner=] [fgroup=] [fsname=]]
 			lsm:	[[subj_user=] [subj_role=] [subj_type=]
 				 [obj_user=] [obj_role=] [obj_type=]]
 			option:	[[appraise_type=]] [template=] [permit_directio]
@@ -40,7 +40,10 @@ Description:
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
index 87b9b71cb820..0f2287699f85 100644
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
@@ -1195,7 +1245,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 			return false;
 
 		if (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_PCR |
-				     IMA_KEYRINGS))
+				     IMA_KEYRINGS | IMA_GID))
 			return false;
 
 		if (ima_rule_contains_lsm_cond(entry))
@@ -1207,7 +1257,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 			return false;
 
 		if (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_PCR |
-				     IMA_LABEL))
+				     IMA_LABEL | IMA_GID))
 			return false;
 
 		if (ima_rule_contains_lsm_cond(entry))
@@ -1276,7 +1326,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	struct audit_buffer *ab;
 	char *from;
 	char *p;
-	bool uid_token;
+	bool eid_token;
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
@@ -1524,8 +1578,41 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
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
+				entry->gid = make_kgid(current_user_ns(), (gid_t)lnum);
+				if (!gid_valid(entry->gid) || (((gid_t)lnum) != lnum))
+					result = -EINVAL;
+				else
+					entry->flags |= eid_token
+					    ? IMA_EGID : IMA_GID;
 			}
 			break;
 		case Opt_fowner_gt:
@@ -1536,8 +1623,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->fowner_op = &uid_lt;
 			fallthrough;
 		case Opt_fowner_eq:
-			ima_log_string_op(ab, "fowner", args[0].from,
-					  entry->fowner_op);
+			ima_log_string_op(ab, "fowner", args[0].from, token);
 
 			if (uid_valid(entry->fowner)) {
 				result = -EINVAL;
@@ -1553,6 +1639,30 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
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
+				entry->fgroup = make_kgid(current_user_ns(), (gid_t)lnum);
+				if (!gid_valid(entry->fgroup) || (((gid_t)lnum) != lnum))
+					result = -EINVAL;
+				else
+					entry->flags |= IMA_FGROUP;
+			}
+			break;
 		case Opt_obj_user:
 			ima_log_string(ab, "obj_user", args[0].from);
 			result = ima_lsm_rule_init(entry, args,
@@ -1936,6 +2046,28 @@ int ima_policy_show(struct seq_file *m, void *v)
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
@@ -1947,6 +2079,17 @@ int ima_policy_show(struct seq_file *m, void *v)
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

