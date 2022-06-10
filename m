Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BEE546517
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jun 2022 13:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348046AbiFJLJ2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jun 2022 07:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347832AbiFJLJX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jun 2022 07:09:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D7D14640A;
        Fri, 10 Jun 2022 04:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654859345;
        bh=mLuSt9GrDvQ8CHVFpIFl/BDsUxB55rqACDGcwmQPwX0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=IggaaXsWOn6fl59/cFAZmlF3IkeQkvdvCn6nwxUv17A2xnKSm5Umao0tjJt1rAGr7
         Jl0CLIXrachWQPVcYAuR0M7wOu1NrqM7z/tb++BaUB1FLnvICzF8aK3QhrNkDjgeY6
         a4kJAtGbUgXYXTC2Xw/1lBqCwtP1uj5M7cH80guI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.3.165]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McH5a-1nTrfJ1zEy-00cjOA; Fri, 10
 Jun 2022 13:09:05 +0200
From:   LinoSanfilippo@gmx.de
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, LinoSanfilippo@gmx.de, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: [PATCH v5 06/10] tpm, tpm_tis: Only handle supported interrupts in wait_for_tpm_stat()
Date:   Fri, 10 Jun 2022 13:08:42 +0200
Message-Id: <20220610110846.8307-7-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
References: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:V9ZSj7NtP38cs9cWw3vp2komO17Wj/HumTOgtp20/73V9KjgMfa
 cvye23uGL22ne2bQCUvSEnEZSRd2LGYpIW2f1Pr4LB9MFX6umJcv1JcLmukQFWQU0y/plI7
 nLxfJDs3GEdt9sHnA+6ZVTIFrN1Difx0pvAhMY2ceYWjBm5akUvMsLxqkKlJF3gWf01eSzF
 pJTpVRo7VVzhElkFB+bOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mhz9Ol5hJp4=:DOvdfBWCHo8CQkhJ5W44gL
 yMtxWCBVPO4LD2R4Di/MALIDlwcUB62NLcoN2gwWLtyehDCcuL8dCjMYnsL2SJGW+F1OYjkQG
 BxCtsdsSDuzY6PPNCY3WwzlKZvyBy3Q5Gj2BlFwqQAxZeYWZscXE/J0CisjknJfH3Vx9nCPnW
 QwkQnUYXpioWfvXRbObBZBSnc0hmotHQg9NqzgWvi6XxuPBYPqx5Kvsvt3tdfoVtIe9Kp1APZ
 tdt7trTESd110gyCSVfciILTQFKn4blPs2NmWvvOxLfa235w66IFn7J0WDy7iQLjPJcOMfTan
 sumz+UWGpMtWVAKM+fGkXMqTw42Jyys2rRVt9nRxNQR2yqZoBcuLzUsdql5JGky2NZtZLAc70
 dj5VmipviVxpgjfcwDhmDQ5q9PLh/bxuZCEpQ3P0JO+6+Bw9sZHKZTYHmn3g10+Pu3QznnkBd
 xN7qq3qBKVM1sLc5bfnM3NgKe2uDUujAsNWpVZdxg1tYCE0PeCmbQh89jO48pVB64mL3xCShw
 K/OLrH755ysLixZ4V7Wr+JQaQJqdLpzpoqNUAe5uvp+dkvS0CDwMH+5bfxxadCCxQtNRYBpPK
 WES+97JYROXZhkTsxQNjJHx43tHnbLgSio+O6wwHBZYL4zAtTetNicccUh7UcJFuuG8avWHU2
 dQYWQzNYMrq1sG/1OxCkwbo4zyqxoc2+BCLCfVzJACxKFLRlhf9+eyQPLNcF5b6nkw2hi/hyw
 wNx6WVu3p2xFjPTyff6onISMj3x7IjPi9TbwxaJ4SNd51Jx/qbMnhFeK/lqWr1tGlEiHYesZS
 Zq6+eNNk0mi2VD0pfDBz+A15kH+goiHYXqcsuPwUxqMUPvyAOos77MlBnrA7qPzprMCuHxAQy
 xJOFQ3ESYkBvEUa0uixQSI6SPQuePVNjU44G0w+wuOw1MVoqJ7wGIfTT8BETUB+k2urNdogeh
 jz3Ks6x5/Up74iC1zZgSFAuaIhTHFbRFijYYJLtwjradAvuE7owfxvut/YKS7js2+4GzqtvpB
 AkSggowdK9xQoubhQacwbGRb4pACqZqGD0HZapke12h6B3pv4jwzE7PrHq1n4YfNc8D+9G5uL
 lNLd5lbx9mD2NaeaQdzbZtZ66lXz6RunpN5YZsCSSHZXVh3fZ0habllkA==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkFjY29yZGlu
