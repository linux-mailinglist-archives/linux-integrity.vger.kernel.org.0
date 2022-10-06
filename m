Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45D35F659B
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Oct 2022 14:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiJFMD5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Oct 2022 08:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiJFMDX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Oct 2022 08:03:23 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80054.outbound.protection.outlook.com [40.107.8.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA359E0EE;
        Thu,  6 Oct 2022 05:03:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g983v0DHYWBnjhjobwEMmj8H58yKxOvP5t6YPamP6gG2oy7j8/Hn4OYi3jwD0gilpZpyJqmEoX7buT3E7xXQtcUmEh5cIj/TOO15Ia+t4SA/5EftBfgUxhC4GSG1dh5tGhz09ROR8SytMVYllco7lHFX+x82+ep7hSeP5T3/wIJKPbWgMIKqUOhc8jZBYYcvY1sIvgnpoLyHmvwBHT4K0lgIejithe0iCCuoHamO4AlLWvvMF3Xr7NxHPJf2kZnGgHgqUTHmRzhbjwzDqH7ygb+axzFSG26iwPVzePHz+dN8G7VwPnNy11eD3YVmtVjUX9UvX2smM9C4582J+oNI5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7YbdqO+/E4zVo+1YJyFVZGcdSM83A81NT0btdwkuSE=;
 b=jPKpCEz2Azl7UqsA/F1xhn+VQADyGxv9PfF9dgYnxtQFsYvzcXfDedBPe8Ic6/nuk+LMT7HeQmw9KRO5ofh+jsmI9KnPZJoNl4wnLI4NYg4tFFwD0cJ5exXQQ4EEb2fUURh7TqLR/bwEqzzYxa0lFA2cs6ng6ENRu8Xz2g5rbOxVMJSAOMJZoHAqVS7MOjdCD+T3keVyuS11GlBOCrkcJDT3poDSCW/1gb7mbWS9k58PLdtVPrBI3e+yjRVUu214UoSO5uRxvfrYHzJFo7x0zf8Hp/nAGpnFZ+0iX8C1AKDv207lsPobn/ZyVJa7yqgsCRrsh+NJjjuuyBK+QdTdYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7YbdqO+/E4zVo+1YJyFVZGcdSM83A81NT0btdwkuSE=;
 b=o6Xf6DshfNzOOv1cl+HqT163olY0YQ7zheJEU5Y24w29N8gg3lCol8RTzT4CDfruy/M5ZLoee/FG1M5RszhmLLBh50UTSOeHMT9W1LHZownRnAolbHVE2eyTSCuSaKy0AY+GvYm7LbeC07m4uy6fX/rum/NwlF1nbuKQ1XOTzh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AM9PR04MB8523.eurprd04.prod.outlook.com (2603:10a6:20b:432::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 12:03:16 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::d551:6af4:bca4:88ea]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::d551:6af4:bca4:88ea%7]) with mapi id 15.20.5676.032; Thu, 6 Oct 2022
 12:03:16 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     jarkko@kernel.org, a.fatoum@pengutronix.de, gilad@benyossef.com,
        Jason@zx2c4.com, jejb@linux.ibm.com, zohar@linux.ibm.com,
        dhowells@redhat.com, sumit.garg@linaro.org, david@sigma-star.at,
        michael@walle.cc, john.ernberg@actia.se, jmorris@namei.org,
        serge@hallyn.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        j.luebbe@pengutronix.de, ebiggers@kernel.org, richard@nod.at,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, sahil.malhotra@nxp.com,
        kshitiz.varshney@nxp.com, horia.geanta@nxp.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v0 4/8] sk_cipher: checking for hw bound operation
