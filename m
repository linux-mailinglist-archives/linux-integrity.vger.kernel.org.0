Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEFD71F93D
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Jun 2023 06:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjFBET5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Jun 2023 00:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjFBETv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Jun 2023 00:19:51 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E19198
        for <linux-integrity@vger.kernel.org>; Thu,  1 Jun 2023 21:19:48 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 879802C0544;
        Fri,  2 Jun 2023 16:19:39 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1685679579;
        bh=gq7OGxmFoF6M8Fv4mcc3bCj3zPpH7ebOrQpjPbYi9G4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=IBGXhs6uc9SdVGJAtwBrk7xflOfxX3bdnl7KW0lR6bq2/kmbjZue9Mp7ySFA6qgok
         tFk3pbR1KRDVXRT7Q+tlLke5pY40lwXJ8Au+s51VMYf3iQfrjDjtPciQVT8v+4yuyj
         5Hs8no55X0ERSL+jGu8q1nr6mCZ9VFqJ9ZvatTQvsBLdVeU/Emn/pfQOVCjVdn7/A6
         6I1otnFyvGoeyvoUj9EetYalLH6DPV/r9hTMz8w6AScDLScM02BefhIijPzRYk6sRi
         UZq/vsHy2zuqqMQrXsDnlO/tZ/8Mksge8uCa/x9HxtwgQ1W7oUGmnBieO7m5NGyf8j
         /66TjHEEGHHdw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B64796ddb0001>; Fri, 02 Jun 2023 16:19:39 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 2 Jun 2023 16:19:39 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Fri, 2 Jun 2023 16:19:39 +1200
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
Thread-Index: AQHZkb4dgnEVWoKsX0S/ux9OJoU4IK9vtwkAgAAJdgCABmNMgIAAAnEA
Date:   Fri, 2 Jun 2023 04:19:39 +0000
Message-ID: <03daca5c-e468-8889-4dc2-e625a664d571@alliedtelesis.co.nz>
References: <fe6f7aa0-56c2-3729-ce8c-0f2d943b33f4@alliedtelesis.co.nz>
 <ZHQIFLWvrWUNMVxb@debian.me>
 <6e470461-1a9b-ec51-bac5-f2beb1dc11c9@alliedtelesis.co.nz>
 <2b09d2ed-0852-bbc9-b792-aad92235c7fa@gmail.com>
In-Reply-To: <2b09d2ed-0852-bbc9-b792-aad92235c7fa@gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <581E0A34EE872F4D8F5CD9704A3F3EED@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=CMhUoijD c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=of4jigFt-DYA:10 a=60ZFW2eZT7UuVB5q5NkA:9 a=QEXdDO2ut3YA:10
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

