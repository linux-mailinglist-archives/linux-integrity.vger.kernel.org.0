Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E687413F41
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Sep 2021 04:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhIVCK6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Sep 2021 22:10:58 -0400
Received: from mail-bn1nam07on2051.outbound.protection.outlook.com ([40.107.212.51]:15239
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229587AbhIVCK5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Sep 2021 22:10:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PI3q5N/bFCRCpxl2REp6rjdAz0PjhfmbneBkz4I5L+7fEneMVS++lgsxQvBnyTmuzL1SX5/VdDA4/0v6a3dsIaKWADpKz66S17r+BGfzYLAqf9fQxLiLBTtXtOBrqy3/+JvrFf0+8E7Zu9T9GF1tq3tOnJ5yAbvMWPA2epl7/I3vlD6FWj1v+A8fiVwFH3MClLg6+BK6HKgmnJ0W4d3vwuo9J6jJquUvD2vc1aPm9IHYrBWWncBEvCB1ReWa9+VlvL6pX671wcHqC7feHeiawJdn4mizEWwG9MUVmc+rsNQi7az60r+8qXPzTwaC+1/nKtV5bDEUrBGV3CzMfixEyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=q82MiURpCg3wYsHmeiNsNe7Rf/gZWspLeepH6kdLtXo=;
 b=cY0jWfOcULln8t0otund3jY0o2WimIuLLVcalD9RtMz1k2EARCLb3lEI7+TlIkbRLGNF+9+76a3XKccZyFS2zM+1RdxpKcyIv8Om9YpP8ukjijHFkeLXCXq4c2w2M7lKZBp2UbPttiNSIPAr1wq4+OM+M9A8GJB5pY9E92wLeZVIndH0fyC6SbTMhysD1I1ZdDD+jZpykfJ/s15GYuds5eGoJ7S6iPrutJu1XI1ZclBhSBYxnUtbv/v0cDmLRNtcyF//WMMmKaJck6AHEDcqc4Do+Gr6ozjD6sCdYPOAy1Sz9CQOR6L58Ul7er5ETft5YfiZiAUHl5XgTBYPRv4ySQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vpitech.com; dmarc=pass action=none header.from=vpitech.com;
 dkim=pass header.d=vpitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vpitech.onmicrosoft.com; s=selector2-vpitech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q82MiURpCg3wYsHmeiNsNe7Rf/gZWspLeepH6kdLtXo=;
 b=SUerteztQvg7qzSrQyAK9/S0FR90ZltAw8ft91hyVZbh8r9Xs9sQFmGemW8SsspL84xawWc6Pi7uNrsWEGuTv5eno3Q8kBkJQuOJwzZvEBuSEv0xLld5kh1GAS6t6FZpgWhuYLLimPDQ/fNzfQtA5baV7bKD8nvj+VjzrVvtCQs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=vpitech.com;
Received: from MW2PR07MB3980.namprd07.prod.outlook.com (2603:10b6:907:a::32)
 by MWHPR07MB3149.namprd07.prod.outlook.com (2603:10b6:300:e8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Wed, 22 Sep
 2021 02:09:24 +0000
Received: from MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014]) by MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014%4]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 02:09:24 +0000
From:   Alex Henrie <alexh@vpitech.com>
To:     linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        zohar@linux.ibm.com, pvorel@suse.cz, alexhenrie24@gmail.com
Cc:     Alex Henrie <alexh@vpitech.com>
Subject: [PATCH ltp v5 3/3] IMA: Add tests for uid, gid, fowner, and fgroup options
Date:   Tue, 21 Sep 2021 20:08:01 -0600
Message-Id: <20210922020801.466936-3-alexh@vpitech.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922020801.466936-1-alexh@vpitech.com>
References: <20210922020801.466936-1-alexh@vpitech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0222.namprd04.prod.outlook.com
 (2603:10b6:303:87::17) To MW2PR07MB3980.namprd07.prod.outlook.com
 (2603:10b6:907:a::32)
