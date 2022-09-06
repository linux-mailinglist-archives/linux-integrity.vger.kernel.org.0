Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38EC5ADF15
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Sep 2022 07:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbiIFFur (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Sep 2022 01:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiIFFun (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Sep 2022 01:50:43 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B426527C;
        Mon,  5 Sep 2022 22:50:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJYYLjHqeYYXNzGvHZSaQ1VIJFQDAWEmzI7WPhmNiH+ONJOIrduYFTVS24igy7N5ARv1Onx2UPL80NyIj+rsBSAxhJz3UwhCk4EhdxpkdeikGIBI9gr71RSzhoy36WV6ofXMOgfoYK/z9KTB7vS0FJzWZVMYlu3k7sUlizLOSdaA8tattrHvogfbRxHDEPjxMSmbNThumfpvsuTyFA/YEcCNMmp0ABryij66p+opg8Fqew9vGsE7vuIvvHcKxFAdNZ3msmT74u5ITiKkeK1WNGMX3YewCNg5tdeMY4KDPne2qLbqz1mgNtQpvTdxeKC9Ulm0Zsvcf3JeaQ2bWnxdRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZNSue1BB98oOwbk5xjFV6FMaUS6f3bYXUbZ7gMa0J0=;
 b=h+nEESh6WgRzTwaKeqBH0oq7vpxvdNCcx98pybrXd+4H2ZmHBGVTj08qkV9Wy1SE6Q6GBXcFaCCJzfeR4Pfs//xHVzPSJtPAJNoSfDCsvrGu7c+uNuq7Eyda9pCHoyssGCBxvO1TDORr7uUlGANkTQP42+Qh832YDWPMak278CvRiI/PfEN0r+aapUMAHhgSuV9n3e42mk5lkBElvNrZUNWNCgNlrmmXpzz7PWjlEDQl8SiCpVXpsqJna2BUAdEVUnTLcnKFWa/pEAH3Cnc6N8XCF8TspjD1WuGPCLORDH1P/HsjamhKduAnkePfU74Cp2etQfCAiDr1+tXlAhTOZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZNSue1BB98oOwbk5xjFV6FMaUS6f3bYXUbZ7gMa0J0=;
 b=fySifEL/pQxpIEoSjNVqSdquHbPP9ofhJWiw1tbSMQPEYlcxsPhYHZo1Pw7zk3j2p0EC3I2euogMavQDHw7VkY4qjdMVCG0VMW1xtVbp8o6bCGi2BJWSv1XUVXwBBTtc881wXPGe5homo+01+gd2pSI4hZvJrI6gxEa8ruOagS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AM0PR04MB6657.eurprd04.prod.outlook.com (2603:10a6:208:17a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 05:50:37 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b%4]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 05:50:37 +0000
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
Subject: [RFC PATCH HBK: 3/8] sk_cipher: checking for hw bound operation
Date:   Tue,  6 Sep 2022 12:21:52 +0530
Message-Id: <20220906065157.10662-4-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220906065157.10662-1-pankaj.gupta@nxp.com>
References: <20220906065157.10662-1-pankaj.gupta@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3a4f3b6-f438-4c2b-c112-08da8fcbb8af
X-MS-TrafficTypeDiagnostic: AM0PR04MB6657:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OYaxSDhcDC3fJC3Kjm5PIZFQ0CrmX+S93kk5J7/jNGObkKcSg7nfENCqJeopnZdqRuLtbpsVtv9yC7Cwg0Q4MDvMs2vxlgcGVD2QXn4SIt4zMt/rKN6D4d3X7vRuBuLbHhR1JheQp2twA+JJfv3j5JCow/q0jBUkelHvq1QCSTrZZ5YLJA7y2s7sp1mmeNjewsKXdWOUd+Yr2xd+Ve6Nt0cD+qRZqfhtFfql9RLaof3wA6wg8Lv63AtazrolxUu6geTJycrxHJ9kDP1ING1o69VPAOxwdgX1bT7czHJE1XChkRVejk1AKX/zniAaiIROs2EiVfFmdN270/NIErFNZcXik+A5+YTtXm1B9uTKy1cM7/eSUzzF1EFGiE9Bl/c0gi8fLPBO2751e42IDoWR/tzxDO2x++XpjG54JFItIIzOP0frby7aX4tnet+N3T/K4MLQkKk8jsUh7QyyQRnL4orq+nSv2rOtxZ6Gp8w9wzdlKv7Ov4zMCm/WQsQXO/sv1mq04adOMcu571K8HqjfHybJo6IIrKozBoE1tEifHkgrP7D0dx0Xtvl1I9dgiQZEzcvlrhTBpFqBc7DKW2OyE/PYi4ZNX6BtQxVJJ0AvwQ3aEZxslCoNdM34nyVX0/TDzZePNxJFr98SYtLcjlp5kZWNFcwrY+T4ARhL5zlLhU2IZrAXxmh7D5iASFoMazpNuOxOMnsU/3E3ugqi2hyjRfNjUOwBtMzbR0TQE8HW7jFzPhMTIoGYNyRKgz8DonvqyXGECLSMPS/UbnQM/Eh5q4YVYx1c0BHTNTW1feJ9a1M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(6486002)(6512007)(316002)(52116002)(6506007)(478600001)(6636002)(41300700001)(86362001)(26005)(6666004)(38350700002)(38100700002)(83380400001)(2616005)(186003)(921005)(1076003)(66556008)(66946007)(66476007)(36756003)(2906002)(4744005)(8936002)(7416002)(8676002)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3gafLITasyrtzxTTHIkiBgXXLi0i2BqLjMLcndgJCgCQlfpK6lECKdmJ6xQC?=
 =?us-ascii?Q?rwlj6APiPTsDQtnUSQTPEZ6iuU0uE+lRBqPFjtgj6BwkSSvScb95iz+2/0ha?=
 =?us-ascii?Q?C6RdISYAg5HI0fdWA/b20HOEDws9yKrHl6inrb7ac4lt4FyKWbZ8rczmdsXQ?=
 =?us-ascii?Q?g36lk2RJYOqBFZOrT3r3ZnM1+/Zy9h+GXYh9knWL50ODcKnKrOzZ/0m/tsFr?=
 =?us-ascii?Q?m9M361+6igS/cpN1oXIMmQK6IEoMQcVK4epbt9YvMi++EL4A5PCiUc6AukWd?=
 =?us-ascii?Q?JjBSDYXLi2I1NB8OD9kxYzgvAC8SNkJf734tJeZ2Sjqu6AKHX951R5+qddkj?=
 =?us-ascii?Q?TLELApGgWkbq41L1RP5ANbLcM4IGo5h1+oQuNLtABWTMPto5WFtntx0d5gjR?=
 =?us-ascii?Q?kubxfJ629Wv188O1rupz1NXdv/g7KSlXe8Bgb7h+t9vncmOcRGEIEdKkxZhD?=
 =?us-ascii?Q?3AePPIu9uk8/7bmNYtgtcwSmIJQ1TTEcFddsUA5vRkPhSaOE5Ja8E1BU1SlQ?=
 =?us-ascii?Q?51GG4JDZpnlTnBJ2wmxWENMqWPqaFYssde7ttE8dnKCIwRg9AGRCHQwpF7HF?=
 =?us-ascii?Q?s21qGuJ3WuzMo6O1cEcl6em/SVWPQcOjdi+9/ef4zcPiFRVubpO/p4ENKVVj?=
 =?us-ascii?Q?hIMNu9AMeWmI+EBI1mJyapd0ZDKM8foazsQGpex2Y3moiUJJBsLykaeD0Dao?=
 =?us-ascii?Q?5PlULeEiMYn+nP95q9vtt4VXb6JwnEhQfG71Y/r9zMxEuhwZhF2gPSROFIm/?=
 =?us-ascii?Q?QTQ4R15Gnty39P0U/FisYib6gTxSOyXYidGkIGIMklszGGgnf62/B7LiO2nF?=
 =?us-ascii?Q?0I4jAFMG1QncOd5RDm3AUGRVRUfotsXtvX9YpeArczf5C9+zt4CSyHX4b+0U?=
 =?us-ascii?Q?nkcr77L4/gPyivzGx3/jNsK5HVdZml/u0g263Couz3kSebR3nPqVUkK4nRiw?=
 =?us-ascii?Q?antKU3gNL3ajNS7InDLmlO0MLJ+gaeSxYpFZoVoVfwZdMB/M3BRwHQXnFCbs?=
 =?us-ascii?Q?TfkDdBHoukXnZ8iv1pSJUIv6dQA6FX5U4pPrjB+oOhZ2CnMvx0WZ6VASDJDZ?=
 =?us-ascii?Q?EoldRAI+3j0aZhVaRXirvFggBK+alnLx7ZCrgG1SgwIpDRPAZGyrecHdEwU9?=
 =?us-ascii?Q?D77XsDbWmy/5ue/EtJkBWh3B9Xdk55qJXyDqH/E14ucvy+HgBEJdesP0vw86?=
 =?us-ascii?Q?7j61uKZXWfWqXvVzWg4gNKZCJEhRumk9rJAVPnwbn0jbfl9l5LCjwlVW1Gv4?=
 =?us-ascii?Q?u7E/q7fFI0NDUTwrO7+NcN/4mdMo8xyw/KajAS4VegQ8ZqaX4STe7CEg9lZ6?=
 =?us-ascii?Q?48CtXGlA2wNnD6bUrWRgSsITHn8AOJEHxnWjAxYpDHxNznNqdbPknuRaooeb?=
 =?us-ascii?Q?hqq3F/EDhGzla5OfQUgl459nQkDrGX+ndxtF4xXCcqcF3NFzxdUV4SIpbIKi?=
 =?us-ascii?Q?wUj9cz70mfpjQnwsMLeHqRJf1wCqLTJV6CcGR0qbBVEavAkbvx2M35UwwJE4?=
 =?us-ascii?Q?QYwReHUGDUtKcENi+5ImE4FfpBhrLE3QaeuuZqXu2gfzgWBx/eOA9XEjSopI?=
 =?us-ascii?Q?uWT6CX6d+MEtmpRad42Aecr5dIiXRaHUX0J5UBeD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a4f3b6-f438-4c2b-c112-08da8fcbb8af
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 05:50:36.9442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NI1vJV2rz1/Ylw8Gcdr1WacGZ9AOs1UQnJDtlqkHRxD9jsvlE5jvD987cTJmBJe9gPc75uyVhK6DnMGKnNUsYA==
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

Checking for hw bound key. If yes,
 - skipping the key-length validation, against the valid min-max range.

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

