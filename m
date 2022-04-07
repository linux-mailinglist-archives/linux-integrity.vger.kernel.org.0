Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D6D4F7DD9
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Apr 2022 13:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244690AbiDGLVi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Apr 2022 07:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbiDGLVb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Apr 2022 07:21:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BD01959F1;
        Thu,  7 Apr 2022 04:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649330356;
        bh=qXAcVdb5+U1V68gy4WuSKtITy5q5Oa2Czfs+ThvCSaY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=OIgX8ZVLYVBbUVTKosMn65lDqQV7nNJbX/gyX9ND4tpdrNm9OR9+xMECcaHs61ghf
         +GlwhfwIO9XFovd2woM6UUy3ukyobi7n6FFcn8+z9qpuseTDg8zXO8gY3fa20rHp8m
         jvWkLmj5HV16IKB3M1pulz858JfUDv5e89023LOk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.2.23]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M89Gj-1ngZAF0f1n-005LBY; Thu, 07
 Apr 2022 13:19:16 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        =robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefanb@linux.ibm.com,
        p.rosenberger@kunbus.com, lukas@wunner.de,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: [PATCH 3/5] tpm: tpm_tis: get optionally defined reset gpio
Date:   Thu,  7 Apr 2022 13:18:47 +0200
Message-Id: <20220407111849.5676-4-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407111849.5676-1-LinoSanfilippo@gmx.de>
References: <20220407111849.5676-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:VOa6nrOx58PxejZldnp8Sgli5Ic8TJYGKO/scam+aIiW/usfP3N
 Z7lJIkvmgfr4kctD3RHvlgy6npl6/+HPw4t/msp3wgxHW3t2To/OYftSQzEkl2ZB6Ec0ukC
 nmh1U7KpzoE6W5swBS9aqbSkg9CK/8fZ6lwTozA0UUvSA5MGRA4Pkzj0d3b2o1Id/puHBxx
 z+MUwHuuYLdnZEJrX4ZEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7RaNUTefLq8=:PeqP0exQKrSOr4/bM+56KG
 DOa5bUc9oR+3w5PwlEtawLhJ5G6nw56Kn1hy7GWxJRPBfb2tGdeo3WW9DfeDtztQrpJg9as/D
 CG5taQ+xMg971mAnjiZpQbN6Km1lJZcnkcrNJuHGQzpm7VXTS4Vi1/tYDQRrekGGH6meJ0Bnz
 cNou9/PeWaEH9Nxtl+C4ynhk8CdehuUfFIeOD8cB74V3iLNlXW7q+mXnX6wTXer9KaiJ6kQAS
 1C4dmTMCa9BNvWHXBT/EuXkr5csYc2hlPGnR4+mT9sfpgg4kIwXN3P8wJ/bcqDb8fTlEX5kN0
 ii/S4m9r1TdHFjaUawFi6m0l2Psxz2bCfociTMHk3LrMYRSs/Sj8EVdqVKNJ+g4y/qACjCIdG
 qipUFN6qqt/+qrtl2PEbpHmt4df/H3Cv4654vT7pHc5Ex8KXj75Pr64CUtMdDYFo4fMGZfKFN
 tbGJUzQgMBKS4We/1ylch61IlFlbprhzostpXOPpyixmtNJCxYKPBc0blbVDKoy0Zp3X/MzeU
 eF6lh0Z7cyAp7BHkNj9taiCXs6D331m4rnMkFnRb0An/lGCdHVQ9ig3j9hTCU06rKLuzpnL6U
 PBg8h6y/Z9nTa/nEJ1uiJgfTPhO5THTo1Lp3FyTOmj527P0xQfjN6xZ9xuhzt2IM545FjBppU
 1uuaGBPPKX5tNo62r8ZmeILK1LbbAxLQgChoMHoL6TgEcc7lfUIWPEQkVzTFYIXGOQfqrvfs+
 sX4K+bQpCp0LZbAhgtjMq4oi96KfFOCK8coHUKX36DW3eR133uZtyS05CZIDsYptE3hihubaK
 xlai2FD1VOxntji90tRxVCnVGEQFx0AmcVFeNR45Edii7BoCKzdBEUH/CJTBtLT3X3+xRhuAl
 ECNHde1IPy3YTnEletTioxWkP8dM/Au8y68pAPxP7qYSFGh9cpQpWx24DbJ163y2zTi2yJBZW
 svH2AEq9ewzjLsIrHeFjd9wGXQLUJtSYK9PuVg487YCBteSURFU/2HUGYQQEhvKk4eup2EZrp
 MODTjvqNeHHocCIdOWGuxtVc1Z8vDJBIeWPcRFToYj6d1rJXALt81cR3PZxt1NjhSv49g8F54
 zgj5bjOwHZnXoE=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

