Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A58AA11A62B
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2019 09:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfLKIpJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Dec 2019 03:45:09 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2178 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725973AbfLKIpJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Dec 2019 03:45:09 -0500
Received: from lhreml708-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id BBB50C8AB48106930635;
        Wed, 11 Dec 2019 08:45:07 +0000 (GMT)
Received: from fraeml706-chm.china.huawei.com (10.206.15.55) by
 lhreml708-cah.china.huawei.com (10.201.108.49) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 11 Dec 2019 08:45:07 +0000
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 11 Dec 2019 09:45:06 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1713.004;
 Wed, 11 Dec 2019 09:45:06 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>,
        "david.safford@ge.com" <david.safford@ge.com>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: Does IMA support SHA-256 PCR banks?
Thread-Topic: Does IMA support SHA-256 PCR banks?
Thread-Index: AQHVr6ptwzBz7E0SPkqTsqbIGjKxw6e0me/w
Date:   Wed, 11 Dec 2019 08:45:06 +0000
Message-ID: <36fb73d7534f47b6906c348792bd5d96@huawei.com>
References: <62e91411-d38d-8b75-bf0e-849fdd3c447f@linux.microsoft.com>
In-Reply-To: <62e91411-d38d-8b75-bf0e-849fdd3c447f@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.220.96.108]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1pbnRlZ3JpdHktb3du
ZXJAdmdlci5rZXJuZWwub3JnIFttYWlsdG86bGludXgtaW50ZWdyaXR5LQ0KPiBvd25lckB2Z2Vy
Lmtlcm5lbC5vcmddIE9uIEJlaGFsZiBPZiBMYWtzaG1pIFJhbWFzdWJyYW1hbmlhbg0KPiBTZW50
OiBUdWVzZGF5LCBEZWNlbWJlciAxMCwgMjAxOSAxMTozNyBQTQ0KPiBUbzogSmFtZXMgQm90dG9t
bGV5IDxKYW1lcy5Cb3R0b21sZXlASGFuc2VuUGFydG5lcnNoaXAuY29tPjsNCj4gamFya2tvLnNh
a2tpbmVuQGxpbnV4LmludGVsLmNvbTsgTWltaSBab2hhciA8em9oYXJAbGludXguaWJtLmNvbT47
DQo+IGxpbnV4LWludGVncml0eUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogRG9lcyBJTUEg
c3VwcG9ydCBTSEEtMjU2IFBDUiBiYW5rcz8NCj4gDQo+IEhpLA0KPiANCj4gSSBub3RpY2VkIHRo
YXQgZXZlbiB3aGVuIFNIQS0yNTYgaXMgc2VsZWN0ZWQgYXMgdGhlIGRpZ2VzdCBhbGdvcml0aG0g
Zm9yDQo+IElNQSBtZWFzdXJlbWVudCwgdGhlIFBDUiBoYXNoIGlzIHN0aWxsIFNIQS0xLg0KPiAN
Cj4gQSBuZXQgc2VhcmNoIGZvdW5kIHRoZSB0ZXh0IGdpdmVuIGJlbG93IGluIHRoZSBmb2xsb3dp
bmcgd2lraToNCj4gICAgIGh0dHBzOi8vd2lraS5zdHJvbmdzd2FuLm9yZy9wcm9qZWN0cy9zdHJv
bmdzd2FuL3dpa2kvSU1BDQo+IA0KPiAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqDQo+ICoqKioqKioqKioqKg0KPiBTaW5jZSBTSEEtMSBo
YXMgYmVlbiAic2hhdHRlcmVkIiB3ZSByZWNvbW1lbmQgdG8gdXNlIFNIQS0yNTYgZm9yIHRoZQ0K
PiBmaWxlIG1lYXN1cmVtZW50IGhhc2hlcy4NCj4gDQo+IElNQSBpbXBsZW1lbnRhdGlvbiBkb2Vz
IG5vdCBzdXBwb3J0IFNIQS0yNTYgUENSIGJhbmtzIHlldCwgc28gdGhlDQo+IFNIQS0yNTYgZmls
ZSBoYXNoZXMgYXJlIGV4dGVuZGVkIGludG8gU0hBLTEgUENSIHJlZ2lzdGVycy4NCj4gKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKg0KPiAq
KioqKioqKioqKioNCj4gDQo+IElzIHRoZSBhYm92ZSBzdGlsbCB0cnVlPw0KPiANCj4gSW4gaW1h
X2luaXRfZGlnZXN0cygpIHRoZSBkaWdlc3QgYWxnb3JpdGhtIGZvciBQQ1IgZXh0ZW5kIGlzIHNl
dCBmcm9tDQo+IHRoZSBkaWdlc3QgYWxnb3JpdGhtIHNldCBpbiB0aGUgUENSIGJhbmtzLg0KPiAN
Cj4gSXMgdGhlcmUgYSB3YXkgdG8gY29uZmlndXJlIElNQSB0byB1c2UgU0hBLTI1NiBQQ1IgYmFu
a3M/DQo+IA0KPiBpbnQgX19pbml0IGltYV9pbml0X2RpZ2VzdHModm9pZCkNCj4gew0KPiAuLi4N
Cj4gCWZvciAoaSA9IDA7IGkgPCBpbWFfdHBtX2NoaXAtPm5yX2FsbG9jYXRlZF9iYW5rczsgaSsr
KQ0KPiAJCWRpZ2VzdHNbaV0uYWxnX2lkID0gaW1hX3RwbV9jaGlwLT5hbGxvY2F0ZWRfYmFua3Nb
aV0uYWxnX2lkOw0KPiAuLi4NCg0KSGkgTGFrc2htaQ0KDQpjdXJyZW50bHkgdGhlIFNIQTI1NiBQ
Q1IgYmFuayBpcyBleHRlbmRlZCB3aXRoIGEgcGFkZGVkIFNIQTEuDQoNClNvbWUgdGltZSBhZ28s
IEkgcG9zdGVkIHNvbWUgcGF0Y2hlcyB0byBzdXBwb3J0IHRoZSBUR0MgQ3J5cHRvIEFnaWxlIGZv
cm1hdDoNCg0KaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTcvNS8xNi8zNjkNCg0KSG93ZXZlciwg
dGhpcyBpcyBhIGJpdCBjb21wbGljYXRlIGJlY2F1c2UgdGhlIGN1cnJlbnQgZm9ybWF0IGRvZXMg
bm90IGZvbGxvdw0KdGhlIFRDRyBzdGFuZGFyZC4gQSB3b3JrIHRvIHN1cHBvcnQgdGhlIG5ldyBJ
TUEgQ2Fub25pY2FsIEV2ZW50IExvZyBmb3JtYXQNCmhhcyBiZWVuIHByZXNlbnRlZCBhdCBMU1M6
DQoNCmh0dHBzOi8vc3RhdGljLnNjaGVkLmNvbS9ob3N0ZWRfZmlsZXMvbHNzbmExOC8wMy9sc3Nf
MjAxOF9zbGlkZXNfVjQucGRmDQoNCkdpdmVuIHRoYXQgdGhlIHBhdGNoZXMgYXJlIHZlcnkgaW52
YXNpdmUsIHRvIG1lIHNlZW1zIGEgZ29vZCBpZGVhIHRvIHNwbGl0IHRoaXMNCndvcmsgaW4gdHdv
IHBhcnRzOiBmaXJzdCwgZXh0ZW5kIFBDUnMgd2l0aCB0aGUgY29ycmVjdCBkaWdlc3QgYW5kIHNl
Y29uZA0KY2hhbmdlIHRoZSBtZWFzdXJlbWVudCBsaXN0IGZvcm1hdC4NCg0KRm9yIHRoZSBmaXJz
dCBwYXJ0LCB0aGUgcGF0Y2ggd2lsbCBiZSB2ZXJ5IHNpbXBsZSwgYXMgSU1BIHdpbGwganVzdCBx
dWVyeSB0aGUgVFBNDQp0byBnZXQgdGhlIGxpc3Qgb2YgaGFzaCBhbGdvcml0aG1zIGFuZCB3aWxs
IGNhbGN1bGF0ZSBhbGwgdGhlIGRpZ2VzdHMgaW4NCmltYV9jYWxjX2ZpZWxkX2FycmF5X2hhc2go
KS4NCg0KQWxzbywgdGhlIGZpcnN0IHBhcnQgd291bGQgYmUgc3VmZmljaWVudCBmb3IgcmVtb3Rl
IGF0dGVzdGF0aW9uLCBhcyB0aGUgZGF0YSB1c2VkDQp0byBjYWxjdWxhdGUgdGhlIGRpZ2VzdHMg
aXMgcGFzc2VkIHRvIHRoZSB2ZXJpZmllci4gVGhlIHZlcmlmaWVyIGNhbiBjYWxjdWxhdGUgYnkN
CmhpbXNlbGYgdGhlIGRpZ2VzdCBvZiBub24tU0hBMSBQQ1IgYmFua3MsIGV2ZW4gaWYgdGhleSBh
cmUgbm90IGluY2x1ZGVkIGluIHRoZQ0KbWVhc3VyZW1lbnQgbGlzdC4NCg0KUm9iZXJ0bw0K
