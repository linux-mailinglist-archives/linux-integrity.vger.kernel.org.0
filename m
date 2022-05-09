Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DA551F6FA
	for <lists+linux-integrity@lfdr.de>; Mon,  9 May 2022 10:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237328AbiEIIq3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 May 2022 04:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbiEIIOx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 May 2022 04:14:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA61515D31D;
        Mon,  9 May 2022 01:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652083627;
        bh=xOpvZ8BgGCUz6IDaFNm7AWkuquQ2TTNkNVxmdRJZRIo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=E2vrTJ8P0DxVREsgDXGdGC/uKskZK8QkaM951p2q8ytXOAa41Vx+vtL0AfSCZNxij
         a/+x9fmIn7/t4Vbdm1+8sy0vG5a+Iik2P1pts7SfpSf35Skolpu3MJlzhdKmc/rrlw
         drIwxuoi46gCXDqo8bJZlrT87J4ec3/6JtZOpYww=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.3.89]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbAgq-1oKpCF03EO-00bdkT; Mon, 09
 May 2022 10:07:07 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v4 4/6] tpm, tpm_tis: avoid CPU cache incoherency in irq test
Date:   Mon,  9 May 2022 10:05:57 +0200
Message-Id: <20220509080559.4381-5-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220509080559.4381-1-LinoSanfilippo@gmx.de>
References: <20220509080559.4381-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:4t6mWcZUnR8Zow/cWZDz9hnDGH0BwWHhkduqhaFeeoJCNlegYyq
 WMw8AKELkLhuUBk2KStJnG2/LTrmkD5o41pRVjgn1BE+Ib/UQfnUw9rR76RF1mkrtYJvt63
 J46ePcf+TzVHpITclAXsg3LvC4FGnJOLPeQbr6gMk0E9VDgPW+n3p3vPifPHjvvu3gktjQU
 CPlDj2S0GSPL/Y+hMKgXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jQrDmr+Dqx4=:XOm0JdT4QTHWTtXnZnVPIZ
 PvNmeB3ZqMrZ4bMl/ARrVO5VFxPCERk+N6xVIJluiBgC9g4sSd6qvHtPhsFCyYH4ns27A6Jm0
 93rcrP24l++IBY7pncbYAN8Z7DI4iRzOcwt3ZFDQ2lpOcx7Y5C+OxQeIHgHTm0+2QC2Q5Ic/P
 uTeIMmA5p6E4qwSasGjN3dYe9+eNBl7U/Fir8MGvh4XvasuNBqSdhD65aiRRcAKw70J+85aWM
 CdiPGBbovn0MMwO3ixfYX/bTdBO9lfHZdiig/dawKFoXG66CDoTlNCMeK/mL6Q+PEVfdSwtoK
 FhrZeLIbMdioCJbZZIZfS8lwEvzgufMa6ftys0i8WDYdBYGq4MAa+vtn5IqsCrN1Ct293edcU
 fJwmM1p/FYs4PwkgPb+C43EcAgcCXcZdh/rmcMQepLA/cwgYQjEZ8HMKCWm6BnZ13k9fGPOCd
 cu7bhXD0VAvro0kqeioiaQ+EJlDhETcf5FEevEb+V0cKVemGh5G8Yq6VlFExCpzD/JJVh0KSQ
 oYSX0QOIkRWjZm8W2ux4WD/MZfT18lNVhwNdsB76DKO2UV5PLRVuUKJ7+X5P1VYIsNL0xypWh
 zWmhIUyM69UrmAZckLqqtQnf/2oztSnI3FuGDZHkDBunOlrRz/BcR63Xgw4NmTCwT6w2P/Dq0
 a0t92kMkckjzjMwF0dxYVk2C2cDNBf7pnISmX+Qppmy3DKJ07ReJha5oYOU1iBrkHmmi70dBF
 NKUtmvJ4+enKrXHQO+GwoUGRGOCaX9ZUKYnErIBptkwumtEqxUfvDBKiTRznHgN+eGmB7amKr
 NsnJCNfSy6EZEeeK3qhPy/M9JVH8CRDoncueMLU+ibPM76VN2mJnNCJiXUBcUb6dEbQRr03es
 FlLnTyDPFtbSiOQg3I0f2m5AymsqzDN2P/2lCHsdhQQyV+67+N6lRmT+kt1lkydKPrfjQCqgs
 oQuZ3lDi7iVYbEX7RVHTwbDDAY2HqdwmTMf1pH/ngxMHOw3Kh2KfwowtTHebTl2iK+61LgLIi
 MRyLB67p4ZszC6lls1FFxt6MRCu2e/rBbYjh441/ER7CeHSyR65zViVwf1HhwLYU6HOjbizbT
 z/FU8od+I6f6vQ=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KClRoZSBpbnRl
