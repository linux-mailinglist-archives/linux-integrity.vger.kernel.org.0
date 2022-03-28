Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A6A4E914D
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Mar 2022 11:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239817AbiC1JbG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Mar 2022 05:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239811AbiC1JbE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Mar 2022 05:31:04 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10080.outbound.protection.outlook.com [40.107.1.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543E13CA5D;
        Mon, 28 Mar 2022 02:29:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HU9j/BE11W/QOJl/YqF+Kkklh0L8UAnraGcc24Ky1IeOL86mPSacBu0JS1IGMrv2o7t2SZ1vgnCPQlo3xNPT/TZY7eCu8J9msZnep+hqq9okZUMfkynRESPWsO+nYg3sESQCMCpDS44gAGIaLIuISVouxQ6L5uJNo+CJv0iyYnsv8gGHLd1rjEsLXlkv6wnyXb29XYyLHosu2SZg9dBS/nQjiaoTOXXKXObItzlMUtJmNXSiN/pN3Qvd72wU1Plm/lrRFGQLA+2K4k6T1LDsPpNUZZvYdMIKpMWnOja2Tsxu+WmC5le571I3s4Je15uzu4BePZZFHpQKovCydXk++g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmHuvG4R1k/1tI6uEuof648WQUCUdIpwuGB/OyyIPuo=;
 b=Zt3NvPOuQv+ALjXjOMUT9pjU4h8ZZwy8MysS1763+w7Ul8hEkQ4G8mjeDoPmlKRJZd3KxFADTtFscqlRA8nloLiBznP8eGpdV00lDlYmmtVrpIqqZSiWKvivFNr7igTTH/7u/+0xmd8Nl6u4RaPcoov6rOtRZUxb5m2lwhNZPtGWZmMgHnIfag8eZIpB1a/9PnSqu+M6vfZMXuH8gADFNgLx4zqn6/y3IcyVIoUgy9j7upSi5db+W7xAH+MYvAmKCqewKvNCS59AInep9KPFkUOxtOuvLqGdeCtSwa4U808pyxQ/gZRlnyTq/Qy2l8U/xvTUCfH9jfQxZ/9I+ozMfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmHuvG4R1k/1tI6uEuof648WQUCUdIpwuGB/OyyIPuo=;
 b=Nr9Xm+p1rFLhSHGLBtB9zGtbWM87j71JZg6Dhg6peiTbZ9EKL204/sGCd0NmmhTA7ihk5urUxAsFSgFDN96gtP6rq86T8NnD0Rg2ut8Ec8RPByA2NJ/jzoFz+36wInHEGSb1gx7YZi86x5bwwGVvDp9YGbvPE3uLNqCP202wLYY=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AM9PR04MB8164.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 09:29:12 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::143:fed1:d645:f60b]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::143:fed1:d645:f60b%7]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 09:29:12 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Horia Geanta <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        David Gstir <david@sigma-star.at>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: RE: [EXT] [PATCH v6 3/4] crypto: caam - add in-kernel interface for
 blob generator
Thread-Topic: [EXT] [PATCH v6 3/4] crypto: caam - add in-kernel interface for
 blob generator
Thread-Index: AQHYOVUNOyYgdbVIskOFW8XkCJYEX6zOQs5wgAAZNICABjWmsA==
Date:   Mon, 28 Mar 2022 09:29:12 +0000
Message-ID: <DU2PR04MB86306DE99EA993BF596BA729951D9@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20220316164335.1720255-1-a.fatoum@pengutronix.de>
 <20220316164335.1720255-4-a.fatoum@pengutronix.de>
 <DU2PR04MB8630BDFC29AA31074C623A7B95199@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <ae941471-43c0-1aea-2567-89eed98a61a6@pengutronix.de>
