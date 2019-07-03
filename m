Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1652C5E0C2
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2019 11:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfGCJQt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Jul 2019 05:16:49 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:34345 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727296AbfGCJQs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Jul 2019 05:16:48 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-215-p55ghHJYOB6dt1vkY_MCpA-1; Wed, 03 Jul 2019 10:16:45 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 3 Jul 2019 10:16:45 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 3 Jul 2019 10:16:45 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Markus Elfring' <Markus.Elfring@web.de>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] ima: Replace two seq_printf() calls by seq_puts() in
 ima_show_template_data_ascii()
Thread-Topic: [PATCH] ima: Replace two seq_printf() calls by seq_puts() in
 ima_show_template_data_ascii()
Thread-Index: AQHVMQh6dLT9GyunYEy+ElDVTeXJmqa4nMYA
Date:   Wed, 3 Jul 2019 09:16:44 +0000
Message-ID: <d94bfdb9d53b46059787b9bdd10c5919@AcuMS.aculab.com>
References: <e96eac40-0745-80b5-6aab-f872e6415031@web.de>
In-Reply-To: <e96eac40-0745-80b5-6aab-f872e6415031@web.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: p55ghHJYOB6dt1vkY_MCpA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogIE1hcmt1cyBFbGZyaW5nDQo+IFNlbnQ6IDAyIEp1bHkgMjAxOSAyMDowMQ0KPiANCj4g
RnJvbTogTWFya3VzIEVsZnJpbmcgPGVsZnJpbmdAdXNlcnMuc291cmNlZm9yZ2UubmV0Pg0KPiBE
YXRlOiBUdWUsIDIgSnVsIDIwMTkgMjA6NTI6MjEgKzAyMDANCj4gDQo+IFR3byBzdHJpbmdzIHdo
aWNoIGRpZCBub3QgY29udGFpbiBhIGRhdGEgZm9ybWF0IHNwZWNpZmljYXRpb24gc2hvdWxkIGJl
IHB1dA0KPiBpbnRvIGEgc2VxdWVuY2UuIFRodXMgdXNlIHRoZSBjb3JyZXNwb25kaW5nIGZ1bmN0
aW9uIOKAnHNlcV9wdXRz4oCdLg0KPiANCj4gVGhpcyBpc3N1ZSB3YXMgZGV0ZWN0ZWQgYnkgdXNp
bmcgdGhlIENvY2NpbmVsbGUgc29mdHdhcmUuDQoNClRoZSB0d28gY2FsbHMgYXJlIGFsbW9zdCBj
ZXJ0YWlubHkgYWJzb2x1dGVseSBlcXVpdmFsZW50Lg0KU28gdGhpcyBpcyBwcm9iYWJseSBqdXN0
IGEgbWlub3IgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQgaW4gYSBjb2RlDQpwYXRoIHdoZXJlIGl0
IHJlYWxseSBkb2Vzbid0IG1hdHRlci4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJrdXMgRWxmcmlu
ZyA8ZWxmcmluZ0B1c2Vycy5zb3VyY2Vmb3JnZS5uZXQ+DQo+IC0tLQ0KPiAgc2VjdXJpdHkvaW50
ZWdyaXR5L2ltYS9pbWFfdGVtcGxhdGVfbGliLmMgfCA0ICsrLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvc2Vj
dXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfdGVtcGxhdGVfbGliLmMgYi9zZWN1cml0eS9pbnRlZ3Jp
dHkvaW1hL2ltYV90ZW1wbGF0ZV9saWIuYw0KPiBpbmRleCA5ZmUwZWY3ZjkxZTIuLjA1NjM2ZTli
MTliMSAxMDA2NDQNCj4gLS0tIGEvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfdGVtcGxhdGVf
bGliLmMNCj4gKysrIGIvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfdGVtcGxhdGVfbGliLmMN
Cj4gQEAgLTc0LDcgKzc0LDcgQEAgc3RhdGljIHZvaWQgaW1hX3Nob3dfdGVtcGxhdGVfZGF0YV9h
c2NpaShzdHJ1Y3Qgc2VxX2ZpbGUgKm0sDQo+ICAJY2FzZSBEQVRBX0ZNVF9ESUdFU1RfV0lUSF9B
TEdPOg0KPiAgCQlidWZfcHRyID0gc3RybmNocihmaWVsZF9kYXRhLT5kYXRhLCBidWZsZW4sICc6
Jyk7DQo+ICAJCWlmIChidWZfcHRyICE9IGZpZWxkX2RhdGEtPmRhdGEpDQo+IC0JCQlzZXFfcHJp
bnRmKG0sICIlcyIsIGZpZWxkX2RhdGEtPmRhdGEpOw0KPiArCQkJc2VxX3B1dHMobSwgZmllbGRf
ZGF0YS0+ZGF0YSk7DQo+IA0KPiAgCQkvKiBza2lwICc6JyBhbmQgJ1wwJyAqLw0KPiAgCQlidWZf
cHRyICs9IDI7DQoNClRoYXQgY29kZSBsb29rcyBoaWdobHkgc3VzcGVjdCENCkl0IHVzZXMgYSBi
b3VuZGVkIHNjYW4gdGhlbiBhc3N1bWVzIGEgJ1wwJyB0ZXJtaW5hdGVkIHN0cmluZy4NCkl0IHRo
ZW4gYWRkcyAyIHRvIGEgcG90ZW50aWFsbHkgTlVMTCBwb2ludGVyLg0KDQpBYm91dCB0eXBpY2Fs
IGZvciAnc2VjdXJpdHknIGNvZGUgOi0pDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJl
c3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsx
IDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

