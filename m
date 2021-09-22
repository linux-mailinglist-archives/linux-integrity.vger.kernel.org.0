Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B9E415030
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Sep 2021 20:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbhIVSzX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Sep 2021 14:55:23 -0400
Received: from mail-dm6nam10on2089.outbound.protection.outlook.com ([40.107.93.89]:5863
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229732AbhIVSzW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Sep 2021 14:55:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRj8mKzgQcEOJgRaM/9or9Srz9j1hs3D8srLuA3P0CvC2lsF92UW17ONwtne8O3p4vRtEG2ZuZf6M8W70FNaqPukW3rWpx+FK1gVyiYMNNAhrQD8rzSUNkcqVOkDVUPM4B5HGH4V1wGuRm2HNlMpiho/lVF+UXNYf115yuhaKlsmUwng5Kvg+Uk2B0g5W1cNCMpZD0kiDnhNU8KO9X7MJq17bKAJKVjU2tKolTzs3M2dgrYs/dpB58tUbWjYxs4bGDvWilCmKhf67hCjPPAn7vuzxXmyP+PEbal1ShqwJRRcfVGiSO04TjhNQEjH+U/Wd8WOJQyjESuGkeelcbg+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=aJx0bn5bjojlOxYp6On5sSFGejd5EZgnUMZmo5Q7nO0=;
 b=e+Y1c3vxyKTI6Pbz6jlXlbqWh/aVNRc9sM8TelV2aIPg4ntmldoGU/i3rTly4P7xmSMnTJsJ/tjM0uhLgvdOdhtiXFMdkdxFjfHl599lyX2EF0Wikx/gwcuub+gincrGrQCT5Ppce9D+XT0kbXnIJEtH96eYyeukLl1sqAw2Bi8mK3Tjdd9MbHqINHaAPnDgLDuAplL54VnfAxPmKDiyhLoeMjZ3Kjkfl3V1blB2gcHH5oo/cRaf/4w9rcBuqZ60ZfWC6TXJzvFWCUfhj+BCWVypoPSHwMZw4UGlrST4uOhVDqic6719N2xvkGYY9e/qW8CzpAzhy4UapHk5Pp9lsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vpitech.com; dmarc=pass action=none header.from=vpitech.com;
 dkim=pass header.d=vpitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vpitech.onmicrosoft.com; s=selector2-vpitech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJx0bn5bjojlOxYp6On5sSFGejd5EZgnUMZmo5Q7nO0=;
 b=Xx4xARsYim5MC6u2rspx1GuA4u8i9N4XBW52RodHfo/lHpa4oAn50sMD8p6m6Z8QvNFuEVpOeAGZkjHsEzJ8ZwFFC6nDAw5UTYDbhkx4v4xh0MwXKStlqZjIm33THbIzt8nBAXOzTITmqq5QF/ZwEZvNs/FU2n9bz2l1Dmnsl50=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=vpitech.com;
Received: from MW2PR07MB3980.namprd07.prod.outlook.com (2603:10b6:907:a::32)
 by MW4PR07MB8649.namprd07.prod.outlook.com (2603:10b6:303:102::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Wed, 22 Sep
 2021 18:53:49 +0000
Received: from MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014]) by MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014%4]) with mapi id 15.20.4544.015; Wed, 22 Sep 2021
 18:53:49 +0000
From:   Alex Henrie <alexh@vpitech.com>
To:     linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        zohar@linux.ibm.com, pvorel@suse.cz, alexhenrie24@gmail.com
Cc:     Alex Henrie <alexh@vpitech.com>
Subject: [PATCH ltp v7 1/3] IMA: Move check_policy_writable() to ima_setup.sh and rename it
Date:   Wed, 22 Sep 2021 12:52:30 -0600
Message-Id: <20210922185232.492879-1-alexh@vpitech.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR11CA0003.namprd11.prod.outlook.com
 (2603:10b6:301:1::13) To MW2PR07MB3980.namprd07.prod.outlook.com
 (2603:10b6:907:a::32)
