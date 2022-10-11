Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52E55FB183
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Oct 2022 13:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJKLct (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Oct 2022 07:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiJKLcs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Oct 2022 07:32:48 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D432D78BF9;
        Tue, 11 Oct 2022 04:32:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsQPFngbtQPTZXpHMrcpiclAY5HaDVEZ2R0ZaNv/QQS6mxoYp1lqsAIu+yyv2xU0GJLanaNklfFlIR0j8+aNsz6/ygXo7wGm/T27lCj/6d31VKzzx1WZSOMjWcIEinwuOLjF99GJxmalkMJm5hXvc+K5mT29LcRo5jNlRjjT0byHWD4oL8lD62GpgzLg525uwmr1fzn0Ngr8fclWGP/O9Z4XN88YghMbhGoaE3hDRvikbgjL/DzhvVh8Z1z0LwKpLHy15lj0yOtHEp8QOyR5J505G3T1LSN6JqUUKT7Z2L886g56GvPVT7CZ2aY1JX+tLeC+TodOOaKhUppyvgymMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOYdT0uHts6MO9MMgz6lo4T1pUoDn2SZQTZ7lO4UpkA=;
 b=GNVTO6vguDT4kKO5vOnVSyDdoB76F96cmII/oY9L/C6IvHPixpIdyNOWAysMXA5BSXEWURCf4Ne6IVOf4+e1b70hqCsFW6hEWcITU475FFYFaaYDoP3b1CuoUtWoYPlSTUrCWV035B58VvXLRP/DT7yeNY3JGKljC/CMJXi+YI+BiJ4xjuTmLjN6qWYjWHxRgf9FuucDSTregbZ2c9CAf+q3NK+w0pbHObm08DldJJVEz1uNKobKaX3d2TiV01JudP4gh6SuiFRzb4cHXcTfJcKC1lxirOZTuEps8eU4wUhKTC5ez/X6NdXosLFZh+XDMJs2y6ol8b1OaVhrXnVa4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOYdT0uHts6MO9MMgz6lo4T1pUoDn2SZQTZ7lO4UpkA=;
 b=ju9YP+Brv+r6s/tZpZuoRbRGKpahGJQ5ffQK1ZYKlhU4tSsdk4vXW50m9RzazM0M8vKDpvG7w2RAWat/0kdS+IW6gEzSZbRR/GvZrioKtiWZNleSJ1oRZw3sxNns7q9bF6uJk3hcoZCPGEMf/ptV3EvZzOTimlHgj2TXzbSEZlM=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by DBAPR04MB7253.eurprd04.prod.outlook.com (2603:10a6:10:1a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 11:32:44 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::d551:6af4:bca4:88ea]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::d551:6af4:bca4:88ea%9]) with mapi id 15.20.5709.021; Tue, 11 Oct 2022
 11:32:44 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     'Herbert Xu' <herbert@gondor.apana.org.au>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     "jarkko@kernel.org" <jarkko@kernel.org>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "gilad@benyossef.com" <gilad@benyossef.com>,
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
Subject: RE: [EXT] Re: [PATCH v0 3/8] crypto: hbk flags & info added to the
 tfm
Thread-Topic: [EXT] Re: [PATCH v0 3/8] crypto: hbk flags & info added to the
 tfm
Thread-Index: AQHY2XuZ7wDJr0j14EOJG/A0UWusR64CgW+AgAT+i0CAAENoAIABKlGAgAAmJYA=
Date:   Tue, 11 Oct 2022 11:32:43 +0000
Message-ID: <DU2PR04MB8630BED11334D94A25731F3695239@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20221006130837.17587-1-pankaj.gupta@nxp.com>
 <20221006130837.17587-4-pankaj.gupta@nxp.com>
 <Yz/OEwDtyTm+VH0p@gondor.apana.org.au>
 <DU2PR04MB8630CBBB8ABDC3768320C18195209@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <Y0Q3JKnWSNIC4Xlu@zx2c4.com> <Y0UxY51KQoKCq59o@gondor.apana.org.au>
