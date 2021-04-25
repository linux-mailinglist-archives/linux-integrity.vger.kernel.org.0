Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECD436A9E5
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Apr 2021 01:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhDYXt3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 25 Apr 2021 19:49:29 -0400
Received: from mout.gmx.net ([212.227.15.15]:40185 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231247AbhDYXt2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 25 Apr 2021 19:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619394514;
        bh=X646+yzuPbS+s5kURuZn4C7yHFwk1iV6M3XlPmxCpnU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=LYmShbl99em9+TiR3a451+pSoTVhXCBAH2jin8fcrvH4sjxkyZuGxerSF2CmDIyfB
         WrLCrzgrBbqThkME1lOxF0IAdLkAYxKajVAqVCk4v07Zu9z6Oncc/VF7P6Hrw2eaEE
         yjW+NKxlrcv6p0BVKL5+UHt+dJG3PvwLMeP34M18=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([78.42.220.31]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRmfo-1m3qbg0RSs-00TH76; Mon, 26
 Apr 2021 01:48:34 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, James.Bottomley@hansenpartnership.com,
        keescook@chromium.org, jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        LinoSanfilippo@gmx.de
Subject: [PATCH v2 0/4] Fixes for TPM interrupt handling
Date:   Mon, 26 Apr 2021 01:47:16 +0200
Message-Id: <1619394440-30646-1-git-send-email-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:4qHzIHr6K2l3e4xERhZnmHXv8PS5230fp8C2yxIaIa7TVJMYFVc
 BUMLrCu2i90goHg6nFZ49wMO6jrf9TVyycVF7JlyBhvcl4ME3aSeMqFOneoGApbHnkTczZp
 SYs9e5CPSOaDt59e+lClecQJCTOmylNsZggvlNzcVjGGgDxcW84ZeBjlnVy4JJcXoChtbMm
 9y3YahnTEluPk29WUOnMw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:X8W08em31wE=:d2Sobpj8MM5gDUBMXedBX3
 hNkmkN6uY+3HXF0XPya9ePkVvJIhtTxFEt/PnqEzlU6X9JGoRKN/4RuNZenAW7FCofQxcDYyg
 eSWOu2/LGCqwfIKA41DttHyWV+vEv7nArzrtTqXTBYrdi5+AmqH2tI1HkmPI2389NdfMPNetT
 EJDiepu1eEmYmfD4yy+RYg9XLkATT5KMhzvHS3KkO1XzhGTqwhvmW9OfSAHEgRXbn3/fx0iV8
 ogvU6Ce9nJcSo/HDrVli4/4XOJAH+efUi3JK+z+ifkeH6+8Y9KG7CgPCUe88vePNW9bnDa1EO
 wDHhE6hEtQbcFtB044dSreXDS37N2SzM9MByGDeFuQ3IEAWYGaeGy1/m1iyxcgVJWbOdwBagp
 AQSB10w0rle2bUFgjGLdmI2SiEFQmFZB60udnwjXX6dQiMNXN+RjoOPBLuwcnr0HfmDHYa/Zh
 8LFPPI6G8ZESV8SxZ2T5ggl4u/gTWENROhPp4CfMnswxdz6iuJErkYd2uz+BlEYK3IDkNil/u
 Y442AP/FED+MA2nO4xsOtSB/GyXmHQC5zAj2DsZ1bOTv0IgSNC8te2BgM9RqKKOukzap7gSTc
 I01OSX2zXpseCAA1JjSNTkr20zhRmFwGEd6mDc4oYbIMsUeASBu+oRWo2bYaUfWNu/zY9jOjj
 JRQvq5Qd1rUIthOcsdijl5QdQyOiBuu61irE6ZJQjrZNrexKXFqhWzNgfGZV1ZMvvdx1HqEs+
 +EkJxAh1BkmOQZz46QwakqKUJEU63snnNuvTJ7nlrXVHXE3GHzs++UYYzXJVFgFcD4moXOhkz
 XCFG6LxPb22s3Bty9WUHx4nIC5cMtxyVHzfz3hhPksNxy2BaIXN6rZhaQQ6BgHQYhxBhkRgnb
 IJV1ANS0q4TRCn1R0scA5TUmoo7Qjg3hta9lB5e/wSJZIX7t077VuHbgzW1WlehY3/syNfZbh
 2ZqqEKRp8E4lnlxRpvrrEzJoXvpied9QGwjv3F/fLi/+NgVwoGhZhtYPDHgjscAnrLrpq9FPT
 22rnjGIRPMKUfYca7LPaK+20uY8UFpjBZOFUJtjPPqy56X/Vwefl3hfIV7NfllRBVhlx2CZLy
 /l7M7VSsTmJtpT6C2cTwuqggNci0lrddE03sQUM/I4H1qPMBAJaeO8IWxRBMDnYs0o6ANdndC
 coLqOQc2ckcpPewkimoju+wvcOXHMIemveOqLBwYWM6/dT7s3sc8xqrZhBMlTKTM1YWovUUpv
 mVjaJZhH9PAVtsCcz
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

VGhpcyBzZXJpZXMgZW5hYmxlcyBpbnRlcnJ1cHRzIGZvciBUUE0uIEZvciB0aGlzIHNvbWUgb2Jz
dGFjbGVzIGhhZCB0byBiZQpyZW1vdmVkIGZpcnN0LCBsaWtlIHRoZSBpbnRlcnJ1cHQgaGFuZGxl
ciBydW5uaW5nIGluIGludGVycnVwdCBjb250ZXh0IGFuZAp0aHVzIG5vdCBhbGxvd2luZyB0byBh
Y2Nlc3MgcmVnaXN0ZXJzIG92ZXIgU1BJLiBBbHNvIHRoZSBsb2NhbGl0eSBoYW5kbGluZwpoYXMg
YmVlbiBzaW1wbGlmaWVkIHRvIG1ha2UgYSBjb21wbGljYXRlZCBzeW5jaHJvbml6YXRpb24gYmV0
d2VlbiB0aHJlYWRzCmFuZCBpcnEgaGFuZGxlciB1bm5lY2Vzc2FyeS4gQXMgYSBzaWRlIGVmZmVj
dCBvZiB0aGlzIHNpbXBsaWZpY2F0aW9uIGEgYnVnCmlzIGZpeGVkIGluIHdoaWNoIGEgVE1QIGNv
bW1hbmQgaXMgaXNzdWVkIHdpdGhvdXQgYSBjbGFpbWVkIGxvY2FsaXR5IGluCmNhc2Ugb2YgVFBN
IDIuCkFub3RoZXIgZml4IGNvbmNlcm5zIHRoZSBpbnRlcnJ1cHQgdGVzdCB3aGljaCBjdXJyZW50
bHkgaXMgYnJva2VuLgpGaW5hbGx5IHRoZSByZXN1bHRzIG9mIHRoZSBjYXBhYmlsaXR5IHF1ZXJ5
IGF0IHN0YXJ0dXAgaXMgdXNlZCB0byBvbmx5IHNldAp0aGUgaW50ZXJydXB0cyB3aGljaCBhcmUg
YWN0dWFsbHkgc3VwcG9ydGVkIGJ5IHRoZSBoYXJkd2FyZS4KClRoZXNlIHBhdGNoZXMgYXJlIGJh
c2VkIG9uIExpbnV4IG1haW5saW5lIFY1LjEyIGFuZCB0ZXN0ZWQgb24gYSBTTEIgOTY3MAp3aGlj
aCB1c2VzIFRQTSAyIHZpYSBTUEkuCgpPZiBjb3Vyc2UgYW55IGZ1cnRoZXIgdGVzdGluZyBpcyBo
aWdobHkgYXBwcmVjaWF0ZWQuCgpQQVRDSCAxOiBUaGUgU1BJIGltcGxlbWVudGF0aW9uIG9mIHRo
ZSBmdW5jdGlvbnMgdG8gcmVhZC93cml0ZSB0by9mcm9tCnJlZ2lzdGVycyB1c2VzIG11dGV4ZXMg
YW5kIHRodXMgcmVxdWlyZSBhIHNsZWVwYWJsZSBjb250ZXh0LiBGb3IgdGhpcwpyZWFzb24gcmVx
dWVzdCBhIHRocmVhZGVkIGludGVycnVwdCBoYW5kbGVyLgoKUEFUQ0ggMjogU2ltcGxpZnkgbG9j
YWxpdHkgaGFuZGxpbmcgYnkgdGFraW5nIHRoZSBkcml2ZXIgbG9jYWxpdHkgKDApIGF0CmRyaXZl
ciBzdGFydHVwIGFuZCByZWxlYXNpbmcgaXQgYXQgZHJpdmVyIHNodXRkb3duLiBUaGlzIGFsc28g
Zml4ZXMgYSBidWcKaW4gY2FzZSBvZiBUTVAgMi4KClBBVENIIDM6IEZpeCBhbmQgc2ltcGxpZnkg
dGhlIHRlc3QgZm9yIGludGVycnVwdHMuCgpQQVRDSCA0OiBPbmx5IHNldCB0aGUgaW50ZXJydXB0
cyB3aGljaCBhcmUgcmVwb3J0ZWQgYXMgYmVpbmcgYXZhaWxhYmxlLgoKQ2hhbmdlcyBpbiB2MjoK
LSByZWJhc2UgYWdhaW5zdCA1LjEyCi0gZnJlZSBpcnEgb24gZXJyb3IgcGF0aAoKTGlubyBTYW5m
aWxpcHBvICg0KToKICB0cG06IFVzZSBhIHRocmVhZGVkIGludGVycnVwdCBoYW5kbGVyCiAgdHBt
OiBTaW1wbGlmeSBsb2NhbGl0eSBoYW5kbGluZwogIHRwbTogRml4IHRlc3QgZm9yIGludGVycnVw
dHMKICB0cG06IE9ubHkgZW5hYmxlIHN1cHBvcnRlZCBpcnFzCgogZHJpdmVycy9jaGFyL3RwbS90
cG0tY2hpcC5jICAgICB8ICA0MCAtLS0tLS0tLS0tCiBkcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNf
Y29yZS5jIHwgMTcwICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIGRy
aXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmggfCAgIDIgKy0KIGluY2x1ZGUvbGludXgvdHBt
LmggICAgICAgICAgICAgfCAgIDUgKy0KIDQgZmlsZXMgY2hhbmdlZCwgNzIgaW5zZXJ0aW9ucygr
KSwgMTQ1IGRlbGV0aW9ucygtKQoKLS0gCjIuNy40Cgo=
