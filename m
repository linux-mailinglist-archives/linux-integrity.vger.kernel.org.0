Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04C23F8412
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Aug 2021 11:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240351AbhHZJBz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Aug 2021 05:01:55 -0400
Received: from mail-eopbgr70134.outbound.protection.outlook.com ([40.107.7.134]:2030
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232957AbhHZJBy (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Aug 2021 05:01:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byXgb2mMciMgX0Ykv1sq0cul7oEHjaIavHvv0kqdeFVfoK8Shw9JRJF6ArU9o9sTvObEIRuAGRHS2ZvmEimELNFHaX0v7FtJYoJ5H+Qwnvf+YTiKn1I2XE3qc3+hjEvMiRvNGcsf8l0KjpA50SwtbtNKDDZuQM33aQgY+kRcAL9i6vBOjT6ztvO1Xaspaz2+4FmTlWzs1q8PwUTX5tGyW/lIB/PS+pnmfngY6mDr7K1mPbJi1aJx44hZ8y0BJYhLaUhDRbZVfdp91Ta9AGnEVmSgfBa8AxrodmE3AYap+vI9yZoDQ11FF8jxoxfvIo8JGV5I9fUu569smgSWG4J16g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8poG2uFvxapD0rE1gHESQrj2thnBixCe9UdyGCEUzM=;
 b=EdYsrETkXbL4L542VOA+pZ+zW2PPBtTI4tJfL12rEogPDcOgaN0Soqs3j0WBPI7/fjgVWSfoe9EQXsXiQcOFrzebEesHch+TZDU2Y28PcospxZAr4FW4yyQH2/q7kvjlyRu8E97GMf5AE7L5RxIoxT+BHLNqOVruJYvibwgE3whLRL4wA4h1GnbsxbkFpYedM6hyMXgmenxxQZ7K5rh8+uQAn/9uS+Wsabirhx4gmGCUgPByUmDFKG1qYyciJQCGufLDjBN27yTCZhy35Ex3g0MQb78OvL+J61D73M9IsxQvTPwuq7nI37JWXU4y9eBjttlyocrG1rLYv02Id1aq6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8poG2uFvxapD0rE1gHESQrj2thnBixCe9UdyGCEUzM=;
 b=cpQRYNt/Msxbfz+pKLYZTrr2yWc/nBOuyGajKqMmUAfrwj/JkffuUXuBvUhtfqQadcxUAnDMd4GG//3nmvcRLYEtVXlJ2ntz6jqS3LFo5W7bcNfZjR0r6igKQBJfX44N5P70UfvXUTITbib3s0mvSUFMUBosQkM1kPwhjQfExXk=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB4051.eurprd09.prod.outlook.com
 (2603:10a6:208:19f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Thu, 26 Aug
 2021 09:01:04 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4457.017; Thu, 26 Aug 2021
 09:01:04 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     liqiong <liqiong@nfschina.com>, Mimi Zohar <zohar@linux.ibm.com>
CC:     "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: fix deadlock within RCU list of ima_rules
Thread-Topic: [PATCH] ima: fix deadlock within RCU list of ima_rules
Thread-Index: AQHXmX+tegVBd7sMTk67aKGRvAyd76uEGmyAgAAFHACAAVKggIAADJCA
Date:   Thu, 26 Aug 2021 09:01:04 +0000
Message-ID: <3ef6906b-ccf1-0ab8-180b-b71568e22443@viveris.fr>
References: <20210819101529.28001-1-liqiong@nfschina.com>
 <20210824085747.23604-1-liqiong@nfschina.com>
 <e720e88e-ebfa-56df-6048-f2da0b8fa2a0@viveris.fr>
 <3ba4da9d-fa7b-c486-0c48-67cee4d5de6d@nfschina.com>
 <2c4f61ff68544b2627fc4a38ad1e4109184ec68a.camel@linux.ibm.com>
 <d502623a-7a49-04f8-1672-6521ceef260b@nfschina.com>
 <5a032a1b-f763-a0e4-8ea2-803872bd7174@nfschina.com>
 <eb9921ff-2d4b-136f-b7a7-924e61a0651b@viveris.fr>
 <1e464ae0-28e1-6511-ab89-52b5cd1a0841@nfschina.com>
In-Reply-To: <1e464ae0-28e1-6511-ab89-52b5cd1a0841@nfschina.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nfschina.com; dkim=none (message not signed)
 header.d=none;nfschina.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe062dc7-7986-45a8-4e38-08d968700920
x-ms-traffictypediagnostic: AM0PR09MB4051:
x-microsoft-antispam-prvs: <AM0PR09MB4051DA1BDFDCCD5099561FCE94C79@AM0PR09MB4051.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kRKHyiOP3X0NaZoIDWoTXFGdsvgIDbrs8q1NBFvUcMreyI3dNLnaKGPKyDTOp0JaE3Q9nWes920ujWwQd6lhPZ43JjY+zpHGXQsG0F5RVlcdoEmZPxTigWjXw9fbQ1JvPi1wx7jUHmGTCMDGR1Hzpu+Q6XPeHLZTCn1mzSXCARWzicW9rANyGmOnD+5z9CyKa5HF9NfpZKp/hHjNnpi0KJS3VCDPK5wI1co08crA5bPU/kr8gFGKUvqjFhSaUD3NgwkJ2ijsSysMJUs7GVFVo920V1UFLc482p3lZUjYZBLxwQUKr0GpUyAdIOs1hepMSfONWG7//bEOeZfQBVOKeOIwhD23M4A1VFSsh5JjvZwnTuBXLtTAUEY/wsrpA0pQfXOyOqBx3Pr1kcZ/lDaTuLlpXDe8+/oD7xekUvM2rRgJYtGg8In4gVRumZK2yMd3YUJzV1l0PvVNQPgbo9v9oHrHwAMKINRWlsF8hmtpD1d4hzFgCsMgKfZQ9SGWIkNHxbw6mOga2MN3/eeU96PnifKmX4KzYpo2YJMMo5auF4NWXoLsB8L8gnGPhWXYq8tGq6ynGwtLXqa1oWqcQckgaW5iALvgdX75j76Akc1BkNIihrJAatS5hshaP+SzGezUgFm7kX4BmEXaokYMD79w399q9Ww/hYxWi+nf/7fCJ7Mp1/AzJZKByRShIE3iTa6jZEph8xHkdq0b4yUXxtnNeFNERK/HeQqH5spwFTmYwOAwjmB+aIXx1EbxN9OPrp51
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(396003)(376002)(39840400004)(66946007)(6506007)(66556008)(83380400001)(66476007)(6486002)(66446008)(64756008)(186003)(5660300002)(2616005)(4326008)(54906003)(110136005)(38100700002)(122000001)(316002)(478600001)(26005)(86362001)(71200400001)(2906002)(6512007)(91956017)(76116006)(8676002)(31696002)(38070700005)(36756003)(8936002)(53546011)(31686004)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVhGYnJ4RGY5S0FxQVB5YzZ0RjBsblFpL2kwK0NDNTRxYmVpN0c2ZkVYTGox?=
 =?utf-8?B?Mnh5cER6VHBqME1xU0VVZDFHbFR6S29PMzNzUTJXMW1XTWR5cXNqWTd0UHpX?=
 =?utf-8?B?ZUVOZlQ1QWFxcGdEMmEvY0cxN2FDdFpOWm43OHBkMUc0U0VuaUw2NTN6bDFS?=
 =?utf-8?B?ZTZyM0x5U1REK0pwY3hBUmV4d1MrUHVHblhicDB6UDZTTm04NVpMbTFJaFY3?=
 =?utf-8?B?bFl6U0J0SGkyTmVpckkxdzJ6L2xBTEgrZm9KbzlScGZjUloyMWliVzN6bTV5?=
 =?utf-8?B?RWtheElScTdwN3B2L0Q4TElhNUM1MnpSSlBYZWVVemZlNitIWFoybGw2Q1Vi?=
 =?utf-8?B?dGFQRlhZQXJMd2Y1dEhZbTBqQjRyTXhteFMzc0YrMVNlRnR2ZEswYXc4alpp?=
 =?utf-8?B?aHFmT2xGa0puMW9RVGFxaldDMkVXUDFqb1plT01iN3lsMHVEUHgxd2lyejV3?=
 =?utf-8?B?azNtamZ3enFxaU13ZUs0NExaVGxUY0hYd0NmSXdrRSswNVhxWkVGWmh6TDcz?=
 =?utf-8?B?T2Q0dG5tR0c5OWVDbXRyMEEwcS9objJrK0liaHFtL0cxZ3gyV0NBejlNaXhy?=
 =?utf-8?B?Nk0wdzRoWEh0Sko3YVdXclBWYnBTckxUU1FqT0pTN3Fld2xnMUwwU0JzUzVj?=
 =?utf-8?B?UFFUOTlPbmhUUkJ2TzZkVGRwTmt6ZXdWby8zYWh0WVEwdXI4bUJKd2dTMndO?=
 =?utf-8?B?enNYYlFBZHVnZmI1dzh3eVE4SVRkUHZXOU8xbHpjb1VPK2JxTDA3eVltVUFC?=
 =?utf-8?B?cXl1WWFtbEplYkVKY0x4VytzaEdtbFVzYkVrdkR0S2RtY3ZmdGxMdGpHRFp3?=
 =?utf-8?B?MFEzbCs3aFRraXR1UVBaTE4zUW9OaDNGVmJ6ZWRlanpVSGdDckdFdzJzQmFX?=
 =?utf-8?B?V01RaFVsZlMxVGlXck5OQTBZTFREUlgzM1dsSnBuSlB0NDFnNCsyYVpGK2pI?=
 =?utf-8?B?SWtsTmNwTDZzRHNsbEJlbi9KQjkzbXdUL0FOQ0FzOURRZmozckp3WFNQc3I2?=
 =?utf-8?B?dGxFVk5xbkFjSXlKaEcwL1VzR3locG5ndXYweHBYNWNFeFVKeW5jVUNhSWti?=
 =?utf-8?B?S01udnhIMjlLT3lXQS93UDI3SE1Kd3h2R2NpVTdNUGZVSmhrYUlValR4UGdR?=
 =?utf-8?B?VUlqSGVhRThZTkR6dU8ybGFpVGttTFZEYjJwaFltSVJycGdDNDkrTUVCT1hE?=
 =?utf-8?B?QVRnblFYUkFkYzRZaDQzNTN2SFUzM29lak5GMGRUc3l4NWdrZk92RlhuUkIr?=
 =?utf-8?B?MXQ1WXE2Zjd3N2JjRWxpKzdwQjU1aUlhYjBKUEdZL2hybmR0aS81b0pLM0VX?=
 =?utf-8?B?bTBIem9Od2gvMCtJNXRaQlkwSXFZMnJLRDdHc0xuVngwOTUrNmFoaE9lM0h2?=
 =?utf-8?B?TC9OWjB3MWkyTEtOVzNrRHVjSUJFRU5BTmVBcmNjTEREbWo3U3prWGpvWThr?=
 =?utf-8?B?T1d1Z3FjdzlWeXFrMTNGOXZnMEovSlB6THIvZSsxNkg0WmlSWTA0NFFRdXFw?=
 =?utf-8?B?M1o4Q0R6bm43eGpDT1pjRmU1WEFQSTVuQVRIdkRjbFFOazZqM1pGeTdwcXM1?=
 =?utf-8?B?YVhRalpzUityeWhKK0R3WGtuY0dpVkFhWnR6cFdKUk5YNnNEdVFnd09ZVEdz?=
 =?utf-8?B?M3Fib1NNa1E4aFVZZk02RVRya3dTVmExd2ZSZXN1a29qUjVheWt0ZUN4NTQ0?=
 =?utf-8?B?Z3BQTklOOHR6SEJla1FuREdxbHk1Ny9GWWZYMHBjeHFycWJJd2NKNXUzKytP?=
 =?utf-8?Q?1Ir17wqm8E0lLRVc2kFg0bRAkO+rF7mquqVHrW8?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <49F5C726A0FE564594B5F895D9ABA1E4@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe062dc7-7986-45a8-4e38-08d968700920
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2021 09:01:04.7144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PN/mjNVP7X0tU31cIpyHFStplK9U5WA5lfNdELr8a5TbUM59hnJp14mlTHXdlu/RVLNdtpudukVP3LE3Ef0KtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4051
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SGkgbGlxaW9uZywNCg0KT24gOC8yNi8yMSAxMDoxNSBBTSwgbGlxaW9uZyB3cm90ZToNCj4gSGkg
U2ltb24sDQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgaGVscCwgeW91ciBhZHZpY2UgaXMgY2xlYXIs
IGNhbiBpIGp1c3QgdXNlIGl0LA0KPiBob3cgYWJvdXQgdGhpczoNCj4gDQo+IA0KPiBUaGUgY3Vy
cmVudCBJTUEgcnVsZXNldCBpcyBpZGVudGlmaWVkIGJ5IHRoZSB2YXJpYWJsZSAiaW1hX3J1bGVz
IiwNCj4gYW5kIHRoZSBwb2ludGVyIHN0YXJ0cyBwb2ludGluZyBhdCB0aGUgbGlzdCAiaW1hX2Rl
ZmF1bHRfcnVsZXMiLg0KDQpBZnRlciByZWFkaW5nIGl0IGFnYWluLCBtYXliZQ0KIlRoZSBjdXJy
ZW50IElNQSBydWxlc2V0IGlzIGlkZW50aWZpZWQgYnkgdGhlIHZhcmlhYmxlICJpbWFfcnVsZXMi
LA0KdGhhdCBkZWZhdWx0cyB0byAiJmltYV9kZWZhdWx0X3J1bGVzIi4nPw0KDQo+IFdoZW4gbG9h
ZGluZyBhIGN1c3RvbSBwb2xpY3kgZm9yIHRoZSBmaXJzdCB0aW1lLCB0aGUgdmFyaWFibGUgaXMN
Cj4gdXBkYXRlZCB0byBwb2ludCB0byB0aGUgbGlzdCAiaW1hX3BvbGljeV9ydWxlcyIgaW5zdGVh
ZC4gVGhhdCB1cGRhdGUNCj4gaXNuJ3QgUkNVLXNhZmUsIGFuZCBkZWFkbG9ja3MgYXJlIHBvc3Np
YmxlLg0KDQpJIHRoaW5rIHdoYXQgTWltaSB3YXMgdHJ5aW5nIHRvIHNheSBpcyB0aGF0IHlvdSBj
b3VsZCBhZGQgdGhlIGhpZ2gtbGV2ZWwNCm92ZXJ2aWV3IGFib3ZlLCBidXQga2VlcCB0aGUgZGV0
YWlscy4gU29ycnkgaWYgSSB3YXNuJ3QgY2xlYXJlciBpbiBteQ0KZWFybGllciBtZXNzYWdlcy4N
Cg0KQ29uc2lkZXIgcmUtYWRkaW5nIHlvdXIgcHJldmlvdXMgcGFyYWdyYXBoDQoiIiINCkFzIGEg
Y29uc2VxdWVuY2UsIHdoZW4gdHJhdmVyc2luZyB0aGUgcnVsZXNldCwgc29tZSBmdW5jdGlvbnMg
bGlrZSBpbWFfbWF0Y2hfcG9saWN5KCkNCm1heSBsb29wIGluZGVmaW5pdGVseSBvdmVyICJpbWFf
ZGVmYXVsdF9ydWxlcyIgYXMgbGlzdF9mb3JfZWFjaF9lbnRyeV9yY3UoKSBkb2Vzbid0DQp0ZXJt
aW5hdGUgKGFmdGVyIHRoZSB1cGRhdGUsICJpbWFfcnVsZXMiIG5vIGxvbmdlciBwb2ludHMgdG8g
dGhlIGxpc3QgaGVhZCwgc28gdGhlDQpsb29wIGNvbmRpdGlvbiBzdGF5cyBhbHdheXMgdHJ1ZSks
IGNhdXNpbmcgUkNVIHN0YWxscy4NCiIiIg0KKG5vdGU6IEkgdHdlYWtlZCBpdCBhYm92ZSwgZmVl
bCBmcmVlIHRvIGZpeCBpdCkNCj4gDQo+IEludHJvZHVjZSBhIHRlbXBvcmFyeSB2YWx1ZSBmb3Ig
ImltYV9ydWxlcyIgd2hlbiBpdGVyYXRpbmcgb3Zlcg0KPiB0aGUgcnVsZXNldCB0byBhdm9pZCB0
aGUgZGVhZGxvY2tzLg0KDQouLi4gd2hpbGUga2VlcGluZyB0aGlzIGEgc2VwYXJhdGUgcGFyYWdy
YXBoLg0KDQo+IA0KPiANCj4gU2lnbmVkLW9mZi1ieTogbGlxaW9uZyA8bGlxaW9uZ0BuZnNjaGlu
YS5jb20+DQo+IC0tLQ0KPiAgc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfcG9saWN5LmMgfCAx
NyArKysrKysrKysrKystLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyks
IDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvaW50ZWdyaXR5L2lt
YS9pbWFfcG9saWN5LmMgYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9wb2xpY3kuYw0KPiBp
bmRleCBmZDVkNDZlNTExZjEuLmU5MmIxOTdiZmQzYyAxMDA2NDQNCj4gLS0tIGEvc2VjdXJpdHkv
aW50ZWdyaXR5L2ltYS9pbWFfcG9saWN5LmMNCj4gKysrIGIvc2VjdXJpdHkvaW50ZWdyaXR5L2lt
YS9pbWFfcG9saWN5LmMNCj4gDQo+IA0KPiANCj4gVGhhbmtzDQo+IA0KPiBsaXFpb25n
