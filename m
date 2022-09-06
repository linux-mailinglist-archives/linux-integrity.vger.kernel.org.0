Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38995ADF29
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Sep 2022 07:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238278AbiIFFvh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Sep 2022 01:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238007AbiIFFvG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Sep 2022 01:51:06 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A19858DE4;
        Mon,  5 Sep 2022 22:50:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKpEdmX1ikIGjcfTQ8L7qx/7dyG2cF5D4Jardmq1qI+9IwBPTpThfX1sBlpMpndEEeqTA/ciQLScTdkFJ5lw2K9U0lS8l686sddzhCiGXO8W0bnPVrmT+8RPpGxdAOllxcLmkfzqPjxTSXcWKELLbOjsGgd0rNZFNdJiuPxSOSNJBK97UoKz9I0vVaCgvdij2oPExEInLlJ9108qOXJSqtD+SoAQfsCOuvjYE9VIjvCkmdJKp+vdDtDHb3sfO+XvrXoa3tCbbbgEPyvZDvkrAk6UY/jO8w07RCk4iJayB4DT4LLZguH/zifFxQNGkIZMYW2jFH2mSDmrz+cyANtZcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouXMirUJooxVjewuyl91g8VCVuTnSKkxZ1LRI17MI+8=;
 b=OwUqxS5HjFUR83aiuUV+wC72vO7d58rf8IoB7pJeEZ0mYmNZQVax4GGzFm6VAKv6lkxqWNgi1F0MkVIgt5fd8JEtvbUo6XwiSYBEC1tbTEydKJ3TiqwYyNYI75gx+gncVWqvoyGwSzCYwQ28y8WcqJCCcfejc/9MPq090YhP+bWZ4A7zQ5cxHLXiU423hg9qy/CkOryU6s2zEiKivuLBlzRnTFQf8AUlLzqlOUA7ACUjTbifpCH48qnCO9gt8y1a7/zmvBn1ZxZRZ6Nv+kl2aoknIxy3uB98yceeQENNeKpUOLmlxZ19sd9WSoXR+SY0qkJ3JU7/SaXn0zoCfy2vbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouXMirUJooxVjewuyl91g8VCVuTnSKkxZ1LRI17MI+8=;
 b=ZFg0BVKTgT8SnpoOzNn9ha8V5b/2wDms6+u60ulRrWw+O9ihAZU/nuU/wVXGwTEgL/w+gDBlj3Zo7I+ah4QA4xVtYDFBDNrAzeSz43Kotl2oulIb2vRy8A8uxnkBdKUdizNCNupwKjzgRn8gW9ZAVoEaHePqX5pzAtA6zAYtgpQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by VI1PR0402MB3550.eurprd04.prod.outlook.com (2603:10a6:803:3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 6 Sep
 2022 05:50:51 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b%4]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 05:50:51 +0000
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
Subject: [RFC PATCH HBK: 5/8] caam blob-gen: moving blob_priv to caam_drv_private
Date:   Tue,  6 Sep 2022 12:21:54 +0530
Message-Id: <20220906065157.10662-6-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220906065157.10662-1-pankaj.gupta@nxp.com>
References: <20220906065157.10662-1-pankaj.gupta@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d297bc8-b626-4f71-b645-08da8fcbc18f
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3550:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +lO3bD7ludBiVwVSiatBY3/v5Xadd5yZaAXPhYAAnhXIc2XNvM4zSIF6tRFSCrBad90zx+RmPdKBmn3JHRC1cmNWdSnYMruSR6tEfttvAleKY3ePQne4PK7jKlB0pLC6hScSomnJwR8fT2hXtU4WMk6rLzy6mSA/A30+q1eSRSHCLuSgMDYDzYYhWaVBRwqHBwf35tjuebWBke8ThV213rMkBjd01zaQyd6oVfbJ9IUDsaIQf9ZKx2iEfZtSU1v/9GxjpYHWEqixLz4RpVFqQP8Y12fIcrDrHXFAIYZsMXcq9Paf+SBCRS69mdUvvO5s8o73avfAexkShLjtx2Q8/RrUUH7YpHK8d6JvRpmoY5sCSfSqmhMZ6epD/qqVjfeKRGKQpY7yoQ4Leldp+C1CtnTt1Oy6nxBRXdUXpAO6G+nSFDyk7hMbutungz9yr3DueTvG3jugrYYTNixgd/wbU55zwG9B3ctIOU5nRCTmzUtnRdFLXNZKClP3rvsdm7Z6hBWbkqfed5+0LYeHyJg1tUcxqkDS66cXK3LYqu7dFgYnPxWqQCcwQN320hJNuQQhJHQ2EwJ/81aOG9G2h3dzSyIJuAlb/1naIrbXIBnFZ5uuqBq/aoqcPUcuk9SkbdSFmRVXAj7nl5m+J0ZH+2OtUSuJAuL4lqWfrMcZWq3CPUbKbYoY3oAwlHqfV3ibkLqbXQDbGmUHalRu9HxbiLDjThOAYVvBdN/Xzk8VpDy2Ts3u1+Mr18cqOO/x/D1Bt/pTjMqcxI4hOQpkL/mnufDuKfvZGVDliLRNzzVtqgnjrpk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(6512007)(86362001)(26005)(921005)(41300700001)(478600001)(52116002)(38100700002)(6506007)(6486002)(2616005)(38350700002)(83380400001)(66556008)(1076003)(186003)(44832011)(316002)(2906002)(8676002)(6636002)(66946007)(66476007)(36756003)(7416002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AD0HCwR41W7sRP05U0VUekO4HTzI2U0PvYzvG2Q+mxFSzHDsloqJ84zViBPF?=
 =?us-ascii?Q?5aJRkixEwbSPA6WqpZLm7nIIoThiToTHcx5gS5HR9qGmswCLnFXKKcMd5TNb?=
 =?us-ascii?Q?sGBPo4tS4rMQXxi/VaoyKvxlXyz0Sn3JWzSdHtX15biAagRG26iQ1VfolmAk?=
 =?us-ascii?Q?hkX7X75baF5sevzgvpEhacrd/VS7dGmh2fXSj2pgNXK4ku0DrEI3uVi5RT3U?=
 =?us-ascii?Q?9eMI6BuzTaO8QyelotLsGm29U8zJn9iLmOQTBRBWPnqdjKW94Ioo9beSJopK?=
 =?us-ascii?Q?EphPf8VpXANQs79Id2h+Qjf/XFJlx2x5qtMSLq0mk+DnGlMi8GT+oKcdH/Na?=
 =?us-ascii?Q?zyOL9JsEnZ6uRe462NukthGHTTSq4pS74W4SEW/J/faNwDSW7rVzpjBGEYgY?=
 =?us-ascii?Q?P+7pMt9sHVH/oVbaF3RlOZXNBVc4+DQnvkYRZqHCypfiv+75yDm8wP2S4pZl?=
 =?us-ascii?Q?oLdpOAydlkn6o8uO91wRzxqrg+tJ94QHM5kgk8dvWrPiE+o80brIT+AJ94Yj?=
 =?us-ascii?Q?vtAh1o5sBS3fQ1pYXQtpOeMNPQomDZUy3J6QLkz2eB40PivmXNA0/TPUY439?=
 =?us-ascii?Q?vqXF4iv0+cj/O8k1E8ii3a6vNy9oU/517eh4x2ZrzgNhF9cbG3XbckHBhKaH?=
 =?us-ascii?Q?NjKzw/S/cFjNq8BZWsbKbikAmiv0LWcJOLO6/GybHjsRDqq2lltVIFvXuliu?=
 =?us-ascii?Q?A+X9QcDuuxRJTVcZQHs2xSRYMKr03DEzgjdL8Sri+KKn9FVbj+VlxIOOB7ai?=
 =?us-ascii?Q?/8mscW3luXFrg1Ljr/VVNYxXIuXwNBgIOQZrzyn3a9eMgambbnb0Ft60pEd7?=
 =?us-ascii?Q?QQQel5ZvqS6ws6WWNCLSNpNvAZfohahkxiY/Dc/b6zHNeLrIDdPtLLq/3KYt?=
 =?us-ascii?Q?WLh6g+hcEqMLAibd13YwYXtHBb6AzkytIVYhNFdPqWWI2htHUvk+Gv4MiNW2?=
 =?us-ascii?Q?VTmi4X0n765kiI6XnYSNumAiEbNRyRcYJahMIIBxZVrfa83oskzWSh1auuf7?=
 =?us-ascii?Q?OeOc4bUeYjyVX/SjN9MDdWPc7aGlUPKFO2Sfspw3kHBY4lPLwjIiFnXxf7ZT?=
 =?us-ascii?Q?xuR7oR6tcFPulWFBEoYbz/PO07BPHDFtHwKz8gKUooA05PE8RtexZwct0EcA?=
 =?us-ascii?Q?ffLIODPhbN7ynNpsBn69Vk2+KF1sF4XkzNi4j9ccsEOc6Ijtu0ic6PMp0qOu?=
 =?us-ascii?Q?x0UFeu1f1uoSlAeDDKPxD5qanwjGsxbDNJuS731bywmCgxqxHB1TCsCVzWLz?=
 =?us-ascii?Q?KFehLrpRLP1otHfi7qMSwaudCLnxXhzsTIWHtXIJaIueuKX5eWHGQ8uILpa5?=
 =?us-ascii?Q?AhPENISBxKvW8tzC3Sxo05lTrLyUzrT+f4/5gYmNpVsDaWW+XOvtKBMF9AEe?=
 =?us-ascii?Q?GroB/iNkdmkSDOYPh3AQ2V/LknbEcXMHU5NA7zOOxZUOtXdsEDi0Zviyg2tT?=
 =?us-ascii?Q?eZPu1K+7Od5nKCKFH2N3REioQuGtCw/Ni8eKgBfx7FtGDdnglci51097zK7U?=
 =?us-ascii?Q?ox7jp023FP41Ix/FKubIFZWT6gQlROAh9m+wxp1hLX58kuYiG/Vm7fWNVy/R?=
 =?us-ascii?Q?ToBF3BK+pI1Y5/8abUfrhGQxDE5MA0rqaIXHjBDy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d297bc8-b626-4f71-b645-08da8fcbc18f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 05:50:51.6931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jogXo8tS3oaREWyBw07xuGksEAvXiM48cHMCsy2v9PzcIdYhhTfc+XNyhJh/yVPXHGaRFHsFNilvZduResP5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3550
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

caam blob-gen: moving structure blob_priv to structure caam_drv_private.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/crypto/caam/blob_gen.c | 8 ++++----
 drivers/crypto/caam/intern.h   | 6 +++++-
 include/soc/fsl/caam-blob.h    | 2 +-
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/caam/blob_gen.c b/drivers/crypto/caam/blob_gen.c
index c128a83cc8dd..5164e62f9596 100644
--- a/drivers/crypto/caam/blob_gen.c
+++ b/drivers/crypto/caam/blob_gen.c
@@ -70,7 +70,7 @@ int caam_encap_blob(struct caam_blob_priv *priv,
 		    struct caam_blob_info *info)
 {
 	struct caam_blob_job_result testres;
-	struct device *jrdev = &priv->jrdev;
+	struct device *jrdev = priv->jrdev;
 	dma_addr_t dma_in, dma_out;
 	int op = OP_PCLID_BLOB;
 	size_t output_len;
@@ -163,7 +163,7 @@ int caam_decap_blob(struct caam_blob_priv *priv,
 		    struct caam_blob_info *info)
 {
 	struct caam_blob_job_result testres;
-	struct device *jrdev = &priv->jrdev;
+	struct device *jrdev = priv->jrdev;
 	dma_addr_t dma_in, dma_out;
 	int op = OP_PCLID_BLOB;
 	size_t output_len;
@@ -267,12 +267,12 @@ struct caam_blob_priv *caam_blob_gen_init(void)
 		return ERR_PTR(-ENODEV);
 	}
 
-	return container_of(jrdev, struct caam_blob_priv, jrdev);
+	return &ctrlpriv->blob_priv;
 }
 EXPORT_SYMBOL(caam_blob_gen_init);
 
 void caam_blob_gen_exit(struct caam_blob_priv *priv)
 {
-	caam_jr_free(&priv->jrdev);
+	caam_jr_free(priv->jrdev);
 }
 EXPORT_SYMBOL(caam_blob_gen_exit);
diff --git a/drivers/crypto/caam/intern.h b/drivers/crypto/caam/intern.h
index 572cf66c887a..2fb7df3ffda5 100644
--- a/drivers/crypto/caam/intern.h
+++ b/drivers/crypto/caam/intern.h
@@ -4,7 +4,7 @@
  * Private/internal definitions between modules
  *
  * Copyright 2008-2011 Freescale Semiconductor, Inc.
- * Copyright 2019 NXP
+ * Copyright 2019-2022 NXP
  */
 
 #ifndef INTERN_H
@@ -12,6 +12,7 @@
 
 #include "ctrl.h"
 #include <crypto/engine.h>
+#include <soc/fsl/caam-blob.h>
 
 /* Currently comes from Kconfig param as a ^2 (driver-required) */
 #define JOBR_DEPTH (1 << CONFIG_CRYPTO_DEV_FSL_CAAM_RINGSIZE)
@@ -114,6 +115,9 @@ struct caam_drv_private {
 	struct dentry *ctl; /* controller dir */
 	struct debugfs_blob_wrapper ctl_kek_wrap, ctl_tkek_wrap, ctl_tdsk_wrap;
 #endif
+#ifdef CONFIG_CRYPTO_DEV_FSL_CAAM_BLOB_GEN
+	struct caam_blob_priv blob_priv;
+#endif
 };
 
 #ifdef CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API
diff --git a/include/soc/fsl/caam-blob.h b/include/soc/fsl/caam-blob.h
index 632944df29f7..380b0bcb79dc 100644
--- a/include/soc/fsl/caam-blob.h
+++ b/include/soc/fsl/caam-blob.h
@@ -15,7 +15,7 @@
 #define CAAM_BLOB_MAX_LEN		4096
 
 struct caam_blob_priv {
-	struct device jrdev;
+	struct device *jrdev;
 };
 
 
-- 
2.17.1

