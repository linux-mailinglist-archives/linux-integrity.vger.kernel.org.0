Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDB34C80F0
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Mar 2022 03:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiCACWc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Feb 2022 21:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiCACWb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Feb 2022 21:22:31 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BE9D5F;
        Mon, 28 Feb 2022 18:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646101296;
        bh=WIDIRWd5lprM1nq14xSroAHwSBuavxMVQkYNOePEUd0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=iiBLurauw9vWCsX0laA0wqsiSWaxmnYYxHree2hESw7Rd1Ud1u5YGpvcmG0yLEYJl
         kKGbejRQsusSXN7umJyY70BCwPyNj5BSXiu55eIzOQjDArL/oCjggmdtq2ZPk7Zv7R
         3257aiicd+qvFrjGdIj1ZZn0hnJMAnaz6SE790gY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mnps0-1o0jzG07Ew-00pK44; Tue, 01
 Mar 2022 03:21:36 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, James.Bottomley@hansenpartnership.com,
        David.Laight@ACULAB.COM, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.rosenberger@kunbus.com,
        LinoSanfilippo@gmx.de
Subject: [PATCH v8 0/1] tpm: fix reference counting for struct tpm_chip
Date:   Tue,  1 Mar 2022 03:21:07 +0100
Message-Id: <20220301022108.30310-1-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:1hj6O9Xlmw9zRBFg2GpWl8Yo1MTILLKm+B4WAaXnwUa0rhHgdcw
 8+eYTeCXSsAiFLtKxG5WgR+f6ZlaHvIj1r1/a44jTE+oFTpedd6ewweskyizd/fPolGSOrE
 u6viNfUFUYomd07/9w1AtIT1fAzHQb/wW2J+qmEg5h64bbseXLMzmxb/+wXhbOCtoF+y+Wm
 gsEZIk9A2UYqpWR0ahJ8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q5AYTQgSRrk=:XGrpTGL21sYEDAdUiC7NrF
 l+Bl/+N8JwJ65SgRvvIK3L++6O0mOQv0od1RSbuS7rdgq1xbEy9uF/zL7sc64vOrsu+p3VBYZ
 MF8XxX1wCuDYNvKJOx40nupFIQfurYSn9IXqfcgnGH0GAaYXDM0yRyhp4mCLU5GyLdfDmS7Lq
 nOk6pr5S2gpWH0L0NXH2CKnF607RGSpE+cYMvCNibaQn6ntwZpnLswPfSDNNnzkeQDA3XoVJG
 5MG9jLf8ruQP2udy17w8ywE/5Nq1yrOYNi+4Io/YTKj51LkXG9Vvxw08nbaFNd3a+AAXgmWMe
 HfIu62BPy3051V2UVg/gQuCkWWPjp/iMPltOFFb3Pp7zr1cDe3fkD0WrilbNZZuiZ01WxOgBa
 Tv1dACHw1GqLcdIl3KiWA8xqlt8q/mmfsBo15nj4KhJfVEG9cQCKjvwaPbP5hp+0N3s8TU/PI
 YOxdvATU7B5xwR1zAlCK+juYEPzfqsRbmtvGWhYVQYwFdRYMn3K5JeMHPIX3dRo6lI4WZHLIo
 M9w6S51M98u7GC9iqOknLPX2mha32gud/+7AT4I1ptqOsemYdNFIalNt0hCuY/5essWzTTw2c
 PV8vPgl3LS9FAmY/IIDxz463kBp9zT8ooSY/wKXEzWPB6vxbVvbihZLDRqjDFYbt26R6tSNtZ
 bT6tqMKgbqNmTrNOa60JTmdQXel/7kw2HIGJWhjgxrG6tst7QjUOnTAhWIKn3e1+W4TcEtV3U
 ffcQgCFKiab1GjaG1+v75ypO+7ceOJAQni3uuEATdfDjrIHtyZ7Ns/ydji2BAcTlkAuAhusDi
 +qH0MK7Ld1i1r31TVWXO/d2g4dp/stxgFLZPOIFC8SDVCzYumC/o8vdpqy3RN75XsyNVb9r9U
 8ru2AF2ZcCskQZbiaIMKHCFqG5W+mB/nruK/kDE2mreWZMMSrCcxwH6NZzbv5ZptFytMrBXJi
 O3aIie4W68AccvzNrdd3uB2yQjjOANBl4coUDZb5kK1ytBrBhJLTp5OSWqG+RqlKtMeKK26QR
 2YsCsmcB7KlyUmIScFCpYwLueqB72gfLYpwqKo8H5mKvXbk2dEwhXQR+PuaoEFVT9MpOltGKj
 OzjIczK5uQY1Wg=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

