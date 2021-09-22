Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F3441502E
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Sep 2021 20:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237093AbhIVSzV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Sep 2021 14:55:21 -0400
Received: from mail-bn8nam12on2059.outbound.protection.outlook.com ([40.107.237.59]:18849
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229732AbhIVSzV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Sep 2021 14:55:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSdoCzWKilIGI8szUboG53nCE8S81VUkLTSc8roWja1Fj49dRjlNm33EHBQoaCea9BqsvObv96cd2FJxtOMEZUJUEfKgWBe1p67FZ0gC4Ref1irQkh5yOhcnfRk46VobvTx4mErYAIz2eV3V3wI5cY5yYi9Dy628QYD7DNkOAnUjCVXQcHOIU11WcEtlT7p877k3ajAjtLmB/DGKcNqILLhon6CjIdbwY5WxJPZ2d9OaYJyp/MaRW77BDeI7r8C44roVxcLlBhS9xBcIjsOloA4SnUTZWAs0hoIqhpAddWNKtS8QGeYFKMeeDuTsuEkwvR59rrPgpT9SHcz5pl+XdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FFVn1DKOblYdEdj04d4Cm2PlRNS0ICkUe5wxDKXg0Pw=;
 b=VyuG5U6Ec9Y9HZTS1uE9I7byk3yOk9Y/eAJzDPv5oSb+BsVf2MddhHPWK7RjTdSmDQ/9UlH7XBjzuA+/x/zlE9PDT0O8n+p7QQSiC+La5x/2YEJ/BSNjKWfYmZCHW+q6ARRdmuWtmdWbV56sGmCcrE3ZSNe1MRkL9x0fDGgQuo+qDlTVSuikBBiOY/eocFfkv+iOaGrvIe3dPg6mkf+QRKHKXVav1FqkC8y3/atG2yGnWeLRsukrky1S6Ctww4jCpoFWmAaxk74VtLBGYydomj8zOEN5Tx36wClWkMdBSG1qfqpZpRH6g8t1Dtlv/aAwcaFQWM2Ud06arVYcBeNUXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vpitech.com; dmarc=pass action=none header.from=vpitech.com;
 dkim=pass header.d=vpitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vpitech.onmicrosoft.com; s=selector2-vpitech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFVn1DKOblYdEdj04d4Cm2PlRNS0ICkUe5wxDKXg0Pw=;
 b=W8rnFp985Cv09zC8vNZQ8B/gWPz3tWbWi+OOFseIhFUlKE+Rhuv2FYAlRtnR8ajNf/pyjZfz127v3Op9wqpJuugOB5nVWQ86tYaCcVraO7KP8C+W266GdXNSS3Eh6Ve1izb01swCC/zRQOVKnoKPiTp5wfpxGdUep9XW4VVrKNA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=vpitech.com;
Received: from MW2PR07MB3980.namprd07.prod.outlook.com (2603:10b6:907:a::32)
 by CO2PR07MB2583.namprd07.prod.outlook.com (2603:10b6:102:a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 18:53:49 +0000
Received: from MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014]) by MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014%4]) with mapi id 15.20.4544.015; Wed, 22 Sep 2021
 18:53:49 +0000
