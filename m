Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EE8637A9B
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Nov 2022 14:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiKXN4i (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Nov 2022 08:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiKXN4d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Nov 2022 08:56:33 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB867FFAA4;
        Thu, 24 Nov 2022 05:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1669298174; bh=RNoCSRg3R8Wx3i1g1q633Fjj4lnL+OK+lra5ATnMp4U=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=EaPyy9kWmOu7yKDblEHFb1TJ5KSgmh9amRrtcp6n4LxnIot32DPejBQEp6w5OZQMb
         wvGeQC8V5z2rSj0pQ1wZAVJP6dQqnCTae817QMGQ1xwCksrsb7fUSDcQ6phiyUQfWP
         Ba0nHQZ0ERIHCurT5pYh9gQKxcnG6GkGGu5UWSD3/aZmYOx4uNNR4IXIH0+fameSR4
         BOidMDBAlEHo7entttgS2iAvsSus35bEgBZdrzLjCQ5swNMwux4uJTnoz607VQaQQA
         r/WXQ3kEy2wvRKtObjNS5wIy2mVlZF96wB67Xc609JwVa0r0Iha7wql8TDfUxkqIX1
         Ttu292M01Cm0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.7.17]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtwZ4-1pCZjF3EZo-00uMey; Thu, 24
 Nov 2022 14:56:13 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v11 11/14] tpm, tpm_tis: Claim locality in interrupt handler
Date:   Thu, 24 Nov 2022 14:55:35 +0100
Message-Id: <20221124135538.31020-12-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
References: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:+4teyRziUIPdBKrwSWvjbsYkNgwpeKjz1mYZdtd3vDEeyiycqjq
 Wn9EuRUn7cNzN0xLlFliMQlxrp3BVEhJBSEoTBpSpElfCo/J7xOXQ9/2TkRPrT0mGaalOUy
 97c/MhwXZU2JvaFyfG+PHlwYacqYGORMF/RkmbU2JdwE2Wodb4K7URnxMG3W6fSRMKMjzWq
 VTXro35eiHY+OdD1aOzGg==
UI-OutboundReport: notjunk:1;M01:P0:9cGxeBqa+go=;IZmiS8eY/s4mXxdKxByX1ytWAaV
 D7ibIuts1yzeVae/mmUwoaaegD1M24aTq+2HcJNDfQybbRRrp/xUSN48bKXNKHFwkA7BJOnw1
 HUFjgAAU65YSumPyzvpOhjJv/addNEkVybPaq41S1SqmZN5rAhMOvZmnZILLRWd5cAOaUrHdZ
 wHooG4mwvJWcT/F9i9GksWlqSNPdlrsW8HLfybtlMs0X/77AzXUAFPmdG/ecJJ+vgb45MXTb2
 FFgtiYPrSGBbNIZpQ8Puzn5yBgvkHWGXkia9tkx2BjGgu8yO0JfhrwjdnKtn0M+FutqkIvMnk
 aVcm2trverNdhUrwL8K+WmOTDRcUGJwplzJET08gaPmramDZH/NQ2FQioxMKE3OOEourBcier
 GfYu2NtVJrKd2uEMyhOxdLMbJJNDAxa7tQoXgKm+sGgT69VZ9tyWN7IM4ONlLc7pGnJ3HeCLE
 30sKBMxjIC9OZflH9NqEZKjaAJIPfjYKaRgrl/K13mkr1rHWIq6V9B96QZYVIiMS8BDVBjGI5
 zoPkOqaI0cduKu6gCrBKuANPDuhVl5moHKFPVBV9+trzcMp0C/Q4lfYRdwhQHkjdiDp1TL74D
 lXmTQ67gcWK3WMMof4sJmyFcxMBaO2bvnYP9QHoeo61FMuLxtX4x00jAwpnDPSP1Up9omPzDG
 Uc04HeDrs4PjK53D6ZgLwIeVACfL29Upgk/+BdToD5LwEbfqR3KkJgZg1N0q2iUJaLfGyCjNP
 Gtj9uWJZ9Xgs5S25P3cdefAQDuaBF/LkHW3HgwBZpUWDUyhVumLdFsC/MbLI3AWwqfRT74Asj
 0X0mT9s0UpIQJQAgXeS0ClFoeKhgB1O1rbauvAZ8fwtRuWtAkkKZEJOZaRKJ7m3Mr1hI0Ae5f
 6db04brPOWz2pHfpyd39uTgbq+2g2hKkKkSTEa2jTpFWcaaCujrYwU20hBjZWJt3a6gMW5X5M
 4k24Cg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCldyaXRpbmcg
dGhlIFRQTV9JTlRfU1RBVFVTIHJlZ2lzdGVyIGluIHRoZSBpbnRlcnJ1cHQgaGFuZGxlciB0byBj
bGVhciB0aGUKaW50ZXJydXB0cyBvbmx5IGhhcyBlZmZlY3QgaWYgYSBsb2NhbGl0eSBpcyBoZWxk
LiBTaW5jZSB0aGlzIGlzIG5vdApndWFyYW50ZWVkIGF0IHRoZSB0aW1lIHRoZSBpbnRlcnJ1cHQg
aXMgZmlyZWQsIGNsYWltIHRoZSBsb2NhbGl0eQpleHBsaWNpdGx5IGluIHRoZSBoYW5kbGVyLgoK
U2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4K
UmV2aWV3ZWQtYnk6IEphcmtrbyBTYWtraW5lbiA8amFya2tvQGtlcm5lbC5vcmc+ClRlc3RlZC1i
eTogTWljaGFlbCBOaWV3w7ZobmVyIDxsaW51eEBtbmlld29laG5lci5kZT4KLS0tCiBkcml2ZXJz
L2NoYXIvdHBtL3RwbV90aXNfY29yZS5jIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMgYi9k
cml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCmluZGV4IDM4OTE0OTlmOTg3Ny4uZWRhM2Ix
MjJlNTQwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCisrKyBi
L2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMKQEAgLTc3Miw3ICs3NzIsOSBAQCBzdGF0
aWMgaXJxcmV0dXJuX3QgdGlzX2ludF9oYW5kbGVyKGludCBkdW1teSwgdm9pZCAqZGV2X2lkKQog
CQl3YWtlX3VwX2ludGVycnVwdGlibGUoJnByaXYtPmludF9xdWV1ZSk7CiAKIAkvKiBDbGVhciBp
bnRlcnJ1cHRzIGhhbmRsZWQgd2l0aCBUUE1fRU9JICovCisJdHBtX3Rpc19yZXF1ZXN0X2xvY2Fs
aXR5KGNoaXAsIDApOwogCXJjID0gdHBtX3Rpc193cml0ZTMyKHByaXYsIFRQTV9JTlRfU1RBVFVT
KHByaXYtPmxvY2FsaXR5KSwgaW50ZXJydXB0KTsKKwl0cG1fdGlzX3JlbGlucXVpc2hfbG9jYWxp
dHkoY2hpcCwgMCk7CiAJaWYgKHJjIDwgMCkKIAkJcmV0dXJuIElSUV9OT05FOwogCi0tIAoyLjM2
LjEKCg==
