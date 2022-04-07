Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296684F7DD8
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Apr 2022 13:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244712AbiDGLVj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Apr 2022 07:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbiDGLVb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Apr 2022 07:21:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E2F195D89;
        Thu,  7 Apr 2022 04:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649330356;
        bh=5/6ZzUueHS3SF2yHi16HZRPFVZW5IvH0j1r8wVbaYU0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=H3la3kpTpg4Z7uOzU0ZQHQenpdBHeB5IDlmTgTean2DfC7LOJuEEYSF4L+riovkIy
         0cWqenq7eMaTwGdK+mX/MIsF7PK/Cg5UjvjZMR8Uy+OkYzi2TMizC8QTISoQaQY1Wg
         sZtl9nHKmRd2JNzw93qBIDzovgq+u5WSj4jTTQ2A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.2.23]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MplXz-1oLhfN1wzN-00qBBW; Thu, 07
 Apr 2022 13:19:16 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        =robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefanb@linux.ibm.com,
        p.rosenberger@kunbus.com, lukas@wunner.de,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: [PATCH 4/5] tpm: tpm_tis: make functions available for external linkage
Date:   Thu,  7 Apr 2022 13:18:48 +0200
Message-Id: <20220407111849.5676-5-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407111849.5676-1-LinoSanfilippo@gmx.de>
References: <20220407111849.5676-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:p5yGYHiR+LCe1gVoENeZriGuaH9Er4iA4m9Xa6QqaP/T7wAg51g
 ssafnceBC/S1gKqum8GjJA4guPukkYT14wZ65DXs5IrJ5ijaVZUKm5e2xsfQ8q3sxjGqp3Q
 aFxQDOl6+qTJE0Q4YK9JZeUV6SGwcKH7O5q7F6kW1rb51fEQ8qydzKn0WHz2abJIhhYjI3T
 Ts3cIhZ1fNYX2Po0p9QTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JWUi0rCOfiE=:2RHflXSnANxWyD6/rzfIIc
 Bjcsri+a9CzRXO2QpsUdmHFB9uWQor73qr4vxgcfYam7ybqNDDDaCWwE8SP9NVvQGmoBTKbQ9
 fi0x46shfJt8DH1YMXRurg2JBZY/P4LhHP8mmYPmF5kM+lMIpM3qNGauI1d8E6Gc4mspiM+AB
 HEs64pDImgNAgNqss/fxjq5CSQqDPFWjbwEgXIiwHR7yVdcmkmpxhkDdqK92GNRWehYL+eC7K
 wGAk/oziryvcAe0scvWvbwD4hKSop8OyXBqqWeJFNHHO1PEzcaAUSjlI2czzO1svCYZNQbckz
 cHgAWxlRgoPWnybt7tPorhseElEko3ZpBf21GFKtuYLgmcw/rmbC0mzXQ3OtPfMlYyFMVUPqH
 ywH+18zITO5RaXM6S3yMuxY19h5M07dJMob+KAf+FEDlIUKYJep7WTWKFd1B+2H15Y++T44DB
 0xHAyJ9ruZhtSJjdZ7KzQGieRi75hjAP8VdOofKtimG5Gg4OEhRug7yb/LkZbD28TClWNtmNz
 gLv+MqTMmBdMg150Risap3EfLvLwJMxdalwzcxNK4iiadSbMD7uLGI1yMIpgBCcB98sRBlxHH
 OgRfv1q57Ms1ZA0aKl/xrnvNTXPVJ2Co3k9fjr7xvqF9tED2pMnOT1yZIorNioNsFxtP8X9oA
 hf4XKqnYzVwRYcGAPHpByaWTCIGV9sovGHP+V1gMrSXD3U9DxSiwqFgQcVTLFAFCrdZ7MItjj
 rPBwpwzkri7gq2qOYjD6QEiHpguBO9P6NGUABuSFcdRp9DnKR0yXw59cxWcaoMSezvV8Q/GvU
 eLKVnSYy0E1U8MZOvcnE0gBz2caFlA1I6Kv/Oqo5DYcp1uzh3+m5cOekFMmQvHj9w8WiGpaCm
 K8GBqxAGeHLazD3uremT4KsLaDviyF132fXIIoldBoxlZNFH8gkK1BpD8G05AXmWrWLHIIMu+
 ClGdTLZAwtfhZ6wTmFL5WClKp+qfBrq3QGyhMyWtfvaRmeIbTmTo21BjQOrziStxdppcf6/mA
 00NIiFH7W6rGjBYk4Rbhqa+YKz/+qPA7VSZDs5DcZ0N1hYMLhodCrV7EIBFPC9Q9bY5URxAON
 6hkas4z2PlDjXQ=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

