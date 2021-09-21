Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7A5412A17
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Sep 2021 02:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344013AbhIUAvU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Sep 2021 20:51:20 -0400
Received: from mail-mw2nam12on2055.outbound.protection.outlook.com ([40.107.244.55]:33729
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233451AbhIUAtU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Sep 2021 20:49:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEeXCgfhlKyk5ClZ0TIjsBLSJeyL40xrLRXpsEq+hw/eUu/35dd+b3+SBQpsikgc8A2Gy8atlSaKReNRFuM0GBQVJ6nOa2lHbSaSq7jWS1KoQRqvyQLXpGN1obTcwJ3cps2zJdkwFroLRkWIRSA++tm9LEw05zEp5l0uknV8fAwSGTKLpi+z0+SpzjjReD7A+ty+/EyJHvY4raEgy3dl/wgFc1V5yQvtAzISX3wy1AIWn/hQfJCehk0kQ642H6pCjtekSl2dYJhUo+KViML5oZw3ofpWnBRZDJAE0Sb+JQAx6WvL6Mvnhdu0dGSEWyN1A6JhD9aGFkcXx+uOKvfRcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=zMxu75s0OhBb/Yj7WUME2AQQ2gmO12Nyk27SSpLlHuk=;
 b=YX0WgQ5UXjXqCfrnDeNrghXB4LkHydeNL6OmBwXEVia6gaS27NZKd28nEIE7IyG9o37eB2d8hcSMT6E4uz7WHqyOv8HjUJalA8gp638fK1qfilLhvxl99KOdY5jbbIsM9skucb5kkSuHdoUWWuXtNhHY0Xmz90pEn0LCgrsgcO744qYIfcpQNp4wj/AJ14gvJVc7wS6E5nNG0LJJaGejyHEoOxtLX44lfdqgK8NKe/ZQZ7zSMkerAzKtCwTVP85rYPt6Xev0FRqndzX0vwTAWLVDQ3KoCqIpmC05CFURn2L2cwjJFvLZ9K9G56ctyXxmnFoNn44EIRp3JKF0kJ/THw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vpitech.com; dmarc=pass action=none header.from=vpitech.com;
 dkim=pass header.d=vpitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vpitech.onmicrosoft.com; s=selector2-vpitech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMxu75s0OhBb/Yj7WUME2AQQ2gmO12Nyk27SSpLlHuk=;
 b=KXhP/acd/glxdodOhswOOxiXCxZHaW+H2GfByxuyLVC5jxt+u0s28dgs1wcWUw2DgHNfKux2gx1OGm+eZVvJ8iVqvMD5vAxpgYA8Iocx/PaUCx51wN2GiY3d3vMuKD+V9JdfOvo0SYV4KQGKWnBfPoJ7H8alUiVVqKTGpkO4//Y=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=vpitech.com;
Received: from MW2PR07MB3980.namprd07.prod.outlook.com (2603:10b6:907:a::32)
 by MW4PR07MB8666.namprd07.prod.outlook.com (2603:10b6:303:103::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 00:47:51 +0000
Received: from MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014]) by MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014%4]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 00:47:50 +0000
From:   Alex Henrie <alexh@vpitech.com>
To:     linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        zohar@linux.ibm.com, pvorel@suse.cz, alexhenrie24@gmail.com
Cc:     Alex Henrie <alexh@vpitech.com>
Subject: [PATCH ltp v4 1/3] IMA: Move check_policy_writable to ima_setup.sh and rename it
Date:   Mon, 20 Sep 2021 18:41:38 -0600
Message-Id: <20210921004140.15041-1-alexh@vpitech.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY4PR16CA0008.namprd16.prod.outlook.com
 (2603:10b6:903:102::18) To MW2PR07MB3980.namprd07.prod.outlook.com
 (2603:10b6:907:a::32)
