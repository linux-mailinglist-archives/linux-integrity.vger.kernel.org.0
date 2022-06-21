Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594E25533A2
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Jun 2022 15:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiFUNe0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Jun 2022 09:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351477AbiFUNbC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jun 2022 09:31:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016AC2AE14;
        Tue, 21 Jun 2022 06:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655817937;
        bh=maYa2L+CZbzp+f7QcA0qs/6WRE/UVVILl5dq1Oq1CAM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jmGV2LnecYwW01LEZV8rqOJgKasRC4jfmr8NZbQk01zyb04xCNE/x7l1rOpajEuYb
         TUl0WxVmgDxjR+Z4w/o9rpEfjXQT+StX7/6kQWG434NgbTpa4pDHWfalM4RvEp7dwu
         crUzqFFjUlGV5H66dwv7z1ngGnlfuVGg+Efj+3R8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.2.162]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAOJV-1nxMMt3X35-00Bu7r; Tue, 21
 Jun 2022 15:25:36 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, LinoSanfilippo@gmx.de, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: [PATCH v6 2/9] tpm, tpm_tis: Claim locality before writing TPM_INT_ENABLE register
Date:   Tue, 21 Jun 2022 15:24:40 +0200
Message-Id: <20220621132447.16281-3-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621132447.16281-1-LinoSanfilippo@gmx.de>
References: <20220621132447.16281-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:gifxAZRXM0plMBXYUpN8b4ed99qm35ucRjTWTjFlReD8vsJmBc5
 d3tVWL5zgA4oggV65gRT9mDOR8rEHcuuRAQ18/MDquAJG133DcznJ4nbhnyS33f+HI1gJHI
 ghYl/CppOys9N8s/3xGsdAifrvL1CPpERvhwIAxMzKxpa1nDlxwBwY7tBN2r/2z1g+QKp3Q
 uWyeet8A/v3f3xcjuW9OQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nrTty1lvEqg=:9P6xa22IfT28cH3BUJ4RlP
 +rkTA0zTSKyWwt1p2v3zMzfYxxaguVGbMTX3ouald+2PjTonHtFLNzKL5L5YGmywzlWszaRuj
 /I9nmyMFKm6qOzU9FhrwlCuFPZ06XN99lJJDPV4rUJIYXRYtuoGjHHr3Ocg4//gdsGGjjVPC5
 7WXAkn3N1sFGBaT5KEAq1bNAHwl/SdgYCTDm4m+zShZvRiOODUwYGOowCjSHq5am1Qk6twU62
 X0aJ2lmJa8fy4L2t9x2fs4GI3My1vh4uFySd3eTxZ+IWozjyp1XHC7EaJ+EfkcN/NfKYeNZ3V
 3sC1DRnoaEeJvgLUxZ0+mY+tp0DJ/SOeVQTbW0+l3P5N4LyOCxvEmHlTq9zEQ0K+7POvtYQL8
 65MuwnfDya9OuI6EHWN5XUPGeqdWr+wCOmhmvL+0soj9BkZzSF8hfaj38U8CnVI9R+dFkquyw
 EXSF7oihpMeCIr0H0isf4s2bWY43WTsum81G7wyGUCCIg+w0tyiWL9/whwFjr08CEzvy7hhUo
 utUCLhVJN3ej+jvhNdJis5YmIM32ujpEtkIwh1jRn43TurFGvuENzyDtxJO4Jp+OUj/ElTR7i
 1QQ8ADWPmRRksmSpNjpPunN4DIawiNwwy3/SxYss52F9/AtxpwAtm4vrKABlUE8G3JJKSaFDX
 1dS0OZfZsuq92/4YeOVeaWhKdcQv63faosNrMGs3KnmPm3wvn2AZVf3cIyv+ESCfZHArwmI+n
 6HIZkQfmfwn8iQRwkC3Xf6NgJTvKa3DKsJXzF+3RjjyID3/cxnn2DghZDQaTy22LsADVWMN04
 7kzc1DydYyO992Xz61Sv7g1ZV0JCbuV/8gB71e278NeapWXVcD4nE3L3FOfhr4Yimi+udYpi4
 goniTzUDUAZLofU5UBJeqwopwwMEJH0YoG0qbQaNhexXFhZFbnpDIZ8DSugvE/wZ4GBZ8GK8d
 CPNT3xq4tN8kQ1lYGbDUYoGfrhqoXQjLpI7THjqxwLFk4fvmqDJZzQXia4BhzbyulUI+6SyF7
 w1nX10ccMKBmXQfCqcNUIYQaj3kZiku8OjaB5N0sIbpPvpx6Xm4pTEZBzMg7zlO9QaH7Iomue
 Ry33nFaixGFIzoIADwIzjN1YfyqDlqMBYnil0gdu1WS1HfGjJPOmPEnRw==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkluIGRpc2Fi
bGVfaW50ZXJydXB0cygpIHRoZSBUUE1fR0xPQkFMX0lOVF9FTkFCTEUgYml0IGlzIHVuc2V0IGlu
IHRoZQpUUE1fSU5UX0VOQUJMRSByZWdpc3RlciB0byBzaHV0IHRoZSBpbnRlcnJ1cHRzIG9mZi4g
SG93ZXZlciBtb2RpZnlpbmcgdGhlCnJlZ2lzdGVyIGlzIG9ubHkgcG9zc2libGUgd2l0aCBhIGhl
bGQgbG9jYWxpdHkuIFNvIGNsYWltIHRoZSBsb2NhbGl0eQpiZWZvcmUgZGlzYWJsZV9pbnRlcnJ1
cHRzKCkgaXMgY2FsbGVkLgoKU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZp
bGlwcG9Aa3VuYnVzLmNvbT4KUmV2aWV3ZWQtYnk6IEphcmtrbyBTYWtraW5lbiA8amFya2tvQGtl
cm5lbC5vcmc+Ci0tLQogZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYyB8IDQgKysrKwog
MSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hh
ci90cG0vdHBtX3Rpc19jb3JlLmMgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCmlu
ZGV4IGI1ZmQ0ZmY0NjY2Ni4uMGU2OGU0NTAyYTU2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIv
dHBtL3RwbV90aXNfY29yZS5jCisrKyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMK
QEAgLTEwODQsNyArMTA4NCwxMSBAQCBpbnQgdHBtX3Rpc19jb3JlX2luaXQoc3RydWN0IGRldmlj
ZSAqZGV2LCBzdHJ1Y3QgdHBtX3Rpc19kYXRhICpwcml2LCBpbnQgaXJxLAogCQkJCWRldl9lcnIo
JmNoaXAtPmRldiwgRldfQlVHCiAJCQkJCSJUUE0gaW50ZXJydXB0IG5vdCB3b3JraW5nLCBwb2xs
aW5nIGluc3RlYWRcbiIpOwogCisJCQkJcmMgPSByZXF1ZXN0X2xvY2FsaXR5KGNoaXAsIDApOwor
CQkJCWlmIChyYyA8IDApCisJCQkJCWdvdG8gb3V0X2VycjsKIAkJCQlkaXNhYmxlX2ludGVycnVw
dHMoY2hpcCk7CisJCQkJcmVsZWFzZV9sb2NhbGl0eShjaGlwLCAwKTsKIAkJCX0KIAkJfSBlbHNl
IHsKIAkJCXRwbV90aXNfcHJvYmVfaXJxKGNoaXAsIGludG1hc2spOwotLSAKMi4zNi4xCgo=
