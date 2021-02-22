Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B24B320EDB
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Feb 2021 02:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhBVBDp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 21 Feb 2021 20:03:45 -0500
Received: from mout.gmx.net ([212.227.17.21]:37135 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhBVBDp (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 21 Feb 2021 20:03:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613955421;
        bh=lRzqWBl0sthZOBbQ0rNx91fg0tHkddzH7h/62HAEdFU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=MTUMmsb7XeNsdwAik+EKkNY1WS/GcOQ8l6URuioT+hASZjBHmObs+yYr8zPpCurUM
         F/llHFrQsLl03usDexEiwxEL69s631ZYEPCR4frkMbo/NzZdWPWPxAJn5ILN+lUMPf
         QgtBy2QuDC8wt8Cypm9o8YO0dTYAqxSODuMVdpZ8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([78.42.220.31]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfYLQ-1ll9YD2PHc-00g4HK; Mon, 22
 Feb 2021 01:57:01 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, James.Bottomley@hansenpartnership.com,
        jsnitsel@redhat.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, LinoSanfilippo@gmx.de
Subject: [PATCH 1/4] tpm: Use a threaded interrupt handler
Date:   Mon, 22 Feb 2021 01:56:31 +0100
Message-Id: <1613955394-13152-2-git-send-email-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1613955394-13152-1-git-send-email-LinoSanfilippo@gmx.de>
References: <1613955394-13152-1-git-send-email-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:9S103CTZTOAfpyXMxVOuZC6DMdivoa+VP6szX9XjvlkwtMDvAAa
 yqdk7kh4h4k4psAz89YdajY+AxlMrHuYnNg8xlsSwOfK5jeXmrOgKcvTza5vE0F7I5e+lNi
 kM915VuKVhV+EDicWGbdqY8t0+Ky/zn2tC0F9BOsgn/MU59Lak2vf3lO0XzP17vt8IXlnqM
 aoJSW0/mgwV1ONqUkagUw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kMhtXEKv2po=:cb1L8fPqIfwt53CBIsu2pr
 Uh7DAs4cZgAlzMKHppdU0aSjtn4tSsRibA85x8a75bT+fBSI8/M9Umna0DFu6J9YhviIiko7b
 0DjCIPRUtbj7zvo4kvYsn64IRPq3pi7DJ+qhOF5KZ/66VGR+1YaKqzG9l+2slVRuvwY979zBd
 OxcofA0AytfvgtAFUAxsoQWSHZUGlNkRxb6hnIyeDqbhmkaBeFARjPAXeSpg9Vs6Pwjmr1ifF
 rzUN+t3eeFLCeD0RrQUy7nU1TcAp4DYIAfZ0Sy5ieM8B9ts7UG2KJWrA5gxY8S/MPFAyNSFA9
 vS6gdHwiYLUYxieSG7FmpXfL4PerbTX2Yt0MDT0nu6NzyQ5hVEAbcvDErgHgPAHp61r5AmDlo
 EDeQWmafrZN/uJrAM3k+vM4CEN7feovwqb0CDj3QRWmlVfcNyPJTxwMofocnxwJp1cFeVdXoM
 KaovUT1nB5erowwCc4KQ18B5tKHnXBONNZ18G4ebF7EITpte1fPoHw46g75hwssdWA+8+XXXC
 nNT2YeIiv7uvwzfyokdsEY5tk6LZ3ODiq8mJAEVuWwAYDOc4C/OeHYjPEawyTlTPabRY+yWgK
 d0ppaTSHntaKVbl1nr3dt5vB15d7x3BVMvCrs+KQpkl7JayJNZNJqohQXlGAY1UvzTVph+d9n
 as5uCHhI/g0nqtfORz6HG5wfTYlwYGaiV1nbfN2eC6Bx9IxDSNdlYm/k5Eyfpd5sFrNtSdtgt
 e0kEcSxtSCRVYNorsrSlZZQ8I3BKAUTU1RM+T9gI28GrJ5gK/bPHv1MjecNZwNiFxPwM9Rm2/
 3lFQX/CxGHdZ1KfLOlkOWHVvtTJaKxIhvrJMpxE00KuSa2Lc0aESJunpIVX23WpPIHjkYpfk6
 eioC70GyU6E7lfVxw1VQ==
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

V3JpdGluZyBhbmQgcmVhZGluZyByZWdpc3RlcnMgb3ZlciBTUEkgcmVxdWlyZXMgYSBzbGVlcGFi
bGUgY29udGV4dCwgc2luY2UKYSBtdXRleCBpcyB1c2VkIGluIHRoZSBjb25jZXJuaW5nIGZ1bmN0
aW9ucy4gU28gaW5zdGVhZCBvZiBpbnN0YWxsaW5nIGEKZ2VuZXJpYyBpbnRlcnJ1cHQgaGFuZGxl
ciB1c2Ugb25lIGZvciB0aHJlYWRlZCBpbnRlcnJ1cHRzLiBUaGlzIHByb3ZpZGVzCnRoZSBzYW1l
IGZ1bmN0aW9uYWxpdHkgYXMgYmVmb3JlIGJ1dCBhbHNvIGFsbG93cyBTUEkgZnVuY3Rpb25zIHRv
IGJlCmNhbGxlZC4KClNpZ25lZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8TGlub1NhbmZpbGlw
cG9AZ214LmRlPgotLS0KIGRyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMgfCA2ICsrKyst
LQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jIGIvZHJpdmVycy9jaGFyL3Rw
bS90cG1fdGlzX2NvcmUuYwppbmRleCA5MmM1MWM2Li4yYzk1NmExIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCisrKyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rp
c19jb3JlLmMKQEAgLTc3MSw4ICs3NzEsMTAgQEAgc3RhdGljIGludCB0cG1fdGlzX3Byb2JlX2ly
cV9zaW5nbGUoc3RydWN0IHRwbV9jaGlwICpjaGlwLCB1MzIgaW50bWFzaywKIAlpbnQgcmM7CiAJ
dTMyIGludF9zdGF0dXM7CiAKLQlpZiAoZGV2bV9yZXF1ZXN0X2lycShjaGlwLT5kZXYucGFyZW50
LCBpcnEsIHRpc19pbnRfaGFuZGxlciwgZmxhZ3MsCi0JCQkgICAgIGRldl9uYW1lKCZjaGlwLT5k
ZXYpLCBjaGlwKSAhPSAwKSB7CisKKwlpZiAoZGV2bV9yZXF1ZXN0X3RocmVhZGVkX2lycShjaGlw
LT5kZXYucGFyZW50LCBpcnEsIE5VTEwsCisJCQkJICAgICAgdGlzX2ludF9oYW5kbGVyLCBJUlFG
X09ORVNIT1QgfCBmbGFncywKKwkJCQkgICAgICBkZXZfbmFtZSgmY2hpcC0+ZGV2KSwgY2hpcCkg
IT0gMCkgewogCQlkZXZfaW5mbygmY2hpcC0+ZGV2LCAiVW5hYmxlIHRvIHJlcXVlc3QgaXJxOiAl
ZCBmb3IgcHJvYmVcbiIsCiAJCQkgaXJxKTsKIAkJcmV0dXJuIC0xOwotLSAKMi43LjQKCg==
