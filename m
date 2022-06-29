Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61859560D25
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jun 2022 01:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiF2X1k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Jun 2022 19:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiF2X1i (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Jun 2022 19:27:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F27525280;
        Wed, 29 Jun 2022 16:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656545244;
        bh=8bvwjFzHTyN26RyydHQkqmMi4yXOCOXQzUZ4H55Cz3k=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FrsMyOxlLPHj0Tow/axOBTr3wlJNmmROtrdlpcVVoUeQmcl/RGCOQkXVXSW35BWSI
         Ki0mRaewvoU/C8AYf4R6lmeY4TXro7fukJGoMTyrvC4Sq4hpQYMujgVkeisFyRzqET
         gHhT3PGBVaX7Nk2J1khj33UnKwj1eKqXasCtqA1c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.23]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlf0K-1nP8oQ1bs2-00ikC5; Thu, 30
 Jun 2022 01:27:24 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, LinoSanfilippo@gmx.de, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: [PATCH v7 03/10] tpm, tpm_tis: Disable interrupts if tpm_tis_probe_irq() failed
Date:   Thu, 30 Jun 2022 01:26:46 +0200
Message-Id: <20220629232653.1306735-4-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629232653.1306735-1-LinoSanfilippo@gmx.de>
References: <20220629232653.1306735-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:ZEm7Xr3wPZL8SwaVhzJKfajnZv1T/Wh0WBV/B78vB3xkgDwvz9V
 OMdOhATHxNjcxay4ENz7BvqLOhPr01uXgKAWKChBQjY/Beqt84zAQP7opn2qHGDvpAxNDUw
 Lv3YR4+k6iMS4NNXdCziEVGYSK5J/4GbSEtme5A3DmDO82PmQiYDPJRZmJWRXm9Dhz7Hfyr
 ZLVwbvAlgog34Z33wkxDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WzdQ9i/npDM=:3pl8kCLN1WwvFMKdq5JqUm
 pkga61uB3/gyge304Fy7pqsZGRkkxk5FkYDYDp35jME8pLAWTY6YjwZj6wv/z2FBEmMKYSITn
 M5Ip6LI0yOgIW72QtEWEPKDssTEBfrtO8iXMkqxSC/8p4iNKM+RXDwjfKIKy5N5LnxvguCEse
 CMU1gRu0LU7wq4a+Yex1A05tKIL7dPJK8B/SHaET7rVtD0g0IPI4iCpm9VoUzL7aY8UaQLk9N
 xL2hxwhtz3mb9kB7SzM9afJnmjNSLKLo7aiJ1QHWZid3h3NYGLA3xSRA6kuzyrxms1IOVRQb2
 5Wzbtx4i92FXWvINMQBJzz1GTvk3ye/0fBhG3oZFuYt8NvT+64rb9mkAxG0W7u4spzG2imOp+
 wH4SRD2smbU3z61E0z3t4dUB5crLd88mGypn5FspxRZApky1zPK/CMyxBAGwBruDhV10dnaTG
 7u2WYeGiOyD+JTGiQzTD9wdsxe/ggAMnuU78BqpBlzLs1u7QEZi0FKVU2nKv8w7ym2axyFpVL
 JgiVSvC3vExMGD7vfJlka00T55xzSLMhLRLKDbB8kYLhUDF/W2fEbGErk8rbKUAI+Ifekywyw
 TUzZJkzq9mxP767JjUQxI+XSY+INR+5ZEs6CSFf6d47JA/Bmp33XNiei9Zj41/rNnskt9/S8J
 H38F1WYlX0eYjO4yowxSBltWSlwR62xcPZs042OUncHNeBUcG2M5cOtuszTMLgTVXFywWdqRU
 db9QEiVLDnr8TK/ZTIKHJfCXtZnQ7+54mU7MtJt5BQAehSNiVkJ43RFXoEhwGOcapA1+Aix6d
 ngQKFpEgoZtdWnWBym0Vyg/4DhWqEjLZlcOuwNy4nOCZmpIL8+SqWE7WIq9dpUp7J8cz/Ebx4
 HsRMP4YLwjIlj6gkGzRMqToCMWCoZcSV5xnQE8pdDws8JyxcHK5JVwo+grvVIjfH0JeZuYxZ+
 xttIZgSWptGxU+zlhaf7M3bfCjhN1gVvKgflvvyzDx/MBT5WTDZEHmxod51GGjrnnBEx9Jfdm
 Wx8nQT+dyAF2M2DTkRvqCfOvKJEx05mrZHfkTo8WIvM/NLYGPgWtrBLDRhKs3l68r6np6rGmz
 1K6bXx4ZdPtiHy2IVSIgKkJ+IIrAOTm/wWm9oc/YlnXliDJQjWWjDl/Rw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkJvdGggZnVu
