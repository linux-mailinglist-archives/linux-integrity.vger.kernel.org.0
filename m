Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0015955339B
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Jun 2022 15:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbiFUNeS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Jun 2022 09:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351719AbiFUNbC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jun 2022 09:31:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897822AE1D;
        Tue, 21 Jun 2022 06:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655817937;
        bh=DRphZ/l39/9GYPej7UvI8/O4Gz2dDgvZS7UWsf3aqIE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XsfFdQGesBGo+d6jFBt7KwUZyTkzPntZJYZaf75N5WdwuZW474pAeYAuMFtGR1Vh0
         j9irPZA4O5C6NvLxP+VSYGJev/m+N/SelnMmIns9CCCHjMysqXFFpqoYxl7nV3LQkv
         I1/3z8DWt6oUZ2t0HRzLVvLSx4BcwllkXT0HyyTE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.2.162]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXp9i-1oBKRh0p6y-00Y7wW; Tue, 21
 Jun 2022 15:25:37 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, LinoSanfilippo@gmx.de, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: [PATCH v6 3/9] tpm, tpm_tis: Disable interrupts if tpm_tis_probe_irq() failed
Date:   Tue, 21 Jun 2022 15:24:41 +0200
Message-Id: <20220621132447.16281-4-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621132447.16281-1-LinoSanfilippo@gmx.de>
References: <20220621132447.16281-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:9JtmR9KMEqWCGdhBCxpCM1SHKiKG1NG9K14z71jAmxvmXo5bQfg
 +tNzkMCHEl8sWEscHLU1ZFgKfu9EIrIpopTa1Tf29SK0KVSi1m4J+WVZ1+MOWQwlEyonhfu
 M1f0J9+HBuZDaBCBadHeFXh5pfZDT9zwTrI8akaplIBlF8btvbBbiYLEzO+8w2NiSIP4qjk
 opGtv1y09cwHytfpSsVZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QH/j+wn9piI=:V69SuUQHmNngJbKTt60HnZ
 yVkHYgg5fmaOaCILpalYehML/iHQooumiaBIn4dttRRqSg+9tZ9955FMX26Jf/S+Wk77PZCAq
 fi0L8LU3YeSIsqNBE2Dxq6kihAtJx+KUPVMihtF/bKlt+meY9DC8q1DeeqRS3spPuyQ+P2Ii0
 cdNhPXNWcj8y87idsaWBTS80wKpRVOCW9dpSP3mGXfKODw27eUwslCNc9hg5j5RHG6qC8MjQs
 AkEx117fOHvQLS3Y5tRQN8NSDwsr+fG+dv464+MSoQisFLuiTVIIjFBaj38a8j8QaEcfaPPOx
 EN1n/9gr3uHiQNndosSw0KfQUDeUMMwuxd4n3x7jl/P1Y2a/78VnOpkz/loHcjrDFUiEH/mKU
 HuCLr7KIUuLI5yY1040orbBSqFzkSXloap1Nt4cHeSzVIcLnfemliOnzc6AnT6YwYTGmn+rPV
 GizeVzBFOYAHFKtW7Aw//R6j41NRUDLL3nrQcB1KBevqWJ5+Ookq8hOC4WXGxSdGm4e8SdODT
 OGrLAnFzQIEFxVUC8X5EffoPsMjs0UGdMMZD88wsMzcbcIclElcqekOUaC1P1OXM+dhYl8sBA
 chp0egkVnImTuTxdop9J8Sl3RQOR37qcYk2VL7WEiNe4aiG7sGJxB/D/ukd2loLVVtebgaNhc
 N1ZR478vdTnigULh4B9oEXISCZJ2f6sRrSTRBct8mPEQMqS0KOGpDXW3Py2ssJ11/d9zGlGkE
 ENCre6P1AxK/pIu6G94s2qs/wLOkiOI39aWtovRmKcZNSNXpI9Ea/JAbY7s/SSbkXMUdJwdSO
 4tDt8eMgY9IGE27AftZu40VCmVS41J4RrfvDu5ncf2SIelKvciswNiw2mbVWuXpmt1aTe8jeK
 /8fcT9p0SOn6PxuMnJ/6levV4ztKgJ7X/ZPqTb3uBNljkngZXNRvtowUcd4tN4SS7oQnH8aur
 WbNsmwfx2jv42HX8EAvdBgxyDQxVqayyTGm4HRaWEvi+9IuBf6eYxIP3kFvt/IikLBg7Mk7PA
 GSakP8NWbihfB9e0xyNxf0UyMvTCkGi53aqYkmUAGrR9NYyNKn0VFhXw+zjzvcjCxFS17OPmy
 0LIizjyBx3Qejgx5SHhehptSNmdp7mezbkGQatGFMqe8p/7weIYIsHuXQ==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkJvdGggZnVu
