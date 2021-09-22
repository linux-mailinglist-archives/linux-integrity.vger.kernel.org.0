Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F02413F43
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Sep 2021 04:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhIVCK7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Sep 2021 22:10:59 -0400
Received: from mail-bn1nam07on2051.outbound.protection.outlook.com ([40.107.212.51]:15239
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229734AbhIVCK6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Sep 2021 22:10:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S98XOJAj99CEhaiwnW8vkKvQO/ccnEnY6VuKTlSng5UKGWucqDCa8U/8as1VSNmjPmW+Cv2m3E8hvBP5H/f/+VlFRQvmCB+q3EN+dLmaqXzb5U1IVspJuwAOv3yTFJQwGz8A50UjT7K7g7jyshtohAV8K0Yvcld1oHcQcDGzwkVE3AKy38l8XslQVOqstfUIpA9C2vpT2AgMs6+YCkFIJmN4+eWznBsWgjliM7UVcjsYvUGk6G7CwodSOgs7gd+ofRs6NFPehFoAqW7e3KxPzMQRvg4F5a25lKahHZCiNE5b+QJLnCRS9AkmIcVriNZwUGocmcOi0XgWnfoEfXVIAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=94+usKn4g49TnEjBKT4BXod0UFimzkXERUq4i/vApW0=;
 b=l8DkTOl2nmrd/pLt6Itf2lZ65z1g17Qr/QWBxgOZHvt+WJd2BA86MFo3zvnYDiTgdiHi0H2qoWZXv3zlL8AsxXg9feZaEJdkLfs8eUls68V9nLuKAWkwtIqoOZrnSo0G6agvME0gogFgNDCZ5taRANsNlshqHvXzj1xyrBOyetzHho+VVTcS8jmiKwLxNrFzGE7D8aooXYz62H9lxN6ntVpBDd6ZzfnXWEzgkeukkwUxmxShGFAiT/ancNUsZlZdBynyr7rkt2hp4C4keTM2qoq2w2LPEb8XBzNjBRqK+HdAGjilJCoPgmdcHWaiA/WC+Vxqh3iYJ8DnMFB5z6YS8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vpitech.com; dmarc=pass action=none header.from=vpitech.com;
 dkim=pass header.d=vpitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vpitech.onmicrosoft.com; s=selector2-vpitech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94+usKn4g49TnEjBKT4BXod0UFimzkXERUq4i/vApW0=;
 b=PfOebaN+mV5Mg1WIrDH6d+u1alZsyrlou/iDlI7mAmFFl1jqF5PHfOoohvXP+iAvbrSVYJaRImlgjnYmwxREhDiqQvOy+22uGfiXUW/KpS+r5MfnP+fwvFQSz1YpgjJTYtAJfauP2c76z6ukpg3uvXep/I8PhbOyVmH3qrtD8Ro=
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
Subject: [PATCH ltp v5 2/3] IMA: Move ima_check to ima_setup.sh
Date:   Tue, 21 Sep 2021 20:08:00 -0600
Message-Id: <20210922020801.466936-2-alexh@vpitech.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922020801.466936-1-alexh@vpitech.com>
References: <20210922020801.466936-1-alexh@vpitech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0222.namprd04.prod.outlook.com
 (2603:10b6:303:87::17) To MW2PR07MB3980.namprd07.prod.outlook.com
 (2603:10b6:907:a::32)
MIME-Version: 1.0
Received: from demeter.ad.vpitech.com (66.60.105.30) by MW4PR04CA0222.namprd04.prod.outlook.com (2603:10b6:303:87::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 22 Sep 2021 02:09:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2d49815-71c9-4763-8b6d-08d97d6dff6e
X-MS-TrafficTypeDiagnostic: MWHPR07MB3149:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR07MB3149781E61E7D7EF87C4E009B8A29@MWHPR07MB3149.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pz2wpT49GXqs6fEC4jAN8zntuXePnUjb4nsziZErWYjkBX8N0OmF0gF6ollfT2WK1UO1c20qp0BvU9zvNIAtOCaPVXLVP6PnEcWQyvfwPY+860Ny22jfDDBJ0cpn3n9IH5sej5ac1ZY+Mu4Z5MLpdXBp6rnDFBeo8LR/bjMztdz+OAyyN1+cA+zI6KQT1NiitLMltVOrtGrK66Nyv+zi5VR18e5FXGYBM4s5pi99D7KBXm3feTN70cBXcnanJPiAtYPc26rxfztCnlT4qEczU5rrcb7qoFFttlAYu7Yvi7/OH9EK5lCRCGTKXkPcTwho9fkRWc9LCWCQfEbF3xrkHZ4tybSle9XCZJa6/z57g2dXPRcKuJhpnLVwAm1Rqe2/nyGLmhEHs4K0w/603HigY6yTveAgohENNsbcYwtdOqSAbv3tkGPSFf6iykV0rwWS7tjqR8mv2CMQYYofLsC+IYtcoMK3Nv1J5qDBoOX1qcerKgW/z2mJBzxXCtB4Ei5vwn5xsWMj+fO1ALH2CNoMLOnsFycFZgIj8tiimNdK8cxANIWQqiIiRe1MgRub6AolOzLTZiQ8nDGnDu4BHh/Y0TWVY8FPwqrLHQ6/u9pkAJaDr625ttUwDSQYZWML9rnPcvYUVklXNkKeZpHu6eeOEnBxAVIZqr3QtdZ1rtMh4cUZLF1JQX67E4DqgisPjhI6vjYO4D9ASvCETcLh/vz+hQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR07MB3980.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39830400003)(136003)(376002)(396003)(366004)(66946007)(36756003)(66476007)(66556008)(1076003)(5660300002)(52116002)(7696005)(316002)(6666004)(2616005)(956004)(86362001)(2906002)(83380400001)(26005)(107886003)(508600001)(8676002)(8936002)(6486002)(186003)(38100700002)(38350700002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qOLFMxyGJ/iwhn7LmTClh6MIQq6FCtNbOZkF+lyFEoqhWI0F+XN+oekXCIzV?=
 =?us-ascii?Q?EA4ACfX904cc903F8OqFShAkG+E7hhMhy8JtW82geLsEVvY8raZ8qZAClLgP?=
 =?us-ascii?Q?EyWGddfq9EyJJbYGb9Q8NyO0mICTWO6pCwSue7TdaIgFJTFgOvp8/NN4Y1HE?=
 =?us-ascii?Q?4HUpfbed/eKH4ycK0vqurbzqCFPOto7iyneo/oJQD2BWWzY/FU6TwZe6mgr7?=
 =?us-ascii?Q?5XOujRnLK/tnvH0YXvouJsxfLpmoLOYaCoOIwDJ9yvHqt+f4lwS4PbU//My0?=
 =?us-ascii?Q?bWm22dMlA7xqT9IE3+2HsdQmT0RydtWc6ds59VuuSs1qCuJZ8vjELqpeW+03?=
 =?us-ascii?Q?+BNLqv2BbY0fC1Q9iEzITepNWmYj7K0aB6v4LLSj3a1ZD3iw7zhEo20BiUa7?=
 =?us-ascii?Q?kPLICL9/kGRiJ7dWbtKAY3XUi9YbmL7x2HEeb+yNBswSf8Jfc+EfeJXHXGFb?=
 =?us-ascii?Q?z7DkYByyKmMl6RQ3BOZ3npOljma6CiN1vBg41FyDjF188qKdfaDb3ilLhfm6?=
 =?us-ascii?Q?Xnh7V4dzBNBo7uVM8q4ysrkQrd8vvVpnTHUgNaBgDFh1dQRPkU6WqurquwaA?=
 =?us-ascii?Q?fgW2fsY52pmS+JbzPaPXmkqUNc/CIJouXI/5J2HzTTrFtSTNHoWYdUKQ/fA+?=
 =?us-ascii?Q?ZRarkvInxr886eSWIi3Xxn8BTRbsiYGgfmHFE5NNZve/rSzxMklkqg71kqtZ?=
 =?us-ascii?Q?0RGiBb311eNuw7YDT4qfkxAoQ5CLiLKtYqBpXzXQgBAfZEYcNcK++sktsmJP?=
 =?us-ascii?Q?nH7zGWvyEHWAnFBilYPDtvah5er6JX+B8ED1wCocD0o+FANCWWiEb/JsFceP?=
 =?us-ascii?Q?B2f+RMobGVeimkPwhVggtxAkze7wQKFeJBoyC85f8iLcp2I0GpL9PJdgZrlH?=
 =?us-ascii?Q?KygmYMQ79S9E4Dh6OaId/EeAk67dCvQpivT5iMnOMxTRKYtV+cHQcRLaAQiE?=
 =?us-ascii?Q?vnOukFYIsQoDQSMOJDYxJrZoBznD+NlGUgwVMOc6cR9MOal/mXQT3wqCoT2x?=
 =?us-ascii?Q?FQN/UNbm5Neh7Le06NAkUZoSutGFnrwfbD/Avi7nx/SkNaVyU5REJ9CHxph5?=
 =?us-ascii?Q?OO01FPiEBmluTgYnIlUR9kSaftShmMZhVQs4JL8TJh6RZGXPFpClfanr/7q0?=
 =?us-ascii?Q?bAws9hu3YwfJOGGm1wJVUpyLiEy+pa4+HwYOOxXbZJt17yBurxtne4JQKHup?=
 =?us-ascii?Q?BdN4YYJNP/u5bS9GvEE4ROpHjl89ExHIOFJsBPVM8ygPbjm+0spL1ALwvW4S?=
 =?us-ascii?Q?6NlJM/aGkuSKkEnCcHeLIGEaUzNG0m8v9BTxkZeIP9nbGsJQ/zYKm/uxtAbD?=
 =?us-ascii?Q?8JnHtigZzPJW3f6EYokS9Jie?=
X-OriginatorOrg: vpitech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d49815-71c9-4763-8b6d-08d97d6dff6e
X-MS-Exchange-CrossTenant-AuthSource: MW2PR07MB3980.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 02:09:24.2756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 130d6264-38b7-4474-a9bf-511ff1224fac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSXk4eJm3M7vZysFfgSUHrZnECGB2b4h78eJEyB2oE1nZUrupW6lR/pN2ELDUNiHOuaOuKYwYyZJbeJmGLVl1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3149
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

