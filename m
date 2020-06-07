Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC721F0F76
	for <lists+linux-integrity@lfdr.de>; Sun,  7 Jun 2020 22:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgFGUOc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 7 Jun 2020 16:14:32 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2288 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726093AbgFGUOb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 7 Jun 2020 16:14:31 -0400
Received: from lhreml741-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 3A925397A483B6B3DAEC;
        Sun,  7 Jun 2020 21:14:29 +0100 (IST)
Received: from fraeml704-chm.china.huawei.com (10.206.15.53) by
 lhreml741-chm.china.huawei.com (10.201.108.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Sun, 7 Jun 2020 21:14:29 +0100
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sun, 7 Jun 2020 22:14:28 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1913.007;
 Sun, 7 Jun 2020 22:14:28 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>
CC:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: [GIT PULL] integrity subsystem updates for v5.8
Thread-Topic: [GIT PULL] integrity subsystem updates for v5.8
Thread-Index: AQHWO1s53vl2WKAKHUKDciwMlVYPIajNc++AgAAkf5A=
Date:   Sun, 7 Jun 2020 20:14:28 +0000
Message-ID: <7ebbfdc6a5ca447c9b19231da6e2fc9f@huawei.com>
References: <1591376548.5816.14.camel@linux.ibm.com>
 <CAHk-=whV2B4fPSkHA1Z6qEbwRTcJF0gYWBfAuqSGG+p-05HtfQ@mail.gmail.com>
In-Reply-To: <CAHk-=whV2B4fPSkHA1Z6qEbwRTcJF0gYWBfAuqSGG+p-05HtfQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.210.130]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

PiBGcm9tOiBsaW51eC1pbnRlZ3JpdHktb3duZXJAdmdlci5rZXJuZWwub3JnIFttYWlsdG86bGlu
dXgtaW50ZWdyaXR5LQ0KPiBvd25lckB2Z2VyLmtlcm5lbC5vcmddIE9uIEJlaGFsZiBPZiBMaW51
cyBUb3J2YWxkcw0KPiBTZW50OiBTdW5kYXksIEp1bmUgNywgMjAyMCA5OjU5IFBNDQo+IE9uIEZy
aSwgSnVuIDUsIDIwMjAgYXQgMTA6MDMgQU0gTWltaSBab2hhciA8em9oYXJAbGludXguaWJtLmNv
bT4gd3JvdGU6DQo+ID4NCj4gPiBUaGUgbWFpbiBjaGFuZ2VzIGFyZSBleHRlbmRpbmcgdGhlIFRQ
TSAyLjAgUENSIGJhbmtzIHdpdGggYmFuaw0KPiA+IHNwZWNpZmljIGZpbGUgaGFzaGVzLCBjYWxj
dWxhdGluZyB0aGUgImJvb3RfYWdncmVnYXRlIiBiYXNlZCBvbiBvdGhlcg0KPiA+IFRQTSBQQ1Ig
YmFua3MsIHVzaW5nIHRoZSBkZWZhdWx0IElNQSBoYXNoIGFsZ29yaXRobSwgaW5zdGVhZCBvZiBT
SEExLA0KPiA+IGFzIHRoZSBiYXNpcyBmb3IgdGhlIGNhY2hlIGhhc2ggdGFibGUga2V5LCBhbmQg
cHJldmVudGluZyB0aGUgbXByb3RlY3QNCj4gPiBzeXNjYWxsIHRvIGNpcmN1bXZlbnQgYW4gSU1B
IG1tYXAgYXBwcmFpc2UgcG9saWN5IHJ1bGUuDQo+IA0KPiBJJ20gbm90IHN1cmUgd2h5IEkgZGlk
bid0IG5vdGljZSB0aGlzIGR1cmluZyBteSB0ZXN0IGJ1aWxkcywgYnV0IHRoaXMNCj4gcmVzdWx0
cyBpbiBhIG5ldyB3YXJuaW5nOg0KPiANCj4gICBXQVJOSU5HOiBtb2Rwb3N0OiB2bWxpbnV4Lm8o
LnRleHQrMHg0OTYyNjQpOiBTZWN0aW9uIG1pc21hdGNoIGluDQo+IHJlZmVyZW5jZSBmcm9tIHRo
ZSBmdW5jdGlvbiBpbWFfY2FsY19ib290X2FnZ3JlZ2F0ZSgpIHRvIHRoZSBmdW5jdGlvbg0KPiAu
aW5pdC50ZXh0OmltYV9wY3JyZWFkKCkNCj4gICBUaGUgZnVuY3Rpb24gaW1hX2NhbGNfYm9vdF9h
Z2dyZWdhdGUoKSByZWZlcmVuY2VzDQo+ICAgdGhlIGZ1bmN0aW9uIF9faW5pdCBpbWFfcGNycmVh
ZCgpLg0KPiAgIFRoaXMgaXMgb2Z0ZW4gYmVjYXVzZSBpbWFfY2FsY19ib290X2FnZ3JlZ2F0ZSBs
YWNrcyBhIF9faW5pdA0KPiAgIGFubm90YXRpb24gb3IgdGhlIGFubm90YXRpb24gb2YgaW1hX3Bj
cnJlYWQgaXMgd3JvbmcuDQo+IA0KPiBhbmQgSSB0aGluayB0aGUgd2FybmluZyBpcyByZWFsIC0g
YW5kIHRoZSBwcm9ibGVtIGlzIHJlYWwsIG5vdCBqdXN0IGENCj4gbWlzc2luZyBhbm5vdGF0aW9u
Lg0KPiANCj4gSXQgbG9va3MgbGlrZSBpbWFfY2FsY19ib290X2FnZ3JlZ2F0ZSgpIG1heSBiZSBj
YWxsZWQgbm90IG9ubHkgYXQgaW5pdA0KPiB0aW1lIChpbWFfZXZlbnRkaWdlc3RfaW5pdCgpIGlz
IHJlZmVyZW5jZWQgZnJvbSAic3RydWN0DQo+IGltYV90ZW1wbGF0ZV9maWVsZCBzdXBwb3J0ZWRf
ZmllbGRzW10iLCBmb3IgZXhhbXBsZSkNCj4gDQo+IFNvIGNhbGxpbmcgYW4gX19pbml0IGZ1bmN0
aW9uIHdvdWxkIGJlIHZlcnkgd3JvbmcsIGJlY2F1c2UgaXQgbWlnaHQgYmUNCj4gZ29uZSBieSB0
aGF0IHRpbWUuDQo+IA0KPiBIbW0/DQoNClJpZ2h0LCBJIGFsc28gbWlzc2VkIGl0LiBXaWxsIHNl
bmQgYSBwYXRjaCBzb29uLg0KDQpSb2JlcnRvDQoNCkhVQVdFSSBURUNITk9MT0dJRVMgRHVlc3Nl
bGRvcmYgR21iSCwgSFJCIDU2MDYzDQpNYW5hZ2luZyBEaXJlY3RvcjogTGkgUGVuZywgTGkgSmlh
biwgU2hpIFlhbmxpDQo=
