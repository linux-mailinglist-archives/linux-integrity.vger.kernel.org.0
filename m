Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7199654651C
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jun 2022 13:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347847AbiFJLJX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jun 2022 07:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347236AbiFJLJW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jun 2022 07:09:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FF014558E;
        Fri, 10 Jun 2022 04:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654859344;
        bh=h2TS/0VnUJCYBFtIAAMCfO7jV4vdocdBAuzudeNWs78=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WjH8K5MYxkrE9XH9tqAaaWBGobyqIbELAYNFCfZY0+/uuu3VB0Ripvn8SsocTSvfp
         OK1IYksTcIcgxf4QLrcZpAktfy44NQsc7G5cT8xWxrMrFy3mi622ueJOO827bgyIJm
         ZCCoc0+sa+b4HxNnO+lbEyE/E2kGhw4l6ovl9Gy4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.3.165]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8QS2-1o42M42AGO-004TUg; Fri, 10
 Jun 2022 13:09:04 +0200
From:   LinoSanfilippo@gmx.de
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, LinoSanfilippo@gmx.de, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: [PATCH v5 03/10] tpm, tpm_tis: Disable interrupts if tpm_tis_probe_irq() failed
Date:   Fri, 10 Jun 2022 13:08:39 +0200
Message-Id: <20220610110846.8307-4-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
References: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:zej+GdlgXsvMXt3EbX2BjWswFuyOPmIPYQx4w9z5fZzqNm6LNTt
 AfMQ9LTVtzbAi7sUVxkkFwB2e+1Wq4nw7lEGktZ2qGpbHIH18HiE8yijd4Ym9dmR8Sswg8j
 LL2rzSj8oy+tm4nZqW+0gO9jZRnHNnqXod09yLcPYmeUKBsfv4M7cWFNTNvhbKgeAgSYFfw
 XAqh1TU8W6CD8VsX2Qb6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JOGJB6hq7Jc=:aTOoYZ6VFme8TfugIDvXLC
 DJ4lWjuNI3UAvHrEuPQ88SOo1XEWj/eu9SDsOqtQ+P9Ls0RhpeZHPZ8hF7wfZbMKDus/s+4A0
 XRD6A40MHSjtIiEkuuAylCHtxPZgwitA5bnowWewBSi6c4JpLtTJmgmG6XCeGRrcC7mAlWMya
 rvi573aCV8SYwNzo3sWq2v4ZJUUPh/mHasK1sZDJ+DWMXRzAB4VFi+bTa+w0cUm6UbJZbs1aR
 NES14k66PkD1MWGgla9YNZ9jggx2yP+FOvLdhk1uKuT4t5kkELLnRsxj/GQihR07UKMbd+TVA
 /QiR2J3JwKcoOmqUIuJs7XTnptsRDcYfA9sGuaH8Xte9s9YebJ0pU39a2yG9qiNxmOROFmwGu
 oLWCrezKCvDO0uKe05Lo8MWTuXTPBCNb6xZhP+6gEyNy7Um/kp9prg97bBgGVCKtR6QcCNIKT
 u29k2JY3vSliz2JEkADC0pcLTVX5a1dtS/IxQ0Vj1JShrGiWmmR34zfWWmD2Pf9kT5AmGsZ8G
 495ZFgxiCH980qq8p0bYCYgsAcyNYPsioGPA+WZha4E+X61880fEtLAh0EeKS9RDkE4wl3Cgj
 HM0d/gtCTzlxoqGaAhS3j4dr9YOSPNDRPL7GihQx+bc9dXcWe/q0Z1EMEBG7yl03oeR/9AuT3
 S8Z57M/0E8IqAeKH0iaHgVdKlxMiyJ7wPpQSdsXskT1d34btOyRkGaHi/AecoE0w7Ib/EdKpm
 gx+pDFax1prFvozKJV8OFcrNnuTCNjFkjGZFMPbnLqqzBj8K3JGu/Yg7TsX938tVgEJVCmvkv
 JiD5ly4fSps5dRvhzPSuIrWN7pmRgU3EyLTZhGHCvSDGnwWqGU5Ffe2PNL1oyktX0QXmforLc
 kPMi4SrZk9xxleUx8nqAb5JttOGY+HVldw1nTc5k9+8Pj9LCNzEDT5HNEIjhsyjCBxhEPfvRK
 yWBYvlb/I/SRaJnZqu5Qpo5nFTRNfmtsgVBs83W6SWkuUALLl93fVidUVlyt+g8GnClRPaqz9
 BbI+bhcjWVf5ffFNZEJZPTUHbw5NN7+J0uSdcDfXaxNw2EFR/aRnWhPyxJvDQ09Ez/SLfXJk0
 gX86p6IQM8n1Eqfo5a1e6pnX9DroIGSGv482hTWo/VdoOL27BoE2uHgFA==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkJvdGggZnVu
