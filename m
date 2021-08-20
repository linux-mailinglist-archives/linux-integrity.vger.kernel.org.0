Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D7E3F2D36
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Aug 2021 15:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240754AbhHTNfu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Aug 2021 09:35:50 -0400
Received: from mail-vi1eur05on2094.outbound.protection.outlook.com ([40.107.21.94]:41444
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233028AbhHTNfu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Aug 2021 09:35:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GB+gMLJz6ampFNmWqLXkQ92O6VPGM6eIhidLFWUchwvF73V591ciRFqqyew/7Io7UKmgJ7UGQjPgO493aAzEchAj11VmWYrRwMw1RMwKiAy5to4CVKdkBUMj22+mV0MuUjz+4oeEj9JEJIYZSHynN0eW+MrKznXk7BlIMPaBKzj3LKOmuef+6teq1DmxWQ22TaMkBoZ5mLZuuxYJSzzBK0jgrlkJnpNsC1N0yT71yd494dHFqdZSiBx7rFjkA/9SvIPksN4zjCtjKq0DNraZcZFc1tfJjSgZEx4jnClPYVnJQn4tsXIQYpxNUPus9OoxPlb2SE7tKFXspD9keKvJHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQ9sBbbgqVQaZEAZRvrTItA5eCkhRfYMTPczVUeL190=;
 b=TkO2bzOfyl+Z0meETyX3cw/2ThRHcy9lncMyvKZgkDSWLBUSPGlNBVzfreRc8bjYnSWWGyAQOKRdK2fgctF53MhiTzsRtIPRDDKYVzWziigG4YDjFtvPEw99JRPMI19ZI1VPoZqlxAHBb0yVQXGlqknp48xIZrZ7DfW/jmiCQsoNlQCAkMH+nWzZgffeaCi0PSpxijcbnBt0uvN9FWxQH3zJwfPoScmGKRs13QYsEXtEhvs814Fsp3ZsTg8/5kpjIiDX12SNjcnpgSeCATmXFrg9/TVEQVaE3KMCCleE+Ho5ZklO0HDHD0Nix7wGPj6vUETGZfrX2MbiUTtxq0v1Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQ9sBbbgqVQaZEAZRvrTItA5eCkhRfYMTPczVUeL190=;
 b=LskZQdkROFsGBjzvvsVa8fKf3fcEYPXeWMJ6RFnryBBmoCK3mUHq0Vd+EJVYZJAHfaqgK36w3VqvmofbnhQIerDo5ReSu9FBIQ+ANiHdy1T87CHvg2B5pNQqCuuXsq5EhE7WiNHTdOaIA0CUfeF2GZtfvcnLTifsxysLFe2VKJ4=
Received: from HE1PR0902MB1755.eurprd09.prod.outlook.com (2603:10a6:3:f2::20)
 by HE1PR0902MB1899.eurprd09.prod.outlook.com (2603:10a6:3:f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 13:35:09 +0000
Received: from HE1PR0902MB1755.eurprd09.prod.outlook.com
 ([fe80::dd95:456d:43e0:786f]) by HE1PR0902MB1755.eurprd09.prod.outlook.com
 ([fe80::dd95:456d:43e0:786f%10]) with mapi id 15.20.4436.019; Fri, 20 Aug
 2021 13:35:08 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     Igor Zhbanov <izh1979@gmail.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/1] NAX (No Anonymous Execution) LSM
Thread-Topic: [PATCH v3 0/1] NAX (No Anonymous Execution) LSM
Thread-Index: AQHXlUdQ4ZzjOiHijU6T9EsD15WwTKt8ZdMA
Date:   Fri, 20 Aug 2021 13:35:08 +0000
Message-ID: <a0e96318-9c27-f447-58f4-6b065c99e4cb@viveris.fr>
References: <adc0e031-f02d-775c-1148-e808013c1b97@gmail.com>
In-Reply-To: <adc0e031-f02d-775c-1148-e808013c1b97@gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5566bb8-d5f3-4306-54d6-08d963df541f
x-ms-traffictypediagnostic: HE1PR0902MB1899:
x-microsoft-antispam-prvs: <HE1PR0902MB189918514158846F3284E84A94C19@HE1PR0902MB1899.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ubvARyWAdGSZ7SSIrsEYGVGYlysXAwKOzK7lXQBwu8bmvCXi2SCurl8oaMkjbpwJht+3VjjtDeMv2M1dK67MJNyn6RM2p4fuAo5N792VQn9OytXKbUjZqYp92fXiG8nwDWrP/qjPUEH7wvmY3U0TaOlLCIz6XwR5jr8PS3S5BY1TymsxkTNUfkhbYXrLUAuNCJVovczuMnsYeBVUnQt3AKGKHqEat+0VvnP4BZbwIp10Ed31kR7Y885qTMLTv7P59EkZ6LdzNNT5mE6DT8D5n+ZkoFCtTOOnYCwWORrITLISWj1SbGqXCnrr5tYRyHQCIQHjjNWZu32QbjL7o3IzzYqqQFGLYBXoyoxiXcPJTW0VmYwHGDCA/E3+ORdyU9wraC9UOI1ioSVNkaEQvVTmt1Fg+27p0PSYklvSaSbllLIInofJxS7w6Jsm8BcVfqFfycnw5p2bfjeUcLbrreAYt7MQAOFwAi0TgacKjgJs1lqfmagtwcPMQ8ujYjMxhffkJe60GKutUA/+CNsWjIK2QsvGqR0QImd/TwXxjpTHpo02vb1hBJGuInCHalk1zeOLaHH2ODYkCeCnpDLgt/Wse4EERL7uPy7ePS2+5xaxR7hUQD4AQWywwQfJ+vpGZyO8V+Kw96vb8yCiLANWPJedqxUFSVFbqH7CVhye0Rm88MXWkFJKQadLgli5DTpBhl9LKOPy0RxWQlouQ3LTivJ5vegfzwpb/duWRSbfKM8KEIlqb+QI8JyG7H7Xuvu3Upbx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0902MB1755.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(376002)(396003)(39830400003)(6512007)(8936002)(36756003)(26005)(31686004)(83380400001)(8676002)(31696002)(5660300002)(38070700005)(6486002)(2906002)(71200400001)(66476007)(66556008)(64756008)(76116006)(66946007)(66446008)(86362001)(91956017)(478600001)(6506007)(38100700002)(2616005)(186003)(110136005)(316002)(122000001)(66574015)(53546011)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0xBOXlaMjhLVDZISGJuaDlVc1V2RFNpSFpIbnc2SUs2Q2xyZmlCdkFZSzBN?=
 =?utf-8?B?ZWZiMUUyRHQySkt5VUgyRUVtVmdLS2FVZzdIdnZLbEI2TTVHY2VxeFR1TVJ2?=
 =?utf-8?B?NC9BL3YyNGhpZndjL3JQbTRJYUZaSjF4dktNMWU0ZWd4NWhadGMyd3I3UGlm?=
 =?utf-8?B?c1RYclVDaWVNUUxHbERLZTFXWUg1SDF4MGRlS2pRZnVwNXpSYmVNOEUxbGhl?=
 =?utf-8?B?UHdVZjdJWFFRb2dLQ0NjcXZjenkzOVdqQjhCV1R5cUNwM241T3VwMFI4dGdJ?=
 =?utf-8?B?UjBzbGQ4ZmlPRmJZNklZckI5RFZFanN2NWFqbjI3Z1ZTMzk0c1JkcHc1bHFw?=
 =?utf-8?B?UGZaOHNwZ0xwcFQvNnpIN1BKN2o0SUVIZVUzYnN5LzZ6WHdCbFdXM2JxUDZa?=
 =?utf-8?B?TzdNb2lFMDhSWWRzREd4Z2hJaU1TOGI3emhoTmpxTHl4UExYaUpkUHFROTdQ?=
 =?utf-8?B?TzlQbk53aGpmeXNPRmR0YnpXdTlKK1NsQS9mdTV1SlNXSVl1S1ZHMkswUjdn?=
 =?utf-8?B?UmFEd3FuUGdNMzdOaVpidTRqM09CZDBrZWpma2VnRi9rekNqWGNWaU9CV1l1?=
 =?utf-8?B?WENzM1BTN2NacS9HMUNjdDQvaldRMHUvZEhFUkJoTmVxcVFmR0NZYzFsbGwv?=
 =?utf-8?B?SFJzaDR4Z0hrb3B2NU1hMnp6b1Z3RTJiVTd2Sis5Wk8rcnhqbEJHVlFuVitl?=
 =?utf-8?B?S2U3QTNWWDBLNzBDa0VBczJnVHZQSTZsOXNJcUE0MFV0QWxidk5jVHpWM1pw?=
 =?utf-8?B?SDgvbTROSkY5Rk5uNzNvWGY4T2p2b2hEVVJHdi9kZ1ZvcXRwZndkMkl4QWYw?=
 =?utf-8?B?MlQzTTZpVXY0R1lvWmJEeG8zMTJmVU1iMExxalpvYU83NDhqOUcrZ1dwdFdI?=
 =?utf-8?B?Q2Z1MVFQSk84d2N6OW1aSVF6Z3VjR0JpbEZIM0kxSWN4T1NFQ05oQTlmVG81?=
 =?utf-8?B?aDNTclF0M3B6aDQrSTVWZklrNHd6Ymc0a0ZaVHB5R01MaS9iWE1CWGxQRm5W?=
 =?utf-8?B?eE1mQ2NLRmRYcnJqcDZXWWxVdWxWNGFWN1pmOTBZZXh2aEw4a0UrNUxiSWhk?=
 =?utf-8?B?RnhXUEtoaURvYTdtUXV6cXgzeWQzTjRGTHFXYTRoTkFXaFBxVTF2NG9ZQUxr?=
 =?utf-8?B?WW1LZERLbWQrdHVXMzJJQmNxOGxmMVE3SVhodWhmREFYa2xSMCtmUnFrclph?=
 =?utf-8?B?WnB0cXJaa3grVy9Zb0FVVEpXYWg4WVFVdWxrSjZ0ajBIVG1RNEJhODNCT0hv?=
 =?utf-8?B?K1hWSmRXeVcvdE5DNkprclFVbXlnYXByKyt5SGU3M1VzYXd3MmZqNm8zMnkr?=
 =?utf-8?B?NVZyakJUaVBxM2JwRFRmL1RoUWtGY1lidVhJM01rK2tweWlnN29kMVdhdFVR?=
 =?utf-8?B?Y01LTVExclgzYWVPbksxVVlrYkF5bmJ0QytmamVFanp0c3UwWHNaR3lsRllU?=
 =?utf-8?B?NG82QWFZbUtWZ3dSV2U5R040YmY1WC9VcVJOYVluQ0tsZUpJQWJ4d3o4dGdD?=
 =?utf-8?B?OFFQS1hHYXh2YmxreFlONkFBRTN5WmtDN01BdTVVbTI5alhYVklWYkZEeGo4?=
 =?utf-8?B?blNhdTdKckU3eDcxcWVTMnhiVDczQjhCVFArdFQ3UnBJWTBnd1VnSDhJMXRJ?=
 =?utf-8?B?RDRKTmQvbDE0VzVEeXBsOU4xUFQ2WVZpR2RJaFdyOXdoWFhWRFcrZkZZRDVV?=
 =?utf-8?B?Q2Uwb3FkVGxtanhsaThvaHNOZW1CRXp1aXRqT3pIa0tuM1hJc3BiOEdRQk5v?=
 =?utf-8?Q?0YTAfa4+XFb7SCpxD/JgQbb+idpjsTrjIpvMVEH?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB70BE26BB238A40BB09C041D02C80E5@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0902MB1755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5566bb8-d5f3-4306-54d6-08d963df541f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 13:35:08.7463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6EPcGmqWI80UO7Ra2dqNP/5sgrPxEOBT3CBpFVZVRDp2JrT6l/TTQfHs5riaaXbm7KpVbkAdxGI29iGbBHTSNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0902MB1899
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SGkgSWdvciwNCg0KT24gOC8yMC8yMSAxMjoxMiBBTSwgSWdvciBaaGJhbm92IHdyb3RlOg0KPiBb
T3ZlcnZpZXddDQo+IA0KPiBGaWxlbGVzcyBtYWx3YXJlIGF0dGFja3MgYXJlIGJlY29taW5nIG1v
cmUgYW5kIG1vcmUgcG9wdWxhciwgYW5kIGV2ZW4NCj4gcmVhZHktdG8tdXNlIGZyYW1ld29ya3Mg
YXJlIGF2YWlsYWJsZSBbMV0sIFsyXSwgWzNdLiBUaGV5IGFyZSBiYXNlZCBvbg0KPiBydW5uaW5n
IG9mIHRoZSBtYWx3YXJlIGNvZGUgZnJvbSBhbm9ueW1vdXMgZXhlY3V0YWJsZSBtZW1vcnkgcGFn
ZXMgKHdoaWNoDQo+IGFyZSBub3QgYmFja2VkIGJ5IGFuIGV4ZWN1dGFibGUgZmlsZSBvciBhIGxp
YnJhcnkgb24gYSBmaWxlc3lzdGVtLikgVGhpcw0KPiBhbGxvd3MgZWZmZWN0aXZlbHkgaGlkaW5n
IG1hbHdhcmUgcHJlc2VuY2UgaW4gYSBzeXN0ZW0sIG1ha2luZyBmaWxlc3lzdGVtDQo+IGludGVn
cml0eSBjaGVja2luZyB0b29scyB1bmFibGUgdG8gZGV0ZWN0IHRoZSBpbnRydXNpb24uDQo+IA0K
DQpbc25pcF0NCg0KPiANCj4gW1RPRE9dDQo+IC0gSW1wbGVtZW50IHhhdHRycyBzdXBwb3J0IGZv
ciBtYXJraW5nIHByaXZpbGVnZWQgYmluYXJpZXMgb24gYSBwZXItZmlsZQ0KPiAgIGJhc2lzLg0K
DQpJZi93aGVuIHlvdSBwbGFuIHRvIGFkZCB0aGF0LCBhZGRpbmcgdGhlIG5ldyB4YXR0ciB0byB0
aGUgbGlzdCBvZiBFVk0tcHJvdGVjdGVkIHhhdHRycw0KbWF5IGJlIHdvcnRoIGRpc2N1c3Npbmcu
DQoNCj4gLSBTdG9yZSBOQVggYXR0cmlidXRlcyBpbiB0aGUgcGVyLXRhc2sgTFNNIGJsb2IgdG8g
aW1wbGVtZW50IHNwZWNpYWwNCj4gICBsYXVuY2hlcnMgZm9yIHRoZSBwcml2aWxlZ2VkIHByb2Nl
c3Nlcywgc28gYWxsIG9mIHRoZSBjaGlsZHJlbiBwcm9jZXNzZXMNCj4gICBvZiBzdWNoIGEgbGF1
bmNoZXIgd291bGQgYmUgYWxsb3dlZCB0byBoYXZlIGFub255bW91cyBleGVjdXRhYmxlIHBhZ2Vz
DQo+ICAgKGJ1dCBub3QgdG8gZ3JhbmRjaGlsZHJlbikuDQo+IA0KDQpbc25pcF0NCg0KT3ZlcmFs
bCBJJ20gcGxlYXNlZCB0byBzZWUgdGhpcyBwYXRjaCBhbmQgSSBoYXZlIG5vIG1vcmUgcmVtYXJr
cywNCm91dHNpZGUgb2YgdGhlIGZldyBwb2ludHMgUmFuZHkgRHVubGFwIHJhaXNlZC4NCg0KUmV2
aWV3ZWQtYnk6IFRIT0JZIFNpbW9uIDxTaW1vbi5USE9CWUB2aXZlcmlzLmZyPg0KDQpUaGFua3Ms
DQpTaW1vbg==
