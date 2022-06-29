Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA43560D33
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jun 2022 01:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbiF2X1o (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Jun 2022 19:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiF2X1j (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Jun 2022 19:27:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551CE26134;
        Wed, 29 Jun 2022 16:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656545246;
        bh=oL28C5/txX1WMfNKiS3Enygdd/Bx8aylw3RToNnKp7Q=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YhQ6qeJ4Hk9WVn3PU/12GzBnpCFji16amM0y8SZs8tYBY8e0gbs5LzjDiGnYn2fNf
         Aa7cfAiTblbUOTX5+0J64NpcB4wsZGLZ6gDleL5S3JFAJgbmBv9oXiHvbL/fdRwwMB
         pt6v0UyNB1j4UEn94E2ym8DquWYqfLnFlP8L01ac=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.23]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwfWa-1nioJI2Z1W-00y9Sn; Thu, 30
 Jun 2022 01:27:26 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, LinoSanfilippo@gmx.de, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: [PATCH v7 09/10] tpm, tpm_tis: Claim locality in interrupt handler
Date:   Thu, 30 Jun 2022 01:26:52 +0200
Message-Id: <20220629232653.1306735-10-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629232653.1306735-1-LinoSanfilippo@gmx.de>
References: <20220629232653.1306735-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:YXr1/sAgSWNaNDcJ76G9BWW6M81O9IOQ329c77KLTTYXl6+Z9PU
 xyS8aHZtq83P3yAaG650/kwLQbNMFHMkOTeDUrC/BI/QQ2MdEEB/Qe5B9z19fCY4kESCaGm
 iFTjmozsHTvTrX2rjZykkxDiVSVRdxMZNqwB2fOvYghE/l7Jxpokos0HNk2CqmHNtYcyP7F
 c1gzTmpR/wszUHus+aT7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JFmiFTMlH4M=:A17eICZZ5FFC9QA/8n/VBY
 GSPeBxsGl0QGIzINjDf4zcwnp2qbMslVKhcwuKetm/4dzwDdKqWyMgVRH4ZEkHwvyc8ITJdeP
 B7+ZyZ/Et54pBCIuNzTM6f4Jx1F6uLXiXRH+V3V0ryWyyHAtKEfgJ9TjW8c1dp8cBFeZ4YZGk
 D9+9NqB8D+O3f2vW/XyPYSmJBFEI1d5Q/LR6ogD4PnNLXj4WlXzkYHgTeVvzapmc/b3m+lwJ5
 cGKXPsuEW0yNxZeQv4NJhsfPGPnsFd9hCAJVqbMnJfyQPrMxSdEtL0GYXyklCVcAmB4hSMKmm
 FxI3h4IYoYPBiTL2WdTr6URr68X6zo7JE0z5Qa49VoBj3Pb+z5OGtS+/t2um4afEaVsChjGPZ
 KYHsW8FI3L16/BMZz+3Fj9Qvmt8NOFCzlXxpcyQabgeQYrZp/y24oNyFEEG2FoUH9xdtTI1In
 HIxUD8mkcDIjPru6qTuO/wT+5HySgGkPcxacT5klQJ5iJQmUZX16XCsFZZAVrZz018Fke0k/x
 RTKIs1P2C9D+Wfo2bHdOTE1Q//0IjEMSzuX83iR5ITzEvnJv9/jxn9uVZkN4fyt4Xn/3CXjwN
 cO480dYZEVw0lG6YJ6srAiZrDl6pwfW3mbOJUjWC8jufco9D7NJAWBbjn9nTxAx/VN40t4mda
 HuLGTVu4r+a+6ek8SYE2NMmSVSwHgOFSAG1mIHUEEVOo/BuoDHKgQpsd/xEZv1RF65+bYYw0e
 GQ9EC0MeRhVt2zlbEynprj1bZDarw3p5GOoSyhFFAQdB64LNRuLg0YFzJSZtJfxPq0XF1UPXd
 YthRuZeFLP69hkNa9nf+IMsBM4xJ75VQegDfwN5T0iPyNVbynQ0Y8Kzv6ktY0Kp8j2zg5T790
 I7ZLk97e6vaxh3Uww1oO9vQwEi0LkgpUbiCAN6ZAUZdFoeFV3WMLhaO1/AMjg1RaWFHSdrxJg
 +4VdUi08FcgNA18JAwvdXTtvrS7rjOtNYCmplthLNSsg7CEinDiYHVSPpxM6xrRP2z+kfOO08
 K9uT51RSOGb6yzk247vcpC8pt/UQKIphfkOCnc5k3tKNBAYWSi9OuU+wx4O0hCwFC25pz9Trv
 rzTOkabdeS4Ff5oZA/SjLPlPxLagMJndz4d9roqGtMObngM3ZGq3KLcUQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
cml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCmluZGV4IDgzYjMxYzI1ZTU1Yy4uMzA3YTdh
M2E1NWM2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCisrKyBi
L2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMKQEAgLTc2MSw3ICs3NjEsOSBAQCBzdGF0
aWMgaXJxcmV0dXJuX3QgdGlzX2ludF9oYW5kbGVyKGludCBkdW1teSwgdm9pZCAqZGV2X2lkKQog
CQl3YWtlX3VwX2ludGVycnVwdGlibGUoJnByaXYtPmludF9xdWV1ZSk7CiAKIAkvKiBDbGVhciBp
bnRlcnJ1cHRzIGhhbmRsZWQgd2l0aCBUUE1fRU9JICovCisJdHBtX3Rpc19yZXF1ZXN0X2xvY2Fs
aXR5KGNoaXAsIDApOwogCXJjID0gdHBtX3Rpc193cml0ZTMyKHByaXYsIFRQTV9JTlRfU1RBVFVT
KHByaXYtPmxvY2FsaXR5KSwgaW50ZXJydXB0KTsKKwl0cG1fdGlzX3JlbGVhc2VfbG9jYWxpdHko
Y2hpcCwgMCk7CiAJaWYgKHJjIDwgMCkKIAkJcmV0dXJuIElSUV9OT05FOwogCi0tIAoyLjI1LjEK
Cg==
