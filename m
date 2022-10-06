Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383DB5F65AA
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Oct 2022 14:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiJFMEe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Oct 2022 08:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiJFMDy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Oct 2022 08:03:54 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10045.outbound.protection.outlook.com [40.107.1.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905579E0C7;
        Thu,  6 Oct 2022 05:03:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPlBng2WZQqxefJhRJz7+QItTSBG/KcowWtMd2Y7hy68R5nnXc7zMqiThGuDq3Iw3FEmEPj6FMRnz5T370WeqWMM8TCGA+EOTq7wh8Rtp2MSjOtj5yiMrvZrgJsZgn/YQswxg9WdQJO51wm5GyX3XIaXpSAk5inHhADoadgv/B4wXNNhrG4wdQ8fG7dJ49JDEaTYyHc5q0R/flJgMpW7ZlfOV7ftfvVkMGZUyAXp2MY5lVompfqMN5q+sVHJ7J+RVrNVeay4T5FOYLc9IF/JDgrSmbV8jFZnNiOdb1jBooWEdbSjXS2UIP/0H6xoOLdmHMyRgSB/9s8Jckwg4RISvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abrzySLGYv1kAIE1YJdlACStwhE+6xZ7E9VIa8YEbC8=;
 b=G/8DoJAtpfIi8KJ3noO3PaW8WrPZpQ5lxa1wqbu+3f5zvk5etcJUGnwyPgr+cCEjP1numjd8GM0an6FA1S2yXWjBFsU/N7L2VjbhbPsvDGBF3DMa91IAGvV7VB6aeL14/yupbg9UTkRKW68Pj8m+WHmMWZvJtvtdXYTHtZuKJXg3Gk51A/8HS6hy9O+bVEea24Ww7ZcB/12eOG++y6QRD0LYhoryYgBoiJY6AtaqPV11Vnq460Enm3GJBpcVqHakwzxLK84tZkFoLbHz2PhS/zxEFKpP6waULHTtkZoIWQB5oFG5Hu9gVYQ6hukYwVcJBXYVcgO/f+ffs32v4hcwvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abrzySLGYv1kAIE1YJdlACStwhE+6xZ7E9VIa8YEbC8=;
 b=JZSow/LJjur7oaTNvM+OZGPawRAA3G5zsbYZvFWaifT6jnHM1tRG5JRLQ5xnjehSzIbh8fRON46e9k6GAFAAjfDb61FL3F2hdkwUF+8hDzFbzXaEjW74DcRI3OwJ18PXY6Wn9Nz4spexfkDTXUFXGuuqfrqex6kb5jzRYBgSWrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS8PR04MB8245.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Thu, 6 Oct
 2022 12:03:40 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::d551:6af4:bca4:88ea]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::d551:6af4:bca4:88ea%7]) with mapi id 15.20.5676.032; Thu, 6 Oct 2022
 12:03:39 +0000
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
Subject: [PATCH v0 7/8] caam alg: symmetric key ciphers are updated
Date:   Thu,  6 Oct 2022 18:38:36 +0530
Message-Id: <20221006130837.17587-8-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221006130837.17587-1-pankaj.gupta@nxp.com>
References: <20221006130837.17587-1-pankaj.gupta@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|AS8PR04MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: fe2ed52f-0116-4106-9f75-08daa792ce6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ubATF1gL5PHsp/korj2YvIDmsY5Hms97jtYrq2XvYuuoeUdsC4M0BsI6GdU8QRHKYD1hs92iP36J6P/j0dcJ6x+FyJ1ksNrHbA8DwM2MEp+xtqJ85bQzwxIqFZ9M3dInyRzMPLSGeC79X0tzsIttMCUnlVP4jvb+5r0JRb2oZShWQ4fdc7KOSzdAttFFEDXgYBYIK9GiMNyxOzYcg+JrzUFbf8NJmlgcA+iYdnhHaTkwg7l2jS++a0G3SUI/hG3xNFvfMnJBqeHMsqKLltgQm9eko0Uyyevol1cTpOJYCnJgccrANpt8GqCwXozoSD5mP91EES8kbsCvnSxzzbWzBzgdk5GqPkckeK/ANCzwMVQsFt1jInewRtKCRIesY5GpDWzjiiVbrjLHZ0OuIFTbcKOcTwNu4LUM18FbpDhEsqPiG9iqt8vJMmaAMeD8RSNa2Dhx3Gf5fMLfVnf4Z9fBkGV3optlKy6MT7ufWI1VfZhle46E6WBDk0FPhTai4B9GDZ/TBVXTgY8TWwSxvlx6YySS7bTLeVlKbcUK6RrrkNVhMkZ5p+WnxuHu26iHB8/5Kj6OQRfm9CHJKO1Nh/YlwzK6UMQPLV58xn+8Em4FUmv4T2Xv38l1q1VkOSHFB6Tsp7VbYc/a83TRzqlti0qVVh9/OZO26aAcYkFgUjZkLoblGH99UvzQE3NQAQmCBLjbh8hSNjBsGwDLrbsmbHtpVoD6wGv0SuG2lU1WWQ/Q6LPqNnssp3bvKTgfmJKCgwSNIq33hWGyM2HIf4U+Z2aLTIEm2T6bSkFD0yI5Yw6Kj8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199015)(2616005)(186003)(83380400001)(1076003)(38100700002)(7416002)(38350700002)(921005)(5660300002)(44832011)(2906002)(8936002)(6666004)(6506007)(52116002)(6486002)(6512007)(41300700001)(478600001)(26005)(6636002)(8676002)(66476007)(66946007)(4326008)(66556008)(316002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?73J6pQy6xdyu35ICGhE9hKqvuA2x1ai2TxRtGivZzeK85xQ4ZwtrDWc0LNRa?=
 =?us-ascii?Q?K/i09E4/7jJBt58g3DfCZkgfae85Coc+Mf7XP3Y4+ovvm/2JUfZiyzZ3bvyL?=
 =?us-ascii?Q?Rw/sE+LHwJWWAw5obn3sMl0ZqjADfNKgJyzCDU6Nqlj1VPrGvRxPBytX1IJy?=
 =?us-ascii?Q?pPKgcd/OE9mimP7pwB5T3dWYYmPegk22IkuiCTAaPoU8rZ1LPLmUdZHAyi+8?=
 =?us-ascii?Q?9QukmvF39LhV5//1BpbFBB4S4v5Kvsq1Qr44ebaycXEE/7psPYwC5wLQUBGX?=
 =?us-ascii?Q?CSV7RKCXYDjVP10AgFadpCj0yiPvIFzRDnvm52fhvA2Xp0plmmpuncHQtnAM?=
 =?us-ascii?Q?24Kf78kVhEzIAhITzgGrV5KhEBaLGnEd6ceWZMhuLr3g13xQvdXSs2WHIxH3?=
 =?us-ascii?Q?Zd9C3/kOD7oNWu8mcAMZOMMUpsM+Y38+/JVamBNrljjUXRmV562uokhR2ahZ?=
 =?us-ascii?Q?bgIcmBZYLgt73u4ACbypHgvKd1nNAhpmwkFSuyF26A3lrCNpdrrgi4AXCAT/?=
 =?us-ascii?Q?xG3ZBhxcNKGbDF9yJR/uG1wL0nw/ifl1JZqkgN2t5/y/e8pCdUV0FDSc+e3z?=
 =?us-ascii?Q?BPgsltmkdsfnXScvSaFhQVh7w25w7O8LjYLOXttWSxwAoQwdC80WjbGKG+db?=
 =?us-ascii?Q?qXgPTdjCoTkRgYAZ3Y7T788KItGWUaijHmjz6evAM6r5xiTYnQtC3tMnDdUh?=
 =?us-ascii?Q?21ZiGynyqZEEBOgoGrdiGwjEmfDcKhH+deWJDnKYRu78ch/sydkNFpFCSwiq?=
 =?us-ascii?Q?w13ystg+/JFSNjR662mzmuegN0YFgpEUJ6VaPvNh/Ko9vPmCOn3x9zXP6UYE?=
 =?us-ascii?Q?GYoF7d1kdLAlDs4sthkL7iRj1mZm5pLuulpDh56cjBjHjwJL1FamNEHP23yh?=
 =?us-ascii?Q?m1XDmoEmrejElndVM0/Sd7Qa09vFWPJnqrviwer/Y6HMYuccTREqP5fokaRx?=
 =?us-ascii?Q?ivCAyUZpkkOpsNR/f+CwnGUY+1FsgJ9ESYx1FIcKiKZ2wSDAy3ywTrYNgfc0?=
 =?us-ascii?Q?+U/ceRGKOhmdF6pZPHlr56TTvPFcANaB5pvgXJPQ2vR/d3KAbpnsxzmcQxFO?=
 =?us-ascii?Q?+ySh6C6Zu8sQ+JssB4OB4hBDj6GLqaLR9WVhR3NsbfcmVVkpZN0ppSU5W63T?=
 =?us-ascii?Q?dXOPmtjcjoSaOIdZkEvSg38wRT3wzjwDZq+MGwPsr3naJljUFEdpKloTrnes?=
 =?us-ascii?Q?JFkqLiIAfpufX01vDXvAxLff5A7dtV/mPZNHpyTBpW2S30KtH71iq4Wv1kEW?=
 =?us-ascii?Q?lb2dGBqwBJdR3SMmqMa053niGkvoTg9f9jAkoLXo8hyIr6//SoGdQwXNfOw4?=
 =?us-ascii?Q?egVxE6gl0Tiv30/auPAFfeimKHPmVLfUYw4b36L5Ek9FuhKcFAKrdXbMOpYa?=
 =?us-ascii?Q?wC2d8a5tOVikqxo9soqhTB1ktwcw3iSN+Vdh8BstJXpY5w/3N5yxsCBSJyff?=
 =?us-ascii?Q?aCrnfiCurm+5Kjpnjv1eHI757hA+XdEZ0VU5P0CFzmD5JpODjQBVm89DOQ3y?=
 =?us-ascii?Q?ZEamoQOdafjRovS5erK5lxvAh37GymZd1UFKzpu2pL3EkBV1FzHCd/zlbA5K?=
 =?us-ascii?Q?44+sjI0eNJEI2INkUTqAHOiDTERsSarLFumeUHTE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2ed52f-0116-4106-9f75-08daa792ce6d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 12:03:39.9044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9sa35q6M57VoYirpEfE65TXhQdgOFyx1xU8dUyM/afG5SkPFsBv3TrGE3cDuHlG9fe/aXKMhxSnuC5zKsTBKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8245
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Changes to enable:
- To work both with black key and plain key.
- It is supported in context of trusted key only.
  - as meta-data is added as part of trusted key generation.
  - otherwise, work as previously.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/crypto/caam/caamalg.c      | 43 ++++++++++++++++++++++++++++--
 drivers/crypto/caam/caamalg_desc.c |  8 +++---
 drivers/crypto/caam/desc_constr.h  |  6 ++++-
 3 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index d3d8bb0a6990..94e971297a9d 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -3,7 +3,7 @@
  * caam - Freescale FSL CAAM support for crypto API
  *
  * Copyright 2008-2011 Freescale Semiconductor, Inc.
- * Copyright 2016-2019 NXP
+ * Copyright 2016-2022 NXP
  *
  * Based on talitos crypto API driver.
  *
@@ -59,6 +59,8 @@
 #include <crypto/engine.h>
 #include <crypto/xts.h>
 #include <asm/unaligned.h>
+#include <linux/hw_bound_key.h>
+#include <soc/fsl/caam-blob.h>
 
 /*
  * crypto alg
@@ -741,9 +743,25 @@ static int skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 	print_hex_dump_debug("key in @"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
 
+	/* Here keylen is actual key length */
 	ctx->cdata.keylen = keylen;
 	ctx->cdata.key_virt = key;
 	ctx->cdata.key_inline = true;
+	/* Here real key len is plain key length */
+	ctx->cdata.key_real_len = keylen;
+	ctx->cdata.key_cmd_opt = 0;
+
+	/* check if the key is HBK */
+	if (skcipher->base.is_hbk) {
+		ctx->cdata.key_cmd_opt |= KEY_ENC;
+
+		/* check if the HBK is CCM key */
+		if (skcipher->base.hbk_info.flags
+				& HWBK_FLAGS_CAAM_CCM_ALGO_MASK)
+			ctx->cdata.key_cmd_opt |= KEY_EKT;
+
+		ctx->cdata.key_real_len = skcipher->base.hbk_info.key_sz;
+	}
 
 	/* skcipher_encrypt shared descriptor */
 	desc = ctx->sh_desc_enc;
@@ -762,12 +780,33 @@ static int skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 	return 0;
 }
 