In-Reply-To: <ae941471-43c0-1aea-2567-89eed98a61a6@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a26d9f2b-826c-49de-e131-08da109d6b6f
x-ms-traffictypediagnostic: AM9PR04MB8164:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM9PR04MB8164FB43AEE08B8F175E57C9951D9@AM9PR04MB8164.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qwS3ich4rLt201Z4rUEdCfv+YiBbi6bCQIUYvpIXtxKQSLdabgG0r8L2kjgyx2/2Lb38GGgIsWJU9BAAJOZ6UfdMZB2GmZuqKFGIph7KT4z0hw7F5nDDwUvHA38BUNqueoYqpS+zo/ByFeygHSr3erESOHloZSQJeVxEZAHmalumtH3u8rQauZyPurcHi6rbGyubUlHdnjz/esWid0tJ6Va4vSm3ESPk/cDKO5h+poj2FrfhsZNlvXf2MOA2yllGzadii07M0LEcyipboHBGd3hDAB0LF/VZQn08BKdQDDccdr+121+kvIXQ1EGfpqemUDrTjg/eHW/l/cNjddPBAFXPAvL6pGbRlmh+QotK54z7LcqFfdR0+QiIRIQeX9cvNxJcv0JX9TBontsxnsW5TLLxFu08+4PN+y6gK3qFsK5eqhLlTaihEu2Z9Azaawm0NEoPeNYBxBBU6P3qEXUtp18x2md1dv5pjK+1jQuusZYHMe4ofzdvSdfg8ttoi21/E5C5gA9ZMGyj81ZKIlF1t+sOcnJ0lJFxPJjkHyss54/1ZUccirYgQ1GgqDfPrJJnPyp7/eR4EJb27Q3dJIo7uhYednyWExtCSOmsPRWb5popqdrGodlecA5yyk49kSuGQiO6vzoaFfhedhRwXEhtaqKRMHVmrP74mWrZZ+E9QHUzT9poynIoZAItH01lPrhh/T7dnBXGZjxET9dO5IcbvgDB4nnmLidUI5FCA4z7JQjdtE+ZxmmBjoouGt0NdiiGlHmTrfD+NegHPpocW6K8M/b98SRx8uHRQ4lkHIPERiw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(38100700002)(6506007)(55016003)(122000001)(52536014)(2906002)(186003)(9686003)(71200400001)(86362001)(7696005)(4326008)(966005)(53546011)(55236004)(26005)(54906003)(110136005)(45080400002)(508600001)(38070700005)(316002)(5660300002)(33656002)(76116006)(66946007)(66476007)(44832011)(8936002)(66556008)(64756008)(7416002)(83380400001)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S9mosKYL1vczp2lcM46ejTjHeVyjlTRzGR5Yydt7OLLz6RyerZilxElHwX0j?=
 =?us-ascii?Q?Tt2RTI5W/rdJy1JopGqN3KS+sjXjurPavbi51KNoW6hO7IlzpnEL8E21plpQ?=
 =?us-ascii?Q?yQ6q+njokcZjPy9r3im8uEc/1NvGUWBuKqrbtDZQUqDpkdn5nLBAiH0lk5Po?=
 =?us-ascii?Q?K+ZiGZq9M/UfB2RX6aZslytwgEunBYS4XBOExaPYjCyqM03DMIpWlM0vNWRH?=
 =?us-ascii?Q?LPlOSz1ruglCvC2xTBK8LX6iRbA9Przow7RoA2qZcCwGo1ehavDThzt7os8K?=
 =?us-ascii?Q?ghy+MMhYHTY8hMt6mcJd/+kyyFFmR6/0Bh70XIbcAkEdZEVRFl8/TV3yRhpP?=
 =?us-ascii?Q?GQnMKmx2pQz+5ry/DtDxCm1Mwe9YTZHTqFIJekZG7KEGxcEKFeiZwDiN4iMM?=
 =?us-ascii?Q?xuOxwDNQOtvdwNtJ9qDIPHjfKOjL5CY/6YqmpsAea1MYM1yPc0KloH0HCgGE?=
 =?us-ascii?Q?QfLDvSfxmVNYmlZqkVtnezRNVgHc9HkZU2Qa2xvTwRORpkqS0d1BJlMS5M1h?=
 =?us-ascii?Q?NPogzfZzxIEcTxtli2dywLsqxXYXgSdprz7BD7pW8BD6U3WuQXJDHKXz6Bms?=
 =?us-ascii?Q?vuqW5vIRE9Xi5wfiGAxfvYVY5HvkkMAnXfhWHeWkFG9XKwaLqfQLgth7hbKS?=
 =?us-ascii?Q?PQ94ANPlz5sCRw3b4jhqCvmLnWtW2jaR6r3JF/RZF2ndtcmVc1EmkjGPRh8l?=
 =?us-ascii?Q?Ggo187RgICINvrkEdRj6qwBvkKKIrb1J4Oz0Ci2XrIaIgYOkWWXoZtoKbBiY?=
 =?us-ascii?Q?7cv2Nk29qQUQhXLD0lE4672FLxccErorl6qFJRk1DGq3n276ladX0kpRZaOu?=
 =?us-ascii?Q?S1SCZbPp5yj2dhO3wIwjcomX1BOz8ZS+8za8Nvop4KU1daKgEGy4+GiOlVFi?=
 =?us-ascii?Q?s8FaH50xa0bVlGTN5PF1i4fPkESXrSfCXEQ8CEMYoSVu7Xjrg9/RpB44VNFK?=
 =?us-ascii?Q?0+hItGnpqQx7WBN2lQ2UXYkJPO0hdprHBITmBLQ88mi4Zra6sUVovTJliacr?=
 =?us-ascii?Q?7BkSNbwE9yvZihDvTIeftZnt33qKu2b7FPpYDs1m5IAg9b+y1iF/WF4lCgAM?=
 =?us-ascii?Q?PuHwzOjM8YzNE36UiNfZRbZP52NcHtMN0yV194v/pZuhYvbD3bJupZ6d3V+/?=
 =?us-ascii?Q?1cCqOfq7HJcH/CoMO3nOzArYk5y37jJdb1vxcsaZhTafr1YXvTXwN8henzrT?=
 =?us-ascii?Q?CROmFz2uncbKxmxkt1EhKvDKpVsc5AEhDh85umr81/K+UUGwOK8DOEmXb68L?=
 =?us-ascii?Q?9TpkIioZojpghbsKI5dM1lNeq9IOVgMktu1d9KHiS4X+emD9mZmqgcHbgBPs?=
 =?us-ascii?Q?ru/4HltiUtWfgklYDrjFrg1mXpljYZ4e5zkqASIe2Tp2AgEdKRAxEnFQGrnt?=
 =?us-ascii?Q?FO0YJ5HoOXmGzjqlNzm4xL1aWjveMKHt0nT1lGitI0pzASbKtsDjQ5AnbyuO?=
 =?us-ascii?Q?NmTScMRIYR7b/hgykF2Qy6G6D0Ka41qfptUZcNYX7o/l8LSPPJKCGuecAl6Q?=
 =?us-ascii?Q?vqaV3assGtJIaNEU5Iz3tcJ/Y9NhxeP3lH+TCSyKIWuK3gTL19a/OJc/0JFF?=
 =?us-ascii?Q?sfO6SUoz1wouBda7bZnVenujLoJCo9+AdnU8Pl6OM1J63H5mRZMmyZS7L2Ts?=
 =?us-ascii?Q?MSCuiGklDJmaofT36RTGwlAgWHnFx4SHe7jQA2iNikfVBeF+8I3c9aXa9bVP?=
 =?us-ascii?Q?KHXVfl9TBDk+rCZB9aV+TNFRMmju6EfuDqmw+fuzi9dGcapx6WJF4ZKYIull?=
 =?us-ascii?Q?P90gBoMT0Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a26d9f2b-826c-49de-e131-08da109d6b6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 09:29:12.3032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +2DPEmggRBCPClQAQE1RjDLCaJcy2DuDfysYBZm89qjSj2yC2yber2AYEbsRFt+9mp8KE36uJ0WQ94LXdHrEIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8164
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Ahmad,

