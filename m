Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C93725262
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jun 2023 05:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbjFGDXM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jun 2023 23:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239057AbjFGDXL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jun 2023 23:23:11 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC3719B9
        for <linux-integrity@vger.kernel.org>; Tue,  6 Jun 2023 20:23:09 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E4EF42C053D;
        Wed,  7 Jun 2023 15:23:05 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1686108185;
        bh=yXOcZXWz3l0z4lNkhTLDOjIcF4Tp/PWCzyThsJLZ9UU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=CYyBbXG0Akb9PaChhfccPKgGZM/GB1r4Mle3Yb+WTUAQvrR3NxafmS7KdFK/y8AZV
         fBxiWTO+fghLADzXPVVMwM5Jf4ucrcAQMJp47O4/4rDnZ1/cZR7Qgs4KCOcXZ0hApr
         yiReRDWyuan7VggbDDrYkqpbfv/SYsC7p6xOEtiG96zsrV6gx0+8iJczvNq0/HZKcY
         5Q3Aml63EuhUWVy0N3OOXKivp8vnqRwlqrhgB8SpwR4kQqub91Z8rnI7uhJkVLkeTZ
         kV4hOoJzakEYNWcVCgQcV6mrO0EzfOyddopZsZF6qFt3ElEB8hRrc97fzt09W+SHx/
         BmPSGBBYUlJCA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B647ff8190001>; Wed, 07 Jun 2023 15:23:05 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.26; Wed, 7 Jun 2023 15:23:05 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Wed, 7 Jun 2023 15:23:05 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Wed, 7 Jun 2023 15:23:05 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     Linux Kernel Integrity <linux-integrity@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Lukas Wunner <lukas@wunner.de>,
        "Philipp Rosenberger" <p.rosenberger@kunbus.com>
Subject: Re: New kernel warning after updating from LTS 5.15.110 to 5.15.112
 (and 5.15.113)
Thread-Topic: New kernel warning after updating from LTS 5.15.110 to 5.15.112
 (and 5.15.113)
Thread-Index: AQHZkb4dgnEVWoKsX0S/ux9OJoU4IK9vtwkAgAAJdgCABmNMgIAAAnEAgAYdAQCAAAVSAIABjagAgAAb4YA=
Date:   Wed, 7 Jun 2023 03:23:05 +0000
Message-ID: <68e7cee4-4136-3940-2007-55aa094ff790@alliedtelesis.co.nz>
References: <fe6f7aa0-56c2-3729-ce8c-0f2d943b33f4@alliedtelesis.co.nz>
 <ZHQIFLWvrWUNMVxb@debian.me>
 <6e470461-1a9b-ec51-bac5-f2beb1dc11c9@alliedtelesis.co.nz>
 <2b09d2ed-0852-bbc9-b792-aad92235c7fa@gmail.com>
 <03daca5c-e468-8889-4dc2-e625a664d571@alliedtelesis.co.nz>
 <ec5245bd-3103-f0c7-d3ef-85aabb4d4712@alliedtelesis.co.nz>
 <ZH6TIjXeXJVMvSKa@debian.me>
 <f905141c-1f8e-aec8-470c-19d476e567a3@kunbus.com>
In-Reply-To: <f905141c-1f8e-aec8-470c-19d476e567a3@kunbus.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <245B4319B5B237438F8420C06BF3C7AA@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=CMhUoijD c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=of4jigFt-DYA:10 a=isEt3noMIIeJo3jZBTAA:9 a=QEXdDO2ut3YA:10
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

