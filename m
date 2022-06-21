Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72AD55339A
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Jun 2022 15:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbiFUNeP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Jun 2022 09:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351572AbiFUNbC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jun 2022 09:31:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027232AE1C;
        Tue, 21 Jun 2022 06:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655817939;
        bh=PvrmjIK2R/7Rg/z0B3aBuH8hQ6T9UKVZJaouKiyYQK8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=NnKKA+LEU1zCj5JU+mRqz3ZY8Hhqonh7iIRlBUBCULX4iO9Jb6ZIu0ufaVhKI1tYH
         9J/TarKVbBRl1VsWAlc7Vc9SgcPMz+CasPefn0iCizxrtQIJgKQmAovijfYaJuzuzc
         31JMZ9d/26zMosdS3E16Li3KqzMgz18CP1rrefA8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.2.162]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFKGZ-1nsQgM0fVJ-00FlkL; Tue, 21
 Jun 2022 15:25:39 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, LinoSanfilippo@gmx.de, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: [PATCH v6 8/9] tpm, tpm_tis: Claim locality in interrupt handler
Date:   Tue, 21 Jun 2022 15:24:46 +0200
Message-Id: <20220621132447.16281-9-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621132447.16281-1-LinoSanfilippo@gmx.de>
References: <20220621132447.16281-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:s+KoSs8FVvUDA9xLoRylghz+uOTWZYvnvvybtoZ3KI/xve0hM/w
 YBWOvQtpSvAmvbRvUq8IfNzzatmUXnXbHVnltc5LVVuYgAzHPrt6iT/PoGe3yqSBZUeblbC
 21be5cSDTWbyE3Pt7yq/ihDDn2+3JbdAYxdhqxfcPpLqxKHoGG6GstH86LEpvfrCEitycOS
 78dsiRQQwx7qpAfQEbI/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:otVE8FV/LOI=:Y1mcxcjPPQSjIuHh4JPiKH
 0iV7Z6R2dpCqDBNkLhCMkWOUFp7Fy00nNy3fDTY6YFop1KQF/xEZYt8CF1C1fNs+slsXXXduc
 NGbbiWIoB8oAPUeSo+/IiKqiqWeZ054rRAzz2fYS5jnkeoTToBsN2VF2TWL5Y+y0vaHWK0sGi
 qTWTSD/X8G72M01GxJWQqnUi0+GkB+FErHqFsmNoiz3EVY12Re4rjt0onALEWdqV7+AtmIM96
 BnNLwWOTWPbgnilHyqYHsVJh/eLCO0kjKk6Yz9H6A5Rj++2xYrzLllgFkvO60R2BAX+7um7ZK
 xpwPXygpA6oCcxcCWT5wRwDivTnJ9/SYJQYM7UFc6EiuDLe8NYHbOgwM9fxcUGcm0rjBDBM1N
 Ec4uBiSjELM5q8WNcs2aCiMhlgZv0t9/0KWqnipmwNjRQC9zv97ZxCL7h1Iaqi2InMV5dkgWR
 rnE5NzAXPWSYKvqkCpjo65PgXRSR/LQJ3KEzy3keOnj5ChPWD8om0LRqHAdRC0yatq7nD2zb3
 e9N42bvGzlfjYf0lPlQYuQqjx7irFtWQO9kHm8C60StRD9kGLF2qFBKyWEdQgq6bCbYxuOAim
 4HZQ0lWhV/W+MUNBAPAs6k1Q0UWVhgNdkvHWxP2OjxF1zC2jt+xza6dA9CiJaMRt+iOkIGcra
 dJzQE2ExJIsB01WaBNH4qocjGTuX2k7ZAWJ3x0hU6QtUN/OPGLxPSVtKPLhDhNSVQs/ri61UA
 h52bSJv61BRJdaBArlMpnj2uv4RLdXzoPqYkdsZPu9W8As/LbA7c3s65aoPRkclr+um8MIdvZ
 VXrjwo9RkvP4kkgvcVrONzjcvoCOzarTekfe7R2mSXivCcYETGHisGhjBTlAtvEzd7kpKteQc
 7Xk8SI2hB9b3yWK0hWzJKLM/pBf9ldQ+iecPMrKKjjh3c7N/Tj2AjJxRH5Db1aOXFjhBB0ker
 hrmwxv8igmmniLKpnCAyRmm7/srynmmHGpJ5nItdw24AOxzYpKhWuab21THkGS2L1VQjEcr8j
 o+MWqeR50TPhzKmh/JZmPlfgch/YMeKE/leGEyG5xMyLIH78uUAsTp0r9DL2MmxWMuXYb7X1L
 klHzRi1cyhr4ut2KEwfH9C1eCZfU8x8oFZLgjE9CP6CVeZkqFBSfzOO3Q==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCldyaXRpbmcg
dGhlIFRQTV9JTlRfU1RBVFVTIHJlZ2lzdGVyIGluIHRoZSBpbnRlcnJ1cHQgaGFuZGxlciB0byBj
bGVhciB0aGUKaW50ZXJydXB0cyBvbmx5IGhhcyBlZmZlY3QgaWYgYSBsb2NhbGl0eSBpcyBoZWxk
LiBTaW5jZSB0aGlzIGlzIG5vdApndWFyYW50ZWVkIGF0IHRoZSB0aW1lIHRoZSBpbnRlcnJ1cHQg
aXMgZmlyZWQsIGNsYWltIHRoZSBsb2NhbGl0eQpleHBsaWNpdGx5IGluIHRoZSBoYW5kbGVyLgoK
U2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4K
UmV2aWV3ZWQtYnk6IEphcmtrbyBTYWtraW5lbiA8amFya2tvQGtlcm5lbC5vcmc+Ci0tLQogZHJp
dmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5j
IGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwppbmRleCAwOGE0ZTgyZjc2YTEuLjFm
NzY2M2FjMWZjNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwor
KysgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCkBAIC03NTQsNyArNzU0LDkgQEAg
c3RhdGljIGlycXJldHVybl90IHRpc19pbnRfaGFuZGxlcihpbnQgZHVtbXksIHZvaWQgKmRldl9p
ZCkKIAkJd2FrZV91cF9pbnRlcnJ1cHRpYmxlKCZwcml2LT5pbnRfcXVldWUpOwogCiAJLyogQ2xl
YXIgaW50ZXJydXB0cyBoYW5kbGVkIHdpdGggVFBNX0VPSSAqLworCXRwbV90aXNfcmVxdWVzdF9s
b2NhbGl0eShjaGlwLCAwKTsKIAlyYyA9IHRwbV90aXNfd3JpdGUzMihwcml2LCBUUE1fSU5UX1NU
QVRVUyhwcml2LT5sb2NhbGl0eSksIGludGVycnVwdCk7CisJdHBtX3Rpc19yZWxlYXNlX2xvY2Fs
aXR5KGNoaXAsIDApOwogCWlmIChyYyA8IDApCiAJCXJldHVybiBJUlFfTk9ORTsKIAotLSAKMi4z
Ni4xCgo=
