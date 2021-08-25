Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1633F74BC
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Aug 2021 14:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240348AbhHYMEm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Aug 2021 08:04:42 -0400
Received: from mail-vi1eur05on2112.outbound.protection.outlook.com ([40.107.21.112]:22849
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232681AbhHYMEl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Aug 2021 08:04:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldHa04WlXRTRYzYgOL/rJRU8FVdIw6eTGYIVZiSmTvSqWvPFJyWW3OsKfwNbc8apdV6PRni+rBFcQ0aHGo0EJ3ZmTx+Kmtm7D6gH5ZN4oO7CAaSc97WEg4r1uyEGXIvk8/NtSj+oxnRM2WPYEYyXMZLRp8pgk6g9YqsQcNcnr6jPUzr/OsGkRq/D+FK1/C5is5/Ketjv+IXeq3TCbd0tPM15XTC+9KQvNs/6igFHaiPP7KQhIwQkFJ1OayrnXMlEo3iBR75fwc91W9gwpotSuVxx16vu3QydLWAquA8ldKKx2FMd4/tuR7ezvQuT25LfOHXzVzL1PCyorHud/UPo8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwF+kXe9IO+2gWE3za1MRUb7S0EgrwntfpOqdhrI2zk=;
 b=GLqwlSmYyQZnxvsJ1S65uslBsWxH73qfslTHylmAs3ePv2Ay62JTYLQrwSgNhgvgMpKjyZFQ+ZeQRwyUOLGsrzYlKRuCzdUMq6mR3GMeYL8/L7KBrR/hA+tlGFKt8xW3Y7tt1A4OQWQija07lkoTTLmqsWTuSiNdntZtL3nR5r4ddpNDQXP6CDN5bCOuXnbsxDgsztn0dYTNgTQfVJ/dbdcz8vm1Mj7dmWq3W30n0zWrpflN2Yo2cVtyKWruBwHth1JJTOZo17Mp2s16A0xub667FVW+os3lys2MUCp/HnyiHWz3sVPhKYa62nLOA4ANtFNCNixSM4XGG/8U8sIQtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwF+kXe9IO+2gWE3za1MRUb7S0EgrwntfpOqdhrI2zk=;
 b=dBFRYErR8uTRcc/5sSUbuwvifK36/9jWRRSEiNZ734bSOwWZKr3M9YYJYR/RzalD3GSRbDGrO4VkHejQi+JB5/ZHV3vaoG4JYkDF5u27ZMkZS/lhubIQ4O0IYi8Q+yqoqGvbuzp063CgU8TJL9ACFKG9vOub4CbYebzPbs4cPkI=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB3426.eurprd09.prod.outlook.com
 (2603:10a6:208:16e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Wed, 25 Aug
 2021 12:03:50 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4457.017; Wed, 25 Aug 2021
 12:03:50 +0000
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
Thread-Index: AQHXmX+tegVBd7sMTk67aKGRvAyd76uEGmyAgAAFHAA=
Date:   Wed, 25 Aug 2021 12:03:50 +0000
Message-ID: <eb9921ff-2d4b-136f-b7a7-924e61a0651b@viveris.fr>
References: <20210819101529.28001-1-liqiong@nfschina.com>
 <20210824085747.23604-1-liqiong@nfschina.com>
 <e720e88e-ebfa-56df-6048-f2da0b8fa2a0@viveris.fr>
 <3ba4da9d-fa7b-c486-0c48-67cee4d5de6d@nfschina.com>
 <2c4f61ff68544b2627fc4a38ad1e4109184ec68a.camel@linux.ibm.com>
 <d502623a-7a49-04f8-1672-6521ceef260b@nfschina.com>
 <5a032a1b-f763-a0e4-8ea2-803872bd7174@nfschina.com>
In-Reply-To: <5a032a1b-f763-a0e4-8ea2-803872bd7174@nfschina.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nfschina.com; dkim=none (message not signed)
 header.d=none;nfschina.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b5ad39d-7e0a-42fd-c5c2-08d967c066c2
x-ms-traffictypediagnostic: AM0PR09MB3426:
x-microsoft-antispam-prvs: <AM0PR09MB3426CB9EE221CB4B5281FC2294C69@AM0PR09MB3426.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RDSw9Jg+kyKFHViH2oKeyQgJEvG6nrZ2nb2hTK7ehHTJ/jijHPoVJMqdfvxdYcXKo9/MrR/2rZyowH+pJzA2iucpt3KKpYGHIb5yezrK4coN6LwXDOG37OHYBbHpD0KrtgqvdGgalYKHujN3CO1PyQRRB898SpsXAEU4iF/Qz6kEWqeh89MECIB4qTP4T2sYenERHkLUovpiKDki6SQa4GPsBcdQn2gt/DCG8dFXyFoAkLnKuASwUAN6GWvxu9FzfxnCr+4QTvt7HDkNUGJNDTjfSXhFNCIhUMCCLjITaZRELyscVUYxZDZxj2S6owE+dj5oYP2Px45MNU8f25PNuKxMhHBh1v/XQL8eLkMj3HJn+Lczzrab6qcIy1JIdp7vYVNLUs/RqduZen+cHSF8qnc38MkfncUmUbzjdRaJNy2do2OsZG79FmodtxZaYPUsyw3aUE7L7L+GwGFpfnZOLvUG2uMEaJx/2EfXNeNE22sikGeldalpWdx6lJU2DLXvibnVQbhxFZjtROcit3WbFjcCFkTkKFhwldET12Xm+nnqIFOICKMUgRHKcZm3qPWU30MeTLAQQaykBZ01iTqR0pEYS1mOBBH9asCFzSDQ+LHQbe1sEQl+937riH60ANnVz/e+guS3JmUnVQMLBhnmOmoy4x+Yj7RxFA9Zs3X1fD6//cyfy74tQx5bP+/Zv6quAlxVtxFt8zjUWsYWc7i78V7LeQw2oJKRBGeycBCQ4pA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39840400004)(376002)(396003)(366004)(136003)(31686004)(2906002)(6486002)(38070700005)(38100700002)(91956017)(76116006)(86362001)(66946007)(478600001)(66556008)(66476007)(66446008)(64756008)(31696002)(110136005)(122000001)(83380400001)(54906003)(316002)(8676002)(186003)(2616005)(71200400001)(36756003)(6512007)(6506007)(8936002)(53546011)(5660300002)(26005)(4326008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVl6ckpDWWdXWjEvMTBBeXAwMlVaTXg2NkdvOVNhTVVRdm9TQ2w1SzYvTThE?=
 =?utf-8?B?UndFekc3TWZ4RElpMzF6aUVJM3BsTXpiZnZMRDhKamVXWFNla2JTdTY4VFlE?=
 =?utf-8?B?YlhjWDZQN3U3YXNhakl6bW0yb2Q1bSs3eWwzcWVVTzlYTHUvbXdVaDJSNWFN?=
 =?utf-8?B?TjZPaGgrVXVEcGRxQ0ZUTTVPM3IvQWtrNis3ZnZ4NlVJZW9OZ0x3QTEwd3FP?=
 =?utf-8?B?cXJDTDRGZnBKQS9na3VOMWNiZm5oQmppb1FkdVA1eERSdzBZUFpsa1cyOUlF?=
 =?utf-8?B?eVl2cXZ0U1c1SkpqZmF0MFpTdCtRekxMZTcxOW9uaS9jS3J5OHBtL3lNc0R3?=
 =?utf-8?B?L0NqYmV5TmhLdnU1SWEzL1VTUzNyOS9lYlhHalZSL1pha2lRMEVrUkpLeGJC?=
 =?utf-8?B?cUNsaTVWcTA3Q1orSkw4alBrNncwSC9xL0NSdC9kRklzNTJpNlJVVFN3VDR3?=
 =?utf-8?B?K21tU3JtK3kzZHhVZnAvbkE5SzJuNFUraVV1VXF4QTZIbU1uTmpXY3VZWXlT?=
 =?utf-8?B?bjZzankzeTc4NkcrRU1oc0NzYTE3VUhEa2J0dC83aFNBSTVKTFNERFVBc2ZE?=
 =?utf-8?B?SVlxeGEzdFpLb3RVYWUvelFrZ2tWSFBkOW1DWFFHNXVUM3d5azcvM2pSS3Jy?=
 =?utf-8?B?U1Vxc1lVNXlSQ25qS1gvREVScTVmZ1RIN0k1MnNKaXQ1YzVFTkE2bnl1Wi9l?=
 =?utf-8?B?bTRDQVA4Z1Z5UTVGL2puRTNZaktpbnplRVJ2R0hyTENJbXNoMTlrdlZwUnhm?=
 =?utf-8?B?MG1mZWhZNG5MYUkwVERIcXU5ekZ6cmFoZ1dBcFFsbTJ0ODQ4eWQ5c0lTY0xX?=
 =?utf-8?B?eHZLV1p4aUpPNTRwMTZqc0NuWjUrSjhzM2VtdG4vTWh5Y1dQTnVvRmRwa2Jo?=
 =?utf-8?B?TXFCNGRaaDhpelNDcTBrZFprdGNNU2poVklkeUJ2VmdTbUVsUFFlTHRiMzVE?=
 =?utf-8?B?QklXK3BjOTZ3Vk1kTzBIaVVOeCtRZEJmTVJuMFdCc3ExdzFuQ2V3aE9vMnN4?=
 =?utf-8?B?ZXRPY3ZZQVhFZUVhYjBvK2d3WmxCOUZrb2hNaE9Yd0k3MnN6U0RsbnFjWlJ1?=
 =?utf-8?B?ZW02TzZmb3JKa3dPYWNabS9SRDNXYnJDaldQUHhNOUtHbE5TaEtWYXlwTTdR?=
 =?utf-8?B?OG9nQ3AwRjBMQTVjUnJtWEFJbjFIT1BNQkNWaDJlTFNTTmZZam44WlVZOWFC?=
 =?utf-8?B?cnhhK1lSdjRkUDBQS3ZzY2wzVE5hMFJjRTdlWmE1cHpvb3N4dlMvSlM1UFdy?=
 =?utf-8?B?K1RYMjhQa1lydllWNC81aGs5V1M5Q0FnRDdBUUpjaFhVNmFrcXRqSE96OXk5?=
 =?utf-8?B?aXhwajRoV0NzemdLeEtIYmF6U2ZxUFo1Z2JCZWdnTElRRUJlUzRGWmpVU1ZV?=
 =?utf-8?B?Z3l0c3pnVTcyWVNuQXB6aVJ5M1F1MnZERXBhWTVUUy85aS81cDB5cS8rZ3My?=
 =?utf-8?B?ZWNPVVlyZDNVakdpV0EvaE1MQmpBMmN5d1EyY0xTbU9kRmpLOXhzOFd4UHov?=
 =?utf-8?B?cEo5MEYwWndHUnRHdm0vbUVWQzZRZFYzVWtpbFF0UU1CTkppaGFtMTNTSWJI?=
 =?utf-8?B?R1RBaUlNY2xwTExsMWR3bjZiU1k1VjJmM2FlYkI4bVZuZlRCOEJSQzA0L29L?=
 =?utf-8?B?V1NNQmpHZklmSzVOS0grNEtRSW5LbEVadXRnOWdTa29EYkRiZkI1S2MzRnZy?=
 =?utf-8?B?TUNBRVZsbHpVNDRYMFNkdURLUGpTdEh4Zy9VSnZXcHcyQ054b0ZsTm5kUG9Z?=
 =?utf-8?Q?9HsL0+cgR9yvYzfcJk6AWuDrd6JPsvR5+GwV4WP?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <08AE1318E2B5E14F87EB4B96F0A09B2A@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5ad39d-7e0a-42fd-c5c2-08d967c066c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 12:03:50.4178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RIXs4qxlM1SYPcoL3zL943NyUpWK7JZFiijdoA96EASPw1OnZblnN2BpTrCKyELv+uLrBzHFTprWylPR0oFPDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3426
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SGkgTGlxaW9uZywNCg0KT24gOC8yNS8yMSAxOjQ1IFBNLCBsaXFpb25nIHdyb3RlOg0KPiBIaSBN
aW1pLA0KPiANCj4gVGhpcyBjb3B5IG1heSBiZSBiZXR0ZXIuDQo+IA0KPiANCj4gc3ViamVjdDog
aW1hOiBmaXggZGVhZGxvY2sgd2hlbiBpdGVyYXRpbmcgb3ZlciB0aGUgaW5pdCAiaW1hX3J1bGVz
IiBsaXN0Lg0KPiANCj4gDQoNCkFzIE1pbWkgc2FpZCwgY29uc2lkZXIgYWRkaW5nIGFuIGludHJv
ZHVjaW5nIHBhcmFncmFwaCwgbGlrZToNCidUaGUgY3VycmVudCBJTUEgcnVsZXNldCBpcyBpZGVu
dGlmaWVkIGJ5IHRoZSB2YXJpYWJsZSAiaW1hX3J1bGVzIiwNCmFuZCB0aGUgcG9pbnRlciBzdGFy
dHMgcG9pbnRpbmcgYXQgdGhlIGxpc3QgImltYV9kZWZhdWx0X3J1bGVzIi4gV2hlbg0KbG9hZGlu
ZyBhIGN1c3RvbSBwb2xpY3kgZm9yIHRoZSBmaXJzdCB0aW1lLCB0aGUgdmFyaWFibGUgaXMNCnVw
ZGF0ZWQgdG8gcG9pbnQgdG8gdGhlIGxpc3QgImltYV9wb2xpY3lfcnVsZXMiIGluc3RlYWQuIFRo
YXQgdXBkYXRlDQppc24ndCBSQ1Utc2FmZSwgYW5kIGRlYWRsb2NrcyBhcmUgcG9zc2libGUuJw0K
DQo+IA0KPiBXaGVuIHRyYXZlcnNpbmcgYmFjayB0byBoZWFkLCB0aGUgaW5pdCAiaW1hX3J1bGVz
IiBsaXN0IGNhbid0IGV4aXQNCj4gaXRlcmF0aW5nIGlmICJpbWFfcnVsZXMiIGhhcyBiZWVuIHVw
ZGF0ZWQgdG8gImltYV9wb2xpY3lfcnVsZXMiLg0KPiBJdCBjYXVzZXMgc29mdCBsb2NrdXAgYW5k
IFJDVSBzdGFsbHMuIFNvIHdlIGNhbiBpbnRyb2R1Y2UgYSBkdXBsaWNhdGUNCj4gb2YgImltYV9y
dWxlcyIgZm9yIGVhY2ggImltYV9ydWxlcyIgbGlzdCBsb29wLg0KDQpQZXIgdGhlIHByb2Nlc3Mg
KHNlZSAnRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5yc3QnKSwNCnBs
ZWFzZSBwcmVmZXIgYW4gaW1wZXJhdGl2ZSBzdHlsZSAod3JpdHRlbiBpbiBhbm90aGVyIHBhcmFn
cmFwaCk6DQonSW50cm9kdWNlIGEgdGVtcG9yYXJ5IHZhbHVlIGZvciAiaW1hX3J1bGVzIiB3aGVu
IGl0ZXJhdGluZyBvdmVyIHRoZSBydWxlc2V0LicNCg0KDQpUaGFua3MsDQpTaW1vbg==