From:   Alex Henrie <alexh@vpitech.com>
To:     linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        zohar@linux.ibm.com, pvorel@suse.cz, alexhenrie24@gmail.com
Cc:     Alex Henrie <alexh@vpitech.com>
Subject: [PATCH ltp v7 2/3] IMA: Move ima_check to ima_setup.sh
Date:   Wed, 22 Sep 2021 12:52:31 -0600
Message-Id: <20210922185232.492879-2-alexh@vpitech.com>
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
X-MS-Office365-Filtering-Correlation-Id: cd74e3b9-b01d-45d3-2f04-08d97dfa507e
X-MS-TrafficTypeDiagnostic: CO2PR07MB2583:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO2PR07MB25836B43D019A6908C085E3DB8A29@CO2PR07MB2583.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tfS1skhjd+cJL6KzAnUIe5xM13q75Y50JLqDzv8f7n6r/xE462gpklml6eXJizoDrMzxMhRb7RGfC9TFqWLgdbN+cjmDjvmvwn9voZDp6BpArpjt3i+z8nZV7mTBMhsFvelgeiTTvMaMemNSCellQfIlRzuqlsauXc8gE2U3+7Fe0469IH+JcXZffjR/GFKf+9OCWT4Y/OQV51yMb+3oVLCHij5RqzRzvL9LnvqtnjseVFZIflkUOewkumY3zj1RFxRaxZEqM6EXmFVi8ZA+Nd4cPvnKy59tvTs3yxlRsJ1Px00YNip3DFs/9NJafDDAJj8WONGZKpdJpwvhRD1lLsysg3twQARR6hjQQ5cFc1VYBOSB+rGtz9ZTx75lxwVCswuLvYRkbF+ood++cLn2hCkBmXbvV/mrVb+bi91uoqcz6R24OeEO2F3sHPvKJAhENpPvT/VDrg3Al3JclbYwtZ/Y6xm6N6Qeqj+cxPaCzcnsRkQIjPxc2BlBKjOcny2dLlkHghGqgsg2xcVF8u2ePU5cRE5ZyNv5Lr2gTwBXZFgb2mEl0EslqnESvSDzJt1o1pxreYbgYZQUYSL34yLW+QLMrcFHDWtce/Uyabw5X6Z+rmSjH5OhPI5MEi8H3RfFz/hREOhNZscS2oCbgKhcXS5w9G0vXjCysbzxJa9DfY2P36jhnKqOWk+fslBPYPc5hY32fFwnt2GBMbHDkma7DA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR07MB3980.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(346002)(396003)(376002)(136003)(366004)(66556008)(66946007)(66476007)(38100700002)(316002)(956004)(2616005)(6486002)(36756003)(8676002)(107886003)(26005)(8936002)(508600001)(86362001)(2906002)(7696005)(6666004)(52116002)(4326008)(1076003)(83380400001)(38350700002)(186003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QUE7OrTGC3HDRxpCw/7shjbyJZztanE2Vhrb80/uDNzBTS1wOpKl7ib7UyH5?=
 =?us-ascii?Q?YiMA33wUsAvdqhYIxYZtTIHKzkHikWa4sjCqz3mabeP9Kfj3GPlw237Q8+oW?=
 =?us-ascii?Q?NvS2//4oxB6Hx9dT8RjmxJvKjs4bCyhoWaix9/9taTSXDBewdgmAiTZE1G9a?=
 =?us-ascii?Q?U7g7WDmz1VGVBw+f2ijp2NBX3oc9/t6rKnCjwux1AUiU/7tz8oWizn9pZpoc?=
 =?us-ascii?Q?JiSxnbbvsFY42XgaEeOSuJphRyRxFFabR0HNy9PcC9fEeQ2PoMli5/ALMvka?=
 =?us-ascii?Q?X51phcC2sibi0wvwkR7lWkYWkM3ueq+QRTFsbHImIpsWUJy/gD/A5FO/QTDu?=
 =?us-ascii?Q?44zZ89CRZTpiA6g8xdOFKlwGO368MCTXAk21gLWBPMN6v3VtaggZ4DcfTHGr?=
 =?us-ascii?Q?qvhQYPVWyCp5mX3hi1fZS3YNuHRqUSoLptbTxUwCaKFPA8l2IIZVaRS1gepe?=
 =?us-ascii?Q?ysLuR4tGd14LCe4PI/gkewFtV84/lhK2ikFKJ4CwmpSGML9Y7GTztvn77Ytx?=
 =?us-ascii?Q?COOCnYerYoEJo2a80JkRKiNybidGkGNGa5vtjkN/H7G0ITmV/ZUgP4aKRNm6?=
 =?us-ascii?Q?1WbUKQyjB8P4q6VJ9IY7bgIuwtrMDCqbq8BtyPtnQUoZZu4PyweJT9KLWtyO?=
 =?us-ascii?Q?dyZvHrZwzNgNW34a2Y8EnvOQ7b6Yrw3fRl32qaH9y0/o+Rr3WI7o9OHQDmTs?=
 =?us-ascii?Q?OCDDH7FPYgkXiBMimXB4k30dOkNh77NO3rwasune+IGIBat3mbIxgNyWSqz+?=
 =?us-ascii?Q?ri4Z/amIjEFhzAClz2ScPDrG7pK1QkNXXBOJwScHNqCpqh6j8NvIxNyBOrz+?=
 =?us-ascii?Q?bIv4vwJGy15wTxs0buwDNpMCHy9ib6ooJrtfMTsMuH8vYPw9sZWbY8Maz8lc?=
 =?us-ascii?Q?QdouU0Acf4DTuciXYzYn90bt6cahkc9C10Tesrs3VVht3czIz5xyLIKNt4AP?=
 =?us-ascii?Q?1gyrifZ5k0bchKartRt28HDnIyru6F+mVu9VMeiXfBCxfn2O2irUC8ROkPVT?=
 =?us-ascii?Q?rfLDUKgWA4ccXPfbcTsdB6KqW/VENjNymoEhof8WtCBETEZIFaKwUi8+tsyL?=
 =?us-ascii?Q?8ohpvdrY3soVSeBBikQmB7b/t8+wL7HNVuNyDTSzGsvbRm1ffDJmqbTxXd0A?=
 =?us-ascii?Q?TWVnIS+jE7XaZprZf3uYNWfz0ytk8VV+DplRgx1bWh1sctdMnmrBigQXZQtE?=
 =?us-ascii?Q?AI94J21MgLIe3qaT4s5OaAjOnihRdf9zVH66gfbpb4Jf1fSWU6j1H0yiHNCd?=
 =?us-ascii?Q?vBU36Vq/5i1OIGXreKB2VOBxs7psWGGsmloICT7UR+5cn7ElfloEihcmqZDM?=
 =?us-ascii?Q?wESMe0y8+47/LCBNlmxjor7X?=
X-OriginatorOrg: vpitech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd74e3b9-b01d-45d3-2f04-08d97dfa507e
X-MS-Exchange-CrossTenant-AuthSource: MW2PR07MB3980.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 18:53:49.6458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 130d6264-38b7-4474-a9bf-511ff1224fac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKvVz3uA0QsFgwpsJBVIcutlB/Mm+fJnw7pOQ0dmsbQUH1XYp3fQp9iDsu/qgPfVghPQO/m5fyZgUnGp2rFeIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB2583
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Alex Henrie <alexh@vpitech.com>
[ pvorel: add test_file parameter to ima_check(), keep $TEST_FILE in
ima_measurements.sh ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../integrity/ima/tests/ima_measurements.sh   | 31 ++-----------------
 .../security/integrity/ima/tests/ima_setup.sh | 28 +++++++++++++++++
 2 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index ef8577d30..a83c416de 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -21,33 +21,6 @@ setup()
 	[ -f "$IMA_POLICY" ] || tst_res TINFO "not using default policy"
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
@@ -83,7 +56,7 @@ test1()
 {
 	tst_res TINFO "verify adding record to the IMA measurement list"
 	ROD echo "$(date) this is a test file" \> $TEST_FILE
-	ima_check
+	ima_check $TEST_FILE
 }
 
 test2()
@@ -92,7 +65,7 @@ test2()
 	tst_res TINFO "verify updating record in the IMA measurement list"
 	check_iversion_support || return
 	ROD echo "$(date) modified file" \> $TEST_FILE
-	ima_check
+	ima_check $TEST_FILE
 }
 
 test3()
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 9c25d634d..af7f3a5f5 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -279,6 +279,34 @@ get_algorithm_digest()
 	echo "$algorithm|$digest"
 }
 
+ima_check()
+{
+	local test_file="$1"
+	local algorithm digest expected_digest line tmp
+
+	# need to read file to get updated $ASCII_MEASUREMENTS
+	cat $test_file > /dev/null
+
+	line="$(grep $test_file $ASCII_MEASUREMENTS | tail -1)"
+
+	if tmp=$(get_algorithm_digest "$line"); then
+		algorithm=$(echo "$tmp" | cut -d'|' -f1)
+		digest=$(echo "$tmp" | cut -d'|' -f2)
+	else
+		tst_res TBROK "failed to get algorithm/digest for '$test_file': $tmp"
+	fi
+
+	tst_res TINFO "computing digest for $algorithm algorithm"
+	expected_digest="$(compute_digest $algorithm $test_file)" || \
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

