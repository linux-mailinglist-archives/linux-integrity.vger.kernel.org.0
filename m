Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C8E31F114
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Feb 2021 21:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhBRUeV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Feb 2021 15:34:21 -0500
Received: from mout.gmx.net ([212.227.15.18]:41749 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231146AbhBRUdq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Feb 2021 15:33:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613680219;
        bh=Rv2QiztmGCI/+aVrwY7N4QY4dBUgpjxiaRS6N+iq1MY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=E2gpjhJH7SEnFPlTBjlgR8M1XnLhdkYJT7Nw4mA/s37pwz3lpkcCGvzbOxrxt5oGp
         lEcKLiJxjx/+FP10zxJR64WL/U1jkvl2SacrZXRTTNU2eplB65bHFEExQsBsv12L58
         pwTaqOZblJ6/aVWsOlfp3b9u56/j/u204+fx0s1A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([78.42.220.31]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5mKP-1lwaw402nL-017Dn6; Thu, 18
 Feb 2021 21:30:19 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, James.Bottomley@hansenpartnership.com,
        David.Laight@ACULAB.COM, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, LinoSanfilippo@gmx.de
Subject: [PATCH v6] TPM fixes
Date:   Thu, 18 Feb 2021 21:29:40 +0100
Message-Id: <1613680181-31920-1-git-send-email-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:XiwFUIsOpBG2o2szLGEPHBKzlWyo836qvtDDLOGT0jKoN4noArT
 HGpeksKMd3vkLSUsTq1v4EULrip0K3QvBCwerJZStwiYBufsoEoBbRs2c0bOPrAd2Iu7zSy
 ybDzbYdSr6emdcLe60FmaWvIJ+sCmaFGrLMdV+zuqy1M2e8excBgOrtvJq0RGluTAhwlT/Y
 PXEMjVxW0l/8Fb0+6r36g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:m81jPigrf5M=:sPZZdSw+p9ZNN01moB3TV+
 /nGOgMXJ+7XNd0ObKFVKP3i4Xr4F6Tx9x4Bku+A1+Dw9kUJOXuh6jAXmrvUWqi8+8TKl09k8a
 ZxKY2q0QTvxQ3kz7XtHK3FQ0wFypncbkjzsOoT/s64qe+bSU9XS5bTWyIsmT1nLCrMGvHiQzl
 +kyuG0KM0fnQR7b2na1U3l8aXKuD09m2J0xsvGr+6D/6VJJh6jRkD67Yvkm1JzhUusYSE562R
 U7jHfSriuAuPmYFos1zu0SqE3MBDPAsbEg1e0E5ip23PZrFa4k3v2/kOQRBJ5oPHi0MEwYml5
 rCNHeXp3fL2ZT2Q+TqokCG1dTwwuxJjCCXiifT5U5rTSzqkdCsTI+GVnzvTwpBQElt6ke8nZ8
 FiuZEAciGqwiUS+KnVuHo6I50DKu39x1hiPAhuHm8ZDB7jPGwRBV8m0ckwvm7HniQdyJplDRe
 U5eaYXhNy3xicceGflHxZNcAWotIQIVysStjKoUkwAm+GMZYuVRDD8/o2Ygveet9MpRHiayVC
 bGeC7LiMnxhslqHjS59zClODwQsbgsvYZfuARuX7gviwZ7QEuqyNuRepdW1PASQVIg6LcqL5l
 Oy0O+Il57KPDwkwlUXvr8rAURnlK9dOUMvQha3f9ElsTG9IhVZ7ll5ivyWiEC4LfAoI2Trbj0
 DBblcVZpItVJGWUGLnVeybiNqwT2UgdliD/mVo43wOI/sQxhEh3IJe3/uex7Pgknd+6yVzUml
 lCZU0w9KF7+V9ZpVROwzBj41r2M++ffXP22AzvuhdxH0KUQiLhx0gUPlcHscF2HVFzEm9flsp
 N0+y4A+WbhXq5CfgNNppl68Aji8ORCKwcknnRiJihoPjkPNFloLfkUi9VwUQD8T+e6EZCeYlD
 Ag7b9KwuxU587D9zxcJg==
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

VGhpcyBwYXRjaCBmaXhlcyBhIHJlZmVyZW5jZSBjb3VudCBpc3N1ZSBpbiB0aGUgVFBNIGNvcmUg
Y29kZS4KCkNoYW5nZXMgaW4gdjY6Ci0gcmVuYW1lIGZ1bmN0aW9uIHRwbTJfYWRkX2RldmljZSgp
IHRvIHRwbV9kZXZzX2FkZCgpIGFzIHJlcXVlc3RlZCBieSBKYXJrbwotIGFkZCBmdW5jdGlvbiBk
ZXNjcmlwdGlvbnMKLSBmaXggc291cmNlIGNvZGUgZm9ybWF0dGluZwoKQ2hhbmdlcyBpbiB2NToK
LSBtb3ZlIGZ1bmN0aW9uIHRwbV9hZGRfdHBtMl9jaGFyX2RldmljZSgpIHRvIHRwbTItc3BhY2Uu
YyBhbmQgcmVuYW1lCml0IHRvIHRwbTJfYWRkX2RldmljZSgpIGFzIHJlcXVlc3RlZCBieSBKYXJr
bwotIHB1dCAiY2MiIHRhZyBiZWZvcmUgYWxsIG90aGVyIHRhZ3MgCi0gZW5zdXJlIHRoYXQgdGhl
IGVycm9yIHBhdGggaW4gdHBtMl9hZGRfZGV2aWNlKCkgYWx3YXlzIGNhbGxzIAp0aGUgcmVsZWFz
ZSgpIGZ1bmN0aW9uIG9mIGNoaXAtPmRldnMgYXMgcmVxdWVzdGVkIGJ5IEphc29uCi0gcmVmb3Jt
YXQgYSBjb2RlIGxpbmUgYXMgc3VnZ2VzdGVkIGJ5IERhdmlkIExhaWdodAoKQ2hhbmdlcyBpbiB2
NDoKLSBkcm9wIHBhdGNoIDIgKHRwbTogaW4gdHBtMl9kZWxfc3BhY2UgY2hlY2sgaWYgb3BzIHBv
aW50ZXIgaXMgc3RpbGwKdmFsaWQpIHNpbmNlIEphbWVzIEJvdHRvbWxleSBvZmZlcmVkIGEgY2xl
YW5lciBzb2x1dGlvbiBmb3IgdGhpcwotIHJlaW1wbGVtZW50IHBhdGNoIDEgdG8gc2V0dXAgdGhl
IC9kZXYvdHBtcm0gZGV2aWNlIG9ubHkgaW4gY2FzZSBvZiBUUE0yCmFuZCBhdm9pZCB0aGUgaW5z
dGFsbGF0aW9uIG9mIGFub3RoZXIgYWN0aW9uIGhhbmRsZXIuIFRoaXMgaXMgYmFzZWQgb24gYQpz
dWdnZXN0aW9uIGFuZCBiYXNpYyBpbXBsZW1lbnRhdGlvbiBkb25lIGJ5IEphc29uIEd1bnRob3Jw
ZS4KLSBhZGRlZCB0YWcgdG8gQ0Mgc3RhYmxlCgpDaGFuZ2VzIGluIHYzOgotIGRyb3AgdGhlIHBh
dGNoIHRoYXQgaW50cm9kdWNlcyB0aGUgbmV3IGZ1bmN0aW9uIHRwbV9jaGlwX2ZyZWUoKQotIHJl
d29yayB0aGUgY29tbWl0IG1lc3NhZ2VzIGZvciB0aGUgcGF0Y2hlcyAoc3R5bGUsIHR5cG9zLCBl
dGMuKQotIGFkZCBmaXhlcyB0YWcgdG8gcGF0Y2ggMgotIGFkZCBKYW1lcyBCb3R0b21sZXkgdG8g
Y2MgbGlzdAotIGFkZCBzdGFibGUgbWFpbGluZyBsaXN0IHRvIGNjIGxpc3QKCkNoYW5nZXMgaW4g
djI6Ci0gZHJvcCB0aGUgcGF0Y2ggdGhhdCBlcnJvbmVvdXNseSBjbGVhbmVkIHVwIGFmdGVyIGZh
aWxlZCBpbnN0YWxsYXRpb24gb2YKICBhbiBhY3Rpb24gaGFuZGxlciBpbiB0cG1tX2NoaXBfYWxs
b2MoKSAocG9pbnRlZCBvdXQgYnkgSmFya2tvIFNha2tpbmVuKQotIG1ha2UgdGhlIGNvbW1pdCBt
ZXNzYWdlIGZvciBwYXRjaCAxIG1vcmUgZGV0YWlsZWQKLSBhZGQgZml4ZXMgdGFncyBhbmQga2Vy
bmVsIGxvZ3MKCgpMaW5vIFNhbmZpbGlwcG8gKDEpOgogIHRwbTogZml4IHJlZmVyZW5jZSBjb3Vu
dGluZyBmb3Igc3RydWN0IHRwbV9jaGlwCgogZHJpdmVycy9jaGFyL3RwbS90cG0tY2hpcC5jICAg
fCA0OCArKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiBkcml2ZXJzL2NoYXIv
dHBtL3RwbS5oICAgICAgICB8ICAxICsKIGRyaXZlcnMvY2hhci90cG0vdHBtMi1zcGFjZS5jIHwg
NTUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMyBmaWxlcyBj
aGFuZ2VkLCA2NiBpbnNlcnRpb25zKCspLCAzOCBkZWxldGlvbnMoLSkKCi0tIAoyLjcuNAoK
