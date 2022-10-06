Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB025F659F
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Oct 2022 14:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiJFMEF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Oct 2022 08:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiJFMDf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Oct 2022 08:03:35 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80083.outbound.protection.outlook.com [40.107.8.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DAA9DFBF;
        Thu,  6 Oct 2022 05:03:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlvC67Z1enkQMkmSJlQ39YS8DTbIeZuD7ky5llukAazVLi6Hxsd8Eu1Mb7DSX9UJvPvM6sKRVDAnCadaPShccHuspaeo2jF1LSw42tEyhAvQk1D1+Qf6IrCu77ocn1D6agalsB6zDjoXwD5HSEH22MBYZj+OGX3woxJhuT1SFiwJPSg9ZqZyurUqHe+sSaS4c+/1+SKmxRDCm6ncDAuflDSTHxjtUf7UZBYnlg9lnrWkfdwdci17cbfzuhidAy6d36IkzwUK97z78oY/a1+eP92liSefHEnsHQxJiRTLoew+wEt7gPlaamvKYk6UXOLkguadWH8oM7kRZCQ2EOo9Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2UritZ64XhuLuHlDNnnLv+PulPgSfha2l3qQaupvMU=;
 b=oSDhUxjnqZaiyLjGw3AbOMst+YUO/VeUA8VFT0bBj/fLcSLDJhk8IZ3mB+k0kxGyu8bXB00+FRHSVuP5hqgnOI0nWQhlgUkG3mArMcfJ7GtmSRC+HmJpsIqkZ8PsxjBaMZCa4QpBE/5I4jFg4AT3Q5wRjOfRWxNMJbjCCyM8a8TtoSuxBReSquUxQ0bIy4F5dgjEzzDC2HmJnSAXCnf7jJjBQMfAZNVLI15Zny1TYUtZQjOEyQMLUOcUnbpCRz551RG3DbDFO7heqLClFJqw2OnwpEF1rgZ0x8W5FNT5JwtdDLEX7WWhJcXTEnDMGTOfV21+GJgFsTC2xUeu+0RE4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2UritZ64XhuLuHlDNnnLv+PulPgSfha2l3qQaupvMU=;
 b=QX5iQptiCSO87n/wxzXY52cjXIaMotgimCaJmHYs0W+fphSWDf5QmPkFa0KuLogn8w4UouZd1Az+2Qr8Xz726Ns61uxdayq1eAICMyTj42GW33UtupM7HgNcBNIOUxwPldk316CoeVgx1aHsEnY54RgK8U21t9mEZN8yp79IIWo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AM9PR04MB8523.eurprd04.prod.outlook.com (2603:10a6:20b:432::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 12:03:24 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::d551:6af4:bca4:88ea]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::d551:6af4:bca4:88ea%7]) with mapi id 15.20.5676.032; Thu, 6 Oct 2022
 12:03:24 +0000
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
Subject: [PATCH v0 5/8] keys-trusted: re-factored caam based trusted key
Date:   Thu,  6 Oct 2022 18:38:34 +0530
Message-Id: <20221006130837.17587-6-pankaj.gupta@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 23a599bd-0eee-4aff-04eb-08daa792c540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mBgm7ZPmylAiKlsaeZG+yIS2p23v80cBHzGjZpfkGPqH4UGoO/AwtxW0ZAXUWEUo0f+4SivS4tyU4UnwosV6GNLFVyVWnwx0jTdY7GA5JehlOS9ck4xykw0KdxENmJRjuM9lQwJWz/QGr1KepYF0+r4pMWceeyRKejEAmklNT9zd0SNSXqxYFAPcvW3f56hYC2pa0JhOjmjjDuXq6ClGOXbVux//rH8+EHm7WdLKKvSjYkaz4dlD5S8j/AcvipX4ovS2M5yuXji+pQrprZUVe0M/iLNIExq+bYc1lBZC0fYPhhIXtT3W8TW3PYpltSP4P02lRpjBOp1ani7zeaSN9oKawAnR509d0bTdMTks2aJTm31QIJyIsUxVOn4ZGkeYcgL254PepFVUv7Vr+cagdF3fmN4ot5zbXXK3VMrOeDzfN0fNaizCZaeZGqEttGxsEKsiMwxFgYp07GYQq/buTQf7dkeOizKzYCqR9oV+rCfiPRZ6cGFEhs0s1jVK0bzId/Q9a5q0Xk6VGyFnSlfIMs2ZYUfSSwNvyzTAqofvl28jwABA4RoL0SaX4JvMmqIpyzQoLC2SHImrSF0tY94AKPL1/tmliYm0lT1Qm+Nz4LVdgHqtVhBbl1xBjlhV5gUx8nnM5dM8HzjrcnRAmV5PAZbBS7WjrH8Y5YfGd4yx/dNJzzOtUmpZN2nSiLPcgaJ199BzJgSiPTO3seXt4U8DmpaNV6SDaBuazKOccGB5NCWPRxbNa20fOpFLhZ9kNQVJ+VPN8uW3M99D9EWs0v/Mz7RfK8bodCTR5Uz7gWAySX8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199015)(66946007)(66556008)(4326008)(66476007)(8676002)(38350700002)(38100700002)(478600001)(83380400001)(1076003)(36756003)(41300700001)(2616005)(186003)(6486002)(316002)(6636002)(52116002)(6506007)(6512007)(86362001)(921005)(6666004)(26005)(2906002)(44832011)(5660300002)(7416002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e6e+SMwx8GLMUlhorOigOYNoJzM/ABDOWYoGz+nh4pztMcfuqTBdCcEs5RWp?=
 =?us-ascii?Q?bZ3crDvn0vloTH7SQIvhTMypan7HN/Zllg6A9xjyqC8l7yDeKeb44PDilQpb?=
 =?us-ascii?Q?9FqEsAaRO7cQIJeB3TF7sw42I8GkSir7cxelc5e9eaX8+I9c8mfsVe5TKUgc?=
 =?us-ascii?Q?iQU4IlcOQ7AzDNkIP73qwUMY/xGDe1jbZvoXCZUo7WP/ASFlFeIZOKHvRnL1?=
 =?us-ascii?Q?oHijM+Y7obuipBRVV3gv1Mvwbib17u01wBqYAnkvb4r0yRMjKMpQUq6L+5W9?=
 =?us-ascii?Q?9KP6wDH5N9qP67sBlQRPKOWptOogm6DiMNKdeS72MqKX1xq8Fg+PRw4mHWbC?=
 =?us-ascii?Q?6htx9eQGIlTsD3c+4/nUzDlSzWoHSjx04nIz9ZctpX9oqqiCbJnldKtCv8GJ?=
 =?us-ascii?Q?RzD4yXFw3cSOkbuf4/HXIhoYd4ZAKeNxEYbHaZ0dxoutkRRCKw9rGUyc2LJI?=
 =?us-ascii?Q?U11ujtfJ3cnLeLJ43feA4ztYtejDpX2UskxGKubyjFjvNUmjH2lJ29KOcN6g?=
 =?us-ascii?Q?7+1qbhPhMRl6dzH4GMQPO2FZEdj4A2622XWjPv/F5c/cqxgjzYWKne4qgLSf?=
 =?us-ascii?Q?YztY69n+cp19TBzTPIRRAPuvkjUnVlafQhWaXpn+8XxWETORUSWhRIGpxQdl?=
 =?us-ascii?Q?O8GgKZoyddcCAazkTYsJPJWQsmCGmOBXB01DvecBq0naUXTEf+VQgj6em0Pv?=
 =?us-ascii?Q?XfjIFcwxlElbQHhVtBMWtRkVRUANDrQmO6uWNwrk0Gzf0muppZDOigeuHeCZ?=
 =?us-ascii?Q?6Xua8fFtUo/DImkiMBVVEFtbMn5LVUAeZvfAbv0xUjq14FhUG2hPmIZYSHFz?=
 =?us-ascii?Q?B4/7JkQR8xi2r0jgNdd2SvtATW9J8YA8v0vDsQBlgfeffCniHFLxqesDWvqj?=
 =?us-ascii?Q?9m8JlSynRl3YGlj/Uu05SpIptQwxPHvvEUlJuf0P3K8negLW+hGPnOWx0JeJ?=
 =?us-ascii?Q?UiYH54KDbzRhiWDF3R72Xl1AXSpLxymdQ/Lq9w/UBnihT721U+VmkNfvNpYp?=
 =?us-ascii?Q?xZCx2Z8/R+cBgQyxs8SyYaa95K1rZJy2sJiy3P44No9NdE2GRcplAtIniBKB?=
 =?us-ascii?Q?FD5tWIg2SDkdlS2GLhRkdr1MyMOG5tf/QrZQqGuFwbjtuW9NNWcR6VDDnkAE?=
 =?us-ascii?Q?/VuxAveG1bMTx4wI+smKJdW7JIcQlkyHrobUUTncko83vrLyRGF4wav26oBD?=
 =?us-ascii?Q?RIGDIcu0t+SfNk62DxTSY/Zv05Ms5xMkGZKqzvJf3uWxUu+dAaqt931OQu8e?=
 =?us-ascii?Q?oc8hfBofTalwNYqx+P/U+gQSEpSN6dxS1CIs7Mysk2mYlQzqHpc9Z7txo+mW?=
 =?us-ascii?Q?e/BTTmEejegX7W/xjm2K28IUjmhXAk+AanhSyTPfDgp/Qh//I4yGlonkQ8pJ?=
 =?us-ascii?Q?mGCzUAsySSHkjZKZLQ9dRS626DtLTXM8Fj3Bsraczp+LGRKlbZSO7X2Rd4wT?=
 =?us-ascii?Q?vgheNSiN8DANDF28lVhIncglolUbrJLDyt8F84Qvf45bZk0D/w0M28jtO6Uk?=
 =?us-ascii?Q?U+FHN9tEV2ndRfrMnVLGrXoH+NxXvbDZyMhe8NJ4vLlctZ6wqgC9K27S1ku9?=
 =?us-ascii?Q?e9JtJRU9/+WXIwldoPikW1vNQqxHcghOCj+kAWDa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a599bd-0eee-4aff-04eb-08daa792c540
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 12:03:24.5998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YaLS7Nz9i6NMEmMgvwbwm3HD1t6HOnTWeaIOJNJ7KU2+YPx2R+KGOzflsPhXIRxYeQ7KFb0C+NQruwQV3l4vvw==
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

