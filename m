Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCBC54651D
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jun 2022 13:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345515AbiFJLJ3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jun 2022 07:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348108AbiFJLJX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jun 2022 07:09:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FFC14642A;
        Fri, 10 Jun 2022 04:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654859346;
        bh=O45VmH8NuxzGZD4XqpbBWPkt09hOK0EdvFcOYQOngco=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XUJ4KEBOFPQEsECL8OmhSz9RoumufW+odPQuCknWFgKaS+1cwtdt2G0bUwELwSP4+
         +GHGuMZmiQh0ekfiCtpfp2sNmXsnu44GtxyvDeDwjt98dc9DhynGODLQa2AkbDOsOX
         h8dWOlynCn2VasbYdKoEYy7Ah6J/yJfPFUZNOePQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.3.165]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxDkw-1noqxF3HVg-00xY1S; Fri, 10
 Jun 2022 13:09:05 +0200
From:   LinoSanfilippo@gmx.de
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, LinoSanfilippo@gmx.de, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: [PATCH v5 07/10] tmp, tmp_tis: Implement usage counter for locality
Date:   Fri, 10 Jun 2022 13:08:43 +0200
Message-Id: <20220610110846.8307-8-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
References: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:73KXtmhSPA6z0Ps5tcxg1HoBOwfkc5Jk0+wV0CmquaXV+7z05O3
 aqDSmUVnsO3xpKCNG5BMtrLphY4YGBfJSpLR84thdCOTio3z1BPd1amY3YVcdo0rj1pzUZe
 Cl3STbGbuFRuF6/e5dIQlMrVk8iVGPslpyXPxh8fcigMqRgKs25+E2bED+PEc1nXaPUfseU
 eobIvmN/CKirKOqvu/4Zg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:reKjEVESRyE=:QMiPPmAMowHXw9o0jUspbw
 CajIooEWEI/df6zM8PGtE2wWmxIGfNxolS0a91dRjXDEsqY3HcoUgNNU3l1f+RQ47Dsn2eKtc
 t8WdFZqu1PemGArS3aIYS9aOKDUWd6WhlNliabGZtf2GJmWKdbqG6yiRTgJQ9wKqUnI5EqwBH
 Xatzkl/vqK66bYKGEq29VnE81ha6NZqJ2B0/KQpZ4ujZgZqBj4EAsOems9bjpKllkyzhOqBUK
 edVnEuA9KR9VXoSS5Va9OSmxBfiJ/Poo2JAZ6kMgY+xsJFIBIMraoh8tra5jafG7JwoviY9vf
 GQ7AAQtgrfegfIuBtyBDAQa0Jj0vtwJDKRh8yY8HT8snvzylx7oXfUNa4k5J1CffQlAyKxrFa
 tYMvkvNpoCuNXNrCVk5gw7E9Yy00hQNzFEHxCBtntLSc+ip3vWJlRTTyfh19f0tJKuzMxwa+W
 GOdTxXpW7g701IcTCas1W+Yo+m8FroNxOXeTMpZ3V1GsJHz1Q0mL+RGhRCnJmV89HGs3jzLO7
 VVu4PFFM9SDxfxCmpDM1TiaeL3DvpOUnDEGSu1UC7/X1U05kYxdztvWPHGS1Xfbqu4jAAiF44
 Em7W/LtM5s22lGGZkdJfIJGmlY+fZXGwkLv5JsZxpwoTgRWQdX7XHxpyB6xeHk/GiRyac+cel
 6yFSmJi1WwWDxKnpfPrifcxLtWytPohLz3M5gs77dT3w4oL8lL4PXjFdowj78hRZb0P1125ok
 ktyBxcbdm1tnUxDhDKAKd73aegtz8LGSLwxYtfFgftT3DWngSj6HaggAlTsLE3spMDM34/qSG
 Xp2tWNwfCR2sHxu3OCoov8mBjj/HB/nRkRa4L9TFa75zZYW04CeUPMoDipXUdNLfXAQ1b+t5d
 1APrec5jmZ1P9CnSlUEfOvGaASJm1PxzpWQNnl00P0Z2Ovm8gIXFLZnbxOv0HM29woI5MYaxr
 05IJULpe2WXLa7kcm4UBfy2D/Rpk6Vqla4orjTdw9nrBShNG5xihQ+iJ49IjFkwhDW9TXRo60
 3dmsmDKfwPvXoeG4j8BUbnHH9z0nbDoWjm0b62WOoWu2m52GIiDbqoerAm+tUrXYnBujJpI2R
 UalgGtv0TRNYpyGHRYwU++tElfmz2yfOHBeDcClOQNdKzAycFFeCJnYeQ==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkltcGxlbWVu
