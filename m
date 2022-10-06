Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6327C5F658E
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Oct 2022 14:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiJFMDW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Oct 2022 08:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiJFMDI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Oct 2022 08:03:08 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60059.outbound.protection.outlook.com [40.107.6.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F099E0CE;
        Thu,  6 Oct 2022 05:03:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUR9j58TsJ82bFO7+uDFXcf+kUWtvnM2532bv5RxAvtJ8SPU/Ct+D8GdVIrffKRDlQr/vFjwBLfrmjEvBpM+JBVyATPbd9xqA60VnKL8uxzOIc7nWskpQcMgbDGd4ivHhdJtshDGFHfxAKXSYHN+vlEPRc6WI7pLug6LRBxFMdwnYjMZmlSFdaUxc2x7CyLck786l0ox88tWIsOoavOMuamIEVVhVEaqt6G8mpeGKjdjDkrGeNMTLGdaMk8LVmRbs0wfL2PNTpX8xxNTaenNwfupituTc2AnQFtSgN6vRtVl1re4lHNTzZ3wM10T5rsyealMk6Vx1ydCYTvCQo7VuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BIZeUlYTkkwEsnHPOV5W2MrbkHuv+NAMrifo5Urybs=;
 b=JQSz8osoave8WGdnInyi4QbdusQgOLpZtarVE3pGuIh/WUQD4S3l3PtyvdgnxFsMBtsbU0XiGy3JZDrMhHrZ/OeYFND8JzNXArBgv9IvHG8ph5URxTofLfvCB3EpeZ+3RXLZ3JnGpT+RUu7H4Rsp1BWgtJxgW/On7HcAVo4s5++JtBXfh/lnoWcWo8SoHCLOT0jaSOWRseo0DAYks8AMcatra9Dc0LLGRE/AVqy0S/cxdlTSGQPqEG7qKzRN6UkY/7qicDobtnir5FLgnINY8cncy1jnCiCWNZEmfd09OTqZsvw2hhcIXIaaKChkCzPrg44paJrYZ372ZFXR/u70Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BIZeUlYTkkwEsnHPOV5W2MrbkHuv+NAMrifo5Urybs=;
 b=bs3zfnttyTcJwElHwR1IHPFTY1cBwYQgtk9iM2/3MKJBbf4ldkC/pF5VZlrYRPReaoiVNBVo02cKGobeE2nMFx1V2dxKwPny9uoT3mZb/T/+GNJ0CVX79d52/1QlW9unCcCgGwxRiQHkNLALbUXiiKORQD6gQONNxjPhs5+LWg8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by VI1PR04MB7008.eurprd04.prod.outlook.com (2603:10a6:803:13b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 12:03:02 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::d551:6af4:bca4:88ea]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::d551:6af4:bca4:88ea%7]) with mapi id 15.20.5676.032; Thu, 6 Oct 2022
 12:03:01 +0000
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
Subject: [PATCH v0 2/8] keys-trusted: new cmd line option added
Date:   Thu,  6 Oct 2022 18:38:31 +0530
Message-Id: <20221006130837.17587-3-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221006130837.17587-1-pankaj.gupta@nxp.com>
References: <20221006130837.17587-1-pankaj.gupta@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|VI1PR04MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: eafea71b-4dd8-47b3-44c2-08daa792b743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j3usDY2jeFFKX720x4didUtEzPGwwHbl5vtGZ8ZrEAObkDdjKkqzCf4KUBDP8KxD8y9PhnC1UXskkqdI+qeit2F9DYuY/+olVMDb4SOCcwrXKMS8ubfWcvlnYKVw1WXaPDijM1oJlkFNQ+iaOfAmm9Gp8jWfK27o/bpqt/YhdaBAH95Sh6qKdpeli2j+Y69RMMxjH7Ovk1R7VIz+LBQxSY26P1r7wBNu81guC0FGEsfeSnS8x23FI27oI2PxUKNFWmoXevsPAUlW2KSSVEFNBMiygfTxnvEMddNYVt9gMP+K56Mu+cFNLv23mRuBOCbTMjNFO2Ril9pp+ImkZkkjC0ZS6qK9Kgw6S4DShLhLkesm14fFPoxlQQ5qFe6BBaXFNsGgI46CUPkBVKLwIbDbmZ8Tr9SJX7AaN2tMMBn1NSAQYque40pka2xmVD3kyfedLpVW1LOdcOQ65Zbz6QOKk6YQJ2AsO0eehz1ZMnKv4uKwqEZvf3E5N6X3wP5lkl89Y9vKdy4p68b3t2LBxvD3k9CuqTv/Y17n1SjS5bYZ37Yw4UryxMRreDX+E3i4kzbeY07pYS05frRzNuAzRCZhx5LM8ULGYRexZ9OQf+JI755Av33DwNbGIHKhs+AQbG72flRysSav3E7FGI1hySyNzh+Akc3HpD2ZBb2ZYu8RaCV3mzbEoUd8i0DYBNwq1nprqhg7ifw2E53M6gd4esnDDlL6OB4ca23crpLDgBx8Ma9W+/llMENNKcYU+gd8fBr5pQj5seghLcH6BAZAuY5lc4cfwLikQ/9/FFeMBJkmc00=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199015)(2906002)(52116002)(26005)(6512007)(6666004)(7416002)(41300700001)(36756003)(478600001)(38350700002)(6486002)(38100700002)(86362001)(8936002)(5660300002)(921005)(2616005)(186003)(44832011)(1076003)(83380400001)(6506007)(316002)(66556008)(66946007)(66476007)(6636002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hDN1w3Y6tDp6bCspK69IAi5ruQfq12nMAQ9UoXlNPoqLYF5wQHWvg8OkkOaz?=
 =?us-ascii?Q?9fkMr/nmft2oAOp3gFCYZnBAA2pgpHYOuoXkgrPAFLo+cwM+sHNMM8Ns7zcy?=
 =?us-ascii?Q?rZOh+bqYT7giIQ6E7mftV8PQUp5LrD88iuT9tTfZ+OOCmM97XPA2nEMI8DML?=
 =?us-ascii?Q?aDBP93DDL+pkOuEpHC4tMYwZVK6fqX7pqv1UHQUHG1+Tx6EC/DHhQgs4iQXx?=
 =?us-ascii?Q?2d+3vVmJ7dTLV+FqDYj9JQFt1ARltiuC0UaXjdr/IvPTe150Vx2o+6szjL0S?=
 =?us-ascii?Q?YrnNO3cpCvvVkh/L1OKZdk/r8jvpZ/fDtap0Z13wiH0oauDu/RzWCuNqceKU?=
 =?us-ascii?Q?Dhx1EPOEyBzZSvyhHlrTLfV6l6riOuKaRHWRta8zfdGd86W4F3mIOWo7vICB?=
 =?us-ascii?Q?c9IOiUqa6rAQOtiXwKsV2++4sUhzFeEPB8153S6ZMzsKKZRAFjWCzd2pWBv4?=
 =?us-ascii?Q?/Wa4LCf5PZ6nJtgZ13R0stLkpYsFVtAOUI2Hum1qwj3ItJIguNhk4Rx71IYB?=
 =?us-ascii?Q?XpL5FE/qlT6recLeAwentPsbjRC/Iy+J9JtCscnAfbo4pFLn41SYBNczN5ZJ?=
 =?us-ascii?Q?o1vr4Z1g4XksSteM/K0qqLppOSUN+LrlSWfDtreM6F463/FKMQx+DKfxSn3W?=
 =?us-ascii?Q?cYWv8VePBtPRsSyU+SuLMSMDQmNtQOXd+pxwoiY9sFoiGL9UyoxyqlHC2Xir?=
 =?us-ascii?Q?58HjfDC9MVAE1lquwmPYhIN7O9qaI1b+r6tStSLAuJmK13+eiyC5cUblOMGQ?=
 =?us-ascii?Q?tZ2J1+oGY2xyRwBKpoZAWuNLfUvGRxdFmgOE5SpEPtl+vew/lBpsf+Gj13fq?=
 =?us-ascii?Q?SF8oJdGmFGslLr9heN1YUgSHrAYQZNz9DQo5bgA5w5HBEp4TTSMn8sKOIU8c?=
 =?us-ascii?Q?t4J5vjq2heigYonZ0BVQSoHlVbLGi44lhHmqBim0+2P/F2zY3Ko+p5AMHkce?=
 =?us-ascii?Q?AhOivRswpGe5c816fHjAAK5QXKyX4V7yxbHdCMrNMWpZdVpk+jyjGwXGEg6D?=
 =?us-ascii?Q?zuXAJQbTGpwSAmMKOIWdP0fMcvfaufzGA3rAby+wi+KWWyH3pWwNBKUY7TEJ?=
 =?us-ascii?Q?q1GdigYui8ugPaJId1kV0Ehjl7IOLj5lOdTX0OeDakTg0GomLTXyFdNtydFB?=
 =?us-ascii?Q?G8X0fIORwbeZMG5jqXKJ5wJZTrufGFZhre7pIHb87sC1zSvG7288IAqZl6CQ?=
 =?us-ascii?Q?XEanYNeOe5uGzrqbAQMQUm7b+cWWmk8S5qigKJwdwbHD9zd9WH4T5OV46M+N?=
 =?us-ascii?Q?j6EyG7QXrm7YpbSP7WRHcuYK4OkyUgmxYMWB8luc39t7t07Z2aukFPo/HD9L?=
 =?us-ascii?Q?pbScvLQseQqsL271NqcB1aTu3fTpsda8V+NapYImxAuEJueWgWPAjpaniw2F?=
 =?us-ascii?Q?WMbhOUrWBvfMdg60SfVf/xoOi4+4GgSsAq6PFYOx37UlDhGQdd7Ppb+xYMR+?=
 =?us-ascii?Q?cY2ili0HJfJxmbA22WZKoId61VnqdwLTPFQwt2s/5WZ07+7R/Mj9eMbR0ZQg?=
 =?us-ascii?Q?rj0BKYoZwwRiYuy5ZVPB6kvTSrnnp96FLP5z2YHB+/6DWC7/MIsymttEb4Yk?=
 =?us-ascii?Q?ps+AOTbJ6cNUyIRCI/FDHrTokDvPYGPPy652F3hV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eafea71b-4dd8-47b3-44c2-08daa792b743
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 12:03:01.0080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n158RM4GMQUNY6f02H9Ga1Rg1K4IX2khJpaEMI4M42XwzElPHHYxxhkMOUL3sd1lwvaVW3+SQBHdpRAE//Gfww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7008
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Changes done:
- new cmd line option "hw" needs to be suffix, to generate the
  hw bound key.
  for ex:
   $:> keyctl add trusted <KEYNAME> 'new 32 hw' @s
   $:> keyctl add trusted <KEYNAME> 'load $(cat <KEY_BLOB_FILE_NAME>) hw' @s
- Key-payload, is added with two more information element specific to HBK
  -- flag 'is_hw_bound'
  -- structure 'struct hw_bound_key_info hbk_info'

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 include/keys/trusted-type.h               |  4 ++++
 security/keys/trusted-keys/trusted_core.c | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index 4eb64548a74f..bf58a204a974 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -7,6 +7,7 @@
 #ifndef _KEYS_TRUSTED_TYPE_H
 #define _KEYS_TRUSTED_TYPE_H
 
+#include <linux/hw_bound_key.h>
 #include <linux/key.h>
 #include <linux/rcupdate.h>
 #include <linux/tpm.h>
@@ -22,6 +23,7 @@
 #define MAX_BLOB_SIZE			512
 #define MAX_PCRINFO_SIZE		64
 #define MAX_DIGEST_SIZE			64
+#define HW_BOUND_KEY                    1
 
 struct trusted_key_payload {
 	struct rcu_head rcu;
@@ -29,6 +31,8 @@ struct trusted_key_payload {
 	unsigned int blob_len;
 	unsigned char migratable;
 	unsigned char old_format;
+	unsigned char is_hw_bound;
+	struct hw_bound_key_info hbk_info;
 	unsigned char key[MAX_KEY_SIZE + 1];
 	unsigned char blob[MAX_BLOB_SIZE];
 };
diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index c6fc50d67214..cb1d56397ed0 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -79,6 +79,8 @@ static int datablob_parse(char **datablob, struct trusted_key_payload *p)
 	int key_cmd;
 	char *c;
 
+	p->is_hw_bound = !HW_BOUND_KEY;
+
 	/* main command */
 	c = strsep(datablob, " \t");
 	if (!c)
@@ -94,6 +96,13 @@ static int datablob_parse(char **datablob, struct trusted_key_payload *p)
 		if (ret < 0 || keylen < MIN_KEY_SIZE || keylen > MAX_KEY_SIZE)
 			return -EINVAL;
 		p->key_len = keylen;
+		do {
+			/* Second argument onwards,
+			 * determine if tied to HW */
+			c = strsep(datablob, " \t");
+			if ((c != NULL) && (strcmp(c, "hw") == 0))
+				p->is_hw_bound = HW_BOUND_KEY;
+		} while (c != NULL);
 		ret = Opt_new;
 		break;
 	case Opt_load:
@@ -107,6 +116,13 @@ static int datablob_parse(char **datablob, struct trusted_key_payload *p)
 		ret = hex2bin(p->blob, c, p->blob_len);
 		if (ret < 0)
 			return -EINVAL;
+		do {
+			/* Second argument onwards,
+			 * determine if tied to HW */
+			c = strsep(datablob, " \t");
+			if ((c != NULL) && (strcmp(c, "hw") == 0))
+				p->is_hw_bound = HW_BOUND_KEY;
+		} while (c != NULL);
 		ret = Opt_load;
 		break;
 	case Opt_update:
-- 
2.17.1