SGkgTGlubywNCg0KT24gNy8wNi8yMyAxMzo0MywgTGlubyBTYW5maWxpcHBvIHdyb3RlOg0KPiBI
aSBCYWdhcywgaGkgQ2hyaXMNCj4NCj4gT24gMDYuMDYuMjMgMDQ6MDAsIEJhZ2FzIFNhbmpheWEg
d3JvdGU6DQo+DQo+PiBPbiBUdWUsIEp1biAwNiwgMjAyMyBhdCAwMTo0MTowMUFNICswMDAwLCBD
aHJpcyBQYWNraGFtIHdyb3RlOg0KPj4+IEJpc2VjdGluZyBiZXR3ZWVuIHY1LjE1LjExMCBhbmQg
djUuMTUuMTEyIHBvaW50cyB0bw0KPj4+DQo+Pj4gNTExNjJiMDVhNDRjYjVkOThmYjBhZTI1MTlh
ODYwOTEwYTQ3ZmQ0YiBpcyB0aGUgZmlyc3QgYmFkIGNvbW1pdA0KPj4gVGhhbmtzIGZvciB0aGUg
YmlzZWN0aW9uLg0KPj4NCj4+IExpbm8sIGl0IGxvb2tzIGxpa2UgdGhpcyByZWdyZXNzaW9uIGlz
IGNhdXNlZCBieSAoYmFja3BvcnRlZCkgY29tbWl0IG9mIHlvdXJzLg0KPj4gV291bGQgeW91IGxp
a2UgdG8gdGFrZSBhIGxvb2sgb24gaXQ/DQo+Pg0KPiBCZWZvcmUgY29tbWl0IDUxMTYyYjA1YTQ0
YyBpbnRlcnJ1cHQgYWN0aXZhdGlvbiBoYXMgZmFpbGVkIHNpbmNlIHRoZSBjb25jZXJuaW5nIHJl
Z2lzdGVyIHdhcyBhY2Nlc3NlZA0KPiB3aXRob3V0IGhvbGRpbmcgdGhlIHJlcXVpcmVkIGxvY2Fs
aXR5Lg0KPg0KPiBOb3cgd2l0aCB0aGUgY29tbWl0IGFwcGxpZWQgdGhlIGFjdGl2YXRpb24gaXMg
c3VjY2Vzc2Z1bCBhbmQgdGhlIGludGVycnVwdCBoYW5kbGVyIGlzIGNhbGxlZCBhcyBzb29uDQo+
IGFzIGFuIGludGVycnVwdCBmaXJlcy4gSG93ZXZlciB0aGUgaGFuZGxlciBydW5zIGluIGludGVy
cnVwdCBjb250ZXh0IHdoaWxlIHRoZSByZWdpc3RlciBhY2Nlc3Nlcw0KPiBhcmUgZG9uZSB2aWEg
U1BJIHdoaWNoIGludm9sdmVzIHRoZSBTUEkgYnVzX2xvY2tfbXV0ZXguIENhbGxpbmcgdGhlIChz
bGVlcGFibGUpIFNQSSBmdW5jdGlvbnMgaW4NCj4gaW50ZXJydXB0IGNvbnRleHQgcmVzdWx0cyBp
biB0aGUgb2JzZXJ2ZWQgd2FybmluZy4NCj4NCj4gVG8gZml4IHRoaXMgYWRkaXRpb25hbGx5IHVw
c3RyZWFtIGNvbW1pdCAwYzdlNjZlNWZkNjkgKCJ0cG0sIHRwbV90aXM6IFJlcXVlc3QgdGhyZWFk
ZWQgaW50ZXJydXB0IGhhbmRsZXIiKSBpcw0KPiByZXF1aXJlZCwgc2luY2UgaXQgZW5zdXJlcyB0
aGF0IHRoZSBoYW5kbGVyIHJ1bnMgaW4gcHJvY2VzcyBjb250ZXh0Lg0KPg0KPiBOb3RlIHRoYXQg
ZXZlbiB3aXRoIHRoaXMgY29tbWl0IGludGVycnVwdHMgd2lsbCBldmVudHVhbGx5IGJlIGRpc2Fi
bGVkIHNpbmNlIHRoZSB0ZXN0IGZvciBpbnRlcnJ1cHRzDQo+IHN0aWxsIGZhaWxzIChmb3IgdGhl
IHRlc3QgdG8gc3VjY2VlZCBhdCBsZWFzdCB1cHN0cmVhbSBjb21taXQgZTY0NGIyZjQ5OGQyICJ0
cG0sIHRwbV90aXM6IEVuYWJsZSBpbnRlcnJ1cHQgdGVzdCINCj4gd291bGQgYmUgcmVxdWlyZWQp
Lg0KPg0KPiBDaHJpcywgY291bGQgeW91IHRlc3QgYWdhaW4gd2l0aCBjb21taXQgMGM3ZTY2ZTVm
ZDY5IGFkZGl0aW9uYWxseSBhcHBsaWVkIGFuZCBjb25maXJtIHRoYXQgdGhlIHdhcm5pbmcgaXMg
Z29uZT8NCg0KWWVzIHdpdGggMGM3ZTY2ZTVmZDY5IGNoZXJyeS1waWNrZWQgb24gdG9wIHRoZSB3
YXJuaW5nIGdvZXMgYXdheS4gQWRkaW5nIA0KZTY0NGIyZjQ5OGQyIGRvZXNuJ3Qgc2VlbSB0byBj
aGFuZ2UgYW55dGhpbmcgKHN0aWxsIHJlcG9ydHMgdGhhdCANCmludGVycnVwdHMgYXJlbid0IHdv
cmtpbmcpIGJ1dCB0aGF0J3MgdGhlIHNhbWUgYXMgdGhlIGxhdGVzdCBtYWlubGluZSBvbiANCnRo
aXMgaGFyZHdhcmUuDQo=
