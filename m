Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BA8631451
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Nov 2022 14:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiKTNco (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Nov 2022 08:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiKTNcb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Nov 2022 08:32:31 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBB529A;
        Sun, 20 Nov 2022 05:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668951126; bh=mo0aex3xZinBFgfr39bfyhV1oZv6iyWkgvj5WLXVwQo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bkpmWPdYYu4avftPo6rrf1aFmdEju2RTaGGoD+EgwTHfLs5d4OInUCAbLL4Hbin3E
         zfesiYSlDp9XnmruYuV+ArJ/W+s/DeCwowDA6JB2Ge4zJDGM9oAXclRBk3ZrRvDVPO
         wb22PxU7zn4TA6Xlp8LTheCZr5UztCUrRuxOOT3RPolVNLu9PUl2cUmzMEztc4h48K
         bdGsmEjufoPXvbVKlMcE8idw0IAnuDVgt5+EP4mUUv4xEcOBug9oYQpj3FXKSaVqqy
         051odHIUS06eYFseOw/IRS1Mv9psTUMlzUWt3VnVXaqdtWH1h546D2v5lQIElBLjP2
         mPTiTZ5evz6xg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.7.17]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVNAr-1oXCvx1UKV-00SLd2; Sun, 20
 Nov 2022 14:32:06 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v10 05/14] tpm, tpm_tis: Claim locality before writing interrupt registers
Date:   Sun, 20 Nov 2022 14:31:25 +0100
Message-Id: <20221120133134.28926-6-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221120133134.28926-1-LinoSanfilippo@gmx.de>
References: <20221120133134.28926-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:f6nQ5ZH2k0l7L/RDWWZNUoDawHxfUyilTX7+GGR9iDdgaGyKXhX
 GYfdpjigd0/KIKMw3uFyAriEijDYFktSMgH8HI76SL9WrnqDB9918GOUJNwl3YaKBRYyW5B
 V/zsZzfKCf5eAp6imLZkkW2F4RbplVfWw3yG0s9NdTq21Nj1Rwnq2D8dDCymUD9acCzt0B1
 U2w6f2RaOYBuCaUjgOdgQ==
