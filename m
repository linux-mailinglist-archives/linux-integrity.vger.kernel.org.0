Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F47431D11B
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Feb 2021 20:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhBPTod (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Feb 2021 14:44:33 -0500
Received: from mout.gmx.net ([212.227.17.22]:52153 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229725AbhBPToc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Feb 2021 14:44:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613504567;
        bh=Eqv2QUEAozP3I/FQI3fOmKajoqJINH8Kd4aFH/KVP+Y=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Kmugg4Ea1XthPmOH+6BtSUAoSx7jmt7ihNMw2tsdnI+j8HpQ5F+wR4ZzyvoTam5Xs
         Pz21INTb3FhNeA5MYqUaH79ehD1og4flBUB53fvsLaI74+Wf1AUWcPEUxrMZ7W3LBK
         96dLiR6zhPFFGWCD7mk70OcsUilolAsHK5SN8Bl0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([78.42.220.31]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mq2nK-1lhZQr2ck6-00n73n; Tue, 16
 Feb 2021 20:42:47 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, James.Bottomley@hansenpartnership.com,
        David.Laight@ACULAB.COM, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, LinoSanfilippo@gmx.de
Subject: [PATCH v5] TPM fixes
Date:   Tue, 16 Feb 2021 20:42:11 +0100
Message-Id: <1613504532-4165-1-git-send-email-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:ES2jq1IW26IylgG+p24A/D6Pg2+XVKkwbMMXdY+ZdLLcY1ZqNVO
 L31m+XLxsNS6vKHrKoDrTXAhnwDS3fdTOuT85f4J5yQOq1fD4q++HEEFaPLWwl2pSzsqlg9
 YV8LKkYSLnRydUjhSv0sq+zwFS4Yr4sLLtMaVEUQYDbLuxxC5+XHTahQUGty35kGMaKSucc
 gh5s7TlpCKI12Hixv/aeA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6oYfJCKHi0M=:TP9sY03oElfmXMEsM4Boz1
 J2r7kVgSvvnavPm+Ro8NGj5MFmvFplTCoMV1DRDleopVL3UWg/eGE22cb+DHnNMCsiZKxyxzU
 Ghh46mXuEuuhrLG8Rc2cfUSPMF3T+bpF2dVJDKWWSbgP4Q2VpVHdqoGmtA31legA4buMj9kui
 xSF2ay7NL3DF6zjXniHWbWa1yd4AzH5LMy3YJXlNUviSwFtSWAK2u/Lb+XPmPhx/b2ebYdS0r
 YsIlSAdqS4D8iZryFoFXq+/ScOZ3nTri2qHDjC2ykxUDDgoGdrszCaX8GqSCV6dX+5Dop2+zj
 R9stVlBWFrxKdKO4ndoiOVwi84aim2GpLFKeK2lRQKsShaC2DKcr+2O+zkKKEX3JgVTTSn4v9
 8AY0UpWnZ5ZUiZZrDjo5xcX2m5PFHbPw0I//2QieVNfFlLiVWj/YXoHmX/vdNHg4HQta46qt+
 fqlo44LoiMZfrF0lJqfoMlP6YVLfdrKk4ABaZtK3qwz7/QknLWMiJq3KjKH4o4JpdrXBoZKY9
 Tbw6nlQZ+XC65iVqFV+2T0DhmnS79UWEfuhEhKCjCfFQ3bL3CQyfdV6X3f58QHEIW/Y+7Rrkr
 IcB6Yq3clHgjA22CTogutch3KXNFEOSs/N+QA2Ekod5nQa8aFk6n7QpkbybkO5zcWiTWdDUrW
 Lzlwy7z/SS7xfj+6sS0SQvUt1P55JITLKqdWTLqTJJKRo+TY3kNYdfCppUEA5eiWw+qXJSZKP
 NMpOsA4UI2Le7G/cDEZElNtauHaZgcc4Yi4QvQwVqt0NpVVd9kzAiPOWVmKCWOlLhsdK/dU9a
 Mz2N6Ix3irdvZS+5WYyIy/Tw3FRQNuUbueE/gQ8a3M3hW4vT9G70i461fxwDFGSBmHJ3hht/I
 rWgtsDnQZKarKGVtyFJg==
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

VGhpcyBwYXRjaCBmaXhlcyBhIHJlZmVyZW5jZSBjb3VudCBpc3N1ZSBpbiB0aGUgVFBNIGNvcmUg
Y29kZS4KCkNoYW5nZXMgaW4gdjUKLSBtb3ZlIGZ1bmN0aW9uIHRwbV9hZGRfdHBtMl9jaGFyX2Rl
dmljZSgpIHRvIHRwbTItc3BhY2UuYyBhbmQgcmVuYW1lCml0IHRvIHRwbTJfYWRkX2RldmljZSgp
IGFzIHJlcXVlc3RlZCBieSBKYXJrbwotIHB1dCAiY2MiIHRhZyBiZWZvcmUgYWxsIG90aGVyIHRh
Z3MgCi0gZW5zdXJlIHRoYXQgdGhlIGVycm9yIHBhdGggaW4gdHBtMl9hZGRfZGV2aWNlKCkgYWx3
YXlzIGNhbGxzIAp0aGUgcmVsZWFzZSgpIGZ1bmN0aW9uIG9mIGNoaXAtPmRldnMgYXMgcmVxdWVz
dGVkIGJ5IEphc29uCi0gcmVmb3JtYXQgYSBjb2RlIGxpbmUgYXMgc3VnZ2VzdGVkIGJ5IERhdmlk
IExhaWdodAoKQ2hhbmdlcyBpbiB2NAotIGRyb3AgcGF0Y2ggMiAodHBtOiBpbiB0cG0yX2RlbF9z
cGFjZSBjaGVjayBpZiBvcHMgcG9pbnRlciBpcyBzdGlsbAp2YWxpZCkgc2luY2UgSmFtZXMgQm90
dG9tbGV5IG9mZmVyZWQgYSBjbGVhbmVyIHNvbHV0aW9uIGZvciB0aGlzCi0gcmVpbXBsZW1lbnQg
cGF0Y2ggMSB0byBzZXR1cCB0aGUgL2Rldi90cG1ybSBkZXZpY2Ugb25seSBpbiBjYXNlIG9mIFRQ
TTIKYW5kIGF2b2lkIHRoZSBpbnN0YWxsYXRpb24gb2YgYW5vdGhlciBhY3Rpb24gaGFuZGxlci4g
VGhpcyBpcyBiYXNlZCBvbiBhCnN1Z2dlc3Rpb24gYW5kIGJhc2ljIGltcGxlbWVudGF0aW9uIGRv
bmUgYnkgSmFzb24gR3VudGhvcnBlLgotIGFkZGVkIHRhZyB0byBDQyBzdGFibGUKCkNoYW5nZXMg
aW4gdjMKLSBkcm9wIHRoZSBwYXRjaCB0aGF0IGludHJvZHVjZXMgdGhlIG5ldyBmdW5jdGlvbiB0
cG1fY2hpcF9mcmVlKCkKLSByZXdvcmsgdGhlIGNvbW1pdCBtZXNzYWdlcyBmb3IgdGhlIHBhdGNo
ZXMgKHN0eWxlLCB0eXBvcywgZXRjLikKLSBhZGQgZml4ZXMgdGFnIHRvIHBhdGNoIDIKLSBhZGQg
SmFtZXMgQm90dG9tbGV5IHRvIGNjIGxpc3QKLSBhZGQgc3RhYmxlIG1haWxpbmcgbGlzdCB0byBj
YyBsaXN0CgpDaGFuZ2VzIGluIHYyOgotIGRyb3AgdGhlIHBhdGNoIHRoYXQgZXJyb25lb3VzbHkg
Y2xlYW5lZCB1cCBhZnRlciBmYWlsZWQgaW5zdGFsbGF0aW9uIG9mCiAgYW4gYWN0aW9uIGhhbmRs
ZXIgaW4gdHBtbV9jaGlwX2FsbG9jKCkgKHBvaW50ZWQgb3V0IGJ5IEphcmtrbyBTYWtraW5lbikK
LSBtYWtlIHRoZSBjb21taXQgbWVzc2FnZSBmb3IgcGF0Y2ggMSBtb3JlIGRldGFpbGVkCi0gYWRk
IGZpeGVzIHRhZ3MgYW5kIGtlcm5lbCBsb2dzCgoKTGlubyBTYW5maWxpcHBvICgxKToKICBUaGUg
Zm9sbG93aW5nIHNlcXVlbmNlIG9mIG9wZXJhdGlvbnMgcmVzdWx0cyBpbiBhIHJlZmNvdW50IHdh
cm5pbmc6CgogZHJpdmVycy9jaGFyL3RwbS90cG0tY2hpcC5jICAgfCA0OCArKysrKysrKystLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiBkcml2ZXJzL2NoYXIvdHBtL3RwbS5oICAg
ICAgICB8ICAxICsKIGRyaXZlcnMvY2hhci90cG0vdHBtMi1zcGFjZS5jIHwgNDggKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCA1OSBp
bnNlcnRpb25zKCspLCAzOCBkZWxldGlvbnMoLSkKCi0tIAoyLjcuNAoK
