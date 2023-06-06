Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52031724E6E
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jun 2023 23:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239496AbjFFVEe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jun 2023 17:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbjFFVEd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jun 2023 17:04:33 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8507F1720
        for <linux-integrity@vger.kernel.org>; Tue,  6 Jun 2023 14:04:30 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9B1EC2C053D;
        Wed,  7 Jun 2023 09:04:27 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1686085467;
        bh=ExxzgBvvai5lmiS4EM6fS5tJ0BkeCkmuqFW5j9wByxE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=QK5ry9oB3XvKiSX0nPlokp3mtqXzgWYfzuGGhzFNrI00xnj/W09qj0P49ragQ7B0h
         s8qsAYKkChXnKrj0S+bt7rCOaV+LHIJ9im5ZdKpZouUeYlDwCREMHpE0H+QI9z2jz8
         5f0kr/hOPpM78FpouB8KNIx5l81mws2SvKvbqJAc/Y6gvKE23wk+50Ze9dms1jfDBv
         rBn29toXSfH2qghFe2w1Jwb7jTWBgPj5phZFvH6lYK1nJroRqA77PRxbPGfL/y1nGk
         ZbwM1zBVEkkpes3QId6LVaBNoTzQw0M0te57HCcnBBLWokPHvzTG53hlNJzxyyIoRg
         WBv3dQyewfu8w==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B647f9f5b0001>; Wed, 07 Jun 2023 09:04:27 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Jun 2023 09:04:27 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Wed, 7 Jun 2023 09:04:27 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Sasha Levin <sashal@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: New kernel warning after updating from LTS 5.15.110 to 5.15.112
 (and 5.15.113)
Thread-Topic: New kernel warning after updating from LTS 5.15.110 to 5.15.112
 (and 5.15.113)
Thread-Index: AQHZkb4dgnEVWoKsX0S/ux9OJoU4IK98yP8AgAC/T4A=
Date:   Tue, 6 Jun 2023 21:04:27 +0000
Message-ID: <0bdf509f-f71a-e3b2-b9fb-4a726021219b@alliedtelesis.co.nz>
References: <fe6f7aa0-56c2-3729-ce8c-0f2d943b33f4@alliedtelesis.co.nz>
 <7bb470fa70ff5944b7b9b82ac17d759819bccdf2.camel@kernel.org>
