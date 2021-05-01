Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4868E37077B
	for <lists+linux-integrity@lfdr.de>; Sat,  1 May 2021 16:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbhEAOC3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 1 May 2021 10:02:29 -0400
Received: from mout.gmx.net ([212.227.17.20]:56987 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232135AbhEAOC2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 1 May 2021 10:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619877685;
        bh=AzZ1AEuOXzDeEZImjz7dTO6fuYvDAouQw4LSy2qtRfc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=cJEtwcMT/jtmDGDmnOkPUOtDVMz5XKQVsLanP9GkzkU9SZxla1Bje4xAU2i1Fyoq/
         bq6YQmiHdDOyTgK5+dLiYPYtUEsVP6rITBpHEcknK0mUX4OLS8GREa4U7nZhA0c2Ss
         MCz7VdZQefZZhle4OVDs88b8W+fVaF2JyHmQby3g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([78.42.220.31]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwQTF-1lJvmq2RYj-00sQci; Sat, 01
 May 2021 16:01:25 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, James.Bottomley@hansenpartnership.com,
        keescook@chromium.org, jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        LinoSanfilippo@gmx.de, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 1/4] tpm: Use a threaded interrupt handler
Date:   Sat,  1 May 2021 15:57:24 +0200
Message-Id: <20210501135727.17747-2-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210501135727.17747-1-LinoSanfilippo@gmx.de>
References: <20210501135727.17747-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:NrTXl/opWW/qgKoUTHBe+9UNDrooth7BL558pzu02XlAoFZ2mXR
 uBepUu9IrF0futHiWZ0QtkjV68QuieCkwEvgeHsuk+/4KXVZI5SHlyGHG9eh2TvXGwRxaTP
 tEqlXh4APLVE2GLSxocC5hN80O4Q8+JLX+jA+gBi0JkrcxGu8eIP73wEiPPXxEDYeiKGQJA
 42G5Uf/V4JM4tgjCMfkbQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6LPgizRyedI=:Cx2O9SlAsQqEtSKq11bB/w
 9ca9OY5wg+eP48gfddI1w8wJCKHxv8WlKx4ulGaDdY6EXbCtipijSJ3Is+wLMiMhLUBucnU94
 dITVMESvGCOHjiGxWovFRx6m3dd2TmGMdpo0WX6ogYQOKUZTPb691+dttuTPJtuaFB4sKNbRp
 4YWJ/pnmlaWVec915D0eW0Qmp9LhL4M2/icYoQIY1svc6nW/uLSSaEYoxZeSEEyWMggLV0zdT
 iEZBJzWF58oOsoqzw98UIiGukGxDqz2zWfIXjl8cteMfSMU8iVMDbEq9+juuR/wTgxgDI2aNF
 JZP+MMJ1XFQTHneMKDNQMOAMWo7tznfE5CCT2mnMcji0Q6o/obNsgiWj2VYevtHIime5J7Qtf
 gA+aMM5u9Q2Q+tTZCnRRbYtF5v9XKR9V72SRxpmW4EKs6cG2f2I4Lz/1fURRuVUbewAB82ts+
 WLgsNcnKD6uOLUwizTyxP6+bnZoZFv+Oruv18KrP3o8UuJ1MfCUFhMgB9SEbJV5k9Aom7tiRv
 R1YDt9IlIvu4bSDY52DUtUHUl9j+36KkiGLnZIkXk3bwrqzpsBwGNKOT3Z6ZdXaR0WeG4Bk6w
 VzzzVwcNbyvJWEz7yzVQAjNYDycOEyRPJLii9zItQU61dGujOL3irqbLqIqAuS0QyhDAFIQ41
 ujMDGbtJQppYOdEeZC/q5hxvWon55VYk8zgoTn8BeThfxBboWJ0Dten5Q4MPFz7jw0hNyQoMe
 Dic7A82abklmPAu9MVhTPyvtZduqhfZOKokeWvg8MLy0qzAYB1Yj2vGlANKxqs2/rP1DyujTc
 8nSRUyOk6R78lCXwAgcJTyEw3F1BFFTCWVr/TGBZzy0fct5zXCuce2b7jcMu4tooLkG9i9NwN
 4R+MHeqNBYDcUgEP43CKoN0qj50VS5FC0kHEgQQreQg0rTqi6IgbkxVoXpKWq/se14bv81dOv
 n7ILwMMVHMf7g9aIY7+RN23d6k6inGeLxL+NEucTeUvR5us+VoElDtH8eWRtMmN9Qm6zcTkf2
 qqs99vxYN+Iz7GuoIwPUEtpt2GEjxJh+2J01xEP3uaSguEDLbP9lx9Ek8ng3y1FbSR3Zz97+B
 SoE/+Mz39+jnI7/OhXRQCWWjZJmFoay9HtXWcWW0aCR6TlYkAqbjKnDjcFRH5NAR+ULHDEpYO
 70tytwQcCH/jNUNYEbb116YfLpQNOhBMfiVW03W7X5Qmy0LQREUKJzXcEs4RK5d2PnL1S4mpC
 IGN9pCdXypWwke3sU
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

VGhlIGludGVycnVwdCBoYW5kbGVyIHVzZXMgdHBtX3Rpc19yZWFkMzIoKSBhbmQgdHBtX3Rpc193
cml0ZTMyKCkgdG8gYWNjZXNzCnRoZSBpbnRlcnJ1cHQgc3RhdHVzIHJlZ2lzdGVyLiBJbiBjYXNl
IG9mIFNQSSB0aG9zZSBhY2Nlc3NlcyBhcmUgZG9uZSB3aXRoCnRoZSBzcGlfYnVzX2xvY2sgbXV0
ZXggaGVsZC4gVGhpcyBtZWFucyB0aGF0IHRoZSBzdGF0dXMgcmVnaXN0ZXIgY2Fubm90CmJlIHJl
YWQgb3Igd3JpdHRlbiBpbiBpbnRlcnJ1cHQgY29udGV4dC4KCkZvciB0aGlzIHJlYXNvbiByZXF1
ZXN0IGEgdGhyZWFkZWQgaW50ZXJydXB0IGhhbmRsZXIgc28gdGhhdCB0aGUgcmVxdWlyZWQKYWNj
ZXNzZXMgY2FuIGJlIGRvbmUgaW4gcHJvY2VzcyBjb250ZXh0LgoKUmV2aWV3ZWQtYnk6IFN0ZWZh
biBCZXJnZXIgPHN0ZWZhbmJAbGludXguaWJtLmNvbT4KU2lnbmVkLW9mZi1ieTogTGlubyBTYW5m
aWxpcHBvIDxMaW5vU2FuZmlsaXBwb0BnbXguZGU+Ci0tLQogZHJpdmVycy9jaGFyL3RwbS90cG1f
dGlzX2NvcmUuYyB8IDYgKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3Jl
LmMgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCmluZGV4IGEyZTAzOTVjYmU2MS4u
YTEyOTkyYWUyYTNlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5j
CisrKyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMKQEAgLTczNyw4ICs3MzcsMTAg
QEAgc3RhdGljIGludCB0cG1fdGlzX3Byb2JlX2lycV9zaW5nbGUoc3RydWN0IHRwbV9jaGlwICpj
aGlwLCB1MzIgaW50bWFzaywKIAlpbnQgcmM7CiAJdTMyIGludF9zdGF0dXM7CiAKLQlpZiAoZGV2
bV9yZXF1ZXN0X2lycShjaGlwLT5kZXYucGFyZW50LCBpcnEsIHRpc19pbnRfaGFuZGxlciwgZmxh
Z3MsCi0JCQkgICAgIGRldl9uYW1lKCZjaGlwLT5kZXYpLCBjaGlwKSAhPSAwKSB7CisKKwlpZiAo
ZGV2bV9yZXF1ZXN0X3RocmVhZGVkX2lycShjaGlwLT5kZXYucGFyZW50LCBpcnEsIE5VTEwsCisJ
CQkJICAgICAgdGlzX2ludF9oYW5kbGVyLCBJUlFGX09ORVNIT1QgfCBmbGFncywKKwkJCQkgICAg
ICBkZXZfbmFtZSgmY2hpcC0+ZGV2KSwgY2hpcCkgIT0gMCkgewogCQlkZXZfaW5mbygmY2hpcC0+
ZGV2LCAiVW5hYmxlIHRvIHJlcXVlc3QgaXJxOiAlZCBmb3IgcHJvYmVcbiIsCiAJCQkgaXJxKTsK
IAkJcmV0dXJuIC0xOwotLSAKMi4zMS4xCgo=
