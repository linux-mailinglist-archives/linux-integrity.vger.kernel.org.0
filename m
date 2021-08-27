Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABEA3F9521
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Aug 2021 09:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244360AbhH0Hbx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Aug 2021 03:31:53 -0400
Received: from mail-eopbgr150108.outbound.protection.outlook.com ([40.107.15.108]:21731
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244198AbhH0Hbw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Aug 2021 03:31:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJovYGxLMqH5k9l+IsuCvTyTw0jGgLFBb3qgcTcAv3fAxWtGIgchyO5blpFSRlHIbXxkXjdK+EUvJcj3TSKV69KjuUpNtb74PDVpW668/75xezxOSgjM/nop2TnDU36GOXP65VcR/6kA3GxTLer13l66SeLvd6Te0POvDx9/8dMhVdFIrr1Hf2yX3YzKJsH96KNvutJuFA0J4p6hKTeysF7mt1OMTMJMSSXL+QUarBMMWb0r7tva3F7oLjPyCRYCWQhL66pZ6bzeOF6ylalJnJcWkldmMKIVT1HDXDrczoA921OGwXNbaIpCdFlHOKaryafu6l4TNCtJ+jHoxAB5VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPZlXWnKkhSoQA2gh2vmfmmRHraEJ95Lqkgfqttf3mQ=;
 b=joKRn1dCla/M+B9wL45BlEfy6TclqTTh7Dq/ybt3JtdRhfKTq0R9L5In5FHpQGP+YGWQB+UZY+EuB9VsORlta/k6rTw/CLVL0pEdgpYBS0wXfPG5eN/tXkHZIE/4CMUQgElcedH3Dibf3iDCieXkX3BtxPFizAmjENUO7PfxNOjFKFynlQklj/oP6lZhhKlDmlTjCsz+wDGVxBr+Quyfh8fErkAg37RiVMmWh67rmjrEMWOsI0/mYcG9W9qMTanODUuLwyZ37qd23saoUhClPHogOOL5NCOosOgmBPjKu5+zdQV47+ZRjk2NfLKBnyDkZUo1oQ1OegaKS/d9/s0aNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPZlXWnKkhSoQA2gh2vmfmmRHraEJ95Lqkgfqttf3mQ=;
 b=EQTrk6bKaYk2YNjuZ8NabQHvtd4FSRl7bgb69ilExijxgvT3nciqqDdaZWH8dABTBu5QbSNrrjO0WrMCWGI/QPo6ewoyyivkvEUoxWE+ujjY7k+lYd0gGpSVG5Qz04aysS4ZnY5ERMz/CEH1SrqFzJZVBTDKzw8mVmZ7J/sk4lE=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB4003.eurprd09.prod.outlook.com
 (2603:10a6:208:197::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Fri, 27 Aug
 2021 07:30:56 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4457.017; Fri, 27 Aug 2021
 07:30:56 +0000
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
Thread-Index: AQHXmX+tegVBd7sMTk67aKGRvAyd76uEGmyAgAAFHACAAVKggIAADJCAgAFrhQCAAA20gA==
Date:   Fri, 27 Aug 2021 07:30:55 +0000
Message-ID: <caa4955e-04d9-d3f8-cccb-5f78bd554c55@viveris.fr>
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
In-Reply-To: <bd52af5b-6c69-73a1-e0b2-8d23f3d8db3a@nfschina.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nfschina.com; dkim=none (message not signed)
 header.d=none;nfschina.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fb4f984-1fb8-4d48-2af2-08d9692c9bb2
x-ms-traffictypediagnostic: AM0PR09MB4003:
x-microsoft-antispam-prvs: <AM0PR09MB4003839CCB6F7707F6F2B23E94C89@AM0PR09MB4003.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:68;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X4C1IrQi/Re0LMTIdR0lOjG0xv00F4m1kjje7wIfvxFvl7TIt5j/eM4PhlE4undpsE3bZX2Sah6bt+d/vcHeyRrUa/Ag42KTYkmMSdWyE/rm6LnyEShndw6T2jg7DJCOMWCWRDLZIHnEVKZw+Q0hL/QdZu6b1r5NF9UF14HiOrIlcjgPNEperRTC8OeIsVjt1WVTlSNTHrA6efgfBXJZ13i4ZmyhDRqgEHYZZ5cIAw8MMwMgzsrhxOn04Vr/9etbJ+/peRkdJkXbYxSHyxxHgvNqbxGBcSYU+9wvEuuVgpAiNzpgO2goTV533HEXxjT5JyPorEf3w0clzKR6bICmpfmR6lLwysHjqO/j2UUnBFdSZVtt/2dyZii72GjOysp936BmQYYFoEFUPkDuHFPqS+Yo+KTSIH5A+yndK9h8spIkj6dygfYZ+s18JYGqM0C8SThLfUwSEbfyvV+A2Zjph2cjeI2G5gXY5XFEwX7fe8zmaXk427X7I3zAdVssVa4JIT5e4DbNG95JERqiuFf/U/7cgxy7AkXQUmO+LKkQJS3+EKsh0NhW4DSnRK3JoYeazyGaiUJ8yh2x5pbvY1YungqxJdg9NtIlPitwv6ObLRYxuJ6FKNex/LY7U+rbSpuYZ9NfoEOf50bB5yrqch+2SMRmf3IILnaV79wiDxqW4dWmqG0EorLgMRKJyyk7dZb14hL3M+SqcAsGmKaqNNFDc4OPD/197bvaGgDXSSx+ngirERADOVojMKNHZ6cr72O5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39830400003)(376002)(366004)(478600001)(53546011)(38070700005)(26005)(186003)(66946007)(31696002)(76116006)(6486002)(4326008)(6506007)(83380400001)(2616005)(8676002)(6512007)(91956017)(66446008)(54906003)(122000001)(66476007)(71200400001)(316002)(38100700002)(31686004)(64756008)(8936002)(110136005)(66556008)(86362001)(2906002)(5660300002)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0x0T1RzNmwzekR5OS9pSXVuSlJLWk1mak9qOHUxRDgwOW5XTXp2enZPVFBy?=
 =?utf-8?B?L2MxbFFXRUtuRUQyRFplWUVsK2gxd2xGeVVEZmNBZk9TZFlXUzlSUlN4aGlX?=
 =?utf-8?B?R2txei8yeW1XZlRqN0JiYm1pdThOU0w4MHFLcm9nWnBKSzdscTNwY3Vad1Jl?=
 =?utf-8?B?SmtKWVZRU0h1ZnhBTHBlVmllMlExYnNiS1NZQmRQaTQrYlFsZkRNcHFidnpV?=
 =?utf-8?B?REczSVpQZFBkUmRzU05BYTFoN3lHaHhVcG83OVhjUFRMTnYzZkZQU1lyejJN?=
 =?utf-8?B?OG5OUnlBQ0dVRlJ0RVZ3WGNKblhWZWw3Q0FKbnk1R3NJZkl2dWZOZlJ6S0pK?=
 =?utf-8?B?enBPNWNiM2hCYlZENngrMHBNclhaLzgvMlR4K3IzMDZYMC9DTzhrOXpvQ3dM?=
 =?utf-8?B?bVdBcXJqNGdmcVJUbEljNFJJZ0pLUTRHL2Vpa0I2Wmh6SFdyRFVjb2FsemlI?=
 =?utf-8?B?YVFPK0hpc3k5dVRPOENkK1BBSno5OVNvU0NyYWtVSnk3WWNvNHF3bGtpY28y?=
 =?utf-8?B?UTNhVGxLd053STArektxdTJjZDRmN2I5T1BnczBZTEJhaWlRY1RjVXZmZEpi?=
 =?utf-8?B?UmJTeVoyb0FuVlFwMy9laG1mczlia3VBSEk5VHFJaWdZY1JjOS9TanBCV011?=
 =?utf-8?B?OXQrKzdEcmEwLzBnUjhQTWFKeS9EUEFFeEJpWVptSDMrMGtLTDdTMnVmTGlR?=
 =?utf-8?B?VDFNYmFFZXo5OUNXSnBHTDBHSzVKU1JpMjVtZ2VBUWdxeG9uY01majR0TThT?=
 =?utf-8?B?Q0FlNlVSU0ZSZEM3Y2JzOEZRSW9Jd1lkWkx0eVcxeE50aloreXU2cllYenU4?=
 =?utf-8?B?YkRzYUcxVjVMS0NyNHl1ZFBUYWZydk1sMllKbVNhWFh2RFhra3NUbW9oSWEw?=
 =?utf-8?B?VDk3Z21qTzM5dWtZOTYwUFNCNVdEaWlqR0c5WDNrRjNqQzdueDBFdS8zOUJl?=
 =?utf-8?B?ajJZYlhqQ3RZRHR0bWtLMWtXTWZ6bjlwbHdDV0FXMGI5ZUVvaG16bU11U2Ew?=
 =?utf-8?B?Y29TenVQbG1pNXh6dEZUTW5pTHBDeFJNeHlHeWxDUXR4Sk5aUDVQQkxzcjk5?=
 =?utf-8?B?MGdGVXMzbXQwOVl2aks1eFZWZ1NxeTY1Q2UzSzlnWEZjdUI1Z3VDTVcyT29t?=
 =?utf-8?B?Q2c2VFM0QXdmTThkTFRqMVBXaU5OQjFwNXFxZzZNdlZSb0JtR0JETDlHWUtG?=
 =?utf-8?B?WDVEdUh5TEJjNnQvRFp4MTQ2bVkxQjlFL0xVNEwrUm5WQXFsTjJXYVA5QlVq?=
 =?utf-8?B?THM2WVdLakNqalM4L1hDc2pKNThIRGFtWVFpK2QwY0sxaWh2SWdLTlpMQUJ0?=
 =?utf-8?B?VFE0QVEya1M2UmRhTk9qVFNOUXR4QUNkZUtQRHFMV1owT0d1ckVwVHZtckJo?=
 =?utf-8?B?RjRlbU9KeGJkNjE4VTFPSlV3dkNRUy8vTlcvZi85RGR0bFZ6SWJxNjJKR3cw?=
 =?utf-8?B?K2o5bEI1aWFYNHhVblR1Y3RXclR6Q1pSc3BKSVgva2gvSFAySVhrODJYbmN0?=
 =?utf-8?B?M1ZUUFA0YVQ1aW1kVkhKNk1HcFl6QUFTTEhabkhpd3N2RG0vTU9DZHQ1RDMx?=
 =?utf-8?B?M1Judjg0ME5CYnRTR2plTzN1Rkd4Rkg2ckU5Y29VQWdwalBwQklLOEY3cmph?=
 =?utf-8?B?NmZEZjJtdzZZdE1IYmFGZk5UWU1mODIzbHhkNm56OUVacTVHaENiR0Rvdnk4?=
 =?utf-8?B?VjdJNUQ2OFZMZENMZnlGYUgxNk5YTmxVaE9TR2JiQ0NtZkJ6L2tSQ29uWTRv?=
 =?utf-8?Q?DuADV65N/zgmPQAKB8b/uHUrPqXrB3YiOs8CT0c?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AAC412764EDF2E479EAAC3D126BF6596@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb4f984-1fb8-4d48-2af2-08d9692c9bb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2021 07:30:56.0228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 74XBm4kEKLCTTWs8o1Nhqo/inW2c17CzMvl2AGEVXDcG3EFJ+UtXhrX9SImKNLjI65vQNUvl29lbjx6IZeCNlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4003
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SGkgbGlxaW9uZywNCg0KYSBmZXcgbml0cyBidXQgbm90aGluZyBzaWduaWZpY2FudC4gVGhpcyBp
cyBnZXR0aW5nIGluIGdvb2Qgc2hhcGUhDQoNCk9uIDgvMjcvMjEgODo0MSBBTSwgbGlxaW9uZyB3
cm90ZToNCj4gSGkgU2ltb24sDQo+IA0KPiBUaGFua3MgZm9yIHlvdSBoZWxwLCBpIG1heSBnb3Qg
aXQsIGhlcmUgaXMgdGhlIG5ldyBjb21taXQgbWVzc2FnZToNCj4gDQo+IA0KPiBUaGUgY3VycmVu
dCBJTUEgcnVsZXNldCBpcyBpZGVudGlmaWVkIGJ5IHRoZSB2YXJpYWJsZSAiaW1hX3J1bGVzIg0K
PiB0aGF0IGRlZmF1bHQgdG8gIiZpbWFfZGVmYXVsdF9ydWxlcyIuIFdoZW4gbG9hZGluZyBhIGN1
c3RvbSBwb2xpY3kNCj4gZm9yIHRoZSBmaXJzdCB0aW1lLCB0aGUgdmFyaWFibGUgaXMgdXBkYXRl
ZCB0byAiJmltYV9wb2xpY3lfcnVsZXMiDQo+IGluc3RlYWQuIFRoYXQgdXBkYXRlIGlzbid0IFJD
VS1zYWZlLCBhbmQgZGVhZGxvY2tzIGFyZSBwb3NzaWJsZS4NCj4gQmVjYXVzZSBzb21lIGZ1bmN0
aW9ucyBsaWtlIGltYV9tYXRjaF9wb2xpY3koKSBtYXkgbG9vcCBpbmRlZmluaXRlbHkNCg0Kcy9C
ZWNhdXNlL0luZGVlZCwvIChpbiBlbmdsaXNoLCBzZW50ZW5jZXMgd2l0aCBhIHN1Ym9yZGluYXRp
bmcgY29uanVuY3Rpb24NCmxpa2UgJ2JlY2F1c2UnIGFyZSB1c3VhbGx5IHdyaXR0ZW4gaW4gdHdv
IHBhcnRzLCBhbmQgYSBkZXBlbmRlbnQgY2xhdXNlDQpzdGFuZGluZyBieSBpdHNlbGYgaXMgcmFy
ZWx5IHVzZWQgZXhjZXB0IGZvciBzdHlsaXN0aWMgZWZmZWN0KQ0KDQo+IG92ZXIgdHJhdmVyc2lu
ZyB0aGUgImltYV9kZWZhdWx0X3J1bGVzIiBhcyBsaXN0X2Zvcl9lYWNoX2VudHJ5X3JjdSgpLg0K
DQpzL292ZXIgdHJhdmVyc2luZyB0aGUgImltYV9kZWZhdWx0X3J1bGVzIiBhcyBsaXN0X2Zvcl9l
YWNoX2VudHJ5X3JjdSgpL3doZW4gdHJhdmVyc2luZyAiaW1hX2RlZmF1bHRfcnVsZXMiIHdpdGgg
bGlzdF9mb3JfZWFjaF9lbnRyeV9yY3UoKS4vDQoNCj4gDQo+IFdoZW4gaXRlcmF0aW5nIG92ZXIg
dGhlIGRlZmF1bHQgcnVsZXNldCBiYWNrIHRvIGhlYWQsIHZhbHVlIG9mDQo+ICImZW50cnktPmxp
c3QiIGlzICImaW1hX2RlZmF1bHRfcnVsZXMiLCBhbmQgImltYV9ydWxlcyIgbWF5IGhhdmUgYmVl
bg0KDQpzL3ZhbHVlIG9mICImZW50cnktPmxpc3QiIGlzICImaW1hX2RlZmF1bHRfcnVsZXMiL2lm
IHRoZSBsaXN0IGhlYWQgaXMgImltYV9kZWZhdWx0X3J1bGVzIi8NCnMvbWF5IGhhdmUgYmVlbi9o
YXZlIGJlZW4vDQoNCj4gdXBkYXRlZCB0byAiJmltYV9wb2xpY3lfcnVsZXMiLCB0aGUgbG9vcCBj
b25kaXRpb24gKCZlbnRyeS0+bGlzdCAhPSBpbWFfcnVsZXMpDQo+IHN0YXkgYWx3YXkgdHJ1ZSwg
dHJhdmVyc2luZyBkb2Vzbid0IHRlcm1pbmF0ZSwgY2F1c2Ugc29mdCBsb2NrdXAgYW5kDQoNCkRv
bid0IGZvcmdldCB0aGUgJ3MnIGluICJzdGF5cyIgKG9yICJyZW1haW5zIikNCkRpdHRvIGZvciAi
YWx3YXlzIg0Kcy90cmF2ZXJzaW5nIGRvZXNuJ3QvdHJhdmVyc2luZyB3b24ndC8NCkFsc286IHMv
Y2F1c2UvY2F1c2luZyBhLw0KDQo+IFJDVSBzdGFsbHMuDQo+IA0KPiBJbnRyb2R1Y2UgYSB0ZW1w
b3JhcnkgdmFsdWUgZm9yICJpbWFfcnVsZXMiIHdoZW4gaXRlcmF0aW5nIG92ZXINCj4gdGhlIHJ1
bGVzZXQgdG8gYXZvaWQgdGhlIGRlYWRsb2Nrcy4NCj4gDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBs
aXFpb25nIDxsaXFpb25nQG5mc2NoaW5hLmNvbT4NCj4gLS0tDQo+ICBzZWN1cml0eS9pbnRlZ3Jp
dHkvaW1hL2ltYV9wb2xpY3kuYyB8IDE3ICsrKysrKysrKysrKy0tLS0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9wb2xpY3kuYyBiL3NlY3VyaXR5L2ludGVncml0
eS9pbWEvaW1hX3BvbGljeS5jDQo+IGluZGV4IGZkNWQ0NmU1MTFmMS4uZTkyYjE5N2JmZDNjIDEw
MDY0NA0KPiAtLS0gYS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9wb2xpY3kuYw0KPiArKysg
Yi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9wb2xpY3kuYw0KPiANCj4gDQo+IFRoYW5rcw0K
PiANCj4gbGlxaW9uZw0KPiANCg0KVGhhbmtzLA0KU2ltb24=
