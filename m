Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FEC70C127
	for <lists+linux-integrity@lfdr.de>; Mon, 22 May 2023 16:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjEVOc2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 May 2023 10:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjEVOc1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 May 2023 10:32:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9E19E;
        Mon, 22 May 2023 07:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684765902; i=linosanfilippo@gmx.de;
        bh=23KmM5Vjp/r+0CEVZoYhx1NZ0LhMxpN04GBEUCeHBaA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Dotd6gRN0IZGqFv0g+0zOBKVgPxT9vZS7OwjQLeoqXusmJGOTOETnLkeT91QPpT3k
         7/qLO6HpAoLMkkRogeeMO2zvQ1FglYnEUgQ5ZteuUvSTeJUa4LEtLG//U2qHsk2kHf
         F9ELFT3uoQIfTY5rJFpharCFXIkJsj9om3vlpFT4e5mQIAJdl28pYUKdfdW/tMuQ6l
         eyKFcDzJ7YSyngaCbWhD3+LgX/KOMSUFyRqS5+hWmvyqJbiiC4/jOLE/AmQgcDQisL
         /pEjFRcTh8MPiM/AQsDpUhCMjM716aBGKv4NFqFe4kPhPX5IbJLqdIk4MRr32i3FRa
         yYZouriZOBzHg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.2.106]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQv8n-1po5rm4Akh-00Nxtb; Mon, 22
 May 2023 16:31:42 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     jsnitsel@redhat.com, hdegoede@redhat.com, oe-lkp@lists.linux.dev,
        lkp@intel.com, peter.ujfalusi@linux.intel.com,
        peterz@infradead.org, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, LinoSanfilippo@gmx.de, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: [PATCH 2/2] tpm, tpm_tis: reuse code in disable_interrupts()
Date:   Mon, 22 May 2023 16:31:05 +0200
Message-Id: <20230522143105.8617-2-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:5nyh3VGLVlEBuWb2yLT46GgisZGdkKDMI/UWxmOTevTZoUkILFN
 5DjVRTH5d5hzFJlQS1ULHkRfnneGFDdSoRfMOb9sjCydsrYvGujtZOf7CzvPzhA2Dsw7ClI
 tv/JxikT3Cc2tY4FE0yPx5A4RGHgOzn0BpRdvlsh2B2CDd27f6w8JP2uc0mW1qKWcL9l+VB
 gbNMTK1x9tr2Y43IxM3Aw==
