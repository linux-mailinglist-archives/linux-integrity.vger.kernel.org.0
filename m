Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F59D637A97
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Nov 2022 14:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiKXN4f (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Nov 2022 08:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiKXN4c (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Nov 2022 08:56:32 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB80F8028;
        Thu, 24 Nov 2022 05:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1669298172; bh=acaYZLOzjstSk1ewiw/25/8EH4h8E4f6Mhp7/e/Rz5w=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=OaCBfR5NBfypcT1zSMwJD814rZYvvu1zviaK+TZg+laBXbTG99/ckYdVg+29iJCE3
         WOZ0QoeyRJingQVkLhacS9qmFt7dFmT/BVS9P2cWDVEVk/JaCSvaGrob/VYOzMMFq/
         Pk60gwgGt2+SCROVVFqaddpSrX+d/ACqQR/splHbNENsiX/pCxEdcADcagfC2ud3g8
         a28SdMFKfFrp4X71P7cehGUZoHfCbQpR5nsGKXcENqZFMseXEG0U196+NCsXkcIMbm
         8543BhEunC6OCN6Ii/qTFk3b6mk4IWY5FHWN6s41qXrTsqlbj3LEw4IxCVDw05zvq8
         Bk00eDa6lFtzA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.7.17]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6Db0-1orazs1YVM-006eG0; Thu, 24
 Nov 2022 14:56:12 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v11 07/14] tpm, tpm_tis: Move interrupt mask checks into own function
Date:   Thu, 24 Nov 2022 14:55:31 +0100
Message-Id: <20221124135538.31020-8-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
References: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:on5JjKFr/xjl/gz/QEuHuParjIQHmU7ELMmZZwpGlAZEBanrutQ
 2DdmYrVPk4MXxqNOEjgNM1o/5202rmsWDop2c4+y1Dd+eAu6B0gEBvosJfuCbNs1QRZu+3V
 qP3NayH4ShRp4zVTwwcUQUUdFlefi6r2iBYNB/W19rryCjjBBk8hYlZSSFRtvztaMtg1uG0
 hGWbAIvKJV3lEse9ay9ww==
