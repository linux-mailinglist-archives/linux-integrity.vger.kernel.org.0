Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5D842AE66
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Oct 2021 23:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbhJLVDX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Oct 2021 17:03:23 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:51989 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232797AbhJLVDW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Oct 2021 17:03:22 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-209-I912YUWeNjaH_VcVetXI8A-1; Tue, 12 Oct 2021 22:01:17 +0100
X-MC-Unique: I912YUWeNjaH_VcVetXI8A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Tue, 12 Oct 2021 22:01:16 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Tue, 12 Oct 2021 22:01:16 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jarkko Sakkinen' <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     Cai Huoqing <caihuoqing@baidu.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tpm: ibmvtpm: Make use of dma_alloc_coherent()
Thread-Topic: [PATCH] tpm: ibmvtpm: Make use of dma_alloc_coherent()
Thread-Index: AQHXv5BF1vwPy+MMsUecj0afA36gwqvP2EkA
Date:   Tue, 12 Oct 2021 21:01:16 +0000
Message-ID: <ba8aefcd8c5a4e8e921e5f56e199a82f@AcuMS.aculab.com>
References: <20211010160147.590-1-caihuoqing@baidu.com>
         <31619f2f192a4f1584e458f468422cf6e8f7542f.camel@kernel.org>
         <20211012154325.GI2688930@ziepe.ca>
 <c36327cce24449b3eb79209c374514e750b38eb4.camel@kernel.org>
In-Reply-To: <c36327cce24449b3eb79209c374514e750b38eb4.camel@kernel.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogSmFya2tvIFNha2tpbmVuDQo+IFNlbnQ6IDEyIE9jdG9iZXIgMjAyMSAxODo0MQ0KPiAN
Cj4gT24gVHVlLCAyMDIxLTEwLTEyIGF0IDEyOjQzIC0wMzAwLCBKYXNvbiBHdW50aG9ycGUgd3Jv
dGU6DQo+ID4gT24gVHVlLCBPY3QgMTIsIDIwMjEgYXQgMDY6Mjk6NThQTSArMDMwMCwgSmFya2tv
IFNha2tpbmVuIHdyb3RlOg0KPiA+ID4gT24gTW9uLCAyMDIxLTEwLTExIGF0IDAwOjAxICswODAw
LCBDYWkgSHVvcWluZyB3cm90ZToNCj4gPiA+ID4gUmVwbGFjaW5nIGttYWxsb2Mva2ZyZWUvZ2V0
X3plcm9lZF9wYWdlL2ZyZWVfcGFnZS9kbWFfbWFwX3NpbmdsZS8NCj4gPiA+IMKgIH5+fn5+fn5+
fg0KPiA+ID4gwqAgUmVwbGFjZQ0KPiA+ID4NCj4gPiA+ID4gZG1hX3VubWFwX3NpbmdsZSgpIHdp
dGggZG1hX2FsbG9jX2NvaGVyZW50L2RtYV9mcmVlX2NvaGVyZW50KCkNCj4gPiA+ID4gaGVscHMg
dG8gcmVkdWNlIGNvZGUgc2l6ZSwgYW5kIHNpbXBsaWZ5IHRoZSBjb2RlLCBhbmQgY29oZXJlbnQN
Cj4gPiA+ID4gRE1BIHdpbGwgbm90IGNsZWFyIHRoZSBjYWNoZSBldmVyeSB0aW1lLg0KPiA+ID4g
Pg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBDYWkgSHVvcWluZyA8Y2FpaHVvcWluZ0BiYWlkdS5j
b20+DQo+ID4gPg0KPiA+ID4gSWYgdGhpcyBkb2VzIG5vdCBkbyBmdW5jdGlvbmFsbHkgYW55dGhp
bmcgdXNlZnVsLCB0aGVyZSdzIG5vDQo+ID4gPiByZWFzb24gdG8gYXBwbHkgdGhpcy4NCj4gPg0K
PiA+IEF0IGxlYXN0IGluIHRoaXMgY2FzZSBpdCBsb29rcyBsaWtlIHRoZSBpYm12dHBtIGlzIG5v
dCB1c2luZyB0aGUgRE1BDQo+ID4gQVBJIHByb3Blcmx5LiBUaGVyZSBpcyBubyBzeW5jIGFmdGVy
IGVhY2ggZGF0YSB0cmFuc2Zlci4gUmVwbGFjaW5nDQo+ID4gdGhpcyB3cm9uZyB1c2FnZSB3aXRo
IHRoZSBjb2hlcmVudCBBUEkgaXMgcmVhc29uYWJsZS4NCj4gDQo+IFRoYW5rIHlvdS4gQXMgbG9u
ZyBhcyB0aGlzIGlzIGRvY3VtZW50ZWQgdG8gdGhlIGNvbW1pdCBtZXNzYWdlLA0KPiBJJ20gY29v
bCB3aXRoIHRoZSBjaGFuZ2UgaXRzZWxmLg0KPiANCj4gRS5nLiBzb21ldGhpbmcgbGlrZSB0aGlz
IHdvdWxkIGJlIHBlcmZlY3RseSBmaW5lIHJlcGxhY2VtZW50IGZvciB0aGUNCj4gY3VycmVudCBj
b21taXQgbWVzc2FnZToNCj4gDQo+ICJUaGUgY3VycmVudCB1c2FnZSBwYXR0ZXJuIGZvciB0aGUg
RE1BIEFQSSBpcyBpbmFwcHJvcHJpYXRlLCBhcw0KPiBkYXRhIHRyYW5zZmVycyBhcmUgbm90IHN5
bmNlZC4gUmVwbGFjZSB0aGUgZXhpc3RpbmcgRE1BIGNvZGUNCj4gd2l0aCB0aGUgY29oZXJlbnQg
RE1BIEFQSS4iDQoNCldoeSBub3QgYWxzbyBzYXkgdGhhdCB0aGUgRE1BIGFjY2VzcyBzbm9vcCB0
aGUgY2FjaGU/DQooSSB0aGluayB0aGF0IHdhcyBtZW50aW9uZWQgZWFybGllciBpbiB0aGUgdGhy
ZWFkLikNCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxl
eSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0
aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