Date:   Thu,  6 Oct 2022 18:38:33 +0530
Message-Id: <20221006130837.17587-5-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221006130837.17587-1-pankaj.gupta@nxp.com>
References: <20221006130837.17587-1-pankaj.gupta@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|AM9PR04MB8523:EE_
X-MS-Office365-Filtering-Correlation-Id: a448c558-63cf-4500-c91e-08daa792c084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: obDUzDvgzq1foSSvVzThro01boAf/9zdoMUgyJpDuiXJrj9d7HLSCmb9Lb3jNV7ZU1SetwM2H2Hum+f88Vt39rA5wrfZo1enLSsrMQ3VcJeU9P4eQzP0tnkC/UHCqhcqC4znSXJl8nYAOznwr+49SXyPZak34l5sEIZbQU6PTisHxbyoAj9dErymLYeOrQlArGQkQHWqRn6NATtoAFY4JAIy8UvDnMtomKAVYtrKrh9oLtVFE898gKUuIUTbAcnYR0uPe2z4IKtTZg5yvrJx+a9u9Y/8kNfXm4TTRbIxmA3fyYBOSfO4PkbCPrbom+IUXzUq5DfYgBSRUjI1jv89+oCKV2qhiYHO4Ax2g5yUXkNr+UAccZwCqDo+T9FBkTDf3UZAmCv7Fu6MhjI6GmeJnDMJwNK8Yhsh16Rk1b6iyLtniYm70NhrGCwqGpieYBqp6ADIjrxoKzoNhpqNnQPytYYAiJ/NCyioaLhJxuRa79moAhw3ajBMi1WGZAX2ig8tHVRrzFMB1Wx1hyoIe2zq/odjbc67EPKJc3cGuPz8sVMP1RRM3BprEM394xbw16GgKYnHBBIbBoDxHgY747D0LqDX+62/CVb9HcdL9cbh/MrAJYgxk3vW1GGFKWOwtFSN/nMqqsZVy5bzvrsYH6wH3ceBTBAcXwNd05H9ASB9PdKHc6RQcaEIqH0ZhQ8tNZ6R9D/C/p2Xo+Hc4yP6J+UAZyLL5xH5t/kOnk3Z7VZAS34LhTnQjY9MCHAEvoA36KfaUdT9HAimdlJoyPwP50xewEjlxuCkVnN1rAsZ6ykNGlE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199015)(66946007)(66556008)(4326008)(66476007)(8676002)(38350700002)(38100700002)(478600001)(83380400001)(1076003)(36756003)(41300700001)(2616005)(186003)(6486002)(316002)(6636002)(52116002)(6506007)(6512007)(86362001)(921005)(6666004)(26005)(2906002)(4744005)(44832011)(5660300002)(7416002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZCJm/1uPIbKzQ9zWyNMOOr3pFp3lgLhNV+PSYkJujkVo8XuVn5/7Oe+RGaWo?=
 =?us-ascii?Q?/C2VUCEuYqCWPgIeTmOEWOiNWYOwSQgSGn/6K11y5aByHsbgmLhtYlfIq2Z/?=
 =?us-ascii?Q?6PWQQg6na9mlcH6MRKY2u2bgYFa+vMywrsEfR+rhFxVvJrAwo74PR5x+7ymH?=
 =?us-ascii?Q?D8dD5vEqzSUMwQZrLPw0JIT268+931Aj4AHVBznTHMPxO87maxDyCHCS/vk7?=
 =?us-ascii?Q?KykpnceqeOkUaZ6/3qSXhy+7Wz7hcboyp9piEUr4D/G9X26NkoSxtoz/8Lz2?=
 =?us-ascii?Q?xe2SXdAALlOwxm5rjP2kBbTRhjaJaKiROULoc3Uh/iUUMyYhkJtf2Nqbj7KU?=
 =?us-ascii?Q?DDUzdggfF+GjVpyWcIX43ipUtNr3lIjgow2UWm/ESaeb88XH0wI6D9a4UNqT?=
 =?us-ascii?Q?Xfrkl2JRArtn+2jgqNr7VqXG33mPJKxRjPPIPgYF6LlNdylvujeqzBe1+7BE?=
 =?us-ascii?Q?/MIgkHVOshwqGWl4yNbfByPWPxuw6XJfxyvTdQjB8+LApqSR/X6ZARslWqJ5?=
 =?us-ascii?Q?mmv+/NjfbuOOO5xW83abswdCuE9e072vhqNme4W4nmsy/MSfyzo5mUaJ8hmx?=
 =?us-ascii?Q?zF2xiCqKWZsarE62FVVqviWK7W+d5B6uNx11uHZIH2OaQLWIa7beNk/PHahM?=
 =?us-ascii?Q?DSLyJWPxt7kKX1bnqSud9Cs1tsqv2mevgu5bE/dKGe6d/R3aMBGEa1J0oRZl?=
 =?us-ascii?Q?WyEo1XWqW4mtMdlsjBBrO16bwoIRmk0N/1Oerg493XJwnmZ4H9VZZjaKVz0Q?=
 =?us-ascii?Q?/yjFsqK8Rz3MRQnYXq5jzoyQeRHD12aAsobDhiT2T24aqaq+9VtlwkubDTBn?=
 =?us-ascii?Q?M82llVMRzP43/uQHycbeIzGXO1UATlVKjRtg6GoOUDA90AdGn79YsyqSviz3?=
 =?us-ascii?Q?Ssk6By2kk1hvXMw3knDNZmTu+0CE1yXggK+fFHK+kpYnFygYrVHhqUBUoS8N?=
 =?us-ascii?Q?EhAnhvPUNAy2+MBireyTxKXjQvDA4wSA/VaqLfZ0jVSe5eTIdSD7xD1O7pZz?=
 =?us-ascii?Q?SyDnqW1GrAX3a9XH18IXBiY/D6c+7U1RH+2py67VclXLaIF7djTlfSX5qJ0b?=
 =?us-ascii?Q?bUYervskm8OMAqltEikWXVfstU54jLfD28KUBcaC7z/JcL7AvKvd4uy5UWii?=
 =?us-ascii?Q?1/2cLrCusXyOjn+WhqWG1gyiZd8q5vdWWFbiI9egSoj221es1fhF/riE/A8F?=
 =?us-ascii?Q?ajXWdKYx24E4A+q4JQbpqEkW6XiAdRUNstx99TAd1H9eWuxvi5KLiDSnBLe5?=
 =?us-ascii?Q?ecD+reHY9fj2qXqrPNSuxSF1MWDrHrEc/pU3cC4n3sbziLdjAL98wxJab2+e?=
 =?us-ascii?Q?E+yvxp6o0oei2LEMg/dDPzK8VFQ01SFMkfxHXLcmcRFPw2OhOAnuEc+6z/6X?=
 =?us-ascii?Q?fBScf8fmQmzs/8bavqB0crG+Q4Q1rdynOkRc+NNicjthkBPrY8qQVGnBDu5K?=
 =?us-ascii?Q?ONTzq22t/rL4p49sZ33GWEx/ol695/bo3wXrXyZ2fCLQ2VxTfY3xemfbtnJJ?=
 =?us-ascii?Q?msZKPT8mVQT+pyY4GnAUN/XhTO8X1F6HdnUwvZBlGZQTG0VczsccKmjdtLle?=
 =?us-ascii?Q?8/tnwCqYbpiEzk5NdfwHAC2um9w290c6UQ0X8Viu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a448c558-63cf-4500-c91e-08daa792c084
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 12:03:16.6931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SC4/1chPpKYCILiSTmhfPDxCXXsPnOmSv9bV3x2+HuPx9055iQHH8p+Id6yoZSSk/5XC4ssn+BdGY1nt7r3wPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8523
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Checking for hw bound key. If yes,
 - skipping the key-length validation to fall in min-max range.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 crypto/skcipher.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/crypto/skcipher.c b/crypto/skcipher.c
index 418211180cee..0f2d0228d73e 100644
--- a/crypto/skcipher.c
+++ b/crypto/skcipher.c
@@ -598,7 +598,8 @@ int crypto_skcipher_setkey(struct crypto_skcipher *tfm, const u8 *key,
 	unsigned long alignmask = crypto_skcipher_alignmask(tfm);
 	int err;
 
-	if (keylen < cipher->min_keysize || keylen > cipher->max_keysize)
+	if ((!tfm->base.is_hbk)
+	    && (keylen < cipher->min_keysize || keylen > cipher->max_keysize))
 		return -EINVAL;
 
 	if ((unsigned long)key & alignmask)
-- 
2.17.1

