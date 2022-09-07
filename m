Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2675AFD55
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Sep 2022 09:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiIGHWz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Sep 2022 03:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiIGHWv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Sep 2022 03:22:51 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00062.outbound.protection.outlook.com [40.107.0.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41E09D8EA;
        Wed,  7 Sep 2022 00:22:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMjppwC2kPolgmOBcJtXAbzzWVLmdnK7VcN8WXpbYDm4P/fv93dK83coXDp/8hz41qp6Mc4AmcDTj7lactYUnU9J4R+5wLHzztaOtkfB/Eab7BcnK9fzSekj34cu5g3r2GxWUNnol7nS7wVkW+5l4TCHYO3umAFZPXUKRTTY1FYiumTNXoc9oGHsSQDNQsz00mTG2bGmDWHd+5vGusbqbWIfcu3WlXbxZAlHIaiZ0iTq3ULfqtYxf609jIZ1X9JtdJDLwhkySzktE1rGSxvYA6jlxRT1WocAR0loQ1VY35qp3vfMswFw/BAmf67keNWRA3ZNOwTOpypFXslbYL+iqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoPWBIW5JINuGdKf+/g0Htv1XyubvSoJxX4mGh7ecmA=;
 b=CKSOpeaakUlGJ5SIhQFU/UwMF1IUMTWKL9VUi/OUJfZYDulmE/R5JKVOYMfYIOG6tGKNYijxA0dhsq83yYS/0mmumRfjj8yzpq5k3sbTsK6bBRj8CW9zamO769kxQCVGQEf7rnDx/vrPoxU7Ot5+KIWT6e8s3PlChCawIWG5ZqU0vpO4mxNBrXUg9cLbZWx3jNCFMnO2pP4Zp5PaG5Hj/tLf74/nL6/0LQeaTZm7Cb/OrQ65ZpQDXfnI/beQoQDYbXK/hbgg//XgzEAoRWRMFD9BRaixa1i0AfCLIvMouoQB7ADrHEpPO9sjf2eZTxeyFRalWpBdCSu6o4XgPk+/0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoPWBIW5JINuGdKf+/g0Htv1XyubvSoJxX4mGh7ecmA=;
 b=JzQ9qOuU1Qm8CpURC4ck/4z9N/nBtlKF34ST+zzg9fjEIgah64533x/GIuZglEKCLFkruYmuCzdC7QA7V2TizuQfvZYoydIsGjAea4t6iFNWJ8W2BLpu6KcfrU3seh68vF00+SncoakGY8S5YagCDH5NbRibonCAQtzNF86dkdE=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AM0PR04MB4004.eurprd04.prod.outlook.com (2603:10a6:208:57::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 7 Sep
 2022 07:22:45 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b%4]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 07:22:45 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Michael Walle <michael@walle.cc>
CC:     "jarkko@kernel.org" <jarkko@kernel.org>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "Jason@zx2c4.com" <Jason@zx2c4.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "david@sigma-star.at" <david@sigma-star.at>,
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
Thread-Index: AQHYwbSICZxhOSR7uk+zrvSafpZt0K3R/KiAgAFrQaA=
Date:   Wed, 7 Sep 2022 07:22:45 +0000
Message-ID: <DU2PR04MB8630C63609D6D785F12DEC6E95419@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20220906065157.10662-1-pankaj.gupta@nxp.com>
 <047746e1134d5bdce699d8c021f849b6@walle.cc>
In-Reply-To: <047746e1134d5bdce699d8c021f849b6@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|AM0PR04MB4004:EE_
x-ms-office365-filtering-correlation-id: 6cbc5f80-4018-432f-eb47-08da90a1c274
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1juvt09HvNHcmS515SV4g9xTcTs6IsdoOLo9xhT+aeC4+7d/Lxahm+2SOYynU+nmOuTgAj3AzDMaUPcI0KOZCoqaJDRxapWJ3EoTCstkEMb//I8JKVLNEuBgfMsNnh7JA0ch1cSg8b0eCmXsLTsOhbc5lXX1LT40hXTQWR+x9Wb6JF1gipNuuCW2CpTy12cE98CShEMfemQlb5TuqETeh9kIn81aOW6Lgyz7D8+7Y/b78a5AK4FkKrtpyBNJ3/uB80hiBUpeLmbRYpkeERaKu1AyKo+6XCon6thuMaW//3a8WfWJWLtJLibwyfX50+9vSAB1i1kfoyYqdO/2cURvjScicWzah8ovhQhHiHgouJ8WkJBe3ewz4LllCqXvmJmC9QFcOHxTgrMfZ5xBr0c7T+THnVzCyWs8zMVZf6okNkDZR4Uq7Y4Y7WZMGQcYQHB1EjE5R2meARBnSAR7S5gXcD9Zb3fTtvLwRAFFPRx1QRQ4DA/iM/BkrvKYdAlzCQMFrcJxErBBBOyWreBhqytp6hFicV9P6diS6urpjNzASCHQ7WGdaiXjhDmIJs0Jj1JmwBYWSLNZy9ChhO38Q6/GG/3uJm/HXPG/tVF36DtaH2tFo2UtqKlwVRA/TIeB1+Bh0doerjT3b4nprPoLKa/1KAlAtHxZHUwQn0u0jBqL8NO1ndXMCfHtdjyW+ZYWri4/VKzGTiTF+l2/k3axz9q0eghnsQuioKU0hZLfYA+11VCx78hkiNlmBawA2IedkQJypTUHlaGO7ErSYLIKEHYJLq4+hvfmpcqq09HRI5XfPJw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(26005)(7696005)(478600001)(8676002)(9686003)(6506007)(66556008)(66446008)(66946007)(55016003)(64756008)(66476007)(2906002)(86362001)(316002)(38070700005)(33656002)(4326008)(54906003)(6916009)(71200400001)(41300700001)(53546011)(55236004)(38100700002)(122000001)(76116006)(186003)(5660300002)(44832011)(7416002)(52536014)(8936002)(83380400001)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SQ2dVF7LrlUSSS7pGU6p8m/eI5eg1fkV8hV04Sv31WPwalYhiE2ICOCb2Aj+?=
 =?us-ascii?Q?8aR/oTU4c+hQUSlQ2axR82lQmrsJdlFtUicVRPp0QtN8zr45EtPsL8XwSLfT?=
 =?us-ascii?Q?nyb/WRijwgjFS1ShXREDVDL63SIo1CMst8wHSnGk49w6fI7nBQKx0R+vou14?=
 =?us-ascii?Q?zH7OhNQkFapRj75e1AcCjAP2I3iXYnPtgu3dFTlexpDypCKWCNOL1eGuJWFO?=
 =?us-ascii?Q?zDalOVQvsSNWan5M/UOXxtkRJBuSStrpu0gWLU+iqTCV6r2ovQ5JsERRht8w?=
 =?us-ascii?Q?NUjce55BfkrMDwsJq/Qnff6jVMk6QykbxUqWoNQ/aZ4nB+aQk/MvCW9E+Chx?=
 =?us-ascii?Q?pViTTgpYgVH9zH2V3edZ1hyBhx+eczaWcDrX6AhZE8mlMCaT5Zv3jjXvEAe9?=
 =?us-ascii?Q?TiYs0VqnXgL11SXkFdo2XuntdU5UAvjdEpFHfuvQcVfhecjV3IQ24hdnuFHY?=
 =?us-ascii?Q?r6Tah/f83KJvSvEw0YSmz0u91zVH6eMsMsMhi7BWCNIMbdflIP73MkMrDWdb?=
 =?us-ascii?Q?3HsuMxm12Feg+cmYwSuy9brKHwKlRzFNdVFlmFL4HbqWWyfLWjdqoA5MxnmE?=
 =?us-ascii?Q?yBH0rXb6Xbsf7YY41vqjAXahYXxwzJVE6vIdOyxhM5MxpoP8EwhPvXM7FSIs?=
 =?us-ascii?Q?hyys3S2/cKk7dNHkXWFt6opKCvtf8jgRoLNsfX9nGcDCTQFPEOHpj11d+T14?=
 =?us-ascii?Q?95r83KLkPXExfFMf8bVhdHOJpAVWY/7vznWKRF7prpjiDYb36vzhPdWJqwo2?=
 =?us-ascii?Q?/TgSfYPAQRrHUVcaVLO/lmyApr/+dah5Qcg3zwEgfm5RZiaXijakEp11F16E?=
 =?us-ascii?Q?bxHtoRKZBhlipCCLRGBCvU7ccuL7tKXZP67JnB1FPtJ/1AnT/svxr/4yB2Np?=
 =?us-ascii?Q?KXpoD5kD0Jb9wSYS7fFPEly4kKyBJ471UMrnqcIgIZuerr8wzOpCDzJLJdAa?=
 =?us-ascii?Q?0IPv+DQpCcmrzz97gJKPaKDTIqGpRgddZvC8ocpFIbZZvz0oLH8R04qM31oc?=
 =?us-ascii?Q?X6Ty9vv+qMAhid1v7NJFBVlEwWveK3HXDrb3pioVv84PKoGn9rlrV9+oAtVr?=
 =?us-ascii?Q?SgO97o1VNAjz8k3g5+ArgjDtyu4QHYOjO2pFS4mLVy9ISsUk4W4qpVeQ+SBa?=
 =?us-ascii?Q?4kmciece3Q1YHiXsV+hiYkYVNQ8sg3PDvyDB14FPSQJQs5ehv4WqNGXtqu7s?=
 =?us-ascii?Q?3WUBIPzsPLU9TOMAUKGvVTb+NFXrfZDYFBUyKL9oExCOBiYHQvrvamoB5CyL?=
 =?us-ascii?Q?ozb4CFWorNvgmdDlBtHJDG3PRi/t1/I7L5/bVeYI59sEP5VNKTbaQjipX8I1?=
 =?us-ascii?Q?chE+6ok1tdVfDMrniGYKSZ7v0sAWPA8UHnU2kxwgD6+CBlr6swcOtn4JZdbP?=
 =?us-ascii?Q?fAMuuht70AlHKYtblvP273TCt1a6VJDHsWenliPvXEOGHvsDhBS64UU4oWiH?=
 =?us-ascii?Q?PugG3hYKbkQrbbGXoKNLtEx1WQXZf/wiqEbAAe9gDORTOnukEjImyE0aFJ0t?=
 =?us-ascii?Q?9gQIXc5aKUwl8xClQdI/b6woCXaWLIZlDh71cG5PChoruiLOyfkYbEuQBxzR?=
 =?us-ascii?Q?9mOaGwDpwiqqIIVwZqcyHR0eD8ObdXjKrkS0mk3y?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbc5f80-4018-432f-eb47-08da90a1c274
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 07:22:45.2454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lmISo6ei1cjbQynwu0JQuNYT2hw4oqSWIW72A/C9zOmiSvHTxM3fuobLaOiI+uZe9Tk3wsaAz0wr1T82OO0yqg==
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
> From: Michael Walle <michael@walle.cc>
> Sent: Tuesday, September 6, 2022 12:43 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: jarkko@kernel.org; a.fatoum@pengutronix.de; Jason@zx2c4.com;
> jejb@linux.ibm.com; zohar@linux.ibm.com; dhowells@redhat.com;
> sumit.garg@linaro.org; david@sigma-star.at; john.ernberg@actia.se;
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
> Hi,
>=20
> Am 2022-09-06 08:51, schrieb Pankaj Gupta:
> > Hardware Bound key(HBK), is never acessible as plain key outside of
> > the hardware boundary. Thus, it is un-usable, even if somehow fetched
> > from kernel memory. It ensures run-time security.
> >
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
> >
> > NXP built CAAM IP is the Cryptographic Acceleration and Assurance
> > Module.
> > This is contain by the i.MX and QorIQ SoCs by NXP.
> >
> > CAAM is a suitable backend (source) for kernel trusted keys.
> > This backend source can be used for run-time security as well by
> > generating the hardware bound key.
> >
> > Along with plain key, the CAAM generates black key. A black key is an
> > encrypted key, which can only be decrypted inside CAAM. Hence, CAAM's
> > black key can only be used by CAAM. Thus it is declared as a hardware
> > bound key.
>=20
> What is the difference to the current trusted keys with CAAM?
> When I tested the patch series back then, I wasn't able to import a seale=
d
> key on another board with the same SoC.
>=20

Currently, keys that are part of trusted key-ring, contains plain key.

With this patch-set, these key will become Hw Bound Key, which is not a pla=
in key anymore.
After this patch-set, if somehow the HB-key is retrieved from the keyring, =
the retrieved key  would be un-usable without hw.
=20

> -michael
