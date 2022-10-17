Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B936601DF6
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Oct 2022 01:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiJQX6O (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Oct 2022 19:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiJQX6N (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Oct 2022 19:58:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADCD7E326;
        Mon, 17 Oct 2022 16:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666051073;
        bh=KEA4wfis+vvcc4jeyKKQbKPArLj4tacnaogTuqRwocY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VwkBy4qkAUamg/cyvpBu4RBbcyHXsIMZLp7MfHllM7E/XccXueflc0KjvJ7EvZURp
         C+1rcjVyhXtahFUyUcPbPmqXAAaK5Acfja85PmEseyHSzxQlZkXv45M9B6sx7kdLU4
         Naz4aS8vvlQDja1ZUzZXiZWmmmMhPMMbOq78UlyU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.speedport.ip ([84.162.5.241]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N33ET-1p79Se1OIv-013NRz; Tue, 18
 Oct 2022 01:57:53 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v8 09/11] tpm, tpm_tis: Request threaded interrupt handler
Date:   Tue, 18 Oct 2022 01:57:30 +0200
Message-Id: <20221017235732.10145-10-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221017235732.10145-1-LinoSanfilippo@gmx.de>
References: <20221017235732.10145-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:dIa9SZQTn6cWmM3h4lHDimeagtlxOyrDcI1LJ7rggPeOZ74g5CN
 oYk73lhX/30vNw/cn58H4fIerri4GH3ig0PE//0dzyzOxoTjOA6G1UxUSxq6V/rXDlXpyKY
 9dNvexRXEScfOqcqJi9ZK3sAxs47CWUHQqUaa5YORsFHEPEq3/UI4gNTxfzTJFmB8Bo6mCl
 IQoX9wvsPKJEva/V76W/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qLWQza80+UM=:D8V6UTfb5HsVEY+PZLCnrS
 6nxKEdsyN0TKelnMq3tzaUZs3ARqcFwxfgxkE85CeeR1m19VMQOOtgEtRV8KK84iClJHy4Qx9
 QgF+nhXdjFqSj+2jslagWZrlv8pXPPAjUx2WflHiPyFoG9W7cnoJX7Uzbu1kJcuY176YXNMsy
 cq42t5u6EjwYBXDU5Vb5SuKLmPf3PAbu8/VeaE9hDYWVuYml4HLfcW0FnmYHxhLoMGN5eRxNe
 TQkUgooLH9MCceTGr4dwXAT9oRtyfwl3BQxIVczYOKEPFboZsqR6as0i5Ill7s5MotDDuX18/
 OuGN4FR0hkIGDE9SsLbM0ewWvVJCol+MiogzWBs+PCl1zwnAJD3tS1bqPQK0kjTO4cnh4mI+7
 dn+VhYdpD7kVkAcdKjxm651DQfIjUdLi+pklZHR7xVnzdAJK1qA01ZbnRBk+aX0V0lSRnO4av
 wS/dc5AioNF2ZKhGfBiwm01IK1dBoqFJR+mGY+Rk7xGALxu7ELy0qy8Xehk7atjCdAs7l70zl
 sZbkEoKhfaItnzOCZZDnkTsfmhMNE4aKqtmERBp2//5/XTNuirTurbYnD1qKEjUqTwuQbQSBz
 G3utCGPlEadXPwLm4c14mBl2dAWcWeMcEh36i1K3YOe0QJ3Nsf0Mlv6G0n/nvmV2gEvlbKudR
 b2bXBG7yL1OgTD3lwSRZXfV4W9a2yVDSS10oUFmv92d9Goz296A4fTz65kQqCBGNxbJmeJZdF
 U76qa29E9JbWkfHMnWMEcqJkN6yA9ReP/hBlXjGBcyc5O6D4qi+qUWXtojitX5WecSHXGPJLV
 8qU/AAUUmiwcfJ19/Ad9KTOLQe12nsLgtKEgvg6HJ48GojwMzgEhZAzMLIOPxFKJxPTssb2fG
 IWjALdOXhun1808GPGfEoesuqm9KrrZLS4kFbOAiA0h+dTsRBsqTTcr9snIYXcxp/WS2DEdzE
 mgXNKVBsKC2iI8bOrPky1l9CksQ7cVUP0T1jUJHjodYD9NU9so9mXZTy0lzSf/rBe0U5SloRa
 qm8RGJro7Hhy/TBI7790mQIc4xD6Z0IzzrBDhP1y1QfLsQWjUFy3EArdRofQCgGaDfQv2vwQo
 JxB0L9cqgayCxvdmGE2uIiGOSV8365Ii4ePl/MFLa05nTxX7wUrPhrJ0qFSrLebvyzWd7OQWu
 AwkzzlVX88IP0D6Bjy/0kHC35ZS05FVHjxWH4jQC2wbGQOrNZqSz+F4+Kgr+VBBb53QjQop8+
 9w/OFuTKwSggq6QopV/QgMzUMWg+gRgz/qFUv/8avMYefetxj98bWgszFwl3qftsmfS0djy6S
 15pCohFe8sZ5o3CSzuRW0ni3B59Hv9tKOTlv9PENmKSZ4BsMcCAD6m/BsfAZwiaxmrMTl+I56
 EghAPJlJfxhW+dr5VxA1pzGvsT83hwn7NBJNHAP+qAWcNk9BA5n3fzQALxvKOPcraL0YXcG5Y
 maV9FO8LUs4qeHqpgoIkXuJDj947YlzFvfh2v2mXljMc1/A8JtrGR0o/mCnbRQTJ+dnrvgutx
 TpEemKqb96ChCEkNofbO0yUou/5pXtd6yGl5dps/3ErQg
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KClRoZSBUSVMg
aW50ZXJydXB0IGhhbmRsZXIgYXQgbGVhc3QgaGFzIHRvIHJlYWQgYW5kIHdyaXRlIHRoZSBpbnRl
cnJ1cHQKc3RhdHVzIHJlZ2lzdGVyLiBJbiBjYXNlIG9mIFNQSSBib3RoIG9wZXJhdGlvbnMgcmVz
dWx0IGluIGEgY2FsbCB0bwp0cG1fdGlzX3NwaV90cmFuc2ZlcigpIHdoaWNoIHVzZXMgdGhlIGJ1
c19sb2NrX211dGV4IG9mIHRoZSBzcGkgZGV2aWNlCmFuZCB0aHVzIG11c3Qgb25seSBiZSBjYWxs
ZWQgZnJvbSBhIHNsZWVwYWJsZSBjb250ZXh0LgoKVG8gZW5zdXJlIHRoaXMgcmVxdWVzdCBhIHRo
cmVhZGVkIGludGVycnVwdCBoYW5kbGVyLgoKU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBv
IDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KVGVzdGVkLWJ5OiBNaWNoYWVsIE5pZXfDtmhuZXIg
PGxpbnV4QG1uaWV3b2VobmVyLmRlPgpSZXZpZXdlZC1ieTogSmFya2tvIFNha2tpbmVuIDxqYXJr
a29Aa2VybmVsLm9yZz4KLS0tCiBkcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jIHwgNyAr
KysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMgYi9kcml2ZXJzL2No
YXIvdHBtL3RwbV90aXNfY29yZS5jCmluZGV4IDc5ZGZhYjY1OTc2Zi4uMWUwNjVlN2FjNDYwIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCisrKyBiL2RyaXZlcnMv
Y2hhci90cG0vdHBtX3Rpc19jb3JlLmMKQEAgLTgxMyw4ICs4MTMsMTEgQEAgc3RhdGljIGludCB0
cG1fdGlzX3Byb2JlX2lycV9zaW5nbGUoc3RydWN0IHRwbV9jaGlwICpjaGlwLCB1MzIgaW50bWFz
aywKIAlpbnQgcmM7CiAJdTMyIGludF9zdGF0dXM7CiAKLQlpZiAoZGV2bV9yZXF1ZXN0X2lycShj
aGlwLT5kZXYucGFyZW50LCBpcnEsIHRpc19pbnRfaGFuZGxlciwgZmxhZ3MsCi0JCQkgICAgIGRl
dl9uYW1lKCZjaGlwLT5kZXYpLCBjaGlwKSAhPSAwKSB7CisKKwlyYyA9IGRldm1fcmVxdWVzdF90
aHJlYWRlZF9pcnEoY2hpcC0+ZGV2LnBhcmVudCwgaXJxLCBOVUxMLAorCQkJCSAgICAgICB0aXNf
aW50X2hhbmRsZXIsIElSUUZfT05FU0hPVCB8IGZsYWdzLAorCQkJCSAgICAgICBkZXZfbmFtZSgm
Y2hpcC0+ZGV2KSwgY2hpcCk7CisJaWYgKHJjKSB7CiAJCWRldl9pbmZvKCZjaGlwLT5kZXYsICJV
bmFibGUgdG8gcmVxdWVzdCBpcnE6ICVkIGZvciBwcm9iZVxuIiwKIAkJCSBpcnEpOwogCQlyZXR1
cm4gLTE7Ci0tIAoyLjM2LjEKCg==
