Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A721063144F
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Nov 2022 14:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiKTNcm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Nov 2022 08:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiKTNc3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Nov 2022 08:32:29 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E809254;
        Sun, 20 Nov 2022 05:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668951126; bh=Wzja5YwaKAZiFWUMEa0HIMVITjRNh5lgwkhDjVIIVv8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WI9WkzvqAEVlFAx3MSFarxoHXZ38m3UoVBGKV2bxv521t9ZMeYK3/S75R5P9hjGDg
         ab4V7zvRgndKizWT8DvP/9Aw99q6KtIC/ZIPE823oZLer7DCFILFkDsS7ntfinQ6hx
         nA0Ge3cYB+J7yY/sh/5ckOs1+0JCdLSh+XD0+sAQKqO5h3W/39AtG2zj8zq/Or4qoR
         gKARc+JazRAbBTy6OXo1THYJK56G8wBhYZU3Jzc+Jnp0oqqUyxm3Gi/fv4eGM0aUZB
         Jzv/GQLuwiOJoXcS74fja1y6T3BqGnjPh1S0xKOqzz1PMp2aKtbMmqdSIJHGIVSl8e
         0bB3B0duPSN0w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.7.17]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhQ6-1pJxlR3urM-00nhs3; Sun, 20
 Nov 2022 14:32:06 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v10 04/14] tpm, tpm_tis: Do not skip reset of original interrupt vector
Date:   Sun, 20 Nov 2022 14:31:24 +0100
Message-Id: <20221120133134.28926-5-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221120133134.28926-1-LinoSanfilippo@gmx.de>
References: <20221120133134.28926-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:VUd5I5eDNIynx/FyCcZmsE7B+Hj1CZFkjV5brjm+tc5mzgN2tIH
 eh0PWN/12QLtOELXmf0NMG5+HCPKEyA5G6L8UqJdL5epvFI9aEysg+NzXS60H1QEcbAXx0a
 D9oZ1PTbFWhorQp5mHR3Ptu9iCuxpGdn28/ST+U/z+3KV6PLNuwr9/qtpsaFwDlpRVOrwHU
 VKuaTChCH7d73U34ciS8g==
