Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC393625C0
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Apr 2021 18:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbhDPQhi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Apr 2021 12:37:38 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2876 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbhDPQhi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Apr 2021 12:37:38 -0400
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FMMDQ3XSpz68BvF;
        Sat, 17 Apr 2021 00:31:50 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 16 Apr 2021 18:37:10 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2106.013;
 Fri, 16 Apr 2021 18:37:10 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "paul@paul-moore.com" <paul@paul-moore.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "reiserfs-devel@vger.kernel.org" <reiserfs-devel@vger.kernel.org>
Subject: RE: [PATCH 0/5] evm: Prepare for moving to the LSM infrastructure
Thread-Topic: [PATCH 0/5] evm: Prepare for moving to the LSM infrastructure
Thread-Index: AQHXMd7FgQB7iowx5ESkxCON7TnufKq16sKAgAFjQMA=
Date:   Fri, 16 Apr 2021 16:37:10 +0000
Message-ID: <2c944d6ddeed4519bdbf3733d7318a3d@huawei.com>
References: <20210415100435.18619-1-roberto.sassu@huawei.com>
 <7659b8cf-71cc-33b5-dbf1-3eb1ff159fe6@schaufler-ca.com>
In-Reply-To: <7659b8cf-71cc-33b5-dbf1-3eb1ff159fe6@schaufler-ca.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.204.62.207]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

