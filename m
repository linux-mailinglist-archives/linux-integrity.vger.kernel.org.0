Return-Path: <linux-integrity+bounces-218-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8B07F9756
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Nov 2023 03:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4B41C20506
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Nov 2023 02:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B974410F3;
	Mon, 27 Nov 2023 02:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="MTeZh8LJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83F9110
	for <linux-integrity@vger.kernel.org>; Sun, 26 Nov 2023 18:02:12 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id CD3642C063F;
	Mon, 27 Nov 2023 15:02:07 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1701050527;
	bh=ZSTdkZZURbRM+Nxl0z+tOQNJUfxCm0iXKsDfdZd8K5Y=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=MTeZh8LJv9EFnRNkfggelqMf2ig+b7E451TMsF7+7Zxbt64nzCqd0HxVIdc1h941Y
	 TPv3se9x41VUD++2l0A/5sXzunQNLJYaRYVPeYINM9SibHNis+jHo+GyHSoE8agHTH
	 dC4TcQZoWXSC62jG5diFW8oIKOCfnjoTlfiwsNF+shzQsL72uqaVEsau2ArgxJzj4m
	 bmS+SBLnyrm/ofxJzc2/m+QYNTRoqnFmg3sJPp5GzHNYLI6NSXbQ/4Yy9SVrWK8epz
	 5ho/B7qqQguUAd/Y1hnBGvdd/t3IslbCmSZwbVaxX28CHeIHr/8pHiT87ELvLXA7Me
	 Xms6iNK2jze4A==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6563f89f0001>; Mon, 27 Nov 2023 15:02:07 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 27 Nov 2023 15:02:07 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Mon, 27 Nov 2023 15:02:07 +1300
From: Angga <Hermin.Anggawijaya@alliedtelesis.co.nz>
To: Stefan Berger <stefanb@linux.ibm.com>, "peterhuewe@gmx.de"
	<peterhuewe@gmx.de>, "jarkko@kernel.org" <jarkko@kernel.org>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>
CC: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Start the tpm2 before running a self test.
Thread-Topic: [PATCH] tpm: Start the tpm2 before running a self test.
Thread-Index: AQHaHREnjIixcvoKIE+Z7DUtybpc5rCFbG2AgAcq9YA=
Date: Mon, 27 Nov 2023 02:02:07 +0000
Message-ID: <b1d29d38-2d9c-4147-a53d-e240d8a436ae@alliedtelesis.co.nz>
References: <20231122065528.1049819-1-hermin.anggawijaya@alliedtelesis.co.nz>
 <85154bfe-6bd5-440a-acc1-f01497d59af5@linux.ibm.com>
In-Reply-To: <85154bfe-6bd5-440a-acc1-f01497d59af5@linux.ibm.com>
Accept-Language: en-NZ, en-US
Content-Language: en-NZ
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <73F3465A8AD98640885D983DE3D3DC45@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=AZXP4EfG c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=-PW-BjYxrnlZlFBXaDUA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

