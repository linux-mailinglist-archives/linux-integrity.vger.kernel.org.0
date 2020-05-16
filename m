Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310D01D6129
	for <lists+linux-integrity@lfdr.de>; Sat, 16 May 2020 15:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgEPNBG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 16 May 2020 09:01:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:21797 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbgEPNBG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 16 May 2020 09:01:06 -0400
IronPort-SDR: 0k2DfdMgIaplgw/DrTxUfeB0RwHCFbbT5+7Tu60m2s50leuoJICKy7UC3WkGyPseblGLHXGMZY
 OwYt+BPjEiuQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2020 06:01:05 -0700
IronPort-SDR: KCo1zU0pZZ515VJt87x9XpBhBGH2IdYZ0Lz50GEECm6T70E68b64LrK8Bc0u8Mce/Jo6wpQa/X
 QiU38h2desdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,398,1583222400"; 
   d="scan'208";a="410758019"
Received: from irsmsx110.ger.corp.intel.com ([163.33.3.25])
  by orsmga004.jf.intel.com with ESMTP; 16 May 2020 06:01:02 -0700
Received: from irsmsx601.ger.corp.intel.com (163.33.146.7) by
 irsmsx110.ger.corp.intel.com (163.33.3.25) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 16 May 2020 14:01:01 +0100
Received: from irsmsx605.ger.corp.intel.com (163.33.146.138) by
 irsmsx601.ger.corp.intel.com (163.33.146.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 16 May 2020 14:01:01 +0100
Received: from irsmsx605.ger.corp.intel.com ([163.33.146.138]) by
 IRSMSX605.ger.corp.intel.com ([163.33.146.138]) with mapi id 15.01.1713.004;
 Sat, 16 May 2020 14:01:01 +0100
From:   "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>
To:     "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>
CC:     "dhowells@redhat.com" <dhowells@redhat.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
Subject: Re: [PATCH v9 0/8] TPM 2.0 trusted keys with attached policy
Thread-Topic: [PATCH v9 0/8] TPM 2.0 trusted keys with attached policy
Thread-Index: AQHWK4IMKh60tfCq+UKbfz2+lcFewQ==
Date:   Sat, 16 May 2020 13:01:01 +0000
Message-ID: <fc542b516c9ddf0e13a68bb52728035c37a1fdf2.camel@intel.com>
References: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
         <23639de13874c00e6bb2b816b4db0b586c9a074c.camel@linux.intel.com>
         <483c4f1af7be41c8d091b11d4484b606ebd319b7.camel@linux.intel.com>
         <1589514263.5759.25.camel@HansenPartnership.com>
         <20200515084702.GA3404@linux.intel.com>
         <20200515191758.ieojyk5xhsx2hzzd@cantor>
         <1589571278.3653.22.camel@HansenPartnership.com>
         <1589573417.3653.28.camel@HansenPartnership.com>
In-Reply-To: <1589573417.3653.28.camel@HansenPartnership.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.249.40.79]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D296735DD2F534483CBBBD17D70AED3@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

