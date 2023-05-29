Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48195714213
	for <lists+linux-integrity@lfdr.de>; Mon, 29 May 2023 04:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjE2CiD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 28 May 2023 22:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE2CiD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 28 May 2023 22:38:03 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77474A9
        for <linux-integrity@vger.kernel.org>; Sun, 28 May 2023 19:38:00 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 7415D2C0596;
        Mon, 29 May 2023 14:37:57 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1685327877;
        bh=CvoTk+Xu1b14AHNypYvOaXT+5OcQdBAujFjRkMNhZ0M=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=D4H+AEl/X7ZSx3/xYxeHH3LU8Wm5bzEihGjKqWxBlgFLCAVqy64LYL0/bzPGlVwHP
         g2Abxirojcr2maFv4PJdgOaCaoiCyhGEuS936CyIdurOJ3v+L5OttL45fBChz3+v1H
         07v5vwEzp0Rf5Li/moe5Cym5oUzx0hEnbc4qbAURRBRNUkcSkTswRpLhJeMc1eEuBV
         ep5kyk8Pxirtz41/jPNi6ygfkZkTwITAP0z54oROjmsb7EsoimuZTo/fU/UCKZIj8w
         HKMHBmJ/HQuGsHrfBqWTzn4laNQB2CgoG8nSBvAwoZHlM+KeAKo7JOsuPf48eFrciD
         OSiHo2GTh8FMQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B647410050001>; Mon, 29 May 2023 14:37:57 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 29 May 2023 14:37:57 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Mon, 29 May 2023 14:37:57 +1200
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
Thread-Index: AQHZkb4dgnEVWoKsX0S/ux9OJoU4IK9vtwkAgAAJdgA=
Date:   Mon, 29 May 2023 02:37:56 +0000
Message-ID: <6e470461-1a9b-ec51-bac5-f2beb1dc11c9@alliedtelesis.co.nz>
References: <fe6f7aa0-56c2-3729-ce8c-0f2d943b33f4@alliedtelesis.co.nz>
 <ZHQIFLWvrWUNMVxb@debian.me>