Y3Rpb25zIHRwbV90aXNfcHJvYmVfaXJxX3NpbmdsZSgpIGFuZCB0cG1fdGlzX3Byb2JlX2lycSgp
IG1heSBzZXR1cAp0aGUgaW50ZXJydXB0cyBhbmQgdGhlbiByZXR1cm4gd2l0aCBhbiBlcnJvci4g
VGhpcyBjYXNlIGlzIGluZGljYXRlZCBieSBhCm1pc3NpbmcgVFBNX0NISVBfRkxBR19JUlEgZmxh
ZyBpbiBjaGlwLT5mbGFncy4KQ3VycmVudGx5IHRoZSBpbnRlcnJ1cHQgc2V0dXAgaXMgb25seSB1
bmRvbmUgaWYgdHBtX3Rpc19wcm9iZV9pcnFfc2luZ2xlKCkKZmFpbHMuIFVuZG8gdGhlIHNldHVw
IGFsc28gaWYgdHBtX3Rpc19wcm9iZV9pcnEoKSBmYWlscy4KClNpZ25lZC1vZmYtYnk6IExpbm8g
U2FuZmlsaXBwbyA8bC5zYW5maWxpcHBvQGt1bmJ1cy5jb20+ClJldmlld2VkLWJ5OiBKYXJra28g
U2Fra2luZW4gPGphcmtrb0BrZXJuZWwub3JnPgotLS0KIGRyaXZlcnMvY2hhci90cG0vdHBtX3Rp
c19jb3JlLmMgfCAyMiArKysrKysrKysrKy0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTEg
aW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFy
L3RwbS90cG1fdGlzX2NvcmUuYyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMKaW5k
ZXggMGU2OGU0NTAyYTU2Li5kMzJlOTNjODZmNDggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY2hhci90
cG0vdHBtX3Rpc19jb3JlLmMKKysrIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwpA
QCAtMTA3NywyMSArMTA3NywyMSBAQCBpbnQgdHBtX3Rpc19jb3JlX2luaXQoc3RydWN0IGRldmlj
ZSAqZGV2LCBzdHJ1Y3QgdHBtX3Rpc19kYXRhICpwcml2LCBpbnQgaXJxLAogCQkJZ290byBvdXRf
ZXJyOwogCQl9CiAKLQkJaWYgKGlycSkgeworCQlpZiAoaXJxKQogCQkJdHBtX3Rpc19wcm9iZV9p
cnFfc2luZ2xlKGNoaXAsIGludG1hc2ssIElSUUZfU0hBUkVELAogCQkJCQkJIGlycSk7Ci0JCQlp
ZiAoIShjaGlwLT5mbGFncyAmIFRQTV9DSElQX0ZMQUdfSVJRKSkgewotCQkJCWRldl9lcnIoJmNo
aXAtPmRldiwgRldfQlVHCisJCWVsc2UKKwkJCXRwbV90aXNfcHJvYmVfaXJxKGNoaXAsIGludG1h
c2spOworCisJCWlmICghKGNoaXAtPmZsYWdzICYgVFBNX0NISVBfRkxBR19JUlEpKSB7CisJCQlk
ZXZfZXJyKCZjaGlwLT5kZXYsIEZXX0JVRwogCQkJCQkiVFBNIGludGVycnVwdCBub3Qgd29ya2lu
ZywgcG9sbGluZyBpbnN0ZWFkXG4iKTsKIAotCQkJCXJjID0gcmVxdWVzdF9sb2NhbGl0eShjaGlw
LCAwKTsKLQkJCQlpZiAocmMgPCAwKQotCQkJCQlnb3RvIG91dF9lcnI7Ci0JCQkJZGlzYWJsZV9p
bnRlcnJ1cHRzKGNoaXApOwotCQkJCXJlbGVhc2VfbG9jYWxpdHkoY2hpcCwgMCk7Ci0JCQl9Ci0J
CX0gZWxzZSB7Ci0JCQl0cG1fdGlzX3Byb2JlX2lycShjaGlwLCBpbnRtYXNrKTsKKwkJCXJjID0g
cmVxdWVzdF9sb2NhbGl0eShjaGlwLCAwKTsKKwkJCWlmIChyYyA8IDApCisJCQkJZ290byBvdXRf
ZXJyOworCQkJZGlzYWJsZV9pbnRlcnJ1cHRzKGNoaXApOworCQkJcmVsZWFzZV9sb2NhbGl0eShj
aGlwLCAwKTsKIAkJfQogCX0KIAotLSAKMi4zNi4xCgo=
