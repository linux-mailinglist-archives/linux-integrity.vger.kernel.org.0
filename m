Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21323546521
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jun 2022 13:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346627AbiFJLJc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jun 2022 07:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348322AbiFJLJY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jun 2022 07:09:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81EA14642B;
        Fri, 10 Jun 2022 04:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654859344;
        bh=cRKDsGN0VdsCFTBnRcstCXzf84DjLh3s5S//H6evbxU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=RxvoEM2s+GCQWM8A+/5BrjdTPCe9c9CIHvswgUwXjKtrwa8Bh1/Cnfi68qad2XeMA
         /HDZYht5oWlChjbdATxTWqYm/u5vg3ff3iE6nmmsF0b4g6z4uaO4yGlNN2dL/RV4id
         NRLRDrLTC8i8mNBBt1TSn4DdoRFe4q3cgJQm5maA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.3.165]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhQ6-1nNEtv3Rky-00njsc; Fri, 10
 Jun 2022 13:09:03 +0200
From:   LinoSanfilippo@gmx.de
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, LinoSanfilippo@gmx.de, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: [PATCH v5 01/10] tpm, tpm_tis: Avoid cache incoherency in test for interrupts
Date:   Fri, 10 Jun 2022 13:08:37 +0200
Message-Id: <20220610110846.8307-2-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
References: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:q8bU0YAnT48OWQ7N8IAEbPbVAzWl5CCrfbTQSDm5sbhGjdqIjlf
 LbPynvy15Ag5+DzsHakUiEJN8MAPK3p2HVIPpLQmW9Jzl9oSsSoxhzQYbvj+qFcNP9d5Xyo
 rMu8RFCICskwoiPKXu4yquCQ8+rtWeySkPHonWidwznKy+CcyivcOWXgVNob0aLl7v/Ms1S
 aJHRweNtbDjWhkWs5ujDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d09viExLtiY=:zlE2J+H0tdbp/D9Rgg8PAj
 UgB3M2NRHpR20pM03pyVo3iXvCpwIn6uPuMVqLE4jm7xzGex8nYgqZT35nvulLLlHPCVzcykg
 zqzYDdwiBthklFrHcM4cR2PfnzxiTlI+kXRiUyVDol+aAgXZpr1fwIonwjeK3f5vB5+JrUZvs
 2Y5Z0XLEtOAIjWQ4+y9mhs6LwLRx2GVcpeafRwRhXtlO+iDpR2OM9aTZnrNMZyb6hFjkYopQ1
 pv0dKmkquDNG2kcRoRpaG2T42T5wuL2ElX6GninO6sSUjNtfSwm+fC1KyzN1Fqzu1g38LBBHs
 JhxVjofqierOSIOve5aNfGw5E5L2M4nEmL4b0TRbkXqBSdB0trfEQqjkU9zTixCezgCoeFUQD
 BGYTlWm562KAlmqHgHtoYopbtQrMNmxzRbygsy3kBUbDHRxkJRh61LqhqyT4PiuGD/C/10sF5
 CmXt3+3OZ/44E/mXiEO/jEAUauE6VmAJSoctpAF0lm2zxPESEmCrP6rAj6XdXf60Yh35tf0kY
 r+oNnVgE7PY99noQKCiaT1rQ/oTj05h2aZK8IHQxMvGOMR+eq9glEodkmrgQR3DwihfHoGwF2
 xkMEXV0MDV3hVQ0r7AGVUJgrqzUXJ5INnM5OdyDJisDrpIU3DaCiyxZw1lYcbauRt4pEiRNwH
 f+RdFuzkO675eiVrKBFf1dCM2vdTbep6icKfWROLuz5pG4xIxx8t6jhaeFtELj9QuCx0e9YQx
 RUvFxunDP/SUP+NrIC9SdSxJxyR07l0nVV00MKMiuK567KhACO+SRfBe6luXJ1UUZw3yKBxQR
 m6kD9IqS4ZheaESBWcahczLpr0h6bgiWHK7EfzMUhLr6Fw//pD4UWm8k4bOYBizjGZqiLIF4n
 t/6gRjOD5HOReUHDnKsqOQAkYv6AUsS18XSkG95r8JdBGt21V/OuNwaFsVBsvjc0BO73roDF7
 fA95DKkF8UWsCc8xLEU5qPxeis2huJioWO8kA/W7z0zq+Ulyf/pxqi6uOTuoQvpdBY8D8kGcq
 3lejuEPHaBZjzHWYbW+gVjf3sn4VVcOHK78LpPrKt3q1woyYbcrCQmKz2qX2rsa8hAvBBthPM
 ZTmfIHcUrXou4du8VYN7iyb6S8YpwXnk/5Uff28GKsVuITRuQrBn8S+ZQ==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KClRoZSBpbnRl
