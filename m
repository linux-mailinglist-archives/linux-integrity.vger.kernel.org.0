Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86A9E14DDC8
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jan 2020 16:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgA3P11 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jan 2020 10:27:27 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2329 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727186AbgA3P11 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jan 2020 10:27:27 -0500
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 193B34E794727836E010;
        Thu, 30 Jan 2020 15:27:25 +0000 (GMT)
Received: from fraeml715-chm.china.huawei.com (10.206.15.34) by
 LHREML711-CAH.china.huawei.com (10.201.108.34) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 30 Jan 2020 15:27:24 +0000
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 30 Jan 2020 16:27:24 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1713.004;
 Thu, 30 Jan 2020 16:27:24 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>
CC:     Jerry Snitselaar <jsnitsel@redhat.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] ima: use the IMA configured hash algo to calculate
 the boot aggregate
Thread-Topic: [PATCH 1/2] ima: use the IMA configured hash algo to calculate
 the boot aggregate
Thread-Index: AQHV1SsskZfHgOFdME+uHgUEG6qPTKf+632AgAALuoCAAkpuAIAA8HoAgADpZbA=
Date:   Thu, 30 Jan 2020 15:27:24 +0000
Message-ID: <2e3ec5f5a4e748a898baeac8a88487ab@huawei.com>
References: <1580140919-6127-1-git-send-email-zohar@linux.ibm.com>
         <20200127204941.2ewman4y5nzvkjqe@cantor>
         <1580160699.5088.64.camel@linux.ibm.com>
 <20200129083034.GA387@dell5510> <1580338276.4790.8.camel@linux.ibm.com>
