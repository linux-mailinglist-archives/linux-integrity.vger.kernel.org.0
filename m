Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0388D553394
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Jun 2022 15:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351445AbiFUNeW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Jun 2022 09:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351573AbiFUNbC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jun 2022 09:31:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70A72AE1E;
        Tue, 21 Jun 2022 06:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655817939;
        bh=6NOAMXdCUByyszfLupmrTS363FnVyz0cu7VA/+0ZRpg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=We4utsoGckPb7P63tspOFDUOD+/zLTgLvZg9QhtYw8+7TshQCwQZo2L6w+91ky5eV
         daVcP4lSCdWcRjfOvC98uMchCvp76tnTwziO81Jy3ll5jp7HCWwQyRtXijWvIWB965
         d1PuJBwxEIt5633EvI1kAa4wJHR9EHSrFMZGKIAM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.2.162]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mof5H-1nJ5re2E2L-00p6Z3; Tue, 21
 Jun 2022 15:25:39 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, LinoSanfilippo@gmx.de, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: [PATCH v6 9/9] tpm, tpm_tis: Enable interrupt test
Date:   Tue, 21 Jun 2022 15:24:47 +0200
Message-Id: <20220621132447.16281-10-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621132447.16281-1-LinoSanfilippo@gmx.de>
References: <20220621132447.16281-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:xSB16AR/mNo0Fvb7nCgg54P4T5PTXXJ6u1/cxTo833nbHj1CGwF
 85DnFGzQJq2atuTTl2iqce6c8e1HOqzMIO+EymhOc6g/r0MKH7EArUfMfOmJfM8o1mFCEMr
 VqNOdl9gVUQienIscPHd1P3lYV3ePa/vcMNOROFa5cSEy4WzXYNfYounXqhnixli/nTi9W+
 ohvFU5CmjZNRWRQ19eI1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OkfFheutD+Q=:vbgJUfdRzcOzV95IvgvhwB
 CF4BNMQGYWVsXIVn55d38NNBBB0qUsZyHgcwI0xX3rWg2miFY85FLWyASWx3oCJpRt6eHQQNS
 7FGs+iNFn3/E71ES5tG5PZJU/VglbLq2edlmrpJrCU8mK3Hf4PIx+JwVnnT9eP62OxM99Kvw1
 RbasWoVbSUlJMzUqqaC5Hnitm3WUSj0dyAgqQGQCO9NtdsGv1loHJrKDOf3UN8ZqxQwtCEXZ6
 O48lBFi9ZtmTzGKG7sy4ozLC88y1YuVcIV3FfrkmQFYuzaTSgTYb6+jrei7vzef73h7sVJF/E
 UBavHCh01ORKG4CBreAhvvtGktQPo1Iy67F1ov2ckJAG21RX5EMrZshM8rEwLF9If4+p5VMZA
 TULeP2oXiuo168M3adh1wpcsUf/zrQZqCYFM38/W18Ey9wRTwJYvCgYvz3ZY/nRZhCua6XnGL
 RpgDVZQr4eh1b++OZAKR3DNnx5EjiOXZ0345rUC15V4kvddpnDPMELp110714ZAUAZAhJKOk3
 mOLCugXLGiFpAP4mJv4dNFPhMABxdEgqmemS6XVM6Lw/b+b0L4bEYuVFUd7QDDHTZwMSp1+QJ
 /TNpy06CpQC+syTZCQebOlDiwqQ8jnGiCWXGkCDuoU1T/PnsyqUTPd0EXgSk92D5pID2dNnw5
 4jVceD2HNX5xvPr8fWL4zIs+3w7+Ra5PAwNtW4pKz+AAca9B3z/64T0I9nLvBJn+CyNiPHHK0
 XVMa9TurgYuWMbhjuqq42lRdjS7ObkOQmhT/0uig+i1dRWc+EvBAD8F6f4zA9YDrf/WQBaWlC
 NdkW7FApsx0WJr6t5HJ6KBKGQsJBSB8kqIsvAfH8kYkCIOFoQ5YVwHOoMViuaIaNmTgK3xr1X
 SowelutJkRpKenaNvA83bmwGy5V7cdmvQV2dtturNeEo+nhDPlhieEVEne/fVPtXsp1Pa7cY+
 JFKwA73133eJzO640cTlKiazx76MX5ZmSt3j0YA5aBCVua1pWntnfjkcAUSDUmWPN8EL1aeyH
 tiMAthMwfRHSxJsANB/xPaAJk8GY50/9lciqCWpwFo1slLTmUsR+92y+6D0ByClXRb1gzR2hS
 Khe0Lqg5apwUdTw3tAkoid/zZwVHqkz+0wUgOR3tNuVs2eU391nqQm3pQ==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KClRoZSB0ZXN0
IGZvciBpbnRlcnJ1cHRzIGluIHRwbV90aXNfc2VuZCgpIGlzIHNraXBwZWQgaWYgdGhlIGZsYWcK
VFBNX0NISVBfRkxBR19JUlEgaXMgbm90IHNldC4gU2luY2UgdGhlIGN1cnJlbnQgY29kZSBuZXZl
ciBzZXRzIHRoZSBmbGFnCmluaXRpYWxseSB0aGUgdGVzdCBpcyBuZXZlciBleGVjdXRlZC4KCkZp
eCB0aGlzIGJ5IHNldHRpbmcgdGhlIGZsYWcgaW4gdHBtX3Rpc19nZW5faW50ZXJydXB0KCkgcmln
aHQgYWZ0ZXIKaW50ZXJydXB0cyBoYXZlIGJlZW4gZW5hYmxlZCBhbmQgYmVmb3JlIHRoZSB0ZXN0
IGlzIGV4ZWN1dGVkLgoKU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlw
cG9Aa3VuYnVzLmNvbT4KLS0tCiBkcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jIHwgNSAr
KysrKwogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29y
ZS5jCmluZGV4IDFmNzY2M2FjMWZjNC4uNjUwYzIwMmQyZjUwIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCisrKyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19j
b3JlLmMKQEAgLTc3NSwxMSArNzc1LDE2IEBAIHN0YXRpYyBpbnQgdHBtX3Rpc19nZW5faW50ZXJy
dXB0KHN0cnVjdCB0cG1fY2hpcCAqY2hpcCkKIAlpZiAocmV0IDwgMCkKIAkJcmV0dXJuIHJldDsK
IAorCWNoaXAtPmZsYWdzIHw9IFRQTV9DSElQX0ZMQUdfSVJROworCiAJaWYgKGNoaXAtPmZsYWdz
ICYgVFBNX0NISVBfRkxBR19UUE0yKQogCQlyZXQgPSB0cG0yX2dldF90cG1fcHQoY2hpcCwgMHgx
MDAsICZjYXAyLCBkZXNjKTsKIAllbHNlCiAJCXJldCA9IHRwbTFfZ2V0Y2FwKGNoaXAsIFRQTV9D
QVBfUFJPUF9USVNfVElNRU9VVCwgJmNhcCwgZGVzYywgMCk7CiAKKwlpZiAocmV0KQorCQljaGlw
LT5mbGFncyAmPSB+VFBNX0NISVBfRkxBR19JUlE7CisKIAl0cG1fdGlzX3JlbGVhc2VfbG9jYWxp
dHkoY2hpcCwgMCk7CiAKIAlyZXR1cm4gcmV0OwotLSAKMi4zNi4xCgo=
