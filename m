Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E548B5B6B49
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Sep 2022 12:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiIMKBv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Sep 2022 06:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiIMKBf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Sep 2022 06:01:35 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDE85B791;
        Tue, 13 Sep 2022 03:01:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7T8/dnmHiYXiFXscNRr6eP/kmc9VJ8rcjFTbQ8MKsTl+g8NYPoI4nVF9NDVWsxZnAg6/XXA64mCwTie5CREHMCMRkkqGw+//eG51CTvPqDCSDc0V0Cm0LKR+7upX6rXJ/faHUHdEwOncEMivY0ZgoEMNdXdLjUyXShc6mdAFG4OZC8FYmEadRN4grQ7kP4Ota/A7Ro8W5UBXw2G6tpTtdsQTgQ+SpnCEgG/h0GtFGQH9J7KBl0+YEQGU/j5/sUqdWh1MrZvCfPiPc9PTO9gsvb6Ti0lgmmHX8T/0B7w9oNjjeb29V8SQjWMpQSvrnl+bfySHrOe/uD+nz1v6ouFQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19BqSNokr0sYx8tyMSX8R5LTFo9U6tlf0bPJXZXWddw=;
 b=PM4FyoLIo8Bk3vXc5p7GfVFGkPNdEO9nFXAAytVAfvHRR+PUz03wnY5TKyDm6u/y5/GFb/aSfXWXs0A0E5ONpf8NR1RkUEifKiQyCGpeNadrR6TKa8UiopmAGcshSvXpCynhWWIJlu9Y2TXKjlDuw4Ois2BeWe4SG0N5VX6r6noKfTOTIftq8GoFBRKEQ221Hvn5kieLoZsgZqOlgMUp1W/GPaEISRNTD0rTmeN2gWfMQ7q6PFbI8qOA1e7YPm5qXRqAFbSzvK1CVkMiiU/n0CV8tDBI1QxtQZwy9jn8g6lVc4FtQT5ecv3hhfvcp8xxWTX9VKMlSz7XgLpGjZx/mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19BqSNokr0sYx8tyMSX8R5LTFo9U6tlf0bPJXZXWddw=;
 b=s/qwTHNhKV/Rt8IheKc8fyBvE/WF2E4fxkIiJyHmY9wc9BLr53niIltnFxx62khiW8zb+Sjh7UCFg7cjswI7fQK/L65l+tcku2DqsJabcZIfCdBmh4P+M9sBp8TZAgAS88hjtNAUqcwOjBAiee1vCZNJr5wBP8wODtElVikX0sA=
Received: from AM9PR04MB8211.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::17)
 by AM8PR04MB7460.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 10:01:13 +0000
