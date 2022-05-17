Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EF2529EBC
	for <lists+linux-integrity@lfdr.de>; Tue, 17 May 2022 12:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343501AbiEQKED (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 May 2022 06:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244799AbiEQKDv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 May 2022 06:03:51 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50085.outbound.protection.outlook.com [40.107.5.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF1242A15;
        Tue, 17 May 2022 03:03:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddIgwLGQeYak+xeeBAaUl8q4oB9/cw7rgji/JHxo/7MLr21XNsQVeJYFS8PGGMj/MXZiKuhNQ31ZNkewWuhG47TLsiYWRzMHZsNUa6JhX/cWFYOhkHxbjlRT0/ijqrH6rU47qPeNMneyD0QSY69GOrKzxXglmgkWqv3f+CnwWuGL/YmOOM7LXokBrWWVkntZC95QtfmxfBJFWrc3wIjV8mF9Yx93aWEo1FPoX5bYVdFLhuNotJr2FWvvmgUt5c7UfYMGUNfDoSrIqybWLfvmpt0YdVqd4q0N5pYR/GgvFxh8BkvP4bDcV1C9M1QPv5PdNcisJ/Ks/2KigUAigWXmZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8X7iz0Int+l79OjDo3XLgjvDYs57Gf+n0dYlBFeGvI=;
 b=JVhtIdQnAiFaLY317unWj/KtwnVj+uHzaMDFK+IOIgWuQ5C7Cgw+ee9wF2ykIUJJF+lPgM1dpQHY7QOOgzNVLca7XFy/3YGocY1Qw2FrI2vCkDhcpVDTzGnUgVewPTcoeLKlxMo5/ZxNhAE87O4gfVTKBKl4nXl9xiEw0CvIiBltw2PSNPR7HwW3mcwGoaMcQRS/grsHyjCT65cGlMLM3x6tCZDH/sVD/cL4dI7YPkMgz7BSNr9CgslrMPd4G9MLiyh1Ii1wDSCM9SonNQiHHnwXgtYGOeHlB77yDKnQgIeU/eI1ennCuP4R2lB4qSQUs2aDcc8tZuutTPb3liKoXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8X7iz0Int+l79OjDo3XLgjvDYs57Gf+n0dYlBFeGvI=;
 b=iaobBCJHMb38tq0bXZcKymWNNcw2VQR4LSgBEOIaGWnHqusiyDiJoiEs/L3AJqnfbI9paiKf3WlIRil6itxlNgzW6cHccds2HPgz6A5uUbf3Sywy72cx0BBwwxI6VGe0KyuaWI4T5YecXROEeiMDIDOK8715OxgWaojrL0YcqdI=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by DB7PR04MB4443.eurprd04.prod.outlook.com (2603:10a6:5:32::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 10:03:06 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::b454:80f3:ce2c:6fbc]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::b454:80f3:ce2c:6fbc%4]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 10:03:06 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Horia Geanta <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Michael Walle <michael@walle.cc>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        John Ernberg <john.ernberg@actia.se>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: RE: [EXT] [PATCH v10 3/7] crypto: caam - determine whether CAAM
 supports blob encap/decap
Thread-Topic: [EXT] [PATCH v10 3/7] crypto: caam - determine whether CAAM
 supports blob encap/decap
Thread-Index: AQHYZtnRnA+6r7qzG0+Ly5ZTvKwGF60i3HNA
Date:   Tue, 17 May 2022 10:03:05 +0000
Message-ID: <DU2PR04MB8630990CD39B409051F490FF95CE9@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20220513145705.2080323-1-a.fatoum@pengutronix.de>
 <20220513145705.2080323-4-a.fatoum@pengutronix.de>
In-Reply-To: <20220513145705.2080323-4-a.fatoum@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d1adc0e-d358-4d48-86c2-08da37ec7025
x-ms-traffictypediagnostic: DB7PR04MB4443:EE_
x-microsoft-antispam-prvs: <DB7PR04MB4443453A780465104AF5D6E795CE9@DB7PR04MB4443.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9GeiaRYUyZnSKLGoC36YfWy/lrQFW6ojuGaHOLKL45ts/jeb72bwKv6K9XVLZBDf9os79mhpqCt9mvpN977w6VKqyz5SqeJC7gh+Mo/Ei/MQcITqDWryP8JI4RRzhF4UTEsSRFrH3nKwfiq8H4nnRSUBP6lWAZrdNY7sQh1Ls7b1Pf3ittrXiM9o/zgJKUtLrLTo4RjNxWvaM5yjpU013OuVReAHYfdTGA53DH78xuTNqkkcKx1qd8n66xu91j48LJ5KLs6TmHMY41MoVjlKr5p6/GYiqCH3QrORznmxU36DPOTIgm8pT9qhYJA72/gpSwX6gJPozzAQUOhj6uvbbuOe+onDuNFxSdb9bAGA6ig0YQnWHWrXJOxp815LH5k3NX0zNz977t6nqCvEU68SB2jKJJT9FoaXhtDOfShP0DAgS5Arky0G0IdwH5MkqTXS2qWGH4Tl1QO2gaq1WL1UAYbGOq0WmS/r7LoyUNUPSN/Hry+Svbe4lbqhOkPaZW7mENcRhOst+fGccgadI/4cHqprFUl/V2DBckzdzkyHZOGNQ2u3ItOP25/mGjC8Wzts+GvOx9Y9Ad4E4nQqizVz46G47lgiSavpEFoCf2/tzVRYd6Wo8uI11Bc5NKxEFn9U7u2uFKxolhaBv9eBLhKS9ZPC2oZ3a5l6FsdYhvA/4AkiPQpOrwXheGYAWPQfKRyKmRyBDyizcDzyiRHRoYzeeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(55236004)(53546011)(122000001)(64756008)(55016003)(76116006)(66946007)(83380400001)(66446008)(66476007)(71200400001)(7696005)(2906002)(8936002)(33656002)(38100700002)(38070700005)(7416002)(5660300002)(8676002)(54906003)(110136005)(66556008)(316002)(4326008)(44832011)(9686003)(186003)(52536014)(26005)(86362001)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDluNE9mK0dtMFRUWkpLTUVjZUNoQXVoYWpvOHF0MHlOeEFXVkdQUENCeFJw?=
 =?utf-8?B?YkRjcmlIWG9wemFQa0FOTDZiajVNV1VXamlIaEE5eW12VllKNG5TdWdhTmVY?=
 =?utf-8?B?K3VOZmhxQ010Qnl1NUoxd1hZSHhaSW9NRDZuL3BoTUQ3SGhqZXdMc2NTKzY5?=
 =?utf-8?B?UVRXTGx1VlN0WXhIVG9QTVpNR2N3SDVtUSt4aXFmcHdWdnZGZFJzR08xSmov?=
 =?utf-8?B?bitSemdpNUlaOUV4SHRJUUtrMVFPV0dzU2l2TzRtbytYVlRtNUdVcXRMTWdC?=
 =?utf-8?B?YXdQQ1RMbTNPYzc0Uk5ERDM2WlBGbkgwSXA3M1lvVHoyOFNGSXFYVVJwaTlN?=
 =?utf-8?B?Yld4dlBOUk5raHBXNlJxek04R2pqUURzWG9DT1RZcEh0Z1JwdDdkbFoxNDky?=
 =?utf-8?B?WHU1VUp2d1phZnRJcTF3TG95ZEpSZjZBMnB0SDZDQ043d2g1NzR2WEtveUNO?=
 =?utf-8?B?YVB5b1Jld3JVVzFod2RaZGZNNkk2S3c4ZWlmSVJ0MWw1eVlWUE4yZzdTZWx6?=
 =?utf-8?B?ZTVEUmtUZFJMclh6d2F1RlhJR1lZMUMrNklHUTIxSW5IZHRVV2NVbHpWcVhF?=
 =?utf-8?B?T2FOOE9IWVhheTF1Vkx3YThuRkRFcGsrQzJtTG9URkpHbmJnem5OR0tFMi84?=
 =?utf-8?B?VVNFd2RBSk43ZXR0YzN5aCtQT3g3WmZKamNCWE1ZMTNDRitYTDhlZzA2SGpw?=
 =?utf-8?B?bmZsT0kzSFEvMnZQRjFCMVovRUJyNlMrYXp0OWI3dmNabXRKalJUUnRhTG54?=
 =?utf-8?B?Y1BwTVplUTVLSHZ2elBMdEo3ZGJHMlhFTW1NdENGbGU4TTNoZ2NGbjYyazZX?=
 =?utf-8?B?RG1qZFRYV1NkaHdSODNtVG92OTJvQ3M3K3lmS0F5QzJVaVh4emJqQUduYUtD?=
 =?utf-8?B?MktzNlB6a3EzRUZSNEFKYWhVR21aV3RJRWdOb1FFN0h1eTl6Rkxic2d6Vkpr?=
 =?utf-8?B?UGZKOGdEUDkwcEZHbnRqVXFmK0t4dHRsekt2enEyRzFTa1E3UHJmM1FmS0FE?=
 =?utf-8?B?Ky9CcFJ6b25xdGpIMHA3aldTLys4bDRzOFNCNjhDdGNJS3lpRlFydllKZzRt?=
 =?utf-8?B?dGZMd01naUx0NzZRWVluUE5NajVveS93MUNZZndCNXN0L3BwckFUMVZzcFpT?=
 =?utf-8?B?WE5BMjEzaThzOGZhTkx2VDRlM0ZXMjZJamlFVXp5d0JLc2NJbk1sUGt1Rzds?=
 =?utf-8?B?cHljYnRHdkdIeldWS1J0YlFDTWtLdTZVV3FZdEliOW9UNE55MGdMUUcwU2VW?=
 =?utf-8?B?WFc2cVl2LzVCanZTQ09pRVprMDFQQnphUWJIMFZDcmVEemtQRFNjNmRRN3Ix?=
 =?utf-8?B?QVJBZGRKZEJsUEhmam9EbVNwcHo5YzI4dVhJTGk2YTQ1SlZlZEZJUVFkN0I1?=
 =?utf-8?B?QlBLNlErOC9vSFR5Wmh3dzBnZE5MbE9FbVhobTMvOXRwSk5tZ0lkU21TT2J5?=
 =?utf-8?B?UlVlYjhBZDZpVm9UTFBENXBNM0NHTEhHMlk4WFBxSWxUSUpZVU5qVnFlNUdG?=
 =?utf-8?B?U3BKNm4xMHpkWnpFN3lPRTdSWkUrNTBsYU9FcEFxMjJzY0ZZRUhUR0VwSGcv?=
 =?utf-8?B?Z3dBK2lkNVhWcVpMN1pzdFIxL2Z1RG83MTllNndmTThOVHN2cy9qYU90cGoy?=
 =?utf-8?B?NjdLZU44dUVzZEFyWk9GczV0YWlUYUcyajhnUkZNQVdIT1d2VHFYVjV5Nkx1?=
 =?utf-8?B?RlZkNVlLS1dGS0M4ci9uSCtuSHp6QXpVWGhhNzNubS9xWGQyeFQ1M1R0ckR1?=
 =?utf-8?B?bDVyU0xma0swakU3YVVOcldDZ2kvTXJqWUJXU1JweWoxL0RrcHFrUFlta1J0?=
 =?utf-8?B?cUg0OWh6eG82WDhpcTdIVDFodDE3ZWNyMnpuOE1YYWdYRWpTWWVsU2FNUllj?=
 =?utf-8?B?aVlzL1Y2WnRMQTVZbHFPNTQ2cFZqQ0ZLZnFuUlZtSDR2bGN0RVphNWNXemJ1?=
 =?utf-8?B?QXgydXhBTkdhMFRvVEY0UFEvcU5ZU3FzWUV5REJXdmIrTDlQdUdWTmNNbUZI?=
 =?utf-8?B?REV4dENTZzA4WGF3eE9iY2lIc24weHNtNjF1Z2dXdDVWRUlIeEZFYzBCM2NB?=
 =?utf-8?B?bG1CTGJFeldCTktCa0FZd0tEdUdpS2lnbXBFRTF3QWszdDZoY0NJeFc2TkxC?=
 =?utf-8?B?dDR3MFdJVlE1SUVjSmxUUU1ZejRrV1FqaWJicVp4Vmg0RllKSHZLbUkzRzBT?=
 =?utf-8?B?ZWRwVU1xaTkySnQ3UGdNdVN6QWYvZ3BDZC9iSC9IeHJ2RDZvN0ZWa0JURHdE?=
 =?utf-8?B?ZTBNZHFpamR2OEpKbE9PajFYd3FhYnBMNDZyNm9CanZFSXF1Umd6Y2FVdG95?=
 =?utf-8?B?UW9jU3BaRWRkV2RMNk1rc1JnRTlLREhTbExESUxISmNpYVV4MTNJUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1adc0e-d358-4d48-86c2-08da37ec7025
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 10:03:05.9038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RxlKwbD1Jr2jlAaPlVUgdXSuErUXcACmCMZ3DG2wYqkJ9IafOR1N0sytNSI1qN9ky25l613fFFhJlrPo0+nMpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4443
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

UmV2aWV3ZWQtYnk6IFBhbmthaiBHdXB0YSA8cGFua2FqLmd1cHRhQG54cC5jb20+DQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWhtYWQgRmF0b3VtIDxhLmZhdG91bUBw
ZW5ndXRyb25peC5kZT4NCj4gU2VudDogRnJpZGF5LCBNYXkgMTMsIDIwMjIgODoyNyBQTQ0KPiBU
bzogSG9yaWEgR2VhbnRhIDxob3JpYS5nZWFudGFAbnhwLmNvbT47IFBhbmthaiBHdXB0YQ0KPiA8
cGFua2FqLmd1cHRhQG54cC5jb20+OyBIZXJiZXJ0IFh1IDxoZXJiZXJ0QGdvbmRvci5hcGFuYS5v
cmcuYXU+Ow0KPiBEYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+DQo+IENjOiBr
ZXJuZWxAcGVuZ3V0cm9uaXguZGU7IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+OyBB
aG1hZA0KPiBGYXRvdW0gPGEuZmF0b3VtQHBlbmd1dHJvbml4LmRlPjsgSmFtZXMgQm90dG9tbGV5
DQo+IDxqZWpiQGxpbnV4LmlibS5jb20+OyBKYXJra28gU2Fra2luZW4gPGphcmtrb0BrZXJuZWwu
b3JnPjsgTWltaSBab2hhcg0KPiA8em9oYXJAbGludXguaWJtLmNvbT47IERhdmlkIEhvd2VsbHMg
PGRob3dlbGxzQHJlZGhhdC5jb20+OyBKYW1lcw0KPiBNb3JyaXMgPGptb3JyaXNAbmFtZWkub3Jn
PjsgRXJpYyBCaWdnZXJzIDxlYmlnZ2Vyc0BrZXJuZWwub3JnPjsgU2VyZ2UgRS4NCj4gSGFsbHlu
IDxzZXJnZUBoYWxseW4uY29tPjsgSmFuIEx1ZWJiZSA8ai5sdWViYmVAcGVuZ3V0cm9uaXguZGU+
OyBEYXZpZA0KPiBHc3RpciA8ZGF2aWRAc2lnbWEtc3Rhci5hdD47IFJpY2hhcmQgV2VpbmJlcmdl
ciA8cmljaGFyZEBub2QuYXQ+OyBGcmFuY2sNCj4gTGVub3JtYW5kIDxmcmFuY2subGVub3JtYW5k
QG54cC5jb20+OyBNYXR0aGlhcyBTY2hpZmZlcg0KPiA8bWF0dGhpYXMuc2NoaWZmZXJAZXcudHEt
Z3JvdXAuY29tPjsgU3VtaXQgR2FyZyA8c3VtaXQuZ2FyZ0BsaW5hcm8ub3JnPjsNCj4gSm9obiBF
cm5iZXJnIDxqb2huLmVybmJlcmdAYWN0aWEuc2U+OyBsaW51eC1pbnRlZ3JpdHlAdmdlci5rZXJu
ZWwub3JnOw0KPiBrZXlyaW5nc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWNyeXB0b0B2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1zZWN1cml0
eS1tb2R1bGVAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRdIFtQQVRDSCB2MTAgMy83
XSBjcnlwdG86IGNhYW0gLSBkZXRlcm1pbmUgd2hldGhlciBDQUFNDQo+IHN1cHBvcnRzIGJsb2Ig
ZW5jYXAvZGVjYXANCj4gDQo+IENhdXRpb246IEVYVCBFbWFpbA0KPiANCj4gRGVwZW5kaW5nIG9u
IFNvQyB2YXJpYW50LCBhIENBQU0gbWF5IGJlIGF2YWlsYWJsZSwgYnV0IHdpdGggc29tZSBmdXR1
cmVzDQo+IGZ1c2VkIG91dC4gVGhlIExTMTAyOEEgKG5vbi1FKSBTb0MgaXMgb25lIHN1Y2ggU29D
IGFuZCB3aGlsZSBpdCBpbmRpY2F0ZXMNCj4gQkxPQiBzdXBwb3J0LCBCTE9CIG9wZXJhdGlvbnMg
d2lsbCB1bHRpbWF0ZWx5IGZhaWwsIGJlY2F1c2UgdGhlcmUgaXMgbm8gQUVTDQo+IHN1cHBvcnQu
IEFkZCBhIG5ldyBibG9iX3ByZXNlbnQgbWVtYmVyIHRvIHJlZmxlY3Qgd2hldGhlciBib3RoIEJM
T0INCj4gc3VwcG9ydCBhbmQgdGhlIEFFUyBzdXBwb3J0IGl0IGRlcGVuZHMgb24gaXMgYXZhaWxh
YmxlLg0KPiANCj4gVGhlc2Ugd2lsbCBiZSB1c2VkIGluIGEgZm9sbG93LXVwIGNvbW1pdCB0byBh
bGxvdyBibG9iIGRyaXZlciBpbml0aWFsaXphdGlvbiB0bw0KPiBlcnJvciBvdXQgb24gU29DcyB3
aXRob3V0IHRoZSBuZWNlc3NhcnkgaGFyZHdhcmUgc3VwcG9ydCBpbnN0ZWFkIG9mIGZhaWxpbmcN
Cj4gYXQgcnVudGltZSB3aXRoIGEgY3J5cHRpYw0KPiANCj4gICBjYWFtX2pyIDgwMjAwMDAuanI6
IDIwMDAwYjBmOiBDQ0I6IGRlc2MgaWR4IDExOiA6IEludmFsaWQgQ0hBIHNlbGVjdGVkLg0KPiAN
Cj4gQ28tZGV2ZWxvcGVkLWJ5OiBNaWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdhbGxlLmNjPg0KPiBT
aWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdhbGxlLmNjPg0KPiBUZXN0ZWQt
Ynk6IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+ICMgb24gbHMxMDI4YSAobm9uLUUg
YW5kIEUpDQo+IFNpZ25lZC1vZmYtYnk6IEFobWFkIEZhdG91bSA8YS5mYXRvdW1AcGVuZ3V0cm9u
aXguZGU+DQo+IC0tLQ0KPiB2OSAtPiB2MTA6DQo+ICAgLSBhZGRlZCBNaWNoYWVsJ3MgVGVzdGVk
LWJ5DQo+ICAgLSBDaGVjayBmb3IgQUVTIHN1cHBvcnQgb24gQ0FBTSBlcmEgPCAxMCwgYXMgTFMx
MDQ2QS9MU0ExMDEyQSBoYXZlDQo+ICAgICBzdWNoIENBQU1zLCB3aGljaCBjYW4gYmUgcGFydGlh
bGx5IGRpc2FibGVkLg0KPiB2OCAtPiB2OToNCj4gICAtIE5ldyBwYXRjaA0KPiANCj4gVG86ICJI
b3JpYSBHZWFudMSDIiA8aG9yaWEuZ2VhbnRhQG54cC5jb20+DQo+IFRvOiBQYW5rYWogR3VwdGEg
PHBhbmthai5ndXB0YUBueHAuY29tPg0KPiBUbzogSGVyYmVydCBYdSA8aGVyYmVydEBnb25kb3Iu
YXBhbmEub3JnLmF1Pg0KPiBUbzogIkRhdmlkIFMuIE1pbGxlciIgPGRhdmVtQGRhdmVtbG9mdC5u
ZXQ+DQo+IENjOiBKYW1lcyBCb3R0b21sZXkgPGplamJAbGludXguaWJtLmNvbT4NCj4gQ2M6IEph
cmtrbyBTYWtraW5lbiA8amFya2tvQGtlcm5lbC5vcmc+DQo+IENjOiBNaW1pIFpvaGFyIDx6b2hh
ckBsaW51eC5pYm0uY29tPg0KPiBDYzogRGF2aWQgSG93ZWxscyA8ZGhvd2VsbHNAcmVkaGF0LmNv
bT4NCj4gQ2M6IEphbWVzIE1vcnJpcyA8am1vcnJpc0BuYW1laS5vcmc+DQo+IENjOiBFcmljIEJp
Z2dlcnMgPGViaWdnZXJzQGtlcm5lbC5vcmc+DQo+IENjOiAiU2VyZ2UgRS4gSGFsbHluIiA8c2Vy
Z2VAaGFsbHluLmNvbT4NCj4gQ2M6IEphbiBMdWViYmUgPGoubHVlYmJlQHBlbmd1dHJvbml4LmRl
Pg0KPiBDYzogRGF2aWQgR3N0aXIgPGRhdmlkQHNpZ21hLXN0YXIuYXQ+DQo+IENjOiBSaWNoYXJk
IFdlaW5iZXJnZXIgPHJpY2hhcmRAbm9kLmF0Pg0KPiBDYzogRnJhbmNrIExFTk9STUFORCA8ZnJh
bmNrLmxlbm9ybWFuZEBueHAuY29tPg0KPiBDYzogTWF0dGhpYXMgU2NoaWZmZXIgPG1hdHRoaWFz
LnNjaGlmZmVyQGV3LnRxLWdyb3VwLmNvbT4NCj4gQ2M6IFN1bWl0IEdhcmcgPHN1bWl0LmdhcmdA
bGluYXJvLm9yZz4NCj4gQ2M6IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+DQo+IENj
OiBKb2huIEVybmJlcmcgPGpvaG4uZXJuYmVyZ0BhY3RpYS5zZT4NCj4gQ2M6IGxpbnV4LWludGVn
cml0eUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGtleXJpbmdzQHZnZXIua2VybmVsLm9yZw0KPiBD
YzogbGludXgtY3J5cHRvQHZnZXIua2VybmVsLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPiBDYzogbGludXgtc2VjdXJpdHktbW9kdWxlQHZnZXIua2VybmVsLm9yZw0K
PiAtLS0NCj4gIGRyaXZlcnMvY3J5cHRvL2NhYW0vY3RybC5jICAgfCAxNyArKysrKysrKysrKysr
KystLQ0KPiAgZHJpdmVycy9jcnlwdG8vY2FhbS9pbnRlcm4uaCB8ICAxICsNCj4gIGRyaXZlcnMv
Y3J5cHRvL2NhYW0vcmVncy5oICAgfCAgNCArKystDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDE5IGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9j
cnlwdG8vY2FhbS9jdHJsLmMgYi9kcml2ZXJzL2NyeXB0by9jYWFtL2N0cmwuYyBpbmRleA0KPiBj
YTAzNjFiMmRiYjAuLjM4YzRkODhhOWQwMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jcnlwdG8v
Y2FhbS9jdHJsLmMNCj4gKysrIGIvZHJpdmVycy9jcnlwdG8vY2FhbS9jdHJsLmMNCj4gQEAgLTgy
MCwxMiArODIwLDI1IEBAIHN0YXRpYyBpbnQgY2FhbV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlDQo+ICpwZGV2KQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+ICAgICAg
ICAgfQ0KPiANCj4gLSAgICAgICBpZiAoY3RybHByaXYtPmVyYSA8IDEwKQ0KPiArICAgICAgIGNv
bXBfcGFyYW1zID0gcmRfcmVnMzIoJmN0cmwtPnBlcmZtb24uY29tcF9wYXJtc19scyk7DQo+ICsg
ICAgICAgY3RybHByaXYtPmJsb2JfcHJlc2VudCA9ICEhKGNvbXBfcGFyYW1zICYgQ1RQUl9MU19C
TE9CKTsNCj4gKw0KPiArICAgICAgIC8qDQo+ICsgICAgICAgICogU29tZSBTb0NzIGxpa2UgdGhl
IExTMTAyOEEgKG5vbi1FKSBpbmRpY2F0ZSBDVFBSX0xTX0JMT0Igc3VwcG9ydCwNCj4gKyAgICAg
ICAgKiBidXQgZmFpbCB3aGVuIGFjdHVhbGx5IHVzaW5nIGl0IGR1ZSB0byBtaXNzaW5nIEFFUyBz
dXBwb3J0LCBzbw0KPiArICAgICAgICAqIGNoZWNrIGJvdGggaGVyZS4NCj4gKyAgICAgICAgKi8N
Cj4gKyAgICAgICBpZiAoY3RybHByaXYtPmVyYSA8IDEwKSB7DQo+ICAgICAgICAgICAgICAgICBy
bmdfdmlkID0gKHJkX3JlZzMyKCZjdHJsLT5wZXJmbW9uLmNoYV9pZF9scykgJg0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBDSEFfSURfTFNfUk5HX01BU0spID4+IENIQV9JRF9MU19STkdf
U0hJRlQ7DQo+IC0gICAgICAgZWxzZQ0KPiArICAgICAgICAgICAgICAgY3RybHByaXYtPmJsb2Jf
cHJlc2VudCA9IGN0cmxwcml2LT5ibG9iX3ByZXNlbnQgJiYNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgKHJkX3JlZzMyKCZjdHJsLT5wZXJmbW9uLmNoYV9udW1fbHMpICYNCj4gQ0hBX0lEX0xT
X0FFU19NQVNLKTsNCj4gKyAgICAgICB9IGVsc2Ugew0KPiAgICAgICAgICAgICAgICAgcm5nX3Zp
ZCA9IChyZF9yZWczMigmY3RybC0+dnJlZy5ybmcpICYgQ0hBX1ZFUl9WSURfTUFTSykgPj4NCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgQ0hBX1ZFUl9WSURfU0hJRlQ7DQo+ICsgICAgICAg
ICAgICAgICBjdHJscHJpdi0+YmxvYl9wcmVzZW50ID0gY3RybHByaXYtPmJsb2JfcHJlc2VudCAm
Jg0KPiArICAgICAgICAgICAgICAgICAgICAgICAocmRfcmVnMzIoJmN0cmwtPnZyZWcuYWVzYSkg
Jg0KPiBDSEFfVkVSX01JU0NfQUVTX05VTV9NQVNLKTsNCj4gKyAgICAgICB9DQo+IA0KPiAgICAg
ICAgIC8qDQo+ICAgICAgICAgICogSWYgU0VDIGhhcyBSTkcgdmVyc2lvbiA+PSA0IGFuZCBSTkcg
c3RhdGUgaGFuZGxlIGhhcyBub3QgYmVlbiBkaWZmIC0tDQo+IGdpdCBhL2RyaXZlcnMvY3J5cHRv
L2NhYW0vaW50ZXJuLmggYi9kcml2ZXJzL2NyeXB0by9jYWFtL2ludGVybi5oIGluZGV4DQo+IDdk
NDViMjFiZDU1YS4uZTkyMjEwZTJhYjc2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2NyeXB0by9j
YWFtL2ludGVybi5oDQo+ICsrKyBiL2RyaXZlcnMvY3J5cHRvL2NhYW0vaW50ZXJuLmgNCj4gQEAg
LTkyLDYgKzkyLDcgQEAgc3RydWN0IGNhYW1fZHJ2X3ByaXZhdGUgew0KPiAgICAgICAgICAqLw0K
PiAgICAgICAgIHU4IHRvdGFsX2pvYnJzOyAgICAgICAgIC8qIFRvdGFsIEpvYiBSaW5ncyBpbiBk
ZXZpY2UgKi8NCj4gICAgICAgICB1OCBxaV9wcmVzZW50OyAgICAgICAgICAvKiBOb256ZXJvIGlm
IFFJIHByZXNlbnQgaW4gZGV2aWNlICovDQo+ICsgICAgICAgdTggYmxvYl9wcmVzZW50OyAgICAg
ICAgLyogTm9uemVybyBpZiBCTE9CIHN1cHBvcnQgcHJlc2VudCBpbiBkZXZpY2UgKi8NCj4gICAg
ICAgICB1OCBtY19lbjsgICAgICAgICAgICAgICAvKiBOb256ZXJvIGlmIE1DIGYvdyBpcyBhY3Rp
dmUgKi8NCj4gICAgICAgICBpbnQgc2VjdmlvX2lycTsgICAgICAgICAvKiBTZWN1cml0eSB2aW9s
YXRpb24gaW50ZXJydXB0IG51bWJlciAqLw0KPiAgICAgICAgIGludCB2aXJ0X2VuOyAgICAgICAg
ICAgIC8qIFZpcnR1YWxpemF0aW9uIGVuYWJsZWQgaW4gQ0FBTSAqLw0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9jcnlwdG8vY2FhbS9yZWdzLmggYi9kcml2ZXJzL2NyeXB0by9jYWFtL3JlZ3MuaCBp
bmRleA0KPiAzNzM4NjI1YzAyNTAuLjY2ZDZkYWQ4NDFiYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9jcnlwdG8vY2FhbS9yZWdzLmgNCj4gKysrIGIvZHJpdmVycy9jcnlwdG8vY2FhbS9yZWdzLmgN
Cj4gQEAgLTMyMCw3ICszMjAsOCBAQCBzdHJ1Y3QgdmVyc2lvbl9yZWdzIHsNCj4gICNkZWZpbmUg
Q0hBX1ZFUl9WSURfTUFTSyAgICAgICAoMHhmZnVsbCA8PCBDSEFfVkVSX1ZJRF9TSElGVCkNCj4g
DQo+ICAvKiBDSEEgTWlzY2VsbGFuZW91cyBJbmZvcm1hdGlvbiAtIEFFU0FfTUlTQyBzcGVjaWZp
YyAqLw0KPiAtI2RlZmluZSBDSEFfVkVSX01JU0NfQUVTX0dDTSAgIEJJVCgxICsgQ0hBX1ZFUl9N
SVNDX1NISUZUKQ0KPiArI2RlZmluZSBDSEFfVkVSX01JU0NfQUVTX05VTV9NQVNLICAgICAgR0VO
TUFTSyg3LCAwKQ0KPiArI2RlZmluZSBDSEFfVkVSX01JU0NfQUVTX0dDTSAgICAgICAgICAgQklU
KDEgKyBDSEFfVkVSX01JU0NfU0hJRlQpDQo+IA0KPiAgLyogQ0hBIE1pc2NlbGxhbmVvdXMgSW5m
b3JtYXRpb24gLSBQS0hBX01JU0Mgc3BlY2lmaWMgKi8NCj4gICNkZWZpbmUgQ0hBX1ZFUl9NSVND
X1BLSEFfTk9fQ1JZUFQgICAgIEJJVCg3ICsgQ0hBX1ZFUl9NSVNDX1NISUZUKQ0KPiBAQCAtNDE0
LDYgKzQxNSw3IEBAIHN0cnVjdCBjYWFtX3BlcmZtb24gew0KPiAgI2RlZmluZSBDVFBSX01TX1BH
X1NaX01BU0sgICAgIDB4MTANCj4gICNkZWZpbmUgQ1RQUl9NU19QR19TWl9TSElGVCAgICA0DQo+
ICAgICAgICAgdTMyIGNvbXBfcGFybXNfbXM7ICAgICAgLyogQ1RQUiAtIENvbXBpbGUgUGFyYW1l
dGVycyBSZWdpc3RlciAgICovDQo+ICsjZGVmaW5lIENUUFJfTFNfQkxPQiAgICAgICAgICAgQklU
KDEpDQo+ICAgICAgICAgdTMyIGNvbXBfcGFybXNfbHM7ICAgICAgLyogQ1RQUiAtIENvbXBpbGUg
UGFyYW1ldGVycyBSZWdpc3RlciAgICovDQo+ICAgICAgICAgdTY0IHJzdmQxWzJdOw0KPiANCj4g
LS0NCj4gMi4zMC4yDQoNCg==