T24gRnJpLCAyMDIwLTA1LTE1IGF0IDEzOjEwIC0wNzAwLCBKYW1lcyBCb3R0b21sZXkgd3JvdGU6
DQo+IE9uIEZyaSwgMjAyMC0wNS0xNSBhdCAxMjozNCAtMDcwMCwgSmFtZXMgQm90dG9tbGV5IHdy
b3RlOg0KPiA+IE9uIEZyaSwgMjAyMC0wNS0xNSBhdCAxMjoxNyAtMDcwMCwgSmVycnkgU25pdHNl
bGFhciB3cm90ZToNCj4gPiA+IE9uIEZyaSBNYXkgMTUgMjAsIEphcmtrbyBTYWtraW5lbiB3cm90
ZToNCj4gPiA+ID4gT24gVGh1LCBNYXkgMTQsIDIwMjAgYXQgMDg6NDQ6MjNQTSAtMDcwMCwgSmFt
ZXMgQm90dG9tbGV5IHdyb3RlOg0KPiA+ID4gPiA+IE9uIEZyaSwgMjAyMC0wNS0xNSBhdCAwNToy
MiArMDMwMCwgSmFya2tvIFNha2tpbmVuIHdyb3RlOg0KPiA+IA0KPiA+IFsuLi5dDQo+ID4gPiA+
ID4gPiBzdWRvIC4va2V5Y3RsLXNtb2tlLnNoDQo+ID4gPiA+ID4gPiA1NjYyMDEwNTMgKDB4ODAw
MDAwMDApDQo+ID4gPiA+ID4gPiBrZXljdGxfcmVhZF9hbGxvYzogUGVybWlzc2lvbiBkZW5pZWQN
Cj4gPiA+IA0KPiA+ID4gSSBnZXQga2V5Y3RsX3JlYWRfYWxsb2MgLUVQRVJNIHdoZW4gSSAnc3Vk
byBzdScgYW5kIHRyeSB0byBwbGF5DQo+ID4gPiB3aXRoDQo+ID4gPiBrZXljdGwgcHJpbnQuDQo+
ID4gPiBJZiBJICdzdWRvIHN1IC0nIGFuZCB0aGVuIHRyeSBpdCB3b3JrcyBhcyBleHBlY3RlZC4g
QWxzbyB3b3JrcyBmb3INCj4gPiA+IG5vcm1hbCB1c2VyLg0KPiA+IA0KPiA+IE9LLCBJIGNvbmZp
cm0gb24gZGViaWFuIGFzIHdlbGwuICBJZiBJIGNyZWF0ZSBhIGtleSBhcyByZWFsIHJvb3QgYW5k
DQo+ID4gdGhlbiB0cnkgdG8gc3VkbyBzdSBrZXljdGwgcGlwZSBpdCBhcyBhbiBvcmRpbmFyeSB1
c2VyLCBJIGdldCBFUEVSTS4NCj4gPiANCj4gPiBJdCBzbWVsbHMgbGlrZSBhIGNvY2t1cCBpbiBy
ZWFsIHZzIGVmZmVjdGl2ZSBwZXJtaXNzaW9ucyBzb21ld2hlcmUgaW4NCj4gPiB0aGUga2V5Y3Rs
IGhhbmRsZXIuDQo+IA0KPiBPSywgc28gdGhlIHByb2JsZW0gaXMNCj4gDQo+IHN1ZG8ga2V5Y3Rs
IGxpc3QgQHMNCj4gDQo+IFN0aWxsIHNob3dzIHRoZSBzZXNzaW9uIGtleXMgb2YgdGhlIHByZXZp
b3VzIHVzZXINCj4gDQo+IHRoYXQgY2F1c2VzIHN1ZG8ga2V5Y3RsIHNob3cgb24gYSByb290IG93
bmVkIGtleSB0byBmYWlsIHRoZQ0KPiBpc19rZXlfcG9zc2Vzc2VkKCkgY2hlY2ssIHJldHVybmlu
ZyAtRUFDQ0VTUyB3aGljaCBnZXRzIHRyYW5zbGF0ZWQgdG8NCj4gRVBFUk0NCj4gDQo+IGlmIHlv
dSBkbw0KPiANCj4gc3VkbyBzdSAtDQo+IA0KPiBUaGVuIGtleWN0bCBsaXN0IEBzIHNob3dzIHRo
ZSByb290IHNlc3Npb24ga2V5cmluZyBhbmQgZXZlcnl0aGluZyB3b3Jrcw0KPiANCj4gSSB0aGlu
ayB0aGF0IG1lYW5zIHRoZSBzb2x1dGlvbiBpcyBub3QgdG8gcnVuIHRoZSBzbW9rZSB0ZXN0IHVu
ZGVyIHN1ZG8NCj4gYnV0IHRvIGRvIHN1ZG8gLXMgYW5kIHRoZW4gcnVuIGl0Lg0KDQpSaWdodCwg
bWFrZXMgc2Vuc2UgYW5kIEkgY2FuIGFsc28gY29uZmlybSB0aGlzIGluIG15IGVudmlyb25tZW50
Lg0KVGhhbmtzIQ0KDQovSmFya2tvDQo=
