Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A813F3EC9
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Aug 2021 11:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbhHVJBX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 22 Aug 2021 05:01:23 -0400
Received: from mail-vi1eur05on2133.outbound.protection.outlook.com ([40.107.21.133]:24161
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231147AbhHVJBX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 22 Aug 2021 05:01:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRArsZLn6b1DAYS4HNj6c2r/sr0o2854ww7OsaOJjEjT7wj0htYja7jIOv1xKOhvfQyxkOuVrFRq9wqd5XUFJsh8b3hszrJOxOQlc1l/mStjeVriVlnIEZV01Hgf/zJ5XykwH5QhVjtpFzobS+8UX+XB/97pCrmqWjrjv6KOO2pHi23Fa4jxH1mYl4zN+sv0TNxT8QSMm8e/W844TG/rIxE9UchR566/4QqUBgCUP92A2vZAnlWL9cvPoIpmSqeHnaBR6wYVpT8OzAkM/pXrwo4hdCqYdSp5AKgX6tql/mKSINovui3HvHRvSsphW+Q86pzUeTl2wHOyJJtNBxpR3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWOtc0Sy6RPaCMo+ODuy+vclruPNNH7wUOH+Gq+wlZQ=;
 b=L0OCrLmeNCZjW+g6IPLQt88rHajn6b3m71Swj4YShSYsdqaWNW1mnToKhZd2m9zcUhJaJ0bPmv2KBU1LDbyoIh9fNswje4RfpWLT1ceVNfrK5u1Foycy5ICzaCApBo4ZTzDJWvbVUMkkew0TRZubVttLxqlSH2weydiC3hobM0TshH94vn6itdDJwlTvHo04ITavw5U+jUU6sTaRd+Cx5fByLPRSDmGowUxN2CSZUHOLmD2yRzGwrllAPVUigqkm7hGUb6veKbrn5k4zsRiidG+kUzL0c9UxGyfoAq7Ck/e2zIf5AyitUPq9Adsso0Rs5Ro+tspwGh+UqKUfzRpsRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWOtc0Sy6RPaCMo+ODuy+vclruPNNH7wUOH+Gq+wlZQ=;
 b=ndvaxEUZn35e9ykz3c/mPPWW9VXpdvqqUY6Wh2XX2TxWTHf2g4GcQV4RThkZZ2VwVBKilpjwrqoooj0ppPhbpLhTIqfy/oT9EeWJThRDmIOMPQW5qu8pQPtNSflZ6ChwBf8KvStDyWDNVpJ0aY5jXWzI3+eD0KHU3JBx1XB/TmQ=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM9PR09MB4786.eurprd09.prod.outlook.com
 (2603:10a6:20b:2d8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Sun, 22 Aug
 2021 09:00:39 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4436.023; Sun, 22 Aug 2021
 09:00:38 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     "nramas@linux.microsoft.com" <nramas@linux.microsoft.com>,
        "syzbot+e8bafe7b82c739eaf153@syzkaller.appspotmail.com" 
        <syzbot+e8bafe7b82c739eaf153@syzkaller.appspotmail.com>
Subject: Re: [PATCH] IMA: reject unknown hash algorithms in ima_get_hash_algo
Thread-Topic: [PATCH] IMA: reject unknown hash algorithms in ima_get_hash_algo
Thread-Index: AQHXlzNzlHGs/yvMiUCFw3wJEmV8JKt/OfGA
Date:   Sun, 22 Aug 2021 09:00:38 +0000
Message-ID: <892b127f-d929-68da-7709-fa001935bfae@viveris.fr>
References: <20210822085522.3416-1-Simon.THOBY@viveris.fr>
In-Reply-To: <20210822085522.3416-1-Simon.THOBY@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9a2cd56-32f7-4e0f-a612-08d9654b4ff4
x-ms-traffictypediagnostic: AM9PR09MB4786:
x-microsoft-antispam-prvs: <AM9PR09MB47862171F3A67E514DF37EAC94C39@AM9PR09MB4786.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TNVds7svM9DNw+XH7Q4P9+ObI3E9IWmKv54WqtwzYkxKIn9i8EaX3CTjX4cZ0tX7NlgkF5NoB/uEY5rL2ttAVAY+4EQgVkpXsJLb49+Y+GT6vcuJLYPIg4i8W0fkg7sZgxHOmweknGjal1LTYKp5DraY5dtCSCXde7NDJ6d0Dcxo0rg9OLYkqgy0bsZQwIl325HPcsWfE0Ac1eGbrDQLVp08h+a9OOIVFpPiuyWoi/cQaKMHKIwDwoJFqqOUiF2vHf5iahCgttxWEhuIQ0sIAEOctkNA7G8uKIWx9pXqP7338UoTwzgxmKZoGA/l7ddY2r6Ah0QzI19aonDufC/2zoj3Cd+flgn2u657UlbbeRtQOcmZCE+qiFmxwOhrtcbnc56ZH7mypWDtCR7ve+6Ba548Es94bqNwA1QidU4edlooSSaoUJfEEjGF4vODI7kaKz/YVKFlNAPNPFpgKFlFXM+9mKkBTFEqM35K4M8vS2BbF6lVCoWRvjkMN9uWLh7JtfXRsDmJViUrnvfud78JNv3HpnLzInlVghDe3kImCB4CM7NExx/QBsNFlaDfw5WG28P5Yb4xwtyOjCYQ7Yjm0Cf4zxLig4YIEFl3Eck4tqYJIBUMlUBDg6LDV9HDRcnJC5Ni5DoZpeQx4TFYjmGs8yox8qVnzEk5kRHTX+eEk7LDPEVz8HFTMkU9m0vIm+xzFvP0YiVM604cKdQ5ceFFj8EUMrJY0BqUAED8i4W8UkcUP/s5wMDzrDXFbPG7+X2kpsS/XJzOoy/dle9VOXnBJ/XbczJ3NuLOZ6Ah10Wn8NbRBe74bREt9inqp80g4UBJHq1iWr3YKr1YfIK+ISDOMGiJS8c2Y0G/RbvjhvUNE/I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39830400003)(396003)(376002)(366004)(6512007)(186003)(86362001)(6486002)(66946007)(31696002)(966005)(8936002)(478600001)(53546011)(26005)(6506007)(2616005)(8676002)(110136005)(83380400001)(36756003)(54906003)(122000001)(71200400001)(38070700005)(38100700002)(316002)(91956017)(4326008)(66476007)(64756008)(66556008)(66446008)(76116006)(2906002)(31686004)(5660300002)(99710200001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bk5UNVZ6ajdkS0U2QzVzdHZkejJrWTZTQjQ2N2NnemxheVNuczRnM2FsalVY?=
 =?utf-8?B?c1ZNRXlzSjBnMjZIeGxnTXVCZDREV242ZXpQNDBMNm8xZWk5THVqeW5rcVZr?=
 =?utf-8?B?NnduNHB4bmRreWl5WnZUdm42ZHBxc0FaQmxhVnIvcDJTc01zeTBMQm5OQ2hN?=
 =?utf-8?B?YS9ibmVWTUtLa0VtVmtCaXhxNkRZMXNFK2p2clV2VWV3UHJVdkF1T3p5VlN2?=
 =?utf-8?B?WEZTYW9yRml1Wk1wT25xOTNXTHd6UUJTaVhwUW0yVlZ0bTg2dzY5bXN3M0U0?=
 =?utf-8?B?c0xnUTA3YkhGSkIvT05qQ3lhNkEyVVp0U3Vqdnd6SC9WQmdqUEhwb3ZYUW1K?=
 =?utf-8?B?L2cvWDdnTk9zcEZSbG9KYVluVzhnczQyNWZ4R2xnWks2c3RQaDJyMCsxQXpo?=
 =?utf-8?B?OEZYYjRnb1BRYWxvKytZQ3F0RUVxZXdQYjUyVnh2ZGNJSTcrSXdsWjVqNkQ4?=
 =?utf-8?B?RmNpTVd1b1BsY2R4ZDM3RjlZcXZ1WUJFNGdtN2NBdmFMM2F0MWVRdUw4VVJw?=
 =?utf-8?B?Ly9aaU5UMC95dHcycDVMbVYzTWdHcVBMbmtyUExEUGxuYU9CN05uS1BscUFs?=
 =?utf-8?B?QkVlakR1NjYzeDlsYnBuTk9CQWZ6T05NR3AveVUzTUxpbS9VTVBUYkIyMGtP?=
 =?utf-8?B?R0VpUWFxS1AzK2FLRGc3UXlwN3lJamVXOXR2WC8wcHp3ZE5CTTJxTXNEczAw?=
 =?utf-8?B?dGpBVWkvL2VvMGtQZ3ZDb3Z2eWxCb0hjbTNCd2c5UzVYTldUaHN4cHViemZs?=
 =?utf-8?B?VkJRaEVyclduZnNRMk1Pbk9DVEp0VHMrSDJySWdBTXhjelpmQnQwOE5IQzhT?=
 =?utf-8?B?SU9adkhKQVkzUkRwcW9CeE5zSFliL3FsdGEzWkc3NVRRRVNrdmNzQjkrUEtQ?=
 =?utf-8?B?Z29PY0pFdWg5OXdCZVZWNDl4a0hNNnZIWTAwak03TldVeDgvbnB5VFo1WEg3?=
 =?utf-8?B?NkJYOXlSVGhhb0w5S2w5NXZhbVJiNHA4WFVjT0VTSFJadzMvSExmQmlxR1ZY?=
 =?utf-8?B?ZG5OaWJYT0pnL0RZdzJvL21Iemk5S3lVZjZUTDcyQkNsazRoYnZ5c2hQdFN4?=
 =?utf-8?B?cmFKaGhaRlFTbENGakFRL3J1K3N5YWhsNlc4SXcrMlg2MTQwQUNzVVNSNlJZ?=
 =?utf-8?B?LzRldXc5SkpEdEtVVVZubTdXWEFmMys1VDRjWDRkNGw1RldTZUJmMlVWenNI?=
 =?utf-8?B?R2tzMzFhRktVU3JTT2t2UU5NL2ExaTJzL2lPZjNUM3hCZzBLaXY2SlpDZFFh?=
 =?utf-8?B?aURDZmJYZitHekJrbUhjSWx5ajN1L0NzSHBDTkRkNDNYalJYTjIzT0lJUk1r?=
 =?utf-8?B?WW9CbUdLaG9SZS84TjRtTWZwQ0FnRjJZMVdxVFB0WUVsQXpPdkNaQTgvUTVa?=
 =?utf-8?B?czRrWll4L2wyeTc5MDBwak9pckJGMkpDYldnRXN1VTREZ0Q2UGRxVFdWbFc1?=
 =?utf-8?B?UUV2QzJVVWx1ZUZmTXh5N2sxTnYwM1F1aCtCMjd6R2xmVEMvbnd5NXBOOVNR?=
 =?utf-8?B?Yzg3dXZFRzV3QVJMMFlzL1k4QWttVUI2VWM5KzhrdHM4RStBalFaK2thdGdi?=
 =?utf-8?B?SEVPY2cxSXBCRDZqMEs3aEtnOERpSE80STkwanJVMWcrMGJzREFnTEd1MzZj?=
 =?utf-8?B?OTc0SVIzeW9xUHpiTENSa0gxTS96YzBRWVFBeEMyV201MHVxV1hIVXFRZyt2?=
 =?utf-8?B?QWIwaWVhQm1vb0pTRk10eGRTdkZQd3VybHhnL1U1Skgrekc1a21NT1lWd3dR?=
 =?utf-8?B?Z1JNZDcyNUZRSURKbk0xVkFVT2FUSEVqRm5sbDc2N0RYT2NOYkxqUzF6eU91?=
 =?utf-8?B?V0NrMWphT281OEdUZkkydz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <15F07C39403B7D4F90170BE4C39FC00E@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a2cd56-32f7-4e0f-a612-08d9654b4ff4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2021 09:00:38.6992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z4CNByHMK9jIzqWQjpZCuXbnPjw16oz8lVY+UA2aPnW+tJLrcn7sr8sfcEeAeEdMN65RXeSj0kJd2psJFuLkBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR09MB4786
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

T24gOC8yMi8yMSAxMDo1NSBBTSwgVEhPQlkgU2ltb24gd3JvdGU6DQo+IFRoZSBuZXcgZnVuY3Rp
b24gdmFsaWRhdGVfaGFzaF9hbGdvKCkgYXNzdW1lZCB0aGF0IGltYV9nZXRfaGFzaF9hbGdvKCkN
Cj4gYWx3YXlzIHJldHVybiBhIHZhbGlkICdlbnVtIGhhc2hfYWxnbycsIGJ1dCBpdCByZXR1cm5l
ZCB0aGUNCj4gdXNlci1zdXBwbGllZCB2YWx1ZSBwcmVzZW50IGluIHRoZSBkaWdpdGFsIHNpZ25h
dHVyZSB3aXRob3V0DQo+IGFueSBib3VuZHMgY2hlY2tzLg0KPiANCj4gVXBkYXRlIGltYV9nZXRf
aGFzaF9hbGdvKCkgdG8gYWx3YXlzIHJldHVybiBhIHZhbGlkIGhhc2ggYWxnb3JpdGhtLA0KPiBk
ZWZhdWx0aW5nIG9uICdpbWFfaGFzaF9hbGdvJyB3aGVuIHRoZSB1c2VyLXN1cHBsaWVkIHZhbHVl
IGluc2lkZQ0KPiB0aGUgeGF0dHIgaXMgaW52YWxpZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRI
T0JZIFNpbW9uIDxTaW1vbi5USE9CWUB2aXZlcmlzLmZyPg0KPiBSZXBvcnRlZC1ieTogc3l6Ym90
K2U4YmFmZTdiODJjNzM5ZWFmMTUzQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20NCj4gRml4ZXM6
IDUwZjc0MmRkOTE0NyAoIklNQTogYmxvY2sgd3JpdGVzIG9mIHRoZSBzZWN1cml0eS5pbWEgeGF0
dHIgd2l0aA0KPiB1bnN1cHBvcnRlZCBhbGdvcml0aG1zIikNCj4gUmV2aWV3ZWQtYnk6IExha3No
bWkgUmFtYXN1YnJhbWFuaWFuIDxucmFtYXNAbGludXgubWljcm9zb2Z0LmNvbT4NCj4gLS0tDQo+
ICBzZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9hcHByYWlzZS5jIHwgMyArKy0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9hcHByYWlzZS5jIGIvc2VjdXJpdHkvaW50
ZWdyaXR5L2ltYS9pbWFfYXBwcmFpc2UuYw0KPiBpbmRleCA4ZjFlYjdlZjA0MWUuLmRiYmE1MTU4
M2U3YyAxMDA2NDQNCj4gLS0tIGEvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfYXBwcmFpc2Uu
Yw0KPiArKysgYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9hcHByYWlzZS5jDQo+IEBAIC0x
ODUsNyArMTg1LDggQEAgZW51bSBoYXNoX2FsZ28gaW1hX2dldF9oYXNoX2FsZ28oY29uc3Qgc3Ry
dWN0IGV2bV9pbWFfeGF0dHJfZGF0YSAqeGF0dHJfdmFsdWUsDQo+ICAJc3dpdGNoICh4YXR0cl92
YWx1ZS0+dHlwZSkgew0KPiAgCWNhc2UgRVZNX0lNQV9YQVRUUl9ESUdTSUc6DQo+ICAJCXNpZyA9
ICh0eXBlb2Yoc2lnKSl4YXR0cl92YWx1ZTsNCj4gLQkJaWYgKHNpZy0+dmVyc2lvbiAhPSAyIHx8
IHhhdHRyX2xlbiA8PSBzaXplb2YoKnNpZykpDQo+ICsJCWlmIChzaWctPnZlcnNpb24gIT0gMiB8
fCB4YXR0cl9sZW4gPD0gc2l6ZW9mKCpzaWcpDQo+ICsJCSAgICB8fCBzaWctPmhhc2hfYWxnbyA+
PSBIQVNIX0FMR09fX0xBU1QpDQo+ICAJCQlyZXR1cm4gaW1hX2hhc2hfYWxnbzsNCj4gIAkJcmV0
dXJuIHNpZy0+aGFzaF9hbGdvOw0KPiAgCQlicmVhazsNCj4gDQoNCk9vcHMsIEkgZm9yZ290IHRv
IHVwZGF0ZSB0aGUgcGF0Y2ggdmVyc2lvbiwgYW5kIHRvIGFkZCBhIGNoYW5nZWxvZy4NCkhlcmUg
aXQgaXM6DQotIFVwZGF0aW5nIHRoZSBjb21taXQgbWVzc2FnZQ0KLSBBZGRpbmcgdGhlICdGaXhl
czonIGFuZCAnUmV2aWV3ZWQtYnk6JyBhbm5vdGF0aW9ucw0KDQpBcyB0aGUgcGF0Y2ggY29udGVu
dCBkaWRuJ3QgY2hhbmdlLCB0aGUgY29tbWVudCBvbiANCnN5c3pib3QgKCJUaGlzIHBhdGNoIHdh
cyBzdWNjZXNzZnVsbHkgdGVzdGVkIGJ5IHN5c3pib3QsIHNlZQ0KaHR0cHM6Ly9zeXprYWxsZXIu
YXBwc3BvdC5jb20vYnVnP2V4dGlkPWU4YmFmZTdiODJjNzM5ZWFmMTUzLiIpDQppcyBzdGlsbCB0
cnVlLg0KDQpTb3JyeSBhYm91dCB0aGF0LA0KU2ltb24=
