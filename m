Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B645637A9D
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Nov 2022 14:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiKXN4k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Nov 2022 08:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiKXN4d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Nov 2022 08:56:33 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22ED100B3E;
        Thu, 24 Nov 2022 05:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1669298173; bh=vnp21/mfPoqtAE/9hipMWqTIgnCW9bDnAe+K+uHJwrI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LvEQYqwKKJlb5S4pUaX7RxL3noLuSJv1rRgUqNElsH5Cj44g9xXImgXuGiSPYNajp
         LoyxrJhhJ9LhlZ6AbdES/IB23dtxOMoPZnb4Sca0xWatzN7V0cClfoXv4qIJQsFwTz
         gd/j++4x6FZRihrfjkrruMbIdBHTrYKUl/Que9sCIazI00gRfqhHTBRebUlb7HJoDN
         gazlUgsJPGsHe3NfvvJ1+ILK1Q3ssp0zFMYiylySFkF8GFZJLpLTI/tV4M6pqEnVcb
         VCNiPtIZg6rUFdXCp1e74MeAsCB0B48FW3SXfHWuUe+2GKLeUuTEddvoS/kvQZPIO4
         x5+G8YSkK+0Rw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.7.17]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxUnz-1p8zDw1j8z-00xvZB; Thu, 24
 Nov 2022 14:56:13 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v11 10/14] tpm, tpm_tis: Request threaded interrupt handler
Date:   Thu, 24 Nov 2022 14:55:34 +0100
Message-Id: <20221124135538.31020-11-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
References: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:FpAKGsitxv+CMneiAfduiO2RrZijFQTQp+bMXElnc3uL6bI8p7F
 zTshYoLZPrT8axM3jWbcpMLVq9mDHDdAM3tEq1uBH7XummJ8qw+y0+qVRCRfiBBWWjPfPKR
 HxVBk5dWcGeX13WUf5W/H/MUSLp/5/IiDTX7Aojuz0RmODZhawY2YNzTV92vhwoK7k4mYYw
 I6ycvYQPwupnhA3TxH/4Q==
UI-OutboundReport: notjunk:1;M01:P0:LNScq3ME++Q=;BKzLYTTefHVMCZH5KtkD/2MYx2g
 yEEGIXB0VrNAzG1MPNtuPEad1NpHbQnDBhREjjp2/F+WkVba7j3fnsy5VBRpIJH4wJ+85Kl4P
 w3YeiiTuCcv1C2PWe0jYoCbyq8Sc2jpJB48ohmPZAtcopjolLQy6NhIHFx+ZLWqSfBLzDI1cC
 U2lRinQ6QHVwAk5j9UEPsZ1DZ3oi755kiFg8cIc1qCjKvVdwVuNb/LPBY0ESyqDyzuezG90y1
 wQKIBFR7v11f69N2jVBKyjm+Fyjt8Z9irgLHT5YA8Edflc9jEU8gf4XlZAyYRiJjBIROl5si/
 rKZT1XI8wypgy4T6eWIB3EzKcLPqGvJJaIcLPB7xXbfKbXV8h1PpJzG+nRuhS2lHqAAjpB0Bm
 YL3Jl+dFIHYSqqjAlyuqVpGmgR8OY7UR3OtUuCmU9HoUYyzSaiPLtAvwUCInmXuQqFEep/6QW
 rlZOHn1eWdulQ3cYXq/99ZEptGZP44GnSBgo10kfT743jbVJGseynRiPgg0ULyS1fiItL3OJE
 SVXyBr1dosQpVdJ+JZzaNzYsWsEx5Y2w1oRTBrM0hljT8aLkF3ZSDmF2sbwZj00je7CVFXg4Z
 KB8KQYCpM4cXiX9cVlpCtEv4cQwcX0rlcOwHfJdaGIICsf30pTVN6PiQo8DNxROccjN297fMo
 L3EXLpEP/IclWwfi/wCSySfN3Ogn4nxD5aekud0T89sl45LR2CJT5iGY2etExs6KdQRCtPseO
 wg4hpy7Jo6jp7vQPlK763YN8d4GRcgInN2xb/2D4+0FzaETFqjJAHKX8qvCifjEJAd6HARFyy
 lUUhJsekePLsi19qReLqJePnVSCah0YyulLyC7axAhMQgtsBLML7ah1bcH5LeG2E5R7Hd6CCE
 vn75t6E8BowE7vcJGB9IT0Zru91gag8mt3KduLDx/X1WveZIiNnVhcjHNdQhOfl/aRQ60R47Z
 jxc/+A==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
YXIvdHBtL3RwbV90aXNfY29yZS5jCmluZGV4IGYwMGYxMDU3ZmQyNy4uMzg5MTQ5OWY5ODc3IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCisrKyBiL2RyaXZlcnMv
Y2hhci90cG0vdHBtX3Rpc19jb3JlLmMKQEAgLTgwNSw4ICs4MDUsMTEgQEAgc3RhdGljIGludCB0
cG1fdGlzX3Byb2JlX2lycV9zaW5nbGUoc3RydWN0IHRwbV9jaGlwICpjaGlwLCB1MzIgaW50bWFz
aywKIAlpbnQgcmM7CiAJdTMyIGludF9zdGF0dXM7CiAKLQlpZiAoZGV2bV9yZXF1ZXN0X2lycShj
aGlwLT5kZXYucGFyZW50LCBpcnEsIHRpc19pbnRfaGFuZGxlciwgZmxhZ3MsCi0JCQkgICAgIGRl
dl9uYW1lKCZjaGlwLT5kZXYpLCBjaGlwKSAhPSAwKSB7CisKKwlyYyA9IGRldm1fcmVxdWVzdF90
aHJlYWRlZF9pcnEoY2hpcC0+ZGV2LnBhcmVudCwgaXJxLCBOVUxMLAorCQkJCSAgICAgICB0aXNf
aW50X2hhbmRsZXIsIElSUUZfT05FU0hPVCB8IGZsYWdzLAorCQkJCSAgICAgICBkZXZfbmFtZSgm
Y2hpcC0+ZGV2KSwgY2hpcCk7CisJaWYgKHJjKSB7CiAJCWRldl9pbmZvKCZjaGlwLT5kZXYsICJV
bmFibGUgdG8gcmVxdWVzdCBpcnE6ICVkIGZvciBwcm9iZVxuIiwKIAkJCSBpcnEpOwogCQlyZXR1
cm4gLTE7Ci0tIAoyLjM2LjEKCg==
