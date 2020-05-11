Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165631CE473
	for <lists+linux-integrity@lfdr.de>; Mon, 11 May 2020 21:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbgEKT26 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 May 2020 15:28:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:47836 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731353AbgEKT26 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 May 2020 15:28:58 -0400
IronPort-SDR: qOWj1qMPB/jyDON4YVboQqxVbcDAFv7v3qEhI5IGegPsDaY/FmvXlrzk52amQV5WTUV1Q0E5WV
 urm14gqH3gMg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 12:28:57 -0700
IronPort-SDR: QrkSUm0BdAflx7znTEOEuxo/VANzM+Fh8h/lbBMpoPYIBSQV4bPj60w12Nmn3dzghMJmVv5BYC
 rQbii0RA/tbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,381,1583222400"; 
   d="scan'208";a="279878756"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga002.jf.intel.com with ESMTP; 11 May 2020 12:28:57 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX105.amr.corp.intel.com ([169.254.2.15]) with mapi id 14.03.0439.000;
 Mon, 11 May 2020 12:28:57 -0700
From:   "Roberts, William C" <william.c.roberts@intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: Questions on SHA1 in ima_init
Thread-Topic: Questions on SHA1 in ima_init
Thread-Index: AdYnu1hfyrMZKMH8Qlu6i128wocGggAR7gUAAA5F/NA=
Date:   Mon, 11 May 2020 19:28:56 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC5649EDCC62@ORSMSX101.amr.corp.intel.com>
References: <476DC76E7D1DF2438D32BFADF679FC5649EDCB91@ORSMSX101.amr.corp.intel.com>
 <1589224468.4201.3.camel@HansenPartnership.com>
