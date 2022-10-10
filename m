Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8519A5F9D5F
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Oct 2022 13:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiJJLPL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Oct 2022 07:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiJJLPH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Oct 2022 07:15:07 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2078.outbound.protection.outlook.com [40.107.247.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E14F24F1A;
        Mon, 10 Oct 2022 04:15:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m09Gewqo1zVk7FoyG3oWUUNPwKFO8PFO9nsooaSemIJQe5iNZszDl0aLLYC9OlIuTMsLo2jSZG1V7UQafHXgVW/QzwS2RNYYLK2L+S8LuxIV/1i+UuQ41XUXrOfwWSreKd1VjMEF5E8Ye1sJYEMYoCPRvWnbtU6MVVnzZOyNHP7riGRUNUmJxDfqr8D2gzUo2SYNxn/F8h1ES8ZX5GA0oFjc6fdT2OCbN34UaVRRqHO4zXYb75sx3IIyxMaIQJPigqBa9D8hUQNfOux4QzlgbQ20DTBY7YXbITpBmM0DI0FwS1b8OcYgcINPaRM9ttKNa2xRr7V7d1h5CEoml1Pc9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+RfPYVBqvc9pJ13abS6KcXYSuQrIOlOqXydVCgrtAQ=;
 b=htJElYNoWh/ooMbFWhXlTC0zJjHyoXsMc5O0Lr7ChB9U9jqwcSzBTvd3PJvQNV7sQqYNPuiS+6SvtUxA9/A7mHWlpRRuUoq0LAgy84icewY7Zo3ZTzz5poveDoHQIIHUd43fzQtrkStH0OoocZRhylAcJq14ak++9ZUOk0yF9pM2cUY8FaZfkOesInQFlPZqd7PsTc8tJB1Wdc7IzD+x+0088gTpn7wz9Ftp24eZ3pgOvK2J4A74P/5GwGuOhupvvVrkhDYaNdY1bFUj09uvwlPRJYCMXfumyY0wSgFTS5qRiGZczV43maPYFFgdJSySo6fysJzWwSRtv4KcRrkNEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+RfPYVBqvc9pJ13abS6KcXYSuQrIOlOqXydVCgrtAQ=;
 b=QuBo/MnyjoSN863bsGy/wOK4lhdxMkva0rhI6Iu1T5XVO+u6Sqm4rhuzgZcDQ7aCMZEj5aLUYUqog2Au32Z+9ckVlLs+PPu6yiqksAYk8rTsXzZ/m2xvXUIuyVF8+aLQNPCVlFGL5Mku0Tp0vbJUgltfIq3I8rtncZfjKuFAotE=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 10 Oct
 2022 11:15:00 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::d551:6af4:bca4:88ea]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::d551:6af4:bca4:88ea%9]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 11:15:00 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     'Herbert Xu' <herbert@gondor.apana.org.au>
CC:     "jarkko@kernel.org" <jarkko@kernel.org>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "gilad@benyossef.com" <gilad@benyossef.com>,
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
Subject: RE: [EXT] Re: [PATCH v0 3/8] crypto: hbk flags & info added to the
 tfm
Thread-Topic: [EXT] Re: [PATCH v0 3/8] crypto: hbk flags & info added to the
 tfm
Thread-Index: AQHY2XuZ7wDJr0j14EOJG/A0UWusR64CgW+AgAT+i0A=
Date:   Mon, 10 Oct 2022 11:15:00 +0000
Message-ID: <DU2PR04MB8630CBBB8ABDC3768320C18195209@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20221006130837.17587-1-pankaj.gupta@nxp.com>
 <20221006130837.17587-4-pankaj.gupta@nxp.com>
 <Yz/OEwDtyTm+VH0p@gondor.apana.org.au>