In-Reply-To: <7bb470fa70ff5944b7b9b82ac17d759819bccdf2.camel@kernel.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <618A76FA7904564692394464C594B452@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=CMhUoijD c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=of4jigFt-DYA:10 a=_ZjsMgP8zofZWL55IocA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SGkgSmFya2tvLA0KDQpPbiA2LzA2LzIzIDIxOjM5LCBKYXJra28gU2Fra2luZW4gd3JvdGU6DQo+
IE9uIFN1biwgMjAyMy0wNS0yOCBhdCAyMzo0MiArMDAwMCwgQ2hyaXMgUGFja2hhbSB3cm90ZToN
Cj4+IEhpLA0KPj4NCj4+IFdlIGhhdmUgYW4gZW1iZWRkZWQgcHJvZHVjdCB3aXRoIGFuIEluZmlu
ZW9uIFNMTTk2NzAgVFBNLiBBZnRlciB1cGRhdGluZw0KPj4gdG8gYSBuZXdlciBMVFMga2VybmVs
IHZlcnNpb24gd2Ugc3RhcnRlZCBzZWVpbmcgdGhlIGZvbGxvd2luZyB3YXJuaW5nIGF0DQo+PiBi
b290Lg0KPj4NCj4+IFvCoMKgwqAgNC43NDEwMjVdIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0t
LS0tLS0tLS0tLQ0KPj4gW8KgwqDCoCA0Ljc0OTg5NF0gaXJxIDM4IGhhbmRsZXIgdGlzX2ludF9o
YW5kbGVyKzB4MC8weDE1NCBlbmFibGVkIGludGVycnVwdHMNCj4+IFvCoMKgwqAgNC43NTY1NTVd
IFdBUk5JTkc6IENQVTogMCBQSUQ6IDAgYXQga2VybmVsL2lycS9oYW5kbGUuYzoxNTkNCj4+IF9f
aGFuZGxlX2lycV9ldmVudF9wZXJjcHUrMHhmNC8weDE4MA0KPj4gW8KgwqDCoCA0Ljc2NTU1N10g
TW9kdWxlcyBsaW5rZWQgaW46DQo+PiBbwqDCoMKgIDQuNzY4NjI2XSBDUFU6IDAgUElEOiAwIENv
bW06IHN3YXBwZXIvMCBOb3QgdGFpbnRlZCA1LjE1LjExMyAjMQ0KPj4gW8KgwqDCoCA0Ljc3NDc0
N10gSGFyZHdhcmUgbmFtZTogQWxsaWVkIFRlbGVzaXMgeDI1MC0xOFhTIChEVCkNCj4+IFvCoMKg
wqAgNC43ODAwODBdIHBzdGF0ZTogNjAwMDAwMDUgKG5aQ3YgZGFpZiAtUEFOIC1VQU8gLVRDTyAt
RElUIC1TU0JTDQo+PiBCVFlQRT0tLSkNCj4+IFvCoMKgwqAgNC43ODcwNzJdIHBjIDogX19oYW5k
bGVfaXJxX2V2ZW50X3BlcmNwdSsweGY0LzB4MTgwDQo+PiBbwqDCoMKgIDQuNzkyMTQ2XSBsciA6
IF9faGFuZGxlX2lycV9ldmVudF9wZXJjcHUrMHhmNC8weDE4MA0KPj4gW8KgwqDCoCA0Ljc5NzIy
MF0gc3AgOiBmZmZmODAwMDA4MDAzZTQwDQo+PiBbwqDCoMKgIDQuODAwNTQ3XSB4Mjk6IGZmZmY4
MDAwMDgwMDNlNDAgeDI4OiBmZmZmODAwMDA5Mzk1MWMwIHgyNzoNCj4+IGZmZmY4MDAwMDkwMmE5
YjgNCj4+IFvCoMKgwqAgNC44MDc3MTZdIHgyNjogZmZmZjgwMDAwOGZlOGQyOCB4MjU6IGZmZmY4
MDAwMDk0YTYyYmQgeDI0Og0KPj4gZmZmZjAwMDAwMWI5MjQwMA0KPj4gW8KgwqDCoCA0LjgxNDg4
NV0geDIzOiAwMDAwMDAwMDAwMDAwMDI2IHgyMjogZmZmZjgwMDAwODAwM2VjNCB4MjE6DQo+PiAw
MDAwMDAwMDAwMDAwMDAwDQo+PiBbwqDCoMKgIDQuODIyMDUzXSB4MjA6IDAwMDAwMDAwMDAwMDAw
MDEgeDE5OiBmZmZmMDAwMDAyMzgxMjAwIHgxODoNCj4+IGZmZmZmZmZmZmZmZmZmZmYNCj4+IFvC
oMKgwqAgNC44MjkyMjJdIHgxNzogZmZmZjgwMDA3Njk2MjAwMCB4MTY6IGZmZmY4MDAwMDgwMDAw
MDAgeDE1Og0KPj4gZmZmZjgwMDA4ODAwM2I1Nw0KPj4gW8KgwqDCoCA0LjgzNjM5MF0geDE0OiAw
MDAwMDAwMDAwMDAwMDAwIHgxMzogZmZmZjgwMDAwOTNhNTA3OCB4MTI6DQo+PiAwMDAwMDAwMDAw
MDAwMzVkDQo+PiBbwqDCoMKgIDQuODQzNTU4XSB4MTE6IDAwMDAwMDAwMDAwMDAxMWYgeDEwOiBm
ZmZmODAwMDA5M2E1MDc4IHg5IDoNCj4+IGZmZmY4MDAwMDkzYTUwNzgNCj4+IFvCoMKgwqAgNC44
NTA3MjddIHg4IDogMDAwMDAwMDBmZmZmZWZmZiB4NyA6IGZmZmY4MDAwMDkzZmQwNzggeDYgOg0K
Pj4gZmZmZjgwMDAwOTNmZDA3OA0KPj4gW8KgwqDCoCA0Ljg1Nzg5NV0geDUgOiAwMDAwMDAwMDAw
MDBiZmY0IHg0IDogMDAwMDAwMDAwMDAwMDAwMCB4MyA6DQo+PiAwMDAwMDAwMDAwMDAwMDAwDQo+
PiBbwqDCoMKgIDQuODY1MDYyXSB4MiA6IDAwMDAwMDAwMDAwMDAwMDAgeDEgOiAwMDAwMDAwMDAw
MDAwMDAwIHgwIDoNCj4+IGZmZmY4MDAwMDkzOTUxYzANCj4+IFvCoMKgwqAgNC44NzIyMzBdIENh
bGwgdHJhY2U6DQo+PiBbwqDCoMKgIDQuODc0Njg2XcKgIF9faGFuZGxlX2lycV9ldmVudF9wZXJj
cHUrMHhmNC8weDE4MA0KPj4gW8KgwqDCoCA0Ljg3OTQxMV3CoCBoYW5kbGVfaXJxX2V2ZW50KzB4
NjQvMHhlYw0KPj4gW8KgwqDCoCA0Ljg4MzI2NF3CoCBoYW5kbGVfbGV2ZWxfaXJxKzB4YzAvMHgx
YjANCj4+IFvCoMKgwqAgNC44ODcyMDJdwqAgZ2VuZXJpY19oYW5kbGVfaXJxKzB4MzAvMHg1MA0K
Pj4gW8KgwqDCoCA0Ljg5MTIyOV3CoCBtdmVidV9ncGlvX2lycV9oYW5kbGVyKzB4MTFjLzB4MmEw
DQo+PiBbwqDCoMKgIDQuODk1NzgwXcKgIGhhbmRsZV9kb21haW5faXJxKzB4NjAvMHg5MA0KPj4g
W8KgwqDCoCA0Ljg5OTcyMF3CoCBnaWNfaGFuZGxlX2lycSsweDRjLzB4ZDANCj4+IFvCoMKgwqAg
NC45MDMzOThdwqAgY2FsbF9vbl9pcnFfc3RhY2srMHgyMC8weDRjDQo+PiBbwqDCoMKgIDQuOTA3
MzM4XcKgIGRvX2ludGVycnVwdF9oYW5kbGVyKzB4NTQvMHg2MA0KPj4gW8KgwqDCoCA0LjkxMTUz
OF3CoCBlbDFfaW50ZXJydXB0KzB4MzAvMHg4MA0KPj4gW8KgwqDCoCA0LjkxNTEzMF3CoCBlbDFo
XzY0X2lycV9oYW5kbGVyKzB4MTgvMHgyNA0KPj4gW8KgwqDCoCA0LjkxOTI0NF3CoCBlbDFoXzY0
X2lycSsweDc4LzB4N2MNCj4+IFvCoMKgwqAgNC45MjI2NTldwqAgYXJjaF9jcHVfaWRsZSsweDE4
LzB4MmMNCj4+IFvCoMKgwqAgNC45MjYyNDldwqAgZG9faWRsZSsweGM0LzB4MTUwDQo+PiBbwqDC
oMKgIDQuOTI5NDA0XcKgIGNwdV9zdGFydHVwX2VudHJ5KzB4MjgvMHg2MA0KPj4gW8KgwqDCoCA0
LjkzMzM0M13CoCByZXN0X2luaXQrMHhlNC8weGY0DQo+PiBbwqDCoMKgIDQuOTM2NTg0XcKgIGFy
Y2hfY2FsbF9yZXN0X2luaXQrMHgxMC8weDFjDQo+PiBbwqDCoMKgIDQuOTQwNjk5XcKgIHN0YXJ0
X2tlcm5lbCsweDYwMC8weDY0MA0KPj4gW8KgwqDCoCA0Ljk0NDM3NV3CoCBfX3ByaW1hcnlfc3dp
dGNoZWQrMHhiYy8weGM0DQo+PiBbwqDCoMKgIDQuOTQ4NDAyXSAtLS1bIGVuZCB0cmFjZSA5NDAx
OTMwNDdiMzViMzExIF0tLS0NCj4+DQo+PiBJbml0aWFsbHkgSSBkaXNtaXNzZWQgdGhpcyBhcyBh
IHdhcm5pbmcgdGhhdCB3b3VsZCBwcm9iYWJseSBiZSBjbGVhbmVkDQo+PiB1cCB3aGVuIHdlIGRp
ZCBtb3JlIHdvcmsgb24gdGhlIFRQTSBzdXBwb3J0IGZvciBvdXIgcHJvZHVjdCBidXQgd2UgYWxz
bw0KPj4gc2VlbSB0byBiZSBnZXR0aW5nIHNvbWUgbmV3IGkyYyBpc3N1ZXMgYW5kIHBvc3NpYmx5
IGEga2VybmVsIHN0YWNrDQo+PiBjb3JydXB0aW9uIHRoYXQgd2UndmUgY29uZmxhdGVkIHdpdGgg
dGhpcyBUUE0gd2FybmluZy4NCj4gSGksIHNvcnJ5IGZvciBsYXRlIHJlc3BvbnNlLiBJJ3ZlIGJl
ZW4gbW92aW5nIG15IChob21lKSBvZmZpY2UgdG8NCj4gYSBkaWZmZXJlbnQgbG9jYXRpb24gZHVy
aW5nIGxhc3QgY291cGxlIG9mIHdlZWtzLCBhbmQgZW1haWwgaGFzIGJlZW4NCj4gcGlsaW5nIHVw
Lg0KPg0KPiBXaGF0IGRvZXMgZG1pZGVjb2RlIGdpdmUgeW91Pw0KPg0KPiBNb3JlIHNwZWNpZmlj
LCBJJ20gaW50ZXJlc3RlZCBvbiBETUkgdHlwZSA0MzoNCj4NCj4gJCBzdWRvIGRtaWRlY29kZSAt
dCA0Mw0KPiAjIGRtaWRlY29kZSAzLjQNCj4gR2V0dGluZyBTTUJJT1MgZGF0YSBmcm9tIHN5c2Zz
Lg0KPiBTTUJJT1MgMy40LjAgcHJlc2VudC4NCj4NCj4gSGFuZGxlIDB4MDA0RCwgRE1JIHR5cGUg
NDMsIDMxIGJ5dGVzDQo+IFRQTSBEZXZpY2UNCj4gCVZlbmRvciBJRDogSU5UQw0KPiAJU3BlY2lm
aWNhdGlvbiBWZXJzaW9uOiAyLjANCj4gCUZpcm13YXJlIFJldmlzaW9uOiA2MDAuMTgNCj4gCURl
c2NyaXB0aW9uOiBJTlRFTA0KPiAJQ2hhcmFjdGVyaXN0aWNzOg0KPiAJCUZhbWlseSBjb25maWd1
cmFibGUgdmlhIHBsYXRmb3JtIHNvZnR3YXJlIHN1cHBvcnQNCj4gCU9FTS1zcGVjaWZpYyBJbmZv
cm1hdGlvbjogMHgwMDAwMDAwMA0KPg0KPiBCUiwgSmFya2tvDQoNClRoaXMgaXMgYW4gZW1iZWRk
ZWQgQVJNNjQgKE1hcnZlbGwgQ045MTMwIFNvQykgZGV2aWNlIHNvIG5vIEJJT1MuIFRoZSANCnJl
bGV2YW50IHNuaXBwZXQgZnJvbSB0aGUgZGV2aWNlIHRyZWUgaXMNCg0KIMKgwqDCoMKgwqDCoMKg
IHRwbUAxIHsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJsZSA9ICJp
bmZpbmVvbixzbGI5NjcwIjsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVnID0g
PDE+OyAvKiBDaGlwIHNlbGVjdCAxICovDQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGludGVycnVwdC1wYXJlbnQgPSA8JmNwMF9ncGlvMj47DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGludGVycnVwdHMgPSA8MzAgSVJRX1RZUEVfTEVWRUxfTE9XPjsNCiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3BpLW1heC1mcmVxdWVuY3kgPSA8MzEyNTAwMDA+Ow0K
IMKgwqDCoMKgwqDCoMKgIH07DQoNCmFuZCBJIGNhbiB0ZWxsIHlvdSB0aGF0IHRoZSBzcGVjaWZp
YyBUUE0gY2hpcCBpcyBhbiBJbmZpbmllb24gDQpTTE05NjcwQVEyMEZXMTMxMVhUTUExDQo=
