Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6BB637AA4
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Nov 2022 14:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiKXN5C (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Nov 2022 08:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiKXN4g (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Nov 2022 08:56:36 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959531144A0;
        Thu, 24 Nov 2022 05:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1669298171; bh=ptF3+UGs4RT73xf2t1eIkj3kEEU2mVqh+94Ww0mBJ/Y=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=AnW4r+OsnxZ+EYbiLrZC1GEfrkwBMKkGjVbunHu9MVuFBEg8tJv4TkeXrSLD8HVib
         2pL4ZWpLDB/eD/XjdwtKOR9haHd/ygJ6ThKqgy9/vfglCvO6Pbo1kuqmRc0bZj3mQY
         /f8di0hXImAOFVtsTfmQx+PYBCWY2sP79gtebkLS9Z4HuOd91+qjJX3OJKePk60qeQ
         l8hDjg7fSqtIjxHmL9x1u2WHIQXjKaouDYKWr11xC6htp67F/b/morily0q26F37N9
         RYQ40TQZ6JMYnsIVae5hINasFXYcMTIQYx0F+Yxz/OBSLs/U80QpK6RTlJydrAY71c
         /6JnRskhZrXug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.7.17]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MjS9I-1pLxfF1RgQ-00kulG; Thu, 24
 Nov 2022 14:56:11 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v11 04/14] tpm, tpm_tis: Do not skip reset of original interrupt vector
Date:   Thu, 24 Nov 2022 14:55:28 +0100
Message-Id: <20221124135538.31020-5-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
References: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:xa3nABt20tkSDNQZTlmJqGyJFMR+Hbk/kMbprAIaZ7AODF6LfDJ
 Ga0c6+Iat/fGjI8FJXKlN6Y9C2aNPvUmcmx5LzMenvb2JTFxXVDHdC6ureaQ7UKKFobQMW7
 XZbwotp3OCfIyfy9i35yO3DFlo9WhGXR1BKBPiDVYPyWupMdSJaUjIlU3aMBqdP2chOexIU
 kCDWZSOL7frbQ5qM+piSg==
