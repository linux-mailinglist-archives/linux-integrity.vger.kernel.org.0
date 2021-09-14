Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD8840B44E
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Sep 2021 18:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhINQRR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Sep 2021 12:17:17 -0400
Received: from mail-bn7nam10on2086.outbound.protection.outlook.com ([40.107.92.86]:54689
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232267AbhINQRQ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Sep 2021 12:17:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLlWRc8v9rVtGCL9Nph2rCo4Nu16fMiydseLkIH89vf+ix8E7VtdpyTpVBja9YuniF1Bf2KqWoNOg4gPV40sI358q5a0WQj/p2Co5P0yXow+ckdcFhgzf9s9/QLImaKc7d3riLDNYjoNpJmAXGFXwOpleH1tPPAbZVTBU9hBhing9JlGdKLekincC/AvoOcZcJhTdb5uOgsxpJrnxbMpj5tIZ2u39lmf5wQelZa70WZdAMQ63bsJgh07jUe1Y7aCbILBkIG6ntjqiXuXXjU+fHOCgcIK52MCx2n5kTbdyb1BDhDQCSCZHlO/Zl+x8xAyn3OHQi9UWVFDOfaMhT5PDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=B75C9ZMjt0z37Rq6pJgKMlHMjmaTLs+HKjNdhcv27NE=;
 b=ISpoQp4u50d850R4yXGK0X1zxCyr8yMpDsYwcVVsTv4Jqz63DcE9CHf0x6NZHBMb6NQ5lOrCSQzJZi6alGZtCRoy//o9hbsXkPYt4rhLBNcWXxpRKwmJnKqNWu+JKHEO8ciWLyA0Yq0UnX2XSs40tRknK4QvNQDDJHr/AunzLjDXD8NdqX35JOmtQ7/1s7cBAnXElXolMi82TDo4wiGGW0vJgTBhmDysdiInY+37tal5U6SKOv/ThfPtpZvEdpItQfbp4IfzawddScQTdn1DuXEpu1n/ICI3dWOe6aqnnFDDIlBSSB4ANP/aGCKcO3+jSNvtmb4wMLakqj9Ao/Mgkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vpitech.com; dmarc=pass action=none header.from=vpitech.com;
 dkim=pass header.d=vpitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vpitech.onmicrosoft.com; s=selector2-vpitech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B75C9ZMjt0z37Rq6pJgKMlHMjmaTLs+HKjNdhcv27NE=;
 b=eni2YHOqc+FZuBAJwxIO2/I4St58l/4XuFrDvVRhXZx0DXInz3p/FZep79JZEPweIvCDHOyui9vl+MQ78BKqkafUKbPvGpio2wq9XD0G1dq+2zjCeb0bin9UZC/hR7y3JZZqpfhEbcWUqj6nEEMmHlftMHSxxZrA8KliI+TVsdA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=vpitech.com;
Received: from MW2PR07MB3980.namprd07.prod.outlook.com (2603:10b6:907:a::32)
 by CO2PR07MB2615.namprd07.prod.outlook.com (2603:10b6:102:13::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 16:15:55 +0000
Received: from MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014]) by MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014%4]) with mapi id 15.20.4500.018; Tue, 14 Sep 2021
 16:15:55 +0000
From:   Alex Henrie <alexh@vpitech.com>
To:     linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        zohar@linux.ibm.com, pvorel@suse.cz, alexhenrie24@gmail.com
Cc:     Alex Henrie <alexh@vpitech.com>
Subject: [PATCH ltp v3 2/2] IMA: Add tests for uid, gid, fowner, and fgroup options
Date:   Tue, 14 Sep 2021 10:15:03 -0600
Message-Id: <20210914161503.97495-2-alexh@vpitech.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914161503.97495-1-alexh@vpitech.com>
References: <20210914161503.97495-1-alexh@vpitech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR11CA0037.namprd11.prod.outlook.com
 (2603:10b6:300:115::23) To MW2PR07MB3980.namprd07.prod.outlook.com
 (2603:10b6:907:a::32)
