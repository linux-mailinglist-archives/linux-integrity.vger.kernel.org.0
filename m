Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0698560D29
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jun 2022 01:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiF2X1p (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Jun 2022 19:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiF2X1j (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Jun 2022 19:27:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C789F26546;
        Wed, 29 Jun 2022 16:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656545247;
        bh=trJhlzE+9h7nejkPPDRUJXRB5bu1x2yTJPTeKLNCj6w=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZJfr34/M7u05kxJerTQq/7yMBUHy75csgDCyOplAhX2i9/PW8SWuhB8TPUAX1hvAI
         wiAbEPmy6L/sG1Yi9Wvo3Oebaid7cfpJKN/UUn8aDBqahcK6ZTUDfbuLq2/xRx21ZE
         2kxrWEPihk4EA43ufBDHy8eBeA8HiEoibkYQkkkI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.23]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mq2j2-1nKixY457C-00n7un; Thu, 30
 Jun 2022 01:27:27 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, LinoSanfilippo@gmx.de, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: [PATCH v7 10/10] tpm, tpm_tis: Enable interrupt test
Date:   Thu, 30 Jun 2022 01:26:53 +0200
Message-Id: <20220629232653.1306735-11-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629232653.1306735-1-LinoSanfilippo@gmx.de>
References: <20220629232653.1306735-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:wD89YvMA7Ghz21K7RCd1iGNpk5t5Qtb8lm2ALSnWhZzJkJD+cMW
 SPNERSZsdCRFDxdzyS4/CstbmOXywFpk2oG3UeQ9fEFX3bESMfr4Nm/puceFN3H83gKREFq
 I6kaAD2jKwIfWaeB9lXMXmUv3YWGB/6R6QZrXIqBwH8dcKx0jmvQ2ExnWvrbQ5OokPpyn33
 cPw6JYgfSctF9C51icMCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3aAohqBAv5Y=:LDpEX1KrDh/NMyxlHknzpI
 aLk2uxA8LH54kya7/5t7LsrdH6sKMjSz7T1ewILGcxNaD9VKeWhmYiHLNOve4ryICDf+HczIp
 qByFA7esuGjqtnkDPvFJ2KZ+gMroFqnV3ROVC3WD2tl0ur39Xweq45ukpdceTdEHR8YH/XUBE
 hpLF9fh4l8Y7G5tGK7Ck2YkwmMaVNQEb+hXmVJNUiW06O8VCVEaw5xYGyyJKEH7yyERb9ecVm
 MWXC3xV7BVozO9u2STXZSf1CUVU9M+T9CRG9c4Jug3pHbRaTCC4ycXRlXNfSx5Al8CGpvT1e3
 O6CMneZxRcStklvtsG+4c8/XMZTFPHLWkto6Cknoec9mVUX3/FW+bIgpMuXvlRP3NlumRuc2r
 PZqJVV1aZC79oYSLqsl4CwS3uZ7lGDPL5ppL/B66GLeEiQNrkjwphEO+jVNxOf2lvwH3wmLpp
 9LvNDi0J53VON8ZNWwpK4MNknGWtQkckAt7t5y4lFgewLEXcZinPWQMj6zR3Am1XUOnsPNsah
 8U78JGXjWe5vKhMv0vyOmiFU51o6jwaUCBMpLbCd+/XBtv6Sb7/AH0geNOzJ5hHqaISZdOgmu
 RfcC035Bp+0CX3HHWhaXM2GNF/2paoAXHtHgt6ntPwfs0K5i9jPwxrqkcbRhx22OX3NWk1YXz
 ld1bu/CF0E46YYt0KqaKK73t4wI5sm3YVO3Y0aIs8WsJs7Qlvvz6fps99kFM/zs10iTFMNKdD
 iQ+TswGONBYF9nZ0ttkySNEy4ciDUUJHEsB4GOlu809y/VmdkjooLnuqTtQfXZJvGBU5kSVT9
 J7bfvMXzdLCR/5BwWpoQZjx4FAf3z3bhckzNIiq4bNo7RKxdBSRmmtB/y7mtJ5zrgR2r1VcBi
 bKz+1H+R1gI+Dv/oOKDn3u0S0ZO0c4hK1GY10yx47fqdCJRUAqfhdT3bFBv2cxuphkYa8qk4U
 hRZf7VsUIxfOEg+ul9A0rZepitwD3KR20zGVd+ZH9+6cBfX84aIYnMLf7gZqa8wHm6QuGTYvj
 6DzOFBY940x/r9QFNO4OEXPXj/HnYB0vQCTcX6YY+SFsnHb2dYp5c4TAMZ3RLd1h2B5hw3WUp
 iT1U5ckAsJBIt/MUguD45uggXYXU52WlALqdZd76MZBuZiN8t3NQz4tSg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
b2VobmVyLmRlPgotLS0KIGRyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMgfCA1ICsrKysr
CiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9j
aGFyL3RwbS90cG1fdGlzX2NvcmUuYyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMK
aW5kZXggMzA3YTdhM2E1NWM2Li5lMDg4OWMxNTI5MDkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY2hh
ci90cG0vdHBtX3Rpc19jb3JlLmMKKysrIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUu
YwpAQCAtNzgyLDExICs3ODIsMTYgQEAgc3RhdGljIGludCB0cG1fdGlzX2dlbl9pbnRlcnJ1cHQo
c3RydWN0IHRwbV9jaGlwICpjaGlwKQogCWlmIChyZXQgPCAwKQogCQlyZXR1cm4gcmV0OwogCisJ
Y2hpcC0+ZmxhZ3MgfD0gVFBNX0NISVBfRkxBR19JUlE7CisKIAlpZiAoY2hpcC0+ZmxhZ3MgJiBU
UE1fQ0hJUF9GTEFHX1RQTTIpCiAJCXJldCA9IHRwbTJfZ2V0X3RwbV9wdChjaGlwLCAweDEwMCwg
JmNhcDIsIGRlc2MpOwogCWVsc2UKIAkJcmV0ID0gdHBtMV9nZXRjYXAoY2hpcCwgVFBNX0NBUF9Q
Uk9QX1RJU19USU1FT1VULCAmY2FwLCBkZXNjLCAwKTsKIAorCWlmIChyZXQpCisJCWNoaXAtPmZs
YWdzICY9IH5UUE1fQ0hJUF9GTEFHX0lSUTsKKwogCXRwbV90aXNfcmVsZWFzZV9sb2NhbGl0eShj
aGlwLCAwKTsKIAogCXJldHVybiByZXQ7Ci0tIAoyLjI1LjEKCg==
