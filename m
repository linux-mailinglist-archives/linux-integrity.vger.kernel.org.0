Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D08051F6FC
	for <lists+linux-integrity@lfdr.de>; Mon,  9 May 2022 10:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbiEIIqa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 May 2022 04:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbiEIIOw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 May 2022 04:14:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE246473F;
        Mon,  9 May 2022 01:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652083626;
        bh=MlFNdZlzZ1snP/e8iwy/NN+cugdEdZuPrb2VR9D/dQ4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=O8QrEhCGbPZo4V0UbdRtWXDGegJxC/q7TxlkZFDu8D7KDYCKO54G05lBP1exTUysf
         0gZR4rKMVnRMGjvdE/lY2+/piYIwZeCm2hx+DUahgx3qa4B5PRDQElsw+AoUYvzIz7
         zXZ2N5xIns7U7iIm2+mfVazWNG4piP/myJ64X97M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.3.89]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBDnC-1neeTk2glq-00CimZ; Mon, 09
 May 2022 10:07:06 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v4 3/6] tpm, tpm_tis: enable irq test
Date:   Mon,  9 May 2022 10:05:56 +0200
Message-Id: <20220509080559.4381-4-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220509080559.4381-1-LinoSanfilippo@gmx.de>
References: <20220509080559.4381-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:yDUEsYMEp33tNMI3hYBWQ7K+MU7i9kK/HNCWtJpBfpdLjIDGXmK
 hK65PnsSMXLlSD9PJiEOIRbsYskx1mVM9YanE8G/Lh2vd0DLw2RwmQ4glhRYg+eStG7eN0a
 JDPxDqG97Vm4P0cQY0BBPqS9ozql8x/IN4+dOXvJLlYKTb66taHWzAbqSHXCszUb4y/mRQF
 MType551/F0d1hn0BayCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eoh8oySfHEU=:a46htkS9luq/lb4KtZLhWp
 fLXOYEjfcOSsAtHxybz+hKDW5UpEcg04hhwxMRxutiqr3uH+D5thZD0MKulPSjIm+byVpGsrf
 5rDQfGBl+al4O0I58RvBLRc1UpSB3cdqFf9VtO3jxYV563PIPabBIlJyyjsUU1Rjx762DT2UL
 EQcMg2h+O4HzVflG+snRaBhxGl6QB5BndkXFh/tm5XmiqIvLSWzfYfwRkNIVJfbiDMwLNI58s
 iu/gISWfgCvB1s2FQ3VtY9EaCi2TVpPGQKIg4JUmeMMjb2h/QhMvh3PUxCMa2zCj2xcIy/C77
 9Jk87vbP7zDPoMQCNPq0FfmWC1nUwjEdBBH8P0GbxYtx8PADh+72Mf+1GSp+MymDX38Ch4Afd
 EIWTv0PulZPXdtIZBknplZBYSQ2czbYBabhMcH2/gg1DyfBfNE27UnORJVJdLLdU/Mu7cV0iz
 ez0OoBAmHSZ+j1zYbfQcFxrP7yLe3H8tHTNTG9DImtOnh+2VJyOZ3j4yCZ0Z/NRcaon69awpF
 l6diwp3IKX+Q2wi1WGByu9Ngc71CheLK0/xgflPNWicmUKJmPRdBeORtG4VrY6jyHiJNjqtjp
 HQBM3UR4SX6GbN1e+G8v9Ml5Q/2noBJ29rOGW6SBXN9dnpYhKVf7SH4eE8CDRZm5ECjceVojE
 t/7XpV+3ZcBqlpFRwMRBs/C/OacPVD5QzHbiS5eSp5sJRa6LC/6RSgiIwb+6WDy82kPfgJsda
 XwOfrWHY/FlfhDqq29EwRvRXKI0GKlMmtCrpTLrfeqWLL27TeRnuO/99etRSywwh2+uG5Moxr
 cEmYRF6+ptj8ktWM0sacB0f1CH3sp0JxCYX4aG6RrMNEEd0MPA+K1SpKd4GC3UQSvffJ7KxGS
 b+AYbnYt6Bye44Jx37r0UbIYMXSGsx/gmJbcimmLC0HM5tvm4SiS/YbDtpnAojHpKNGFFtw9Q
 YNJRqkOtc9cIeI0bFYvuzmlZfUjQ+4B4s/tgc5nwwyIlr05m5v3Lw/1XcSs98/XIcBboSmaWW
 o7UZrNCiwhYMOUoiiZBvRWXstm7KN3nAQvf3kg3zpL26Arg1A945tjcemOpjqsJ/hqsDH0dA7
 jNi0sWnu1aSHCw=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KClRoZSB0ZXN0
IGZvciB3b3JraW5nIGlycXMgd2hpY2ggaXMgZG9uZSBpbiB0cG1fdGlzX3NlbmQoKSBpcyBvbmx5
IGV4ZWN1dGVkCmlmIGJvdGggcHJpdi0+aXJxX3Rlc3RlZCBpcyBmYWxzZSBhbmQgVFBNX0NISVBf
RkxBR19JUlEgaXMgc2V0IGluCmNoaXAtPmZsYWdzLgoKV2hpbGUgdGhlIGZpcnN0IGNvbmRpdGlv
biBpcyBpbml0aWFsbHkgbWV0LCB0aGUgVFBNX0NISVBfRkxBR19JUlEgZmxhZyBpcwpuZXZlciBz
ZXQsIHdoaWNoIHByZXZlbnRzIHRoZSBpcnEgdGVzdCBmcm9tIGJlaW5nIGV2ZXIgZXhlY3V0ZWQu
IEZpeCB0aGlzCmJ5IHNldHRpbmcgVFBNX0NISVBfRkxBR19JUlEganVzdCBiZWZvcmUgdGhlIHRl
c3QgaXMgbWFkZS4KClNpZ25lZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8bC5zYW5maWxpcHBv
QGt1bmJ1cy5jb20+Ci0tLQogZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYyB8IDEgKwog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFy
L3RwbS90cG1fdGlzX2NvcmUuYyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMKaW5k
ZXggNDZmNTA0ZmI1MDg0Li40ZjNiODJjM2YyMDUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY2hhci90
cG0vdHBtX3Rpc19jb3JlLmMKKysrIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwpA
QCAtNzgxLDYgKzc4MSw3IEBAIHN0YXRpYyBpbnQgdHBtX3Rpc19wcm9iZV9pcnFfc2luZ2xlKHN0
cnVjdCB0cG1fY2hpcCAqY2hpcCwgdTMyIGludG1hc2ssCiAJCXJldHVybiByYzsKIAogCXByaXYt
PmlycV90ZXN0ZWQgPSBmYWxzZTsKKwljaGlwLT5mbGFncyB8PSBUUE1fQ0hJUF9GTEFHX0lSUTsK
IAogCS8qIEdlbmVyYXRlIGFuIGludGVycnVwdCBieSBoYXZpbmcgdGhlIGNvcmUgY2FsbCB0aHJv
dWdoIHRvCiAJICogdHBtX3Rpc19zZW5kCi0tIAoyLjM2LjAKCg==
