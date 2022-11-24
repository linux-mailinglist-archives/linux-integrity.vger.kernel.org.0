Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B6C637AAC
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Nov 2022 14:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiKXN5G (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Nov 2022 08:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiKXN4g (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Nov 2022 08:56:36 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75CE11604C;
        Thu, 24 Nov 2022 05:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1669298171; bh=nfj6LxEEakS1d9oZm1Vln0mVngkSUD4WhjDUy9R8goU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SIpKaQvo39+/4NrHUTAzIjtNS5X9hGHJXHnX2qgwSeaYMSlJAWLIEIOrpYEZJ5YJb
         B0FJwZQ6RQrFs2+hPoNhUklaYNeB+c+bHvNV/20JwkWh3cr1XpvJme9DSfu9WDBgiZ
         AYOnCW2Nte1anJo7A70I0jbPaI0gIS4wOcGbfuyCLvNBHwCgmXLvJQ7694NghaNXt9
         KjrCrIwLFuYGHuXZdVXm9Zz5jNnla+R2GMK3sYObxu0LszAQqUkVx9JjcbZLP0uo8U
         SVXp280OBqTY5qX+yrhhefftRzbsp6nAjJ8pwSucyofUNTAGwhEdvxUN5P7HV6fEZo
         A12ltdQolCm3g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.7.17]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mjj8D-1pLgY42t7j-00lBsR; Thu, 24
 Nov 2022 14:56:11 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v11 05/14] tpm, tpm_tis: Claim locality before writing interrupt registers
Date:   Thu, 24 Nov 2022 14:55:29 +0100
Message-Id: <20221124135538.31020-6-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
References: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:VB7psXmoZkW0IM+pjguIbLL50aHa+0ppnyDiamI4IevQAzorTbS
 DN1FMlxqHjwgFCmjNlcT78/3720y6XYjrRdytKbwNyd144yREiDnpOfPqeUEm0EIJQDZjGp
 tEY69lnVO+hH7TRvSapOJ6ScMoYrJ5h+pBUw/wKv/wO4H1LxHxMqeP1ht+jq7PInvG+ddyV
 3yK5Qmy5ivPI8+G76VBPA==
