Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6BC5412A18
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Sep 2021 02:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344061AbhIUAvW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Sep 2021 20:51:22 -0400
Received: from mail-bn1nam07on2063.outbound.protection.outlook.com ([40.107.212.63]:26025
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233453AbhIUAtW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Sep 2021 20:49:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XK4KYd6UB/+WWyQ8rpcMa138va7dYofAkLPMfS5P/7PoljcIV3rYXMUE1qVVaY06toemHDG8oRrA6/dNHsenO3Fgk5MlTdK21RPXOjdqxEU9KAM2GJLlkDzT/zYlCvpdYDG3eR+HYqGkYG/WQUV7N7g3MhsFGjH7ItFSlmM4FL6KVVFBWC4IVIj3tdDc990i7wsnGfoBBrhJWkemlBt+IqGoPMMYs1pgmWHxeuvWYeOfWMSSMQtREiraZio6lRRTljhDJifeVhOx9Mk0LIylLqHQPSb8duEmv15mrZKqFuZBc5ggnNzoRjf+Oy+cCYC58LmXtAgD3pus+rld1fB/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=94+usKn4g49TnEjBKT4BXod0UFimzkXERUq4i/vApW0=;
 b=kpSZFxLIYahj3pvH4ZkyTJCesyVQUeTWDxmyWmchpW57jvZ6o+7czG8+KMBLp0Mp29vYFjH4Q+VAaeyJKqfkJoEUhYaRnfF9X91gtFGtJ/WmzENfxkBrKKAWfjkldBeqYHd9ZP1cALVK7O8PqSEsWnHsYJVlmhphieFLaEd0R+mq2Gb+dMLRKqMRRF3aQ+To2ZnP20eBNmPz5mtuOeh+EnudUCDpwQG228SM+fnsBG9ckTil56S1mVn1TfShkYu6kccDA4xiA0Mx35bsue3dV52HsW37hgh5Nfib+UODspqp/PNQyH78RY6FBYP2q3JInROZIxerWxEwKnmPCDVQQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vpitech.com; dmarc=pass action=none header.from=vpitech.com;
 dkim=pass header.d=vpitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vpitech.onmicrosoft.com; s=selector2-vpitech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94+usKn4g49TnEjBKT4BXod0UFimzkXERUq4i/vApW0=;
 b=XsjG58L8a0NWdUjB9GYk83gmOiK7enmu040+mnSFVcfWU3hJ54qkOAYq8EjuNI5cOqL8DC512isgCfyoukvq242+ET3NgYYTSU0twbEhiTaOG1Lm2uSSaBoBLuGBmPq/DCEjqHV3VVc+zDORpgVZGsm1jpncNEgzP+6hJN5nUZw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=vpitech.com;
Received: from MW2PR07MB3980.namprd07.prod.outlook.com (2603:10b6:907:a::32)
 by MW2PR07MB3977.namprd07.prod.outlook.com (2603:10b6:907:5::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Tue, 21 Sep
 2021 00:47:51 +0000
Received: from MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014]) by MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014%4]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 00:47:51 +0000
From:   Alex Henrie <alexh@vpitech.com>
To:     linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        zohar@linux.ibm.com, pvorel@suse.cz, alexhenrie24@gmail.com
Cc:     Alex Henrie <alexh@vpitech.com>
Subject: [PATCH ltp v4 2/3] IMA: Move ima_check to ima_setup.sh
Date:   Mon, 20 Sep 2021 18:41:39 -0600
Message-Id: <20210921004140.15041-2-alexh@vpitech.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921004140.15041-1-alexh@vpitech.com>
References: <20210921004140.15041-1-alexh@vpitech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY4PR16CA0008.namprd16.prod.outlook.com
 (2603:10b6:903:102::18) To MW2PR07MB3980.namprd07.prod.outlook.com
 (2603:10b6:907:a::32)
