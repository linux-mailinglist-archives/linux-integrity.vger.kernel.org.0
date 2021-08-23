Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EC33F4672
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Aug 2021 10:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbhHWIP3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Aug 2021 04:15:29 -0400
Received: from mail-eopbgr80109.outbound.protection.outlook.com ([40.107.8.109]:54689
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235316AbhHWIP3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Aug 2021 04:15:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXV2ryHNnWummhaPN985XudrVluCdV+QlX2FjPAPmmzUmJSrZsxZYio5+Cu8mgEX6V8WPRnGqCGMg6oBm+mZy8WPeJWUGfR732qdit/bC+1gxBWlMKXOxByz7t0nG/rJZEWOmub8OWR0R/ERNWAyCpKxiYkilzRvdlWKjWUCVY02JVwb9HAnQ0PUWihdxRc2kojczgv3N487fRLYhlUQb1zZvKUuWHj8W9fQzlC+Tb/xbleHPkXlWG7F9IHneqOm1UlqxnANQO6Er0pVoTGZLZFCf9gnRae+3+GHfzE4QJEeZ1U7MEF6gVGEpLFpkbwtxBtsU+Ly9VIps6PcEOmF7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tw4kz3LKaDvgvYo2NNwVRob/VNkU4czRxuXkXo9wQhU=;
 b=UMzEKj3DCwddlHnmq8fNGesZ7MCOYwqwJiblow4uASUgq03LAXkeXRqPk04UfPS61RnPHCwdEbeEvsQFNIonZANQjDUpXGchVv88PpiF3z98Ocm2W3R0TPOtBOqf7kGN4hGZJI4i/rWG/Qd4g9eBXzL4upf3DMxPxvCmGjmTQxLiqsyoWkJ8kpvki9V8QnnipKmK9MzaDmilE/FxyJ/21NgAH4jo9Dl7NqypdzR0rJ5UiNgIVxsUzCvl+gt+SeiNmt4SsxC6gv2leR5tduhw++fzmR1G2HSqJYbzAG6Uc1xevVgSAV1/2ehdZ1pIoMRn5NM6Fg3NG0whIaiEMU1Gfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tw4kz3LKaDvgvYo2NNwVRob/VNkU4czRxuXkXo9wQhU=;
 b=N5sDW0l8guX68tb0i/ss1R9fuV1rvbhWnehd1mkeY4JgBV/REJnKWKXPQmluEaq1vSmB2fnoZ1oMZ2DtimDqGxIZ/B+bVimztcSUW4iQyMP7O3RxcfFGGvAI9tCQh0ToVy+MUXfFKuTcZkfXs2N9/fdUX0fVjcc5Srwej0m8vK8=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM9PR09MB4612.eurprd09.prod.outlook.com
 (2603:10a6:20b:2da::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Mon, 23 Aug
 2021 08:14:44 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 08:14:44 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     liqiong <liqiong@nfschina.com>, Mimi Zohar <zohar@linux.ibm.com>
CC:     "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: fix infinite loop within "ima_match_policy"
 function.
Thread-Topic: [PATCH] ima: fix infinite loop within "ima_match_policy"
 function.
Thread-Index: AQHXlPnZCsK5CNi7NkWxUIAyoKg2DKt8LpyAgAA0rYCAAChigIAD4XiAgABUhACAAAJBAA==
Date:   Mon, 23 Aug 2021 08:14:44 +0000
Message-ID: <cf715a40-b255-c688-578c-7f8bcd004ee3@viveris.fr>
References: <20210819101529.28001-1-liqiong@nfschina.com>
 <8d17f252-4a93-f430-3f25-e75556ab01e8@viveris.fr>
 <d385686b-ffa5-5794-2cf2-b87f2a471e78@nfschina.com>
 <1f631c3d-5dce-e477-bfb3-05aa38836442@viveris.fr>
 <96037695de6125c701889c168550def278adfd4b.camel@linux.ibm.com>
 <f9798484-7090-0ddf-50a6-7c7c5bf0606c@nfschina.com>
 <fee498ec-087c-b52d-102c-d29d98f9b794@nfschina.com>
In-Reply-To: <fee498ec-087c-b52d-102c-d29d98f9b794@nfschina.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nfschina.com; dkim=none (message not signed)
 header.d=none;nfschina.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 927ba316-b47b-4c32-d6b7-08d9660e10d6
x-ms-traffictypediagnostic: AM9PR09MB4612:
x-microsoft-antispam-prvs: <AM9PR09MB46129E85C98C6FB1E23F43C394C49@AM9PR09MB4612.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gzpAKElwdtB2sLC/yrH8inb6j6pW7LQaA5aG8IEjGATjW0PKo27m81rpex9QY4oNcmYjVRcueakx3NURu98mLmY0J0sIOfamf47BCvXnu0/ucwxw2iKwKYVPHgofH1WmzlDBNSSHXYorLCzUPzDGvwbiKIm635f496wjflic5yRGLaj2gBBMJf/AOcUpbvYm6jQdeCynef4nmCVFyJO7L6hQxG2/n70xvjMt50QZWBhSmi5IUD6vW/l0cIyanczkgoiOZiQKVTomAba9IOjqmmnQj0ZVQOwkNjEJGBuX0EuxSgc3pQtv71ZyIODmbDMlpZz30/oqWSc7cWvHDv8a42UreD00ye4wleR1JXYwCduk7HSGdfae1qwBTFUOLvHoGsdjuPQzDD63ITACe+pvor2XYF7+6nqKsgeu7fji+jBaan3KsEEiN6sXuAUpwrAH6RMN0Kbye0lu9MVHpWCZlDhFRABczg/ZhqVUU5ci/VLx4q066maeF4ugDXHwszVFaVFc6yGAJYpmKP+35dQhdRBdy2wkQ1lUwfJij+ftvY+IeWYc8NBEttnfT8PCMqYhOUiYBXCgUYmDahmOBvbXYNcm+zOtoccFr9Xr7aQaempo0HtnN8vB+m8yyZjTMVyVhf6H0LzBbfe2srJCu1+gLjO3HY7J4Otv3TN8rx8gdi4uLaJIcsFgfgutAM90QAGoYBrcN7NwEvHGl0riwkx8oDO+zP+u+RBsbOnsQJ9CKaQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(136003)(346002)(39840400004)(36756003)(66476007)(71200400001)(478600001)(66556008)(6486002)(110136005)(6506007)(64756008)(5660300002)(316002)(66446008)(54906003)(2616005)(4326008)(31686004)(38100700002)(53546011)(8676002)(91956017)(66946007)(76116006)(122000001)(2906002)(86362001)(31696002)(8936002)(6512007)(186003)(26005)(38070700005)(83380400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RW1FdHc4TE11SUphKy9kdTkvaEZaRnM4eU40ZStuZUgrRUJPOWJHTXhZNWp6?=
 =?utf-8?B?NngzaUcwL2w4WWd6bmk0LzBlSDh2dWwvcmZjZitBdmNhSG5xR2R2aE4xUGFN?=
 =?utf-8?B?Tk1tdDRnR0lVVG5IaHRZRVgzUTVyaU9tajRDeHl1VmdSVzFCckZWanNZSnBZ?=
 =?utf-8?B?QTlneDVJYkIydjZ5eTcxZTNROVlTSUE3UEwvUFVqYytud2xGeEJPTFZLT1hO?=
 =?utf-8?B?a3hjZm1kZUNUNDJPd0grSHQza1ovaGlrR0tYMFZwL2Z2SGxSb1RzMHk3VG85?=
 =?utf-8?B?a3BaZnVlSlhNOTU0RElQbDVkTG50eGU1TmJUVzl3a1V5Z3c3MmJheGhJMVRl?=
 =?utf-8?B?OVlqdm0zYmNUdkVlZVJYSlY4Wmk4aEgxa3Q2T2hvVjhycnM1UWxwZno1aGNM?=
 =?utf-8?B?VzExellUL2s5dHN6THIwTGpRSFhGMDJKb3gzVjBYOWJ1Ry9qWkl6Wkd1Z05E?=
 =?utf-8?B?amNMRWNyWUJwN0hYaTczV3FiNHRtcksyNTlHKzVKejFCL25CblpBZXIrRFBw?=
 =?utf-8?B?S2E0NFBzcHlmQjNyZUVFZTlaYjg4dmgwVlB5R1g4SElib1BONS9DSmpPTGhp?=
 =?utf-8?B?VHhwVnovSEVjeWx1WnBya1NHNUhJaWlhSUUxWFNNTlVPa2NYclJGYlkzR2lS?=
 =?utf-8?B?UDVqZDJic1RTN2svNWVJRE9uSVF6RlVQZWhwQXh6WWI4K0pIUHE2ak1YaEdE?=
 =?utf-8?B?QU5ucEVlVDBjQzdVdHBHK0toZ3NOT25jaWlVU0prK3NTeVdkcHg3VzNxSzZJ?=
 =?utf-8?B?VUJpNndqV3hEZDkrU0Y3aWU4TStSV0VrSDRaMGw3dDlLSCtXTXg4WWQzRm1F?=
 =?utf-8?B?a05rM2h1VmpTcFpvbzNrcXBwTFJKOUtpcVQ0bXM3eDh3b2o0aW40azZQUmd4?=
 =?utf-8?B?OG43K2psQzlCdXNacG9JeTlzRUU4bmhMVnk2NVkyUGNWU0tFY1c5M3FPbWJG?=
 =?utf-8?B?Zk4xK0ZMOGl6WHpDNGxGNDdPQ1FvdS9hM1Q2ZG1KcTRtMXhSSzgrYnZ4R0RO?=
 =?utf-8?B?bWZiRTYzNnN1UUlldHlJeWNDc3hxVVAybWhHdDFEYlF3V2ZFZytOZXZkNEx2?=
 =?utf-8?B?bFJmREM5L3k3RmttWnk5Ykt3NG9PdHFKcUpVZDZVeUVUNDZ4bDZvK3pmSnk0?=
 =?utf-8?B?OUwvYTFUVVcwaFYzZXprdE5SR2dqMFJJeXdJd0hlbmNtS0xiSFV4WUwveENx?=
 =?utf-8?B?YWxNRGhrNGhQb3dpV3NGb1VaSGFtSWRBOC9pREc1aUVCeVdMSGY1MnRnTGhz?=
 =?utf-8?B?N0tBQWUzZWtaS05LTG8za0ZMQzJBd0VpZWRUVzdFSkVOOFVvb1VzeUpNVXFG?=
 =?utf-8?B?MVJJZXlDRG9VNkFLL2RINFNFTXFqUTdjR3NZV1pBdFUxZm1SMjZYZlJGQ1gy?=
 =?utf-8?B?SStZWkgvaExxNS9lM0FNc0ZpdytxSFY1dFBBNkx6QUpRUGNwTWR2aUxWY0U4?=
 =?utf-8?B?NEJuZVZvN0VwVGt0MHI0V2t4TVUrTTR5a0RSQy9wYUs4cDZsUWxUN3haK2RW?=
 =?utf-8?B?eW5qZnNoaDJ0NFpHNkE3Z0FpMWpKVitOYW16TDhkMktWZmxLVm45VUVEM2tG?=
 =?utf-8?B?d2hCVklRaCtSOE5sVktUbFRIRFpUTVJOWlNDa1Z2aXVKRGNWQkNGTTRVNE43?=
 =?utf-8?B?TFE0UWdrQnlxanRkbFZtRFVHbXRrbzhNZjV2aWE4VmdidWdZVzJ5MXRBSWM5?=
 =?utf-8?B?RGZ2OGMwRnBWOEREUXRNdVVTTkVVYitNMzBkYXBxeGdBT0lUM3AzcXU4RHV6?=
 =?utf-8?Q?MY2UpF4F7l3A1soHn4wFK/yXIjj/K2LgBzRS/ql?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <86A2A26ABF74AB40A1B539CE12B859E8@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 927ba316-b47b-4c32-d6b7-08d9660e10d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 08:14:44.7156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tObkKbGQ8eoToSisWT7XQoRQvoMIdlwSXm3AEScX/QJz/FnDY2ZuJOYUYuSxt8i/n0x18eJ3o7sgn6cgmtbUyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR09MB4612
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SGkgTGlxaW9uZywNCg0KT24gOC8yMy8yMSAxMDowNiBBTSwgbGlxaW9uZyB3cm90ZToNCj4gSGkg
U2ltb24gOg0KPiANCj4gVXNpbmcgYSB0ZW1wb3JhcnkgaW1hX3J1bGVzIHZhcmlhYmxlIGlzIG5v
dCB3b3JraW5nIGZvciAiaW1hX3BvbGljeV9uZXh0Ii4gDQo+IA0KPiAgdm9pZCAqaW1hX3BvbGlj
eV9uZXh0KHN0cnVjdCBzZXFfZmlsZSAqbSwgdm9pZCAqdiwgbG9mZl90ICpwb3MpDQo+ICB7DQo+
ICAJc3RydWN0IGltYV9ydWxlX2VudHJ5ICplbnRyeSA9IHY7DQo+IC0NCj4gKwlzdHJ1Y3QgbGlz
dF9oZWFkICppbWFfcnVsZXNfdG1wID0gcmN1X2RlcmVmZXJlbmNlKGltYV9ydWxlcyk7DQo+ICAJ
cmN1X3JlYWRfbG9jaygpOw0KPiAgCWVudHJ5ID0gbGlzdF9lbnRyeV9yY3UoZW50cnktPmxpc3Qu
bmV4dCwgc3RydWN0IGltYV9ydWxlX2VudHJ5LCBsaXN0KTsNCj4gIAlyY3VfcmVhZF91bmxvY2so
KTsNCj4gIAkoKnBvcykrKzsNCj4gIA0KPiAtCXJldHVybiAoJmVudHJ5LT5saXN0ID09IGltYV9y
dWxlcykgPyBOVUxMIDogZW50cnk7DQo+ICsJcmV0dXJuICgmZW50cnktPmxpc3QgPT0gaW1hX3J1
bGVzX3RtcCkgPyBOVUxMIDogZW50cnk7DQo+ICB9DQo+IA0KPiBJdCBzZWVtcyBubyB3YXkgdG8g
Zml4ICJpbWFfcnVsZXMiIGNoYW5nZSB3aXRoaW4gdGhpcyBmdW5jdGlvbiwgaXQgd2lsbCBhbHdh
eQ0KPiByZXR1cm4gYSBlbnRyeSBpZiAiaW1hX3J1bGVzIiBiZWluZyBjaGFuZ2VkLg0KDQotIEkg
dGhpbmsgcmN1X2RlcmVmZXJlbmNlKCkgc2hvdWxkIGJlIGNhbGxlZCBpbnNpZGUgdGhlIFJDVSBy
ZWFkIGxvY2sNCi0gTWF5YmUgd2UgY291bGQgY2hlYXQgd2l0aDoNCglyZXR1cm4gKCZlbnRyeS0+
bGlzdCA9PSAmaW1hX3BvbGljeV9ydWxlcyB8fCAmZW50cnktPmxpc3QgPT0gJmltYV9kZWZhdWx0
X3J1bGVzKSA/IE5VTEwgOiBlbnRyeTsNCiAgYXMgdGhhdCdzIHRoZSBvbmx5IHR3byBydWxlc2V0
cyBJTUEgZXZlciB1c2U/DQogIEFkbWl0dGVkbHksIHRoaXMgaXMgbm90IGFzIGNsZWFuIGFzIHBy
ZXZpb3VzbHksIGJ1dCBpdCBzaG91bGQgd29yayB0b28uDQoNClRoZSB3YXkgSSBzZWUgaXQsIHRo
ZSBzZW1hcGhvcmUgc29sdXRpb24gd291bGQgbm90IHdvcmsgaGVyZSBlaXRoZXIsDQphcyBpbWFf
cG9saWN5X25leHQoKSBpcyBjYWxsZWQgcmVwZWF0ZWRseSBhcyBhIHNlcV9maWxlDQooaXQgaXMg
c2V0IHVwIGluIGltYV9mcy5jKSBhbmQgd2UgY2FuJ3QgY29udHJvbCB0aGUgbG9ja2luZyB0aGVy
ZToNCndlIGNhbm5vdCBsb2NrIGFjcm9zcyB0aGUgc2VxX3JlYWQoKSBjYWxsICh0aGF0IGN1cmUg
Y291bGQgZW5kIHVwIGJlDQp3b3JzZSB0aGFuIHRoZSBkaXNlYXNlLCBkZWFkbG9jay13aXNlKSwg
c28gSSBmZWFyIHdlIGNhbm5vdCBwcm90ZWN0DQphZ2FpbnN0IGEgbGlzdCB1cGRhdGUgd2hpbGUg
YSB1c2VyIGlzIGl0ZXJhdGluZyB3aXRoIGEgbG9jay4NCg0KU28gaW4gYm90aCBjYXNlcyBhIGNo
ZWF0IGxpa2UgIiZlbnRyeS0+bGlzdCA9PSAmaW1hX3BvbGljeV9ydWxlcyB8fCAmZW50cnktPmxp
c3QgPT0gJmltYV9kZWZhdWx0X3J1bGVzIg0KbWF5YmUgbmVlZCB0byBiZSBjb25zaWRlcmVkLg0K
DQpXaGF0IGRvIHlvdSB0aGluaz8NCg0KDQo+IA0KPiBSZWdyYWRzLA0KPiANCj4gbGlxaW9uZw0K
DQpUaGFua3MsDQpTaW1vbg==
