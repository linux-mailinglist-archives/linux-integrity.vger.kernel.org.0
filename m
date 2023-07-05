Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F50D74838C
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Jul 2023 13:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjGELz6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Jul 2023 07:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjGELz5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Jul 2023 07:55:57 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2118.outbound.protection.outlook.com [40.107.117.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6541717;
        Wed,  5 Jul 2023 04:55:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ax+dBxSZ3se6ahR0ISIrafkZ5XJgCgviR9bJawVNJ1GOOWp9hZ3ZPmoozKLAcTf7TO/dMSVf5BAj/i7uhkK1MGv+TwNtKUqe22yTWJ7GGOgDeT0RyayyiZYIfxDJXZlim3CV5/eFuPiw+GSocbTswKY4UL1U1IuD/9UkpoGdgJONjB1EN34PP3rtiinOCi7rYAyIDC4jvnbekAza/9FsvqKbs59xYQz0njr5WICCArIXx+nuT7urSTPkLPF8JhKfH+l100zZEgF8arcUH41SrTQHwGLMZWpWJnGmWbF6j50UE/7FieMTZqIafItVCpuQUJQeRxyE6btoj02VY08aaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QBuSnDq08ApO+V1eouNE+uh8yS62/o0KYueG1oldmw=;
 b=m/+vONnwwa9CKSr4IqVePvxMJ/7Ii6znlDum5vI+UAmG0dxBASKV0gCHOCHVyktZywjNMJPQxcvSvAB0X60fn8H+P+PvajXrvAuHqE4aWXegBPF8CGBGgB3j8vVYfoTcFo1NH2A9N2dweKkRWhhfNCxRGG/7jQt/zGOl5MNWnwIqlC2yuNlmd1y8CiB1U3w96V6fBRMsJ7l5TgwtRfOLTx+fPhAOkRqSE4OroKwSxqSt9XblqtolXwBVfdQdnKQcNOINcY3b5aTGesOq6shHZ+9194UkkmyGX/EqjE8/JcKQHbBmMtc61vrp+33WgA4wsNDSmpBRUJI8wSOT7XhKSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QBuSnDq08ApO+V1eouNE+uh8yS62/o0KYueG1oldmw=;
 b=E5p99jgha2iV6uj6lCSjsjfnUjtNWZJXEkFL8t3j0okRjQX7rpzfXgdYco/CCWTDssi9FPnX/pqmFRU96QMkq4LpDS9ahrGNyCnr7sroMXeNJIEqxzfXMKStqPG0TcIgZdknMtnEHh67wWFNbqXw4C98C61j63w+DHpx6/8G5bI7fpvK+LX6eCdszyucN9cUl2vUbBKTChkUkiAvrarzdvIK5HMQu96/S9fDqS9EvJUC7lXsW80X45pQI4suJ1245IbjzZR0JU78RbvJ95+uww7pkeTcQo5ixph8gwTCWEHAkWfyd3sV5mU3s0ZeFLxlF2i7tQw8Njgya5WO6bLFYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 11:55:48 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 11:55:48 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tpm/tpm_tis_synquacer: do some cleanup
Date:   Wed,  5 Jul 2023 19:55:36 +0800
Message-Id: <20230705115536.55931-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB5140:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bdf6544-5c1e-4d44-dc8b-08db7d4ec58d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ThvCgH4ds1J1shgbg3lZxgYSCvizlpYciyIH46H0SVdL5fSstfcMXh45NLg/AOrLoV8mvGS2FYOVW16k8zTPgWSsrPzkLGN0XRM3Tw7tJVMu/BDGOaGs57N7laAjOQKfclyR86/yXOOAXVC7zFPE0E4KD05jUWKSF3EyInrGshuoDQDEGdCnyAByOKgw5tmPkesuiduSav4z5zRIdJPQXpjnxL27Cy/Q2ZxkR5zxWwiZ6sGSZZSDT9zWadfNWpcYrZjCAzHXa99L0t2f8JF/O7x+PCBKwvnd7/yW4OkV1J6+4DNnA7sFImDJBlLx9CEbN74ORzpU7BCEcdksm5CbjvIABL1zsF01h4rwYnSPf8ZXavUvKBpmOzxen7k06Yf42HEgqATGx+dQEjhaO5BfRH7dLB5J/uCImjF0VXRGxZo7L8/s3D0XYRAKXLtvPaZp8ALcnhCPDJkNwfXrSqd0+fMcanRpCfxGprjmNsnmAmRNAGk7moG7dHFg3QZK1eAlbDr8oNSP4mAk1aaKcw3LrkACt44BRHrZ7mLp8v8LuMS2eYz80fJChFQF/eTD7KgoR7GzkqjOMBg3nOdUiBt5oiIS+T3mQCaXLEg8otVZWh3RrR0kUcVNhXcmu3SX7lA6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199021)(38100700002)(83380400001)(8936002)(38350700002)(8676002)(186003)(41300700001)(26005)(1076003)(6506007)(52116002)(2906002)(6486002)(86362001)(6666004)(6512007)(316002)(5660300002)(2616005)(36756003)(110136005)(4326008)(478600001)(66476007)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jjLjrce6duO5il6kCDDw1abHUnog834V93F9hKRlYbl84kohATu8tgRFAyic?=
 =?us-ascii?Q?VNYN2/yXJhAq1emOwKeYAu18d2gnmkSMST/+sjqerXLaS1k6PcKfJ8VsxSwt?=
 =?us-ascii?Q?/rE/vwvqFoXL0AB/XiR8QUKjBEc42+3wZBDqQ56XvVWcEx3PjxD2FKRWNtjl?=
 =?us-ascii?Q?7ErfANOScBGwv5HUN6EObOtLRTkcxhiZ7dA8LOyUyndCwdLIsGUP9G4hFKzm?=
 =?us-ascii?Q?pbjjZqlSoU0pXSt+r4gNnpALvtQfJurDawpIR2foq8gkMMz1Q2WAKz/S+KXq?=
 =?us-ascii?Q?y0kuulYoRBG5saP5OFNSb9DeY/9eHBMe1XqaWUslbpIfhXAw9ubQimBz+PW4?=
 =?us-ascii?Q?dGq7JMDaSingvaWGXz8GNpZb1xhExX08OJ/7DV0L9KN87BdqOwFSnEoQeUFA?=
 =?us-ascii?Q?TsbUl4/dIKqXtgKm63PKY4PrHoMcIfy8Wgxq1nWAW1g64zDAq6Cilkeg9j72?=
 =?us-ascii?Q?cfHNM0vWyAJSFgfUD4iQ6/sOhKQrRfPSdUy0osF6O2efj4CpNOVl4p6TJOox?=
 =?us-ascii?Q?zJCuqunjl9xS6Gr60e3E8x+SRzXTI2idGNOu956xO1aUKeBWmC9cM6C2Xyl5?=
 =?us-ascii?Q?gv0/iThKjfy3ieuQYcXsVdB6DwVzTNuNVj/Qou8g7J0YKmRzTsDbcuRum3u5?=
 =?us-ascii?Q?5aA7E35VLkgFrXgSfM4pD8YR+w4Vf2mbk48xbkrQNTLLW7FUhoSb/SGLEkOj?=
 =?us-ascii?Q?FIBgFXZ6jz75Y/QIxbO5OR4jTfDV3M+l1cy8itR1JBjRuLzrEAdUUiv0tofS?=
 =?us-ascii?Q?PXJYOyz7bzK0fW4l03vIP3RgCQy9W9W7q2MKbSnJzvb+dAdmpWiy172MPBGD?=
 =?us-ascii?Q?2GYpbidfyyN6Xj8UBbYVuVpaYOtTQMVGiTSqS/t5Dhpct49YOIn/yDmCBr6P?=
 =?us-ascii?Q?OH5IybI4rvbQC2vr5xHA6YgyA+im4d2CioEG3cEFkKKcU+adujjn5fijouFb?=
 =?us-ascii?Q?YZaM1hFUcZkjFomTBJvt3Hc5AHKfFprDL/L6cBx8R7+gUjPh4cRjLIH98WWz?=
 =?us-ascii?Q?UbA3FmxS1UZ1F6xYbBlXKrzBsE2/+LL+oyw/EeOaUuI+6PRoNE/0Rqg1JPCE?=
 =?us-ascii?Q?vRm4wJZGfxibk1kYB6QHY7zf/dmU120KYtLS/1fsQ1xeszZZwfjI64kPfZMd?=
 =?us-ascii?Q?siNT0/+7vTo9P+cCBNaBSf8YB3tY9AC638vP660jvNq4j1Qto6hRoms7LW77?=
 =?us-ascii?Q?ZFohD1yDZnCIyMG2J+7w/7KMVB/d5hq07r0DaZE1IxreTQhzrKEwXF2qmZTN?=
 =?us-ascii?Q?dbJB6zE8vf0omFeK332jTgaSiSh6PJGZQ6F3sRgL8eUa8G9UOcFBzL2TlxR4?=
 =?us-ascii?Q?IC9whciAGuFji1/QVXij2F32pZEDagdRGoZW0STAOK+BoYQNckFH1AbEGrKn?=
 =?us-ascii?Q?OrF0yW9OQ1R1uP5Z4PaxQp/SUQiNL1k+knmnbdQAQH9QQK2LjPmeQDPs8uoa?=
 =?us-ascii?Q?PtCiRxhXZo2z6uEV/QZFRQUDPvTMGHn/P7hxehhZxVeQ9r3ruW83lClQWYVO?=
 =?us-ascii?Q?tlWYMIiOGrAJAlHsiLMF287OkoERxTDfelBtysXZNxGJ+Nl7tYOSWyNuEtg6?=
 =?us-ascii?Q?lBeX+AvlD6A/xUxHRCMrGUNjWCYPMDmCrLGCVbjd?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bdf6544-5c1e-4d44-dc8b-08db7d4ec58d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 11:55:48.2945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5Sc7zY0ihffEaI3JGGuwB2N4rzrrMa04UGQRSszX+PPE5t7YsfZO00Dj+1QC/k5/Hoiau4sJqgz2XJOVmeEMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5140
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code,
and remove unnecessary struct tpm_tis_synquacer_info.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/char/tpm/tpm_tis_synquacer.c | 39 +++++-----------------------
 1 file changed, 6 insertions(+), 33 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_synquacer.c b/drivers/char/tpm/tpm_tis_synquacer.c