In-Reply-To: <1580338276.4790.8.camel@linux.ibm.com>
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
Lmtlcm5lbC5vcmddIE9uIEJlaGFsZiBPZiBNaW1pIFpvaGFyDQo+IFNlbnQ6IFdlZG5lc2RheSwg
SmFudWFyeSAyOSwgMjAyMCAxMTo1MSBQTQ0KPiBUbzogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+DQo+IENjOiBKZXJyeSBTbml0c2VsYWFyIDxqc25pdHNlbEByZWRoYXQuY29tPjsgbGludXgt
aW50ZWdyaXR5QHZnZXIua2VybmVsLm9yZzsNCj4gSmFtZXMgQm90dG9tbGV5IDxKYW1lcy5Cb3R0
b21sZXlAaGFuc2VucGFydG5lcnNoaXAuY29tPjsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IFJvYmVydG8gU2Fzc3UgPHJvYmVydG8uc2Fzc3VAaHVhd2VpLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCAxLzJdIGltYTogdXNlIHRoZSBJTUEgY29uZmlndXJlZCBoYXNoIGFsZ28g
dG8gY2FsY3VsYXRlDQo+IHRoZSBib290IGFnZ3JlZ2F0ZQ0KPiANCj4gT24gV2VkLCAyMDIwLTAx
LTI5IGF0IDA5OjMwICswMTAwLCBQZXRyIFZvcmVsIHdyb3RlOg0KPiA+IEhpIE1pbWksDQo+ID4N
Cj4gPiBSZXZpZXdlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+DQo+ID4NCj4gPiA+
IFRoZSBvcmlnaW5hbCBMVFAgaW1hX2Jvb3RfYWdncmVnYXRlLmMgdGVzdCBuZWVkZWQgdG8gYmUg
dXBkYXRlZCB0bw0KPiA+ID4gc3VwcG9ydCBUUE0gMi4wIGJlZm9yZSB0aGlzIGNoYW5nZS4gwqBG
b3IgVFBNIDIuMCwgdGhlIFBDUnMgYXJlIG5vdA0KPiA+ID4gZXhwb3J0ZWQuIMKgV2l0aCB0aGlz
IGNoYW5nZSwgdGhlIGtlcm5lbCBjb3VsZCBiZSByZWFkaW5nIFBDUnMgZnJvbSBhDQo+ID4gPiBU
UE0gYmFuayBvdGhlciB0aGFuIFNIQTEgYW5kIGNhbGN1bGF0aW5nIHRoZSBib290X2FnZ3JlZ2F0
ZSBiYXNlZCBvbg0KPiBhDQo+ID4gPiBkaWZmZXJlbnQgaGFzaCBhbGdvcml0aG0gYXMgd2VsbC4g
wqBJJ20gbm90IHN1cmUgaG93IGEgcmVtb3RlIHZlcmlmaWVyDQo+ID4gPiB3b3VsZCBrbm93IHdo
aWNoIFRQTSBiYW5rIHdhcyByZWFkLCB3aGVuIGNhbGN1bGF0aW5nIHRoZSBib290LQ0KPiA+ID4g
YWdncmVnYXRlLg0KPiA+IE1pbWksIGRvIHlvdSBwbGFuIHRvIGRvIHVwZGF0ZSBMVFAgdGVzdD8N
Cj4gDQo+IEluIG9yZGVyIHRvIHRlc3QgUm9iZXJ0bydzIHBhdGNoZXMgdGhhdCBjYWxjdWxhdGVz
IGFuZCBleHRlbmRzIHRoZQ0KPiBkaWZmZXJlbnQgVFBNIGJhbmtzIHdpdGggdGhlIGFwcHJvcHJp
YXRlIGhhc2hlcywgd2UnbGwgbmVlZCBzb21lIHRlc3QNCj4gdG8gdmVyaWZ5IHRoYXQgaXQgaXMg
d29ya2luZyBwcm9wZXJseS4gwqBBcyB0byB3aGV0aGVyIHRoaXMgd2lsbCBiZSBpbg0KPiBMVFAg
b3IgaW1hLWV2bS11dGlscywgSSdtIG5vdCBzdXJlLg0KDQphdHRlc3QtdG9vbHMgKGh0dHBzOi8v
Z2l0aHViLmNvbS9ldWxlcm9zL2F0dGVzdC10b29scywgYnJhbmNoIDAuMi1kZXZlbCkgaGFzIHRo
ZQ0KYWJpbGl0eSB0byBwYXJzZSB0aGUgQklPUyBhbmQgSU1BIGV2ZW50IGxvZ3MsIGFuZCB0byBj
b21wYXJlIGJvb3RfYWdncmVnYXRlDQp3aXRoIHRoZSBkaWdlc3Qgb2YgZmluYWwgUENSIHZhbHVl
cyBvYnRhaW5lZCBieSBwZXJmb3JtaW5nIGluIHNvZnR3YXJlIHRoZSBQQ1INCmV4dGVuZCBvcGVy
YXRpb24gd2l0aCBkaWdlc3RzIGluIHRoZSBCSU9TIGV2ZW50IGxvZy4NCg0KVG8gcGVyZm9ybSB0
aGUgdGVzdCwgaXQgaXMgbmVjZXNzYXJ5IHRvIGhhdmUgYSBjb21wbGV0ZSBCSU9TIGV2ZW50IGxv
Zy4NCg0KQ3JlYXRlIHJlcS5qc29uIHdpdGggdGhpcyBjb250ZW50Og0KLS0tDQp7DQogICJyZXFz
Ijp7DQogICAgImR1bW15fHZlcmlmeSI6IiIsDQogICAgImltYV9ib290X2FnZ3JlZ2F0ZXx2ZXJp
ZnkiOiIiDQogIH0NCn0NCi0tLQ0KDQpXaXRoIHRoZSByZXF1aXJlbWVudHMgYWJvdmUsIHdlIGFy
ZSB0ZWxsaW5nIGF0dGVzdC10b29scyB0byB2ZXJpZnkgb25seQ0KYm9vdF9hZ2dyZWdhdGUuIFdp
dGhvdXQgdGhlIGR1bW15IHJlcXVpcmVtZW50LCB2ZXJpZmljYXRpb24gd291bGQNCmZhaWwgKEJJ
T1MgYW5kIHJlbWFpbmluZyBJTUEgbWVhc3VyZW1lbnQgZW50cmllcyBhcmUgbm90IHByb2Nlc3Nl
ZCkuDQoNCk9uIHNlcnZlciBzaWRlIHJ1bjoNCiMgYXR0ZXN0X3JhX3NlcnZlciAtcCAxMCAtciBy
ZXEuanNvbiAtcyAtaQ0KDQotcyBkaXNhYmxlcyBUUE0gc2lnbmF0dXJlIHZlcmlmaWNhdGlvbg0K
LWkgYWxsb3dzIElNQSB2aW9sYXRpb25zDQoNClRvIGVuYWJsZSBUUE0gc2lnbmF0dXJlIHZlcmlm
aWNhdGlvbiBpdCBpcyBuZWNlc3NhcnkgdG8gaGF2ZSBhIHZhbGlkIEFLDQpjZXJ0aWZpY2F0ZS4g
SXQgY2FuIGJlIG9idGFpbmVkIGJ5IGZvbGxvd2luZyB0aGUgaW5zdHJ1Y3Rpb25zIGF0Og0KDQpo
dHRwczovL2dpdGh1Yi5jb20vZXVsZXJvcy9hdHRlc3QtdG9vbHMvYmxvYi8wLjItZGV2ZWwvUkVB
RE1FDQoNCk9uIGNsaWVudCBzaWRlIHJ1bjoNCiMgZWNobyB0ZXN0ID4gYWlrX2NlcnQucGVtDQoj
IGVjaG8gYWlrX2NlcnQucGVtID4gbGlzdF9wcml2YWN5X2NhDQojIGF0dGVzdF9yYV9jbGllbnQg
LUENCg0KVGhlIGNvbW1hbmQgYWJvdmUgZ2VuZXJhdGVzIGFuIEFLLg0KDQojIGF0dGVzdF9yYV9j
bGllbnQgLXMgPHNlcnZlciBJUD4gLXEgLXAgMTAgLVAgPFBDUiBhbGdvPiAtYiAtaQ0KDQpUaGUg
Y29tbWFuZCBhYm92ZSBzZW5kcyB0aGUgVFBNIHF1b3RlIGFuZCB0aGUgZXZlbnQgbG9ncw0KdG8g
dGhlIFJBIHNlcnZlciBhbmQgZ2V0cyB0aGUgcmVzcG9uc2UgKHN1Y2Nlc3NmdWwvZmFpbGVkDQp2
ZXJpZmljYXRpb24pLg0KDQotYiBpbmNsdWRlcyB0aGUgQklPUyBldmVudCBsb2cgZnJvbSBzZWN1
cml0eWZzDQotaSBpbmNsdWRlcyB0aGUgSU1BIGV2ZW50IGxvZyBmcm9tIHNlY3VyaXR5ZnMNCg0K
VG8gY2hlY2sgdGhhdCBib290X2FnZ3JlZ2F0ZSBpcyBjYWxjdWxhdGVkIHByb3Blcmx5LCB1c2Ug
LVAgc2hhMjU2DQppbiBhdHRlc3RfcmFfY2xpZW50IGFuZCBzZXQgaW1hX2hhc2g9c2hhMjU2IGlu
IHRoZSBrZXJuZWwgY29tbWFuZA0KbGluZS4NCg0KUm9iZXJ0bw0KDQpIVUFXRUkgVEVDSE5PTE9H
SUVTIER1ZXNzZWxkb3JmIEdtYkgsIEhSQiA1NjA2Mw0KTWFuYWdpbmcgRGlyZWN0b3I6IExpIFBl
bmcsIExpIEppYW4sIFNoaSBZYW5saQ0K
