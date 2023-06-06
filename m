Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8932F7234A7
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jun 2023 03:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjFFBlO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Jun 2023 21:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbjFFBlM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Jun 2023 21:41:12 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE203110
        for <linux-integrity@vger.kernel.org>; Mon,  5 Jun 2023 18:41:10 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D35B12C066D;
        Tue,  6 Jun 2023 13:41:01 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1686015661;
        bh=qMU8m94d7D3vVzxg8DCRFo5uds8hTtd3HL9D/Y/KOYk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=2uzJBcsbkS4TszzvlMJpAsH3i2sjiwe8ycsqZ0Fw8Ua9ioTVD6rLebMspKM8wfXAB
         L2BzaIjll5Rc1GL4MIC/WO66RK7HHIKzSJjL0eDHcOCaysEqfFilfnj8uD8YGtQrNv
         4eUeLZhO7A7dom69/Q9EwRPasY9MKdnPdalYRqr83d1178GwCYmg1kfMilm2z7d+rK
         1eU987ZZbYEoyyIZwP5VhznQsqVXQAIbYouHmdPVOoTC5evN83qccJXLyIrV5wxsbV
         UcUa/V5P2P/bFwfR+qCjvHxFp0GY0plGfa6LvhT5NFWy4VLugt8qz7ocrSnFKTT6U0
         kO34X0/WuT3vw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B647e8ead0001>; Tue, 06 Jun 2023 13:41:01 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.26; Tue, 6 Jun 2023 13:41:01 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with Microsoft
 SMTP Server (TLS) id 15.0.1497.48; Tue, 6 Jun 2023 13:41:01 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Tue, 6 Jun 2023 13:41:01 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     Linux Kernel Integrity <linux-integrity@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: New kernel warning after updating from LTS 5.15.110 to 5.15.112
 (and 5.15.113)
Thread-Topic: New kernel warning after updating from LTS 5.15.110 to 5.15.112
 (and 5.15.113)
Thread-Index: AQHZkb4dgnEVWoKsX0S/ux9OJoU4IK9vtwkAgAAJdgCABmNMgIAAAnEAgAYdAQA=
Date:   Tue, 6 Jun 2023 01:41:01 +0000
Message-ID: <ec5245bd-3103-f0c7-d3ef-85aabb4d4712@alliedtelesis.co.nz>
References: <fe6f7aa0-56c2-3729-ce8c-0f2d943b33f4@alliedtelesis.co.nz>
 <ZHQIFLWvrWUNMVxb@debian.me>
 <6e470461-1a9b-ec51-bac5-f2beb1dc11c9@alliedtelesis.co.nz>
 <2b09d2ed-0852-bbc9-b792-aad92235c7fa@gmail.com>
 <03daca5c-e468-8889-4dc2-e625a664d571@alliedtelesis.co.nz>
