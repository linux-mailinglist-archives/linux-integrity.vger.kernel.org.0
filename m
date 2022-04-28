Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F27513432
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Apr 2022 14:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbiD1MyQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 Apr 2022 08:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346851AbiD1MyK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Apr 2022 08:54:10 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20049.outbound.protection.outlook.com [40.107.2.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD7D60D80;
        Thu, 28 Apr 2022 05:50:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTVNbPxcPs75oNXQdKGqOBs9zMsZ6kJ5nZ/M8Zhd4byT6eLc12oNsuOTmWB00qEqIZCBdPydWYHNT6WNAeUqJDmJGt+d784I7bq7JFvZmu07v5BTa24++73CzJj9mGRQG42HKXa3hp/ofVOCk1/Bj58082RbBhJP96R0KFYhRT3V/7IiaBH7MjE2mfdeRL8/6d8qigETX6JERisW9XZUzlHKJDUgHqaBrZs2XByFETZb/IDiDFn5qk2bIwKD5NQq9rfuUyA9pKf4tu/QTuMEI72i7aonvdNZ1luv5I/iNGIqM8lYZ/E+bdkAQtQm4eMtyeHDL5Vpifl+d1fUY65jbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGQOnSOLyd3po3sb+G/Cyzngt80L+ZYhBj+lSkWW7q4=;
 b=VKThFHZLMnF5b6pHhVraropGTaBpcTGhJa8SVFVePiHJZTtWQ5GmSMJ5heGXS/gZVqC1piC8pC9YSX4ofZSyJSc3BAwpswgrtL64LQVij1j3kb1A5Z7KBhp7PWWF1sO252ziTE0jQIlFcoypGfejgim3tQ7D0kY6XthzQRD/x1IxyoBsyUpAPQPPhZcxRBi3/foBzLPkXerD/Ujtqm2El9FngBsrw0ZOYMs0V4fOXc+b32W31S+D8rw/GCwDRhPeRBT6Fb3Za/cXgbSXFiZwveaV0MiDWry8dxo5pUUlw5OJljlvW/Ho8tFiHSwBVmlPnJU40gltLhdprh2XI1PjgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGQOnSOLyd3po3sb+G/Cyzngt80L+ZYhBj+lSkWW7q4=;
 b=A9Y5ruHTC3ivTFyrEKWwSoRWhozCCFj45BeXzSiCNfkbYzY5SUR5UI5LoHdPyYvQmn/Hvy5/nNABEwctj6kaK+h7UMCosWpm8O/vUCibiZ8Or28M6wd95UqVeLweQTT7dpcK7iBQxsbHnAIEtISddk+yp/SjhZ82pIGgcVgmiGA=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by DBBPR04MB6250.eurprd04.prod.outlook.com (2603:10a6:10:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23; Thu, 28 Apr
 2022 12:50:50 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::2969:d3a8:3fc8:9446]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::2969:d3a8:3fc8:9446%3]) with mapi id 15.20.5206.014; Thu, 28 Apr 2022
 12:50:50 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Horia Geanta <horia.geanta@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        James Bottomley <jejb@linux.ibm.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Andreas Rammhold <andreas@rammhold.de>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: RE: [EXT] [PATCH v7 0/6] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
