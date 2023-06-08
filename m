Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A300728999
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Jun 2023 22:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbjFHUjM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Jun 2023 16:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjFHUjL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Jun 2023 16:39:11 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11161BEB
        for <linux-integrity@vger.kernel.org>; Thu,  8 Jun 2023 13:39:08 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0AE182C0593;
        Fri,  9 Jun 2023 08:39:05 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1686256745;
        bh=v19MWtwVW2IiWNcAuLnjwIQsw+sLWgM145TwnC6PTzs=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=yKlpNBzOppKVY6BWxePnYu0TOODK1ZogkBKJqbbrICdZnJsGdIzFXtRiwX6bheSwt
         OwozNcO1mzUSoEIkH2gV93DXjTlnDIrH7KXOi6sG7cwy5QfjH0jT9iXd/LpoEKJ9JU
         MJQ7Ekc92dpUpGp4wsR45l9m0QrJRtANcmWOigtmmWskphT2ks9kRpNx4n7Szzps/O
         /+8sKJhNQpDXI9G2WI49pmdcIAHRnSEccsWKw4l0uTG5fnSvREHrwkIKigF2qwct75
         772knbg69uu4v4AJ9HE/jHR0FBgVq/XRyQw/AV4CFRFHmXfDjNOmsgONTzglw08k1d
         mRyZhD5zMO4NQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B64823c680001>; Fri, 09 Jun 2023 08:39:04 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.26; Fri, 9 Jun 2023 08:39:04 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Fri, 9 Jun 2023 08:39:04 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Fri, 9 Jun 2023 08:39:04 +1200
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
Thread-Index: AQHZkb4dgnEVWoKsX0S/ux9OJoU4IK98yP8AgAC/T4CAAUGLAIABgjCAgABZ1wA=
Date:   Thu, 8 Jun 2023 20:39:04 +0000
Message-ID: <1a168fef-8d9f-a700-2472-a60da508aeac@alliedtelesis.co.nz>
References: <fe6f7aa0-56c2-3729-ce8c-0f2d943b33f4@alliedtelesis.co.nz>
 <7bb470fa70ff5944b7b9b82ac17d759819bccdf2.camel@kernel.org>
 <0bdf509f-f71a-e3b2-b9fb-4a726021219b@alliedtelesis.co.nz>
 <CT6JW4528UBU.1K3QJTVUN25OR@suppilovahvero>
 <CT7DAF9JJ4KD.37K8GDWP7GKG1@suppilovahvero>