In-Reply-To: <03daca5c-e468-8889-4dc2-e625a664d571@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FA85DA13B42764B810BFD3DD5C99E18@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=CMhUoijD c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=of4jigFt-DYA:10 a=d_NS31tpAAAA:8 a=VwQbUJbxAAAA:8 a=iREdgMsEqhSVUURpQtUA:9 a=QEXdDO2ut3YA:10 a=PfdiIfcH12mfzV1Ea7Td:22 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQpPbiAyLzA2LzIzIDE2OjE5LCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPg0KPiBPbiAyLzA2LzIz
IDE2OjEwLCBCYWdhcyBTYW5qYXlhIHdyb3RlOg0KPj4gT24gNS8yOS8yMyAwOTozNywgQ2hyaXMg
UGFja2hhbSB3cm90ZToNCj4+PiBPbiAyOS8wNS8yMyAxNDowNCwgQmFnYXMgU2FuamF5YSB3cm90
ZToNCj4+Pj4gT24gU3VuLCBNYXkgMjgsIDIwMjMgYXQgMTE6NDI6NTBQTSArMDAwMCwgQ2hyaXMg
UGFja2hhbSB3cm90ZToNCj4+Pj4+IEhpLA0KPj4+Pj4NCj4+Pj4+IFdlIGhhdmUgYW4gZW1iZWRk
ZWQgcHJvZHVjdCB3aXRoIGFuIEluZmluZW9uIFNMTTk2NzAgVFBNLiBBZnRlciANCj4+Pj4+IHVw
ZGF0aW5nDQo+Pj4+PiB0byBhIG5ld2VyIExUUyBrZXJuZWwgdmVyc2lvbiB3ZSBzdGFydGVkIHNl
ZWluZyB0aGUgZm9sbG93aW5nIA0KPj4+Pj4gd2FybmluZyBhdA0KPj4+Pj4gYm9vdC4NCj4+Pj4+
DQo+Pj4+PiBbwqDCoMKgIDQuNzQxMDI1XSAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0t
LS0tLS0NCj4+Pj4+IFvCoMKgwqAgNC43NDk4OTRdIGlycSAzOCBoYW5kbGVyIHRpc19pbnRfaGFu
ZGxlcisweDAvMHgxNTQgZW5hYmxlZCANCj4+Pj4+IGludGVycnVwdHMNCj4+Pj4+IFvCoMKgwqAg
NC43NTY1NTVdIFdBUk5JTkc6IENQVTogMCBQSUQ6IDAgYXQga2VybmVsL2lycS9oYW5kbGUuYzox
NTkNCj4+Pj4+IF9faGFuZGxlX2lycV9ldmVudF9wZXJjcHUrMHhmNC8weDE4MA0KPj4+Pj4gW8Kg
wqDCoCA0Ljc2NTU1N10gTW9kdWxlcyBsaW5rZWQgaW46DQo+Pj4+PiBbwqDCoMKgIDQuNzY4NjI2
XSBDUFU6IDAgUElEOiAwIENvbW06IHN3YXBwZXIvMCBOb3QgdGFpbnRlZCA1LjE1LjExMyAjMQ0K
Pj4+Pj4gW8KgwqDCoCA0Ljc3NDc0N10gSGFyZHdhcmUgbmFtZTogQWxsaWVkIFRlbGVzaXMgeDI1
MC0xOFhTIChEVCkNCj4+Pj4+IFvCoMKgwqAgNC43ODAwODBdIHBzdGF0ZTogNjAwMDAwMDUgKG5a
Q3YgZGFpZiAtUEFOIC1VQU8gLVRDTyAtRElUIC1TU0JTDQo+Pj4+PiBCVFlQRT0tLSkNCj4+Pj4+
IFvCoMKgwqAgNC43ODcwNzJdIHBjIDogX19oYW5kbGVfaXJxX2V2ZW50X3BlcmNwdSsweGY0LzB4
MTgwDQo+Pj4+PiBbwqDCoMKgIDQuNzkyMTQ2XSBsciA6IF9faGFuZGxlX2lycV9ldmVudF9wZXJj
cHUrMHhmNC8weDE4MA0KPj4+Pj4gW8KgwqDCoCA0Ljc5NzIyMF0gc3AgOiBmZmZmODAwMDA4MDAz
ZTQwDQo+Pj4+PiBbwqDCoMKgIDQuODAwNTQ3XSB4Mjk6IGZmZmY4MDAwMDgwMDNlNDAgeDI4OiBm
ZmZmODAwMDA5Mzk1MWMwIHgyNzoNCj4+Pj4+IGZmZmY4MDAwMDkwMmE5YjgNCj4+Pj4+IFvCoMKg
wqAgNC44MDc3MTZdIHgyNjogZmZmZjgwMDAwOGZlOGQyOCB4MjU6IGZmZmY4MDAwMDk0YTYyYmQg
eDI0Og0KPj4+Pj4gZmZmZjAwMDAwMWI5MjQwMA0KPj4+Pj4gW8KgwqDCoCA0LjgxNDg4NV0geDIz
OiAwMDAwMDAwMDAwMDAwMDI2IHgyMjogZmZmZjgwMDAwODAwM2VjNCB4MjE6DQo+Pj4+PiAwMDAw
MDAwMDAwMDAwMDAwDQo+Pj4+PiBbwqDCoMKgIDQuODIyMDUzXSB4MjA6IDAwMDAwMDAwMDAwMDAw
MDEgeDE5OiBmZmZmMDAwMDAyMzgxMjAwIHgxODoNCj4+Pj4+IGZmZmZmZmZmZmZmZmZmZmYNCj4+
Pj4+IFvCoMKgwqAgNC44MjkyMjJdIHgxNzogZmZmZjgwMDA3Njk2MjAwMCB4MTY6IGZmZmY4MDAw
MDgwMDAwMDAgeDE1Og0KPj4+Pj4gZmZmZjgwMDA4ODAwM2I1Nw0KPj4+Pj4gW8KgwqDCoCA0Ljgz
NjM5MF0geDE0OiAwMDAwMDAwMDAwMDAwMDAwIHgxMzogZmZmZjgwMDAwOTNhNTA3OCB4MTI6DQo+
Pj4+PiAwMDAwMDAwMDAwMDAwMzVkDQo+Pj4+PiBbwqDCoMKgIDQuODQzNTU4XSB4MTE6IDAwMDAw
MDAwMDAwMDAxMWYgeDEwOiBmZmZmODAwMDA5M2E1MDc4IHg5IDoNCj4+Pj4+IGZmZmY4MDAwMDkz
YTUwNzgNCj4+Pj4+IFvCoMKgwqAgNC44NTA3MjddIHg4IDogMDAwMDAwMDBmZmZmZWZmZiB4NyA6
IGZmZmY4MDAwMDkzZmQwNzggeDYgOg0KPj4+Pj4gZmZmZjgwMDAwOTNmZDA3OA0KPj4+Pj4gW8Kg
wqDCoCA0Ljg1Nzg5NV0geDUgOiAwMDAwMDAwMDAwMDBiZmY0IHg0IDogMDAwMDAwMDAwMDAwMDAw
MCB4MyA6DQo+Pj4+PiAwMDAwMDAwMDAwMDAwMDAwDQo+Pj4+PiBbwqDCoMKgIDQuODY1MDYyXSB4
MiA6IDAwMDAwMDAwMDAwMDAwMDAgeDEgOiAwMDAwMDAwMDAwMDAwMDAwIHgwIDoNCj4+Pj4+IGZm
ZmY4MDAwMDkzOTUxYzANCj4+Pj4+IFvCoMKgwqAgNC44NzIyMzBdIENhbGwgdHJhY2U6DQo+Pj4+
PiBbwqDCoMKgIDQuODc0Njg2XcKgIF9faGFuZGxlX2lycV9ldmVudF9wZXJjcHUrMHhmNC8weDE4
MA0KPj4+Pj4gW8KgwqDCoCA0Ljg3OTQxMV3CoCBoYW5kbGVfaXJxX2V2ZW50KzB4NjQvMHhlYw0K
Pj4+Pj4gW8KgwqDCoCA0Ljg4MzI2NF3CoCBoYW5kbGVfbGV2ZWxfaXJxKzB4YzAvMHgxYjANCj4+
Pj4+IFvCoMKgwqAgNC44ODcyMDJdwqAgZ2VuZXJpY19oYW5kbGVfaXJxKzB4MzAvMHg1MA0KPj4+
Pj4gW8KgwqDCoCA0Ljg5MTIyOV3CoCBtdmVidV9ncGlvX2lycV9oYW5kbGVyKzB4MTFjLzB4MmEw
DQo+Pj4+PiBbwqDCoMKgIDQuODk1NzgwXcKgIGhhbmRsZV9kb21haW5faXJxKzB4NjAvMHg5MA0K
Pj4+Pj4gW8KgwqDCoCA0Ljg5OTcyMF3CoCBnaWNfaGFuZGxlX2lycSsweDRjLzB4ZDANCj4+Pj4+
IFvCoMKgwqAgNC45MDMzOThdwqAgY2FsbF9vbl9pcnFfc3RhY2srMHgyMC8weDRjDQo+Pj4+PiBb
wqDCoMKgIDQuOTA3MzM4XcKgIGRvX2ludGVycnVwdF9oYW5kbGVyKzB4NTQvMHg2MA0KPj4+Pj4g
W8KgwqDCoCA0LjkxMTUzOF3CoCBlbDFfaW50ZXJydXB0KzB4MzAvMHg4MA0KPj4+Pj4gW8KgwqDC
oCA0LjkxNTEzMF3CoCBlbDFoXzY0X2lycV9oYW5kbGVyKzB4MTgvMHgyNA0KPj4+Pj4gW8KgwqDC
oCA0LjkxOTI0NF3CoCBlbDFoXzY0X2lycSsweDc4LzB4N2MNCj4+Pj4+IFvCoMKgwqAgNC45MjI2
NTldwqAgYXJjaF9jcHVfaWRsZSsweDE4LzB4MmMNCj4+Pj4+IFvCoMKgwqAgNC45MjYyNDldwqAg
ZG9faWRsZSsweGM0LzB4MTUwDQo+Pj4+PiBbwqDCoMKgIDQuOTI5NDA0XcKgIGNwdV9zdGFydHVw
X2VudHJ5KzB4MjgvMHg2MA0KPj4+Pj4gW8KgwqDCoCA0LjkzMzM0M13CoCByZXN0X2luaXQrMHhl
NC8weGY0DQo+Pj4+PiBbwqDCoMKgIDQuOTM2NTg0XcKgIGFyY2hfY2FsbF9yZXN0X2luaXQrMHgx
MC8weDFjDQo+Pj4+PiBbwqDCoMKgIDQuOTQwNjk5XcKgIHN0YXJ0X2tlcm5lbCsweDYwMC8weDY0
MA0KPj4+Pj4gW8KgwqDCoCA0Ljk0NDM3NV3CoCBfX3ByaW1hcnlfc3dpdGNoZWQrMHhiYy8weGM0
DQo+Pj4+PiBbwqDCoMKgIDQuOTQ4NDAyXSAtLS1bIGVuZCB0cmFjZSA5NDAxOTMwNDdiMzViMzEx
IF0tLS0NCj4+Pj4+DQo+Pj4+PiBJbml0aWFsbHkgSSBkaXNtaXNzZWQgdGhpcyBhcyBhIHdhcm5p
bmcgdGhhdCB3b3VsZCBwcm9iYWJseSBiZSANCj4+Pj4+IGNsZWFuZWQNCj4+Pj4+IHVwIHdoZW4g
d2UgZGlkIG1vcmUgd29yayBvbiB0aGUgVFBNIHN1cHBvcnQgZm9yIG91ciBwcm9kdWN0IGJ1dCB3
ZSANCj4+Pj4+IGFsc28NCj4+Pj4+IHNlZW0gdG8gYmUgZ2V0dGluZyBzb21lIG5ldyBpMmMgaXNz
dWVzIGFuZCBwb3NzaWJseSBhIGtlcm5lbCBzdGFjaw0KPj4+Pj4gY29ycnVwdGlvbiB0aGF0IHdl
J3ZlIGNvbmZsYXRlZCB3aXRoIHRoaXMgVFBNIHdhcm5pbmcuDQo+Pj4+IENhbiB5b3UgcmVwcm9k
dWNlIHRoaXMgaXNzdWUgb24gbWFpbmxpbmU/IENhbiB5b3UgYWxzbyBiaXNlY3QgdG8gZmluZA0K
Pj4+PiB0aGUgY3VscHJpdD8NCj4+PiBObyB0aGUgZXJyb3IgZG9lc24ndCBhcHBlYXIgb24gYSBy
ZWNlbnQgbWFpbmxpbmUga2VybmVsLiBJIGRvIHN0aWxsIGdldA0KPj4+DQo+Pj4gdHBtX3Rpc19z
cGkgc3BpMS4xOiAyLjAgVFBNIChkZXZpY2UtaWQgMHgxQiwgcmV2LWlkIDIyKQ0KPj4+IHRwbSB0
cG0wOiBbRmlybXdhcmUgQnVnXTogVFBNIGludGVycnVwdCBub3Qgd29ya2luZywgcG9sbGluZyBp
bnN0ZWFkDQo+Pj4gdHBtIHRwbTA6IEEgVFBNIGVycm9yICgyNTYpIG9jY3VycmVkIGF0dGVtcHRp
bmcgdGhlIHNlbGYgdGVzdA0KPj4+DQo+Pj4gYnV0IEkgdGhpbmsgSSB3YXMgZ2V0dGluZyB0aGF0
IG9uIHY1LjE1LjExMA0KPj4+DQo+PiBJIHJlcGVhdDogQ2FuIHlvdSBiaXNlY3QgYmV0d2VlbiB2
NS4xNSBhbmQgdjUuMTUuMTEyPw0KPg0KPiBJdCdzIGRlZmluaXRlbHkgYmV0d2VlbiB2NS4xNS4x
MTAgYW5kIHY1LjE1LjExMi4NCj4NCj4gSSdsbCBkbyBhIHByb3BlciBiaXNlY3QgbmV4dCB3ZWVr
IGJ1dCBJJ20gcHJldHR5IHN1cmUgaXQncyByZWxhdGVkIHRvIA0KPiB0aGUgInRwbSwgdHBtX3Rp
czoiIHNlcmllcy4gVGhlIHByb2JsZW0gY2FuIGJlIHdvcmtlZCBhcm91bmQgYnkgDQo+IHJlbW92
aW5nIHRoZSBUUE0gaW50ZXJydXB0IGZyb20gdGhlIGRldmljZSB0cmVlIGZvciB0aGUgYm9hcmQu
DQoNCkJpc2VjdGluZyBiZXR3ZWVuIHY1LjE1LjExMCBhbmQgdjUuMTUuMTEyIHBvaW50cyB0bw0K
DQo1MTE2MmIwNWE0NGNiNWQ5OGZiMGFlMjUxOWE4NjA5MTBhNDdmZDRiIGlzIHRoZSBmaXJzdCBi
YWQgY29tbWl0DQpjb21taXQgNTExNjJiMDVhNDRjYjVkOThmYjBhZTI1MTlhODYwOTEwYTQ3ZmQ0
Yg0KQXV0aG9yOiBMaW5vIFNhbmZpbGlwcG8gPGwuc2FuZmlsaXBwb0BrdW5idXMuY29tPg0KRGF0
ZTrCoMKgIFRodSBOb3YgMjQgMTQ6NTU6MjkgMjAyMiArMDEwMA0KDQogwqDCoMKgIHRwbSwgdHBt
X3RpczogQ2xhaW0gbG9jYWxpdHkgYmVmb3JlIHdyaXRpbmcgaW50ZXJydXB0IHJlZ2lzdGVycw0K
DQogwqDCoMKgIFsgVXBzdHJlYW0gY29tbWl0IDE1ZDdhYTRlNDZlYmE4NzI0MmEzMjBmMzk3NzNh
YTE2ZmFkZGFkZWUgXQ0KDQogwqDCoMKgIEluIHRwbV90aXNfcHJvYmVfc2luZ2xlX2lycSgpIGlu
dGVycnVwdCByZWdpc3RlcnMgVFBNX0lOVF9WRUNUT1IsDQogwqDCoMKgIFRQTV9JTlRfU1RBVFVT
IGFuZCBUUE1fSU5UX0VOQUJMRSBhcmUgbW9kaWZpZWQgdG8gc2V0dXAgdGhlIGludGVycnVwdHMu
DQogwqDCoMKgIEN1cnJlbnRseSB0aGVzZSBtb2RpZmljYXRpb25zIGFyZSBkb25lIHdpdGhvdXQg
aG9sZGluZyBhIGxvY2FsaXR5IA0KdGh1cyB0aGV5DQogwqDCoMKgIGhhdmUgbm8gZWZmZWN0LiBG
aXggdGhpcyBieSBjbGFpbWluZyB0aGUgKGRlZmF1bHQpIGxvY2FsaXR5IGJlZm9yZSB0aGUNCiDC
oMKgwqAgcmVnaXN0ZXJzIGFyZSB3cml0dGVuLg0KDQogwqDCoMKgIFNpbmNlIG5vdyB0cG1fdGlz
X2dlbl9pbnRlcnJ1cHQoKSBpcyBjYWxsZWQgd2l0aCB0aGUgbG9jYWxpdHkgYWxyZWFkeQ0KIMKg
wqDCoCBjbGFpbWVkIHJlbW92ZSBsb2NhbGl0eSByZXF1ZXN0IGFuZCByZWxlYXNlIGZyb20gdGhp
cyBmdW5jdGlvbi4NCg0KIMKgwqDCoCBTaWduZWQtb2ZmLWJ5OiBMaW5vIFNhbmZpbGlwcG8gPGwu
c2FuZmlsaXBwb0BrdW5idXMuY29tPg0KIMKgwqDCoCBUZXN0ZWQtYnk6IEphcmtrbyBTYWtraW5l
biA8amFya2tvQGtlcm5lbC5vcmc+DQogwqDCoMKgIFJldmlld2VkLWJ5OiBKYXJra28gU2Fra2lu
ZW4gPGphcmtrb0BrZXJuZWwub3JnPg0KIMKgwqDCoCBTaWduZWQtb2ZmLWJ5OiBKYXJra28gU2Fr
a2luZW4gPGphcmtrb0BrZXJuZWwub3JnPg0KIMKgwqDCoCBTdGFibGUtZGVwLW9mOiA5NTVkZjRm
ODc3NjAgKCJ0cG0sIHRwbV90aXM6IENsYWltIGxvY2FsaXR5IHdoZW4gDQppbnRlcnJ1cHRzIGFy
ZSByZWVuYWJsZWQgb24gcmVzdW1lIikNCiDCoMKgwqAgU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2
aW4gPHNhc2hhbEBrZXJuZWwub3JnPg0KDQogwqBkcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29y
ZS5jIHwgMjIgKysrKysrKysrKysrLS0tLS0tLS0tLQ0KIMKgMSBmaWxlIGNoYW5nZWQsIDEyIGlu
c2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygNCg==