UI-OutboundReport: notjunk:1;M01:P0:asWYfnMi/Wo=;S+A6QUJ0wtwWQ7q2ybxhH9+aYvF
 U0HaOIIsKHYk6HBVUMH2mhQWYzo/5IRadKEyWsEvwBfsZj7FP/Avb2lBRFN0Peu7ezb5wYVwn
 GszS/t9X3woWxPTz3tTHZ8kl50mJRzwolWtFTY2mCQzxIIT+hmQjPY4+6/mSTWvZwvXv6GCsf
 s+Q/b9H68eAhI6tdd2ywlloM+pPl1C8oUafH3Wr7+h8lP9itrChA8aZdnaYLGTPqnKp1DGlZL
 IwS/WVR8LKEksKMYQ4JyyTT5MOnY7O/oKRz1FVh+a2KxLu/nZRFYwgRnvtWulVnX3rQFSxH3Q
 Dk5I12Yq3YrLayZAOezJlDq2cmMmx4qv6AxuZhmmgu/yypnULilvwdEj/jMJupT7FcTlm3T2M
 9yPMSwkDKHqqcD4s+j7pTl6AtDMuGWhju5oF7T6Vy4g22Ud1SM+CfYECU09XvCr+lEYMgRptR
 pThYNmL69AM3azQjRowL9HjV4QUccOGemxMr0S5gGxDkoJJkukXWs1cVoU9M8s6KOwbE55VaQ
 5jL184fv92djeX9fNmu/Sz506nH8T2jTc1ss6mOfVrX6PtM3q4KgQEpi2WAn5eMuZ0qkF+DmL
 og4bsoETA8babipE0pkHLTMvOFGVSz5VqzbAljeLAQAXeR3zp6l1FY0Uu0XuY5ApWknlZJOvM
 G58dicL7MZr3bdNvp+VVr4IshnvXBx8cTG2goeeoV/nVEdxqdWdP+7kNn/vz/X9oJxsYGGsOJ
 OYnW03gZF2+h6g+UT5Zehb70pN3BTQZllL8Qq0nnEsrOM7Q1fSsOjgIwCPJw4lXFxsYNs5zZ1
 QWj5Rf7IdzjP2O19GN4xSo8OdjYBEOtybR0CQ+6BWdNG5DfuprvBeawm+QTkgZHw6enaaeYbX
 JTI3l64q3d+sQCu2JrL1NlblPrKzImtSg/u6xWPEy0DtUuFo1ho5j5Ve5sJLC/0yfoDfIzkGw
 FIu9Rw==
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCklmIGluIHRw
bV90aXNfcHJvYmVfaXJxX3NpbmdsZSgpIGFuIGVycm9yIG9jY3VycyBhZnRlciB0aGUgb3JpZ2lu
YWwKaW50ZXJydXB0IHZlY3RvciBoYXMgYmVlbiByZWFkLCByZXN0b3JlIHRoZSBpbnRlcnJ1cHRz
IGJlZm9yZSB0aGUgZXJyb3IgaXMKcmV0dXJuZWQuCgpTaW5jZSB0aGUgY2FsbGVyIGRvZXMgbm90
IGNoZWNrIHRoZSBlcnJvciB2YWx1ZSwgcmV0dXJuIC0xIGluIGFueSBjYXNlIHRoYXQKdGhlIFRQ
TV9DSElQX0ZMQUdfSVJRIGZsYWcgaXMgbm90IHNldC4gU2luY2UgdGhlIHJldHVybiB2YWx1ZSBv
ZiBmdW5jdGlvbgp0cG1fdGlzX2dlbl9pbnRlcnJ1cHQoKSBpcyBub3QgbG9uZ2VyIHVzZWQsIG1h
a2UgaXQgYSB2b2lkIGZ1bmN0aW9uLgoKRml4ZXM6IDExMDdkMDY1ZmRmMSAoInRwbV90aXM6IElu
dHJvZHVjZSBpbnRlcm1lZGlhdGUgbGF5ZXIgZm9yIFRQTSBhY2Nlc3MiKQpTaWduZWQtb2ZmLWJ5
OiBMaW5vIFNhbmZpbGlwcG8gPGwuc2FuZmlsaXBwb0BrdW5idXMuY29tPgotLS0KIGRyaXZlcnMv
Y2hhci90cG0vdHBtX3Rpc19jb3JlLmMgfCAzMyArKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0t
LS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jIGIvZHJpdmVycy9j
aGFyL3RwbS90cG1fdGlzX2NvcmUuYwppbmRleCA2MDNiODJjYTU2ZGEuLjFlYWMxMjc5NTk0ZCAx
MDA2NDQKLS0tIGEvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYworKysgYi9kcml2ZXJz
L2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCkBAIC03MjksNyArNzI5LDcgQEAgc3RhdGljIGlycXJl
dHVybl90IHRpc19pbnRfaGFuZGxlcihpbnQgZHVtbXksIHZvaWQgKmRldl9pZCkKIAlyZXR1cm4g
SVJRX0hBTkRMRUQ7CiB9CiAKLXN0YXRpYyBpbnQgdHBtX3Rpc19nZW5faW50ZXJydXB0KHN0cnVj
dCB0cG1fY2hpcCAqY2hpcCkKK3N0YXRpYyB2b2lkIHRwbV90aXNfZ2VuX2ludGVycnVwdChzdHJ1
Y3QgdHBtX2NoaXAgKmNoaXApCiB7CiAJY29uc3QgY2hhciAqZGVzYyA9ICJhdHRlbXB0aW5nIHRv
IGdlbmVyYXRlIGFuIGludGVycnVwdCI7CiAJdTMyIGNhcDI7CkBAIC03MzgsMTYgKzczOCwxNCBA
QCBzdGF0aWMgaW50IHRwbV90aXNfZ2VuX2ludGVycnVwdChzdHJ1Y3QgdHBtX2NoaXAgKmNoaXAp
CiAKIAlyZXQgPSByZXF1ZXN0X2xvY2FsaXR5KGNoaXAsIDApOwogCWlmIChyZXQgPCAwKQotCQly
ZXR1cm4gcmV0OworCQlyZXR1cm47CiAKIAlpZiAoY2hpcC0+ZmxhZ3MgJiBUUE1fQ0hJUF9GTEFH
X1RQTTIpCi0JCXJldCA9IHRwbTJfZ2V0X3RwbV9wdChjaGlwLCAweDEwMCwgJmNhcDIsIGRlc2Mp
OworCQl0cG0yX2dldF90cG1fcHQoY2hpcCwgMHgxMDAsICZjYXAyLCBkZXNjKTsKIAllbHNlCi0J
CXJldCA9IHRwbTFfZ2V0Y2FwKGNoaXAsIFRQTV9DQVBfUFJPUF9USVNfVElNRU9VVCwgJmNhcCwg
ZGVzYywgMCk7CisJCXRwbTFfZ2V0Y2FwKGNoaXAsIFRQTV9DQVBfUFJPUF9USVNfVElNRU9VVCwg
JmNhcCwgZGVzYywgMCk7CiAKIAlyZWxlYXNlX2xvY2FsaXR5KGNoaXAsIDApOwotCi0JcmV0dXJu
IHJldDsKIH0KIAogLyogUmVnaXN0ZXIgdGhlIElSUSBhbmQgaXNzdWUgYSBjb21tYW5kIHRoYXQg
d2lsbCBjYXVzZSBhbiBpbnRlcnJ1cHQuIElmIGFuCkBAIC03NzcsNDIgKzc3NSwzNyBAQCBzdGF0
aWMgaW50IHRwbV90aXNfcHJvYmVfaXJxX3NpbmdsZShzdHJ1Y3QgdHBtX2NoaXAgKmNoaXAsIHUz
MiBpbnRtYXNrLAogCiAJcmMgPSB0cG1fdGlzX3dyaXRlOChwcml2LCBUUE1fSU5UX1ZFQ1RPUihw
cml2LT5sb2NhbGl0eSksIGlycSk7CiAJaWYgKHJjIDwgMCkKLQkJcmV0dXJuIHJjOworCQlnb3Rv
IHJlc3RvcmVfaXJxczsKIAogCXJjID0gdHBtX3Rpc19yZWFkMzIocHJpdiwgVFBNX0lOVF9TVEFU
VVMocHJpdi0+bG9jYWxpdHkpLCAmaW50X3N0YXR1cyk7CiAJaWYgKHJjIDwgMCkKLQkJcmV0dXJu
IHJjOworCQlnb3RvIHJlc3RvcmVfaXJxczsKIAogCS8qIENsZWFyIGFsbCBleGlzdGluZyAqLwog
CXJjID0gdHBtX3Rpc193cml0ZTMyKHByaXYsIFRQTV9JTlRfU1RBVFVTKHByaXYtPmxvY2FsaXR5
KSwgaW50X3N0YXR1cyk7CiAJaWYgKHJjIDwgMCkKLQkJcmV0dXJuIHJjOwotCisJCWdvdG8gcmVz
dG9yZV9pcnFzOwogCS8qIFR1cm4gb24gKi8KIAlyYyA9IHRwbV90aXNfd3JpdGUzMihwcml2LCBU
UE1fSU5UX0VOQUJMRShwcml2LT5sb2NhbGl0eSksCiAJCQkgICAgIGludG1hc2sgfCBUUE1fR0xP
QkFMX0lOVF9FTkFCTEUpOwogCWlmIChyYyA8IDApCi0JCXJldHVybiByYzsKKwkJZ290byByZXN0
b3JlX2lycXM7CiAKIAljbGVhcl9iaXQoVFBNX1RJU19JUlFfVEVTVEVELCAmcHJpdi0+ZmxhZ3Mp
OwogCiAJLyogR2VuZXJhdGUgYW4gaW50ZXJydXB0IGJ5IGhhdmluZyB0aGUgY29yZSBjYWxsIHRo
cm91Z2ggdG8KIAkgKiB0cG1fdGlzX3NlbmQKIAkgKi8KLQlyYyA9IHRwbV90aXNfZ2VuX2ludGVy
cnVwdChjaGlwKTsKLQlpZiAocmMgPCAwKQotCQlyZXR1cm4gcmM7CisJdHBtX3Rpc19nZW5faW50
ZXJydXB0KGNoaXApOwogCityZXN0b3JlX2lycXM6CiAJLyogdHBtX3Rpc19zZW5kIHdpbGwgZWl0
aGVyIGNvbmZpcm0gdGhlIGludGVycnVwdCBpcyB3b3JraW5nIG9yIGl0CiAJICogd2lsbCBjYWxs
IGRpc2FibGVfaXJxIHdoaWNoIHVuZG9lcyBhbGwgb2YgdGhlIGFib3ZlLgogCSAqLwogCWlmICgh
KGNoaXAtPmZsYWdzICYgVFBNX0NISVBfRkxBR19JUlEpKSB7Ci0JCXJjID0gdHBtX3Rpc193cml0
ZTgocHJpdiwgb3JpZ2luYWxfaW50X3ZlYywKLQkJCQlUUE1fSU5UX1ZFQ1RPUihwcml2LT5sb2Nh
bGl0eSkpOwotCQlpZiAocmMgPCAwKQotCQkJcmV0dXJuIHJjOwotCi0JCXJldHVybiAxOworCQl0
cG1fdGlzX3dyaXRlOChwcml2LCBvcmlnaW5hbF9pbnRfdmVjLAorCQkJICAgICAgIFRQTV9JTlRf
VkVDVE9SKHByaXYtPmxvY2FsaXR5KSk7CisJCXJldHVybiAtMTsKIAl9CiAKIAlyZXR1cm4gMDsK
LS0gCjIuMzYuMQoK
