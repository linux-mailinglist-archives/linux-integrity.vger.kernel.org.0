Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA13810F4D7
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Dec 2019 03:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfLCCLM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Dec 2019 21:11:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:61351 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbfLCCLM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Dec 2019 21:11:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 18:11:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,271,1571727600"; 
   d="scan'208";a="293630033"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga001.jf.intel.com with ESMTP; 02 Dec 2019 18:11:11 -0800
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Dec 2019 18:11:10 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.109]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.222]) with mapi id 14.03.0439.000;
 Tue, 3 Dec 2019 10:11:07 +0800
From:   "Zhao, Shirley" <shirley.zhao@intel.com>
To:     James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'Mauro Carvalho Chehab'" <mchehab+samsung@kernel.org>,
        "Zhu, Bing" <bing.zhu@intel.com>,
        "Chen, Luhai" <luhai.chen@intel.com>
Subject: RE: One question about trusted key of keyring in Linux kernel.
Thread-Topic: One question about trusted key of keyring in Linux kernel.
Thread-Index: AdWZwFKzDBwFOydYTGGk+Aqs+6BIxAANhxEAAoxRZMAAOKaagABSSevwABZzFQAAgRP1kP//pW0A//9ftMCAAMH6gP//eLrAgACO1ID//3k2UAAqYIQA//8FitA=
Date:   Tue, 3 Dec 2019 02:11:06 +0000
Message-ID: <A888B25CD99C1141B7C254171A953E8E4909E62E@shsmsx102.ccr.corp.intel.com>
References: <A888B25CD99C1141B7C254171A953E8E49094313@shsmsx102.ccr.corp.intel.com>
         <1573659978.17949.83.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E49095F9B@shsmsx102.ccr.corp.intel.com>
         <1574877977.3551.5.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E49096521@shsmsx102.ccr.corp.intel.com>
         <1575057916.6220.7.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909BA3B@shsmsx102.ccr.corp.intel.com>
         <1575260220.4080.17.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909D360@shsmsx102.ccr.corp.intel.com>
         <1575267453.4080.26.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909E381@shsmsx102.ccr.corp.intel.com>
         <1575269075.4080.31.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909E399@shsmsx102.ccr.corp.intel.com>
 <1575312932.24227.13.camel@linux.ibm.com>
In-Reply-To: <1575312932.24227.13.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzU1MDQ2OWEtOWRhNC00OWQ3LTgwMWUtZmIxYTg0MmMwMzVlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiYVA4VHRIY1Z4VVZFTGRjUDJaMm1ub2VQVzBBRkQ2bzBpb1hHWEFYWFByRnZwUGU4VkFxXC9WWjdnd1RHejFBSEQifQ==
x-ctpclassification: CTP_NT
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

