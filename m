Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9DC41502F
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Sep 2021 20:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbhIVSzW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Sep 2021 14:55:22 -0400
Received: from mail-bn8nam12on2059.outbound.protection.outlook.com ([40.107.237.59]:18849
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237022AbhIVSzW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Sep 2021 14:55:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diDgG5w+rQrp3NF4c/ac7huU4NvhnAS7FItDPxIkDYmbG0FvnTG04PqQZssgVTUL8UD0vzDPMZ++cBkzpKlVYvZS+NotN+NPNLWtqNOpM4BQHVjxzSi7SAfUJMLWu+My5v/tA6vVKI39PK3K0CLGueSoF5YAosb470J0EjNeyZp1nPddFX13smUPxHKlDhiRWq4FDHPx/f+8LKgAPUrFvzIsTxFCre8aRUWKag91v1hQ6skS21uql7DtZKeNsDFQBLjNELsDliw8yZGzDN4SxixQqSe7Hn+IV7bcEaD6rdEC41CVW0scCyuZHgk7aLGdxYkXEf/GBHScKtvxFQT32g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=oh8oFmUd3CL+XgW5TtKLjwn2JsiE9huahvp1HFni/BM=;
 b=H5ug2t5bZOnKTypisCcZrloUL1lwA3PsQQVPd2TI4FUnCFV59x1LAIptTbrbiy/PHWOH0lkqe41exZlP0v4GagpBKe+NnBjJX46dJ70wp14OAawJZ3zoqu9Ej3g59Q2DqRPG6ROceyB8jfnRVRL8JbjARLz8X9KqJiaDck+N1fHwx1ipCyCEsATnXc1yt3nTt69NNrYSJioBALX2QITHKEe7CQDVk+4L5ADyG9Qz++c1/hOYKdpHwsVLXOY5xiAISgChTaqJe0rFdW/fKaV1b+tknmLd2xrYlVmOMO0hKcL0QXqyUBNZ9K9vhHprHPdz9MFAkSE7WfYyfUG4VJgYUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vpitech.com; dmarc=pass action=none header.from=vpitech.com;
 dkim=pass header.d=vpitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vpitech.onmicrosoft.com; s=selector2-vpitech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oh8oFmUd3CL+XgW5TtKLjwn2JsiE9huahvp1HFni/BM=;
 b=NQXqj3NSiytMKAzluV8MMKMspsOzurJ7E3y2+6JpeqinFGIFQ5KZcGn8GaLH2w84z7KHzjLfIwX6kcDJQnWXYr43k5ZZFDVLUUCwmle/clt6qPE0+f3txjRwLpbSlL6WyvixY+BF3hOAAkqrdY5T552T7Bj0U0emcQAX1FB11tI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=vpitech.com;
Received: from MW2PR07MB3980.namprd07.prod.outlook.com (2603:10b6:907:a::32)
 by CO2PR07MB2583.namprd07.prod.outlook.com (2603:10b6:102:a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 18:53:50 +0000
Received: from MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014]) by MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014%4]) with mapi id 15.20.4544.015; Wed, 22 Sep 2021
 18:53:50 +0000
From:   Alex Henrie <alexh@vpitech.com>
To:     linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        zohar@linux.ibm.com, pvorel@suse.cz, alexhenrie24@gmail.com
Cc:     Alex Henrie <alexh@vpitech.com>
Subject: [PATCH ltp v7 3/3] IMA: Add tests for uid, gid, fowner, and fgroup options
Date:   Wed, 22 Sep 2021 12:52:32 -0600
Message-Id: <20210922185232.492879-3-alexh@vpitech.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922185232.492879-1-alexh@vpitech.com>
References: <20210922185232.492879-1-alexh@vpitech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR11CA0003.namprd11.prod.outlook.com
 (2603:10b6:301:1::13) To MW2PR07MB3980.namprd07.prod.outlook.com
 (2603:10b6:907:a::32)
