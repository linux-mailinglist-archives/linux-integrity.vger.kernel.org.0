Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7F55AFD59
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Sep 2022 09:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiIGHW4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Sep 2022 03:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiIGHWw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Sep 2022 03:22:52 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00062.outbound.protection.outlook.com [40.107.0.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3467A915FA;
        Wed,  7 Sep 2022 00:22:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DM+ZqvZeAFv0dYoigmiBdJQuJRyr1buDbbW/WlpDcTVj2wMa1hUlE/8V5qfa0tZn1mO0LpN2AUbvRnl+X2t/tF6u7Q/IhlAlHDBCELuusOD8M4yxRbuSgYz3QAFW/Yhb6I/t6uMycr/tQP6pngLE/usLMBW6NqN01rb+gj2bA8W/eO8c3a0zuMypd4ZAl+ZuBmPn+8oyYbFytLt3/IFKTPzpeBrgBVz8Tl0cBE48lpMPbBQBuzAi0KwqrpEqlCVJGbxaSuGqI0Pe/AoLHWBPSlI1TlbDlojlzgbVNTw3UvhbP2/csduzJEB7jZJFNwXMtLGUO611NMGsUwrD/EOEfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szfEkGSn3VEpejtUHfg3ZxU5Wmv0VQp7xhDsT9XJlks=;
 b=nV6HqDayVRYHI596AYxyWE4VtfhM4G8+mClu3PnK6O6EN6BsdENOteHOOsYhj6DJGuPdz/Cgwqxc1JDxD80Ms4h2aCQdXyT3TDjKc7K9BLPuQKoZn58Xar4yQLOBrCjIiXl/cfio1MT56PQMWYrt54+6+00viVJjMOeL9y3+YYgPXEdIq041swROSPmly03EaUPgLDt03sKcixYfY0Zu0RPkTgjF4Bbyn+iXj52XZEgdGolzHy4sxLHhuthT4Clb1wtWc7ol1pvx0pp3giETvBbGDLWpDeXOHrEpcJ5ZKjWaZ/KwODWg7njFNEirGJtiNS2KuHjfz9PMscVCVZPzJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szfEkGSn3VEpejtUHfg3ZxU5Wmv0VQp7xhDsT9XJlks=;
 b=dlD1XbKEHvjpxh8o9yDI5/xTmSBppJwx2ObpkjxlR+Fc4gfmoALGl9fuRE1/HzU7ztF+h44r36F7ANO0ogdSWNR9yhv8KIbhInsNMhDWZLAOuiGSERTTP8YElgtX2FoGJST3sNd76QqmraJ4fc+VHO30Nuy8zPc7ukiPtXmkaz4=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AM0PR04MB4004.eurprd04.prod.outlook.com (2603:10a6:208:57::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 7 Sep
 2022 07:22:48 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b%4]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 07:22:48 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
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
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
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
Subject: RE: [EXT] Re: [RFC PATCH HBK: 0/8] HW BOUND KEY as TRUSTED KEY
Thread-Topic: [EXT] Re: [RFC PATCH HBK: 0/8] HW BOUND KEY as TRUSTED KEY
Thread-Index: AQHYwbSICZxhOSR7uk+zrvSafpZt0K3SGjKAgAFFWYA=
Date:   Wed, 7 Sep 2022 07:22:48 +0000
Message-ID: <DU2PR04MB86303DE3507B6FF37BD5B6A595419@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20220906065157.10662-1-pankaj.gupta@nxp.com>
 <YxcLqepquOuOOjvq@kernel.org>
In-Reply-To: <YxcLqepquOuOOjvq@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|AM0PR04MB4004:EE_
x-ms-office365-filtering-correlation-id: 18644122-35f9-4231-5e57-08da90a1c441
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XfWcDbh0bzC+TZ7cAzbw85jR9R4U2uJx6OMCqXs7SgHMlyyRcI30dSsmLESDDxOVVVxUank9bWFHiiBQu2FDi42wjlbvmRPs0TqGW2IUcbKjH4OqoqYzNkog3af3XXkKZ4/e7C4cTTJVGu0jyeN3YSaCo7iwUopox32O4kldgg7NTu01iupaGmZwkvfLEMXTagNG78Iy5UXO01NrN6b6eQ8ZAdBBVNxNc0+MWdQScctrci/Ps/MUEAol2wZJkAdYR7EMHUf/Ypx7bbLBMIHSXAcDHNNjcxmpMsdwqiMQbeg/X4uXaSu6kW12MtFDBTi/3sDLblGoqOxULJGrwqIIw6J9Sx4vnGQt1uc+jDVqTv2oXbDYlzLzQqbhLtQw5n+9Lvy52YMVHRUu7TYsALfXN/P6AZ0i6dGUAau0XUZou2pJHSgOkwp5KYBv/USkuRbRhpfbLL3wtLTvvsNkpfvKNvOeOsXWcfqdJI1Z8zq2q7uYJTmGjGbu4MBycnaumT7OlqGzTPtFR7m74+xE6Xj3Ys2g4pHw7g7q61LOF+nfNSOXFlmxKyHUqA2J1NWg9gUqtFqNNq0WYvALRJlDhH1A/FOM9VxSpIiDYpGOnD0TJO+kyY9Pl731VMgojCrUiaN/IMtMjzCUnRdsIgzIftx/RZuYOhOaRAJqDP6+fl2hssHsekcGSWc6WdTS5wgUG2PlFPxamBA+h4X6ZWWEbTaeEs6ybsoHi+xZARYwNaR7GAfzIGMuD6ApOCKTLeRdP/rx50ESYjtusy9kgx0E7mVbAfdtUwZ6E0zvPpwfiLO02Ck=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(26005)(7696005)(478600001)(8676002)(9686003)(6506007)(66556008)(66446008)(66946007)(55016003)(64756008)(66476007)(2906002)(86362001)(316002)(38070700005)(33656002)(4326008)(54906003)(6916009)(71200400001)(41300700001)(53546011)(55236004)(38100700002)(122000001)(76116006)(186003)(5660300002)(44832011)(7416002)(52536014)(8936002)(83380400001)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NqSdpXSNtGMRmspYUbEbaIc+g3Q+awrdQ2itfCx4pQ2oHbycze1b4lxfNbBw?=
 =?us-ascii?Q?WQSaA6PMnWMiNwEQCkCv3w4Z4g0KqkKNVmK9dzADImQucSoE0PJ3oLgi9Dlz?=
 =?us-ascii?Q?cEt1TXE209YjZ9B+NfosAl00hx5NK6MH42XGvqro3hmhIpRLjm0pv6si2uqn?=
 =?us-ascii?Q?t7EFTKbkT68aGGiNxZY0RFapcUlDE9nvp6iIawGV0Z38Pu1uOOQEZlOTCOaW?=
 =?us-ascii?Q?m2JYB+JkRL5LNmyxhH8FGnGnqfFmyaORkHAWBXHTSZRW94xlTi7ks1uNZRDj?=
 =?us-ascii?Q?uDOReqYpJwD+cMlFNHDkYdJKLY9kGpybb7eHLZBKiSWWKiV7MmIsqBO5IrF+?=
 =?us-ascii?Q?N+WEvGBqI/kpQn3Cec8naEcuacT2CnVWz9ZAtR+VIcmm79OWquFsb+lEKH+o?=
 =?us-ascii?Q?HUnPC1+xfglgSxPMJqRuHLEFQQTR8Yp0t+8u2J9a3N4RoxL5WzfZcPXE9ler?=
 =?us-ascii?Q?D82XpT3zgT3Vm7Dm+krRKmGC0mBv49HDJr53SPQchGGmcft14iOdZBcPbQYO?=
 =?us-ascii?Q?30W+TpFI8JQgxNrAotsNb5cnB1WSr0tZUJVbMDQhiRMj6vnJbLVXOpLwRsfl?=
 =?us-ascii?Q?Rdf/LCfO+IvJYb968YzQdp8boyF5NQm6Q4kbabWMTSYGSwMv9pemmOv3iRqv?=
 =?us-ascii?Q?DW0sa2PnfOuxQyoOX4IhboTL34m9FChZOFW9MYvXtqSuDDKZZIziwh48JGLA?=
 =?us-ascii?Q?vhywUfElEd+j/MtCoo7CSk83FxA3euGN7IGix3s2EAOoUHe8prJjgtwIgFBy?=
 =?us-ascii?Q?CHY9evxmeST8kKmGPZpkPNOXp3OdBG8tZcehLGj5FOMT4ICwQzRPjapfvBYQ?=
 =?us-ascii?Q?+FOuC7eEVipX+q9NCF6o+Kq/HisCN42CTsWkFBbAOs4p1c+C4/VhzatjEivr?=
 =?us-ascii?Q?Yy0brIdqydlf+KRLuj0BUeCUCZZXxmU/niKapJ3wo8Mjands6XuTgXhdmOIS?=
 =?us-ascii?Q?BBDfdO0A2IuPsIppsOAWgkMbCcBoEkd+xuah/CeTDexLQFfnUSBixS/eeLBQ?=
 =?us-ascii?Q?a/NF/vCp7Moe/q0+anOgHSxTDABgDdHCcd+iiI/Tf7PUrN730iAegTwxiMpf?=
 =?us-ascii?Q?vUc58gFU7oZXxnkujEfgBDMfd3uzvFA1o27ehA32h26HTiUEb8uJmCMPurSp?=
 =?us-ascii?Q?xqe5wObD9RdlahqzQalaFbA5ufBwmKmnyrVCZHlSTy2dr2B5hjiMYPieC+Dq?=
 =?us-ascii?Q?XH9JcRxQnST0ABrwZnXMIgh6g2KOOT527PmTwbHazjIUE9Em81O3DY/E2hVz?=
 =?us-ascii?Q?npSAB1P2F1WVue+g9uvCYORuvjtMEescRR3dl+Cb1LBuv0+TVBRxgeidVgcZ?=
 =?us-ascii?Q?J+FD/Mm37OPexwfUdFJtCtHE7Zoxb6XS/uHVfXoOcz6rpqTr4LQptVFKzpCA?=
 =?us-ascii?Q?NZ3E0XSAgHor/76F5zStIy5TzYU2SjVYVnx5Zvqi+74yq2lhsbnCQtGL5R3I?=
 =?us-ascii?Q?Ggn7dYZfO0I2XovPw4xy9KLdf2exPVyME/Qt3wvs0zB4BMPEqXifMfYkQgRk?=
 =?us-ascii?Q?8fuZwQPR9fnw5tKiuSrztTCj/JUaJAYt/MhYxuQ6WrEfjk2my27KagAUIeIm?=
 =?us-ascii?Q?uBY++U7VmFovzoNlLXFcJUaWWTHi7LaxAgd//M+Y?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18644122-35f9-4231-5e57-08da90a1c441
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 07:22:48.2787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8yEmJZ2JrUa4E8J86O/SEMsXrxyYAU5IgVr8U3RlD+y2FYt5F078Z50csZTnAnleO95+OuZBq+ljKfMhtsm8Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4004
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
> From: Jarkko Sakkinen <jarkko@kernel.org>
> Sent: Tuesday, September 6, 2022 2:28 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: a.fatoum@pengutronix.de; Jason@zx2c4.com; jejb@linux.ibm.com;
> zohar@linux.ibm.com; dhowells@redhat.com; sumit.garg@linaro.org;
> david@sigma-star.at; michael@walle.cc; john.ernberg@actia.se;
> jmorris@namei.org; serge@hallyn.com; herbert@gondor.apana.org.au;
> davem@davemloft.net; j.luebbe@pengutronix.de; ebiggers@kernel.org;
> richard@nod.at; keyrings@vger.kernel.org; linux-crypto@vger.kernel.org;
> linux-integrity@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> security-module@vger.kernel.org; Sahil Malhotra
> <sahil.malhotra@nxp.com>; Kshitiz Varshney <kshitiz.varshney@nxp.com>;
> Horia Geanta <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>
> Subject: [EXT] Re: [RFC PATCH HBK: 0/8] HW BOUND KEY as TRUSTED KEY
>=20
> Caution: EXT Email
>=20
> On Tue, Sep 06, 2022 at 12:21:49PM +0530, Pankaj Gupta wrote:
> > Hardware Bound key(HBK), is never acessible as plain key outside of
> > the
>                                     ~~~~~~~~~
>                                     accesible.
>=20
> > hardware boundary. Thus, it is un-usable, even if somehow fetched from
> > kernel memory. It ensures run-time security.
>=20
> Why is it called "HBK" here and "hw" in the context of keyctl?
It is HBK, because the key is bounded to the Hardware. As:
- Key is generated by hardware.
- Key can only be used by hardware.
- Stored as a blob by the hardware.

>=20
> > This patchset adds generic support for classing the Hardware Bound
> > Key, based on:
> >
> > - Newly added flag-'is_hbk', added to the tfm.
> >
> >   Consumer of the kernel crypto api, after allocating
> >   the transformation, sets this flag based on the basis
> >   of the type of key consumer has.
> >
> > - This helps to influence the core processing logic
> >   for the encapsulated algorithm.
> >
> > - This flag is set by the consumer after allocating
> >   the tfm and before calling the function crypto_xxx_setkey().
> >
> > First implementation is based on CAAM.
>=20
> CAAM is implementation of what exactly?


CAAM is the chip's cryptographic acceleration and offloading hardware and c=
ombines cryptographic and other mathematical
functions to create a modular and scalable hardware acceleration and assura=
nce engine. In context to this patchset, CAAM implements the following func=
tions:
- Generates HBK
- Generates key-blob, from HBK, for security at rest.
- Perform crypto operations, using HBK.=20

>=20
> I'm sorry but I don't know your definition of unusable.

Even if somehow the key is retrieved from the keyring, the retrieved key  w=
ould be an encrypted key.
This encrypted key can only be decrypted by Hardware, which generated it.

Hence, the retrieved key is unusable outside of the hardware.

>=20
> BR, Jarkko
