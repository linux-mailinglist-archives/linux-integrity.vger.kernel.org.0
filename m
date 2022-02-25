Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7BE4C440C
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Feb 2022 12:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240325AbiBYL6A (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Feb 2022 06:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240327AbiBYL57 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Feb 2022 06:57:59 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B334021DF38;
        Fri, 25 Feb 2022 03:57:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NiA0IMnrwlZZeNux8G/PoGli+Q5nauGj2aCPXBMxM8d7Nv+he3a7Lvy4EB05BBjggXRVVTLz2bgHfyrPd7D+RWQW77zUhQx6i17DmwpxwKMOvaiqOicpP6RGKM+g/N2PmAcOQONWNjwE3ihTgKKb+EgtM5aIya6QdnEK6sAiRVxgVW4zKght5pupAVS2IRXC+ZOg/xe5eW+OYVTHBv4C71NcNKumerxTtWYZ8V9w3WVUgJyng3cIHLX6YPjzM3znTwVUdmGbaK0nYL/D5JM4LTZcOXd7K55Da0HGCEV/71ps1SKBcAtvzSpu0A4zaghcklng289oOLRUhvnuPMpRtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N54JM4gNLdRapD7Yfogeh8qcAkR5YsiGdxJGuQyfbHs=;
 b=YAiS4BEOSFewdIt/xbWXb7XlaM3+hsrevlhJRvElhmY5T6IxYOjAvNG6r+SrkcmxLq4MaOvdVC8PL/x3N1sqrsSooDBpcnX9h1hiPntukO2q4U51laCPWmP+c1Id7h3U2Z06Pj4U8jDkngykLm0a1riYmI4BhRUaDG+ULR2/w/Nt+Y8QfEWggDKFFLHs0yU5cyjUgPPd4vjpx7hzAG5s8YjewMNDWLuCjVtu6dUOX6/2RxixvI50kEihPWlCY7wJuGjY7c6VtFBVhO4fGJz/6vPiK54MAj1jtZguz0f1KmVgEZu/nPad6Nbx+tqRKr6u2nCqf1yTMjiuQdHlGrG0jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N54JM4gNLdRapD7Yfogeh8qcAkR5YsiGdxJGuQyfbHs=;
 b=mkge+dLcovHLEUcs889gw4p9FhbCRMnhMlfBE3AEWwy5fE9PSZsS5t9Tgt2Ag3V9KNnczpY/narzoFh8tMD1HNpURQn8bEHPrWWf5FhzJeiLWqr2YdG3jIxwnKDwP/djgJZCVvomNhJqBSWZq/ylVnqCnpi1QPNMjMI6Qu0T1X0=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by PA4PR04MB7885.eurprd04.prod.outlook.com (2603:10a6:102:ce::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 11:57:23 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::f92e:7648:49d2:d017]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::f92e:7648:49d2:d017%5]) with mapi id 15.20.5017.024; Fri, 25 Feb 2022
 11:57:23 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Sumit Garg <sumit.garg@linaro.org>,
        David Gstir <david@sigma-star.at>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v5 3/5] KEYS: trusted: allow trust sources to
 use kernel RNG for key material
Thread-Topic: [EXT] Re: [PATCH v5 3/5] KEYS: trusted: allow trust sources to
 use kernel RNG for key material
Thread-Index: AQHYKNGtB/drzUl2a02HqOqaymkrp6ykK8NQ
Date:   Fri, 25 Feb 2022 11:57:22 +0000
Message-ID: <DU2PR04MB86303E8F639FF98CE53E4701953E9@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20220222195819.2313913-1-a.fatoum@pengutronix.de>
 <20220222195819.2313913-4-a.fatoum@pengutronix.de>
 <994a4d49-b1d3-a7ab-d7b3-33405b13c125@pengutronix.de>
