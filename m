Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8EC5B5F21
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Sep 2022 19:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiILRT4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Sep 2022 13:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiILRTt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Sep 2022 13:19:49 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3D9616F;
        Mon, 12 Sep 2022 10:19:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4FFm8tFc/CLhBCPgOeA+X/Ade2j9FGblQs84Jd08kixUmXDt794w33QoUvMDjDB3AR/eGy4Orcok7RJuKd7M+Q55CmLsg16vI0xG9P8FKnjTom7r3ULws87/NLO0kBvzwAPx8/VYfDAb8HVzUftKo02HSoIWhdAosSlppFhgrrM9IXAELCZ9sPB8aeVDQmIPKEECY85oRrSKk3TARk7MZ4IB15qBe7cN9oakk9mef6LnFBezlMiuqb1ChIKdLHczREN4RPTL9wFOGa/X/w5+HxPtGNmPKvqCtGO3SmeV9Y1MBqVLAeu7vbeHB1Oxg8EUbzZJ0J/AhSl8UMIBrur5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZMnnhonGJM2GtBdbo8rJv6VR1Q8BI9tAG1BohAYfqQ=;
 b=iobavHucy6Y8rM6YjyGLCuS+TyZzBd8dT9zclLcZucKSmyMEdbVD/l5+jnijvdGN7mtmbFgdCN0eMY1DUOkjv4H5RX0hmELrYCCuLWZITMKW/DTiAHT9PdMRO1gf/8L0hjCbxTSc1s/UAiGm2vGGadYEV51U6NG3Vqd2FgK7qgAjMLW4V9x5X5H57rOqHA2MTkVLZpYiIukKMqOfP+LMdQnOJQOPaoKAhM2rqorBtdrHR8IouBwUFB8B4kf5NmjxgTCFPHNUM9Mcmc2ERpsK7JWpcTuOdmX3KMmRI5yTCa94+Z2HANPrW8hKyQ5FLJvJ3iQDAwkS+kAHrIbMGOBXYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZMnnhonGJM2GtBdbo8rJv6VR1Q8BI9tAG1BohAYfqQ=;
 b=P7cB7qlC4A0It/Oretbb0M6lelzzxYPNZgLm/H3P3a0qGEhQXfQSmf4sT2ucJT2msqKpAWOr8/pO8Drh3OcEGN8t/OIXB9EMZpZbWPgj4AAFAgN0coIDOhJ4PTbHKtSfInudO99yDPgwXJX14SubcMyF/4Bj0rj2NibDKEws7CU=
