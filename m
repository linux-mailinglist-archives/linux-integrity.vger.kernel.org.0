Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3625336D36B
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Apr 2021 09:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhD1Htg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Apr 2021 03:49:36 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2933 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhD1Htd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Apr 2021 03:49:33 -0400
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FVVws4j2qz685Yc;
        Wed, 28 Apr 2021 15:43:09 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Apr 2021 09:48:47 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Wed, 28 Apr 2021 09:48:47 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "mjg59@google.com" <mjg59@google.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 04/11] ima: Move ima_reset_appraise_flags() call to
 post hooks
Thread-Topic: [PATCH v4 04/11] ima: Move ima_reset_appraise_flags() call to
 post hooks
Thread-Index: AQHXEdMA2oN9D131skWV9JJ8Z5VEUap1limAgFHPEQCAAOj3gIAAYluAgAAixgD//+9mgIABHETQ
Date:   Wed, 28 Apr 2021 07:48:46 +0000
Message-ID: <24cd7c6a3e36451691f70ed153ab3e75@huawei.com>
References: <20210305151923.29039-1-roberto.sassu@huawei.com>
 <20210305151923.29039-5-roberto.sassu@huawei.com>
 <c3bb1069-c732-d3cf-0dde-7a83b3f31871@schaufler-ca.com>
 <93858a47a29831ca782c8388faaa43c8ffc3f5cd.camel@linux.ibm.com>
 <7a39600c24a740838dca24c20af92c1a@huawei.com>
 <d047d1347e7104162e0e36eb57ade6bba914ea2d.camel@linux.ibm.com>
 <d783e2703248463f9af68e155ee65c38@huawei.com>
 <3354e1a0-bca2-2cb9-6e82-7209b9106008@schaufler-ca.com>
In-Reply-To: <3354e1a0-bca2-2cb9-6e82-7209b9106008@schaufler-ca.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.221.98.153]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

