Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FFF5ADF36
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Sep 2022 07:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238381AbiIFFwl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Sep 2022 01:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiIFFvx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Sep 2022 01:51:53 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10074.outbound.protection.outlook.com [40.107.1.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38BC6E8BA;
        Mon,  5 Sep 2022 22:51:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+MrGulFf/QlOCbojT2zly7DjF4VsGjq2m1cZhhveCJT8kOLNzlVhc0UC0VyPkLuhWaS61i1b+k+9fgnl1ryQw2yTCWtAyhybZWSfhNshjxhkt9WtEK9PWDw6+cX3tHJ0HmRJnErEhe77ke7PC9M5OrH4S06yhUQhI6I+RxrCxzSzUv136Ts2XDJR/Vmxi9QnqkRq7B1lDa+hQOzTQlC2vHejU/OS0Hy0lhFi3mHBhUk4d+oqsdFEdfKuoQuIU2mYl2tudtK1Rp/AO9+SGSJpPPBE68uaUSpPeARLMz0X9sLNxkUqej2r25gApBfRp7r8QhOV1QWnycQ2aa8CcW6bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTSJ4DEQZ1rlAIrW9LGVy1RJjj1BmzngUFmb3iC1gGY=;
 b=cUO+CY72vF5b1m4eoWF21JtI3DqsnYkKwRrxAhpgfL282aLsOpckR6nnmWt/txWfJoy3pXciSCgK/F7/tT395RNh7hEa+eeYZR4oeTHGdDZQiYUCb4aNrbMRk1rQnurHohFLiiMZMlVwFknqjLWNf//P4rMfqsaYEIpq/7v6+GXyGMYlq1xf9rhCVkavPB33LR6ndWH3X3aL1q57Ak1qbIjL9vQ8HekYelvOVx7cGIIvkzwGn8GZnV2XfD6w73u4KadtN9uNeFJVfXWFQ5/TDbzLy6j3Rlu/w5d75BThUVnGAyrOPawwXHgPTMkEOqiKvqAZAjENhzmQLssYfHj3lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTSJ4DEQZ1rlAIrW9LGVy1RJjj1BmzngUFmb3iC1gGY=;
 b=OGSBXEQXnvexg8X32kNnZob4Gt6av2YaCotuZgY/JfqwA2TWfXA4/GMFiwG1kNLhRJZHQs2ABMo9Pl0tWoYAWw/izvRwBmjd+C7rwHDumC+93c4FrtKYHfBaoEVXE3rNmaNlp8E8tIQRiwC7QYzNFmnTKn7HBd+G3VaJr+SNRIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AM0PR04MB6657.eurprd04.prod.outlook.com (2603:10a6:208:17a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 05:51:14 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b%4]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 05:51:13 +0000
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
Subject: [RFC PATCH HBK: 8/8] dm-crypt: consumer-app setting the flag-is_hbk
Date:   Tue,  6 Sep 2022 12:21:57 +0530
Message-Id: <20220906065157.10662-9-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220906065157.10662-1-pankaj.gupta@nxp.com>
References: <20220906065157.10662-1-pankaj.gupta@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7781a519-9edf-47e9-1acb-08da8fcbcec3
X-MS-TrafficTypeDiagnostic: AM0PR04MB6657:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qI6dBEa27cwGMKhSv1fAizGjZnEKFa+57IP4Q9YRVdpGoZcx2jNOlPu3YuRiXuVZ9ZNmL2sjKuV339Qloj6yl2hPeF9wvlxuy33lEKkRnMrZB8o/N4/SbYXkF8/gCsnCK9f6bCJgDkXu6msbygsAfQ7RIgIUHCTRMxBXRSktXa5QCtzoTT8vkL2oQPf/h4Bu6XQbRAcRPR+A0PfTv3MFl4yW4MR4erp+dapRKN2M7u2yIoFsKm38gOeOHYjBkpYhjxhD1+tsi854rkD1znVwWLSvKRxrOxvPawzWKHqn2eAE3HKZpBS0ojjyJo0fY4vzF6zh/dXGJsGMw/5KqyLnyXqIi0C4KID3NaHRSZ9dqFDklVIiGHM3b7nYE1WmypfA9l+vpLN44R4fjmOjJFbQByiPO72Kk1KBw+mIBqsIX+pJntaV/sIjNI9BYOLxtK+6zN/1JuTSOBFbwBH1CBHkP8Q8YcAfyxtWmgBkPzO93sWUN43Jx/fQ1cw8cTlFX2SqDTANQ1LOHxd8N/NqIxY9aD7vzc+fy58fA1ONKO+bIXCmPZqgGTnTsRTfPBlKeDOxr+4A3nweuqvnLqgKA8wtEe8wsdDcMrSBVV5JYH+BgZkQTM8W+awmxIucpuMpg8SqIrxY29qOJeGHsd3APsQ6waqv+NcieI6IBMbw+F5P06LziNA+rSN3J+yULb6N/94Gv6wJmPAWXmnKbEe+DvJke3mSBoKOk1e9k+jsJ4OlxttNXVAbslwqA5U8eMYiSGCePU3AlKsdvP4Q/m7ODl9fup2uSP9M8pbn4uL5Q55T3RVcn44VfDNUW2ET7YQNQwx1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(6486002)(6512007)(316002)(52116002)(6506007)(478600001)(6636002)(41300700001)(86362001)(26005)(6666004)(38350700002)(38100700002)(83380400001)(2616005)(186003)(921005)(1076003)(66556008)(66946007)(66476007)(36756003)(2906002)(8936002)(7416002)(8676002)(5660300002)(44832011)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KHkEF98PjKQ3JuUzBrhd3Zex2/taBCwMIUUeCS6bQUumOLBQ8JYK2ABX+oV2?=
 =?us-ascii?Q?My+Zdgfv55lGaU2DJMMCIpZEzA6+1M6EeYOGvFDgI4gJ709QW82ArtOyQXWd?=
 =?us-ascii?Q?NcFi70T4NYz5tMrNiPaDdI2iiOyeEC+jRz+5HY4+jM6s2iJ5auOGETEAxmqM?=
 =?us-ascii?Q?IDOoi9QSs3SDtJyuhVZRO+Q+4TNbFFaYMp806t5VoJCrA1yAIhE63S9SGdTR?=
 =?us-ascii?Q?m6mPF0fbAHctBdBRB0PgvTdtfbV8I+tqjz/XjFUQjQZg4BEezbtSv+QqBSyr?=
 =?us-ascii?Q?JZOoTnZD0pKELMjale/67X4Iego43BrXf4Iy8tFmIV+YvMDfUHMT7gFycmwG?=
 =?us-ascii?Q?9JSZBB9TElMZrirxaAA62leRJOxgHNBJjX5nCmlWCD8/d261EAHZYA4ON2X1?=
 =?us-ascii?Q?mF75AeA0Ks42sUW7NB6qpgvxT34KsRf4ExK75Hmo7LG93rfZxJF2c4Z9XFv0?=
 =?us-ascii?Q?9nE5BiDiD0Q77/zfEepfB8Qdc3SzsQJYNWYgLAElNbRy1a7D3AQOkrX+Rlm0?=
 =?us-ascii?Q?Uu5ot7gd6vb7F6CowTYK5ZTI9VeMtL6kbhcA8qxXPnH3yTkpiuUeRpckT687?=
 =?us-ascii?Q?G5isQtxDk16aG79WDVK2gTCIHVaoam8XeINnO/tFVvyBFUxG+1qINIfRrVXO?=
 =?us-ascii?Q?xAQoNTe7uJvb1pW9EffEn2bm5o2v8euwy238iRgewhuC2pD5xNW2OfisYlVx?=
 =?us-ascii?Q?3dmM2QS39flob6yei9QFARiaE0mj2zCQwxQtHOwyh/r2NvFfafa70s5UQZ8M?=
 =?us-ascii?Q?lfLgQXzJXTnxN8OVv5w0CJ9Z4DKRwDjbH+y14EiSY8U5hfm1d2QC7MuZmtmi?=
 =?us-ascii?Q?/HLZiyJxnwwOpce39Q6Gc1VQCNFPmePTmT6vV8qAVoc2Hkqs/5le/EYzaSde?=
 =?us-ascii?Q?de+FPbwObkHic8jLU3I2uDgm8BpkfUD2Bqo/w2sK6T4Pm2PNtmpap1uW3yYq?=
 =?us-ascii?Q?uRwV229woQ38s5X4Dqxj9tzh4YOYJ0+Us5T5+utRDf8Mj6cN6IWJKlYhURW7?=
 =?us-ascii?Q?EwdUO1j8Ru5dOffC1kpyeMmU/haKfjlnVZ2h3IYzc4vntEfF+miwpxad5t1D?=
 =?us-ascii?Q?y+tWw5A3eyNFJ3TzBMNsVZND38WAl3K4FoMAl/iwxlO76gi27Khz7J+A7g4G?=
 =?us-ascii?Q?veyE1NARuKvg8R1+9r0ITe+uPzexwqcN1IWl1i9tUtorSGhmNuCkx+1ZGgzz?=
 =?us-ascii?Q?NtEyX2QFjTHz00ZhM+LsUPav77zBSbiQRXoJ/CU4Tyq6GPrNCzS3X6j99kmQ?=
 =?us-ascii?Q?3aP82ldg6y42MddJmuwZ/mBgVjemyHzaT5wIlQYnM0/fb5J647nMghR1Ixaz?=
 =?us-ascii?Q?rtg0p9QhGjZ4oVcEJMNkxaBvQCq4M+RcpHoVVDAf0lONWsnUVY9pg6KIGgX3?=
 =?us-ascii?Q?Azk3h9HpjEKV/LXGyCJvozbjN5KDMgum79Sn8rUrY/iOg2btim+ntT7owDtr?=
 =?us-ascii?Q?t5e9XAjt4nM5M3lNGwnXF8Fl18WYDacFEHOScHtiMmoJnw625lv6P9+Iblal?=
 =?us-ascii?Q?xXukWgYoz1rFitZyC0YCzwXgdfRhmqKygpARcTheB2cxI/R0Ym4oS3Omonc1?=
 =?us-ascii?Q?WO3hWckutlaPM/K3LfzpDBHJF+YYWZCmzviVobIv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7781a519-9edf-47e9-1acb-08da8fcbcec3
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 05:51:13.8403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: je8949H6t1m4jndK2f6WV8PfEl+xlEpTMTOk0Q4/N/+mV45F7zA++PyRLNv5o/rJpO4lBrIIWFCKgtupb5IuIw==
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

Consumer application:
- Adding a flag 'is_hbk', in its "struct crypto_config".

- After fetching the keys, it is setting the above
  mentioned flag, based on the key fetched.
  -- Note: Supported for trusted keys only.

- After allocating the tfm, and before calling
  crypto_xxx_setkey(), setting the tfm flag 'is_hbk':
          cc->cipher_tfm.tfms[i]->base.is_hbk = cc->is_hbk;
  -- Note: Supported for symmetric-key ciphers only.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/md/dm-crypt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 159c6806c19b..12b400e06cbf 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -221,6 +221,7 @@ struct crypt_config {
 	struct mutex bio_alloc_lock;
 
 	u8 *authenc_key; /* space for keys in authenc() format (if used) */
+	unsigned int is_hbk;
 	u8 key[];
 };
 
@@ -2397,10 +2398,12 @@ static int crypt_setkey(struct crypt_config *cc)
 			r = crypto_aead_setkey(cc->cipher_tfm.tfms_aead[i],
 					       cc->key + (i * subkey_size),
 					       subkey_size);
-		else
+		else {
+			cc->cipher_tfm.tfms[i]->base.is_hbk = cc->is_hbk;
 			r = crypto_skcipher_setkey(cc->cipher_tfm.tfms[i],
 						   cc->key + (i * subkey_size),
 						   subkey_size);
+		}
 		if (r)
 			err = r;
 	}
@@ -2461,6 +2464,7 @@ static int set_key_trusted(struct crypt_config *cc, struct key *key)
 	if (!tkp)
 		return -EKEYREVOKED;
 
+	cc->is_hbk = tkp->is_hw_bound;
 	if (cc->key_size != tkp->key_len)
 		return -EINVAL;
 
-- 
2.17.1