cnJ1cHQgaGFuZGxlciB0aGF0IHNldHMgaXJxX3Rlc3RlZCB0byBpbmRpY2F0ZSB0aGF0IGludGVy
cnVwdHMgYXJlCndvcmtpbmcgbWF5IHJ1biBvbiBhbm90aGVyIENQVSB0aGFuIHRoZSB0aHJlYWQg
dGhhdCBjaGVja3MgdGhpcyB2YXJpYWJsZSBpbgp0bXBfdGlzX3NlbmQoKS4KClNpbmNlIG5vIHN5
bmNocm9uaXphdGlvbiBpcyB1c2VkIHRvIGFjY2VzcyBpcnFfdGVzdGVkLCB0aGVyZSBpcyBubwpn
dWFyYW50ZWUgZm9yIGNhY2hlIGNvaGVyZW5jeSBiZXR3ZWVuIHRoZSBDUFVzLCBzbyB0aGF0IHRo
ZSB2YWx1ZSBzZXQgYnkKdGhlIGludGVycnVwdCBoYW5kbGVyIG1pZ2h0IG5vdCBiZSB2aXNpYmxl
IHRvIHRoZSB0ZXN0aW5nIHRocmVhZC4KCkF2b2lkIHRoaXMgaXNzdWUgYnkgdXNpbmcgYSBiaXRm
aWVsZCBpbnN0ZWFkIG9mIGEgYm9vbGVhbiB2YXJpYWJsZSBhbmQgYnkKYWNjZXNzaW5nIHRoaXMg
ZmllbGQgd2l0aCBiaXQgbWFuaXB1bGF0aW5nIGZ1bmN0aW9ucyB0aGF0IGd1YXJhbnRlZSBjYWNo
ZQpjb2hlcmVuY3kuCgpTaWduZWQtb2ZmLWJ5OiBMaW5vIFNhbmZpbGlwcG8gPGwuc2FuZmlsaXBw
b0BrdW5idXMuY29tPgotLS0KIGRyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMgfCAxMyAr
KysrKysrLS0tLS0tCiBkcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5oIHwgIDYgKysrKyst
CiAyIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYyBiL2RyaXZlcnMvY2hhci90
cG0vdHBtX3Rpc19jb3JlLmMKaW5kZXggNGYzYjgyYzNmMjA1Li5iZGZkZTFjZDcxZmUgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMKKysrIGIvZHJpdmVycy9jaGFy
L3RwbS90cG1fdGlzX2NvcmUuYwpAQCAtNDcwLDcgKzQ3MCw4IEBAIHN0YXRpYyBpbnQgdHBtX3Rp
c19zZW5kKHN0cnVjdCB0cG1fY2hpcCAqY2hpcCwgdTggKmJ1Ziwgc2l6ZV90IGxlbikKIAlpbnQg
cmMsIGlycTsKIAlzdHJ1Y3QgdHBtX3Rpc19kYXRhICpwcml2ID0gZGV2X2dldF9kcnZkYXRhKCZj
aGlwLT5kZXYpOwogCi0JaWYgKCEoY2hpcC0+ZmxhZ3MgJiBUUE1fQ0hJUF9GTEFHX0lSUSkgfHwg
cHJpdi0+aXJxX3Rlc3RlZCkKKwlpZiAoIShjaGlwLT5mbGFncyAmIFRQTV9DSElQX0ZMQUdfSVJR
KSB8fAorCSAgICAgdGVzdF9iaXQoVFBNX1RJU19JUlFURVNUX09LLCAmcHJpdi0+aXJxdGVzdF9m
bGFncykpCiAJCXJldHVybiB0cG1fdGlzX3NlbmRfbWFpbihjaGlwLCBidWYsIGxlbik7CiAKIAkv
KiBWZXJpZnkgcmVjZWlwdCBvZiB0aGUgZXhwZWN0ZWQgSVJRICovCkBAIC00ODAsMTEgKzQ4MSwx
MSBAQCBzdGF0aWMgaW50IHRwbV90aXNfc2VuZChzdHJ1Y3QgdHBtX2NoaXAgKmNoaXAsIHU4ICpi
dWYsIHNpemVfdCBsZW4pCiAJcmMgPSB0cG1fdGlzX3NlbmRfbWFpbihjaGlwLCBidWYsIGxlbik7
CiAJcHJpdi0+aXJxID0gaXJxOwogCWNoaXAtPmZsYWdzIHw9IFRQTV9DSElQX0ZMQUdfSVJROwot
CWlmICghcHJpdi0+aXJxX3Rlc3RlZCkKKwlpZiAoIXRlc3RfYml0KFRQTV9USVNfSVJRVEVTVF9P
SywgJnByaXYtPmlycXRlc3RfZmxhZ3MpKQogCQl0cG1fbXNsZWVwKDEpOwotCWlmICghcHJpdi0+
aXJxX3Rlc3RlZCkKKwlpZiAoIXRlc3RfYml0KFRQTV9USVNfSVJRVEVTVF9PSywgJnByaXYtPmly
cXRlc3RfZmxhZ3MpKQogCQlkaXNhYmxlX2ludGVycnVwdHMoY2hpcCk7Ci0JcHJpdi0+aXJxX3Rl
c3RlZCA9IHRydWU7CisJc2V0X2JpdChUUE1fVElTX0lSUVRFU1RfT0ssICZwcml2LT5pcnF0ZXN0
X2ZsYWdzKTsKIAlyZXR1cm4gcmM7CiB9CiAKQEAgLTY4OSw3ICs2OTAsNyBAQCBzdGF0aWMgaXJx
cmV0dXJuX3QgdGlzX2ludF9oYW5kbGVyKGludCBkdW1teSwgdm9pZCAqZGV2X2lkKQogCWlmIChp
bnRlcnJ1cHQgPT0gMCkKIAkJcmV0dXJuIElSUV9OT05FOwogCi0JcHJpdi0+aXJxX3Rlc3RlZCA9
IHRydWU7CisJc2V0X2JpdChUUE1fVElTX0lSUVRFU1RfT0ssICZwcml2LT5pcnF0ZXN0X2ZsYWdz
KTsKIAlpZiAoaW50ZXJydXB0ICYgVFBNX0lOVEZfREFUQV9BVkFJTF9JTlQpCiAJCXdha2VfdXBf
aW50ZXJydXB0aWJsZSgmcHJpdi0+cmVhZF9xdWV1ZSk7CiAJaWYgKGludGVycnVwdCAmIFRQTV9J
TlRGX0xPQ0FMSVRZX0NIQU5HRV9JTlQpCkBAIC03ODAsNyArNzgxLDcgQEAgc3RhdGljIGludCB0
cG1fdGlzX3Byb2JlX2lycV9zaW5nbGUoc3RydWN0IHRwbV9jaGlwICpjaGlwLCB1MzIgaW50bWFz
aywKIAlpZiAocmMgPCAwKQogCQlyZXR1cm4gcmM7CiAKLQlwcml2LT5pcnFfdGVzdGVkID0gZmFs
c2U7CisJY2xlYXJfYml0KFRQTV9USVNfSVJRVEVTVF9PSywgJnByaXYtPmlycXRlc3RfZmxhZ3Mp
OwogCWNoaXAtPmZsYWdzIHw9IFRQTV9DSElQX0ZMQUdfSVJROwogCiAJLyogR2VuZXJhdGUgYW4g
aW50ZXJydXB0IGJ5IGhhdmluZyB0aGUgY29yZSBjYWxsIHRocm91Z2ggdG8KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmggYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90
aXNfY29yZS5oCmluZGV4IDQzYjcyNGU1NTE5Mi4uYzg5NzJlYThlMTNlIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5oCisrKyBiL2RyaXZlcnMvY2hhci90cG0vdHBt
X3Rpc19jb3JlLmgKQEAgLTg5LDExICs4OSwxNSBAQCBlbnVtIHRwbV90aXNfZmxhZ3MgewogCVRQ
TV9USVNfVVNFX1RIUkVBREVEX0lSUQk9IEJJVCgyKSwKIH07CiAKK2VudW0gdHBtX3Rpc19pcnF0
ZXN0X2ZsYWdzIHsKKwlUUE1fVElTX0lSUVRFU1RfT0sJCT0gQklUKDApLAorfTsKKwogc3RydWN0
IHRwbV90aXNfZGF0YSB7CiAJdTE2IG1hbnVmYWN0dXJlcl9pZDsKIAlpbnQgbG9jYWxpdHk7CiAJ
aW50IGlycTsKLQlib29sIGlycV90ZXN0ZWQ7CisJdW5zaWduZWQgbG9uZyBpcnF0ZXN0X2ZsYWdz
OwogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CiAJdm9pZCBfX2lvbWVtICppbGJfYmFzZV9hZGRyOwog
CXUxNiBjbGtydW5fZW5hYmxlZDsKLS0gCjIuMzYuMAoK