ZyB0byB0aGUgVFBNIEludGVyZmFjZSBTcGVjaWZpY2F0aW9uIChUSVMpIGludGVycnVwdHMgZm9y
CiJzdHNWYWxpZCIgYW5kICJjb21tYW5kUmVhZHkiIG1pZ2h0IG5vdCBiZSBzdXBwb3J0ZWQuCgpU
YWtlIHRoaXMgaW50byBhY2NvdW50IGFuZCBvbmx5IHdhaXQgZm9yIGludGVycnVwdHMgd2hpY2gg
YXJlIGFjdHVhbGx5IGluCnVzZSBpbiB3YWl0X2Zvcl90cG1fc3RhdCgpLiBBZnRlciB0aGF0IHBy
b2Nlc3MgYWxsIHRoZSByZW1haW5pbmcgc3RhdHVzCmNoYW5nZXMgYnkgcG9sbGluZyB0aGUgc3Rh
dHVzIHJlZ2lzdGVyLgoKU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlw
cG9Aa3VuYnVzLmNvbT4KLS0tCiBkcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jIHwgNDYg
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMzQgaW5z
ZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL3Rw
bS90cG1fdGlzX2NvcmUuYyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMKaW5kZXgg
MmYwM2ZlZmExNzA2Li4wMjhiZWM0NDM2MmQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY2hhci90cG0v
dHBtX3Rpc19jb3JlLmMKKysrIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwpAQCAt
NTMsNDEgKzUzLDYzIEBAIHN0YXRpYyBpbnQgd2FpdF9mb3JfdHBtX3N0YXQoc3RydWN0IHRwbV9j
aGlwICpjaGlwLCB1OCBtYXNrLAogCWxvbmcgcmM7CiAJdTggc3RhdHVzOwogCWJvb2wgY2FuY2Vs
ZWQgPSBmYWxzZTsKKwl1OCBhY3RpdmVfaXJxcyA9IDA7CisJaW50IHJldCA9IDA7CiAKIAkvKiBj
aGVjayBjdXJyZW50IHN0YXR1cyAqLwogCXN0YXR1cyA9IGNoaXAtPm9wcy0+c3RhdHVzKGNoaXAp
OwogCWlmICgoc3RhdHVzICYgbWFzaykgPT0gbWFzaykKIAkJcmV0dXJuIDA7CiAKLQlzdG9wID0g
amlmZmllcyArIHRpbWVvdXQ7CisJLyogY2hlY2sgd2hhdCBzdGF0dXMgY2hhbmdlcyBjYW4gYmUg
aGFuZGxlZCBieSBpcnFzICovCisJaWYgKHByaXYtPmlycXNfaW5fdXNlICYgVFBNX0lOVEZfU1RT
X1ZBTElEX0lOVCkKKwkJYWN0aXZlX2lycXMgfD0gVFBNX1NUU19WQUxJRDsKIAotCWlmIChjaGlw
LT5mbGFncyAmIFRQTV9DSElQX0ZMQUdfSVJRKSB7CisJaWYgKHByaXYtPmlycXNfaW5fdXNlICYg
VFBNX0lOVEZfREFUQV9BVkFJTF9JTlQpCisJCWFjdGl2ZV9pcnFzIHw9IFRQTV9TVFNfREFUQV9B
VkFJTDsKKworCWlmIChwcml2LT5pcnFzX2luX3VzZSAmIFRQTV9JTlRGX0NNRF9SRUFEWV9JTlQp
CisJCWFjdGl2ZV9pcnFzIHw9IFRQTV9TVFNfQ09NTUFORF9SRUFEWTsKKworCWFjdGl2ZV9pcnFz
ICY9IG1hc2s7CisKKwlzdG9wID0gamlmZmllcyArIHRpbWVvdXQ7CisJLyogcHJvY2VzcyBzdGF0
dXMgY2hhbmdlcyB3aXRoIGlycSBzdXBwb3J0ICovCisJaWYgKGFjdGl2ZV9pcnFzKSB7CisJCXJl
dCA9IC1FVElNRTsKIGFnYWluOgogCQl0aW1lb3V0ID0gc3RvcCAtIGppZmZpZXM7CiAJCWlmICgo
bG9uZyl0aW1lb3V0IDw9IDApCiAJCQlyZXR1cm4gLUVUSU1FOwogCQlyYyA9IHdhaXRfZXZlbnRf
aW50ZXJydXB0aWJsZV90aW1lb3V0KCpxdWV1ZSwKLQkJCXdhaXRfZm9yX3RwbV9zdGF0X2NvbmQo
Y2hpcCwgbWFzaywgY2hlY2tfY2FuY2VsLAorCQkJd2FpdF9mb3JfdHBtX3N0YXRfY29uZChjaGlw
LCBhY3RpdmVfaXJxcywgY2hlY2tfY2FuY2VsLAogCQkJCQkgICAgICAgJmNhbmNlbGVkKSwKIAkJ
CXRpbWVvdXQpOwogCQlpZiAocmMgPiAwKSB7CiAJCQlpZiAoY2FuY2VsZWQpCiAJCQkJcmV0dXJu
IC1FQ0FOQ0VMRUQ7Ci0JCQlyZXR1cm4gMDsKKwkJCXJldCA9IDA7CiAJCX0KIAkJaWYgKHJjID09
IC1FUkVTVEFSVFNZUyAmJiBmcmVlemluZyhjdXJyZW50KSkgewogCQkJY2xlYXJfdGhyZWFkX2Zs
YWcoVElGX1NJR1BFTkRJTkcpOwogCQkJZ290byBhZ2FpbjsKIAkJfQotCX0gZWxzZSB7Ci0JCWRv
IHsKLQkJCXVzbGVlcF9yYW5nZShwcml2LT50aW1lb3V0X21pbiwKLQkJCQkgICAgIHByaXYtPnRp
bWVvdXRfbWF4KTsKLQkJCXN0YXR1cyA9IGNoaXAtPm9wcy0+c3RhdHVzKGNoaXApOwotCQkJaWYg
KChzdGF0dXMgJiBtYXNrKSA9PSBtYXNrKQotCQkJCXJldHVybiAwOwotCQl9IHdoaWxlICh0aW1l
X2JlZm9yZShqaWZmaWVzLCBzdG9wKSk7CiAJfQorCisJaWYgKHJldCkKKwkJcmV0dXJuIHJldDsK
KworCW1hc2sgJj0gfmFjdGl2ZV9pcnFzOworCWlmICghbWFzaykgLyogYWxsIGRvbmUgKi8KKwkJ
cmV0dXJuIDA7CisJLyogcHJvY2VzcyBzdGF0dXMgY2hhbmdlcyB3aXRob3V0IGlycSBzdXBwb3J0
ICovCisJZG8geworCQlzdGF0dXMgPSBjaGlwLT5vcHMtPnN0YXR1cyhjaGlwKTsKKwkJaWYgKChz
dGF0dXMgJiBtYXNrKSA9PSBtYXNrKQorCQkJcmV0dXJuIDA7CisJCXVzbGVlcF9yYW5nZShwcml2
LT50aW1lb3V0X21pbiwKKwkJCSAgICAgcHJpdi0+dGltZW91dF9tYXgpOworCX0gd2hpbGUgKHRp
bWVfYmVmb3JlKGppZmZpZXMsIHN0b3ApKTsKIAlyZXR1cm4gLUVUSU1FOwogfQogCi0tIAoyLjM2
LjEKCg==