MIME-Version: 1.0
Received: from demeter.localdomain (66.60.105.30) by CY4PR16CA0008.namprd16.prod.outlook.com (2603:10b6:903:102::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 00:47:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 129b5346-4465-4638-f901-08d97c99700a
X-MS-TrafficTypeDiagnostic: MW4PR07MB8666:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW4PR07MB8666FE8AEB6541D9491B7504B8A19@MW4PR07MB8666.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vj8eUIq9CC/NR2CTMvAB3mCJChBz/4GhcOaQ26fKkzcbwsII6mVbNTPou4uj88NjnljFg5ciCkYM+6xMbMlxRr6dsvU0KLaWM+Abh9wLREo2ZJzZe1i53Vj6VVk2WHG4lhcPny+H1CJEukTZqVn/6VRZeq1rpbtMUOHBhIxhlKuaMelfK7PE+DmOa4KlKpnTpprM68415ofHk5t8svGdn4LJtCEFLoVk8nr5dX1SOA/z6tniKeyOywTMK/nLrYQsDnN7oh9mhf+3hoXvpFdfJUrbX3cMHM9Dky9frap2cMTL0D1p3X4rzzEBaRW9lPPy9ZkVJ0r3anTTouu8IwmEVOzvfP0lrTd8yQ4tDfvAp8lFWCjXqGUKaME9QMqqpIUdyqXtV5qQ4q0IRJvq3Tix5lXcOIKKUBIMNuDs7+ymhSH509QUnuHSBPqESPmx9keGycgjaPcukVOFqPiaHgBpM1fL/WP3LpJuuFf5CcVQ87nHeuzW0cV7ndLuqJav0t3S3AfXb++XUFa42OsQ/h+AGBUfyZHJ+Vumciboy1eizTJYDfSdR+jAU+ICpBiinxh3dI5mB1z3wRkt1Fj6PlYAC9X/qlQTwXbieLCLnKamoTBozicuv2Gx+DyLhzh2uiGqdt4oTV/Hf6bEoTSKLsWj/2650JF3HcY8mmohb+A1uipxRAUkQxSqg+X3/QKQuVWcH75h17kPGWgX/BXlTOAC4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR07MB3980.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39840400004)(396003)(346002)(376002)(6486002)(1076003)(4326008)(36756003)(38350700002)(38100700002)(86362001)(5660300002)(6506007)(316002)(508600001)(52116002)(66946007)(66556008)(66476007)(6512007)(186003)(2906002)(8676002)(83380400001)(8936002)(26005)(6666004)(2616005)(107886003)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jb/PMe9wEIAHstVrNqUHWN6+CCrYE27mK/QGj/jGlbWS3L2zrKB9yrNLYq7d?=
 =?us-ascii?Q?ScSebIoW5bPPhZsfBVRiLD3B5QRHGC+DpfPn0XU8yWrwUZqeP4RqWZwJFRK7?=
 =?us-ascii?Q?olcdp1YJx1FI4pJ2RxKJHCLVYl0fip1bKZQrHfUWoy9BXOi5BMwMk2Aaq2dz?=
 =?us-ascii?Q?ORn1Gy5SqpX2/gB2+HDKLj8NmArcGgbezP3JOGw5F9j9iPSLaeaM4/W+CoKN?=
 =?us-ascii?Q?a8Nd/JUA5Krb0cy0WRbKVSr8arhz7p5nDPvswa/SIWh7gRpggDi2MdKfhAxF?=
 =?us-ascii?Q?0jknloYONmbu98pXJ0tb8Nz/ADTqOxtDOBaYTNNgSdqf4AjSpYMyQxF1X3zG?=
 =?us-ascii?Q?aFSP1sqweOpqqzzP3d828HpAtJUDLGkrVYJhma+Lvy0DtJWE8Df79Yisyf3j?=
 =?us-ascii?Q?PFdIl61FOdP9Q6rqP7GiVfDeCOgG99CAKzOVFixxfMrLxIfDAwkNF7s3s7jl?=
 =?us-ascii?Q?MrzAFSxZ9F32FcxQyIw9BEkFEXt3As9ntrzkOIfkYD//OtCAYQGP4/oGxC8z?=
 =?us-ascii?Q?HiSzC0TK+bf+NrMbPMiV1rwOV5STypKQZ/q+ZrwoO3BQd/+fxqV4E1x/QDgZ?=
 =?us-ascii?Q?mAZi8ovT8bfFSl8tJ2xCWie2Uk/cX8bllzu3es4d8I4SqBKVr4NDpqvDuXFJ?=
 =?us-ascii?Q?njU2HfsCVlAeK/1+9pGVSO5TamLSt+gaMCeA6GDzYlu3XpLAf6lzHph8ifwo?=
 =?us-ascii?Q?KBdgj+u9cQJmNQKVysn/uR7+T8Z5oUzYLAC7lBdyhDUWH2WIuNegstNY0BHr?=
 =?us-ascii?Q?uXs1QO+6xUT85z2TaQ4+ojKZMz94EUgMCvfl5KONTCM4hpEPuu/mTMDBvYOx?=
 =?us-ascii?Q?9wERcwcY7s/FlVSQye3jYN9qUqxrefEABz0KdUjlYQvn41iOl6FMz8jnFKcw?=
 =?us-ascii?Q?/3IaBXqIJjTnid4GVqHs/N4n4bYG3uLDCvcoJh6phQrUlen6T+5qg/16NvUQ?=
 =?us-ascii?Q?ExevYKi8DtyHovo4MxB4qczRiUL7LhTF4nq518lgKcBiZ+oV1xa84RuIb2Cp?=
 =?us-ascii?Q?AHGDYi/1zd164RCNqfSV+JcLiBkZVZjvRdT1KnT6YqqqZ7xU58xvRdNrjoo6?=
 =?us-ascii?Q?s6PTeEC3kfjkIwi4be9xNv0m/LH3q2MGGviR+cnuQwtrk4FVVp5tmNJ9w6IE?=
 =?us-ascii?Q?4FPqc9UY+AE/PqMdjPZBjmBA/qyxp0lTnh1WZMOnz3mLTXUrzWfZQNEdpEYU?=
 =?us-ascii?Q?Qg/mQ8YhEi6kZIK+H5ySKss9cNqKctmiZwZCVO3gGbxJ8PDsj6w0LHuVKyok?=
 =?us-ascii?Q?26XClAfKzrmLbakwOU8ftVsT/g1Aq8uNGqwCz51qGNy6brs6T9Fhke7kTVcn?=
 =?us-ascii?Q?N/fNVNSfy+q2JpgJO3OBqK2g?=
