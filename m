Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801DB637A96
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Nov 2022 14:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiKXN4f (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Nov 2022 08:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKXN4c (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Nov 2022 08:56:32 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2D4FCDE5;
        Thu, 24 Nov 2022 05:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1669298172; bh=KYgm8KRRqsXZGdn21yoPTnrJv96Ne6lqyUqKM2FAIYk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=l3aJvhaSv1q0D+rXI60cI/Ma/anYl/lkYrN80NC1/0UTnepJGz5pH5nnaoGzmzMsI
         kzDRZ9wfyYQ6g33KPjVvOj+sApYyCFRQxoJxcalz1yVrVoz1wS0cqMd1w4+vTp8vHJ
         8t+g0DxSyqcgDd9YjNiHTTNTUKYne8cYShzHrZPo29G1FIZjWJpfmbgzFl8PpccO4k
         mFw9w7C1hmEHp0oVMCVz3c/E4bqeauKGwwAF2JuQTTb+Rwqm3fmieAVwauPC+VlawG
         oaJfVGS6Onu+ahQGtJwkIlgtxkyu3ac1N/HfMsDUSqWBjucrTN7eSa0RN4l/QeSXyR
         2LWZtRLX9R9Dw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.7.17]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MybGh-1p7slF2snt-00z1Ur; Thu, 24
 Nov 2022 14:56:12 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v11 08/14] tpm, tpm_tis: do not check for the active locality in interrupt handler
Date:   Thu, 24 Nov 2022 14:55:32 +0100
Message-Id: <20221124135538.31020-9-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
References: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:YZiUudcwOuChyLmzP4dwIkl3/awLNQ8KvBhXt/WodxMvdwl6lqo
 LlvMEiHfeu8ijXYdt5z3l1dJ8nClGm3ZE/fOr0XUIvycnjXXKIE/a9nSTHWz2Lx7j+PLOFz
 UoIsae9eEmaE265WB9dK/wPWCsVS9zLGWYpPzJeKKcPyOki2TCwCFwMxS9j9TLKqdr2dVZb
 5S/AFQr/uIehx5tMNoMZg==