T24gMjMvMTEvMjAyMyAxOjM0IGFtLCBTdGVmYW4gQmVyZ2VyIHdyb3RlOg0KPg0KPg0KPiBPbiAx
MS8yMi8yMyAwMTo1NSwgSGVybWluIEFuZ2dhd2lqYXlhIHdyb3RlOg0KPj4gQmVmb3JlIHNlbmRp
bmcgYSBjb21tYW5kIHRvIGF0dGVtcHQgdGhlIHNlbGYgdGVzdCwgdGhlIFRQTQ0KPj4gbWF5IG5l
ZWQgdG8gYmUgc3RhcnRlZCwgb3RoZXJ3aXNlIHRoZSBzZWxmIHRlc3QgcmV0dXJucw0KPj4gVFBN
Ml9SQ19JTklUSUFMSVpFIHZhbHVlIGNhdXNpbmcgYSBsb2cgYXMgZm9sbG93czoNCj4+ICJ0cG0g
dHBtMDogQSBUUE0gZXJyb3IgKDI1Nikgb2NjdXJyZWQgYXR0ZW1wdGluZyB0aGUgc2VsZiB0ZXN0
Ii4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBIZXJtaW4gQW5nZ2F3aWpheWEgDQo+PiA8aGVybWlu
LmFuZ2dhd2lqYXlhQGFsbGllZHRlbGVzaXMuY28ubno+DQo+PiAtLS0NCj4+IMKgIGRyaXZlcnMv
Y2hhci90cG0vdHBtMi1jbWQuYyB8IDggKysrKy0tLS0NCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvY2hhci90cG0vdHBtMi1jbWQuYyBiL2RyaXZlcnMvY2hhci90cG0vdHBtMi1jbWQuYw0KPj4g
aW5kZXggOTM1NDViZTE5MGE1Li4wNTMwZjNiNWY4NmEgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJz
L2NoYXIvdHBtL3RwbTItY21kLmMNCj4+ICsrKyBiL2RyaXZlcnMvY2hhci90cG0vdHBtMi1jbWQu
Yw0KPj4gQEAgLTczNywxNSArNzM3LDE1IEBAIGludCB0cG0yX2F1dG9fc3RhcnR1cChzdHJ1Y3Qg
dHBtX2NoaXAgKmNoaXApDQo+PiDCoMKgwqDCoMKgIGlmIChyYykNCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCBnb3RvIG91dDsNCj4+IMKgICvCoMKgwqAgcmMgPSB0cG0yX3N0YXJ0dXAoY2hpcCk7DQo+
PiArwqDCoMKgIGlmIChyYyAmJiByYyAhPSBUUE0yX1JDX0lOSVRJQUxJWkUpDQo+PiArwqDCoMKg
wqDCoMKgwqAgZ290byBvdXQ7DQo+PiArDQo+DQo+IE1vc3QgcGxhdGZvcm1zIHNob3VsZCBoYXZl
IGZpcm13YXJlIGluaXRpYWxpemUgdGhlIFRQTSAyIHRoZXNlIGRheXMuIA0KPiBUaGVyZWZvcmUs
IGEgc2VsZnRlc3Qgc2hvdWxkIHdvcmsgYW5kIGluIGNhc2UgaXQgZG9lc24ndCB3b3JrIHlvdSBm
YWxsIA0KPiBiYWNrIHRvIHRoZSB0cG0yX3N0YXJ0dXAgYmVsb3cgYW5kIGlmIHlvdSBnZXQgYW4g
ZXJyb3IgbWVzc2FnZSBpbiB0aGUgDQo+IGxvZyB5b3UgYXQgbGVhc3Qga25vdyB0aGF0IHlvdSBm
aXJtd2FyZSBpcyBub3QgdXAtdG8tZGF0ZS4NCj4NCj4+IMKgwqDCoMKgwqAgcmMgPSB0cG0yX2Rv
X3NlbGZ0ZXN0KGNoaXApOw0KPj4gwqDCoMKgwqDCoCBpZiAocmMgJiYgcmMgIT0gVFBNMl9SQ19J
TklUSUFMSVpFKQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0Ow0KPj4gwqAgwqDCoMKg
wqDCoCBpZiAocmMgPT0gVFBNMl9SQ19JTklUSUFMSVpFKSB7DQo+PiAtwqDCoMKgwqDCoMKgwqAg
cmMgPSB0cG0yX3N0YXJ0dXAoY2hpcCk7DQo+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKHJjKQ0KPj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBvdXQ7DQo+PiAtDQo+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgcmMgPSB0cG0yX2RvX3NlbGZ0ZXN0KGNoaXApOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKg
IGlmIChyYykNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0Ow0KDQpIZWxs
byBTdGVmYW4NCg0KVGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnRzLg0KDQpVbmZvcnR1bmF0ZWx5
IG91ciBwbGF0Zm9ybXMgKGN1c3RvbSBoYXJkd2FyZSBkZXNpZ24pIGFyZSB0aGUgb25lcyB3aGlj
aCANCmRvIG5vdCBpbml0aWFsaXplL3N0YXJ0IHRoZSBUUE0yIGZyb20gYm9vdCBsb2FkZXIgeWV0
LCBhbmQgYmVjYXVzZSBvZiANCnRoYXQgdGhlDQpzZWxmIHRlc3QgaW4gdHBtMl9hdXRvX3N0YXJ0
dXAgYWx3YXlzIHByb2R1Y2UgYSBsb2cgZXJyb3IgbWVzc2FnZSBvbiB0aGUgDQpwbGF0Zm9ybSBz
dGFydCB1cC4NCg0KV2hpbGUgSSB1bmRlcnN0YW5kIHlvdXIgcG9pbnQgYWJvdXQgdGhlIGxvZyBi
ZWluZyB1c2VmdWwgZm9yICJwb2ludGluZyANCm91dCBub3QgdXAtdG8tZGF0ZSBmaXJtd2FyZSIs
IGJ1dCBpdCBtaWdodCBhbHNvIGdlbmVyYXRlIHVubmVjZXNzYXJ5IHN1cHBvcnQNCnF1ZXJpZXMg
ZnJvbSBzb21lIHVzZXJzIG9uIHN1Y2ggcGxhdGZvcm1zID8gQW5kIG1heWJlIHRoZSBrZXJuZWwg
YmVpbmcgDQphYmxlIHRvIGRlYWwgd2l0aCBUUE0gYmVpbmcgc3RhcnRlZCBtb3JlIHRoYW4gb25j
ZSBpcyBiZXR0ZXIgPw0KDQpJZiB3YW50ZWQsIEkgaGF2ZSB0aGUgc2Vjb25kIHZlcnNpb24gb2Yg
dGhlIHBhdGNoIHdoaWNoIGNvbnNpc3Qgb2YgY29kZSANCmNoYW5nZXMgYXMgaW4gdjEsIHBsdXMg
YWJpbGl0eSBmb3IgdHBtMl90cmFuc21pdF9jbWQgdG8gaGFuZGxlIG11bHRpcGxlDQphdHRlbXB0
cyB0byBzdGFydCB1cCB0aGUgVFBNIHNpbGVudGx5LCBmb3IgZXhhbXBsZSwgb25jZSBieSB0aGUg
ZmlybXdhcmUgDQphbmQgYW5vdGhlciBieSB0aGUga2VybmVsIGR1cmluZyB0cG0yIGF1dG8tc3Rh
cnR1cC4NCg0KS2luZCByZWdhcmRzDQoNCkhlcm1pbiBBbmdnYXdpamF5YQ0KDQo=