Received: from AM9PR04MB8211.eurprd04.prod.outlook.com
 ([fe80::dd7d:c23f:d6f:db70]) by AM9PR04MB8211.eurprd04.prod.outlook.com
 ([fe80::dd7d:c23f:d6f:db70%8]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 10:01:13 +0000
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
Thread-Index: AQHYwbSVJxssHkcinkOJLgRDaMQm8K3R9HsAgAGdVwCAAAD6gIAAKqCAgAADO4CAAgk08IAG3V+AgABPatA=
Date:   Tue, 13 Sep 2022 10:01:13 +0000
Message-ID: <AM9PR04MB82112828E21FDA2043073216E8479@AM9PR04MB8211.eurprd04.prod.outlook.com>
References: <20220906065157.10662-1-pankaj.gupta@nxp.com>
 <20220906065157.10662-3-pankaj.gupta@nxp.com>
 <YxbsBiCrIQT/0xz6@gondor.apana.org.au>
 <DU2PR04MB86308036FB517BF8CAD3D32795419@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <YxhHkz+UlE9XAG/Z@gondor.apana.org.au>
 <DU2PR04MB86308DB7CFBC7A31CEB612D295419@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <YxhuC3QlurfSgdXG@gondor.apana.org.au>
 <AM9PR04MB8211C7D59379D4C9F877D20EE8449@AM9PR04MB8211.eurprd04.prod.outlook.com>
 <Yx/lc1YjWm9+df1r@gondor.apana.org.au>
In-Reply-To: <Yx/lc1YjWm9+df1r@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8211:EE_|AM8PR04MB7460:EE_
x-ms-office365-filtering-correlation-id: d9aed664-5798-4f5f-03c2-08da956ee411
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LE79AuoGnGF9GDoXFL0So7VgggrAqGQNm1ZQ6t241ODEyR7wRNXMHoQIaKTJF10dg+251Srt9iS7o38ZkQbaPIyuOGJ3um/kokfqgrr37trfKbU7uXbVsIK0+TkSiLIJbuED0UrhdsuVpSJu5RfIwq8LZMnjGpKNPW6fy6YTjAYPVyfvcrT9L+X2OuVFjmTiNnizmEmT2j89mfVDqz0C4cZ/cgxaXNIKbvxYPcrpv1z7STbKXmYNVBQDq0udJazM8nmp+dA73txDPHEImflk9Saf8C+SkPnumkLW1V/v8DHVCbMYrorUv2ScdDx9oytU4PyTwxoTL7sdA+H95S+58KxgaZkj682sbp3TWpV0Lk7Z++xTcZFTUOnsHoW6ABwEXB+6J3e05G0Nd8vAgfFQbKWSKN7Cvj1sZ6r3/mJZf7+3uCUItcEEHIbvdKqn/ElI1t3SCLv2Ko6n0qew7qxOceWrRtQwuqNm1CsTTIM2QFEpQ6RjdljUKk2nNdpce84TSp4rUwsFiSiqJjG4SpO93bHIgHrnqL9dqLak4NE99zNeG7FsXT5ZrregHWCtR81hA4EfVGUF6PA0f5R06ssUcU++bmf3Yl9PVuOdFqKyoALJCH5oH5GLowyh4sVa0xPB5K9/1smxU5n49LOqAyd+OEpptTwELayQl+pUZjpu3TW+61KvOgvMqPKW82O3/WO69aFe2n15gmWzrMEdtKOQYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8211.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199015)(7696005)(26005)(186003)(4326008)(7416002)(5660300002)(86362001)(966005)(6916009)(54906003)(66946007)(316002)(45080400002)(64756008)(8676002)(55236004)(76116006)(2906002)(52536014)(66556008)(71200400001)(8936002)(478600001)(66476007)(41300700001)(33656002)(55016003)(9686003)(83380400001)(122000001)(66446008)(38100700002)(6506007)(38070700005)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l8MGHONMaIcIPzIfljHcFty3nk82lJ1w6kYLS46XhxK8D5TvdWBcUAlwEuqc?=
 =?us-ascii?Q?agolXzeY1+4+/Jria8OZTr6V1aeMlxyNlkWhi0/uDiV+TpA0VxYzHhCgwlHx?=
 =?us-ascii?Q?GOx7I8Xw1/n6TRbAKAGlN4xV5qp/DCO4G5pcbdLzioSqNivcBPChbs3uljBO?=
 =?us-ascii?Q?EYq6TixLtCuT/gmwG3ilAD7JZ8NiK5HrN4cTHnZPyckfDhXpW1cJUXY/MjjO?=
 =?us-ascii?Q?duZaB5q7aZpeg9WUESBLdkwm/nx/loU31WmcCMsc2aVgNvz1CX0Jiq/8mGqB?=
 =?us-ascii?Q?QXr+XMiRoJ044dyisQMnGKTpkhxRUQUvfpsSyVZquLDNGty2wawdsHyDwuZp?=
 =?us-ascii?Q?u+7tsubHAz1QoxEwqM8qIB3PPGWvzn0XvaSZk/ujM7SB8XAEtlHKc+193+D1?=
 =?us-ascii?Q?M5wwycwc8j/QWWqtDLDWYEBmKE9v0R0ndUyxnnVN/I8v0/E6OB7PIqQ18a7k?=
 =?us-ascii?Q?699fMtcyXcuVfsu8nNjA3XMZYFMvUViIVazCQChFLonByU4elJRXBWbLJojN?=
 =?us-ascii?Q?isn0b9cZYlC/l8JKx8r82uGi1o7DoEAwOggFGd9tCuJzYkpFJUdpQiJH0EL2?=
 =?us-ascii?Q?YuHJxgvFkEdZVWoQUuAvPn41+6ND9N5wziU97SGww2Udnr7Ktk+SOLnbh0dm?=
 =?us-ascii?Q?T+PaphAyC5cZDkKepXdXB9d2RxQK1vIhlsGI5wBSvHAYDaH9pdFe48kE6J0M?=
 =?us-ascii?Q?ts+igWubKWtKKcamasbuTJjDPLdP82iBu8R+ZuvYnovUzye4xHTbQJQ6JSMX?=
 =?us-ascii?Q?sUWRTGCCzFFfPQacGQ8QNd+ew95H/cFdItlmTbGFzqS6JU9Gc54n+oZZplHS?=
 =?us-ascii?Q?hoIgyuJoMVHQPDP2Hd8UaI17eQ8jOQP75+YL3nESxN8V3Sqb7VuODq7AURIr?=
 =?us-ascii?Q?gkNvCH/gAZKxScba8m5giuRT9PcP/rWQZYX18qOFfaGBhB2D1RK2h6Ab+TP9?=
 =?us-ascii?Q?YO+i+ynpL+cgKKRvv1TSquLrgy6/NAik0E0x+DYWkML3mtz1LzLNmlXO+UMi?=
 =?us-ascii?Q?X5A6UCcCZnr0q2MdS3ax+QcWNfSD5u4x5Me0ZzEAF4gRvKmuzfL0gv0i3GVh?=
 =?us-ascii?Q?Ub2QKIAE6odMSVaMrxgms6Ha8DfBLh4QHaQEETOF4FfE03R6ajPreWS0Hn5q?=
 =?us-ascii?Q?xHEKaZY3j1f1PQNe5FyENIdzBgevxkJHD9U7FLmN1J9fV3k/egzVBa0aup2I?=
 =?us-ascii?Q?+33uNqckxS6qv3Z5/TGYLXKl9jVtiaQWnwRmBud2pqMMlL5/RhIK+GjGSGB8?=
 =?us-ascii?Q?NuJAMWNf/w9wxMYS2gg0rLmRCNXrn0y7nnIAABu1iqoa8HOAv36mUshiSDJk?=
 =?us-ascii?Q?zlhU6qY+lKG7vAG/Z43UCwoY784uWAuDAwSoXH9nsJI5FlPcZ04DGFSj3zwm?=
 =?us-ascii?Q?dKHnhl+a7qjnXTNMUiLiu9PDHBc+Il+a0kLRMxiCwyiLWpWn4HBzBmPEMZCk?=
 =?us-ascii?Q?y+YaAKzDvM/4yjuqfXk9A0gWM8BN4z3COU9Zv7RMIUcaFho9A+HC1KHYac4C?=
 =?us-ascii?Q?L+41AG/EFvuAATHjg0y888iqmzskh+lHdxIQef7zem7HIRrCJ3aS4gf1UB6S?=
 =?us-ascii?Q?EbaIq0QfjmF94y1WRow=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8211.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9aed664-5798-4f5f-03c2-08da956ee411
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 10:01:13.1295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dqcUlzyr25d9W5EmAZJNBxwt5tHIBtIZ6h68ODTGzufGNolNc6jWDsdYr5jiCxL7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7460
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Herbert,
Please find response inline.

