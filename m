Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505575BFCBC
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Sep 2022 13:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiIULHN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Sep 2022 07:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiIULHM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Sep 2022 07:07:12 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20089.outbound.protection.outlook.com [40.107.2.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A757F7FFAA;
        Wed, 21 Sep 2022 04:07:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyX1QHhNSBxBD4LZZrX7sPPXslep1rL+EFNfAETBFOaxvqMH0ZulUMp4eNXeGgD5eccy0E0UrnRXg4loLa+/sq00a2YFdbktZLB5IPVmcVCbs+QnLD5MQB6rAkjTIXGyNc8xRQL3z2/931usHlUlpUUpFE55a2+43D7sUCg/HTt/3GQc3lXZkycJeePu6LKbDg/zxbBTXsf2s5fXPkIjtRk4SBCfP3hUShGziKotsHwbdUa/m8uJ8jiAl7tmRX8JryqeapXe1jke9ATN/GKs7LbKuWRf8M0w7SGE03yyFS7N4wy22EghbKhceBVKYRG/irdq0rmEcHm1Q9ALAduSWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NUVR/6NbQ9kyGAb+Tb+islu606FAKiPq1x6O/lrg3c=;
 b=Xt1GfA5znu+e+OR5KUynPlIl94zyUhJTBJ4eeH9Z2GZMpwF8lINbl/wWXSd6QMqiKM4lVPcfFC4cYa+vflYT4evp3Tb+sfHOi+2h4RAheEyTpP1IKIeFTkR2sXsBtHvMEdJ+/OoAmzsFtOHcGygU91qk7kseAksTEtEWaI6lxHyjOZkn9XPaH9m/Pv19L+gC1P8G81mR6LNjtGVjvbULQIom3Ul/VZ2dQqaD6BZw/GxnM+763iL69Pazky1DBFXyoHaEf7vdXIpR4B3PS8vj5IOLbETra/9Dp8WLsm3GrryVyxCAH7xDreaaRLfIgqYPAbRmadP1p9Nb3w+61rRjAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NUVR/6NbQ9kyGAb+Tb+islu606FAKiPq1x6O/lrg3c=;
 b=Fx6kg1IdZyIiFihw9vz3s3ivUhqjREgAsV7326ui+oXukXI+gPxSWE2gR1apYTPon6Is9Cqplft1WkNCK+8nqlyi2/z/Ouse7ZZ2pgjbZoX5uvDGxQ5wTsX1gJJFgX07gc3K49riKO5vIbTaVOxJIoZHjktvvfyJ8w9MfFTKxqU=
Received: from AM9PR04MB8211.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::17)
 by DU2PR04MB8887.eurprd04.prod.outlook.com (2603:10a6:10:2e2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Wed, 21 Sep
 2022 11:07:07 +0000
Received: from AM9PR04MB8211.eurprd04.prod.outlook.com
 ([fe80::dd7d:c23f:d6f:db70]) by AM9PR04MB8211.eurprd04.prod.outlook.com
 ([fe80::dd7d:c23f:d6f:db70%7]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 11:07:07 +0000
From:   Varun Sethi <V.Sethi@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     Pankaj Gupta <pankaj.gupta@nxp.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
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
        Horia Geanta <horia.geanta@nxp.com>
Subject: RE: [EXT] Re: [RFC PATCH HBK: 2/8] hw-bound-key: flag-is_hbk added to
 the tfm
Thread-Topic: [EXT] Re: [RFC PATCH HBK: 2/8] hw-bound-key: flag-is_hbk added
 to the tfm
Thread-Index: AQHYwbSVJxssHkcinkOJLgRDaMQm8K3R9HsAgAGdVwCAAAD6gIAAKqCAgAADO4CAAgk08IAG3V+AgABPatCAAD0bgIAMfEPw
Date:   Wed, 21 Sep 2022 11:07:07 +0000
Message-ID: <AM9PR04MB821120DC26BFDD907A1229B0E84F9@AM9PR04MB8211.eurprd04.prod.outlook.com>
References: <20220906065157.10662-1-pankaj.gupta@nxp.com>
 <20220906065157.10662-3-pankaj.gupta@nxp.com>
 <YxbsBiCrIQT/0xz6@gondor.apana.org.au>
 <DU2PR04MB86308036FB517BF8CAD3D32795419@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <YxhHkz+UlE9XAG/Z@gondor.apana.org.au>
 <DU2PR04MB86308DB7CFBC7A31CEB612D295419@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <YxhuC3QlurfSgdXG@gondor.apana.org.au>
 <AM9PR04MB8211C7D59379D4C9F877D20EE8449@AM9PR04MB8211.eurprd04.prod.outlook.com>
 <Yx/lc1YjWm9+df1r@gondor.apana.org.au>
 <AM9PR04MB82112828E21FDA2043073216E8479@AM9PR04MB8211.eurprd04.prod.outlook.com>
 <YyBbU9sNC88EXFJs@gondor.apana.org.au>
In-Reply-To: <YyBbU9sNC88EXFJs@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8211:EE_|DU2PR04MB8887:EE_
x-ms-office365-filtering-correlation-id: 40d6fbba-25a2-4062-a4a8-08da9bc16c5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IqU0Jks5ODKkmyJ0JLQvmy23HoRriC4LXM/C8ny7quSMSjqvw2GQf091n3nw0bDVHkkj1c1/GYLw6BrkbOg4lLo6615736OOvXpCyQNNvxOMjStN+TRX727Jzc1L0aetNtkHazS4vCUVujOLjLFEnSRQ1sAPIi+2Di5Yijox7B/48FT1r4E3C4g9B6QTpxP6wDRW0YAZIPQZtEYbkR1XatbIhGuxOm5u8cjXv+YifqdDBFHdkrzv3TBrgeYPDXOt0WX780V7MTzQ9ii8J+Um3ZDD1x0jTPyHSgCYmW96VfrsfMYzcgPk1fJoawS72gnJVuhD+nkmIWiWa7fGyN3/qU5W+4P6BxaFpw3xWrSOeUxE683wneyVege9oVAeR3FjNJHOWQ04YLIhd+GSX7rO6Ibe1dcOFv3meUbTWbJCHlpLfYY5HbBMDakyJYLbwtuYE7bnQ2wAcLrhxFfdKoMdbruCSR07r7Tp3L6olTo4E9eXvA7ZF3hwU0DydfYUpuIA/boclpgCjDvdtbSdqx2RtW80iTxOdkpMEsFwt4CRVS7i5Oc3EYO35zNG+aCRwa74StH/lhGM+5DvAVzuA5/Q1PVv94L4f/FbImRv4OcbChZP+RmCggYOJY/BQghO9UW+71uZ96nMWNmY3oqSmbgO1bjrNdpA7ZlXAeNUcYnFevaGktd42nNH5LX5OKaEYBP1MATZmep2Qxx38vmrh4xU0EFGoPg5ePisA9AVtZf5Owno/6Hp0bDQRFqfUAT4UE9Furpu6KfMbtj8BzW684o9xTjG1ZavNbsDvAorl/wWhRs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8211.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199015)(55016003)(2906002)(64756008)(122000001)(4326008)(8676002)(66446008)(66476007)(66556008)(38100700002)(316002)(7416002)(45080400002)(8936002)(86362001)(52536014)(66946007)(6916009)(5660300002)(33656002)(54906003)(76116006)(186003)(38070700005)(9686003)(478600001)(7696005)(83380400001)(41300700001)(966005)(71200400001)(26005)(55236004)(53546011)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pyDyl2JVBSCy2GydL8cyKB38JC82YO6zbhfa7pPi4qRRxlJ8dEi6s69ZEMJ/?=
 =?us-ascii?Q?t3f1lnEo92JWOeIpUj8bFsbKn6tUI/k5js4tnWXwyhCAraSfZDxHG51QlUOi?=
 =?us-ascii?Q?oIh/mbnTkTOxBtxRXGz/hmIWPWU4pzNG3jouuHYw8nzq85VuOvNflPTOetvX?=
 =?us-ascii?Q?2kpM9a6l26MqgsPI2Oo4mIjztwRWRn6iTJ0gR2JJFmrKUBQIpcRqegprs3Vn?=
 =?us-ascii?Q?4ibgpFq4p7C10km2kVor3gmGEc3npdRXFK+TCwSj7Ei1tb/vs/z9MfLvjRZk?=
 =?us-ascii?Q?F+GK2WBkHNG04Z2Y/AFQ5zZF96xssPNsYaVdeuhefpXjs0eRAqt+/zpw8g5/?=
 =?us-ascii?Q?Nvcbpg1BUQYViot/oK990MVW9pRsQXGXDpoQFnwzx3S4nueLX99boJlcmuI0?=
 =?us-ascii?Q?uy0BgbLGgkbW1hEiW5ii2f2os/pEZtVGO3+Q+6r++p/lMdX5ED1DsXBFl0Lb?=
 =?us-ascii?Q?jDVo5c3ZA7cyaZXRMTP6n5/6oGeo7c7sx+BLaQ1B2jXFy5kq7QW2Zv3rbmlI?=
 =?us-ascii?Q?YKJRrkttx1RkDYbBRwagT9U+9BDeZkMXYsqZCG670VfJeyLhgacArdfA6pgE?=
 =?us-ascii?Q?M+UHumKYJzmLFwZEGmOPOkI1qAaLRstAbPsgJNHG03wzvTeTdLDRl0dKIu8Y?=
 =?us-ascii?Q?VCntvV1Z/4e+5X1hWKHMZILhi+KzaBO0C2kCK/vC0jXpTlpMzg1UJ/vcq7+j?=
 =?us-ascii?Q?0FvWYzgUeSUv1RjAzZcHlFUgbjSGOVhiZBWlDRvHhyIDNZPXX3oDf4fLTAa7?=
 =?us-ascii?Q?kAx6XgJFNTUk9XO1YssX1SVpOr+Bxd2baJI65g5Yrzqe8IYJdnH3OJxSpCYr?=
 =?us-ascii?Q?N+y/FAxPtDkxEGjzf/PzoQZUF1e4MarqtYM66tN+6e0PCqmfUWcYvvcvotPN?=
 =?us-ascii?Q?ZE8+czXlsW2VykDtloIkfWHJf1R2jj9v0DAE7XugZXECA13gwFSOcePZL8WO?=
 =?us-ascii?Q?qyoTvHIfS94sSd8Gqzd3TVbprzGYOlRW92pDPhxdIsX2h7jKuNWtZ9BpOA4u?=
 =?us-ascii?Q?m6oq5baKrQ9Mo3diq06LgX+NhoLJQY8BmGeSyMSFkhuHCM3Mlw9b86fdzkb8?=
 =?us-ascii?Q?CIXIFRMTrS6z1zGJYSsCF668sczTczRpLfMqfyvFYRow6jEIW00ce5+/NWpf?=
 =?us-ascii?Q?2KLEaa6dOH+G+FQp7n4sGwgragqYosQmJYpMtSC2SK3ZKqut7jIt0yHJcVqi?=
 =?us-ascii?Q?23L4R1RFcbG02tIcsqMhFfsn/ewCWQQ43EqEZSSdTOGXfgYdHnY6tRgJQdJ9?=
 =?us-ascii?Q?IPLdsqWPng/GK5V+3DP+hC6rQIVPAEKWuhuMdIP48SEUr7horUwXtwcIQJG3?=
 =?us-ascii?Q?1UHmX681NJN23LOrWlfeRA0rj1BX8nbOEoBuuZaqiNPJFChowyva2D6FJn1Y?=
 =?us-ascii?Q?T9M8booT4oj86Io91Z2JdEkf6c2BdcxIB/KZZHeEg9P3WM9QTPOMfB9naFTh?=
 =?us-ascii?Q?CGFopAMYAjPQQHYLQ7cZt9RfBz5JRG9WmE8yR2HIqqP+BCz15iUrFVyj47x1?=
 =?us-ascii?Q?0MWJiuHrcjRY48SC31p/Tl7zNQ/TcEpgzDvmMoZmqgwoUG54SEZY9JuZI6DR?=
 =?us-ascii?Q?WKlZIuK2vP9Cd40iSk0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8211.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d6fbba-25a2-4062-a4a8-08da9bc16c5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 11:07:07.4922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CYvlWNSQZe7Px7BJ48n6PTgz5gO9Je4s3J1JJmvgFYGDQkOlAxw9IhGgSj3Trr9c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8887
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Herbert,
Please find comments inline.



Regards
Varun

> -----Original Message-----
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Sent: Tuesday, September 13, 2022 3:59 PM
> To: Varun Sethi <V.Sethi@nxp.com>
> Cc: Pankaj Gupta <pankaj.gupta@nxp.com>; jarkko@kernel.org;
> a.fatoum@pengutronix.de; Jason@zx2c4.com; jejb@linux.ibm.com;
> zohar@linux.ibm.com; dhowells@redhat.com; sumit.garg@linaro.org;
> david@sigma-star.at; michael@walle.cc; john.ernberg@actia.se;
> jmorris@namei.org; serge@hallyn.com; davem@davemloft.net;
> j.luebbe@pengutronix.de; ebiggers@kernel.org; richard@nod.at;
> keyrings@vger.kernel.org; linux-crypto@vger.kernel.org; linux-
> integrity@vger.kernel.org; linux-kernel@vger.kernel.org; linux-security-
> module@vger.kernel.org; Sahil Malhotra <sahil.malhotra@nxp.com>; Kshitiz
> Varshney <kshitiz.varshney@nxp.com>; Horia Geanta <horia.geanta@nxp.com>
> Subject: Re: [EXT] Re: [RFC PATCH HBK: 2/8] hw-bound-key: flag-is_hbk add=
ed
> to the tfm
>=20
> Caution: EXT Email
>=20
> On Tue, Sep 13, 2022 at 10:01:13AM +0000, Varun Sethi wrote:
> >
> > [Varun] The proposed patchset makes things more scalable. With the
> hardware backed key flag, there's no need for the security co-processor d=
river
> to register separate set of algorithms. This makes things simpler and mor=
e
> scalable for the consumers (OpenSSL, AF_ALG, KTLS etc), as they can conti=
nue to
> use standard set of algorithms and leave the key specific complexity to t=
he
> driver.
>=20
> Users already need to specify which driver they are going to use in order=
 to
> actually access the hardware keys instead of getting a software implement=
ation
> of the same algorithm.
>=20
> So I don't see what extra burdens are placed on them by the current regim=
e.
[Varun] Problem with the current approach is that it's completely disconnec=
ted from the kernel keyrings. We are using the trusted key rings for storin=
g the hardware backed keys. Now, for the hardware backed keys we can still =
continue to use the existing generic algorithms exposed by the crypto drive=
rs. With our approach the driver can distinguish between a hardware backed =
key and a plain key, thus perform the relevant operation.=20

As a part of our patchset we are also proposing modifications to the truste=
d keys, in order to store additional meta data associated with the key. =20

>=20
> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au> Home Page:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fgondor=
.ap
> ana.org.au%2F~herbert%2F&amp;data=3D05%7C01%7CV.Sethi%40nxp.com%7C9
> df35ead51ad4143067e08da9572d5d5%7C686ea1d3bc2b4c6fa92cd99c5c301635
> %7C0%7C0%7C637986617695149505%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000
> %7C%7C%7C&amp;sdata=3Dt5RXelrFDZZ7GdMyZeLcSR2hRN6O0Hs8uI2MpIwhCms
> %3D&amp;reserved=3D0
> PGP Key:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fgondor=
.ap
> ana.org.au%2F~herbert%2Fpubkey.txt&amp;data=3D05%7C01%7CV.Sethi%40nxp.
> com%7C9df35ead51ad4143067e08da9572d5d5%7C686ea1d3bc2b4c6fa92cd99
> c5c301635%7C0%7C0%7C637986617695149505%7CUnknown%7CTWFpbGZsb3
> d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C3000%7C%7C%7C&amp;sdata=3DV7NXYx5pYPjte6jlw1gpYCBPftJBZGpHBN44
> e3pD0ps%3D&amp;reserved=3D0
