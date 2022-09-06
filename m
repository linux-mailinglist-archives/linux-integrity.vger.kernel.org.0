Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57ADC5ADF31
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Sep 2022 07:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238327AbiIFFwS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Sep 2022 01:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237736AbiIFFvh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Sep 2022 01:51:37 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10074.outbound.protection.outlook.com [40.107.1.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3686582E;
        Mon,  5 Sep 2022 22:51:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebxEn08C61oTwe6gPb7efjVBuvQfGr3MGfRofWOvMVS15SaXxyt99iINpHRx2MgqXmSsoair+gjwEOKay0Ri9xTozQu6EkbDEVd3OpyZG4g96QBqUcNkUAbtQaVKPo9Q9akYpTWJs0uSOt+yW+RahP9pj/+cj4FlclOCiTfsegAyu67xMgkZbBuB+l8+roWAQHf3W2j+d5T7eGfsY7o4WtDYPnYS2tKk+8HU+S0CUGJWdDkBxRVACYMfb2kxQ/umzxMiz7twQXs4TCu7MneHEZPB2TKgz10WkDNOsA/NKmcw/KtKdbf1ZNmfwhhjaCtc+a1ElSkRQlSzcsg5+hcepw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6FQW9hNUjaVzqCmSWBiXp+ijFABj5QYHO3sceWPnqI=;
 b=h6oIO2zQOcaI5GDvvrnkUCE/c+Q+VjQyUPLWx9d9qL6YtWCAvZNBdNavaxCTyDFnINSa7g5zdC+GT7XnCaRrWyuFPFwhabgfx12KzcGnCNqPxmCu2gNUO7ozV6WWIdXPw9/BKWzDOC8ZzT8D0z2kshezeUQFFWylJzyzWk9mDTQHYXU9ktmo08QETtCoK8/FvjBpZJciApKVT9MwIFGid2jlzdLJZLBimClqRjjr0Jv9S14glS0f7CKFXb4pL6pQCj937qs0HRzvMMzWmpnCjEf4NRHd0L9iqlZ7N9+8Lwfc3ODBcBdHi5OzRre6bqs3Ih2/87lLQDYO43XBMe8mgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6FQW9hNUjaVzqCmSWBiXp+ijFABj5QYHO3sceWPnqI=;
 b=VrUNKVDnRQMV+7Br7tcmZxvwUFFwW8EuvDRyUilxQ/hsTuLniBV7U3oSvJ/Ia2dHMLiDPvdtdtxqe6Tag6573niXmAlwJN8kNm80ArIwo7+0GDn2+3/tntDCQTzheQwd1LtVCqVtSUazP0p8kABWSFGTArdF34YFupTxgoRS6DE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AM0PR04MB6657.eurprd04.prod.outlook.com (2603:10a6:208:17a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 05:51:06 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b%4]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 05:51:06 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     jarkko@kernel.org, a.fatoum@pengutronix.de, Jason@zx2c4.com,
        jejb@linux.ibm.com, zohar@linux.ibm.com, dhowells@redhat.com,
        sumit.garg@linaro.org, david@sigma-star.at, michael@walle.cc,
        john.ernberg@actia.se, jmorris@namei.org, serge@hallyn.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        j.luebbe@pengutronix.de, ebiggers@kernel.org, richard@nod.at,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, sahil.malhotra@nxp.com,
        kshitiz.varshney@nxp.com, horia.geanta@nxp.com,
        pankaj.gupta@nxp.com, V.Sethi@nxp.com
Subject: [RFC PATCH HBK: 7/8] caam alg: symmetric key ciphers are updated
Date:   Tue,  6 Sep 2022 12:21:56 +0530
Message-Id: <20220906065157.10662-8-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220906065157.10662-1-pankaj.gupta@nxp.com>
References: <20220906065157.10662-1-pankaj.gupta@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b4fbbab-f219-4d83-1657-08da8fcbca43
X-MS-TrafficTypeDiagnostic: AM0PR04MB6657:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2RzErukOS570x0c+ALJCkFcjS/LbyZ1o/T5hNVUHlNfOkTNZVrd5qNVkh2iyXzstqYXZllwWOLjPEHhqQc+j8rScdl92UGmVI6K3bvATYeZE7k3oSZrcQk2mmkhXt1ENHPprQvzeb3DHi9LKJu3BZhANiUeXhy0XcmFZCoP2xQfo+7hWfz0RvYVlTjAtcOyVo2ccTuLunjZ5h01nRAe8G1PcGyUpDL2RhPdlHrG2NiVOqXRGDebSYyvJuYdXwmj1vKcnWtFiWbSjLmGBz1O4Q9jBVwvJB2AqKQ6InMQ46DYtDdfc2RysVLP3FtGum3YYGsFLra5nHjHU6DXzK7viaVdQ78gHaY7I8Mnk6aBT3EL/9DqSPpvEOEg+wkdHP3YudvrY88Tm/QJfjXHpsilQcbrqcofBZfGSPagdbX0K7ct6LFYg15F1EnFRJ4nOSwR/5FMXILFihTFKX3hlE5hF0PASfpxgDGRku2+/Es9CDqVT2txxJgI1SBzVvKaJ2MRFISyzx+DG1uxyLK5AjbAAklRvxDDBdWpjllNEYVe7FP/6ezoObsfejvFYBwojJGocR+h3MMaFOu15eRYkRs+LVVX+NP68wlMdO8XMlDjqf/yLYbPWW2O3r99vaLNwXoXWrhdB5IKC3XMdAto7XM6Rk/I/jlct1id9O4cB1Dw/W7gyz6GAW8Kodwc1oXc3wh14EtVeMbxuyIDIJVy3Et9IH7lnZRzh+ltqqCN9vW2/03BGFQrt/xzP8JeVVVTw/ZPcbQqT/nuNHygnJz24hr99GcxvYp1MNBTrga6GRrJ8Lko=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(6486002)(6512007)(316002)(52116002)(6506007)(478600001)(6636002)(41300700001)(86362001)(26005)(6666004)(38350700002)(38100700002)(83380400001)(2616005)(186003)(921005)(1076003)(66556008)(66946007)(66476007)(36756003)(2906002)(8936002)(7416002)(8676002)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?faN1j7XalYOtfdWF0SU3z/IKckSuEDVI4KfcrbpcByhHaOpYprg+/Fb1ynEY?=
 =?us-ascii?Q?MpM675HtyYk40U09J9JzhNpaLCHbBnUVrSJCCpKevFAXPLOF3NUb6tvRYvg9?=
 =?us-ascii?Q?5QDpqC9dAxCtPhKuKKg5/gLn9J6COLD1iKEPyIIwhm95vYdzFCLJW2YTOysP?=
 =?us-ascii?Q?ZolUL9Of7abQPT1iU2hrY6SJ7OaXjYewNqsQK+ofq9Y/lYKWaVcd6CeRYZYJ?=
 =?us-ascii?Q?l8OVs6Dy4FBH4jMcaD6jNn0K14RGisnNYX/T5VWRz8TxG/cIkRDUNGAyy2Lh?=
 =?us-ascii?Q?QvzrV6xVa0NNqpzvsEVk/RkmHALUxwvYz3xwHxu14ukr45VzyBz32SVVEQhK?=
 =?us-ascii?Q?4+bRumvYF6Us1GSoYKo/KT0fiHTNG/OLeBTEJm6I6Ig1S4+dnBfMmD4YAidG?=
 =?us-ascii?Q?shO/4w6kIRby75R2qNbELKc+e7zs/cF5SmcEb5nSgqj6TFNurvbSOhWvKSJY?=
 =?us-ascii?Q?ir70psq5q1yJp3PKQ2kB4LhB/8R/L+nbgEnJYyBYDSGoij44jaDFB3p5JNGe?=
 =?us-ascii?Q?GUHDWpeVhJqCqk60kq895Yf9JjyI8Se3G0LKUdoZxAhsgkvZ/vl4W00VJsUg?=
 =?us-ascii?Q?BmHsSJlVrg6q6wPr/pc8+F7stoN4fbG88kG8RbNFwkYojlfdqxgWle9rVLKL?=
 =?us-ascii?Q?gXCuqJfIB4e8MjqNRafVZqu1k+TTX5Vsa1x7DWTFN87mTdqpmtBA61BIsyaM?=
 =?us-ascii?Q?zx8EuEQi52nm+8BhJzwF+QRs5u8TsUxwpufaxK0jNiH/Js5zLwJDk5hs+ueH?=
 =?us-ascii?Q?1Sfdz8FudJWrW8dB8zcDoh96PeGdkrrDYnfhy/b0DIc11fxgb1O7XVYT3lZS?=
 =?us-ascii?Q?jD1QT3e9lEVbvEVEPrBNBq+4MOFPQJz8QcYMt3dp4mcsMwvTiB7JEC4U5VHm?=
 =?us-ascii?Q?j4rYUS1oCbpXRFm2ImxpEtqIw/UM1HZb1rW974QK3cWwOkr6z1d9XhganZ72?=
 =?us-ascii?Q?bqwO3RfLNfGcJ0zoqUm+lf7c3Nvr/QVZx6EEpO+ZQhEbP2tu3w9CaDerRRcv?=
 =?us-ascii?Q?t69JM8/91EaeKCjIy9avLbadXpGSHahhdOY6+74peZ9OaR7qJCUYjwVeyjDv?=
 =?us-ascii?Q?nYi/s4A5J8eDwGXikvlhGuY6lMEGU/psEbXbVaWhLr9s0S58YD8grezuE0r2?=
 =?us-ascii?Q?CmnZf5WBCgwyqoDboGetDZ1CGcq+Y7tth435LQHKkYrJ5xmUDJiHMYH41Ijr?=
 =?us-ascii?Q?TC3eVl6Jy8PY1h7rOsF83INl+8RoG1s1to8uP8qatSdbDq2QnQMUGZbP9JFe?=
 =?us-ascii?Q?HiLDNXrz4Mh7pZmDgHM11Se1Of7zjQWkS3+bJvjjbAoLWO6tkPYbmM0/ymjj?=
 =?us-ascii?Q?o1dWMnlabVSvcJmeFQ9p5tWlw0uUGgwRkYb3OkL6zUgjIpcmbI37mWLEtPGs?=
 =?us-ascii?Q?JhvtkUdcUdaolzeq5jszlrT9zuUZf59gcfRNQ84fQ50TTtxxYUqc7Byq3h8S?=
 =?us-ascii?Q?zzzd2FGRAq11oSze9/9R8f+2RcHcnrMh3/4ofVcn7utgSGkbEMxSJIT3Hngl?=
 =?us-ascii?Q?l4diRk4nREslyOiHV1OZ15y1onquXugrU4FbYhx+Xh2VWCwlRPW/YbV/r+v+?=
 =?us-ascii?Q?7UWSk6+xwy8ve+hm3Qbcn3xSQ846BdzKviAKn4Ol?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4fbbab-f219-4d83-1657-08da8fcbca43
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 05:51:06.4792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hcwSAyJ4ogJsm4RLp4ZQYm29OQ25PYpvmLGs/M2ClXFj4Q4UmCOMv2e242/hVqPD2ben7Xdr7cHUm/1fysc50Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6657
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Changes to enable:
- To work both with black key and plain key.
- It is supported in context of symmetric key ciphers only.
- Based on as crypto layer's flag: tfm->is_hbk, handling for
  h/w bound key is done.
- Otherwise, work as previously.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/crypto/caam/caamalg.c      | 37 ++++++++++++++++++++++++++++--
 drivers/crypto/caam/caamalg_desc.c |  8 ++++---
 drivers/crypto/caam/desc_constr.h  |  6 ++++-
 3 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index d3d8bb0a6990..2c96aecab627 100644
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
@@ -59,6 +59,7 @@
 #include <crypto/engine.h>
 #include <crypto/xts.h>
 #include <asm/unaligned.h>
+#include <soc/fsl/caam-blob.h>
 
 /*
  * crypto alg
@@ -734,6 +735,7 @@ static int skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 		container_of(crypto_skcipher_alg(skcipher), typeof(*alg),
 			     skcipher);
 	struct device *jrdev = ctx->jrdev;
+	struct caam_drv_private *ctrlpriv;
 	unsigned int ivsize = crypto_skcipher_ivsize(skcipher);
 	u32 *desc;
 	const bool is_rfc3686 = alg->caam.rfc3686;
@@ -741,9 +743,26 @@ static int skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
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
+		ctrlpriv = dev_get_drvdata(jrdev->parent);
+		ctx->cdata.key_cmd_opt |= KEY_ENC;
+
+		/* check if the HBK is CCM key */
+		if (ctrlpriv->blob_priv.hbk_flags
+				& HWBK_FLAGS_CAAM_CCM_ALGO_MASK) {
+			ctx->cdata.key_cmd_opt |= KEY_EKT;
+			ctx->cdata.key_real_len = keylen - CCM_OVERHEAD;
+		}
+	}
 
 	/* skcipher_encrypt shared descriptor */
 	desc = ctx->sh_desc_enc;
@@ -766,8 +785,22 @@ static int aes_skcipher_setkey(struct crypto_skcipher *skcipher,
 			       const u8 *key, unsigned int keylen)
 {
 	int err;
+	int overhead = 0;
+	struct caam_ctx *ctx;
+	struct device *jrdev;
+	struct caam_drv_private *ctrlpriv;
+
+	if (skcipher->base.is_hbk) {
+		ctx = crypto_skcipher_ctx(skcipher);
+		jrdev = ctx->jrdev;
+		ctrlpriv = dev_get_drvdata(jrdev->parent);
+		if (ctrlpriv->blob_priv.hbk_flags
+				& HWBK_FLAGS_CAAM_CCM_ALGO_MASK)
+			overhead += CCM_OVERHEAD;
+	}
+
+	err = aes_check_keylen((keylen - overhead));
 
-	err = aes_check_keylen(keylen);
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

