Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E9C5ADF28
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Sep 2022 07:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238416AbiIFFv5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Sep 2022 01:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238231AbiIFFv0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Sep 2022 01:51:26 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10074.outbound.protection.outlook.com [40.107.1.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566EC65804;
        Mon,  5 Sep 2022 22:51:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dONvjE+Dma1gGknamz0uBMm4A3nv5z4pgOoP7oBf+VdD45zIF6DKkwLV90lhp3rignLH8YHkk7Ov5RZrxhTA9egXpaIOazQJlBiDEeaoYfm1WIYyUpZmNjepjEuj3cFMpzCtvPQPD1Zxy8AlarUAovBwswMGJblt0fmSWwB2GBZi/NBFGpVaivHvGHfRtlabe0MrjdArN5TD5ywqjOjQ3fOBKrHU8Ypji8uASOgBdOY/vULojn5z1tHPa3IrEb/I6NYAf4bnpADgn3pcvVE0LZzK178sOOA9MS0u76oZUcBcujcotX+F7PpTJ3g6RH9k5gTgjjKNCHbGxXIm33c63Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcCLvgTpwkHq1/FO0qm84w6sR6hR0QNPu4jIAmnLxJw=;
 b=VCu6VlkmYv0M3cbLyyLv28EsikbhqaY2brLsvkdCdv5oI4KvqOsM9jvELqy3w68A5Zva2+raTCEq6y1XN13EygFRQi5nvgzwvq684dkXb5vR60AdVWFPnHIS0WNxYiN5UTW/ORw5RPJZPhyhCu9OD0FdkK3rA1EoqIj6xXnGbPSWdrDs0MVmZstZtyN4Db4Gsqr2bb+5MufL7IgfK7mzZb3DGXlfjYdrboGsdNn9jg/Kh5KmtUOS8eEF+6YXN3+ZNVGbxCFMVpMIrPCT9xcT1Xw38TBpShYMPiWjr0yxwr0HDK5b+Vqi+RE1KzyQCzHmBEaeomxJ3n7g8yp0zLmo7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcCLvgTpwkHq1/FO0qm84w6sR6hR0QNPu4jIAmnLxJw=;
 b=RMJt9oVVlmuOg9Wy+2vdVJDi/b0B4hfJLt7oN+Q18NXx2hBMHBUQsI8S9ehname5Y7PzlIGgfrnKWgnwMPRhatCIZH3wUmbc8LKL2d01MnfE+JrI2jqDiU1Hzj7LI8/zl1wNPwURjUMalko3C8sme7qtfKs/DyhT1S2BnP0gQ8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AM0PR04MB6657.eurprd04.prod.outlook.com (2603:10a6:208:17a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 05:50:59 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b%4]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 05:50:59 +0000
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
Subject: [RFC PATCH HBK: 6/8] KEYS: trusted: caam based black key
Date:   Tue,  6 Sep 2022 12:21:55 +0530
Message-Id: <20220906065157.10662-7-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220906065157.10662-1-pankaj.gupta@nxp.com>
References: <20220906065157.10662-1-pankaj.gupta@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10c417ca-1789-49a2-389d-08da8fcbc5f5
X-MS-TrafficTypeDiagnostic: AM0PR04MB6657:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nzIWm3n3dJsVK5bFZG3GYongLW/pl/2LK16wFtW1PRpviU/aLN0OcBY2xqOy2nWTiASQjBUMjlgG703wpWAdPrZsVZ0rf88plwb/F4m7Vf7lOxbBA+3ZVwh4ifd46najw08+60Irlo4IjKTaPfedm2JcD7nDgcVM7ZagEHpdb1vaFOnQmciWX4IQMl9BgAIxqwVGydYkxr2KziyrbR8lADFO7N49+sSXEuSQKR4kAcO2lD+l1+UythjgMWl9impHHGDnl1UcZLgI4nn8f2Ie07kE7LEGtX74EdBg9uOqBLopkPXjJM/DnNlnTY8qERHaxTBT9guqBSlPJqUi5ef1p4VO1BLygzzIvz0TPC0gS+bn7pChI2KShDd3BX59MJ6syHMEZSEOF/MS43zGfk5MmBB+VDSVYnxc/vsT4nUHJYdQqlwo6SnMvaZknbPV60VHUm5GetisQbSpQUX6+JusQXFaSdF+aE/jEtTqq/16T4ctF7IG9vQQZv6m5iLP9Lk+SzFmovaz4E21U6raxLWaCQCuv4WyRWGTiim7BCLWP4yjIXnXG737k2L9A+tuAME9Z/WYjo6lD8fgbFyCMevaxZnp/++rkyIlN7D4wRfOESot2/8v7ks47YtVfIk49UCiUhCXjWBK4an9Z/B2fQ3viQi6ykPv2D9l7C67kDNz7wVwDpB00Xio9+LtWJQKk1iR5wook5NQ/kETqK8iOeaUqodDymAt39xdNXTf6lwgsK/w1/KKRYADup3JYPqp0tgEGBvHdzYtUrlEZj+LFcO10w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(6486002)(6512007)(316002)(52116002)(6506007)(478600001)(6636002)(41300700001)(86362001)(26005)(6666004)(38350700002)(38100700002)(83380400001)(2616005)(186003)(921005)(1076003)(66556008)(66946007)(66476007)(36756003)(2906002)(8936002)(7416002)(8676002)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b8qH9imoEJPQfx6xxCspAZeap0FsOOgkQJ2QKmBJIwRhve3IMLMV/oahzlF7?=
 =?us-ascii?Q?hcnkSCamUextZhIi0hA411KbS7yd4nD7l3eKMxR1+2VwN/fE+jhPiI+f0s1P?=
 =?us-ascii?Q?EDb0DW6NelvMLEgkiEsFRW/wxVUuhEEnUD3SWXsEEIH5zLpWtONxQFEaogNW?=
 =?us-ascii?Q?Yzb6t6dAG5CXqEGghhlryfV9gpYuw7a23j50e2vms2nfEDMavOs+5vbPIIQ0?=
 =?us-ascii?Q?k5OjI3GHsWbNHf3r4zqrDh9UxPuAjMt012DT/CrhQVWq1ChKLuR3rllKWvLD?=
 =?us-ascii?Q?dVcO0TKIVepu1HcTiskYZIG2liqYkVY+EaVgWP9Cu5HQY5o8vU/ZmUgU5I35?=
 =?us-ascii?Q?IgYUKiEKdTVgMe5vkz+XrEmj42ZSe9TWpXb0/GfKVj74rFJLfr3/nIU1R4Pr?=
 =?us-ascii?Q?m9D2AbCMiwwJWF0Sq7STRaR9Y8b5ptukr1BMRpeUPWcZMzOevVGPhrAFp3OF?=
 =?us-ascii?Q?y+S2VdNRNDnKz930Pb7jFtxKAlXE5V4c+FGa1EXyLC4aiRCiSs31h7DoiBcI?=
 =?us-ascii?Q?4VEXdOgL/BLNCYA85OdiIkWTAwVspI61H3vq5QoUi7Ipk0N/4P/nca2LGkcN?=
 =?us-ascii?Q?NTG1tAghMa+1vgGsGYmWLUfoeI5EXQFkfy/BxUliORmNJ8twyV2s5XoKymAT?=
 =?us-ascii?Q?bmkwkiJoaYk/0aHe2kLIwFMtEVwkZDhx7i6vPEYDRgqiv1RoWovgknSa31j8?=
 =?us-ascii?Q?i1wYS8hfxRy4WtGly2OXF0bJEsH+I81m59bfM0RywS22E18AutewrXGfBH6v?=
 =?us-ascii?Q?2qKyGYLDXqO9pvNcLmbdSGdVkWexMEuCNo5xyTCgZyKR0nUb8XM4mdS6eKsM?=
 =?us-ascii?Q?TaqEERYsHPuIW1jwj3V6/s6ADpoDHFA4qmXV8pI2wBppXimaScwryWwIOcTG?=
 =?us-ascii?Q?yySG+tryIpCT1ShRm+OMNUQM0Nun5O6erJMOd36AW7GvEFOy4NNS1zVmgZn6?=
 =?us-ascii?Q?k5Tvf92t3P3u+c9Mw4efxYgTUrXoc9jT8h5njFic6SI00NS7Bax85mqGNLRS?=
 =?us-ascii?Q?nPFlLbmA6izFhwZ8b/A6fe/J2/j4SdkefbUUgmXA8bkdnLuj4g6qHrrriSM6?=
 =?us-ascii?Q?rgtBB8YP18IS7sEeXH6Q0wr3g8XL+cAVaxqZ4YiQ1i2e6y7XDGRS0vpn2eCP?=
 =?us-ascii?Q?k2N61PijrSv/fP3oVejipYg9BvHMJ9Vm2ohsN2rb1thcLRv9FpQQXFaxfmPX?=
 =?us-ascii?Q?kUmYcQeWaqiPCY5hid/2GcMHt0QS4pyauVK1zugfi6edTJWgLKe44RRVuSrs?=
 =?us-ascii?Q?RSF394GDxXEc44WORST7O5U58o3Z/24DSgU6qedt+kygoQfvn668BqT/YPT+?=
 =?us-ascii?Q?ATKdCdzvTvwUL/aCL7urWFQgIaASXkpeTaJvM7ebnzqOisCDH2XLJKCYlbl8?=
 =?us-ascii?Q?w5CNg/YDZdix5+gQYv9mq5Zd2TLYcOJuW3lSr0qnqaj/uPnjekGKluepoUqY?=
 =?us-ascii?Q?PIRcrvimEf2PEBznW3TrbcDlQuzWL0a+cPer1eFCR5yl5Rd5h+WJ9tFXIz37?=
 =?us-ascii?Q?HXnfakdT1boxADQ0a9IXg2hPQj93R7Zjmr8P1ZTyZ5BoFteXn027Jb/ppykK?=
 =?us-ascii?Q?NdFBIhau1Lg5CrXCV0VdruyJ+9Au/jcdm0c31QoG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c417ca-1789-49a2-389d-08da8fcbc5f5
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 05:50:59.0536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MP3LuObwiPCCQbZZWPhKheUT7VsMhqvyT3KAz99lnOwPjTvqJsdvTcQFxZswq+H/OH+6wcelJ3BS1ulVkifAPw==
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
 drivers/crypto/caam/blob_gen.c | 132 +++++++++++++++++++++++++++++----
 drivers/crypto/caam/desc.h     |   8 +-
 include/soc/fsl/caam-blob.h    |  16 ++++
 3 files changed, 140 insertions(+), 16 deletions(-)

diff --git a/drivers/crypto/caam/blob_gen.c b/drivers/crypto/caam/blob_gen.c
index 5164e62f9596..2354e3c6fc61 100644
--- a/drivers/crypto/caam/blob_gen.c
+++ b/drivers/crypto/caam/blob_gen.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt) "caam blob_gen: " fmt
 
 #include <linux/device.h>
