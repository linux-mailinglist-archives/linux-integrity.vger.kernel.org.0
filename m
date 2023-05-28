Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AB871413A
	for <lists+linux-integrity@lfdr.de>; Mon, 29 May 2023 01:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjE1Xm4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 28 May 2023 19:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE1Xmz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 28 May 2023 19:42:55 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14D7B8
        for <linux-integrity@vger.kernel.org>; Sun, 28 May 2023 16:42:53 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 902262C0547;
        Mon, 29 May 2023 11:42:50 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1685317370;
        bh=Yxl/Wv7EGO8otOGzYDsnqGKLAySxtcvmBjUnaBr1j7s=;
        h=From:To:CC:Subject:Date:From;
        b=1psPayb0udFCl2PLJdsFC9z77kFrAXxFj9+8zQeASD1PtFNUKA5HH7OurYkhP0cp9
         Fx5UYGg8HXZQSchHv/BmS2KAeoDEzksifKG8CVPHCFIPib8jGW+JdHXqzqWA73fc7X
         RSOCiQrSNRDmqZXudovJJogvXN+TgKwgJo6fZ2eKPcfhBI646ejrq3f02tZEuvABxR
         bYgtk5xrOt9PK5d4WZP1XTKvA/CbrUqttHdmUVkme9nlX0uujV+z25d1XN7gN/HX47
         Leu64jax4WzT8aMWTWXRCmcQ4t82gg1kgOn8o+gA6eD6di7lbKHpdEBKITvJ+VlQCn
         q5mZ98ckeu/OQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6473e6fa0001>; Mon, 29 May 2023 11:42:50 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 29 May 2023 11:42:50 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Mon, 29 May 2023 11:42:50 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: New kernel warning after updating from LTS 5.15.110 to 5.15.112 (and
 5.15.113)
Thread-Topic: New kernel warning after updating from LTS 5.15.110 to 5.15.112
 (and 5.15.113)
