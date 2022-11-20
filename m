Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B61631455
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Nov 2022 14:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiKTNcr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Nov 2022 08:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiKTNci (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Nov 2022 08:32:38 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C4FB28;
        Sun, 20 Nov 2022 05:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668951129; bh=E6zlWIm9oM/GjzOpdjNAuGrLapusFr2z5NlJBYv1qs8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=i2h2mOc3C3vVDsqj33TjYpssnck9VB33EVvQavhM5O1mXJ1hes4o2R/cYv0TEd2Eo
         wlSqFrpy/oVTQ7yNOWRKiJLwurBOgFekfAos71dho1uqrQJLninyfgdRc46esrVKQC
         KZDEMoQyD2d5FyM/1h91YM4Y4FnTlZ3AFZ8JF8shMOzPA3kHjbvLKQJeDQ3RF8j/dZ
         3sUgXv3aFrSyoQ5B9S15Fw4SCgc+eIkNhagKI70qEe7fpvzQ6dVIP65fzILWSeBEOi
         FvC063QBQRC3DCnFXziokM5zVJTGimc+XTQQ3jjNmAqPvod2lRdRljRp6oaeki7iHa
         ei3WJIpMU8hLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.7.17]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTAFh-1oV00k0XGB-00UYYC; Sun, 20
 Nov 2022 14:32:09 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v10 13/14] tpm, tpm_tis: startup chip before testing for interrupts
Date:   Sun, 20 Nov 2022 14:31:33 +0100
Message-Id: <20221120133134.28926-14-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221120133134.28926-1-LinoSanfilippo@gmx.de>
References: <20221120133134.28926-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:o4Yv8LXi3e7EPxUvPlF5naCJKcyg/01QSCkduQcXf0VhvL/9xWN
 38/8XEupEFIFwFL7cLZJwOr7L/zZd4ME0aTqvIJLPDO7FlH1VMKTHPX7/3rVVHaijWKxRyK
 GcILisb7Tld1OHTL204XKo21XVuoFoRF5UQWzJdrVgSmevwBHpfzW52gdnHDkaS231D9lqm
 X938WbCORj9Bk02IkYABg==
