Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F74D3BA5F0
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Jul 2021 00:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhGBWZW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Jul 2021 18:25:22 -0400
Received: from mail-dm6nam12on2045.outbound.protection.outlook.com ([40.107.243.45]:48922
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229917AbhGBWZW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Jul 2021 18:25:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIk/0h38kDb5c/vEIXtxFR732E89dUCluGaOGozMeFdMPW0h/RKOaiNfOugaSXA1nO8dQS/Q9XABZPAFBP7nVN1gyQxas9V/yuz1fySKTz6bCt7hwq+PImrVkN4bg+DlEDda/usyGC7yeww7KTarXM+QhPUhR57G1ACXeL1u7ApBqa508EJ21pxPvtH7jRkCeCfk9tuhKiTRt/9qho6iYfYzuYbSu4y7KP2xZ6v5wv9wpW5qIEGamOtDuftjTbSd9VqMhUt7brhPrR2inwwNQLdgX6EpOHNlJe8Z2/ig84cQZYGKzTYGwSh9bFkLbjMH7/OjrDNEkoKmeNNCMsDxIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiOWEZq978tboaZS7tNdOJ9RTpM5Yz5WjN9GNLb3bCA=;
 b=eS0QzfAxMMxdRJGGom0wmbG/xoJdY0ErOgWHFbF7paW6so225MYjATtsencca8lmv7yOKLHlSfsBAawUUnnu1d6voFThnloCwVzsM4QXRZDymN4OygPP/zVQ10yN4+Qt8rYAYu59PNcStzaGiIyFpQGVYg18qouD9AfNWAADfahHeJcKhUI+8XLDggmjN6DOaeIGfVy+vV6B+3A/oifrblBs0EXVtQTXTUDipGvyCI+4CMnvhvQuOGRfc+i3iEB3yONLtAOcyNfNVeHYAgjQSVg1mI1aRUUg9URev4BIc3pYdyYgud5RpMFfcjd2Vlg/eaB1Xeuz/BzmyqHeTshQPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vpitech.com; dmarc=pass action=none header.from=vpitech.com;
 dkim=pass header.d=vpitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vpitech.onmicrosoft.com; s=selector2-vpitech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiOWEZq978tboaZS7tNdOJ9RTpM5Yz5WjN9GNLb3bCA=;
 b=Y4erXaYZo74mYTDMhTtGpurPvp0l7eUmfD4NhfqmMR0KTPBDLu0kmWQjmro3SVleQqUyJm0EZwlNrcm/gxNa0xF0ym0yx57lm/vONuaSJHSYWc9vN6RJiVGP6buLxy7adUzEvMrGrxv3aCkQ99zT+UgAt6KvVu3S1nsZFaLrDB4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=vpitech.com;
Received: from MW2PR07MB3980.namprd07.prod.outlook.com (2603:10b6:907:a::32)
 by MW2PR07MB3978.namprd07.prod.outlook.com (2603:10b6:907:b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.24; Fri, 2 Jul
 2021 22:22:46 +0000
Received: from MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::71c9:db8e:2292:3ebf]) by MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::71c9:db8e:2292:3ebf%6]) with mapi id 15.20.4287.026; Fri, 2 Jul 2021
 22:22:46 +0000
