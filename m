Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C64B63144C
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Nov 2022 14:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiKTNck (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Nov 2022 08:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiKTNc3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Nov 2022 08:32:29 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCE7202;
        Sun, 20 Nov 2022 05:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668951127; bh=F2hzzeSzk8y4Ogbig7FSAtP0DXv6VqmVYAg81reycu8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YoAOpnl2cGULoCrUpsM4P43BSWEiq0m2yNqAU8UnpBomByPL1uyDiPhOhE9kInDVI
         3zmUAT4KOY5xcGNCzmwoCqA4LPaR0ej/yIQGoha8vbju9CSKQ/OVuglRsfTgm1x93B
         uGtVHA/u7PMwJakPWPYJOFQDwTmOMLwI+zpBv6sjfQWbf8bbFA95v4Mvyhz8VM1jza
         ccPWefZOOGaeTCAuo+YVooRiIJcjgbbW2785wlQx2Ck7fIzFjmKZ67fKaoJllLj1nd
         mG0uFMPTY93mbro0raOmi3zS0HA6q3fEcEjPJeXaiSQ7i4OlmbeNQ2fhoWAfhkO2Br
         9+C6/34Kci7FA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.7.17]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtwUw-1pDRMp1Z1A-00uIVv; Sun, 20
 Nov 2022 14:32:07 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v10 08/14] tpm, tpm_tis: do not check for the active locality in interrupt handler
Date:   Sun, 20 Nov 2022 14:31:28 +0100
Message-Id: <20221120133134.28926-9-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221120133134.28926-1-LinoSanfilippo@gmx.de>
References: <20221120133134.28926-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:qDOS5QDjXdbwOofh6vZTHErbO+5mCvO4iiSZ5/xFYyCEu6lwU1K
 93ZMirCD+aeoLEIT1HWNIrru1jnO8tLVJcMsRi+CEWuexoAttgGDD3fode2VQA+QedOtaM5
 N/xzjYqwe7Dxl6JdINF1/tQiH0fRkAdxFLbLPwRrD574ipm3pf6HiX5DRU0/ULJrF0+g+HT
 y1T7eZ/lZ38apE9GlIxHg==
UI-OutboundReport: notjunk:1;M01:P0:z5JKXYd0BeY=;vUttoE07kPsMS0FVFrXeO2dmo2e
 zkJx0Rw4PUQy5qqtuv3wfTECOF7u1eTEYyvoAfyBKVUOpr2RyDF3AwFXYBfdWt3gmd0Bdxzgf
 TzKKI17UN+SUdV+/lzlyoRkymCbp+krZ6fNLHB6fAbJuimQd3K7FFnC2WmJN4yKaVQY/MQMLE
 qw3l/96CLSPGEhKf3k1Ca2Xrksu4rUAEckCvaNS/AzHdkhTmqP1Ld1+3rwM5MFfK/FWBjcc2c
 ISeOu367IgxXqgBA/QYu86dQFFyOVPCB4vWkpfpq2NbM/+Hq6pUNJ+PfhTBsNnkyu/uygggIL
 W+ZKkcdgWBrvk3cWyNNOwRmgtGka1kGilngZam1DFRcq71ko3t85njxjiXPov1SvdRz5YjPL9
 yk79vTjk9oB45sNED8RxxaG8wBl2wVDPjbnN/VkvTsLxAbPd7qqwSed6ntuedUMTO84tW0Kdj
 m0bSm3pF3d+GKf5zxaCmSol85+2WsLEXERK8E/jv1N/RqBcPBhFct/8zg8gki5MWw+5NYrXpM
 UPxuNXoBUgGbtuHV2jIkGhTQZvDGcsxtmPWisqjVnUUs9kTBa8AAP1oVsxnuL4PbSTiHU+xES
 cEjOi/jI98cwqW0iZ0FhVE3kB/rqW6gxSYpmln3uVRRg+9K3JGf6+W9C+C6P28s5CcRrmtJJ3
 D0QPPawxEKF8bVJyLhAfz+kvxVn7GIELCVqOg5DmmGxv86DHUhGTLIcBXEVyTetV6mXy2v+M/
 Q5DvNixN7AtaJgNDZoDwnK/QLErjEMRVdHUjCqBMYllmBanRcy7Lz6QkUJD+OwRcaEPYqZ1LJ
 5Eso5GI4zd/+3ILsVToGds//+aQIQAIVCRNkHulVxKBAqQRGV7yY8qntedEJCj3wsRFFuJNKY
 4/Fk6QP1Q16SO5iPAr1+5fhGuNOQMK9TIdVci2xhaVSTnrqu1NBK6gDtEH6l30diRHZz2mzRm
 9TB1pQ==
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
ZS5jIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwppbmRleCA1ZmY0Y2E1ZmI5MzYu
LmQwZTVhY2Q2Yjc2OSAxMDA2NDQKLS0tIGEvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUu
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
