Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B48A31D13C
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Feb 2021 20:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhBPTzq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Feb 2021 14:55:46 -0500
Received: from mout.gmx.net ([212.227.17.20]:46271 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbhBPTzq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Feb 2021 14:55:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613505245;
        bh=sKkr2LLsp31ybzVvhuzZEzxd7uLtbzsp6tlD9ICKQTk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Pt151KRTaTTQ2IT47owrpRkmSJ67Q5SBvUY96iy9tESF/v72HGyVXy7je6QLCkW3M
         gJ/w+dHC+YeBZCQ/pz57FdbtxK2Wpen7hmA/AUMZm25F2+p6pia3vcehp8TJ0D/ewH
         rwWocKTPVC7djajEMo6/n0TKQGyOlzO0FCJiez0I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([78.42.220.31]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Ygt-1lAjdm1c1z-0038ns; Tue, 16
 Feb 2021 20:54:05 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, James.Bottomley@hansenpartnership.com,
        David.Laight@ACULAB.COM, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, LinoSanfilippo@gmx.de
Subject: [PATCH RESEND v5] TPM fixes
Date:   Tue, 16 Feb 2021 20:53:10 +0100
Message-Id: <1613505191-4602-1-git-send-email-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:imbFJcgnVUP1pz8geMCZSgfP3CnwehxM1NSTVkhLXGDLGSpTCXx
 B9LF5MjXUJhYCDvny6fTAkehKtInoFhntvwuiV5sLNL/pYMMcH2Npsu7nDGJZsR4OKRsBzD
 YhOArNQg/F7L3c9h8lF4GCEc6Dq2OibgnlU/bldn8IX3BBBmCNWZ1SnxDOGjJblBOcvIrCP
 c9TbgGLYkEoivskHWtnIQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lPJrq1jQ4IY=:IVP/D5+V/i9hbiU8+ARbYE
 Ptk1azAkyWehZFMc4bmoKTPOd3csQy4HcZQBiBFPxH1dpF0HBAwGai+C4NFIK13Bxw5+ttlg8
 LlMe9zXdVw7Sps5TT6w0cUk0S+cGgN6eeLQr56Pbur8736boPcOg4+Mux8+v1GdpC8jcuXb+6
 jO5fgj64Xna2M/by7AGkntdnKIB9PvzZYLQjUg8Km06peckngFvqUiAAs7npoX22BXbQDR1fq
 4BcSl9fCfaZhhDlkdqZikOvVDAWXZLsleWwjEkCY85cN8Iv9wNTLDmOCH0sAaBg3KraHhBFQH
 mIqUFTgMUZKuqXAFnua8EJo8HQ5HRwBqxzDYCwQy5CEk2KnA8Pzj3rr8KgmSenaApXr3gCcq+
 tX9YbHxK33rT8Oy5yw7ld/JNAJpGB+PRRMly4IlQErfCXNiE5mmuJUA3pXZ/3pYb4lANjWEaK
 gxwJEB76ekj4cSxj//2C6IzBDTYBjk2lreW2Fa43MWzGr2xHsIo0nIdHv7kpc5XHbpq10ABv8
 dKjbaLPOFAjBwMalwOG98+Uu0q9+/V6dXOCxwZcX25KXCUu1NR8UJDNewOdr34a6okUDDyL4b
 N+umvlZ9qeMZHUJfh5tAWA39Zc5NZBZL7V4VCFGqtmiwO/ftiS4xd4fkQeurfiS9Gpke7H7in
 v5obHT4KyeUjmT+t9nDsy3srH7CUuePN/w28LbCNjfoJ97wAKoZ3KRef3rOgikvmZaTa38nfY
 X3qA/rC9X2cdeVG4y7gebRhoTsRhAddMFnMmvoyoqrbRgYT0Ip35foQSD/ANknF55G6gQXT7Q
 EqqyooRL9pJ9FR2STgbPKO6Sfl4DEKFFYIWEUFmrfaDWQ6BSMv9CZKnU+n0uTRLDJoZVjcIt+
 cA1wBC54EMv2Aw1MUoTw==
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
IGZpeGVzIHRhZ3MgYW5kIGtlcm5lbCBsb2dzCgoKCkxpbm8gU2FuZmlsaXBwbyAoMSk6CiAgdHBt
OiBmaXggcmVmZXJlbmNlIGNvdW50aW5nIGZvciBzdHJ1Y3QgdHBtX2NoaXAKCiBkcml2ZXJzL2No
YXIvdHBtL3RwbS1jaGlwLmMgICB8IDQ4ICsrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0KIGRyaXZlcnMvY2hhci90cG0vdHBtLmggICAgICAgIHwgIDEgKwogZHJpdmVy
cy9jaGFyL3RwbS90cG0yLXNwYWNlLmMgfCA0OCArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDU5IGluc2VydGlvbnMoKyksIDM4IGRl
bGV0aW9ucygtKQoKLS0gCjIuNy40Cgo=