PiBGcm9tOiBDYXNleSBTY2hhdWZsZXIgW21haWx0bzpjYXNleUBzY2hhdWZsZXItY2EuY29tXQ0K
PiBTZW50OiBUdWVzZGF5LCBBcHJpbCAyNywgMjAyMSA2OjQwIFBNDQo+IE9uIDQvMjcvMjAyMSA4
OjU3IEFNLCBSb2JlcnRvIFNhc3N1IHdyb3RlOg0KPiA+PiBGcm9tOiBNaW1pIFpvaGFyIFttYWls
dG86em9oYXJAbGludXguaWJtLmNvbV0NCj4gPj4gU2VudDogVHVlc2RheSwgQXByaWwgMjcsIDIw
MjEgNTozNSBQTQ0KPiA+PiBPbiBUdWUsIDIwMjEtMDQtMjcgYXQgMDk6MjUgKzAwMDAsIFJvYmVy
dG8gU2Fzc3Ugd3JvdGU6DQo+ID4+Pj4gRnJvbTogTWltaSBab2hhciBbbWFpbHRvOnpvaGFyQGxp
bnV4LmlibS5jb21dDQo+ID4+Pj4gU2VudDogTW9uZGF5LCBBcHJpbCAyNiwgMjAyMSA5OjQ5IFBN
DQo+ID4+Pj4gT24gRnJpLCAyMDIxLTAzLTA1IGF0IDA5OjMwIC0wODAwLCBDYXNleSBTY2hhdWZs
ZXIgd3JvdGU6DQo+ID4+Pj4+IEhvd2V2ZXIgLi4uDQo+ID4+Pj4+DQo+ID4+Pj4+IFRoZSBzcGVj
aWFsIGNhc2luZyBvZiBJTUEgYW5kIEVWTSBpbiBzZWN1cml0eS5jIGlzIGdldHRpbmcgb3V0IG9m
DQo+ID4+Pj4+IGhhbmQsIGFuZCBhcHBlYXJzIHRvIGJlIHVubmVjZXNzYXJ5LiBCeSBteSBjb3Vu
dCB0aGVyZSBhcmUgOSBJTUENCj4gPj4+Pj4gaG9va3MgYW5kIDUgRVZNIGhvb2tzIHRoYXQgaGF2
ZSBiZWVuIGhhcmQgY29kZWQuIEFkZGluZyB0aGlzIElNQQ0KPiA+Pj4+PiBob29rIG1ha2VzIDEw
LiBJdCB3b3VsZCBiZSByZWFsbHkgZWFzeSB0byByZWdpc3RlciBJTUEgYW5kIEVWTSBhcw0KPiA+
Pj4+PiBzZWN1cml0eSBtb2R1bGVzLiBUaGF0IHdvdWxkIHJlbW92ZSB0aGUgZGVwZW5kZW5jeSB0
aGV5IGN1cnJlbnRseQ0KPiA+Pj4+PiBoYXZlIG9uIHNlY3VyaXR5IHN1Yi1zeXN0ZW0gYXBwcm92
YWwgZm9yIGNoYW5nZXMgbGlrZSB0aGlzIG9uZS4NCj4gPj4+Pj4gSSBrbm93IHRoZXJlIGhhcyBi
ZWVuIHJlc2lzdGFuY2UgdG8gIklNQSBhcyBhbiBMU00iIGluIHRoZSBwYXN0LA0KPiA+Pj4+PiBi
dXQgaXQncyBwcmV0dHkgaGFyZCB0byBzZWUgaG93IGl0IHdvdWxkbid0IGJlIGEgd2luLg0KPiA+
PiBJdCBzaG9sZG4ndCBiZSBvbmUgd2F5LiAgQXJlIHlvdSB3aWxsaW5nIHRvIGFsc28gbWFrZSB0
aGUgZXhpc3RpbmcNCj4gPj4gSU1BL0VWTSBob29rcyB0aGF0IGFyZSBub3QgY3VycmVudGx5IHNl
Y3VyaXR5IGhvb2tzLCBzZWN1cml0eSBob29rcw0KPiA+PiB0b28/ICAgQW5kIGFjY2VwdCBhbnkg
bmV3IElNQS9FVk0gaG9va3Mgd291bGQgcmVzdWx0IGluIG5ldyBzZWN1cml0eQ0KPiA+PiBob29r
cz8gIEFyZSB5b3UgYWxzbyB3aWxsaW5nIHRvIGFkZCBkZXBlbmRlbmN5IHRyYWNraW5nIGJldHdl
ZW4gTFNNcz8NCj4gPiBJIGFscmVhZHkgaGF2ZSBhIHByZWxpbWluYXJ5IGJyYW5jaCB3aGVyZSBJ
TUEvRVZNIGFyZSBmdWxsIExTTXMuDQo+IA0KPiBJIGRvbid0IHRoaW5rIHRoYXQgSU1BL0VWTSBu
ZWVkIHRvIGJlIGZ1bGwgTFNNcyB0byBhZGRyZXNzIG15IHdoaW5naW5nLg0KPiBJIGRvbid0IHRo
aW5rIHRoYXQgY2hhbmdpbmcgdGhlIGV4aXN0aW5nIGludGVncml0eV93aGF0ZXZlcigpIHRvDQo+
IHNlY3VyaXR5X3doYXRldmVyKCkgaXMgbmVjZXNzYXJ5LiBBbGwgdGhhdCBJJ20gcmVhbGx5IG9i
amVjdGluZyB0byBpcw0KPiBzcGVjaWFsIGNhc2VzIGluIHNlY3VyaXR5LmM6DQo+IA0KPiB7DQo+
IAlpbnQgcmV0Ow0KPiANCj4gCWlmICh1bmxpa2VseShJU19QUklWQVRFKGRfYmFja2luZ19pbm9k
ZShkZW50cnkpKSkpDQo+IAkJcmV0dXJuIDA7DQo+IAkvKg0KPiAJICogU0VMaW51eCBhbmQgU21h
Y2sgaW50ZWdyYXRlIHRoZSBjYXAgY2FsbCwNCj4gCSAqIHNvIGFzc3VtZSB0aGF0IGFsbCBMU01z
IHN1cHBseWluZyB0aGlzIGNhbGwgZG8gc28uDQo+IAkgKi8NCj4gCXJldCA9IGNhbGxfaW50X2hv
b2soaW5vZGVfcmVtb3ZleGF0dHIsIDEsIG1udF91c2VybnMsIGRlbnRyeSwNCj4gbmFtZSk7DQo+
IAlpZiAocmV0ID09IDEpDQo+IAkJcmV0ID0gY2FwX2lub2RlX3JlbW92ZXhhdHRyKG1udF91c2Vy
bnMsIGRlbnRyeSwgbmFtZSk7DQo+IAlpZiAocmV0KQ0KPiAJCXJldHVybiByZXQ7DQo+IAlyZXQg
PSBpbWFfaW5vZGVfcmVtb3ZleGF0dHIoZGVudHJ5LCBuYW1lKTsNCj4gCWlmIChyZXQpDQo+IAkJ
cmV0dXJuIHJldDsNCj4gCXJldHVybiBldm1faW5vZGVfcmVtb3ZleGF0dHIoZGVudHJ5LCBuYW1l
KTsNCj4gfQ0KPiANCj4gTm90IGFsbCB1c2VzIG9mIGltYS9ldm0gZnVuY3Rpb25zIGluIHNlY3Vy
aXR5LmMgbWFrZSBzZW5zZSB0byBjb252ZXJ0DQo+IHRvIExTTSBob29rcy4gSW4gZmFjdCwgSSBj
b3VsZCBiZSBjb21wbGV0ZWx5IHdyb25nIHRoYXQgaXQgbWFrZXMgc2Vuc2UNCj4gdG8gY2hhbmdl
IGFueXRoaW5nLiBXaGF0IEkgc2VlIGlzIHNvbWV0aGluZyB0aGF0IGxvb2tzIGxpa2UgaXQgb3Vn
aHQgdG8NCj4gYmUgbm9ybWFsaXplZC4gSWYgdGhlcmUncyBnb29kIHJlYXNvbiAoYW5kIGl0IGxv
b2tzIGxpa2UgdGhlcmUgbWF5IGJlKQ0KPiBmb3IgaXQgdG8gYmUgZGlmZmVyZW50IHRoZXJlJ3Mg
bm8gcmVhc29uIHRvIHBheSBhdHRlbnRpb24gdG8gbWUuDQoNCllvdSBhcmUgcmlnaHQuIFdoZW4g
SSBzYWlkIHRoYXQgSSBkb24ndCBzZWUgYW55IHZhbGlkIHJlYXNvbiBmb3INCm5vdCBtb3Zpbmcg
SU1BL0VWTSB0byB0aGUgTFNNIGluZnJhc3RydWN0dXJlLCBJIHByb2JhYmx5IHNob3VsZA0KaGF2
ZSBzYWlkIGp1c3QgdGhhdCBpdCBpcyB0ZWNobmljYWxseSBmZWFzaWJsZS4gQXBvbG9naWVzIGZv
ciBiZWluZw0KdG9vIHJlc29sdXRlIGluIG15IHN0YXRlbWVudC4NCg0KUm9iZXJ0bw0KDQpIVUFX
RUkgVEVDSE5PTE9HSUVTIER1ZXNzZWxkb3JmIEdtYkgsIEhSQiA1NjA2Mw0KTWFuYWdpbmcgRGly
ZWN0b3I6IExpIFBlbmcsIExpIEppYW4sIFNoaSBZYW5saQ0KDQo+ID4gSW5kZWVkLCB0aGUgYmln
Z2VzdCBwcm9ibGVtIHdvdWxkIGJlIHRvIGhhdmUgdGhlIG5ldyBob29rcw0KPiA+IGFjY2VwdGVk
LiBJIGNhbiBzZW5kIHRoZSBwYXRjaCBzZXQgZm9yIGV2YWx1YXRpb24gdG8gc2VlIHdoYXQNCj4g
PiBwZW9wbGUgdGhpbmsuDQo+ID4NCj4gPj4+PiBTb21laG93IEkgbWlzc2VkIHRoZSBuZXcgImxz
bT0iIGJvb3QgY29tbWFuZCBsaW5lIG9wdGlvbiwgd2hpY2gNCj4gPj4+PiBkeW5hbWljYWxseSBh
bGxvd3MgZW5hYmxpbmcvZGlzYWJsaW5nIExTTXMsIGJlaW5nIHVwc3RyZWFtZWQuICBUaGlzDQo+
ID4+Pj4gd291bGQgYmUgb25lIG9mIHRoZSByZWFzb25zIGZvciBub3QgbWFraW5nIElNQS9FVk0g
ZnVsbCBMU01zLg0KPiA+Pj4gSGkgTWltaQ0KPiA+Pj4NCj4gPj4+IG9uZSBjb3VsZCBhcmd1ZSB3
aHkgSU1BL0VWTSBzaG91bGQgcmVjZWl2ZSBhIHNwZWNpYWwNCj4gPj4+IHRyZWF0bWVudC4gSSB1
bmRlcnN0YW5kIHRoYXQgdGhpcyB3YXMgYSBuZWNlc3NpdHkgd2l0aG91dA0KPiA+Pj4gTFNNIHN0
YWNraW5nLiBOb3cgdGhhdCBMU00gc3RhY2tpbmcgaXMgYXZhaWxhYmxlLCBJIGRvbid0DQo+ID4+
PiBzZWUgYW55IHZhbGlkIHJlYXNvbiB3aHkgSU1BL0VWTSBzaG91bGQgbm90IGJlIG1hbmFnZWQN
Cj4gPj4+IGJ5IHRoZSBMU00gaW5mcmFzdHJ1Y3R1cmUuDQo+ID4+Pg0KPiA+Pj4+IEJvdGggSU1B
IGFuZCBFVk0gZmlsZSBkYXRhL21ldGFkYXRhIGlzIHBlcnNpc3RlbnQgYWNyb3NzIGJvb3RzLiAg
SWYNCj4gPj4+PiBlaXRoZXIgb25lIG9yIHRoZSBvdGhlciBpcyBub3QgZW5hYmxlZCB0aGUgZmls
ZSBkYXRhIGhhc2ggb3IgZmlsZQ0KPiA+Pj4+IG1ldGFkYXRhIEhNQUMgd2lsbCBub3QgcHJvcGVy
bHkgYmUgdXBkYXRlZCwgcG90ZW50aWFsbHkgcHJldmVudGluZyB0aGUNCj4gPj4+PiBzeXN0ZW0g
ZnJvbSBib290aW5nIHdoZW4gcmUtZW5hYmxlZC4gIFJlLWVuYWJsaW5nIElNQSBhbmQgRVZNDQo+
IHdvdWxkDQo+ID4+Pj4gcmVxdWlyZSAiZml4aW5nIiB0aGUgbXV0YWJsZSBmaWxlIGRhdGEgaGFz
aCBhbmQgSE1BQywgd2l0aG91dCBhbnkNCj4gPj4+PiBrbm93bGVkZ2Ugb2Ygd2hhdCB0aGUgImZp
eGVkIiB2YWx1ZXMgc2hvdWxkIGJlLiAgRGF2ZSBTYWZmb3JkIHJlZmVycmVkDQo+ID4+Pj4gdG8g
dGhpcyBhcyAiYmxlc3NpbmciIHRoZSBuZXdseSBjYWxjdWxhdGVkIHZhbHVlcy4NCj4gPj4+IElN
QS9FVk0gY2FuIGJlIGVhc2lseSBkaXNhYmxlZCBpbiBvdGhlciB3YXlzLCBmb3IgZXhhbXBsZQ0K
PiA+Pj4gYnkgbW92aW5nIHRoZSBJTUEgcG9saWN5IG9yIHRoZSBFVk0ga2V5cyBlbHNld2hlcmUu
DQo+ID4+IER5bmFtaWNhbGx5IGRpc2FibGluZyBJTUEvRVZNIGlzIHZlcnkgZGlmZmVyZW50IHRo
YW4gcmVtb3Zpbmcga2V5cyBhbmQNCj4gPj4gcHJldmVudGluZyB0aGUgc3lzdGVtIGZyb20gYm9v
dGluZy4gIFJlc3RvcmluZyB0aGUga2V5cyBzaG91bGQgcmVzdWx0DQo+ID4+IGluIGJlaW5nIGFi
bGUgdG8gcmUtYm9vdCB0aGUgc3lzdGVtLiAgUmUtZW5hYmxpbmcgSU1BL0VWTSwgcmVxdWlyZXMg
cmUtDQo+ID4+IGxhYmVsaW5nIHRoZSBmaWxlc3lzdGVtIGluICJmaXgiIG1vZGUsIHdoaWNoICJi
bGVzc2VzIiBhbnkgY2hhbmdlcyBtYWRlDQo+ID4+IHdoZW4gSU1BL0VWTSB3ZXJlIG5vdCBlbmFi
bGVkLg0KPiA+IFVobSwgSSB0aG91Z2h0IHRoYXQgaWYgeW91IG1vdmUgdGhlIEhNQUMga2V5IGZv
ciBleGFtcGxlDQo+ID4gYW5kIHlvdSBib290IHRoZSBzeXN0ZW0sIHlvdSBpbnZhbGlkYXRlIGFs
bCBmaWxlcyB0aGF0IGNoYW5nZSwNCj4gPiBiZWNhdXNlIHRoZSBITUFDIGlzIG5vdCB1cGRhdGVk
Lg0KPiA+DQo+ID4+PiBBbHNvIG90aGVyIExTTXMgcmVseSBvbiBhIGR5bmFtaWMgYW5kIHBlcnNp
c3RlbnQgc3RhdGUNCj4gPj4+IChmb3IgZXhhbXBsZSBmb3IgZmlsZSB0cmFuc2l0aW9ucyBpbiBT
RUxpbnV4KSwgd2hpY2ggY2Fubm90IGJlDQo+ID4+PiB0cnVzdGVkIGFueW1vcmUgaWYgTFNNcyBh
cmUgZXZlbiB0ZW1wb3JhcmlseSBkaXNhYmxlZC4NCj4gPj4gWW91ciBhcmd1bWVudCBpcyBiZWNh
dXNlIHRoaXMgaXMgYSBwcm9ibGVtIGZvciBTRUxpbnV4LCBtYWtlIGl0IGFsc28gYQ0KPiA+PiBw
cm9ibGVtIGZvciBJTUEvRVZNIHRvbz8hICAgKCJUd28gd3JvbmdzIG1ha2UgYSByaWdodCIpDQo+
ID4gVG8gbWUgaXQgc2VlbXMgcmVhc29uYWJsZSB0byBnaXZlIHRoZSBhYmlsaXR5IHRvIHBlb3Bs
ZSB0bw0KPiA+IGRpc2FibGUgdGhlIExTTXMgaWYgdGhleSB3YW50IHRvIGRvIHNvLCBhbmQgYXQg
dGhlIHNhbWUgdGltZQ0KPiA+IHRvIHRyeSB0byBwcmV2ZW50IGFjY2lkZW50YWwgZGlzYWJsZSB3
aGVuIHRoZSBMU01zIHNob3VsZCBiZQ0KPiA+IGVuYWJsZWQuDQo+ID4NCj4gPj4+IElmIElNQS9F
Vk0gaGF2ZSB0byBiZSBlbmFibGVkIHRvIHByZXZlbnQgbWlzY29uZmlndXJhdGlvbiwNCj4gPj4+
IEkgdGhpbmsgdGhlIHNhbWUgY2FuIGJlIGFjaGlldmVkIGlmIHRoZXkgYXJlIGZ1bGwgTFNNcywg
Zm9yDQo+ID4+PiBleGFtcGxlIGJ5IHByZXZlbnRpbmcgdGhhdCB0aGUgbGlzdCBvZiBlbmFibGVk
IExTTXMgY2hhbmdlcw0KPiA+Pj4gYXQgcnVuLXRpbWUuDQo+ID4+IFRoYXQgc2hpcCBzYWlsZWQg
d2hlbiAic2VjdXJpdHk9IiB3YXMgZGVwcmVjYXRlZCBpbiBmYXZvciBvZiAibHNtPSINCj4gPj4g
c3VwcG9ydCwgd2hpY2ggZHluYW1pY2FsbHkgZW5hYmxlcy9kaXNhYmxlcyBMU01zIGF0IHJ1bnRp
bWUuDQo+IA0KPiBzZWN1cml0eT0gaXMgc3RpbGwgc3VwcG9ydGVkIGFuZCB3b3JrcyB0aGUgc2Ft
ZSBhcyBldmVyLiBsc209IGlzDQo+IG1vcmUgcG93ZXJmdWwgdGhhbiBzZWN1cml0eT0gYnV0IGFs
c28gaGFyZGVyIHRvIHVzZS4NCj4gDQo+ID4gTWF5YmUgdGhpcyBwb3NzaWJpbGl0eSBjYW4gYmUg
ZGlzYWJsZWQgd2l0aCBhIG5ldyBrZXJuZWwgb3B0aW9uLg0KPiA+IEkgd2lsbCB0aGluayBhIG1v
cmUgY29uY3JldGUgc29sdXRpb24uDQo+ID4NCj4gPiBSb2JlcnRvDQo+ID4NCj4gPiBIVUFXRUkg
VEVDSE5PTE9HSUVTIER1ZXNzZWxkb3JmIEdtYkgsIEhSQiA1NjA2Mw0KPiA+IE1hbmFnaW5nIERp
cmVjdG9yOiBMaSBQZW5nLCBMaSBKaWFuLCBTaGkgWWFubGkNCg0K