UI-OutboundReport: notjunk:1;M01:P0:06rG0ZS1J/c=;RSMRuY/3OKsQ5trQLbvspA8j/tt
 me5d23IVCWFvb9DvjpfT3gogOJWPob2IOX42+dPgWH8Rig9J9bLaYsp9VAU+R89TBPaGjmayp
 KvQrZFVxq0HNc1pVmzXwZ5VKs+Qf1QDMSS4P2Ptbg/ruYg2mgdJFxHC+6f4b+um22BePTTPQo
 WSgDdPe1tcXJe1+41jfa5bq6I1Kx/7rHjBOr8JgME4xf4P8t4fsiCzrUFJH8KgJYEWGedMVny
 fw4yLh/CTjlS5Dz+0/STt7jcpUYWya2aK/GJ8n/5Xk4aBCI9H7ZTg1NsLWYmDPKyd0Gik/YE7
 Q8LYsTVYYK8e7ycG17s/njOqHP7i1q53ZSrS7AuthCPiEiRykIujAY9tnE+wFknRj9jxSig4M
 1u216Ww5Nvvd4ElJFUgxZm3i6U9bwV7ehWjpKKW3uodoQIF6foU4siPwl3qUwL/1cqjAj+CcO
 y7KjfmNQk58ZGiGueLWORK39KfgS1eCDwzC2G83qbh0Ac9koKaJ0GK/GffcUg7blvb63h9T+A
 zTXg7fv/7+gsaU8po3/0vR3E7aKxJlJVXUONMiHX/5tpZ03K8rYfzR0mMweYF/SAomPcNSc6O
 xsIBy4WJ5vriUBYSGyUkNxYLTFGb+8fw9mC5hlZ7dqrLf2tPcRPvYydnCFHXsRE6zq2B3+u6U
 tpTDEvgjc+MMFc5uBKGEtG35oqRUDu22KdllIxTkxOHJowUFHXm4S72yp0PYtuffLX/FFuxGX
 jsCSWm/haU9h0bz6AW3XyciivTo/I79KshCxmrn5t2hFeid96t1a/l5Ww9OyHtVMYRDz66wB3
 0UBjX/E0gGuRvwxW70T15APOFvUz8ZafBbxSDeyBiF3MhnRe1VQ2o/EdgzYeK9LCFQcKW4VXx
 jCEFguNv16Pd1hb7fvAPPaMgLHeXs8ywGvbEzTvykYFvtTe3zkrInXCogjFxT/qi+8Am11Mf3
 7AtzgQ==
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkluIHRwbV90
aXNfZ2VuX2ludGVycnVwdCgpIGEgcmVxdWVzdCBmb3IgYSBwcm9wZXJ0eSB2YWx1ZSBpcyBzZW50
IHRvIHRoZQpUUE0gdG8gdGVzdCBpZiBpbnRlcnJ1cHRzIGFyZSBnZW5lcmF0ZWQuIEhvd2V2ZXIg
YWZ0ZXIgYSBwb3dlciBjeWNsZSB0aGUKVFBNIHJlc3BvbmRzIHdpdGggVFBNX1JDX0lOSVRJQUxJ
WkUgd2hpY2ggaW5kaWNhdGVzIHRoYXQgdGhlIFRQTSBpcyBub3QKeWV0IHByb3Blcmx5IGluaXRp
YWxpemVkLgpGaXggdGhpcyBieSBmaXJzdCBzdGFydGluZyB0aGUgVFBNIHVwIGJlZm9yZSB0aGUg
cmVxdWVzdCBpcyBzZW50LiBGb3IgdGhpcwp0aGUgc3RhcnR1cCBpbXBsZW1lbnRhdGlvbiBpcyBy
ZW1vdmVkIGZyb20gdHBtX2NoaXBfcmVnaXN0ZXIoKSBhbmQgcHV0CmludG8gdGhlIG5ldyBmdW5j
dGlvbiB0cG1fY2hpcF9zdGFydHVwKCkgd2hpY2ggaXMgY2FsbGVkIGJlZm9yZSB0aGUKaW50ZXJy
dXB0cyBhcmUgdGVzdGVkLgoKU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZp
bGlwcG9Aa3VuYnVzLmNvbT4KLS0tCiBkcml2ZXJzL2NoYXIvdHBtL3RwbS1jaGlwLmMgICAgIHwg
MzggKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tCiBkcml2ZXJzL2NoYXIvdHBtL3Rw
bS5oICAgICAgICAgIHwgIDEgKwogZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYyB8ICA1
ICsrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90cG0vdHBtLWNoaXAuYyBiL2RyaXZlcnMvY2hh
ci90cG0vdHBtLWNoaXAuYwppbmRleCA3ODNkNjVmYzcxZjAuLjM3MGFhMWY1MjlmMiAxMDA2NDQK
LS0tIGEvZHJpdmVycy9jaGFyL3RwbS90cG0tY2hpcC5jCisrKyBiL2RyaXZlcnMvY2hhci90cG0v
dHBtLWNoaXAuYwpAQCAtNTQzLDYgKzU0MywzMCBAQCBzdGF0aWMgaW50IHRwbV9nZXRfcGNyX2Fs
bG9jYXRpb24oc3RydWN0IHRwbV9jaGlwICpjaGlwKQogCXJldHVybiByYzsKIH0KIAorLyoKKyAq
IHRwbV9jaGlwX3N0YXJ0dXAoKSAtIHBlcmZvcm1zIGF1dG8gc3RhcnR1cCBhbmQgYWxsb2NhdGVz
IHRoZSBQQ1JzCisgKiBAY2hpcDogVFBNIGNoaXAgdG8gdXNlLgorICovCitpbnQgdHBtX2NoaXBf
c3RhcnR1cChzdHJ1Y3QgdHBtX2NoaXAgKmNoaXApCit7CisJaW50IHJjOworCisJcmMgPSB0cG1f
Y2hpcF9zdGFydChjaGlwKTsKKwlpZiAocmMpCisJCXJldHVybiByYzsKKworCXJjID0gdHBtX2F1
dG9fc3RhcnR1cChjaGlwKTsKKwlpZiAocmMpCisJCWdvdG8gc3RvcDsKKworCXJjID0gdHBtX2dl
dF9wY3JfYWxsb2NhdGlvbihjaGlwKTsKK3N0b3A6CisJdHBtX2NoaXBfc3RvcChjaGlwKTsKKwor
CXJldHVybiByYzsKK30KK0VYUE9SVF9TWU1CT0xfR1BMKHRwbV9jaGlwX3N0YXJ0dXApOworCiAv
KgogICogdHBtX2NoaXBfcmVnaXN0ZXIoKSAtIGNyZWF0ZSBhIGNoYXJhY3RlciBkZXZpY2UgZm9y
IHRoZSBUUE0gY2hpcAogICogQGNoaXA6IFRQTSBjaGlwIHRvIHVzZS4KQEAgLTU1OCwyMCArNTgy
LDYgQEAgaW50IHRwbV9jaGlwX3JlZ2lzdGVyKHN0cnVjdCB0cG1fY2hpcCAqY2hpcCkKIHsKIAlp
bnQgcmM7CiAKLQlyYyA9IHRwbV9jaGlwX3N0YXJ0KGNoaXApOwotCWlmIChyYykKLQkJcmV0dXJu
IHJjOwotCXJjID0gdHBtX2F1dG9fc3RhcnR1cChjaGlwKTsKLQlpZiAocmMpIHsKLQkJdHBtX2No
aXBfc3RvcChjaGlwKTsKLQkJcmV0dXJuIHJjOwotCX0KLQotCXJjID0gdHBtX2dldF9wY3JfYWxs
b2NhdGlvbihjaGlwKTsKLQl0cG1fY2hpcF9zdG9wKGNoaXApOwotCWlmIChyYykKLQkJcmV0dXJu
IHJjOwotCiAJdHBtX3N5c2ZzX2FkZF9kZXZpY2UoY2hpcCk7CiAKIAl0cG1fYmlvc19sb2dfc2V0
dXAoY2hpcCk7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdHBtL3RwbS5oIGIvZHJpdmVycy9j
aGFyL3RwbS90cG0uaAppbmRleCAyNGVlNGUxY2M0NTIuLjkxOWJiMGI4OGIxMiAxMDA2NDQKLS0t
IGEvZHJpdmVycy9jaGFyL3RwbS90cG0uaAorKysgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbS5oCkBA
IC0xOTAsNiArMTkwLDcgQEAgc3RhdGljIGlubGluZSB2b2lkIHRwbV9tc2xlZXAodW5zaWduZWQg
aW50IGRlbGF5X21zZWMpCiAJCSAgICAgZGVsYXlfbXNlYyAqIDEwMDApOwogfTsKIAoraW50IHRw
bV9jaGlwX3N0YXJ0dXAoc3RydWN0IHRwbV9jaGlwICpjaGlwKTsKIGludCB0cG1fY2hpcF9zdGFy
dChzdHJ1Y3QgdHBtX2NoaXAgKmNoaXApOwogdm9pZCB0cG1fY2hpcF9zdG9wKHN0cnVjdCB0cG1f
Y2hpcCAqY2hpcCk7CiBzdHJ1Y3QgdHBtX2NoaXAgKnRwbV9maW5kX2dldF9vcHMoc3RydWN0IHRw
bV9jaGlwICpjaGlwKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3Jl
LmMgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCmluZGV4IDI1MTRlNjBmNjc3OC4u
Yjk3Y2IzMjVjY2I3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5j
CisrKyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMKQEAgLTExMjgsNiArMTEyOCwx
MSBAQCBpbnQgdHBtX3Rpc19jb3JlX2luaXQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgdHBt
X3Rpc19kYXRhICpwcml2LCBpbnQgaXJxLAogCS8qIElOVEVSUlVQVCBTZXR1cCAqLwogCWluaXRf
d2FpdHF1ZXVlX2hlYWQoJnByaXYtPnJlYWRfcXVldWUpOwogCWluaXRfd2FpdHF1ZXVlX2hlYWQo
JnByaXYtPmludF9xdWV1ZSk7CisKKwlyYyA9IHRwbV9jaGlwX3N0YXJ0dXAoY2hpcCk7CisJaWYg
KHJjKQorCQlnb3RvIG91dF9lcnI7CisKIAlpZiAoaXJxICE9IC0xKSB7CiAJCS8qCiAJCSAqIEJl
Zm9yZSBkb2luZyBpcnEgdGVzdGluZyBpc3N1ZSBhIGNvbW1hbmQgdG8gdGhlIFRQTSBpbiBwb2xs
aW5nIG1vZGUKLS0gCjIuMzYuMQoK