MIME-Version: 1.0
Received: from demeter.ad.vpitech.com (66.60.105.30) by MWHPR11CA0003.namprd11.prod.outlook.com (2603:10b6:301:1::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Wed, 22 Sep 2021 18:53:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16af8fc4-7199-4144-6ef7-08d97dfa5013
X-MS-TrafficTypeDiagnostic: MW4PR07MB8649:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW4PR07MB8649231BEAEFF3D9719C608DB8A29@MW4PR07MB8649.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6KnvqjnvgApau6QENced1+L+6BIjK6U3+tsdSgo9htVBY/wiCEeBDbSPNw+IbkB5cUGcWNZBeXbErefqNs6fw2cQCjCiSnheIUDIGsBKfy3bQbyWcMtrtNQLczi/4aOZANfhON5+mr8jclIptwrlSmnpngw6CfNATlqJurdJeGMx/x4sfY5AsSPRU/GUue5Gmc0v0WYAZ54rnz8S3HaUCf6aF46z6aoZPz4g9/of4VvMd5E/BsuHRsU8HEl6+tl/CNietCbyYZbm6ztOuK5bi7yV58jJuQLyHJcrj2jVoLVZqWovTUkm+n/zjg1EDuMv0Zg6Qe98qw+nrGnmUySB9mJyy2ce4xGAiw6S3xmhmW5xRidExusxIageKFiJE0Q0fWqnwSMp9BGnz629vP589bTDwXRZQ5+JCfzUpr1rplxpv3ORHj3nNkui4oyuKk/6Q6K548+6ZI6BoCrmrShiCl6KcJsHig7mjnwy/XEH2NEARg319XTRQEISi/QZsci1VnKaZp4oKftmflVZhdLwYZc3wrabBrHiqpnw5odB9r+nnVUj5jP4/LZ98+EyItCq1Mk+uUs9c2JQezEve788PCyLdsexlBDNSBL71k32nC5CCEyTQ89fnX53JQmFSKcYekXLiykDwvR4tBC3UXZR9BllxwMua2mZfdzdrq10+5aFzSD1iaglIHKN4N1GDobAefhG7tn3drqKo/C44fs0rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR07MB3980.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(396003)(366004)(39840400004)(376002)(1076003)(186003)(8936002)(38100700002)(86362001)(6486002)(6666004)(2906002)(4326008)(7696005)(107886003)(38350700002)(26005)(316002)(52116002)(8676002)(83380400001)(5660300002)(66476007)(956004)(2616005)(508600001)(66556008)(36756003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YdIYobZXH9YZEm8rjhLMWyae/t+Z6gqM9RQBrz1EYG2SMSrqHz9VC1lQfnIB?=
 =?us-ascii?Q?5dMhkx+fEoGQ8srYnXlkM/LQoFs0JUbiKIVX870Kxv2qGM7s+hoEH/t2Aa/0?=
 =?us-ascii?Q?84VwvR1sBCIdXyesQJ3R3HttcfnTmCDd/5br2VXtnSkjYOuaC3sStDUz1eBt?=
 =?us-ascii?Q?8jhzP0rxytqNFp1fwsJ4xAkPy4aQhHELY9htqDx0kC+wmJ/x7ESkr3e7GMxf?=
 =?us-ascii?Q?C0ylPJ1tf+pe21cC1dbqCpsFpwXDrL31Ixl7S2IXwbFB+Pv7xDW7XZ0NESbl?=
 =?us-ascii?Q?QrNB/fJizpB2pl8khmY6nfZWweiSCo3Jn6zK0oP4gIxhslUIVn2BOubGgboZ?=
 =?us-ascii?Q?8IUGav5miStq1JeN+Q1jVlc+vrzV7fhqmRKkKaLOzTYvQVXad4L1BbCJIgrJ?=
 =?us-ascii?Q?TwYmiTvS7F5a+2QEM2crWYjUxyPtDIfa17xr28fjV5yhm7s536HCvjfulgQ0?=
 =?us-ascii?Q?IkbU4RmWf0ochntgzmxc6+OWq0hDpQFp2Wu73P4E/AwpYTMVZs/jnJtpC78M?=
 =?us-ascii?Q?um3HKK255CTCO/vzksYCs6rOa2iA+YOLlxg81Jynbc8RBzaFkZHWoGTusfTj?=
 =?us-ascii?Q?W2t1F/APr6GY4tSnYpDKYezQg3mMC1e+vScCoEHbOUoguHhdS0nEoVXj69my?=
 =?us-ascii?Q?y91pbgDUIyGyNl2gQeXJ0YLK3LCQ6+MP1FlpGouIrs65mx4Uey7od6JWWD5o?=
 =?us-ascii?Q?5HxfMzITcKy7TwvDBLRmkXVaGbHzkXqPYkU2kiIr6O/xjAlHEv9T103KsJYg?=
 =?us-ascii?Q?rJaEVUpMDP3VmtWLVvi6iz7vudqr3cAht4HXWDR3sdOaIB+HES1MD6AtRSXn?=
 =?us-ascii?Q?vMUTVgMcxJFmPiUUi0wsLt3WORtWzGDIpvqvKgv1G/r5y1o8sM+/B5p+GJId?=
 =?us-ascii?Q?DhK4y5PA+C2MIT7ri3Nw1Wp0joY1q2GBbdAwYHaMpSHxQivjsLHoj3MzOXw/?=
 =?us-ascii?Q?q/JZZT2dMBkLr1aNN+dRzxYbDAGLtdIDon4VxnLJIB66UR5Ab7SuAFZZtdBX?=
 =?us-ascii?Q?CzWHE+DzN6SVXoO4LHX6uLvxmSYwfkVMhXYNJLOE2ju/dRdoil8A9qx9u/7c?=
 =?us-ascii?Q?57qmfLJe7b58dqn8K4K1kHA+N7Y6GbxGCGxFAHR/reKarAjf8W56qyG9dC00?=
 =?us-ascii?Q?ofPk2I/Ta0usXFURHq7Eiv/NnQksZC9vaHw0icDBMt5fl3wNG5ES7kqsN5Gg?=
 =?us-ascii?Q?SKs+iYc/FllzOBFLEML/ZBNh5nx4UW8AmF8MEc9Z6uLXKDWqrtBFyPwrmGNC?=
 =?us-ascii?Q?SzisOYkhOig9PzEosRnxC0RDoODiGlsfhcW85obeuxSbARpbRTIMOtMzuV4p?=
 =?us-ascii?Q?IR19q1+mPf4PAnNbjlrDTXX5?=
X-OriginatorOrg: vpitech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16af8fc4-7199-4144-6ef7-08d97dfa5013
X-MS-Exchange-CrossTenant-AuthSource: MW2PR07MB3980.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 18:53:49.0051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 130d6264-38b7-4474-a9bf-511ff1224fac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59q2Seoz3NaPNstytB+rdLl45RksKwbWG9MwAY0iyQuDGKpiwEYjHmat+la9cecLU1ZXl+2U49N+Wfck+fwqHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR07MB8649
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Suggested-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Alex Henrie <alexh@vpitech.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
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