From:   Alex Henrie <alexh@vpitech.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        alexhenrie24@gmail.com
Cc:     Curtis Veit <veit@vpieng.com>, Alex Henrie <alexh@vpitech.com>
Subject: [PATCH] ima: add gid support
Date:   Fri,  2 Jul 2021 16:20:27 -0600
Message-Id: <20210702222027.13973-1-alexh@vpitech.com>
X-Mailer: git-send-email 2.32.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [66.60.105.30]
X-ClientProxiedBy: CY4PR16CA0033.namprd16.prod.outlook.com
 (2603:10b6:910:60::20) To MW2PR07MB3980.namprd07.prod.outlook.com
 (2603:10b6:907:a::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from demeter.ad.vpitech.com (66.60.105.30) by CY4PR16CA0033.namprd16.prod.outlook.com (2603:10b6:910:60::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21 via Frontend Transport; Fri, 2 Jul 2021 22:22:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bf92c27-6893-4db2-0618-08d93da7eb12
X-MS-TrafficTypeDiagnostic: MW2PR07MB3978:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR07MB39782D0655360014394DBED2B81F9@MW2PR07MB3978.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rCaGHiG5Tihc7kFj4THHoWV/AtYeK+ckL//+9ct3DUQBYbhP7/9qXYt4JOIAYXd7nSQB+AaZUL0PjuyCvu8SvKRp7qz8HX2oY3mUfFuVe2c4721iLqnwaV+zmROCV7Axl9448Myklp+uSUZM0mLmhT9PNEW/50i7ZaKcM0GRL/oafIWrmUpeKeF4p5cw0b8bxzVOYrZXCHbMIzPWw5gVip39OUvfzrxNjp0JtreITJeNzhJXeoP2DEHytOIAKtz+1eOLHV6bua4NKeivxFbX9s4TUNQ12Bv/R8UngTPn5J69JdPpu+0fT/TsBXCfYpgTd+12qgfnOXDXp7IiApDhdltwehQk8OPlpBRQdfypOSgZtePer6yLRDrAmNhr8CIdjMieqPn7xZnm9SkfxJmK5johlOXoDZIM9rDK/C+fXnOCm0Opuf3a+s5NvpWi6e5sV2iJxhoBl7D9NpYCo7Y+6EKTXaEI2a/5bWfRtW0rRPx+Iv1S26E2Ek13h47O7Pyb/wWAcTkeXEXQ21uFyuTvXOhYTPG1ZpWBW00GYB/xf7yhpoqB9fG26mRhkZOaj5RJ7+02PnRkfQWFvZl41BH0zSJYNDrsRTobHVokR391xBFcJsQRR0FdJeLrCHMvcDWqrBqYWN+TVcZSwVACtDQNOcVX3bbSi9gSFU6AZV3vxIVuNWRseQWqkhBCc4mxJIFB5bDU3GMjdiulKI+IFcwnyRXM6WDbary3fwMoIF6PW3BWmJ0ZhMofXLKqL1ovsCGXHqP2yh7k1qPLFtq1eGk9bTxoJJumyEvKT6cTk81G9vo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR07MB3980.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(346002)(366004)(39830400003)(66476007)(7696005)(186003)(66946007)(2616005)(2906002)(16526019)(6486002)(52116002)(66556008)(4326008)(1076003)(107886003)(26005)(6666004)(5660300002)(316002)(54906003)(83380400001)(38350700002)(966005)(478600001)(38100700002)(956004)(8936002)(36756003)(8676002)(30864003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7l7yAewaP8dmvHAnP8EYZJXuBn93zv9JAs92e8M26rgSUeElLXv2OpnWQr6X?=
 =?us-ascii?Q?IiPyrRcWsNHpdYZ6TYOMJFQbdSOlvoBNlwlG7yRq/Rs6c4f3x2vq+8LrFuWy?=
 =?us-ascii?Q?GufuaomV03Ybr1i9/5CKUgIUhOg68i+8vYyhAwcr/Tv1DwqM0NTiw8PveA1T?=
 =?us-ascii?Q?K9Olj7AvVjKLuzO0SzUBeXmqi0ce/Gq5AfqfWAlTtMHCrB80WLRUM+cPMP7h?=
 =?us-ascii?Q?Xa0Ui3MhHF6zvUfnbODlnPc89Vutph5D1ZfbOIwZweW7fMA+T9cXWsYxlQ9e?=
 =?us-ascii?Q?i/H+VJSlTElhYhqCNdvgJeQ7mKjCqxBLeYd3cjLqIBiLu+p8xPW6My9O6wIg?=
 =?us-ascii?Q?aff04iI+cO2nZUZerUqVeSZgIDnpgAkLyGsWbz+dsfxalGnwFAjiLnw/2ZiH?=
 =?us-ascii?Q?/BcEFjQ8moCEifhAfcX1MFlkUbP6E7jUqwQFZynrXyF0sVMqdJpCQjor7ouA?=
 =?us-ascii?Q?ZexeUs9GB3TMu0GTAFK3MbqyUswxnTegURE8Y7G2Obyo6H5K3aICo9a+Fr83?=
 =?us-ascii?Q?CVG9rpFRV/kqRpv0RZk7PoaikDs06bgbgAsb9RfktJrUPNmGmo+Dt+y6WPex?=
 =?us-ascii?Q?G/8oR0Hpt7SGa8caBDB9oagy5REEa2BxTBA7iE+Ji0s+csqE3MwNztY4tKCp?=
 =?us-ascii?Q?hBk5xKiO39s6aRzSP8C9GEr9V5JpkyKG1nCUYXu4euM8/yyfRIup9jaj41LX?=
 =?us-ascii?Q?x3zM1trHTyPJ/w8osOQHfDPnZct8iJe0Nz/wSFL1Ve+gz9364fxGQhNznkBB?=
 =?us-ascii?Q?94sv8egXKLvDoj12CxCUnKBJqRdDQNVXUl9dOcxLJqXq1ldDEvbayOa8Op4A?=
 =?us-ascii?Q?dXPCL2rrnnmYR6AYb0gUmhdHg4c/kqT2jCXx6T9dL7yzb/+ycJRkfFmy4JSh?=
 =?us-ascii?Q?iS7nFfB4L+xLNPFs9wVw+D09/f3QtBEyo2AsCh4DW07MgSRlIVidobtnhrf2?=
 =?us-ascii?Q?R3xOofrEvBJSbcf1RUTx2m0lsSJMLSZuxj1YII0w5qLmK21BRFKQYI1rTYfD?=
 =?us-ascii?Q?lkq3YRyXQGz0NDfK/j1CykyAeqoIurOFpNqvdwn9ivuY5X0ti5RVT4PuRrCn?=
 =?us-ascii?Q?GXPJJtRiVo0uQb+iNplAEebrerIyarwn4bKDSm+NPemIdfG/NU1NSePceTTm?=
 =?us-ascii?Q?8k9wWf+M3DUTTLQ14n4gV+qy3MTqIPgCnJ6HkdjztmBADtLwr7CvyLykJZbj?=
 =?us-ascii?Q?kY559YW85OT4gL+WIszdSgCXdMPTYk43iR2hygIn1Z1vadpXLZG5+5OwtFrc?=
 =?us-ascii?Q?Lxw0jYD54ZFXOg7UtuUDB/CXC3ZTMuQzOk+M+Hf08UiEKsjLZCGoQ8rwseJl?=
 =?us-ascii?Q?1FA4dIHk73ah7EaL9O4RXGIf?=
X-OriginatorOrg: vpitech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf92c27-6893-4db2-0618-08d93da7eb12
X-MS-Exchange-CrossTenant-AuthSource: MW2PR07MB3980.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2021 22:22:46.4084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 130d6264-38b7-4474-a9bf-511ff1224fac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6DQl7DmMRJTAT8Lg8QgbHk0+h3qbbJf6TBCBxi4KYI1G88byRBF3jwrGAawWsdPIpPV2E78RcTnzmd4339HJWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR07MB3978
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
index 070779e8d836..28f2a5948bdd 100644
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
@@ -39,7 +39,10 @@ Description:
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
index fd5d46e511f1..9f8ac5c34baf 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -35,6 +35,9 @@
 #define IMA_FSNAME	0x0200
 #define IMA_KEYRINGS	0x0400
 #define IMA_LABEL	0x0800
+#define IMA_GID		0x1000
+#define IMA_EGID	0x2000
+#define IMA_FGROUP	0x4000
 
 #define UNKNOWN		0
 #define MEASURE		0x0001	/* same as IMA_MEASURE */
@@ -75,9 +78,13 @@ struct ima_rule_entry {
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
 	struct {
 		void *rule;	/* LSM file metadata specific */
@@ -92,7 +99,8 @@ struct ima_rule_entry {
 
 /*
  * Without LSM specific knowledge, the default policy can only be
- * written in terms of .action, .func, .mask, .fsmagic, .uid, and .fowner
+ * written in terms of .action, .func, .mask, .fsmagic, .uid, .gid,
+ * .fowner, and .fgroup
  */
 
 /*
@@ -570,10 +578,23 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
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
@@ -936,16 +957,19 @@ void ima_update_policy(void)
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
 	Opt_appraise_type, Opt_appraise_flag,
 	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
 	Opt_label, Opt_err
@@ -972,13 +996,22 @@ static const match_table_t policy_tokens = {
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
 	{Opt_permit_directio, "permit_directio"},
@@ -1021,22 +1054,36 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
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
@@ -1110,7 +1157,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 		if (entry->flags & ~(IMA_FUNC | IMA_MASK | IMA_FSMAGIC |
 				     IMA_UID | IMA_FOWNER | IMA_FSUUID |
 				     IMA_INMASK | IMA_EUID | IMA_PCR |
-				     IMA_FSNAME | IMA_DIGSIG_REQUIRED |
+				     IMA_FSNAME | IMA_GID | IMA_EGID |
+				     IMA_FGROUP | IMA_DIGSIG_REQUIRED |
 				     IMA_PERMIT_DIRECTIO))
 			return false;
 
@@ -1121,7 +1169,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 		if (entry->flags & ~(IMA_FUNC | IMA_MASK | IMA_FSMAGIC |
 				     IMA_UID | IMA_FOWNER | IMA_FSUUID |
 				     IMA_INMASK | IMA_EUID | IMA_PCR |
-				     IMA_FSNAME | IMA_DIGSIG_REQUIRED |
+				     IMA_FSNAME | IMA_GID | IMA_EGID |
+				     IMA_FGROUP | IMA_DIGSIG_REQUIRED |
 				     IMA_PERMIT_DIRECTIO | IMA_MODSIG_ALLOWED |
 				     IMA_CHECK_BLACKLIST))
 			return false;
@@ -1133,7 +1182,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 
 		if (entry->flags & ~(IMA_FUNC | IMA_FSMAGIC | IMA_UID |
 				     IMA_FOWNER | IMA_FSUUID | IMA_EUID |
-				     IMA_PCR | IMA_FSNAME))
+				     IMA_PCR | IMA_FSNAME | IMA_GID | IMA_EGID |
+				     IMA_FGROUP))
 			return false;
 
 		break;
@@ -1142,7 +1192,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 			return false;
 
 		if (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_PCR |
-				     IMA_KEYRINGS))
+				     IMA_KEYRINGS | IMA_GID))
 			return false;
 
 		if (ima_rule_contains_lsm_cond(entry))
@@ -1154,7 +1204,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 			return false;
 
 		if (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_PCR |
-				     IMA_LABEL))
+				     IMA_LABEL | IMA_GID))
 			return false;
 
 		if (ima_rule_contains_lsm_cond(entry))
@@ -1178,7 +1228,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	struct audit_buffer *ab;
 	char *from;
 	char *p;
-	bool uid_token;
+	bool eid_token;
 	struct ima_template_desc *template_desc;
 	int result = 0;
 
@@ -1186,9 +1236,13 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
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
@@ -1404,12 +1458,12 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
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
@@ -1424,8 +1478,41 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
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
@@ -1436,8 +1523,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->fowner_op = &uid_lt;
 			fallthrough;
 		case Opt_fowner_eq:
-			ima_log_string_op(ab, "fowner", args[0].from,
-					  entry->fowner_op);
+			ima_log_string_op(ab, "fowner", args[0].from, token);
 
 			if (uid_valid(entry->fowner)) {
 				result = -EINVAL;
@@ -1453,6 +1539,30 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
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
@@ -1800,6 +1910,28 @@ int ima_policy_show(struct seq_file *m, void *v)
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
@@ -1811,6 +1943,17 @@ int ima_policy_show(struct seq_file *m, void *v)
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
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		if (entry->lsm[i].rule) {
 			switch (i) {
-- 
2.32.0