MIME-Version: 1.0
Received: from demeter.ad.vpitech.com (66.60.105.30) by MWHPR11CA0003.namprd11.prod.outlook.com (2603:10b6:301:1::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Wed, 22 Sep 2021 18:53:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d8d91ff-1b63-4df7-fd18-08d97dfa50d9
X-MS-TrafficTypeDiagnostic: CO2PR07MB2583:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO2PR07MB25830E517E87FC0404C8929FB8A29@CO2PR07MB2583.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:407;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1GjR5QfPwH8jryZmh5a7oo467AluvD2KrZE1SJXR/0+DR4VJzaN5/wu07ZdPDqJwkP+LRFFqvb/S9euF9jZDV0e2+54w7ZbgNUP96IOXeGPLGnLD4OU9OdGMZgTfl754YlQRLpNn1cxFtZ9b4U9bsoHR1sSrBTS5ZG8WL0+qU/n/rWXMdvds08AdC5bOxaeOesd5ybLlmS6zMCls4oUAbMDmf41SpHIVD0L1wqypvZHjbyALi1TycnLjMftMVITQBsxm9AkmGPRnKMwvFRhfXYueW7Y0y8Dhm4fIBRjQwLYYjXrN86kWDy+m/Qx44c5Op/oWSmsqVf6WF0htt4r0b0iDnpaTyrshHkaNZKllG7KUKBQAyR0uOjTnaLqzy2MGS35tb58rzz+3O/5/m6O6yCtNMX4MLETYms8mI2sNGjbouKcPnNrX0Jaxdf4wNO7hDtkddt6f1rvJRt/rpOYah4ofnLRYg3y0tCBp/V73kgznnpHvhId9qnnt2pN+RdFGDuguiJwNykR4Z+27y2LQbHYQ8wHk8sVbaJx+OXijYQ+LrnMPby9g5dmpPK1RQ0/Ai0k2fCzNtbKWmBZz/PM+ZGfTs5Gy9W8KQCMZfppAepNUPwZZz+rfHn16gFDzd2s3AUGtk4wcBgacn4kKFXqvlI4oudUnTqtWsn+zxbCMEj8amkD6Yre4O6kWNfHKlNwyR9bGycPfIg63W9Kt6Kw6lA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR07MB3980.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(346002)(396003)(376002)(136003)(366004)(66556008)(66946007)(66476007)(38100700002)(316002)(956004)(2616005)(6486002)(36756003)(8676002)(107886003)(26005)(8936002)(508600001)(86362001)(2906002)(7696005)(6666004)(52116002)(4326008)(1076003)(83380400001)(38350700002)(186003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OpiHUth3sI0SsadPJ9NgZA7uGZLaPmz87tedD8tzQ7jur6Os916ws9I5uiGk?=
 =?us-ascii?Q?wcmZJPddkqRqsxzgNSc2VmpTkuOY6+z1/8JrJOo7uGn1r1Bn+JI+FPOFEB+d?=
 =?us-ascii?Q?6QuiCW++u2eAB/RoI5BXPocj4xSamuy1nifp2IXNF6/QdwbAlo8tfppH1Zhv?=
 =?us-ascii?Q?aeOzOu85ePCtVpllu7L3FjQER0dsJSJRI485MNWTZwW34tn0rN3JSa/2DnJp?=
 =?us-ascii?Q?3tV8SnVfJM32f8vzzeu8abKgEWh7BoEXHChhVIQu7FZSeAwstGV1mmqppyHq?=
 =?us-ascii?Q?WnUPtdDtsyTZopoWRMxTRLGI0UsjLt59N4/lBFC/n1LbJWCTkcE1kov6ejTe?=
 =?us-ascii?Q?0mW7E9K8/9MIOY0mho5jaC9iVHEd9DUafZdQnGWAOncURm2kcGkD+WtafPYN?=
 =?us-ascii?Q?eBG6oRJjmBnIv0cdgHX9oYYwvL6OWAuEyArnkmgSRhV96QlVAHsbn2Cyq1Kz?=
 =?us-ascii?Q?z9JZHydLl66kzy+0x0QU/p4v4VQ65XpWE9C93RadbWQmAFwYIXWh3QxTmbRr?=
 =?us-ascii?Q?BEhMU3jCGDE4F/mniJ7kZK/zoLMC6xm7wvKt9q1J7ISXtRrZDvEf+jluez0D?=
 =?us-ascii?Q?7A3rkDBOfRp65zxQ40M/qFGXKISAPbOlQxF/Tl99hb6q9sK8Ncg8dSbs5JAU?=
 =?us-ascii?Q?TyQ5FSAaUa9IBX1AaBkwhvniyIyIOVBuf4iWZoTKF7RTQ4k94PyhXpV5qJjr?=
 =?us-ascii?Q?PEp00wnsAAI8mzISQTriYEc74MNVw9xu+LasAMds8naXsD5LzTAioNIx38iS?=
 =?us-ascii?Q?0IQQyaKXS8AOkkltNVaBZR1amIZI7PU46oUTY9I2lw/JLyBlDNXS12VLgJSf?=
 =?us-ascii?Q?nTrpE7iNmG4P9vXjNX6K4yBaaJIUer6NrlfcQHjjYOFsYR3/QvrmfU7FyCjW?=
 =?us-ascii?Q?hmdf5b8hU7tpFSMELp53aNGhRnjyOIfCfqNtanYs846QXv0nLb6IQyp5va8i?=
 =?us-ascii?Q?9mamwgF3C+ywEKePaFNNcN7McUZr1rNMm5KRJFbuT2LYOpD06Qbmys2GBkcx?=
 =?us-ascii?Q?h3hRF/zGVty//l332+nsnqIs6CinAefFgK+SC+5ewegHGTH7wnv56vhDxk4+?=
 =?us-ascii?Q?tKUc4UbZbTc6+xV3D7iCZZGO85aOxyVBOtTdJyBNJgYzxJi3N3Kv6E80Kezh?=
 =?us-ascii?Q?ZJKDWs/9UmuvG/ZivBLtvUdPZGpGNPm7yUMQqUE4PwhBCE6/B9u5sJP2lo0y?=
 =?us-ascii?Q?I9HNM8dZCxTMRQ28AZ1JqAE86YKk983t0XAOFAOPsjTcwqsCXUWyGeKfWy0q?=
 =?us-ascii?Q?YP4hkt43OoiMgVz0tnDDt1Qza/K7LvStPr1bsThIort7uv/maxTuKQlabUdt?=
 =?us-ascii?Q?ooGZ4ZIsK1DS5pfgkIKsq85S?=
X-OriginatorOrg: vpitech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8d91ff-1b63-4df7-fd18-08d97dfa50d9
X-MS-Exchange-CrossTenant-AuthSource: MW2PR07MB3980.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 18:53:50.2504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 130d6264-38b7-4474-a9bf-511ff1224fac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hR/foyA6mOisOO5voDt0XQLz0/i76VtHA+nMWM3jz7HmoM2NBSzMk2hBz8WniwO36oqvSrQDIqbn3PB3DhlKCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB2583
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Requires "ima: add gid support".

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Alex Henrie <alexh@vpitech.com>
[ pvorel: add test_file parameter to ima_check(), add
verify_measurement() (DRY) ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
v7: Change "Copyright (c) 2021 VPI Technology" to "Copyright (c) 2021
VPI Engineering" per internal feedback from VPI
---
 runtest/ima                                   |  1 +
 .../integrity/ima/tests/ima_conditionals.sh   | 62 +++++++++++++++++++
 2 files changed, 63 insertions(+)
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
index 000000000..b76f7cb5a
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
@@ -0,0 +1,62 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2021 VPI Engineering
+# Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
+# Author: Alex Henrie <alexh@vpitech.com>
+#
+# Verify that conditional rules work.
+
+TST_NEEDS_CMDS="chgrp chown id sg sudo"
+TST_CNT=1
+TST_NEEDS_DEVICE=1
+
+. ima_setup.sh
+
+verify_measurement()
+{
+	local request="$1"
+	local user="nobody"
+	local test_file="$PWD/test.txt"
+	local cmd="cat $test_file > /dev/null"
+
+	local value="$(id -u $user)"
+	[ "$request" = 'gid' -o "$request" = 'fgroup' ] && value="$(id -g $user)"
+
+	require_policy_writable
+
+	ROD rm -f $test_file
+
+	tst_res TINFO "verify measuring user files when requested via $request"
+	ROD echo "measure $request=$value" \> $IMA_POLICY
+	ROD echo "$(date) $request test" \> $test_file
+
+	case "$request" in
+	fgroup)
+		chgrp $user $test_file
+		$cmd
+	fowner)
+		chown $user $test_file
+		$cmd
+		;;
+	gid) sudo sg $user "sh -c '$cmd'";;
+	uid) sudo -n -u $user sh -c "$cmd";;
+	*) tst_brk TBROK "Invalid res type '$1'";;
+	esac
+
+	ima_check $test_file
+}
+
+test1()
+{
+	verify_measurement uid
+	verify_measurement fowner
+
+	if tst_kvcmp -lt 5.16; then
+		tst_brk TCONF "gid and fgroup options require kernel 5.16 or newer"
+	fi
+
+	verify_measurement gid
+	verify_measurement fgroup
+}
+
+tst_run
-- 
2.33.0

