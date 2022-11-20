Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFBA631453
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Nov 2022 14:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiKTNcp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Nov 2022 08:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiKTNci (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Nov 2022 08:32:38 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1CF326;
        Sun, 20 Nov 2022 05:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668951129; bh=b2p9orljkPQAtfm2cx8Ohv8A3ug+yirHYm4KhuxDbQg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=cLJ3ZWl4KL9RDxAMDQazxg/pLd+UAJ34UD2jdHsrA8zzTo0oZuodjjbrCIaz6ztdu
         9cQ11nbp1mfazF3yTPaPX9QZ4cZ3GkCm3iqjKhSud4umBw4KGR98KnmC5X3fbmvoot
         6pgPZ2vcyLUDUbclQLgzDfdyBmt6AahXVjwkgd7XWXvhxbwN/J535tAo3mRPw7qS76
         OL75adGNRqhq8oOOysn3HkdJxylcl5o5lIyTJldqnZWL1SbpWmWRtVApJvWWwGK/hz
         mAaZUx3xI/K+0u1xiKGPtjNb9Ho8oQXYDJ435hDGrPG0sqfEdj1accCwPnm38sOizy
         xV7mWRLrqQRZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.7.17]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8QS2-1osMht1t56-004VDT; Sun, 20
 Nov 2022 14:32:09 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v10 14/14] tpm, tpm_tis: Enable interrupt test
Date:   Sun, 20 Nov 2022 14:31:34 +0100
Message-Id: <20221120133134.28926-15-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221120133134.28926-1-LinoSanfilippo@gmx.de>
References: <20221120133134.28926-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:BKMRYOEhyfnkSjTu8QNQmyWBrZ0shgweC98K2S5I+em4v1FZ1vw
 xJm/V0KgsjeT2pkq7QRrr2FLo/CfBqDLcYP60wIBRTvSLhV68R/Ams+kdnFxcYt8jb2L3ou
 pZX5r3uJjv09RWyvQxM4GR0ioUKekCkRPUT1LtkvJkbc4AY47ouqSRekmuK3Rmai8TxViw/
 ynwEGbIg2JzXb0ffAcbEw==
UI-OutboundReport: notjunk:1;M01:P0:mrSM3TH/Aok=;Dkll088hNQPY5V9rJi8UGOJXlhK
 /cloz7pNK06KOjCzCC7ZWEhOByE0aQhQh/yKhebkyyVJzoIOi7ySiRWEn7/k/WVebebusWZW5
 igSfzp1b/aMLUvcKxZ0zBROBN7QemmtzaJkYVUUVIYx1OAXtndVQOj7LD47Qy7MFIA8yTcdcu
 qUnFLg3CTqrNLkNylDVcxLqPmjv0m4PhCCFuUBsZnkPHnNrn2TJx9mgPdiV2hU1Nf/Tnm+HMV
 gvyIL4YVTruDZ6U6OWhwyl6YTlpJ1XImMPm0F9LRxTegVJmYB18oDaf+3jtySuBYVA7f+6a+g
 RX33Z+uitevMgTTkiEeXgMk2l6AAlLmz/jVusjuAheRxqy7PgDHSVepwAPTGNXvMLSHnwS/aC
 6MJr5oUJdDfeHFyUgYhpQkPf3HHdCds6xObHFPFqFpd2JP8mSSXoo7zfH72QfwjJ2Alyss9wY
 VQZy9Le8z307WUKTx8nRijLcRWh0a8i5DhlO4LxJ3vYDkUM7g/kkduiowOiFTJnFCDiR2C2Ei
 vRzVFdQgx8HlUQWES9VC/LfFuIotKfPMYFuHRl/8YSF0lfDyvMgGchuTLTDQ6W8VRSGivjsa8
 rBbP2n0JLxVleUFmJJV1qTqWw+ysuXQa992+eD9mJZuuEY0JtOQrgHurJhlBj0kvGLKfxG5Zh
 Dpa6StViIIfspolhEyzYsSG72zgPgrZFLxlgWDR1D11BpSgGWW7iwYBV5Jkx0QzjUn30aVTsJ
 OhyCQYN3bncQigf2207ca5wL+fT8yREiW6y7ZroM4ZA40IoaVAzwQgKWT+JmHioetZg6ZmKJT
 xhXDqh+0DMn6eG1DEG+ch7yUVh8j0zxQKgMTufJBCZNFIIz8T6h81SA3vDnE6JWIQTfwj4hua
 uypPw1ZsctNbDOWQtnjsxDyRpMr4Ngk6/4UYYqNKEKsEi5/+SeMOetD5l2aEExv+qyVhll3ZZ
 MPrTOg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
cG9Aa3VuYnVzLmNvbT4KVGVzdGVkLWJ5OiBNaWNoYWVsIE5pZXfDtmhuZXIgPGxpbnV4QG1uaWV3
b2VobmVyLmRlPgpSZXZpZXdlZC1ieTogSmFya2tvIFNha2tpbmVuIDxqYXJra29Aa2VybmVsLm9y
Zz4KLS0tCiBkcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jIHwgMTAgKysrKysrKystLQog
MSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jIGIvZHJpdmVycy9jaGFyL3RwbS90
cG1fdGlzX2NvcmUuYwppbmRleCBiOTdjYjMyNWNjYjcuLjYwMmNhNGJiOGUyZiAxMDA2NDQKLS0t
IGEvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYworKysgYi9kcml2ZXJzL2NoYXIvdHBt
L3RwbV90aXNfY29yZS5jCkBAIC03ODcsMTEgKzc4NywxNyBAQCBzdGF0aWMgdm9pZCB0cG1fdGlz
X2dlbl9pbnRlcnJ1cHQoc3RydWN0IHRwbV9jaGlwICpjaGlwKQogCWNvbnN0IGNoYXIgKmRlc2Mg
PSAiYXR0ZW1wdGluZyB0byBnZW5lcmF0ZSBhbiBpbnRlcnJ1cHQiOwogCXUzMiBjYXAyOwogCWNh
cF90IGNhcDsKKwlpbnQgcmV0OworCisJY2hpcC0+ZmxhZ3MgfD0gVFBNX0NISVBfRkxBR19JUlE7
CiAKIAlpZiAoY2hpcC0+ZmxhZ3MgJiBUUE1fQ0hJUF9GTEFHX1RQTTIpCi0JCXRwbTJfZ2V0X3Rw
bV9wdChjaGlwLCAweDEwMCwgJmNhcDIsIGRlc2MpOworCQlyZXQgPSB0cG0yX2dldF90cG1fcHQo
Y2hpcCwgMHgxMDAsICZjYXAyLCBkZXNjKTsKIAllbHNlCi0JCXRwbTFfZ2V0Y2FwKGNoaXAsIFRQ
TV9DQVBfUFJPUF9USVNfVElNRU9VVCwgJmNhcCwgZGVzYywgMCk7CisJCXJldCA9IHRwbTFfZ2V0
Y2FwKGNoaXAsIFRQTV9DQVBfUFJPUF9USVNfVElNRU9VVCwgJmNhcCwgZGVzYywgMCk7CisKKwlp
ZiAocmV0KQorCQljaGlwLT5mbGFncyAmPSB+VFBNX0NISVBfRkxBR19JUlE7CiB9CiAKIC8qIFJl
Z2lzdGVyIHRoZSBJUlEgYW5kIGlzc3VlIGEgY29tbWFuZCB0aGF0IHdpbGwgY2F1c2UgYW4gaW50
ZXJydXB0LiBJZiBhbgotLSAKMi4zNi4xCgo=
