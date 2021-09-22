Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5843E413F42
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Sep 2021 04:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhIVCK6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Sep 2021 22:10:58 -0400
Received: from mail-bn1nam07on2051.outbound.protection.outlook.com ([40.107.212.51]:15239
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229594AbhIVCK6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Sep 2021 22:10:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgA05g6vQQqx4vPGFAagdsJGu4Bl/UwPelzoT1o3Oq/ZTxMhBnwfNGtv6S5xRTew1eApKKgwvzojLz0OqC0rope/yKzqMBdhAWyx0mSyVP7ucSnsS7XCImp0L+Cv0GtFnUS880YzgLgGmaJ6dPmPwOF++FHtVxJz/FtJ7pu63O3OqIqomnT5Cc5rIdQc4RNZZK3uhC22vgdcErpcnq62PDdruhIC4Pq4/I+Qafbt6e32v7j5OSx2eBXN67fIDaZ+tmbAfzBYhAkd590mWpqhr/mZ9xz+luyYuHKXRC8D5MkkC0GOj/L6ukb4qTVjLi8qeSJa8tCrAyxD8nRIVH94xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=zMxu75s0OhBb/Yj7WUME2AQQ2gmO12Nyk27SSpLlHuk=;
 b=IAPjxVQMjjj+XvgIWk8oosAAsBjAklZQM7Qjb6jbojk0ku7KwILaLPn6tt61tOm6L89JHeUFDDSzPKDy2xqwuPfqHP3/2/FVFVRbYykJjOeA/8I0o00GRbmayHwbhU6gih43xZcTa9HHUq05Y+IoZSQqUGz6JsSgb50OBQs1V//1Jgwi1LQ+VogUz02aN8XwKzYEuVK7/SLQmAcsnfDv9qpf7NE7mmuGKSpo0LroU9Iw/VHvSoJn00eXQVnREYGI33P2b8BZGDUjGPhd4M0K7bKLzG06tVXmg2RrXXQg/66FT69XymsU+R3cL5BgkG5apBr3giEjylqyCrmyka+PIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vpitech.com; dmarc=pass action=none header.from=vpitech.com;
 dkim=pass header.d=vpitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vpitech.onmicrosoft.com; s=selector2-vpitech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMxu75s0OhBb/Yj7WUME2AQQ2gmO12Nyk27SSpLlHuk=;
 b=nrZueeN319AN3CReihtmrX0oiZfWFoikn6Gj7KuiJyB0k5cvLcYMV+SG0Nf+i1GSLCRXEFqbpJhDr+9DQWPy4Wu3fZe8MPx/Xo0xv6vB+NJSh+gvapX/L4qmo+wKhJdJ8wJBJ/mFx0vQFMtrjrL0aos0TlIJQLOpvJyntV6mbKE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=vpitech.com;
Received: from MW2PR07MB3980.namprd07.prod.outlook.com (2603:10b6:907:a::32)
 by MWHPR07MB3149.namprd07.prod.outlook.com (2603:10b6:300:e8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Wed, 22 Sep
 2021 02:09:23 +0000
Received: from MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014]) by MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014%4]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 02:09:23 +0000
From:   Alex Henrie <alexh@vpitech.com>
To:     linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        zohar@linux.ibm.com, pvorel@suse.cz, alexhenrie24@gmail.com
Cc:     Alex Henrie <alexh@vpitech.com>
Subject: [PATCH ltp v5 1/3] IMA: Move check_policy_writable to ima_setup.sh and rename it
Date:   Tue, 21 Sep 2021 20:07:59 -0600
Message-Id: <20210922020801.466936-1-alexh@vpitech.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0222.namprd04.prod.outlook.com
 (2603:10b6:303:87::17) To MW2PR07MB3980.namprd07.prod.outlook.com
 (2603:10b6:907:a::32)