index 49278746b0e2..6e17b655cbde 100644
--- a/drivers/char/tpm/tpm_tis_synquacer.c
+++ b/drivers/char/tpm/tpm_tis_synquacer.c
@@ -14,16 +14,6 @@
 #include "tpm.h"
 #include "tpm_tis_core.h"
 
-/*
- * irq > 0 means: use irq $irq;
- * irq = 0 means: autoprobe for an irq;
- * irq = -1 means: no irq support
- */
-struct tpm_tis_synquacer_info {
-	struct resource res;
-	int irq;
-};
-
 struct tpm_tis_synquacer_phy {
 	struct tpm_tis_data priv;
 	void __iomem *iobase;
@@ -91,42 +81,25 @@ static const struct tpm_tis_phy_ops tpm_tcg_bw = {
 	.write_bytes	= tpm_tis_synquacer_write_bytes,
 };
 
-static int tpm_tis_synquacer_init(struct device *dev,
-				  struct tpm_tis_synquacer_info *tpm_info)
+static SIMPLE_DEV_PM_OPS(tpm_tis_synquacer_pm, tpm_pm_suspend, tpm_tis_resume);
+
+static int tpm_tis_synquacer_probe(struct platform_device *pdev)
 {
 	struct tpm_tis_synquacer_phy *phy;
+	struct device *dev = &pdev->dev;
 
 	phy = devm_kzalloc(dev, sizeof(struct tpm_tis_synquacer_phy), GFP_KERNEL);
 	if (phy == NULL)
 		return -ENOMEM;
 
-	phy->iobase = devm_ioremap_resource(dev, &tpm_info->res);
+	phy->iobase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(phy->iobase))
 		return PTR_ERR(phy->iobase);
 
-	return tpm_tis_core_init(dev, &phy->priv, tpm_info->irq, &tpm_tcg_bw,
+	return tpm_tis_core_init(dev, &phy->priv, -1, &tpm_tcg_bw,
 				 ACPI_HANDLE(dev));
 }
 
-static SIMPLE_DEV_PM_OPS(tpm_tis_synquacer_pm, tpm_pm_suspend, tpm_tis_resume);
-
-static int tpm_tis_synquacer_probe(struct platform_device *pdev)
-{
-	struct tpm_tis_synquacer_info tpm_info = {};
-	struct resource *res;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "no memory resource defined\n");
-		return -ENODEV;
-	}
-	tpm_info.res = *res;
-
-	tpm_info.irq = -1;
-
-	return tpm_tis_synquacer_init(&pdev->dev, &tpm_info);
-}
-
 static void tpm_tis_synquacer_remove(struct platform_device *pdev)
 {
 	struct tpm_chip *chip = dev_get_drvdata(&pdev->dev);
-- 
2.39.0