In-Reply-To: <ZHQIFLWvrWUNMVxb@debian.me>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0F65EDD43D12A449AF8828D55AAEF22@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=CSfSghpekuitt3WpJpAA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQpPbiAyOS8wNS8yMyAxNDowNCwgQmFnYXMgU2FuamF5YSB3cm90ZToNCj4gT24gU3VuLCBNYXkg
MjgsIDIwMjMgYXQgMTE6NDI6NTBQTSArMDAwMCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+IEhp
LA0KPj4NCj4+IFdlIGhhdmUgYW4gZW1iZWRkZWQgcHJvZHVjdCB3aXRoIGFuIEluZmluZW9uIFNM
TTk2NzAgVFBNLiBBZnRlciB1cGRhdGluZw0KPj4gdG8gYSBuZXdlciBMVFMga2VybmVsIHZlcnNp
b24gd2Ugc3RhcnRlZCBzZWVpbmcgdGhlIGZvbGxvd2luZyB3YXJuaW5nIGF0DQo+PiBib290Lg0K
Pj4NCj4+IFvCoMKgwqAgNC43NDEwMjVdIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0t
LS0tLQ0KPj4gW8KgwqDCoCA0Ljc0OTg5NF0gaXJxIDM4IGhhbmRsZXIgdGlzX2ludF9oYW5kbGVy
KzB4MC8weDE1NCBlbmFibGVkIGludGVycnVwdHMNCj4+IFvCoMKgwqAgNC43NTY1NTVdIFdBUk5J
Tkc6IENQVTogMCBQSUQ6IDAgYXQga2VybmVsL2lycS9oYW5kbGUuYzoxNTkNCj4+IF9faGFuZGxl
X2lycV9ldmVudF9wZXJjcHUrMHhmNC8weDE4MA0KPj4gW8KgwqDCoCA0Ljc2NTU1N10gTW9kdWxl
cyBsaW5rZWQgaW46DQo+PiBbwqDCoMKgIDQuNzY4NjI2XSBDUFU6IDAgUElEOiAwIENvbW06IHN3
YXBwZXIvMCBOb3QgdGFpbnRlZCA1LjE1LjExMyAjMQ0KPj4gW8KgwqDCoCA0Ljc3NDc0N10gSGFy
ZHdhcmUgbmFtZTogQWxsaWVkIFRlbGVzaXMgeDI1MC0xOFhTIChEVCkNCj4+IFvCoMKgwqAgNC43
ODAwODBdIHBzdGF0ZTogNjAwMDAwMDUgKG5aQ3YgZGFpZiAtUEFOIC1VQU8gLVRDTyAtRElUIC1T
U0JTDQo+PiBCVFlQRT0tLSkNCj4+IFvCoMKgwqAgNC43ODcwNzJdIHBjIDogX19oYW5kbGVfaXJx
X2V2ZW50X3BlcmNwdSsweGY0LzB4MTgwDQo+PiBbwqDCoMKgIDQuNzkyMTQ2XSBsciA6IF9faGFu
ZGxlX2lycV9ldmVudF9wZXJjcHUrMHhmNC8weDE4MA0KPj4gW8KgwqDCoCA0Ljc5NzIyMF0gc3Ag
OiBmZmZmODAwMDA4MDAzZTQwDQo+PiBbwqDCoMKgIDQuODAwNTQ3XSB4Mjk6IGZmZmY4MDAwMDgw
MDNlNDAgeDI4OiBmZmZmODAwMDA5Mzk1MWMwIHgyNzoNCj4+IGZmZmY4MDAwMDkwMmE5YjgNCj4+
IFvCoMKgwqAgNC44MDc3MTZdIHgyNjogZmZmZjgwMDAwOGZlOGQyOCB4MjU6IGZmZmY4MDAwMDk0
YTYyYmQgeDI0Og0KPj4gZmZmZjAwMDAwMWI5MjQwMA0KPj4gW8KgwqDCoCA0LjgxNDg4NV0geDIz
OiAwMDAwMDAwMDAwMDAwMDI2IHgyMjogZmZmZjgwMDAwODAwM2VjNCB4MjE6DQo+PiAwMDAwMDAw
MDAwMDAwMDAwDQo+PiBbwqDCoMKgIDQuODIyMDUzXSB4MjA6IDAwMDAwMDAwMDAwMDAwMDEgeDE5
OiBmZmZmMDAwMDAyMzgxMjAwIHgxODoNCj4+IGZmZmZmZmZmZmZmZmZmZmYNCj4+IFvCoMKgwqAg
NC44MjkyMjJdIHgxNzogZmZmZjgwMDA3Njk2MjAwMCB4MTY6IGZmZmY4MDAwMDgwMDAwMDAgeDE1
Og0KPj4gZmZmZjgwMDA4ODAwM2I1Nw0KPj4gW8KgwqDCoCA0LjgzNjM5MF0geDE0OiAwMDAwMDAw
MDAwMDAwMDAwIHgxMzogZmZmZjgwMDAwOTNhNTA3OCB4MTI6DQo+PiAwMDAwMDAwMDAwMDAwMzVk
DQo+PiBbwqDCoMKgIDQuODQzNTU4XSB4MTE6IDAwMDAwMDAwMDAwMDAxMWYgeDEwOiBmZmZmODAw
MDA5M2E1MDc4IHg5IDoNCj4+IGZmZmY4MDAwMDkzYTUwNzgNCj4+IFvCoMKgwqAgNC44NTA3Mjdd
IHg4IDogMDAwMDAwMDBmZmZmZWZmZiB4NyA6IGZmZmY4MDAwMDkzZmQwNzggeDYgOg0KPj4gZmZm
ZjgwMDAwOTNmZDA3OA0KPj4gW8KgwqDCoCA0Ljg1Nzg5NV0geDUgOiAwMDAwMDAwMDAwMDBiZmY0
IHg0IDogMDAwMDAwMDAwMDAwMDAwMCB4MyA6DQo+PiAwMDAwMDAwMDAwMDAwMDAwDQo+PiBbwqDC
oMKgIDQuODY1MDYyXSB4MiA6IDAwMDAwMDAwMDAwMDAwMDAgeDEgOiAwMDAwMDAwMDAwMDAwMDAw
IHgwIDoNCj4+IGZmZmY4MDAwMDkzOTUxYzANCj4+IFvCoMKgwqAgNC44NzIyMzBdIENhbGwgdHJh
Y2U6DQo+PiBbwqDCoMKgIDQuODc0Njg2XcKgIF9faGFuZGxlX2lycV9ldmVudF9wZXJjcHUrMHhm
NC8weDE4MA0KPj4gW8KgwqDCoCA0Ljg3OTQxMV3CoCBoYW5kbGVfaXJxX2V2ZW50KzB4NjQvMHhl
Yw0KPj4gW8KgwqDCoCA0Ljg4MzI2NF3CoCBoYW5kbGVfbGV2ZWxfaXJxKzB4YzAvMHgxYjANCj4+
IFvCoMKgwqAgNC44ODcyMDJdwqAgZ2VuZXJpY19oYW5kbGVfaXJxKzB4MzAvMHg1MA0KPj4gW8Kg
wqDCoCA0Ljg5MTIyOV3CoCBtdmVidV9ncGlvX2lycV9oYW5kbGVyKzB4MTFjLzB4MmEwDQo+PiBb
wqDCoMKgIDQuODk1NzgwXcKgIGhhbmRsZV9kb21haW5faXJxKzB4NjAvMHg5MA0KPj4gW8KgwqDC
oCA0Ljg5OTcyMF3CoCBnaWNfaGFuZGxlX2lycSsweDRjLzB4ZDANCj4+IFvCoMKgwqAgNC45MDMz
OThdwqAgY2FsbF9vbl9pcnFfc3RhY2srMHgyMC8weDRjDQo+PiBbwqDCoMKgIDQuOTA3MzM4XcKg
IGRvX2ludGVycnVwdF9oYW5kbGVyKzB4NTQvMHg2MA0KPj4gW8KgwqDCoCA0LjkxMTUzOF3CoCBl
bDFfaW50ZXJydXB0KzB4MzAvMHg4MA0KPj4gW8KgwqDCoCA0LjkxNTEzMF3CoCBlbDFoXzY0X2ly
cV9oYW5kbGVyKzB4MTgvMHgyNA0KPj4gW8KgwqDCoCA0LjkxOTI0NF3CoCBlbDFoXzY0X2lycSsw
eDc4LzB4N2MNCj4+IFvCoMKgwqAgNC45MjI2NTldwqAgYXJjaF9jcHVfaWRsZSsweDE4LzB4MmMN
Cj4+IFvCoMKgwqAgNC45MjYyNDldwqAgZG9faWRsZSsweGM0LzB4MTUwDQo+PiBbwqDCoMKgIDQu
OTI5NDA0XcKgIGNwdV9zdGFydHVwX2VudHJ5KzB4MjgvMHg2MA0KPj4gW8KgwqDCoCA0LjkzMzM0
M13CoCByZXN0X2luaXQrMHhlNC8weGY0DQo+PiBbwqDCoMKgIDQuOTM2NTg0XcKgIGFyY2hfY2Fs
bF9yZXN0X2luaXQrMHgxMC8weDFjDQo+PiBbwqDCoMKgIDQuOTQwNjk5XcKgIHN0YXJ0X2tlcm5l
bCsweDYwMC8weDY0MA0KPj4gW8KgwqDCoCA0Ljk0NDM3NV3CoCBfX3ByaW1hcnlfc3dpdGNoZWQr
MHhiYy8weGM0DQo+PiBbwqDCoMKgIDQuOTQ4NDAyXSAtLS1bIGVuZCB0cmFjZSA5NDAxOTMwNDdi
MzViMzExIF0tLS0NCj4+DQo+PiBJbml0aWFsbHkgSSBkaXNtaXNzZWQgdGhpcyBhcyBhIHdhcm5p
bmcgdGhhdCB3b3VsZCBwcm9iYWJseSBiZSBjbGVhbmVkDQo+PiB1cCB3aGVuIHdlIGRpZCBtb3Jl
IHdvcmsgb24gdGhlIFRQTSBzdXBwb3J0IGZvciBvdXIgcHJvZHVjdCBidXQgd2UgYWxzbw0KPj4g
c2VlbSB0byBiZSBnZXR0aW5nIHNvbWUgbmV3IGkyYyBpc3N1ZXMgYW5kIHBvc3NpYmx5IGEga2Vy
bmVsIHN0YWNrDQo+PiBjb3JydXB0aW9uIHRoYXQgd2UndmUgY29uZmxhdGVkIHdpdGggdGhpcyBU
UE0gd2FybmluZy4NCj4gQ2FuIHlvdSByZXByb2R1Y2UgdGhpcyBpc3N1ZSBvbiBtYWlubGluZT8g
Q2FuIHlvdSBhbHNvIGJpc2VjdCB0byBmaW5kDQo+IHRoZSBjdWxwcml0Pw0KDQpObyB0aGUgZXJy
b3IgZG9lc24ndCBhcHBlYXIgb24gYSByZWNlbnQgbWFpbmxpbmUga2VybmVsLiBJIGRvIHN0aWxs
IGdldA0KDQp0cG1fdGlzX3NwaSBzcGkxLjE6IDIuMCBUUE0gKGRldmljZS1pZCAweDFCLCByZXYt
aWQgMjIpDQp0cG0gdHBtMDogW0Zpcm13YXJlIEJ1Z106IFRQTSBpbnRlcnJ1cHQgbm90IHdvcmtp
bmcsIHBvbGxpbmcgaW5zdGVhZA0KdHBtIHRwbTA6IEEgVFBNIGVycm9yICgyNTYpIG9jY3VycmVk
IGF0dGVtcHRpbmcgdGhlIHNlbGYgdGVzdA0KDQpidXQgSSB0aGluayBJIHdhcyBnZXR0aW5nIHRo
YXQgb24gdjUuMTUuMTEwDQoNCj4NCj4gQW55d2F5LCBJJ20gYWRkaW5nIGl0IHRvIHJlZ3pib3Q6
DQo+DQo+ICNyZWd6Ym90IF5pbnRyb2R1Y2VkOiB2NS4xNS4xMTAuLnY1LjE1LjExMg0KPiAjcmVn
emJvdCB0aXRsZTogUG9zc2libGUgc3RhY2sgY29ycnVwdGlvbiBhbmQgaTJjIGlzc3VlcyBkdWUg
dG8gaXJxIHdhcm5pbmcgb24gSW5pZmluZW9uIFNMTTk2NzAgVFBNDQo+DQo+IFRoYW5rcy4NCj4=