Regards
Varun

> -----Original Message-----
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Sent: Tuesday, September 13, 2022 7:36 AM
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
> On Mon, Sep 12, 2022 at 05:19:44PM +0000, Varun Sethi wrote:
> >
> > > On Wed, Sep 07, 2022 at 09:58:45AM +0000, Pankaj Gupta wrote:
> > > >
> > > > There are 3rd party IP(s), which uses kernel for crypto-algorithm's
> operations.
> > > > Modifying the algorithm name in these IP(s), is not always allowed
> > > > or easy to
> > > maintain.
> > >
> > > So the objective is to support out-of-tree modules?
> > [Varun] No, the intention is not to use out of tree modules but to allo=
w
> seamless use of crytpo ciphers with keys backed by security co-processors=
 (keys
> only visible to security co-processors), by Linux kernel and userspace
> components. Hardware backed keys are being introduced as a variant of exi=
sting
> Trusted keys, with the difference that these are not un-sealed and releas=
ed in
> plain to the kernel memory. With the current patchset, the existing set o=
f ciphers
> can be used along with newly introduced hardware backed flag. The securit=
y co-
> processor driver is able to interpret the flag and subsequently program t=
he
> hardware, to interpret the supplied key as a hardware backed key.
>=20
> Well I asked why isn't the existing arrangement for hardware key algorith=
ms
> sufficient, and I was given the response that you needed this for compati=
bility
> with third-party IP(s).
>=20
> Now are you saying this is not the case? So the existing framework should=
 work
> then?
>=20
[Varun] The proposed patchset makes things more scalable. With the hardware=
 backed key flag, there's no need for the security co-processor driver to r=
egister separate set of algorithms. This makes things simpler and more scal=
able for the consumers (OpenSSL, AF_ALG, KTLS etc), as they can continue to=
 use standard set of algorithms and leave the key specific complexity to th=
e driver.

> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au> Home Page:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fgondor=
.ap
> ana.org.au%2F~herbert%2F&amp;data=3D05%7C01%7CV.Sethi%40nxp.com%7C6
> 51bdc5f5da249c7f23408da952c9980%7C686ea1d3bc2b4c6fa92cd99c5c301635
> %7C0%7C0%7C637986316034004134%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000
> %7C%7C%7C&amp;sdata=3Db%2BjXwEqMEomgvSpLVnNzuWRNbmfQF4pX5hitrFh
> Frww%3D&amp;reserved=3D0
> PGP Key:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fgondor=
.ap
> ana.org.au%2F~herbert%2Fpubkey.txt&amp;data=3D05%7C01%7CV.Sethi%40nxp.
> com%7C651bdc5f5da249c7f23408da952c9980%7C686ea1d3bc2b4c6fa92cd99c
> 5c301635%7C0%7C0%7C637986316034004134%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> %7C3000%7C%7C%7C&amp;sdata=3D6VRL5smACsEevXL8HKs2ADlni9G%2F9J0q7E
> 3Q2emxVzU%3D&amp;reserved=3D0
