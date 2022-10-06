Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D6B5F65A4
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Oct 2022 14:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiJFMEa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Oct 2022 08:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiJFMDv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Oct 2022 08:03:51 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015BF9E0FF;
        Thu,  6 Oct 2022 05:03:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUYVFHGLetpBMXujCCzjU4J2eFAa9zi0/GK68Jav68lHRU6Z8QZe++JX0jX5AM6CHQ9t+zNSfD5k7fkwT54QWELQuDFM6rJcr1cCryRJdg1wsxFb9kKUE9ip6pw9ue84L8oFd8EZWNAvMq2QomPRjp928DcjuCYmwubIhb2xf+cSKpdVa0p/dSEeleOOFRzYGKWomrPuljy2Q8fJhbgWwo0WZNiFAUOTWEiWyWw17H5e4bf4aFVHHDZM/V9kSQyE1x7Io1EKVvpO2fzy8Vyg7CT5M45PcKboc0cYe8cJFkGewYY9KfwUZm7oojeBo6GjY1iMYFfV7HjO2JPEwWRfPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQQVzVk1wfibk9bdpjQfi8CXKdBDOHMEi7f9ZwMZzlM=;
 b=BmTUhlyF1hO1eQ59t8hgAT/TrjB3cOXwlNF1OIZYGzFxb9PE3NR4Zg7l30gURZq4qWfHYhHzIqhbtbHcFLpVUB5t1EPaYddyLAknnG04TjTdTXsOD8mK58UQ2waPLw3YnY7/06NbRf15ZarjMOHqM9w78QtqJ5BP7TuusL1R/Ed7GB2FZ/Hsc+VCe7SMsNi638sMLqwOcFpKMTlR8U0lSNhGpANcgsADHYPcJ7es23KuPWXVhSWkHP3uwZxhhbKUSH9rwmpfMz0jvjJD4fdv2FzNzlzu7v7voFpDzZP+l7z3CLWyK08mjAP42L1uehHe9zUw3dll1psUE4JBt8A5Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQQVzVk1wfibk9bdpjQfi8CXKdBDOHMEi7f9ZwMZzlM=;
 b=CFbI1M2sgXRYk1aGNnTkT47FTQMV8bUVLjMI3Q/jyfMA2IJFbwFRtkV3UHPHTS44EKrzjapBBIuW1mFqn8Qg9fNYrK7UuISYbB9mnxVo9c6y+C8+SR/WjqCZJpGTu8Uoc4Zcy0oqbJT2hnBJq6nstKcGLmqtkEPOOl4GdPWUqHk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS8PR04MB8245.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Thu, 6 Oct
 2022 12:03:32 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::d551:6af4:bca4:88ea]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::d551:6af4:bca4:88ea%7]) with mapi id 15.20.5676.032; Thu, 6 Oct 2022
 12:03:32 +0000
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
Subject: [PATCH v0 6/8] KEYS: trusted: caam based black key
Date:   Thu,  6 Oct 2022 18:38:35 +0530
Message-Id: <20221006130837.17587-7-pankaj.gupta@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: efadc8de-e4b9-4fa1-014f-08daa792c9d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HBfFs0FdOQWgS2E8GIu/fsF/QnVPbI0tTFQNqXXnAjNXvZwuatNSbIMzuCIvQuj3Lc7jtN4MeZNlQz0i0sUW1UHcqoqkurCJjMgHdbqKL3dN6H+HZ91PDspUeldNUed5NoXjSnJ1C4IkBQcLNmBg0yPJiWLqGBEa2YsM2pzGv91zWAXXkD4Pu2ijHi21YWsRKtcFqSAqc2s845ilA9lrZ9Hj58cj2Ka9oJdsOqNRlfL/Wh0TKoDZ1nDBDkMldUf/bcCIm0WZ/+VSYnyPmL4PNqFNFuxf467mINcQuOizpO5l1BVZ8DDVZb0RWbvv9GdQh8Zxw89F7+7G23Mvk8N9fBfc4EsBX2tAbhC4CuGSKTgeHWfnloVn9k4iWCoXHGbTjad0gRcIyadUOkPPeCRwOaMB/8FsDAJGUwIgO8UJHZw9WucTDDszNEJs/zYYm5TvOSw9qu6C0vGkfbGIpy1teQKXgHwXYKYTNPTAlg3Pi2iwtJtoj1jZWEr84NCIv+kwrNRXT+z8I0WWHzb5bHrjp4V1MlxYwrs8IgNPMXGUo5lwgG+3owH38LuobLW0M/7Rti79U2EIyYpxz/alC5MY2QxGCg5tX1fQ2Ulu81pp4zr/xz+djFwWYYghXTxN9ejmzbuQP7PqSCvEOLQuXGSOFy7EIJ82QTKOEvR1yZk0G9CEezGOOQUrGpOm6EOWZPbZx9k9wWLSFrEc2V97ddn3HPdnrwRofFy6ho0U44YmcMn3DfsY98r7gw5aK3wPfo0ClWSWxJ3qNDW6IjhCR+xsgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199015)(2616005)(186003)(83380400001)(1076003)(38100700002)(7416002)(38350700002)(921005)(30864003)(5660300002)(44832011)(2906002)(8936002)(6506007)(52116002)(6486002)(6512007)(41300700001)(478600001)(26005)(6636002)(8676002)(66476007)(66946007)(4326008)(66556008)(316002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VLWh1KEDCEi11UWHGGByJLYYjOI7NNnjsEvgB4HKv6i4rNaP3EOwWFlYNvrg?=
 =?us-ascii?Q?oQgCIwyczPu8opYp2o8xEq4sqU4NwCqGIbi2WreovLTEOo2XL6mgMeHCiH47?=
 =?us-ascii?Q?1XtO1QHCpuoaVUzrH443nZCkP+wh2IAcP2JaXXpQzoxV2kRptFYGn2Zn2c7G?=
 =?us-ascii?Q?IlfMvB8pxHAfdO6ryCG9FX4H5DFEq6wtHNA77VNbZUNMyi6cJts6lTZ/sC1Y?=
 =?us-ascii?Q?lkXQRsAwEz9oH1qabHQvuiWvxcLk9eJkzT/ni5XDkXdjfcs+HSE1yOAyq28E?=
 =?us-ascii?Q?FlB6uFZGLLMfKmfSOGihejPqulCYa8yNcuoDvurYChvWHANA5uWhZzuAqXQc?=
 =?us-ascii?Q?0O3NYP/T2fRh7Qigs88Y/lx6e7MdL9gTNPxSBKVtA/7/SiRp8ry8mMHVt8sB?=
 =?us-ascii?Q?w7fMzOPctVztFQ44ZJWCT3bu20MfWVcwVV0C++WZxR3gZjUF0LyCFZTWBYGg?=
 =?us-ascii?Q?VCzkyG6qlzXoePlXfjNChfQgazs49J5jYoo4K/kkGTtb6z7Iy9afv7v8R0fQ?=
 =?us-ascii?Q?6hehXybV8rYk1m0P2J/omdEU1sPIolaSdZklbdLVVQ44ulESktCrzIpeD8Wd?=
 =?us-ascii?Q?gGl2gCjcAmgr2vv4tOOrAIZa5rvcCcmh9oh9CXKsb/BMhB+goVoJXepErJgP?=
 =?us-ascii?Q?WqMawl0k+Pzloa5pQLJ1O0ZpOV7nkuk5nUYB4rHgZwn4pBFhivNKUL/DwqLh?=
 =?us-ascii?Q?3JbaVyRSkJ4jAz8L5ZeO8aIUV+wKokiTx89N/DtRMlLhsFbt0+V0liiTHYW+?=
 =?us-ascii?Q?p4ptr5WSgxlfQgokp/hcXqV/obbceUOc3VsjlmDcpkzeUgiRm7SYR8Qmslwa?=
 =?us-ascii?Q?3ZOsix+7MDUEphSWNUJnIcI9nzHi+YUtI5cqMfLMnpq/PGOxW0q2GN/9EucK?=
 =?us-ascii?Q?d4sl8rO4UjqvN49aN9IoP0YAnA7V++C4QwJPwV40+Hb3aGpmoT0XhR7cMq5Y?=
 =?us-ascii?Q?7/CGFzG3kL5w6yGo227DGWbVF7SGq0UOhCddmRhvZmFRPSu8kbIzX76Vy6JH?=
 =?us-ascii?Q?74WzWErUTa9pS+qVWLNMBWAcIp4uHhAPGFFD2XqvrHxi7wJxAOMf0fD2AxvD?=
 =?us-ascii?Q?85W6PUz8Jv8nCAw1kkjrYARXdC7XmF1AtfdOHipbrL4AmApuVjak2aekAS1V?=
 =?us-ascii?Q?iNNNW1mNO0R6GOsQONNk/rI/tbP8Or3XCqOdgUXgm5eA936MKmTwemwFGu5Y?=
 =?us-ascii?Q?NOE+RSlppTKOGNfZlRAkDfrPhiETxztrEKlIkNi0ll6HJ2Tjk2zoR6pRqbeV?=
 =?us-ascii?Q?xtFn/sxmd2CifYy/HLhXe1jAsYUHH9EwKcGWmaK05CBgH+OHLVdIQ/81e51c?=
 =?us-ascii?Q?kIxXJZpFPsOxTUATogGNpMPX7l3KfHbV/ei8iJCZuPVcUemBpZgLUCPewSH6?=
 =?us-ascii?Q?c7rHXAPzYQTgNfxXEELMqtoNlQjNcDcvgScY5OreTEop4NH95Ev5K9OinR9t?=
 =?us-ascii?Q?AGMhuFNP2ev27jSobSMtV0VvGcgV7o8H54whGYeLuATOEv5gtYcHHy8GuKzO?=
 =?us-ascii?Q?70/FFFrDeAum09ixieDoAVZWlW2i+47wyb1ibnNqWIMFMWke/MD5Y+HIM5Jz?=
 =?us-ascii?Q?FF6BomRhMeYFsQx9C2mOusXCM441QC+AbW4Z0+AD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efadc8de-e4b9-4fa1-014f-08daa792c9d6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 12:03:32.3072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D2CsDQ44cSePbeADfRPG8K2L529bny37fBaWS1VSGIwhfufc89Qv3o+/I8O0Tmql9vHNdDManv6UddQGskj/Dw==
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

- CAAM supports two types of black keys:
  -- Plain key encrypted with ECB
  -- Plain key encrypted with CCM
  Note: Due to robustness, default encytption used for black key is CCM.

- A black key blob is generated, and added to trusted key payload.
  This is done as part of sealing operation, that was triggered as a result of:
  -- new key generation
  -- load key,

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/crypto/caam/blob_gen.c            | 123 +++++++++++++++++++---
 drivers/crypto/caam/desc.h                |   8 +-
 include/soc/fsl/caam-blob.h               |  15 +++
 security/keys/trusted-keys/trusted_caam.c |   8 ++
 4 files changed, 136 insertions(+), 18 deletions(-)

diff --git a/drivers/crypto/caam/blob_gen.c b/drivers/crypto/caam/blob_gen.c
index 36683ec9aee0..93e05557dcaa 100644
--- a/drivers/crypto/caam/blob_gen.c
+++ b/drivers/crypto/caam/blob_gen.c
@@ -8,6 +8,8 @@
 #define pr_fmt(fmt) "caam blob_gen: " fmt
 
 #include <linux/device.h>
+#include <linux/hw_bound_key.h>
+#include <keys/trusted-type.h>
 #include <soc/fsl/caam-blob.h>
 
 #include "compat.h"
@@ -32,6 +34,9 @@
 
 struct caam_blob_priv {
 	struct device jrdev;
+	/* Flags: whether generated trusted key, is ECB or CCM encrypted.*/
+	uint8_t hbk_flags;
+	uint8_t rsv[3];
 };
 
 struct caam_blob_job_result {
@@ -78,8 +83,13 @@ int caam_encap_blob(struct caam_blob_priv *priv,
 	dma_addr_t dma_in, dma_out;
 	int op = OP_PCLID_BLOB;
 	size_t output_len;
+	dma_addr_t dma_blk;
 	u32 *desc;
 	int ret;
+	int hwbk_caam_ovhd = 0;
+
+	if (info->output_len < info->input_len + CAAM_BLOB_OVERHEAD)
+		return -EINVAL;
 
 	if (info->key_mod_len > CAAM_BLOB_KEYMOD_LENGTH)
 		return -EINVAL;
@@ -87,6 +97,21 @@ int caam_encap_blob(struct caam_blob_priv *priv,
 	op |= OP_TYPE_ENCAP_PROTOCOL;
 	output_len = info->input_len + CAAM_BLOB_OVERHEAD;
 
+	if (info->is_hw_bound == 1) {
+		op |= OP_PCL_BLOB_BLACK;
+		if (priv->hbk_flags & HWBK_FLAGS_CAAM_CCM_ALGO_MASK) {
+			op |= OP_PCL_BLOB_EKT;
+			hwbk_caam_ovhd = CCM_OVERHEAD;
+		}
+
+		if ((info->input_len + hwbk_caam_ovhd) > MAX_KEY_SIZE)
+			return -EINVAL;
+
+		set_hbk_info(info->hbk_info,
+			     priv->hbk_flags,
+			     info->input_len);
+	}
+
 	desc = kzalloc(CAAM_BLOB_DESC_BYTES_MAX, GFP_KERNEL | GFP_DMA);
 	if (!desc)
 		return -ENOMEM;
@@ -99,12 +124,26 @@ int caam_encap_blob(struct caam_blob_priv *priv,
 		goto out_free;
 	}
 
+	if (info->is_hw_bound == 1) {
+		dma_blk = dma_map_single(jrdev, info->input,
+					 info->input_len + hwbk_caam_ovhd,
+					 DMA_FROM_DEVICE);
+		if (dma_mapping_error(jrdev, dma_out)) {
+			dev_err(jrdev, "unable to map output DMA buffer\n");
+			ret = -ENOMEM;
+			goto out_unmap_in;
+		}
+	}
+
 	dma_out = dma_map_single(jrdev, info->output, output_len,
 				 DMA_FROM_DEVICE);
 	if (dma_mapping_error(jrdev, dma_out)) {
 		dev_err(jrdev, "unable to map output DMA buffer\n");
 		ret = -ENOMEM;
-		goto out_unmap_in;
+		if (info->is_hw_bound == 1)
+			goto out_unmap_blk;
+		else
+			goto out_unmap_in;
 	}
 
 	/*
@@ -116,15 +155,40 @@ int caam_encap_blob(struct caam_blob_priv *priv,
 	 */
 
 	init_job_desc(desc, 0);
+
+	if (info->is_hw_bound == 1) {
+		/*!1. key command used to load class 1 key register
+		 *    from input plain key.
+		 */
+		append_key(desc, dma_in, info->input_len,
+						CLASS_1 | KEY_DEST_CLASS_REG);
+
+		/*!2. Fifostore to store black key from class 1 key register. */
+		append_fifo_store(desc, dma_blk, info->input_len,
+				  LDST_CLASS_1_CCB | FIFOST_TYPE_KEY_CCM_JKEK);
+
+		append_jump(desc, JUMP_COND_NOP | 1);
+	}
+	/*!3. Load class 2 key with key modifier. */
 	append_key_as_imm(desc, info->key_mod, info->key_mod_len,
 			  info->key_mod_len, CLASS_2 | KEY_DEST_CLASS_REG);
-	append_seq_in_ptr_intlen(desc, dma_in, info->input_len, 0);
+
+	/*!4. SEQ IN PTR Command. */
+	if (info->is_hw_bound == 1) {
+		append_seq_in_ptr_intlen(desc, dma_blk, info->input_len, 0);
+	} else {
+		append_seq_in_ptr_intlen(desc, dma_in, info->input_len, 0);
+	}
+
+	/*!5. SEQ OUT PTR Command. */
 	append_seq_out_ptr_intlen(desc, dma_out, output_len, 0);
+
+	/*!6. BlackBlob encapsulation PROTOCOL Command. */
 	append_operation(desc, op);
 
 	print_hex_dump_debug("data@"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 1, info->input,
-			     info->input_len, false);
+			     info->input_len + hwbk_caam_ovhd, false);
 	print_hex_dump_debug("jobdesc@"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 1, desc,
 			     desc_bytes(desc), false);
@@ -140,11 +204,15 @@ int caam_encap_blob(struct caam_blob_priv *priv,
 				     DUMP_PREFIX_ADDRESS, 16, 1, info->output,
 				     output_len, false);
 	}
-
-	if (ret == 0)
+	if (ret == 0) {
+		info->input_len += hwbk_caam_ovhd;
 		info->output_len = output_len;
-
+	}
 	dma_unmap_single(jrdev, dma_out, output_len, DMA_FROM_DEVICE);
+out_unmap_blk:
+	if (info->is_hw_bound == 1) {
+		dma_unmap_single(jrdev, dma_blk, info->input_len, DMA_TO_DEVICE);
+	}
 out_unmap_in:
 	dma_unmap_single(jrdev, dma_in, info->input_len, DMA_TO_DEVICE);
 out_free:
@@ -170,15 +238,35 @@ int caam_decap_blob(struct caam_blob_priv *priv,
 	struct device *jrdev = &priv->jrdev;
 	dma_addr_t dma_in, dma_out;
 	int op = OP_PCLID_BLOB;
-	size_t output_len;
 	u32 *desc;
 	int ret;
+	int hwbk_caam_ovhd = 0;
+
+	if (info->input_len < CAAM_BLOB_OVERHEAD)
+		return -EINVAL;
 
 	if (info->key_mod_len > CAAM_BLOB_KEYMOD_LENGTH)
 		return -EINVAL;
 
 	op |= OP_TYPE_DECAP_PROTOCOL;
-	output_len = info->input_len - CAAM_BLOB_OVERHEAD;
+	info->output_len = info->input_len - CAAM_BLOB_OVERHEAD;
+
+	if (info->is_hw_bound == 1) {
+		op |= OP_PCL_BLOB_BLACK;
+		if (priv->hbk_flags & HWBK_FLAGS_CAAM_CCM_ALGO_MASK) {
+			op |= OP_PCL_BLOB_EKT;
+			hwbk_caam_ovhd = CCM_OVERHEAD;
+		}
+
+		if ((info->output_len + hwbk_caam_ovhd) > MAX_KEY_SIZE)
+			return -EINVAL;
+
+		set_hbk_info(info->hbk_info,
+			     priv->hbk_flags,
+			     info->output_len);
+
+		info->output_len += hwbk_caam_ovhd;
+	}
 
 	desc = kzalloc(CAAM_BLOB_DESC_BYTES_MAX, GFP_KERNEL | GFP_DMA);
 	if (!desc)
@@ -192,7 +280,7 @@ int caam_decap_blob(struct caam_blob_priv *priv,
 		goto out_free;
 	}
 
-	dma_out = dma_map_single(jrdev, info->output, output_len,
+	dma_out = dma_map_single(jrdev, info->output, info->output_len,
 				 DMA_FROM_DEVICE);
 	if (dma_mapping_error(jrdev, dma_out)) {
 		dev_err(jrdev, "unable to map output DMA buffer\n");
@@ -211,8 +299,8 @@ int caam_decap_blob(struct caam_blob_priv *priv,
 	init_job_desc(desc, 0);
 	append_key_as_imm(desc, info->key_mod, info->key_mod_len,
 			  info->key_mod_len, CLASS_2 | KEY_DEST_CLASS_REG);
-	append_seq_in_ptr_intlen(desc, dma_in, info->input_len, 0);
-	append_seq_out_ptr_intlen(desc, dma_out, output_len, 0);
+	append_seq_in_ptr(desc, dma_in, info->input_len, 0);
+	append_seq_out_ptr(desc, dma_out, info->output_len, 0);
 	append_operation(desc, op);
 
 	print_hex_dump_debug("data@"__stringify(__LINE__)": ",
@@ -231,13 +319,10 @@ int caam_decap_blob(struct caam_blob_priv *priv,
 		ret = testres.err;
 		print_hex_dump_debug("output@"__stringify(__LINE__)": ",
 				     DUMP_PREFIX_ADDRESS, 16, 1, info->output,
-				     output_len, false);
+				     info->output_len, false);
 	}
 
-	if (ret == 0)
-		info->output_len = output_len;
-
-	dma_unmap_single(jrdev, dma_out, output_len, DMA_FROM_DEVICE);
+	dma_unmap_single(jrdev, dma_out, info->output_len, DMA_FROM_DEVICE);
 out_unmap_in:
 	dma_unmap_single(jrdev, dma_in, info->input_len, DMA_TO_DEVICE);
 out_free:
@@ -251,6 +336,7 @@ struct caam_blob_priv *caam_blob_gen_init(void)
 {
 	struct caam_drv_private *ctrlpriv;
 	struct device *jrdev;
+	struct caam_blob_priv *blob_priv;
 
 	/*
 	 * caam_blob_gen_init() may expectedly fail with -ENODEV, e.g. when
@@ -271,7 +357,10 @@ struct caam_blob_priv *caam_blob_gen_init(void)
 		return ERR_PTR(-ENODEV);
 	}
 
-	return container_of(jrdev, struct caam_blob_priv, jrdev);
+	blob_priv = container_of(jrdev, struct caam_blob_priv, jrdev);
+	blob_priv->hbk_flags = HWBK_FLAGS_CAAM_CCM_ALGO_MASK;
+
+	return blob_priv;
 }
 EXPORT_SYMBOL(caam_blob_gen_init);
 
diff --git a/drivers/crypto/caam/desc.h b/drivers/crypto/caam/desc.h
index e13470901586..41b2d0226bdf 100644
--- a/drivers/crypto/caam/desc.h
+++ b/drivers/crypto/caam/desc.h
@@ -4,7 +4,7 @@
  * Definitions to support CAAM descriptor instruction generation
  *
  * Copyright 2008-2011 Freescale Semiconductor, Inc.
- * Copyright 2018 NXP
+ * Copyright 2018-2022 NXP
  */
 
 #ifndef DESC_H
@@ -403,6 +403,7 @@
 #define FIFOST_TYPE_PKHA_N	 (0x08 << FIFOST_TYPE_SHIFT)
 #define FIFOST_TYPE_PKHA_A	 (0x0c << FIFOST_TYPE_SHIFT)
 #define FIFOST_TYPE_PKHA_B	 (0x0d << FIFOST_TYPE_SHIFT)
+#define FIFOST_TYPE_KEY_CCM_JKEK (0x14 << FIFOST_TYPE_SHIFT)
 #define FIFOST_TYPE_AF_SBOX_JKEK (0x20 << FIFOST_TYPE_SHIFT)
 #define FIFOST_TYPE_AF_SBOX_TKEK (0x21 << FIFOST_TYPE_SHIFT)
 #define FIFOST_TYPE_PKHA_E_JKEK	 (0x22 << FIFOST_TYPE_SHIFT)
@@ -1001,6 +1002,11 @@
 #define OP_PCL_TLS12_AES_256_CBC_SHA384		 0xff63
 #define OP_PCL_TLS12_AES_256_CBC_SHA512		 0xff65
 
+/* Blob protocol protinfo bits */
+
+#define OP_PCL_BLOB_BLACK                        0x0004
+#define OP_PCL_BLOB_EKT                          0x0100
+
 /* For DTLS - OP_PCLID_DTLS */
 
 #define OP_PCL_DTLS_AES_128_CBC_SHA		 0x002f
diff --git a/include/soc/fsl/caam-blob.h b/include/soc/fsl/caam-blob.h
index de507e2a9555..8d9f6b209418 100644
--- a/include/soc/fsl/caam-blob.h
+++ b/include/soc/fsl/caam-blob.h
@@ -9,7 +9,19 @@
 
 #include <linux/types.h>
 #include <linux/errno.h>
+#include <linux/hw_bound_key.h>
 
+#define HWBK_FLAGS_CAAM_CCM_ALGO_MASK   0x01
+
+/*
+ * CCM-Black Key will always be at least 12 bytes longer,
+ * since the encapsulation uses a 6-byte nonce and adds
+ * a 6-byte ICV. But first, the key is padded as necessary so
+ * that CCM-Black Key is a multiple of 8 bytes long.
+ */
+#define NONCE_SIZE 6
+#define ICV_SIZE 6
+#define CCM_OVERHEAD (NONCE_SIZE + ICV_SIZE)
 #define CAAM_BLOB_KEYMOD_LENGTH		16
 #define CAAM_BLOB_OVERHEAD		(32 + 16)
 #define CAAM_BLOB_MAX_LEN		4096
@@ -35,6 +47,9 @@ struct caam_blob_info {
 
 	const void *key_mod;
 	size_t key_mod_len;
+
+	const char is_hw_bound;
+	struct hw_bound_key_info *hbk_info;
 };
 
 /**
diff --git a/security/keys/trusted-keys/trusted_caam.c b/security/keys/trusted-keys/trusted_caam.c
index e3415c520c0a..60e50bed7014 100644
--- a/security/keys/trusted-keys/trusted_caam.c
+++ b/security/keys/trusted-keys/trusted_caam.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2021 Pengutronix, Ahmad Fatoum <kernel@pengutronix.de>
+ * Copyright 2022 NXP, Pankaj Gupta <pankaj.gupta@nxp.com>
  */
 
 #include <keys/trusted_caam.h>
@@ -23,6 +24,7 @@ static int trusted_caam_seal(struct trusted_key_payload *p, char *datablob)
 		.input  = p->key,  .input_len   = p->key_len,
 		.output = p->blob, .output_len  = MAX_BLOB_SIZE,
 		.key_mod = KEYMOD, .key_mod_len = sizeof(KEYMOD) - 1,
+		.is_hw_bound = p->is_hw_bound, .hbk_info = &p->hbk_info,
 	};
 
 	ret = caam_encap_blob(blobifier, &info);
@@ -30,6 +32,10 @@ static int trusted_caam_seal(struct trusted_key_payload *p, char *datablob)
 		return ret;
 
 	p->blob_len = info.output_len;
+
+	if (p->is_hw_bound)
+		p->key_len = info.input_len;
+
 	return 0;
 }
 
@@ -40,6 +46,7 @@ static int trusted_caam_unseal(struct trusted_key_payload *p, char *datablob)
 		.input   = p->blob,  .input_len  = p->blob_len,
 		.output  = p->key,   .output_len = MAX_KEY_SIZE,
 		.key_mod = KEYMOD,  .key_mod_len = sizeof(KEYMOD) - 1,
+		.is_hw_bound = p->is_hw_bound, .hbk_info = &p->hbk_info,
 	};
 
 	ret = caam_decap_blob(blobifier, &info);
@@ -47,6 +54,7 @@ static int trusted_caam_unseal(struct trusted_key_payload *p, char *datablob)
 		return ret;
 
 	p->key_len = info.output_len;
+
 	return 0;
 }
 
-- 
2.17.1