Please find the comments in-line.

Regards
Pankaj

> -----Original Message-----
> From: Ahmad Fatoum <a.fatoum@pengutronix.de>
> Sent: Thursday, March 24, 2022 3:40 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>; Horia Geanta
> <horia.geanta@nxp.com>; Herbert Xu <herbert@gondor.apana.org.au>;
> David S. Miller <davem@davemloft.net>
> Cc: linux-security-module@vger.kernel.org; Eric Biggers
> <ebiggers@kernel.org>; David Gstir <david@sigma-star.at>; Matthias
> Schiffer <matthias.schiffer@ew.tq-group.com>; Sumit Garg
> <sumit.garg@linaro.org>; Jan Luebbe <j.luebbe@pengutronix.de>; Richard
> Weinberger <richard@nod.at>; tharvey@gateworks.com; Franck Lenormand
> <franck.lenormand@nxp.com>; James Morris <jmorris@namei.org>; Mimi
> Zohar <zohar@linux.ibm.com>; linux-kernel@vger.kernel.org; David Howells
> <dhowells@redhat.com>; Jarkko Sakkinen <jarkko@kernel.org>;
> keyrings@vger.kernel.org; linux-crypto@vger.kernel.org;
> kernel@pengutronix.de; linux-integrity@vger.kernel.org; James Bottomley
> <jejb@linux.ibm.com>; Serge E. Hallyn <serge@hallyn.com>
> Subject: Re: [EXT] [PATCH v6 3/4] crypto: caam - add in-kernel interface =
for
> blob generator
>=20
> Caution: EXT Email
>=20
> Hello Pankaj,
>=20
> On 24.03.22 10:55, Pankaj Gupta wrote:
> > Hi Ahmad,
> >
> > Please find the comments in-line.
>=20
> Thanks for you review.
>=20
> > Suggest to continue to use two separate descriptor-creation-function fo=
r
> 'encap' and 'decap'.
> > This will help these API(s) to be maintained easily going forward.
>=20
> We can still split them up in future once there is a real need.
> But currently they are exactly the same, except for input/output length, =
so I
> think it's correct to not introduce duplication unless needed.
>=20
> >>   - use append_seq_(in|out)_ptr_intlen for both encap/decap as a
> >> result
>=20
> Case in point. The intlen omission was because the two functions are larg=
ely
> identical and I only fixed up one of them. This is prone to repeat when w=
e go
> back to have identical code with minor differences.
>=20
> > In continuation to the previous comment, there is another suggestion:
> >
> > Either:
> > struct keyblob_info {
> >         void *key;
> >         size_t key_len;
> >
> >         void *blob;
> >         size_t blob_len;
> >
> >         size_t key_mod_len;
> >         const void *key_mod;
> > };
>=20
> I can do that.
>=20

Please do. Thanks.
Patch 4/4, needs to be re-worked to.

> Whats your opinion on the desc size computation? Comment the macro or
> add the static inline helper?
>=20

Comment the macro is fine.

> Cheers,
> Ahmad
>=20
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=3D04%7C01%7Cpankaj.gupta%40nxp.com%7C4
> d60f0d524a04b7cbd7b08da0d7e7d21%7C686ea1d3bc2b4c6fa92cd99c5c30163
> 5%7C0%7C0%7C637837134158793951%7CUnknown%7CTWFpbGZsb3d8eyJWI
> joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3
> 000&amp;sdata=3DPetvZm8teusBwQ4BeZ1VLEOvBlCrZ2k2bNG3SJBEXPw%3D&
> amp;reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|
