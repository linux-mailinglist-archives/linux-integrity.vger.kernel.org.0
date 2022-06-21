Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29994553399
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Jun 2022 15:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351435AbiFUNeU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Jun 2022 09:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351724AbiFUNbC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jun 2022 09:31:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D5E2AE21;
        Tue, 21 Jun 2022 06:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655817939;
        bh=DoyUOUgtLRmwTXrdCxwv4uyz3gneFIuw1ykEwqWoKmk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fKg0FPNJ+QhuxDvoyU3GWxbPagIh+fqfozdg45qiBM1ujcKUBvGVyX8zWJyky5j2b
         eLXYb88XLPKAlX26vudyjkr9ZtuK6ThqhaUgdAI6gNx4qJH6tQnkQTa7io1Aiuy5lc
         RntGorcb7dvVPmijjti9Od+JGUUqc17ecrvuYMEk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.2.162]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPXhA-1oHKym33tC-00MbLS; Tue, 21
 Jun 2022 15:25:38 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, LinoSanfilippo@gmx.de, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: [PATCH v6 7/9] tpm, tpm_tis: Request threaded interrupt handler
Date:   Tue, 21 Jun 2022 15:24:45 +0200
Message-Id: <20220621132447.16281-8-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621132447.16281-1-LinoSanfilippo@gmx.de>
References: <20220621132447.16281-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:LSFolzDTqrxzG241zWlFs0bZTJW6YP2K+0p264Voigwvs6X3g10
 q0izPBl+f62rpvBvWkR85sAtIJ6jkhKx7SuTO2J2V8OQwTM+jasC/tNC8/o6GkrX6QOqBG4
 8KdTq/5fg9muaZU5cdFH1Ipjp15NUfsxdHPzlaaFvS8d+mYsyGbW5bG5UpiJtVKMqfMuVDD
 yiUGKm8fWBqgmSKdHEeAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uDSmFMLF+R8=:yWUtSU9WlaxR4aBz2TGW40
 vCM7msOYbff7lyc3E+x8BaFtCWUMMtcFt1o6/7SdNatkZlNQVSplvhRFRiQ+gY6M8BAQUNj0C
 zIpQr8MxD3K+htr1ZWs2CEDjca79TQ8+VcBUnWTPojJzTcc8LZqZzNxe/yjx5MlSfEC3bgQKJ
 r1f5QmPdxGk8/W4aWBTbpYfS75BpETH+nr2jA2MmXvwfMcz9E6xY/JPdfDOI8BEcb+SfS0/ug
 jX6NAXq0AdF/2TOR7yvmuJvlyzFubII6OS1pI8EWuRCNBMlJZcipyLrWaewwmFWuCbpbctQXF
 mAHl4FVFz4TmfsLJiAMMXcz1ZLlQsRwM21IbfoMipWiGq6a70OefkUiRORGiOcJfzLsPq839B
 8gatpyy2SNYSkPhJapkmxvNwhBljEaJtA9gQJOnas8NCqrgI2yrNy0Ov5kIeuk0hJeSa8QqbL
 k6W/YYvKIgVkhMIQ4jUuysvxKIYnWhvAgPUtIGwMAs9FqypVmPXAlHMHG/JGV3oTeZK84F3NH
 5YQBsapUrieHBXQhYWDCUjfNPl96d0rMOAkzUCUFYN1pH0uSTVgPaiy7YO0pOVja95jniX/Kj
 4HplBtRZzsnD0FBPAG4zzcuQUN63UWnSkfFp8lt3O0FzVo/AX2sQW6S1Gj0/0S/z8NrA972Rd
 SFmJazzzMELlBEWlqPzu7UHjgTvrY2XqgYLwynxjp3uEN9crkWKAsPp2JVGkngyzN98V5J2p9
 FdrJqrwKsNxNcynJ1mVNNZ4CQfb/DoaYMOQhhylSDEg5O8tSQ6kNxHcYZh4Mxg5KJXb73U2RN
 HqD0Sq9SGIGf3/lwQ+/E46C4kmX6A6gSdwuSCdq6RzGKMRcUiUxJgScZtw3pfDCmlpYpA5lrV
 PXs8Ag5MtMG2w4t6p5OrE1rvNq6Jp60ZwJk9bj2QUuqhcW1s4n/m+AL2L26lBjQPwDh6BvJHx
 FY8gGbDDuUjU4hHtaVrbeX7FZHi27V0dabJEcd24VEeaC22j9N8RPGUwP253KsbjO8idYih5L
 uQjmHidrbcqxvctrLhcw5YOeFWYY1ncyYNR9bqmBSH6QFh2H5MPwpKHVievc5t15RCzsUSSja
 PpitHFfj4r87z3SlZOleds5CFCMMwW8qG1jjdOtPko2+Z6+Ajx5fkKLsQ==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KClRoZSBUSVMg
