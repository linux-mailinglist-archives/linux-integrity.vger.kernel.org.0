Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 786A0198043
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Mar 2020 17:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbgC3P4j (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Mar 2020 11:56:39 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2619 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726497AbgC3P4j (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Mar 2020 11:56:39 -0400
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 333CFAF894D5E1DDADC2;
        Mon, 30 Mar 2020 16:56:38 +0100 (IST)
Received: from fraeml702-chm.china.huawei.com (10.206.15.51) by
 LHREML712-CAH.china.huawei.com (10.201.108.35) with Microsoft SMTP Server
 (TLS) id 14.3.487.0; Mon, 30 Mar 2020 16:56:37 +0100
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 30 Mar 2020 17:56:37 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1913.007;
 Mon, 30 Mar 2020 17:56:37 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "matthewgarrett@google.com" <matthewgarrett@google.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: Immutable metadata
Thread-Topic: Immutable metadata
Thread-Index: AdYE5l5uAUZNHIlESc2JQvQGvX4yuwBQTyyAAByCloAABDn24A==
Date:   Mon, 30 Mar 2020 15:56:37 +0000
Message-ID: <378d0dea0ccb49b8a0f0e58301328b5a@huawei.com>
References: <ff12bbbd945545a988ef84d6e4d3b83d@huawei.com>
         <1585534223.5188.408.camel@linux.ibm.com>
 <1585583203.5188.418.camel@linux.ibm.com>
In-Reply-To: <1585583203.5188.418.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.5.91]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaW1pIFpvaGFyIFttYWlsdG86
em9oYXJAbGludXguaWJtLmNvbV0NCj4gU2VudDogTW9uZGF5LCBNYXJjaCAzMCwgMjAyMCA1OjQ3
IFBNDQo+IFRvOiBSb2JlcnRvIFNhc3N1IDxyb2JlcnRvLnNhc3N1QGh1YXdlaS5jb20+Ow0KPiBt
YXR0aGV3Z2FycmV0dEBnb29nbGUuY29tDQo+IENjOiBsaW51eC1pbnRlZ3JpdHlAdmdlci5rZXJu
ZWwub3JnOyBTaWx2aXUgVmxhc2NlYW51DQo+IDxTaWx2aXUuVmxhc2NlYW51QGh1YXdlaS5jb20+
DQo+IFN1YmplY3Q6IFJlOiBJbW11dGFibGUgbWV0YWRhdGENCj4gDQo+IE9uIFN1biwgMjAyMC0w
My0yOSBhdCAyMjoxMCAtMDQwMCwgTWltaSBab2hhciB3cm90ZToNCj4gPiBIaSBSb2JlcnRvLA0K
PiA+DQo+ID4gT24gU2F0LCAyMDIwLTAzLTI4IGF0IDExOjE4ICswMDAwLCBSb2JlcnRvIFNhc3N1
IHdyb3RlOg0KPiA+ID4gSGkgTWF0dGhldywgTWltaQ0KPiA+ID4NCj4gPiA+IEkgaGF2ZSBhIHF1
ZXN0aW9uIGFib3V0IHBvcnRhYmxlIHNpZ25hdHVyZXMuIElzIHRoZXJlIGFueSBwYXJ0aWN1bGFy
DQo+IHJlYXNvbg0KPiA+ID4gd2h5IGEgd3JpdGUgdG8gYSBmaWxlIGlzIG5vdCBkZW5pZWQgYnkg
SU1BIGlmIG1ldGFkYXRhIGFyZSBpbW11dGFibGU/DQo+ID4NCj4gPiBBcyBtdWNoIGFzIHBvc3Np
YmxlLCBJTUEgYW5kIEVWTSBzaG91bGQgYmUgaW5kZXBlbmRlbnQgb2YgZWFjaCBvdGhlci4NCj4g
PiDCoEVWTSBpcyByZXNwb25zaWJsZSBmb3IgdGhlIGludGVncml0eSBvZiBmaWxlIG1ldGFkYXRh
LCBzbyBpdCBuZWVkcyB0bw0KPiA+IHJlYWQgb3RoZXIgc2VjdXJpdHkgeGF0dHJzLCBidXQgSU1B
IHNob3VsZG4ndCBiZSBsb29raW5nIGF0IHRoZSBFVk0NCj4gPiB4YXR0ci4NCj4gPg0KPiA+IExp
a2UgYW55IG90aGVyIHNlY3VyaXR5IHhhdHRyLCByZXNwb25zaWJpbGl0eSBmb3IgbWFpbnRhaW5p
bmcgdGhlDQo+ID4geGF0dHIgaXMgbGVmdCB1cCB0byB0aGUgcGFydGljdWxhciBMU00uIMKgSW4g
dGhpcyBjYXNlLCBFVk0gd291bGQgbmVlZA0KPiA+IHRvIHByZXZlbnQgdGhlIGZpbGUgZnJvbSBi
ZWluZyBvcGVuZWQgcncuIMKgU2hvdWxkIHRoYXQgYmUgaGFyZCBjb2RlZA0KPiA+IG9yIGJhc2Vk
IG9uIGFuIEVWTSBwb2xpY3k/DQo+IA0KPiBUaGlua2luZyBhYm91dCB0aGlzIGEgYml0IG1vcmUs
IGV2bV92ZXJpZnl4YXR0cigpIGlzIGFscmVhZHkgcmV0dXJuaW5nDQo+IElOVEVHUklUWV9QQVNT
X0lNTVVUQUJMRS4gwqBJIGd1ZXNzIElNQSBjb3VsZCBtYWtlIGRlY2lzaW9ucyBiYXNlZCBvbg0K
PiBpdC4NCg0KWWVzLCB0aGlzIHdhcyB0aGUgaWRlYS4NCg0KSSB3b3VsZCBzYXkgYWxzbyB0aGF0
IGZpbGVzIHdpdGggcG9ydGFibGUgc2lnbmF0dXJlcyBmdWxmaWxsIHRoZSBhcHByYWlzZV90eXBl
PWltYXNpZw0KcmVxdWlyZW1lbnQuIEkgd291bGQgc2V0IHRoZSBJTUFfRElHU0lHIGJpdCBpbiBp
aW50LT5hdG9taWNfZmxhZ3MuIElzIGl0IG9rPw0KDQpUaGFua3MNCg0KUm9iZXJ0bw0KDQpIVUFX
RUkgVEVDSE5PTE9HSUVTIER1ZXNzZWxkb3JmIEdtYkgsIEhSQiA1NjA2Mw0KTWFuYWdpbmcgRGly
ZWN0b3I6IExpIFBlbmcsIExpIEppYW4sIFNoaSBZYW5saQ0K
