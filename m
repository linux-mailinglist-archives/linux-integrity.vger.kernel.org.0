Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D90D5B011B
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Sep 2022 11:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiIGJ7p (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Sep 2022 05:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiIGJ7W (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Sep 2022 05:59:22 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2042.outbound.protection.outlook.com [40.107.104.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0409B69C8;
        Wed,  7 Sep 2022 02:58:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGZYGWwxfp0ybj77Z+7d/29eFKkdC02WV2leCNw0P8B7GFyd9ZTzYo294RmpL+7yldVERdDW4HW97z1Ip1zhhLBUoBs3U4wxFY8fqbjhpZjsHmOuRARYGRq/YO4azRM3czmjcsvzFnr0wnzmbJoLSFo7lcqX+0WDc28+YThFzn68dsVmbiu/zJqXDv/e3DYwOHJLBLGpTrPyqnD0bVZ/c9nFzXPyoQnBCWvk0TT0gmp7ANwUgEmkfvKeFiVpfNKh9l25yL3vrfZdAt+Cu63ALM1R5H2vVmNwebFmgEptrcUsODG5zIWcruCPyQC/iBf5Zv33wecJKgm/+oJQ5RnCmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1dtBXh6X/qhduiuR3xxSk02R/+ZQNXdVaOhQu8oT3o=;
 b=RH6SatcTQKk0zLgnNHSjk23tcVvEQNhVU+wYhHc6PRMdEIkn/+uFiiqrgEKCF1wyCs+oTHUcSQXfEbs6wU+X8RnNBkk49hWrCGZjiNjTKERu7DbJ7xkDeDS0+y0uIdcuIrI68Ibali8PU4SV7y5UCuGeDRGUFgYHdMk97Jl2uqKKaCM1uZducVbn34BpJINEwE0G8d+CT6KWX5lVenf6NC9j6VpBnOpyFafzEdzy1HQ0AZjjI3DE8NPvsxWwdSejLVq+fmGyx8/eM6dmSGzzHpW3kgdt8r1YicJLJPNF9VioFmhVCXncnkl2dbbT/05FRJ+uf3dSTurHnYZcytyjdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1dtBXh6X/qhduiuR3xxSk02R/+ZQNXdVaOhQu8oT3o=;
 b=pn/3vnoKw6sxRZUdpIp4TGOjosRVWntmRK8E4OcQyN2LsIyFq08xP0goKuXG8e47kU3gNAuWA6XwS45Y71AwaaSjUFuBIQtxtQ13oQkXlt7/kU5p78FCITewRfyaIQ9X1HVB4VPqcCSI6TCc5S2mckQYKjo3F3+Z2J79CUMAtsQ=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by VI1PR04MB4158.eurprd04.prod.outlook.com (2603:10a6:803:42::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 7 Sep
 2022 09:58:46 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b%4]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 09:58:45 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     "jarkko@kernel.org" <jarkko@kernel.org>,
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
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [EXT] Re: [RFC PATCH HBK: 2/8] hw-bound-key: flag-is_hbk added to
 the tfm
Thread-Topic: [EXT] Re: [RFC PATCH HBK: 2/8] hw-bound-key: flag-is_hbk added
 to the tfm
Thread-Index: AQHYwbSROQtM17Y3rUes00GOEj1Wxa3R9HsAgAGPkHCAAA7BgIAAHQrw
Date:   Wed, 7 Sep 2022 09:58:45 +0000
Message-ID: <DU2PR04MB86308DB7CFBC7A31CEB612D295419@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20220906065157.10662-1-pankaj.gupta@nxp.com>
 <20220906065157.10662-3-pankaj.gupta@nxp.com>
 <YxbsBiCrIQT/0xz6@gondor.apana.org.au>
 <DU2PR04MB86308036FB517BF8CAD3D32795419@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <YxhHkz+UlE9XAG/Z@gondor.apana.org.au>
In-Reply-To: <YxhHkz+UlE9XAG/Z@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|VI1PR04MB4158:EE_
x-ms-office365-filtering-correlation-id: 40e09fce-8c9d-48e6-77de-08da90b78dda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wP04vsq+wJVFlW84b8xwmmG3RMmUsLYFfBuLC+Jb5E+2JS+wGbatpy+dW3/GU62auYGCLea2J4YJ2KAJ7emaf1v6y4SL16BmzaRitPobymnpJ+75VRG2i3Pje2PgvzNtQlX7GenY7isQoVa+5k0Ch0jBtQN8n1oiXPsbQxFI8qBrbXrbfEJz2wBVhXg1JGKx3v9EnUzZlxsWJy4TTEgKfbFnhmvKEKGHt8GtmuQ0+mVPWSoIjgCV7OsavNnoUKIwuH5d4gcPR32jVk83RtGVBzZGyPKq7eE2OCbZqUCz0DoGa2rrOfSQlNAILAoA2GDI3cO34P/W/P92fJuxjGNq2TBFgNV//6zQIdPf9OmgK1nE0G9S9K8v/bK2q/1t+4jgyvFVhPvDOVkk741obSZt9h0YC6Srj2gerY5tIgAdBfkyP9NfYMcL+G/gOvPLrA7cYDfllPvAj+T0HAsBMhIaQtMmeC6MuzSebw6aPmYH/h3rJ1qdgisuLTCJriuLKIOk6Dj3Adkw0Yi0lFlOhlTHA7XchcKlWzE9BU3xuc7W+W+bleFoOtrGev7FB7y1PHvxmvQ1H6J3FTRy7mOcUceFXQ/dX64gznfjueYpme+DSLCyi33IamfAW6PLxaSSraU12bLZqb7kFh5+9y14mzC9BMKg79d2juv1AiVhQK7yebJ3vIFGNPvuX0ZTMN9GPA9xQOZS7X/+XbX5K36PKHQOHwmdECi+XCFLicXBjzmLxCZBkzZkE3LJXkWb7OiVLQoiDu8o+Uf6fbQlSoP78PH8Etth6ujaFuImtvhEoO+9DvE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(55236004)(33656002)(53546011)(9686003)(26005)(55016003)(52536014)(316002)(64756008)(76116006)(66476007)(8676002)(478600001)(71200400001)(66946007)(54906003)(4326008)(66556008)(66446008)(2906002)(6916009)(83380400001)(86362001)(966005)(8936002)(41300700001)(38070700005)(44832011)(7416002)(5660300002)(122000001)(6506007)(7696005)(45080400002)(38100700002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Iu4bqgpIIZ8cSjS0t5FHlrY33N5WIm8OQO8aklly1yD8AIUdsFCit9ATfgTU?=
 =?us-ascii?Q?59IMszIcfjRDoxbLgnl+W5AZiZ5ESLZgfqqBobz4308N7k122L+fGYJxAqGh?=
 =?us-ascii?Q?h3d9ia1g933aIcJeoKmslzcmS1QQ2s6cNcxuftqkQZ9pqx22s9BPgHd/SS00?=
 =?us-ascii?Q?gi5st9XbGbZxpx6GjB0QAggt/SXB77bcB8mDbpF99saaoKxR/0A+XeLmrjqf?=
 =?us-ascii?Q?s/VwI24YxCMpZQzHPJZ6GmSv1pgQWKNUr5SaieUWhfrHX/kF3+IxlB5uN3vQ?=
 =?us-ascii?Q?Y+YuU9KBgaB2Us8ZaxyKIupoJ5LLXkB4YJhRgPF/ccMV36TwmrHs3WTMD/dE?=
 =?us-ascii?Q?1rYnzxnnZUqLKlJAOKxsLghfzcAy9XR9MR0N99DHUJ3YcAeVkaOpBQlYYjyP?=
 =?us-ascii?Q?afOGcjgm19375yzipWS5oC88uoYcmTzlgSTb2QxFsI4L9OXAkrHXznE0gpFZ?=
 =?us-ascii?Q?ycXihAw9ut85t+E3Ez8k/bdaBPPI1sOc4RgZ8IIhE1e5XMNfkK1tL+hQoYTV?=
 =?us-ascii?Q?PoTPfQpFD8GxQAzBEMdhnQ73eMuy+D7XBm5xW53PhVv4TdeY5v0WSsw4hkYd?=
 =?us-ascii?Q?ctolUTLICJz9rgZ2ubFADX/uAtrWYEUgVGQVVicZ3rtuMYqPOyNY5n1ufQAn?=
 =?us-ascii?Q?2vNkMOJlq/MTClR4s26jYgB/CkphuBDdjBgLmN6jdF5ALi+PyPL3uxMcYYRv?=
 =?us-ascii?Q?Uzc+hFn+UK8P3rtll7rhHp0CTr0tA/2bGrqTbxZ72479y/WCLp4oxLqTIo4a?=
 =?us-ascii?Q?2k1Rgf4cAq9LlqmhuWWu2zn14wAlHoW6dg/HrKLbo8IWAxxVNMoHfY93ON7E?=
 =?us-ascii?Q?Sv0WfVmc0QOmRwNYg7aN59xWoE57krcWMFiVBWr5/ZjS3biliz83KsfxDWD+?=
 =?us-ascii?Q?A+HXluUx8m1RBcsjshTmyBVB5DPqIoZYkdHCAY+51buMYYwtYa06R3RekGf+?=
 =?us-ascii?Q?hKlTht2QZw4D7QT0K7hn6uUfAS7HIACIdZooGTlJXBkY67OY5ukF82A6xn66?=
 =?us-ascii?Q?j/WU8zTx95hiOYQxcxDV1vG9LzvfDz1s61VTW5FsUBWuxEKfyZchCSZEJUEq?=
 =?us-ascii?Q?N6YzFnSdB8I1l6YHhf+ECCsEQdp8tDHXGkFrs6T7TklCbGi0lCx+RJs7hU91?=
 =?us-ascii?Q?zZI3i06Uf5EUtt/u3AZiH5wQQjkH5nrdRGRpNIK8kQcsSbWJQrKJgGDG3A4B?=
 =?us-ascii?Q?HDFYMDNPUUHkubB+LOYIYU3ZnF8WvL0zkFRG74aECcWjA/nxO/Vjkng3I+Iq?=
 =?us-ascii?Q?IwPGrjULrebRItIjh6IqYHpkSWHSQKtdm5cQpG0Hnhf6At+y4+1QvU8NMDJM?=
 =?us-ascii?Q?cYwaKX90G+5fMhheG5acJvL3gOkC4qTBb5ry7748qpxakjSYBOgFY1kRmhdb?=
 =?us-ascii?Q?s25zZBXM9KGh0UIfo0YnbsQrxvlTSuu6c53hqPwiICmP+79242y53XGwjqFf?=
 =?us-ascii?Q?D4kr7Oa6Q8LbVVkXLIjE+jpDZTwvQVAZelMN0bbkTEiBTLcd8se8qGb43cZ1?=
 =?us-ascii?Q?IbX7iCwO7/Bf+HyhNyKY4ymhtSc/dKDMVwfngtMqWSIo/smx6oUlOSeSOYsD?=
 =?us-ascii?Q?vKujqXFKCPxXCs6Fg4gzA0dOSYeeX2/pQZgB+Nik?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e09fce-8c9d-48e6-77de-08da90b78dda
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 09:58:45.9041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lUziX6y1HKjC6NP7/jj04+eiiyNtWZx49o17T0yWPZhlqEEmMxQw0vWoM5jwgINbjGd1/oIvAV2qjRS/FC5f7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4158
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



> -----Original Message-----
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Sent: Wednesday, September 7, 2022 12:56 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: jarkko@kernel.org; a.fatoum@pengutronix.de; Jason@zx2c4.com;
> jejb@linux.ibm.com; zohar@linux.ibm.com; dhowells@redhat.com;
> sumit.garg@linaro.org; david@sigma-star.at; michael@walle.cc;
> john.ernberg@actia.se; jmorris@namei.org; serge@hallyn.com;
> davem@davemloft.net; j.luebbe@pengutronix.de; ebiggers@kernel.org;
> richard@nod.at; keyrings@vger.kernel.org; linux-crypto@vger.kernel.org;
> linux-integrity@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> security-module@vger.kernel.org; Sahil Malhotra
> <sahil.malhotra@nxp.com>; Kshitiz Varshney <kshitiz.varshney@nxp.com>;
> Horia Geanta <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>
> Subject: Re: [EXT] Re: [RFC PATCH HBK: 2/8] hw-bound-key: flag-is_hbk
> added to the tfm
>=20
> Caution: EXT Email
>=20
> On Wed, Sep 07, 2022 at 07:22:42AM +0000, Pankaj Gupta wrote:
> >
> > Current support, does not permit the hardware to support both types of
> keys: HBK & Plain Key, at the same time.
> >
> > This change is generic and permit any driver that supports both- HBK an=
d
> plain-key, to differentiate and use the keys accordingly.
>=20
> Existing drivers simply register hardware keys under a different algorith=
m
> name, there is no reason why they can't coexist with a plain key.
>=20

Thanks for the comments.

Intention is to only secure the key buffer, at run-time.
Not to change the working of the crypto algorithm. Algorithm would be worki=
ng exactly same for plain and HBK.

There are 3rd party IP(s), which uses kernel for crypto-algorithm's operati=
ons.
Modifying the algorithm name in these IP(s), is not always allowed or easy =
to maintain.

While, this patch-set allows to use the same algorithm name,=20
and hence prevents any changes required to the user(3rd Party IPs) of kerne=
l crypto layer.

Regards,

> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au> Home Page:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fgondo
> r.apana.org.au%2F~herbert%2F&amp;data=3D05%7C01%7Cpankaj.gupta%40nx
> p.com%7C9bc412605fa243702f3a08da90a2602c%7C686ea1d3bc2b4c6fa92cd9
> 9c5c301635%7C0%7C0%7C637981324324251974%7CUnknown%7CTWFpbGZs
> b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn
> 0%3D%7C3000%7C%7C%7C&amp;sdata=3Db1ImbcEMa9jticFU7yrpwHXuuQEog
> KLrjuiE%2FFpcYyA%3D&amp;reserved=3D0
> PGP Key:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fgondo
> r.apana.org.au%2F~herbert%2Fpubkey.txt&amp;data=3D05%7C01%7Cpankaj.g
> upta%40nxp.com%7C9bc412605fa243702f3a08da90a2602c%7C686ea1d3bc2b
> 4c6fa92cd99c5c301635%7C0%7C0%7C637981324324251974%7CUnknown%7C
> TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL
> CJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DcP4js5Q0QPBJfvlrYDi0j6R
> IGFpqHtJOSa9C7YC2IXM%3D&amp;reserved=3D0