In-Reply-To: <994a4d49-b1d3-a7ab-d7b3-33405b13c125@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e151675-cd1f-4ad5-4bdc-08d9f855fbd0
x-ms-traffictypediagnostic: PA4PR04MB7885:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <PA4PR04MB78855BE80100EAC04AC4AC47953E9@PA4PR04MB7885.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6LiuGnpXySIhjxVVst/xtGp51pP1g0t5kI4yelyeGa3UwEt1GwM87vQyQp/FVdB6Jh+k5hc7Akz1hzthpxf/hTYd543LPbrK2fTr9uF8acR3T5yr59vq87CvtBId7Jy4+gzzT5ySmUGNdjtx7t6NL0f5iUkxmvKe0CejbjjCSCnbwBihzLbopIcCE95fgTwFJlHiYjjstiDQ8JKyDUXc4yZ0vqfkU3lqTSL8tNjV7lsgn3ajd9vsRfFUTnbRk4k9Hpyp71h/897pcQugxIVhXldoNSHZhl1FiiubhxCaR2V7w0uENsSIuPesU1HCDtCdrEo78eIi6vL/GPQhG9mFeH8eP9x2uP1yirt3F2lUS2zVbRdKZEcnaRndJpa+IXjReg22ZrTe6cTPwnBUB6RPKg71hM2zSUqJbI4PiVyw+RHS8uqnmuC2t1BYPQ7FRjVyTIR6U39Ak2j4d7kivFjq4ikL/zB47OLYIdYSwet4Qe3XBX3t0Irok2C7/M2Z0/pArUbi3R4xV6/hZmfcBMBETMb16qHMclkxIwxWVMPYCtYlwD1FLk81YwuGFToNUV0ehWGasdNH7Jz+iVpxNZGc3pTWhklXD5w0cLi84v8Ychag9xZ/TvvcffDdIIY/7jJ1Lbd29KwSJatdHQYPI5C/3o73u2t5PgJOU5B64scDFKHLl0/VEyH+iKN/bs42peZYq2m8zMMoiUMrsw/8Wc9QhmvEXBJHWi8/X2P51NBRLoTXAmwquPHtNfeIHg4kF04U9FFqhuoq7/w8AkFV6SMxGQNoWtZU1bWTPgGGYTnCDak=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(8936002)(4326008)(66476007)(66946007)(76116006)(66446008)(5660300002)(64756008)(7416002)(66556008)(316002)(53546011)(54906003)(52536014)(2906002)(33656002)(508600001)(966005)(8676002)(55236004)(7696005)(71200400001)(6506007)(55016003)(45080400002)(9686003)(38070700005)(122000001)(83380400001)(38100700002)(26005)(86362001)(44832011)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?k2Hr0hbyzNnlWQDniIY/CiVJ3y8AjBV7PI39CBR0OHFVicMGauXOFZj2ED?=
 =?iso-8859-2?Q?1WhcP3663Wd+vlD2oe0tsceYBqGxMiiUcfSSpTXV/LNInhAtGT7PWY4rlH?=
 =?iso-8859-2?Q?XckOua7z5E34sOXdW55c2t67pamvbP5zhOM1t4uVJDNGaGjLbWW68xKazj?=
 =?iso-8859-2?Q?LCGIkKTw9bgmMvUyHQEZZKsV6I0RkS3ql7t+nmaN4evy3O2h699Tah6i5f?=
 =?iso-8859-2?Q?vkxDsybN6+l20EbYszxusSDuaOMx6sUbyaRRskAljiW78VXq/+AmXWrP/n?=
 =?iso-8859-2?Q?h1eg/k/oqQKf+zL6wCe29oBU86LFIEumdaHRVceGJ/Nj4kf9hb14ZJQSce?=
 =?iso-8859-2?Q?A0Ons1Wa/9emxSykWBxyJUMk1VACt+3fZRJ0XN+/RS/0Wm/SYI+ly3J4OF?=
 =?iso-8859-2?Q?llV/ygQM1fM/4cyy2ZAPMdDom8Pu3uEbUnsCn3tWxJ2+fepdlVsFmhFmse?=
 =?iso-8859-2?Q?ccrrZT+aN5PSw4PxacNVjUirgCXhY3bqRLDB1n86JIyj2oVKSNb9SB4QJw?=
 =?iso-8859-2?Q?xS2zW9iHywOovcelthlpQveqBi/MqlEy/CHcJ4fMA+z2pIO53gZaogkusO?=
 =?iso-8859-2?Q?2jO1MSLeC2r1hcQyMwEZyu+ea7vzsRXxle0woxSwVprKe/xd50c8k5s4WI?=
 =?iso-8859-2?Q?dapCUOurnR1sCPBfGIbby7XHV5YB+me40aoL6df0pGIeEpvWGj4hbVlb95?=
 =?iso-8859-2?Q?a4zHoF6aClSDKu7dJGOZ8uiejBU8XUyso1pE5yYzoqF7jdzbVcKuxKIASm?=
 =?iso-8859-2?Q?x2Zc5LY7WyuPMqMojIGh+3fVv0VfY63e8W1Cy0O7Wh4CH7g8771Hr25+bD?=
 =?iso-8859-2?Q?3Ki8eHq+mJAwuYsnpMapF0EAr1ILxzW4CWkBTVENZlk38LaNcCVpv+U0mC?=
 =?iso-8859-2?Q?T1HxJDFVxxM0c6oNUyUHUT+8UL7f9waYyExsN8AESpaJqXGugMYuPwRnfL?=
 =?iso-8859-2?Q?raFBdyC681npq/x01o2Bch31q57zaIGSwe+eiTIIgyvDKmwWdD8v11WBWc?=
 =?iso-8859-2?Q?+wmO62plW5mCVqiBnwHD4KTCD7ouH0HuIt2tnEPpcwWfxslzVs91F/tuUf?=
 =?iso-8859-2?Q?yFb1K9C2ntcgGYCllj116tklFK6yggIxnLyDwXIaPn8XomSDdgxAyWh4vU?=
 =?iso-8859-2?Q?EJY3TES2lp1pcYm56ufKgLcNQWKxlzAdd5khaqP3bCFvbcbHfzdLcopr4T?=
 =?iso-8859-2?Q?Gi7RAsNBkg/1tHjGhAab1LitXF0pb6s+P1fV7jfFP7gGrWD1zmjZTU+BQf?=
 =?iso-8859-2?Q?q0S0pBOe/m7U751/UlyvD5Nwsr/d0p5sYlItwwhw8N9PhIN2ZXXkeS3LBM?=
 =?iso-8859-2?Q?/E8TmPQ9zb80tU34p8XFTkHEBewwX4RwC4Jddg8SKCZnRUy/7spUPLigZu?=
 =?iso-8859-2?Q?N+mrlnlQnWOXxX4vcBiAlps5JQ9neJY6t5MHVI1WAZc9I/pe0rpqN3vHXb?=
 =?iso-8859-2?Q?pgGJyw5cwQvvIwDkxPZxlFJ1chODIT4JL2x1L7BPmO6xmEYWLU/uDK/fI3?=
 =?iso-8859-2?Q?J3QtSxZq5F/L545/3bwEH7ww3Liqvm+Rolx5TeCoL7ZdAiiYmER6R0C9zR?=
 =?iso-8859-2?Q?q7D0FQ+Fy9wRlVfMcKyDwFcvbwADQXIZpbpJwOWEfZuMvcJ/OApPAVCO6F?=
 =?iso-8859-2?Q?5gsz8Fe0VpGonPZ+ueCE459zyaEEAn9bUqbERZ0/12NgWox+101r8UM6l4?=
 =?iso-8859-2?Q?PVtJ/Eif1NPybSs/K+8=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e151675-cd1f-4ad5-4bdc-08d9f855fbd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 11:57:22.8880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uRv6edyY42dPctkXcI7eqUXTjAs8fRITiG/u0bB2cHXG4mLoO8Txf93R4MMtlSzl+YDebUTGSJZr443eCWAnWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7885
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Reviewed-by: Pankaj Gupta <pankaj.gupta@nxp.com>