In-Reply-To: <CT7DAF9JJ4KD.37K8GDWP7GKG1@suppilovahvero>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7589C5524C828741BCCDBB70EA9E2996@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=CMhUoijD c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=of4jigFt-DYA:10 a=VwQbUJbxAAAA:8 a=d_NS31tpAAAA:8 a=URbYG7BdFpQEoCwZzwwA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=PfdiIfcH12mfzV1Ea7Td:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SGkgSmFya2tvLA0KDQpPbiA5LzA2LzIzIDAzOjE3LCBKYXJra28gU2Fra2luZW4gd3JvdGU6DQo+
IE9uIFdlZCBKdW4gNywgMjAyMyBhdCA3OjE1IFBNIEVFU1QsIEphcmtrbyBTYWtraW5lbiB3cm90
ZToNCj4+IE9uIFdlZCBKdW4gNywgMjAyMyBhdCAxMjowNCBBTSBFRVNULCBDaHJpcyBQYWNraGFt
IHdyb3RlOg0KPj4+IEhpIEphcmtrbywNCj4+Pg0KPj4+IE9uIDYvMDYvMjMgMjE6MzksIEphcmtr
byBTYWtraW5lbiB3cm90ZToNCj4+Pj4gT24gU3VuLCAyMDIzLTA1LTI4IGF0IDIzOjQyICswMDAw
LCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4+Pj4gSGksDQo+Pj4+Pg0KPj4+Pj4gV2UgaGF2ZSBh
biBlbWJlZGRlZCBwcm9kdWN0IHdpdGggYW4gSW5maW5lb24gU0xNOTY3MCBUUE0uIEFmdGVyIHVw
ZGF0aW5nDQo+Pj4+PiB0byBhIG5ld2VyIExUUyBrZXJuZWwgdmVyc2lvbiB3ZSBzdGFydGVkIHNl
ZWluZyB0aGUgZm9sbG93aW5nIHdhcm5pbmcgYXQNCj4+Pj4+IGJvb3QuDQo+Pj4+Pg0KPj4+Pj4g
W8KgwqDCoCA0Ljc0MTAyNV0gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tDQo+
Pj4+PiBbwqDCoMKgIDQuNzQ5ODk0XSBpcnEgMzggaGFuZGxlciB0aXNfaW50X2hhbmRsZXIrMHgw
LzB4MTU0IGVuYWJsZWQgaW50ZXJydXB0cw0KPj4+Pj4gW8KgwqDCoCA0Ljc1NjU1NV0gV0FSTklO
RzogQ1BVOiAwIFBJRDogMCBhdCBrZXJuZWwvaXJxL2hhbmRsZS5jOjE1OQ0KPj4+Pj4gX19oYW5k
bGVfaXJxX2V2ZW50X3BlcmNwdSsweGY0LzB4MTgwDQo+Pj4+PiBbwqDCoMKgIDQuNzY1NTU3XSBN
b2R1bGVzIGxpbmtlZCBpbjoNCj4+Pj4+IFvCoMKgwqAgNC43Njg2MjZdIENQVTogMCBQSUQ6IDAg
Q29tbTogc3dhcHBlci8wIE5vdCB0YWludGVkIDUuMTUuMTEzICMxDQo+Pj4+PiBbwqDCoMKgIDQu
Nzc0NzQ3XSBIYXJkd2FyZSBuYW1lOiBBbGxpZWQgVGVsZXNpcyB4MjUwLTE4WFMgKERUKQ0KPj4+
Pj4gW8KgwqDCoCA0Ljc4MDA4MF0gcHN0YXRlOiA2MDAwMDAwNSAoblpDdiBkYWlmIC1QQU4gLVVB
TyAtVENPIC1ESVQgLVNTQlMNCj4+Pj4+IEJUWVBFPS0tKQ0KPj4+Pj4gW8KgwqDCoCA0Ljc4NzA3
Ml0gcGMgOiBfX2hhbmRsZV9pcnFfZXZlbnRfcGVyY3B1KzB4ZjQvMHgxODANCj4+Pj4+IFvCoMKg
wqAgNC43OTIxNDZdIGxyIDogX19oYW5kbGVfaXJxX2V2ZW50X3BlcmNwdSsweGY0LzB4MTgwDQo+
Pj4+PiBbwqDCoMKgIDQuNzk3MjIwXSBzcCA6IGZmZmY4MDAwMDgwMDNlNDANCj4+Pj4+IFvCoMKg
wqAgNC44MDA1NDddIHgyOTogZmZmZjgwMDAwODAwM2U0MCB4Mjg6IGZmZmY4MDAwMDkzOTUxYzAg
eDI3Og0KPj4+Pj4gZmZmZjgwMDAwOTAyYTliOA0KPj4+Pj4gW8KgwqDCoCA0LjgwNzcxNl0geDI2
OiBmZmZmODAwMDA4ZmU4ZDI4IHgyNTogZmZmZjgwMDAwOTRhNjJiZCB4MjQ6DQo+Pj4+PiBmZmZm
MDAwMDAxYjkyNDAwDQo+Pj4+PiBbwqDCoMKgIDQuODE0ODg1XSB4MjM6IDAwMDAwMDAwMDAwMDAw
MjYgeDIyOiBmZmZmODAwMDA4MDAzZWM0IHgyMToNCj4+Pj4+IDAwMDAwMDAwMDAwMDAwMDANCj4+
Pj4+IFvCoMKgwqAgNC44MjIwNTNdIHgyMDogMDAwMDAwMDAwMDAwMDAwMSB4MTk6IGZmZmYwMDAw
MDIzODEyMDAgeDE4Og0KPj4+Pj4gZmZmZmZmZmZmZmZmZmZmZg0KPj4+Pj4gW8KgwqDCoCA0Ljgy
OTIyMl0geDE3OiBmZmZmODAwMDc2OTYyMDAwIHgxNjogZmZmZjgwMDAwODAwMDAwMCB4MTU6DQo+
Pj4+PiBmZmZmODAwMDg4MDAzYjU3DQo+Pj4+PiBbwqDCoMKgIDQuODM2MzkwXSB4MTQ6IDAwMDAw
MDAwMDAwMDAwMDAgeDEzOiBmZmZmODAwMDA5M2E1MDc4IHgxMjoNCj4+Pj4+IDAwMDAwMDAwMDAw
MDAzNWQNCj4+Pj4+IFvCoMKgwqAgNC44NDM1NThdIHgxMTogMDAwMDAwMDAwMDAwMDExZiB4MTA6
IGZmZmY4MDAwMDkzYTUwNzggeDkgOg0KPj4+Pj4gZmZmZjgwMDAwOTNhNTA3OA0KPj4+Pj4gW8Kg
wqDCoCA0Ljg1MDcyN10geDggOiAwMDAwMDAwMGZmZmZlZmZmIHg3IDogZmZmZjgwMDAwOTNmZDA3
OCB4NiA6DQo+Pj4+PiBmZmZmODAwMDA5M2ZkMDc4DQo+Pj4+PiBbwqDCoMKgIDQuODU3ODk1XSB4
NSA6IDAwMDAwMDAwMDAwMGJmZjQgeDQgOiAwMDAwMDAwMDAwMDAwMDAwIHgzIDoNCj4+Pj4+IDAw
MDAwMDAwMDAwMDAwMDANCj4+Pj4+IFvCoMKgwqAgNC44NjUwNjJdIHgyIDogMDAwMDAwMDAwMDAw
MDAwMCB4MSA6IDAwMDAwMDAwMDAwMDAwMDAgeDAgOg0KPj4+Pj4gZmZmZjgwMDAwOTM5NTFjMA0K
Pj4+Pj4gW8KgwqDCoCA0Ljg3MjIzMF0gQ2FsbCB0cmFjZToNCj4+Pj4+IFvCoMKgwqAgNC44NzQ2
ODZdwqAgX19oYW5kbGVfaXJxX2V2ZW50X3BlcmNwdSsweGY0LzB4MTgwDQo+Pj4+PiBbwqDCoMKg
IDQuODc5NDExXcKgIGhhbmRsZV9pcnFfZXZlbnQrMHg2NC8weGVjDQo+Pj4+PiBbwqDCoMKgIDQu
ODgzMjY0XcKgIGhhbmRsZV9sZXZlbF9pcnErMHhjMC8weDFiMA0KPj4+Pj4gW8KgwqDCoCA0Ljg4
NzIwMl3CoCBnZW5lcmljX2hhbmRsZV9pcnErMHgzMC8weDUwDQo+Pj4+PiBbwqDCoMKgIDQuODkx
MjI5XcKgIG12ZWJ1X2dwaW9faXJxX2hhbmRsZXIrMHgxMWMvMHgyYTANCj4+Pj4+IFvCoMKgwqAg
NC44OTU3ODBdwqAgaGFuZGxlX2RvbWFpbl9pcnErMHg2MC8weDkwDQo+Pj4+PiBbwqDCoMKgIDQu
ODk5NzIwXcKgIGdpY19oYW5kbGVfaXJxKzB4NGMvMHhkMA0KPj4+Pj4gW8KgwqDCoCA0LjkwMzM5
OF3CoCBjYWxsX29uX2lycV9zdGFjaysweDIwLzB4NGMNCj4+Pj4+IFvCoMKgwqAgNC45MDczMzhd
wqAgZG9faW50ZXJydXB0X2hhbmRsZXIrMHg1NC8weDYwDQo+Pj4+PiBbwqDCoMKgIDQuOTExNTM4
XcKgIGVsMV9pbnRlcnJ1cHQrMHgzMC8weDgwDQo+Pj4+PiBbwqDCoMKgIDQuOTE1MTMwXcKgIGVs
MWhfNjRfaXJxX2hhbmRsZXIrMHgxOC8weDI0DQo+Pj4+PiBbwqDCoMKgIDQuOTE5MjQ0XcKgIGVs
MWhfNjRfaXJxKzB4NzgvMHg3Yw0KPj4+Pj4gW8KgwqDCoCA0LjkyMjY1OV3CoCBhcmNoX2NwdV9p
ZGxlKzB4MTgvMHgyYw0KPj4+Pj4gW8KgwqDCoCA0LjkyNjI0OV3CoCBkb19pZGxlKzB4YzQvMHgx
NTANCj4+Pj4+IFvCoMKgwqAgNC45Mjk0MDRdwqAgY3B1X3N0YXJ0dXBfZW50cnkrMHgyOC8weDYw
DQo+Pj4+PiBbwqDCoMKgIDQuOTMzMzQzXcKgIHJlc3RfaW5pdCsweGU0LzB4ZjQNCj4+Pj4+IFvC
oMKgwqAgNC45MzY1ODRdwqAgYXJjaF9jYWxsX3Jlc3RfaW5pdCsweDEwLzB4MWMNCj4+Pj4+IFvC
oMKgwqAgNC45NDA2OTldwqAgc3RhcnRfa2VybmVsKzB4NjAwLzB4NjQwDQo+Pj4+PiBbwqDCoMKg
IDQuOTQ0Mzc1XcKgIF9fcHJpbWFyeV9zd2l0Y2hlZCsweGJjLzB4YzQNCj4+Pj4+IFvCoMKgwqAg
NC45NDg0MDJdIC0tLVsgZW5kIHRyYWNlIDk0MDE5MzA0N2IzNWIzMTEgXS0tLQ0KPj4+Pj4NCj4+
Pj4+IEluaXRpYWxseSBJIGRpc21pc3NlZCB0aGlzIGFzIGEgd2FybmluZyB0aGF0IHdvdWxkIHBy
b2JhYmx5IGJlIGNsZWFuZWQNCj4+Pj4+IHVwIHdoZW4gd2UgZGlkIG1vcmUgd29yayBvbiB0aGUg
VFBNIHN1cHBvcnQgZm9yIG91ciBwcm9kdWN0IGJ1dCB3ZSBhbHNvDQo+Pj4+PiBzZWVtIHRvIGJl
IGdldHRpbmcgc29tZSBuZXcgaTJjIGlzc3VlcyBhbmQgcG9zc2libHkgYSBrZXJuZWwgc3RhY2sN
Cj4+Pj4+IGNvcnJ1cHRpb24gdGhhdCB3ZSd2ZSBjb25mbGF0ZWQgd2l0aCB0aGlzIFRQTSB3YXJu
aW5nLg0KPj4+PiBIaSwgc29ycnkgZm9yIGxhdGUgcmVzcG9uc2UuIEkndmUgYmVlbiBtb3Zpbmcg
bXkgKGhvbWUpIG9mZmljZSB0bw0KPj4+PiBhIGRpZmZlcmVudCBsb2NhdGlvbiBkdXJpbmcgbGFz
dCBjb3VwbGUgb2Ygd2Vla3MsIGFuZCBlbWFpbCBoYXMgYmVlbg0KPj4+PiBwaWxpbmcgdXAuDQo+
Pj4+DQo+Pj4+IFdoYXQgZG9lcyBkbWlkZWNvZGUgZ2l2ZSB5b3U/DQo+Pj4+DQo+Pj4+IE1vcmUg
c3BlY2lmaWMsIEknbSBpbnRlcmVzdGVkIG9uIERNSSB0eXBlIDQzOg0KPj4+Pg0KPj4+PiAkIHN1
ZG8gZG1pZGVjb2RlIC10IDQzDQo+Pj4+ICMgZG1pZGVjb2RlIDMuNA0KPj4+PiBHZXR0aW5nIFNN
QklPUyBkYXRhIGZyb20gc3lzZnMuDQo+Pj4+IFNNQklPUyAzLjQuMCBwcmVzZW50Lg0KPj4+Pg0K
Pj4+PiBIYW5kbGUgMHgwMDRELCBETUkgdHlwZSA0MywgMzEgYnl0ZXMNCj4+Pj4gVFBNIERldmlj
ZQ0KPj4+PiAJVmVuZG9yIElEOiBJTlRDDQo+Pj4+IAlTcGVjaWZpY2F0aW9uIFZlcnNpb246IDIu
MA0KPj4+PiAJRmlybXdhcmUgUmV2aXNpb246IDYwMC4xOA0KPj4+PiAJRGVzY3JpcHRpb246IElO
VEVMDQo+Pj4+IAlDaGFyYWN0ZXJpc3RpY3M6DQo+Pj4+IAkJRmFtaWx5IGNvbmZpZ3VyYWJsZSB2
aWEgcGxhdGZvcm0gc29mdHdhcmUgc3VwcG9ydA0KPj4+PiAJT0VNLXNwZWNpZmljIEluZm9ybWF0
aW9uOiAweDAwMDAwMDAwDQo+Pj4+DQo+Pj4+IEJSLCBKYXJra28NCj4+PiBUaGlzIGlzIGFuIGVt
YmVkZGVkIEFSTTY0IChNYXJ2ZWxsIENOOTEzMCBTb0MpIGRldmljZSBzbyBubyBCSU9TLiBUaGUN
Cj4+PiByZWxldmFudCBzbmlwcGV0IGZyb20gdGhlIGRldmljZSB0cmVlIGlzDQo+Pj4NCj4+PiAg
IMKgwqDCoMKgwqDCoMKgIHRwbUAxIHsNCj4+PiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBjb21wYXRpYmxlID0gImluZmluZW9uLHNsYjk2NzAiOw0KPj4+ICAgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJlZyA9IDwxPjsgLyogQ2hpcCBzZWxlY3QgMSAqLw0KPj4+ICAg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludGVycnVwdC1wYXJlbnQgPSA8JmNwMF9n
cGlvMj47DQo+Pj4gICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50ZXJydXB0cyA9
IDwzMCBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KPj4+ICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHNwaS1tYXgtZnJlcXVlbmN5ID0gPDMxMjUwMDAwPjsNCj4+PiAgIMKgwqDCoMKgwqDC
oMKgIH07DQo+Pj4NCj4+PiBhbmQgSSBjYW4gdGVsbCB5b3UgdGhhdCB0aGUgc3BlY2lmaWMgVFBN
IGNoaXAgaXMgYW4gSW5maW5pZW9uDQo+Pj4gU0xNOTY3MEFRMjBGVzEzMTFYVE1BMQ0KPj4gT0ss
IHlvdSBrbm93IHdoYXQgSSBvd24gdGhhdCBjaGlwIGluIHRoZSBmb3JtIG9mIExldHNUcnVzdFRQ
TQ0KPj4gcHJvZHVjdC4NCj4+DQo+PiBJIGhhdmUgbm90IHVzZWQgaXQgYSBsb3QgYmVjYXVzZSBv
ZiBsYWNrIG9mIHRpbWUgYnV0IEkgY291bGQgdHJ5DQo+PiB0byByZXByb2R1Y2UgdGhlIGJ1ZyB3
aXRoIHRoYXQgYW5kIFJQaSAzQiwgb3IgYXQgbGVhc3Qgc2VlIHdoYXQNCj4+IGhhcHBlbnMgd2l0
aCBkaWZmZXJlbnQgaGFyZHdhcmUgcGxhdGZvcm0gd2l0aCB0aGUgc2FtZSBUUE0gY2hpcC4NCj4g
SSdtIG5vdCBkZXZpY2UgdHJlZSBleHBlcnQgYnV0IHdpdGggbXkgbGltaXRlZCBrbm93bGVkZ2Us
IEkgZ3Vlc3Mga3dlDQo+IGNvdWxkIGFkZCBhIHF1aXJrIHRoYXQgdXNlcyBvZl9tYWNoaW5lX2lz
X2NvbXBhdGlibGUoKSwgdG8gZGlzYWJsZQ0KPiBJUlEncywgaS5lLiBiYXNlIHRoZSBwb2xpY3kg
b24gc3BlY2lmaWMgYm9hcmRzIHJhdGhlciB0aGFuIHNwZWNpZmljDQo+IGNoaXBzOiBbKl0NCj4N
Cj4gCWlmIChvZl9tYWNoaW5lX2lzX2NvbXBhdGlibGUoIm1hcnZlbGwsY245MTMwIikpIHsNCj4g
CQlkZXZfbm90aWNlKGRldiwgImRpc2FibGUgaW50ZXJydXB0cyIpOw0KPiAJCWludGVycnVwdHMg
PSAwOwkNCj4gCX0NCj4NCj4gWypdIEkgbG9va2VkIHVwIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFy
dmVsbC9jbjkxMzAuZHRzaS4gSSBob3BlIEkgcGlja2VkDQo+IHRoZSBjb3JyZWN0IGZpbGUuDQoN
ClRoZSB3YXJuaW5nIGl0c2VsZiB3YXMgcmVzb2x2ZWQgYnkgYnJpbmdpbmcgaW4gYSBmdXJ0aGVy
IGNoYW5nZSBmb3IgdGhlIA0KTFRTIGJyYW5jaFsxXS4gVGhlcmUgZG9lcyBzdGlsbCBzZWVtIHRv
IGJlIGFuIGlzc3VlIHdpdGggdGhlIGludGVycnVwdHMgDQphY3R1YWxseSB3b3JraW5nIChzYW1l
IGJlaGF2aW91ciBvbiBtYWlubGluZSkgYnV0IGF0IGxlYXN0IG5vdyB0aGVyZSBpcyANCm5vIHdh
cm5pbmcgYW5kIG5vIGFkdmVyc2UgZG93bnN0cmVhbSBlZmZlY3RzLg0KDQpJbiB0ZXJtcyBvZiBk
ZXZpY2UgdHJlZSBzdHVmZiB0byBkaXNhYmxlIHRoZSBpbnRlcnJ1cHQgSSBjb3VsZCBzaW1wbHkg
DQpyZW1vdmUgdGhlIGludGVycnVwdCBwcm9wZXJ0aWVzIGZyb20gdGhlIGJvYXJkIERUUyAoSSB3
YXMgZG9pbmcgdGhpcyBhcyANCmEgd29ya2Fyb3VuZCBiZWZvcmUgdGhlIGNvcnJlY3QgZml4IHdh
cyBpZGVudGlmaWVkKS4NCg0KWzFdIC0gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1p
bnRlZ3JpdHkvYWM1Yjc2YWYtODdkYy1iMDRkLTYwMzUtOGVkYThiYTVlZDEyQGt1bmJ1cy5jb20v
DQo=
