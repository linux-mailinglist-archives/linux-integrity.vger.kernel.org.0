Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63434C9C9F
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Mar 2022 05:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbiCBEoc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Mar 2022 23:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbiCBEob (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Mar 2022 23:44:31 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140075.outbound.protection.outlook.com [40.107.14.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D03B10A4;
        Tue,  1 Mar 2022 20:43:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuOEwbsvhSnI6oOumxzWmu7OYKSqtijZs/6CZPDqk1nHeAjGbrwuFIvyz9cBybrTofxNJMgfPUaN+ZEZK4YU6kjhVbQTPlj8Up0TcorHKvGwTY1z9447jHJTiA8T6vTy1aRC3ymOlZJR4aRRiIaf16eltvu32nE/hKEeId2hyhT/fFzm6tG3Y0L21crvbCKeFE2bcAKXlSHmlKfVWgUOJYUki09Cx0xSFvCgyPYqIMMZceU0uWX+x5ihY2V/GaqaWmbI0Yc37SvimUqCdsd0OCKAd+GWrAYRTYVqzTG04sva5rP1kb+TkyLESmBvmVkDMEA78Cc028eyg2AEF3+cfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiJPBHbQARh83A4Mh9hgcoF8TKdRGDn4epVJw7FWapk=;
 b=J4CRF0/F/DUd+uIkiGylNQ8vHbYhGcU+b4POfcbLR27dq/f8kRt3CXyaIUwcwr1Gor+0HLGoOle3WnkOcWeMPkopTFOT3bAdb5yL7PmLDCpIwrvfKwEtD2xdHtUOyQxwDn35HhIWDcpRCfv1XwYKf4FnbDySt0M5GICkWdzI23N/4U6rfGIR/RGHu8KW7ktYUJePreLrLdyD3uoUPbpwQKVqSpMYvNHzBh322AgmcM/gPV/FSwD0gAJAOK+MN57uCN9eDQOLxD2XsijxBmBfZDRVj1+XEFqyQtYS96dLS4reCqnNLw3b1c0gHEPgp+nlcRMPqeNeTGIPrAaSL6uFxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hiJPBHbQARh83A4Mh9hgcoF8TKdRGDn4epVJw7FWapk=;
 b=bnkzUZNyvnuuR9jjxj93VRAQSVd8wB31S75INlIgToa6YMElWqUoRbt1l5tjjH5iLiOuSELSGMxNA4M3lU9tWahO3OqWXAlz6L4wcnbk5QNhx5kGNw1Og9nWjIl1Z57GH5hMWFy3jwSq6ewvVQdUZ398WRRmJldiALPc+YJJb1I=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by DB6PR04MB3174.eurprd04.prod.outlook.com (2603:10a6:6:c::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Wed, 2 Mar 2022 04:43:42 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::f92e:7648:49d2:d017]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::f92e:7648:49d2:d017%5]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 04:43:42 +0000
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
Thread-Index: AQHYKNGtB/drzUl2a02HqOqaymkrp6yriiew
Date:   Wed, 2 Mar 2022 04:43:42 +0000
Message-ID: <DU2PR04MB8630747D195F49D56A5D7E2195039@DU2PR04MB8630.eurprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: e9fb6b91-d4df-4623-7c66-08d9fc073a47
x-ms-traffictypediagnostic: DB6PR04MB3174:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB6PR04MB3174A189B17DDE7A5882ADF795039@DB6PR04MB3174.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LaEnl/HxUGhM62TRVCMUl1NAwjcM+23Rdn7en8tuuCrQQ+o8kcekONGvPKtscDSoQQM/29wRXKvOon6F8c/4cqteftFypTDBiIvFnXhaLx/oViTwSotuKa1R7Gh+zLQ1GpRfxATa/OOdfVgFw+rZC9DOuw4QZpDH3ftRAMfdWo/JT9Zx2fdSMnn+vuZRjtjZhRo5rxzYrOG2dxD7018qXTvpegmCwjP18CUoDUCD0dhruJEikgAKugfslwhXIXj0PmE+CKagllQ4QsHXzVMsjGt03YvxKCtaXpUfteaju4ZzLKljtd6q0m4otH8wtXh9+ilnYKBnwfbfwnx+Pg09cA8HnsD+piaaD4h1NMBNenmhW0cju/9DjbqOzBtoN80kLuKBVtDsqCRLPDU5ytKJyZUQPUhU+FUaY519iQQlL22T5reWqonZU0pU6OEHaOyB9Sv69NaiO3k2zyx6xW+cCrm81iM6DgECvTNuxOZyYVOt8FGH/w18dRPd1D9ndfEeuL/k8VJHMKWyLHufU+myjFmmpOIpc++E1XLY2AnB0VkW5J2uwc6k8fHCpNALJVmxYsqSVLkhamjpyaJquoyl0w05XNHXK9W5sWD3yLCtI2gfZ4kLrtJ2m3FwBkH+HHKq6iOJOS7Ce6ZNqKI76UMRSjF70l4+hyIWo83leVAa4636O13Cs2j0xwsJvvK2M7YMLUKzZBuapzm5bRGWTEp86NPmzLClm61bBHk/Zj3NXz+k4W7Bd07LNavOugWdVJcYekopQsjXFs7Ho1DkB4zOwsVVBItcftoTRiOshR5yfKM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(38100700002)(86362001)(122000001)(186003)(966005)(26005)(83380400001)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(38070700005)(55016003)(7696005)(45080400002)(6506007)(53546011)(55236004)(9686003)(71200400001)(54906003)(110136005)(316002)(33656002)(4326008)(5660300002)(2906002)(7416002)(8676002)(8936002)(52536014)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?Y0aK7YP0HfCbx1lPBuO+ecXh0iKYYFaIdUMSFm8IM+o3U8WzCo3TNqA4sR?=
 =?iso-8859-2?Q?JQKL1ToGueN4qkSrShUo3LWGlT1Cf9uU6nW5MRbIccN9b+J3REIc5ycYuJ?=
 =?iso-8859-2?Q?fJf6rz+9pywmSEdci7K4V8GO0XebqcAHpm/31xczcwHLFgOFaaY+DvF0eS?=
 =?iso-8859-2?Q?TTlVqEDEkADohyhwixSrN7IjXK9kZl0ZXmAfvYIuqB851nisL0dejgw5Fx?=
 =?iso-8859-2?Q?Hjsli3zceKkcq3kPFnx/5V8aBG2r7GNivYs1iA4DIP5WVfbtO3f7+8X5yv?=
 =?iso-8859-2?Q?9N3QsJOH+H+azz8pO95w8OZTo96H2kgaXxE217HLzEWaQhhHrwRSCqupQI?=
 =?iso-8859-2?Q?7KSGoYT2Xm4mYNWDiRClF0Sz5bRdRhD1nyye13wNucqkB1iDco4nhhxVcz?=
 =?iso-8859-2?Q?PNkNI4NvjSbP1ccYby56Y+alZMPhUuQjkykpxKFuW7KbBnHnLPQKjJlnXB?=
 =?iso-8859-2?Q?eqA6vyV1oWNoxtCCsOPUR3EkCyiQqfQ2CAEVjfwFapzYW/seQe/6Wdpl92?=
 =?iso-8859-2?Q?2pk7TRIMFw0XtjdBGeg9zuu3PrIQ3fTCyhXvoWKlFx2ijosheYzCU+RFt/?=
 =?iso-8859-2?Q?yQ/YSn5luVD945PmPnmGEJEo/4ggogdQPlx3w/DEpgvelH3tt+S3Dbk2jg?=
 =?iso-8859-2?Q?hWm2Thli9bpsPEq3YPU5JfB1btc8dHWfCZeggT8f7c8SD1q5b18qO6eWsY?=
 =?iso-8859-2?Q?5m/z3jZ5Fv+8sNcwd8P5K+1CwxbH752RKW3kGaOF7EqgFKxFRXEK6XT7qO?=
 =?iso-8859-2?Q?k0961RNJ7EeSGt+uP4CnZ3yDwcAxl17R6tUAcq2+o1xm+6KxP69FVGuMmp?=
 =?iso-8859-2?Q?cnUm9AeKccyr1WeMZ4/r+UOXQYgQ4hEFBuT0CyvYRojdP5G6ZhH5/kK0xM?=
 =?iso-8859-2?Q?qcYJwtvHXh4bY+bq2VsNuyjC9wVR5f3+PF5xhlMNEZzCGUtLDfRg3c4+Yj?=
 =?iso-8859-2?Q?9CL0JOvhvJR2HF0kH47y5Ukhf5g1lcmp82eWLHjRpHE/n7xZJtRVZ2yiEN?=
 =?iso-8859-2?Q?ACkvsFC2k9eKvouYSimbgDntnBPOeLMdKuetQpikzgDBCKrcrar1kV1c0I?=
 =?iso-8859-2?Q?RDhmDkcc0wuZCs8FswEazlktr8NRJy6iFRitjMMA5Uv5GClaAnvbjbFLYw?=
 =?iso-8859-2?Q?2NAdZjMcTF7xWLS/dHHfW+Y9MjdcWGV2ViDedWtK6SPyMKCHLKE3uINiJ8?=
 =?iso-8859-2?Q?TK1SCXzgtKebL1FTu4sWYqYX8p3m06ZSaF/tyGFP74I7F2sS67u7/79v/d?=
 =?iso-8859-2?Q?7QHjxO5fQpZUVlYe2Z0Htd/3vgu6AM1SyYgVDIO1qaC0bj0ejFRMmtMI0C?=
 =?iso-8859-2?Q?80c/3di97bkHnFbcWDro2ozYTvIyUiZ2Sly8Gc/sdISleS7nx0PIkjmCAN?=
 =?iso-8859-2?Q?eUKzSBZ/OKLcO01HsfeGX5uxB8YM7ab5iz9HbUDi9OHWkcnqlbVoQHlSSk?=
 =?iso-8859-2?Q?iq9+mcE756Fdo7om48oimKfybd/t2uL8CXZIxDYHYDSWWPLLCXZ5uRy+N8?=
 =?iso-8859-2?Q?/PrkkKB2rcs+txoxeWvvsflW2ADElvStQocuQRWBjjajFhX6XhEcBaf/wx?=
 =?iso-8859-2?Q?f+PHsrDcDBurt+GTcwfvKHcQVr9Faietd+0LrpXNPOTSd4B9hSgcMCE0Ay?=
 =?iso-8859-2?Q?FrLQr2VLl8CX7+RPOKQEUoEzos6Ixd14RHZnnWoxrJkLt97rRGPJjh1Inf?=
 =?iso-8859-2?Q?N9nSEp//i3jTVeEjNWg=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9fb6b91-d4df-4623-7c66-08d9fc073a47
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 04:43:42.1901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3SjktrL2/dCBw3OFvp0DMSHJD5vUKx2B9hXJk/dRkWXhnoUvcNxdPIZZCK8htv9Qf+UxZN61WdjXbWTKCS1w9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3174
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Acked-by: Pankaj Gupta <pankaj.gupta@nxp.com>

Regards
Pankaj

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
> <horia.geanta@nxp.com>; Aymen Sghaier <aymen.sghaier@nxp.com>;
> Herbert Xu <herbert@gondor.apana.org.au>; David S. Miller
> <davem@davemloft.net>; Eric Biggers <ebiggers@kernel.org>; Jan Luebbe
> <j.luebbe@pengutronix.de>; Richard Weinberger <richard@nod.at>; Franck
> Lenormand <franck.lenormand@nxp.com>; Matthias Schiffer
> <matthias.schiffer@ew.tq-group.com>; Pankaj Gupta
> <pankaj.gupta@nxp.com>; keyrings@vger.kernel.org; linux-
> crypto@vger.kernel.org; linux-integrity@vger.kernel.org; linux-
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
> The rebase on the change in scope of the previous commit made this one
> here quite small. I would squash it into the previous commit for v6, unle=
ss
> there are objections.
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
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=3D04%7C01%7Cpankaj.gupta%40nxp.com%7Cd
> 6143a1791a8494849f208d9f6e8cef8%7C686ea1d3bc2b4c6fa92cd99c5c301635
> %7C0%7C0%7C637812302026139014%7CUnknown%7CTWFpbGZsb3d8eyJWIj
> oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3
> 000&amp;sdata=3D2QRFygy%2BVafXrLIkF1BOHtDiwP%2Fz9kwU9ovtG1WJBTY
> %3D&amp;reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|
