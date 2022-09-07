Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12AA5B010E
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Sep 2022 11:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiIGJ6v (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Sep 2022 05:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiIGJ6Y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Sep 2022 05:58:24 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60081.outbound.protection.outlook.com [40.107.6.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A080B6D70;
        Wed,  7 Sep 2022 02:58:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIG8n4G1lEMP3u9oEkEdnFH6k6yrZi4490UiIb/qcA1ED1YrpPgGVZp8owBMDo6ohfH3xsocqFAm2YRL6IZ1Lx4FvVVunduc32B/5QQIEhxCZxJbmmXPGOr+jnGCOCP8OkNq4Ls5iV3Uc5MJ/dV3ekHVaYZrI734b5VTf8IBSdceuVhJesi44qumrlOtw9bZpE88Gyg7mW70bsq1gHNk0rcF3RH7DRv782FtiyXUffFaVHieJ2GHW6K+MerbznH4ebCq1O0ZXR/1sY3GZeK6Nk5KWJYwf4IV36ldcPFgEZl4ARQnXYcyz3OlfOAoLN/Ekw5kRia0FWdgPvdAdRINyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ri4NYhx0rH9x5CCuxB0ulkR9sDw4Pik2QP/FN88t3cE=;
 b=eagmt4J/EhEoCxqi3TL9ifOURoizdMl0tEbhfPOMipwRhCGUMnRMNxCf7PJBH+mLhHOMv72rN4kre2DUd16uPNFyWzNRMiOYM/7Mi6RCHIBYuE7xzBejwSnTbvBfOxKoRZLnDAGhfP/Y2P2qem/PNEmeos7awl+CW8ZFDckcq2D75U9eQp+TrLA2Uw3JvXzvUOBPCcGqXXY2ylLzxsyYW+1lY3zb3r/6OCBlCSlFptED62XKy9kDqzM2EBGcDtrIqwXBmNPivzDmMjDmbBMXVb+QvCXouKE3+OgSQTCow9P2NbdGz7LGC8CgAmNfb4zKXPKwWveN+As4zcv7KPx5ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ri4NYhx0rH9x5CCuxB0ulkR9sDw4Pik2QP/FN88t3cE=;
 b=lRpO7QPK6b2v6JRtiET4oi3UGhE6/eufjhMEm70TaT6e7TVFn2wbdg9tZV+QPCBRFLOVkWH8WaHOz9hUGPB95N/Lqn/VGwfLlw57Odu4RIoqzdZvexJTP4RraEzHgxKOFsJuvkJmg9cqiuQLR9qzUbxfVtZTPPguhN+obWAwZCg=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS8PR04MB7493.eurprd04.prod.outlook.com (2603:10a6:20b:293::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 7 Sep
 2022 09:57:55 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b%4]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 09:57:55 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     "jlu@pengutronix.de" <jlu@pengutronix.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
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
Thread-Index: AQHYwbSICZxhOSR7uk+zrvSafpZt0K3SGjKAgAFFWYCAAD+nAIAADdrw
Date:   Wed, 7 Sep 2022 09:57:55 +0000
Message-ID: <DU2PR04MB863055712C4D919D7892AAC795419@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20220906065157.10662-1-pankaj.gupta@nxp.com>
         <YxcLqepquOuOOjvq@kernel.org>
         <DU2PR04MB86303DE3507B6FF37BD5B6A595419@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <843e1f1cbed67ce558e20d1e56a82dfe27732028.camel@pengutronix.de>
In-Reply-To: <843e1f1cbed67ce558e20d1e56a82dfe27732028.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|AS8PR04MB7493:EE_
x-ms-office365-filtering-correlation-id: c942e59f-d3c9-42b6-2397-08da90b76fe6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pVPNm+33sYrqRGjoCHhYEjG8o2CKFBsH7gqoiCZY39b5HW5oc4wIB7z35D7NsatSI+ObXnPIne6DobC4YaQhL9yNUohpYRp56PG9WnkAqMIZTNNFa18Iko8vmMxfL4wdSCP6AybIa0UswRJ98KJZh/Hyr9EB+8/x6LtMPeAiBqQ68hDJjDbhKsR9xQAqT3LOhSHtppaEbOL8RD667Zq2Utfjcor3BfsFmllA+t4osOMi8VujGnCnBDHeYP/ytsOevI643zLRR2pYHGoyuQLL1tL7U2spYWNLweni0H2cKaZIjht0ZoEYZEQPSS6ncK36J2AvWjZQOMnXhtZfOKj9wOR8qbe2Z7tvuF9x6pBgol5EyrZWuD1IyIFCVw2HKRMkQ0+KY7IlNSc2LjlGGcmXzdZnAtZBT+DhLZsUpgCAtf6b60fblIqKHnpqO6FLqPckDQNejfdlOEvVYuISRVMOus3INWueRGH2h+H6x27WEYdhJ2t+P6h9p7ffI6PC3vctOtaE9vLJj7+jufXPAISIQnRyd0DfqVA2KuMN5460XFdlkvkGqIMnahHF1Gd2HfPfQE9lvDNj2BXhQLOXdifJTGZNqXAX19sGQipoQzHOAi9IEMC1tUC3V3Zc72NMjemkBejGWVMRYwUPE6CNCo2xY8YxPHhCevu2ed5B96vvdXO5dbTngw3wAaut7MDbcpOB7RyhzaNhgdsQBsxjRo62vFR8ersAMyS5eiQEqQlJhAGm6nwBoRpTuI0tMC4Kemb5DtGxccOhfL7Yc/krCx/kwq6k/KEksFvuFJFL9udE+eI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(44832011)(45080400002)(186003)(110136005)(71200400001)(55016003)(54906003)(316002)(38100700002)(478600001)(8936002)(966005)(7696005)(6506007)(64756008)(66476007)(122000001)(4326008)(66446008)(76116006)(52536014)(66556008)(8676002)(5660300002)(66946007)(66574015)(9686003)(53546011)(86362001)(33656002)(55236004)(7416002)(41300700001)(38070700005)(83380400001)(26005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fa0BPBRxYe6tTpiLBTL9lXBO+omGq5Z3SJFUTv5QpNRT3v7Ylm0f36pD4j?=
 =?iso-8859-1?Q?Rae9l7LlJP7gPY6MTl+OPXxmIP2nJAEiq7o3DmoxXil/Ugb1hGYzYWiyL5?=
 =?iso-8859-1?Q?+6ItR9q82iBE+2/KBjBo8W/EDLzFSnNB5CNYGqZnWm+VE50MzJTSIdY2GA?=
 =?iso-8859-1?Q?j1dfTKCNyYdGl/JJA4L04iRDDsBDzSV00Ex0UqoAF1sBzSdIvvXJFN0e5N?=
 =?iso-8859-1?Q?UojhezTz2wAqi8FWq9ROVOzmv8dvsf8mpctE0p6HNCmfy7ct5+TtBba4h9?=
 =?iso-8859-1?Q?HKzd/GNRyR22FpUsHt371uKCg+/C7WhXttHMfK23oa3p9x+h8bv2RGcQKG?=
 =?iso-8859-1?Q?4iSyPqLzdrRfWJedhX8IzXtvidPUsyNddvmdR0doIufUI7gPJs/oH48MBF?=
 =?iso-8859-1?Q?kplLIYZ0yV6Ytwu5u4EEido2YkiQPl0r4l0bSZZVL1pb9oRwOJkXsPbPbl?=
 =?iso-8859-1?Q?wZZB8sBqn1D3eBunIkI1O73Cj2mutu8bLc5PmHFnC4U33iv8adKWzE9mA8?=
 =?iso-8859-1?Q?maFqLU68+S/z5k9Eu9iQHdLY7tVl+VkI48HEkLJ52KxWOY27ZYVeB0Zm6N?=
 =?iso-8859-1?Q?nHOkaUZnsS42dIY+j4jMnY5Z3elC8GR1ZXjbUqCZUpFykLbDwMRBnRa48p?=
 =?iso-8859-1?Q?2jXp4gwrstqTYXFvbxeXejks1IyxVhp5Kqmuc2T8x5oozz1BdZgTV3i1zU?=
 =?iso-8859-1?Q?9PLTBx97dcZJPUnzO05YHCwo6MRLl6KPYveOsuCpZ8YakT7Lx5s8I4724o?=
 =?iso-8859-1?Q?FULceepRnI5u8APZ2AirE0humpwPLvaVUcng0sV9n7XzYR0aU83ZAOFXol?=
 =?iso-8859-1?Q?OFi1zC1q7YfvNd4eIZEGF2v4glCzhqhcdU7bI0rW67u7HY4NPKgI1nsUS5?=
 =?iso-8859-1?Q?Yum+2T6cacqd6MRvlVWxjddn9MERxv9XCKClOZqIjd1BzC1zSiB8BxjLTq?=
 =?iso-8859-1?Q?63rYnBxFTwi119WzJAPK4Bk9rWQ6P84nF/xWcTC0/Dc4xUMEnxZfJtT3GM?=
 =?iso-8859-1?Q?f8uiXQldDtuRS17UDEfWn/7JngSZmEV1bn+n4WSt/sYKQzn49Vt1Rcx7Df?=
 =?iso-8859-1?Q?BztaAdXDeUXl4L3bAIs0eK5+lfdRbjUTdET5XRhgmYFw/Hn7ffof8APOL8?=
 =?iso-8859-1?Q?27C7IgncX47rqotl12H4YDa5eBESRfZvdXf+bo8ASjkbzWMDViqV4CAXzv?=
 =?iso-8859-1?Q?4zvhdAmv8ijHLU1DeEUngxnCGupbg6avbhMzZUAbSJZDbCv/QGXIyqqPrA?=
 =?iso-8859-1?Q?V9J8iBUwLuTJ8Rfa2FyqZkF+PHw0XEW6SJ3L4FtLaha9KuoGyR+0fUl/XC?=
 =?iso-8859-1?Q?gtWMBkaRKhUv+J+P7ep1qXNUzYGTLxSy9sn3ZSkM8rOPQYmwpLFOBxXOrv?=
 =?iso-8859-1?Q?xSf07CEX9Df872J2JoDbAZk14/hEe1LTxpGb23JVRXvUqhzI4I1haS9AQJ?=
 =?iso-8859-1?Q?DTSXu7eQQioAHhE1WTCf7K89ZLpwgg/DU23PtUXKqPLtLmcOY7tM0i+vWY?=
 =?iso-8859-1?Q?PwRHS45DFXdkUgjWFXO5VnW8GYJdcIyXQyavcGODml2yZ+q/gZC/adOEnc?=
 =?iso-8859-1?Q?haTscUi7+7YoscxgEvdcveIgzXtYmomjW7OaZSmp7ix23js4otBSgV/tQ4?=
 =?iso-8859-1?Q?o+G3I1xgNiV9zUTA5+JP5Nfw63qSRn7x1q?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c942e59f-d3c9-42b6-2397-08da90b76fe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 09:57:55.6801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wu2X0vnZD8D3s1Z5duY4iKcUhWxyPN2xEPt0eXUzG0uv7NWOp99wvWVw4MBP/Qi8XfKHcIdKRr84KtgXWaB0rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7493
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
> From: Jan L=FCbbe <jlu@pengutronix.de>
> Sent: Wednesday, September 7, 2022 1:41 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>; Jarkko Sakkinen
> <jarkko@kernel.org>
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
> Subject: Re: [EXT] Re: [RFC PATCH HBK: 0/8] HW BOUND KEY as TRUSTED KEY
>=20
> Caution: EXT Email
>=20
> On Wed, 2022-09-07 at 07:22 +0000, Pankaj Gupta wrote:
> > Even if somehow the key is retrieved from the keyring, the retrieved
> > key would be an encrypted key.
> > This encrypted key can only be decrypted by Hardware, which generated i=
t.
> >
> > Hence, the retrieved key is unusable outside of the hardware.
>=20
> NXP's CAAM unit (i.e. on i.MX6) supports several modes of sealed/encrypte=
d
> keys.
> The (un)sealing process uses a key that is normally derived from a per-de=
vice
> key in eFUSES. One aspect of these modes is whether the plaintext key
> material is accessible to the kernel or not.
>=20
> Ahmad's patch set added support for a mode where the CAAM is used to
> seal plaintext known to the kernel to a "blob" (in CAAM terminology) on
> export to userspace and the reverse on import. This mode allows the kerne=
l
> to use the plaintext for dm-crypt, to encrypt other keyrings and similar.
>=20
> The CAAM has another sealing mode, where it will not allow writing of the
> plaintext key to memory. Instead, it is kept in one of the CAAM-internal =
key
> registers. There, it can be used for cryptographic operations (i.e. AES).=
 This
> way, the plaintext key is protected even from the kernel. The kernel coul=
d
> keep a copy of in sealed form, so it can reload the CAAM's key register w=
hen
> needed.
>=20
>=20
> Pankaj, is that the mode you intend to support with this series?
Yes, this is what is called as "black key", in CAAM terminology.
Black key is nothing but a HBK key.
This is what I am trying to achieve with this patch-set.

>=20
> Could you describe the high-level use-cases this would be need for,
> compared to the existing mode where plaintext keys are accessible to the
> kernel? In which cases would you use each mode?
>=20

High-level Use-case is to ensure runtime security.
By runtime security, I mean, key that is added to keyring after blob-decaps=
ulation,=20
- if get  stolen, then being plain key, security can be compromised.
- After this patch-set, if key get stolen, then being HBK(encrypted by H/W)=
, will not be of any use without HW. Security is not   compromised.

> Regards,
> Jan
> --
> Pengutronix e.K.                           |                             =
|
> Industrial Linux Solutions                 |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=3D05%7C01%7Cpankaj.gupta%40nxp.com%7Cb
> 1335df185404e02df1108da90a8886c%7C686ea1d3bc2b4c6fa92cd99c5c301635
> %7C0%7C0%7C637981350763081319%7CUnknown%7CTWFpbGZsb3d8eyJWIj
> oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3
> 000%7C%7C%7C&amp;sdata=3DaNxEETFYLc74F%2BOq9IK3p63tniVfczpgslG3LYe
> ZzAo%3D&amp;reserved=3D0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|

