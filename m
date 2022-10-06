Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBBD5F658A
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Oct 2022 14:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiJFMDH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Oct 2022 08:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiJFMDC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Oct 2022 08:03:02 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80049.outbound.protection.outlook.com [40.107.8.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845809DF97;
        Thu,  6 Oct 2022 05:02:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORWMUU1LIKiwz1S1CVF9IIRa+cP/blr4ZsiVYfgGU7ERXOMWmU4d4GHzFvm8n3Hu+gMhb5A5XkpQMHXf/XMR6GzWHSgqkeauHAPJSSNK96jO99pi8+hxFCnOTWDWaouKI7jS4N4y8kRikahgvDax/gaVthqTuTVlzojwlYDbQIZzGOOY2veb0Q7gCAHdvYlN6h6pnl0gS8IlQxyF4hwDyeJOVyt+c9JUed+SSegybaD7/f9i6eLCikP2GZh6JnTfEMDZfXNrd4KgpYQYDoQDHk6UoEVaV9/SIL606M2ZiAyc8jM9QtdhZ3q6MPgPZqO0awaiHHeYhxtAPOwYrYH33Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ut6SQk9xGws8OY0mrSJBJ4KVW4Sj21Bmvp4J0BHJjxw=;
 b=IOzHhnK1dBuLTjb2XJylICn3kNYbbwxiKdCumoZR0Mx6Q2H/DTXzzuuXCMjlK7otVj1IMbkqH5TMDbmXSCtSvrsdfuWVvKy2CJLHhSl7PWJQrCdEMvYtBw3MMA5i1p0sAJmBuPXGLOLv2JLTRMfDB/k9NR5uNtxrfmYurIUvc5MflUgPE8CUY/267jl/J12ImS6OiaoakytPYEKNRJMQTooMhTbWQmqgMLX96sS+42kotjmDu2qY/8aix/99fL+HGagGLoEgRwpGu1y7JMvOwjarn4g0dJF+iC3Tqx9ideLuOUdd/6BCfu1NfWOMsOpYCoxUv2LIyN/m89mDdGhKVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ut6SQk9xGws8OY0mrSJBJ4KVW4Sj21Bmvp4J0BHJjxw=;
 b=DBW7lCW/FpX5LAwAdKNsqDx5f63fLV9MPJQVBwRoeF5Oh02Kq2gp4E1aKhpWL3bge7JRXHj20KbqXGarUL6Fg7mrpCwEya5gDBb9vugqPVbOw/x270jBz72mn8qcTgH6dWFF4tunPwG4vZu8NdjpsrqeOawPkzrla4/6tEoRv8Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AM9PR04MB8523.eurprd04.prod.outlook.com (2603:10a6:20b:432::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 12:02:53 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::d551:6af4:bca4:88ea]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::d551:6af4:bca4:88ea%7]) with mapi id 15.20.5676.032; Thu, 6 Oct 2022
 12:02:53 +0000
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
Subject: [PATCH v0 1/8] hw-bound-key: introducing the generic structure
Date:   Thu,  6 Oct 2022 18:38:30 +0530
Message-Id: <20221006130837.17587-2-pankaj.gupta@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0c565679-3cfb-435b-b069-08daa792b29a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mNv9UzIo114sYH77KTJWvFAuYM32i8LYQbWbINOHqPRbkPBqpxaEje0ojYhjx3k75yM4ejj0ot+TjhYKD9XO7OBXPAhz7Xzdj1kbRJjMFnS6enVeCr28PIh71/mujaZmFCnQ691getwCegEKvsXIknjK2L0JZ1g5te7VUhciIS/UEq6z1W921jOO7P63xRt7rjgXY42S3P+wH3WCKoxjTekp1aytSG7MAwBcxVcZurxXPtobdzHKQpR0HZrqdWzbMAEyvAXcDB18LhBHRRDE4cxwuiuWMO2XFK05ux3wguUmw/TpnQN5ftWakKCcoFXaY5ni68WaDDxOjmuoo118aUftAtqlZXICXnJZzVVzl740FSyjvLOcXuREs7eQka4Vj1mm7xLmcZ+a3/iyKERQWwTs/JENZlFcGrBgkkvm6FroRFN1qO0RVQyaRZjH1qACCzYS1NSGI8Tx3NpewE4/IQlLubchi/fB+hrt0NCVVV2OH8ry2S3taPOTqAHNm6O2yKv+kMuhaPhDjeXlb+v4q5IRMvfjVFT7wBFK+Z8XWg0+3GdrV/E9vLatA4al3FnijbOic0iNsWXyeP81Ck5FfCVbBNIYgBKITX9S/cakQGOQpzkXOG9g/1SsgiYz7AzlLXEh3QroZNRYd+jBu0scarEvSu8qtGKAEJg7aFwbQVaqKJtrwhrElozWDiFvO5bjt0zAsxhPKw5sn9mAww1cBq95V8svSlVKS84+6hk/F+ztWDcbNeeGvFx6lcKPg1b8HWtXCJAhqsN+q9IxO4Flp7m5TekbPgUs5Znmyq8Hx0639Hp4uOzjgcTOAGuaScOu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199015)(66946007)(66556008)(4326008)(66476007)(8676002)(38350700002)(38100700002)(478600001)(83380400001)(1076003)(36756003)(41300700001)(2616005)(186003)(6486002)(316002)(6636002)(52116002)(6506007)(6512007)(86362001)(921005)(6666004)(26005)(2906002)(44832011)(5660300002)(7416002)(8936002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SHPknXPj6uzVPoUCnipRx5wXuFWNjABISF61Htf4uJunLoC/eK86Ygq4Xw86?=
 =?us-ascii?Q?dzeK+7ye8MJGaayKG6GCNxYaUiJsoMPAIvFV/LLbuUCWu9i5ru6sdLK9FyQE?=
 =?us-ascii?Q?93MPX18XJULSvqD6IJAaguQ2oFpq7bD/ex08UliUP+DfL0WGGPC3hMbwmmTB?=
 =?us-ascii?Q?RK6fVwXxbk/+o2ju7sHydTQyEUsDyOp2OZLdXsVO4NcSfex7N2YHzGZ4Xjp0?=
 =?us-ascii?Q?BrcRUuuQ3RTYXhsDdZYkEqci6j8RcZLN6g85FnFTweA6cn0mVxGiI0MppdjV?=
 =?us-ascii?Q?6axgnrqnggPpDETi7kxf9iNAphppMHUAEf8d9qWG/glI52mewJQQNGLVoRr2?=
 =?us-ascii?Q?dOToYt1Uqk0Si9nJFnboRZJZT0UtQQWWdYm62BtMuJQhck9bUBPlaLgwP/bQ?=
 =?us-ascii?Q?Jkl8U6q+2iiocWCm2fjNW1fzyDgkecAFR6rVv3QvBTdgDPoxcYpPcDP3Mf5/?=
 =?us-ascii?Q?D6o+S6GzDxmMwxGu9l32b49sbSPsBkldPpZg5hfprW1jgZgUCumndlzveDZV?=
 =?us-ascii?Q?2zy9NcRq93VJGy+LN5iqkoNEcBih55sAj15Mpy286GFtZdfVQdenEgWi64oj?=
 =?us-ascii?Q?sOk4FWVsgx9EcpexQe+ZjwewX6jsy2WSKfkXkCpq1HgOtkvs6F4tc9HHT1+E?=
 =?us-ascii?Q?m+sxAB1d/vuQz5ejMVnNoTp+i1zClYqD43Q7j0bxZeimfGabdeoagEF6GDQC?=
 =?us-ascii?Q?v1vLgBKh8o5rHZLfGyibkxOJqk6vZHGI3NwVhX+6vvpNhfPK3LWzxZvWVgBh?=
 =?us-ascii?Q?FIve6EpmOav0uL+gJNzVT2NTRaPyNJqdr+dHBTxx1QwzB1u/AmRAgMc3a/E0?=
 =?us-ascii?Q?HZggnBvlm2UHgyWtvmJ07KVWBzJY7ZPYHaITcUmteBgEAYt0x/esUHGQ0stw?=
 =?us-ascii?Q?y2QaCKeGx7uvjGTC9Az83uB4LoaiHEeMVUtbSrTbDL+S2HUPftVbVMZO1VXO?=
 =?us-ascii?Q?WusTuuAapedoYqV7ARPO90HcSjR9C9Pj4zAKDul0BVydzN/J2qDT6x4+bqhD?=
 =?us-ascii?Q?28jtV4K/SXy4BUYtRMoCBmgclU7Hc7AFp+tVkv2Jfo+D1sf/PG6jpE2EbctR?=
 =?us-ascii?Q?wpc5Si7wuJRDbBhH016o2UB68kCmkdoMt9XGM0eBnrkubE8vdA71Agos8Onh?=
 =?us-ascii?Q?oUal9JI9wtQEdPfjzwM5ejAaeUegmwLjVEaMzXBVyQ/hooO1Z+KHAkN7ebTH?=
 =?us-ascii?Q?/Vx7CL2xfxjGjdzchXfLVlIE5UYiNmN8rLcBFicWq/sIjFOQAuvhIQd19Nxa?=
 =?us-ascii?Q?ohKSwNNVYhqBmhsauMPTsBj1rV9/CCotFQaWjiunLuCkOp8QopiojpuHgzIi?=
 =?us-ascii?Q?3Gh7oubVcehIy3TL2Uk5rLxBpdniQqjjEbk1yCgYJVOzp6rrEWoywIxjt8wb?=
 =?us-ascii?Q?Lg6vwG/twZe39oIuqnY/DIQnLbBim7aoVxGl5Qg1VAOtG2UC0ILotnrFNHuM?=
 =?us-ascii?Q?W+KwUeDvgjZCVoAt/xbPornV1L+JEhR5JZoSA51dLyX/91jsHOGU54QlzcL7?=
 =?us-ascii?Q?rQqW2iE9TxEPJv1vmfIqWrcQTM30JTN6rbevCOViRy3L9meZfZitWG+HPTzy?=
 =?us-ascii?Q?gqEPwLb4C30LwrKBbfiamOsYtHKJw9vuIf7bOwag?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c565679-3cfb-435b-b069-08daa792b29a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 12:02:53.3810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2MCT56vIO50H/bjB+2j01nh49xrmRFovzdOUEmL9a6aLbcLC5pZl8Uc/CtRXUizEwEumrdi1Ce2qAHB2WvojKg==
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

Hardware bound keys buffer has additional information,
that will be accessed using this new structure.

structure members are:
- flags, flags for hardware specific information.
- key_sz, size of the plain key.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 include/linux/hw_bound_key.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 include/linux/hw_bound_key.h

diff --git a/include/linux/hw_bound_key.h b/include/linux/hw_bound_key.h
new file mode 100644
index 000000000000..e7f152410438
--- /dev/null
+++ b/include/linux/hw_bound_key.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright 2022 NXP
+ * Author: Pankaj Gupta <pankaj.gupta@nxp.com>
+ */
+
+#ifndef _HW_BOUND_KEY_H
+#define _HW_BOUND_KEY_H
+
+#include "types.h"
+
+struct hw_bound_key_info {
+	/* Key types specific to the hw. [Implementation Defined]
+	 */
+	uint8_t flags;
+	uint8_t reserved;
+	/* Plain key size.
+	 */
+	uint16_t key_sz;
+};
+
+#define set_hbk_info(hbk_info, hw_flags, key_len) do {\
+	hbk_info->flags = hw_flags;\
+	hbk_info->key_sz = key_len;\
+} while (0)
+
+#endif /* _HW_BOUND_KEY_H */
-- 
2.17.1

