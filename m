Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226561E3445
	for <lists+linux-integrity@lfdr.de>; Wed, 27 May 2020 03:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgE0BBJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 May 2020 21:01:09 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:8758 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727087AbgE0BBI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 May 2020 21:01:08 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04R0pgNA017182
        for <linux-integrity@vger.kernel.org>; Tue, 26 May 2020 21:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=cqBZ+w+y68912QKata+dRiCmT9/WdJb55+IBOvnxYXc=;
 b=u3g1gxEaa0bcJQ9fSbn4ElqrJQEO6jm3qzdm9TlZW3e9xIB+9h29F5+l194/cTVL82IW
 J9mioueuJscxUNMUClVHgNrHaWQtFsx0lSuiXH586/R2bCC293ceK3zGcIz7xdwS34Du
 OUpC0446f4GB6UWE3sig8k0dKAfGbbc1d4MTlnTMkTGJobDh9NGArQG9fIxeZ/o/rFMg
 cxzNjpt0N4MhmSsSDHyX7rYN1NcJwACaJ2SX/aZGIWQPxhQqslnhPaTBqtgYIka+lQDV
 kgGhm8T459hBnLVAq4ZtzsDKrQopnmiv7/oQe+lSe3RLA4t02Z+bGf+HY8/mmQSGwx7b eg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 316xw4shnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 26 May 2020 21:01:06 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04R0vamc137499
        for <linux-integrity@vger.kernel.org>; Tue, 26 May 2020 21:01:06 -0400
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com [143.166.85.207])
        by mx0b-00154901.pphosted.com with ESMTP id 3192py1x9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-integrity@vger.kernel.org>; Tue, 26 May 2020 21:01:06 -0400
X-LoopCount0: from 10.166.132.133
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,346,1549951200"; 
   d="scan'208";a="1391548170"
