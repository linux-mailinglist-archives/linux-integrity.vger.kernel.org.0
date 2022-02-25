Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8374C447D
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Feb 2022 13:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238332AbiBYMVb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Feb 2022 07:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbiBYMV3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Feb 2022 07:21:29 -0500
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00084.outbound.protection.outlook.com [40.107.0.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414311C3D13;
        Fri, 25 Feb 2022 04:20:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGPmCQHZ3zVXrXJpEp/EE14Jz0DwE/l2cbK1Xmbkq2tBtV5buinkREf4daE5uOqmktAewCvYYmVXR8+e0l92ZfGArA2Cww+5K6T6wCWthAFaAusaF0OCubXVxSRx7b2RbBNRKT0qa62HbfDDwo7bFlV//X68vDYd+5i7DzxxJIFlzQhhZuqCMIcBs/sURgsPp4P1IIawhAG11okO3SmXjUSbhdFDYUHexDtCnxwh+HgFIXF1AjoFSV8qUqEPNrTYnZe+l0XKPWdIj1ynbLjkN670cTHyIZimGW8oJUhdmPwFpQ4wtRHzXWKfHFAS3D5yvg0y8bO1RjJ82koWWxSwwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qj3GbyS3ci7+f5bRsdZocHmJhwiWXaTcQCiMegdZ4bY=;
 b=gvULrzf+xRxtwLGINWdlFTJStF+rjNOh0MibAonDnBkHzRAxU8fWrGWgOoPREIqrJPUayblI03oY6Il23ZRxRea0SIh4ZEhOEx/dAJ32zk9/OfunEbTdYWU/115T9aM2LEK/B93tPYQj2CIYGerQwGf/bCPxa/KGyB1ThBeXCatM0Id9uOw8qonHagjRxlxQUTlyCfCGOkh1Bhcsrs0PPXGfGnOEB0VcS9VxQaWLXGNKsEn8GiZj9w2P25DIJRtI6lxTvVjCsKfk3EHRRv+osfZuX2sG1KupUnVdffvM53aeTnpEqlIuP86uFDPCgLfG8hupXV5z8sfmP505j0coqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qj3GbyS3ci7+f5bRsdZocHmJhwiWXaTcQCiMegdZ4bY=;
 b=U1xNojoLcOrXIizLC1SIZThd1CKEiGWZ7QEhjMZYXjILaFdqJnbmSnxYzDU/0296fe4fvL6wjKcv7H5+HX06dr9LnFILwl89uOEMxT1aTjx8rz/fOaD0fFXwJzZwlDy6OAkLfD6rYL2Nx00RTACo5UyqZ4xaVWgYqhTVoTZrUGo=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AM0PR04MB4945.eurprd04.prod.outlook.com (2603:10a6:208:c5::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 12:20:54 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::f92e:7648:49d2:d017]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::f92e:7648:49d2:d017%5]) with mapi id 15.20.5017.024; Fri, 25 Feb 2022
 12:20:54 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
CC:     Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v5 4/5] crypto: caam - add in-kernel interface
 for blob generator
Thread-Topic: [EXT] Re: [PATCH v5 4/5] crypto: caam - add in-kernel interface
 for blob generator
Thread-Index: AQHYKMu29wEgG18aYk6KcocJX/sIp6yhUPGAgALbRkA=
Date:   Fri, 25 Feb 2022 12:20:54 +0000
Message-ID: <DU2PR04MB863084B70239A69E4DE9D65B953E9@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20220222195819.2313913-1-a.fatoum@pengutronix.de>
 <20220222195819.2313913-5-a.fatoum@pengutronix.de> <YhZVmBy3/nWbqf+/@iki.fi>
 <a8cb99e0-fe01-2234-9839-fea28ca09f6d@pengutronix.de>
