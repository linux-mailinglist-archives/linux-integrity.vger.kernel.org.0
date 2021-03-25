Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78F8349232
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Mar 2021 13:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhCYMju (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Mar 2021 08:39:50 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2741 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbhCYMjY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Mar 2021 08:39:24 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F5kw60vXwz680Zn;
        Thu, 25 Mar 2021 20:30:30 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 25 Mar 2021 13:39:19 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2106.013;
 Thu, 25 Mar 2021 13:39:19 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "mjg59@google.com" <mjg59@google.com>,
        "agruenba@redhat.com" <agruenba@redhat.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 08/11] evm: Allow setxattr() and setattr() for
 unmodified metadata
Thread-Topic: [PATCH v4 08/11] evm: Allow setxattr() and setattr() for
 unmodified metadata
Thread-Index: AQHXEdMs3dcvjnFQvUyUTwTeWmdH4qqTStlAgAFhU4CAABYSsA==
Date:   Thu, 25 Mar 2021 12:39:19 +0000
Message-ID: <0ad97143a7c841228962d9062a20051d@huawei.com>
References: <20210305151923.29039-1-roberto.sassu@huawei.com>
 <20210305151923.29039-9-roberto.sassu@huawei.com>
 <ad33c998ee834a588e0ca1a31ee2a530@huawei.com>
 <20210325121341.q2ufjhnqe3osjc7c@wittgenstein>
In-Reply-To: <20210325121341.q2ufjhnqe3osjc7c@wittgenstein>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.4.143]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