DQpPbiAyLzA2LzIzIDE2OjEwLCBCYWdhcyBTYW5qYXlhIHdyb3RlOg0KPiBPbiA1LzI5LzIzIDA5
OjM3LCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4gT24gMjkvMDUvMjMgMTQ6MDQsIEJhZ2FzIFNh
bmpheWEgd3JvdGU6DQo+Pj4gT24gU3VuLCBNYXkgMjgsIDIwMjMgYXQgMTE6NDI6NTBQTSArMDAw
MCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+Pj4gSGksDQo+Pj4+DQo+Pj4+IFdlIGhhdmUgYW4g
ZW1iZWRkZWQgcHJvZHVjdCB3aXRoIGFuIEluZmluZW9uIFNMTTk2NzAgVFBNLiBBZnRlciB1cGRh
dGluZw0KPj4+PiB0byBhIG5ld2VyIExUUyBrZXJuZWwgdmVyc2lvbiB3ZSBzdGFydGVkIHNlZWlu
ZyB0aGUgZm9sbG93aW5nIHdhcm5pbmcgYXQNCj4+Pj4gYm9vdC4NCj4+Pj4NCj4+Pj4gW8KgwqDC
oCA0Ljc0MTAyNV0gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tDQo+Pj4+IFvC
oMKgwqAgNC43NDk4OTRdIGlycSAzOCBoYW5kbGVyIHRpc19pbnRfaGFuZGxlcisweDAvMHgxNTQg
ZW5hYmxlZCBpbnRlcnJ1cHRzDQo+Pj4+IFvCoMKgwqAgNC43NTY1NTVdIFdBUk5JTkc6IENQVTog
MCBQSUQ6IDAgYXQga2VybmVsL2lycS9oYW5kbGUuYzoxNTkNCj4+Pj4gX19oYW5kbGVfaXJxX2V2
ZW50X3BlcmNwdSsweGY0LzB4MTgwDQo+Pj4+IFvCoMKgwqAgNC43NjU1NTddIE1vZHVsZXMgbGlu
a2VkIGluOg0KPj4+PiBbwqDCoMKgIDQuNzY4NjI2XSBDUFU6IDAgUElEOiAwIENvbW06IHN3YXBw
ZXIvMCBOb3QgdGFpbnRlZCA1LjE1LjExMyAjMQ0KPj4+PiBbwqDCoMKgIDQuNzc0NzQ3XSBIYXJk
d2FyZSBuYW1lOiBBbGxpZWQgVGVsZXNpcyB4MjUwLTE4WFMgKERUKQ0KPj4+PiBbwqDCoMKgIDQu
NzgwMDgwXSBwc3RhdGU6IDYwMDAwMDA1IChuWkN2IGRhaWYgLVBBTiAtVUFPIC1UQ08gLURJVCAt
U1NCUw0KPj4+PiBCVFlQRT0tLSkNCj4+Pj4gW8KgwqDCoCA0Ljc4NzA3Ml0gcGMgOiBfX2hhbmRs
ZV9pcnFfZXZlbnRfcGVyY3B1KzB4ZjQvMHgxODANCj4+Pj4gW8KgwqDCoCA0Ljc5MjE0Nl0gbHIg
OiBfX2hhbmRsZV9pcnFfZXZlbnRfcGVyY3B1KzB4ZjQvMHgxODANCj4+Pj4gW8KgwqDCoCA0Ljc5
NzIyMF0gc3AgOiBmZmZmODAwMDA4MDAzZTQwDQo+Pj4+IFvCoMKgwqAgNC44MDA1NDddIHgyOTog
ZmZmZjgwMDAwODAwM2U0MCB4Mjg6IGZmZmY4MDAwMDkzOTUxYzAgeDI3Og0KPj4+PiBmZmZmODAw
MDA5MDJhOWI4DQo+Pj4+IFvCoMKgwqAgNC44MDc3MTZdIHgyNjogZmZmZjgwMDAwOGZlOGQyOCB4
MjU6IGZmZmY4MDAwMDk0YTYyYmQgeDI0Og0KPj4+PiBmZmZmMDAwMDAxYjkyNDAwDQo+Pj4+IFvC
oMKgwqAgNC44MTQ4ODVdIHgyMzogMDAwMDAwMDAwMDAwMDAyNiB4MjI6IGZmZmY4MDAwMDgwMDNl
YzQgeDIxOg0KPj4+PiAwMDAwMDAwMDAwMDAwMDAwDQo+Pj4+IFvCoMKgwqAgNC44MjIwNTNdIHgy
MDogMDAwMDAwMDAwMDAwMDAwMSB4MTk6IGZmZmYwMDAwMDIzODEyMDAgeDE4Og0KPj4+PiBmZmZm
ZmZmZmZmZmZmZmZmDQo+Pj4+IFvCoMKgwqAgNC44MjkyMjJdIHgxNzogZmZmZjgwMDA3Njk2MjAw
MCB4MTY6IGZmZmY4MDAwMDgwMDAwMDAgeDE1Og0KPj4+PiBmZmZmODAwMDg4MDAzYjU3DQo+Pj4+
IFvCoMKgwqAgNC44MzYzOTBdIHgxNDogMDAwMDAwMDAwMDAwMDAwMCB4MTM6IGZmZmY4MDAwMDkz
YTUwNzggeDEyOg0KPj4+PiAwMDAwMDAwMDAwMDAwMzVkDQo+Pj4+IFvCoMKgwqAgNC44NDM1NThd
IHgxMTogMDAwMDAwMDAwMDAwMDExZiB4MTA6IGZmZmY4MDAwMDkzYTUwNzggeDkgOg0KPj4+PiBm
ZmZmODAwMDA5M2E1MDc4DQo+Pj4+IFvCoMKgwqAgNC44NTA3MjddIHg4IDogMDAwMDAwMDBmZmZm
ZWZmZiB4NyA6IGZmZmY4MDAwMDkzZmQwNzggeDYgOg0KPj4+PiBmZmZmODAwMDA5M2ZkMDc4DQo+
Pj4+IFvCoMKgwqAgNC44NTc4OTVdIHg1IDogMDAwMDAwMDAwMDAwYmZmNCB4NCA6IDAwMDAwMDAw
MDAwMDAwMDAgeDMgOg0KPj4+PiAwMDAwMDAwMDAwMDAwMDAwDQo+Pj4+IFvCoMKgwqAgNC44NjUw
NjJdIHgyIDogMDAwMDAwMDAwMDAwMDAwMCB4MSA6IDAwMDAwMDAwMDAwMDAwMDAgeDAgOg0KPj4+
PiBmZmZmODAwMDA5Mzk1MWMwDQo+Pj4+IFvCoMKgwqAgNC44NzIyMzBdIENhbGwgdHJhY2U6DQo+
Pj4+IFvCoMKgwqAgNC44NzQ2ODZdwqAgX19oYW5kbGVfaXJxX2V2ZW50X3BlcmNwdSsweGY0LzB4
MTgwDQo+Pj4+IFvCoMKgwqAgNC44Nzk0MTFdwqAgaGFuZGxlX2lycV9ldmVudCsweDY0LzB4ZWMN
Cj4+Pj4gW8KgwqDCoCA0Ljg4MzI2NF3CoCBoYW5kbGVfbGV2ZWxfaXJxKzB4YzAvMHgxYjANCj4+
Pj4gW8KgwqDCoCA0Ljg4NzIwMl3CoCBnZW5lcmljX2hhbmRsZV9pcnErMHgzMC8weDUwDQo+Pj4+
IFvCoMKgwqAgNC44OTEyMjldwqAgbXZlYnVfZ3Bpb19pcnFfaGFuZGxlcisweDExYy8weDJhMA0K
Pj4+PiBbwqDCoMKgIDQuODk1NzgwXcKgIGhhbmRsZV9kb21haW5faXJxKzB4NjAvMHg5MA0KPj4+
PiBbwqDCoMKgIDQuODk5NzIwXcKgIGdpY19oYW5kbGVfaXJxKzB4NGMvMHhkMA0KPj4+PiBbwqDC
oMKgIDQuOTAzMzk4XcKgIGNhbGxfb25faXJxX3N0YWNrKzB4MjAvMHg0Yw0KPj4+PiBbwqDCoMKg
IDQuOTA3MzM4XcKgIGRvX2ludGVycnVwdF9oYW5kbGVyKzB4NTQvMHg2MA0KPj4+PiBbwqDCoMKg
IDQuOTExNTM4XcKgIGVsMV9pbnRlcnJ1cHQrMHgzMC8weDgwDQo+Pj4+IFvCoMKgwqAgNC45MTUx
MzBdwqAgZWwxaF82NF9pcnFfaGFuZGxlcisweDE4LzB4MjQNCj4+Pj4gW8KgwqDCoCA0LjkxOTI0
NF3CoCBlbDFoXzY0X2lycSsweDc4LzB4N2MNCj4+Pj4gW8KgwqDCoCA0LjkyMjY1OV3CoCBhcmNo
X2NwdV9pZGxlKzB4MTgvMHgyYw0KPj4+PiBbwqDCoMKgIDQuOTI2MjQ5XcKgIGRvX2lkbGUrMHhj
NC8weDE1MA0KPj4+PiBbwqDCoMKgIDQuOTI5NDA0XcKgIGNwdV9zdGFydHVwX2VudHJ5KzB4Mjgv
MHg2MA0KPj4+PiBbwqDCoMKgIDQuOTMzMzQzXcKgIHJlc3RfaW5pdCsweGU0LzB4ZjQNCj4+Pj4g
W8KgwqDCoCA0LjkzNjU4NF3CoCBhcmNoX2NhbGxfcmVzdF9pbml0KzB4MTAvMHgxYw0KPj4+PiBb
wqDCoMKgIDQuOTQwNjk5XcKgIHN0YXJ0X2tlcm5lbCsweDYwMC8weDY0MA0KPj4+PiBbwqDCoMKg
IDQuOTQ0Mzc1XcKgIF9fcHJpbWFyeV9zd2l0Y2hlZCsweGJjLzB4YzQNCj4+Pj4gW8KgwqDCoCA0
Ljk0ODQwMl0gLS0tWyBlbmQgdHJhY2UgOTQwMTkzMDQ3YjM1YjMxMSBdLS0tDQo+Pj4+DQo+Pj4+
IEluaXRpYWxseSBJIGRpc21pc3NlZCB0aGlzIGFzIGEgd2FybmluZyB0aGF0IHdvdWxkIHByb2Jh
Ymx5IGJlIGNsZWFuZWQNCj4+Pj4gdXAgd2hlbiB3ZSBkaWQgbW9yZSB3b3JrIG9uIHRoZSBUUE0g
c3VwcG9ydCBmb3Igb3VyIHByb2R1Y3QgYnV0IHdlIGFsc28NCj4+Pj4gc2VlbSB0byBiZSBnZXR0
aW5nIHNvbWUgbmV3IGkyYyBpc3N1ZXMgYW5kIHBvc3NpYmx5IGEga2VybmVsIHN0YWNrDQo+Pj4+
IGNvcnJ1cHRpb24gdGhhdCB3ZSd2ZSBjb25mbGF0ZWQgd2l0aCB0aGlzIFRQTSB3YXJuaW5nLg0K
Pj4+IENhbiB5b3UgcmVwcm9kdWNlIHRoaXMgaXNzdWUgb24gbWFpbmxpbmU/IENhbiB5b3UgYWxz
byBiaXNlY3QgdG8gZmluZA0KPj4+IHRoZSBjdWxwcml0Pw0KPj4gTm8gdGhlIGVycm9yIGRvZXNu
J3QgYXBwZWFyIG9uIGEgcmVjZW50IG1haW5saW5lIGtlcm5lbC4gSSBkbyBzdGlsbCBnZXQNCj4+
DQo+PiB0cG1fdGlzX3NwaSBzcGkxLjE6IDIuMCBUUE0gKGRldmljZS1pZCAweDFCLCByZXYtaWQg
MjIpDQo+PiB0cG0gdHBtMDogW0Zpcm13YXJlIEJ1Z106IFRQTSBpbnRlcnJ1cHQgbm90IHdvcmtp
bmcsIHBvbGxpbmcgaW5zdGVhZA0KPj4gdHBtIHRwbTA6IEEgVFBNIGVycm9yICgyNTYpIG9jY3Vy
cmVkIGF0dGVtcHRpbmcgdGhlIHNlbGYgdGVzdA0KPj4NCj4+IGJ1dCBJIHRoaW5rIEkgd2FzIGdl
dHRpbmcgdGhhdCBvbiB2NS4xNS4xMTANCj4+DQo+IEkgcmVwZWF0OiBDYW4geW91IGJpc2VjdCBi
ZXR3ZWVuIHY1LjE1IGFuZCB2NS4xNS4xMTI/DQoNCkl0J3MgZGVmaW5pdGVseSBiZXR3ZWVuIHY1
LjE1LjExMCBhbmQgdjUuMTUuMTEyLg0KDQpJJ2xsIGRvIGEgcHJvcGVyIGJpc2VjdCBuZXh0IHdl
ZWsgYnV0IEknbSBwcmV0dHkgc3VyZSBpdCdzIHJlbGF0ZWQgdG8gDQp0aGUgInRwbSwgdHBtX3Rp
czoiIHNlcmllcy4gVGhlIHByb2JsZW0gY2FuIGJlIHdvcmtlZCBhcm91bmQgYnkgcmVtb3Zpbmcg
DQp0aGUgVFBNIGludGVycnVwdCBmcm9tIHRoZSBkZXZpY2UgdHJlZSBmb3IgdGhlIGJvYXJkLg0K