+static int caam_hbk_check_keylen(struct hw_bound_key_info *hbk_info,
+				 unsigned int keylen)
+{
+	u32 overhead = 0;
+
+	if (hbk_info->flags & HWBK_FLAGS_CAAM_CCM_ALGO_MASK)
+		overhead += CCM_OVERHEAD;
+
+	/* deduce the hb_key_len, by adding plain-key len
+	 * and encryption overhead.
+	 */
+	if (keylen != (hbk_info->key_sz + overhead))
+		return -EINVAL;
+
+	return aes_check_keylen(hbk_info->key_sz);
+}
+
 static int aes_skcipher_setkey(struct crypto_skcipher *skcipher,
 			       const u8 *key, unsigned int keylen)
 {
 	int err;
 
-	err = aes_check_keylen(keylen);
+	if (skcipher->base.is_hbk)
+		err = caam_hbk_check_keylen(&(skcipher->base.hbk_info), keylen);
+	else
+		err = aes_check_keylen(keylen);
+
 	if (err)
 		return err;
 
diff --git a/drivers/crypto/caam/caamalg_desc.c b/drivers/crypto/caam/caamalg_desc.c
index 7571e1ac913b..784acae8c9b7 100644
--- a/drivers/crypto/caam/caamalg_desc.c
+++ b/drivers/crypto/caam/caamalg_desc.c
@@ -2,7 +2,7 @@
 /*
  * Shared descriptors for aead, skcipher algorithms
  *
- * Copyright 2016-2019 NXP
+ * Copyright 2016-2022 NXP
  */
 
 #include "compat.h"
@@ -1391,7 +1391,8 @@ void cnstr_shdsc_skcipher_encap(u32 * const desc, struct alginfo *cdata,
 
 	/* Load class1 key only */
 	append_key_as_imm(desc, cdata->key_virt, cdata->keylen,
-			  cdata->keylen, CLASS_1 | KEY_DEST_CLASS_REG);
+			  cdata->key_real_len, CLASS_1 | KEY_DEST_CLASS_REG
+					       | cdata->key_cmd_opt);
 
 	/* Load nonce into CONTEXT1 reg */
 	if (is_rfc3686) {
@@ -1466,7 +1467,8 @@ void cnstr_shdsc_skcipher_decap(u32 * const desc, struct alginfo *cdata,
 
 	/* Load class1 key only */
 	append_key_as_imm(desc, cdata->key_virt, cdata->keylen,
-			  cdata->keylen, CLASS_1 | KEY_DEST_CLASS_REG);
+			  cdata->key_real_len, CLASS_1 | KEY_DEST_CLASS_REG
+					       | cdata->key_cmd_opt);
 
 	/* Load nonce into CONTEXT1 reg */
 	if (is_rfc3686) {
diff --git a/drivers/crypto/caam/desc_constr.h b/drivers/crypto/caam/desc_constr.h
index 62ce6421bb3f..d652bdbf3f91 100644
--- a/drivers/crypto/caam/desc_constr.h
+++ b/drivers/crypto/caam/desc_constr.h
@@ -3,7 +3,7 @@
  * caam descriptor construction helper functions
  *
  * Copyright 2008-2012 Freescale Semiconductor, Inc.
- * Copyright 2019 NXP
+ * Copyright 2019-2022 NXP
  */
 
 #ifndef DESC_CONSTR_H
@@ -500,6 +500,8 @@ do { \
  * @key_virt: virtual address where algorithm key resides
  * @key_inline: true - key can be inlined in the descriptor; false - key is
  *              referenced by the descriptor
+ * @key_real_len: size of the key to be loaded by the CAAM
+ * @key_cmd_opt: optional parameters for KEY command
  */
 struct alginfo {
 	u32 algtype;
@@ -508,6 +510,8 @@ struct alginfo {
 	dma_addr_t key_dma;
 	const void *key_virt;
 	bool key_inline;
+	u32 key_real_len;
+	u32 key_cmd_opt;
 };
 
 /**
-- 
2.17.1