MIME-Version: 1.0
Received: from demeter.ad.vpitech.com (66.60.105.30) by MW4PR04CA0222.namprd04.prod.outlook.com (2603:10b6:303:87::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 22 Sep 2021 02:09:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec431f4b-d0e5-436f-4f4a-08d97d6dffe0
X-MS-TrafficTypeDiagnostic: MWHPR07MB3149:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR07MB31491BB727F8A4E6D202132DB8A29@MWHPR07MB3149.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:130;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hsWjKml9r3E4Ni0gohMWKLjI9K7E7FLiPPShotQxFtt5ng4JieHcsYNs9l2iW7zqyLTYKMlnZmAla/R9qrqsYc8WYcUq7VDCc87GJRGeFmcxHu8KLo/x43lc4nTalefMBKC7tDu97EM47UDgriSUB/Tny3Vmp2Eu3nXYC4mA2BgXNAXjJenuWGfAhiz0vodELofD1O9cCJ+8h9jZB4wGu8ZP1DNunPO1K8QsNIhdgoCIP+9lwczzdxsX2IEz+euI9s2m4CgnGfV+XzwG13MZ+VpT44mfOWjz9WgXmUbIVZnU+vsXJhrXTbdOJ6mosNEWGA6YKiS47SZuA4eQC1IPmKgtDpN66tSX0oP03KflxAFbEVQMcVS1IHE9H8vr+Ut7eFUUFxWf7DL4abK4IONsCxuT4ECKG3xzxit3z7X9cZBOLLo30VGS8rV2/wHeqzMpUds1MlHLejmwQRxHH/vtZmHF0/SLfxUrGunm9lnCrY45euoE8e4X8v7w7iHMYKl33zuKdKthLJCginZbVOI94ivH+RseuRbKymAAkNKRIzh+ms1tc7YY/oa0J++La+R+Les5Y5qTO++8CGaMrmi9UGPhrA00k5Fz7lsBQpSZ2jqlbfuAPIcSnLuOPv00fgPylJO8EUYyd3NaWUX/SZN+FJrNm7i5uSCtju3WMhjLN2AwHqktj8zDUUu+Q41r195/SAtJ7A4eNyBoowp9UHTDiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR07MB3980.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39830400003)(136003)(376002)(396003)(366004)(66946007)(36756003)(66476007)(66556008)(1076003)(5660300002)(52116002)(7696005)(316002)(6666004)(2616005)(956004)(86362001)(2906002)(83380400001)(26005)(107886003)(508600001)(8676002)(8936002)(6486002)(186003)(38100700002)(38350700002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+aRfdaR0yGwybwSgyBrGnZTVIIvZVLTuAxzsm9h641HuOQWwmVdROCkVMWt5?=
 =?us-ascii?Q?BOMjBopkRPw7QOfkbpIdMM0uwcjUTmRMORpnVU44CyorqKEo84Hl8nnJU8ce?=
 =?us-ascii?Q?Qvrz13imaySvAfF53e0jsENAsDkoVlPUPwdW8SsyfkxSNCxzSavDHjuFPONY?=
 =?us-ascii?Q?SKkaTtVfu1R8wVlDVQi1NUU9eCTldIvS5pZxuzqvY0nhkoKNI5Dq7/V5MHf8?=
 =?us-ascii?Q?rMJiUmR7BLYTN65voZZREErMLVNl8nGm/+Dms+lSn73o4kBI0b/d/9gbQFfH?=
 =?us-ascii?Q?JThh14rqfTowFJjcltq10NrSiHowDS0THpKNPQCX/OxIcbqsTN3VnRB1hv3u?=
 =?us-ascii?Q?AhuqiZ6adrPVfGKPjIwguhcRvXNDr3V3yvNQTgYjfmGfPWvxn2/rxe5jl6TB?=
 =?us-ascii?Q?DXe5U6JTJ+/7rBq1ebEntvfS3tXnz6dHv+hX2TFc7I4mhwvDkQ7yqXst8Q4w?=
 =?us-ascii?Q?1reXIzFeUQZeGtKrhh5uzv6TMBzYdkwRD6XqkTBI6ckpoBV1YvKDTg5+Ri4/?=
 =?us-ascii?Q?xz9TTN85YnmcZQOTqEBupW2C3nWSFEYe8BZ9Sy2tMyEbl3UWjoOMgsivlvp1?=
 =?us-ascii?Q?0KBKK2TLqB0y4xwvAjcpSIC4DRdxPt+S5viQgqnnbaJ+tkfK9jaPISmQ0M0J?=
 =?us-ascii?Q?Hy+Jqt7ZZslSQR8dbVhl9bbWfmqhN1nqvyNkkqgl19AdsebIdVxizjT8oHHi?=
 =?us-ascii?Q?7auo47rwHRXsKMFXa4oWT7q0vTmrsXF5xV1nK3B/CQXzif0uY+7jm3VtYv+F?=
 =?us-ascii?Q?PrdWNIl8mns3RBmkuB8UdmSGM3u0xqCE7rH4+aWZ6W+/D2M37yFK1sPeCjzT?=
 =?us-ascii?Q?GOXtSFKQ74bLNFEyGdyq/rnzxOdsElJxeSYnzRI9WX5Ka4xzNk46BHcy/IJO?=
 =?us-ascii?Q?/wrCa0LHqY8uE+3bImpc9JCZvDiUqnNG+Ni7q+TZZYHI9g40mNk14AXD+kQ6?=
 =?us-ascii?Q?6Y/RN08QZUuT3SKS6MOSPsVfHdd442D1KY1dVnHWR0utuASbaGKU/C2Wp6dB?=
 =?us-ascii?Q?ukX/kHOMxZjblo/mN+9pXJn69d00ZwQOj3id/PnFf6xEE/SuEjkxQcKYT3zR?=
 =?us-ascii?Q?L0n3gRRSdMzQWRRIJjxFDmHg10aADbPJLo/RUSuQ5Gu39C3G61vpa23hiytQ?=
 =?us-ascii?Q?GFSf5wTmK6F542n1dfjWtvjcWUpt8Wo66wQKRz7obSUAewhNEnIvxPbC//BJ?=
 =?us-ascii?Q?wvF1MKCeQLA8z6k9SqQUUZWFVq9TNrUAoBA/VnaNYThGsM78Q42Kl54j4CXA?=
 =?us-ascii?Q?69DBacA3AlsgbzaTktY/hB+kJ1AyawqBPkS7TP4Y5tQCe3PAEPTA+K291pnH?=
 =?us-ascii?Q?hGXupb9p0aBXT6hoISXrJF1x?=
X-OriginatorOrg: vpitech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec431f4b-d0e5-436f-4f4a-08d97d6dffe0
X-MS-Exchange-CrossTenant-AuthSource: MW2PR07MB3980.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 02:09:24.9042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 130d6264-38b7-4474-a9bf-511ff1224fac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAdM9Z6v9Z7wePpFXUxGSn1MqcM4FXXDcBmt43k1wDVECqmAf6Vk715OiN85OKt/WEoWPy9Z7ArOnqUBf/Wl5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3149
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Requires "ima: add gid support".

Signed-off-by: Alex Henrie <alexh@vpitech.com>
---
v5: Omit awk and cut from TST_NEEDS_CMDS
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
index 000000000..657f4d244
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
+TST_NEEDS_CMDS="chgrp chown sg sudo"
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