R2V0IHRoZSBvcHRpb25hbGx5IHNwZWNpZmllZCByZXNldCBncGlvLiBUaGlzIHByb3BlcnR5IGNh
biBiZSBzZXQgd2l0aCB0aGUKY29uLWlkICJyZXNldC1ncGlvcyIuCgpTaWduZWQtb2ZmLWJ5OiBM
aW5vIFNhbmZpbGlwcG8gPExpbm9TYW5maWxpcHBvQGdteC5kZT4KLS0tCiBkcml2ZXJzL2NoYXIv
dHBtL3RwbV90aXNfY29yZS5jIHwgMjAgKysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvY2hh
ci90cG0vdHBtX3Rpc19jb3JlLmggfCAgMSArCiAyIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jIGIvZHJp
dmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwppbmRleCAxMWU1ZTA0NWYzYTcuLjg5YmZlZTNj
ZmIxOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYworKysgYi9k
cml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCkBAIC0yNCw2ICsyNCw3IEBACiAjaW5jbHVk
ZSA8bGludXgvd2FpdC5oPgogI2luY2x1ZGUgPGxpbnV4L2FjcGkuaD4KICNpbmNsdWRlIDxsaW51
eC9mcmVlemVyLmg+CisjaW5jbHVkZSA8bGludXgvZ3Bpby9jb25zdW1lci5oPgogI2luY2x1ZGUg
InRwbS5oIgogI2luY2x1ZGUgInRwbV90aXNfY29yZS5oIgogCkBAIC05MTksNiArOTIwLDIxIEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgdHBtX2NsYXNzX29wcyB0cG1fdGlzID0gewogCS5jbGtfZW5h
YmxlID0gdHBtX3Rpc19jbGtydW5fZW5hYmxlLAogfTsKIAorLyoKKyAqIFJldHJpZXZlIHRoZSBy
ZXNldCBHUElPIGlmIGl0IGlzIGRlZmluZWQuCisgKi8KK3N0YXRpYyBpbnQgdHBtX3Rpc19nZXRf
cmVzZXRfZ3BpbyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCB0cG1fdGlzX2RhdGEgKmRhdGEp
Cit7CisJZGF0YS0+cmVzZXRfZ3BpbyA9IGRldm1fZ3Bpb2RfZ2V0X29wdGlvbmFsKGRldiwgInJl
c2V0IiwgR1BJT0RfT1VUX0xPVyk7CisJaWYgKElTX0VSUihkYXRhLT5yZXNldF9ncGlvKSkKKwkJ
cmV0dXJuIFBUUl9FUlIoZGF0YS0+cmVzZXRfZ3Bpbyk7CisKKwlpZiAoZGF0YS0+cmVzZXRfZ3Bp
bykKKwkJZ3Bpb2Rfc2V0X2NvbnN1bWVyX25hbWUoZGF0YS0+cmVzZXRfZ3BpbywgIlRQTSByZXNl
dCIpOworCisJcmV0dXJuIDA7Cit9CisKIGludCB0cG1fdGlzX2NvcmVfaW5pdChzdHJ1Y3QgZGV2
aWNlICpkZXYsIHN0cnVjdCB0cG1fdGlzX2RhdGEgKnByaXYsIGludCBpcnEsCiAJCSAgICAgIGNv
bnN0IHN0cnVjdCB0cG1fdGlzX3BoeV9vcHMgKnBoeV9vcHMsCiAJCSAgICAgIGFjcGlfaGFuZGxl
IGFjcGlfZGV2X2hhbmRsZSkKQEAgLTk1Miw2ICs5NjgsMTAgQEAgaW50IHRwbV90aXNfY29yZV9p
bml0KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHRwbV90aXNfZGF0YSAqcHJpdiwgaW50IGly
cSwKIAogCWRldl9zZXRfZHJ2ZGF0YSgmY2hpcC0+ZGV2LCBwcml2KTsKIAorCXJjID0gdHBtX3Rp
c19nZXRfcmVzZXRfZ3BpbyhkZXYsIHByaXYpOworCWlmIChyYykKKwkJcmV0dXJuIHJjOworCiAJ
aWYgKHByaXYtPnBoeV9vcHMtPnVuc2V0X3Jlc2V0KQogCQlwcml2LT5waHlfb3BzLT51bnNldF9y
ZXNldChwcml2KTsKIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUu
aCBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmgKaW5kZXggZjFhNjc0NDVhNWM1Li41
MDI4MTZkOTEzNTMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmgK
KysrIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuaApAQCAtOTQsNiArOTQsNyBAQCBz
dHJ1Y3QgdHBtX3Rpc19kYXRhIHsKIAlpbnQgaXJxOwogCWJvb2wgaXJxX3Rlc3RlZDsKIAl1bnNp
Z25lZCBsb25nIGZsYWdzOworCXN0cnVjdCBncGlvX2Rlc2MgKnJlc2V0X2dwaW87CiAJdm9pZCBf
X2lvbWVtICppbGJfYmFzZV9hZGRyOwogCXUxNiBjbGtydW5fZW5hYmxlZDsKIAl3YWl0X3F1ZXVl
X2hlYWRfdCBpbnRfcXVldWU7Ci0tIAoyLjM1LjEKCg==