VGhlIHRwbV90aXNfcGh5X29wcyBmdW5jdGlvbnMgdHBtX3Rpc19zcGlfcmVhZDE2LCB0cG1fdGlz
X3NwaV9yZWFkMzIgYW5kCnRwbV90aXNfc3BpX3dyaXRlMzIgYXJlIGFscmVhZHkgZGVjbGFyZWQg
ZXh0ZXJuIHRvIGJlIHVzZWQgb3V0c2lkZSBvZgp0cG1fdGltX3NwaV9tYWluLmMuCgpEbyB0aGUg
c2FtZSB3aXRoIHRwbV90aXNfc3BpX3JlYWRfYnl0ZXMgYW5kIHRwbV90aXNfc3BpX3dyaXRlX2J5
dGVzIHRvCmFsbG93IHRoZSBleHRlcm5hbCBhY2Nlc3MgdG8gdGhlIGNvbXBsZXRlIHNldCBvZiB0
cG1fdGlzX3BoeV9vcHMuCgpUaGlzIGlzIGluIHByZXBhcmF0aW9uIG9mIHRoZSBhc3NpZ25tZW50
IG9mIFNMQjk2NzAgc3BlY2lmaWMgcGh5IG9wcyBpbiBhCnNlcGFyYXRlIGZpbGUuCgpGdXJ0aGVy
bW9yZSBkZWNsYXJlIHRwbV90aXNfc3BpX2Zsb3dfY29udHJvbCBleHRlcm4sIHNvIHRoYXQgd2Ug
Y2FuIHVzZSBpdAppbiBhIFNMQjk2NzAgc3BlY2lmaWMgcHJvYmUgZnVuY3Rpb24gaW4gdGhlIHNh
bWUgZmlsZS4KClNpZ25lZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8TGlub1NhbmZpbGlwcG9A
Z214LmRlPgotLS0KIGRyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19zcGkuaCAgICAgIHwgIDcgKysr
KysrKwogZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX3NwaV9tYWluLmMgfCAxMiArKysrKystLS0t
LS0KIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfc3BpLmggYi9kcml2ZXJzL2NoYXIv
dHBtL3RwbV90aXNfc3BpLmgKaW5kZXggYmJhNzM5NzljMzY4Li44ZjQzMzFkOGE0ZGQgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19zcGkuaAorKysgYi9kcml2ZXJzL2NoYXIv
dHBtL3RwbV90aXNfc3BpLmgKQEAgLTI1LDYgKzI1LDkgQEAgc3RhdGljIGlubGluZSBzdHJ1Y3Qg
dHBtX3Rpc19zcGlfcGh5ICp0b190cG1fdGlzX3NwaV9waHkoc3RydWN0IHRwbV90aXNfZGF0YSAq
ZGEKIAlyZXR1cm4gY29udGFpbmVyX29mKGRhdGEsIHN0cnVjdCB0cG1fdGlzX3NwaV9waHksIHBy
aXYpOwogfQogCitleHRlcm4gaW50IHRwbV90aXNfc3BpX2Zsb3dfY29udHJvbChzdHJ1Y3QgdHBt
X3Rpc19zcGlfcGh5ICpwaHksCisJCQkJICAgIHN0cnVjdCBzcGlfdHJhbnNmZXIgKnNwaV94ZmVy
KTsKKwogZXh0ZXJuIGludCB0cG1fdGlzX3NwaV9pbml0KHN0cnVjdCBzcGlfZGV2aWNlICpzcGks
IHN0cnVjdCB0cG1fdGlzX3NwaV9waHkgKnBoeSwKIAkJCSAgICBpbnQgaXJxLCBjb25zdCBzdHJ1
Y3QgdHBtX3Rpc19waHlfb3BzICpwaHlfb3BzKTsKIApAQCAtMzQsNiArMzcsMTAgQEAgZXh0ZXJu
IGludCB0cG1fdGlzX3NwaV90cmFuc2ZlcihzdHJ1Y3QgdHBtX3Rpc19kYXRhICpkYXRhLCB1MzIg
YWRkciwgdTE2IGxlbiwKIGV4dGVybiBpbnQgdHBtX3Rpc19zcGlfcmVhZDE2KHN0cnVjdCB0cG1f
dGlzX2RhdGEgKmRhdGEsIHUzMiBhZGRyLCB1MTYgKnJlc3VsdCk7CiBleHRlcm4gaW50IHRwbV90
aXNfc3BpX3JlYWQzMihzdHJ1Y3QgdHBtX3Rpc19kYXRhICpkYXRhLCB1MzIgYWRkciwgdTMyICpy
ZXN1bHQpOwogZXh0ZXJuIGludCB0cG1fdGlzX3NwaV93cml0ZTMyKHN0cnVjdCB0cG1fdGlzX2Rh
dGEgKmRhdGEsIHUzMiBhZGRyLCB1MzIgdmFsdWUpOworZXh0ZXJuIGludCB0cG1fdGlzX3NwaV9y
ZWFkX2J5dGVzKHN0cnVjdCB0cG1fdGlzX2RhdGEgKmRhdGEsIHUzMiBhZGRyLCB1MTYgbGVuLAor
CQkJCSAgdTggKnJlc3VsdCk7CitleHRlcm4gaW50IHRwbV90aXNfc3BpX3dyaXRlX2J5dGVzKHN0
cnVjdCB0cG1fdGlzX2RhdGEgKmRhdGEsIHUzMiBhZGRyLCB1MTYgbGVuLAorCQkJCSAgIGNvbnN0
IHU4ICp2YWx1ZSk7CiAKICNpZmRlZiBDT05GSUdfVENHX1RJU19TUElfQ1I1MAogZXh0ZXJuIGlu
dCBjcjUwX3NwaV9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKTsKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvY2hhci90cG0vdHBtX3Rpc19zcGlfbWFpbi5jIGIvZHJpdmVycy9jaGFyL3RwbS90cG1f
dGlzX3NwaV9tYWluLmMKaW5kZXggMTg0Mzk2YjNhZjUwLi5iMmQxM2I4NDQ2NTkgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19zcGlfbWFpbi5jCisrKyBiL2RyaXZlcnMvY2hh
ci90cG0vdHBtX3Rpc19zcGlfbWFpbi5jCkBAIC00NSw4ICs0NSw4IEBACiAgKgogICogWzFdIGh0
dHBzOi8vdHJ1c3RlZGNvbXB1dGluZ2dyb3VwLm9yZy9yZXNvdXJjZS9wYy1jbGllbnQtcGxhdGZv
cm0tdHBtLXByb2ZpbGUtcHRwLXNwZWNpZmljYXRpb24vCiAgKi8KLXN0YXRpYyBpbnQgdHBtX3Rp
c19zcGlfZmxvd19jb250cm9sKHN0cnVjdCB0cG1fdGlzX3NwaV9waHkgKnBoeSwKLQkJCQkgICAg
c3RydWN0IHNwaV90cmFuc2ZlciAqc3BpX3hmZXIpCitpbnQgdHBtX3Rpc19zcGlfZmxvd19jb250
cm9sKHN0cnVjdCB0cG1fdGlzX3NwaV9waHkgKnBoeSwKKwkJCSAgICAgc3RydWN0IHNwaV90cmFu
c2ZlciAqc3BpX3hmZXIpCiB7CiAJc3RydWN0IHNwaV9tZXNzYWdlIG07CiAJaW50IHJldCwgaTsK
QEAgLTE0MCwxNCArMTQwLDE0IEBAIGludCB0cG1fdGlzX3NwaV90cmFuc2ZlcihzdHJ1Y3QgdHBt
X3Rpc19kYXRhICpkYXRhLCB1MzIgYWRkciwgdTE2IGxlbiwKIAlyZXR1cm4gcmV0OwogfQogCi1z
dGF0aWMgaW50IHRwbV90aXNfc3BpX3JlYWRfYnl0ZXMoc3RydWN0IHRwbV90aXNfZGF0YSAqZGF0
YSwgdTMyIGFkZHIsCi0JCQkJICB1MTYgbGVuLCB1OCAqcmVzdWx0KQoraW50IHRwbV90aXNfc3Bp
X3JlYWRfYnl0ZXMoc3RydWN0IHRwbV90aXNfZGF0YSAqZGF0YSwgdTMyIGFkZHIsIHUxNiBsZW4s
CisJCQkgICB1OCAqcmVzdWx0KQogewogCXJldHVybiB0cG1fdGlzX3NwaV90cmFuc2ZlcihkYXRh
LCBhZGRyLCBsZW4sIHJlc3VsdCwgTlVMTCk7CiB9CiAKLXN0YXRpYyBpbnQgdHBtX3Rpc19zcGlf
d3JpdGVfYnl0ZXMoc3RydWN0IHRwbV90aXNfZGF0YSAqZGF0YSwgdTMyIGFkZHIsCi0JCQkJICAg
dTE2IGxlbiwgY29uc3QgdTggKnZhbHVlKQoraW50IHRwbV90aXNfc3BpX3dyaXRlX2J5dGVzKHN0
cnVjdCB0cG1fdGlzX2RhdGEgKmRhdGEsIHUzMiBhZGRyLCB1MTYgbGVuLAorCQkJICAgIGNvbnN0
IHU4ICp2YWx1ZSkKIHsKIAlyZXR1cm4gdHBtX3Rpc19zcGlfdHJhbnNmZXIoZGF0YSwgYWRkciwg
bGVuLCBOVUxMLCB2YWx1ZSk7CiB9Ci0tIAoyLjM1LjEKCg==
