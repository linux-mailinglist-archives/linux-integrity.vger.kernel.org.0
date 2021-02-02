Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC70630CE7B
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Feb 2021 23:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbhBBWLk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Feb 2021 17:11:40 -0500
Received: from mout.gmx.net ([212.227.17.21]:49509 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233941AbhBBWLh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Feb 2021 17:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612303792;
        bh=kpbzdNODFnAbXuoY59f8MDbpPfxSMH2i07Z3601DVHk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=brP2JX65mXnCFdr/ei65Iwwr9jgWvzCAClAC/vFyrBtYLmajTJi5bYwl98Z4mrDg0
         PiyDpnUcz5D2X4R16tSc7oOtGvKLT9Yt7De9IaFTEATzkH++ueOCgOqwyWmWsmMHKu
         vZ75gKBsIhycz56MX8QUA9Fi8a0qhylq8UHuDfO8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([78.42.220.31]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvsJ5-1lz1V906Zr-00stp0; Tue, 02
 Feb 2021 23:09:52 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org
Cc:     jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        LinoSanfilippo@gmx.de, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v2 3/3] tpm: in tpm2_del_space check if ops pointer is still valid
Date:   Tue,  2 Feb 2021 23:09:03 +0100
Message-Id: <1612303743-29017-4-git-send-email-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612303743-29017-1-git-send-email-LinoSanfilippo@gmx.de>
References: <1612303743-29017-1-git-send-email-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:zmynfQP3JZaYqVs6nC0/Hn+6lj9knW7njjTftLILSh1/GVLGxhz
 5nMGtjf60zyVSrK/1Unrhc6hbhd4OoC2GMvkywgGuR2JCCsJAiwIABwIOG0GvllthQB6JfU
 Ywleq9NThjSRlZrMpTwIP1/l7fF8FovBh7ObIdZY8/kuyio763HmFdJrmhIYobNM/6oztZK
 lW5PwR6XvMbu3A4t0kQVA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kaR3qkK5XkY=:CzGRqcNemXwU/XCHjoppZT
 ffM3vm+6PTRSuPvPt9Y/W9M5s+ZOuoB3/H7mZyCjQGBL7jp+FW84Pep8rnSCJfzcyOh2OtYSf
 HmLuxC0WiRyq1WAO67uAhwpYkmSxeE4ib8wdTj9PtVakJHptZUpzPNQrTgFCR/s+nxG7ajpeB
 dbdWg95kcT4Mj3tzpP1DJiJNmqvilX/1bpME7KnOWV4rzg+4Df4hz+djOGxBPbikJVRpCtEGh
 7ZmiOUQ3CBH/5BPAJLZzOWM2Do2RfSr5cb2QwVxKXmlLaKR1vAxM4OR4pV2Zd7rkigG9+RaV7
 cJs3TxUjMZga912NcyVB8v21bHwJNxbKPo3CWSD2NnEjrFcf/3K5/Hg8gDcP0vQ3B35WWHqAg
 rCvJO6mj9kdbQ8JpbbekhaQMOmctX7Vxzh+/EhEJTWsGuSmf6M+6FLK0HoB+ORwwzoaaX8L80
 SvM0FzsEm/gB6ARUd0rISDCOomBAcwpyd1MqOYhlfqFVEWi/zNdMz1Pxf7xMk4jfvP2IiBpx0
 T9w6taRTym684aD/AYAp6LcyV5EGo4cKYoQ2hYJYpRnXkETjMRT9id91HtnyjgiUH3bUkxkQr
 Q/O2F/WtLaqSHjMsxInOcSGQKqg2RcsPWKwaGzvdUb9YlWO0v1eTBXY7nm7F8Y/ozyD62kAC3
 7VNprweiYXViq/BK97K284Zh2gxwcCoSWnhPQ/5JpLLPearPOd2ptCjs/y6ofB77GgrE1dCMw
 ya2RpBx/WYbB7zLy47xnvPlYIx9FjfvpMdfiToxfxdabdhIVNebBxwW2gik9AneCaCXPyNvaF
 mzQNteQSurfzfYDmIuIYQgxi8ijRTR0p5ISLixbGdKzT6mmeOulIVy321WswpDg9BwCJCwCI+
 /RGaE3GKqsQa9lUngMCg==
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkluIHRwbTJf
ZGVsX3NwYWNlKCkgdGhlIHNlc3Npb25zIGFyZSBmbHVzaGVkIGJ5IG1lYW5zIG9mIHRoZSB0cG1f
Y2hpcApvcGVyYXRpb25zLiBIb3dldmVyIHRoZSBjb25jZXJuaW5nIG9wZXJhdGlvbnMgcG9pbnRl
ciBteSBhbHJlYWR5IGJlIE5VTEwgYXQKdGhpcyB0aW1lIGluIGNhc2UgdGhhdCB0aGUgY2hpcCBo
YXMgYmVlbiB1bnJlZ2lzdGVyZWQgKHNlZQp0cG1fY2hpcF91bnJlZ2lzdGVyKCkgd2hpY2ggY2Fs
bHMgdHBtX2RlbF9jaGFyX2RldmljZSgpIHdoaWNoIHNldHMKY2hpcC0+b3BzIHRvIE5VTEwpLgpC
ZWZvcmUgYWNjZXNzaW5nIGNoaXAtPm9wcyBjaGVjayBpZiBpdCBpcyBzdGlsbCB2YWxpZC4gU2tp
cCBmbHVzaGluZwp0aGUgc2Vzc2lvbnMgaW4gdGhpcyBjYXNlLgoKU2lnbmVkLW9mZi1ieTogTGlu
byBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KLS0tCiBkcml2ZXJzL2NoYXIv
dHBtL3RwbTItc3BhY2UuYyB8IDE1ICsrKysrKysrKystLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEw
IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFy
L3RwbS90cG0yLXNwYWNlLmMgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbTItc3BhY2UuYwppbmRleCA3
ODRiOGIzLi45YTI5YTQwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbTItc3BhY2Uu
YworKysgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbTItc3BhY2UuYwpAQCAtNTgsMTIgKzU4LDE3IEBA
IGludCB0cG0yX2luaXRfc3BhY2Uoc3RydWN0IHRwbV9zcGFjZSAqc3BhY2UsIHVuc2lnbmVkIGlu
dCBidWZfc2l6ZSkKIAogdm9pZCB0cG0yX2RlbF9zcGFjZShzdHJ1Y3QgdHBtX2NoaXAgKmNoaXAs
IHN0cnVjdCB0cG1fc3BhY2UgKnNwYWNlKQogewotCW11dGV4X2xvY2soJmNoaXAtPnRwbV9tdXRl
eCk7Ci0JaWYgKCF0cG1fY2hpcF9zdGFydChjaGlwKSkgewotCQl0cG0yX2ZsdXNoX3Nlc3Npb25z
KGNoaXAsIHNwYWNlKTsKLQkJdHBtX2NoaXBfc3RvcChjaGlwKTsKKwlkb3duX3JlYWQoJmNoaXAt
Pm9wc19zZW0pOworCWlmIChjaGlwLT5vcHMpIHsKKwkJbXV0ZXhfbG9jaygmY2hpcC0+dHBtX211
dGV4KTsKKwkJaWYgKCF0cG1fY2hpcF9zdGFydChjaGlwKSkgeworCQkJdHBtMl9mbHVzaF9zZXNz
aW9ucyhjaGlwLCBzcGFjZSk7CisJCQl0cG1fY2hpcF9zdG9wKGNoaXApOworCQl9CisJCW11dGV4
X3VubG9jaygmY2hpcC0+dHBtX211dGV4KTsKIAl9Ci0JbXV0ZXhfdW5sb2NrKCZjaGlwLT50cG1f
bXV0ZXgpOworCXVwX3JlYWQoJmNoaXAtPm9wc19zZW0pOworCiAJa2ZyZWUoc3BhY2UtPmNvbnRl
eHRfYnVmKTsKIAlrZnJlZShzcGFjZS0+c2Vzc2lvbl9idWYpOwogfQotLSAKMi43LjQKCg==
