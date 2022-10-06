Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2F05F6594
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Oct 2022 14:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiJFMDZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Oct 2022 08:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiJFMDO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Oct 2022 08:03:14 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80071.outbound.protection.outlook.com [40.107.8.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337949DFB9;
        Thu,  6 Oct 2022 05:03:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOgd4maMTke7LcGtf5zC0UO+59Ph/xQJvRS++IeZuoFqr6XnNgcC6Z8DUvAHMHcqW7Z15Z3vNITW1oZwx6gVNqkl+z4gvAOi/QCqFBszCOToiZpUZsiSv8yAuDu66wH5fnwvmFRDryd/H6X1g2/cgHkjnjRBLgiivJ/w534C6Xsxew9gm5PffaFd6zpXgSh47pOTVGM8IEVYAo0VA5uYUhe+w3auE3fzx/ZMypEieTa1/K/w/tB753twq/9Bpn9dqMIkdRSV2IAvjXQeXHezzkC9lZE+Pe9J8ofEB+qYZNL6e95I2XYnPfC+p20HxiVl9bkYs0lV0qMnkn1lE9fgRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BR0jgTDctb8AveoCnh5toL0VHmlthJ0oAPEakOL+or4=;
 b=n+nIA0tS/SHxeqLcsPgV2Y6UIAty3afPg+DCIhKpr/pL9cU9Pn8VXwkP0nfuz6jJsh61mzY2SJ/gU91okU2MLc/B+flI5NSzKZgatRTlskvchhJsnMwJI/OnptfSLGePp2n2NuMD2FwsE2RqRKEV89YsmgeCirHuUX+agZ6QCZ6ybkNL9cQlZkzYuMUB0Qrsjd1X6P1aVUokjDVi+OVhjdi+lrt/04rWbeD3kq953OuR/cH7kRpW0NmVk5VQJBVB77tRU6Upef3m3BpZT/kN7hfHQdbsmM7xTL+ZMLK5iL8bDymBT5PgAtU5cXKTjyBluOBJwRjQiR26C+goHdODnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BR0jgTDctb8AveoCnh5toL0VHmlthJ0oAPEakOL+or4=;
 b=rjAlJ9PPT5NCy4+PrF6YeTSYyzheDgwGn/QGPVNg/do/6WGYxpk3vxCHjyqhKC5N3unBqiQNPO1ou1HdEZnOCbtIH4w2J4rI/ROh+HqQbUUGfrixm8YVEYBSMFKBOiNlOZ+SN75WzhbNRPZX74Kl1hhkOSWN3N1SEAW5pJTEU70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AM9PR04MB8523.eurprd04.prod.outlook.com (2603:10a6:20b:432::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 12:03:08 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::d551:6af4:bca4:88ea]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::d551:6af4:bca4:88ea%7]) with mapi id 15.20.5676.032; Thu, 6 Oct 2022
 12:03:08 +0000
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
Subject: [PATCH v0 3/8] crypto: hbk flags & info added to the tfm
Date:   Thu,  6 Oct 2022 18:38:32 +0530
Message-Id: <20221006130837.17587-4-pankaj.gupta@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4d90a3e3-1ce6-4acc-07db-08daa792bbdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rj6+BbjLUsqpxESgLHG3Ri1CuGmw8+YM9fllT8vhIoOY+MDDAWJ3J3tiW6QFkA40PvpGVEWOs397hDKpnwZoGqbTm619ZQUozIl54ss/NrkFwbOPnV/LTJllNssbpr6dyc01vkOIeVu5qel8Brvz14oYzpbZ5fvbczQGFjeRbnGn7gzYO4SZ4p1ABgfXVnMCPbgfU3u5/oqDupa+GpOIuq7CsvCdLNFPYGy44Iu63VIQTYKK6rq9/xPfntCB/8rRRVXzqdRFITXVRYQM7VryiY57bJmTqD8O+JTb8YnZ6eZXNMLcMKdnlpeiPSb7AqPnsmHBJQofE4DwtlWKg5QmPg+CwFueXC77YN8vJfu+U2o0x8ig8Q3LyIoa8fpUoyKPENcI3GTzsYFzrVy4NA/uQ0nWaJlrN5PJWF5h/gBVxnTIwh1P/1CcHBQcVQkzdiRyzQ1cqToA3i8kbOdIt8U1Ss8FvwuVjwj1vCab/Ikqc+Fq1/ccyjs0i7m+HDdT5X8Gyy2LXdV38pCZi9FSPes7XPg8WVea/0lp+1057iKt7kkkikp/jcLdR/jyoJJ3riSIfYQS0u/ndCHRA0IXUcCrDjcStnEGBTL79HdxExPCcmDo+5fCACqwVr2z/EMLiJNO5iljI9KMW852fHkWTDtqfIBvjd+ik9zs3v9IRTlYs6s9n6A9wHddAglBagll4Pgq5JUeuK4TVDjh8wg3A5LwZOGXxiKatfPWUFj99tHlwLI2bBDdmOdpt9oBRTI1sH3vapj8+g77OYIHtQTn4XJsQR6HhRuxdzQcgaVHh/vVqG3p7EC0IrU7VlZAjTs4vXEX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199015)(66946007)(66556008)(4326008)(66476007)(8676002)(38350700002)(38100700002)(478600001)(1076003)(36756003)(41300700001)(2616005)(186003)(6486002)(316002)(6636002)(52116002)(6506007)(6512007)(86362001)(921005)(6666004)(26005)(2906002)(44832011)(5660300002)(7416002)(8936002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?otSzbL+wPMErzb1HCkqwj+dSfue9GPHjoAAlQi88QS058Y/CnOff0HJSPrIe?=
 =?us-ascii?Q?vGKzXcVqxHff77tuWTUA0WSJs40h8n92KLTIXuOlXqipnFCSv7A21oHHiaol?=
 =?us-ascii?Q?nuB4O+flfS1j5Re/OW0VS9My5ZgfA6lNI6qDBz0fVT3hGPuL4Q+P7Q8Zeuqy?=
 =?us-ascii?Q?1gaztYTSm4J3eOrymHVyU5GfC825VSLfKE0vFIU/0OCIKDD+r+fLjWE7e0mm?=
 =?us-ascii?Q?fPEK/2SZVF1Iy3hBy/Ek8pEYu7MsT6glcYzvsdAPgWqckI4vs8Al6xLNKprv?=
 =?us-ascii?Q?0a8ysccT8/iJ7ZuicLOM/pVHbPoV1B2He+HPFnsF3rySwoVmEr1FlC5PqucR?=
 =?us-ascii?Q?/XgSEyfSuffXsl0YXP3ojLqu1bCMtHFNl3OQQEF6+BlqcRWorTd7CVgXV9Ja?=
 =?us-ascii?Q?hxuMXXPu+rcCdQHK6FZVivJKUlWnZoG9CaDYTidFAIS09YJu3alBF3uo3gGT?=
 =?us-ascii?Q?KVHT/mbDtD/5hvuV8rt9WmYqQCN6dVLl0oLNM4aXwHO1GRczaJuV72ItGvgP?=
 =?us-ascii?Q?vhPPxal1RSiSvMfnjI6Br+8tUoYTRJhzgVe6f6SgxoX8o3J6at32mbYjkWqF?=
 =?us-ascii?Q?9G7JuIDSZIPCVxVixUhX5BSkQP4zY2d3eJJQDiltwAw30CYWgAT8TexEwGPe?=
 =?us-ascii?Q?7PpJmbLqexUMRah51QBDNtWgA9zsvjWO3JBppnSuh7RpwWjDEdr1iomgZIov?=
 =?us-ascii?Q?tydzu4gGuG4caL7Kzj9ZDnV0baEP3RBLr5u94QZqniyp3GSMkZ7xaL8byxtX?=
 =?us-ascii?Q?NmiF34+K6gjtmHmQJL33gb8zTyoFSno9leMwQGwXtZSxwfFPiwpqqYuEVblB?=
 =?us-ascii?Q?ElTCg2grFZKAMMl1v28hTqXXIbGAA0T/GYjmj+BRpcbHC734pX5vPjYlML+q?=
 =?us-ascii?Q?um7UVxwKe/6FLXYxGOlt6J2OOgTxhY2pRVVB+ELLXssN254RstRQPb5N2hvB?=
 =?us-ascii?Q?ZxBHzqxyXio/3+66Heru5gm5Xe4/lzGZHv4WLai0ci8KpqrWVoWkFI0iwbnS?=
 =?us-ascii?Q?9iQsjudn7b41Z9yBZSl7hCMMsiZZ/tbUhLM6CiamW/g1LvoO8f4UTLPIHVvA?=
 =?us-ascii?Q?Ui7CF3UUjeluSeRzk/zBkhOB4VcesX5jCgRcjEBHOYj3+hwv6DANXm4rXbLn?=
 =?us-ascii?Q?9EKF3AaggH5s2GIH12rAbIwK546ZDmtuG9Ge1kC5i1R/hk1C8+MdWPNgeo0f?=
 =?us-ascii?Q?NlwdgL7+sDpJy8QZ1RtvuIXahQEP8UvnNBpQo/RM7D9Ms23LocLpbhWMIk3Y?=
 =?us-ascii?Q?kwxi3Q9DxCKHXxdc5d4YHEVe1ozsf4E+ubH9cYZDhA1XpMwU4bbDhEL+bJim?=
 =?us-ascii?Q?J3xQClASZYNhTNEXRZlAc5H1YfW9Tr2am9Ar++ZkQ9M88cbc2xZ540qr20Q9?=
 =?us-ascii?Q?rlYMVlZKBPZ8QetC6eLOwv7bYofsZiZXFmiLraMAmREChMJeJzUeCe7xlizG?=
 =?us-ascii?Q?w8FQZunFpk2bD2wE/RT+4sRLTxRlVd8Y8fD+yCpkEbKj/pi898NZYmo09h4C?=
 =?us-ascii?Q?W1SaPPX52ZMFoJnQg6EVXAkLf++NNcBqqYumAjrrtJoByYRTDgAkAjRutOlx?=
 =?us-ascii?Q?42eiPBojpwPgI5q96Wtgcl57aSOlxQWA63jzFIkY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d90a3e3-1ce6-4acc-07db-08daa792bbdc
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 12:03:08.8918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scdvJctj0bTe5Yi+XgKVaIt1z+fri4OQPjA0n52owvbIJCxck/P2S8O8p1pJgzubRGSweqbnfKwaqmy3WBlHQA==
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

Consumer of the kernel crypto api, after allocating
the transformation (tfm), sets the:
- flag 'is_hbk'
- structure 'struct hw_bound_key_info hbk_info'
based on the type of key, the consumer is using.

This helps:

- This helps to influence the core processing logic
  for the encapsulated algorithm.
- This flag is set by the consumer after allocating
  the tfm and before calling the function crypto_xxx_setkey().

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 include/linux/crypto.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 2324ab6f1846..cd476f8a1cb4 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -19,6 +19,7 @@
 #include <linux/refcount.h>
 #include <linux/slab.h>
 #include <linux/completion.h>
+#include <linux/hw_bound_key.h>
 
 /*
  * Autoloaded crypto modules should only use a prefixed name to avoid allowing
@@ -639,6 +640,10 @@ struct crypto_tfm {
 
 	u32 crt_flags;
 
+	unsigned int is_hbk;
+
+	struct hw_bound_key_info hbk_info;
+
 	int node;
 	
 	void (*exit)(struct crypto_tfm *tfm);
-- 
2.17.1