UI-OutboundReport: notjunk:1;M01:P0:PYvem97hXWc=;JEbL4U403GY4pF3llnOIcrIDa+1
 eY9Xw3t0hyQtzqrQ0aeN028TNUfWO//NJBUDjgZwgYIllqk2ss0OGmUFKvGpOC+/5OXi18Bkp
 KFyfpTAaRrvvJj49qW4i9uCmYUx47xoSL0jIF4ZSXxUNSVdi5gBgj6GwGijSnEAyFMOq0WuvJ
 JkXMXyjBt5G2+Zx57TCHEFOFPDsyE+EJH4dHcUGCgKi5oN/rKMUzHiKs5jZDU4qwSFiMeFMjV
 mSUF+aWb7pzuyxSUpvKmnAjWF6JPqfzVrRVp/aU5tOuyHkSMYJrBthQ2hwEfaqHpyhrGv0lDa
 YPeX2fq6dqNcn8tnfIJRl+d/n5BzfHqqyHJ2Ks9g2rzKm1/BTeNaYvs+6elNC39HyJOVXiOcm
 ZNDwmbQaPMB1bI+36CpxeOKiVESlGkMK0kBfKp1r7KQDguZ4HTNIKusVr76svFarcREW+pOCi
 +M5BjY8A3RIyJ6ry3w3FwqI8i69sbMN4+EVzcBILasLEhOfwSEasqI4bXAQYFBlW4TyWCj9VB
 E+fPvk/cFxJvf0p6Qb9xrU5YoTkQwwO5zra2WWdd1VanFG4GHd53kprZtfPibpjgjvEfqsP+Q
 pYQTAi6COMA32lPhOOU43DtSeSNrGV5liSv+ds56D3XMlAhaC25lcQfs/nbM2lRMNAya+6lTP
 mYExtOafF0hKsSvpDWdMBQLS1Ee3TAmAtq4NBHNtJ1Ij29jeLAa/6KGEX5faVR7+JXASqqlPL
 ZHpMSbG+p8ZQ+Ask7wtue8iaqyCwFjf+W5U8q+Lfqtb0mtDnxRjWJTv6+CE300J7bJ2sAxVk7
 AKyRB85fUGxikbuxWndZO3x5i41ACAPa6pn2MOheXHDCWix856MX13PtZ517FjaR9bISucqZo
 nEEDN/A3Sn2t6SMJdP4s1C+AFH2i46Ev3RUIhSU3tvEzhl0EUjY4rDTqkW29C2n3hMJ2lmR7+
 tlAHQw==
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkF2b2lkIGNv
ZGUgcmVkdW5kYW5jeSBieSBzaGlmdGluZyBwYXJ0IG9mIHRoZSBjb2RlIGluIGRpc2FibGVfaW50
ZXJydXB0cygpCmludG8gYSBzdWJmdW5jdGlvbiBhbmQgcmV1c2luZyB0aGlzIGZ1bmN0aW9uIGlu
IHRwbV90aXNfaGFuZGxlX2lycV9zdG9ybSgpLgpNYWtlIHN1cmUgdGhhdCBpbiB0aGUgc3ViZnVu
Y3Rpb24gdGhlIElOVF9FTkFCTEUgcmVnaXN0ZXIgaXMgd3JpdHRlbiB3aXRoIGEKY2xhaW1lZCBs
b2NhbGl0eSBldmVuIGlmIHRoZSBjYWxsZXIgZGlkIG5vdCBjbGFpbSBpdCBiZWZvcmUuCgpJbiB0
aGUgc2hpZnRlZCBjb2RlIGdldCByaWQgb2YgdGhlIHZhcmlhYmxlICJyYyIgYnkgaW5pdGlhbGl6
aW5nIHRoZQppbnRlcnJ1cHQgbWFzayB0byB6ZXJvIGF0IHZhcmlhYmxlIGRlY2xhcmF0aW9uLgoK
U2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4K
LS0tCiBkcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jIHwgMzYgKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMTkg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUu
YyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMKaW5kZXggNDU4ZWJmOGMyZjE2Li44
ZjRmMmNiNTUyMGYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMK
KysrIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwpAQCAtNDY4LDI1ICs0NjgsMzIg
QEAgc3RhdGljIGludCB0cG1fdGlzX3NlbmRfZGF0YShzdHJ1Y3QgdHBtX2NoaXAgKmNoaXAsIGNv
bnN0IHU4ICpidWYsIHNpemVfdCBsZW4pCiAJcmV0dXJuIHJjOwogfQogCitzdGF0aWMgdm9pZCBf
X3RwbV90aXNfZGlzYWJsZV9pbnRlcnJ1cHRzKHN0cnVjdCB0cG1fY2hpcCAqY2hpcCkKK3sKKwlz
dHJ1Y3QgdHBtX3Rpc19kYXRhICpwcml2ID0gZGV2X2dldF9kcnZkYXRhKCZjaGlwLT5kZXYpOwor
CXUzMiBpbnRtYXNrID0gMDsKKworCXRwbV90aXNfcmVhZDMyKHByaXYsIFRQTV9JTlRfRU5BQkxF
KHByaXYtPmxvY2FsaXR5KSwgJmludG1hc2spOworCWludG1hc2sgJj0gflRQTV9HTE9CQUxfSU5U
X0VOQUJMRTsKKworCXRwbV90aXNfcmVxdWVzdF9sb2NhbGl0eShjaGlwLCAwKTsKKwl0cG1fdGlz
X3dyaXRlMzIocHJpdiwgVFBNX0lOVF9FTkFCTEUocHJpdi0+bG9jYWxpdHkpLCBpbnRtYXNrKTsK
Kwl0cG1fdGlzX3JlbGlucXVpc2hfbG9jYWxpdHkoY2hpcCwgMCk7CisKKwljaGlwLT5mbGFncyAm
PSB+VFBNX0NISVBfRkxBR19JUlE7Cit9CisKIHN0YXRpYyB2b2lkIGRpc2FibGVfaW50ZXJydXB0
cyhzdHJ1Y3QgdHBtX2NoaXAgKmNoaXApCiB7CiAJc3RydWN0IHRwbV90aXNfZGF0YSAqcHJpdiA9
IGRldl9nZXRfZHJ2ZGF0YSgmY2hpcC0+ZGV2KTsKLQl1MzIgaW50bWFzazsKLQlpbnQgcmM7CiAK
IAlpZiAocHJpdi0+aXJxID09IDApCiAJCXJldHVybjsKIAotCXJjID0gdHBtX3Rpc19yZWFkMzIo
cHJpdiwgVFBNX0lOVF9FTkFCTEUocHJpdi0+bG9jYWxpdHkpLCAmaW50bWFzayk7Ci0JaWYgKHJj
IDwgMCkKLQkJaW50bWFzayA9IDA7Ci0KLQlpbnRtYXNrICY9IH5UUE1fR0xPQkFMX0lOVF9FTkFC
TEU7Ci0JcmMgPSB0cG1fdGlzX3dyaXRlMzIocHJpdiwgVFBNX0lOVF9FTkFCTEUocHJpdi0+bG9j
YWxpdHkpLCBpbnRtYXNrKTsKKwlfX3RwbV90aXNfZGlzYWJsZV9pbnRlcnJ1cHRzKGNoaXApOwog
CiAJZGV2bV9mcmVlX2lycShjaGlwLT5kZXYucGFyZW50LCBwcml2LT5pcnEsIGNoaXApOwogCXBy
aXYtPmlycSA9IDA7Ci0JY2hpcC0+ZmxhZ3MgJj0gflRQTV9DSElQX0ZMQUdfSVJROwogfQogCiAv
KgpAQCAtNzU1LDIwICs3NjIsMTEgQEAgc3RhdGljIGJvb2wgdHBtX3Rpc19yZXFfY2FuY2VsZWQo
c3RydWN0IHRwbV9jaGlwICpjaGlwLCB1OCBzdGF0dXMpCiBzdGF0aWMgdm9pZCB0cG1fdGlzX2hh
bmRsZV9pcnFfc3Rvcm0oc3RydWN0IHRwbV9jaGlwICpjaGlwKQogewogCXN0cnVjdCB0cG1fdGlz
X2RhdGEgKnByaXYgPSBkZXZfZ2V0X2RydmRhdGEoJmNoaXAtPmRldik7Ci0JaW50IGludG1hc2sg
PSAwOwogCiAJZGV2X2VycigmY2hpcC0+ZGV2LCBIV19FUlIKIAkJIlRQTSBpbnRlcnJ1cHQgc3Rv
cm0gZGV0ZWN0ZWQsIHBvbGxpbmcgaW5zdGVhZFxuIik7CiAKLQl0cG1fdGlzX3JlYWQzMihwcml2
LCBUUE1fSU5UX0VOQUJMRShwcml2LT5sb2NhbGl0eSksICZpbnRtYXNrKTsKLQotCWludG1hc2sg
Jj0gflRQTV9HTE9CQUxfSU5UX0VOQUJMRTsKLQotCXRwbV90aXNfcmVxdWVzdF9sb2NhbGl0eShj
aGlwLCAwKTsKLQl0cG1fdGlzX3dyaXRlMzIocHJpdiwgVFBNX0lOVF9FTkFCTEUocHJpdi0+bG9j
YWxpdHkpLCBpbnRtYXNrKTsKLQl0cG1fdGlzX3JlbGlucXVpc2hfbG9jYWxpdHkoY2hpcCwgMCk7
Ci0KLQljaGlwLT5mbGFncyAmPSB+VFBNX0NISVBfRkxBR19JUlE7CisJX190cG1fdGlzX2Rpc2Fi
bGVfaW50ZXJydXB0cyhjaGlwKTsKIAogCS8qCiAJICogV2UgbXVzdCBub3QgY2FsbCBkZXZtX2Zy
ZWVfaXJxKCkgZnJvbSB3aXRoaW4gdGhlIGludGVycnVwdCBoYW5kbGVyLAotLSAKMi40MC4xCgo=
