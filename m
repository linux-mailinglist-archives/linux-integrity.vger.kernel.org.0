Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD3E412A19
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Sep 2021 02:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbhIUAvW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Sep 2021 20:51:22 -0400
Received: from mail-bn8nam11on2064.outbound.protection.outlook.com ([40.107.236.64]:44257
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233464AbhIUAtW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Sep 2021 20:49:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0GQTMIfuNFYJ9vv/rpzp1iYqH6s1ZCyDyzQO+DOHPUBgIYmq3oOLkcD8CnaowJWbOQmVnJXrcc5BWwrYgS5bJHZjhL/7t/WEfMbE08wO2IUsaKBCj0suX5WTKGltWRwnvl2p5s5dzD2lTFB40JgKjBE9E0m+wH4bzwLMqQL4ev5HH/En9qz62ZC7rv72430nffDrRDjzDQLTbB/Y3hENrN7p5OCdg7oM6MIraReluf6Dh/RJdRerCa445hrJnwdJ9eFZAV+2ftXb1uCgzut3IpSOPQ2sPJAJSY0rRWxiZEha4m5H82Q4aDGdeXt7OM1iTGIrJ3QE6tNzCuTJDnL7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=/pRxB72ThmHgtBZDYxC1LKX2gi41fuaGVWF2G7K0LSc=;
 b=UIWriSMJr+5Cf2lDpj6EjL9rLVILqQx8kyx0XO+UqIi/ogbW8xN4fjUb6jeHgtsasCCB2e5DfWPo9rLTffVTNxqJjUt6lAaXPujUkjPxFAwxTkvXpUVM0T7yIQx6DImDP7yx6f6Kj8i27tHsrEvSEcsGDwKpCGVTHOtOOC89o8EEZUxylG7XRq/nGBqASmcrggsbr/pf6R97dDxmqQ+yv9TkcmbaDPcLc5DleDHu7ftB0OIFliyC3Ln7IznrSbO91maKsJOVXBFKBMW4Ew++2XJXZYYjDSsxcLn+JaX+iGXr6glSydTo3u9wsOZZj9B2660H+dBVPdzycq7GrhWjmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vpitech.com; dmarc=pass action=none header.from=vpitech.com;
 dkim=pass header.d=vpitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vpitech.onmicrosoft.com; s=selector2-vpitech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pRxB72ThmHgtBZDYxC1LKX2gi41fuaGVWF2G7K0LSc=;
 b=RLxxKwvMGF3rdMq3MSXY4jNqAfUF8mJvnwopo89gv1yAcY8eiICQNYZLI6Ux5iPwYGsfxOAx4cYLhwuaDO7nwi/BpHwMJ8Ioq2xPxX/xyzQldGj/b75dbBM1I/ww8G+iq3KLSQ3to5Yhia6n9YztajoYn0FqqxTjxX/4pGxg4nQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=vpitech.com;
Received: from MW2PR07MB3980.namprd07.prod.outlook.com (2603:10b6:907:a::32)
 by MW2PR07MB3915.namprd07.prod.outlook.com (2603:10b6:907:2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 00:47:52 +0000
Received: from MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014]) by MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014%4]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 00:47:52 +0000
From:   Alex Henrie <alexh@vpitech.com>
To:     linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        zohar@linux.ibm.com, pvorel@suse.cz, alexhenrie24@gmail.com
Cc:     Alex Henrie <alexh@vpitech.com>
Subject: [PATCH ltp v4 3/3] IMA: Add tests for uid, gid, fowner, and fgroup options
Date:   Mon, 20 Sep 2021 18:41:40 -0600
Message-Id: <20210921004140.15041-3-alexh@vpitech.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921004140.15041-1-alexh@vpitech.com>
References: <20210921004140.15041-1-alexh@vpitech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY4PR16CA0008.namprd16.prod.outlook.com
 (2603:10b6:903:102::18) To MW2PR07MB3980.namprd07.prod.outlook.com
 (2603:10b6:907:a::32)
