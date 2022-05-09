Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20C651FD11
	for <lists+linux-integrity@lfdr.de>; Mon,  9 May 2022 14:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbiEIMm7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 May 2022 08:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbiEIMm6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 May 2022 08:42:58 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20069.outbound.protection.outlook.com [40.107.2.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283F328ED2E;
        Mon,  9 May 2022 05:39:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWPz9IGuH1NmwjwBBubXx04u8dKcaiNfLqp9RB24vxnSrfIXOcnwNtrCjTr//Akp2ewxchb9FN6gOC0MYqFi+dRDn2JnmOLNwGcGtDpr5+e+X0O6IFfohDR7T5k0rCTTeffXi4g/XPeGt4fcN0Gr9xtHbChYiZ0KbBRd6sg4ARxVIWITERU7jlFXXtoll9gI/yP360YNtkhut3FMUz2Z1TIsvX7rIx1LU8n5+VA7oC0kgPOrlISVl1MSp4nfeNsA2GEn3GsBK4xbjfIlMRYkRLvO5Pd7WP0Xdw6r/8k44EjQ7CUWKuHuhiTzgMjF0aAZYYTI8pWkYIBUUM1t7J6LFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHTvfAr/XeQ/4WBhoe+sgiXSMW3oEYTtkDvj6dD1bNs=;
 b=G8dt8OHZ+baMbzvnCeWRWv5h0g5P2qdQFRlzi4PRkvwoT9mZavjzNbaZWKICYaIZiEjDHdgsU/XH5PGObmZeB/OM+PkTX6uc+8MfWufHMeS43PITgEAZ5FK60f+FVEidhNoY++11Z90ZdnYe+Vi2hlJp6RxegB4fPEXAqSZZBJIqCe8cFDDMpvVSavbbMiYEE/ZOZCAi4I3+iSNl5ezV6HDAinjnCVO0XMG781HME/V2aTKO2w4O0dD2m8eOQl8F/TaBv/0mBBLwgFLB1H0EI3KR2RLxSS16C/eA04zfwNjErDUuq2xC0Fphv+ZduVwx32eP6pK0wQsqgWFWMAF+CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHTvfAr/XeQ/4WBhoe+sgiXSMW3oEYTtkDvj6dD1bNs=;
 b=eJytAukTjT7U9dpCVbSjPpGaa//ftHjbMjxNgjh1P44MZTlz+hm1xucbTYur6iYypjQm88thBdkpUE4OMZ9HU1TcktqPgL3qv85nvdKJf/E6g+zlkCUMYo6vwkgnbJgK+Ai1QHAfc/ZA7domq3N7ZBI3lcN9X3KNvyaml04L6ew=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by PAXPR04MB8717.eurprd04.prod.outlook.com (2603:10a6:102:21c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 12:39:01 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::b454:80f3:ce2c:6fbc]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::b454:80f3:ce2c:6fbc%4]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 12:39:01 +0000
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
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: RE: [EXT] [PATCH v9 3/7] crypto: caam - determine whether CAAM
 supports blob encap/decap
Thread-Topic: [EXT] [PATCH v9 3/7] crypto: caam - determine whether CAAM
 supports blob encap/decap
Thread-Index: AQHYYRI97Pupc5Ww9UOAxVboSwK5L60WgJwg
Date:   Mon, 9 May 2022 12:39:01 +0000
Message-ID: <DU2PR04MB8630501008F661C596C0106295C69@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20220506062553.1068296-1-a.fatoum@pengutronix.de>
 <20220506062553.1068296-4-a.fatoum@pengutronix.de>
In-Reply-To: <20220506062553.1068296-4-a.fatoum@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32ab1fb1-be90-4f67-503f-08da31b8e507
x-ms-traffictypediagnostic: PAXPR04MB8717:EE_
x-microsoft-antispam-prvs: <PAXPR04MB871765731354151320E1932495C69@PAXPR04MB8717.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sEFV0rLKhZHqDB7sTArTDIVn/ET12x1K2lzeBseYk7pGDeJ5hubQj2OmAqYFuhyqwIsZLETZuoUs1XOrMUZUR1x67CEL1HgKFPxyruByK4oKFGynR70ptkjSCky7NR3yzwAdVr/TQ2CSN9i27FyMyiWmztpaZOuRRpULFdysSZwhEL8vxAar1KwNnnOtGIOE5UoJzaL2QtCaLNp8IXmycZrgLNrLoHvbQ8j3l6cm59Iw3eVb5RnybASq8YFgRd1jUCfBSeUwRD54bwpUl43J0s7bfJFOyHbme3Xy7N1czdcvG65O/TOiIqDYjKp+WOLNpgdtDD3RsqTWbiCPaLOuD0wk1ABVcSTGOQ5n/DR28tx5gd8sxEQyT5WNWB6BX2OcK9SUkwW4wcTW4l7MGsGfZJJFRf3Y/deW+kCp1OrqKydkpG+kLku9i+GAmFuvIusEBnNoHXlZKVsTY1zB/1S14CAJuX9eLtfMomyVvIPas2dv+Rd64QBCFjU5DLWfcEMYMTTp1Mq0cMn7kyW1ZQ1id37AtqwXdYKUjKW7V+IpS+JoLZGsw/1HsIYLJdejP0GwQAx1FQ+gLv77grcMRTNrhE0yzdvzbMlD919okIATcruBegZFYZ5Abv3rLmyFvojCQZplU818sEzNJVL0oTsxgUJIqKDi4xKJF1Yfhgn7A2St002iWF/rpMe5YN7wBKplqWDqXKzALcE0dP5dCsnSZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(8676002)(76116006)(66946007)(83380400001)(38100700002)(64756008)(38070700005)(2906002)(66446008)(66476007)(66556008)(55236004)(7696005)(33656002)(53546011)(54906003)(508600001)(316002)(110136005)(55016003)(71200400001)(6506007)(7416002)(9686003)(52536014)(26005)(5660300002)(186003)(86362001)(122000001)(8936002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVBoN0dLbWNHTk9GaU54cE1UM1Z5dk5WZXZRT3pNMnA2MUU2dFpuY2JMeW92?=
 =?utf-8?B?Rmc0WGF1dGdPRTh6K0Jwcisra1FpeTVpMGd5L0t0K0ZqaHFvN0lzbXVtaVYx?=
 =?utf-8?B?TXR5QlRSK0RBMXY0VVl3aTAzUzhmVGNBVkYvMWFHNlVJeDkwQ1hwQ1VWYU9r?=
 =?utf-8?B?Nk9JVEZYVXgyWDgyU091cGdqWDhJaFU4bmg3WG9zRklUT3QwY29hZnhyVDVw?=
 =?utf-8?B?TGxyZk01bzA0bCt1NGJvdWkwRDBPLzNWRDVMbm82UkpDTXNYSTAvSHFZanpN?=
 =?utf-8?B?SkFWM3BiMVVjQllKUmpSc0VrSldyUSs3VHlaYjQ1L2ZtNDhoOEJlRHpsR1g3?=
 =?utf-8?B?aTN0SFJpM2pSV3NUaTdnck5ydkpTNlpjV1RhdG9rM3dFSFJiTHZVcG5vTyt3?=
 =?utf-8?B?YXFkVXJnSmpaekh4djFFTG1GUi9HbzR3M2dBRjE4QUZWMm9BQjJlZ1RmcWFZ?=
 =?utf-8?B?Vys1Q0FlcGVBby9oZ0FRa1poSlpLTFhnWkNMVmEyS3BoU3QyU2c5aS8rQkll?=
 =?utf-8?B?ME1kNGU1RnRUajVhVzlvWkFzQm1BR2QyOHpadEhXcWU4NktKTDU5L3ZtR0lm?=
 =?utf-8?B?cVBEb2dDK3V6UDF1WnhpZ1pxbHZFcmxYRWtQckFaamthU2R2TFFKYW0zZGdJ?=
 =?utf-8?B?b2FuYVU5RXVQVFlCV3NOSFdKOUlGb3V3M2k5aUVFNTBLendaTSt6czJ0ZDVx?=
 =?utf-8?B?ODB6amx4VmNTaTRMNDRaa0NKQkpvdFlpYUk5clYwY0l1Q1FSU2luY0NlVW5F?=
 =?utf-8?B?eVVoNGpUTk9RdFk5bTc2THdrVjNzcUZhanhEdGRIcXlWK0RoZWt1K29uR1Ev?=
 =?utf-8?B?TitvMmJjWndBRDZtNWFjaTNhanBqY3BJV1p2ODdrM2E1dDRDQTc2Q0FkSjdS?=
 =?utf-8?B?YUxVTklLYlFsMmpjOVNtcDU5UXZud3ZBYkNaODFDb21ld2h4Y3YzYW45a1or?=
 =?utf-8?B?RUZtazM3Ym5kaG5ubU5ObTVTN21Ub2c4NjlvbVE4eGViQjRBR0EyTVhpTnNy?=
 =?utf-8?B?SUYyeWpiRC9VZ0dveUI0RFlrMGwyeXVRc1AvR3VJS05QZ0o0ZDB6ZWVxNGov?=
 =?utf-8?B?VzNOODlkQzM2OHdpY3BUd3BMNUFTRXhFaDFMWjRmK2VVcUdVU1JxNmVtYVk1?=
 =?utf-8?B?NmxSQkFteFJmNjJUWmxUbUhvMnFCZFUrbDFwdGVUWEpBeGw3N0RtMGhNVmhS?=
 =?utf-8?B?d2NlT05mZ3pxemhkMU8xanpOM1FVUmRXRDFlMjBaMFFTUy9qUzBHckZIcStv?=
 =?utf-8?B?YnZidWlzZk9mQWZsTzQyK1ZSRW5YeE1peitTc1JVY3RhM1VJZHYwTSt3Szlo?=
 =?utf-8?B?N0ZWUnJSR0YyTzJrTmJQY1FmZjBza2l6YVl0WlJOWlg5WVloS3Boc0s5Tm1l?=
 =?utf-8?B?UHZ6TWcyblV2Q294bXJlcytGbmViclM4ZjdzY0tCdzUxOHJwa0h4MHNwSFY0?=
 =?utf-8?B?aXhBazZSRmJKdnhVcDBKeDBOR0dKU0MrRzkxQVlLMlZxckhGR2dBM1h6QzI2?=
 =?utf-8?B?dm9IZFVTWkxYNERmT3NWQzZOazNwNEtqSGRGUGlvdENpR01RektBMkZGV3B1?=
 =?utf-8?B?bUY0bTlVNUpZczBRUHBmeXZSQlBVSndXVEpOUVduMXRHMzR5R2tzYWZod3dk?=
 =?utf-8?B?dlNrdU1lSTNPQmJVMzd6NXlSVGxiTlkvbWc0UDU3M0V6RzdTenNTeldzcXFZ?=
 =?utf-8?B?RFZEeUlvWTAxbDI3K2IzS0I2THJ4N1BlMjFxck1HM0orSGFQRm9NZExEVURH?=
 =?utf-8?B?ZnNucEdPRGVjdGY5NUYveFpQeks5WnowWmNncFovNDJHOXZTdmpOeENNT1pS?=
 =?utf-8?B?MUJGTWFmcjQ0SjNMeE5hTEhyaHJlZDhXWDNrZE1wNDhpeEE1YVp4YSsvWVQx?=
 =?utf-8?B?WWtFQXR5eFhtVU9Zb1hkZ3kvQkVMN1h4dXNYdDhiUDYzc0RTL0JFRkZPYzFE?=
 =?utf-8?B?SlkvazR4cWkxcjA0Q3ZZWXBIblB4SjVYdjFtL2txS0d3WHJSVzJrTHd4d3FU?=
 =?utf-8?B?VUcyeFBKRDNNZWVqdTUrUmFJd0VDSmNUc3N6YUxOTjc1TWZrajNKUmxSc3Bv?=
 =?utf-8?B?bCs4Qnk0V2xHYkg4Zzh3OGlVZW1UeHdmbGQrVTYzRWhOaXEycWc4TDZHYkFs?=
 =?utf-8?B?VCtCalNRWDVmaDJXWWR4VkMrbCtxT05URDdvd2ExR29HY2lkUkpvY1lzK1pn?=
 =?utf-8?B?NXBrWU50djZWVHJlRWdOYlNVeVdmS0lsZnRlNUpRZmczR2hUbTlwSERuQy94?=
 =?utf-8?B?L0FUMUNna3RxYlFWREtlOWxOUXp6NmhYNnIrcWlSY0RjUmo5cUNVRHg4ZWsv?=
 =?utf-8?B?QkdXeS9EL3VUdEx3ZVZ5RFVmYTZDMFBRc0VNSGNCdGxEZzJmZjNVUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ab1fb1-be90-4f67-503f-08da31b8e507
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 12:39:01.2395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jh5SoN4nbW7fAT2hFQ2wtny+djLzLy51ByB3WHcfH6hChvzsj30oREo6HH0ZRVA28nMyRiIHIwFu83ZiYvp0Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8717
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SGkgQWhtYWQsDQoNCkNoZWNrIGZvciBBRVMgQ0hBcyBpcyBkb25lIG9ubHkgZm9yIEVyYSA+PSAx
MC4NCg0KUGxlYXNlIGZpbmQgdGhlIGNvbW1lbnRzIGluLWxpbmUuDQoNClJlZ2FyZHMNClBhbmth
ag0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFobWFkIEZhdG91bSA8
YS5mYXRvdW1AcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IEZyaWRheSwgTWF5IDYsIDIwMjIgMTE6
NTYgQU0NCj4gVG86IEhvcmlhIEdlYW50YSA8aG9yaWEuZ2VhbnRhQG54cC5jb20+OyBQYW5rYWog
R3VwdGENCj4gPHBhbmthai5ndXB0YUBueHAuY29tPjsgSGVyYmVydCBYdSA8aGVyYmVydEBnb25k
b3IuYXBhbmEub3JnLmF1PjsgRGF2aWQNCj4gUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0
Pg0KPiBDYzoga2VybmVsQHBlbmd1dHJvbml4LmRlOyBNaWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdh
bGxlLmNjPjsgQWhtYWQgRmF0b3VtDQo+IDxhLmZhdG91bUBwZW5ndXRyb25peC5kZT47IEphbWVz
IEJvdHRvbWxleSA8amVqYkBsaW51eC5pYm0uY29tPjsgSmFya2tvDQo+IFNha2tpbmVuIDxqYXJr
a29Aa2VybmVsLm9yZz47IE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+OyBEYXZpZA0K
PiBIb3dlbGxzIDxkaG93ZWxsc0ByZWRoYXQuY29tPjsgSmFtZXMgTW9ycmlzIDxqbW9ycmlzQG5h
bWVpLm9yZz47IEVyaWMNCj4gQmlnZ2VycyA8ZWJpZ2dlcnNAa2VybmVsLm9yZz47IFNlcmdlIEUu
IEhhbGx5biA8c2VyZ2VAaGFsbHluLmNvbT47IEphbg0KPiBMdWViYmUgPGoubHVlYmJlQHBlbmd1
dHJvbml4LmRlPjsgRGF2aWQgR3N0aXIgPGRhdmlkQHNpZ21hLXN0YXIuYXQ+OyBSaWNoYXJkDQo+
IFdlaW5iZXJnZXIgPHJpY2hhcmRAbm9kLmF0PjsgRnJhbmNrIExlbm9ybWFuZA0KPiA8ZnJhbmNr
Lmxlbm9ybWFuZEBueHAuY29tPjsgTWF0dGhpYXMgU2NoaWZmZXIgPG1hdHRoaWFzLnNjaGlmZmVy
QGV3LnRxLQ0KPiBncm91cC5jb20+OyBTdW1pdCBHYXJnIDxzdW1pdC5nYXJnQGxpbmFyby5vcmc+
OyBsaW51eC0NCj4gaW50ZWdyaXR5QHZnZXIua2VybmVsLm9yZzsga2V5cmluZ3NAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC0NCj4gY3J5cHRvQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtc2VjdXJpdHktDQo+IG1vZHVsZUB2Z2VyLmtlcm5lbC5vcmcN
Cj4gU3ViamVjdDogW0VYVF0gW1BBVENIIHY5IDMvN10gY3J5cHRvOiBjYWFtIC0gZGV0ZXJtaW5l
IHdoZXRoZXIgQ0FBTSBzdXBwb3J0cw0KPiBibG9iIGVuY2FwL2RlY2FwDQo+IA0KPiBDYXV0aW9u
OiBFWFQgRW1haWwNCj4gDQo+IERlcGVuZGluZyBvbiBTb0MgdmFyaWFudCwgYSBDQUFNIG1heSBi
ZSBhdmFpbGFibGUsIGJ1dCB3aXRoIHNvbWUgZnV0dXJlcw0KPiBmdXNlZCBvdXQuIFRoZSBMUzEw
MjhBIChub24tRSkgU29DIGlzIG9uZSBzdWNoIFNvQyBhbmQgd2hpbGUgaXQgaW5kaWNhdGVzIEJM
T0INCj4gc3VwcG9ydCwgQkxPQiBvcGVyYXRpb25zIHdpbGwgdWx0aW1hdGVseSBmYWlsLCBiZWNh
dXNlIHRoZXJlIGlzIG5vIEFFUyBzdXBwb3J0Lg0KPiBBZGQgYSBuZXcgYmxvYl9wcmVzZW50IG1l
bWJlciB0byByZWZsZWN0IHdoZXRoZXIgYm90aCBCTE9CIHN1cHBvcnQgYW5kIHRoZQ0KPiBBRVMg
c3VwcG9ydCBpdCBkZXBlbmRzIG9uIGlzIGF2YWlsYWJsZS4NCj4gDQo+IFRoZXNlIHdpbGwgYmUg
dXNlZCBpbiBhIGZvbGxvdy11cCBjb21taXQgdG8gYWxsb3cgYmxvYiBkcml2ZXIgaW5pdGlhbGl6
YXRpb24gdG8NCj4gZXJyb3Igb3V0IG9uIFNvQ3Mgd2l0aG91dCB0aGUgbmVjZXNzYXJ5IGhhcmR3
YXJlIHN1cHBvcnQgaW5zdGVhZCBvZiBmYWlsaW5nIGF0DQo+IHJ1bnRpbWUgd2l0aCBhIGNyeXB0
aWMNCj4gDQo+ICAgY2FhbV9qciA4MDIwMDAwLmpyOiAyMDAwMGIwZjogQ0NCOiBkZXNjIGlkeCAx
MTogOiBJbnZhbGlkIENIQSBzZWxlY3RlZC4NCj4gDQo+IENvLWRldmVsb3BlZC1ieTogTWljaGFl
bCBXYWxsZSA8bWljaGFlbEB3YWxsZS5jYz4NCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBXYWxs
ZSA8bWljaGFlbEB3YWxsZS5jYz4NCj4gU2lnbmVkLW9mZi1ieTogQWhtYWQgRmF0b3VtIDxhLmZh
dG91bUBwZW5ndXRyb25peC5kZT4NCj4gDQo+IC0tLQ0KPiB2OCAtPiB2OToNCj4gICAtIE5ldyBw
YXRjaA0KPiANCj4gVG86ICJIb3JpYSBHZWFudMSDIiA8aG9yaWEuZ2VhbnRhQG54cC5jb20+DQo+
IFRvOiBQYW5rYWogR3VwdGEgPHBhbmthai5ndXB0YUBueHAuY29tPg0KPiBUbzogSGVyYmVydCBY
dSA8aGVyYmVydEBnb25kb3IuYXBhbmEub3JnLmF1Pg0KPiBUbzogIkRhdmlkIFMuIE1pbGxlciIg
PGRhdmVtQGRhdmVtbG9mdC5uZXQ+DQo+IENjOiBKYW1lcyBCb3R0b21sZXkgPGplamJAbGludXgu
aWJtLmNvbT4NCj4gQ2M6IEphcmtrbyBTYWtraW5lbiA8amFya2tvQGtlcm5lbC5vcmc+DQo+IENj
OiBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPg0KPiBDYzogRGF2aWQgSG93ZWxscyA8
ZGhvd2VsbHNAcmVkaGF0LmNvbT4NCj4gQ2M6IEphbWVzIE1vcnJpcyA8am1vcnJpc0BuYW1laS5v
cmc+DQo+IENjOiBFcmljIEJpZ2dlcnMgPGViaWdnZXJzQGtlcm5lbC5vcmc+DQo+IENjOiAiU2Vy
Z2UgRS4gSGFsbHluIiA8c2VyZ2VAaGFsbHluLmNvbT4NCj4gQ2M6IEphbiBMdWViYmUgPGoubHVl
YmJlQHBlbmd1dHJvbml4LmRlPg0KPiBDYzogRGF2aWQgR3N0aXIgPGRhdmlkQHNpZ21hLXN0YXIu
YXQ+DQo+IENjOiBSaWNoYXJkIFdlaW5iZXJnZXIgPHJpY2hhcmRAbm9kLmF0Pg0KPiBDYzogRnJh
bmNrIExFTk9STUFORCA8ZnJhbmNrLmxlbm9ybWFuZEBueHAuY29tPg0KPiBDYzogTWF0dGhpYXMg
U2NoaWZmZXIgPG1hdHRoaWFzLnNjaGlmZmVyQGV3LnRxLWdyb3VwLmNvbT4NCj4gQ2M6IFN1bWl0
IEdhcmcgPHN1bWl0LmdhcmdAbGluYXJvLm9yZz4NCj4gQ2M6IE1pY2hhZWwgV2FsbGUgPG1pY2hh
ZWxAd2FsbGUuY2M+DQo+IENjOiBsaW51eC1pbnRlZ3JpdHlAdmdlci5rZXJuZWwub3JnDQo+IENj
OiBrZXlyaW5nc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWNyeXB0b0B2Z2VyLmtlcm5l
bC5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LXNl
Y3VyaXR5LW1vZHVsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gLS0tDQo+ICBkcml2ZXJzL2NyeXB0by9j
YWFtL2N0cmwuYyAgIHwgMTAgKysrKysrKystLQ0KPiAgZHJpdmVycy9jcnlwdG8vY2FhbS9pbnRl
cm4uaCB8ICAxICsNCj4gIGRyaXZlcnMvY3J5cHRvL2NhYW0vcmVncy5oICAgfCAgNCArKystDQo+
ICAzIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcnlwdG8vY2FhbS9jdHJsLmMgYi9kcml2ZXJzL2NyeXB0
by9jYWFtL2N0cmwuYyBpbmRleA0KPiBjYTAzNjFiMmRiYjAuLjY0MjZmZmVjNTk4MCAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9jcnlwdG8vY2FhbS9jdHJsLmMNCj4gKysrIGIvZHJpdmVycy9jcnlw
dG8vY2FhbS9jdHJsLmMNCj4gQEAgLTgyMCwxMiArODIwLDE4IEBAIHN0YXRpYyBpbnQgY2FhbV9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgICAgICAgICAgICAgICAgcmV0
dXJuIC1FTk9NRU07DQo+ICAgICAgICAgfQ0KPiANCj4gLSAgICAgICBpZiAoY3RybHByaXYtPmVy
YSA8IDEwKQ0KPiArICAgICAgIGNvbXBfcGFyYW1zID0gcmRfcmVnMzIoJmN0cmwtPnBlcmZtb24u
Y29tcF9wYXJtc19scyk7DQo+ICsgICAgICAgY3RybHByaXYtPmJsb2JfcHJlc2VudCA9ICEhKGNv
bXBfcGFyYW1zICYgQ1RQUl9MU19CTE9CKTsNCj4gKw0KPiArICAgICAgIGlmIChjdHJscHJpdi0+
ZXJhIDwgMTApIHsNCj4gICAgICAgICAgICAgICAgIHJuZ192aWQgPSAocmRfcmVnMzIoJmN0cmwt
PnBlcmZtb24uY2hhX2lkX2xzKSAmDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIENIQV9J
RF9MU19STkdfTUFTSykgPj4gQ0hBX0lEX0xTX1JOR19TSElGVDsNCg0KQ2hlY2sgZm9yIEFFUyBD
SEFzIGZvciBFcmEgPCAxMCwgc2hvdWxkIGJlIGFkZGVkLg0KDQo+IC0gICAgICAgZWxzZQ0KPiAr
ICAgICAgIH0gZWxzZSB7DQo+ICAgICAgICAgICAgICAgICBybmdfdmlkID0gKHJkX3JlZzMyKCZj
dHJsLT52cmVnLnJuZykgJiBDSEFfVkVSX1ZJRF9NQVNLKSA+Pg0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBDSEFfVkVSX1ZJRF9TSElGVDsNCj4gKyAgICAgICAgICAgICAgIGN0cmxwcml2
LT5ibG9iX3ByZXNlbnQgPSBjdHJscHJpdi0+YmxvYl9wcmVzZW50ICYmDQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIChyZF9yZWczMigmY3RybC0+dnJlZy5hZXNhKSAmIENIQV9WRVJfTUlTQ19B
RVNfTlVNX01BU0spOw0KPiArICAgICAgIH0NCj4gDQo+ICAgICAgICAgLyoNCj4gICAgICAgICAg
KiBJZiBTRUMgaGFzIFJORyB2ZXJzaW9uID49IDQgYW5kIFJORyBzdGF0ZSBoYW5kbGUgaGFzIG5v
dCBiZWVuIGRpZmYgLS1naXQNCj4gYS9kcml2ZXJzL2NyeXB0by9jYWFtL2ludGVybi5oIGIvZHJp
dmVycy9jcnlwdG8vY2FhbS9pbnRlcm4uaCBpbmRleA0KPiA3ZDQ1YjIxYmQ1NWEuLmU5MjIxMGUy
YWI3NiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jcnlwdG8vY2FhbS9pbnRlcm4uaA0KPiArKysg
Yi9kcml2ZXJzL2NyeXB0by9jYWFtL2ludGVybi5oDQo+IEBAIC05Miw2ICs5Miw3IEBAIHN0cnVj
dCBjYWFtX2Rydl9wcml2YXRlIHsNCj4gICAgICAgICAgKi8NCj4gICAgICAgICB1OCB0b3RhbF9q
b2JyczsgICAgICAgICAvKiBUb3RhbCBKb2IgUmluZ3MgaW4gZGV2aWNlICovDQo+ICAgICAgICAg
dTggcWlfcHJlc2VudDsgICAgICAgICAgLyogTm9uemVybyBpZiBRSSBwcmVzZW50IGluIGRldmlj
ZSAqLw0KPiArICAgICAgIHU4IGJsb2JfcHJlc2VudDsgICAgICAgIC8qIE5vbnplcm8gaWYgQkxP
QiBzdXBwb3J0IHByZXNlbnQgaW4gZGV2aWNlICovDQo+ICAgICAgICAgdTggbWNfZW47ICAgICAg
ICAgICAgICAgLyogTm9uemVybyBpZiBNQyBmL3cgaXMgYWN0aXZlICovDQo+ICAgICAgICAgaW50
IHNlY3Zpb19pcnE7ICAgICAgICAgLyogU2VjdXJpdHkgdmlvbGF0aW9uIGludGVycnVwdCBudW1i
ZXIgKi8NCj4gICAgICAgICBpbnQgdmlydF9lbjsgICAgICAgICAgICAvKiBWaXJ0dWFsaXphdGlv
biBlbmFibGVkIGluIENBQU0gKi8NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3J5cHRvL2NhYW0v
cmVncy5oIGIvZHJpdmVycy9jcnlwdG8vY2FhbS9yZWdzLmggaW5kZXgNCj4gMzczODYyNWMwMjUw
Li42NmQ2ZGFkODQxYmIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY3J5cHRvL2NhYW0vcmVncy5o
DQo+ICsrKyBiL2RyaXZlcnMvY3J5cHRvL2NhYW0vcmVncy5oDQo+IEBAIC0zMjAsNyArMzIwLDgg
QEAgc3RydWN0IHZlcnNpb25fcmVncyB7DQo+ICAjZGVmaW5lIENIQV9WRVJfVklEX01BU0sgICAg
ICAgKDB4ZmZ1bGwgPDwgQ0hBX1ZFUl9WSURfU0hJRlQpDQo+IA0KPiAgLyogQ0hBIE1pc2NlbGxh
bmVvdXMgSW5mb3JtYXRpb24gLSBBRVNBX01JU0Mgc3BlY2lmaWMgKi8NCj4gLSNkZWZpbmUgQ0hB
X1ZFUl9NSVNDX0FFU19HQ00gICBCSVQoMSArIENIQV9WRVJfTUlTQ19TSElGVCkNCj4gKyNkZWZp
bmUgQ0hBX1ZFUl9NSVNDX0FFU19OVU1fTUFTSyAgICAgIEdFTk1BU0soNywgMCkNCj4gKyNkZWZp
bmUgQ0hBX1ZFUl9NSVNDX0FFU19HQ00gICAgICAgICAgIEJJVCgxICsgQ0hBX1ZFUl9NSVNDX1NI
SUZUKQ0KPiANCj4gIC8qIENIQSBNaXNjZWxsYW5lb3VzIEluZm9ybWF0aW9uIC0gUEtIQV9NSVND
IHNwZWNpZmljICovDQo+ICAjZGVmaW5lIENIQV9WRVJfTUlTQ19QS0hBX05PX0NSWVBUICAgICBC
SVQoNyArIENIQV9WRVJfTUlTQ19TSElGVCkNCj4gQEAgLTQxNCw2ICs0MTUsNyBAQCBzdHJ1Y3Qg
Y2FhbV9wZXJmbW9uIHsNCj4gICNkZWZpbmUgQ1RQUl9NU19QR19TWl9NQVNLICAgICAweDEwDQo+
ICAjZGVmaW5lIENUUFJfTVNfUEdfU1pfU0hJRlQgICAgNA0KPiAgICAgICAgIHUzMiBjb21wX3Bh
cm1zX21zOyAgICAgIC8qIENUUFIgLSBDb21waWxlIFBhcmFtZXRlcnMgUmVnaXN0ZXIgICAqLw0K
PiArI2RlZmluZSBDVFBSX0xTX0JMT0IgICAgICAgICAgIEJJVCgxKQ0KPiAgICAgICAgIHUzMiBj
b21wX3Bhcm1zX2xzOyAgICAgIC8qIENUUFIgLSBDb21waWxlIFBhcmFtZXRlcnMgUmVnaXN0ZXIg
ICAqLw0KPiAgICAgICAgIHU2NCByc3ZkMVsyXTsNCj4gDQo+IC0tDQo+IDIuMzAuMg0KDQo=
