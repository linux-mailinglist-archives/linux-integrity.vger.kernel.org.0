Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173B23EB1ED
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Aug 2021 09:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239415AbhHMHsR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Aug 2021 03:48:17 -0400
Received: from mail-eopbgr80134.outbound.protection.outlook.com ([40.107.8.134]:39808
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239212AbhHMHsQ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Aug 2021 03:48:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsAR4T6Rb2OlHjlf05IZR1hDoZHReHlWjSPyIGz2SewscxmgC+1s+GCQRDXQsFPE0OQ92XA+xiC92r4b+U2WwR5kseyEIWg0jq8LgrLZhS5KIcCuw92A0jlds9+fviJyKE+QM2d5r2sAw8c2gjHmsf9JbYOPfzpD+JdQxl4jkO4giWOoS/HO6JitUFgtXmEfWyjbmeQCJUYjJ/fCzd+jM/zHbCdBNRuVEO9JEn28/4w/5X1QQyMq+n6LQ+UPRg0AYFXoforKX3zu4c8s7zfMKzli502sat7KwmGrxqMrvtelRNfNl06g1Zn4oNB5GC+QmwYQx7I2j4msDaZyh7oCGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1GW0GdQHKgEZvMC4RbfZtfL+jY0FceeJiWIg3X0xqY=;
 b=UcJlJJCOkpbCQ1yZsdPV4JjnVyDjmspUDUWOnJWM44poGry91Sk3/2oyLLdUQNCWFzVBPv5Fn+4FbLwGtxUlfJ/kzqfZmpdoJSU++J5Lq5zxCi01uyPU3SA4VdBpfv7M+wt8qxDu+GUJYpB73MF9CGzedM4KDHW0CQ95EwwsTWsx0evOLd7Dzv7T/WP1CCfRcuXo+p8NDf0TlevOb6ZDLmryrblEX4dHe8O/RdcW7ukK1EwlCNVLvZ/92i12fMyRCQdctimlD2yA0Wsv4wBefVWHbaJIanWT7S7XV+jEIQ7FECRxfIdp9Nff2kBsoH6NjxcRgnScn+mzJ6tl0iwnmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1GW0GdQHKgEZvMC4RbfZtfL+jY0FceeJiWIg3X0xqY=;
 b=QnKV6QxKIrfLb9vvyJOg727GW4FTzhsGshk3N6Ymh/KBO7/wIGtCzT1yJRQbGfaDHRFjTVU1rZw553cRDW+mYAHe1H2Feb+XpTqY1+U4IYHsME0F98u1mhV464Yh8kmfUTDsvRN2bDdSxj1dr1Xdazt3Eqj7niqf7uGaDTm0pAQ=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB2257.eurprd09.prod.outlook.com
 (2603:10a6:208:df::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Fri, 13 Aug
 2021 07:47:47 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4415.017; Fri, 13 Aug 2021
 07:47:47 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     Igor Zhbanov <izh1979@gmail.com>
CC:     Igor Zhbanov <i.zhbanov@omp.ru>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH 1/1] NAX LSM: Add initial support support
Thread-Topic: [PATCH 1/1] NAX LSM: Add initial support support
Thread-Index: AQHXg5n/AqeKwEHmDUiYDh8DD+AiWqtwaOcAgAC+6IA=
Date:   Fri, 13 Aug 2021 07:47:47 +0000
Message-ID: <7642c670-55d9-9c30-40a9-15aba27503da@viveris.fr>
References: <db1c1de0-3672-4bae-ef45-c554379f36f4@omp.ru>
 <d97d7fdb-1676-9670-6cf5-2427f780ec6f@viveris.fr>
 <CAEUiM9PRv+WhALQb-1im2_oZzAOvWzrMFrgn5xX9sU1K6DJ6+w@mail.gmail.com>
In-Reply-To: <CAEUiM9PRv+WhALQb-1im2_oZzAOvWzrMFrgn5xX9sU1K6DJ6+w@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aaf03e46-b0e0-4633-83ec-08d95e2ea4be
x-ms-traffictypediagnostic: AM0PR09MB2257:
x-microsoft-antispam-prvs: <AM0PR09MB2257DCA9DFEB2EE9E9CDAA3394FA9@AM0PR09MB2257.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AiasqLm/LrD6yy8mFXNigZ+ZF7QCpm1Dx06RiT/0jtFR6X6UMV2pQ7Zmwp/zK2wxvi98EUe+rS22T14p0ac+pI1t3vfSllAqt2LqM4y0EZWbFuedR+4XOONaxbLuBxuw2yzf/QqJjV8hFaKDCGZlK50nG1CvW7aP9GgbI9aWzo5yILhqfr8j+c8v0CMUjRxte4BNmZ8rFxGH/nL/uF+SzK1pB/I7WYb1onlhUM9vtm6LPmvdgLq+2Vy2RinugSuQWr5brCQ9i0Kyh+p+2VfkgNEyfoBs+g3ZZhf6f0aUY2nfN5JUOPnX3chK+VcjC5/ie2MVLUTiqR9XHfza8+OclxpMQbktjXt+FpD2kMRjDO9ZgKtymWq6/NqQIv5yXyF82DLQt1r2kbGxDrR0vvNxZMiBmZ8srok8XYS6cfsnoDhZfrHw5MwUxbBJSszw3Wd8jL4CDjU39BQXcAWGbi28aLKOEKXyhLx/il0mIc/MsTACdBKQ6HyJoIfrLaHmamwibX1K28SUEgA9VMPPEwd/AmwYTjLn8nXI7sQ90L+xu7JLUbHYgywx0GJz22/Bg+BO+dSN2ptHa9CztyYadF9S5Gn7N4f6gwhYTghSq0+Yr2eV0dHnrqsp6Pkw1Z2OMauUJpLGdW5wgzE2voUQdMy1M163JrZqxOzItNOm1F6d9pkgpB6qNK/STEJm42Fpltcj5/lbqkbDOihA9bpOPbZVoNH3cgadJhPQHVVkgJFsNl6MIvG+1jr8eEtiNpwLd7Oc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39830400003)(136003)(396003)(376002)(366004)(38100700002)(6512007)(316002)(122000001)(4326008)(54906003)(31686004)(478600001)(186003)(36756003)(26005)(2616005)(86362001)(8936002)(5660300002)(8676002)(6916009)(53546011)(31696002)(71200400001)(6506007)(76116006)(91956017)(2906002)(83380400001)(6486002)(38070700005)(66476007)(66556008)(64756008)(66446008)(66946007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzdTMWcxYUZ0T2dDYmVhUVVPaGxYdzBYckE3NlFDTi9aTy82K1hzUkpUV0lH?=
 =?utf-8?B?bGhJQU9yeWM3WmlRWVUzcndVZGVkSDRvSnNhVG03OTl2NnQ0ZlltbStCaGZu?=
 =?utf-8?B?OERSN2dCV3o5QlBJYXVMNHdnRVlIcDdxN0ZVbENGakxFRmNPK1hhdGFsSG5X?=
 =?utf-8?B?NWpqMkw1K3FqeTVxVS9vTjIvNC9QbXE3Wms3Y2tVVkt2Y3A4YVZxQ0JRRmY0?=
 =?utf-8?B?Myt6M3Z2aDZvZDBUb1ZYUkJvbHFwbVlONzFYTEZTQXNZdEVnNGtwbk9mckRI?=
 =?utf-8?B?dHdCVU9NTk5wc3YrZmR0Z1VqdTROeC9zdVU0aTF6YlVwZkplYytnK2ZSZjJE?=
 =?utf-8?B?ZGJqR3d6NUVuRHcrYndyeDVYY0QzMG1wMElOV2VPb2JJMzRhOTJEMWlITTNP?=
 =?utf-8?B?OE8zY1dyT0ZpU244RkMxZzBIQVdJS0tHUU16QVZGMmV2Sm5xMGErZXlSa2My?=
 =?utf-8?B?VVpqaHl2c09EbnpUM0ZQeUx4MkEreVl4L3N6NzNQZXp3ZDZaNWU4SGxxYmNK?=
 =?utf-8?B?Wjhnd1VGbE5TUHpiVFdBWlp5bjEvRlBoVkJFWk9Oby9scGJLWHRXQXlQVDE0?=
 =?utf-8?B?dDRnMzIwRmpXaThnSHZ3UWZnMVcycUM2M3UxZzUxdU1TaGY0ckFCa2F4WDM5?=
 =?utf-8?B?R2g3eEY2eXplVmRFTS9ta24wZ3VZYTJqVHprMklSRWYzbUZ5RGkvWUVuck5z?=
 =?utf-8?B?UmxlVDMxSW9xOWVIaUQ3VER1TWdFRVVxaUprWlM5a05Ld0xvY2dBbm8yWGtv?=
 =?utf-8?B?eVRvQUJjRCtJc1VXMHQ1ZlBZblVhUEx0RWdnSXpnN1U0TzQxeStaUk1PeHNo?=
 =?utf-8?B?R3ZneWtxRGkwTFpMZm44b0hiTm93TTFYNXc1RHB6VUlubjdBcXZHSENKNWtr?=
 =?utf-8?B?RWhVWXlGNW5BRTV3V214VHVpRnRyQXRlKzloWDJJRWlDWmtta1h1angzN0J1?=
 =?utf-8?B?QXRRWmdDWWxLMUFUOTNhbDVPenJlbWdTVWtsVlpSNTZXUUw5MS9oYVdDZHd0?=
 =?utf-8?B?aWVBZlB2SGJta1F5U25ZcHJqNVdESjdHUUh3MmthTS9idWtpVkR1Nlc4RnJD?=
 =?utf-8?B?U0toU0NhN2Naa0tSUjFNcTVGKzdEbHpORHpJcldvbXU2MzU0dTV5OFBTclF4?=
 =?utf-8?B?M3lIcnB1ellUc3h2aXlwVVJIOFk2QStudTdiNVJxL0xmV2V6cXVVWjQyUm5r?=
 =?utf-8?B?Q1BySkdPNVZXam1BMUs1czBRUzhldXptQ0greGZ3VWhBQVkxbDBFczNGYUMw?=
 =?utf-8?B?dDhLdCtqN3I2YTY4WW84dTlJQlpzV21vK3Bmb0xoOXRQVFRDZjIxVG15SVpz?=
 =?utf-8?B?R1NKdUcxVDZ0VXprUFE5cGlZaVVxSEZCaHAxaVNEeWt2OWlxUm5HRGFJaU1Z?=
 =?utf-8?B?TVlrcjZKN0NSRVpHRDNQRFRmVjdOTkdHQXI2MzA2bzRydFBsZEl6RzlvUmVQ?=
 =?utf-8?B?YTFtaG03dFNpM3N2QTVUNXQ0NTNPUlpJZGFIOVpUellod21DVUpRTWNLSktK?=
 =?utf-8?B?VzJwRWsxTzhDYVBrdGZYSVo2RFZTaWw4Z2k1Y2Uza0NIYzUwZFltSFdMOGZI?=
 =?utf-8?B?S1BzenY5MFVWdTlwblR0QjVsRGVqMVFYTHExOUlTd0t5TW1mWDB2bUorMUdw?=
 =?utf-8?B?Sng4eGVJQVQvZ25uT1ZKOUtOWFgvUGlWMVpyM01pWEpGZ3pib3dkVjZOekdM?=
 =?utf-8?B?NFV4NEJEKzl0a0lxYitobzd1SFZKWC9Kb1I2MkdXaTF0NnphNVdKYlBjejl4?=
 =?utf-8?Q?qh7XF680a7bPk69a0bEe5MHD+G23K8XneNVHOPW?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FAD68CE980F68A4C8D626E7290D88B0B@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf03e46-b0e0-4633-83ec-08d95e2ea4be
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2021 07:47:47.4481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1TE0JE+Mt7hPAQ+jhIqPJYDl/M7gpwdfWkAVxclD20SQIEiYyo2gwIxINdCcPKeQ990L1PPr3BSHRd/G7pv0xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB2257
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SGkgSWdvciwNCg0KT24gOC8xMi8yMSAxMDoyNCBQTSwgSWdvciBaaGJhbm92IHdyb3RlOg0KPiBI
aSBTaW1vbiwNCj4gDQo+INGB0YAsIDI4INC40Y7Quy4gMjAyMSDQsy4g0LIgMTM6MTksIFRIT0JZ
IFNpbW9uIDxTaW1vbi5USE9CWUB2aXZlcmlzLmZyPjoNCj4+IE5pdDogY29uc2lkZXJpbmcgdGhh
dCBhbGxvd2VkX2NhcHNfaGV4IGlzIG9ubHkgdXNlZCBpbiB0aGlzIGZ1bmN0aW9uLCBhbmQgdGhh
dCBpdCByZXByZXNlbnRzIGEgc21hbGwgYW1vdW50IG9mDQo+PiBzdGFjayBzcGFjZSwgY291bGRu
J3QgeW91IGRlZmluZSBpdCBkaXJlY3RseSBpbiB0aGUgZnVuY3Rpb24/DQo+Pg0KPj4+ICsgICAg
ICAgICAgICAgbGVuID0gc3RybGVuKGFsbG93ZWRfY2Fwc19oZXgpOw0KPiANCj4gSXQgaXMgYWxz
byB1c2VkIGFzIHN5c2N0bCBwYXJhbWV0ZXIgaW5wdXQgYnVmZmVyIGluIG5heF9zeXNjdGxfdGFi
bGVbXQ0KPiBmb3IgImFsbG93ZWRfY2FwcyIgcGFyYW1ldGVyLg0KPiANCg0KWWVzLCB3aGF0IEkg
bWVhbnQgd2FzIHRoYXQgbWF5YmUgeW91IGNvdWxkIGp1c3QgZGVjbGFyZSBpdCBhdCB0aGUgYmVn
aW5uaW5nIG9mIHRoZSBmdW5jdGlvbiwNCmFuZCBub3QgdXNlIGl0IGF0IGFsbCBpbiB0aGUgc3lz
Y3RsIHRhYmxlLiBCZWNhdXNlIGFzIEkgc2VlIGl0LCB5b3Ugb25seSB1c2UgYWxsb3dlZF9jYXBz
X2hleCBpbiB0aGUgc3lzY3RsDQp0YWJsZSB0byBjb3B5IHRoZSBzdHJpbmcgdG8gdGhhdCB0ZW1w
b3JhcnkgKHZhcmlhYmxlKSwgYW5kIGl0cyB1c2UgaXMgbGltaXRlZCB0byB0aGF0IG9uZSBmdW5j
dGlvbi4NCg0KSW5zdGVhZCBvZjoNCg0KKwkJaWYgKChlcnJvciA9IHByb2NfZG9zdHJpbmcodGFi
bGUsIHdyaXRlLCBidWZmZXIsIGxlbnAsIHBwb3MpKSkNCisJCQlyZXR1cm4gZXJyb3I7DQoNCllv
dSBjb3VsZCBwcm9iYWJseSBnZXQgYXdheSB3aXRoIHNvbWV0aGluZyBsaWtlOg0KDQo+ICtzdGF0
aWMgaW50DQo+ICtuYXhfZG9zdHJpbmcoc3RydWN0IGN0bF90YWJsZSAqdGFibGUsIGludCB3cml0
ZSwgdm9pZCAqYnVmZmVyLA0KPiArICAgICAgICAgICAgIHNpemVfdCAqbGVucCwgbG9mZl90ICpw
cG9zKQ0KPiArew0KKyAJaW50IGVycm9yOw0KKwljaGFyIGFsbG93ZWRfY2Fwc19oZXhbQUxMT1dF
RF9DQVBTX0hFWF9MRU4gKyAxXTsNClsuLi5dDQorCWxlbiA9IHN0cmxlbihhbGxvd2VkX2NhcHNf
aGV4KTsNCisJaWYgKGxlbiA+IEFMTE9XRURfQ0FQU19IRVhfTEVOKQ0KKwkJcmV0dXJuIC1FSU5W
QUw7DQorCXN0cm5jcHkoYWxsb3dlZF9jYXBzX2hleCwgYnVmZmVyLCBBTExPV0VEX0NBUFNfSEVY
X0xFTiArIDEpOw0KDQpJIGhhdmUgdG8gYWRtaXQgdGhhdCBoYXZpbmcgbmVhcmx5IG5vIGtlcm5l
bCBkZXZlbG9wbWVudCBleHBlcmllbmNlLCBJJ20gbm90DQpzdXJlIHRoZXJlIGlzIGFueSBndWlk
YW5jZSBvbiB0aGUgbWF0dGVyIChtYXliZSB0aGVyZSBpcyBldmVuIGd1aWRhbmNlIHRoYXQgcmVj
b21tZW5kDQpwcmVmZXJyaW5nIHdoYXQgeW91ciBvcmlnaW5hbCBwYXRjaCBkb2VzIHRvIHdoYXQg
SSBzdWdnZXN0ZWQpIGJ1dCBJIHRoaW5rIGl0IGlzDQp1bm5lY2Vzc2FyeSB0byBoYXZlIGEgdmFy
aWFibGUgYWNjZXNzaWJsZSB0byB0aGUgd2hvbGUgZmlsZSBidXQgYmVpbmcgdXNlZCB0byBob2xk
IChzbWFsbCkNCnRlbXBvcmFyeSBkYXRhIGZvciBhIHNpbmdsZSBmdW5jdGlvbi4NCkluIGFueSBj
YXNlLCBJIHdvdWxkIGFwcHJlY2lhdGUgY29tbWVudHMgZm9yIG90aGVyIHJldmlld2VycyBpZiB3
aGF0IEknbSBzYXlpbmcgaXMgY29tcGxldGVseQ0Kd3JvbmcsIHNvIGFzIHRvIG5vdCBtaXNsZWFk
IHlvdSBpbiBkb2luZyBhZHZlcnNlIGNoYW5nZXMuDQoNCiANClRoYW5rcywNClNpbW9u