In-Reply-To: <Y0UxY51KQoKCq59o@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|DBAPR04MB7253:EE_
x-ms-office365-filtering-correlation-id: 792e8a11-ff32-4a57-3e10-08daab7c5058
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zr5NpgZSsp6+HyeEoJtQWUQCJ+Y9KAYmwquaOKnKtb+/0BZf3Saw9TQRNZBbcVwG+GI87sFJ0ajXA6SOFbTQX9eVH2oZ8oElkkEb9lakV/dk7aL1s3sx+ur3p9IdaiH8LMTtIlW2F7ktGDYIYHKV3o9syfgVTpsWxGvc+RninAWPaaXcdkGWHAmsWtrHGzkpCE8kVNH5rJqyF+o9niO9BzztmNoASUv9mXj1u8i5u2UOUTBLnuVaIG+B/g4YSY5TVZMNMb87TG8wz/nNb9pMlS63aJTePh/pPMe+Bkz3ESGByaFZ1cls3Z1Iv0REAQIMEPsN10O88ZTNX66Ejwla5uZCiec8ue3SG2QU/iSgwTr1PuxquWyZaMgR3N3C+DXHJXIj6wnwV7ELrYOPuacisl+LFn2H2pBR8j5hpTLv2obZlPG97rfjtHuFY8scqCBw/0jyC2rxhG0uhpy23sf88cACofI3Vq9RKl9Wy6ZAIQJ7zjeCikwx3gsPTsktvr86xvXb/ZERTsQN2f92ebjPPhupu360/8WqjkySKgfd5scGUTb9cMW9mE5DPz5nvpWdakqto/ZOKFk5vT90Br0URntZki76VBns/r/5W8rGs6B6ZM6lGp6bRgcQjZsguGeHSgkMRc4WrlVy+NbTHiWy5zjACscD8RTMfruuPA/Q64A2fgS1PVcMtTaZeZpn8+mv44b4pqSYALgUm/ZkMsDn7o02y8jehdRW1Mw6qfnTC3yQzxePOVCEFFPb7S8M886ZIa4YxAvEJiQ0yqxpZraLuAy4KaSrYrJGGI+lRWx2yjw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199015)(2906002)(66899015)(8936002)(52536014)(44832011)(33656002)(316002)(7416002)(4326008)(64756008)(66946007)(8676002)(66446008)(478600001)(66476007)(76116006)(71200400001)(54906003)(110136005)(26005)(186003)(45080400002)(41300700001)(5660300002)(966005)(86362001)(6506007)(55236004)(53546011)(7696005)(66556008)(38100700002)(38070700005)(9686003)(122000001)(83380400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cR6vI14ebLYKD6JvFv0nsSXqegfckU9i+dWm1O0DWsHfDieTpQvC4PzprnKF?=
 =?us-ascii?Q?q0eGp2Zk1o/jNP8MuJfkRZO1yy0XC9Ro+Oy9mWPhoWzacnGcjY2UvQEgrLgp?=
 =?us-ascii?Q?dwl9UinHLFiH/+B6emTXcvpFk31vE/UuZUrMAWn/Tf7eYGX3XhbyVQJ13u5+?=
 =?us-ascii?Q?osKhgccxb0pr22gRqSMubWbOwJqEEqlRCFc7feh50UHe9Qyw8o3eUErZMs1K?=
 =?us-ascii?Q?IaZeH0ivo5DKePxmriG4T9BU3+RW803Yblm2LUhQy64aMZlDdodxvHfrzGNK?=
 =?us-ascii?Q?utbOP5zSqGjLSvxwzjyaaRDmJoe51vfEq50/JaUmzmwLP5dreW/EBokmRKDU?=
 =?us-ascii?Q?3q2QqkMQ8dxL9yMpiLXWNr9cC4DLKBAlmOpJ1JQzVglhXwhijtF/EBWnCtbv?=
 =?us-ascii?Q?7VopwPafzv8Q9o3SZkUrerkvYLtEmTFCVaKvbXfqaIlx6mGYWdwl5OUdTTBd?=
 =?us-ascii?Q?ZT1tozR7q4JCODqcEuHGAtY3kYrhE6nCS+tAkgbX8QSW6ejEzZGt23GN8b6y?=
 =?us-ascii?Q?0HEV10ZkCvdesYXE1R2dUmKnKKjA6mybUAr11elOq+HNG4ejUtx3zc/g2adX?=
 =?us-ascii?Q?XkqaO3e57OXWmIMxcIl8cFpvICvwv3PM/VKZPVh+YXmGM+qhsO/b2tcLTU4D?=
 =?us-ascii?Q?RPGfI2MIcveO2U/zR14nO80+CrKHtHITtnjK7oAkQd2+JS+wNdP07UdwITtX?=
 =?us-ascii?Q?jVXNw0Di3R+sP3JDaX6g4q+DpluYJF36SG7RPM/qj4idWCzI92l5p5wU2Z+2?=
 =?us-ascii?Q?GF9b0+xmQ/RSpe8LJmZcL6erc/iZHrQPin8vsNVQh+ils+J9m5A7cUuW531+?=
 =?us-ascii?Q?2cAS8xFewLH4zv0YxK235j1NAVr+auDmD5uYrhPaBhTDPZjm5DL7w+JVld1z?=
 =?us-ascii?Q?q22oFUzHlx2PNBJljezaGNMmD95g3mp07hfBGyJFzK1dOI3k6HVwkEyfYNky?=
 =?us-ascii?Q?41zlBxOpe7sJ7opMFAQlQBiJrArDfa4mrxcVI346aEkedsSRxP76y0iRK+jo?=
 =?us-ascii?Q?dz9RhUAXQ28bPkSDRSJ1COXXaRPIwtwB9gLY2X4RI5jhRptPlPktjkMy9eEq?=
 =?us-ascii?Q?v+xPuC8cHaIb9kSXPMSWug1yq1KIb/eaeevAFvm8LE1uf32rFYKYhSKPiNI6?=
 =?us-ascii?Q?NvSY0BNc3/VtllgLrXbHJqkvDvtIxH1ZvTuvEKqIQjwJ/ouU9x9t4Xxc8khT?=
 =?us-ascii?Q?ZCSkQsiqdeFwIsLRL5Df2Iipd1bJ9xsxUvWRRjXGVZ13IglYD+YFokTKau0R?=
 =?us-ascii?Q?HZSDW3fhfE8vU3NUPm3Dryw1wdG7+0IZG6bwBLU4z/PCXqP8xozrXMmOf3Yg?=
 =?us-ascii?Q?Aed9Vu3XKSF+irgU/KRUrmDj/nc4O25EAbIxkq0R93J7A2qpiTYj/WDnuqre?=
 =?us-ascii?Q?Qegl5h/RRfkMCu1HrXIZLPzCJV6wJUcqLRJc+W9A6GWeJVttidfyFjUh7hZf?=
 =?us-ascii?Q?gp507UVmf5QRYqt58vJljkHitgjm23pv4y9E+UAdLsGwaXin+CYeVVh/O3uE?=
 =?us-ascii?Q?jLeeJ+VZnuqB4I0XWHy5ZrTGjix2cPkT3pgLzAUvkGHow0fUgDdwGNFJ/8Mv?=
 =?us-ascii?Q?8dufMK/TcHfQ1qh1G5J4eSKv+376z+4+gaX0zi8K?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 792e8a11-ff32-4a57-3e10-08daab7c5058
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 11:32:43.8288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3RdpBv/LLv0XygLoitkcCPRRWgFR+0EcAkgfAcqkQCRKsP1ou5eYXEMNh17Bp0ZTkfMffYJx1vwyqdFi3bUmaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7253
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



> -----Original Message-----
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Sent: Tuesday, October 11, 2022 2:34 PM
> To: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: Pankaj Gupta <pankaj.gupta@nxp.com>; jarkko@kernel.org;
> a.fatoum@pengutronix.de; gilad@benyossef.com; jejb@linux.ibm.com;
> zohar@linux.ibm.com; dhowells@redhat.com; sumit.garg@linaro.org;
> david@sigma-star.at; michael@walle.cc; john.ernberg@actia.se;
> jmorris@namei.org; serge@hallyn.com; davem@davemloft.net;
> j.luebbe@pengutronix.de; ebiggers@kernel.org; richard@nod.at;
> keyrings@vger.kernel.org; linux-crypto@vger.kernel.org; linux-
> integrity@vger.kernel.org; linux-kernel@vger.kernel.org; linux-security-
> module@vger.kernel.org; Sahil Malhotra <sahil.malhotra@nxp.com>; Kshitiz
> Varshney <kshitiz.varshney@nxp.com>; Horia Geanta
> <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>
> Subject: Re: [EXT] Re: [PATCH v0 3/8] crypto: hbk flags & info added to t=
he
> tfm
>=20
> Caution: EXT Email
>=20
> On Mon, Oct 10, 2022 at 09:15:48AM -0600, Jason A. Donenfeld wrote:
> >
> > Do you mean to say that other drivers that use hardware-backed keys do
> > so by setting "cra_name" to something particular? Like instead of "aes"
> > it'd be "aes-but-special-for-this-driver"? If so, that would seem to
> > break the design of the crypto API. Which driver did you see that does
> > this? Or perhaps, more generally, what are the drivers that Herbert is
> > talking about when he mentions the "plenty of existing drivers" that
> > already do this?
>=20
> Grep for paes for the existing drivers that support this.  I don't have a=
nything
> against this feature per se, but the last thing we want is a proliferatio=
n of
> different ways of doing the same thing.

Our goal is to have a generic solution, which can be extended to any driver=
 dealing with:
- Generating HBK and adding to trusted keyring.
- Using the trusted keyring's HBK for crypto operation.

With this framework in place, driver specific custom changes can be avoided=
, bridging the interface-gap of:
kernel-keyring <-> kernel-crypto-layer.

Thanks.
>=20
> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au> Home Page:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fgondo
> r.apana.org.au%2F~herbert%2F&amp;data=3D05%7C01%7Cpankaj.gupta%40nx
> p.com%7C4ef27fc922d04350ca9f08daab67a1a3%7C686ea1d3bc2b4c6fa92cd9
> 9c5c301635%7C0%7C0%7C638010758832054902%7CUnknown%7CTWFpbGZs
> b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn
> 0%3D%7C3000%7C%7C%7C&amp;sdata=3DSOguJ9LGhSCDmspbjDIEzkQLk9Bz%
> 2FsS0B%2BLNc4gzRo8%3D&amp;reserved=3D0
> PGP Key:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fgondo
> r.apana.org.au%2F~herbert%2Fpubkey.txt&amp;data=3D05%7C01%7Cpankaj.g
> upta%40nxp.com%7C4ef27fc922d04350ca9f08daab67a1a3%7C686ea1d3bc2b
> 4c6fa92cd99c5c301635%7C0%7C0%7C638010758832054902%7CUnknown%7C
> TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL
> CJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DhCzT2fPfJ%2BBNVqN6JR
> wMx9zNJkqvdRSLrR68ubhCvN4%3D&amp;reserved=3D0