Re-factored caam based trusted key code:
- Two separate definition for encap and decap having
  separate code for creating CAAM job descriptor.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/crypto/caam/blob_gen.c | 118 ++++++++++++++++++++++++++++++---
 include/soc/fsl/caam-blob.h    |  23 ++-----
 2 files changed, 114 insertions(+), 27 deletions(-)

diff --git a/drivers/crypto/caam/blob_gen.c b/drivers/crypto/caam/blob_gen.c
index 6345c7269eb0..36683ec9aee0 100644
--- a/drivers/crypto/caam/blob_gen.c
+++ b/drivers/crypto/caam/blob_gen.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2015 Pengutronix, Steffen Trumtrar <kernel@pengutronix.de>
  * Copyright (C) 2021 Pengutronix, Ahmad Fatoum <kernel@pengutronix.de>
+ * Copyright 2022 NXP, Pankaj Gupta <pankaj.gupta@nxp.com>
  */
 
 #define pr_fmt(fmt) "caam blob_gen: " fmt
@@ -58,8 +59,19 @@ static void caam_blob_job_done(struct device *dev, u32 *desc, u32 err, void *con
 	complete(&res->completion);
 }
 
-int caam_process_blob(struct caam_blob_priv *priv,
-		      struct caam_blob_info *info, bool encap)
+
+
+/** caam_encap_blob - encapsulate blob
+ *
+ * @priv:   instance returned by caam_blob_gen_init
+ * @info:   pointer to blobbing info describing input key,
+ *          output blob and key modifier buffers.
+ *
+ * returns 0 and sets info->output_len on success and returns
+ * a negative error code otherwise.
+ */
+int caam_encap_blob(struct caam_blob_priv *priv,
+		    struct caam_blob_info *info)
 {
 	struct caam_blob_job_result testres;
 	struct device *jrdev = &priv->jrdev;
@@ -72,14 +84,102 @@ int caam_process_blob(struct caam_blob_priv *priv,
 	if (info->key_mod_len > CAAM_BLOB_KEYMOD_LENGTH)
 		return -EINVAL;
 
-	if (encap) {
-		op |= OP_TYPE_ENCAP_PROTOCOL;
-		output_len = info->input_len + CAAM_BLOB_OVERHEAD;
-	} else {
-		op |= OP_TYPE_DECAP_PROTOCOL;
-		output_len = info->input_len - CAAM_BLOB_OVERHEAD;
+	op |= OP_TYPE_ENCAP_PROTOCOL;
+	output_len = info->input_len + CAAM_BLOB_OVERHEAD;
+
+	desc = kzalloc(CAAM_BLOB_DESC_BYTES_MAX, GFP_KERNEL | GFP_DMA);
+	if (!desc)
+		return -ENOMEM;
+
+	dma_in = dma_map_single(jrdev, info->input, info->input_len,
+				DMA_TO_DEVICE);
+	if (dma_mapping_error(jrdev, dma_in)) {
+		dev_err(jrdev, "unable to map input DMA buffer\n");
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	dma_out = dma_map_single(jrdev, info->output, output_len,
+				 DMA_FROM_DEVICE);
+	if (dma_mapping_error(jrdev, dma_out)) {
+		dev_err(jrdev, "unable to map output DMA buffer\n");
+		ret = -ENOMEM;
+		goto out_unmap_in;
+	}
+
+	/*
+	 * A data blob is encrypted using a blob key (BK); a random number.
+	 * The BK is used as an AES-CCM key. The initial block (B0) and the
+	 * initial counter (Ctr0) are generated automatically and stored in
+	 * Class 1 Context DWords 0+1+2+3. The random BK is stored in the
+	 * Class 1 Key Register. Operation Mode is set to AES-CCM.
+	 */
+
+	init_job_desc(desc, 0);
+	append_key_as_imm(desc, info->key_mod, info->key_mod_len,
+			  info->key_mod_len, CLASS_2 | KEY_DEST_CLASS_REG);
+	append_seq_in_ptr_intlen(desc, dma_in, info->input_len, 0);
+	append_seq_out_ptr_intlen(desc, dma_out, output_len, 0);
+	append_operation(desc, op);
+
+	print_hex_dump_debug("data@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 1, info->input,
+			     info->input_len, false);
+	print_hex_dump_debug("jobdesc@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 1, desc,
+			     desc_bytes(desc), false);
+
+	testres.err = 0;
+	init_completion(&testres.completion);
+
+	ret = caam_jr_enqueue(jrdev, desc, caam_blob_job_done, &testres);
+	if (ret == -EINPROGRESS) {
+		wait_for_completion(&testres.completion);
+		ret = testres.err;
+		print_hex_dump_debug("output@"__stringify(__LINE__)": ",
+				     DUMP_PREFIX_ADDRESS, 16, 1, info->output,
+				     output_len, false);
 	}
 
+	if (ret == 0)
+		info->output_len = output_len;
+
+	dma_unmap_single(jrdev, dma_out, output_len, DMA_FROM_DEVICE);
+out_unmap_in:
+	dma_unmap_single(jrdev, dma_in, info->input_len, DMA_TO_DEVICE);
+out_free:
+	kfree(desc);
+
+	return ret;
+}
+EXPORT_SYMBOL(caam_encap_blob);
+
+/** caam_decap_blob - decapsulate blob
+ *
+ * @priv:   instance returned by caam_blob_gen_init
+ * @info:   pointer to blobbing info describing output key,
+ *          input blob and key modifier buffers.
+ *
+ * returns 0 and sets info->output_len on success and returns
+ * a negative error code otherwise.
+ */
+int caam_decap_blob(struct caam_blob_priv *priv,
+		    struct caam_blob_info *info)
+{
+	struct caam_blob_job_result testres;
+	struct device *jrdev = &priv->jrdev;
+	dma_addr_t dma_in, dma_out;
+	int op = OP_PCLID_BLOB;
+	size_t output_len;
+	u32 *desc;
+	int ret;
+
+	if (info->key_mod_len > CAAM_BLOB_KEYMOD_LENGTH)
+		return -EINVAL;
+
+	op |= OP_TYPE_DECAP_PROTOCOL;
+	output_len = info->input_len - CAAM_BLOB_OVERHEAD;
+
 	desc = kzalloc(CAAM_BLOB_DESC_BYTES_MAX, GFP_KERNEL | GFP_DMA);
 	if (!desc)
 		return -ENOMEM;
@@ -145,7 +245,7 @@ int caam_process_blob(struct caam_blob_priv *priv,
 
 	return ret;
 }
-EXPORT_SYMBOL(caam_process_blob);
+EXPORT_SYMBOL(caam_decap_blob);
 
 struct caam_blob_priv *caam_blob_gen_init(void)
 {
diff --git a/include/soc/fsl/caam-blob.h b/include/soc/fsl/caam-blob.h
index 937cac52f36d..de507e2a9555 100644
--- a/include/soc/fsl/caam-blob.h
+++ b/include/soc/fsl/caam-blob.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (C) 2020 Pengutronix, Ahmad Fatoum <kernel@pengutronix.de>
+ * Copyright 2022 NXP, Pankaj Gupta <pankaj.gupta@nxp.com>
  */
 
 #ifndef __CAAM_BLOB_GEN
@@ -72,15 +73,8 @@ int caam_process_blob(struct caam_blob_priv *priv,
  * Return: %0 and sets ``info->output_len`` on success and
  * a negative error code otherwise.
  */
-static inline int caam_encap_blob(struct caam_blob_priv *priv,
-				  struct caam_blob_info *info)
-{
-	if (info->output_len < info->input_len + CAAM_BLOB_OVERHEAD)
-		return -EINVAL;
-
-	return caam_process_blob(priv, info, true);
-}
-
+int caam_encap_blob(struct caam_blob_priv *priv,
+		    struct caam_blob_info *info);
 /**
  * caam_decap_blob - decapsulate blob
  * @priv:   instance returned by caam_blob_gen_init()
@@ -90,14 +84,7 @@ static inline int caam_encap_blob(struct caam_blob_priv *priv,
  * Return: %0 and sets ``info->output_len`` on success and
  * a negative error code otherwise.
  */
-static inline int caam_decap_blob(struct caam_blob_priv *priv,
-				  struct caam_blob_info *info)
-{
-	if (info->input_len < CAAM_BLOB_OVERHEAD ||
-	    info->output_len < info->input_len - CAAM_BLOB_OVERHEAD)
-		return -EINVAL;
-
-	return caam_process_blob(priv, info, false);
-}
+int caam_decap_blob(struct caam_blob_priv *priv,
+		    struct caam_blob_info *info);
 
 #endif
-- 
2.17.1

