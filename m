Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F248D2F8A54
	for <lists+linux-integrity@lfdr.de>; Sat, 16 Jan 2021 02:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbhAPBZQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Jan 2021 20:25:16 -0500
Received: from mout.gmx.net ([212.227.15.18]:45783 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbhAPBZQ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Jan 2021 20:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610760217;
        bh=xjaNy2jhggcb4Dwq4QKbDLswe0FZxJm5YOihOK0R47Y=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=iINcEsvccuNiMKRkXHjBx5npYtxzX2XeOLhAWu3ep+xk1x4KhpKy6EvRAq47ED61C
         A0+ST9r28aXGbOe4YUVcoNI9slDRTcmRMP7GOyVcXKWfeNe1AIp3/lfJGM7wQogUhh
         gcDVVjqUMMccBmZUo3ZmWQk+4VqtE6bFvMCRVDwc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([78.42.220.31]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8ygO-1l5Yel0kgo-0065xX; Sat, 16
 Jan 2021 02:23:37 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org
Cc:     jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        LinoSanfilippo@gmx.de, p.rosenberger@kunbus.com
Subject: [PATCH 0/4] TPM fixes
Date:   Sat, 16 Jan 2021 02:22:37 +0100
Message-Id: <1610760161-21982-1-git-send-email-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:LTvCw+DJfok177BhcUpGz04TJV5msyWUJhtqkH5ijX5qIHhP9R3
 BVApJHWOkN2YxUQoAm77ibAAS6z2ca6pEN5Qdd4x6Os1P06tPBHSS7QcX5PAJv+56210Y9n
 HaKDF1Cf1weXuIUOtWI2rBageTwYkarDkao4laeFx79wCoWnt0Jq306eQsLOL1/LU9eYtYY
 P9TQBxru8u7MAMLMUfjew==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5U/8eqHYO1k=:AyVG1umk338o4BAqsDqv59
 +3R2L0/LNTKwMzC+U3a7hSi5ObB3RBCqIAdwYExY8nmlD3macTv/u/N5htHB8fBkL9f0Y+/E4
 iVGNgosY78dKYf2odFMcwD7YNR3ln1K+meDkdbYfV3sTOKdEBksuzizReFbh4zVrhHRKcs6yq
 F05EQiK2F7zOjCOiwoB3Yf5ajvny2f/ufyG9HfdAS+Y7ZCkyTjm8G9Pt67JwmBLS8yk74HeR/
 1SbtWtfeqjeXa8Em8ucYmCj21d+dkcP6p62GU33C7DL13J7xxfD+aoxH0PdpJ7CGcQ/KlW8Ew
 DNyrfzYJk1ri5RJoT4qFtKFSmCKRByXD9Y3WOf4RDXivHmWfYP0rIKqV69DFd1zY+LdgzKVH7
 OhdRwyndNB/+fUr3gKcE7qEEGHvvJ/2GQ8jF2Q9oUh3h8xp4cpti61fTXwUO9tDP3WehEhGBZ
 3ZQNwWzXrElD8CbBpZDO2qryNU67tKzsNoxQJtbE3rGpkZLCHlIUhTdrwVHNmMg9PsiH+jvD4
 NYK3GLqxnPm8ec+myF7FH9pU/GWmbDPDnoB+ekPU1IYobm6Y1xv9sviUoXZk/vyDvltL/bIvR
 uFeSG32AWPlP7HkHMma8XzE+/f/qcalwxN+evts+pA9opgFfgI6nABy2sM1EsJKP4gGk1Z1sS
 a+VBZKeb6QRhHCc7ZbG5RI7piS+6m99QAHTzLh1HHRfVbA4wJA3SYRSHE0mpghstuKc7zdDmy
 MYIbA9O4Qn7lloN1Bsi7/l/3fJEZ3XHwe5waOgN1RTk7wwR4HQLC+OLIqr2R9yz5a03+3Vgi5
 /n+tZOLC5NFhAafnsb3m9NEMzPk9CynE0iFcakXhcZoij5xIzElMFdpWsk83CAn3oBg0iXHnt
 sp0l/0WLA18O86MLNJ1w==
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

VGhpcyBwYXRjaCBzZXJpZXMgZml4ZXMgc29tZSBmbGF3cyBpbiB0aGUgVFBNIGNvZGUuIE1vc3Qg
aW1wb3J0YW50bHkgYQpyZWZlcmVuY2UgY291bnQgaXNzdWUgKHBhdGNoIDIpIGFuZCBhIHBvc3Np
YmxlIE5VTEwgcG9pbnRlciBhY2Nlc3MKKHBhdGNoIDMpLiBQYXRjaCAxIGZpeGVzIHRoZSBlcnJv
ciBwYXRoIGluIHRwbW1fY2hpcF9hbGxvYygpIGFuZCBpcyBpbgpwcmVwYXJhdGlvbiB0byBwYXRj
aCAyIHdoaWNoIGV4dGVuZHMgdGhpcyBmdW5jdGlvbi4gUGF0Y2ggNCBpbnRyb2R1Y2VzCmEgbmV3
IGZ1bmN0aW9uIHRwbV9jaGlwX2ZyZWUoKSB3aGljaCBpcyB1c2VkIGFzIGEgY291bnRlcnBhcnQg
dG8KdHBtX2NoaXBfYWxsb2MoKS4gVGhlIG1haW4gcmVhc29uIGZvciB0aGlzIGZ1bmN0aW9uIGlz
IHRvIGhpZGUgdGhlCmludGVybmFscyBvZiB0cG1fY2hpcCBjbGVhbnVwIGJ5IG1lYW5zIG9mIG11
bHRpcGxlIHJlZmVyZW5jZSBjb3VudApoYW5kbGluZy4KCkxpbm8gU2FuZmlsaXBwbyAoNCk6CiAg
dHBtOiBpbiBjYXNlIG9mIGVycm9yIHByb3Blcmx5IGNsZWFudXAgaW4gdHBtbV9jaGlwX2FsbG9j
CiAgdHBtOiBmaXggcmVmZXJlbmNlIGNvdW50aW5nIGZvciBzdHJ1Y3QgdHBtX2NoaXAKICB0cG06
IGluIHRwbTJfZGVsX3NwYWNlIGNoZWNrIGlmIG9wcyBwb2ludGVyIGlzIHN0aWxsIHZhbGlkCiAg
dHBtOiBQcm92aWRlIGEgZnVuY3Rpb24gdHBtX2NoaXBfZnJlZSgpIHRvIGZyZWUgdHBtIGNoaXBz
CgogZHJpdmVycy9jaGFyL3RwbS90cG0tY2hpcC5jICAgICAgIHwgMzMgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLS0tCiBkcml2ZXJzL2NoYXIvdHBtL3RwbS5oICAgICAgICAgICAgfCAg
MSArCiBkcml2ZXJzL2NoYXIvdHBtL3RwbTItc3BhY2UuYyAgICAgfCAgMiArLQogZHJpdmVycy9j
aGFyL3RwbS90cG1fZnRwbV90ZWUuYyAgIHwgIDQgKystLQogZHJpdmVycy9jaGFyL3RwbS90cG1f
dnRwbV9wcm94eS5jIHwgIDIgKy0KIDUgZmlsZXMgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKSwg
NyBkZWxldGlvbnMoLSkKCi0tIAoyLjcuNAoK