In-Reply-To: <a8cb99e0-fe01-2234-9839-fea28ca09f6d@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c213e2c-4651-4ddf-7141-08d9f8594511
x-ms-traffictypediagnostic: AM0PR04MB4945:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM0PR04MB49452B6C99AB5885F8A7A373953E9@AM0PR04MB4945.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WCS4+wOgE5xWvCyHKhsBBmjTETGvf61Lg2zaJfRrTA+GaEk+ZgevkVanUze4HG8K0CVsQOdpIcY+P2SjeZ51d56iu1qIvRHSQy8JV6BplAlxoQJaUUgPzNbZYh94u5BbJM7/HeAYmshryEFhMl1sNYuizqguz3mJ2HuZSvteUMZ3kk3bvpL/4WnYg0ENTfol4uf5uX/M7sb3jl91esyhWvZpJRy6lHbG+Zush5COSmhPl95t92HCSufVUotXTnlScg3Wp1sgYQg7Qyo1pVFpwoBUcKR4J6llff5tJJXkk5lRsBVy+9MswI3n6oM7nGxg8oNlG5vVzyM3X2liQrV6GUQwiiRDRjXGvRF6YZi1+X/Ns01QO5xTOpolz3jrGhCP4140U9J6XWvO0ay3ZA9InDh8GnsUDpFBFnBOzmcgEXhniaYMXhjdZWhDKGlIBsVEyXt+xzsyldJzbT1Jd7W9TVkf+EStzKOD/iYnatnLtB56SDavSj5OUCIBBlLtfkEbMuCjvcMRNFMK8jetOZPz028bX62VVgIZNnds87jsHIv9H7KDA0QpPfdeHNyWwgZ/xLc6Rksxug0wOXxrTHS/3bueF9WMmiNF0qfptPoMN6o8dKpesfEmKimc/JVtVahzYAEl2Ea6PA1FyQSAIA5Kw9ki1s7nLpNH/gW/pBOEd9PkYDP3qhmHdJuOL6vVSSH1fgHP2rZLa+8/3zietqx2SqBMCcHicgXdsZWZRrkMxF/2IxopjWMyNgiwp08/K9dIWrUmxqyZmf9CM0MWH2JUMd0LaAYXcBDDciONjvCk5YY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(64756008)(45080400002)(66446008)(66946007)(66556008)(66476007)(122000001)(86362001)(508600001)(38100700002)(316002)(76116006)(110136005)(966005)(54906003)(71200400001)(55016003)(6506007)(9686003)(7696005)(33656002)(8676002)(55236004)(38070700005)(44832011)(52536014)(7416002)(53546011)(5660300002)(26005)(186003)(83380400001)(2906002)(4326008)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?0x+3wklkru38YR/LcsKnUmGY6QOizIBRHShVmlry34rLKZofx2dD1O/jzH?=
 =?iso-8859-2?Q?erh463BzHgZO3mEcrub2Jhrj98qDbYkvefFy59ViTyxccSvhEgboYsZ5IW?=
 =?iso-8859-2?Q?scl+SGdK3JiL38Xi5jzfVj/xJBUJmLNfOun+/r0YO5EU1BeRDvpRVLeDS7?=
 =?iso-8859-2?Q?pZuqIzxIsyWAUeW69appidPuTN6bDqR+G+wPUFD+p0a30pibOCDEiuaiIC?=
 =?iso-8859-2?Q?vTY9xdP8FukA5/WE6Klyv/7SkP/Og5EpDrJGFtjWQ8aLa2AzS6dCMJd1o1?=
 =?iso-8859-2?Q?xoBbecwL2XhHz7OJzAdXQNncPkn5HXbEQU8qEH4MmM/auwLlSlDoml2QdH?=
 =?iso-8859-2?Q?uxaeF0PQ+82ArOygFpmXQyWpvHpeApf/OSokyc/VIPZtsUnh+RX+mX67x6?=
 =?iso-8859-2?Q?N3TMyRnQCReSdLsvXHlKePqLOIwVvR7YkrFyYT5zbhWsn6OpCt/aWd9dGe?=
 =?iso-8859-2?Q?Q/y09yZizzhG2ceMaz92I1BcdH1VwD7mKHdfkDM83wfmhfUkONslGqVzdB?=
 =?iso-8859-2?Q?bKGCnGoFWMkYTYWgN4ZtXsdSUdoJLj9eWSeaPWODPs1mwJsLmZi9tOepGW?=
 =?iso-8859-2?Q?/oJcQUoGYcDrF82s/PM4rXR7+7FlDOm83AuFcbFwP5L6MMSCetC4n2tEBu?=
 =?iso-8859-2?Q?8HjPzxl4OQlEeYDCjLcvyJ73r92ezvoyEVA3Hr32zgpihT0ky8QkQ9AcT8?=
 =?iso-8859-2?Q?a+A6aYwEWf2i3D7n1Ck+1TXpC46ULECGeJgf7QuF/zVm0F/NSw+MMtTOdq?=
 =?iso-8859-2?Q?lwAdxr/oCwRwUbzE+vbC4i0h0OqBKKpqmc3iik4PDAn8BqXPbTbw/7Lm3k?=
 =?iso-8859-2?Q?2r1jgdKhnGVV8oV4V8es5N/7nQeWOHvkQCIq4w/dgvJ7EocNPTuPcmSlWJ?=
 =?iso-8859-2?Q?HlyG1omgnDFN3WGaBJ5QtLKRmMho+1pvwnOmjYyS9P+T/50BsT/u+xSnZ5?=
 =?iso-8859-2?Q?4W05H0O1z2zD5J8Q47/cPQvJXtiRoLP2R0S2ya6LqNtHI9qW5m5MlT4sTo?=
 =?iso-8859-2?Q?yVno2T00h9CQnF3slWxrmS55b5x66bAqmkFjbPHqGq9WLI9vEJkvgIiB0X?=
 =?iso-8859-2?Q?OYnrEfavGW6M3A0EXDZw9fQBzKhFvm1yHbtqEsMfIYK2eXSmObYKZeWTP4?=
 =?iso-8859-2?Q?rTcpiZ9U61p+o0YvgsghBU72zaa0d7thfB9PE3aeRve9lhSLy+2ccB1FLV?=
 =?iso-8859-2?Q?fHBHLR43oViij5/yrdh3IIKABdE8sYGO/W16PyrokPY/svwBo+g2lahs+b?=
 =?iso-8859-2?Q?Tds0pYbaoNe/5tA3LKbP5+kcMB6b7i3TTLQZ01fyNcFNe7vxog4SEv74of?=
 =?iso-8859-2?Q?uBSTNMjh1V7LbWaUr6LThfKYqWOo/o9jpwzSXhs14igGmqpgESI7pVoKHA?=
 =?iso-8859-2?Q?jZLekeMrTOT0RHA/mjm+cSGzh0ck3T1zP7/58U8uF2oQe/y8dm9SrvcDVE?=
 =?iso-8859-2?Q?tR5xkr+lrQbry++I2RXP4uf/sW7MiOms7fcMRl0S8FQ3NjvVu0FiraCiFm?=
 =?iso-8859-2?Q?VFhBGs1l2q0QiLHUfRvCOXyujbe9DfNjHLeRAX1L9D2wqiGD6IYKXZ5mHI?=
 =?iso-8859-2?Q?8Tdm26dNj8+/jXvYHZSOjM7ULaxT8jEUzC1aCAvw1EMCFIXOtitUn8c0lx?=
 =?iso-8859-2?Q?NEI9j0d+OeRRj9qkNtieqTkIzDpYLSnxgBc1tq+VfOXelpV+qIVLs1+hA4?=
 =?iso-8859-2?Q?AlwYahhVadWKaUNCmP4=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c213e2c-4651-4ddf-7141-08d9f8594511
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 12:20:54.2934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xf5wirHgjxlMWyjb5ldb+cLXI0hF8OG0yI52RtJeh0QrUzDL8hQHaAY6SuNi3qkKgItX6LoSSGBScsqy5GHdtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4945
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
> From: Ahmad Fatoum <a.fatoum@pengutronix.de>
> Sent: Wednesday, February 23, 2022 9:50 PM
> To: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Horia Geanta <horia.geanta@nxp.com>; Aymen Sghaier
> <aymen.sghaier@nxp.com>; Herbert Xu <herbert@gondor.apana.org.au>;
> David S. Miller <davem@davemloft.net>; kernel@pengutronix.de; David Gstir
> <david@sigma-star.at>; Pankaj Gupta <pankaj.gupta@nxp.com>;
> tharvey@gateworks.com; Matthias Schiffer <matthias.schiffer@ew.tq-
> group.com>; James Bottomley <jejb@linux.ibm.com>; Mimi Zohar
> <zohar@linux.ibm.com>; David Howells <dhowells@redhat.com>; James Morris
> <jmorris@namei.org>; Eric Biggers <ebiggers@kernel.org>; Serge E. Hallyn
> <serge@hallyn.com>; Jan Luebbe <j.luebbe@pengutronix.de>; Richard
> Weinberger <richard@nod.at>; Franck Lenormand
> <franck.lenormand@nxp.com>; Sumit Garg <sumit.garg@linaro.org>; linux-
> integrity@vger.kernel.org; keyrings@vger.kernel.org; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org; linux-security-
> module@vger.kernel.org
> Subject: [EXT] Re: [PATCH v5 4/5] crypto: caam - add in-kernel interface =
for blob
> generator
>=20
> Caution: EXT Email
>=20
> On 23.02.22 16:41, Jarkko Sakkinen wrote:
> > On Tue, Feb 22, 2022 at 08:58:18PM +0100, Ahmad Fatoum wrote:
> >> The NXP Cryptographic Acceleration and Assurance Module (CAAM) can be
> >> used to protect user-defined data across system reboot:
> >>
> >>   - When the system is fused and boots into secure state, the master
> >>     key is a unique never-disclosed device-specific key
> >>   - random key is encrypted by key derived from master key
> >>   - data is encrypted using the random key
> >>   - encrypted data and its encrypted random key are stored alongside
> >>   - This blob can now be safely stored in non-volatile memory
> >>
> >> On next power-on:
> >>   - blob is loaded into CAAM
> >>   - CAAM writes decrypted data either into memory or key register
> >>
> >> Add functions to realize encrypting and decrypting into memory
> >> alongside the CAAM driver.
> >>
> >> They will be used in a later commit as a source for the trusted key
> >> seal/unseal mechanism.
> >>
> >> Reviewed-by: David Gstir <david@sigma-star.at>
> >> Reviewed-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> >> Tested-By: Tim Harvey <tharvey@gateworks.com>
> >> Tested-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> >> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> >> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> >> ---
> >> To: "Horia Geant=E3" <horia.geanta@nxp.com>
> >> To: Aymen Sghaier <aymen.sghaier@nxp.com>
> >> To: Herbert Xu <herbert@gondor.apana.org.au>
> >> To: "David S. Miller" <davem@davemloft.net>
> >> Cc: James Bottomley <jejb@linux.ibm.com>
> >> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> >> Cc: Mimi Zohar <zohar@linux.ibm.com>
> >> Cc: David Howells <dhowells@redhat.com>
> >> Cc: James Morris <jmorris@namei.org>
> >> Cc: Eric Biggers <ebiggers@kernel.org>
> >> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> >> Cc: Jan Luebbe <j.luebbe@pengutronix.de>
> >> Cc: David Gstir <david@sigma-star.at>
> >> Cc: Richard Weinberger <richard@nod.at>
> >> Cc: Franck LENORMAND <franck.lenormand@nxp.com>
> >> Cc: Sumit Garg <sumit.garg@linaro.org>
> >> Cc: Tim Harvey <tharvey@gateworks.com>
> >> Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> >> Cc: Pankaj Gupta <pankaj.gupta@nxp.com>
> >> Cc: linux-integrity@vger.kernel.org
> >> Cc: keyrings@vger.kernel.org
> >> Cc: linux-crypto@vger.kernel.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Cc: linux-security-module@vger.kernel.org
> >> ---
> >>  drivers/crypto/caam/Kconfig    |   3 +
> >>  drivers/crypto/caam/Makefile   |   1 +
> >>  drivers/crypto/caam/blob_gen.c | 230
> +++++++++++++++++++++++++++++++++
> >>  include/soc/fsl/caam-blob.h    |  56 ++++++++
> >>  4 files changed, 290 insertions(+)
> >>  create mode 100644 drivers/crypto/caam/blob_gen.c  create mode
> >> 100644 include/soc/fsl/caam-blob.h
> >>
> >> diff --git a/drivers/crypto/caam/Kconfig
> >> b/drivers/crypto/caam/Kconfig index 84ea7cba5ee5..ea9f8b1ae981 100644
> >> --- a/drivers/crypto/caam/Kconfig
> >> +++ b/drivers/crypto/caam/Kconfig
> >> @@ -151,6 +151,9 @@ config CRYPTO_DEV_FSL_CAAM_RNG_API
> >>        Selecting this will register the SEC4 hardware rng to
> >>        the hw_random API for supplying the kernel entropy pool.
> >>
> >> +config CRYPTO_DEV_FSL_CAAM_BLOB_GEN
> >> +    bool
> >> +
> >>  endif # CRYPTO_DEV_FSL_CAAM_JR
> >>
> >>  endif # CRYPTO_DEV_FSL_CAAM
> >> diff --git a/drivers/crypto/caam/Makefile
> >> b/drivers/crypto/caam/Makefile index 3570286eb9ce..25f7ae5a4642
> >> 100644
> >> --- a/drivers/crypto/caam/Makefile
> >> +++ b/drivers/crypto/caam/Makefile
> >> @@ -21,6 +21,7 @@ caam_jr-
> $(CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_QI)
> >> +=3D caamalg_qi.o
> >>  caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_AHASH_API) +=3D caamhash.o
> >>  caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_RNG_API) +=3D caamrng.o
> >>  caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_PKC_API) +=3D caampkc.o
> >> pkc_desc.o
> >> +caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_BLOB_GEN) +=3D blob_gen.o
> >>
> >>  caam-$(CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_QI) +=3D qi.o  ifneq
> >> ($(CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_QI),)
> >> diff --git a/drivers/crypto/caam/blob_gen.c
> >> b/drivers/crypto/caam/blob_gen.c new file mode 100644 index
> >> 000000000000..513d3f90e438
> >> --- /dev/null
> >> +++ b/drivers/crypto/caam/blob_gen.c
> >> @@ -0,0 +1,230 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Copyright (C) 2015 Pengutronix, Steffen Trumtrar
> >> +<kernel@pengutronix.de>
> >> + * Copyright (C) 2021 Pengutronix, Ahmad Fatoum
> >> +<kernel@pengutronix.de>  */
> >> +
> >> +#include <linux/device.h>
> >> +#include <soc/fsl/caam-blob.h>
> >> +
> >> +#include "compat.h"
> >> +#include "desc_constr.h"
> >> +#include "desc.h"
> >> +#include "error.h"
> >> +#include "intern.h"
> >> +#include "jr.h"
> >> +#include "regs.h"
> >> +
> >> +struct caam_blob_priv {
> >> +    struct device jrdev;
> >> +};
> >> +
> >> +struct caam_blob_job_result {
> >> +    int err;
> >> +    struct completion completion;
> >> +};
> >> +
> >> +static void caam_blob_job_done(struct device *dev, u32 *desc, u32
> >> +err, void *context) {
> >> +    struct caam_blob_job_result *res =3D context;
> >> +    int ecode =3D 0;
> >> +
> >> +    dev_dbg(dev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
> >> +
> >> +    if (err)
> >> +            ecode =3D caam_jr_strstatus(dev, err);
> >> +
> >> +    res->err =3D ecode;
> >> +
> >> +    /*
> >> +     * Upon completion, desc points to a buffer containing a CAAM job
> >> +     * descriptor which encapsulates data into an externally-storable
> >> +     * blob.
> >> +     */
> >> +    complete(&res->completion);
> >> +}
> >> +
> >> +static u32 *caam_blob_alloc_desc(size_t keymod_len) {
> >> +    size_t len;
> >> +
> >> +    /* header + (key mod immediate) + 2x pointers + op */
> >> +    len =3D 4 + (4 + ALIGN(keymod_len, 4)) + 2*(4 + 4 +
> >> + CAAM_PTR_SZ_MAX) + 4;
> >
> > Nit: the amount of magic numbers is overwhelming here. I neither
> > understand the statement nor how that comment should help me to
> understand it.
>=20
> header              =3D  4
> (key mod immediate) =3D (4 + ALIGN(keymod_len, 4))
> 2x pointer          =3D  2 * (4 + 4 + CAAM_PTR_SZ_MAX)
> op                  =3D  4

Instead of the function caam_blob_alloc_desc(), it will be great if the cal=
ler functions caam_encap_blob()/caam_encap_blob (), could add local array:
uint32_t desc[CAAM_DESC_BYTES_MAX];

>=20
> I haven't heard back from the CAAM maintainers yet since v1. Perhaps now =
is a
> good occasion to chime in? :-)
>=20
> @Jarkko, could you take a look at patch 5? That's the gist of the series =
and I
> have yet to get maintainer feedback on that one.
>=20
> Cheers,
> Ahmad
>=20
>=20
> >
> > BR, Jarkko
> >
>=20
>=20
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.pe=
n
> gutronix.de%2F&amp;data=3D04%7C01%7Cpankaj.gupta%40nxp.com%7Cc97e9d4
> aaf304124407908d9f6e87101%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> 7C0%7C637812300459173929%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL
> jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;s
> data=3DCvnfIXR68DPRCaYrOYQKSv2eSBSNSSJYx2BQJee4yLg%3D&amp;reserved=3D0
> |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|
