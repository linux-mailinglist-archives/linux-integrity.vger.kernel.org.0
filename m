Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2DF3EB24C
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Aug 2021 10:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239576AbhHMIJB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Aug 2021 04:09:01 -0400
Received: from mail-am6eur05on2097.outbound.protection.outlook.com ([40.107.22.97]:44545
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239668AbhHMII7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Aug 2021 04:08:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m73eOHvsn8jYX+at3QEArCM/fvMbkU4juNTU8O8//s5AvaGyrDPlOETol8iMYxh3ti1326hVz0TcGTiFtQBsgz4LhnBfOSpgv5QSUx7HTRruDlcYzwyL1OLJ67ilLnXIFP8XKaG6V4KzUbDUbXLWI0ZsSEaVBOwEsMs0Z0VcSVzXe/dmmeWwIIEvm4tklQF5Gc+lF3A5QhsPJxKoTLwYKzQUWaj/wi35UXbh8KEJMvKRVZ2RTRsyDzoOaxmHbwMmKGFasCq/HcH9sPdbnhbsCHNUgSAJy7dL+QWNR1ENo6GesMowIgsL0dsuAnLZgf9Bhnl5N/sVND3+Tmio/k0MhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJhRthoy5slEJtDBK1wngbi1cYOAEsUo4FxnhbqPWns=;
 b=nLtuxmwdk5Et/62Q/e3228FQSY2lOmIX4jrvO98lkOG3RUGg9x/31Ue2fNOrzCTSIR2QJdDX3jdm6Mz52MyKhEt4RK3O5g51b5CAoJuxtVAEBfgVaa9j+noieQhF0rPZrFDUKr5ngDY6Gu7sSXCHY7sMtesDtPBJsdPj/V1BC5nB66Ko6DnC5iuOAW0WIcmjpEAfqoqPZ6GNeQoaYMOLP3EASnKtb4QKDsz2RAuWUbPE3jhQK/rJBsBa3gVDp/AO5wHVBDiM+EePdrNz1vzpML8OtkvGoXtowSK+zfuoUMkQlCzd48dRATvRtIUTB/RLKN6hoxWuf9qhHxvJYa7loQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJhRthoy5slEJtDBK1wngbi1cYOAEsUo4FxnhbqPWns=;
 b=2E7cCDLz/mxHXLpRFDv7U17MIgm3mip0m7sg9/t0Q0B5JqxPm+Co4m1dXP3qTGGWBeVQK8rufUu2avz1nnv+bxZd+S+9EKfsoMlcgKZta+gXCxZyzNUd1z3/A2OoW+eKP/3Ofz7Wstn/hLrhw2MnWkyTCrKP6uLMEvwJabcaygY=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB4003.eurprd09.prod.outlook.com
 (2603:10a6:208:197::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Fri, 13 Aug
 2021 08:08:31 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4415.017; Fri, 13 Aug 2021
 08:08:31 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     Igor Zhbanov <izh1979@gmail.com>
CC:     Igor Zhbanov <i.zhbanov@omp.ru>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH 1/1] NAX LSM: Add initial support support
Thread-Topic: [PATCH 1/1] NAX LSM: Add initial support support
Thread-Index: AQHXg5n/AqeKwEHmDUiYDh8DD+AiWqtwKxAAgAECiQA=
Date:   Fri, 13 Aug 2021 08:08:31 +0000
Message-ID: <a41a0116-8d05-3aea-d979-090cdbb1d52f@viveris.fr>
References: <db1c1de0-3672-4bae-ef45-c554379f36f4@omp.ru>
 <d97d7fdb-1676-9670-6cf5-2427f780ec6f@viveris.fr>
 <CAEUiM9ObZD=miina1NsP8Ohtv=byO=33Kp2XaeF8_RB_R_uC1Q@mail.gmail.com>
In-Reply-To: <CAEUiM9ObZD=miina1NsP8Ohtv=byO=33Kp2XaeF8_RB_R_uC1Q@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d413f89-685c-431a-b239-08d95e318a03
x-ms-traffictypediagnostic: AM0PR09MB4003:
x-microsoft-antispam-prvs: <AM0PR09MB400315892CB29E8ABF4713D994FA9@AM0PR09MB4003.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GIY8G+qQJIZ/3ZP98JhIJfkUUFUowbZvEo7Rj5c6dNHTDbNPh4Y2uDGpUEc1FVBC1EbXO3x/Fec39UQ1Xy2RXslIY1IrpdrLF6lzqPNw6YtjfQnU5Z6FdWb1Q/MulpODaKOylPRFszBOABIbSP4KrQK/JhlRP9QT+OgoLLb3k+VILMppP4w96wNHrj1GFJk58enKbPTQLjhQ26EAC13ynXSEoPm5t3SysI3oRBmHbVrBOAL8IhlBpb5XErluPO9/uhitxw0ZUW1mR3pWhUU0Z/0vCc1/sOOMStd2G8tRaKX1rHxRuYjfJSnDN5ZdgrivsEZf0zvZ7pY/nVamW2qmCCUGvdHpnMiF+f5TM4rKEtudmFdeS+RZOnUC4R3eOwmQ8PWNqAq5QG5q6O1y0zmbxdvnglUF2HfzNkvmcJKGjXfJM5P208tYyT9MslG3G3d5UtATFj4+CDDR5rELd9SYkkLUNrAQtDQAtcPtnuoox7OLWjOP63+An1lPiPRbHza9RYaooRv8VtdFrTcLxWcy0Oz/alo9gDDJiJISgPdUBl9wBFzKS8c5/OryzfceI9rpCW8c7KHEUKn0WA4x7QSb8s5Ng0N7+H82mb3e2Edd9yL6vaQSR9DPbJWsNZ5938QgXNg8nWdd5Rg8dqgV+mnXZLCR+baAgr/9z5jvoPgbgIacIL4YqbZO0M0KXYO02dm6xD8k+3ih/3pkDapqdQA04g5QBMsxYNF4YoWGlbNtLHyRhZ1E97S51tzYnv4D1ezE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(376002)(39830400003)(346002)(83380400001)(91956017)(86362001)(6512007)(53546011)(6506007)(8676002)(8936002)(4326008)(66946007)(76116006)(64756008)(66446008)(66556008)(26005)(66476007)(186003)(36756003)(71200400001)(31686004)(122000001)(38100700002)(6916009)(5660300002)(6486002)(54906003)(478600001)(31696002)(2616005)(38070700005)(2906002)(316002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2cxOHM3UlM5a2JLSGFuUTUrOHdNZTBXT1hUd2hpVU96YlIvRkhJZWxCUk05?=
 =?utf-8?B?eDZjQ0V6TVJ4VlZYbW5pNG9pNXhJYTZnOWxzbEZPWWJoaGNESm51Sm1OSzhl?=
 =?utf-8?B?UzZtN1NMZmpMSDl4VURTWmZiWVJoR2xNczF3NkpGbHJWcFZjUDdzZWJiMkNG?=
 =?utf-8?B?K29seC81dTh3Q1ZRVW1SNEE3UllUQVJFYzFWU3dWNnNaM0YzZG9vbk9aeFc4?=
 =?utf-8?B?ZytTOGhmQmhSRnJRdjg5SHkvaVM5aGdBUWNSSGhqajF1VDZpczZ6R0hCS2lr?=
 =?utf-8?B?VDlxZDR6YjBRdmtkQlJDT0Rid2Q5UldIRTNhYlpTYzlzbS9ndldFZEN4WCtE?=
 =?utf-8?B?MEhFa2pCSzlaRTJsQXFEQTlWdVVzMW5tWC9iUmlFMVI3OU04ZE5odlVmRWcy?=
 =?utf-8?B?REN5MzFQTTFHcnBSS1dYREl1enpsWlZXZ3JoVmx1TWswWlJuMjgwcjBmWlhl?=
 =?utf-8?B?andvL0hwQXJaZ1BGdExSODd0dytkZkhzcHJLMnhKRHZ5MlZJQjRrR2s2Sk1y?=
 =?utf-8?B?RVVOU0xJeWc1OWFCM3dSMWFZRGU5bjZISHBJa1pRSlZ2YjZoWTV0UmZ1RVNZ?=
 =?utf-8?B?czZuUWJwK21uTUZ6N0NNZC8veEZoMWkwWnVxSTFxbGxLNVN2djFYZzFvU1Vu?=
 =?utf-8?B?UmwvSXo2dW1RQmdwRmMzdzBhN1haWE4rTVVlRlpBOWtwY2RqM2pyclVyQ1Z4?=
 =?utf-8?B?cGZtMVJSRXR2anRyNTRMSHF0QVVaS1drRHh6Nk9VdVZEOG04cVdZUHhqcnh2?=
 =?utf-8?B?cERseExaN3RoRUZLKzZmMktuRjJNaVR0ZGhkb3dyNml5TTVSb0I5aTIycXNI?=
 =?utf-8?B?bFA5RkhuWHcrVDVqRXNaTys0bm9uRjRnWFgweFRMNmdHUC9LTmE4Tld4TWU5?=
 =?utf-8?B?UkVxU1czZ294aVVGVDVCMkE5TkZtbmNlL3A3Y1JWSkNLZWo1ekdleW43TXhx?=
 =?utf-8?B?dVh1dkRrS2dDMmNlMW9ZbDZYQ1lyZXJ0QVREM1pZY01mYTJ0TkVTMWhnRlBM?=
 =?utf-8?B?WTJ1cUhRei8wTW5RSWxqalVudXA1RUhlS0IySVRtNS9OaldLeGJBcjlLWTd6?=
 =?utf-8?B?djd0cHlQL1lYcW9XSnZCb2JUQlhBVlRKQjY1OUowNzRtQndaT0dIWlluakVw?=
 =?utf-8?B?UTZrL09sU2IxWkJSSDk2V3BodVNlU2pZNFFhaWtvQWprdDVGbFJ2T082bFFD?=
 =?utf-8?B?YUxodnlzTyswenZXeDFjZU9yMXVUTUVCaVgyUVNBRktWcUprSmpsYTNnOVFY?=
 =?utf-8?B?a0cybUZBUllCUDAzUFM1a0dBNFAzUTZWN0gxRDNQN09QV0dCVjBaWnJDRExC?=
 =?utf-8?B?eURWRXZMU3RkUmtOT3RRcHBxQy96RGtjSFJDdkR1cE9oMExTQ2NFMStzR0NR?=
 =?utf-8?B?bzdWMlY2cklPS21mRmR5VlhYenlFMENhK0pkMGRyTWFzTGFCZ2pBMUtlSFNV?=
 =?utf-8?B?Y1V6SlJiWmV3V2lXcllnZEFCOXQ3V2oyWjc1bCtCcGQrbko2Q04zeC9YVHgw?=
 =?utf-8?B?OHJiTVl2aHVaNXRnVHhUdmIrRzg2cm80ODNOV2R0V29yZG9nUUZvejdrN1FG?=
 =?utf-8?B?YWZDUDg3OHE4WThod1hnZEFrd0tNdEg4UmEwZ2pXTlhJYjVpaXVjN0QzRTBj?=
 =?utf-8?B?Uzg0UEk3bVdZUjY0VWZ4eTNVOTVoeWVQaStrTlMwR3FqU3U1QzBSdjFNUEl5?=
 =?utf-8?B?a2YwUDU1V1JEOEFWZ0VEWWY1djhtUnVnZ3lheHNaZFdHNnFjbWpwS3Y5Ny9x?=
 =?utf-8?Q?By1Q9/z+LrRMEbaug+OjjGFxHGUg1KhdT9hGgLu?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <54E36B1B6855144BAA9B4640F8775F12@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d413f89-685c-431a-b239-08d95e318a03
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2021 08:08:31.1022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i+W5qEY04mKYMzM+IhtVE1QaSw+BMy9DWkQk/c0WENNAjQu5PFS+fOnzi7biFdogMZCaHxtaZxKlO670EYeVCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4003
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SGkgSWdvciwNCg0KT24gOC8xMi8yMSA2OjQzIFBNLCBJZ29yIFpoYmFub3Ygd3JvdGU6DQo+IEhp
IFNpbW9uLA0KPiANCj4gVGhhbmtzIGZvciB0aG9yb3VnaCByZXZpZXcuIFdpbGwgcG9zdCB0aGUg
Y29ycmVjdGVkIHZlcnNpb24gc29vbi4NCj4gDQo+Pj4gQEAgLTI3OCwxMSArMjc5LDExIEBAIGVu
ZGNob2ljZQ0KPj4+DQo+Pj4gIGNvbmZpZyBMU00NCj4+PiAgICAgICBzdHJpbmcgIk9yZGVyZWQg
bGlzdCBvZiBlbmFibGVkIExTTXMiDQo+Pj4gLSAgICAgZGVmYXVsdCAibGFuZGxvY2ssbG9ja2Rv
d24seWFtYSxsb2FkcGluLHNhZmVzZXRpZCxpbnRlZ3JpdHksc21hY2ssc2VsaW51eCx0b21veW8s
YXBwYXJtb3IsYnBmIiBpZiBERUZBVUxUX1NFQ1VSSVRZX1NNQUNLDQo+Pj4gLSAgICAgZGVmYXVs
dCAibGFuZGxvY2ssbG9ja2Rvd24seWFtYSxsb2FkcGluLHNhZmVzZXRpZCxpbnRlZ3JpdHksYXBw
YXJtb3Isc2VsaW51eCxzbWFjayx0b21veW8sYnBmIiBpZiBERUZBVUxUX1NFQ1VSSVRZX0FQUEFS
TU9SDQo+Pj4gLSAgICAgZGVmYXVsdCAibGFuZGxvY2ssbG9ja2Rvd24seWFtYSxsb2FkcGluLHNh
ZmVzZXRpZCxpbnRlZ3JpdHksdG9tb3lvLGJwZiIgaWYgREVGQVVMVF9TRUNVUklUWV9UT01PWU8N
Cj4+PiAtICAgICBkZWZhdWx0ICJsYW5kbG9jayxsb2NrZG93bix5YW1hLGxvYWRwaW4sc2FmZXNl
dGlkLGludGVncml0eSxicGYiIGlmIERFRkFVTFRfU0VDVVJJVFlfREFDDQo+Pj4gLSAgICAgZGVm
YXVsdCAibGFuZGxvY2ssbG9ja2Rvd24seWFtYSxsb2FkcGluLHNhZmVzZXRpZCxpbnRlZ3JpdHks
c2VsaW51eCxzbWFjayx0b21veW8sYXBwYXJtb3IsYnBmIg0KPj4+ICsgICAgIGRlZmF1bHQgIm5h
eCxsYW5kbG9jayxsb2NrZG93bix5YW1hLGxvYWRwaW4sc2FmZXNldGlkLGludGVncml0eSxzbWFj
ayxzZWxpbnV4LHRvbW95byxhcHBhcm1vcixicGYiIGlmIERFRkFVTFRfU0VDVVJJVFlfU01BQ0sN
Cj4+PiArICAgICBkZWZhdWx0ICJuYXgsbGFuZGxvY2ssbG9ja2Rvd24seWFtYSxsb2FkcGluLHNh
ZmVzZXRpZCxpbnRlZ3JpdHksYXBwYXJtb3Isc2VsaW51eCxzbWFjayx0b21veW8sYnBmIiBpZiBE
RUZBVUxUX1NFQ1VSSVRZX0FQUEFSTU9SDQo+Pj4gKyAgICAgZGVmYXVsdCAibmF4LGxhbmRsb2Nr
LGxvY2tkb3duLHlhbWEsbG9hZHBpbixzYWZlc2V0aWQsaW50ZWdyaXR5LHRvbW95byxicGYiIGlm
IERFRkFVTFRfU0VDVVJJVFlfVE9NT1lPDQo+Pj4gKyAgICAgZGVmYXVsdCAibmF4LGxhbmRsb2Nr
LGxvY2tkb3duLHlhbWEsbG9hZHBpbixzYWZlc2V0aWQsaW50ZWdyaXR5LGJwZiIgaWYgREVGQVVM
VF9TRUNVUklUWV9EQUMNCj4+PiArICAgICBkZWZhdWx0ICJuYXgsbGFuZGxvY2ssbG9ja2Rvd24s
eWFtYSxsb2FkcGluLHNhZmVzZXRpZCxpbnRlZ3JpdHksc2VsaW51eCxzbWFjayx0b21veW8sYXBw
YXJtb3IsYnBmIg0KPj4NCj4+IEkgZG9uJ3Qga25vdyB0aGUgcG9saWN5IHdpdGggcmVnYXJkIHRv
IG5ldyBMU01zLCBidXQgZW5hYmxpbmcgdGhpcyBvbmUgYnkgZGVmYXVsdCBpcyBtYXliZSBhIGJp
dCB2aW9sZW50Pw0KPj4gVGhhdCBzYWlkLCBjb25zaWRlcmluZyB0aGUgZGVmYXVsdCBtb2RlIGlz
IFNFQ1VSSVRZX05BWF9NT0RFX0xPRywgdGhpcyB3b3VsZCBqdXN0IGxvZyBrZXJuZWwgbWVzc2Fn
ZXMgYW5kDQo+PiBub3QgYnJlYWsgZXhpc3Rpbmcgc3lzdGVtcywgc28gdGhpcyBzaG91bGRuJ3Qg
YmUgYSBwcm9ibGVtLg0KPiANCj4gSSd2ZSBqdXN0IG9yaWVuZGVkIG9uIGxhbmRsb2NrIGFuZCBs
b2NrZG93bi4gVGhleSBhcmUgaGFuZGxlZCBpbiB0aGUgc2ltaWxhcg0KPiB3YXkuIEJ1dCwgeWVz
LCBieSBkZWZhdWx0IE5BWCBtb2R1bGUgZG9lc24ndCBibG9jayBhbnl0aGluZy4NCj4gSWYgeW91
IHN1Z2dlc3Qgbm90IHRvIGRvIHRoYXQsIEkgY2FuIHJlbW92ZSBpdC4NCg0KSWYgb3RoZXIgTFNN
cyBhcmUgYWxzbyBlbmFibGVkIGJ5IGRlZmF1bHQgd2hlbiBhZGRlZCB0byB0aGUga2VybmVsLCBh
bmQga2VlcGluZyB0aGUgaWRlYSB0aGF0IHRoZSBkZWZhdWx0IGJlaGF2aW9yDQppcyB3YXJuaW5n
LW9ubHkgKHdhcm5pbmcgaW4gYSByYXRlLWxpbWl0ZWQgZmFzaGlvbiwgYXMgeW91IHJpZ2h0ZnVs
bHkgZGlkLCBzbyBwZW9wbGUgcnVubmluZyBKSVQgZW5naW5lcyBhcyByb290DQpkb24ndCBnZXQg
dGhlaXIga2VybmVsIGxvZyBmbG9vZGVkIHdpdGggd2FybmluZ3MpLCB0aGVuIEkgaGF2ZSBubyBv
YmplY3Rpb24gdG8gdGhhdCBjaGFuZ2UuDQoNCj4gDQo+Pj4gK19fc2V0dXAoIm5heF9tb2RlPSIs
IHNldHVwX21vZGUpOw0KPj4+ICsNCj4+PiArc3RhdGljIGludCBfX2luaXQgc2V0dXBfcXVpZXQo
Y2hhciAqc3RyKQ0KPj4+ICt7DQo+Pj4gKyAgICAgdW5zaWduZWQgbG9uZyB2YWw7DQo+Pj4gKw0K
Pj4+ICsgICAgIGlmICghbG9ja2VkICYmICFrc3RydG91bChzdHIsIDAsICZ2YWwpKQ0KPj4+ICsg
ICAgICAgICAgICAgcXVpZXQgPSB2YWwgPyAxIDogMDsNCj4+DQo+PiBUaGUgb3JkZXIgb2YgdGhl
IGtlcm5lbCBwYXJhbWV0ZXJzIHdpbGwgaGF2ZSBhbiBpbXBhY3Qgb24gTkFYIGJlaGF2aW9yLg0K
Pj4NCj4+ICJuYXhfbW9kZT0xIG5heF9sb2NrZWQ9MSIgYW5kICJuYXhfbG9ja2VkPTEgbmF4X21v
ZGU9MSIgd2lsbCBlbmQgdXAgd2l0aCB0aGUgc2FtZSBiZWhhdmlvci4NCj4+IGluIHRoZSBmaXJz
dCBjYXNlIHRoZSBtb2RlIGlzIGVuZm9yY2VkLCBpbiB0aGUgc2Vjb25kIGNhc2UgaXQgaXNuJ3Qg
KHdlbGwgdW5sZXNzIHlvdSBjaGFuZ2VkDQo+PiAgdGhlIGtlcm5lbCBjb25maWd1cmF0aW9uIGZy
b20gdGhlIGRlZmF1bHQpIGFuZCBpdCBjYW4ndCBiZSBlbmFibGVkIGxhdGVyIGVpdGhlci4NCj4+
DQo+PiBJcyB0aGF0IGRlc2lyZWQ/DQo+IA0KPiBZZXMuIFRoZSBpZGVhIGlzIHRoYXQgb24gYm9v
dCB5b3UgY2FuIHNldC11cCB0aGUgcHJvcGVyIG9wdGlvbnMgdGhlbiBibG9jaw0KPiBmdXJ0aGVy
IGNoYW5naW5nIChlc3BlY2lhbGx5IHR1cm5pbmcgdGhlIG1vZHVsZSBvZmYpLg0KPiBJbml0aWFs
bHkgaXQgd2FzIGltcGxlbWVudGVkIGZvciBzeXNjdGwgcGFyYW1ldGVycywgc28sIHlvdSBjYW4g
Y2hhbmdlDQo+IHNvbWV0aGluZyBpbiBpbml0LXNjcmlwdHMsIHRoZW4gbG9jay4gVGhlbiwgSSd2
ZSBleHRlbmRlZCBpdCB0byBjb21tYW5kLWxpbmUNCj4gcGFyYW1ldGVycy4NCj4gSSBjYW4gaWdu
b3JlICJsb2NrZWQiIGZsYWcgaW4gc2V0dXBfKiBmdW5jdGlvbnMgdG8gZGVmZXIgbG9ja2luZyB0
byBzeXNjdGwNCj4gcGFyc2luZy4gKFVubGVzcyBvdXIgY29tbWFuZC1saW5lIGlzIGdsdWVkIGJ5
IHRoZSBib290bG9hZGVyIGZyb20gc2V2ZXJhbA0KPiBwYXJ0cywgc28gd2Ugd2FudCB0byBsb2Nr
IGl0IGFzIGVhcmx5IGFzIHBvc3NpYmxlLi4uKS4NCj4gDQoNCkkgbWF5IGhhdmUgYmFkbHkgbWFk
ZSBteSBwb2ludCAoZXNwZWNpYWxseSBjb25zaWRlcmluZyBJIG1hZGUgYSBsb3Qgb2YgdHlwb3Mg
d2hlbiB3cml0aW5nDQp0aGF0IG1haWwsIGZvciB3aGljaCBJIHdvdWxkIGxpa2UgdG8gYXBvbG9n
aXplKS4NCk15IHNlbnRlbmNlDQoJIm5heF9tb2RlPTEgbmF4X2xvY2tlZD0xIiBhbmQgIm5heF9s
b2NrZWQ9MSBuYXhfbW9kZT0xIiB3aWxsIGVuZCB1cCB3aXRoIHRoZSBzYW1lIGJlaGF2aW9yLg0K
bGFja2VkIHRoZSAibm90IiB3b3JkLCBhbmQgYm90aCBvcHRpb25zIHdpbGwgTk9UIGhhdmUgdGhl
IHNhbWUgYmVoYXZpb3IuDQpXaGF0IEkgd2FudGVkIHRvIHNheSB3YXMgdGhhdCBJIHRoaW5rIGJv
dGggcGFyYW1ldGVyIHNob3VsZCBoYXZlIHRoZSBzYW1lIGJlaGF2aW9yLCBhbmQgdGhhdA0KdGhl
IG9yZGVyaW5nIG9mIHRoZSBvcHRpb25zIHNob3VsZG4ndCBpbXBhY3QgdGhlIGVuZCByZXN1bHQs
IGJlY2F1c2Ugb3JkZXItZGVwZW5kZW50IG9wdGlvbnMNCm1heSBjb25mdXNlIHVzZXJzLg0KDQpG
b3IgdGhlIG1hdHRlciBvZiBoYXZlIGEga2VybmVsIGNvbW1hbmRsaW5lIGJlaW5nIHRoZSByZXN1
bHQgb2YgY29uY2F0ZW5hdGlvbnMgZnJvbSBtdWx0aXBsZQ0Kc291cmNlcywgSSB0aGluayB0aGF0
IGlmIGFueSBhdHRhY2tlciBpcyBhYmxlIHRvIGFsdGVyIHBhcnQgb2YgdGhlIGNvbW1hbmQgbGlu
ZSwgdGhleSBjYW4NCmFscmVhZHkgd3JpdGUgJ2xzbT0nIHRvIGl0IGFuZCBjb21wbGV0ZWx5IGRp
c2FibGUgTkFYLCB0aHVzIEknbSBub3Qgc3VyZSAnbmF4X2xvY2tlZCcgc2hvdWxkDQppbXBhY3Qg
b3RoZXIgc2V0dXBfKiBmdW5jdGlvbnMuDQoNCkkgYmVsaWV2ZSBrZWVwaW5nIHRoZSBuYXhfbG9j
a2VkIHBhcmFtZXRlciwgYnV0IG5vdCBjaGVja2luZyBmb3IgdGhlICdsb2NrZWQnIHN0YXR1cyBp
biB0aGUgb3RoZXIgc2V0dXBfKg0KZnVuY3Rpb25zIHNob3VsZCBiZSBlbm91Z2h0LCBhcyBzeXNj
dGxzIHdyaXRlcyB3aWxsIHN0aWxsIGJlIHByb3RlY3RlZCBieSB0aGUgJ2xvY2tlZCcgdmFyaWFi
bGUuDQoNCg0KPiBUaGFua3MuDQo+IA0KDQpUaGFua3MsDQpTaW1vbg0K