VGhpcyBwYXRjaCBmaXhlcyBhIHJlZmVyZW5jZSBjb3VudCBpc3N1ZSBpbiB0aGUgVFBNIGNvcmUg
Y29kZS4KCkNoYW5nZXMgaW4gdjg6Ci0gYWRqdXN0IG5hbWVzIG9mIGp1bXAgbGFiZWxzIGZvciBl
cnJvciBjYXNlcwoKQ2hhbmdlcyBpbiB2NzoKLSBhZGp1c3QgbmFtaW5nIG9mIGp1bXAgbGFiZWxz
IHRvIGZpdCBiZXR0ZXIgdGhlIHVzZWQgbGFiZWwgbmFtaW5nIHNjaGVtZQoKQ2hhbmdlcyBpbiB2
NjoKLSByZW5hbWUgZnVuY3Rpb24gdHBtMl9hZGRfZGV2aWNlKCkgdG8gdHBtX2RldnNfYWRkKCkg
YXMgcmVxdWVzdGVkIGJ5IEphcmtvCi0gYWRkIGZ1bmN0aW9uIGRlc2NyaXB0aW9ucwotIGZpeCBz
b3VyY2UgY29kZSBmb3JtYXR0aW5nCgpDaGFuZ2VzIGluIHY1OgotIG1vdmUgZnVuY3Rpb24gdHBt
X2FkZF90cG0yX2NoYXJfZGV2aWNlKCkgdG8gdHBtMi1zcGFjZS5jIGFuZCByZW5hbWUKaXQgdG8g
dHBtMl9hZGRfZGV2aWNlKCkgYXMgcmVxdWVzdGVkIGJ5IEphcmtvCi0gcHV0ICJjYyIgdGFnIGJl
Zm9yZSBhbGwgb3RoZXIgdGFncyAKLSBlbnN1cmUgdGhhdCB0aGUgZXJyb3IgcGF0aCBpbiB0cG0y
X2FkZF9kZXZpY2UoKSBhbHdheXMgY2FsbHMgCnRoZSByZWxlYXNlKCkgZnVuY3Rpb24gb2YgY2hp
cC0+ZGV2cyBhcyByZXF1ZXN0ZWQgYnkgSmFzb24KLSByZWZvcm1hdCBhIGNvZGUgbGluZSBhcyBz
dWdnZXN0ZWQgYnkgRGF2aWQgTGFpZ2h0CgpDaGFuZ2VzIGluIHY0OgotIGRyb3AgcGF0Y2ggMiAo
dHBtOiBpbiB0cG0yX2RlbF9zcGFjZSBjaGVjayBpZiBvcHMgcG9pbnRlciBpcyBzdGlsbAp2YWxp
ZCkgc2luY2UgSmFtZXMgQm90dG9tbGV5IG9mZmVyZWQgYSBjbGVhbmVyIHNvbHV0aW9uIGZvciB0
aGlzCi0gcmVpbXBsZW1lbnQgcGF0Y2ggMSB0byBzZXR1cCB0aGUgL2Rldi90cG1ybSBkZXZpY2Ug
b25seSBpbiBjYXNlIG9mIFRQTTIKYW5kIGF2b2lkIHRoZSBpbnN0YWxsYXRpb24gb2YgYW5vdGhl
ciBhY3Rpb24gaGFuZGxlci4gVGhpcyBpcyBiYXNlZCBvbiBhCnN1Z2dlc3Rpb24gYW5kIGJhc2lj
IGltcGxlbWVudGF0aW9uIGRvbmUgYnkgSmFzb24gR3VudGhvcnBlLgotIGFkZGVkIHRhZyB0byBD
QyBzdGFibGUKCkNoYW5nZXMgaW4gdjM6Ci0gZHJvcCB0aGUgcGF0Y2ggdGhhdCBpbnRyb2R1Y2Vz
IHRoZSBuZXcgZnVuY3Rpb24gdHBtX2NoaXBfZnJlZSgpCi0gcmV3b3JrIHRoZSBjb21taXQgbWVz
c2FnZXMgZm9yIHRoZSBwYXRjaGVzIChzdHlsZSwgdHlwb3MsIGV0Yy4pCi0gYWRkIGZpeGVzIHRh
ZyB0byBwYXRjaCAyCi0gYWRkIEphbWVzIEJvdHRvbWxleSB0byBjYyBsaXN0Ci0gYWRkIHN0YWJs
ZSBtYWlsaW5nIGxpc3QgdG8gY2MgbGlzdAoKQ2hhbmdlcyBpbiB2MjoKLSBkcm9wIHRoZSBwYXRj
aCB0aGF0IGVycm9uZW91c2x5IGNsZWFuZWQgdXAgYWZ0ZXIgZmFpbGVkIGluc3RhbGxhdGlvbiBv
ZgogIGFuIGFjdGlvbiBoYW5kbGVyIGluIHRwbW1fY2hpcF9hbGxvYygpIChwb2ludGVkIG91dCBi
eSBKYXJra28gU2Fra2luZW4pCi0gbWFrZSB0aGUgY29tbWl0IG1lc3NhZ2UgZm9yIHBhdGNoIDEg
bW9yZSBkZXRhaWxlZAotIGFkZCBmaXhlcyB0YWdzIGFuZCBrZXJuZWwgbG9ncwoKCkxpbm8gU2Fu
ZmlsaXBwbyAoMSk6CiAgdHBtOiBmaXggcmVmZXJlbmNlIGNvdW50aW5nIGZvciBzdHJ1Y3QgdHBt
X2NoaXAKCiBkcml2ZXJzL2NoYXIvdHBtL3RwbS1jaGlwLmMgICB8IDQ4ICsrKysrKystLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQogZHJpdmVycy9jaGFyL3RwbS90cG0uaCAgICAgICAgfCAgMSArCiBk
cml2ZXJzL2NoYXIvdHBtL3RwbTItc3BhY2UuYyB8IDU1ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDY2IGluc2VydGlvbnMoKyksIDM4IGRlbGV0
aW9ucygtKQoKCmJhc2UtY29tbWl0OiA3MTlmY2U3NTM5Y2QzZTE4NjU5OGUyYWVkMzYzMjVmZTg5
MjE1MGNmCi0tIAoyLjM1LjEKCg==