UI-OutboundReport: notjunk:1;M01:P0:6fJmel/inqo=;Xf58vLAIKBd8FABsoQ2j5E1vpHB
 Pm6ssHhRUxLjlzXsLBNl2lVwOC0N/daWFx+PkqgPMJk5A1EQDCpiyPpEluUKiZEv1P5KXQrIM
 aceYNzDS2M2CAa5f88BD8MtIosfhLQUC5GGCvgUvKg66ch57MUHZqfORiRgdjhYjS1Zb/SDIo
 2DjUWlkneDzOkdEHYrybkVSgDKLyCwWE99qx4LvL4yZSIYlLjj4MgJT7wJmbIZ3NMflV1zSqU
 lq1fxrkmQAxYQEzt2gVdQslzl7qMuCRjpT40xBA9qKXaLgEycj2CqviIWmTKoOx99Ajf5qqKZ
 yD9ZHYL3ab706mtUUesc2ZjVIw+MbwkbCRgxrirQd4Sa9QRiyOXGB55CxJr1AwrHA7xNnvxCR
 tIF74Ul9W/NoVCTtxPjLv3jTd6bK4lSeIXqCvUUR0q+FRSX6weFKB6i8gzqeUFJhvpszziTPc
 7rS+nrqTMU3XdFkBnW20reV1f7bvtJf4tekEXyq1rHQATYKphAIzxe/OycuXWoYibJs2I+rWy
 ZaPkA0gkmtVCrFYwPxY673u4j7exBZyOCx8kgfTfbz5gbs8dH85dmcs7KKyMtZYliJD44PYl5
 eZFgvh1rhgq9vHBfuh1WAs6VlzOjEn50IvW/Gj1qhflSdG90eLUARCPe0L56Z8EupCaDBYZ1/
 dtYf8tYpz01YAUefzdtkXkDuTatW5iS9J9rbRb8l6a19Y4jl+xKVa1QzUp2MbN59lv3d9u6X7
 gX7LY/neHAwh39NVD6z6p0fR6yCtjA6Ytz2LOIrC+2jLT7vWB6sZzjQUd+vhi8SVq2ULyGwYf
 nhNXQVy/dMTex496Sfs/vvLMW0nrNgNPdSaFf4skJy0ICO42cMITdLUyXw8hWdyiybnFOvm2v
 DlrKXyEbRxQAxi3HWByT84Py+MENN+J+TowiEKUJD4CdFV6rAjX61xgNrPHFK/FQkCUkFsvdC
 J9jXqg==
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkFmdGVyIGRy
aXZlciBpbml0aWFsaXphdGlvbiB0cG1fdGlzX2RhdGEtPmxvY2FsaXR5IG1heSBvbmx5IGJlIG1v
ZGlmaWVkIGluCmNhc2Ugb2YgYSBMT0NBTElUWSBDSEFOR0UgaW50ZXJydXB0LiBJbiB0aGlzIGNh
c2UgdGhlIGludGVycnVwdCBoYW5kbGVyCml0ZXJhdGVzIG92ZXIgYWxsIGxvY2FsaXRpZXMgb25s
eSB0byBhc3NpZ24gdGhlIGFjdGl2ZSBvbmUgdG8KdHBtX3Rpc19kYXRhLT5sb2NhbGl0eS4KCkhv
d2V2ZXIgdGhpcyBpbmZvcm1hdGlvbiBpcyBuZXZlciB1c2VkIGFueSBtb3JlLCBzbyB0aGUgYXNz
aWdubWVudCBpcyBub3QKbmVlZGVkLgpGdXJ0aGVybW9yZSB3aXRob3V0IHRoZSBhc3NpZ25tZW50
IHRwbV90aXNfZGF0YS0+bG9jYWxpdHkgY2Fubm90IGNoYW5nZSBhbnkKbW9yZSBhdCBkcml2ZXIg
cnVudGltZSwgYW5kIHRodXMgbm8gcHJvdGVjdGlvbiBhZ2FpbnN0IGNvbmN1cnJlbnQKbW9kaWZp
Y2F0aW9uIGlzIHJlcXVpcmVkIHdoZW4gdGhlIHZhcmlhYmxlIGlzIHJlYWQgYXQgb3RoZXIgcGxh
Y2VzLgoKU28gcmVtb3ZlIHRoaXMgaXRlcmF0aW9uIGVudGlyZWx5LgoKU2lnbmVkLW9mZi1ieTog
TGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KQWNrZWQtYnk6IEphcmtr
byBTYWtraW5lbiA8amFya2tvQGtlcm5lbC5vcmc+Ci0tLQogZHJpdmVycy9jaGFyL3RwbS90cG1f
dGlzX2NvcmUuYyB8IDcgKystLS0tLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
NSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29y
ZS5jIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwppbmRleCA2NWQxZWM3ZWI0YzMu
LmQ3MDVkZmI2NGNmOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUu
YworKysgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCkBAIC03MjgsNyArNzI4LDcg
QEAgc3RhdGljIGlycXJldHVybl90IHRpc19pbnRfaGFuZGxlcihpbnQgZHVtbXksIHZvaWQgKmRl
dl9pZCkKIAlzdHJ1Y3QgdHBtX2NoaXAgKmNoaXAgPSBkZXZfaWQ7CiAJc3RydWN0IHRwbV90aXNf
ZGF0YSAqcHJpdiA9IGRldl9nZXRfZHJ2ZGF0YSgmY2hpcC0+ZGV2KTsKIAl1MzIgaW50ZXJydXB0
OwotCWludCBpLCByYzsKKwlpbnQgcmM7CiAKIAlyYyA9IHRwbV90aXNfcmVhZDMyKHByaXYsIFRQ
TV9JTlRfU1RBVFVTKHByaXYtPmxvY2FsaXR5KSwgJmludGVycnVwdCk7CiAJaWYgKHJjIDwgMCkK
QEAgLTc0MCwxMCArNzQwLDcgQEAgc3RhdGljIGlycXJldHVybl90IHRpc19pbnRfaGFuZGxlcihp
bnQgZHVtbXksIHZvaWQgKmRldl9pZCkKIAlzZXRfYml0KFRQTV9USVNfSVJRX1RFU1RFRCwgJnBy
aXYtPmZsYWdzKTsKIAlpZiAoaW50ZXJydXB0ICYgVFBNX0lOVEZfREFUQV9BVkFJTF9JTlQpCiAJ
CXdha2VfdXBfaW50ZXJydXB0aWJsZSgmcHJpdi0+cmVhZF9xdWV1ZSk7Ci0JaWYgKGludGVycnVw
dCAmIFRQTV9JTlRGX0xPQ0FMSVRZX0NIQU5HRV9JTlQpCi0JCWZvciAoaSA9IDA7IGkgPCA1OyBp
KyspCi0JCQlpZiAoY2hlY2tfbG9jYWxpdHkoY2hpcCwgaSkpCi0JCQkJYnJlYWs7CisKIAlpZiAo
aW50ZXJydXB0ICYKIAkgICAgKFRQTV9JTlRGX0xPQ0FMSVRZX0NIQU5HRV9JTlQgfCBUUE1fSU5U
Rl9TVFNfVkFMSURfSU5UIHwKIAkgICAgIFRQTV9JTlRGX0NNRF9SRUFEWV9JTlQpKQotLSAKMi4z
Ni4xCgo=
