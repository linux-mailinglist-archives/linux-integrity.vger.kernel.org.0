Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5386245AB
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Nov 2022 16:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiKJP0j (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Nov 2022 10:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiKJP0Z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Nov 2022 10:26:25 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04063F057;
        Thu, 10 Nov 2022 07:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668093944; bh=BzRmHyDjx6k9QxSMFomIGBOCh5qkOm5olPta9ZMqnS8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=oY6fc+MYBmRFOvgb1YCUuqd6X+pZtADhu3inWas+5FfA/rSVClrbBWfvPFhTl6djQ
         v9ej/mziiOQMsOxkFUgWGlsCSXzxAVhDPhKyN/xh6DQx6ieT6UHaNfa5bEEh4RxqPZ
         51gng7vWATJ1935pn85laTRnf6KebPt66RJimf0sDUAYhUSkJSPu5ygNpHPKfQvIQo
         2tzggNsFvU2TjLy4cg7roPmIBj5kZCnC0LkiKGIW96fL+6ZGaJkPOPMoA6Tp4+II4k
         fekEygrmS32NeEQ63LVuuiffk2hKMO7o1zkJZ/yvo6wUrZnU0zzaPaXu+bVP/DxiYZ
         EPzKUdXv1OQpQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.7.17]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXp9Y-1oTwV23BQS-00Y6S9; Thu, 10
 Nov 2022 16:25:44 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v9 06/12] tpm, tpm_tis: Move interrupt mask checks into own function
Date:   Thu, 10 Nov 2022 16:25:27 +0100
Message-Id: <20221110152533.24243-7-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221110152533.24243-1-LinoSanfilippo@gmx.de>
References: <20221110152533.24243-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:cFLkuomk+v0SkP7u8SezZBP73KBGJZF+fzCImxN4pepHBu5mmiO
 WmkjjVnyKIMm8XUfP1CeWH7OAbdnoIbnWYanzNGiKAY+F+5PL/F41fRNg0sp9A8LZm136lk
 TtzqNt0X+LzYIX/bfXTtDWSsMgWA2dqaDIaMXq4pqBC7ZqVcWDnwMbDB+bNeoE+/2+E3TMV
 EfrSj4atodSK8n4KR2JQQ==
UI-OutboundReport: notjunk:1;M01:P0:lP6ySNlNswI=;hZlaPPrCIuE9fbdQsSy5xcOLm7o
 Y1+ZA49ssqiuYcDb/0XdwAYWFCM/yHjRT7WOgAZz4xtX/36EriSQ4RH/btxVIpaCr9htSdkoN
 jhLfjOYF4i1pPetZSWJS0q7aRUT9D9xKXwBDKXtwsUIgePBl5GNo41756hkkmtitsgfz/a8nF
 omkPJvjMsYJpwIiG73JeziCK/0gGNZMgYsYtlJHITM6PE1iyHQK+yxrsSVnRvTBNffSN0t0IY
 WQeVmAuykY/ThW6ikbSw3kQYla3AWQyvIDEM4LsGfLJM0NbphDsJKcX52MM1oyLzeEQGlImap
 9qMH7eZcX0eqGZa+uNc5ZsKa/yjNQlkDGYaOrYBw3Po0p2o+xWIcuCb57D6js0uyy3mbKD0RK
 i8lQUZwh8OhyUFUDB1dhpIvJsmtIB+dB+FXIftHyThgll0VGGQbe8F+DtaHmx0/ydK8C7Exmf
 A7+vIW4uW3U8vm0O8xESS1di+xUfYPcggfx6uY/6E2vBrw2Rj8a2UwLvr9eg661GfY/Q7YQYY
 c6SpyuqU+x35azXxgAbnrZQFsNIL6CsfsgFJlzs4O8lB4ECIBoahX1p5QZzpRCkG6vJkeoQ+Q
 /jS7JLe7s1hD6B1mmG7UOGF4hQ9gG1s2P6aSaAfvUSrfWJUpSs3moni+o8/iFneVkGt6+26yH
 uDDum/OKxZs8Y3s5AKkPf1J50bDcbJzlBjtD76qjWBzZ/ZMVyNfIGK9QiAt1vizPZci08/mHx
 U92021RTCnjcwUylWhSIdpeMZ96n/527q4Tg0Rvcl32INyOwk7cYxYu3OHZ54kcQbiRNhkfQX
 rB8oisujW1e2g8ajYu85rspxHXrCOSdHbUS6HMJzdEqqum9QKm6QxqdvfWmREgxuzqhLMs9Pu
 9Z1d2u5OBaZtU2RqekAaso2rxQGi6m75eN3nTPFEF107etCkQlVbmJYpI71JacBuf/PCZ6MGY
 NkI2hU4tEm5o2mTBKoB3rg5X9gw=
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
eCBkMDdkZWJjMzE4MmMuLjE4MWMyOTFiMGJiOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9jaGFyL3Rw
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