MIME-Version: 1.0
Received: from demeter.ad.vpitech.com (66.60.105.30) by MWHPR11CA0037.namprd11.prod.outlook.com (2603:10b6:300:115::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 16:15:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0de38125-f4be-440b-6fb4-08d9779aedf4
X-MS-TrafficTypeDiagnostic: CO2PR07MB2615:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO2PR07MB2615C72A23C83DAB9BECB10EB8DA9@CO2PR07MB2615.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cdZJUz1skFo/DxRLY1xJrBLd2oLHWZuKj0XdTO2GDT3Pi5xZsepZQMInHZPdHYlzhBdjFUGzk4tvonEEtLqeOpVJJQwFwaLucn5h6QbwMcg52m6VPSnInv3BCuDTqfP9f0bTAwU2drtRGxRCGM7n8Kae9bE3YZLhxQM02mFLiMLQ4iX1kfh103JR8gxObh8TLYlAXQa3O8ShX8+s78uPJKlLYtJky0pijeTRHzRB4EzApTyD91cmmcg/hwmDSb9v81Ar9WXlfga5Nc/iAVDUaMH16YLzsNtfHyB/3QYjTE/H2/Jf+Zzg9A2amoE80UmgNCNAA/c4SpgjzB36W41XpiPZlR0jMvU0qaZFhePiJfk4NUJUKR32tBBLtrvsFSlBs8KiKQws++dK/5jkJmXGK2gekyG4aX0F2DgV4eFuP0RusQPEWE4CFNPFOKtA0lCMWYdSJglKhghxOpMmd9cfERZBaG8QKgWnvBOfSxeyv1Y7jUfDuFOE7A1+0/ofIISufG8MFxxJFxcigjPDzlMX/1RVUIsiUCQAALDbEs3vcSDqhz5cbzF2TFChjej2KttTSLfIlGOKIDQf0wfTBGliiHJVpVLWeLt2WHIqVABpOREGd0bAu8e/yeCduPZCjGsg5USFEcJco+Dqp1SaVYfdMBjVVpYEuKHxoFPZlLldIHG4PVx07WnR0GyJ99YO2uzJ1ZtG/jXoU08QO/nOr/dWuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR07MB3980.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39830400003)(376002)(346002)(396003)(4326008)(6666004)(6486002)(36756003)(66556008)(52116002)(2616005)(2906002)(66946007)(8936002)(478600001)(956004)(86362001)(38100700002)(107886003)(38350700002)(83380400001)(26005)(1076003)(8676002)(66476007)(7696005)(5660300002)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IzVTStWXJXKy5JfhAID1s4CXrQ4uhA6rFy7CSKCE6Vz/clbCZfGyI4zuorMr?=
 =?us-ascii?Q?oz8ljMFoUdljsEhjesjnrke95n9k6/3aMDzKxy8IVG6inZP3QGkSaDhGMRzl?=
 =?us-ascii?Q?oNbXW1izSNzFodMhlUYGjWgzJ6xn/Hr9TYU7/PN5CMIgGxpWghuBWzaUemPh?=
 =?us-ascii?Q?bDYZdw2tzJgW/4hBUXhlCMe1M1bVIm8Ki8FNYu3kqZjN09QCopXWcgCjip1+?=
 =?us-ascii?Q?AST6gr3g1Tbq3XVFvQ1l5kvzE28u97NRoaM5Fm+Jy+qGVdz2mb6Gv36t7JQi?=
 =?us-ascii?Q?brbpmLQOxs838UhtRGDd1EwsyfxbuYTsB22rN7sD0iE2PDamFiTiUdrhR6ul?=
 =?us-ascii?Q?azVu6V/5lwYxYfF2aI/ro5MKICmfrzSQX8Nbr5VWXC9Vv2OMFXfPX1EltfHV?=
 =?us-ascii?Q?gL+PD8wOeJH1UZRE0ZIRFDzAsXJHg2BNjCkz4hPO88NATwnpCsBct66zQF1v?=
 =?us-ascii?Q?AYKbrvscboIxLmrOVVWOitMuBa+yvNnyNAn+KoIEoLSe6YBVzQlS0oESOcHj?=
 =?us-ascii?Q?wJsZluBYNOOhg1Gi2qK0ebh2/ODkQjaZWNNLqTKgzrHa/GXXw+pftO6EtUoe?=
 =?us-ascii?Q?VpYLJf82BAo3apMfJj0/JrWVp22VnsQ+qGsw/qIIbCb6KGGax8EQmTI7GX+0?=
 =?us-ascii?Q?kJa+Mj7/Cu/dk4D8wRjMO411GLgCJ2EkctZ9NACImT4IsJAWjM9ES1JCRkh6?=
 =?us-ascii?Q?A/wCucpXz0NYFE7FhWpmv0zNtdxEqSZmnidHhCdOuqvreWNBaqX+TfSO3PzJ?=
 =?us-ascii?Q?jidmrofN68baEzPN1c/g7mKbNrfYi+jHj8LSvpp5Qss/mpgQvjzOVoM9vdrd?=
 =?us-ascii?Q?C+5AtQF5KCsmsl/hGHP6Yo2WOTWJIjvLtITeEeD2z4pJJqyIX5coJqiBkrje?=
 =?us-ascii?Q?nL2imOqlw7fzu+FlflhTCiXZB7kagi6DOEuIwWab4r4NBUXmzGTaDe3MPpE3?=
 =?us-ascii?Q?HvgKD5qC6fgwluzhjnQGhD/JvThBPpNfU17vgy8Xk2w7Arj9X39q85u3B6lR?=
 =?us-ascii?Q?rsv233mZXO1k35Iy7qq9LGB2f0Xw+r8TuLJoMuBP7ebl/WbK5N12mTbxRPAq?=
 =?us-ascii?Q?WRoPlZVwdwGnzty1AbjBzZeeNFQi4EEzwrO9wAaCjfnxiyVXlvzQhX5Uf0co?=
 =?us-ascii?Q?RodkW42RD4n2LR8F9Ai9uNWqgp9u91+iWzk0fCTFIn+v4GL0fY0y5gWWuhk+?=
 =?us-ascii?Q?JfbAqfxYnJ/jsnRFYx9QX6cOqM3BbX2VOpcS/vq5qvJYKmRkjxqPfkHwJs2r?=
 =?us-ascii?Q?I25w87TlHBp85RiNWIQmpzIIGst7yG5Dawzod/OUuAakRYItu+5vk4CDJ0yY?=
 =?us-ascii?Q?xy57KNTcFMnOj34LdXivOSNK?=