UI-OutboundReport: notjunk:1;M01:P0:2Hr5OHt1gBo=;NUhu4G4cDfH7sTC3pjO8cBUfk7h
 tZCb0PHuDXpJsMonJd/CvI5LHnzBltvRtPHblBrRTMe5zFPGZSBmlWjqTefk1dH/wNHET60lr
 MrAaRG4l1xqlw+AEztk4wr1UoiS6tI2dwXuae9XpRuOE3eZVLYJ2J0O86eHVn1ZZBQ6tmQPJ0
 Ge7zmvA0ZYoWmruFXMO7b8+rIhuMzo1aXOvI8IIHY0jLKvemekT3PSHPNOzntqA3SwPG+7lUc
 mVX+T0njRTLcGoWJSiuJFFH4RJrCgwST+L0/cINzUydQbzfJbN1YfpstXTvd8FE9NeHEhbqaI
 bkG7d8K7NKmauHaF+dZ1tSDhMsn1Qt2zCcNRZgXZ0NcN75qE8OR9x35gWfmKgAA3snMok0kl4
 fPJinvr5oX6R/ZrNrqJ7sU0B3xbNsAnzneaCcHxCdTR2jO5VMiXN6U3PG6xjxlUwprDeXoNE4
 FUZMvVyz90wGq+t0BSgnjFgMPIHh3oJChdWNRrghoX3GjFFEFqVvEAUJGGbPqnptk5dfkiirr
 RNdt/t65fxSfRF+HhsZqF8x3SYQMfD24J7pfbAOihuafH3q3z5le9d+juhl/puqHxTjG5QOqb
 4hpAjCxlS/ELD80617vknBZlTnXp/49vAQfqJVjEKRx5kFiYHZIC+HMUnWJZd8RkWGTpuhHWD
 bLfwdAKSTe26fFaf449kTB6P+D080NwhGsgde3udeqt3o/H5V2wbiL0MHDmgxOkCu2nrpSGZG
 B5UwJmzvN47wxJWSOMXE0mcxWjPENKu/8C57BAXYUCL1XHBrlWi5zZC47PqWil4BLb6Q76cKs
 hg2Jbw47bupIuN4sC9OOsHMJiCZkdw9Z1qfqqNTbQROvsUxxA86weCLHZ+T9xA1Uo5gOa8ARg
 vMuYmSUIxQaxA1qjmg1zDKADcCxzIxg397Ivy4DzgSzzACqQg73a84aE1+/+NVZM2ZNaz8NvS
 OmIYpA==
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCklmIGluIHRw
bV90aXNfcHJvYmVfaXJxX3NpbmdsZSgpIGFuIGVycm9yIG9jY3VycyBhZnRlciB0aGUgb3JpZ2lu
YWwKaW50ZXJydXB0IHZlY3RvciBoYXMgYmVlbiByZWFkLCByZXN0b3JlIHRoZSBpbnRlcnJ1cHRz
IGJlZm9yZSB0aGUgZXJyb3IgaXMKcmV0dXJuZWQuCgpTaW5jZSB0aGUgY2FsbGVyIGRvZXMgbm90
IGNoZWNrIHRoZSBlcnJvciB2YWx1ZSwgcmV0dXJuIC0xIGluIGFueSBjYXNlIHRoYXQKdGhlIFRQ
TV9DSElQX0ZMQUdfSVJRIGZsYWcgaXMgbm90IHNldC4gU2luY2UgdGhlIHJldHVybiB2YWx1ZSBv
ZiBmdW5jdGlvbgp0cG1fdGlzX2dlbl9pbnRlcnJ1cHQoKSBpcyBub3QgbG9uZ2VyIHVzZWQsIG1h
a2UgaXQgYSB2b2lkIGZ1bmN0aW9uLgoKRml4ZXM6IDExMDdkMDY1ZmRmMSAoInRwbV90aXM6IElu
dHJvZHVjZSBpbnRlcm1lZGlhdGUgbGF5ZXIgZm9yIFRQTSBhY2Nlc3MiKQpTaWduZWQtb2ZmLWJ5
OiBMaW5vIFNhbmZpbGlwcG8gPGwuc2FuZmlsaXBwb0BrdW5idXMuY29tPgotLS0KIGRyaXZlcnMv
Y2hhci90cG0vdHBtX3Rpc19jb3JlLmMgfCAyOSArKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0t
LQogMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMgYi9kcml2ZXJzL2NoYXIv
dHBtL3RwbV90aXNfY29yZS5jCmluZGV4IDYwM2I4MmNhNTZkYS4uODFiOTcyNmQzZWQyIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCisrKyBiL2RyaXZlcnMvY2hh
ci90cG0vdHBtX3Rpc19jb3JlLmMKQEAgLTcyOSw3ICs3MjksNyBAQCBzdGF0aWMgaXJxcmV0dXJu
X3QgdGlzX2ludF9oYW5kbGVyKGludCBkdW1teSwgdm9pZCAqZGV2X2lkKQogCXJldHVybiBJUlFf
SEFORExFRDsKIH0KIAotc3RhdGljIGludCB0cG1fdGlzX2dlbl9pbnRlcnJ1cHQoc3RydWN0IHRw
bV9jaGlwICpjaGlwKQorc3RhdGljIHZvaWQgdHBtX3Rpc19nZW5faW50ZXJydXB0KHN0cnVjdCB0
cG1fY2hpcCAqY2hpcCkKIHsKIAljb25zdCBjaGFyICpkZXNjID0gImF0dGVtcHRpbmcgdG8gZ2Vu
ZXJhdGUgYW4gaW50ZXJydXB0IjsKIAl1MzIgY2FwMjsKQEAgLTczOCw3ICs3MzgsNyBAQCBzdGF0
aWMgaW50IHRwbV90aXNfZ2VuX2ludGVycnVwdChzdHJ1Y3QgdHBtX2NoaXAgKmNoaXApCiAKIAly
ZXQgPSByZXF1ZXN0X2xvY2FsaXR5KGNoaXAsIDApOwogCWlmIChyZXQgPCAwKQotCQlyZXR1cm4g
cmV0OworCQlyZXR1cm47CiAKIAlpZiAoY2hpcC0+ZmxhZ3MgJiBUUE1fQ0hJUF9GTEFHX1RQTTIp
CiAJCXJldCA9IHRwbTJfZ2V0X3RwbV9wdChjaGlwLCAweDEwMCwgJmNhcDIsIGRlc2MpOwpAQCAt
NzQ2LDggKzc0Niw2IEBAIHN0YXRpYyBpbnQgdHBtX3Rpc19nZW5faW50ZXJydXB0KHN0cnVjdCB0
cG1fY2hpcCAqY2hpcCkKIAkJcmV0ID0gdHBtMV9nZXRjYXAoY2hpcCwgVFBNX0NBUF9QUk9QX1RJ
U19USU1FT1VULCAmY2FwLCBkZXNjLCAwKTsKIAogCXJlbGVhc2VfbG9jYWxpdHkoY2hpcCwgMCk7
Ci0KLQlyZXR1cm4gcmV0OwogfQogCiAvKiBSZWdpc3RlciB0aGUgSVJRIGFuZCBpc3N1ZSBhIGNv
bW1hbmQgdGhhdCB3aWxsIGNhdXNlIGFuIGludGVycnVwdC4gSWYgYW4KQEAgLTc3Nyw0MiArNzc1
LDM3IEBAIHN0YXRpYyBpbnQgdHBtX3Rpc19wcm9iZV9pcnFfc2luZ2xlKHN0cnVjdCB0cG1fY2hp
cCAqY2hpcCwgdTMyIGludG1hc2ssCiAKIAlyYyA9IHRwbV90aXNfd3JpdGU4KHByaXYsIFRQTV9J
TlRfVkVDVE9SKHByaXYtPmxvY2FsaXR5KSwgaXJxKTsKIAlpZiAocmMgPCAwKQotCQlyZXR1cm4g
cmM7CisJCWdvdG8gcmVzdG9yZV9pcnFzOwogCiAJcmMgPSB0cG1fdGlzX3JlYWQzMihwcml2LCBU
UE1fSU5UX1NUQVRVUyhwcml2LT5sb2NhbGl0eSksICZpbnRfc3RhdHVzKTsKIAlpZiAocmMgPCAw
KQotCQlyZXR1cm4gcmM7CisJCWdvdG8gcmVzdG9yZV9pcnFzOwogCiAJLyogQ2xlYXIgYWxsIGV4
aXN0aW5nICovCiAJcmMgPSB0cG1fdGlzX3dyaXRlMzIocHJpdiwgVFBNX0lOVF9TVEFUVVMocHJp
di0+bG9jYWxpdHkpLCBpbnRfc3RhdHVzKTsKIAlpZiAocmMgPCAwKQotCQlyZXR1cm4gcmM7Ci0K
KwkJZ290byByZXN0b3JlX2lycXM7CiAJLyogVHVybiBvbiAqLwogCXJjID0gdHBtX3Rpc193cml0
ZTMyKHByaXYsIFRQTV9JTlRfRU5BQkxFKHByaXYtPmxvY2FsaXR5KSwKIAkJCSAgICAgaW50bWFz
ayB8IFRQTV9HTE9CQUxfSU5UX0VOQUJMRSk7CiAJaWYgKHJjIDwgMCkKLQkJcmV0dXJuIHJjOwor
CQlnb3RvIHJlc3RvcmVfaXJxczsKIAogCWNsZWFyX2JpdChUUE1fVElTX0lSUV9URVNURUQsICZw
cml2LT5mbGFncyk7CiAKIAkvKiBHZW5lcmF0ZSBhbiBpbnRlcnJ1cHQgYnkgaGF2aW5nIHRoZSBj
b3JlIGNhbGwgdGhyb3VnaCB0bwogCSAqIHRwbV90aXNfc2VuZAogCSAqLwotCXJjID0gdHBtX3Rp
c19nZW5faW50ZXJydXB0KGNoaXApOwotCWlmIChyYyA8IDApCi0JCXJldHVybiByYzsKKwl0cG1f
dGlzX2dlbl9pbnRlcnJ1cHQoY2hpcCk7CiAKK3Jlc3RvcmVfaXJxczoKIAkvKiB0cG1fdGlzX3Nl
bmQgd2lsbCBlaXRoZXIgY29uZmlybSB0aGUgaW50ZXJydXB0IGlzIHdvcmtpbmcgb3IgaXQKIAkg
KiB3aWxsIGNhbGwgZGlzYWJsZV9pcnEgd2hpY2ggdW5kb2VzIGFsbCBvZiB0aGUgYWJvdmUuCiAJ
ICovCiAJaWYgKCEoY2hpcC0+ZmxhZ3MgJiBUUE1fQ0hJUF9GTEFHX0lSUSkpIHsKLQkJcmMgPSB0
cG1fdGlzX3dyaXRlOChwcml2LCBvcmlnaW5hbF9pbnRfdmVjLAotCQkJCVRQTV9JTlRfVkVDVE9S
KHByaXYtPmxvY2FsaXR5KSk7Ci0JCWlmIChyYyA8IDApCi0JCQlyZXR1cm4gcmM7Ci0KLQkJcmV0
dXJuIDE7CisJCXRwbV90aXNfd3JpdGU4KHByaXYsIG9yaWdpbmFsX2ludF92ZWMsCisJCQkgICAg
ICAgVFBNX0lOVF9WRUNUT1IocHJpdi0+bG9jYWxpdHkpKTsKKwkJcmV0dXJuIC0xOwogCX0KIAog
CXJldHVybiAwOwotLSAKMi4zNi4xCgo=
