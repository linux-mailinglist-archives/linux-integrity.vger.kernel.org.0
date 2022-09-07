Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478955AFD51
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Sep 2022 09:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiIGHWx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Sep 2022 03:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiIGHWu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Sep 2022 03:22:50 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20060.outbound.protection.outlook.com [40.107.2.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260CB94EEA;
        Wed,  7 Sep 2022 00:22:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDABO90MuB+Pm7a7aiwvVFBOqBTICJAS6zJZ0s6cHZofp6ryXvlneOmUS4a1Lilkt1nUUixbcbGIpnXyrU/TPKZhPXSchpsvR32VW/n1zpMVXiMfGr766tgGW6Db5SDYIV9/uW6mFmV36v6t08WiywBjqwn4v0JYS2s2VcBZccvvhJh73U/Hnmwdqrxm+dOw7JlUd8KFFsSbKC00bWpHdJjWlsVH7jTXqlKdYTjzcVsSBxq9FEue0sVgMmfm5ahxBxuFbFkQ9blTgGMzmy5KO1xskVZ3qPf5p01kiwm+/NSWN2g2mL3OKZOwARqE0bIWQH8I99jRH4MJWUSChAUlDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8aU/8kazmI8Bw8c1yVKZvGtCKDX595BIAtiMYh95GdA=;
 b=HYQUBJUnWsUM0CK0ULnm59xTKo+AldtYYkczW0UI5l+ecZ7aZrAx+0/w6tgeDvPlkc2g9Y8BlTao139BbsLt9HOgF1lNdSB7IBvGOV8tJxe5dScaPlWU71ZJWpQOyKVuDxtWDstYuTcQMo+oJtpuuVjgibKEKqWXHkHTJNgUpQgUILXKSdVq0tJ1L+oQiuI19yOb/ePbnt+vkkAgLM7USnZBapGyVnVVehfrvTs1aH8zsnknMq3IPcmf7jAWRRclpkw5EWYBA2mHm55iL10iiptOEoc90ikf00Ep9ccZQuBo7VjP/ifkJy+Ph8eB/L0feTTuX343Sk9zP4QsZwYwzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8aU/8kazmI8Bw8c1yVKZvGtCKDX595BIAtiMYh95GdA=;
 b=N1K2d/4hMzb0hdMBAXf/WcDhM0jW175zYqVOTbGIwUQsFuh4SrQYKF3Kyg9IW5aofppPJ+E63eBNPZ1mnzu/lQHGQI2z9vbPCTvtTkbF0XNYiPjD4ZAI6i3yptA7O63md4QL0dqj28zvBxE5NybvtdwR2DohZzD3S0cWXhFAgZo=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by DBBPR04MB7770.eurprd04.prod.outlook.com (2603:10a6:10:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 7 Sep
 2022 07:22:43 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b%4]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 07:22:43 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     "jarkko@kernel.org" <jarkko@kernel.org>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "Jason@zx2c4.com" <Jason@zx2c4.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "david@sigma-star.at" <david@sigma-star.at>,
        "michael@walle.cc" <michael@walle.cc>,
        "john.ernberg@actia.se" <john.ernberg@actia.se>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "j.luebbe@pengutronix.de" <j.luebbe@pengutronix.de>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Kshitiz Varshney <kshitiz.varshney@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [EXT] Re: [RFC PATCH HBK: 2/8] hw-bound-key: flag-is_hbk added to
 the tfm
Thread-Topic: [EXT] Re: [RFC PATCH HBK: 2/8] hw-bound-key: flag-is_hbk added
 to the tfm
Thread-Index: AQHYwbSROQtM17Y3rUes00GOEj1Wxa3R9HsAgAGPkHA=
Date:   Wed, 7 Sep 2022 07:22:42 +0000
Message-ID: <DU2PR04MB86308036FB517BF8CAD3D32795419@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20220906065157.10662-1-pankaj.gupta@nxp.com>
 <20220906065157.10662-3-pankaj.gupta@nxp.com>
 <YxbsBiCrIQT/0xz6@gondor.apana.org.au>
In-Reply-To: <YxbsBiCrIQT/0xz6@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|DBBPR04MB7770:EE_
x-ms-office365-filtering-correlation-id: 7d8ab84c-da1c-4a97-f19f-08da90a1c10c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QMRvrRyRdHNOsuF3GdI8kkfm1/hQiqdA+cpR3+CQaaoYhffvJ7IfLtxDdKDnngPK0/QpZcdebLdUfm8fCmKFuyVQG41d+RpvhLfqDHdDgjDwQDHthFg/D2wIDURyTu3oRcCF2Jv0RZvgE5gC1Rh3rWLy06GiGLaCSDxl59LT9adFWXY9QEjE2/JQmPsZIJL3ijhjnADH5KN+RPgU5oSDMJXXI6+Yz4j9nrcQXuS92YF+ZIMWcday5t9wVzrVbhE/mYoUkkcAkwxL4wXYuaDmrfKNheaxUT1GayiR65Nx2y5cJA1I5hLXDWYbrQ7NxqIGdYjEEbaEngPS85H8e5ImLN0ZR4gBD6JemE2g3J3kirTZLSGJeOPbL6R+5BvCMAAYr5RIp47gBs0zUjSdToGICFH5bSHe/e0rtKG7jJc8cFWmkNqJCO9iheKNcIa9n2wVE4La8IMc1wXXcMqhmIBUa9TZzdIcEVPgD24/U1pvIKXnGYCTHw4FVdXoqSq2DOIWRy+zpf/1LYvrb8nQgEHp3kDmCqaln4iGNtXJluCgL8sMYrBRFYpZGOYXSi55ZYQDMPJnnNLQxEt51R0NnA1wFtLXjMt7fWxmRKOwWzx/lrAuF7ZTOxfJ/v1BPb/jxUD6BSEaxDn5jQcYShvPSScqSHUptnKBxlCi/47EJWHgpHR4GQjWz1swBnS1iMLTiqh56eSyTkwZ5Y7TDRtfzXGTj+jpxE5GYC/V+IpgxnQkHsqh7OxYNex5qQlb7keWy/CAKbKH8gpmbgDm46nmlnWwxCloZP5E3MFA/xDcTncU0ktGnPzvpn2yZg18CEpYvPMv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(186003)(55016003)(83380400001)(2906002)(38070700005)(122000001)(5660300002)(66556008)(66476007)(66446008)(8676002)(4326008)(64756008)(66946007)(76116006)(38100700002)(52536014)(44832011)(33656002)(8936002)(7416002)(6506007)(53546011)(26005)(7696005)(55236004)(9686003)(6916009)(966005)(54906003)(45080400002)(478600001)(316002)(86362001)(71200400001)(41300700001)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2g8IFGBV6TelRmj4KGIKRcJkB1Kuw/UmgzxcSuk7N+2dT0spAFMVkJwsId+g?=
 =?us-ascii?Q?a77QcvUcdrBHYYqzlJECjuMMrigLo4RMHNnYh3sn8/8eDSK7wTTL4Mpl3ENH?=
 =?us-ascii?Q?EK5phmeMm+NXRdI2ACKWnNS/z1L6RAjHSd2FxPNAToCq7zW/tC+mJfBRXm4G?=
 =?us-ascii?Q?vPo5xhnEl9E5nQENl33KIeyWkWQUjl/3vuycgaRAKn/ht7yN88v3plrNo7r3?=
 =?us-ascii?Q?hLPw0NRPvHfqOniYrbgidMgKqiVHfLvAIdYePatzZdEQLTbuzGZu4LEtPB/i?=
 =?us-ascii?Q?9vfSfG18lS9Ae3mHAqWZdGLjPP8SR0EIqW7xj6piEWzPVXVE47DKV30kRbiw?=
 =?us-ascii?Q?4GFNlpi4rgT4njNk2dMV6cDfKp76hvGm3IUM+NQ0udfMPY02AL0E7jhN7X/a?=
 =?us-ascii?Q?XORt7SosTtYiQDq7DGEju3yEU24VwVh7bpjgXVlQE4KZRcCvp4ihdjCs4P7t?=
 =?us-ascii?Q?8caqSQAdWn7chA5Wb9u5IR4BPeCSqeDC6wTrFOhPjx3VRst3595y4jlh1Gj5?=
 =?us-ascii?Q?QEccLFcsppDSo/XasyMq8RwppdRahjdaGLUMF4prY1yy2B4McgTfdt7eEHN+?=
 =?us-ascii?Q?Z9psxfyw8WqGJB4EIZ+oNRORCJQ8T6GU3kZopnkpLWqYpVr7yItfKD7bQdyT?=
 =?us-ascii?Q?RFMT4ksHtMa4FrZ4SSTXsTHDooql+olfLiVbQkZsbU63TCe8y6lfj0bdQbVi?=
 =?us-ascii?Q?8NhyIveteO+ltN1CMg4xwzMaIwBZ5rpFRPNusWqIMeOQas/h+NsuuhVNOrlp?=
 =?us-ascii?Q?Xf/6TjxqgIo6Dcdxsq6+yq1t39wK1/EdTPqF+zxeMD/S8zgxRnJUl0nDq99h?=
 =?us-ascii?Q?6n0ybapqnmPsTN9IDXJZQ72lMBdvMeSf2sqVMoTpCDhfLtzheDhmZzTzwv9g?=
 =?us-ascii?Q?PLN8Yx6MWJYxN4L4YgGLYAIOJjEIMudaOrd3yj2aLMEGxByMrrD+7sPLdTvQ?=
 =?us-ascii?Q?Ghs+VjTAWnetlofMuKuFdAUeA8PlVIgHf2gbFaQ8Dt+VGFnyH/vaka6xB+jH?=
 =?us-ascii?Q?fG48hQqGPygd8hv/UNnjRJRpA3gaw4B/hnKCjRsb6ajyl5qksUBUNIsjnHFi?=
 =?us-ascii?Q?+h3QDg/BRgcWz2I6t4/J6aR8IlcvvPHVWO3oq0qoYwWBfGJhmAds1OoiZ7qQ?=
 =?us-ascii?Q?Qa3uudEZ9aowjDJa1XKdjE7Vmlat1TehgKFLqi9D6qLH5EeJxHhOMEIS70p1?=
 =?us-ascii?Q?AQwSp5UweGWhKps3D9yVi26WI86Ld7ozk/KlisDkRkLnBkwlRDSf70hPwhgD?=
 =?us-ascii?Q?YpBahrf6Uyh9SAaw6Cjuze9zwpQ+gySjvRHIF5wOB3fQSMMahHaEes1SfI78?=
 =?us-ascii?Q?j1H9C0NmkQk+e2YTulBpr9lhiMCwz2i+4jZl9bQO6JNx19SUPmu29QP4Fl4P?=
 =?us-ascii?Q?U18ZNjH6Cxp1lc1JFQp4brUmtUPrwULSlX9VnEcewpXfj9HaAHfdYd/N/qKx?=
 =?us-ascii?Q?8D8YhGMRzmuYEmJWLgDRTk0a2bUZmhXDs7UzChnPS0Z6i20b7tRokqSAzLLt?=
 =?us-ascii?Q?O2aLnCt5x5MXXrTWzlH/O/fKY5mg91LKL89WT11NRxxD4jI8i5qVzJUSAWo0?=
 =?us-ascii?Q?V95CVxNVNMX7J0YNQT4tdOb1ZBgbprcsE6sX+B4C?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8ab84c-da1c-4a97-f19f-08da90a1c10c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 07:22:42.9019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: io57pptt80z/M3jqjmKgCoCbFDGRW7Gmjk48Bok1dHGG84RnJj9/vc2Ns8at8PFLm5uoS9qYbGn3aYprCgbcQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7770
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



> -----Original Message-----
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Sent: Tuesday, September 6, 2022 12:13 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: jarkko@kernel.org; a.fatoum@pengutronix.de; Jason@zx2c4.com;
> jejb@linux.ibm.com; zohar@linux.ibm.com; dhowells@redhat.com;
> sumit.garg@linaro.org; david@sigma-star.at; michael@walle.cc;
> john.ernberg@actia.se; jmorris@namei.org; serge@hallyn.com;
> davem@davemloft.net; j.luebbe@pengutronix.de; ebiggers@kernel.org;
> richard@nod.at; keyrings@vger.kernel.org; linux-crypto@vger.kernel.org;
> linux-integrity@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> security-module@vger.kernel.org; Sahil Malhotra
> <sahil.malhotra@nxp.com>; Kshitiz Varshney <kshitiz.varshney@nxp.com>;
> Horia Geanta <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>
> Subject: [EXT] Re: [RFC PATCH HBK: 2/8] hw-bound-key: flag-is_hbk added t=
o
> the tfm
>=20
> Caution: EXT Email
>=20
> On Tue, Sep 06, 2022 at 12:21:51PM +0530, Pankaj Gupta wrote:
> > Consumer of the kernel crypto api, after allocating the
> > transformation, sets this flag based on the basis of the type of key
> > consumer has. This helps:
> >
> > - This helps to influence the core processing logic
> >   for the encapsulated algorithm.
> > - This flag is set by the consumer after allocating
> >   the tfm and before calling the function crypto_xxx_setkey().
> >
> > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > ---
> >  include/linux/crypto.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/include/linux/crypto.h b/include/linux/crypto.h index
> > 2324ab6f1846..b4fa83ca87bd 100644
> > --- a/include/linux/crypto.h
> > +++ b/include/linux/crypto.h
> > @@ -639,6 +639,8 @@ struct crypto_tfm {
> >
> >       u32 crt_flags;
> >
> > +     unsigned int is_hbk;
> > +
>=20
> We already have plenty of drivers with hardware keys in the tree.
> Plesae explain why the current support is inadequate and you need to do
> this.
>=20
Current support, does not permit the hardware to support both types of keys=
: HBK & Plain Key, at the same time.

This change is generic and permit any driver that supports both- HBK and pl=
ain-key, to differentiate and use the keys accordingly.

> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au> Home Page:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fgondo
> r.apana.org.au%2F~herbert%2F&amp;data=3D05%7C01%7Cpankaj.gupta%40nx
> p.com%7Cffd6105be88e4b82546c08da8fd33b6e%7C686ea1d3bc2b4c6fa92cd9
> 9c5c301635%7C0%7C0%7C637980434686220485%7CUnknown%7CTWFpbGZs
> b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn
> 0%3D%7C3000%7C%7C%7C&amp;sdata=3DAErrjpwh%2FRZSCNDDbtH%2FWW
> %2B39J%2FrxPJwak2X2Fk%2BWBg%3D&amp;reserved=3D0
> PGP Key:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fgondo
> r.apana.org.au%2F~herbert%2Fpubkey.txt&amp;data=3D05%7C01%7Cpankaj.g
> upta%40nxp.com%7Cffd6105be88e4b82546c08da8fd33b6e%7C686ea1d3bc2
> b4c6fa92cd99c5c301635%7C0%7C0%7C637980434686220485%7CUnknown%7
> CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi
> LCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D%2F7axxa8nrYDiItrwcZi
> AfRTVc%2F25Ln5IgUzr%2F1uK%2FNk%3D&amp;reserved=3D0