Thread-Topic: [EXT] [PATCH v7 0/6] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
Thread-Index: AQHYUQtqGx5ZNsXGgEiU8Xf+YU6Oaa0FWnyA
Date:   Thu, 28 Apr 2022 12:50:50 +0000
Message-ID: <DU2PR04MB86306B75C018C7CAB9FFA57195FD9@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20220415205647.46056-1-a.fatoum@pengutronix.de>
In-Reply-To: <20220415205647.46056-1-a.fatoum@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a505f52-0963-453f-d75a-08da2915b955
x-ms-traffictypediagnostic: DBBPR04MB6250:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DBBPR04MB62502FF01D04693170CB838395FD9@DBBPR04MB6250.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fQSIhAyD4c9yrTXezJ+u2LIxHzA5bA9YZOScGChRw4z45SXbL7NzfDx+Njd7XZ1h25MwmZ2CYwPDlg1CBycZq+14d3kZ/TmHoTJTb0bJa41YLss9aygRQMwQ++j1lrYNZC9a+or1OM3LNOn9gzXTLmwEa2+yAw5qhuJ/ZL8FAFdai94/DLOhYJmjbLFLj4OFcyEQQFuSwq4fwt0R9RJLQrqREY5zsekxgXU8SDPt6d+o6PNjVoDLPnZehvoNXvQK1uoWpC4LfrH4mFs0YS4IzS+pn90oT7/c2+OUZLlcLWLBDBnDUc2CiMLkekwOJrqwAbFdScPazMMtgS6QBaTmC32PzIQIsLLUv5MzUT6yQMUl1y92Bz+u2xrQ83JSd5DnBYrVLGe+hIr/a2/4i0vJifbhQFdE9+HI/ypz9sSoVtLTxFNm0S9UjfkqAE9DgsJMsv8GWhaULCheRVjswmYBbV8nZz728DPUzU7wvLLKqWKilsFQ4qEw2SliqrDYR53CUiwQGeJu858eZ9aR0Cy60SCH+JBjmeEM5svib3EjGT5Ln7vYzDPcReGx6LaHQWMlDRiEwMHtmQyd5B0+7e48cxXYnL+yG7uTKqCirQ4LF/TUSTDBTOQkS5WiXdjtlWkoDNTVwHNanI+Z2lhepV8qwgcTpmN17E1hglGai44gkFka34OmSI73KFPb08Q/B2Ir6K9nCdGsQfE7yANKCvL9lBdWBDiHhC7QIkvxYSEATd7FlAOUxZ8B/HIhvQSliLWpYRDslGOi63iYWBgi7YrwixsZ/h+IQWaJyfvRV5e6uq8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(186003)(26005)(9686003)(44832011)(4326008)(2906002)(7416002)(8676002)(55236004)(38100700002)(53546011)(6506007)(5660300002)(316002)(7696005)(38070700005)(83380400001)(122000001)(45080400002)(66446008)(33656002)(64756008)(8936002)(52536014)(966005)(110136005)(76116006)(54906003)(55016003)(71200400001)(508600001)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?P5AAIW4UC6VSZRAc5UIR9b1sF22EJFkJdqdhi+CK+MArBemfbqMNYGWVuk?=
 =?iso-8859-2?Q?PMs3MDzHvY7NoYZ3i9xWYWUCn3wHajUALvMge1/6JWbufqBBJXDcYBKSVk?=
 =?iso-8859-2?Q?JM37mlU2d1s0tVg7xbTgb3z8G7BcGrd9tUMIdPBifBvnjU4bapD5bHVNJa?=
 =?iso-8859-2?Q?+96ctpMqLl5CfYQW5mDmVCglR2DOweOFF+7xSLwCvteHNuCqjfdBCB/+Va?=
 =?iso-8859-2?Q?AMib7NbvDRzNEdCB7OZFHIbrTZJQszGTS0ynoRw8tqKbUiSzwsSBzKzDvD?=
 =?iso-8859-2?Q?SF0WPtMJaTtcz4XJ+kiO5SpUStrHxgB8gBIna8QDQdE/x5nAefEgcENZ9z?=
 =?iso-8859-2?Q?aNUssaH4aHTz0x8tUWBTt34R/tZkBljCZCwV41nvZORlgpWmZ8o9g8eMgo?=
 =?iso-8859-2?Q?zRf0QjAZnNWqa0kM0nOYfJvMA2GQZAv+/izpicTRrysKK7/crJlR9+E6kf?=
 =?iso-8859-2?Q?d+nUhmKd6o1l46ZFfgU3iSkQCNomY/OdNa1jtxKWRRX9n1dmrGjR37pmd2?=
 =?iso-8859-2?Q?Flesy8ZRF1/bdpdzR0eNO19igH1lfzZjQ/8jG+fPr9COqr/9zSA+mGzJVq?=
 =?iso-8859-2?Q?70XwixyZU+L6eBnT8FSuUz/c9ric6GluMQ6kn8ape961RmLd5RRayYAny6?=
 =?iso-8859-2?Q?Szv78rrUB3bN84pyN2Jc0torGO+1xD8Bv6KQ1o9l+f6ynSL9Q6l+XME6aL?=
 =?iso-8859-2?Q?DzL8mZXllnhCPBW82r5wqdOGcTQJqWQ2ZB/KyUjnb8i7MDROUIygfoxLyU?=
 =?iso-8859-2?Q?8huuYQGqSREZBPLl6kIVyFHnembJUjlviw8uatEFGilau50acjnRPRruIw?=
 =?iso-8859-2?Q?tR0H0rq4HglXfIx6d0Fea6tw/xndB58INPpNfK32+Rldl5RLdALuTZTfuI?=
 =?iso-8859-2?Q?pee5Uo0AbK9KO3Yeil9WYmY0JgkMkOoKkUtrZEqvQeMzZloDK1l+zEo2n+?=
 =?iso-8859-2?Q?u4/NHvWBFzFNRaOG9rfQLjj0povl2251JvM7XYIpb1YLfY1pCU/1VBTi0T?=
 =?iso-8859-2?Q?hjfeFdMJMPLOW5dSKNVwL+z79jy2dVJACftTVnPAqtdGi4c9waUpuNiHss?=
 =?iso-8859-2?Q?p9Uiv18OYKGssAh1V/gyvSDOj6FIz91J9ys1b+gUJOhLi+kU4GN2J+uUbF?=
 =?iso-8859-2?Q?IR0CQVvgI1AbUpygPPemZZsnvdty9OjP8kmECnOp5rcmXNjdW5nyoOFSF8?=
 =?iso-8859-2?Q?M0LGSRa4PiBDPr0X3kXkF2/J9O8yz1pOlqTSyLjQjjXLoVuUM3Ylfaym1w?=
 =?iso-8859-2?Q?EC/FBHUWw67rbm0wvc1GFuWja8naQqi5ZLVHHdUZrN2vYt887aDsO+dR48?=
 =?iso-8859-2?Q?QCSEkP7Z7LV32Tjx5xApeRlDdtCFkxwyEoFZiE/ZH5suF2BdIZGJd8wwS2?=
 =?iso-8859-2?Q?y+cm4citer5s8Uml/fbescbV7Q27mQ6yLqvCUIuVg9W7Vdx5Uarj72PcIw?=
 =?iso-8859-2?Q?khBfY9YuFyE2+KKeqdIN5hXqVvU4DTlzDCpqtXJQF9t6qJgmZJ4+U/a7g2?=
 =?iso-8859-2?Q?7fpNaw2CN7KAezfDJaD0IiYCcqnxwfOu8P39gboEZGhvdROE1aQHap3NdH?=
 =?iso-8859-2?Q?3+8W0pk8k3kk9hJp2CPOTAsBWK0TP4dkYpvAryXwd7IEEBDNr1D+Kfohv4?=
 =?iso-8859-2?Q?c7esQ8qdYMIlR+logi8BRArhA/tQnLQ89OXmb5hDiFNZJhtVo0p1VMw4LX?=
 =?iso-8859-2?Q?ZLVUQUvKm6Z+SwB4Nfk/F+87QLN36t7eQ6Zgrlb7zS8X/Ho+ZhZvUH1l+Z?=
 =?iso-8859-2?Q?BOZRllhIJi6jczUUzVGMakcugkLdzwaXsuo+U9USu9QvoqS8Yx3m5Ytxyh?=
 =?iso-8859-2?Q?8uH+revNNw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a505f52-0963-453f-d75a-08da2915b955
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 12:50:50.6340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yhvp1khCL9dAX06KgjKeZTSbihB+6VFpP6+6zdkZi8SjmIIb9XNN9mkNjA9/r1CjOsSBsatsG4nJimzwAXws1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6250
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Ahmad,