X-OriginatorOrg: vpitech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de38125-f4be-440b-6fb4-08d9779aedf4
X-MS-Exchange-CrossTenant-AuthSource: MW2PR07MB3980.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 16:15:55.2093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 130d6264-38b7-4474-a9bf-511ff1224fac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92OzsKhOHBio8uhNFhUGscAQSPt7BFrpUFHVlgMqbAy70TzhmjVtdattBpnLrK4bUPtLzSJfl9uMF3fl0WNdww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB2615
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Requires "ima: add gid support".

Signed-off-by: Alex Henrie <alexh@vpitech.com>
---
v3:
- Put new tests in their own function
- Don't require sudo or CONFIG_IMA_READ_POLICY=y for all tests
- Increase kernel version requirement for new tests to 5.16
- Delete test file and recreate it with correct ownership for each test
---
 .../integrity/ima/tests/ima_measurements.sh   | 49 ++++++++++++++++++-
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index 1927e937c..5d22d12d3 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -8,7 +8,7 @@
 
 TST_NEEDS_CMDS="awk cut sed"
 TST_SETUP="setup"
-TST_CNT=3
+TST_CNT=4
 TST_NEEDS_DEVICE=1
 
 . ima_setup.sh
@@ -103,7 +103,7 @@ test3()
 	local file="$dir/test.txt"
 
 	# Default policy does not measure user files
-	tst_res TINFO "verify not measuring user files"
+	tst_res TINFO "verify not measuring user files by default"
 	tst_check_cmds sudo || return
 
 	if ! id $user >/dev/null 2>/dev/null; then
@@ -121,4 +121,49 @@ test3()
 	EXPECT_FAIL "grep $file $ASCII_MEASUREMENTS"
 }
 
+test4()
+{
+	local user="nobody"
+
+	tst_check_cmds chgrp chown sg sudo || return
+
+	# try to write to the policy, then check whether it can be written again
+	cat $IMA_POLICY > $IMA_POLICY 2> /dev/null
+	require_policy_writable
+
+	ROD rm -f $TEST_FILE
+	tst_res TINFO "verify measuring user files when requested via uid"
+	ROD echo "measure uid=$(id -u $user)" \> $IMA_POLICY
+	ROD echo "$(date) uid test" \> $TEST_FILE
+	sudo -n -u $user sh -c "cat $TEST_FILE > /dev/null"
+	ima_check
+
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
+	ROD rm -f $TEST_FILE
+	tst_res TINFO "verify measuring user files when requested via gid"
+	ROD echo "measure gid=$(id -g $user)" \> $IMA_POLICY
+	ROD echo "$(date) gid test" \> $TEST_FILE
+	sudo sg $user "sh -c 'cat $TEST_FILE > /dev/null'"
+	ima_check
+
+	ROD rm -f $TEST_FILE
+	tst_res TINFO "verify measuring user files when requested via fgroup"
+	ROD echo "measure fgroup=$(id -g $user)" \> $IMA_POLICY
+	ROD echo "$(date) fgroup test" \> $TEST_FILE
+	chgrp $user $TEST_FILE
+	cat $TEST_FILE > /dev/null
+	ima_check
+}
+
 tst_run
-- 
2.33.0

