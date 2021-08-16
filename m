Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E2A3ECF66
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Aug 2021 09:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhHPHbr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Aug 2021 03:31:47 -0400
Received: from mail-vi1eur05on2122.outbound.protection.outlook.com ([40.107.21.122]:63456
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233906AbhHPHbr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Aug 2021 03:31:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXHsTs78SDiwYtgc9vDpb2QHwouY32CgpCSUKd86xfNILcDORC6imJFFYQD2qWZwyj+nBq2pzwW3oPskIjz9NGZDt8CALdCNV9PxN0IJyALE6ExGty+MTrs+JCOJblxdu33O6BHbFCt/y1eck8fdj8pBrtMjTfEM1zGKGbWEzPpMZ3+e6VNslorkm7uS4wCtV4kaS6dLzKSdWXkJrUpM8wi2iIICzmJdb9HS0dqUIkKYrHvGpdkd9yfCPQaLVbc6zM/3EmPTyb9oAaZGnV8a6jZ3Y0c9YkRuBTkbvNbdw6uFkVvvhB+WoJyf73rvMDFMOO9CHu82tg1MgQGMeBKOBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/wUuA9vDAIT5s97VKbHjAz+gaf49XbU1x3Vd/gDzjM=;
 b=L7qrTTHbTTlpau+CMOAHmvlrrCo0Tb3GyW8gzeC3pgepUh1Bf6h5YZpaEH2K3fE35VZRh2Vws/kMn3zTKXg4ihiVS2yNkd8PRnnzf2YgD6Ct7HnY/iDg+TC7LjewoVBJLwv/B6rgYE+01r3KHeha5/8LQuKvtmngkWAjHdqUM9BDXC0YC+YPN8Nfy46Y2HA/FDIU+ntEMPoApceY+I/K4NDWIz2yK/8plvQLbX1rJDnERpn/Br9APZfaDKD//4zrh08ZcI/CdX0HBprEtcWIbZ3kl7r3eZIELD6bLHjJeabbEHK0IiBP/rgeJBu7ljtqiSuObM+Q5gAgQvoNNYrh6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/wUuA9vDAIT5s97VKbHjAz+gaf49XbU1x3Vd/gDzjM=;
 b=46bSsCTGasFZME1OnUeliIvZfMjkRJaRobYJ2X6Xi87LKNZTDbzV7pucJFxTPPk6gPKhYtuDAKMnMXM80g0jmTbLvtK8d/GOA4d2afYQZbdEraB0NKns7LJ5E4ufP0jSeYs/CdED/ROnzl00ELu0zLR0gYyuMWuHcIjsWPqQ8Sw=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB4482.eurprd09.prod.outlook.com
 (2603:10a6:208:16d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Mon, 16 Aug
 2021 07:31:12 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 07:31:12 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     Igor Zhbanov <izh1979@gmail.com>
CC:     Igor Zhbanov <i.zhbanov@omp.ru>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH 1/1] NAX LSM: Add initial support support
Thread-Topic: [PATCH 1/1] NAX LSM: Add initial support support
Thread-Index: AQHXg5n/AqeKwEHmDUiYDh8DD+AiWqtx92eAgAPixQA=
Date:   Mon, 16 Aug 2021 07:31:12 +0000
Message-ID: <f7296695-b181-0ffc-0e21-8cbedc11dce0@viveris.fr>
References: <db1c1de0-3672-4bae-ef45-c554379f36f4@omp.ru>
 <d97d7fdb-1676-9670-6cf5-2427f780ec6f@viveris.fr>
 <CAEUiM9NnimMa2V2xN80kMox9gyOtUqhtPV1OPK3Ea83+JkxPpQ@mail.gmail.com>
In-Reply-To: <CAEUiM9NnimMa2V2xN80kMox9gyOtUqhtPV1OPK3Ea83+JkxPpQ@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c0773ca-fc27-44e5-2757-08d96087d300
x-ms-traffictypediagnostic: AM0PR09MB4482:
x-microsoft-antispam-prvs: <AM0PR09MB4482CF500D8113392F0004B194FD9@AM0PR09MB4482.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OHbc74fQQJp21jTJW7fIyhPN388Y8lFggFso+u4yhWz8Djbh59YHvI0mtrPb0/Dz3h93gOZDM6rDxivzcI5YQGlSSlRoYGj/VKeY8uw6Y5r+SsqfhNWIb5gQu69XszjqR58tIM8j2N4q+WDCs0J1CAqlsdblP1QPBFAOo8WvVxztBZ0HLUMyzU1iIAWPdZEW4sNPieCw25CU8Bq2/OpH05mTxug2QC07GWgTh7lj2xzJ5l4OUpmnLY11W/2/S+jsmfWr0Etw13BqwpstOuYCx+MUtr4hLZhjNAL5nj/MbaFvgt4dBNeAL+uyUUkbccADYJrAfXRzYGowo6hxgfzuKZdKN83iIIzmffu+aPQMEJ1/QoDLd0IEqi3aED5GqRg9tmQiFnDXw5V1+gmTgVrUHnXXOQUg18pXORqLUQdr21/saSKJ+IXcLTxxiTRPqMuvkFZwCmPrSNsXU8fM7Id6FosO+g24ernVeKCIDWW+iISe2EQAMPEFAb3g3thYIE3VjEHhUgbqacEl8cYbDa0lOOB/vUU+ybtz0qZY+7LlP6r0oWB085JD+tq5TnMnvIGlw0G73IMACrXx7yH0u5ghh3hUce3AhxRmWQcOjLVCK7gSOtN8hJcZyACyYRbzstPWXmwzdcdYKFQB5wJyHXyEi389NBtAfY8vsOT2CPYR7o+oS+hbq0MWi+hGXrwZfX+OPsu55lNyj4S1ngnpvZuUrhVg4dK2UZOH1rVkIjUb7t72RkmpU9F0Xr5PeH2bZVeeNkx9LrSB67BpNdqTfk7X0N+YnATHhzkxIBkpodQOC/X6P0sfSo14JtN0EOhm2InIvgO0MpGYt8iwfjg935bd8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(396003)(346002)(39830400003)(64756008)(6916009)(2616005)(38070700005)(66556008)(66476007)(66946007)(83380400001)(31686004)(91956017)(76116006)(26005)(36756003)(478600001)(71200400001)(5660300002)(6506007)(53546011)(66446008)(6512007)(966005)(186003)(86362001)(316002)(6486002)(8676002)(31696002)(8936002)(38100700002)(122000001)(4326008)(54906003)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlB2WS9nRnVtcGZ4QXlweWM2YjFSc1dLVm5QUEkvZmJTVzR4VThEbDA4SktD?=
 =?utf-8?B?SnN5OGF5SE5rS2o4Z0k3cjBtVy82RnpxK3k0TUFCRzhycTRtUUpzcTVCbU1q?=
 =?utf-8?B?ajY4MmhsNGE1a1U4eUFrL2JxejBmTG1TUk9VZkFDMlIxRVRTYUp4amdxWDJw?=
 =?utf-8?B?bDIxWlBsY1hHN1hqdWxVancwTWIyeU5URUkxZ1J0OWJPbklzeXZDWmxCTmx3?=
 =?utf-8?B?NUY3SXpzWmpiU1FuQWFlNjY4bDBqZUZhWGRRQzZVeDNVakx1WUZrZUkrbVlZ?=
 =?utf-8?B?WHFqWHpocjVjYTRMdGdsdnY0UC9WSEVUR09PdGpJdUJqTzNZcVhIUkdTMHZj?=
 =?utf-8?B?d0Z2SUN6eXU2NGJXQ1VoeFFIdlJJejkraktGS2oyZmdjTXo3NExOQzRid0Qx?=
 =?utf-8?B?bmpCZ3BhSTF4TlVTUU1Tc1pEcWRjeHpGb0h4NkFMTTA2bnFET0kvUU40K3Ns?=
 =?utf-8?B?TjVodUZvc04xZUNJSFNwT3BjUFp2cVBBcXhabGZDdlpoYURUWG1TK0puYmtq?=
 =?utf-8?B?SnNyQVpvZ2MvcnNUOHBsS05KMFQwdW9kb1JCSm5nNzNsRVZxL0ZKUkdwZDZy?=
 =?utf-8?B?dWdCSks4b2xWeG1yQjFQd000MkpzT3g2S3phYzJ1RFBjcTFUeEdaN0NvRURU?=
 =?utf-8?B?NURrc3p6TnNtZmh0M09PZHlLZVozaUsyeWhjd2h6RFlmM29hNWhhcGIrdXBn?=
 =?utf-8?B?OVJGVlFiYnZ2UGhkcy9Fenp3QzlzLzM0dEk1Y3YwQm55aGpvTWs4ZWp0WGhZ?=
 =?utf-8?B?MCsrR3RpL3BGQ1p1NVN5Q0JVWTFyT3drOFlGV3ZyN1Z4cUxhY3NERU1rdHhp?=
 =?utf-8?B?RXlQLzRHQlpXeWo2UHpJNXBsMFR0TDJma3M1VzhjNmNRZ1VZcUpaR2YwR2gw?=
 =?utf-8?B?RzN6YTlwOEU1YXRSajlQMy9CS1J0TXFaT1c5VFB0Y1QvZUZvSEppU2ZLU1Fm?=
 =?utf-8?B?MnlpUFJOei93Rnh2R29HTWl6K3JlWmphNGJmeWxtSTZOdWc0a29UdkpxZDJi?=
 =?utf-8?B?LzZIaWhFZFd6RHh5K282RWdHSGVINDRPbGFxaG9idHpOY0pqaVBXQzg0R2k2?=
 =?utf-8?B?SHpTSUUvRXFYRTcyd0xNN0d3RGtTbGlLdnJsYU9jMDFqMDRWckFXMmVkYjFm?=
 =?utf-8?B?MmxYVFl1LzBTcE9yY1oyRzJzSGdyOGM4elJDQnk0SStLZE91MkJFU1VLL09Z?=
 =?utf-8?B?T1VrNkhmU1FOcGdhRGpkMUwraHJuclhpc3NMZGREcExCczYzMGppRzJzd0FN?=
 =?utf-8?B?UEJnZEVkWXFRblhhVGVidjNwK202ZkxEN2k0eHg3SXg2WXB1a1l1RnlDK0dF?=
 =?utf-8?B?TjMxSThrc2FTWmxrK3F0SStYcHE2R09Mb0pRMjBqRDFOVWpieUNJdDlyMkts?=
 =?utf-8?B?SEU2WnhDdjRzWTBlQ0lnU2Z6cVE5MnRIMnFyK1c5dUNLK1RWVjVHVlhuQmtU?=
 =?utf-8?B?MXJrU2FRVXBKYmNuZEJVMHJHQ1ZYa2QwYjZxczVzVFpSWXpFRmw2RjUxTmd2?=
 =?utf-8?B?RTkzOWhrQkRiWWZsdXpGQTBKU29aUnZ0Vi9aeVNDRjZ3TUdiaitOM2g2UCtG?=
 =?utf-8?B?MWYrUXl5cEUrblhaOXF3SHJEMzNhSzYyN2Q4ZUtOYU50dldGN0Z1NStHWkla?=
 =?utf-8?B?Rit4UXJPeEhGL0w2QnpueFIyTGNsT1Z6MUtmR1V2WjVaeW9rdU5ZWk9PWGs3?=
 =?utf-8?B?K1NOdFk0MUFrQzJrRmVJMXJEYUFUWEI0TFR0TXhVWVFzNC9ocG1SUzN0Z1pT?=
 =?utf-8?Q?TCehQh8hvz0DgzbABXTHfXU9cY/6ayizIaD8ajT?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE86D558BAD63A4280529B1E29FC2DAB@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0773ca-fc27-44e5-2757-08d96087d300
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 07:31:12.5080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dew4RTJ7+kkjnwMExeiciSRDJtwI56GSBx4lYxWcv/QhQ36tkY2mz4VRabudGDtE3ohuTh3GPsUkbEqgs3PDcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4482
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SGkgSWdvciwNCg0KT24gOC8xMy8yMSAxMDoxMCBQTSwgSWdvciBaaGJhbm92IHdyb3RlOg0KPiBI
aSBTaW1vbiwNCj4gDQo+INGB0YAsIDI4INC40Y7Quy4gMjAyMSDQsy4g0LIgMTM6MTksIFRIT0JZ
IFNpbW9uIDxTaW1vbi5USE9CWUB2aXZlcmlzLmZyPjoNCj4+IFRoZSBrZXJuZWwgc3R5bGUgZ3Vp
ZGUgbWFuZGF0ZXMgdGhhdCBhbGwgdmFyaWFibGVzIGFyZSBvbmx5IGRlZmluZWQgYXQgdGhlIGJl
Z2dpbmluZyBvZiB0aGUNCj4+IGZ1bmN0aW9uLCBhbmQgbm90IGF0IHRoZSBiZWdnaW5pbmcgb2Yg
YW55IGJsb2NrIGxpa2UgQzg5Lg0KPiANCj4gSSd2ZSBjaGVja2VkIHRoZSBrZXJuZWwgY29kaW5n
IHN0eWxlIGFuZCBjb3VsZG4ndCBmaW5kIGFueXRoaW5nIGFib3V0DQo+IHZhcmlhYmxlcyBkZWZp
bml0aW9uDQo+IHBsYWNlLiBDb3VsZCB5b3UsIHBsZWFzZSwgcG9pbnQgbWUgdG8gdGhlIHJlcXVp
cmVtZW50Pw0KDQpBZnRlciB0cnlpbmcgKHdpdGhvdXQgcmVzdWx0cykgdG8gZmluZCBpdCBpbiB0
aGUga2VybmVsIGNvZGluZyBzdHlsZSwgaXQgc2VlbXMgSSBoYXZlDQphY2NlcHRlZCBhIG1haW50
YWluZXIgcHJlZmVyZW5jZSBhcyB0aGUgb2ZmaWNpYWwgc3R5bGUgZ3VpZGUgd2l0aG91dCBjaGVj
a2luZzoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWludGVncml0eS9iZDc4NWE5ZDBj
MDI5Y2VjMzQ1MTRkMzA2ZTExMGJkZWY5NDVjMTNlLmNhbWVsQGxpbnV4LmlibS5jb20vDQooc2Vl
ICJNb3ZlIHRoZSB2YXJpYWJsZSBkZWZpbml0aW9uIHRvIHRoZSBiZWdpbm5pbmcgb2YgdGhlIGZ1
bmN0aW9uLiIpDQoNCkknbSBzb3JyeSBhYm91dCB0aGF0LCBhbmQgZm9yIHRoZSB0aW1lIHlvdSBt
YXkgaGF2ZSBsb3N0IHRyeWluZyB0byBsb2NhdGUgaXQgaW4gdGhlIHN0eWxlIGd1aWRlLCB3aGlj
aA0KZG9lc24ndCBzYXkgKGFzIGZhciBhcyBJIGNvdWxkIHNlZSkgYW55dGhpbmcgYWJvdXQgdmFy
aWFibGUgZGVjbGFyYXRpb25zLg0KDQo+IA0KPiBTY29waW5nIHZhcmlhYmxlcyBkZWNsYXJhdGlv
biBtYWtlcyB0aGUgY29kZSBiZXR0ZXIgYW5kIG1vcmUgc2VjdXJlLg0KDQpOb3QgYXJndWluZywg
SSBhZ3JlZSB3aXRoIHlvdSBvbiB0aGUgYmVuZWZpdHMgZm9yIG1haW50YWluYWJpbGl0eSBhbmQg
cmVhZGFiaWxpdHkgb2YNCmtlZXBpbmcgdmFyaWFibGUgZGVjbGFyYXRpb24gYW5kIHVzZSBsb2Nh
bGl6ZWQgKHdoaWNoIGlzIGFsc28gd2h5IEkgdGhpbmsNCidhbGxvd2VkX2NhcHNfaGV4JyB3b3Vs
ZCBiZSBiZXR0ZXIgYXMgYSBsb2NhbCB2YXJpYWJsZSkuDQoNCj4gQmVzaWRlcywgSSd2ZSBjaGVj
a2VkIHRoZSBrZXJuZWwgc291cmNlcyBhbmQgc2VlIG1hbnkgZXhhbXBsZXMgb2YgdGhhdC4NCj4g
DQo+IFRoYW5rIHlvdS4NCj4gDQoNClNvcnJ5IGFnYWluLA0KU2ltb24=