PiBGcm9tOiBDYXNleSBTY2hhdWZsZXIgW21haWx0bzpjYXNleUBzY2hhdWZsZXItY2EuY29tXQ0K
PiBTZW50OiBUaHVyc2RheSwgQXByaWwgMTUsIDIwMjEgMTA6NDQgUE0NCj4gT24gNC8xNS8yMDIx
IDM6MDQgQU0sIFJvYmVydG8gU2Fzc3Ugd3JvdGU6DQo+ID4gVGhpcyBwYXRjaCBzZXQgZGVwZW5k
cyBvbjoNCj4gPg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWludGVncml0eS8y
MDIxMDQwOTExNDMxMy40MDczLTEtDQo+IHJvYmVydG8uc2Fzc3VAaHVhd2VpLmNvbS8NCj4gPiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1pbnRlZ3JpdHkvMjAyMTA0MDcxMDUyNTIuMzA3
MjEtMS0NCj4gcm9iZXJ0by5zYXNzdUBodWF3ZWkuY29tLw0KPiA+DQo+ID4gT25lIG9mIHRoZSBj
aGFsbGVuZ2VzIHRoYXQgbXVzdCBiZSB0YWNrbGVkIHRvIG1vdmUgSU1BIGFuZCBFVk0gdG8gdGhl
IExTTQ0KPiA+IGluZnJhc3RydWN0dXJlIGlzIHRvIGVuc3VyZSB0aGF0IEVWTSBpcyBjYXBhYmxl
IHRvIGNvcnJlY3RseSBoYW5kbGUNCj4gPiBtdWx0aXBsZSBzdGFja2VkIExTTXMgcHJvdmlkaW5n
IGFuIHhhdHRyIGF0IGZpbGUgY3JlYXRpb24uIEF0IHRoZSBtb21lbnQsDQo+ID4gdGhlcmUgYXJl
IGZldyBpc3N1ZXMgdGhhdCB3b3VsZCBwcmV2ZW50IGEgY29ycmVjdCBpbnRlZ3JhdGlvbi4gVGhp
cyBwYXRjaA0KPiA+IHNldCBhaW1zIGF0IHNvbHZpbmcgdGhlbS4NCj4gPg0KPiA+IEZyb20gdGhl
IExTTSBpbmZyYXN0cnVjdHVyZSBzaWRlLCB0aGUgTFNNIHN0YWNraW5nIGZlYXR1cmUgYWRkZWQg
dGhlDQo+ID4gcG9zc2liaWxpdHkgb2YgcmVnaXN0ZXJpbmcgbXVsdGlwbGUgaW1wbGVtZW50YXRp
b25zIG9mIHRoZSBzZWN1cml0eSBob29rcywNCj4gPiB0aGF0IGFyZSBjYWxsZWQgc2VxdWVudGlh
bGx5IHdoZW5ldmVyIHNvbWVvbmUgY2FsbHMgdGhlIGNvcnJlc3BvbmRpbmcNCj4gPiBzZWN1cml0
eSBob29rLiBIb3dldmVyLCBzZWN1cml0eV9pbm9kZV9pbml0X3NlY3VyaXR5KCkgYW5kDQo+ID4g
c2VjdXJpdHlfb2xkX2lub2RlX2luaXRfc2VjdXJpdHkoKSBhcmUgY3VycmVudGx5IGxpbWl0ZWQg
dG8gc3VwcG9ydCBvbmUNCj4gPiB4YXR0ciBwcm92aWRlZCBieSBMU00gYW5kIG9uZSBieSBFVk0u
DQo+IA0KPiBUaGF0IGlzIGNvcnJlY3QuIEF0IHByZXNlbnQgdGhlIG9ubHkgdHdvIG1vZHVsZXMg
dGhhdCBwcm92aWRlIGV4dGVuZGVkDQo+IGF0dHJpYnV0ZXMgYXJlIFNFTGludXggYW5kIFNtYWNr
LiBUaGUgTFNNIGluZnJhc3RydWN0dXJlIHJlcXVpcmVzIG1vcmUNCj4gY2hhbmdlLCBpbmNsdWRp
bmcgY2hhbmdlIHRvIHNlY3VyaXR5X2lub2RlX2luaXRfc2VjdXJpdHkoKSwgYmVmb3JlIHRob3Nl
DQo+IG1vZHVsZXMgY2FuIGJlIHVzZWQgdG9nZXRoZXIuDQoNCk9uZSBvZiB0aGUgZ29hbHMgb2Yg
dGhpcyBwYXRjaCBzZXQgaXMgdG8gc29sdmUgdGhlIHNwZWNpZmljIHByb2JsZW0NCm9mIHNlY3Vy
aXR5X2lub2RlX2luaXRfc2VjdXJpdHkoKSwgd2hlbiBhcmJpdHJhcnkgTFNNcyBhcmUgYWRkZWQN
CnRvIHRoZSBMU00gaW5mcmFzdHJ1Y3R1cmUuIEdpdmVuIHRoYXQgc29tZSBwcm9ibGVtcyBoYXZl
DQpiZWVuIGFscmVhZHkgaWRlbnRpZmllZCwgYW5kIHdpbGwgYXJpc2Ugd2hlbiBhIG5ldyBMU00N
CnByb3ZpZGluZyBhbiBpbXBsZW1lbnRhdGlvbiBmb3IgdGhlIGlub2RlX2luaXRfc2VjdXJpdHkg
aG9vaw0Kd2lsbCBiZSBhZGRlZCB0byB0aGUgTFNNIGluZnJhc3RydWN0dXJlLCBpdCBzZWVtcyBh
IGdvb2QgaWRlYQ0KZml4aW5nIHRoZW0uIFdlIGNvdWxkIGRpc2N1c3MgYWJvdXQgdGhlIHNvbHV0
aW9uLCBpZiB0aGVyZSBpcw0KYSBiZXR0ZXIgYXBwcm9hY2guDQoNCj4gPiBJbiBhZGRpdGlvbiwg
dXNpbmcgdGhlIGNhbGxfaW50X2hvb2soKSBtYWNybyBjYXVzZXMgc29tZSBpc3N1ZXMuIEFjY29y
ZGluZw0KPiA+IHRvIHRoZSBkb2N1bWVudGF0aW9uIGluIGluY2x1ZGUvbGludXgvbHNtX2hvb2tz
LmgsIGl0IGlzIGEgbGVnaXRpbWF0ZSBjYXNlDQo+ID4gdGhhdCBhbiBMU00gcmV0dXJucyAtRU9Q
Tk9UU1VQUCB3aGVuIGl0IGRvZXMgbm90IHdhbnQgdG8gcHJvdmlkZSBhbiB4YXR0ci4NCj4gPiBI
b3dldmVyLCB0aGUgbG9vcCBkZWZpbmVkIGluIHRoZSBtYWNybyB3b3VsZCBzdG9wIGNhbGxpbmcg
c3Vic2VxdWVudCBMU01zDQo+ID4gaWYgdGhhdCBoYXBwZW5zLiBJbiB0aGUgY2FzZSBvZiBzZWN1
cml0eV9vbGRfaW5vZGVfaW5pdF9zZWN1cml0eSgpLCB1c2luZw0KPiA+IHRoZSBtYWNybyB3b3Vs
ZCBhbHNvIGNhdXNlIGEgbWVtb3J5IGxlYWsgZHVlIHRvIHJlcGxhY2luZyB0aGUgKnZhbHVlDQo+
ID4gcG9pbnRlciwgaWYgbXVsdGlwbGUgTFNNcyBwcm92aWRlIGFuIHhhdHRyLg0KPiANCj4gQXMg
dGhlcmUgaXMgbm8gY2FzZSB3aGVyZSB0aGVyZSB3aWxsIGJlIG11bHRpcGxlIHByb3ZpZGVycyBv
ZiBob29rcyBmb3INCj4gaW5vZGVfaW5pdF9zZWN1cml0eSB0aGlzIGlzbid0IGFuIGlzc3VlLg0K
DQpJIGNvdWxkIHNraXAgdGhlIHBhdGNoZXMgdGhhdCBhcmUgbm90IHJlcXVpcmVkIHRvIHN1cHBv
cnQNCm11bHRpcGxlIExTTXMgcmVnaXN0ZXJpbmcgdG8gdGhlIGlub2RlX2luaXRfc2VjdXJpdHkg
aG9vaw0KYW5kIGp1c3QgZG8gdGhlIEVWTSBjaGFuZ2VzIChzZWUgYmVsb3cgZm9yIHRoZSBtb3Rp
dmF0aW9uKS4NCg0KPiA+IEZyb20gRVZNIHNpZGUsIHRoZSBmaXJzdCBvcGVyYXRpb24gdG8gYmUg
ZG9uZSBpcyB0byBjaGFuZ2UgdGhlIGRlZmluaXRpb24NCj4gPiBvZiBldm1faW5vZGVfaW5pdF9z
ZWN1cml0eSgpIHRvIGJlIGNvbXBhdGlibGUgd2l0aCB0aGUgc2VjdXJpdHkgaG9vaw0KPiA+IGRl
ZmluaXRpb24uIFVuZm9ydHVuYXRlbHksIHRoZSBjdXJyZW50IGRlZmluaXRpb24gZG9lcyBub3Qg
cHJvdmlkZSBlbm91Z2gNCj4gPiBpbmZvcm1hdGlvbiBmb3IgRVZNLCBhcyBpdCBtdXN0IGhhdmUg
dmlzaWJpbGl0eSBvZiBhbGwgeGF0dHJzIHByb3ZpZGVkIGJ5DQo+ID4gTFNNcyB0byBjb3JyZWN0
bHkgY2FsY3VsYXRlIHRoZSBITUFDLiBUaGlzIHBhdGNoIHNldCBjaGFuZ2VzIHRoZSBzZWN1cml0
eQ0KPiA+IGhvb2sgZGVmaW5pdGlvbiBieSBhZGRpbmcgdGhlIGZ1bGwgYXJyYXkgb2YgeGF0dHIg
YXMgYSBwYXJhbWV0ZXIuDQo+IA0KPiBXaHkgZG8geW91IHdhbnQgdG8gY2FsbCBldm1faW5vZGVf
aW5pdF9zZWN1cml0eSgpIGFzIGEgcmVndWxhciBMU00gaG9vaz8NCj4gRXhjZXB0IGZvciB0aGUg
bmFtZXMgZXZtX2lub2RlX2luaXRfc2VjdXJpdHkoKSBhbmQNCj4gc2VsaW51eF9pbm9kZV9pbml0
X3NlY3VyaXR5KCkNCj4gaGF2ZSBub3RoaW5nIGluIGNvbW1vbi4gVGhleSBkbyB2ZXJ5IGRpZmZl
cmVudCB0aGluZ3MgYW5kIHJlcXVpcmUgZGlmZmVyZW50DQo+IGRhdGEsIGFzIGNvbWVzIG91dCBp
biB0aGUgcGF0Y2hlcy4NCg0KSSB0aG91Z2h0IHRoYXQgaXQgd291bGQgYmUgbW9yZSBjbGVhbiBp
ZiBhbGwgaG9va3MgYXJlIHJlZ2lzdGVyZWQNCnRvIHRoZSBMU00gaW5mcmFzdHJ1Y3R1cmUuIE90
aGVyd2lzZSwgaXQgY291bGQgaGFwcGVuIHRoYXQgc29tZQ0KaG9va3MgYXJlIHN0aWxsIGV4ZWN1
dGVkIGV2ZW4gaWYgdGhlIExTTSBpcyBub3QgYWN0aXZlLCBmcm9tIHRoZQ0KcGVyc3BlY3RpdmUg
b2YgdGhlIExTTSBpbmZyYXN0cnVjdHVyZS4NCg0KZXZtX2lub2RlX2luaXRfc2VjdXJpdHkoKSBp
cyBzdGlsbCBhIHByb3ZpZGVyIG9mIHhhdHRycywgbGlrZSB0aGUNCm90aGVyIExTTXMsIGp1c3Qg
aXQgcmVxdWlyZXMgYW4gZXh0cmEgcGFyYW1ldGVyIHRvIGNhbGN1bGF0ZQ0KdGhlIEhNQUMuDQoN
Cj4gVGhlcmUgYXJlIGV2bSBmdW5jdGlvbnMgdGhhdCBjb3VsZCBiZSBpbXBsZW1lbnRlZCBhcyBM
U00gaG9va3MuIEkgZG9uJ3QgdGhpbmsNCj4gdGhpcyBpcyBvbmUgb2YgdGhlbS4gVGhlcmUncyBu
byBwb2ludCBpbiBnb2luZyBvdmVyYm9hcmQuDQoNCklNQSBhbmQgRVZNIGJvdGggdXNlIGEgY2Fj
aGUgdG8gc3RvcmUgdGhlIGludGVncml0eSB2ZXJpZmljYXRpb24sDQp3aGljaCBpcyBjdXJyZW50
bHkgbm90IG1hbmFnZWQgYnkgdGhlIExTTSBpbmZyYXN0cnVjdHVyZSBidXQNCmJ5IGFuIGFkLWhv
YyBtZWNoYW5pc20gaW1wbGVtZW50ZWQgd2l0aCBhbiByYnRyZWUuDQoNCk9uZSBvZiB0aGUgYmVu
ZWZpdHMgb2YgZGVmaW5pbmcgYm90aCBJTUEgYW5kIEVWTSBhcyBhbiBMU00NCmlzIHRoYXQgd2Ug
Y2FuIHN3aXRjaCBmcm9tIHRoaXMgYWQtaG9jIG1lY2hhbmlzbSB0byB0aGUgb25lDQppbXBsZW1l
bnRlZCBmb3IgdGhlIExTTSBpbmZyYXN0cnVjdHVyZSwgd2l0aCBhIHNlYXJjaCBpbg0KY29uc3Rh
bnQgdGltZS4gR2l2ZW4gdGhhdCBldm1faW5vZGVfaW5pdF9zZWN1cml0eSgpIHdvdWxkDQp1cGRh
dGUgdGhlIGludGVncml0eSBzdGF0dXMgKHhhdHRycyBhcmUgZ29vZCBhdCBpbm9kZSBjcmVhdGlv
bg0KdGltZSksIEkgd291bGQgYWRkIGl0IGFzIHdlbGwgdG8gdGhlIExTTSBpbmZyYXN0cnVjdHVy
ZS4NCg0KT25lIGFkZGl0aW9uYWwgbW90aXZhdGlvbiBmb3IgZGVmaW5pbmcgRVZNIGFzIGFuIExT
TSBpcyB0aGF0DQppdCB3b3VsZCBzb2x2ZSBvbmUgb2YgdGhlIEVWTSBsaW1pdGF0aW9ucyB0aGF0
IGFmZmVjdHMgaXRzDQp1c2FiaWxpdHk6IHBhcnRpYWwgY29weSBvZiB4YXR0cnMgKGUuZy4gYnkg
Y3AgYW5kIHRhcikgd291bGQgbm90DQp3b3JrIHdoZW4gYW4gSE1BQyBrZXkgaXMgbG9hZGVkIGJl
Y2F1c2UsIHNpbmNlIEVWTSBpbg0KdGhlIHBvc3Qgc2V0L3JlbW92ZXhhdHRyIGhvb2sgZG9lcyBu
b3Qga25vdyB0aGUgc3RhdHVzDQpvZiB0aGUgbGFzdCBpbnRlZ3JpdHkgdmVyaWZpY2F0aW9uLCBp
dCBoYXMgdG8gZGVueSB0aGUgcGVybWlzc2lvbg0KdG8gcGVyZm9ybSB0aGUgeGF0dHIgb3BlcmF0
aW9uLCB0byBhdm9pZCB0aGF0IHRoZSBITUFDIGlzDQpjYWxjdWxhdGVkIG9uIGNvcnJ1cHRlZCB4
YXR0cnMuIEhhdmluZyB0aGUgc3RhdHVzIGluIHRoZQ0KcGVyLWlub2RlIGJsb2Igd291bGQgc29s
dmUgdGhpcyBpc3N1ZSBtb3JlIGVmZmljaWVudGx5IHRoYW4NCmFkZGluZyBhIGNhY2hlIGZvciBl
YWNoIHZlcmlmaWVkIGlub2RlIGluIHRoZSByYnRyZWUuDQoNCldvdWxkIHlvdSBzZWUgdGhpcyBh
cyBhbiB1c2VmdWwgbW9kaWZpY2F0aW9uPw0KDQpUaGFua3MNCg0KUm9iZXJ0bw0KDQpIVUFXRUkg
VEVDSE5PTE9HSUVTIER1ZXNzZWxkb3JmIEdtYkgsIEhSQiA1NjA2Mw0KTWFuYWdpbmcgRGlyZWN0
b3I6IExpIFBlbmcsIExpIEppYW4sIFNoaSBZYW5saQ0KDQo+ID4gU2Vjb25kbHksIEVWTSBtdXN0
IGtub3cgaG93IG1hbnkgZWxlbWVudHMgYXJlIGluIHRoZSB4YXR0ciBhcnJheS4gSXQNCj4gc2Vl
bXMNCj4gPiB0aGF0IGl0IGlzIG5vdCBuZWNlc3NhcnkgdG8gYWRkIGFub3RoZXIgcGFyYW1ldGVy
LCBhcyBhbGwgZmlsZXN5c3RlbXMgdGhhdA0KPiA+IGRlZmluZSBhbiBpbml0eGF0dHIgZnVuY3Rp
b24sIGV4cGVjdCB0aGF0IHRoZSBsYXN0IGVsZW1lbnQgb2YgdGhlIGFycmF5DQo+IGlzDQo+ID4g
b25lIHdpdGggdGhlIG5hbWUgZmllbGQgc2V0IHRvIE5VTEwuIEVWTSByZXVzZXMgdGhlIHNhbWUg
YXNzdW1wdGlvbi4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggc2V0IGhhcyBiZWVuIHRlc3RlZCBieSBp
bnRyb2R1Y2luZyBzZXZlcmFsIGluc3RhbmNlcyBvZiBhDQo+ID4gVGVzdExTTSAoc29tZSBwcm92
aWRpbmcgYW4geGF0dHIsIHNvbWUgbm90LCBvbmUgd2l0aCBhIHdyb25nDQo+IGltcGxlbWVudGF0
aW9uDQo+ID4gdG8gc2VlIGhvdyB0aGUgTFNNIGluZnJhc3RydWN0dXJlIGhhbmRsZXMgaXQpLiBU
aGUgcGF0Y2ggaXMgbm90IGluY2x1ZGVkDQo+ID4gaW4gdGhpcyBzZXQgYnV0IGl0IGlzIGF2YWls
YWJsZSBoZXJlOg0KPiA+DQo+ID4NCj4gaHR0cHM6Ly9naXRodWIuY29tL3JvYmVydG9zYXNzdS9s
aW51eC9jb21taXQvMDM3MGZmMGZiYzE2ZTVkNjM0ODk4MzZhOTUNCj4gOGU2NWQ2OTdmOTU2ZGIN
Cj4gPg0KPiA+IFRoZSB0ZXN0LCBhZGRlZCB0byBpbWEtZXZtLXV0aWxzLCBpcyBhdmFpbGFibGUg
aGVyZToNCj4gPg0KPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9yb2JlcnRvc2Fzc3UvaW1hLWV2bS11
dGlscy9ibG9iL2V2bS1tdWx0aXBsZS1sc21zLXYxLQ0KPiBkZXZlbC12MS90ZXN0cy9ldm1fbXVs
dGlwbGVfbHNtcy50ZXN0DQo+ID4NCj4gPiBUaGUgdGVzdCB0YWtlcyBhIFVNTCBrZXJuZWwgYnVp
bHQgYnkgVHJhdmlzIGFuZCBsYXVuY2hlcyBpdCBzZXZlcmFsIHRpbWVzLA0KPiA+IGVhY2ggdGlt
ZSB3aXRoIGEgZGlmZmVyZW50IGNvbWJpbmF0aW9uIG9mIExTTXMuIEFmdGVyIGJvb3QsIGl0IGZp
cnN0IGNoZWNrcw0KPiA+IHRoYXQgdGhlcmUgaXMgYW4geGF0dHIgZm9yIGVhY2ggTFNNIHByb3Zp
ZGluZyBpdCwgYW5kIHRoZW4gY2FsY3VsYXRlcyB0aGUNCj4gPiBITUFDIGluIHVzZXIgc3BhY2Ug
YW5kIGNvbXBhcmVzIGl0IHdpdGggdGhlIEhNQUMgY2FsY3VsYXRlZCBieSBFVk0gaW4NCj4gPiBr
ZXJuZWwgc3BhY2UuDQo+ID4NCj4gPiBBIHRlc3QgcmVwb3J0IGNhbiBiZSBvYnRhaW5lZCBoZXJl
Og0KPiA+DQo+ID4gaHR0cHM6Ly93d3cudHJhdmlzLWNpLmNvbS9naXRodWIvcm9iZXJ0b3Nhc3N1
L2ltYS1ldm0tDQo+IHV0aWxzL2pvYnMvNDk4Njk5NTQwDQo+ID4NCj4gPiBMYXN0bHksIHJ1bm5p
bmcgdGhlIHRlc3Qgb24gcmVpc2VyZnMgdG8gY2hlY2sNCj4gPiBzZWN1cml0eV9vbGRfaW5vZGVf
aW5pdF9zZWN1cml0eSgpLCBzb21lIGlzc3VlcyBoYXZlIGJlZW4gZGlzY292ZXJlZDogYQ0KPiA+
IGZyZWUgb2YgeGF0dHItPm5hbWUgd2hpY2ggaXMgbm90IGNvcnJlY3QgYWZ0ZXIgY29tbWl0IDk1
NDg5MDZiMmJiNyAoJ3hhdHRyOg0KPiA+IENvbnN0aWZ5IC0+bmFtZSBtZW1iZXIgb2YgInN0cnVj
dCB4YXR0ciInKSwgYW5kIGEgbWlzYWxpZ25tZW50IHdpdGgNCj4gPiBzZWN1cml0eV9pbm9kZV9p
bml0X3NlY3VyaXR5KCkgKHRoZSBvbGQgdmVyc2lvbiBleHBlY3RzIHRoZSBmdWxsIHhhdHRyIG5h
bWUNCj4gPiB3aXRoIHRoZSBzZWN1cml0eS4gcHJlZml4LCB0aGUgbmV3IHZlcnNpb24ganVzdCB0
aGUgc3VmZml4KS4gVGhlIGxhc3QgaXNzdWUNCj4gPiBoYXMgbm90IGJlZW4gZml4ZWQgeWV0Lg0K
PiA+DQo+ID4gUm9iZXJ0byBTYXNzdSAoNSk6DQo+ID4gICB4YXR0cjogQ29tcGxldGUgY29uc3Rp
ZnkgLT5uYW1lIG1lbWJlciBvZiAic3RydWN0IHhhdHRyIg0KPiA+ICAgc2VjdXJpdHk6IFN1cHBv
cnQgbXVsdGlwbGUgTFNNcyBpbXBsZW1lbnRpbmcgdGhlIGlub2RlX2luaXRfc2VjdXJpdHkNCj4g
PiAgICAgaG9vaw0KPiA+ICAgc2VjdXJpdHk6IFBhc3MgeGF0dHJzIGFsbG9jYXRlZCBieSBMU01z
IHRvIHRoZSBpbm9kZV9pbml0X3NlY3VyaXR5DQo+ID4gICAgIGhvb2sNCj4gPiAgIGV2bTogQWxp
Z24gZXZtX2lub2RlX2luaXRfc2VjdXJpdHkoKSBkZWZpbml0aW9uIHdpdGggTFNNDQo+ID4gICAg
IGluZnJhc3RydWN0dXJlDQo+ID4gICBldm06IFN1cHBvcnQgbXVsdGlwbGUgTFNNcyBwcm92aWRp
bmcgYW4geGF0dHINCj4gPg0KPiA+ICBmcy9yZWlzZXJmcy94YXR0cl9zZWN1cml0eS5jICAgICAg
ICB8ICAyIC0NCj4gPiAgaW5jbHVkZS9saW51eC9ldm0uaCAgICAgICAgICAgICAgICAgfCAyMSAr
KysrLS0tDQo+ID4gIGluY2x1ZGUvbGludXgvbHNtX2hvb2tfZGVmcy5oICAgICAgIHwgIDIgKy0N
Cj4gPiAgaW5jbHVkZS9saW51eC9sc21faG9va3MuaCAgICAgICAgICAgfCAgNSArLQ0KPiA+ICBz
ZWN1cml0eS9pbnRlZ3JpdHkvZXZtL2V2bS5oICAgICAgICB8ICAyICsNCj4gPiAgc2VjdXJpdHkv
aW50ZWdyaXR5L2V2bS9ldm1fY3J5cHRvLmMgfCAgOSArKy0NCj4gPiAgc2VjdXJpdHkvaW50ZWdy
aXR5L2V2bS9ldm1fbWFpbi5jICAgfCAzNSArKysrKysrLS0tLQ0KPiA+ICBzZWN1cml0eS9zZWN1
cml0eS5jICAgICAgICAgICAgICAgICB8IDk1ICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
DQo+ID4gIHNlY3VyaXR5L3NlbGludXgvaG9va3MuYyAgICAgICAgICAgIHwgIDMgKy0NCj4gPiAg
c2VjdXJpdHkvc21hY2svc21hY2tfbHNtLmMgICAgICAgICAgfCAgNCArLQ0KPiA+ICAxMCBmaWxl
cyBjaGFuZ2VkLCAxMzUgaW5zZXJ0aW9ucygrKSwgNDMgZGVsZXRpb25zKC0pDQo+ID4NCg0K
