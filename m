Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9185ADF13
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Sep 2022 07:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbiIFFup (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Sep 2022 01:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbiIFFuk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Sep 2022 01:50:40 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8966E58DE4;
        Mon,  5 Sep 2022 22:50:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3SYaRriF2jZBVoXckLTALyMSXDGQJd50vaJqeLx3xNNkJDb3XxTtnKigqtv2ssQBCE2JyRB1BXUS+XXVooG5zQvWouKhddFBex0OXX2Ne0c2OuVpQhE0LoecmiVvNcfW0yrP7BEK6N7rn9Rsq5CyZuuP18D3aN+cYeEP7+HFRUuG1ce5SokFaeT12qZCIvGJVlF6jfHu4O31R4sMHyVWGVYK/iw3LnEDIgqs8W0lpNq9uuDJ/b5ayDV1Yt4CbBUI8HYuIhvIfLa06hTgj0+Um7aMQKZLKhC4NZEnOHRxf6aT59q4VpuNsfGs/oS5KjWM1cwDLXTfNaxu4gVjQ+7gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GndXkJkPfORYmKcovuFi24Udklu9kGU68uV6SYGtSs=;
 b=FuauGIvFT4tVFlByLqCtOJ+3qx0iXOS0aGei/HVgwLaE8UYEfyMpmIjr1VfevIjFEVdWUZwKzJ9NuQG3GFx+kNBoUjduHqQlPrZnqp0n/0Py+sdpqD0GbluOFdQ/uGByMCABoq4OyeMl5l+UePmfy0qRo/ktjv10N4SUAqQDOLe4plnHzd0ukKGdka8chcAr3zt5qG3+YiuKfiYhBJuZmEeV7KoptALjx/hpH5LXPrCyutBi8N9hIp8BCqyQS9x9oAUrWSXt/+Om+uBvr1allLMryQGMuJ5oQFU3AFgqgGiqRr9zm74Mz/bP9hyAvQyD64IMkVKXJ9y4m9QulrNkEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GndXkJkPfORYmKcovuFi24Udklu9kGU68uV6SYGtSs=;
 b=OMdSoZAIhUJLuBgxjBQhG+XsOqMkQfWiL7SXQEYDnXqW7e1tk6+L1+6OgrEjJ9mq4s6o5bS2HTUC34U6GkM+WdveuTBU4MSyynP8hHxWK9UpICj0t82XOyvQsKofxgFqIF6xYmW6fxS5cVl4VRDKnkWWn4lo7FPB2S+X2D4n60M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AM0PR04MB6657.eurprd04.prod.outlook.com (2603:10a6:208:17a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 05:50:29 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b%4]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 05:50:29 +0000
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
Subject: [RFC PATCH HBK: 2/8] hw-bound-key: flag-is_hbk added to the tfm
Date:   Tue,  6 Sep 2022 12:21:51 +0530
Message-Id: <20220906065157.10662-3-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220906065157.10662-1-pankaj.gupta@nxp.com>
References: <20220906065157.10662-1-pankaj.gupta@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b94f26f-a8a9-4ae3-a5b6-08da8fcbb43d
X-MS-TrafficTypeDiagnostic: AM0PR04MB6657:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4NUZvrliIvreb7pPeOn3tCN+nTmFyCFiZQWJ0mJQ8bUGuLFGxDNMbaHKL35lLp963OevTgoRHdHeZPo9Lj+qPqwg8QDS5tzIM3yiZ8lWWncy22VptcW1DPMODyEMGOOvSJk/4qfOqzjdnxwpLpNZSoExptCV6wu66NYvpTQIiizcjRu89MMo3BgsLQrujozCxTJippJxvPsdhlvOZE13ZISQBvrO8dWgsiAkSYmO/OErTQxHYIVi4UqiLDXTtUgjYy8LcDxtjyu9ZmbTl0OlOYXJRcGFUBrDhBp6zpzYAPYpXnBjL/AdFanoRbo+ipZRMycbZnPe/iMQIjCROzvSHiNhAXP5w+Crls6Uu3pbdddxcwfbdotJQRxQec4xvEFH7+HRK11wAbAc6FQOxQDh64HlRsu2FMNIXms4Wy2rlzSmd3p8Ebnfo+T3Mzg3tHST+xolrHyTDJg/rQrFYI74A28FV5foBpjuvNpdfVfPN68TfcGdyoHftJaM6D9tnFdsthBueW7+PxStax/RvaBXvE3nilYjISyDNUyXnoThcUyt95a4FHtAvNy06LpRebY+xjOhnRRgEKUsMvlkJGejL0UoPJ/9YlXs+On0WbFxLDbUlUiiXEeRS7gOv98ViYeY83CiFnW0ALlKdpA8fozXK/6sYqYlJxLgTqwFtP2+jrjx/MIiYn1J7cMpwiHiED8WDtP+ChKVSfgOmIzlKrSdh/SNVUjf7loK/HNEsqtebl6SHPvpAzkEjdsIU8HJmjxVk+Ugg74BXSqTKfLqpodUxPHCJ8mAuBiJFLYNumD7JqE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(6486002)(6512007)(316002)(52116002)(6506007)(478600001)(6636002)(41300700001)(86362001)(26005)(6666004)(38350700002)(38100700002)(2616005)(186003)(921005)(1076003)(66556008)(66946007)(66476007)(36756003)(2906002)(4744005)(8936002)(7416002)(8676002)(5660300002)(44832011)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MGtQfiibBjvVEakIFICJeaoNW59gfNWWwbrqZZyB6+OrAl3h74nnK0ljyzoQ?=
 =?us-ascii?Q?ZzdSeRRVtXPmGTSR18ferolP10RbRRja7GJB4jprBUxzrilghrYlhTKgnGyh?=
 =?us-ascii?Q?/sOpSC9m+F2aNTYfALHX9A5JDvdgEVb/HPpjhVHv7da4OsuAXTEdLNAoU9hR?=
 =?us-ascii?Q?JCnoa6a5q2fkvU1+BU8COZK5Z9k5vTu6Ps0fATtemghrQWUdMawYYT8VeECX?=
 =?us-ascii?Q?0PuurADzBmZZlZKoxDCJ7Ri+QMyYEwlUA3pRMfVkHu3uZRE0rRqvvCazm7J9?=
 =?us-ascii?Q?QT8Kxk8o5rLWGyzO+qkWttR3JXgtz9aXkbyAgXjGWkEXWzYQOo5es+pEvenF?=
 =?us-ascii?Q?qkeSjQ2jdrbDf7LCS+YljHIs7G4bThB+jbvs75o/GP6NdVfxZw57vpBkJK5+?=
 =?us-ascii?Q?fwz/bhyGtaZSZdTMy6TAi8IjBer+BdV+Cujy0ZFBCv6tfWtmYXF6K1VOrIMT?=
 =?us-ascii?Q?BY1SjNpuubqNEeTTBRNbQWOmjPHquHqHn5zS2VVFjY1WFgXfjHm0vmseCZav?=
 =?us-ascii?Q?hBDjp9mHQFKHN7tErmT22A9bhHtf6hr8HPhNE4WvfXKnP3Q6D2BWB4a2TeBT?=
 =?us-ascii?Q?BzXPWq05BylpjbLxAn5ArJdg3i0ikFnLf09ylGouwIj5Ogq75VDadoR8EEn0?=
 =?us-ascii?Q?ab8enlnTLNUVaAi5c0o6d8oRNqdCriK/fCzVmQ03KpyRXS0S6cgB3jqsow+0?=
 =?us-ascii?Q?vSYV70ehdtGjW9LnME98wClboVqCllLaaAKapt0zFoNunmY0T45BaX4LvZSJ?=
 =?us-ascii?Q?UjOE1WnzV7KUTHusf3oe9tq384tV/MN71vHP19VOTvnH1E74dWmEFZCXdp1Z?=
 =?us-ascii?Q?MHGmZYIPaAV2MaCCqmM3ar/BJt7TBEpHBwkYEFGEnXSpco5noGFbOxSGk7+H?=
 =?us-ascii?Q?u1Zlh2TF6YqhVcexE5jNC/sGx5iqTc4io3J2eYoSSDWlJbGyguhPC2b7RiDA?=
 =?us-ascii?Q?vOo/Hzw7mpbbGEmIwgAHg1B9vd+9PWdMzztYu2E2Az+PyjJZoYUTSrwrz/Ol?=
 =?us-ascii?Q?ccAaMDi0NYphWn63JaFy9pwEdcZ1zPUlAA3XdypdGIL91QRTzDosp3MPorJR?=
 =?us-ascii?Q?HGSyB1fjl3pIHMG+8liwpDaCqW9YnigCNVH/UC7a37YGV7r2/18AYx0Z/5OT?=
 =?us-ascii?Q?Wnnbv9CpyeXPuhoEBEv5bZUmHHDarW/DKQfqERpGd+y5L4FHiCWgdI+KATtz?=
 =?us-ascii?Q?YLr4rIHEaDGLvMy+WAV4l3UdKZLlgj9mureFlC/uF9AkIcLIoDKPR1V1Gejz?=
 =?us-ascii?Q?1bHildrQtZhTUluETTAgh2ASiBh38o5fnOr0Rb4lueiB+Qq//Hc7J8LIWJvC?=
 =?us-ascii?Q?XE7CcDldc9d0ewwKUR5WX1ZULnyiAbM1utgE4caxdq7EKLCzH43Y9Ft8oBbI?=
 =?us-ascii?Q?E0RPcQWEFvI/x5uIdKn/LAP6x24dtDQ18gaz7h5/E5LAvGC+zCxBBdoQT9pJ?=
 =?us-ascii?Q?SFJQjXXDPnMQ1fjvNLHc/roL+BV8dFazZ2CxLd3cVXNqVEA6dignp34M8f5j?=
 =?us-ascii?Q?CvE5C+QBoRYQ5txArkZBWs9y8nOFzapoGnnSvgP792mQCjLVUFIXhWxmW7Ef?=
 =?us-ascii?Q?4L8C2TLSwZp8Ag4shOn9ABQXPF7xZvnZW60Ns8gi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b94f26f-a8a9-4ae3-a5b6-08da8fcbb43d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 05:50:29.5015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EnQAd0YyfVG/D80BtpnSz0CYqHyVdLoCI9uKWsRjA5zxLzbR3yjaW2Z7FLoHvrNDcUFuWVyNpiwC3PNKbGO/qg==
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

Consumer of the kernel crypto api, after allocating
the transformation, sets this flag based on the basis
of the type of key consumer has. This helps:

- This helps to influence the core processing logic
  for the encapsulated algorithm.
- This flag is set by the consumer after allocating
  the tfm and before calling the function crypto_xxx_setkey().

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 include/linux/crypto.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 2324ab6f1846..b4fa83ca87bd 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -639,6 +639,8 @@ struct crypto_tfm {
 
 	u32 crt_flags;
 
+	unsigned int is_hbk;
+
 	int node;
 	
 	void (*exit)(struct crypto_tfm *tfm);
-- 
2.17.1

