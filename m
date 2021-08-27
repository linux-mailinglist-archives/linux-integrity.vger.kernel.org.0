Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13EE63F96C4
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Aug 2021 11:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244602AbhH0JVl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Aug 2021 05:21:41 -0400
Received: from mail-eopbgr70093.outbound.protection.outlook.com ([40.107.7.93]:9540
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232282AbhH0JVk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Aug 2021 05:21:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XysnxgleyI6Im7BdX/+WVozkVmT5J+jznRJas8MilwEYc77mxNFq3JwaDJpXj/8rKA2gypN7JNadgBITms/N/uVTjp24BBmMLom8rFpWVDnQjECZrf+SzseY5Z8dBZF3XvcifGPPTupUkrhGNJXUxkmsBSnqFJZiB4bzW3stY5Hr6BpiM5GPdbLnOgqaLRdHS9J7Oxy+93WeyM8pif06odfCjfprPMRed1exKB5teUIJCW9nwGveg8QjOHuK3deFt0FcJ98cQFKNCgiOLS9PxBACX0HGyeYfjuq8KQ2gMpOlKws9RBSyr1hZVFNbTJTevZ6xKG5qOR584fp1cFrdoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8B2r30Ru6cgRJ7E6VuRoToB3+5o2ZtqEKR7NGlWt78=;
 b=R6+nfmrpj4hMLD0H0328oz9IItI3YZpZ38sueVHXqKp3MgrU45C/SLv34GpA3wzv3H01XkBHaAgMY/bQGNIzY1SWkWsZa+Wu4JBeJRsP1mtGhr8wcWvQPv2oZrS7srcwY4afn3AyF6Oz4e1j9ol4pTIDDx8gje0gjhYSMTtxZcWBl74ldiYjHr2IFjHBKdT0g3uyaPt261lzfl46gbGIoqrPUHxbfwkrGF51aJzhkvbwAJaXZWFy38Iw0KtahZSm5995gRRxdVik1q9PcFVJ608TTqQ6S3wK6jcC/glQLBDVx+UxIVzLjiYJuo790ML1zH+9RY/0W5GKWEGtqep5qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8B2r30Ru6cgRJ7E6VuRoToB3+5o2ZtqEKR7NGlWt78=;
 b=4a+P3AipMCHGFvbO4I/8DSRB1Y3N8FQ/82y0l7/UFN1FcJu+r7OoLYdQ2nAJgB6m1cJNUZj9SqfMgOKpBND7oqN0qSCVQtmSOYEvX/CmH0IUor3Nga62kKCGmv7654OfGqkwH69Dfn9wBKtnByqnrMS2IqGAeu7RTOAjyDn1QYY=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB2548.eurprd09.prod.outlook.com
 (2603:10a6:208:e0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Fri, 27 Aug
 2021 09:20:49 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4457.017; Fri, 27 Aug 2021
 09:20:48 +0000
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
Thread-Index: AQHXmX+tegVBd7sMTk67aKGRvAyd76uEGmyAgAAFHACAAVKggIAADJCAgAFrhQCAAA20gIAAG+QAgAAC0AA=
Date:   Fri, 27 Aug 2021 09:20:48 +0000
Message-ID: <13c503f9-3a21-e92f-9930-76418d31956d@viveris.fr>
References: <20210819101529.28001-1-liqiong@nfschina.com>
 <20210824085747.23604-1-liqiong@nfschina.com>
 <e720e88e-ebfa-56df-6048-f2da0b8fa2a0@viveris.fr>
 <3ba4da9d-fa7b-c486-0c48-67cee4d5de6d@nfschina.com>
 <2c4f61ff68544b2627fc4a38ad1e4109184ec68a.camel@linux.ibm.com>
 <d502623a-7a49-04f8-1672-6521ceef260b@nfschina.com>
 <5a032a1b-f763-a0e4-8ea2-803872bd7174@nfschina.com>
 <eb9921ff-2d4b-136f-b7a7-924e61a0651b@viveris.fr>
 <1e464ae0-28e1-6511-ab89-52b5cd1a0841@nfschina.com>
 <3ef6906b-ccf1-0ab8-180b-b71568e22443@viveris.fr>
 <bd52af5b-6c69-73a1-e0b2-8d23f3d8db3a@nfschina.com>
 <caa4955e-04d9-d3f8-cccb-5f78bd554c55@viveris.fr>
 <266c50d0-1efd-dc45-d11f-e8c91bfc8490@nfschina.com>
In-Reply-To: <266c50d0-1efd-dc45-d11f-e8c91bfc8490@nfschina.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nfschina.com; dkim=none (message not signed)
 header.d=none;nfschina.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1794166-6c59-4ba7-9441-08d9693bf54b
x-ms-traffictypediagnostic: AM0PR09MB2548:
x-microsoft-antispam-prvs: <AM0PR09MB2548E26BBAA872B858E199C894C89@AM0PR09MB2548.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xUoma6evPxxvrRBnub9oDUXNdOWAlM6L6I+UW1KHgSB7AESOb9zFXHdLuZQJBewnsgfr17AyS7U/LNZc6lTElenXUyYWm2vYscl2jckQonCqwJe91otG5OQkuEOs9Z9QH1zO8K1PAfkYomA645yZdP0uQATYBnUIylYOsK2KB/r808Pq5EACB+geakQlyrPgfNstOIWGGFSrAhYJhVQTZ5o8HsGBRaCNH80UxMewSZ1XdUPMXUlM3Plr+zo4RLo4+xCXoSyPbuwX6KN1E/3Ud/mJRy60crG2kecYorSXJgMnzYa03M4YlF837BQ3CDzSWQvmFEiSBPA8mpGudOtFQRXSTEqxiUFsrCwqZrO2AjJ0vk1tkSTeOQG14b3KWkzuemOj2KlgrvCe7CMrFGKLJzuruEm52jmwVSEGSSY/BGaIh5P380j91XGsbe9RNpFa6EYREbB6xhk0JmWguDFdTABG0jEnFImeDxUy6Tyil5KHixiOtZCIgMLLiGxTIffQKh/He7CM4XctJSrqqiV1NI1s8XuuDfe8xvPD7zrHXIsFOV4rxiTLifjuLuuIYgiDdCiZvS9H3bRvQB3t8g4D7gJoffRa+vq94LD6ZJE4O5uKoUaMzDV+aJdEoAXB0Yv9duaIC558shdsopaE2+7gwubufDQOW0s/hhNSaIejiA4Xa+8LfF4PDqfJI3NyjF2ldSELGoxY1G5hd5mQgCbLwWNOKL4gzN3L+P/iqN1aVz9BlPAbao+6bftNofOwYjt2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39840400004)(396003)(136003)(376002)(122000001)(91956017)(110136005)(478600001)(64756008)(66556008)(26005)(71200400001)(316002)(66446008)(66946007)(2906002)(66476007)(6486002)(83380400001)(86362001)(31686004)(4326008)(38070700005)(2616005)(5660300002)(31696002)(6506007)(8936002)(36756003)(6512007)(76116006)(186003)(8676002)(53546011)(38100700002)(54906003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFF2WExFNmMwcGxOT05DblpqQzVyWTl5ZDd0RUpzVXhIcVU0TTZqWlZCSWdV?=
 =?utf-8?B?ZmU0OWN1V2dETHgrOThqUHZ3bTBVTDhNaHJLeVd5U0lLdytDMU81UzNnZTcv?=
 =?utf-8?B?aUg3TEkrdnFldDIxUm83RTQxSFpDM1QvVnROeEkxRC9GRHhCUGxvSSs4UGVC?=
 =?utf-8?B?cXRiOGxickM5RkgxU29DekR3TEt6OGl1eWllYTFVWURwdXNDSnM1VGlCWTc5?=
 =?utf-8?B?YitWSlZFUDVCclpNT1JBSjh1eTFFSG1vdFB5S2J0RFBFWm9QL3JEVGRjQm1x?=
 =?utf-8?B?UnlneGRnZkJ3MlZrYnllQ1ZFVVBkMkZucUE0ZDkxOUdXOXprN3RUV1IvMXNp?=
 =?utf-8?B?ODRPa0ZaZ2ZpSmNjN2tWcHZqaHRibmdqOVZWZ2kvR3ExRkMwME5MUzBxdWFa?=
 =?utf-8?B?QjV2alQ2QXIvNHh2M3Y5eXdVeU1rNEMwY0Q3dXNiVUFZWVAvbWdna0JiRWh5?=
 =?utf-8?B?K0NPT29yZkFCSk1yNFlRSDU2aktrZHlLY0VPd0ZTWTM2eHlMbGp6T0FTb2V3?=
 =?utf-8?B?Qk1iSUwxTjZpRFVRQy9mNFlyUmFSVVFsWCtKM1U2YzBLOEw5RUJPdnRZRWhB?=
 =?utf-8?B?RTVOb3dvUFRWZGM3SUdJKzQ3Q3hOT0JlOXVXVDd3L01oRTc3L2E0UmdPdnBP?=
 =?utf-8?B?NVlLaENkM3pZWWQvVWhuZFNwQVZBRXg1Y0VSdHVFS3R4MlROTGd0aC9XY3kw?=
 =?utf-8?B?TVByU3E5ZERDcVVCT3ZzNWZEZFV3bzFCZmFtL05oc25lYkUwUUhqQ000RFNE?=
 =?utf-8?B?SXhXY2NlUlN1YnI2Q1U0WEp4dGM5bzFCNVVhWVM0MWUyOHpqYlArK1dwcFJL?=
 =?utf-8?B?a1AyZkhCZ3Q2Mi9jYkJhSHY4UG1xL0E5WS9IWFY3eXBkbTlWUmE5eGNkSTRV?=
 =?utf-8?B?dlNOdGErc3BLcCtLNG9lQzFJQ1plb1JTbXpCRmo0UnFIWkJRbHZNaWFUYjhB?=
 =?utf-8?B?OHRMRXd3bTRrQUFQcHBWNjFLbnRtcXdwVml0SFNBcCtUV2hWL1FZM1ZWTDZa?=
 =?utf-8?B?cnNGQ1VjckJ1UTdOZHp6RVVlanVTSkpQTlVlczJQZUNnUFdOc3VHYmYyUkJL?=
 =?utf-8?B?WWxORjh4cTBwbWk5aUZMNEdXck9KNGxGOWZTUVVKbUJnSlVOdDNydTVuWkl2?=
 =?utf-8?B?eGFxUzdVUCtvODM5ZDg2ZFhoYklnYXkyaklwMk9PTEdjU0V0MVRVVDJ0b3pq?=
 =?utf-8?B?UUZranozWGFmQU5RbTFzaFNaME9hQ2FPcXBGMXJrNmN6VHlSaG52UjB3VEFw?=
 =?utf-8?B?NUYwbi95K2Z4NUdnelRMN1JKekdhYnpXSi8vaGtPU0lZMUlFNFpSZ0lsMTYw?=
 =?utf-8?B?MFNLcTR4TkhMUjVnNkREL0ptc2VPbDlQS042M2p5Sm5HUDVjQnZBdUpOVm9K?=
 =?utf-8?B?dmNJRVNTLzZBTXVFeHMrNWNUM3lqYmJ2WUQ5aDNob2Q1aGphc1laY1VndWVq?=
 =?utf-8?B?RjJpRnA4SHJ2M21ZZk1kbkl5VUhFWmNlZHRQbXNodUxzNmZIcFdNVFJqMWgx?=
 =?utf-8?B?MDlWUVhBbzg5STByZ3JqOGtydVNyQm1zZlNrdXprVDM2MWYrNEhEUmkvQzNS?=
 =?utf-8?B?cEJSbWgydDJ1Z1JzK1pLdXdBVG14dnJjbnNzU1IxaVVFZTNjbHh1elF5VzY4?=
 =?utf-8?B?RmhZVS83V2FqcFQ5NmdBTXZTVWZrMHNIM0xIQm5VMHh3QzVXWGg2WWxoMFM4?=
 =?utf-8?B?T2Qyem5ZL1hRVHFUdm9mTFZQSVRoamV1M0hZVjZiWWxPdzZreENxU21WQ014?=
 =?utf-8?Q?DPzPkFXlszFeInDkJBvhFshYCf6vjVThLYbfKMw?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <692DEA8B1C077F47A3C75152E8E1D9DA@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1794166-6c59-4ba7-9441-08d9693bf54b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2021 09:20:48.8014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /dDWh0WWFTXJF6s2W2Zi+3qaNSDZ5LfZhSVGN6hVTnkgvDDxVEU8SV8brDffSEu7M4Bkgg8A9Rdft/0qkEL05Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB2548
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

T24gOC8yNy8yMSAxMToxMCBBTSwgbGlxaW9uZyB3cm90ZToNCj4gSGkgU2ltb24sDQo+IA0KPiBU
aGFua3MgZm9yIHlvdXIgcGF0aWVudCwgaSBsZWFybiBhIGxvdC4gSWYgdGhlIGNvbW1pdCBtZXNz
YWdlDQo+IGRvZXMgd29yaywgaSB3b3VsZCByZXN1Ym1pdCB0aGUgcGF0Y2guICBIZXJlIGlzIHRo
ZSB3aG9sZSBwYXRjaDoNCj4gDQo+IA0KPiBUaGUgY3VycmVudCBJTUEgcnVsZXNldCBpcyBpZGVu
dGlmaWVkIGJ5IHRoZSB2YXJpYWJsZSAiaW1hX3J1bGVzIg0KPiB0aGF0IGRlZmF1bHQgdG8gIiZp
bWFfZGVmYXVsdF9ydWxlcyIuIFdoZW4gbG9hZGluZyBhIGN1c3RvbSBwb2xpY3kNCj4gZm9yIHRo
ZSBmaXJzdCB0aW1lLCB0aGUgdmFyaWFibGUgaXMgdXBkYXRlZCB0byAiJmltYV9wb2xpY3lfcnVs
ZXMiDQo+IGluc3RlYWQuIFRoYXQgdXBkYXRlIGlzbid0IFJDVS1zYWZlLCBhbmQgZGVhZGxvY2tz
IGFyZSBwb3NzaWJsZS4NCj4gSW5kZWVkLCBzb21lIGZ1bmN0aW9ucyBsaWtlIGltYV9tYXRjaF9w
b2xpY3koKSBtYXkgbG9vcCBpbmRlZmluaXRlbHkNCj4gd2hlbiB0cmF2ZXJzaW5nICJpbWFfZGVm
YXVsdF9ydWxlcyIgd2l0aCBsaXN0X2Zvcl9lYWNoX2VudHJ5X3JjdSgpLg0KPiANCj4gV2hlbiBp
dGVyYXRpbmcgb3ZlciB0aGUgZGVmYXVsdCBydWxlc2V0IGJhY2sgdG8gaGVhZCwgaWYgdGhlIGxp
c3QNCj4gaGVhZCBpcyAiaW1hX2RlZmF1bHRfcnVsZXMiLCBhbmQgImltYV9ydWxlcyIgaGF2ZSBi
ZWVuIHVwZGF0ZWQgdG8NCj4gIiZpbWFfcG9saWN5X3J1bGVzIiwgdGhlIGxvb3AgY29uZGl0aW9u
ICgmZW50cnktPmxpc3QgIT0gaW1hX3J1bGVzKQ0KPiBzdGF5cyBhbHdheXMgdHJ1ZSwgdHJhdmVy
c2luZyB3b24ndCB0ZXJtaW5hdGUsIGNhdXNpbmcgYSBzb2Z0IGxvY2t1cA0KPiBhbmQgUkNVIHN0
YWxscy4NCj4gDQo+IEludHJvZHVjZSBhIHRlbXBvcmFyeSB2YWx1ZSBmb3IgImltYV9ydWxlcyIg
d2hlbiBpdGVyYXRpbmcgb3Zlcg0KPiB0aGUgcnVsZXNldCB0byBhdm9pZCB0aGUgZGVhZGxvY2tz
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogbGlxaW9uZyA8bGlxaW9uZ0BuZnNjaGluYS5jb20+DQo+
IC0tLQ0KPiAgc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfcG9saWN5LmMgfCAxNyArKysrKysr
KysrKystLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDUgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfcG9s
aWN5LmMgYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9wb2xpY3kuYw0KPiBpbmRleCBmZDVk
NDZlNTExZjEuLmU5MmIxOTdiZmQzYyAxMDA2NDQNCj4gLS0tIGEvc2VjdXJpdHkvaW50ZWdyaXR5
L2ltYS9pbWFfcG9saWN5LmMNCj4gKysrIGIvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfcG9s
aWN5LmMNCj4gQEAgLTY2MiwxMiArNjYyLDE0IEBAIGludCBpbWFfbWF0Y2hfcG9saWN5KHN0cnVj
dCB1c2VyX25hbWVzcGFjZSAqbW50X3VzZXJucywgc3RydWN0IGlub2RlICppbm9kZSwNCj4gIHsN
Cj4gIAlzdHJ1Y3QgaW1hX3J1bGVfZW50cnkgKmVudHJ5Ow0KPiAgCWludCBhY3Rpb24gPSAwLCBh
Y3RtYXNrID0gZmxhZ3MgfCAoZmxhZ3MgPDwgMSk7DQo+ICsJc3RydWN0IGxpc3RfaGVhZCAqaW1h
X3J1bGVzX3RtcDsNCj4gIA0KPiAgCWlmICh0ZW1wbGF0ZV9kZXNjICYmICEqdGVtcGxhdGVfZGVz
YykNCj4gIAkJKnRlbXBsYXRlX2Rlc2MgPSBpbWFfdGVtcGxhdGVfZGVzY19jdXJyZW50KCk7DQo+
ICANCj4gIAlyY3VfcmVhZF9sb2NrKCk7DQo+IC0JbGlzdF9mb3JfZWFjaF9lbnRyeV9yY3UoZW50
cnksIGltYV9ydWxlcywgbGlzdCkgew0KPiArCWltYV9ydWxlc190bXAgPSByY3VfZGVyZWZlcmVu
Y2UoaW1hX3J1bGVzKTsNCj4gKwlsaXN0X2Zvcl9lYWNoX2VudHJ5X3JjdShlbnRyeSwgaW1hX3J1
bGVzX3RtcCwgbGlzdCkgew0KPiAgDQo+ICAJCWlmICghKGVudHJ5LT5hY3Rpb24gJiBhY3RtYXNr
KSkNCj4gIAkJCWNvbnRpbnVlOw0KPiBAQCAtOTE5LDggKzkyMSw4IEBAIHZvaWQgaW1hX3VwZGF0
ZV9wb2xpY3kodm9pZCkNCj4gIA0KPiAgCWlmIChpbWFfcnVsZXMgIT0gcG9saWN5KSB7DQo+ICAJ
CWltYV9wb2xpY3lfZmxhZyA9IDA7DQo+IC0JCWltYV9ydWxlcyA9IHBvbGljeTsNCj4gIA0KPiAr
CQlyY3VfYXNzaWduX3BvaW50ZXIoaW1hX3J1bGVzLCBwb2xpY3kpOw0KPiAgCQkvKg0KPiAgCQkg
KiBJTUEgYXJjaGl0ZWN0dXJlIHNwZWNpZmljIHBvbGljeSBydWxlcyBhcmUgc3BlY2lmaWVkDQo+
ICAJCSAqIGFzIHN0cmluZ3MgYW5kIGNvbnZlcnRlZCB0byBhbiBhcnJheSBvZiBpbWFfZW50cnlf
cnVsZXMNCj4gQEAgLTE2NDksOSArMTY1MSwxMSBAQCB2b2lkICppbWFfcG9saWN5X3N0YXJ0KHN0
cnVjdCBzZXFfZmlsZSAqbSwgbG9mZl90ICpwb3MpDQo+ICB7DQo+ICAJbG9mZl90IGwgPSAqcG9z
Ow0KPiAgCXN0cnVjdCBpbWFfcnVsZV9lbnRyeSAqZW50cnk7DQo+ICsJc3RydWN0IGxpc3RfaGVh
ZCAqaW1hX3J1bGVzX3RtcDsNCj4gIA0KPiAgCXJjdV9yZWFkX2xvY2soKTsNCj4gLQlsaXN0X2Zv
cl9lYWNoX2VudHJ5X3JjdShlbnRyeSwgaW1hX3J1bGVzLCBsaXN0KSB7DQo+ICsJaW1hX3J1bGVz
X3RtcCA9IHJjdV9kZXJlZmVyZW5jZShpbWFfcnVsZXMpOw0KPiArCWxpc3RfZm9yX2VhY2hfZW50
cnlfcmN1KGVudHJ5LCBpbWFfcnVsZXNfdG1wLCBsaXN0KSB7DQo+ICAJCWlmICghbC0tKSB7DQo+
ICAJCQlyY3VfcmVhZF91bmxvY2soKTsNCj4gIAkJCXJldHVybiBlbnRyeTsNCj4gQEAgLTE2NzAs
NyArMTY3NCw4IEBAIHZvaWQgKmltYV9wb2xpY3lfbmV4dChzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZv
aWQgKnYsIGxvZmZfdCAqcG9zKQ0KPiAgCXJjdV9yZWFkX3VubG9jaygpOw0KPiAgCSgqcG9zKSsr
Ow0KPiAgDQo+IC0JcmV0dXJuICgmZW50cnktPmxpc3QgPT0gaW1hX3J1bGVzKSA/IE5VTEwgOiBl
bnRyeTsNCj4gKwlyZXR1cm4gKCZlbnRyeS0+bGlzdCA9PSAmaW1hX2RlZmF1bHRfcnVsZXMgfHwN
Cj4gKwkJJmVudHJ5LT5saXN0ID09ICZpbWFfcG9saWN5X3J1bGVzKSA/IE5VTEwgOiBlbnRyeTsN
Cj4gIH0NCj4gIA0KPiAgdm9pZCBpbWFfcG9saWN5X3N0b3Aoc3RydWN0IHNlcV9maWxlICptLCB2
b2lkICp2KQ0KPiBAQCAtMTg3Miw2ICsxODc3LDcgQEAgYm9vbCBpbWFfYXBwcmFpc2Vfc2lnbmF0
dXJlKGVudW0ga2VybmVsX3JlYWRfZmlsZV9pZCBpZCkNCj4gIAlzdHJ1Y3QgaW1hX3J1bGVfZW50
cnkgKmVudHJ5Ow0KPiAgCWJvb2wgZm91bmQgPSBmYWxzZTsNCj4gIAllbnVtIGltYV9ob29rcyBm
dW5jOw0KPiArCXN0cnVjdCBsaXN0X2hlYWQgKmltYV9ydWxlc190bXA7DQo+ICANCj4gIAlpZiAo
aWQgPj0gUkVBRElOR19NQVhfSUQpDQo+ICAJCXJldHVybiBmYWxzZTsNCj4gQEAgLTE4NzksNyAr
MTg4NSw4IEBAIGJvb2wgaW1hX2FwcHJhaXNlX3NpZ25hdHVyZShlbnVtIGtlcm5lbF9yZWFkX2Zp
bGVfaWQgaWQpDQo+ICAJZnVuYyA9IHJlYWRfaWRtYXBbaWRdID86IEZJTEVfQ0hFQ0s7DQo+ICAN
Cj4gIAlyY3VfcmVhZF9sb2NrKCk7DQo+IC0JbGlzdF9mb3JfZWFjaF9lbnRyeV9yY3UoZW50cnks
IGltYV9ydWxlcywgbGlzdCkgew0KPiArCWltYV9ydWxlc190bXAgPSByY3VfZGVyZWZlcmVuY2Uo
aW1hX3J1bGVzKTsNCj4gKwlsaXN0X2Zvcl9lYWNoX2VudHJ5X3JjdShlbnRyeSwgaW1hX3J1bGVz
X3RtcCwgbGlzdCkgew0KPiAgCQlpZiAoZW50cnktPmFjdGlvbiAhPSBBUFBSQUlTRSkNCj4gIAkJ
CWNvbnRpbnVlOw0KPiAgDQo+IA0KDQpSZXZpZXdlZC1CeTogVEhPQlkgU2ltb24gPFNpbW9uLlRI
T0JZQHZpdmVyaXMuZnI+
