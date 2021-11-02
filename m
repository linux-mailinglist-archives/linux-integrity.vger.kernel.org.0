Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F784443762
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Nov 2021 21:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhKBUhj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Nov 2021 16:37:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229764AbhKBUhj (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Nov 2021 16:37:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 389DC604DA;
        Tue,  2 Nov 2021 20:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635885303;
        bh=dMj/G2/V3965WnIMSNeXebG24HMfcXKI7dEgO0/HkAY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YmLcjg3loMFRRSdbOBa3hE9vhMNkD2Z1JTqg2XSbU1Bro3PC/Qlp01acm7yVWpyHF
         Yh9q0CBv6AIkNSiwW11YJJzTaVsY7Hw5rrYeN1MKieglhIiKIIx7R0z3u9bXrcYhes
         PEpHZAXD2AmQP3XFQXGLTM8/Mcc9kkWlhYm4CIxvtVzRr4hzxo7fIR7Cp6PGE+6LmW
         eeZKiT6vJhtYkM4cKM4CpwOIxApxRh1AXKdRfGMCnqeZ5mHSo/g8cc08JmkMyKxO9b
         ob6sozrVnh50WMbgUODOJGgoZh+GNmIdgoh3SAVL5ZueakdCVWtSYgQ5nFoXXTzd0Z
         +w7MZuwujx7rA==
Message-ID: <c66fe7d58cd2cd0b988b49ac688ddea58826bba5.camel@kernel.org>
Subject: Re: [PATCH v18 4/6] tpm: tpm_tis: Verify TPM_STS register is valid
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
Date:   Tue, 02 Nov 2021 22:35:01 +0200
In-Reply-To: <20211102152056.241769-5-amirmizi6@gmail.com>
References: <20211102152056.241769-1-amirmizi6@gmail.com>
         <20211102152056.241769-5-amirmizi6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

T24gVHVlLCAyMDIxLTExLTAyIGF0IDE3OjIwICswMjAwLCBhbWlybWl6aTZAZ21haWwuY29tIHdy
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
cyB0aGUgY29ycmVjdCB2YWx1ZS4KPiAKPiBTdWdnZXN0ZWQtYnk6IEJlbm9pdCBIb3V5ZXJlIDxi
ZW5vaXQuaG91eWVyZUBzdC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogQW1pciBNaXppbnNraSA8YW1p
cm1pemk2QGdtYWlsLmNvbT4KPiAtLS0KPiDCoGRyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3Jl
LmMgfCA4ICsrKysrKystCj4gwqAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3Jl
LmMgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCj4gaW5kZXggOTBkOTJhMS4uZjA2
YzZjNiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCj4gKysr
IGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwo+IEBAIC0xNzcsOCArMTc3LDE0IEBA
IHN0YXRpYyBpbnQgcmVxdWVzdF9sb2NhbGl0eShzdHJ1Y3QgdHBtX2NoaXAgKmNoaXAsIGludCBs
KQo+IMKgwqDCoMKgwqDCoMKgwqB9IGVsc2Ugewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgLyogd2FpdCBmb3IgYnVyc3Rjb3VudCAqLwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgZG8gewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgaWYgKGNoZWNrX2xvY2FsaXR5KGNoaXAsIGwpKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGNoZWNrX2xvY2FsaXR5KGNoaXAsIGwpKSB7
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgaWYgKHdhaXRfZm9yX3RwbV9zdGF0KGNoaXAsIFRQTV9TVFNfR08sIDAsCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2hp
cC0+dGltZW91dF9jLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICZwcml2LT5pbnRfcXVldWUsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmFsc2UpIDwgMCkKCkRvZXMgdGhp
cyBjb21waWxlIHdpdGggdGhlIGNoYW5nZSBpbiAxLzY/CgovSmFya2tvCgo=