In-Reply-To: <Yz/OEwDtyTm+VH0p@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|PAXPR04MB9422:EE_
x-ms-office365-filtering-correlation-id: a7cade18-a2ba-4202-b6d9-08daaab0ac53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dj/k1z1cF/BdIRrDJRKank8C3pXQXEnEgL5AaCb8C9Ulesvo32gc1WdnREEGysY1pAtNnU+u5JySCpnz8MBG0MHx+a8Zn2a0J5aKhNoBItXuxxbk6C3Whka1581G42eHo18pkt/qdIbzs26Zfln0ddeXYeYzoWdNpkct1+rmnPe/gm7rsXlqyAkAYjoIYG9Oj6evnlLrRNdS3tGnFldeRlymDWx79QjLzI/dxY/WsoNOUKsLXp4bNwvAucYYEG+SGiqrwJR8hhyKfKZXJjv5deEWLS+kfLL/9z8y+hoRMD9XD4msh8zlr7SEgzlR5cr9+GI/W6GbY9KIlS+SAAaxAMIn0ucsbDGESsA+vhkfyasYuCygEDtj9EGu2R2wmKAQSY85TAD6IuQJ9ciAHnxA8/vIdyh1FhkJ3YTyd6/jRebbMbdhYtEAiuPz7vOIFzky+ruT9CEDb/DiT/FppJ7ZkvMM+Hmr+tIzS4ckJtBU3MuqAz5f/+482KKWzm+tr/xkQv4y/OHSHeV1v7pfoyNn9AhAVhUNkoiGZdGCtzcUNY2yS41eaTLjJHy20iAuIgm/GnC2bi3ob7FKcmxB+7VuyRKDO8MBeVmDHf+UVZJB3buj35GFrFdGDJR89txG9ku12v/bcDmVxauT12y1lxdKx3uwfyvHYPcqRU8guM3WmTqxm35CekkshJZygn2ODlVwDF8bBmupKJkSmHok4/HnwKKy9VPY3ocaXHq66+PygWi0ARFtRRReSacWKKwVxKu7XiIAaImm3Q5mmoBRahYejaeA/FIH/Vlix+cjXYZ8nCT/ArLTiRqPsHMVgYUpifs7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199015)(55016003)(7416002)(26005)(9686003)(7696005)(6506007)(83380400001)(186003)(8936002)(53546011)(44832011)(52536014)(38100700002)(122000001)(41300700001)(5660300002)(33656002)(38070700005)(316002)(76116006)(71200400001)(6916009)(54906003)(2906002)(966005)(86362001)(45080400002)(4326008)(66946007)(66446008)(66556008)(478600001)(64756008)(66476007)(8676002)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LU83z1Y91X6sEzh/HVTCIib7OEq8wUdFq1wiirkQqN/Jma+EfBlwHnpJ8dch?=
 =?us-ascii?Q?VlMpkiWHFeMyNxuXyHGbhGlT/wdIxL8bTLALh4knHJzVyYEkm+Oz2271r1yN?=
 =?us-ascii?Q?mSf0jJQ7G3GdRhxaXcCxJDraEOZc/uFZYOEXp/dtioLdVF02ilbLgaITT78R?=
 =?us-ascii?Q?IJnbD57V9WJIMvRH1Xq241Esys7zkGj3p1K5BMhopDNk+HbP6EaDB6RBoNZa?=
 =?us-ascii?Q?Ezy9AG/bNRVMTCo9a2peRL9YDyEUzuvvxDgCuJPFJiUhR6TB0znQ816DwtJ7?=
 =?us-ascii?Q?7mH9FRjqgIkG0YRV40rI/cjnwu/XSdr1PmbWSwr6kUVSKGx+pK2zp98eeIzf?=
 =?us-ascii?Q?MmlgkdpZQTfLkkzbjRsSiH4tkzNwtjkU1sPTG73yPP0WYisku6A7T9TVhUyG?=
 =?us-ascii?Q?Vdf7L0m8Igs8TTWOvswDESUZVNkjd2yNXou408P+o3DKw7Hpjp1wlVIDKhJl?=
 =?us-ascii?Q?Zn/oT4ayMApK4ylaSP4uJXCO5NI0P/2rQ7HqowxpDEUh9sHt7PWvvAtHdwwo?=
 =?us-ascii?Q?dsFjo3fm5wRGUJdovJt71OcsprwSVjGOXXhj8417L2i3+ch7T17En41/i/eX?=
 =?us-ascii?Q?iF2+GXC5RwsLGKecnPZdJXu/1R9zmVFsCHHGTTpA/J49ej3mXnz6W13EfCFE?=
 =?us-ascii?Q?MeNe8E2ZkQAxL//BDjFs70WnLnsS59sbJCouYAID/KYy45Zg3DXBksfIwBZS?=
 =?us-ascii?Q?2l+ZuVM/02FQ9ee5/NJ2do2Q0fjb6n4NhSqvOhXvynTKqfyzBdmewy1+Kn40?=
 =?us-ascii?Q?FFqueFRdrv9D4OzVKTYnRaPTH2YpUiSh7XTo9IYDX289yucN030IKcBk+cty?=
 =?us-ascii?Q?lAkzR/FBOBTFY3vkOSO0G4Sk15EhYfObGDe0Ybs/4zHc+gfWSjp5XIHah49T?=
 =?us-ascii?Q?x87sf19YNIY/Gx24Jslxg7d/sKaQzBU4psZbeUAKDYoPyWtiMm+Z5h3xS2tU?=
 =?us-ascii?Q?r/slbhbP4JqylHd4jSvPE7nro8O4rBIBLEOG8OgskUNXcDzrGJfPsThcih97?=
 =?us-ascii?Q?ZqOsd8tHRHoI8BviY23oT7GyW7vA+3rew8ffYZnbIToKOC6cxf1ceAG5mKOm?=
 =?us-ascii?Q?Oj/CZW8D1m1+BG5mwvoiJZZ+t2DvANYB4brAhOKzzQfIBjGpSNKyTBJ+zbrr?=
 =?us-ascii?Q?eV8dCLcihCPd+7ndV9B/6G25STgd1jnfS8ctHzJAMr3lSQA9Dh/FTUF/DaGw?=
 =?us-ascii?Q?+PamrJtK1Ms0tb/Eq/1iQ4CBI+vSt+2GNIdFn7wWSN2XziXx24Bdz85qcKqR?=
 =?us-ascii?Q?iSxiqvJ63YwaF8kBGmQlaNxv8fkUBvUQsHGKA1+qiEilPFi0vVkbVODMHxTc?=
 =?us-ascii?Q?OLlFCBodeBhRPkEa1HXXr8tp3C7CWay7LF6U4y7DI/WXp0h0yj8ByL5JBcLs?=
 =?us-ascii?Q?pE26nLygcJc2KTw0FaDY3QjLqZ/Kg0MFLkJI6SMO0rgzrRDMeqQWy9XJslmo?=
 =?us-ascii?Q?Z7nglLz0q7pSK3l7XTtPZDfo5IZPVFdot5Tvdhtg+AyQFtikmFBIJYbajUWq?=
 =?us-ascii?Q?Q8MLWI8wfae0f+k7dy/LmolZRjgCwl4kIgQLrG+0wU/c3L+Yn3RxH3cGHu41?=
 =?us-ascii?Q?U6jIZpWokr9ZnMWNKlD+xTnBHxKXJxQ3JENOFCxe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7cade18-a2ba-4202-b6d9-08daaab0ac53
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2022 11:15:00.8167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7tgujxo83cKlYgYZZ/PQSHo5JRTaO2ZcwSOfHz3cfy3fCVjCN2b5T44g0R9RTSBtUBzp19anLobMhIAFjXaalQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9422
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
> Sent: Friday, October 7, 2022 12:28 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: jarkko@kernel.org; a.fatoum@pengutronix.de; gilad@benyossef.com;
> Jason@zx2c4.com; jejb@linux.ibm.com; zohar@linux.ibm.com;
> dhowells@redhat.com; sumit.garg@linaro.org; david@sigma-star.at;
> michael@walle.cc; john.ernberg@actia.se; jmorris@namei.org;
> serge@hallyn.com; davem@davemloft.net; j.luebbe@pengutronix.de;
> ebiggers@kernel.org; richard@nod.at; keyrings@vger.kernel.org; linux-
> crypto@vger.kernel.org; linux-integrity@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-security-module@vger.kernel.org; Sahil Malh=
otra
> <sahil.malhotra@nxp.com>; Kshitiz Varshney <kshitiz.varshney@nxp.com>;
> Horia Geanta <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>
> Subject: [EXT] Re: [PATCH v0 3/8] crypto: hbk flags & info added to the t=
fm
>=20
> Caution: EXT Email
>=20
> On Thu, Oct 06, 2022 at 06:38:32PM +0530, Pankaj Gupta wrote:
> > Consumer of the kernel crypto api, after allocating the transformation
> > (tfm), sets the:
> > - flag 'is_hbk'
> > - structure 'struct hw_bound_key_info hbk_info'
> > based on the type of key, the consumer is using.
> >
> > This helps:
> >
> > - This helps to influence the core processing logic
> >   for the encapsulated algorithm.
> > - This flag is set by the consumer after allocating
> >   the tfm and before calling the function crypto_xxx_setkey().
> >
> > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > ---
> >  include/linux/crypto.h | 5 +++++
> >  1 file changed, 5 insertions(+)
>=20
> Nack.  You still have not provided a convincing argument why this is nece=
ssary
> since there are plenty of existing drivers in the kernel already providin=
g similar
> features.
>=20
CAAM is used as a trusted source for trusted keyring. CAAM can expose these=
 keys either as plain key or HBK(hardware bound key- managed by the hardwar=
e only and never visible in plain outside of hardware).

