Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F46405B52
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Sep 2021 18:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238377AbhIIQwq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Sep 2021 12:52:46 -0400
Received: from mail-dm6nam12on2082.outbound.protection.outlook.com ([40.107.243.82]:12507
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238789AbhIIQwq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Sep 2021 12:52:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqTvTpZAxlgot6vH5Ym89NXfnJSOz1zxib+U1Dm5t8DHFW7FdhCaKXpwsDELbgpkIIdgomCLFOiMz3Xipnm35NQrpdYkGutjSHlfNMI/Oya/7tlDcm2uIYOgxnoHyoOuIUHO+CTiobx16xyi0730Sv0X4LWxg0xTAEXNPfxthiHo4leyWTWmFhogMPTlHgZokPrrH7k23yDIa3jjPif6NdoRP+QD58FSOGqsaS7n10EGJmKeM57IMEswSSSvIoouNjUCuq+5BgpOIW/yUQnQqvII4pUB0vb7t3OKYzpO5d/ff8u68ZWF7FjuppSi0BpexI/BOvrzCrsc+W3eBLRNGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+T9DtiRWoLup4+CsDkgKyFxaAqMBUsAQ6Y3jexeiyME=;
 b=BAD7HrWh4HvueNSKxkJa6fCb6ZPWSbve1XHvqArE9wtCnnVcVWq0QJfCqNnnCm8f34QajtirocawtQjbQ0L1+hs4BwQux+nSG06OUP9fzhlNFf2t+cK4e+MjdFRqqvb7ySvwP1xeTVIYf5KNBrtGcxSmm5r483WOF6/ft/e/RmtmnUVUZPHr9UI+Y/JTvEr6ZUiNTW2ExgM12IDo0TsxirQH5pzMWVigepRMlePX4t7Duw7WLoYNOEVGSKarVrnSTvJJK3SUjprLVmh7jnrxY+W98ZNDCMYz0sC5OxkQGPxEkfGKVtPSAYsDx2zv2/vWg8OyK3Jfq2gyroWjnfZ+SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vpitech.com; dmarc=pass action=none header.from=vpitech.com;
 dkim=pass header.d=vpitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vpitech.onmicrosoft.com; s=selector2-vpitech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+T9DtiRWoLup4+CsDkgKyFxaAqMBUsAQ6Y3jexeiyME=;
 b=lwTJSqdszhM+1RnNpo6Ud0ey4oqfmlxrjtzezCS90mU6151V0Mxs4084HNXFhbJU48agRTLYF8WfqDRIRQCgnpbMyfp22lwBRuQvUcNTgfimq67XyBWLVzH8ew7JVhmM2XbAVGPsVF7e8zg9FgmLxNdTeej6yvKskF7E9vb+EVc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=vpitech.com;
Received: from MW2PR07MB3980.namprd07.prod.outlook.com (2603:10b6:907:a::32)
 by MW4PR07MB8667.namprd07.prod.outlook.com (2603:10b6:303:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Thu, 9 Sep
 2021 16:51:34 +0000
Received: from MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014]) by MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014%4]) with mapi id 15.20.4478.026; Thu, 9 Sep 2021
 16:51:34 +0000
From:   Alex Henrie <alexh@vpitech.com>
To:     linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        zohar@linux.ibm.com, pvorel@suse.cz, alexhenrie24@gmail.com
Cc:     Alex Henrie <alexh@vpitech.com>
Subject: [PATCH ltp] IMA: Add tests for uid, gid, fowner, and fgroup options
Date:   Thu,  9 Sep 2021 10:51:11 -0600
Message-Id: <20210909165111.51038-2-alexh@vpitech.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210909165111.51038-1-alexh@vpitech.com>
References: <20210909165111.51038-1-alexh@vpitech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR22CA0050.namprd22.prod.outlook.com
 (2603:10b6:300:12a::12) To MW2PR07MB3980.namprd07.prod.outlook.com
 (2603:10b6:907:a::32)
