Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F172F8A5F
	for <lists+linux-integrity@lfdr.de>; Sat, 16 Jan 2021 02:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbhAPBZd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Jan 2021 20:25:33 -0500
Received: from mout.gmx.net ([212.227.15.15]:54637 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbhAPBZQ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Jan 2021 20:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610760218;
        bh=RllRKwXuRdY908zIMhQCzfTVTvy1FyJcMAFll2CdYOg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=AfxmsLSqk+D3vpEqQj6urhp9UzC9A7+oSUlL0DuCy7Kz3cnUFuYw3tJNIKZidgCaE
         w5vsL5zS4RftUWZav9AftqnZH/L8Sk1lsc9A8xkOzAcuItLsRtXCF2dh87erBnsx//
         zKiYRrx8pm49HlTqQ1f2j8fb8viR9x93ApUaJE5w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([78.42.220.31]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYNJg-1lUomW0udW-00VQqZ; Sat, 16
 Jan 2021 02:23:38 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org
Cc:     jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        LinoSanfilippo@gmx.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH 3/4] tpm: in tpm2_del_space check if ops pointer is still valid
Date:   Sat, 16 Jan 2021 02:22:40 +0100
Message-Id: <1610760161-21982-4-git-send-email-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610760161-21982-1-git-send-email-LinoSanfilippo@gmx.de>
References: <1610760161-21982-1-git-send-email-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:ZsvOIgcO2aTxCN/WelIU/Ca2Qcol1VSd4kBnXdZOdTWHNjn6uYr
 zSSpwUL0M0IG4ejhaoCwRoEIJ4QaqqNCJO2smcvfumFxDDvOWVAAnOdbrhdvLWdhFl2MsxI
 NTEq+UmhOJNvzIaZd7h08MObp9EJWoNWNtD6PWQqYhEwfSSY2LSo3LKIEJFjUGDqVM3UlXs
 I4z+mZFeAmVYWdK0Oaupg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nvY53QdNuuI=:cFt/j42cwoIISNHFTDCWby
 amS0H8TQ+aLUeAd22WD7UdY164r6zopwXJs/pjUWULQ5sGDvEHYnNRljtwoyKKDQF6fxjf3DJ
 To5z90CiuebSnRkHwHs+29rSCaHIDlb3Gk7k3CSO2xn1xIyUbA6dIIdkV3w0Vq5kk1VpAd5Bk
 3QE2VIkNd4GZ+rx/iUBLXJYuHXhep0l0lTcgf/QTtT0AHlrQZqnWkhzRVHNNHQC0cA9HLaGlB
 jKD3H3ybyMQLGjpXrUi9jFvbDcM09we/7NHT/lvL8uBDe4r5wNaWJIysenjqxX4czkJnPSw5d
 qNGlMR+E6s9730gcORmgAwRkNzRS5WqSineXZJFpc3ykvwL65pjg/WW27n6Oj+Y83GPVAGu5D
 zK0axK2/v2+sON1K/Zs973+/6xxhyR94lS4zdG+Zd+cnpKNA+mRoezjxVLL3aMBLZwKxVK2IC
 QcKEUIqYkU0ozFmrzyu/KdQPE4mtt8X78UdgnTkbPzPHWtZJ5QasjVqXruIxQWbyze2MKV7kC
 iPRT+AbKOF7ZquZ4ADfWruw2VjfrjDzmCeLw1jbYD14LW998KCpe/PqV3/bP5sjhxE0FKts2y
 6lHJOonDTiAJLjVXVWhi5efJvGYyvIqAXeQrHUrV4/AhrxsPcymkv5Thhis8weRU6UmobDsmK
 JyvXhnvIu3Ch3LgEgffSSqq05B0PbABzJgT6DEdAudC003L1fydlloDxYx3/2+yZNvsY6X4co
 enp34S2ailm0hGNAUOXmYbHwlh7UNGmJXP6pTd8O2qDO7LbU/LXbi85D56wceuBEoHxrJH1Mq
 iiT9rIXSdR97oKH/e6BVmZ5zjtNy9+QL6+b2/B2NxrpTp6fmmD/MEBEnuF0cqA8BWvUPHrnpo
 doK7QOjFZEhOzNpm4LmQ==
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkluIHRwbTJf
ZGVsX3NwYWNlKCkgdGhlIHNlc3Npb25zIGFyZSBmbHVzaGVkIGJ5IG1lYW5zIG9mIHRoZSB0cG1f
Y2hpcApvcGVyYXRpb25zLiBIb3dldmVyIHRoZSBjb25jZXJuaW5nIG9wZXJhdGlvbnMgcG9pbnRl
ciBteSBhbHJlYWR5IGJlIE5VTEwgYXQKdGhpcyB0aW1lIGluIGNhc2UgdGhhdCB0aGUgY2hpcCBo
YXMgYmVlbiB1bnJlZ2lzdGVyZWQgKHNlZQp0cG1fY2hpcF91bnJlZ2lzdGVyKCkgd2hpY2ggY2Fs
bHMgdHBtX2RlbF9jaGFyX2RldmljZSgpIHdoaWNoIHNldHMKY2hpcC0+b3BzIHRvIE5VTEwpLgpB
dm9pZCB0aGUgTlVMTCBwb2ludGVyIGFjY2VzcyBieSBmaXJzdCBjYWxsaW5nIHRwbV90cnlfZ2V0
X29wcygpIHRvIGNoZWNrCmlmIHRoZSBvcGVyYXRpb25zIHBvaW50ZXIgaXMgc3RpbGwgdmFsaWQg
YW5kIHNraXBwaW5nIHRoZSBzZXNzaW9uIGZsdXNoaW5nCmluIGNhc2Ugb2YgYW4gdW5yZWdpc3Rl
cmVkIGNoaXAuCgpTaWduZWQtb2ZmLWJ5OiBMaW5vIFNhbmZpbGlwcG8gPGwuc2FuZmlsaXBwb0Br
dW5idXMuY29tPgotLS0KIGRyaXZlcnMvY2hhci90cG0vdHBtMi1zcGFjZS5jIHwgMiArLQogMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9jaGFyL3RwbS90cG0yLXNwYWNlLmMgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbTItc3Bh
Y2UuYwppbmRleCA3ODRiOGIzLi5lYTZlZWU5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvdHBt
L3RwbTItc3BhY2UuYworKysgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbTItc3BhY2UuYwpAQCAtNTks
NyArNTksNyBAQCBpbnQgdHBtMl9pbml0X3NwYWNlKHN0cnVjdCB0cG1fc3BhY2UgKnNwYWNlLCB1
bnNpZ25lZCBpbnQgYnVmX3NpemUpCiB2b2lkIHRwbTJfZGVsX3NwYWNlKHN0cnVjdCB0cG1fY2hp
cCAqY2hpcCwgc3RydWN0IHRwbV9zcGFjZSAqc3BhY2UpCiB7CiAJbXV0ZXhfbG9jaygmY2hpcC0+
dHBtX211dGV4KTsKLQlpZiAoIXRwbV9jaGlwX3N0YXJ0KGNoaXApKSB7CisJaWYgKCF0cG1fdHJ5
X2dldF9vcHMoY2hpcCkgJiYgIXRwbV9jaGlwX3N0YXJ0KGNoaXApKSB7CiAJCXRwbTJfZmx1c2hf
c2Vzc2lvbnMoY2hpcCwgc3BhY2UpOwogCQl0cG1fY2hpcF9zdG9wKGNoaXApOwogCX0KLS0gCjIu
Ny40Cgo=