Received: from AM9PR04MB8211.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::17)
 by DBBPR04MB7499.eurprd04.prod.outlook.com (2603:10a6:10:203::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 12 Sep
 2022 17:19:44 +0000
Received: from AM9PR04MB8211.eurprd04.prod.outlook.com
 ([fe80::dd7d:c23f:d6f:db70]) by AM9PR04MB8211.eurprd04.prod.outlook.com
 ([fe80::dd7d:c23f:d6f:db70%8]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 17:19:44 +0000
From:   Varun Sethi <V.Sethi@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Pankaj Gupta <pankaj.gupta@nxp.com>
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
        Horia Geanta <horia.geanta@nxp.com>
Subject: RE: [EXT] Re: [RFC PATCH HBK: 2/8] hw-bound-key: flag-is_hbk added to
 the tfm
Thread-Topic: [EXT] Re: [RFC PATCH HBK: 2/8] hw-bound-key: flag-is_hbk added
 to the tfm
Thread-Index: AQHYwbSVJxssHkcinkOJLgRDaMQm8K3R9HsAgAGdVwCAAAD6gIAAKqCAgAADO4CAAgk08A==
Date:   Mon, 12 Sep 2022 17:19:44 +0000
Message-ID: <AM9PR04MB8211C7D59379D4C9F877D20EE8449@AM9PR04MB8211.eurprd04.prod.outlook.com>
References: <20220906065157.10662-1-pankaj.gupta@nxp.com>
 <20220906065157.10662-3-pankaj.gupta@nxp.com>
 <YxbsBiCrIQT/0xz6@gondor.apana.org.au>
 <DU2PR04MB86308036FB517BF8CAD3D32795419@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <YxhHkz+UlE9XAG/Z@gondor.apana.org.au>
 <DU2PR04MB86308DB7CFBC7A31CEB612D295419@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <YxhuC3QlurfSgdXG@gondor.apana.org.au>
In-Reply-To: <YxhuC3QlurfSgdXG@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8211:EE_|DBBPR04MB7499:EE_
x-ms-office365-filtering-correlation-id: fdf7ce46-3d4a-4ca3-4385-08da94e2fc88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3jVPYMV5MxNKyFaEfkIJcWTD/hUmUvOy1kmsWDpcVzi7v6rKaQuWFJpQYrzECTQvKNoWFa4we7XBAqSaxGWrLfDrJBilbitNuHh5Yjmt60seJ9OKzIlU+18zfhYY/YxuQrAE9p4esgt0hwCgX15Ih60MBTg+slJe4tLtp2Yq2baVcxxr8UDaOeuBB7p9oxrSk8V1Li956Y54Q9JOeLCf5i8a4HrmAC+76aQ5DLUsSX20Pa36kMEzIrT7ExMmRZAMLyfdKcpxue6xVNXuhCGwIyOuAGsmt7fPlseKJR9M5cG0Y7nnCoofzQP7QrOo34/h2xTAh+Ofn1EwtauejWx+c4RdOusxPEtOaQl+F3whv/E+kCJNizgQtEn1RDlK8fIPZNY/wScdt2M/ldv68qX57dao5Beh7qA9C2gAVVRkTDHsIj3IE3Gn2THWj7atIWTJk8jMkocPFRdH1iRQqDh3PlI6H+ovvQlb8Dyk9MlBZkY8Tx0XylwDpTrjXFnxj3nogeI4IZ91VQYYr/QBB8Jv6OHkFKmniWz/f9KqzAG8uUWYbPY9gXKuZ+bB0A2GWmDlcIGpTkfm308C4vyXpBR/M3pgR6gdeM0HvVGP0r58oguSIfd1bp1H5B3siqLsOmUXfEVvpsPHHJEcgvqarz/fc+W36PIFbLSfwY6jNLvBFfE5rlRbX1IShz5e0rKy5GZFt+AMsnXmW4UC+oO8P24VgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8211.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230019)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199012)(316002)(110136005)(45080400002)(54906003)(41300700001)(6506007)(7696005)(966005)(122000001)(4326008)(66556008)(38100700002)(8676002)(71200400001)(76116006)(53546011)(478600001)(9686003)(66946007)(33656002)(64756008)(86362001)(38070700005)(5660300002)(52536014)(8936002)(7416002)(186003)(55016003)(2906002)(55236004)(26005)(83380400001)(66446008)(66476007)(6636002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+0HtFVW9RQy/AiGHLLVq3+cH5iZ86/QPlI/aQuifyGNObZDafebvctEOAiFD?=
 =?us-ascii?Q?zR4XJY4K9sRNPk3MPriseKuVqeji6ZE39v0GkSNQZDHbrYe9bHG0UCv7BE4i?=
 =?us-ascii?Q?qd0AuB7cvsHTKhChZJphUzk5um8c0C1vRvAX1WZp3M2L7y3BLfHv5pleHQYR?=
 =?us-ascii?Q?qnEdJofOdlq3+OzV4inxtTrGE97raC6JrqjVikCcEWgRNvGu4OEzQsoZeSn4?=
 =?us-ascii?Q?4b/ApyzCUX66puOljE/En10FWjQLqaQgF1WEwUNA6EQgIh8WsmhWwrXXM2Fn?=
 =?us-ascii?Q?GlHwlIsR9NsLszjQ4WrDa7+KwhjoUsNuXv/bhxEeUR02o/VYih5UZZmaWyHv?=
 =?us-ascii?Q?xP87tTsV8/zvfpvNtE6UI0q9w1SfDcJNwedOWcQTkkC5Msn+xquk4+3RqpX4?=
 =?us-ascii?Q?qoodszcGaaUefmeDr8S1eVKw3KxCz6nc/w4Ov8xz1QD7XCsZE/GFmU0oPCri?=
 =?us-ascii?Q?MGkBovOMOuj81uHzAKZh/znKa3Zl3g+5jCcy4Zd7uJb8c65x5hhO+qH/dwVo?=
 =?us-ascii?Q?xOeLWzzXCONWhdH9nwyxel3gyURKIzdd/GMweZzXNlDTA/X47W8MZbqQeXgW?=
 =?us-ascii?Q?ScsqaXnqtbKJIXFO76MK3GCZNKy4v3lwrmO68oB5YEpt7kWyv/sPLTmCA+db?=
 =?us-ascii?Q?POIxZEjNLBTJKgJJ2TthELjesA1g+0yWriPSg5T5tw4te6vET+bczKD0z3BE?=
 =?us-ascii?Q?w/NgDjuG9We/LamSN/T2LZbWd98k3QvspNbTdklR0BxNh8zwJU3DO8EbYt9K?=
 =?us-ascii?Q?QGEOFlyyB6uWMg1I6fCaKAfsufZCVHjMembHeQioRhWXRlQg/aAUEY+JOzcM?=
 =?us-ascii?Q?ZT//+I9JRwPqbNKe1bbcZePPZZMOkFEVtIegO1KpUP26g9aatm/JBgVmPDJP?=
 =?us-ascii?Q?1nWQOUMq8tKDnv5BRUNn6XOuDuUSIFblMyAFUjdO2fsqp12qAkbM1eqe2gro?=
 =?us-ascii?Q?PZXdPAf0h4JOePV4T5w6FKiBRRFvdrDWHlR7phZp9WMFacw6NYAZtfZVIrEm?=
 =?us-ascii?Q?k9QiSVIz5NIfbSXjjOsrNqbbJDmVMozVnkc7SL4ODyrULGwC6M8/ngel3kff?=
 =?us-ascii?Q?ELRQkxL14oZF+MCuH3WUxzhIOHFNbtR80sOxtgN3B1uEywPHMRCM1YQMXhMd?=
 =?us-ascii?Q?TIphDTB16/+RfNQIsJg4BvVJBjyLQ4HhTVJfzmNCRSpKpoBvu+IHUrgJAnPh?=
 =?us-ascii?Q?GhtYIDMIN1TxOHHYlGoSWKObpm4Vodf+6+KXv/bOum64TYuSu8qU81Isu5xO?=
 =?us-ascii?Q?GcdmXsv8t0kCAvqgKeLidspQpLrJNvfDW+mSDLjqI5AGEldvTGcV5rNDtJyL?=
 =?us-ascii?Q?vTpipxCmPBcWgP0zD6bcdcxjd+ZkecX7geS8OXxBSRxBvxDljqyxB+lbNmKd?=
 =?us-ascii?Q?W5yS7d09eTbIXL/vCaB0s+cMHnSgk0eqiN/rJgDPyL72Iz2ZrhMOO1NoMJRJ?=
 =?us-ascii?Q?cD46Kpralcd0fhwLVcoxgd+xt+TkAzZ9ffa1ro69Ht6Lt12654QB+nW64hid?=
 =?us-ascii?Q?Rj+rpWBhqsLmzSGUG/cCEIjPTLByPUjQ3XslrcWxgzpLXHChTw+BnWY9UdMI?=
 =?us-ascii?Q?emHF/4J6dg1WITbNqhk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8211.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf7ce46-3d4a-4ca3-4385-08da94e2fc88
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 17:19:44.6186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wGaBfj+wpnUDc+EsIqRYUYnZvKFviz6AcQTnkMfI4u35hoy7uTKV0yeMhOnwA8Pq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7499
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Herbert
Please find response inline.


Regards
Varun

> -----Original Message-----
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Sent: Wednesday, September 7, 2022 3:40 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: jarkko@kernel.org; a.fatoum@pengutronix.de; Jason@zx2c4.com;
> jejb@linux.ibm.com; zohar@linux.ibm.com; dhowells@redhat.com;
> sumit.garg@linaro.org; david@sigma-star.at; michael@walle.cc;
> john.ernberg@actia.se; jmorris@namei.org; serge@hallyn.com;
> davem@davemloft.net; j.luebbe@pengutronix.de; ebiggers@kernel.org;
> richard@nod.at; keyrings@vger.kernel.org; linux-crypto@vger.kernel.org; l=
inux-
> integrity@vger.kernel.org; linux-kernel@vger.kernel.org; linux-security-
> module@vger.kernel.org; Sahil Malhotra <sahil.malhotra@nxp.com>; Kshitiz
> Varshney <kshitiz.varshney@nxp.com>; Horia Geanta <horia.geanta@nxp.com>;
> Varun Sethi <V.Sethi@nxp.com>
> Subject: Re: [EXT] Re: [RFC PATCH HBK: 2/8] hw-bound-key: flag-is_hbk add=
ed
> to the tfm
>=20
> Caution: EXT Email
>=20
> On Wed, Sep 07, 2022 at 09:58:45AM +0000, Pankaj Gupta wrote:
> >
> > There are 3rd party IP(s), which uses kernel for crypto-algorithm's ope=
rations.
> > Modifying the algorithm name in these IP(s), is not always allowed or e=
asy to
> maintain.
>=20
> So the objective is to support out-of-tree modules?
[Varun] No, the intention is not to use out of tree modules but to allow se=
amless use of crytpo ciphers with keys backed by security co-processors (ke=
ys only visible to security co-processors), by Linux kernel and userspace c=
omponents. Hardware backed keys are being introduced as a variant of existi=
ng Trusted keys, with the difference that these are not un-sealed and relea=
sed in plain to the kernel memory. With the current patchset, the existing =
set of ciphers can be used along with newly introduced hardware backed flag=
. The security co-processor driver is able to interpret the flag and subseq=
uently program the hardware, to interpret the supplied key as a hardware ba=
cked key.
>=20
> There is no way I'm merging this then.
>=20
> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au> Home Page:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fgondor=
.ap
> ana.org.au%2F~herbert%2F&amp;data=3D05%7C01%7CV.Sethi%40nxp.com%7Cd
> ec165619848426b9c9008da90b946da%7C686ea1d3bc2b4c6fa92cd99c5c30163
> 5%7C0%7C0%7C637981422690327443%7CUnknown%7CTWFpbGZsb3d8eyJWIj
> oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C300
> 0%7C%7C%7C&amp;sdata=3DkKaGEvKOmUbV8hCh6T9Fswfo39jg%2BqbxYavPcfJS
> h3E%3D&amp;reserved=3D0
> PGP Key:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fgondor=
.ap
> ana.org.au%2F~herbert%2Fpubkey.txt&amp;data=3D05%7C01%7CV.Sethi%40nxp.
> com%7Cdec165619848426b9c9008da90b946da%7C686ea1d3bc2b4c6fa92cd99
> c5c301635%7C0%7C0%7C637981422690327443%7CUnknown%7CTWFpbGZsb3
> d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C3000%7C%7C%7C&amp;sdata=3DvSNYijBOH5mCmOzZW02R0sNzNNrtTWkD
> vF8%2FpwlTUqk%3D&amp;reserved=3D0