MIME-Version: 1.0
Received: from demeter.ad.vpitech.com (66.60.105.30) by MWHPR22CA0050.namprd22.prod.outlook.com (2603:10b6:300:12a::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 16:51:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45706093-7d39-42b5-19b9-08d973b2152c
X-MS-TrafficTypeDiagnostic: MW4PR07MB8667:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW4PR07MB866724479844D2497C51BD37B8D59@MW4PR07MB8667.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:231;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8k+G2xX1w4WRF9EKgm4H9PfD1OpQYeiGoPhjfNFHQNuzc4lfMoUnjBe6sZiWVVUSywGIHsd/crC13TR8aVQUrGap+CZLhmLcMir2DYAGF0yVYNq4ANRavhVWiMr8bTDFVH2j+zD+m2dL1OVXjdLpb6oE8LusWxUWD8MnDggOOz75rHCA7uGzXYycImrNduTsUWNwyLtEYNKPIWxDXbH0b/l7gCMNpni4LBBb3uB6Kk7O58AaKr+Ij5bQqBJuNI7L9uMqQP62j/5y0W77Vb3fup85bqhKvzGPL0LlOf8AoYyBWsOukgme3cYRIkYOb6RHs+6kfKUEgekYollXSSTJRNqZxMoc9WitrLD0BQd1RNa+LYwt8qF7WAytqhU6tQaKEPfYLYnH0yLbpMmfI6WRplt3iv1+H2J4hNjVJREN9/ijMq1dP3NWTcItAk4y9EWUaBbjEu0jvzQm/+ccCyuIhbsgzM0hsn7TOcNXGJhjiODohD6eqav4+bNO07lK529jyBLTQ5g49RH8wihf9YGzn2zPF+MPgWThVBZKp1QI5+LnmWOZYXdSpaU0oTVznF/HOcB0ndsf70BVuC4wD60W0bsoBSMeZIgCAfsEUiFHd7QIHVO1gxhUFWXlFHZ/mvoT5Bb5X4VvdqwjdHbWMvHB6MS5kRqrvY4QoGTQhCVBe6Z5k+IOEC1+IC9beE8DKgEwNCNqdicwESA1vthINQU5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR07MB3980.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(376002)(39840400004)(396003)(2616005)(2906002)(36756003)(66476007)(66556008)(52116002)(86362001)(6666004)(478600001)(1076003)(8936002)(66946007)(956004)(7696005)(5660300002)(8676002)(6486002)(107886003)(38350700002)(38100700002)(186003)(4326008)(316002)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eJG9YAytUjUNRf0RJpUXPq0z3ZQX1NsPanqxOBwZhv2d/KAQ52N1G0e5UiJO?=
 =?us-ascii?Q?q3GAtp0f1mp9qsM3t7EDL5EhgGQYLHWSL7wwuPdrDgt4P35jVRX+Ma/iNB/X?=
 =?us-ascii?Q?e+sV/lApenIgCkSYGtHij5acTh9wRUjaH4y4See/cu3Nktr9LaURXmviWPQP?=
 =?us-ascii?Q?sT7v/PnDUOek/d++PRF31vXld/QoRj8CKapaDKOLUDEyYroKRlPNfzA42hvq?=
 =?us-ascii?Q?7I4RGAf5NASlBHPpNqJ+NnM02UB2SP/ysGk2UeSv5PoOQnPEofIVaGsAa3ZO?=
 =?us-ascii?Q?RbyRfuby9zEvLePyTUdmzNG1p5kmfNjpG/X82ADXMs9NabvspyOr8ea1HzE+?=
 =?us-ascii?Q?Hz6s+wgVYVffhtKpgM6DxUY8w+bmb8MzJrN532/P2UbaCHGsfB43Hr7BqbXC?=
 =?us-ascii?Q?/LgMJul3oUiWBgGLKGpIe1eX1QT1W/cLsh0BaaSp7Q+zYT1xVHWwJAEs1z0+?=
 =?us-ascii?Q?VTBdS2U/umdA5jmjCsYPJ0ENHU6NTOzL2iE2MJvHFVmDqi5UBlFJGUanc3au?=
 =?us-ascii?Q?YnSbDBmt7z3Gl31msZqbmU9egRQx9T2WBAOsvydr8sTz2nZU59aR//y6DOvL?=
 =?us-ascii?Q?7bz1+vTO3R31HCJbX9ldMxBd42OKecC+RCVX74nuQxI2XiS+5R3mlvl2K+C8?=
 =?us-ascii?Q?8yfTzjkx2rUFZ6cShbJYScwegI8mQY/oA8VNHNP7jd1ITkZ5pABGNX2C97jj?=
 =?us-ascii?Q?s2cCNl0cekUxqt4ogqe/uoWIcZlfdmE8Ducr92jz4PqGoN0IdmUjy5ROfCIw?=
 =?us-ascii?Q?R2NGSYWzCHhc+sDWSOdAcFtj2RwTPpYuoGY7wvBsmBcA7u5lW6+gTfZK0G1z?=
 =?us-ascii?Q?xerOiMg33D0itAaa8tQTlfVqTuNBFuvR6ePU/qqvcd7Hnc4AGs58he4qtTuP?=
 =?us-ascii?Q?jVGpUFwKSpvecmUuUHR8UZzOzx1ImWZspq+yie4OV3a97Brj7jTXJNmYqeoY?=
 =?us-ascii?Q?8onbP88CQPxmelhqboW7ydNPPXaJiVqncx/3t50y3VknWaxhrLmSKqedF2J3?=
 =?us-ascii?Q?NZg+J8B1UhvOyPx+E8gcDcI4+vyYBZiq0HwjsgD+83HhfiK/prIMDEkJWNy9?=
 =?us-ascii?Q?NlVZ4myyH0hNMrRwJfM54onYxmWICx9OCGDNVf7pTPpEPdWjFfaoKxLMXanF?=
 =?us-ascii?Q?rilAQIZRtURKp5t/V+iTetHllKQQezs1KCatqN4H5ETfV93syRJstlL+lRES?=
 =?us-ascii?Q?gShb7kgqVsw/uMEI+sqghNr6vLCSRm4OMGCn6eCdJSAfbFKj3zDYazyzU+ih?=
 =?us-ascii?Q?BmKHXSoZj54am8vOcpzEIMLqJJ8WvEi64EIV2j24XFzp5I99QCffsAJ6YUQ+?=
 =?us-ascii?Q?9B5RAu7u9XMrDSRFOzEHEuKN?=
X-OriginatorOrg: vpitech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45706093-7d39-42b5-19b9-08d973b2152c
X-MS-Exchange-CrossTenant-AuthSource: MW2PR07MB3980.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 16:51:34.7439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 130d6264-38b7-4474-a9bf-511ff1224fac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +jIanzir6D3sdzB6IabrORkJSBu3iCsC8UGELB1sLjPIgE+fSadEtrAZkCYdC5TmkZ2qbi/Hbku2p/11eJu92A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR07MB8667
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Requires "ima: add gid support".

Signed-off-by: Alex Henrie <alexh@vpitech.com>
---
 .../integrity/ima/tests/ima_measurements.sh   | 37 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index 1927e937c..3c1bcbf88 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -8,6 +8,7 @@
 
 TST_NEEDS_CMDS="awk cut sed"
 TST_SETUP="setup"
+TST_CLEANUP="cleanup"
 TST_CNT=3
 TST_NEEDS_DEVICE=1
 
@@ -20,6 +21,13 @@ setup()
 	TEST_FILE="$PWD/test.txt"
 	POLICY="$IMA_DIR/policy"
 	[ -f "$POLICY" ] || tst_res TINFO "not using default policy"
+
+	cat $IMA_POLICY > policy-original
+}
+
+cleanup()
+{
+	cat policy-original > $IMA_POLICY
 }
 
 ima_check()
@@ -103,7 +111,7 @@ test3()
 	local file="$dir/test.txt"
 
 	# Default policy does not measure user files
-	tst_res TINFO "verify not measuring user files"
+	tst_res TINFO "verify not measuring user files by default"
 	tst_check_cmds sudo || return
 
 	if ! id $user >/dev/null 2>/dev/null; then
@@ -116,9 +124,34 @@ test3()
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
+	tst_res TINFO "verify measuring user files when requested via gid"
+	ROD echo "measure gid=$(id -g $user)" \> $IMA_POLICY
+	ROD echo "$(date) gid test" \> $TEST_FILE
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
+	tst_res TINFO "verify measuring user files when requested via fgroup"
+	ROD echo "measure fgroup=$(id -g $user)" \> $IMA_POLICY
+	ROD echo "$(date) fgroup test" \> $TEST_FILE
+	chgrp $(id -g $user) $TEST_FILE
+	cat $TEST_FILE > /dev/null
+	ima_check
 }
 
 tst_run
-- 
2.33.0

