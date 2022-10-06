Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47D15F6585
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Oct 2022 14:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiJFMCx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Oct 2022 08:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiJFMCw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Oct 2022 08:02:52 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130054.outbound.protection.outlook.com [40.107.13.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4AE9DFAB;
        Thu,  6 Oct 2022 05:02:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pe1IFClc0y8G8EVioRm7V5+Kn+EILUxYKx1LZRef6F9DCOGTJ/f8YV38eCPqX2yksv9ML2dC9JJ8QMTGJrWhQa5dCJvjdov8tjSl3ifwZEysUx9Hw1Ai1mGzgT9+l4K7SVzpz6nVXUic7ZeBOlHEpFLp4BvghohC5ZJTMJhAahvCi8CUkgX+c4v1jrWSo+3WFRZUVtdItPUVrRR7HycirsVCsFzgKBbm7Yl7SMPuJoc5o8luD65KVoosT9rR8xknVa+1N/LOFf1Eu5H9NqQBBXfcNgm+REJJ/OgPpbBnxhMSYRnLnba2QDyKIhcso7N79FkRUc9OxGohXieF8eZKpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mkMP5F83kXf4WhXlGerUWx7J3LD5XE2oRNb/0WC+yc=;
 b=IEF5Sdy1SGt1uFvce/NRjM0st4gCP4Z/gCzsNgDnubmlTLqwhQCV4GJyHp1bLWgVVHDaCfZmbkR3IrFN/X4F5BI4fsyoaPcMzAiswtTME8EvwAPueGQtA9KrbYCbQBdCRiznDg3u7DRhUdA4n9zpECMPfVGEIzGLyGVXPcSRFQf9ul2MNq82nvVnVI1//lD0Gq7n3T1EY5qk23KidoP607sGGt+eHtcALEbR6qiwp2SyGxRBng5VXnCoup7PmEqWeNH78nUUpmCb2u2mTvHcLolUBOZdtSs2oG6LmTfB044DIzHVj5CBxprH59C4S3QPriW1W891st8Z2iIeCqfCSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mkMP5F83kXf4WhXlGerUWx7J3LD5XE2oRNb/0WC+yc=;
 b=VbNK5xwpf4I1+iRFIUzR2u8kKoPc2UZTZw0cEXhkxJBcRB+3+ThxOR3xdzDbo80azT01DMRbz6Hcq5d6fCKx6rkJDu+/5WWPEM7o5e+FkvcTFi1xJkiKgMSeIkhZcgxJnYJPl1Ehkcrq2zEDX17RWtOapEwgns+lvE1Mvq4l+zI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by VI1PR04MB7008.eurprd04.prod.outlook.com (2603:10a6:803:13b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 12:02:45 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::d551:6af4:bca4:88ea]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::d551:6af4:bca4:88ea%7]) with mapi id 15.20.5676.032; Thu, 6 Oct 2022
 12:02:45 +0000
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
Subject: [PATCH v0 0/8] Hardware Bound key added to Trusted Key-Ring
Date:   Thu,  6 Oct 2022 18:38:29 +0530
Message-Id: <20221006130837.17587-1-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|VI1PR04MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: fda89363-1bf2-4e84-02c8-08daa792adc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wmqhgyUAmJZyKpkJ5xRYEXXi7WMX1LMuA5FCKgi/YgeSgHtluqmo2cfV/k3KLQ/f8RdE6kzIBZiwL7y0/E2CxQAGVyqgkbH1bVh/Z78/ut2dTNWEhbpTvyNm2l4AKGv7Gg2ohz7EHlQAdMIgpWt/75pMoLaQh52ZHAMNsFebdd9Fx2AnXRAEsbXNBWl7RGEE5mVPreoPHHsmYhLvdHYht2bXqw5mOaQQ2V35dq4ZIINZTn28fYXr+8qr/TK+WH07ygVwNqGq1YWENz8CHpxpGrNFI5Bw2F5SbezmvORDMslNGn4JQdb1OrcZ9oQA2jnKTqB5MJSxccXwNWZ+TtBET5Wee4OD2CcqNFkif2ULdnIwIsgZEd6n/XRRWo8wC8440g0lKrugmTH4vcMpD4CotjifCkLUq7kg+JAg5FMtqylUXH8nXEIRc48y37rzCag3udpTmSIvSZGW9NJAEK+Skj9OWf1knO2FfiksTw41NNh2jgyuLAltRlP/o03yieeErLvE0G7eE8xIaJFmj2arTwbba+dkA5W2w+qiS9ab/jRgwFTg0xpLWA9CO5Nuf/A3sVlFumer8fKjnawiUc/NsHMEu84vAt8Z1LyQ9ExTyKc38dCCNd2t9fMycCQJmrzWNOC8LKnqr4BfZ2hYTdcEK7sO4p5ffhaid6arqncx8W5vwab2jdJAyEEHNRUWOHSPV0JL3okDpIly071DGaiDzUPq4TGGz74+oQG1t7oJwOOxyn3aAVOYd6RDpljMkEUIXBtnKgX6M9EPgdeIkw4WVdPTiKuTRVPx7X1mnAFtaiU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199015)(2906002)(52116002)(26005)(6512007)(6666004)(7416002)(41300700001)(36756003)(478600001)(38350700002)(6486002)(38100700002)(86362001)(8936002)(5660300002)(921005)(2616005)(186003)(44832011)(1076003)(83380400001)(6506007)(316002)(66556008)(66946007)(66476007)(6636002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F/LKeZZdP6VmW+zpFYz9aGjoohBnk751z+cfO7V0RYe9dhAxvVp90jWsXgGT?=
 =?us-ascii?Q?ikf/A60OF/C/CR3Dz73+Bt/CqlPa4wqUscjM/NtQGas/q6m/AIg5D2JTafZ/?=
 =?us-ascii?Q?HG3N6a6tksE25/V8KzcWSsbyf/Dz9uRieVAG1FtQcg4L1gy8YwdaIx216sRH?=
 =?us-ascii?Q?OrvtD22NGF9SNnHdGYQWALhHWrhAHp8u4DLSNdk5P50aYJSDADkaORUN1kYh?=
 =?us-ascii?Q?7xKJb702Vwpvvvp4jGay9OLiESi487rznijyR2SWamSViviBHY60bXE55Ir6?=
 =?us-ascii?Q?B6/pbFWdRSzUUuEanOZOkBM1mQU3mDYiv9ODxvJu3who6+eV5FiRDXDlgz05?=
 =?us-ascii?Q?EQ3Qtoh4QzCoT+AewjeUEOjhGk6oLM8ODB+iorIZ0hevpozbU5lmVHKHXm8Z?=
 =?us-ascii?Q?n9f8qzwKrRkijIIreKXVfBwNxqgYRBfXA5AAzES36cEhcRmgfcFYjzZYhqeo?=
 =?us-ascii?Q?WBEuFkO8GFAzv6XOORTYUV/0DpveCy6dvp796lj2Emro0H/rPJ9dIuU6zaTn?=
 =?us-ascii?Q?ih8TlmGajDZZjX7uJu4Og4h3Ich5FP62eRZ8dH6E8iDBTyOSxSYA0Sn0MeyL?=
 =?us-ascii?Q?0u41N+FZYS1REnnzol8Jglx3yK3Dx3fYW0h3GVxRjlIpEj/OQOEKPlBOjW9q?=
 =?us-ascii?Q?aKkj1zAvHKwK4TQiOXRK3D0UJOkOdNKRkH5zdVDwcfEystRFCcFbmhM8kwzd?=
 =?us-ascii?Q?U1JvYwJl5G7EwDRuf5QUZdm2CXkxAbWoyVi22ufUb5FRSHDBsy+8WDJZG441?=
 =?us-ascii?Q?vZvkbM1JkrJ5Yk6cIrdDFzSrAJjLPOdcWm/KCDJbpfZuAcU2sgqdv448L7zp?=
 =?us-ascii?Q?iu4dHwE9PQO1Gcx3XTVuTxtG0KJVMyuUvjE7ylgJ1tqV/sX0L/6PgWqqMYpw?=
 =?us-ascii?Q?i9MY1sh4YDcTiWGxwbhPaIJ08WMqGPync0kID3jqSDq5EWE5EI/ut9mkjdNH?=
 =?us-ascii?Q?p5JJeLIg2xuHuvjhCI8OyRZvXZI8VaUb9IDYZfxpJMekU3wLpBi/ZMZJUK1h?=
 =?us-ascii?Q?a2nB7KUOUoywIBe5Ei3uwwxLfYOzz6LgUHY9C4SLsqCFmsBDQhRwsA39vzGS?=
 =?us-ascii?Q?xv3av9gjychR+84nfkHB0komvD8w0X/0NmgFRibW3Wto30Tc8VSDzVV/Zx7y?=
 =?us-ascii?Q?d87VIi6tbKVFsEmnP66qDvWvgrfTgggaaHM12s5QWULlgXrDRV4ktq+Hp6mn?=
 =?us-ascii?Q?Ou8VxjyIaoCI6MVjb65LvUJ/XMgSXZpsMVVDulBmxpVrAQoHp8zEV+f9N7MS?=
 =?us-ascii?Q?G0Oj5LtCen6F1u+O6kkuuRqlhlbRQxUOMvqMiP8dBCZtBubJ1EtVpHYSLvIl?=
 =?us-ascii?Q?QL2+18Gbci6QB60A0bZSJU6myb71cb6z4S6jh2a41D5N2y3Y2iyC/RXAYk2D?=
 =?us-ascii?Q?g7GZWbS8J+Jk54QxO9At94NY8K3sT+27QOkflMWBsMEq5zMbJba9KcaNuI94?=
 =?us-ascii?Q?x9oYuAH4FUSv+bxyDmpEFCN2NT73dfKYX0i4iDPLg/rn53EAMROu8wiYSUsA?=
 =?us-ascii?Q?PEZauBZ/wZ96/P+i8emToZYREvTyhPS1uJV/y3GTh38bpG1AcHFyZ1Kj5zKz?=
 =?us-ascii?Q?pzV/EvNX5N6D+nOqC8VjBFVIUHwkabv4xbsyYtHo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda89363-1bf2-4e84-02c8-08daa792adc2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 12:02:45.1252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VTB4D7N13tcjDVQz0Y9aWCZwmfSS4H3B711RJ1cYtNBgavLkcYYKq7WPV2WrotDP4NeiBaH0EdTuprLyWsymgg==
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

Hardware Bound key(HBK), is never available as a plain key buffer outside of the hardware boundary.
Thus, it is un-usable, even if somehow fetched from kernel memory.
It ensures run-time security.

This patchset establishes a generic bridge between HBK & the kernel's trusted-keyring.
This patchset adds generic support for identifying if the key is HBK.

Note: Copy-paste this text-based block diagram to notepad, for better
clarity.
                      +---------------+
                      |               |
                      |    keyctl     |
                      |               |
                      +-------+-------+
                              |
                              |
      +-----------------------+-------------------------+
      |                trusted keyring                  |
      |                               +---------------+ |
      |   +-----------------+         |trusted-key    | |
      |   |                 |-------->|payload (plain)| |
      |   |                 |         +---------------+ |
      |-->| trusted key     |         +---------------+ |
      |   | source as CAAM  |-------->|  trusted-key  | |
      |   +-----------------+         |  payload (HBK)| |
      |                               +-------^-------+ |
      +---------------------------------------|---------+
                                              |
                                              |
                                              |
 +----------------+  crypt_alloc_tfms +-------|------------------+
 | Kernel         |<------------------|        DM-Crypt          |
 | Crypto-API     |                   | +---------------------+  |
 |                |------------------>| |struct crypto_tfm:   |  |
 +----------------+  crypto_tfm(HBK)  | |- flag-is_hbk        |  |
                                      | |- struct-hbk_info,   |  |
                                      | |is copied from the   |  |
                                      | |tkp structure        |  |
                                      | +---------------------+  |
                                      +------------|-------------+
                                                   |
                                                   |
                                                   |crypto_tfm(HBK)
                                                   |
                                   +---------------|--------------+
                                   | Hardware crypto driver       |
                                   |                              |
                                   | Processing the incoming      |
                                   | key based on the flag        |
                                   | - as plain key, if is_hbk = 0|
                                   | - as HBK, if is_hbk = 1      |
                                   +------------------------------+

Major additions done: (in brief)

- Newly added:
  -- flag-'is_hbk', and
  -- struct hw_bound_key_info hbk_info,
  added to the structures - tfm & trusted key payload.

- Enhanced the 'keyctl' command to generate the hardware bound key
  as trusted key.
  -- at the time of generating the HBK, the values: 'flag - is_hbk'
     & structure 'hbk_info', in the trusted key payload, is set by
     the hw driver, generating or loading the key in the trusted
     key-ring.

- Applications like dm-crypt,
  -- first fetch the key from trusted key-ring. As part of doing this,
     application retains the values of: 'flag - is_hbk' & structure 'hbk_info'.

  -- to use kernel crypto api, after allocating the transformation,
     application sets the 'flag - is_hbk' & structure 'hbk_info', 
     to the tfm allocated from crypto_alloc_tfm().

- Newly added information to tfm, helps to influence the core processing logic
  for the encapsulated algorithm.

First implementation is based on CAAM.

NXP built CAAM IP is the Cryptographic Acceleration and Assurance Module.
This is contain by the i.MX and QorIQ SoCs by NXP.

CAAM is a suitable backend (source) for kernel trusted keys.
This backend source can be used for run-time security as well by generating the hardware bound key.

Along with plain key, the CAAM generates black key. A black key is an encrypted key, which can only be decrypted inside CAAM.
Hence, CAAM's black key can only be used by CAAM. Thus it is declared as a hardware bound key.

Pankaj Gupta (8):
  hw-bound-key: introducing the generic structure
  keys-trusted: new cmd line option added
  crypto: hbk flags & info added to the tfm
  sk_cipher: checking for hw bound operation
  keys-trusted: re-factored caam based trusted key
  KEYS: trusted: caam based black key
  caam alg: symmetric key ciphers are updated
  dm-crypt: consumer-app setting the flag-is_hbk

 crypto/skcipher.c                         |   3 +-
 drivers/crypto/caam/blob_gen.c            | 221 ++++++++++++++++++++--
 drivers/crypto/caam/caamalg.c             |  43 ++++-
 drivers/crypto/caam/caamalg_desc.c        |   8 +-
 drivers/crypto/caam/desc.h                |   8 +-
 drivers/crypto/caam/desc_constr.h         |   6 +-
 drivers/md/dm-crypt.c                     |  12 +-
 include/keys/trusted-type.h               |   4 +
 include/linux/crypto.h                    |   5 +
 include/linux/hw_bound_key.h              |  27 +++
 include/soc/fsl/caam-blob.h               |  38 ++--
 security/keys/trusted-keys/trusted_caam.c |   8 +
 security/keys/trusted-keys/trusted_core.c |  16 ++
 13 files changed, 356 insertions(+), 43 deletions(-)
 create mode 100644 include/linux/hw_bound_key.h

-- 
2.17.1