In-Reply-To: <1589224468.4201.3.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtaW50ZWdyaXR5
LW93bmVyQHZnZXIua2VybmVsLm9yZyBbbWFpbHRvOmxpbnV4LWludGVncml0eS0NCj4gb3duZXJA
dmdlci5rZXJuZWwub3JnXSBPbiBCZWhhbGYgT2YgSmFtZXMgQm90dG9tbGV5DQo+IFNlbnQ6IE1v
bmRheSwgTWF5IDExLCAyMDIwIDI6MTQgUE0NCj4gVG86IFJvYmVydHMsIFdpbGxpYW0gQyA8d2ls
bGlhbS5jLnJvYmVydHNAaW50ZWwuY29tPjsgbGludXgtDQo+IGludGVncml0eUB2Z2VyLmtlcm5l
bC5vcmcNCj4gU3ViamVjdDogUmU6IFF1ZXN0aW9ucyBvbiBTSEExIGluIGltYV9pbml0DQo+IA0K
PiBPbiBNb24sIDIwMjAtMDUtMTEgYXQgMTc6NDkgKzAwMDAsIFJvYmVydHMsIFdpbGxpYW0gQyB3
cm90ZToNCj4gPiBIZWxsbywNCj4gPg0KPiA+IEknbSBwYXJ0IG9mIHRoZSB0cG0yIHVzZXJzIHBh
Y2UgdG9vbGluZyBhbmQgbGlicmFyaWVzLCBhbmQgSSBhbSB0cnlpbmcNCj4gPiB0byB0cmFjayBk
b3duIGFuIGlzc3VlIGluIHdoZXJlIGJvb3QgYWdncmVnYXRlIGlzIG9ubHkgZXh0ZW5kZWQgaW4g
dGhlDQo+ID4gU0hBMSBiYW5rIG9mIFBDUjEwLg0KPiA+DQo+ID4gWW91IGNhbiByZWFkIHRoZSBk
ZXRhaWxzIG9uIHRoZSBsaW5rIGJlbG93LCBidXQgaWxsIHN1bW1hcml6ZSBoZXJlDQo+ID4gICAt
IGh0dHBzOi8vbGlzdHMuMDEub3JnL2h5cGVya2l0dHkvbGlzdC90cG0yQGxpc3RzLjAxLm9yZy90
aHJlYWQvRlVCDQo+ID4gRDNNWTVVNVlJQ05VWVNGM05FMlNUTzNZQVc3WTQvDQo+ID4NCj4gPiBJ
dCBsb29rcyBsaWtlIGltYV9hZGRfYm9vdF9hZ2dyZWdhdGUoKSBpcyBoYXJkY29kZWQgdG8gU0hB
MSwgb3VyIGd1ZXNzDQo+ID4gaXMsIHRoYXQgaXQncyBzbyBpdCB3b3JrcyBiZXR3ZWVuIFRQTSAx
LlggYW5kIFRQTTIuMCBjaGlwcy4gSXMgdGhhdA0KPiA+IGNvcnJlY3Q/DQo+ID4NCj4gPiBJIHdh
cyB3b25kZXJpbmcgaWYgdGhhdCBzeW5vcHNpcyBpcyBjb3JyZWN0IGFuZCBpZiB0aGVyZSB3b3Vs
ZCBiZQ0KPiA+IHRyYWN0aW9uIHRvIGFkZCBzb21ldGhpbmcgbGlrZSBxdWVyeWluZyB0aGUgdHBt
IGNoaXAgYW5kIGdldHRpbmcgdGhlDQo+ID4gdmVyc2lvbiBBbmQgcGlja2luZyBTSEEyNTYgaWYg
aXRzIHRwbTIuMCwgYXMgYSBzYW1wbGUgdG8gZ3VpZGUgdGhlDQo+ID4gZGlzY3Vzc2lvbiBJIGlu
Y2x1ZGVkIHRoZSBwYXRjaCBiZWxvdyAodG90YWxseSB1bnRlc3RlZC9ub3QtDQo+ID4gY29tcGls
ZWQpLiBUaGUgbWFpbiBkb3duc2lkZSB3b3VsZCBiZSBsZWFraW5nIFRQTSB2ZXJzaW9ucyBpbnRv
IElNQSB0bw0KPiA+IG1ha2UgYSBkZWNpc2lvbnMsIHNvIGl0IG1heSBiZSBiZXR0ZXIgdG8gaGF2
ZSBhIGhlbHBlciBpbiB0aGUgdHBtIGNvZGUNCj4gPiB0byBwaWNrIHRoZSBiZXN0IGRlZmF1bHQg
YWxnb3JpdGhtIHdoZXJlIGl0IGNvdWxkIHBpY2sgU0hBMSBmb3IgVFBNMS5YDQo+ID4gYW5kIFNI
QTI1NiBmb3IgVFBNMi4wLiBUaG91Z2h0cz8NCj4gDQo+IEkgdGhpbmsgeW91J3JlIG5vdCB0cmFj
a2luZyB0aGUgbGlzdC4gIFRoZSBjdXJyZW50IHBhdGNoIHNldCBkb2luZyB0aGlzIGFtb25nIG90
aGVyDQo+IHRoaW5ncyBpcyBoZXJlOg0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtaW50ZWdyaXR5LzIwMjAwMzI1MTA0NzEyLjI1Njk0LTEtDQo+IHJvYmVydG8uc2Fzc3VAaHVh
d2VpLmNvbS8NCj4gDQo+IFRoZSBwYXRjaCBiZWxvdyBpcyB0b28gc2ltcGxpc3RpYy4gSWYgeW91
IGZvbGxvdyB0aGUgdGhyZWFkcyBvbiB0aGUgbGlzdCwgeW91J2xsIHNlZQ0KPiB3ZSBmb3VuZCBh
IERlbGwgd2l0aCBhIFRQTTIgdGhhdCB3b24ndCBlbmFibGUgdGhlDQo+IHNoYTI1NiBiYW5rIGlm
IGl0J3Mgc2V0IGluIGJpb3MgdG8gc2hhMSBtb2RlLCB3aGljaCBpcyB3aHkgdGhlIGFjdHVhbCBw
YXRjaCBoZXJlOg0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW50ZWdyaXR5
LzIwMjAwMzI1MTA0NzEyLjI1Njk0LTEtDQo+IHJvYmVydG8uc2Fzc3VAaHVhd2VpLmNvbS8NCj4g
DQo+IENoZWNrcyB0aGUgc3VwcG9ydGVkIGJhbmtzIGFuZCB1c2VzIHNoYTI1NiBpZiBpdCdzIGxp
c3RlZC4NCj4gDQoNCk5vIEkgYW0gbm90IHRyYWNraW5nIHRoaXMgbGlzdCBhbmQgbXkgZ3JlcCBm
b28gd2FzIGZhaWxpbmcgaW4gdGhlIGFyY2hpdmVzLg0KVGhpcyBpcyBleGFjdGx5IHdoYXQgSSB3
YXMgbG9va2luZyBmb3IgLCB0aGFua3MhDQoNCj4gSmFtZXMNCj4gDQo+ID4gZGlmZiAtLWdpdCBh
L3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2luaXQuYw0KPiA+IGIvc2VjdXJpdHkvaW50ZWdy
aXR5L2ltYS9pbWFfaW5pdC5jDQo+ID4gaW5kZXggNTY3NDY4MTg4YTYxLi5kMDUxM2JhZmVlYmYg
MTAwNjQ0DQo+ID4gLS0tIGEvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfaW5pdC5jDQo+ID4g
KysrIGIvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfaW5pdC5jDQo+ID4gQEAgLTE1LDYgKzE1
LDcgQEANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3NjYXR0ZXJsaXN0Lmg+DQo+ID4gICNpbmNsdWRl
IDxsaW51eC9zbGFiLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9lcnIuaD4NCj4gPiArI2luY2x1
ZGUgPGxpbnV4L3ByaW50ay5oPg0KPiA+DQo+ID4gICNpbmNsdWRlICJpbWEuaCINCj4gPg0KPiA+
IEBAIC01OSw2ICs2MCwxNiBAQCBzdGF0aWMgaW50IF9faW5pdCBpbWFfYWRkX2Jvb3RfYWdncmVn
YXRlKHZvaWQpDQo+ID4gICAgICAgICBpaW50LT5pbWFfaGFzaC0+bGVuZ3RoID0gU0hBMV9ESUdF
U1RfU0laRTsNCj4gPg0KPiA+ICAgICAgICAgaWYgKGltYV90cG1fY2hpcCkgew0KPiA+ICsgICAg
ICAgICAgICAgICByZXN1bHQgPSB0cG1faXNfdHBtMihpbWFfdHBtX2NoaXApOw0KPiA+ICsgICAg
ICAgICAgICAgICBpZiAocmVzdWx0ID4gMCkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IC8qIHllcyBpdCdzIGEgVFBNMiBjaGlwc2V0IHVzZSBzaGEyNTYgKi8NCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICBpaW50LT5pbWFfaGFzaC0+YWxnbyA9IEhBU0hfQUxHT19TSEEyNTY7DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaWludC0+aW1hX2hhc2gtPmxlbmd0aCA9IFNIQTI1
Nl9ESUdFU1RfU0laRTsNCj4gPiArICAgICAgICAgICAgICAgfSBlbHNlIGlmIChyZXN1bHQgPCAw
KSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgLyogaWdub3JlIGVycm9ycyBoZXJlLCBh
cyB3ZSBjYW4ganVzdCBtb3ZlIG9uDQo+ID4gd2l0aCBTSEExICovDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgcHJfd2FybigiQ291bGQgbm90IHF1ZXJ5IFRQTSBjaGlwIHZlcnNpb24sDQo+
ID4gZ290OiAlZFxuIiwgcmVzdWx0KTsNCj4gPiArICAgICAgICAgICAgICAgfQ0KPiA+ICsNCj4g
PiAgICAgICAgICAgICAgICAgcmVzdWx0ID0gaW1hX2NhbGNfYm9vdF9hZ2dyZWdhdGUoJmhhc2gu
aGRyKTsNCj4gPiAgICAgICAgICAgICAgICAgaWYgKHJlc3VsdCA8IDApIHsNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICBhdWRpdF9jYXVzZSA9ICJoYXNoaW5nX2Vycm9yIjsNCj4gPg0KPiA+
DQo+ID4NCj4gPg0KPiA+DQoNCg==