UI-OutboundReport: notjunk:1;M01:P0:HR9zpvCBO74=;u5PMihDoYh3FpZMRJEm9ZrHdye6
 1SNHWZzEn+F0ZHl2nXdF8XG0FN+EbfqlIb8rCY3GUf2RXY2kvY5bxJo6/5XOpopibay6itEoz
 xhrKNV4nIB48OfkcZzLDjKuoR+vcQ5AFjn7LBpcvoHsfV13GdUraeCE/bPQ7H6hjqGWvEyPKw
 eX2YryeXpKPDaGoC/4QJgpUN63LNf/PddP1CAJjnZ9hc7moa6J8uonaAcs3cqpLRsxcE78YI/
 6L/+QtrCgQpChjWP9TODeOQX65QExUgwEOAL84CKCn6BPpriCMl/ToqMj/zGUOLrs0nL3SZOo
 8YJc9VcbCGoiyT/x1gPRRFRqftFNAxS5fkWeNoWC5HIt2OQbJujvgz9MGDLAqK/CUN9tYcKIp
 jK1j9mTg9omWDmnttzGcWaPW2qJmne/VPubOIaX1OHTiS/cjXX8ImSz5WP5Pe05sVhMZA/vvB
 vTFked3bgOXobgiPm7o4BXcSwtTMKokJ1BOVGoyMTWccmccl0ysqFHSNVTbYmV8hMjpoSeZm7
 XPcQh5ug9TX1vdtBE4DOh1fx1GGwGADRT1oaYZr3JS+nlugIz/aP4tSnLuIKscWYLzuI0jH69
 zMxdjlR5IA5pNOp1wjdXBG+n4U4OwOEgAL6oM6o3hRkfJrxYwY6CRPuAY9ZTFK7+3nggpTgw1
 z65G4KJiV5Q+ejVsbUumDicWvn+JPyxeKYYLSu9QCGzmztoPUS4msyJKM5shswK3ZuIeL8SF8
 hpsgFRA6bS4BbThyZ7k61tZb6w+c0mGimoLZEQ20WmU6YdXBZ7kQB+aL8al4ET5f6+in/wtKn
 Z+Rqo4wf4z5Rd7tFlfobyQM63xai5jf6t23bZjMYvBY/jKZw2yLJ1ONWUVqjNQfj5p3x4If7x
 3M1b8oZqBUUUt3e/yauhsJsqo0atO3Ql4r/feU7yc5R2wOKJsZiD/Evi5UpjkHbKBJ9sh11IQ
 Az97XcDFLwnor90Ro5xyscPImiM=
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkluIHRwbV90
aXNfcHJvYmVfc2luZ2xlX2lycSgpIGludGVycnVwdCByZWdpc3RlcnMgVFBNX0lOVF9WRUNUT1Is
ClRQTV9JTlRfU1RBVFVTIGFuZCBUUE1fSU5UX0VOQUJMRSBhcmUgbW9kaWZpZWQgdG8gc2V0dXAg
dGhlIGludGVycnVwdHMuCkN1cnJlbnRseSB0aGVzZSBtb2RpZmljYXRpb25zIGFyZSBkb25lIHdp
dGhvdXQgaG9sZGluZyBhIGxvY2FsaXR5IHRodXMgdGhleQpoYXZlIG5vIGVmZmVjdC4gRml4IHRo
aXMgYnkgY2xhaW1pbmcgdGhlIChkZWZhdWx0KSBsb2NhbGl0eSBiZWZvcmUgdGhlCnJlZ2lzdGVy
cyBhcmUgd3JpdHRlbi4KClNpbmNlIG5vdyB0cG1fdGlzX2dlbl9pbnRlcnJ1cHQoKSBpcyBjYWxs
ZWQgd2l0aCB0aGUgbG9jYWxpdHkgYWxyZWFkeQpjbGFpbWVkIHJlbW92ZSBsb2NhbGl0eSByZXF1
ZXN0IGFuZCByZWxlYXNlIGZyb20gdGhpcyBmdW5jdGlvbi4KClNpZ25lZC1vZmYtYnk6IExpbm8g
U2FuZmlsaXBwbyA8bC5zYW5maWxpcHBvQGt1bmJ1cy5jb20+ClJldmlld2VkLWJ5OiBKYXJra28g
U2Fra2luZW4gPGphcmtrb0BrZXJuZWwub3JnPgotLS0KIGRyaXZlcnMvY2hhci90cG0vdHBtX3Rp
c19jb3JlLmMgfCAyMCArKysrKysrKysrKy0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDExIGlu
c2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL3Rw
bS90cG1fdGlzX2NvcmUuYyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMKaW5kZXgg
ODFiOTcyNmQzZWQyLi40OTg0ODI2OGY1NDcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY2hhci90cG0v
dHBtX3Rpc19jb3JlLmMKKysrIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwpAQCAt
NzM2LDE2ICs3MzYsMTAgQEAgc3RhdGljIHZvaWQgdHBtX3Rpc19nZW5faW50ZXJydXB0KHN0cnVj
dCB0cG1fY2hpcCAqY2hpcCkKIAljYXBfdCBjYXA7CiAJaW50IHJldDsKIAotCXJldCA9IHJlcXVl
c3RfbG9jYWxpdHkoY2hpcCwgMCk7Ci0JaWYgKHJldCA8IDApCi0JCXJldHVybjsKLQogCWlmIChj
aGlwLT5mbGFncyAmIFRQTV9DSElQX0ZMQUdfVFBNMikKIAkJcmV0ID0gdHBtMl9nZXRfdHBtX3B0
KGNoaXAsIDB4MTAwLCAmY2FwMiwgZGVzYyk7CiAJZWxzZQogCQlyZXQgPSB0cG0xX2dldGNhcChj
aGlwLCBUUE1fQ0FQX1BST1BfVElTX1RJTUVPVVQsICZjYXAsIGRlc2MsIDApOwotCi0JcmVsZWFz
ZV9sb2NhbGl0eShjaGlwLCAwKTsKIH0KIAogLyogUmVnaXN0ZXIgdGhlIElSUSBhbmQgaXNzdWUg
YSBjb21tYW5kIHRoYXQgd2lsbCBjYXVzZSBhbiBpbnRlcnJ1cHQuIElmIGFuCkBAIC03NjgsMTAg
Kzc2MiwxNiBAQCBzdGF0aWMgaW50IHRwbV90aXNfcHJvYmVfaXJxX3NpbmdsZShzdHJ1Y3QgdHBt
X2NoaXAgKmNoaXAsIHUzMiBpbnRtYXNrLAogCX0KIAlwcml2LT5pcnEgPSBpcnE7CiAKKwlyYyA9
IHJlcXVlc3RfbG9jYWxpdHkoY2hpcCwgMCk7CisJaWYgKHJjIDwgMCkKKwkJcmV0dXJuIHJjOwor
CiAJcmMgPSB0cG1fdGlzX3JlYWQ4KHByaXYsIFRQTV9JTlRfVkVDVE9SKHByaXYtPmxvY2FsaXR5
KSwKIAkJCSAgICZvcmlnaW5hbF9pbnRfdmVjKTsKLQlpZiAocmMgPCAwKQorCWlmIChyYyA8IDAp
IHsKKwkJcmVsZWFzZV9sb2NhbGl0eShjaGlwLCBwcml2LT5sb2NhbGl0eSk7CiAJCXJldHVybiBy
YzsKKwl9CiAKIAlyYyA9IHRwbV90aXNfd3JpdGU4KHByaXYsIFRQTV9JTlRfVkVDVE9SKHByaXYt
PmxvY2FsaXR5KSwgaXJxKTsKIAlpZiAocmMgPCAwKQpAQCAtODA1LDEwICs4MDUsMTIgQEAgc3Rh
dGljIGludCB0cG1fdGlzX3Byb2JlX2lycV9zaW5nbGUoc3RydWN0IHRwbV9jaGlwICpjaGlwLCB1
MzIgaW50bWFzaywKIAlpZiAoIShjaGlwLT5mbGFncyAmIFRQTV9DSElQX0ZMQUdfSVJRKSkgewog
CQl0cG1fdGlzX3dyaXRlOChwcml2LCBvcmlnaW5hbF9pbnRfdmVjLAogCQkJICAgICAgIFRQTV9J
TlRfVkVDVE9SKHByaXYtPmxvY2FsaXR5KSk7Ci0JCXJldHVybiAtMTsKKwkJcmMgPSAtMTsKIAl9
CiAKLQlyZXR1cm4gMDsKKwlyZWxlYXNlX2xvY2FsaXR5KGNoaXAsIHByaXYtPmxvY2FsaXR5KTsK
KworCXJldHVybiByYzsKIH0KIAogLyogVHJ5IHRvIGZpbmQgdGhlIElSUSB0aGUgVFBNIGlzIHVz
aW5nLiBUaGlzIGlzIGZvciBsZWdhY3kgeDg2IHN5c3RlbXMgdGhhdAotLSAKMi4zNi4xCgo=