MIME-Version: 1.0
Received: from demeter.localdomain (66.60.105.30) by CY4PR16CA0008.namprd16.prod.outlook.com (2603:10b6:903:102::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 00:47:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c0d15dc-373f-4d78-995d-08d97c9970fd
X-MS-TrafficTypeDiagnostic: MW2PR07MB3915:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR07MB39159710C5D4AE2F658DFE5EB8A19@MW2PR07MB3915.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:275;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yRw+8wOSB3VLwJVbcKssxBvDeVTIIqnmy5dyMyfCT/3d9xrXojFvzXkoFQrqNqFGuGJCineOrxmWb/rTa2XN9Z90udM4fPHHrrUBqiaZPZHmBsgo2/U8H+gBRxDoUwM+QKEvA1sjcTdh8goPLVFRBtWvQhl8GuAozc3e7DW7UjekiPa6L0Mv8U3WHNZP4pLCSQwaPwV28T+RkwoIF1kuTkR54U20Qk72wWJ1afMs1waY7w6vSZCIMmmyyCe0HG0H12d7SvBP/TR9EMrFrOMe2/usbmxpAIXeliWQI8PZbQUo5F4n5r0gU5E9sYY8F3z8v2vWmuYCigJT2wjQZNeX+YJ1b1tzeQJo/AKSoQjxTB6tp018SukcfUTmHw3SoZxNCrweWEL0CRFx6Mbn/RCrwKYdRhokPLrgKgqf1vjekXCzQtTTlKHV/3uYRnhsvpTG4w9OWm928PnJCt1+fuZNoXjJoHC+QpHRrKfday4EJZOj/qeL+kKKtVt9N7nOrVo21829Awc1VU6TU03Gl5Xan7jbixqKqT5rLx49v9MCUcnjM8o2M4Nm6ce3auKSrGzCGxMkVN1uMopQ8gGCqzH748r84CjC4kfEXckazTFiatYcJvbITtaVRxAJrwSW07rvmUJBl4EJePwT/W6Lv1/xjMFfbg4ylxQ79lVX3Kdf+tTvJ/15aGR3HmwpIVSQRkYIr7JgQ8OVdnBfHF8SnHIpjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR07MB3980.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39840400004)(136003)(346002)(396003)(366004)(6512007)(2906002)(8936002)(8676002)(478600001)(6486002)(107886003)(6666004)(316002)(38350700002)(4326008)(5660300002)(36756003)(6506007)(66556008)(66946007)(66476007)(2616005)(52116002)(38100700002)(956004)(186003)(26005)(83380400001)(1076003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?coXamiMotQisqu7SUqrAoVB20nPo3bHyrdtdhudebhoz3Ak9fTR9trw24QT2?=
 =?us-ascii?Q?L23WHL+3EFuU74ajvMgTSX1Yqo+/gVenMQFUUjLfkEsyIbI4Y78jzU2myesp?=
 =?us-ascii?Q?C3wIdPaqNKQH6E15ACRTK2ZztLMB75bZJOrm1ORWEVTjPn/DmpEdDWEg75AF?=
 =?us-ascii?Q?PSEHGQBZcdLSrDnBhnRraCiVU+nVANqAJWeO7/nFXINBd+WmRrObmwbZmVZ9?=
 =?us-ascii?Q?5u4YkW3OZQyrj9L5Uk2mjPdiIVm6GOgBUwlpHuc6XDlbwAGAtJNdMPu7k9DH?=
 =?us-ascii?Q?bH25nmSR3E9/ww2vVS6G2FHtOElozEz2yvOop7rS1hMFC+0Rg1rlUsvLPOHp?=
 =?us-ascii?Q?Nawb7CtHr0496TntpkQwyzcP2h9bTkEexlNH7BehznYBd4qRt1TfZ6BUUnGs?=
 =?us-ascii?Q?sX52QUqiNFU1xT930ymFybQCYPvZPoXdNsr/P+WcMbnnjaYE+PtREX98g1QM?=
 =?us-ascii?Q?3DDg3ypigG+e0Kihr/Bul4iq8vfTSgy1pjM3ZKEpFBgo9QyKl+dZilI8eXh3?=
 =?us-ascii?Q?6kh4SuVYPkPpc1dCbmcXhltIxE45GYegb53QN6vtUWxSgqBcDGH3lfOaLReb?=
 =?us-ascii?Q?bHtfdm8SC/ScQ1FTaUmxfqisunV1Oq5DF2o2JBTohw6WwQXwAQ+4n0UcXSv3?=
 =?us-ascii?Q?f7hSmQuM22Bj+/NfwDvJ4YN4c5LypmS55R9ZBYTDysKVBQDzYAJ6ypuOpnY0?=
 =?us-ascii?Q?RquHKlcVcby9d/qozVnQ1A395uYKCDU2Udpm2nmS+rpIW4mrmbK2tCQPpP7O?=
 =?us-ascii?Q?XV83tgPbYci8N0qmL1lgncy6HInw3JHMEiAS2kqeHpTTscyy5fpdpRziC5IC?=
 =?us-ascii?Q?4FvyDsw4qIsdkTKmpCAFe6DVoUuMP7yvO/B0COuKVSXMF35gsikiB+t7NsdT?=
 =?us-ascii?Q?s+tJ9gBoIxMzaCQOx0MAYObPWKD7ZfYRJIWvMXpCMRzedhIhVrhZH13BIWyF?=
 =?us-ascii?Q?eq8fvKVnPH8UMoefXTgnHlNLosiSS4r/w/PTSiCnUqUVKA+UFW1l2pn+JBxO?=
 =?us-ascii?Q?P20jmSteINyk1tKnlpkrVFgdfKgq5G/TBwGPRfhazIy6/ar0FTEzWv6UiQ5i?=
 =?us-ascii?Q?EoAcAt0YhkGc88OYvTggSxohIji+T/qmO7kyspOwhfIUNpQCDMkcfd6VQRmz?=
 =?us-ascii?Q?TU8lbF6j0qgaCo7/HGDMLuuLuecUjilq3U7uPUmyc9t5SLUYvWIOflYGM1Xg?=
 =?us-ascii?Q?xMbnqU9jBc7aYQ+glUBGSot9kG3BC+OgoTFrzJNgiIjs8OXK7xPUrGvK7i/a?=
 =?us-ascii?Q?iAB/U/+maOtzlOZmpUbI2wUG4J0y1BSe/pkgy0PKlJk7OxTs8wzUSwSf0a07?=
 =?us-ascii?Q?4Oyz5dTD1G9hiTUOgOoLpmXu?=
X-OriginatorOrg: vpitech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0d15dc-373f-4d78-995d-08d97c9970fd
X-MS-Exchange-CrossTenant-AuthSource: MW2PR07MB3980.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 00:47:51.8353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 130d6264-38b7-4474-a9bf-511ff1224fac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DKMGn7MIHFRnrLxk+gFSqADBuwNay5hYljo5RhY0WEM2detgVS3HrXiG3zf6AsFN0ZzEy3+NZB+hiSdhVgMUiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR07MB3915
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Requires "ima: add gid support".

Signed-off-by: Alex Henrie <alexh@vpitech.com>
---
v4:
- Put new tests in their own file
- Check for policy writability before each test instead of once before
  all tests
---
 runtest/ima                                   |  1 +
 .../integrity/ima/tests/ima_conditionals.sh   | 57 +++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh

diff --git a/runtest/ima b/runtest/ima
index 29caa034a..01942eefa 100644
--- a/runtest/ima
+++ b/runtest/ima
@@ -6,4 +6,5 @@ ima_violations ima_violations.sh
 ima_keys ima_keys.sh
 ima_kexec ima_kexec.sh
 ima_selinux ima_selinux.sh
+ima_conditionals ima_conditionals.sh
 evm_overlay evm_overlay.sh
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
new file mode 100755
index 000000000..5eb8859b2
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
@@ -0,0 +1,57 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2021 VPI Technology
+# Author: Alex Henrie <alexh@vpitech.com>
+#
+# Verify that conditional rules work.
+
+TST_NEEDS_CMDS="awk chgrp chown cut sg sudo"
+TST_CNT=1
+TST_NEEDS_DEVICE=1
+
+. ima_setup.sh
+
+test1()
+{
+	local user="nobody"
+
+	require_policy_writable
+	ROD rm -f $TEST_FILE
+	tst_res TINFO "verify measuring user files when requested via uid"
+	ROD echo "measure uid=$(id -u $user)" \> $IMA_POLICY
+	ROD echo "$(date) uid test" \> $TEST_FILE
+	sudo -n -u $user sh -c "cat $TEST_FILE > /dev/null"
+	ima_check
+
+	require_policy_writable
+	ROD rm -f $TEST_FILE
+	tst_res TINFO "verify measuring user files when requested via fowner"
+	ROD echo "measure fowner=$(id -u $user)" \> $IMA_POLICY
+	ROD echo "$(date) fowner test" \> $TEST_FILE
+	chown $user $TEST_FILE
+	cat $TEST_FILE > /dev/null
+	ima_check
+
+	if tst_kvcmp -lt 5.16; then
+		tst_brk TCONF "gid and fgroup options require kernel 5.16 or newer"
+	fi
+
+	require_policy_writable
+	ROD rm -f $TEST_FILE
+	tst_res TINFO "verify measuring user files when requested via gid"
+	ROD echo "measure gid=$(id -g $user)" \> $IMA_POLICY
+	ROD echo "$(date) gid test" \> $TEST_FILE
+	sudo sg $user "sh -c 'cat $TEST_FILE > /dev/null'"
+	ima_check
+
+	require_policy_writable
+	ROD rm -f $TEST_FILE
+	tst_res TINFO "verify measuring user files when requested via fgroup"
+	ROD echo "measure fgroup=$(id -g $user)" \> $IMA_POLICY
+	ROD echo "$(date) fgroup test" \> $TEST_FILE
+	chgrp $user $TEST_FILE
+	cat $TEST_FILE > /dev/null
+	ima_check
+}
+
+tst_run
-- 
2.33.0