I have tested the patch-set.
It is working as expected even when CAAM is compiled as kernel module.

Reviewed-by: Pankaj Gupta <pankaj.gupta@nxp.com>
Tested-by: Pankaj Gupta <pankaj.gupta@nxp.com>

Regards
Pankaj

> -----Original Message-----
> From: Ahmad Fatoum <a.fatoum@pengutronix.de>
> Sent: Saturday, April 16, 2022 2:27 AM
> To: Jarkko Sakkinen <jarkko@kernel.org>; Horia Geanta
> <horia.geanta@nxp.com>; Mimi Zohar <zohar@linux.ibm.com>; Pankaj
> Gupta <pankaj.gupta@nxp.com>; Herbert Xu
> <herbert@gondor.apana.org.au>; David S. Miller <davem@davemloft.net>;
> James Bottomley <jejb@linux.ibm.com>
> Cc: kernel@pengutronix.de; David Howells <dhowells@redhat.com>; James
> Morris <jmorris@namei.org>; Serge E. Hallyn <serge@hallyn.com>; Steffen
> Trumtrar <s.trumtrar@pengutronix.de>; Jan Luebbe
> <j.luebbe@pengutronix.de>; David Gstir <david@sigma-star.at>; Eric Bigger=
s
> <ebiggers@kernel.org>; Richard Weinberger <richard@nod.at>; Franck
> Lenormand <franck.lenormand@nxp.com>; Sumit Garg
> <sumit.garg@linaro.org>; Andreas Rammhold <andreas@rammhold.de>;
> tharvey@gateworks.com; Matthias Schiffer <matthias.schiffer@ew.tq-
> group.com>; linux-integrity@vger.kernel.org; keyrings@vger.kernel.org;
> linux-crypto@vger.kernel.org; linux-kernel@vger.kernel.org; linux-securit=
y-
> module@vger.kernel.org
> Subject: [EXT] [PATCH v7 0/6] KEYS: trusted: Introduce support for NXP
> CAAM-based trusted keys
>=20
> Caution: EXT Email
>=20
> Series applies on top of v5.18-rc2
>=20
> v6 was here:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
k
> ernel.org%2Flinux-integrity%2F20220316164335.1720255-1-
> a.fatoum%40pengutronix.de%2F&amp;data=3D04%7C01%7Cpankaj.gupta%40n
> xp.com%7C59fba782ed2445f72a3708da1f228c18%7C686ea1d3bc2b4c6fa92cd
> 99c5c301635%7C0%7C0%7C637856530483504933%7CUnknown%7CTWFpbGZ
> sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M
> n0%3D%7C3000&amp;sdata=3DHX0dpx79%2BRpfD0CTzd59XgcdEIOmUV0BtL3Y
> 36Sx1AY%3D&amp;reserved=3D0
>=20
> Changelog is beneath each individual patch.
>=20
>=20
> The Cryptographic Acceleration and Assurance Module (CAAM) is an IP core
> built into many newer i.MX and QorIQ SoCs by NXP.
>=20
> Its blob mechanism can AES encrypt/decrypt user data using a unique never=
-
> disclosed device-specific key.
>=20
> There has been multiple discussions on how to represent this within the
> kernel:
>=20
> The Cryptographic Acceleration and Assurance Module (CAAM) is an IP core
> built into many newer i.MX and QorIQ SoCs by NXP.
>=20
> Its blob mechanism can AES encrypt/decrypt user data using a unique never=
-
> disclosed device-specific key. There has been multiple discussions on how=
 to