VGhhbmtzIHNvIG11Y2ggZm9yIHlvdSBmZWVkYmFjaywgSmFtZXMuIA0KQW5kIGdsYWQgdG8gaGVh
ciB0aGF0IHRoZSBBUEkgd2lsbCBiZSBtYWRlIG1vcmUgZnJpZW5kbHkuIA0KDQpCdXQgSSBoYXZl
IGEgbGl0dGxlIGNvbmZ1c2VkIGFib3V0IHRoZSBjYWxsIHN0YWNrLiANCkZyb20gdGhlIGRvY3Vt
ZW50LCBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIvRG9jdW1l
bnRhdGlvbi9zZWN1cml0eS9rZXlzL3RydXN0ZWQtZW5jcnlwdGVkLnJzdCBhbmQgDQpodHRwczov
L2dpdGh1Yi5jb20vemZzb25saW51eC9kcmFjdXQvdHJlZS9tYXN0ZXIvbW9kdWxlcy5kLzk3bWFz
dGVya2V5LCB0aGUgdHJ1c3RlZCBrZXkgaXMgYSByYW5kb20gbnVtYmVyIGFuZCBnZW5lcmF0ZWQg
YnkgVFBNMi4wIGFuZCBzZWFsZWQgd2l0aCBUUE0yLjAgMjA0OCBSU0Ega2V5LiANCg0KVGhlIDIw
NDggUlNBIGtleSBpcyBnZW5lcmF0ZWQgYnkgdHBtMl9jcmVhdGVwcmltYXJ5LCBhbmQgaXQgY2Fu
IGJlIGdvdCBieSB0aGUgVFBNMi4wIGhhbmRsZSwganVzdCB0aGUgImtleWhhbmRsZSIgdXNlZCBp
biB0aGUgZm9sbG93aW5nIGtleWN0bCBjb21tYW5kLiANCiQga2V5Y3RsIGFkZCB0cnVzdGVkIGtt
ayAibmV3IDMyIGtleWhhbmRsZT0weDgxMDAwMDAxIGhhc2g9c2hhMjU2IHBvbGljeWRpZ2VzdD1g
Y2F0IHBjcjcucG9saWN5YCIgQHUNCg0KSWYgcmVib290LCB0byByZS1sb2FkIHRoZSB0cnVzdGVk
IGtleSBiYWNrIHRvIGtleXJpbmcsIGp1c3QgY2FsbCB0cG0yX3Vuc2VhbCBpcyBlbm91Z2gsIGRv
bid0IG5lZWQgdG8gY2FsbCB0cG0yX2xvYWQgdG8gbG9hZCB0aGUgVFBNMi4wIDIwNDggUlNBIGtl
eS4NCklmIHRoZSB0cnVzdGVkIGtleSBpcyBhbHNvIHByb3RlY3RlZCBieSBwb2xpY3ksIHRoZW4g
dGhlIHBvbGljeSB3aWxsIGJlIGNoZWNrZWQgZHVyaW5nIHRwbTJfdW5zZWFsLiANCg0KQWZ0ZXIg
Y2hlY2sgdGhlIHNvdXJjZSBjb2RlLCB0aGUgY2FsbCBzdGFjayBpcyBtb3N0bHkgbGlrZTogDQpT
WVNDQUxMX0RFRklORTUoYWRkX2tleSwuLi4pIC0tPiBrZXlfY3JlYXRlX29yX3VwZGF0ZSgpIC0t
PiBfX2tleV9pbnN0YW50aWF0ZV9hbmRfbGluaygpIC0tPiAgdHJ1c3RlZF9pbnN0YW50aWF0ZSgp
IC0tPiB0cG0yX3Vuc2VhbF90cnVzdGVkKCkgLS0+IHRwbTJfdW5zZWFsX2NtZCgpLg0KDQpBbm90
aGVyIHByb2JsZW0gaGVyZSBpcywgdG8gYnVpbGQgdGhlIHBvbGljeSB0byB1bnNlYWwgdGhlIGtl
eSwgaXQgbmVlZCB0byBzdGFydCBhbiBwb2xpY3kgc2Vzc2lvbiwgYW5kIHRyYW5zZmVyIHRoZSBz
ZXNzaW9uIGhhbmRsZSB0byBUUE0yLjAgdW5zZWFsIGNvbW1hbmQuIA0KSW4gbXkga2V5Y3RsIGNv
bW1hbmQsIEkgdXNlIHRwbTIuMCBjb21tYW5kIHRvIHN0YXJ0IHRoZSBzZXNzaW9uIGFuZCBnZXQg
dGhlIGhhbmRsZSwgcHV0IGl0IGludG8gdGhlIGtleWN0bCBjb21tYW5kIGxpa2U6DQprZXljdGwg
YWRkIHRydXN0ZWQga21rICJsb2FkIGBjYXQga21rLmJsb2JgIGtleWhhbmRsZT0weDgxMDAwMDAx
IHBvbGljeWhhbmRsZT0weDMwMDAwMDAiIEB1DQoNCkkgYW0gbm90IHN1cmUgd2hldGhlciBpdCBp
cyBjb3JyZWN0LiANCg0KVGhhbmtzLiANCg0KLSBTaGlybGV5IA0KDQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBKYW1lcyBCb3R0b21sZXkgPGplamJAbGludXguaWJtLmNvbT4g
DQpTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAzLCAyMDE5IDI6NTYgQU0NClRvOiBaaGFvLCBTaGly
bGV5IDxzaGlybGV5LnpoYW9AaW50ZWwuY29tPjsgTWltaSBab2hhciA8em9oYXJAbGludXguaWJt
LmNvbT47IEphcmtrbyBTYWtraW5lbiA8amFya2tvLnNha2tpbmVuQGxpbnV4LmludGVsLmNvbT47
IEpvbmF0aGFuIENvcmJldCA8Y29yYmV0QGx3bi5uZXQ+DQpDYzogbGludXgtaW50ZWdyaXR5QHZn
ZXIua2VybmVsLm9yZzsga2V5cmluZ3NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1kb2NAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyAnTWF1cm8gQ2FydmFsaG8g
Q2hlaGFiJyA8bWNoZWhhYitzYW1zdW5nQGtlcm5lbC5vcmc+OyBaaHUsIEJpbmcgPGJpbmcuemh1
QGludGVsLmNvbT47IENoZW4sIEx1aGFpIDxsdWhhaS5jaGVuQGludGVsLmNvbT4NClN1YmplY3Q6
IFJlOiBPbmUgcXVlc3Rpb24gYWJvdXQgdHJ1c3RlZCBrZXkgb2Yga2V5cmluZyBpbiBMaW51eCBr
ZXJuZWwuDQoNCk9uIE1vbiwgMjAxOS0xMi0wMiBhdCAwNjo1MCArMDAwMCwgWmhhbywgU2hpcmxl
eSB3cm90ZToNCj4gU28gSSBndWVzcyBtb3N0bHkgbGlrZSwgaXQgaXMgdGhlIGZvcm1hdCBvZiBw
b2xpY3lkaWdlc3QsIHBvbGljeWhhbmRsZSANCj4gaXMgbm90IGNvcnJlY3RseSBpbiBteSBrZXlj
dGwgY29tbWFuZC4NCj4gQnV0IHdoYXQgaXMgdGhlIGNvcnJlY3QgdXNpbmc/DQo+IA0KPiBNeSBr
ZXljdGwgY29tbWFuZHMgYXJlIGF0dGFjaGVkIGFzIGJlbG93OiANCj4gJCBrZXljdGwgYWRkIHRy
dXN0ZWQga21rICJuZXcgMzIga2V5aGFuZGxlPTB4ODEwMDAwMDEgaGFzaD1zaGEyNTYgDQo+IHBv
bGljeWRpZ2VzdD1gY2F0IHBjcjcucG9saWN5YCIgQHUNCj4gODc0MTE3MDQ1DQo+IA0KPiBTYXZl
IHRoZSB0cnVzdGVkIGtleS4gDQo+ICQga2V5Y3RsIHBpcGUgODc0MTE3MDQ1ID4ga21rLmJsb2IN
Cg0KT0ssIGxvb2tpbmcgYXQgdGhlIGFjdHVhbCBjb2RlLCBpdCBzZWVtcyB0aGF0IHdob2V2ZXIg
d3JvdGUgaXQgZGlkbid0IGFjY291bnQgZm9yIHRoZSBkaWZmZXJlbmNlcyBiZXR3ZWVuIFRQTTEu
MiBhbmQgVFBNMi4wLiAgV2l0aCBUUE0yLjAgVFBNMl9DcmVhdGUgcmV0dXJucyB0aGUgcHVibGlj
IGFuZCBwcml2YXRlIHBhcnRzIHBsdXMgdGhyZWUgb3RoZXIgdHBtMmIgZW50aXRlcyB1c2VkIHRv
IGNlcnRpZnkgYW5kIGNoZWNrIHRoZSBrZXkuICBXaGVuIHlvdSBsb2FkIHRoZSBibG9iIGJhY2sg
dXNpbmcgVFBNMl9Mb2FkLCBpdCBvbmx5IGFjY2VwdHMgdGhlIHB1YmxpYyBhbmQgcHJpdmF0ZSBw
YXJ0cy4gDQpIb3dldmVyLCB5b3VyIGJsb2IgY29udGFpbnMgdGhlIG90aGVyIGV4dHJhbmVvdXMg
ZWxlbWVudHMsIHRoYXQncyB3aHkgaXQgY2FuJ3QgYmUgbG9hZGVkLiAgWW91IGNvdWxkIG1ha2Ug
aXQgbG9hZGFibGUgYnkgc3RyaXBwaW5nIG9mZiB0aGUgZXh0cmFuZW91cyBwaWVjZXMgLi4uIGp1
c3QgdGFrZSB0aGUgZmlyc3QgdHdvIHRwbTJiIGVsZW1lbnRzIG9mIHRoZSBibG9iIGJ1dCBpdCBs
b29rcyBsaWtlIHdlIG5lZWQgdG8gZml4IHRoZSBBUEkuICBJIHN1cHBvc2UgdGhlIGdvb2QgbmV3
cyBpcyBnaXZlbiB0aGlzIGZhaWx1cmUgdGhhdCB3ZSBoYXZlIHRoZSBvcHBvcnR1bml0eSB0byBy
ZXdyaXRlIHRoZSBBUEkgc2luY2Ugbm8tb25lIGVsc2UgY2FuIGhhdmUgdXNlZCBpdCBmb3IgYW55
dGhpbmcgYmVjYXVzZSBvZiB0aGlzLiAgVGhlIGZ1bmRhbWVudGFsIHByb2JsZW0gd2l0aCB0aGUg
Y3VycmVudCBBUEkgaXMgdGhhdCBtb3N0IFRQTTIncyBvbmx5IGhhdmUgdGhyZWUgYXZhaWxhYmxl
IHNlc3Npb24gcmVnaXN0ZXJzLiAgSXQncyBzaW1wbHkgbm90IHNjYWxhYmxlIHRvIHNldCB0aGVt
IHVwIGluIHVzZXJzcGFjZSBhbmQgaGF2ZSB0aGUga2VybmVsIHVzZSB0aGVtLCBzbyB3aGF0IHdl
IHNob3VsZCBiZSBkb2luZyBpcyBwYXNzaW5nIGRvd24gdGhlIGFjdHVhbCBwb2xpY3kgYW5kIGhh
dmluZyB0aGUga2VybmVsIGNvbnN0cnVjdCB0aGUgc2Vzc2lvbiBhdCB0aGUgcG9pbnQgb2YgdXNl
IGFuZCB0aGVuIGZsdXNoIGl0LCB0aHVzIHNvbHZpbmcgdGhlIHBvdGVudGlhbCBzZXNzaW9uIGV4
aGF1c3Rpb24gaXNzdWUuDQoNCkknZCBhY3R1YWxseSBwcm9wb3NlIHdlIG1ha2UgYSBUU1NMT0FE
QUJMRSB0aGUgZnVuZGFtZW50YWwgZWxlbWVudCBvZiBvcGVyYXRpb24gZm9yIHRydXN0ZWQga2V5
cy4gIFRoZSBJQk0gYW5kIEludGVsIFRTUyBwZW9wbGUgaGF2ZSBhZ3JlZWQgdG8gZG8gdGhpcyBh
cyB0aGUgZm9ybWF0IGZvciBUUE0gbG9hZGFibGUga2V5cywgYnV0IGl0IHNob3VsZCBhbHNvIGFw
cGx5IHRvIHNlYWxlZCBkYXRhLiAgVGhlIGJlYXV0eSBvZiBUU1NMT0FEQUJMRSBpcyB0aGF0IHRo
ZSBBU04uMSBmb3JtYXQgaW5jbHVkZXMgYSBwb2xpY3kgc3BlY2lmaWNhdGlvbjoNCg0KLyoNCiAq
IFRTU0xPQURBQkxFIDo6PSBTRVFVRU5DRSB7DQogKgl0eXBlCQlPQkpFQ1QgSURFTlRJRklFUg0K
ICoJZW1wdHlBdXRoCVswXSBFWFBMSUNJVCBCT09MRUFOIE9QVElPTkFMDQogKglwb2xpY3kJCVsx
XSBFWFBMSUNJVCBTRVFVRU5DRSBPRiBUUE1Qb2xpY3kgT1BUSU9OQUwNCiAqCXNlY3JldAkJWzJd
IEVYUExJQ0lUIE9DVEVUIFNUUklORyBPUFRJT05BTA0KICoJcGFyZW50CQlJTlRFR0VSDQogKglw
dWJrZXkJCU9DVEVUIFNUUklORw0KICoJcHJpdmtleQkJT0NURVQgU1RSSU5HDQogKiB9DQogKiBU
UE1Qb2xpY3kgOjo9IFNFUVVFTkNFIHsNCiAqCUNvbW1hbmRDb2RlCQlbMF0gRVhQTElDSVQgSU5U
RUdFUg0KICoJQ29tbWFuZFBvbGljeQkJWzFdIEVYUExJQ0lUIE9DVEVUIFNUUklORw0KICogfQ0K
ICovDQoNCkphbWVzDQoNCg==