aW50ZXJydXB0IGhhbmRsZXIgYXQgbGVhc3QgaGFzIHRvIHJlYWQgYW5kIHdyaXRlIHRoZSBpbnRl
cnJ1cHQKc3RhdHVzIHJlZ2lzdGVyLiBJbiBjYXNlIG9mIFNQSSBib3RoIG9wZXJhdGlvbnMgcmVz
dWx0IGluIGEgY2FsbCB0bwp0cG1fdGlzX3NwaV90cmFuc2ZlcigpIHdoaWNoIHVzZXMgdGhlIGJ1
c19sb2NrX211dGV4IG9mIHRoZSBzcGkgZGV2aWNlCmFuZCB0aHVzIG11c3Qgb25seSBiZSBjYWxs
ZWQgZnJvbSBhIHNsZWVwYWJsZSBjb250ZXh0LgoKVG8gZW5zdXJlIHRoaXMgcmVxdWVzdCBhIHRo
cmVhZGVkIGludGVycnVwdCBoYW5kbGVyLgoKU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBv
IDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KLS0tCiBkcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNf
Y29yZS5jIHwgNyArKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMg
Yi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCmluZGV4IDYzOTgzOGM1Y2ZlMy4uMDhh
NGU4MmY3NmExIDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCisr
KyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMKQEAgLTc5NSw4ICs3OTUsMTEgQEAg
c3RhdGljIGludCB0cG1fdGlzX3Byb2JlX2lycV9zaW5nbGUoc3RydWN0IHRwbV9jaGlwICpjaGlw
LCB1MzIgaW50bWFzaywKIAlpbnQgcmM7CiAJdTMyIGludF9zdGF0dXM7CiAKLQlpZiAoZGV2bV9y
ZXF1ZXN0X2lycShjaGlwLT5kZXYucGFyZW50LCBpcnEsIHRpc19pbnRfaGFuZGxlciwgZmxhZ3Ms
Ci0JCQkgICAgIGRldl9uYW1lKCZjaGlwLT5kZXYpLCBjaGlwKSAhPSAwKSB7CisKKwlyYyA9IGRl
dm1fcmVxdWVzdF90aHJlYWRlZF9pcnEoY2hpcC0+ZGV2LnBhcmVudCwgaXJxLCBOVUxMLAorCQkJ
CSAgICAgICB0aXNfaW50X2hhbmRsZXIsIElSUUZfT05FU0hPVCB8IGZsYWdzLAorCQkJCSAgICAg
ICBkZXZfbmFtZSgmY2hpcC0+ZGV2KSwgY2hpcCk7CisJaWYgKHJjKSB7CiAJCWRldl9pbmZvKCZj
aGlwLT5kZXYsICJVbmFibGUgdG8gcmVxdWVzdCBpcnE6ICVkIGZvciBwcm9iZVxuIiwKIAkJCSBp
cnEpOwogCQlyZXR1cm4gLTE7Ci0tIAoyLjM2LjEKCg==
