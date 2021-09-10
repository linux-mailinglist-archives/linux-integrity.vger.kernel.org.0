Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDD0406FE9
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Sep 2021 18:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhIJQrE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Sep 2021 12:47:04 -0400
Received: from mail-sn1anam02on2079.outbound.protection.outlook.com ([40.107.96.79]:33633
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229448AbhIJQrE (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Sep 2021 12:47:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpzRJok3OSKfDMY36vtA4p1UNbqO/i445r3WEMWsRG9d9we4L8Iz1EVbMSJUb78CHijH4E20CftgqJ3F+4dV1S7G3JCHvF8sK+6FUWyZMvYObzKSwh38EaXU6shOxUl7AB8sI1n59RTPY+G5osI3uRRUg+QZ5Dxp15NaKbVHGwnavoiNWEohduqXZ/Ka6h2H8ynXR/UOeHnzsZ4V5P5R15sEpBvY1t8X36tePe6Bfi/mzHN/6wcSnpTIEWF7OHT9vz484MiywkZTgW8inGxGQoa4Pvk8caJLxRMGF3TWaCw2S5nFzCIhVVZFMJpbjAeVcDAJvDp1ki8ZaugVQ4smXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=1xxuuqLRrgXtS+hEfc1wkPberdG8RdG6xaXoHM+mKLQ=;
 b=Edm2YYf3KwWYeEBZ1EDx/jQ9cW0vo5mwW6lWz1z5O5LfXLfM0hLt6T4pPsKhpkvTsnc00i7p/87gQh7zFPBvXzyGrxkmFf9CD4X64qNj7Um6nTPpoIsI9lwmqF3U34Bd3kOkWJ7EO95BmK2qYuyuSKRqIu4vudBeGu+EXkSiDDMlMrB27iSbvQkuA/Tj6k536UejwFpeJuIUSVxIYvQuvpxb+nXQ/6IkXv7FTQ8WgmUPeP7ZdGak01dr6uYJl9h+R+7DhkjNQeOE5NB8MlMyZx14Lv4+ikWIi2aNwpZ/RP+oUE147miKEEwi/GCLUNpcqAUXHFV9MY6/er5BvitrtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vpitech.com; dmarc=pass action=none header.from=vpitech.com;
 dkim=pass header.d=vpitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vpitech.onmicrosoft.com; s=selector2-vpitech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xxuuqLRrgXtS+hEfc1wkPberdG8RdG6xaXoHM+mKLQ=;
 b=XXNzgdQAatZlawb+7H9Rz3VlPXOVDVnTAFpLkmE6J90MskRtXIxYmR4AK0StCN93aTs/OosqdyXdazUJjvneyhujkM5x4U9Is53lLmtEwTFdTycuHsaUEi33OW1c2GREDSqwjwVtrRxiK3+ckm4HOcvrndCpAb5b9nv0L/EdCco=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=vpitech.com;
Received: from DM5PR07MB3975.namprd07.prod.outlook.com (2603:10b6:4:b3::39) by
 DM6PR07MB7993.namprd07.prod.outlook.com (2603:10b6:5:169::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.16; Fri, 10 Sep 2021 16:45:50 +0000
Received: from DM5PR07MB3975.namprd07.prod.outlook.com
 ([fe80::94ed:80bc:9907:b5b1]) by DM5PR07MB3975.namprd07.prod.outlook.com
 ([fe80::94ed:80bc:9907:b5b1%5]) with mapi id 15.20.4478.027; Fri, 10 Sep 2021
 16:45:50 +0000
From:   Alex Henrie <alexh@vpitech.com>
To:     linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        zohar@linux.ibm.com, pvorel@suse.cz, alexhenrie24@gmail.com
Cc:     Alex Henrie <alexh@vpitech.com>
Subject: [PATCH ltp v2] IMA: Add tests for uid, gid, fowner, and fgroup options
Date:   Fri, 10 Sep 2021 10:44:48 -0600
Message-Id: <20210910164448.28302-1-alexh@vpitech.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CO2PR04CA0095.namprd04.prod.outlook.com
 (2603:10b6:104:6::21) To DM5PR07MB3975.namprd07.prod.outlook.com
 (2603:10b6:4:b3::39)
MIME-Version: 1.0
Received: from demeter.ad.vpitech.com (66.60.105.30) by CO2PR04CA0095.namprd04.prod.outlook.com (2603:10b6:104:6::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 16:45:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 241749d3-6577-4505-ebb1-08d9747a7228
X-MS-TrafficTypeDiagnostic: DM6PR07MB7993:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR07MB79935C200925D30F2DD108C0B8D69@DM6PR07MB7993.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:747;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LpqUXwjYiBEdjFhrT9KZKuTUYubA5hlkohTZ+LHDtd3MnoMCdQeIUC3oCWnr3ai02zOIXpycB4OoMVyy+We3d/eUTKtCxxOYbenSZY/3+grRx3nLl+jSBLOqgjZtkEojN4CUAraRLl3bJ2jzLgbuRTUuAKOJXxKGCwMC12i3y2QUWoiF1zhhWFk4/XkBMmVEudKVoeN9cqRLC9zM/CTEy8mXbUjYIcDwHTNTgeg5CV7W76zPRz9jwJeTQCk4wRWe4i/AqcK8aUzMXHB49lPkodFcAkdR5H2L1+3Sko+DqiwQB+S0bcMpP4uObvp9f5NfD2pkpSaSEABGcq1jSd1oPK+bwCzI0xELASSyZHmAQszIvY7LpH6745iuRy8W5kzRPYHtxd5ewQ7mxu2ZRmXXzeQqmeSrIC8bEtqpRgexNQCU1i1gciXgNWr6EahjqWP9l4JwZCKa/URZw1QAnPsGJiH/tVnTGBOR67ySXF/ooE/edIw+wH+8J6UKtkrYyMLPG+dQUGqGVA97ZvsqE6AATLCMNQIWjZBALGtBH3qw1CQ6RlFWQbzU5qvs4kvswPI/WuEfffX6GxAKR7xC/Ws3zu4CY7iCbi3TbhEXLHiaLLwHAxMwhKuQfifzH4kCqzy+jkvYyUP5cxB/0N9ond19RKxP1DHyRwA3IA48ncj2/siCHcsAVxGSq9rSBB6apPmAoK2dYnOTm4YeBQK+wrHltg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR07MB3975.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(346002)(39830400003)(366004)(36756003)(2616005)(52116002)(7696005)(8676002)(956004)(316002)(26005)(83380400001)(5660300002)(4326008)(66946007)(66476007)(8936002)(66556008)(2906002)(86362001)(107886003)(1076003)(478600001)(186003)(38350700002)(38100700002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?geuL5bW/7aph2EicSJnWDwCUYAwtwtItPqpy9IFqQp/cwfxJnCZEYuWFrD2L?=
 =?us-ascii?Q?kG3KyxzKHeyDCvM3P1v4yGE3i6Xmq3DNGJSjX0JCr6VZZx7dfkG+RL4Iiww/?=
 =?us-ascii?Q?SGRgkHwq+3jE2hKGZQwmVt7WnJ8KhDinQgdcZUX/129ncwS9IWzBKdSsuUCf?=
 =?us-ascii?Q?KncYpUqOwtsmpM/p1kjlMvvZOWZ2cS7fR2oLGE3aWZRuW3CWxhCM17ePsnHD?=
 =?us-ascii?Q?JN6na4Ehp+xHP79NhQOZ2u1/F9h2TIVjlOBDWIZWBvBgF2nEb52wf8zTa1lq?=
 =?us-ascii?Q?n80xtRo3lBNt8dsppWo07Kx/ZYlvKISC9xZVPncpnwF340EWgO46NaBHLSP0?=
 =?us-ascii?Q?4MC39M2rWDMEYYJ436GLE1qE7fije7YFH6X+IGopfKAB2TgqkvYbWlOeNjNB?=
 =?us-ascii?Q?Yd5+MWw6tD7XEieCYJZDj3D7JLz8oEVPTHNRTIvGLbP35FafcvyJzz2gxvdg?=
 =?us-ascii?Q?XL17odOllsdSwluYdy93ScDDS6j/5DE5M3QIrjX9b7mFavwq1hiA6eplaDZW?=
 =?us-ascii?Q?hMK3YEeKGuxn7nDHkv2oekK9MyPx9cqqAJpjAvub6XFhX2+yUwuAunUbmamP?=
 =?us-ascii?Q?Fwo+UVbotvn6CKsrBXL2RcCMsUl4CIcEiR+MG53L8kx/svWk4YYMrpMgZyMc?=
 =?us-ascii?Q?7DXlpHcrl5UcyVdi8p17bIg4NugyZiePTFt0+GCG9PDH4CqxnkMrtiKJLgT1?=
 =?us-ascii?Q?/LA/X846gY57t3+s1t9h396z1YnITgfKlmQJrugOxfkdbveOEI8YQapH1+tH?=
 =?us-ascii?Q?Re2nQtil+4f2W7dIvqpNmzHYpFDkysKrEPY6AtJ3QT0v1udDMx8rUG9HxUYD?=
 =?us-ascii?Q?ojIlueBuxdSxsA67zofIgaOctY3IdidiqX5EZb9JrtDVwaMCEzIp64oVudmT?=
 =?us-ascii?Q?XMOy7ojmvcwC3ZfxI5lSVrFmHqbvS6Yqj7pH1aNuAazKW9TAwlOzX96s2+qD?=
 =?us-ascii?Q?E8+6Zu9whj/LzSYHTYqfIstaiSTPggJ6pa9Oe3sw+8nOGS1w/R5mRi3nmf7D?=
 =?us-ascii?Q?tJT4DubKY9ciSpWfdfWRZyfM3E0eI+saBEEYLDX8SyPatwJuWyLl8pwrBNoc?=
 =?us-ascii?Q?c5/3XwQ6SZxAHTvCA5w8CGoZ5etb7vEtGhZVgQFGKVVO73GcPrisrFiHWoUz?=
 =?us-ascii?Q?HrTBSkaNXBkiGPbnBykvXHizF0BLsypfzAIBJBbP+51rxAsDXoyo5JtrQKke?=
 =?us-ascii?Q?8LoUqhNQp/uHGKgDFPKDOpv1VIWPqosJFJ9EI2Tc9Feg4Hl00nmjiTIeuB9v?=
 =?us-ascii?Q?WsqlDNt1H8AhnQLXD4SLPxkjBIteiR9JY9loaSIeIow7d24Qcrq47bxH3mAC?=
 =?us-ascii?Q?Buwo1GMZxJo8sU7+wEyDuH0/?=
X-OriginatorOrg: vpitech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 241749d3-6577-4505-ebb1-08d9747a7228
X-MS-Exchange-CrossTenant-AuthSource: DM5PR07MB3975.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 16:45:50.2410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 130d6264-38b7-4474-a9bf-511ff1224fac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Emo9000SRwrsud+r/eq6DFJ8IIPK2Sf5wRZZbhHHmTjT+Ed8rPHbH442vAjdgDza6JGbHtMu9m/MMdl2Sq4cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB7993
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Requires "ima: add gid support".

Signed-off-by: Alex Henrie <alexh@vpitech.com>
---
v2:
- Add sudo to list of required commands
- Check policy writability
- Check kernel version
- Use `sudo sg` to test the gid option
- Don't try to restore the original policy after testing
---
 .../integrity/ima/tests/ima_measurements.sh   | 37 +++++++++++++++++--
 .../integrity/ima/tests/ima_policy.sh         | 14 +------
 .../security/integrity/ima/tests/ima_setup.sh | 10 +++++
 3 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index 1927e937c..d685fc161 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -6,7 +6,7 @@
 #
 # Verify that measurements are added to the measurement list based on policy.
 
-TST_NEEDS_CMDS="awk cut sed"
+TST_NEEDS_CMDS="awk cut sed sg sudo"
 TST_SETUP="setup"
 TST_CNT=3
 TST_NEEDS_DEVICE=1
@@ -20,6 +20,8 @@ setup()
 	TEST_FILE="$PWD/test.txt"
 	POLICY="$IMA_DIR/policy"
 	[ -f "$POLICY" ] || tst_res TINFO "not using default policy"
+
+	require_policy_writable
 }
 
 ima_check()
@@ -103,7 +105,7 @@ test3()
 	local file="$dir/test.txt"
 
 	# Default policy does not measure user files
-	tst_res TINFO "verify not measuring user files"
+	tst_res TINFO "verify not measuring user files by default"
 	tst_check_cmds sudo || return
 
 	if ! id $user >/dev/null 2>/dev/null; then
@@ -116,9 +118,38 @@ test3()
 	cd $dir
 	# need to read file to get updated $ASCII_MEASUREMENTS
 	sudo -n -u $user sh -c "echo $(date) user file > $file; cat $file > /dev/null"
+	EXPECT_FAIL "grep $file $ASCII_MEASUREMENTS"
 	cd ..
 
-	EXPECT_FAIL "grep $file $ASCII_MEASUREMENTS"
+	tst_res TINFO "verify measuring user files when requested via uid"
+	ROD echo "measure uid=$(id -u $user)" \> $IMA_POLICY
+	ROD echo "$(date) uid test" \> $TEST_FILE
+	sudo -n -u $user sh -c "cat $TEST_FILE > /dev/null"
+	ima_check
+
+	tst_res TINFO "verify measuring user files when requested via fowner"
+	ROD echo "measure fowner=$(id -u $user)" \> $IMA_POLICY
+	ROD echo "$(date) fowner test" \> $TEST_FILE
+	chown $user $TEST_FILE
+	cat $TEST_FILE > /dev/null
+	ima_check
+
+	if tst_kvcmp -lt 5.15; then
+		tst_brk TCONF "gid and fgroup options require kernel 5.15 or newer"
+	fi
+
+	tst_res TINFO "verify measuring user files when requested via gid"
+	ROD echo "measure gid=$(id -g $user)" \> $IMA_POLICY
+	ROD echo "$(date) gid test" \> $TEST_FILE
+	sudo sg $user "sh -c 'cat $TEST_FILE > /dev/null'"
+	ima_check
+
+	tst_res TINFO "verify measuring user files when requested via fgroup"
+	ROD echo "measure fgroup=$(id -g $user)" \> $IMA_POLICY
+	ROD echo "$(date) fgroup test" \> $TEST_FILE
+	chgrp $user $TEST_FILE
+	cat $TEST_FILE > /dev/null
+	ima_check
 }
 
 tst_run
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
index 244cf081d..f1d3b6074 100755
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
@@ -55,7 +45,6 @@ test1()
 
 	local p1
 
-	check_policy_writable
 	load_policy $INVALID_POLICY & p1=$!
 	wait "$p1"
 	if [ $? -ne 0 ]; then
@@ -71,7 +60,6 @@ test2()
 
 	local p1 p2 rc1 rc2
 
-	check_policy_writable
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

