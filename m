Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EC66245B0
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Nov 2022 16:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiKJP0k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Nov 2022 10:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiKJP01 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Nov 2022 10:26:27 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB513C6FF;
        Thu, 10 Nov 2022 07:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668093945; bh=NZ0b2tOq2Jj1mWbGc2AGV1zg/VmCzKBMKS0JDk1OzUg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JraCJdsKpqTaJ1tCduuIEmE+jAYDJpzWpdV2jYswMKYAuEZ/y5xjAMMDFv9Jpt43E
         JEtjkNPZYzBB7ZdZsimenVC5Ar4VddpJGl5M45xvFFDhgrS5tJQVGojoJJZc3NxM50
         QSbQalNEqu0fhhstUAqwqPQbmR+L6PJPJq8XhGHU0Btozc/wtR7vHFJoiYF/YfbweI
         T6Z3AMYN9R6k0tD3wvEy/Vz8qcX/9FS6BZ99vRoBPwws4NeYwr2ZzOcuDe3/bZFgR8
         KoLuErV2A1UuK+RzW4TyTw1zouoR8DLVHKyYXBy0gyd5AV3ufL4BZeBNhy44RskGd2
         QRffVo0oqmM/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.7.17]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwQTF-1p9Zj20CdZ-00sNBA; Thu, 10
 Nov 2022 16:25:45 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v9 07/12] tpm, tpm_tis: do not check for the active locality in interrupt handler
Date:   Thu, 10 Nov 2022 16:25:28 +0100
Message-Id: <20221110152533.24243-8-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221110152533.24243-1-LinoSanfilippo@gmx.de>
References: <20221110152533.24243-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:GxP0aibOPHfomqlU2L62HC78GYwnrsSmJt5Ub7ZOMwbOcAXKjiZ
 TmH7+V1qV/nkWal0Chqm7Ie45EULFTBztt0nz6MsGxyDfTmEJYv5fktsf6RET4B7IT3benQ
 /vnTRy7nbIafZMQrbmt27nnhrsr1ZPIeME8jRZtj52XunV4xRG2EDK5Yq75ez6jNrcgOUoN
 lbI0d8/n0/8QfFEAvE6dg==
UI-OutboundReport: notjunk:1;M01:P0:pE9h/nbfKPo=;amtKpgOOFt18QFUb+vzjAWN2835
 uIquYovDCbBjPUvi+DhHtFa4miXr+EkvA+4+GmktxmLK8CYEkbqgK4PTlzqTDWvcaLH0PrW2Y
 R7k/Ic16SBH1ldZA8W5K52+FfKc9TwXzeTU3htqPcekjX3SGMswS/0vsEXzb/1hedV5y68VcL
 CRCh3dS51SrmROZBG6UQ10GMx5FFDfxVLzIaCAnJqoYg0XZoyo5okMQrtQF7SGcwRXMEN2qFr
 39WaWxhjHrI5Y/e41Rz0OofushHhXXIVY2VK0J42R+Lmbxj17mL8A9ZNqH0l1gFLBrBDvuWo+
 y6K+AWEEYFh/FHvZG9qq3WDRAz+27whaqJ2xXzLCjZBZzTJJhu1d/A6MVddZaix7J+LBewaTZ
 HCnSOp88z4gl8LO846ws3993XKNXuJrq/9rkI0Q/W/IH8l/1vGVt5uX+Wz3Gl5VcVD+AdaeoX
 D31efIBIBiUFNqdEkKVDENVM+awbqPfbkwKN9UAey91bo+/3NcbKzyulGOErleHaOE/cWFaZf
 pzQQOrizAmB+h/EBHY9ox4r9CF+pZ5ZhgqmayPb1zi+nqJTwzXsP3KU+/Vpqpj/BW795aVv/a
 3kqJvNiLWR1LxxArrfjOFe21PusJxyUxX6VaBMB0IpHby6i1Twvn2WzdHW/0LYC+44xyK9m3K
 a3h0okqcUV89d3zetbXB/JpI7+Xgeeg662/MbSuJLAzFe9IzgHPr7vorVqGg1e0Zny3wFnIZe
 fLecKn3to3Okx0v0N4qpp/SJfvLRMGV8wc+l8/aJnXwgM3KHZcvC6+H9e4Y/tew7P5c4bQmzM
 /vJrw01ZLN3Gr+N8tcSZ/HDVT1C5LyZmIvF1jvvMUN3xSlJ409K6ygKU9vGYVIZpq67yYT3is
 LR3cFWhFf+t2QR+q9tjnQAjwZzsrZKbjPCi3qxuDdpwNeh2cUv3XmwK9ZQHeQ6wPSN+tg8fLd
 itOuV3FeF/lcPF52bGJ6c5OV/H0=
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
ZS5jIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwppbmRleCAxODFjMjkxYjBiYjgu
LjQzMzZmN2VhOGMyYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUu
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