MIME-Version: 1.0
Received: from demeter.ad.vpitech.com (66.60.105.30) by MW4PR04CA0222.namprd04.prod.outlook.com (2603:10b6:303:87::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 22 Sep 2021 02:09:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0251680-5475-47ef-dd5a-08d97d6dfefb
X-MS-TrafficTypeDiagnostic: MWHPR07MB3149:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR07MB314955A8A2EB4ADF042E4C99B8A29@MWHPR07MB3149.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NMvK88vb9NfV68IyIFPWq3RjN3oF2A3Jv8DJBDJGQeqgbCiz+49JIotLxeI+DmfqA0rPRNICWDhRK+m1FbnzUlOCAGc+dsc94c9MPEGmMJYOA7sUjGS1IVHNYBgszD7gKDDHGi39M95X2YrK7Loa2ieg4+AU7mxGxdaZuwW9NE2w226bwHhLVKkOwrNt7DgzEcHzaMS5aexYAeYHtxTJ6gouimp45g9l4XALdTFQE9ZCxHdRPaOeVp98jMGxxiyUoq/7nZRuu6f1CogCCT0sbYlYuguI9Ico7EeDs3TTuDTCdiUbSqw4FCqKTt/G3IWOjnbWT0+6GEwHZtiMmQ8weZRXl68NqS1NsLkerC7DJdgFLlSVXAXC7ox7TiPErEDKnvuvhk3Gfl0wMvOhHxC1SWEqn+G/h4G/nElD0wSB63oaBASi2NuVAJmEJ9itCYcQIBPsDFCHtBB8uzY/JnOjcjQHUEZmaEzOU9NCKGAE0KKlQewvSSq2CmuUO83gn+VZC51vQGSGJbMERHfGWc6LbTlEx4YtO+V0b7yHuD+o6XNIixDff3BdmXgDplwe10cjJA8pkiuEOjh1mbLJuwlsF63MiWoNPp/hWjM9ecqVYJ994mkoWQmH+wnkCDrfTv38fExBpGjI3DftPNCsZb5CN3AyD2pwEyQBdMggSFdueysX/QykvZOkMvx29duHh9lO5H7SCRBsCbw8ja6HzyQenw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR07MB3980.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39830400003)(136003)(376002)(396003)(366004)(66946007)(36756003)(66476007)(66556008)(1076003)(5660300002)(52116002)(7696005)(316002)(6666004)(2616005)(956004)(86362001)(2906002)(83380400001)(26005)(107886003)(508600001)(8676002)(8936002)(6486002)(186003)(38100700002)(38350700002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n/ovwJi2GkvBnG9xk2AtUEmSO8bsl9LxgzUNk7+hEL290agVDpVdLsO/K2fI?=
 =?us-ascii?Q?koT6QGMJbCyrZILHCt3Blx28gp6mloBpBwZfUa/OVVPe+5UF19V/jt6uRsdc?=
 =?us-ascii?Q?R2OUY8ocAYk3/jBn8vu87chHjAngENBsy0qWDUzX2HF59numNAl7pCkJrfsO?=
 =?us-ascii?Q?PKPBVCINeCl8sINM52POI/pnRP5CXgwl0WtjjCfDUprkTlmvvfRIk1xxUA/b?=
 =?us-ascii?Q?S/kSPzLD+yiX/ePsyam6hyfRGUHIREGihLowwks/9xU8FJyJ6re9NRNiR/QB?=
 =?us-ascii?Q?HOZvNtovtV55s0KfEUe6efVaJ1BAKBEgyhg1TK4PbqvVDKVlYy/5+tksWCOM?=
 =?us-ascii?Q?qJKh8rkfCVmj1lpF97oW31oqR9am/nIkLE2SiAm5cLWOFqmdQE9tCCqQodQE?=
 =?us-ascii?Q?8Y3hQ83R3Dc/4sywQhHLyODpZdNsZs1j1oIlHDxf0OGTfuYtxI3pT6+l352G?=
 =?us-ascii?Q?kRIHrOHHd7J6kLraP2DwK57pumL8byAt7RfMEvtHMPNcEQWtBFlXEGWDDh9e?=
 =?us-ascii?Q?7z+5s4sFkM6a5eg/DdzlmV9YRjPHzI0Cf0TB3gU8pm3TPE2t1bSyVC43SdYs?=
 =?us-ascii?Q?azCfzZj014UWspWEtKXhDv7nh/9c7eOLKh7si8GfAHtCrsPDs0rBmv39xhWK?=
 =?us-ascii?Q?qp2RMGwrtvGhO1P+MkBE+a/IIMcRgNtbBv18Hpdbzlln3bzPT7K1j9VV6P1b?=
 =?us-ascii?Q?RkWZ9vvV0BpvRZ7YM5mdTTWyZ+y/da+If3TQezU6VinqDcUpZYNkLp2d0Tnc?=
 =?us-ascii?Q?pxSy8QnZyED+VN1FcsxmkkuJmmpMJnO2x9MBVlvKbKjom+d9NiIm/OEtg9D+?=
 =?us-ascii?Q?S/ZjBbQcMS0henGMKDT2FN3XzpzLKNfAcd8gVz/LKJ9KG67dfL3bpzOTHT7X?=
 =?us-ascii?Q?jnpZdIuRuSJ/ANNf9rBuoCXaSc6RS39X769ObprWxgfGOkHjNFWO0+jQso7B?=
 =?us-ascii?Q?SGDsCplqQa0zlnt9NYftFHhYMgIVZhQmfl2KE04yqdiszqkonVg4O2OK4WKx?=
 =?us-ascii?Q?nWiKxRXGQx+FkkwlkOBX+DMLgsHsNjp1z5U81AC4KHCnC27gca29wYHnW1Cj?=
 =?us-ascii?Q?18J17cYKuG3bZVpwaRjCLUAk5bHZDePL2rEhIDaqp+pn+El9doy1w61HIokt?=
 =?us-ascii?Q?ZSQ4ce1tHQvVWu+hAH6yfQOV9V7NdqXgh/1DWvl0oheRtitC+E+VDs1sDZ/W?=
 =?us-ascii?Q?crdT05GBIqf/fsCnwj3tPNur2iVWQg5PxcyO6kIAMp2EKooKh/lCk+BghlTZ?=
 =?us-ascii?Q?QK47hL9NzebhHORr0Idf5Z1+Y85O1tSJthED35VFfn82ywO9Rm48/6KKH5YV?=
 =?us-ascii?Q?XolNG678J/UKfBaU4cgiURhJ?=
X-OriginatorOrg: vpitech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0251680-5475-47ef-dd5a-08d97d6dfefb
X-MS-Exchange-CrossTenant-AuthSource: MW2PR07MB3980.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 02:09:23.5080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 130d6264-38b7-4474-a9bf-511ff1224fac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Y8EjFfloOtc0YpHxwss+2odNhSjM87vl/nuKxnE7AjNiXtnv4p/npdwEFxO4AUv9djdOH1jlvj8rJOR4H1w/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3149
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