> -----Original Message-----
> From: Ahmad Fatoum <a.fatoum@pengutronix.de>
> Sent: Wednesday, February 23, 2022 9:53 PM
> To: James Bottomley <jejb@linux.ibm.com>; Jarkko Sakkinen
> <jarkko@kernel.org>; Mimi Zohar <zohar@linux.ibm.com>; David Howells
> <dhowells@redhat.com>
> Cc: kernel@pengutronix.de; Sumit Garg <sumit.garg@linaro.org>; David Gsti=
r
> <david@sigma-star.at>; tharvey@gateworks.com; James Morris
> <jmorris@namei.org>; Serge E. Hallyn <serge@hallyn.com>; Horia Geanta
> <horia.geanta@nxp.com>; Aymen Sghaier <aymen.sghaier@nxp.com>; Herbert
> Xu <herbert@gondor.apana.org.au>; David S. Miller <davem@davemloft.net>;
> Eric Biggers <ebiggers@kernel.org>; Jan Luebbe <j.luebbe@pengutronix.de>;
> Richard Weinberger <richard@nod.at>; Franck Lenormand
> <franck.lenormand@nxp.com>; Matthias Schiffer <matthias.schiffer@ew.tq-
> group.com>; Pankaj Gupta <pankaj.gupta@nxp.com>; keyrings@vger.kernel.org=
;
> linux-crypto@vger.kernel.org; linux-integrity@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-security-module@vger.kernel.org
> Subject: [EXT] Re: [PATCH v5 3/5] KEYS: trusted: allow trust sources to u=
se
> kernel RNG for key material
>=20
> Caution: EXT Email
>=20
> On 22.02.22 20:58, Ahmad Fatoum wrote:
> > The two existing trusted key sources don't make use of the kernel RNG,
> > but instead let the hardware that does the sealing/unsealing also
> > generate the random key material. While a previous change offers users
> > the choice to use the kernel RNG instead for both, new trust sources
> > may want to unconditionally use the kernel RNG for generating key
> > material, like it's done elsewhere in the kernel.
> >
> > This is especially prudent for hardware that has proven-in-production
> > HWRNG drivers implemented, as otherwise code would have to be
> > duplicated only to arrive at a possibly worse result.
> >
> > Make this possible by turning struct trusted_key_ops::get_random into
> > an optional member. If a driver leaves it NULL, kernel RNG will be
> > used instead.
>=20
> The rebase on the change in scope of the previous commit made this one he=
re
> quite small. I would squash it into the previous commit for v6, unless th=
ere are
> objections.
>=20
>=20
> >
> > Acked-by: Sumit Garg <sumit.garg@linaro.org>
> > Reviewed-by: David Gstir <david@sigma-star.at>
> > Tested-By: Tim Harvey <tharvey@gateworks.com>
> > Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> > ---
> > To: James Bottomley <jejb@linux.ibm.com>
> > To: Jarkko Sakkinen <jarkko@kernel.org>
> > To: Mimi Zohar <zohar@linux.ibm.com>
> > To: David Howells <dhowells@redhat.com>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Cc: "Horia Geant=E3" <horia.geanta@nxp.com>
> > Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Biggers <ebiggers@kernel.org>
> > Cc: Jan Luebbe <j.luebbe@pengutronix.de>
> > Cc: David Gstir <david@sigma-star.at>
> > Cc: Richard Weinberger <richard@nod.at>
> > Cc: Franck LENORMAND <franck.lenormand@nxp.com>
> > Cc: Sumit Garg <sumit.garg@linaro.org>
> > Cc: Tim Harvey <tharvey@gateworks.com>
> > Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > Cc: Pankaj Gupta <pankaj.gupta@nxp.com>
> > Cc: keyrings@vger.kernel.org
> > Cc: linux-crypto@vger.kernel.org
> > Cc: linux-integrity@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-security-module@vger.kernel.org
> > ---
> >  include/keys/trusted-type.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
> > index d89fa2579ac0..4eb64548a74f 100644
> > --- a/include/keys/trusted-type.h
> > +++ b/include/keys/trusted-type.h
> > @@ -64,7 +64,7 @@ struct trusted_key_ops {
> >       /* Unseal a key. */
> >       int (*unseal)(struct trusted_key_payload *p, char *datablob);
> >
> > -     /* Get a randomized key. */
> > +     /* Optional: Get a randomized key. */
> >       int (*get_random)(unsigned char *key, size_t key_len);
> >
> >       /* Exit key interface. */
>=20
>=20
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.pe=
n
> gutronix.de%2F&amp;data=3D04%7C01%7Cpankaj.gupta%40nxp.com%7Cd6143a
> 1791a8494849f208d9f6e8cef8%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
> %7C0%7C637812302026139014%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&am
> p;sdata=3D2QRFygy%2BVafXrLIkF1BOHtDiwP%2Fz9kwU9ovtG1WJBTY%3D&amp;r
> eserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|