cnJ1cHQgaGFuZGxlciB0aGF0IHNldHMgdGhlIGJvb2xlYW4gdmFyaWFibGUgaXJxX3Rlc3RlZCBt
YXkgcnVuIG9uCmFub3RoZXIgQ1BVIGFzIHRoZSB0aHJlYWQgdGhhdCBjaGVja3MgaXJxX3Rlc3Rl
ZCBhcyBwYXJ0IG9mIHRoZSBpcnEgdGVzdCBpbgp0bXBfdGlzX3NlbmQoKS4KClNpbmNlIG5vdGhp
bmcgZ3VhcmFudGVlcyBjYWNoZSBjb2hlcmVuY3kgYmV0d2VlbiBDUFVzIGZvciB1bnN5bmNocm9u
aXplZAphY2Nlc3NlcyB0byBib29sZWFuIHZhcmlhYmxlcyB0aGUgdGVzdGluZyB0aHJlYWQgbWln
aHQgbm90IHBlcmNlaXZlIHRoZQp2YWx1ZSBjaGFuZ2UgZG9uZSBpbiB0aGUgaW50ZXJydXB0IGhh
bmRsZXIuCgpBdm9pZCB0aGlzIGlzc3VlIGJ5IHVzaW5nIGEgYml0ZmllbGQgaW5zdGVhZCBvZiBh
IGJvb2xlYW4gdmFyaWFibGUgYW5kIGJ5CmFjY2Vzc2luZyB0aGlzIGZpZWxkIHdpdGggdGhlIGJp
dCBtYW5pcHVsYXRpbmcgZnVuY3Rpb25zIHRoYXQgcHJvdmlkZSBjYWNoZQpjb2hlcmVuY3kuCgpT
aWduZWQtb2ZmLWJ5OiBMaW5vIFNhbmZpbGlwcG8gPGwuc2FuZmlsaXBwb0BrdW5idXMuY29tPgot
LS0KIGRyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMgfCAxMyArKysrKysrLS0tLS0tCiBk
cml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5oIHwgIDYgKysrKystCiAyIGZpbGVzIGNoYW5n
ZWQsIDEyIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3Jl
LmMKaW5kZXggZGM1NmI5NzZkODE2Li42ZjJjZjc1YWRkOGIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Y2hhci90cG0vdHBtX3Rpc19jb3JlLmMKKysrIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2Nv
cmUuYwpAQCAtNDcwLDcgKzQ3MCw4IEBAIHN0YXRpYyBpbnQgdHBtX3Rpc19zZW5kKHN0cnVjdCB0
cG1fY2hpcCAqY2hpcCwgdTggKmJ1Ziwgc2l6ZV90IGxlbikKIAlpbnQgcmMsIGlycTsKIAlzdHJ1
Y3QgdHBtX3Rpc19kYXRhICpwcml2ID0gZGV2X2dldF9kcnZkYXRhKCZjaGlwLT5kZXYpOwogCi0J
aWYgKCEoY2hpcC0+ZmxhZ3MgJiBUUE1fQ0hJUF9GTEFHX0lSUSkgfHwgcHJpdi0+aXJxX3Rlc3Rl
ZCkKKwlpZiAoIShjaGlwLT5mbGFncyAmIFRQTV9DSElQX0ZMQUdfSVJRKSB8fAorCSAgICAgdGVz
dF9iaXQoVFBNX1RJU19JUlFfVEVTVEVELCAmcHJpdi0+aXJxdGVzdF9mbGFncykpCiAJCXJldHVy
biB0cG1fdGlzX3NlbmRfbWFpbihjaGlwLCBidWYsIGxlbik7CiAKIAkvKiBWZXJpZnkgcmVjZWlw
dCBvZiB0aGUgZXhwZWN0ZWQgSVJRICovCkBAIC00ODAsMTEgKzQ4MSwxMSBAQCBzdGF0aWMgaW50
IHRwbV90aXNfc2VuZChzdHJ1Y3QgdHBtX2NoaXAgKmNoaXAsIHU4ICpidWYsIHNpemVfdCBsZW4p
CiAJcmMgPSB0cG1fdGlzX3NlbmRfbWFpbihjaGlwLCBidWYsIGxlbik7CiAJcHJpdi0+aXJxID0g
aXJxOwogCWNoaXAtPmZsYWdzIHw9IFRQTV9DSElQX0ZMQUdfSVJROwotCWlmICghcHJpdi0+aXJx
X3Rlc3RlZCkKKwlpZiAoIXRlc3RfYml0KFRQTV9USVNfSVJRX1RFU1RFRCwgJnByaXYtPmlycXRl
c3RfZmxhZ3MpKQogCQl0cG1fbXNsZWVwKDEpOwotCWlmICghcHJpdi0+aXJxX3Rlc3RlZCkKKwlp
ZiAoIXRlc3RfYml0KFRQTV9USVNfSVJRX1RFU1RFRCwgJnByaXYtPmlycXRlc3RfZmxhZ3MpKQog
CQlkaXNhYmxlX2ludGVycnVwdHMoY2hpcCk7Ci0JcHJpdi0+aXJxX3Rlc3RlZCA9IHRydWU7CisJ
c2V0X2JpdChUUE1fVElTX0lSUV9URVNURUQsICZwcml2LT5pcnF0ZXN0X2ZsYWdzKTsKIAlyZXR1
cm4gcmM7CiB9CiAKQEAgLTY5Myw3ICs2OTQsNyBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgdGlzX2lu
dF9oYW5kbGVyKGludCBkdW1teSwgdm9pZCAqZGV2X2lkKQogCWlmIChpbnRlcnJ1cHQgPT0gMCkK
IAkJcmV0dXJuIElSUV9OT05FOwogCi0JcHJpdi0+aXJxX3Rlc3RlZCA9IHRydWU7CisJc2V0X2Jp
dChUUE1fVElTX0lSUV9URVNURUQsICZwcml2LT5pcnF0ZXN0X2ZsYWdzKTsKIAlpZiAoaW50ZXJy
dXB0ICYgVFBNX0lOVEZfREFUQV9BVkFJTF9JTlQpCiAJCXdha2VfdXBfaW50ZXJydXB0aWJsZSgm
cHJpdi0+cmVhZF9xdWV1ZSk7CiAJaWYgKGludGVycnVwdCAmIFRQTV9JTlRGX0xPQ0FMSVRZX0NI
QU5HRV9JTlQpCkBAIC03NzksNyArNzgwLDcgQEAgc3RhdGljIGludCB0cG1fdGlzX3Byb2JlX2ly
cV9zaW5nbGUoc3RydWN0IHRwbV9jaGlwICpjaGlwLCB1MzIgaW50bWFzaywKIAlpZiAocmMgPCAw
KQogCQlyZXR1cm4gcmM7CiAKLQlwcml2LT5pcnFfdGVzdGVkID0gZmFsc2U7CisJY2xlYXJfYml0
KFRQTV9USVNfSVJRX1RFU1RFRCwgJnByaXYtPmlycXRlc3RfZmxhZ3MpOwogCiAJLyogR2VuZXJh
dGUgYW4gaW50ZXJydXB0IGJ5IGhhdmluZyB0aGUgY29yZSBjYWxsIHRocm91Z2ggdG8KIAkgKiB0
cG1fdGlzX3NlbmQKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmgg
Yi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5oCmluZGV4IDNiZTI0ZjIyMWUzMi4uMGYy
OWQwYjY4YzNlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5oCisr
KyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmgKQEAgLTg4LDExICs4OCwxNSBAQCBl
bnVtIHRwbV90aXNfZmxhZ3MgewogCVRQTV9USVNfSU5WQUxJRF9TVEFUVVMJCT0gQklUKDEpLAog
fTsKIAorZW51bSB0cG1fdGlzX2lycXRlc3RfZmxhZ3MgeworCVRQTV9USVNfSVJRX1RFU1RFRAkJ
PSBCSVQoMCksCit9OworCiBzdHJ1Y3QgdHBtX3Rpc19kYXRhIHsKIAl1MTYgbWFudWZhY3R1cmVy
X2lkOwogCWludCBsb2NhbGl0eTsKIAlpbnQgaXJxOwotCWJvb2wgaXJxX3Rlc3RlZDsKKwl1bnNp
Z25lZCBsb25nIGlycXRlc3RfZmxhZ3M7CiAJdW5zaWduZWQgbG9uZyBmbGFnczsKIAl2b2lkIF9f
aW9tZW0gKmlsYl9iYXNlX2FkZHI7CiAJdTE2IGNsa3J1bl9lbmFibGVkOwotLSAKMi4zNi4xCgo=