dCBhIHVzYWdlIGNvdW50ZXIgZm9yIHRoZSAoZGVmYXVsdCkgbG9jYWxpdHkgdXNlZCBieSB0aGUg
VFBNIFRJUwpkcml2ZXI6ClJlcXVlc3QgdGhlIGxvY2FsaXR5IGZyb20gdGhlIFRQTSBpZiBpdCBo
YXMgbm90IGJlZW4gY2xhaW1lZCB5ZXQsIG90aGVyd2lzZQpvbmx5IGluY3JlbWVudCB0aGUgY291
bnRlci4gQWxzbyByZWxlYXNlIHRoZSBsb2NhbGl0eSBpZiB0aGUgY291bnRlciBpcyAwCm90aGVy
d2lzZSBvbmx5IGRlY3JlbWVudCB0aGUgY291bnRlci4gRW5zdXJlIHRocmVhZC1zYWZldHkgYnkg
cHJvdGVjdGluZwp0aGUgY291bnRlciB3aXRoIGEgbXV0ZXguCgpUaGlzIGFsbG93cyB0byByZXF1
ZXN0IGFuZCByZWxlYXNlIHRoZSBsb2NhbGl0eSBmcm9tIGEgdGhyZWFkIGFuZCB0aGUKaW50ZXJy
dXB0IGhhbmRsZXIgYXQgdGhlIHNhbWUgdGltZSB3aXRob3V0IHRoZSBkYW5nZXIgdG8gaW50ZXJm
ZXJlIHdpdGgKZWFjaCBvdGhlci4KClNpZ25lZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8bC5z
YW5maWxpcHBvQGt1bmJ1cy5jb20+Ci0tLQogZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUu
YyB8IDMwICsrKysrKysrKysrKysrKysrKysrKysrKysrKystLQogZHJpdmVycy9jaGFyL3RwbS90
cG1fdGlzX2NvcmUuaCB8ICAyICsrCiAyIGZpbGVzIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2Nv
cmUuYyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMKaW5kZXggMDI4YmVjNDQzNjJk
Li4wZWY3NDk3OWJjMmMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3Jl
LmMKKysrIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwpAQCAtMTU4LDE2ICsxNTgs
MjYgQEAgc3RhdGljIGJvb2wgY2hlY2tfbG9jYWxpdHkoc3RydWN0IHRwbV9jaGlwICpjaGlwLCBp
bnQgbCkKIAlyZXR1cm4gZmFsc2U7CiB9CiAKK3N0YXRpYyBpbnQgcmVsZWFzZV9sb2NhbGl0eV9s
b2NrZWQoc3RydWN0IHRwbV90aXNfZGF0YSAqcHJpdiwgaW50IGwpCit7CisJdHBtX3Rpc193cml0
ZTgocHJpdiwgVFBNX0FDQ0VTUyhsKSwgVFBNX0FDQ0VTU19BQ1RJVkVfTE9DQUxJVFkpOworCXJl
dHVybiAwOworfQorCiBzdGF0aWMgaW50IHJlbGVhc2VfbG9jYWxpdHkoc3RydWN0IHRwbV9jaGlw
ICpjaGlwLCBpbnQgbCkKIHsKIAlzdHJ1Y3QgdHBtX3Rpc19kYXRhICpwcml2ID0gZGV2X2dldF9k
cnZkYXRhKCZjaGlwLT5kZXYpOwogCi0JdHBtX3Rpc193cml0ZTgocHJpdiwgVFBNX0FDQ0VTUyhs
KSwgVFBNX0FDQ0VTU19BQ1RJVkVfTE9DQUxJVFkpOworCW11dGV4X2xvY2soJnByaXYtPmxvY2Fs
aXR5X2NvdW50X211dGV4KTsKKwlwcml2LT5sb2NhbGl0eV9jb3VudC0tOworCWlmIChwcml2LT5s
b2NhbGl0eV9jb3VudCA9PSAwKQorCQlyZWxlYXNlX2xvY2FsaXR5X2xvY2tlZChwcml2LCBsKTsK
KwltdXRleF91bmxvY2soJnByaXYtPmxvY2FsaXR5X2NvdW50X211dGV4KTsKIAogCXJldHVybiAw
OwogfQogCi1zdGF0aWMgaW50IHJlcXVlc3RfbG9jYWxpdHkoc3RydWN0IHRwbV9jaGlwICpjaGlw
LCBpbnQgbCkKK3N0YXRpYyBpbnQgcmVxdWVzdF9sb2NhbGl0eV9sb2NrZWQoc3RydWN0IHRwbV9j
aGlwICpjaGlwLCBpbnQgbCkKIHsKIAlzdHJ1Y3QgdHBtX3Rpc19kYXRhICpwcml2ID0gZGV2X2dl
dF9kcnZkYXRhKCZjaGlwLT5kZXYpOwogCXVuc2lnbmVkIGxvbmcgc3RvcCwgdGltZW91dDsKQEAg
LTIwOCw2ICsyMTgsMjAgQEAgc3RhdGljIGludCByZXF1ZXN0X2xvY2FsaXR5KHN0cnVjdCB0cG1f
Y2hpcCAqY2hpcCwgaW50IGwpCiAJcmV0dXJuIC0xOwogfQogCitzdGF0aWMgaW50IHJlcXVlc3Rf
bG9jYWxpdHkoc3RydWN0IHRwbV9jaGlwICpjaGlwLCBpbnQgbCkKK3sKKwlzdHJ1Y3QgdHBtX3Rp
c19kYXRhICpwcml2ID0gZGV2X2dldF9kcnZkYXRhKCZjaGlwLT5kZXYpOworCWludCByZXQgPSAw
OworCisJbXV0ZXhfbG9jaygmcHJpdi0+bG9jYWxpdHlfY291bnRfbXV0ZXgpOworCWlmIChwcml2
LT5sb2NhbGl0eV9jb3VudCA9PSAwKQorCQlyZXQgPSByZXF1ZXN0X2xvY2FsaXR5X2xvY2tlZChj
aGlwLCBsKTsKKwlpZiAoIXJldCkKKwkJcHJpdi0+bG9jYWxpdHlfY291bnQrKzsKKwltdXRleF91
bmxvY2soJnByaXYtPmxvY2FsaXR5X2NvdW50X211dGV4KTsKKwlyZXR1cm4gcmV0OworfQorCiBz
dGF0aWMgdTggdHBtX3Rpc19zdGF0dXMoc3RydWN0IHRwbV9jaGlwICpjaGlwKQogewogCXN0cnVj
dCB0cG1fdGlzX2RhdGEgKnByaXYgPSBkZXZfZ2V0X2RydmRhdGEoJmNoaXAtPmRldik7CkBAIC05
ODcsNiArMTAxMSw4IEBAIGludCB0cG1fdGlzX2NvcmVfaW5pdChzdHJ1Y3QgZGV2aWNlICpkZXYs
IHN0cnVjdCB0cG1fdGlzX2RhdGEgKnByaXYsIGludCBpcnEsCiAJcHJpdi0+dGltZW91dF9taW4g
PSBUUE1fVElNRU9VVF9VU0VDU19NSU47CiAJcHJpdi0+dGltZW91dF9tYXggPSBUUE1fVElNRU9V
VF9VU0VDU19NQVg7CiAJcHJpdi0+cGh5X29wcyA9IHBoeV9vcHM7CisJcHJpdi0+bG9jYWxpdHlf
Y291bnQgPSAwOworCW11dGV4X2luaXQoJnByaXYtPmxvY2FsaXR5X2NvdW50X211dGV4KTsKIAog
CWRldl9zZXRfZHJ2ZGF0YSgmY2hpcC0+ZGV2LCBwcml2KTsKIApkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuaCBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3Jl
LmgKaW5kZXggOGUwMmZhYTQwNzlkLi5lMTg3MWM0ODJkYTIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Y2hhci90cG0vdHBtX3Rpc19jb3JlLmgKKysrIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2Nv
cmUuaApAQCAtOTQsNiArOTQsOCBAQCBlbnVtIHRwbV90aXNfaXJxdGVzdF9mbGFncyB7CiAKIHN0
cnVjdCB0cG1fdGlzX2RhdGEgewogCXUxNiBtYW51ZmFjdHVyZXJfaWQ7CisJc3RydWN0IG11dGV4
IGxvY2FsaXR5X2NvdW50X211dGV4OworCXVuc2lnbmVkIGludCBsb2NhbGl0eV9jb3VudDsKIAlp
bnQgbG9jYWxpdHk7CiAJaW50IGlycTsKIAl1bnNpZ25lZCBpbnQgaXJxc19pbl91c2U7Ci0tIAoy
LjM2LjEKCg==
