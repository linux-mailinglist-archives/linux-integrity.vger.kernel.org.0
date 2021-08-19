Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6AD3F19DA
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Aug 2021 14:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhHSM6s (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Aug 2021 08:58:48 -0400
Received: from mail-eopbgr140121.outbound.protection.outlook.com ([40.107.14.121]:50821
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229601AbhHSM6q (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Aug 2021 08:58:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyXNtVVsuJ6TVY9sMieksDj2GLs/tbXw88PWGbjWQJWsfqFsj/UhupdLHzkfgNiKVo1Aeq6ECOmA1awLVq3V1ZWzOjRZTjJL336tzEDsnMMmClXc0Y6CaSpRbXjROHy2OzmqAmqCeNtRWrqz1bx1/7rPBeU3QikRk15DC8zB/+8edTBZ+h/tEVdfvVpCN3K1if8v0LdOm0JfouCxpRTfcv7P264ypqqjCr21B3WO/OVMLMSr2rqf+MuQ39IzidHSpU7eAsFzN0ube8obJLRLuxLV2hQEQtMvC+Gn3i8a28o1E1D0iq8szuu3ZZSiLEyuL/V+/Qvcelbj0S5sJgBzSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=267mZfgsw08nQMitHSIZ31FgomW7ZT5IyGYpyL6B2t8=;
 b=C6SNjj/4clyNP7If2bvvsRw5IkUMx5RagXzrjV4tKBXRDB6jMg1Jpe1fbB13Rv6bARopz5Di5mAVNtYFD+s+mSjz38MX95CdZzl9inFzZkH809kvzKe3+uPtI2tE8iIyR5PatcFJ/yhYz+Lc9jD4xb26t00KvZnW6WhFTjo+udC3PruAQ9cgygIwgXRCO6gEmLN34M0hfZKtohhgkqLWOCEX5u61HQPdxbQESaBWYaQidwu5atrPXKVSsaWR3ux+rtCOoeo11+3ThtuvnbepPbs6Ucs90bJZhmRoQYfot+Rc3SIScHonzmsacqbmMsjCrzGk5UF3RGzIye0kDVHStA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=267mZfgsw08nQMitHSIZ31FgomW7ZT5IyGYpyL6B2t8=;
 b=jsGPjrGekTaomKjyIT4WwLyn9CAOm5jD+TsfN8/o3JTnyfBkvJOXHubkDnvl2oZYx5oxBfnIsVv+tmTiAlwTHbv3yhe8rF2F8/BTlwuAAR0TCG38LQ7CkaMuMLdrbmZqv6nmYSSbC40Od2vttG4OPm6d3YGLP0tVX4J81qScMEY=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB4305.eurprd09.prod.outlook.com
 (2603:10a6:20b:168::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 12:58:06 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 12:58:05 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     liqiong <liqiong@nfschina.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>
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
Thread-Index: AQHXlPnZCsK5CNi7NkWxUIAyoKg2DA==
Date:   Thu, 19 Aug 2021 12:58:05 +0000
Message-ID: <8d17f252-4a93-f430-3f25-e75556ab01e8@viveris.fr>
References: <20210819101529.28001-1-liqiong@nfschina.com>
In-Reply-To: <20210819101529.28001-1-liqiong@nfschina.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nfschina.com; dkim=none (message not signed)
 header.d=none;nfschina.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 259f2904-3f31-495e-b5ad-08d96310fcac
x-ms-traffictypediagnostic: AM0PR09MB4305:
x-microsoft-antispam-prvs: <AM0PR09MB4305D399CFEE165D7B8DC11B94C09@AM0PR09MB4305.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3GWgqOUi3k8VWoWH46zBUiRTuLDhfIyauNI9MW8bzjKMKj+lwtHMgjzKi9uesWwFDw5OdConIVO5ClKBSdN0WXARwqIOCb73mC4cOTt8jww3aFP0pVZUaTveiTblwJk5TAH85cgYwxCcanJoWcLelOwc/xT586uAsdnl+MzTZ2yGzurk4tHIDDp6AtgOFeSOan95aR2nWlYtMhbPf5M7wgC7uIfTj3r/XZF3S2JQ9rQD2dGuxoWNCplyF+OdGkU4KBmeJbZB9suKbxwq6Bt70Kkjy3F0Cc11jq421IQ1KKKSKVvue1gTbfH09x1fCGxJinpKwpvY7xp8wdYxeF/TbYEbqHQ5UE6ftpPdcSpaX5aa+roACTuEDfBntnMi1AeNRPh4EZfxva/zKF0S4hQQi4uvhWVYiE0KGPiqiX+fnDv94wkrP+roZC13iKj8S86OHbuVbIL86vSsZUfIsuHmLmh49yfSa5DKFpPxba8fepG+tae4jjhi6QtmA5rjw/aRRvvGT+L/ZHDhTHAjLfII8ObEL/OoGv1zIzUDLNDOkHZLNQuZvoPBh9fwCzzp4lxhP4Mx82cFuk/eqE+9CvXCuMj6rMarJCV1/ymN/ePqvHm8MST4vu1CN31NmN0UEUgiwclDoKfOneU+MXVvmJAeI9kYJjNmC0OHPfoH/WcFawLPFtYLac1PAMzp5ppg6V9AOMwWkkY9Rv5HK2OkgqXXdxvTh8vmEoGH/4M5jH0jYgzUhjLFntV0xbRuV/z+04cG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(376002)(346002)(136003)(366004)(71200400001)(186003)(76116006)(54906003)(36756003)(110136005)(38100700002)(122000001)(31696002)(6512007)(316002)(6486002)(4326008)(2906002)(26005)(5660300002)(53546011)(478600001)(8936002)(31686004)(8676002)(66556008)(66476007)(66446008)(64756008)(86362001)(66946007)(83380400001)(91956017)(2616005)(6506007)(38070700005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEdjeDYxaWtmUFp2YUFkeC9rWk9tTmNyYlhBS3lEZFA5RUcxZ2l4WXM3OE1w?=
 =?utf-8?B?aXA5K1o5L3pGU2tDZTF2Q0JsZ05ydnZxek92RmpFa3V6SVk1MUZVMldPdXhC?=
 =?utf-8?B?VTFwNVhFQWNPT1kvdWZheHg4ZzdLdngzOGhPVTZWMkk3NWY2N1ZDbC9sT1dE?=
 =?utf-8?B?Smt2RnY0NnkycmN2U2J1MVBWbm5JbUNURy9GRUwvaWpvM28yTUQzQkEvQ3U4?=
 =?utf-8?B?ajdBZjg5Nkp1QWRNeWFCTEc0cEp4WXBQK1BDOHd1SGtEL3Z6TmNkN1RwUDRJ?=
 =?utf-8?B?cks5MzYwTkVmdzZWeHduNWxreWZmWlNBeGM2NkZuZks5WHA0NFl0MGRmSHU0?=
 =?utf-8?B?Y1l4QXZBUE54YW9YeXA5ZnFxN0RKNnlyUG4vSEJndk9vcXhuaWp1WmN5Qi9i?=
 =?utf-8?B?dGd6eFNBd1ZGWTltRmczOVJTQUtkbXZ5UEZyYjVJNm9melRqVG40amJoVy81?=
 =?utf-8?B?UTEvRFNQZFhrbmM2V2ZtK3g0Q0w1NGRuakwxNDBQSnBrcWpvWlllUkhqb3h3?=
 =?utf-8?B?UE4xU21tTzdZRjhua2krK1FadUJJN000SU1qNWNTOXpYQ1VKeFNYb3UwV1BV?=
 =?utf-8?B?eXozMmsxL3Jjakk3UmNsRjNYK3ZaV3FDeGRZb3lBZ2tqSmh5dVczeU4ydDAv?=
 =?utf-8?B?RWl0R3k5VTdXQmF0K0JySHUwaUJBMmh5QVllRG5saGI3VlB4WldxNCtFdHdo?=
 =?utf-8?B?ZFdZdVJ4YmVzMnp6K0pzNndZSUl6d2VrRTROMjFNY2ZOWUEwbFcwVXJBZ2M2?=
 =?utf-8?B?dWZyajhRZHlzSmtXTksxejRoL2J0Z0VKVzNPR1dOQkkyc0cybTFic0NJMmZL?=
 =?utf-8?B?TzZ3dWpBNDRnc0J4cEJLM04xOG1DTVpqdWtWMEV3ZWhrN3NXMDVGSjVSU2pm?=
 =?utf-8?B?WitsSVNVRUJvSnQ0czBjQXREbm1KTkQxbzJhVDRTdy80ZVRBTXB3V3VCeE5q?=
 =?utf-8?B?b0NLRjFxVm5yaDZjVFl0OXJra0x5b3J2RmxPZm1nWUxNZFJmSkZNcXArQXl1?=
 =?utf-8?B?MlI5a1lkbDZXSTZJek5hSVhGSksxTWJONTVtd05JQ1ZKOFRhbG1zWDFvM09T?=
 =?utf-8?B?VGY5c0NkZkE3empIMjFaVGgwL0JFbDlTR0VoVTRWcXl2b2tJeEF3QXc3Ymd1?=
 =?utf-8?B?L1dNdFhqNGIrUElKZi9KL2RBWm5ieTZGYk93YUpMR3Vxc2lPM29iQ3NhYk15?=
 =?utf-8?B?VTJmdkJUTjhlQWRqK3hCa1NlaTJobFZvSFBlS0tXUHJKc1VTcWJ1TmJPdU1a?=
 =?utf-8?B?Mi9TTXF3blhhZWZCTFpiUmpjVkMwbFVqU29DL3RXekZhOGREdVVBbkFwWnJa?=
 =?utf-8?B?OXYzRERuTURqUTBBL3JwT2JDWWlHTDlKaFRERVhOL3VxNXFuM1ZPby9UZkg2?=
 =?utf-8?B?NUVXRnZFeXZNaWM5YXc5ejR0azlqcnIybFQrK1BpK1cwR044NVFpZEFralQy?=
 =?utf-8?B?eWo0L2Z0ZjU0QjRUMlpjaE5WNFpOV3hhYXozMU9ObW9tNGM2VU8zM3NDalNN?=
 =?utf-8?B?RkY5RGxyc01oOHozVWprMWxSZCs0eFpCVnlhWlFBcFNpTUpwdXp5b3FxTURp?=
 =?utf-8?B?dWM5TXlvOWtNOURhY3BCd3dESHhTblRWZ1ZXM1lHMkFiQnR4Q2ZnTmZDT0VW?=
 =?utf-8?B?VmdtUUZiZ21QdWZTcmp3T0dwZnk4YVFseUh0RFZ6bmU1VElYbnNqYjBrcE5j?=
 =?utf-8?B?bVd1SnZOYW1YRktncDZBcys4eGJQWlZpajdldkI1eHhaS2ZabjBEcWNjYmJ2?=
 =?utf-8?Q?BYURM/JXorA3+OvSjpiUAqzcn4HfzFs8v6+yBAh?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <16050265F97A7D4B9BE19169411B1A88@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 259f2904-3f31-495e-b5ad-08d96310fcac
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 12:58:05.8300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 432n9fwkfQVRNlQBwAd7MKAzD/nYgWvhQGFnMZXGCL1R6Du2Nk55rGQ53G7uoEoHkFilPYqhUfZoDBHhLb/EPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4305
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SGkgTGlxaW9uZywNCg0KT24gOC8xOS8yMSAxMjoxNSBQTSwgbGlxaW9uZyB3cm90ZToNCj4gV2hl
biAiaW1hX21hdGNoX3BvbGljeSIgaXMgbG9vcGluZyB3aGlsZSAiaW1hX3VwZGF0ZV9wb2xpY3ki
IGNoYW5ncw0KPiB0aGUgdmFyaWFibGUgImltYV9ydWxlcyIsIHRoZW4gImltYV9tYXRjaF9wb2xp
Y3kiIG1heSBjYW4ndCBleGl0IGxvb3AsDQo+IGFuZCBrZXJuZWwga2VlcHMgcHJpbnRmICJyY3Vf
c2NoZWQgZGV0ZWN0ZWQgc3RhbGwgb24gQ1BVIC4uLiIuDQo+IA0KPiBJdCBvY2N1cnMgYXQgYm9v
dCBwaGFzZSwgc3lzdGVtZC1zZXJ2aWNlcyBhcmUgYmVpbmcgY2hlY2tlZCB3aXRoaW4NCj4gImlt
YV9tYXRjaF9wb2xpY3ksYXQgdGhlIHNhbWUgdGltZSwgdGhlIHZhcmlhYmxlICJpbWFfcnVsZXMi
DQo+IGlzIGNoYW5nZWQgYnkgYSBzZXJ2aWNlLg0KDQpGaXJzdCBvZmYsIHRoYW5rcyBmb3IgZmlu
ZGluZyBhbmQgaWRlbnRpZnlpbmcgdGhpcyBuYXN0eSBidWcuDQoNCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IGxpcWlvbmcgPGxpcWlvbmdAbmZzY2hpbmEuY29tPg0KPiAtLS0NCj4gIHNlY3VyaXR5L2lu
dGVncml0eS9pbWEvaW1hX3BvbGljeS5jIHwgNSArKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2ludGVncml0eS9pbWEv
aW1hX3BvbGljeS5jIGIvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfcG9saWN5LmMNCj4gaW5k
ZXggZmQ1ZDQ2ZTUxMWYxLi43ZTcxZTY0MzQ1N2MgMTAwNjQ0DQo+IC0tLSBhL3NlY3VyaXR5L2lu
dGVncml0eS9pbWEvaW1hX3BvbGljeS5jDQo+ICsrKyBiL3NlY3VyaXR5L2ludGVncml0eS9pbWEv
aW1hX3BvbGljeS5jDQo+IEBAIC0yMTcsNiArMjE3LDcgQEAgc3RhdGljIExJU1RfSEVBRChpbWFf
ZGVmYXVsdF9ydWxlcyk7DQo+ICBzdGF0aWMgTElTVF9IRUFEKGltYV9wb2xpY3lfcnVsZXMpOw0K
PiAgc3RhdGljIExJU1RfSEVBRChpbWFfdGVtcF9ydWxlcyk7DQo+ICBzdGF0aWMgc3RydWN0IGxp
c3RfaGVhZCAqaW1hX3J1bGVzID0gJmltYV9kZWZhdWx0X3J1bGVzOw0KPiArc3RhdGljIERFQ0xB
UkVfUldTRU0oaW1hX3J1bGVzX3NlbSk7DQo+ICANCj4gIHN0YXRpYyBpbnQgaW1hX3BvbGljeSBf
X2luaXRkYXRhOw0KPiAgDQo+IEBAIC02NjYsNiArNjY3LDcgQEAgaW50IGltYV9tYXRjaF9wb2xp
Y3koc3RydWN0IHVzZXJfbmFtZXNwYWNlICptbnRfdXNlcm5zLCBzdHJ1Y3QgaW5vZGUgKmlub2Rl
LA0KPiAgCWlmICh0ZW1wbGF0ZV9kZXNjICYmICEqdGVtcGxhdGVfZGVzYykNCj4gIAkJKnRlbXBs
YXRlX2Rlc2MgPSBpbWFfdGVtcGxhdGVfZGVzY19jdXJyZW50KCk7DQo+ICANCj4gKwlkb3duX3Jl
YWQoJmltYV9ydWxlc19zZW0pOw0KPiAgCXJjdV9yZWFkX2xvY2soKTsNCj4gIAlsaXN0X2Zvcl9l
YWNoX2VudHJ5X3JjdShlbnRyeSwgaW1hX3J1bGVzLCBsaXN0KSB7DQo+ICANCj4gQEAgLTcwMiw2
ICs3MDQsNyBAQCBpbnQgaW1hX21hdGNoX3BvbGljeShzdHJ1Y3QgdXNlcl9uYW1lc3BhY2UgKm1u
dF91c2VybnMsIHN0cnVjdCBpbm9kZSAqaW5vZGUsDQo+ICAJCQlicmVhazsNCj4gIAl9DQo+ICAJ
cmN1X3JlYWRfdW5sb2NrKCk7DQo+ICsJdXBfcmVhZCgmaW1hX3J1bGVzX3NlbSk7DQo+ICANCj4g
IAlyZXR1cm4gYWN0aW9uOw0KPiAgfQ0KPiBAQCAtOTE5LDcgKzkyMiw5IEBAIHZvaWQgaW1hX3Vw
ZGF0ZV9wb2xpY3kodm9pZCkNCj4gIA0KPiAgCWlmIChpbWFfcnVsZXMgIT0gcG9saWN5KSB7DQo+
ICAJCWltYV9wb2xpY3lfZmxhZyA9IDA7DQo+ICsJCWRvd25fd3JpdGUoJmltYV9ydWxlc19zZW0p
Ow0KPiAgCQlpbWFfcnVsZXMgPSBwb2xpY3k7DQo+ICsJCXVwX3dyaXRlKCZpbWFfcnVsZXNfc2Vt
KTsNCj4gIA0KPiAgCQkvKg0KPiAgCQkgKiBJTUEgYXJjaGl0ZWN0dXJlIHNwZWNpZmljIHBvbGlj
eSBydWxlcyBhcmUgc3BlY2lmaWVkDQo+IA0KDQpSYXRoZXIgdGhhbiBpbnRyb2R1Y2luZyBhIG5l
dyBzZW1hcGhvcmUsIEkgd29uZGVyIGlmIHlvdSBjb3VsZG4ndCBoYXZlIGRvbmUgc29tZXRoaW5n
DQpsaWtlIHRoZSBmb2xsb3dpbmc/DQoNCkBAIC02NzQsMTMgKzY3NCwxNSBAQCBpbnQgaW1hX21h
dGNoX3BvbGljeShzdHJ1Y3QgdXNlcl9uYW1lc3BhY2UgKm1udF91c2VybnMsIHN0cnVjdCBpbm9k
ZSAqaW5vZGUsDQogICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpmdW5jX2RhdGEsIHVu
c2lnbmVkIGludCAqYWxsb3dlZF9hbGdvcykNCiB7DQogICAgICAgIHN0cnVjdCBpbWFfcnVsZV9l
bnRyeSAqZW50cnk7DQorICAgICAgIHN0cnVjdCBsaXN0X2hlYWQgKmltYV9ydWxlc190bXA7DQog
ICAgICAgIGludCBhY3Rpb24gPSAwLCBhY3RtYXNrID0gZmxhZ3MgfCAoZmxhZ3MgPDwgMSk7DQoN
CiAgICAgICAgaWYgKHRlbXBsYXRlX2Rlc2MgJiYgISp0ZW1wbGF0ZV9kZXNjKQ0KICAgICAgICAg
ICAgICAgICp0ZW1wbGF0ZV9kZXNjID0gaW1hX3RlbXBsYXRlX2Rlc2NfY3VycmVudCgpOw0KDQog
ICAgICAgIHJjdV9yZWFkX2xvY2soKTsNCi0gICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeV9yY3Uo
ZW50cnksIGltYV9ydWxlcywgbGlzdCkgew0KKyAgICAgICBpbWFfcnVsZXNfdG1wID0gcmN1X2Rl
cmVmZXJlbmNlKGltYV9ydWxlcyk7DQorICAgICAgIGxpc3RfZm9yX2VhY2hfZW50cnlfcmN1KGVu
dHJ5LCBpbWFfcnVsZXNfdG1wLCBsaXN0KSB7DQoNCiAgICAgICAgICAgICAgICBpZiAoIShlbnRy
eS0+YWN0aW9uICYgYWN0bWFzaykpDQogICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsN
CkBAIC05NzAsNyArOTcyLDcgQEAgdm9pZCBpbWFfdXBkYXRlX3BvbGljeSh2b2lkKQ0KDQogICAg
ICAgIGlmIChpbWFfcnVsZXMgIT0gcG9saWN5KSB7DQogICAgICAgICAgICAgICAgaW1hX3BvbGlj
eV9mbGFnID0gMDsNCi0gICAgICAgICAgICAgICBpbWFfcnVsZXMgPSBwb2xpY3k7DQorICAgICAg
ICAgICAgICAgcmN1X2Fzc2lnbl9wb2ludGVyKGltYV9ydWxlcywgcG9saWN5KTsNCg0KICAgICAg
ICAgICAgICAgIC8qDQogICAgICAgICAgICAgICAgICogSU1BIGFyY2hpdGVjdHVyZSBzcGVjaWZp
YyBwb2xpY3kgcnVsZXMgYXJlIHNwZWNpZmllZA0KDQoNCkFsc28sIGltYV9tYXRjaF9wb2xpY3kg
aXMgbm90IHRoZSBvbmx5IHBsYWNlIHdoZXJlIHdlIGl0ZXJhdGUgb3ZlciBpbWFfcnVsZXMsIG1h
eWJlDQp0aGlzIGNoYW5nZSBzaG91bGQgYmUgYXBwbGllZCB0byBldmVyeSBmdW5jdGlvbiB0aGF0
IHBlcmZvcm0gYSBjYWxsIHRoZSBsaWtlIG9mDQoibGlzdF9mb3JfZWFjaF9lbnRyeV9yY3UoZW50
cnksIGltYV9ydWxlc190bXAsIGxpc3QpIiA/DQoNCkFsbCB0aGF0IGJlaW5nIHNhaWQsIHlvdXIg
Y2hhbmdlIGlzIHF1aXRlIHNtYWxsIGFuZCBJIGhhdmUgbm8gb2JqZWN0aW9uIHRvIGl0LA0KSSB3
YXMganVzdCB3b25kZXJpbmcgd2hldGhlciB3ZSBjb3VsZCBhY2hpZXZlIHRoZSBzYW1lIGVmZmVj
dCB3aXRob3V0IGxvY2tzDQp3aXRoIFJDVS4NCg0KV2hhdCBkbyB5b3UgdGhpbms/DQoNClRoYW5r
cywNClNpbW9uDQo=