X-OriginatorOrg: vpitech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 129b5346-4465-4638-f901-08d97c99700a
X-MS-Exchange-CrossTenant-AuthSource: MW2PR07MB3980.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 00:47:50.3462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 130d6264-38b7-4474-a9bf-511ff1224fac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TeuyzNJecz0YLxCypFj2PcHXvcvmbi4VBgxFlpCZfT9ssY+RXLYLhWySY2WJJOpyhacJ6Q+bd9BRI7XLxEi/Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR07MB8666
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Signed-off-by: Alex Henrie <alexh@vpitech.com>
---
 .../security/integrity/ima/tests/ima_policy.sh   | 16 +++-------------
 .../security/integrity/ima/tests/ima_setup.sh    | 10 ++++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
index 244cf081d..8924549df 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
@@ -11,19 +11,9 @@ TST_CNT=2
 
 . ima_setup.sh
 
-check_policy_writable()
-{
-	local err="IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y)"
-
-	[ -f $IMA_POLICY ] || tst_brk TCONF "$err"
-	# CONFIG_IMA_READ_POLICY
-	echo "" 2> log > $IMA_POLICY
-	grep -q "Device or resource busy" log && tst_brk TCONF "$err"
-}
-
 setup()
 {
-	check_policy_writable
+	require_policy_writable
 
 	VALID_POLICY="$TST_DATAROOT/measure.policy"
 	[ -f $VALID_POLICY ] || tst_brk TCONF "missing $VALID_POLICY"
@@ -55,7 +45,7 @@ test1()
 
 	local p1
 
-	check_policy_writable
+	require_policy_writable
 	load_policy $INVALID_POLICY & p1=$!
 	wait "$p1"
 	if [ $? -ne 0 ]; then
@@ -71,7 +61,7 @@ test2()
 
 	local p1 p2 rc1 rc2
 
-	check_policy_writable
+	require_policy_writable
 	load_policy $VALID_POLICY & p1=$!
 	load_policy $VALID_POLICY & p2=$!
 	wait "$p1"; rc1=$?
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 565f0bc3e..9c25d634d 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -73,6 +73,16 @@ require_policy_readable()
 	fi
 }
 
+require_policy_writable()
+{
+	local err="IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y)"
+
+	[ -f $IMA_POLICY ] || tst_brk TCONF "$err"
+	# CONFIG_IMA_READ_POLICY
+	echo "" 2> log > $IMA_POLICY
+	grep -q "Device or resource busy" log && tst_brk TCONF "$err"
+}
+
 check_ima_policy_content()
 {
 	local pattern="$1"
-- 
2.33.0