UI-OutboundReport: notjunk:1;M01:P0:7PKF015SJ3k=;ZQ+6RO+dhA8NmXq+NwqOtgXnECp
 WdYnA0BoBnscfzWwRbebUA1EK34VYc7scgcqnoNG+aUfoWA3r8MJn229qHZfdEHGBmUCHbYmE
 Vqcr5KMsin9JBRByyDhiWwXl4yscRtjxYbyYJ7NUP9nDHHY9qX6KWBA0n0Dsw1naS2cfzt2sG
 awEZQ8xnNV1paExhEojGfl2ZpJOmnjajfWVR1gD3YxeT8YjFQMsH+SPFDhr9Lyo2O7QczUWLW
 OTDfYUJ6Gn116666pF52nUN4ZvEezhxT8RhawpK/BL7azZsV875GN9vCW9HLjosGyDfjYf/ql
 Q88hTleVP6cVnDmsaTlrxtgqiffyJP+BjgWO01CRoNHbP1k0/K4DLyyA8hYDcRQVrHX2lvbLM
 GqnLGbemneIObAAPkMvYEWYxTyQG0JUaXAJu8sdfB7fofO2n47wMtYCqJtr4BU408ahSRadeJ
 pi/KTaMSRwB7x8VX1K2pY67MKlM7Ygcr0AEcqES6ZYd3r1WfTxM1hhHd7qYuaZ0ii4NvW+HGF
 r3bghOL8p7DWbiMoNiASu6GuqKoVzyEVBmaPRjYQKGRdsaVwbcPzkUirAC0SGkf9a3en6z1jr
 X1qV/38cGUlUhWAXesWCxCv8OYoGalm2uR0HAfWgVRIXLOE9/B4qme5+yGv1FWxELqTZSTXSD
 i8n8m7qjR1VVfQJa7VWfLv9Oyz8CWOML6dNbeEcff78E8QA9QVTjCb32CTX3hJeLrMI6qLdqr
 OFrOaj4BPmI0s6tfMGB6eYPCqXV0JUsUWiN8axciD9xzBtUgYUJSE+qnm7j9StN9RhF0amd7K
 JLyJBAXE72cmfQUjHOZZ5WRPYDr0/VXSYmj77c4tGZFUUKFi1KVY4JJsCUUltTYfL2A56A3lD
 eqXfprcibZuj6lnnfN5a5eHo6M9KB2OXG+tLaNmkPvVhcLuXE8/5DSuWg2VpjnlXFaluPIsyl
 1gku5A==
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkluIHRwbV90
aXNfcHJvYmVfc2luZ2xlX2lycSgpIGludGVycnVwdCByZWdpc3RlcnMgVFBNX0lOVF9WRUNUT1Is
ClRQTV9JTlRfU1RBVFVTIGFuZCBUUE1fSU5UX0VOQUJMRSBhcmUgbW9kaWZpZWQgdG8gc2V0dXAg
dGhlIGludGVycnVwdHMuCkN1cnJlbnRseSB0aGVzZSBtb2RpZmljYXRpb25zIGFyZSBkb25lIHdp
dGhvdXQgaG9sZGluZyBhIGxvY2FsaXR5IHRodXMgdGhleQpoYXZlIG5vIGVmZmVjdC4gRml4IHRo
aXMgYnkgY2xhaW1pbmcgdGhlIChkZWZhdWx0KSBsb2NhbGl0eSBiZWZvcmUgdGhlCnJlZ2lzdGVy
cyBhcmUgd3JpdHRlbi4KClNpbmNlIG5vdyB0cG1fdGlzX2dlbl9pbnRlcnJ1cHQoKSBpcyBjYWxs
ZWQgd2l0aCB0aGUgbG9jYWxpdHkgYWxyZWFkeQpjbGFpbWVkIHJlbW92ZSBsb2NhbGl0eSByZXF1
ZXN0IGFuZCByZWxlYXNlIGZyb20gdGhpcyBmdW5jdGlvbi4KClNpZ25lZC1vZmYtYnk6IExpbm8g
U2FuZmlsaXBwbyA8bC5zYW5maWxpcHBvQGt1bmJ1cy5jb20+Ci0tLQogZHJpdmVycy9jaGFyL3Rw
bS90cG1fdGlzX2NvcmUuYyB8IDIxICsrKysrKysrKysrLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5n
ZWQsIDExIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29y
ZS5jCmluZGV4IDFlYWMxMjc5NTk0ZC4uNThhNTNlYzUzNGFhIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCisrKyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19j
b3JlLmMKQEAgLTczNCwxOCArNzM0LDExIEBAIHN0YXRpYyB2b2lkIHRwbV90aXNfZ2VuX2ludGVy
cnVwdChzdHJ1Y3QgdHBtX2NoaXAgKmNoaXApCiAJY29uc3QgY2hhciAqZGVzYyA9ICJhdHRlbXB0
aW5nIHRvIGdlbmVyYXRlIGFuIGludGVycnVwdCI7CiAJdTMyIGNhcDI7CiAJY2FwX3QgY2FwOwot
CWludCByZXQ7Ci0KLQlyZXQgPSByZXF1ZXN0X2xvY2FsaXR5KGNoaXAsIDApOwotCWlmIChyZXQg
PCAwKQotCQlyZXR1cm47CiAKIAlpZiAoY2hpcC0+ZmxhZ3MgJiBUUE1fQ0hJUF9GTEFHX1RQTTIp
CiAJCXRwbTJfZ2V0X3RwbV9wdChjaGlwLCAweDEwMCwgJmNhcDIsIGRlc2MpOwogCWVsc2UKIAkJ
dHBtMV9nZXRjYXAoY2hpcCwgVFBNX0NBUF9QUk9QX1RJU19USU1FT1VULCAmY2FwLCBkZXNjLCAw
KTsKLQotCXJlbGVhc2VfbG9jYWxpdHkoY2hpcCwgMCk7CiB9CiAKIC8qIFJlZ2lzdGVyIHRoZSBJ
UlEgYW5kIGlzc3VlIGEgY29tbWFuZCB0aGF0IHdpbGwgY2F1c2UgYW4gaW50ZXJydXB0LiBJZiBh
bgpAQCAtNzY4LDEwICs3NjEsMTYgQEAgc3RhdGljIGludCB0cG1fdGlzX3Byb2JlX2lycV9zaW5n
bGUoc3RydWN0IHRwbV9jaGlwICpjaGlwLCB1MzIgaW50bWFzaywKIAl9CiAJcHJpdi0+aXJxID0g
aXJxOwogCisJcmMgPSByZXF1ZXN0X2xvY2FsaXR5KGNoaXAsIDApOworCWlmIChyYyA8IDApCisJ
CXJldHVybiByYzsKKwogCXJjID0gdHBtX3Rpc19yZWFkOChwcml2LCBUUE1fSU5UX1ZFQ1RPUihw
cml2LT5sb2NhbGl0eSksCiAJCQkgICAmb3JpZ2luYWxfaW50X3ZlYyk7Ci0JaWYgKHJjIDwgMCkK
KwlpZiAocmMgPCAwKSB7CisJCXJlbGVhc2VfbG9jYWxpdHkoY2hpcCwgcHJpdi0+bG9jYWxpdHkp
OwogCQlyZXR1cm4gcmM7CisJfQogCiAJcmMgPSB0cG1fdGlzX3dyaXRlOChwcml2LCBUUE1fSU5U
X1ZFQ1RPUihwcml2LT5sb2NhbGl0eSksIGlycSk7CiAJaWYgKHJjIDwgMCkKQEAgLTgwNSwxMCAr
ODA0LDEyIEBAIHN0YXRpYyBpbnQgdHBtX3Rpc19wcm9iZV9pcnFfc2luZ2xlKHN0cnVjdCB0cG1f
Y2hpcCAqY2hpcCwgdTMyIGludG1hc2ssCiAJaWYgKCEoY2hpcC0+ZmxhZ3MgJiBUUE1fQ0hJUF9G
TEFHX0lSUSkpIHsKIAkJdHBtX3Rpc193cml0ZTgocHJpdiwgb3JpZ2luYWxfaW50X3ZlYywKIAkJ
CSAgICAgICBUUE1fSU5UX1ZFQ1RPUihwcml2LT5sb2NhbGl0eSkpOwotCQlyZXR1cm4gLTE7CisJ
CXJjID0gLTE7CiAJfQogCi0JcmV0dXJuIDA7CisJcmVsZWFzZV9sb2NhbGl0eShjaGlwLCBwcml2
LT5sb2NhbGl0eSk7CisKKwlyZXR1cm4gcmM7CiB9CiAKIC8qIFRyeSB0byBmaW5kIHRoZSBJUlEg
dGhlIFRQTSBpcyB1c2luZy4gVGhpcyBpcyBmb3IgbGVnYWN5IHg4NiBzeXN0ZW1zIHRoYXQKLS0g
CjIuMzYuMQoK