> represent this within the kernel:
>=20
>  - [RFC] crypto: caam - add red blobifier
>    Steffen implemented[1] a PoC sysfs driver to start a discussion on how=
 to
>    best integrate the blob mechanism.
>    Mimi suggested that it could be used to implement trusted keys.
>    Trusted keys back then were a TPM-only feature.
>=20
>  - security/keys/secure_key: Adds the secure key support based on CAAM.
>    Udit Agarwal added[2] a new "secure" key type with the CAAM as backend=
.
>    The key material stays within the kernel only.
>    Mimi and James agreed that this needs a generic interface, not specifi=
c
>    to CAAM. Mimi suggested trusted keys. Jan noted that this could serve =
as
>    basis for TEE-backed keys.
>=20
>  - [RFC] drivers: crypto: caam: key: Add caam_tk key type
>    Franck added[3] a new "caam_tk" key type based on Udit's work. This ti=
me
>    it uses CAAM "black blobs" instead of "red blobs", so key material sta=
ys
>    within the CAAM and isn't exposed to kernel in plaintext.
>    James voiced the opinion that there should be just one user-facing gen=
eric
>    wrap/unwrap key type with multiple possible handlers.
>    David suggested trusted keys.
>=20
>  - Introduce TEE based Trusted Keys support
>    Sumit reworked[4] trusted keys to support multiple possible backends w=
ith
>    one chosen at boot time and added a new TEE backend along with TPM.
>    This now sits in Jarkko's master branch to be sent out for v5.13
>=20
> This patch series builds on top of Sumit's rework to have the CAAM as yet
> another trusted key backend.
>=20
> The CAAM bits are based on Steffen's initial patch from 2015. His work ha=
d
> been used in the field for some years now, so I preferred not to deviate =
too
> much from it.
>=20
> This series has been tested with dmcrypt[5] on an i.MX6Q/DL and an
> i.MX8M[6].
>=20
> Looking forward to your feedback.
>=20
> Cheers,
> Ahmad
>=20
>  [1]:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
k
> ernel.org%2Flinux-crypto%2F1447082306-19946-2-git-send-email-
> s.trumtrar%40pengutronix.de%2F&amp;data=3D04%7C01%7Cpankaj.gupta%40
> nxp.com%7C59fba782ed2445f72a3708da1f228c18%7C686ea1d3bc2b4c6fa92c
> d99c5c301635%7C0%7C0%7C637856530483504933%7CUnknown%7CTWFpbG
> Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn0%3D%7C3000&amp;sdata=3D1SsslHlyFr2xaWNsE3aa0DEdQ3r5%2BLqDI16X
> bLBEi5M%3D&amp;reserved=3D0
>  [2]:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
k
> ernel.org%2Flinux-integrity%2F20180723111432.26830-1-
> udit.agarwal%40nxp.com%2F&amp;data=3D04%7C01%7Cpankaj.gupta%40nxp.
> com%7C59fba782ed2445f72a3708da1f228c18%7C686ea1d3bc2b4c6fa92cd99c
> 5c301635%7C0%7C0%7C637856530483504933%7CUnknown%7CTWFpbGZsb3
> d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%7C3000&amp;sdata=3D%2FvQXaQAJZc5aid84IWIUyfRLSUPSylOhkpoaB%2
> FAgMgs%3D&amp;reserved=3D0
>  [3]:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
k
> ernel.org%2Flkml%2F1551456599-10603-2-git-send-email-
> franck.lenormand%40nxp.com%2F&amp;data=3D04%7C01%7Cpankaj.gupta%4
> 0nxp.com%7C59fba782ed2445f72a3708da1f228c18%7C686ea1d3bc2b4c6fa92
> cd99c5c301635%7C0%7C0%7C637856530483504933%7CUnknown%7CTWFpb
> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> 6Mn0%3D%7C3000&amp;sdata=3D%2F2fSdeN%2FG%2BObdJW9hpPrR%2B%2B
> KoKOvtUGvijdu2rgSMCg%3D&amp;reserved=3D0
>  [4]:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
k
> ernel.org%2Flkml%2F1604419306-26105-1-git-send-email-
> sumit.garg%40linaro.org%2F&amp;data=3D04%7C01%7Cpankaj.gupta%40nxp.c
> om%7C59fba782ed2445f72a3708da1f228c18%7C686ea1d3bc2b4c6fa92cd99c5
> c301635%7C0%7C0%7C637856530483504933%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> 3D%7C3000&amp;sdata=3DYNRk2%2FYFm9mI8vEigYxoIDRcHilHR4U6uqYXSj8dJ
> VI%3D&amp;reserved=3D0
>  [5]:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
k
> ernel.org%2Flinux-integrity%2F20210122084321.24012-2-
> a.fatoum%40pengutronix.de%2F&amp;data=3D04%7C01%7Cpankaj.gupta%40n
> xp.com%7C59fba782ed2445f72a3708da1f228c18%7C686ea1d3bc2b4c6fa92cd
> 99c5c301635%7C0%7C0%7C637856530483504933%7CUnknown%7CTWFpbGZ
> sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M
> n0%3D%7C3000&amp;sdata=3DTlA7QBMbBGhJTyx5wHk3%2BhQUhuqBWW3W
> tEZq94w13kY%3D&amp;reserved=3D0
>  [6]:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
k
> ernel.org%2Flinux-
> integrity%2FDU2PR04MB8630D83FE9BBC0D782C4FAF595089%40DU2PR04MB
> 8630.eurprd04.prod.outlook.com%2F&amp;data=3D04%7C01%7Cpankaj.gupta
> %40nxp.com%7C59fba782ed2445f72a3708da1f228c18%7C686ea1d3bc2b4c6fa
> 92cd99c5c301635%7C0%7C0%7C637856530483504933%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC
> I6Mn0%3D%7C3000&amp;sdata=3DjOJusQxZ%2BUfjxDKyMImc4BYjO8sFmamV
> b5LnAo%2BknFc%3D&amp;reserved=3D0
>=20
> ---
> To: Jarkko Sakkinen <jarkko@kernel.org>
> To: "Horia Geant=E3" <horia.geanta@nxp.com>
> To: Mimi Zohar <zohar@linux.ibm.com>
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> To: Herbert Xu <herbert@gondor.apana.org.au>
> To: "David S. Miller" <davem@davemloft.net>
> To: James Bottomley <jejb@linux.ibm.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Cc: Jan Luebbe <j.luebbe@pengutronix.de>
> Cc: David Gstir <david@sigma-star.at>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Franck LENORMAND <franck.lenormand@nxp.com>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Andreas Rammhold <andreas@rammhold.de>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Cc: linux-integrity@vger.kernel.org
> Cc: keyrings@vger.kernel.org
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
>=20
> Ahmad Fatoum (6):
>   KEYS: trusted: allow use of TEE as backend without TCG_TPM support
>   KEYS: trusted: allow use of kernel RNG for key material
>   crypto: caam - add in-kernel interface for blob generator
>   KEYS: trusted: Introduce support for NXP CAAM-based trusted keys
>   doc: trusted-encrypted: describe new CAAM trust source
>   MAINTAINERS: add myself as CAAM trusted key maintainer
>=20
>  .../admin-guide/kernel-parameters.txt         |  11 ++
>  .../security/keys/trusted-encrypted.rst       |  60 ++++++-
>  MAINTAINERS                                   |   9 +
>  drivers/crypto/caam/Kconfig                   |   3 +
>  drivers/crypto/caam/Makefile                  |   1 +
>  drivers/crypto/caam/blob_gen.c                | 164 ++++++++++++++++++
>  include/keys/trusted-type.h                   |   2 +-
>  include/keys/trusted_caam.h                   |  11 ++
>  include/soc/fsl/caam-blob.h                   | 102 +++++++++++
>  security/keys/Kconfig                         |  18 +-
>  security/keys/trusted-keys/Kconfig            |  38 ++++
>  security/keys/trusted-keys/Makefile           |  10 +-
>  security/keys/trusted-keys/trusted_caam.c     |  82 +++++++++
>  security/keys/trusted-keys/trusted_core.c     |  45 ++++-
>  14 files changed, 527 insertions(+), 29 deletions(-)  create mode 100644
> drivers/crypto/caam/blob_gen.c  create mode 100644
> include/keys/trusted_caam.h  create mode 100644 include/soc/fsl/caam-
> blob.h  create mode 100644 security/keys/trusted-keys/Kconfig
>  create mode 100644 security/keys/trusted-keys/trusted_caam.c
>=20
> --
> 2.30.2