MIME-Version: 1.0
Received: from demeter.localdomain (66.60.105.30) by CY4PR16CA0008.namprd16.prod.outlook.com (2603:10b6:903:102::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 00:47:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a88f12b0-705c-4b9d-e798-08d97c997083
X-MS-TrafficTypeDiagnostic: MW2PR07MB3977:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR07MB397760C61AADB5D5DE866494B8A19@MW2PR07MB3977.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q90fr3/zppLSySFIxRcd9mBc8aG4d9W9KU+qNCs5Z2vOwl96ybSfEXvrYn5Y21eC3CbQlJ/EhDmqhq2f751tR9N/+5Amew/44Neo8KmeFw9Rrz8rfLJRc75qq4Un9X933DB+OqqhBNvotVSlwYWw0lXs3PGw+0noalM+yVRc8s3UYAmX0248mE/ExWyHFmkAGIViegWUU6pRvYj6arebwIfn0ik0Q7YlbEbSniFtKzLvtxdjr5zQWuILYK8rdss2iDwbRo5ez1HmOKX67FI2VVhedAdlda5u9OhBQLAFYeEp0XYLIdZDhtSs9LfWoeTZ34AtdA7Lzncd7PwXEzOa33KRr3y/x6oQAhgW/RnSE8WWsm715Z8a0MwCCEybZtPtpOf/cOeAKhjg6wI0GBmUrcXEEaYm33pzbrYw+UdefmCxaRL/6Zg/j5vfvBsNtgqrpIMoFwJEKOnXmPnf1R39HW7atDOjvBcqS3LNjwBU6xnPwRl+MHbuljzM7Yqt/YxyQQALZI8eBylTtGuifO70b3fps2A1dYaqutgOQeamPlmZ9QIRxqaYB3lFCtzd4tPxPHEiXVbfnYRn/FEoqOAS+2kcdjAS78QrC5X/l7fS3kwRnmjidGRMupCJS3G+Z0x4caWleV9OrvoO6HuOv/jVl4d1jV32nMC9EwOsJH0EByFqQNjs7vjo1+JPhxvgnPNy3JAkRCP64ONtFZTde5QDAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR07MB3980.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(346002)(366004)(39840400004)(66476007)(66556008)(8936002)(66946007)(83380400001)(316002)(26005)(2616005)(52116002)(956004)(107886003)(6486002)(38100700002)(6512007)(508600001)(38350700002)(186003)(8676002)(6666004)(4326008)(1076003)(5660300002)(6506007)(36756003)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?liyxJRd4VeiEmmTO00/3rdLZ6P2dFy8vLnM0fHAjSJ8QI4sinMP2avISxDaw?=
 =?us-ascii?Q?FyBrcyF4CPT7mKeXDfnzPw9ObDa4TepqnPywphfQq4bEWodSfps66GFX71EG?=
 =?us-ascii?Q?dAb6I23uq7iGeiO1gJAImNoX46cG8Uxip43Ynmnz95zps/t89WkcXMAXZh6J?=
 =?us-ascii?Q?xmp0akMzFUTx5RAkfzLu4suq8gcL1tsbhA+u3ppJpRaKIYfUJA0KCwu1P5pK?=
 =?us-ascii?Q?sbYJTmy/rpNmFGef/Me9MbI0dJvVh1lGsxxN1OxMAL83/K0pEnuI+bmqyyjN?=
 =?us-ascii?Q?0rCJxIbnsl8W483LmQRwGNjcGK/6+OZdcn3MdP0VymnLtaywXrq1mor9QmdJ?=
 =?us-ascii?Q?Q4UnKtmP2l+saaVcHGhyoqB3hNu7yrsFzAkHm8rV3XmgZIOLWtzpfKSiIOuO?=
 =?us-ascii?Q?Y1VT3YtxFURA0onF/l3ujc1Zvjc3pPiMDtf/rr/X+3hmpw8pA6Jwv1+yZ9t2?=
 =?us-ascii?Q?vDF1FuVd4F7yocfDDsFpshy/1m0bWBaj4oupXUTNh+uiylBmTlliORKorPvw?=
 =?us-ascii?Q?3jBLsRGB8XmEfUW6WIgBzbYne/v4ndanJ31G7j2u8q9XxMNmb2rziO4bZMRH?=
 =?us-ascii?Q?zEoUGYCMaOuUsZ2BNAoeD5QHfeIgJ1UX431skSTwpBxLQkmFK3q0i3SIHlhb?=
 =?us-ascii?Q?XlHWeAb2/uX0J4RndrDdeHwdJKfk+y8dmkquGjfW2mnqwh9sM6VXaqO2pAjp?=
 =?us-ascii?Q?4HGJqjpkgYHYqygIuGMLj6Rvu3F06KoOmlD/DPNPeSCgGJLLF3H62UXdvchO?=
 =?us-ascii?Q?Owk72rz9dBYng0KxdcxymfprjLUj9eivdKOCCz7nHFVKjyP/Kz/YK16Q0Cbu?=
 =?us-ascii?Q?dTBHDMpPU3rUgMLVpNz7bw6dsro7B3jVBJEc7QR+qE70sHuDqAmtL46mD3bD?=
 =?us-ascii?Q?WN0jEo+1Ev0RplWBsZfX7TwOS6ssSUCOJowUrr3Xn3l29zfm1r6sXl7I6zQB?=
 =?us-ascii?Q?G5nNHo1IPQilvI5bPjN97lYVoNCyelvRik/2fkscmKR6DXyrn3OaEy+zGCE+?=
 =?us-ascii?Q?27I3CxXSqeUpp5ZLjNXdTW2c+sGxgmPduayIJbD0XICIs7urazYBccO1wCeT?=
 =?us-ascii?Q?W/amLolNlnwBdBED4YK5nnS9cYjSRsXTThl1h8XAWeWHC5JiWX/t6jfBD33H?=
 =?us-ascii?Q?cay4BaPQpPOPiZ4svSxCKnclFokBtyoueVRlnJ906RkNO2bK4219SjNpQuux?=
 =?us-ascii?Q?xffKPYYC6uE/4i16kVR34soJAkHVY0gVu8XZ/TiVp8E68nreQ7J4Z2YkByOH?=
 =?us-ascii?Q?9GmPwCu8nLCXX8ERQVbR8B/vDBkCnygZAmuq24bgzgrbIv25Sgqcd/gm8uwD?=
 =?us-ascii?Q?c4fN15B2c0LELrhwr+ONiX5e?=
X-OriginatorOrg: vpitech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a88f12b0-705c-4b9d-e798-08d97c997083
X-MS-Exchange-CrossTenant-AuthSource: MW2PR07MB3980.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 00:47:51.2157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 130d6264-38b7-4474-a9bf-511ff1224fac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ox6LYq08DS/RuJ+7eMpWWnToQV4VDdGvUCS8k9m8UzKqzpiXFxFpB/la6LyzMGUEVkhS00WrgVhwtryf5bPtVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR07MB3977
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Signed-off-by: Alex Henrie <alexh@vpitech.com>
---
 .../integrity/ima/tests/ima_measurements.sh   | 28 -------------------
 .../security/integrity/ima/tests/ima_setup.sh | 28 +++++++++++++++++++
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index 1927e937c..807c5f57b 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -17,38 +17,10 @@ setup()
 {
 	require_ima_policy_cmdline "tcb"
 
-	TEST_FILE="$PWD/test.txt"
 	POLICY="$IMA_DIR/policy"
 	[ -f "$POLICY" ] || tst_res TINFO "not using default policy"
 }
 
-ima_check()
-{
-	local algorithm digest expected_digest line tmp
-
-	# need to read file to get updated $ASCII_MEASUREMENTS
-	cat $TEST_FILE > /dev/null
-
-	line="$(grep $TEST_FILE $ASCII_MEASUREMENTS | tail -1)"
-
-	if tmp=$(get_algorithm_digest "$line"); then
-		algorithm=$(echo "$tmp" | cut -d'|' -f1)
-		digest=$(echo "$tmp" | cut -d'|' -f2)
-	else
-		tst_res TBROK "failed to get algorithm/digest for '$TEST_FILE': $tmp"
-	fi
-
-	tst_res TINFO "computing digest for $algorithm algorithm"
-	expected_digest="$(compute_digest $algorithm $TEST_FILE)" || \
-		tst_brk TCONF "cannot compute digest for $algorithm algorithm"
-
-	if [ "$digest" = "$expected_digest" ]; then
-		tst_res TPASS "correct digest found"
-	else
-		tst_res TFAIL "digest not found"
-	fi
-}
-
 check_iversion_support()
 {
 	local device mount fs
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 9c25d634d..976c6a86c 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -188,6 +188,7 @@ ima_setup()
 	if [ "$TST_NEEDS_DEVICE" = 1 ]; then
 		tst_res TINFO "\$TMPDIR is on tmpfs => run on loop device"
 		mount_loop_device
+		TEST_FILE="$PWD/test.txt"
 	fi
 
 	[ -n "$TST_SETUP_CALLER" ] && $TST_SETUP_CALLER
@@ -279,6 +280,33 @@ get_algorithm_digest()
 	echo "$algorithm|$digest"
 }
 
+ima_check()
+{
+	local algorithm digest expected_digest line tmp
+
+	# need to read file to get updated $ASCII_MEASUREMENTS
+	cat $TEST_FILE > /dev/null
+
+	line="$(grep $TEST_FILE $ASCII_MEASUREMENTS | tail -1)"
+
+	if tmp=$(get_algorithm_digest "$line"); then
+		algorithm=$(echo "$tmp" | cut -d'|' -f1)
+		digest=$(echo "$tmp" | cut -d'|' -f2)
+	else
+		tst_res TBROK "failed to get algorithm/digest for '$TEST_FILE': $tmp"
+	fi
+
+	tst_res TINFO "computing digest for $algorithm algorithm"
+	expected_digest="$(compute_digest $algorithm $TEST_FILE)" || \
+		tst_brk TCONF "cannot compute digest for $algorithm algorithm"
+
+	if [ "$digest" = "$expected_digest" ]; then
+		tst_res TPASS "correct digest found"
+	else
+		tst_res TFAIL "digest not found"
+	fi
+}
+
 # check_evmctl REQUIRED_TPM_VERSION
 # return: 0: evmctl is new enough, 1: version older than required (or version < v0.9)
 check_evmctl()
-- 
2.33.0