PiBGcm9tOiBDaHJpc3RpYW4gQnJhdW5lciBbbWFpbHRvOmNocmlzdGlhbi5icmF1bmVyQHVidW50
dS5jb21dDQo+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAyNSwgMjAyMSAxOjE0IFBNDQo+IE9uIFRo
dSwgTWFyIDI1LCAyMDIxIGF0IDEwOjUzOjQzQU0gKzAwMDAsIFJvYmVydG8gU2Fzc3Ugd3JvdGU6
DQo+ID4gPiBGcm9tOiBSb2JlcnRvIFNhc3N1DQo+ID4gPiBTZW50OiBGcmlkYXksIE1hcmNoIDUs
IDIwMjEgNDoxOSBQTQ0KPiA+ID4gV2l0aCB0aGUgcGF0Y2ggdG8gYWxsb3cgeGF0dHIvYXR0ciBv
cGVyYXRpb25zIGlmIGEgcG9ydGFibGUgc2lnbmF0dXJlDQo+ID4gPiB2ZXJpZmljYXRpb24gZmFp
bHMsIGNwIGFuZCB0YXIgY2FuIGNvcHkgYWxsIHhhdHRycy9hdHRycyBzbyB0aGF0IGF0IHRoZQ0K
PiA+ID4gZW5kIG9mIHRoZSBwcm9jZXNzIHZlcmlmaWNhdGlvbiBzdWNjZWVkcy4NCj4gPiA+DQo+
ID4gPiBIb3dldmVyLCBpdCBtaWdodCBoYXBwZW4gdGhhdCB0aGUgeGF0dHJzL2F0dHJzIGFyZSBh
bHJlYWR5IHNldCB0byB0aGUNCj4gPiA+IGNvcnJlY3QgdmFsdWUgKHRha2VuIGF0IHNpZ25pbmcg
dGltZSkgYW5kIHNpZ25hdHVyZSB2ZXJpZmljYXRpb24gc3VjY2VlZHMNCj4gPiA+IGJlZm9yZSB0
aGUgY29weSBoYXMgY29tcGxldGVkLiBGb3IgZXhhbXBsZSwgYW4gYXJjaGl2ZSBtaWdodCBjb250
YWlucw0KPiBmaWxlcw0KPiA+ID4gb3duZWQgYnkgcm9vdCBhbmQgdGhlIGFyY2hpdmUgaXMgZXh0
cmFjdGVkIGJ5IHJvb3QuDQo+ID4gPg0KPiA+ID4gVGhlbiwgc2luY2UgcG9ydGFibGUgc2lnbmF0
dXJlcyBhcmUgaW1tdXRhYmxlLCBhbGwgc3Vic2VxdWVudA0KPiBvcGVyYXRpb25zDQo+ID4gPiBm
YWlsIChlLmcuIGZjaG93bigpKSwgZXZlbiBpZiB0aGUgb3BlcmF0aW9uIGlzIGxlZ2l0aW1hdGUg
KGRvZXMgbm90IGFsdGVyDQo+ID4gPiB0aGUgY3VycmVudCB2YWx1ZSkuDQo+ID4gPg0KPiA+ID4g
VGhpcyBwYXRjaCBhdm9pZHMgdGhpcyBwcm9ibGVtIGJ5IHJlcG9ydGluZyBzdWNjZXNzZnVsIG9w
ZXJhdGlvbiB0byB1c2VyDQo+ID4gPiBzcGFjZSB3aGVuIHRoYXQgb3BlcmF0aW9uIGRvZXMgbm90
IGFsdGVyIHRoZSBjdXJyZW50IHZhbHVlIG9mDQo+IHhhdHRycy9hdHRycy4NCj4gPiA+DQo+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBSb2JlcnRvIFNhc3N1IDxyb2JlcnRvLnNhc3N1QGh1YXdlaS5jb20+
DQo+ID4gPiAtLS0NCj4gPiA+ICBzZWN1cml0eS9pbnRlZ3JpdHkvZXZtL2V2bV9tYWluLmMgfCA5
Ng0KPiA+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gIDEgZmlsZSBj
aGFuZ2VkLCA5NiBpbnNlcnRpb25zKCspDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL3NlY3Vy
aXR5L2ludGVncml0eS9ldm0vZXZtX21haW4uYw0KPiA+ID4gYi9zZWN1cml0eS9pbnRlZ3JpdHkv
ZXZtL2V2bV9tYWluLmMNCj4gPiA+IGluZGV4IGVhYjUzNmZhMjYwZi4uYTA3NTE2ZGNiOTIwIDEw
MDY0NA0KPiA+ID4gLS0tIGEvc2VjdXJpdHkvaW50ZWdyaXR5L2V2bS9ldm1fbWFpbi5jDQo+ID4g
PiArKysgYi9zZWN1cml0eS9pbnRlZ3JpdHkvZXZtL2V2bV9tYWluLmMNCj4gPiA+IEBAIC0xOCw2
ICsxOCw3IEBADQo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L2ludGVncml0eS5oPg0KPiA+ID4gICNp
bmNsdWRlIDxsaW51eC9ldm0uaD4NCj4gPiA+ICAjaW5jbHVkZSA8bGludXgvbWFnaWMuaD4NCj4g
PiA+ICsjaW5jbHVkZSA8bGludXgvcG9zaXhfYWNsX3hhdHRyLmg+DQo+ID4gPg0KPiA+ID4gICNp
bmNsdWRlIDxjcnlwdG8vaGFzaC5oPg0KPiA+ID4gICNpbmNsdWRlIDxjcnlwdG8vaGFzaF9pbmZv
Lmg+DQo+ID4gPiBAQCAtMzI4LDYgKzMyOSw3OSBAQCBzdGF0aWMgZW51bSBpbnRlZ3JpdHlfc3Rh
dHVzDQo+ID4gPiBldm1fdmVyaWZ5X2N1cnJlbnRfaW50ZWdyaXR5KHN0cnVjdCBkZW50cnkgKmRl
bnRyeSkNCj4gPiA+ICAJcmV0dXJuIGV2bV92ZXJpZnlfaG1hYyhkZW50cnksIE5VTEwsIE5VTEws
IDAsIE5VTEwpOw0KPiA+ID4gIH0NCj4gPiA+DQo+ID4gPiArLyoNCj4gPiA+ICsgKiBldm1feGF0
dHJfYWNsX2NoYW5nZSAtIGNoZWNrIGlmIHBhc3NlZCBBQ0wgY2hhbmdlcyB0aGUgaW5vZGUNCj4g
bW9kZQ0KPiA+ID4gKyAqIEBkZW50cnk6IHBvaW50ZXIgdG8gdGhlIGFmZmVjdGVkIGRlbnRyeQ0K
PiA+ID4gKyAqIEB4YXR0cl9uYW1lOiByZXF1ZXN0ZWQgeGF0dHINCj4gPiA+ICsgKiBAeGF0dHJf
dmFsdWU6IHJlcXVlc3RlZCB4YXR0ciB2YWx1ZQ0KPiA+ID4gKyAqIEB4YXR0cl92YWx1ZV9sZW46
IHJlcXVlc3RlZCB4YXR0ciB2YWx1ZSBsZW5ndGgNCj4gPiA+ICsgKg0KPiA+ID4gKyAqIENoZWNr
IGlmIHBhc3NlZCBBQ0wgY2hhbmdlcyB0aGUgaW5vZGUgbW9kZSwgd2hpY2ggaXMgcHJvdGVjdGVk
IGJ5DQo+ID4gPiBFVk0uDQo+ID4gPiArICoNCj4gPiA+ICsgKiBSZXR1cm5zIDEgaWYgcGFzc2Vk
IEFDTCBjYXVzZXMgaW5vZGUgbW9kZSBjaGFuZ2UsIDAgb3RoZXJ3aXNlLg0KPiA+ID4gKyAqLw0K
PiA+ID4gK3N0YXRpYyBpbnQgZXZtX3hhdHRyX2FjbF9jaGFuZ2Uoc3RydWN0IGRlbnRyeSAqZGVu
dHJ5LCBjb25zdCBjaGFyDQo+ID4gPiAqeGF0dHJfbmFtZSwNCj4gPiA+ICsJCQkJY29uc3Qgdm9p
ZCAqeGF0dHJfdmFsdWUsIHNpemVfdA0KPiA+ID4geGF0dHJfdmFsdWVfbGVuKQ0KPiA+ID4gK3sN
Cj4gPiA+ICsJdW1vZGVfdCBtb2RlOw0KPiA+ID4gKwlzdHJ1Y3QgcG9zaXhfYWNsICphY2wgPSBO
VUxMLCAqYWNsX3JlczsNCj4gPiA+ICsJc3RydWN0IGlub2RlICppbm9kZSA9IGRfYmFja2luZ19p
bm9kZShkZW50cnkpOw0KPiA+ID4gKwlpbnQgcmM7DQo+ID4gPiArDQo+ID4gPiArCS8qIFVJRC9H
SUQgaW4gQUNMIGhhdmUgYmVlbiBhbHJlYWR5IGNvbnZlcnRlZCBmcm9tIHVzZXIgdG8gaW5pdCBu
cw0KPiA+ID4gKi8NCj4gPiA+ICsJYWNsID0gcG9zaXhfYWNsX2Zyb21feGF0dHIoJmluaXRfdXNl
cl9ucywgeGF0dHJfdmFsdWUsDQo+ID4gPiB4YXR0cl92YWx1ZV9sZW4pOw0KPiA+ID4gKwlpZiAo
IWFjbCkNCj4gPg0KPiA+IEJhc2VkIG9uIE1pbWkncyByZXZpZXcsIEkgd2lsbCBjaGFuZ2UgdGhp
cyB0bzoNCj4gPg0KPiA+IGlmIChJU19FUlJfT1JfTlVMTChhY2wpKQ0KPiA+DQo+ID4gPiArCQly
ZXR1cm4gMTsNCj4gPiA+ICsNCj4gPiA+ICsJYWNsX3JlcyA9IGFjbDsNCj4gPiA+ICsJcmMgPSBw
b3NpeF9hY2xfdXBkYXRlX21vZGUoJmluaXRfdXNlcl9ucywgaW5vZGUsICZtb2RlLA0KPiA+ID4g
JmFjbF9yZXMpOw0KPiA+DQo+ID4gQWJvdXQgdGhpcyBwYXJ0LCBwcm9iYWJseSBpdCBpcyBub3Qg
Y29ycmVjdC4NCj4gPg0KPiA+IEknbSB3cml0aW5nIGEgdGVzdCBmb3IgdGhpcyBwYXRjaCB0aGF0
IGNoZWNrcyBpZiBvcGVyYXRpb25zDQo+ID4gdGhhdCBkb24ndCBjaGFuZ2UgdGhlIGZpbGUgbW9k
ZSBzdWNjZWVkIGFuZCB0aG9zZSB0aGF0DQo+ID4gZG8gZmFpbC4NCj4gPg0KPiA+IG1vdW50LWlk
bWFwcGVkIC0tbWFwLW1vdW50IGI6MzAwMTowOjEgL21udCAvbW50LWlkbWFwcGVkDQo+ID4gcHVz
aGQgL21udA0KPiA+IGVjaG8gInRlc3QiID4gdGVzdC1maWxlDQo+ID4gY2hvd24gMzAwMSB0ZXN0
LWZpbGUNCj4gPiBjaGdycCAzMDAxIHRlc3QtZmlsZQ0KPiA+IGNobW9kIDI2NDQgdGVzdC1maWxl
DQo+ID4gPGNoZWNrIGVuYWJsZWQ+DQo+ID4gc2V0ZmFjbCAtLXNldCB1OjpydyxnOjpyLG86OnIs
bTpyIHRlc3QtZmlsZSAoZXhwZWN0ZWQgdG8gc3VjY2VlZCwgY2FsbGVyIGhhcw0KPiBDQVBfRlNF
VElELCBzbyBTX0lTR0lEIGlzIG5vdCBkcm9wcGVkKQ0KPiA+IHNldGZhY2wgLS1zZXQgdTo6cncs
Zzo6cixvOjpyLG06cncgdGVzdC1maWxlIChleHBlY3RlZCB0byBmYWlsKQ0KPiA+IHB1c2hkIC9t
bnQtaWRtYXBwZWQNCj4gPiBjYXBzaCAtLWRyb3A9Y2FwX2ZzZXRpZCAtLSAtYyBzZXRmYWNsIC0t
c2V0IHU6OnJ3LGc6OnIsbzo6ciB0ZXN0LWZpbGUgKGV4cGVjdGVkDQo+IHRvIHN1Y2NlZWQsIGNh
bGxlciBpcyBpbiB0aGUgb3duaW5nIGdyb3VwIG9mIHRlc3QtZmlsZSwgc28gU19JU0dJRCBpcyBu
b3QNCj4gZHJvcHBlZCkNCj4gPg0KPiA+IEFmdGVyIGFkZGluZyBhIGRlYnVnIGxpbmUgaW4gcG9z
aXhfYWNsX3VwZGF0ZV9tb2RlKCk6DQo+ID4gcHJpbnRrKCIlczogJWQoJWQpICVkXG4iLCBfX2Z1
bmNfXywNCj4gaW5fZ3JvdXBfcChpX2dpZF9pbnRvX21udChtbnRfdXNlcm5zLCBpbm9kZSkpLA0K
PiBfX2tnaWRfdmFsKGlfZ2lkX2ludG9fbW50KG1udF91c2VybnMsIGlub2RlKSksDQo+IGNhcGFi
bGVfd3J0X2lub2RlX3VpZGdpZChtbnRfdXNlcm5zLCBpbm9kZSwgQ0FQX0ZTRVRJRCkpOw0KPiA+
DQo+ID4gd2l0aG91dCBwYXNzaW5nIG1udF91c2VybnM6DQo+ID4gWyAgNzQ4LjI2MjU4Ml0gc2V0
ZmFjbCAtLXNldCB1OjpydyxnOjpyLG86OnIsbTpyIHRlc3QtZmlsZQ0KPiA+IFsgIDc0OC4yNjgw
MjFdIHBvc2l4X2FjbF91cGRhdGVfbW9kZTogMCgzMDAxKSAxDQo+ID4gWyAgNzQ4LjI2ODAzNV0g
cG9zaXhfYWNsX3VwZGF0ZV9tb2RlOiAwKDMwMDEpIDENCj4gPiBbICA3NDguMjY4NTcwXSBzZXRm
YWNsIC0tc2V0IHU6OnJ3LGc6OnIsbzo6cixtOnJ3IHRlc3QtZmlsZQ0KPiA+IFsgIDc0OC4yNzQx
OTNdIHBvc2l4X2FjbF91cGRhdGVfbW9kZTogMCgzMDAxKSAxDQo+ID4gWyAgNzQ4LjI3OTE5OF0g
Y2Fwc2ggLS1kcm9wPWNhcF9mc2V0aWQgLS0gLWMgc2V0ZmFjbCAtLXNldCB1OjpydyxnOjpyLG86
OnIgdGVzdC0NCj4gZmlsZQ0KPiA+IFsgIDc0OC4yODc4OTRdIHBvc2l4X2FjbF91cGRhdGVfbW9k
ZTogMCgzMDAxKSAwDQo+ID4NCj4gPiBwYXNzaW5nIG1udF91c2VybnM6DQo+ID4gWyAgIDgxLjE1
OTc2Nl0gc2V0ZmFjbCAtLXNldCB1OjpydyxnOjpyLG86OnIsbTpyIHRlc3QtZmlsZQ0KPiA+IFsg
ICA4MS4xNjUyMDddIHBvc2l4X2FjbF91cGRhdGVfbW9kZTogMCgzMDAxKSAxDQo+ID4gWyAgIDgx
LjE2NTIyNl0gcG9zaXhfYWNsX3VwZGF0ZV9tb2RlOiAwKDMwMDEpIDENCj4gPiBbICAgODEuMTY1
NzMyXSBzZXRmYWNsIC0tc2V0IHU6OnJ3LGc6OnIsbzo6cixtOnJ3IHRlc3QtZmlsZQ0KPiA+IFsg
ICA4MS4xNzA5NzhdIHBvc2l4X2FjbF91cGRhdGVfbW9kZTogMCgzMDAxKSAxDQo+ID4gWyAgIDgx
LjE3NjAxNF0gY2Fwc2ggLS1kcm9wPWNhcF9mc2V0aWQgLS0gLWMgc2V0ZmFjbCAtLXNldCB1Ojpy
dyxnOjpyLG86OnIgdGVzdC0NCj4gZmlsZQ0KPiA+IFsgICA4MS4xODQ2NDhdIHBvc2l4X2FjbF91
cGRhdGVfbW9kZTogMSgwKSAwDQo+ID4gWyAgIDgxLjE4NDY2M10gcG9zaXhfYWNsX3VwZGF0ZV9t
b2RlOiAxKDApIDANCj4gPg0KPiA+IFRoZSBkaWZmZXJlbmNlIGlzIHRoYXQsIGJ5IHBhc3Npbmcg
bW50X3VzZXJucywgdGhlIGNhbGxlciAocm9vdCkgaXMNCj4gPiBpbiB0aGUgb3duaW5nIGdyb3Vw
IG9mIHRoZSBmaWxlICgzMDAxIC0+IDApLiBXaXRob3V0IHBhc3NpbmcgbW50X3VzZXJucywNCj4g
PiBpdCBpcyBub3QgKDMwMDEgLT4gMzAwMSkuDQo+ID4NCj4gPiBDaHJpc3RpYW4sIEFuZHJlYXMs
IGNvdWxkIHlvdSBjb25maXJtIHRoYXQgdGhpcyBpcyBjb3JyZWN0Pw0KPiANCj4gSGV5IFJvYmVy
dCwNCj4gDQo+IFRoYW5rcyBmb3IgdGhlIENjIGFuZCB0aGFua3MgZm9yIHRlc3RpbmcgdGhpcyB3
aXRoIGFuZCB3aXRob3V0IGlkbWFwcGVkDQo+IG1vdW50czsgdmVyeSBtdWNoIGFwcHJlY2lhdGVk
Lg0KPiANCj4gPg0KPiA+IElmIHRoZXJlIGFyZSBubyBvYmplY3Rpb25zLCBJIHdpbGwgc2VuZCBh
biBhZGRpdGlvbmFsIHBhdGNoIHRvIHBhc3MNCj4gPiBtbnRfdXNlcm5zIHRvIEVWTS4NCj4gDQo+
IFllcywgc2luY2UgeW91J3JlIHN0YXJ0aW5nIHRvIHZlcmlmeSBhdHRycyBhbmQgcG9zaXhfYWNs
IGNoYW5nZXMgdGhhdA0KPiBkZWFsIHdpdGggdWlkcy9naWRzIHlvdSBuZWVkIHRvIGFjY291bnQg
Zm9yIHRoZSBtbnRfdXNlcm5zLiBJJ3ZlIHB1bGxlZA0KPiBhbmQgYXBwbGllZCB5b3VyIHBhdGNo
IGxvY2FsbHkgYW5kIGxvb2tlZCB0aHJvdWdoIGl0LiBJIHRoaW5rIHlvdSBuZWVkDQo+IHRvIGNo
YW5nZToNCj4gDQo+IC0gZXZtX2lub2RlX3NldHhhdHRyKCkNCj4gLSBldm1faW5vZGVfcmVtb3Zl
eGF0dHIoKQ0KPiANCj4gdG8gdGFrZSBhIG1udF91c2VybnMuIFRoYXQgc2hvdWxkIGJlIHN0cmFp
Z2h0Zm9yd2FyZC4gSSBhbHJlYWR5IGNoYW5nZWQNCj4gc2VjdXJpdHlfaW5vZGVfc2V0eGF0dHIo
KSB0byBwYXNzIGRvd24gdGhlIG1udF91c2VybnMgc28geW91IG5lZWQgdG8NCj4gc2ltcGx5IHBh
c3MgdGhhdCBmdXJ0aGVyIGRvd246DQo+IA0KPiAtIHNlY3VyaXR5X2lub2RlX3NldHhhdHRyKG1u
dF91c2VybnMsIC4uLikNCj4gICAtPiBldm1faW5vZGVfc2V0eGF0dHIobW50X3VzZXJucywgLi4u
KQ0KPiANCj4gLSBzZWN1cml0eV9pbm9kZV9yZW1vdmV4YXR0cihtbnRfdXNlcm5zLCAuLi4pDQo+
ICAgLT4gZXZtX2lub2RlX3JlbW92ZXhhdHRyKG1udF91c2VybnMsIC4uLikNCg0KSGkgQ2hyaXN0
aWFuDQoNCnllcywgSSBjaGFuZ2VkIGJvdGguDQoNCj4gVGhlIHJlc3QgbG9va3Mgc2FuZSB0byBt
ZS4NCj4gDQo+IEZ3aXcsIEknbSBtYWludGluZyBhIGxhcmdlIHRlc3Qtc3VpdGUgdGhhdCBJIHdy
b3RlIGZvciBpZG1hcHBlZCBtb3VudHMNCj4gYnV0IHRoYXQgYWltcyB0byBjb3ZlciBhbGwgdmZz
IG9wZXJhdGlvbnMgaW5kZXBlbmRlbnQgb2YgdGhlbS4gSXQgYWltcw0KPiBmb3I6DQo+IC0gdGVz
dCB2ZnMgZmVhdHVyZSB4IG9uIHJlZ3VsYXIgbW91bnRzDQo+IC0gdGVzdCB2ZnMgZmVhdHVyZSBv
biBpZG1hcHBlZCBtb3VudHMNCj4gLSB0ZXN0IHZmcyBmZWF0dXJlIGluIHVzZXIgbmFtZXNwYWNl
cw0KPiAtIHRlc3QgdmZzIGZlYXR1cmUgb24gaWRtYXBwZWQgbW91bnQgaW4gdXNlciBuYW1lc3Bh
Y2VzDQo+IEknbSBpbiB0aGUgcHJvY2VzcyBvZiB1cHN0cmVhbWluZyBpdCBmb3IgeGZzdGVzdHMg
KGNmLiBbMV0pLiBJdCBhbHNvDQo+IGluY2x1ZGVzIHRlc3RzIGZvciB4YXR0cnMvYWNscyBhbmQg
ZnNjYXBzLiBpZiBpbWEgYW5kIGV2bSB3YW50IHRvIGFkZA0KPiBzb21ldGhpbmcgdG8gdGhpcyB0
aGF0J2QgYmUgZ3JlYXQgYnV0IGlmIHlvdSBtYWludGFpbiB5b3VyIG93biB0ZXN0aW5nDQo+IHRo
YXQncyBvZiBjb3Vyc2UgdG90YWxseSBvay4NCj4gWzFdOiBodHRwczovL2dpdC5rZXJuZWwub3Jn
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9icmF1bmVyL3hmc3Rlc3RzLQ0KPiBkZXYuZ2l0L2xv
Zy8/aD1pZG1hcHBlZF9tb3VudHMNCg0KWWVzLCBJIHRoaW5rIGl0IHdvdWxkIGJlIGdvb2QgdG8g
aGF2ZSBtb3JlIHRlc3RzIGFuZCBjb21wYXJlDQpJTUEvRVZNIGJlaGF2aW9yIGJldHdlZW4gbm9u
IGFuZCBpZG1hcHBlZCBtb3VudHMuDQoNCkZvciBub3csIEkgd2FudGVkIHRvIGJlIHN1cmUgdGhh
dCBteSBwYXRjaCBzZXQgd29ya3Mgd2VsbA0Kb24gdG9wIG9mIHlvdXIgcGF0Y2hlcy4gVGhhbmtz
IGEgbG90IGZvciByZXZpZXdpbmcgdGhpcyENCg0KUm9iZXJ0bw0KDQpIVUFXRUkgVEVDSE5PTE9H
SUVTIER1ZXNzZWxkb3JmIEdtYkgsIEhSQiA1NjA2Mw0KTWFuYWdpbmcgRGlyZWN0b3I6IExpIFBl
bmcsIExpIEppYW4sIFNoaSBZYW5saQ0KDQo+IFRoYW5rcyENCj4gQ2hyaXN0aWFuDQo=