Thus, Keys that are inside CAAM-backed-trusted-keyring, can either be plain=
 key or HBK. So the trusted-key-payload requires additional flag & info(key=
-encryption-protocol)  to help differentiate it from each other. Now when C=
AAM trusted-key is presented to the kernel crypto framework, the additional=
 information associated with the key, needs to be passed to the hardware dr=
iver. Currently the kernel keyring and kernel crypto frameworks are associa=
ted for plain key, but completely dis-associated for HBK. This patch addres=
ses this problem.

Similar capabilities (trusted source), are there in other crypto accelerato=
rs on NXP SoC(s). Having hardware specific crypto algorithm name, does not =
seems to be a scalable solution.

> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au> Home Page:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fgondor=
.ap
> ana.org.au%2F~herbert%2F&amp;data=3D05%7C01%7Cpankaj.gupta%40nxp.com
> %7C33055110772a4d4bb97508daa8317e93%7C686ea1d3bc2b4c6fa92cd99c5c3
> 01635%7C0%7C0%7C638007227793511347%7CUnknown%7CTWFpbGZsb3d8ey
> JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> 3000%7C%7C%7C&amp;sdata=3DH0fzzxQhsV%2FyPphBAHBDmzQfTFnjDE7jYstTM
> ok%2F09I%3D&amp;reserved=3D0
> PGP Key:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fgondor=
.ap
> ana.org.au%2F~herbert%2Fpubkey.txt&amp;data=3D05%7C01%7Cpankaj.gupta%4
> 0nxp.com%7C33055110772a4d4bb97508daa8317e93%7C686ea1d3bc2b4c6fa9
> 2cd99c5c301635%7C0%7C0%7C638007227793667554%7CUnknown%7CTWFpb
> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M
> n0%3D%7C3000%7C%7C%7C&amp;sdata=3DSclJ9G7jBWhOW%2Fm3Gt0jP1oicqVp
> 5ghH%2BDT8Vd5maag%3D&amp;reserved=3D0