From:   <Mario.Limonciello@dell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <linux-integrity@vger.kernel.org>
CC:     <jarkko.sakkinen@linux.intel.com>, <jgg@ziepe.ca>, <alex@guzman.io>
Subject: RE: [PATCH] tpm2: fix TIS locality timeout problems
Thread-Topic: [PATCH] tpm2: fix TIS locality timeout problems
Thread-Index: AQHWM71TdkaIqWWU9ECoNeApMw2a5Ki7HJuA
Date:   Wed, 27 May 2020 01:01:03 +0000
Message-ID: <661a6a2fadba44fb82846c6b3b5bfe73@AUSX13MPC105.AMER.DELL.COM>
References: <1590539114.3576.5.camel@HansenPartnership.com>
In-Reply-To: <1590539114.3576.5.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-05-27T01:01:02.5419807Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=cf0c2f15-1f07-4139-a961-13662ab5e466;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.28]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_04:2020-05-26,2020-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 suspectscore=0
 cotscore=-2147483648 malwarescore=0 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270002
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005270001
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFtZXMgQm90dG9tbGV5
IDxKYW1lcy5Cb3R0b21sZXlASGFuc2VuUGFydG5lcnNoaXAuY29tPg0KPiBTZW50OiBUdWVzZGF5
LCBNYXkgMjYsIDIwMjAgNzoyNSBQTQ0KPiBUbzogbGludXgtaW50ZWdyaXR5QHZnZXIua2VybmVs
Lm9yZw0KPiBDYzogSmFya2tvIFNha2tpbmVuOyBKYXNvbiBHdW50aG9ycGU7IExpbW9uY2llbGxv
LCBNYXJpbzsgQWxleCBHdXptYW4NCj4gU3ViamVjdDogW1BBVENIXSB0cG0yOiBmaXggVElTIGxv
Y2FsaXR5IHRpbWVvdXQgcHJvYmxlbXMNCj4gDQo+IA0KPiBbRVhURVJOQUwgRU1BSUxdDQo+IA0K
PiBJdCBoYXMgYmVlbiByZXBvcnRlZCB0aGF0IHNvbWUgVElTIGJhc2VkIFRQTXMgYXJlIGdpdmlu
ZyB1bmV4cGVjdGVkDQo+IGVycm9ycyB3aGVuIHVzaW5nIHRoZSBPX05PTkJMT0NLIHBhdGguICBU
aGUgcHJvYmxlbSBpcyB0aGF0IHNvbWUgVFBNcw0KPiBkb24ndCBsaWtlIGl0IHdoZW4geW91IGdl
dCBhbmQgdGhlbiByZWxpbnF1aXNoIGEgbG9jYWxpdHkgKGFzIHRoZQ0KPiB0cG1fdHJ5X2dldF9v
cHMvdHBtX3B1dF9vcHMgcGFpciBkb2VzKSB3aXRob3V0IHNlbmRpbmcgYSBjb21tYW5kLg0KPiBU
aGlzIGN1cnJlbnRseSBoYXBwZW5zIGFsbCB0aGUgdGltZSBpbiB0aGUgT19OT05CTE9DSyB3cml0
ZSBwYXRoLiAgV2UNCj4gY2FuIGZpeCB0aGlzIGJ5IG1vdmluZyB0aGUgdHBtX3RyeV9nZXRfb3Bz
IGZ1cnRoZXIgZG93biB0aGUgY29kZSB0bw0KPiBhZnRlciB0aGUgT19OT05CTE9DSyBkZXRlcm1p
bmF0aW9uIGlzIG1hZGUuICBUaGlzIGlzIHNhZmUgYmVjYXVzZSB0aGUNCj4gcHJpdi0+YnVmZmVy
X211dGV4IHN0aWxsIHByb3RlY3RzIHRoZSBwcml2IHN0YXRlIGJlaW5nIG1vZGlmaWVkLg0KPiAN
Cj4gRml4ZXM6IGQyM2QxMjQ4NDMwNyAoInRwbTogZml4IGludmFsaWQgbG9ja2luZyBpbiBOT05C
TE9DS0lORyBtb2RlIikNCj4gUmVwb3J0ZWQtYnk6IE1hcmlvIExpbW9uY2llbGxvIDxNYXJpby5M
aW1vbmNpZWxsb0BkZWxsLmNvbT4NCj4gVGVzdGVkLWJ5OiBBbGV4IEd1em1hbiA8YWxleEBndXpt
YW4uaW8+DQo+IFNpZ25lZC1vZmYtYnk6IEphbWVzIEJvdHRvbWxleSA8SmFtZXMuQm90dG9tbGV5
QEhhbnNlblBhcnRuZXJzaGlwLmNvbT4NCg0KQSBmZXcgb3RoZXIgbm90ZXMgZm9yIHJpZ2h0IGhl
cmU6DQoNCiogWW91IHNob3VsZCBwcm9iYWJseSBtZW50aW9uIHRoaXMgYnVnbGluazoNCkJ1Z0xp
bms6IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjA2Mjc1DQoN
CiogQW5kIGFkZCBhbm90aGVyIFJlcG9ydGVkLWJ5OiBGb3IgQWxleCBwcm9iYWJseSBtYWtlcyBz
ZW5zZSAsIGFzIGhlIGlzDQp0aGUgb3JpZ2luYWwgcmVwb3J0ZXIgdG8gdGhlIGJ1Zy4gIEkganVz
dCBoZWxwZWQgdG8gYnJpbmcgaXQgaGVyZS4NCg0KKiBUaGlzIHNob3VsZCBDQyBzdGFibGUgKGFz
IHRoaXMgcmVncmVzc2lvbiBtYW5hZ2VkIHRvIGhpdCB0aGUgc3RhYmxlDQprZXJuZWxzIHRvbyku
DQoNCj4gLS0tDQo+ICBkcml2ZXJzL2NoYXIvdHBtL3RwbS1kZXYtY29tbW9uLmMgfCAxOSArKysr
KysrKystLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxMCBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdHBtL3RwbS1kZXYt
Y29tbW9uLmMgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbS1kZXYtDQo+IGNvbW1vbi5jDQo+IGluZGV4
IDg3ZjQ0OTM0MDIwMi4uMTc4NDUzMGI4Mzg3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2NoYXIv
dHBtL3RwbS1kZXYtY29tbW9uLmMNCj4gKysrIGIvZHJpdmVycy9jaGFyL3RwbS90cG0tZGV2LWNv
bW1vbi5jDQo+IEBAIC0xODksMTUgKzE4OSw2IEBAIHNzaXplX3QgdHBtX2NvbW1vbl93cml0ZShz
dHJ1Y3QgZmlsZSAqZmlsZSwgY29uc3QgY2hhcg0KPiBfX3VzZXIgKmJ1ZiwNCj4gIAkJZ290byBv
dXQ7DQo+ICAJfQ0KPiANCj4gLQkvKiBhdG9taWMgdHBtIGNvbW1hbmQgc2VuZCBhbmQgcmVzdWx0
IHJlY2VpdmUuIFdlIG9ubHkgaG9sZCB0aGUgb3BzDQo+IC0JICogbG9jayBkdXJpbmcgdGhpcyBw
ZXJpb2Qgc28gdGhhdCB0aGUgdHBtIGNhbiBiZSB1bnJlZ2lzdGVyZWQgZXZlbiBpZg0KPiAtCSAq
IHRoZSBjaGFyIGRldiBpcyBoZWxkIG9wZW4uDQo+IC0JICovDQo+IC0JaWYgKHRwbV90cnlfZ2V0
X29wcyhwcml2LT5jaGlwKSkgew0KPiAtCQlyZXQgPSAtRVBJUEU7DQo+IC0JCWdvdG8gb3V0Ow0K
PiAtCX0NCj4gLQ0KPiAgCXByaXYtPnJlc3BvbnNlX2xlbmd0aCA9IDA7DQo+ICAJcHJpdi0+cmVz
cG9uc2VfcmVhZCA9IGZhbHNlOw0KPiAgCSpvZmYgPSAwOw0KPiBAQCAtMjExLDExICsyMDIsMTkg
QEAgc3NpemVfdCB0cG1fY29tbW9uX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLCBjb25zdCBjaGFy
DQo+IF9fdXNlciAqYnVmLA0KPiAgCWlmIChmaWxlLT5mX2ZsYWdzICYgT19OT05CTE9DSykgew0K
PiAgCQlwcml2LT5jb21tYW5kX2VucXVldWVkID0gdHJ1ZTsNCj4gIAkJcXVldWVfd29yayh0cG1f
ZGV2X3dxLCAmcHJpdi0+YXN5bmNfd29yayk7DQo+IC0JCXRwbV9wdXRfb3BzKHByaXYtPmNoaXAp
Ow0KPiAgCQltdXRleF91bmxvY2soJnByaXYtPmJ1ZmZlcl9tdXRleCk7DQo+ICAJCXJldHVybiBz
aXplOw0KPiAgCX0NCj4gDQo+ICsJLyogYXRvbWljIHRwbSBjb21tYW5kIHNlbmQgYW5kIHJlc3Vs
dCByZWNlaXZlLiBXZSBvbmx5IGhvbGQgdGhlIG9wcw0KPiArCSAqIGxvY2sgZHVyaW5nIHRoaXMg
cGVyaW9kIHNvIHRoYXQgdGhlIHRwbSBjYW4gYmUgdW5yZWdpc3RlcmVkIGV2ZW4gaWYNCj4gKwkg
KiB0aGUgY2hhciBkZXYgaXMgaGVsZCBvcGVuLg0KPiArCSAqLw0KPiArCWlmICh0cG1fdHJ5X2dl
dF9vcHMocHJpdi0+Y2hpcCkpIHsNCj4gKwkJcmV0ID0gLUVQSVBFOw0KPiArCQlnb3RvIG91dDsN
Cj4gKwl9DQo+ICsNCj4gIAlyZXQgPSB0cG1fZGV2X3RyYW5zbWl0KHByaXYtPmNoaXAsIHByaXYt
PnNwYWNlLCBwcml2LT5kYXRhX2J1ZmZlciwNCj4gIAkJCSAgICAgICBzaXplb2YocHJpdi0+ZGF0
YV9idWZmZXIpKTsNCj4gIAl0cG1fcHV0X29wcyhwcml2LT5jaGlwKTsNCj4gLS0NCj4gMi4yNi4y
DQoNCg==