+#include <keys/trusted-type.h>
 #include <soc/fsl/caam-blob.h>
 
 #include "compat.h"
@@ -74,8 +75,16 @@ int caam_encap_blob(struct caam_blob_priv *priv,
 	dma_addr_t dma_in, dma_out;
 	int op = OP_PCLID_BLOB;
 	size_t output_len;
+	dma_addr_t dma_blk;
+	u8 *input = info->input;
+	u8 *blk_out;
+	size_t input_len = info->input_len;
 	u32 *desc;
 	int ret;
+	int hwbk_caam_ovhd = 0;
+
+	if (info->output_len < info->input_len + CAAM_BLOB_OVERHEAD)
+		return -EINVAL;
 
 	if (info->key_mod_len > CAAM_BLOB_KEYMOD_LENGTH)
 		return -EINVAL;
@@ -83,11 +92,33 @@ int caam_encap_blob(struct caam_blob_priv *priv,
 	op |= OP_TYPE_ENCAP_PROTOCOL;
 	output_len = info->input_len + CAAM_BLOB_OVERHEAD;
 
+	if (info->is_hw_bound == 1) {
+		op |= OP_PCL_BLOB_BLACK;
+		if (priv->hbk_flags & HWBK_FLAGS_CAAM_CCM_ALGO_MASK) {
+			op |= OP_PCL_BLOB_EKT;
+			hwbk_caam_ovhd = CCM_OVERHEAD;
+		}
+
+		if ((input_len + hwbk_caam_ovhd) > MAX_KEY_SIZE)
+			return -EINVAL;
+
+		/* create copy of input buffer */
+		input = kzalloc(info->input_len, GFP_KERNEL | GFP_DMA);
+		if (!input)
+			return -ENOMEM;
+		memcpy(input, info->input, info->input_len);
+
+		/* create hw bound key on input buffer reference */
+		blk_out = info->input;
+
+		info->input_len = input_len + hwbk_caam_ovhd;
+	}
+
 	desc = kzalloc(CAAM_BLOB_DESC_BYTES_MAX, GFP_KERNEL | GFP_DMA);
 	if (!desc)
 		return -ENOMEM;
 
-	dma_in = dma_map_single(jrdev, info->input, info->input_len,
+	dma_in = dma_map_single(jrdev, input, input_len,
 				DMA_TO_DEVICE);
 	if (dma_mapping_error(jrdev, dma_in)) {
 		dev_err(jrdev, "unable to map input DMA buffer\n");
@@ -95,12 +126,26 @@ int caam_encap_blob(struct caam_blob_priv *priv,
 		goto out_free;
 	}
 
+	if (info->is_hw_bound == 1) {
+		dma_blk = dma_map_single(jrdev, blk_out,
+					 input_len + hwbk_caam_ovhd,
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
@@ -112,15 +157,40 @@ int caam_encap_blob(struct caam_blob_priv *priv,
 	 */
 
 	init_job_desc(desc, 0);
+
+	if (info->is_hw_bound == 1) {
+		/*!1. key command used to load class 1 key register
+		 *    from input plain key.
+		 */
+		append_key(desc, dma_in, input_len,
+						CLASS_1 | KEY_DEST_CLASS_REG);
+
+		/*!2. Fifostore to store black key from class 1 key register. */
+		append_fifo_store(desc, dma_blk, input_len,
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
+		append_seq_in_ptr_intlen(desc, dma_blk, input_len, 0);
+	} else {
+		append_seq_in_ptr_intlen(desc, dma_in, input_len, 0);
+	}
+
+	/*!5. SEQ OUT PTR Command. */
 	append_seq_out_ptr_intlen(desc, dma_out, output_len, 0);
+
+	/*!6. BlackBlob encapsulation PROTOCOL Command. */
 	append_operation(desc, op);
 
 	print_hex_dump_debug("data@"__stringify(__LINE__)": ",
-			     DUMP_PREFIX_ADDRESS, 16, 1, info->input,
-			     info->input_len, false);
+			     DUMP_PREFIX_ADDRESS, 16, 1, input,
+			     input_len + hwbk_caam_ovhd, false);
 	print_hex_dump_debug("jobdesc@"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 1, desc,
 			     desc_bytes(desc), false);
@@ -136,15 +206,19 @@ int caam_encap_blob(struct caam_blob_priv *priv,
 				     DUMP_PREFIX_ADDRESS, 16, 1, info->output,
 				     output_len, false);
 	}
-
-	if (ret == 0)
+	if (ret == 0) {
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
 	kfree(desc);
+	kfree(input);
 
 	return ret;
 }
@@ -168,13 +242,41 @@ int caam_decap_blob(struct caam_blob_priv *priv,
 	int op = OP_PCLID_BLOB;
 	size_t output_len;
 	u32 *desc;
+	u8 *output = info->output;
 	int ret;
+	int hwbk_caam_ovhd = 0;
+
+	if (info->input_len < CAAM_BLOB_OVERHEAD)
+		return -EINVAL;
 
 	if (info->key_mod_len > CAAM_BLOB_KEYMOD_LENGTH)
 		return -EINVAL;
 
 	op |= OP_TYPE_DECAP_PROTOCOL;
 	output_len = info->input_len - CAAM_BLOB_OVERHEAD;
+	info->output_len = output_len;
+
+	if (info->is_hw_bound == 1) {
+		op |= OP_PCL_BLOB_BLACK;
+		if (priv->hbk_flags & HWBK_FLAGS_CAAM_CCM_ALGO_MASK) {
+			op |= OP_PCL_BLOB_EKT;
+			hwbk_caam_ovhd = CCM_OVERHEAD;
+		}
+
+		if ((output_len + hwbk_caam_ovhd) > MAX_KEY_SIZE)
+			return -EINVAL;
+
+		/* In case of HW Bound Key, lengths have different purpose:
+		 * -       output_len = HW encrypted key length.
+		 * - info->output_len = Length of HW Bound Key Payload
+		 *                     (Payload = Header + outlen)
+		 */
+		info->output_len = output_len + hwbk_caam_ovhd;
+
+		output_len += hwbk_caam_ovhd;
+
+		output = info->output;
+	}
 
 	desc = kzalloc(CAAM_BLOB_DESC_BYTES_MAX, GFP_KERNEL | GFP_DMA);
 	if (!desc)
@@ -188,7 +290,7 @@ int caam_decap_blob(struct caam_blob_priv *priv,
 		goto out_free;
 	}
 
-	dma_out = dma_map_single(jrdev, info->output, output_len,
+	dma_out = dma_map_single(jrdev, output, output_len,
 				 DMA_FROM_DEVICE);
 	if (dma_mapping_error(jrdev, dma_out)) {
 		dev_err(jrdev, "unable to map output DMA buffer\n");
@@ -207,8 +309,8 @@ int caam_decap_blob(struct caam_blob_priv *priv,
 	init_job_desc(desc, 0);
 	append_key_as_imm(desc, info->key_mod, info->key_mod_len,
 			  info->key_mod_len, CLASS_2 | KEY_DEST_CLASS_REG);
-	append_seq_in_ptr_intlen(desc, dma_in, info->input_len, 0);
-	append_seq_out_ptr_intlen(desc, dma_out, output_len, 0);
+	append_seq_in_ptr(desc, dma_in, info->input_len, 0);
+	append_seq_out_ptr(desc, dma_out, output_len, 0);
 	append_operation(desc, op);
 
 	print_hex_dump_debug("data@"__stringify(__LINE__)": ",
@@ -226,13 +328,10 @@ int caam_decap_blob(struct caam_blob_priv *priv,
 		wait_for_completion(&testres.completion);
 		ret = testres.err;
 		print_hex_dump_debug("output@"__stringify(__LINE__)": ",
-				     DUMP_PREFIX_ADDRESS, 16, 1, info->output,
+				     DUMP_PREFIX_ADDRESS, 16, 1, output,
 				     output_len, false);
 	}
 
-	if (ret == 0)
-		info->output_len = output_len;
-
 	dma_unmap_single(jrdev, dma_out, output_len, DMA_FROM_DEVICE);
 out_unmap_in:
 	dma_unmap_single(jrdev, dma_in, info->input_len, DMA_TO_DEVICE);
@@ -267,6 +366,9 @@ struct caam_blob_priv *caam_blob_gen_init(void)
 		return ERR_PTR(-ENODEV);
 	}
 
+	ctrlpriv->blob_priv.hbk_flags = HWBK_FLAGS_CAAM_CCM_ALGO_MASK;
+	ctrlpriv->blob_priv.jrdev = jrdev;
+
 	return &ctrlpriv->blob_priv;
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
index 380b0bcb79dc..ae2c2a6c8c23 100644
--- a/include/soc/fsl/caam-blob.h
+++ b/include/soc/fsl/caam-blob.h
@@ -10,12 +10,26 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 
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
 
 struct caam_blob_priv {
 	struct device *jrdev;
+	/* Flags: whether generated trusted key, is ECB or CCM encrypted.*/
+	uint8_t hbk_flags;
+	uint8_t rsv[3];
 };
 
 
@@ -38,6 +52,8 @@ struct caam_blob_info {
 
 	const void *key_mod;
 	size_t key_mod_len;
+
+	const char is_hw_bound;
 };
 
 /**
-- 
2.17.1