Thread-Index: AQHZkb4dgnEVWoKsX0S/ux9OJoU4IA==
Date:   Sun, 28 May 2023 23:42:50 +0000
Message-ID: <fe6f7aa0-56c2-3729-ce8c-0f2d943b33f4@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F74858C97EAF748AC2A658BE5377484@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=P9toQ6B8Ia7luQItJswA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SGksDQoNCldlIGhhdmUgYW4gZW1iZWRkZWQgcHJvZHVjdCB3aXRoIGFuIEluZmluZW9uIFNMTTk2
NzAgVFBNLiBBZnRlciB1cGRhdGluZyANCnRvIGEgbmV3ZXIgTFRTIGtlcm5lbCB2ZXJzaW9uIHdl
IHN0YXJ0ZWQgc2VlaW5nIHRoZSBmb2xsb3dpbmcgd2FybmluZyBhdCANCmJvb3QuDQoNClvCoMKg
wqAgNC43NDEwMjVdIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KW8KgwqDC
oCA0Ljc0OTg5NF0gaXJxIDM4IGhhbmRsZXIgdGlzX2ludF9oYW5kbGVyKzB4MC8weDE1NCBlbmFi
bGVkIGludGVycnVwdHMNClvCoMKgwqAgNC43NTY1NTVdIFdBUk5JTkc6IENQVTogMCBQSUQ6IDAg
YXQga2VybmVsL2lycS9oYW5kbGUuYzoxNTkgDQpfX2hhbmRsZV9pcnFfZXZlbnRfcGVyY3B1KzB4
ZjQvMHgxODANClvCoMKgwqAgNC43NjU1NTddIE1vZHVsZXMgbGlua2VkIGluOg0KW8KgwqDCoCA0
Ljc2ODYyNl0gQ1BVOiAwIFBJRDogMCBDb21tOiBzd2FwcGVyLzAgTm90IHRhaW50ZWQgNS4xNS4x
MTMgIzENClvCoMKgwqAgNC43NzQ3NDddIEhhcmR3YXJlIG5hbWU6IEFsbGllZCBUZWxlc2lzIHgy
NTAtMThYUyAoRFQpDQpbwqDCoMKgIDQuNzgwMDgwXSBwc3RhdGU6IDYwMDAwMDA1IChuWkN2IGRh
aWYgLVBBTiAtVUFPIC1UQ08gLURJVCAtU1NCUyANCkJUWVBFPS0tKQ0KW8KgwqDCoCA0Ljc4NzA3
Ml0gcGMgOiBfX2hhbmRsZV9pcnFfZXZlbnRfcGVyY3B1KzB4ZjQvMHgxODANClvCoMKgwqAgNC43
OTIxNDZdIGxyIDogX19oYW5kbGVfaXJxX2V2ZW50X3BlcmNwdSsweGY0LzB4MTgwDQpbwqDCoMKg
IDQuNzk3MjIwXSBzcCA6IGZmZmY4MDAwMDgwMDNlNDANClvCoMKgwqAgNC44MDA1NDddIHgyOTog
ZmZmZjgwMDAwODAwM2U0MCB4Mjg6IGZmZmY4MDAwMDkzOTUxYzAgeDI3OiANCmZmZmY4MDAwMDkw
MmE5YjgNClvCoMKgwqAgNC44MDc3MTZdIHgyNjogZmZmZjgwMDAwOGZlOGQyOCB4MjU6IGZmZmY4
MDAwMDk0YTYyYmQgeDI0OiANCmZmZmYwMDAwMDFiOTI0MDANClvCoMKgwqAgNC44MTQ4ODVdIHgy
MzogMDAwMDAwMDAwMDAwMDAyNiB4MjI6IGZmZmY4MDAwMDgwMDNlYzQgeDIxOiANCjAwMDAwMDAw
MDAwMDAwMDANClvCoMKgwqAgNC44MjIwNTNdIHgyMDogMDAwMDAwMDAwMDAwMDAwMSB4MTk6IGZm
ZmYwMDAwMDIzODEyMDAgeDE4OiANCmZmZmZmZmZmZmZmZmZmZmYNClvCoMKgwqAgNC44MjkyMjJd
IHgxNzogZmZmZjgwMDA3Njk2MjAwMCB4MTY6IGZmZmY4MDAwMDgwMDAwMDAgeDE1OiANCmZmZmY4
MDAwODgwMDNiNTcNClvCoMKgwqAgNC44MzYzOTBdIHgxNDogMDAwMDAwMDAwMDAwMDAwMCB4MTM6
IGZmZmY4MDAwMDkzYTUwNzggeDEyOiANCjAwMDAwMDAwMDAwMDAzNWQNClvCoMKgwqAgNC44NDM1
NThdIHgxMTogMDAwMDAwMDAwMDAwMDExZiB4MTA6IGZmZmY4MDAwMDkzYTUwNzggeDkgOiANCmZm
ZmY4MDAwMDkzYTUwNzgNClvCoMKgwqAgNC44NTA3MjddIHg4IDogMDAwMDAwMDBmZmZmZWZmZiB4
NyA6IGZmZmY4MDAwMDkzZmQwNzggeDYgOiANCmZmZmY4MDAwMDkzZmQwNzgNClvCoMKgwqAgNC44
NTc4OTVdIHg1IDogMDAwMDAwMDAwMDAwYmZmNCB4NCA6IDAwMDAwMDAwMDAwMDAwMDAgeDMgOiAN
CjAwMDAwMDAwMDAwMDAwMDANClvCoMKgwqAgNC44NjUwNjJdIHgyIDogMDAwMDAwMDAwMDAwMDAw
MCB4MSA6IDAwMDAwMDAwMDAwMDAwMDAgeDAgOiANCmZmZmY4MDAwMDkzOTUxYzANClvCoMKgwqAg
NC44NzIyMzBdIENhbGwgdHJhY2U6DQpbwqDCoMKgIDQuODc0Njg2XcKgIF9faGFuZGxlX2lycV9l
dmVudF9wZXJjcHUrMHhmNC8weDE4MA0KW8KgwqDCoCA0Ljg3OTQxMV3CoCBoYW5kbGVfaXJxX2V2
ZW50KzB4NjQvMHhlYw0KW8KgwqDCoCA0Ljg4MzI2NF3CoCBoYW5kbGVfbGV2ZWxfaXJxKzB4YzAv
MHgxYjANClvCoMKgwqAgNC44ODcyMDJdwqAgZ2VuZXJpY19oYW5kbGVfaXJxKzB4MzAvMHg1MA0K
W8KgwqDCoCA0Ljg5MTIyOV3CoCBtdmVidV9ncGlvX2lycV9oYW5kbGVyKzB4MTFjLzB4MmEwDQpb
wqDCoMKgIDQuODk1NzgwXcKgIGhhbmRsZV9kb21haW5faXJxKzB4NjAvMHg5MA0KW8KgwqDCoCA0
Ljg5OTcyMF3CoCBnaWNfaGFuZGxlX2lycSsweDRjLzB4ZDANClvCoMKgwqAgNC45MDMzOThdwqAg
Y2FsbF9vbl9pcnFfc3RhY2srMHgyMC8weDRjDQpbwqDCoMKgIDQuOTA3MzM4XcKgIGRvX2ludGVy
cnVwdF9oYW5kbGVyKzB4NTQvMHg2MA0KW8KgwqDCoCA0LjkxMTUzOF3CoCBlbDFfaW50ZXJydXB0
KzB4MzAvMHg4MA0KW8KgwqDCoCA0LjkxNTEzMF3CoCBlbDFoXzY0X2lycV9oYW5kbGVyKzB4MTgv
MHgyNA0KW8KgwqDCoCA0LjkxOTI0NF3CoCBlbDFoXzY0X2lycSsweDc4LzB4N2MNClvCoMKgwqAg
NC45MjI2NTldwqAgYXJjaF9jcHVfaWRsZSsweDE4LzB4MmMNClvCoMKgwqAgNC45MjYyNDldwqAg
ZG9faWRsZSsweGM0LzB4MTUwDQpbwqDCoMKgIDQuOTI5NDA0XcKgIGNwdV9zdGFydHVwX2VudHJ5
KzB4MjgvMHg2MA0KW8KgwqDCoCA0LjkzMzM0M13CoCByZXN0X2luaXQrMHhlNC8weGY0DQpbwqDC
oMKgIDQuOTM2NTg0XcKgIGFyY2hfY2FsbF9yZXN0X2luaXQrMHgxMC8weDFjDQpbwqDCoMKgIDQu
OTQwNjk5XcKgIHN0YXJ0X2tlcm5lbCsweDYwMC8weDY0MA0KW8KgwqDCoCA0Ljk0NDM3NV3CoCBf
X3ByaW1hcnlfc3dpdGNoZWQrMHhiYy8weGM0DQpbwqDCoMKgIDQuOTQ4NDAyXSAtLS1bIGVuZCB0
cmFjZSA5NDAxOTMwNDdiMzViMzExIF0tLS0NCg0KSW5pdGlhbGx5IEkgZGlzbWlzc2VkIHRoaXMg
YXMgYSB3YXJuaW5nIHRoYXQgd291bGQgcHJvYmFibHkgYmUgY2xlYW5lZCANCnVwIHdoZW4gd2Ug
ZGlkIG1vcmUgd29yayBvbiB0aGUgVFBNIHN1cHBvcnQgZm9yIG91ciBwcm9kdWN0IGJ1dCB3ZSBh
bHNvIA0Kc2VlbSB0byBiZSBnZXR0aW5nIHNvbWUgbmV3IGkyYyBpc3N1ZXMgYW5kIHBvc3NpYmx5
IGEga2VybmVsIHN0YWNrIA0KY29ycnVwdGlvbiB0aGF0IHdlJ3ZlIGNvbmZsYXRlZCB3aXRoIHRo
aXMgVFBNIHdhcm5pbmcuDQo=
