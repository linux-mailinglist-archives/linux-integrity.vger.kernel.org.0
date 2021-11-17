Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CD445426C
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Nov 2021 09:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbhKQINV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Nov 2021 03:13:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:55710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232086AbhKQINV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Nov 2021 03:13:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A970D61B7D;
        Wed, 17 Nov 2021 08:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637136623;
        bh=r95Z+70f1SxANDfTBZzjaeB9B3eWiVZJu26oU6UqTm8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jzK9va+Hbe2/5w6dtqZcck3jrN6+Uoi/rIiYnVzZD0f1gE8MPIqO9hleJ7aTMquvg
         S+fpeodj1jERXc5vQNt9suP08x1sTEZuBjYf7Q4IRH7E9HHacG/g4Ay+e/MTkSmFCO
         0Iu+c+GYTogBJ4RfaH4QmFC/XT9IXNeVAA98bFj/mCEtwWSg5Kad59PUusa9WPjaff
         EPXfajoX1kVeo9G7I6hqcanqSuNm9NqNybdu3doO069b3WUnv1wb6drsSMKeaBnL17
         aJuDSyWE7vamtBFo0FMnTWRTvt6r93FV5Wb2xHB1YckGdWKsLrvK2TnINf1QjebbLs
         GP0xUEt+hBJEA==
Message-ID: <fd914758628f416db9fbaa35e910cceedabb65f7.camel@kernel.org>
Subject: Re: [PATCH v19 3/5] tpm: tpm_tis: Verify TPM_STS register is valid
 after locality request
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     amirmizi6@gmail.com, Eyal.Cohen@nuvoton.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org,
        benoit.houyere@st.com, eajames@linux.ibm.com, joel@jms.id.au
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com
Date:   Wed, 17 Nov 2021 10:10:20 +0200
In-Reply-To: <20211104140211.6258-4-amirmizi6@gmail.com>
References: <20211104140211.6258-1-amirmizi6@gmail.com>
         <20211104140211.6258-4-amirmizi6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

T24gVGh1LCAyMDIxLTExLTA0IGF0IDE2OjAyICswMjAwLCBhbWlybWl6aTZAZ21haWwuY29tIHdy
b3RlOgo+IEZyb206IEFtaXIgTWl6aW5za2kgPGFtaXJtaXppNkBnbWFpbC5jb20+Cj4gCj4gQW4g
aW52YWxpZCBUUE1fU1RTIHZhbHVlIGNvdWxkIGJlIHVzZWQgd2hlbiB0aGUgZm9sbG93aW5nIHR3
byBldmVudHMgb2NjdXI6Cj4gVFBNIGRvZXMgbm90IHVwZGF0ZSBUUE1fU1RTIHJlZ2lzdGVyIGFm
dGVyIGEgbG9jYWxpdHkgcmVxdWVzdCAoVFBNX1NUUwo+IEluaXRpYWwgdmFsdWUgPSAweEZGKSwg
YW5kIGEgVFBNX1NUUyByZWdpc3RlciByZWFkIG9jY3VycyBpbiB0aGUKPiB0cG1fdGlzX3N0YXR1
cyhjaGlwKSBmdW5jdGlvbiBjYWxsLgo+IAo+IEluIHByb2JlX2l0cG0oKSwgYSBjYWxsIHRvIHRw
bV90aXNfc2VuZF9kYXRhKCkgZnVuY3Rpb24gaXMgbWFkZSBhZnRlciBhCj4gcmVxdWVzdF9sb2Nh
bGl0eSgpIGNhbGwsIGFuZCB0aGUgY29uZGl0aW9uCj4gKCJpZiAoKHN0YXR1cyAmIFRQTV9TVFNf
Q09NTUFORF9SRUFEWSkgPT0gMCkiKSBpcyBjaGVja2VkLiBBdCB0aGlzIG1vbWVudAo+IGlmIHRo
ZSBzdGF0dXMgdmFsdWUgaXMgMHhGRiwgdGhlbiBpdCBpcyBjb25zaWRlcmVkLCB3cm9uZ2x5LCBp
biDigJxyZWFkeeKAnQo+IHN0YXRlIChieSBjaGVja2luZyBvbmx5IG9uZSBiaXQpLiBIb3dldmVy
LCBhdCB0aGlzIG1vbWVudCB0aGUgVFBNIGlzLCBpbgo+IGZhY3QsIGluICJJZGxlIiBzdGF0ZSBh
bmQgcmVtYWlucyBpbiAiSWRsZSIgc3RhdGUgYmVjYXVzZQo+ICJ0cG1fdGlzX3JlYWR5KGNoaXAp
OyIgd2FzIG5vdCBleGVjdXRlZC4KPiBXYWl0aW5nIGZvciB0aGUgY29uZGl0aW9uIFRQTV9TVFMu
dHBtR28gPT0gMCwgd2lsbCBlbnN1cmUgdGhhdCB0aGUgVFBNCj4gc3RhdHVzIHJlZ2lzdGVyIGhh
cyB0aGUgY29ycmVjdCB2YWx1ZS4KCllvdSBzaG91bGQgdXNlIGltcGVyYXRpdmUgZm9ybSBpbiBj
b21taXQgbWVzc2FnZSwgZS5nLiAiV2FpdCBmb3IgVFBNX1NUUy50cG1Hbwp0byByZXNldCB0byB6
ZXJvLCAuLi4iLgoKPiAKPiBTdWdnZXN0ZWQtYnk6IEJlbm9pdCBIb3V5ZXJlIDxiZW5vaXQuaG91
eWVyZUBzdC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogQW1pciBNaXppbnNraSA8YW1pcm1pemk2QGdt
YWlsLmNvbT4KPiAtLS0KPiDCoGRyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMgfCA2ICsr
KysrLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+
IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jIGIvZHJpdmVy
cy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwo+IGluZGV4IDZmZjhiNDQuLjc3MDY4NWEgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwo+ICsrKyBiL2RyaXZlcnMv
Y2hhci90cG0vdHBtX3Rpc19jb3JlLmMKPiBAQCAtMTc3LDggKzE3NywxMiBAQCBzdGF0aWMgaW50
IHJlcXVlc3RfbG9jYWxpdHkoc3RydWN0IHRwbV9jaGlwICpjaGlwLCBpbnQgbCkKPiDCoMKgwqDC
oMKgwqDCoMKgfSBlbHNlIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qIHdh
aXQgZm9yIGJ1cnN0Y291bnQgKi8KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRv
IHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChj
aGVja19sb2NhbGl0eShjaGlwLCBsKSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGlmIChjaGVja19sb2NhbGl0eShjaGlwLCBsKSkgewo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlm
ICh0cG1fdGlzX3dhaXRfZm9yX3N0YXQoY2hpcCwgVFBNX1NUU19HTywgMCwgY2hpcC0+dGltZW91
dF9jLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICZwcml2LT5pbnRfcXVldWUsIGZhbHNlKSA8IDApCgpZb3Ugd291bGQgbmVlZCB0byBl
eHBsYWluIHRoaXMgd2l0aCBhbiBpbmxpbmUgY29tbWVudC4KCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJldHVybiAtRVRJTUU7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBsOwo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRwbV9tc2xlZXAoVFBNX1RJTUVPVVQpOwo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfSB3aGlsZSAodGltZV9iZWZvcmUoamlmZmllcywg
c3RvcCkpOwo+IMKgwqDCoMKgwqDCoMKgwqB9CgoKL0phcmtrbwoK

