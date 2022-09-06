Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA475ADF2A
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Sep 2022 07:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbiIFFvT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Sep 2022 01:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237864AbiIFFux (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Sep 2022 01:50:53 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10062.outbound.protection.outlook.com [40.107.1.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CF95B063;
        Mon,  5 Sep 2022 22:50:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLYxT39r/2AbGQGsVUGRs1vPS3k9XJFW3jNomrfM2J/qJkYQOhQKBpW5QE9RPn+1M+dWZvML71xf6h4/n5Ab00+IrNDwMU5/JYBZwB4jBA4Nswo1HLizCWYb7E9M1uVd1LEP0x8U2zsoQee8BTcO1y938DQhgfGU/CnI3RBimRTOudE8pF20B+b6hB5shwez1d0C9v2K8ufCD6CHMzcqq/AR4TzmU0oOsSFRF5tVKLeowZkbRvmzOaPUCWHO1f6THLox5eNCiWc7/lKWe2ODtqkNRAmkxcuZ4LibT7Nv+tSJF/HoWCm8PZXia5HVAYOz3JOE6f3Imyl7snJJsb0qqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxIElYum3e9A7v8sdm6x798tL61g4LMWOYtHfaJWI4k=;
 b=b0rErnHZNt8EJC+U6oX7LolLtEmsOXLT09WDaLpsDq3teuqEWkxTOlb/XQNvyltIBZtkuIEkocFm0fjssF/yQAi5XD8S5Hfkex7yBa0i1u/oul7IUILs9vWsLA37vI1szT7VgFVaCNaz4Xn0e0+7ls+HeyeiDON1x86yaupIkLj7I0FyF9pdSGJtsCAG7T0K0Ec2MxFPRvqoLOczY4GIfVXlZIBnjEpHevLpkOaHhV0I0xR8R8S5YRY6VXJcH+J0c9pmTUoea7TJ6Xv7HGZIAhyL1fmewM8+1t3AIdj9gMbvA7Nl9YoXwSg9xsC+YsxEKMdak3AYztHFU7neFpf2oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxIElYum3e9A7v8sdm6x798tL61g4LMWOYtHfaJWI4k=;
 b=jI5tG+TTgho4TOzwS6sbHFkm0ivGvtxyWmIDeeeaf240tyKVK8hyuLVdrx6yaI21CqIdQAZqKbQ5RHa3gDuFOWUkVc9hvl2vK82Gg+qdJ6BW/17HIs03s+WipkDPoZasEa/UZCNICjpHU1tau9wrKffQqF0FU+9bKTKwdRZszlY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AM0PR04MB6657.eurprd04.prod.outlook.com (2603:10a6:208:17a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 05:50:44 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b%4]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 05:50:44 +0000
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
Subject: [RFC PATCH HBK: 4/8] keys-trusted: re-factored caam based trusted key
Date:   Tue,  6 Sep 2022 12:21:53 +0530
Message-Id: <20220906065157.10662-5-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220906065157.10662-1-pankaj.gupta@nxp.com>
References: <20220906065157.10662-1-pankaj.gupta@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c24dc6a6-cfaa-4908-b784-08da8fcbbd10
X-MS-TrafficTypeDiagnostic: AM0PR04MB6657:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TTkuGv0pgxFTFh3koR1XcOy4FhvQ63ZhNr2e1wNfBRfP/QXpOFGZG2BslfvZTOId4M0ZPbqlf5AKb08ZiI4mKbaFSTzZ2kAs+SbQCI7nbhR0RDxqN3YanhyT8/pSNdNJenE6iRklufTulLRHldTvJUDn2GKkFjkWGPoaZLkYVy14tsHAva4FOTYMMD1qMUF77Z559O5cPKJO6791WNdm9QdZFnxOm2B0b3mEbfjfALRnPCGExx7yb6HjtnVAa5lUqt5QfiaBvVSawWjdEgLmjLfKXUpLjkmreXXuuBnSkEW+SfkLAlpkecIezck3z1h5fsZ28X1bnrSMTGI1R7eFGTp23RUOU9/+hKR3LfLorgyXhwPt7ptPqB/yq6fHRHgiNN525M41rGOF0kMlg7b013T+lvjZ2BQQidsgbM8g2LdTP2FTYEmAcBprdLMzANjb13J3ba9XmW3FaNAsZ5WQs6qren+hpGKNuLG4PD0qxXvFEI3xVdw56Y/RGjywWQIlC+1V3NNSHn0Nc+lQbtSb1xKarLyyMLPNgHXnnvaQXdPQ3+hgYgV6U/C9JCddUySbsL22obHZ9KOar2j7nPQJiwVFbnIaynDOVvT9Twwc3DHWWJ/R7Rb72RhIgJA6t6ybirzYer2PkR21I6NBFCx1mh6V1I7G99LkHaeiZgseXsf0zf93K4/TjkSzYicy7g8c69lKcpTz+peYrRZ6fDCHgMulW7jxN7Zzc4ZGJQCVqS/xn9b39rltgY8/MIoB5t3/OGx2X9B0QiM8haD/jFpODUHlbc+4kpuHWlycr3kClXk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(6486002)(6512007)(316002)(52116002)(6506007)(478600001)(6636002)(41300700001)(86362001)(26005)(6666004)(38350700002)(38100700002)(83380400001)(2616005)(186003)(921005)(1076003)(66556008)(66946007)(66476007)(36756003)(2906002)(8936002)(7416002)(8676002)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K76pVVpKwI0kRLHWhp/PGlRaNLkwU1yE336o2qmbab6VZBdDvFNJOj+VJMCE?=
 =?us-ascii?Q?QG3IDJQ1YAnzUDM9/soP/MEFkWoBFHoDAdecb3T0jY9hfXbETG9RRy24Y6r9?=
 =?us-ascii?Q?8/1PLCSxcIONbMCiBLVvg0ug9Pq1HugGAUFIeiE0regr2g1fBAvWNUZQV8lj?=
 =?us-ascii?Q?x6EbCC0rh48UVqVLiawmC7S1WqMQhRfpcZ1NF2cbaWpc4YjAnvr92Fshq8r9?=
 =?us-ascii?Q?qjOy9lI9FduzzoQDmhC/jVjZAWTECUAFYQwTDLZoKN/jamHBsplx0wQBSuN1?=
 =?us-ascii?Q?omAqrVJ+Cpz7TiCZejQGW6k9AwGla5vbCSJWJ00wjV+HxL1cCPBJSgjiz9a/?=
 =?us-ascii?Q?HSdSy1bjHxWFu7mQMLi0TevwDVzNFtr+e8ZCiP+vcEGJGD5d7+t7jQTvYGfR?=
 =?us-ascii?Q?L9slD6L8W27+c+soovcHxKCWWZEKeb7K2ZY2+m8iLyo9JKngpfNslOM/SpSl?=
 =?us-ascii?Q?Pnlua5VuKA/kBFYTysuUbjHghd+GWIGzpKBSudpLCgSbinCZm9gwGzori1Ya?=
 =?us-ascii?Q?YTcl4DpHc7g/f8aO71X4q4TS45DIoj47Hd/10gxRBynjKIACbnPJVZPLjMA5?=
 =?us-ascii?Q?2fDUdI8eRE5TryJewPQ2V5zQSk6bQHaoJOZke2H5ZFfjrbD3FtuXrdIozzlc?=
 =?us-ascii?Q?zEb+KK9t8O25oOt2txyeXjQErDMOm+ue1lx+DOp7KanAQXsei4n5q0e8Fzew?=
 =?us-ascii?Q?Nu5+c9g8c54I0xUeBJCfeUD77nmk+I8MBzVy4wygJ3K3bTuSS1wHrZQXH14e?=
 =?us-ascii?Q?9D/KNlnGRJKG4MwPcTeT7kjnMASV3whk2b7MuQsgcB+k0pcjLnlpDQMVcOQQ?=
 =?us-ascii?Q?mnMnndeoms0joo5jiOBZGC/5VRO0v9ymA/YCe5I2KhC8j8mdMWODhU4zPEnj?=
 =?us-ascii?Q?KWHlpeAInBocCFNnTn0kDKIl/71LYg2Zi7OpDen0vumaRWxkcu6gZt2BMRVR?=
 =?us-ascii?Q?TZvXRrlSIALqFso8vaaYOH61KphpGvwnrq0H+Crw6uO/sWbJa6weLNIu4eOT?=
 =?us-ascii?Q?fLT6n0v/jZk978G90WUQSht/1B1HbhlFOMQOveNh5ygLJ7MNdhi9vptQvn9h?=
 =?us-ascii?Q?UN2DIvIMRMf0z0iBP8qweaIaX9+guT9vZUx1CV1VDz6Zes3uAkF+vYLlu7JZ?=
 =?us-ascii?Q?tzVdk9vdeCYItHqpTuv4VLZiWkuq+swUEg2Bk/EQkDWlP1Zs19gOaszZVPQk?=
 =?us-ascii?Q?4QRmdgiqFZ64syJIzcWyjkvRkMlWhOe8d6+PawZiHb0PaxMo9KWuisTF+cUA?=
 =?us-ascii?Q?CcaGrPnzVpIIZeIibzOlIQXhsPKMGR2IRy+aSDd4jbFkj6aMaGfgP8FVFCK8?=
 =?us-ascii?Q?YH31eQEov2Grqw8M3RSRHh9B9T40lS/VErkyxisfgnec7QDTDnfI4vVMHhf7?=
 =?us-ascii?Q?LQdjqkYgODALmkprHi+s0PcgNB0UcKs3/SssU3HdPSamBRLENfr+FfwahjEh?=
 =?us-ascii?Q?VgTtVwgLyHUyLZAnrNVXeF77Zw6AAzUvnPS2pCxLpwhoCKj0cbhKm7jJG+t7?=
 =?us-ascii?Q?McK5czpfJmp4FY4XbDdZ/9MFC3cPtgl0tA1jGgr5Keh5bwwEXGyxT4RwBgFy?=
 =?us-ascii?Q?/PHejfpva0qJPSQfyFQJXpaIKWy9PikS99ZwJP9w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24dc6a6-cfaa-4908-b784-08da8fcbbd10
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 05:50:44.1656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bru+JnjxlWoBUUht9058sIjVm7ylKzNHSKW9t5x4yQN7Wtg0/RhPO6gRhcOEe9NC0zjBdUQlmrpMMn1wTmuoYg==
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

Re-factored caam based trusted key code:
- Two separate definition for encap and decap having
  separate code for creating CAAM job descriptor.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/crypto/caam/blob_gen.c | 122 +++++++++++++++++++++++++++++----
 include/soc/fsl/caam-blob.h    |  28 +++-----
 2 files changed, 118 insertions(+), 32 deletions(-)

diff --git a/drivers/crypto/caam/blob_gen.c b/drivers/crypto/caam/blob_gen.c
index 6345c7269eb0..c128a83cc8dd 100644
--- a/drivers/crypto/caam/blob_gen.c
+++ b/drivers/crypto/caam/blob_gen.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2015 Pengutronix, Steffen Trumtrar <kernel@pengutronix.de>
  * Copyright (C) 2021 Pengutronix, Ahmad Fatoum <kernel@pengutronix.de>
+ * Copyright 2022 NXP, Pankaj Gupta <pankaj.gupta@nxp.com>
  */
 
 #define pr_fmt(fmt) "caam blob_gen: " fmt
@@ -29,10 +30,6 @@
 	/* Command describing the operation to perform */		\
 	 CAAM_CMD_SZ)
 
-struct caam_blob_priv {
-	struct device jrdev;
-};
-
 struct caam_blob_job_result {
 	int err;
 	struct completion completion;
@@ -58,8 +55,19 @@ static void caam_blob_job_done(struct device *dev, u32 *desc, u32 err, void *con
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
@@ -72,14 +80,102 @@ int caam_process_blob(struct caam_blob_priv *priv,
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
@@ -145,7 +241,7 @@ int caam_process_blob(struct caam_blob_priv *priv,
 
 	return ret;
 }
-EXPORT_SYMBOL(caam_process_blob);
+EXPORT_SYMBOL(caam_decap_blob);
 
 struct caam_blob_priv *caam_blob_gen_init(void)
 {
diff --git a/include/soc/fsl/caam-blob.h b/include/soc/fsl/caam-blob.h
index 937cac52f36d..632944df29f7 100644
--- a/include/soc/fsl/caam-blob.h
+++ b/include/soc/fsl/caam-blob.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (C) 2020 Pengutronix, Ahmad Fatoum <kernel@pengutronix.de>
+ * Copyright 2022 NXP, Pankaj Gupta <pankaj.gupta@nxp.com>
  */
 
 #ifndef __CAAM_BLOB_GEN
@@ -13,7 +14,10 @@
 #define CAAM_BLOB_OVERHEAD		(32 + 16)
 #define CAAM_BLOB_MAX_LEN		4096
 
-struct caam_blob_priv;
+struct caam_blob_priv {
+	struct device jrdev;
+};
+
 
 /**
  * struct caam_blob_info - information for CAAM blobbing
@@ -72,15 +76,8 @@ int caam_process_blob(struct caam_blob_priv *priv,
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
@@ -90,14 +87,7 @@ static inline int caam_encap_blob(struct caam_blob_priv *priv,
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