UI-OutboundReport: notjunk:1;M01:P0:qKA8UB9uP7o=;NJHWReHTds23j2YjqLN53o8czve
 pO8MMywFusnZoBq752jV++IRjLJ3npvTyinry9nqWvRaxmrIj1ZjrTkFGHztRgaFq6nIoP/Zz
 8DeTgGAHaTLgr+VO+rgpBmuKQe/8kv0utfunymD9mFUhU1N6a3oul+HDqWavxCEVWie3H7wqW
 UvSbpL7PZEkEE1XCxGVJCzzku07N73BMxinTVZWZV/JJYPdUsfT/Mz6dRqMfFhEW9YZ/6NukL
 18E0f+PRHZeQu/nkT7T2wFCo9caKtjwqQhGj5x4qZkFkuI2sowKfh/ygkS823SqAR46crAHTp
 VhdIVEb0w8F9naqRWqwD9wtGCJsadfQBQH4AHB2a4COnjHnxxx/Wf3V/quUzYVXf46uIXSRGW
 qJo8TkZ6Fhvnv+kOF7RAwG8JVCyq3C5Yc7BosykHuJrsZdPoexaLQRPRer3YGrYXp29kVaHa4
 aN4Q5vHy5SmQGf5hEf/FE2kevdzxUBXBf0zdyMnLwWmuylpiQQdHkN1HZfBJveTjSRTd+DMuc
 fUmkKxLkiOIAambnVlznRKR8WeU6Yd9W6RsfrWKPQvSGwscWiQiWT53OGUbTZIG3SsaF60tf0
 adsO+2SXenbr+g8X9O+olynu4D6kWljgjfyoc64tY0KldkoesA3PIbel7I3SsZTwp+zDfb9vR
 zwG4hPsyWf1d3Q2yPPtj61oQhBMlip8Tck/8cxu1f08FVXA6NnuTFZ499F5fny0/YFHxmcxCA
 a4DngGmbrZEcpxnGfnrff/CF2MKNxvb/8YsnXUIVtyeZ1hb+X/iFxYacOGKbq9i9nKtLdxm8y
 KhvcsEoCIGKfCOYQLyQACo7eGFHE0u4fdMeuK5yKGIe/nhsA3HdZSuTwUO7S9bXm4DabGxHHm
 9fWkz0hojsmU0vfMjLCSrgkNfWFDc4wIStTkxskzUt0EdNzgs5qWqq4nlDb/rDEwEq2t2Jdgy
 dU+KeIa1xHjdKS2GFKMVIXadGKs=
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkNsZWFuIHVw
IHdhaXRfZm9yX3RwbV9zdGF0KCkgYnkgbW92aW5nIG11bHRpcGxlIHNpbWlsYXIgaW50ZXJydXB0
IG1hc2sKY2hlY2tzIGludG8gYW4gb3duIGZ1bmN0aW9uLgoKU2lnbmVkLW9mZi1ieTogTGlubyBT
YW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KU3VnZ2VzdGVkLWJ5OiBKYXJra28g
U2Fra2luZW4gPGphcmtrb0BrZXJuZWwub3JnPgpSZXZpZXdlZC1ieTogSmFya2tvIFNha2tpbmVu
IDxqYXJra29Aa2VybmVsLm9yZz4KLS0tCiBkcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5j
IHwgMjkgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxOCBp
bnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIv
dHBtL3RwbV90aXNfY29yZS5jIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwppbmRl
eCAyNjk0YjFiYjc3ZGUuLjY1ZDFlYzdlYjRjMyAxMDA2NDQKLS0tIGEvZHJpdmVycy9jaGFyL3Rw
bS90cG1fdGlzX2NvcmUuYworKysgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCkBA
IC00NCw2ICs0NCwyMCBAQCBzdGF0aWMgYm9vbCB3YWl0X2Zvcl90cG1fc3RhdF9jb25kKHN0cnVj
dCB0cG1fY2hpcCAqY2hpcCwgdTggbWFzaywKIAlyZXR1cm4gZmFsc2U7CiB9CiAKK3N0YXRpYyB1
OCB0cG1fdGlzX2ZpbHRlcl9zdHNfbWFzayh1OCBpbnRfbWFzaywgdTggc3RzX21hc2spCit7CisJ
aWYgKCEoaW50X21hc2sgJiBUUE1fSU5URl9TVFNfVkFMSURfSU5UKSkKKwkJc3RzX21hc2sgJj0g
flRQTV9TVFNfVkFMSUQ7CisKKwlpZiAoIShpbnRfbWFzayAmIFRQTV9JTlRGX0RBVEFfQVZBSUxf
SU5UKSkKKwkJc3RzX21hc2sgJj0gflRQTV9TVFNfREFUQV9BVkFJTDsKKworCWlmICghKGludF9t
YXNrICYgVFBNX0lOVEZfQ01EX1JFQURZX0lOVCkpCisJCXN0c19tYXNrICY9IH5UUE1fU1RTX0NP
TU1BTkRfUkVBRFk7CisKKwlyZXR1cm4gc3RzX21hc2s7Cit9CisKIHN0YXRpYyBpbnQgd2FpdF9m
b3JfdHBtX3N0YXQoc3RydWN0IHRwbV9jaGlwICpjaGlwLCB1OCBtYXNrLAogCQl1bnNpZ25lZCBs
b25nIHRpbWVvdXQsIHdhaXRfcXVldWVfaGVhZF90ICpxdWV1ZSwKIAkJYm9vbCBjaGVja19jYW5j
ZWwpCkBAIC01Myw3ICs2Nyw3IEBAIHN0YXRpYyBpbnQgd2FpdF9mb3JfdHBtX3N0YXQoc3RydWN0
IHRwbV9jaGlwICpjaGlwLCB1OCBtYXNrLAogCWxvbmcgcmM7CiAJdTggc3RhdHVzOwogCWJvb2wg
Y2FuY2VsZWQgPSBmYWxzZTsKLQl1OCBzdHNfbWFzayA9IDA7CisJdTggc3RzX21hc2s7CiAJaW50
IHJldCA9IDA7CiAKIAkvKiBjaGVjayBjdXJyZW50IHN0YXR1cyAqLwpAQCAtNjEsMTcgKzc1LDEw
IEBAIHN0YXRpYyBpbnQgd2FpdF9mb3JfdHBtX3N0YXQoc3RydWN0IHRwbV9jaGlwICpjaGlwLCB1
OCBtYXNrLAogCWlmICgoc3RhdHVzICYgbWFzaykgPT0gbWFzaykKIAkJcmV0dXJuIDA7CiAKKwlz
dHNfbWFzayA9IG1hc2sgJiAoVFBNX1NUU19WQUxJRCB8IFRQTV9TVFNfREFUQV9BVkFJTCB8CisJ
CQkgICBUUE1fU1RTX0NPTU1BTkRfUkVBRFkpOwogCS8qIGNoZWNrIHdoYXQgc3RhdHVzIGNoYW5n
ZXMgY2FuIGJlIGhhbmRsZWQgYnkgaXJxcyAqLwotCWlmIChwcml2LT5pbnRfbWFzayAmIFRQTV9J
TlRGX1NUU19WQUxJRF9JTlQpCi0JCXN0c19tYXNrIHw9IFRQTV9TVFNfVkFMSUQ7Ci0KLQlpZiAo
cHJpdi0+aW50X21hc2sgJiBUUE1fSU5URl9EQVRBX0FWQUlMX0lOVCkKLQkJc3RzX21hc2sgfD0g
VFBNX1NUU19EQVRBX0FWQUlMOwotCi0JaWYgKHByaXYtPmludF9tYXNrICYgVFBNX0lOVEZfQ01E
X1JFQURZX0lOVCkKLQkJc3RzX21hc2sgfD0gVFBNX1NUU19DT01NQU5EX1JFQURZOwotCi0Jc3Rz
X21hc2sgJj0gbWFzazsKKwlzdHNfbWFzayA9IHRwbV90aXNfZmlsdGVyX3N0c19tYXNrKHByaXYt
PmludF9tYXNrLCBzdHNfbWFzayk7CiAKIAlzdG9wID0gamlmZmllcyArIHRpbWVvdXQ7CiAJLyog
cHJvY2VzcyBzdGF0dXMgY2hhbmdlcyB3aXRoIGlycSBzdXBwb3J0ICovCi0tIAoyLjM2LjEKCg==
