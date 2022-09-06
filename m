Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE105ADF0C
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Sep 2022 07:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiIFFub (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Sep 2022 01:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbiIFFua (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Sep 2022 01:50:30 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8841533417;
        Mon,  5 Sep 2022 22:50:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/Ju5byC8jP7tnuhUtJeJMVxB39bJbv/kemE7txtBnDxbmrk+kTqUUdwW4NTJbJ4eXZfJqIiF0zXVg7EFqdobjUg+kjeI+USH4i/7G7pkTbriYoA5Nso2281bhkmJCiv2YFg6T1YzaZtSdru7OcHCTmiXq+bQZVfbFZ6mhtZK1/knQJlEy830hx8OUiXZCvG+lNpXnwqKZU+Sf+K8FR6GRzZw6/UqeTst5zX1MgkQcfjYUijsO2wYu9pbFFL6VUmOFmTjmceLD/Hpqrx0MNv3L1zPSMdRUR6wH7LnHCYufk1BsEJatfhYrxkkKOG2kApH+noIq3xIGCEo/W18LqLvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCssSUe6dhxjhUcSJEQkYkqaKfP+0IaIM6k08ekogHs=;
 b=MCuaiPiMeSx9OlEJz71vZqlaKs5Bbekn/qRgd1fmSBJvHgVhxXZDm89H8ioEHhLes047hVznMPglmjNVEIn446YdcPrlYjNNbzBW40AibniuJxCatEpQ7n6Bft9/Tk7MC01GFEBusRpqcxtUOS1SuCd6S6dcvzWCFc/75Ey9h6Y0DfsNz3w33A8UUMDWjUB0yAPjpJaz1rlQZjmbXYToQizwq/rE1Avuo1OYqODzxrz8AAuttKPwlsUq69eewkuIbINPQ9+WYrf0aZKtwpinr3Q6jqD99I+4usG9JLHmsahnLi+jiF2kBOjFNiJdi8xJnpvB6MZtNf9tZotuhlZVag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCssSUe6dhxjhUcSJEQkYkqaKfP+0IaIM6k08ekogHs=;
 b=SvO2ZggzCrVoYv/38LXdwi+OUNABakNF2Q393DlQ+EqYNPMbsPdpy7JeIozCah9E3Dgr5nTRz7nvtQM0jh+WYfhX0TPVChaaucW/c3oQPtIMJASRL2+pSTk+MqK48ZST59G8Frqsyb9Kx7NwAjr2m9SAAhylSU+EJqsD043hG3o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AM0PR04MB6657.eurprd04.prod.outlook.com (2603:10a6:208:17a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 05:50:15 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b%4]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 05:50:14 +0000
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
Subject: [RFC PATCH HBK: 0/8] HW BOUND KEY as TRUSTED KEY
Date:   Tue,  6 Sep 2022 12:21:49 +0530
Message-Id: <20220906065157.10662-1-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 565cf064-7ba7-447f-7971-08da8fcbab3d
X-MS-TrafficTypeDiagnostic: AM0PR04MB6657:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G92UkA3ki4GzhO4o2e1THeyVGHJAYtcAqof8ocrP7+u63v77rKVP5Y9lEazHGni13dYBrv9CNNYuTSnTT7+b/g0PGed0HQkucg8AxlcmqlZrcoEsrz/wlHXZRTuZ1AnPabpXlEGuO/14dfpqsKF1sIa/zUbSWa5nQHgmnM56kDuBQBg9k3Cfm5Nzdgcyzsfzy7BBQyELzBA9bsLKo+a4FNuoMUFfwI97TY7kXb0n8HV/ay4IHfXQ1YeP5KmhdycE2Idilr1VXALzaVKMNdV/IuvQiD18RXNlM5il7iODqKGJ9yCNeS9f6qigNrfP9S7vU/l9ORtGAKt3ZBZUl8zEupRmQkXWbOIjAOTgjxJDqKnTbfZeeBgHOfSYHAyWWQFaYle+CVc3UkO+KRxAABowxG7FHHnGfrpDJGnH7xvFEPh8flJ9Z6TA4bgA7IF9E/BysWubj3Xawpfews9e/oDZD/7ISydQKz72vOm2dCqDs/5r9TcGW6IR3Xh+aUDTUf6G7DlsfqRBPjiLDKIXND8qOzpImtmHx7rNJUZvJdK24BpAqRBDJoye8xzuodDE+0Re4hh2QiuLhEQFCItswnFI+d46zdJqDgCPEoIdkio2E5ekL5TMmDtPSBrpww8/oq2yoJTtMLwp3lj0bToYNX5xtTutWkEhgs40lne5aQgZ4c7VAlGwZnyIWoAfQr2dmPyjnxgf681wy/otDtpkHWhSiPKFely60giK8RoCt5EwNYIFhZxsdWG3Y8d2rf+aGtbPP1Tk2acNGSB5PFkT9RQJNYnD53PaGdx05wZqljej59VFmFszJUyWgbvV9cWCzaHA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(6486002)(6512007)(316002)(52116002)(6506007)(478600001)(6636002)(41300700001)(86362001)(26005)(6666004)(38350700002)(38100700002)(83380400001)(2616005)(186003)(921005)(1076003)(66556008)(66946007)(66476007)(36756003)(2906002)(8936002)(7416002)(8676002)(5660300002)(44832011)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8bjqRj4JrnnwTFNOsC1CoGy5h/BBzndA8iOxPbV8eSkRzWeuw1OlKX5vubqV?=
 =?us-ascii?Q?fxVPzJwl7Q/LaghF9URNzHEFF4o4oKMp2dcOSl7iEV8cW4ycW4frzxyt1bn2?=
 =?us-ascii?Q?6zWAt1SL9Qnp94SxxFY8R2EjGdCGcW7so36ej4L+0wRAnde2NUzht9OpuMwh?=
 =?us-ascii?Q?eGrI2ognrAkBu+j9lP9a6mnppHyFgPqlWSCv8BBnm+7u6+yOmJw6tTU8hVd0?=
 =?us-ascii?Q?HcPR8xpeqdsWp8gvyMbZRmqUCO4WdsAuLl0pfEURBOToRUIXjMrvNgfJAYFY?=
 =?us-ascii?Q?YpT78yH2LHgcnjMUAT0euNMqyYBiLVwWR/qQO64Ht2/eHJLtXR7chMCD0cha?=
 =?us-ascii?Q?2POAMPpgDtRf+ARpklO5M+2DkIsCyeTUT2xKAj75u2UlvzhE2RKdfUIMcA24?=
 =?us-ascii?Q?e0g73z9WwW47OxJA2mVCiO0iYv5b/Prn9xXZlrjhsF3v8Kyjl1KOywhB9Fva?=
 =?us-ascii?Q?MymXWspf4DnTMcpPZRU1i9+QcKULqZc0OtkmcNkBldgNt2rxsvSbZWKfU3xW?=
 =?us-ascii?Q?kh/BxTjZJx/HqO1D8pfXaqAqlJsjCJ8lCeQPVSiYcSTE4pq5zCH4YxzeXYTF?=
 =?us-ascii?Q?96gRZ1tqF5DuoTcx+m3V2spnyp8IO8hRUzh77IxCv33o8T0zDP7VUxfuKwdX?=
 =?us-ascii?Q?Muqxg79YnosFeTvUE+0HzuVWMpiUNGvtSHgx5TCfWgwnaAr68onmDZYOZjQI?=
 =?us-ascii?Q?xyQPmysuAYvYqHhYNE9WjsQCZBQIvn+SlxhFL5mq2kxnOUMSgOcbD3+s7Pz1?=
 =?us-ascii?Q?/xc/I5KKqqVJT0fjT+CB5KLIGILkMLY/5S6Y8rheQtGgd6QFds7/A3rb6g6V?=
 =?us-ascii?Q?CJvdy+vmXEPU5IG9EUsXJABDEMgq/FlmauCNdBTuboPB12hq64EDpyfNfZ+B?=
 =?us-ascii?Q?scQpPySi59d+NTdrlsDCIqXwaDP8jxRW4NhN+oUKO5HZlUj6zaRvIoOAs16G?=
 =?us-ascii?Q?aKEVZ1r7F834PLYaZRn8yO0Z9zHYrnvBD52T22hEIVMwpco6BSSx1ywbN56d?=
 =?us-ascii?Q?x0pRnkZBmZFhoghdAKzos7K+ai+NGlaiRvMmxognjg8N3yZWiqoR7gB0XnhL?=
 =?us-ascii?Q?2OrOD5/JDc8ZOAROMwVRI80bZjlf0DiluB0V6u8qdB+SiP7pUfJY5mO5qGdM?=
 =?us-ascii?Q?i+Co6jqI6mLiSxnfYPQg5rRgmNBvVG6ZeqvXaI2ICEY7z0RZZ9C/lqG52PY+?=
 =?us-ascii?Q?My2oGnJBHNMuIimafEx4vpxWNYvTHtrYzfq2k+9aorypb8xQcpd52FZ8nzU0?=
 =?us-ascii?Q?lxyXhWHoo/NhtS48Jq07bo04oAp+P6OA0kR1paNVFeT0Q9t+SGJiKf9FjfjA?=
 =?us-ascii?Q?TnWyLnq4h3Qjap8dXuvgFISdk6Jdx+u11DGVrIfPcKa9/IC6grm3aKGKZuM0?=
 =?us-ascii?Q?98TBr4IpEdF+Vpr3dNItmMsU3mkT3CKQkmaa6f4063naiuYceT2DhwTJTy0f?=
 =?us-ascii?Q?09QGk56BGlzSiCqWyop3xdPIwxTppBPvyxuRx3XDcweeYSJWnpGAm0veHEv5?=
 =?us-ascii?Q?c9qmPW2JwUgcTwxfkZRuNUe5OdZ6dX3CXRCQxIv+/wwOo+bX4nhvIhIa/2Zj?=
 =?us-ascii?Q?cKgoWS5t6XKFBBU0tRYHy/cVmvF4PAyOYMsr67NK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 565cf064-7ba7-447f-7971-08da8fcbab3d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 05:50:14.4464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjtCCEAmuxht0Rv57mbFl8fwDRM/W0VsY3Qt9jCAgQ5zWkIZ0HAs6Bv4+rZuQ1ld+B3QY8ciqR2ve/iPTRnrOw==
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

Hardware Bound key(HBK), is never acessible as plain key outside of the
hardware boundary. Thus, it is un-usable, even if somehow fetched
from kernel memory. It ensures run-time security.

This patchset adds generic support for classing the Hardware Bound Key,
based on:

- Newly added flag-'is_hbk', added to the tfm.

  Consumer of the kernel crypto api, after allocating
  the transformation, sets this flag based on the basis
  of the type of key consumer has.

- This helps to influence the core processing logic
  for the encapsulated algorithm.

- This flag is set by the consumer after allocating
  the tfm and before calling the function crypto_xxx_setkey().

First implementation is based on CAAM.

NXP built CAAM IP is the Cryptographic Acceleration and Assurance Module.
This is contain by the i.MX and QorIQ SoCs by NXP.

CAAM is a suitable backend (source) for kernel trusted keys.
This backend source can be used for run-time security as well
by generating the hardware bound key.

Along with plain key, the CAAM generates black key. A black key is an
encrypted key, which can only be decrypted inside CAAM. Hence, CAAM's
black key can only be used by CAAM. Thus it is declared as a hardware bound key.

Pankaj Gupta (8):
  keys-trusted: new cmd line option added
  hw-bound-key: flag-is_hbk added to the tfm
  sk_cipher: checking for hw bound operation
  keys-trusted: re-factored caam based trusted key
  caam blob-gen: moving blob_priv to caam_drv_private
  KEYS: trusted: caam based black key
  caam alg: symmetric key ciphers are updated
  dm-crypt: consumer-app setting the flag-is_hbk

 crypto/skcipher.c                         |   3 +-
 drivers/crypto/caam/blob_gen.c            | 242 ++++++++++++++++++++--
 drivers/crypto/caam/caamalg.c             |  37 +++-
 drivers/crypto/caam/caamalg_desc.c        |   8 +-
 drivers/crypto/caam/desc.h                |   8 +-
 drivers/crypto/caam/desc_constr.h         |   6 +-
 drivers/crypto/caam/intern.h              |   6 +-
 drivers/md/dm-crypt.c                     |   6 +-
 include/keys/trusted-type.h               |   2 +
 include/linux/crypto.h                    |   2 +
 include/soc/fsl/caam-blob.h               |  44 ++--
 security/keys/trusted-keys/trusted_caam.c |   6 +
 security/keys/trusted-keys/trusted_core.c |  14 ++
 13 files changed, 333 insertions(+), 51 deletions(-)

-- 
2.17.1