Y3Rpb25zIHRwbV90aXNfcHJvYmVfaXJxX3NpbmdsZSgpIGFuZCB0cG1fdGlzX3Byb2JlX2lycSgp
IG1heSBzZXR1cAp0aGUgaW50ZXJydXB0cyBhbmQgdGhlbiByZXR1cm4gd2l0aCBhbiBlcnJvci4g
VGhpcyBjYXNlIGlzIGluZGljYXRlZCBieSBhCm1pc3NpbmcgVFBNX0NISVBfRkxBR19JUlEgZmxh
ZyBpbiBjaGlwcy0+ZmxhZ3MuCkN1cnJlbnRseSB0aGUgaW50ZXJydXB0IHNldHVwIGlzIG9ubHkg
dW5kb25lIGlmIHRwbV90aXNfcHJvYmVfaXJxX3NpbmdsZSgpCmZhaWxzLiBVbmRvIHRoZSBzZXR1
cCBhbHNvIGlmIHRwbV90aXNfcHJvYmVfaXJxKCkgZmFpbHMuCgpTaWduZWQtb2ZmLWJ5OiBMaW5v
IFNhbmZpbGlwcG8gPGwuc2FuZmlsaXBwb0BrdW5idXMuY29tPgotLS0KIGRyaXZlcnMvY2hhci90
cG0vdHBtX3Rpc19jb3JlLmMgfCAyMiArKysrKysrKysrKy0tLS0tLS0tLS0tCiAxIGZpbGUgY2hh
bmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19j
b3JlLmMKaW5kZXggZWU2YjQ4YzU1YWM5Li5kZWU3MDE2MDliODAgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMKKysrIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlz
X2NvcmUuYwpAQCAtMTA3NywyMSArMTA3NywyMSBAQCBpbnQgdHBtX3Rpc19jb3JlX2luaXQoc3Ry
dWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgdHBtX3Rpc19kYXRhICpwcml2LCBpbnQgaXJxLAogCQkJ
Z290byBvdXRfZXJyOwogCQl9CiAKLQkJaWYgKGlycSkgeworCQlpZiAoaXJxKQogCQkJdHBtX3Rp
c19wcm9iZV9pcnFfc2luZ2xlKGNoaXAsIGludG1hc2ssIElSUUZfU0hBUkVELAogCQkJCQkJIGly
cSk7Ci0JCQlpZiAoIShjaGlwLT5mbGFncyAmIFRQTV9DSElQX0ZMQUdfSVJRKSkgewotCQkJCWRl
dl9lcnIoJmNoaXAtPmRldiwgRldfQlVHCisJCWVsc2UKKwkJCXRwbV90aXNfcHJvYmVfaXJxKGNo
aXAsIGludG1hc2spOworCisJCWlmICghKGNoaXAtPmZsYWdzICYgVFBNX0NISVBfRkxBR19JUlEp
KSB7CisJCQlkZXZfZXJyKCZjaGlwLT5kZXYsIEZXX0JVRwogCQkJCQkiVFBNIGludGVycnVwdCBu
b3Qgd29ya2luZywgcG9sbGluZyBpbnN0ZWFkXG4iKTsKIAotCQkJCXJjID0gcmVxdWVzdF9sb2Nh
bGl0eShjaGlwLCAwKTsKLQkJCQlpZiAocmMgPCAwKQotCQkJCQlnb3RvIG91dF9lcnI7Ci0JCQkJ
ZGlzYWJsZV9pbnRlcnJ1cHRzKGNoaXApOwotCQkJCXJlbGVhc2VfbG9jYWxpdHkoY2hpcCwgMCk7
Ci0JCQl9Ci0JCX0gZWxzZSB7Ci0JCQl0cG1fdGlzX3Byb2JlX2lycShjaGlwLCBpbnRtYXNrKTsK
KwkJCXJjID0gcmVxdWVzdF9sb2NhbGl0eShjaGlwLCAwKTsKKwkJCWlmIChyYyA8IDApCisJCQkJ
Z290byBvdXRfZXJyOworCQkJZGlzYWJsZV9pbnRlcnJ1cHRzKGNoaXApOworCQkJcmVsZWFzZV9s
b2NhbGl0eShjaGlwLCAwKTsKIAkJfQogCX0KIAotLSAKMi4zNi4xCgo=
