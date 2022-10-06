Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8A75F65B1
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Oct 2022 14:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiJFMFR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Oct 2022 08:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiJFMD6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Oct 2022 08:03:58 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10049.outbound.protection.outlook.com [40.107.1.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158E49DFA8;
        Thu,  6 Oct 2022 05:03:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIKhDFcdjxbYcM4HZCg9yRUru0yqJdZkHLAc4QASjnBbeB5dJ+Dip4n8oMDkSEWLdEhVXch0hHwLDvwBUOzLWDiQzyjrjByItTxjoV4eOedK71rOp2E6LHRMjlJz5zHRFJ+X9frg7yVO6gIe4HoWrlx1I6NmnVBci5yuvYA3vitoL0rwgXxrT6Q7XW5cLe9RbiKPH6e73w3cylVXBiYwdbmlS+JCGW2xIpgWvAo52/b7eHQXWsKRYYA3BELUCKrYzLAuJKlp7w2AlS3hYJnSqyu93+hQZHP8sUoTy40mfL93BjsSgYhaUqBBUqLrA0NJ+XhmdFrP2OJww2Ef+cv9EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJHKE1DoG8ShMStm76AC3w1I6ls2KmauOqjww3i9/Iw=;
 b=RWoFi0U0uNApGhCHkaYFmsqOm1I1CA3M87k9u6KbaHdsca66j6XZ94KMVDZmEF70AoYkPZiZsYJ/kCiHjs4vLK0gh0r983zzAtZk9X2tkwA6Eeh0oZ/WEspaNMoAp4d610fw3PQ6+ayHmChTGUz3BOl22s9+s1/N8OcLFY0x+y/pxupHmbwpfST4XTf3AtQXAqAh8OJJi3/xfDsRnG3P+WflQAq+0GW2k4c1FMHThy3SaFDLjJxbFGn8Hwkgy08FDZh3o9XbvOUKDgxxdzx9nLBbetroV7GDZZSbAwPxaMSeY8YUSvULqt4xpSaM555kPLPZ7ITeqNq6NEuLFBEbVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJHKE1DoG8ShMStm76AC3w1I6ls2KmauOqjww3i9/Iw=;
 b=E2NtCIQr+xLH/u1e4l9FfoO+kgtZGaadDhnJ0SOX5pzyYL46AawYhdFe/HJPFCNZamRhcIcfuIlEKCm1PF50S58y9kvt2B2xpwcrWJiSjKK0i2krEO4EVkrRo8Cc2hNJPBNPxG8Xp636N3Kq+kdRExSIVL2R8jIX+KU1FHKjmG8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS8PR04MB8245.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Thu, 6 Oct
 2022 12:03:47 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::d551:6af4:bca4:88ea]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::d551:6af4:bca4:88ea%7]) with mapi id 15.20.5676.032; Thu, 6 Oct 2022
 12:03:47 +0000
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
Subject: [PATCH v0 8/8] dm-crypt: consumer-app setting the flag-is_hbk
Date:   Thu,  6 Oct 2022 18:38:37 +0530
Message-Id: <20221006130837.17587-9-pankaj.gupta@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 85020fc1-a3f5-41d3-4e90-08daa792d30e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E1LcyNylw7fekofHUsQbu62g2DZE0H1l5k6FZtNAKWoEh3Jb5BWerTPgalhPIyTe2iLMuiGy3z39rHl9estqjbfXC+F+eLahPZQWswMaob8F3LPKiGtOTA2asDke26wzNl30h9tQi7ObshxVkCbuGOlmYxyMpcgHnasXPRnngI+6+ICj7W+KIMT6nEBHBDvrgyPfVsTpqi/BmVinJ5w+PHN358/likvqyxay72RE7D/L8y3yAn/dlMqPO4CSYEtp96sYKG+yQiIh1tXGB8roUB4wRnrwsSgpJcCW7RwGAKsw13jQDhB01iOsKaaGmlnSR4mN0mNy540VHVYCV6jfDw8iPXnmBga+3iUwgQ5FzBfEZZ1ZqRqgz3NZEo46S6+/3wg8w8Q3fwnVELeJte4Ljf5HIFmL+nBZgZFBAtQ4NyMTeGI0FxLhczWuwQ3ERVlAmKjUuu6IMIcEQGiUXNeoBr67wsfgdpQqe/plA+jNQOkQ/aFabdlJmIEcDtQuHFdY8SGwtbwmZgeWtiFmGc25uGkT0o5yRsEA3DdVDX4hJJ6e6cxmShwoXXrcbFpwCGJwu8xIvMDxMiadGxH18w5uy4y5rkGzMngjN2i52KKjxyohpkpC8yZBA7D6472PKOHxTQ23NqAK1TDvpMCbNQ03hAY0dPq3sBDY2B/H2uZXu0Y2j15LqkW4jS6UcV8UymdW0I8BSyDHoJOBCwoFZhHYYH9pxJuij8X9j5JQSEiRgE1EIOo/cA1RyOVsSdbt065hrpSgHxK5YrnCd6cz4+/rA1FCbDjYUNJleQ3VDHy576spofbknHyw/KAizQHikPPs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199015)(2616005)(186003)(83380400001)(1076003)(38100700002)(7416002)(38350700002)(921005)(5660300002)(44832011)(2906002)(8936002)(6666004)(6506007)(52116002)(6486002)(6512007)(41300700001)(478600001)(26005)(6636002)(8676002)(66476007)(66946007)(4326008)(66556008)(316002)(36756003)(86362001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cK3A61X15SvmEobr+R+H8VQcxWdjJaV0MYfdMmfF7nua+5B4tpfAcPKAPDza?=
 =?us-ascii?Q?pfv+VxXF7LVwlWTXK17sdx/GxbE9/9LMo91ntnH8Yc4rxndsuV1ryhqe4wVB?=
 =?us-ascii?Q?Na/igHz2YW1Q+QStKLbRpcctY/UJUft/x32521w+hKgZriZwRI/IuM0CPu90?=
 =?us-ascii?Q?wLLF83mQHs5wNDofik0c9ViLhXh9/sppxTopEJP+RPf0pFrmPwB1v0pwz5uG?=
 =?us-ascii?Q?dQ7zIUb5u7rCKLDAi2qwfjeku9PuCVqC728Db6BgWl/1DaOO3HwFpJa5IJOJ?=
 =?us-ascii?Q?oUAUaX5Q91z6ERLkNsM6VSQ16zK1BchsTJE7k2erTWMt2O4XsGCnBz/n1njm?=
 =?us-ascii?Q?LBGmosn3HLLbkIW+DF8eFw+PdEH1CWsKu9R96MYXsQqQwqX/ZfXX9zLCDDo1?=
 =?us-ascii?Q?janvK4MRkW7GRdXL58w2oBBLKOHo43Df4nLautxyQ2Dpc0s8irWscmi3p+pP?=
 =?us-ascii?Q?ybH49Sw2q+zrYQjsbDvyRdrwsBo7OW3O26dLlFTcRoOIHHB8n0WA6st+BQ2z?=
 =?us-ascii?Q?ggS3BN+laPUu+bqZZUu2Z+B7gBKRwek9au1Jo0EE8/hbEqHeQcUUIUqoJ0OT?=
 =?us-ascii?Q?P88pizX+jApmUh7DkuxpzVcHTAZ4v1QGk1HMP2+O1Uy3RxluYJiYIkMp+1Y8?=
 =?us-ascii?Q?5YyPovZ6SWYOzgjnD0JpBlcwYZbk7mltnC4Cf3Aa1+0Xi7uplTQtwi82ouV5?=
 =?us-ascii?Q?At/F7nwzS0YZqmhe9UI7h80TLltvLkQARmIYdyZ+GmSCGBp3Q6nV6wEOugKv?=
 =?us-ascii?Q?RXcXbKSnTAKVm+dd5RP22HmZ+ek/kEeku5E9C0KaKxQcLHmsAunLw0n6gd6g?=
 =?us-ascii?Q?eVwUVHuDjYS2DH3O4oca/+VHOXr+iXwSFqscFRiRAhIjLI4JZhOKs8PJtISZ?=
 =?us-ascii?Q?POQsGiUWOjMpj9gMBoUZ0u+6a2xDz8IjO3mOp9tmAHjkT4jaeWProUcRQ5wz?=
 =?us-ascii?Q?mFI6k5lt4eUbLQkgLVKmsqYQdKf8IHlemqz9zSzbWPA+lx3qOVg1FIg5ReoU?=
 =?us-ascii?Q?3TBSa1UhQ9RdrpeRilRG62WYVcwNdV9PHrjjZMRCoBe91YNLAkNFWxGEzCE7?=
 =?us-ascii?Q?eZXPGu2wn4xF0lUKiJh9fTVIFXwPjt4SwsvS62uSxFo2/hMM2y7N/19hq10r?=
 =?us-ascii?Q?PhNfxlGvxEbfjCBNriKoUOCFVW6mSX1mmVduS5PWZRsY6TvVOHHo1nlIiD+j?=
 =?us-ascii?Q?dTC1w3ovFHsmc7pCL/NJvd+6s5zuM0bFsEMLEX9GDmrffmRdLzNiH4yfz6v2?=
 =?us-ascii?Q?vlGVfE6f5OcxAydGMd901pi3KQ4qGLkqsgp1ENFdn5kKVQnD1uV5sjKMgyNZ?=
 =?us-ascii?Q?VTgttCksqNanaqbi24ToIWBVgYxH6avHHUlQ1RYuqbD5Df7vHqhUhbxAfOBJ?=
 =?us-ascii?Q?KMuqTNwcWchZPurEBBRi6W0stZXnWqQBl0jH8fm4LsgCPHCzQOP3R9ByGsmF?=
 =?us-ascii?Q?AfJxwj6Wr6DUvGBUgFfCIju5jeViYIZ3RXoe3T7HZxANBsU+Az/RUZW2vFqh?=
 =?us-ascii?Q?wK7y418qUB6tqjNMO4cpxFlcxwBXp/knUBpbe3YuJExeBMrQmFJzxh6c0x+z?=
 =?us-ascii?Q?3Tl8yNk7HPut6Pgvg6/PSkBmdbVOta8xYboER4wA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85020fc1-a3f5-41d3-4e90-08daa792d30e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 12:03:47.7464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: noNZ/HZSnaYX+SLssiqhN3yULnVd9dy0eTPuDiqb/aPJDQBLJ9+vwuNeAnHC3Xfg3AdWWOIYeGAHFqXJblhgUw==
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

Consumer application:
- Adding a flag 'is_hbk', in its "struct crypto_config".

- After fetching the keys, it is setting the above
  mentioned flag, based on the key fetched.
  -- Note: Supported for trusted keys only.

- After allocating the tfm, and before calling
  crypto_xxx_setkey(), setting the:
  -- tfm flag 'is_hbk':
          cc->cipher_tfm.tfms[i]->base.is_hbk = cc->is_hbk;
  -- tfm hbk_info, if cc->is_hbk, is non-zero.

  Note: HBK Supported for symmetric-key ciphers only.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/md/dm-crypt.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 159c6806c19b..d28c4af2904e 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -221,6 +221,8 @@ struct crypt_config {
 	struct mutex bio_alloc_lock;
 
 	u8 *authenc_key; /* space for keys in authenc() format (if used) */
+	unsigned int is_hbk;
+	struct hw_bound_key_info hbk_info;
 	u8 key[];
 };
 
@@ -2397,10 +2399,16 @@ static int crypt_setkey(struct crypt_config *cc)
 			r = crypto_aead_setkey(cc->cipher_tfm.tfms_aead[i],
 					       cc->key + (i * subkey_size),
 					       subkey_size);
-		else
+		else {
+			cc->cipher_tfm.tfms[i]->base.is_hbk = cc->is_hbk;
+			if (cc->is_hbk)
+				memcpy(&(cc->cipher_tfm.tfms[i]->base.hbk_info),
+				       &(cc->hbk_info),
+				       sizeof(struct hw_bound_key_info));
 			r = crypto_skcipher_setkey(cc->cipher_tfm.tfms[i],
 						   cc->key + (i * subkey_size),
 						   subkey_size);
+		}
 		if (r)
 			err = r;
 	}
@@ -2461,9 +2469,11 @@ static int set_key_trusted(struct crypt_config *cc, struct key *key)
 	if (!tkp)
 		return -EKEYREVOKED;
 
+	cc->is_hbk = tkp->is_hw_bound;
 	if (cc->key_size != tkp->key_len)
 		return -EINVAL;
 
+	memcpy(&(cc->hbk_info), &(tkp->hbk_info), sizeof(struct hw_bound_key_info));
 	memcpy(cc->key, tkp->key, cc->key_size);
 
 	return 0;
-- 
2.17.1