Y3Rpb25zIHRwbV90aXNfcHJvYmVfaXJxX3NpbmdsZSgpIGFuZCB0cG1fdGlzX3Byb2JlX2lycSgp
IG1heSBzZXR1cAp0aGUgaW50ZXJydXB0cyBhbmQgdGhlbiByZXR1cm4gd2l0aCBhbiBlcnJvci4g
VGhpcyBjYXNlIGlzIGluZGljYXRlZCBieSBhCm1pc3NpbmcgVFBNX0NISVBfRkxBR19JUlEgZmxh
ZyBpbiBjaGlwLT5mbGFncy4KQ3VycmVudGx5IHRoZSBpbnRlcnJ1cHQgc2V0dXAgaXMgb25seSB1
bmRvbmUgaWYgdHBtX3Rpc19wcm9iZV9pcnFfc2luZ2xlKCkKZmFpbHMuIFVuZG8gdGhlIHNldHVw
IGFsc28gaWYgdHBtX3Rpc19wcm9iZV9pcnEoKSBmYWlscy4KClNpZ25lZC1vZmYtYnk6IExpbm8g
U2FuZmlsaXBwbyA8bC5zYW5maWxpcHBvQGt1bmJ1cy5jb20+ClJldmlld2VkLWJ5OiBKYXJra28g
U2Fra2luZW4gPGphcmtrb0BrZXJuZWwub3JnPgpUZXN0ZWQtYnk6IE1pY2hhZWwgTmlld8O2aG5l
ciA8bGludXhAbW5pZXdvZWhuZXIuZGU+Ci0tLQogZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2Nv
cmUuYyB8IDIyICsrKysrKysrKysrLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNl
cnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdHBt
L3RwbV90aXNfY29yZS5jIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwppbmRleCAw
ZTY4ZTQ1MDJhNTYuLmQzMmU5M2M4NmY0OCAxMDA2NDQKLS0tIGEvZHJpdmVycy9jaGFyL3RwbS90
cG1fdGlzX2NvcmUuYworKysgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCkBAIC0x
MDc3LDIxICsxMDc3LDIxIEBAIGludCB0cG1fdGlzX2NvcmVfaW5pdChzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHN0cnVjdCB0cG1fdGlzX2RhdGEgKnByaXYsIGludCBpcnEsCiAJCQlnb3RvIG91dF9lcnI7
CiAJCX0KIAotCQlpZiAoaXJxKSB7CisJCWlmIChpcnEpCiAJCQl0cG1fdGlzX3Byb2JlX2lycV9z
aW5nbGUoY2hpcCwgaW50bWFzaywgSVJRRl9TSEFSRUQsCiAJCQkJCQkgaXJxKTsKLQkJCWlmICgh
KGNoaXAtPmZsYWdzICYgVFBNX0NISVBfRkxBR19JUlEpKSB7Ci0JCQkJZGV2X2VycigmY2hpcC0+
ZGV2LCBGV19CVUcKKwkJZWxzZQorCQkJdHBtX3Rpc19wcm9iZV9pcnEoY2hpcCwgaW50bWFzayk7
CisKKwkJaWYgKCEoY2hpcC0+ZmxhZ3MgJiBUUE1fQ0hJUF9GTEFHX0lSUSkpIHsKKwkJCWRldl9l
cnIoJmNoaXAtPmRldiwgRldfQlVHCiAJCQkJCSJUUE0gaW50ZXJydXB0IG5vdCB3b3JraW5nLCBw
b2xsaW5nIGluc3RlYWRcbiIpOwogCi0JCQkJcmMgPSByZXF1ZXN0X2xvY2FsaXR5KGNoaXAsIDAp
OwotCQkJCWlmIChyYyA8IDApCi0JCQkJCWdvdG8gb3V0X2VycjsKLQkJCQlkaXNhYmxlX2ludGVy
cnVwdHMoY2hpcCk7Ci0JCQkJcmVsZWFzZV9sb2NhbGl0eShjaGlwLCAwKTsKLQkJCX0KLQkJfSBl
bHNlIHsKLQkJCXRwbV90aXNfcHJvYmVfaXJxKGNoaXAsIGludG1hc2spOworCQkJcmMgPSByZXF1
ZXN0X2xvY2FsaXR5KGNoaXAsIDApOworCQkJaWYgKHJjIDwgMCkKKwkJCQlnb3RvIG91dF9lcnI7
CisJCQlkaXNhYmxlX2ludGVycnVwdHMoY2hpcCk7CisJCQlyZWxlYXNlX2xvY2FsaXR5KGNoaXAs
IDApOwogCQl9CiAJfQogCi0tIAoyLjI1LjEKCg==
