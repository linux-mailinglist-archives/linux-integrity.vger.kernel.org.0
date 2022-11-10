Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF2D6245B9
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Nov 2022 16:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiKJP0o (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Nov 2022 10:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiKJP02 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Nov 2022 10:26:28 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2E740916;
        Thu, 10 Nov 2022 07:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668093946; bh=Zv582plVPWfjvWSFZ+HC7O7wVU9329RHBLjGsq+Wxlg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=sv8sIbiLVMNHGfnpIUKme8pM78n9hmI7t4nqaze2Blp+2pK6r1w1O1gtum0CE5pqv
         vl4elkm7gVhRaH4z998o9azfWM23ibCCVW3NlV7PHmYWSRcih82j90i5rrzxwfd9/6
         e7imOvRDOvgQ9fi+f/nQPvbeljQFdY6XGlRgUeoP++Hq82C+KNykMFKV03WhfemfIj
         koDainuGZP6q2vJW//jJ1oQikQjO7akMs6Xu1hMj/BLXokyCI+/HyTHZuROugnML8i
         UFVyOz70rMoF6pVequTuaOkbx58GrxpOEwFBAlsKSzrFPgw1lxavjcj+fGAosuVT5n
         8HoZS+G80FAIg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.7.17]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtwYu-1p7eys2wOa-00uI3d; Thu, 10
 Nov 2022 16:25:46 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v9 12/12] tpm, tpm_tis: Enable interrupt test
Date:   Thu, 10 Nov 2022 16:25:33 +0100
Message-Id: <20221110152533.24243-13-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221110152533.24243-1-LinoSanfilippo@gmx.de>
References: <20221110152533.24243-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:9CsuxgDeZtyikWqXYyxaadfmCCDJ8wut//BXW/q07Vkw5oXZUrv
 DoBeST34tttiIfQXmDwi4dnbjqwY6/PpJP6y0gBGopQM7g0+5uO3L+JpJbkI0VINTx7kMJ7
 S3YkK4JqESPC6qBzhRKPj4TKNjzSimpRGXrLgRt/HgZB7TyGTPyl5nqpAWejLmE+tkqtxjN
 29MuiVyLtwgX6M6mVSwlQ==
UI-OutboundReport: notjunk:1;M01:P0:46bxHaXbu58=;SAhuf1Syhgc7z0wEm4xorJlzv0r
 eBVFIN2B64Qv6gX+tfA1lWBblLNNR4EwD74iPPV7oBnOLCrT/uPOwW3HuW2flRZJEFuGPWUhb
 RMAMStXzvR6G2cN4zWzgNTu4Ehtj8BOkf/j3MJp+g/T/wMdxzaxzx+m1qAWfLomC6YHCTOGg1
 wgykjclmezSSjYJwljhEBnC5Uunm+1Y67B2/h9++ZraAxU1c5sOt4x6C455gGqlISJffxC/lJ
 Bg5wsYLPSLZGQ9WvQPGHzZAGosCx3TkLE27cawlH0O/Ak8qxk3a5hzYbr4E7dWiauetGX8ITZ
 7OicIYv9eJ07F51BdExqXYiRygaxq8OTJTBkqsEaU0qj5nK+2tfUUkq0uxOcyhiXDvGpnpXyn
 tZM61JaBCl9SGksqeD3xCFnGCNfJeC/cKo6ciQlk6ZxMJafuYXlEIwAQjdA3E1l/zCrqjb1Gj
 KLNvwIQHlXikpb/+M9wWro9ME+YfezoCR63NGw3ZIPaI2YrGDLeHiB+jFIii9hriTTG8RmmJu
 mns1Q1FUe8kplfcF+ZLe03yMeP0YlBkon4TBx31f53TKYQ1eN4umnTUKRchV3yR+WDycR7EaX
 CDSrB558HYGXSqbumpvNkJDjcbiyCZNRvGpWwiaJ4V9NhSe2zcBsci2RrAkdrTuc+thnWTqPW
 5YqhNR9ieVds9sWiVxjKQHbBO43ePvLbL+jCAFdjlUtpCfov84q5IF0UJyh/5DIYiMSRRpStB
 M4MUF/Eq/Su3ppOC2UWriIuH8erOBEJwJfH+Yj+V3oDIvn//8z3XvhnvY/38vbL0Bb/G3AJKJ
 G+IfgpoEYwjRAM6kl7NhniTxehFnf4KVk8Hb5YY3g7k2oii/GVls0SMwTj1RNRB1U/AqRcaek
 MuNZq3j7tB9SiOkpQQvlLiOvdQQOAouAjVPUm/88CXJcfxfc0wxXeOLGTS169HxjlZNAwuLG6
 25WiSA==
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KClRoZSB0ZXN0
IGZvciBpbnRlcnJ1cHRzIGluIHRwbV90aXNfc2VuZCgpIGlzIHNraXBwZWQgaWYgdGhlIGZsYWcK
VFBNX0NISVBfRkxBR19JUlEgaXMgbm90IHNldC4gU2luY2UgdGhlIGN1cnJlbnQgY29kZSBuZXZl
ciBzZXRzIHRoZSBmbGFnCmluaXRpYWxseSB0aGUgdGVzdCBpcyBuZXZlciBleGVjdXRlZC4KCkZp
eCB0aGlzIGJ5IHNldHRpbmcgdGhlIGZsYWcgaW4gdHBtX3Rpc19nZW5faW50ZXJydXB0KCkgcmln
aHQgYWZ0ZXIKaW50ZXJydXB0cyBoYXZlIGJlZW4gZW5hYmxlZCBhbmQgYmVmb3JlIHRoZSB0ZXN0
IGlzIGV4ZWN1dGVkLgoKU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlw
cG9Aa3VuYnVzLmNvbT4KLS0tCiBkcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jIHwgMiAr
KwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Y2hhci90cG0vdHBtX3Rpc19jb3JlLmMgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5j
CmluZGV4IDQ2OWExZGI5NTk0MS4uMWY3ODU4MjI2NGViIDEwMDY0NAotLS0gYS9kcml2ZXJzL2No
YXIvdHBtL3RwbV90aXNfY29yZS5jCisrKyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3Jl
LmMKQEAgLTc5Myw2ICs3OTMsOCBAQCBzdGF0aWMgaW50IHRwbV90aXNfZ2VuX2ludGVycnVwdChz
dHJ1Y3QgdHBtX2NoaXAgKmNoaXApCiAJaWYgKHJldCA8IDApCiAJCXJldHVybiByZXQ7CiAKKwlj
aGlwLT5mbGFncyB8PSBUUE1fQ0hJUF9GTEFHX0lSUTsKKwogCWlmIChjaGlwLT5mbGFncyAmIFRQ
TV9DSElQX0ZMQUdfVFBNMikKIAkJcmV0ID0gdHBtMl9nZXRfdHBtX3B0KGNoaXAsIDB4MTAwLCAm
Y2FwMiwgZGVzYyk7CiAJZWxzZQotLSAKMi4zNi4xCgo=
