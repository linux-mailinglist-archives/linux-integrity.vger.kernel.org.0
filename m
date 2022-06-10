Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D202154651A
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jun 2022 13:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348518AbiFJLJY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jun 2022 07:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347368AbiFJLJW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jun 2022 07:09:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C297D145595;
        Fri, 10 Jun 2022 04:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654859344;
        bh=gceo6ZyZ+3/FHWvb4g2ddGemHTh6VUEjyhULSfblaes=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XKlEkY8iOrWA/a+k0cnaJnC8GlL2A9c/kpH6TSVHcB0kLVBD0e5VapHyX9nurnHkI
         pojh5Me71KVznHY2+ylxx1uNlHIqWRqm995pooIH6S/I4Mkglr2GCVY4QQh5cp3G6e
         +eT2nyYXwt65OZslrwu8cqd360n7zT9he/Ox3lkE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.3.165]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlw7V-1nGtuN0nSN-00j5Jh; Fri, 10
 Jun 2022 13:09:04 +0200
From:   LinoSanfilippo@gmx.de
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, LinoSanfilippo@gmx.de, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: [PATCH v5 02/10] tpm, tpm_tis: Claim locality before writing TPM_INT_ENABLE register
Date:   Fri, 10 Jun 2022 13:08:38 +0200
Message-Id: <20220610110846.8307-3-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
References: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:+T2VMvPYLN9HNY9SF32J3bu/AAmCYyuCfuIPXtTCm+C4hFezLbu
 ncVG1mcLvoy6eb7fGAdjLVw65s9DLRUClHD8zgP5PMx8JKsgP3curSZBEjRnB2NsTRchY5F
 ix3savnkOEubwxopsVAXBHOwdOnDvnb1Ccnw9g5II4Xr10OP1umpEycaw98fyfv91xen3Z9
 DlMh0uolqQGgyl8v8tkkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/+6qvJ1QfqA=:5lFmzGCTwQY7Wj12cDc213
 PHJVHeYgsO8qmqOdwoizmjNUCLkCEQLlFQGh3BWzbcVlUD4Ji/xRvmPw7Ih22WhQdzvKq9VeS
 2xSZpEz63H+fqoYP5fEbmxtakwk6OWP1nvePrRrncaHz/oU5RlcZVZRD9p0nfRFQYWDW+vvo3
 +7HU3rav3QMW2qMdPp17craIntV3gx2jI0XgGxuCSCdDmGe8lz93CcFEThNbsQYI1hAZA+ffC
 abO+3um3anhRemFQtkWczp7Q0jvITIsdjN4lIx6PGndX0yRn5AyUoOWfaXAzy18/kp4ayb07r
 4N6AFpYMfSR0uz8pZ4LSsI5tYLHfuYkpanL5Pj3qTtC8PRijGiqBHMYMsJ1nuiSQpglPiIUGE
 wN0APXTZjkkUomTeW3tfd8nvWRF9Rr0R2FSdUDDP21HJgMS0MppyfBODdDDg4NJmm3wkkVfqc
 rtQjc0xNPGiQp4M95ndi+mUM8E6wtl4EW7ui7mCJcQdw/ldQP/+JqpbWIa03kPjUd756GEtLx
 sFHWtBFAU5KYIjrN450F4g4ca9K9I/R4ohysn4L2s01Es8+uVvC28tvD1/LT68LzSLXV668Dv
 6JC5KnUYgoF/9LukeUIjBds53CLZfS4ZcmK4bVamQFSu8uXfMCrFvqb04mBBGRBFeGx113ahT
 ySZImfeTlV3Fy2Egdn5m+o8Nt/SxAyrNntDLpqayUfKJopxCcxoHOjUr1T8wDsbMSkX9hleQ4
 2E5Fj8Xvm239GbuY1f5wWFCO1KT65m+RqYJVwJamtv3sPZt80mRd2hYItmEbMo7Ncv9zGYgXn
 wkxh7qIs0OmovkhCTt6ndr9n36RolSOTm/m5Q/U8DPUW/DKi9Yjb8IyG6UxAqYbK0DMVB3zNu
 860vox54QaG+vd+DqEHyBwQMxvtWzZ6FxJdcLk6nYnKt5xpS+sJcpCwJg1ErF0Cc5CLDLBqg0
 qJGXYp1rMgMBksuHmazOQ1vfD+YE31jb6T3flVz5RvTlmscvDGRyM1y+O9us7DJh/Xuz+btey
 5J8R6leicQNgFqF56k5xxWi0n+2if11AncGgOZASIl3OBPFTfl0VSwPhMoPcYLTr/ZtSYe9Ad
 YxHGAAoCtlrea+BlK6K2vKQ0be1NKHvEgWd75QA+1HgBVoDXF55UyTMQw==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkluIGRpc2Fi
bGVfaW50ZXJydXB0cygpIHRoZSBUUE1fR0xPQkFMX0lOVF9FTkFCTEUgYml0IGlzIHVuc2V0IGlu
IHRoZQpUUE1fSU5UX0VOQUJMRSByZWdpc3RlciB0byBzaHV0IHRoZSBpbnRlcnJ1cHRzIG9mZi4g
SG93ZXZlciBtb2RpZnlpbmcgdGhlCnJlZ2lzdGVyIGlzIG9ubHkgcG9zc2libGUgd2l0aCBhIGhl
bGQgbG9jYWxpdHkuIFNvIGNsYWltIHRoZSBsb2NhbGl0eQpiZWZvcmUgZGlzYWJsZV9pbnRlcnJ1
cHRzKCkgaXMgY2FsbGVkLgoKU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZp
bGlwcG9Aa3VuYnVzLmNvbT4KLS0tCiBkcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jIHwg
NCArKysrCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19j
b3JlLmMKaW5kZXggNmYyY2Y3NWFkZDhiLi5lZTZiNDhjNTVhYzkgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMKKysrIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlz
X2NvcmUuYwpAQCAtMTA4NCw3ICsxMDg0LDExIEBAIGludCB0cG1fdGlzX2NvcmVfaW5pdChzdHJ1
Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCB0cG1fdGlzX2RhdGEgKnByaXYsIGludCBpcnEsCiAJCQkJ
ZGV2X2VycigmY2hpcC0+ZGV2LCBGV19CVUcKIAkJCQkJIlRQTSBpbnRlcnJ1cHQgbm90IHdvcmtp
bmcsIHBvbGxpbmcgaW5zdGVhZFxuIik7CiAKKwkJCQlyYyA9IHJlcXVlc3RfbG9jYWxpdHkoY2hp
cCwgMCk7CisJCQkJaWYgKHJjIDwgMCkKKwkJCQkJZ290byBvdXRfZXJyOwogCQkJCWRpc2FibGVf
aW50ZXJydXB0cyhjaGlwKTsKKwkJCQlyZWxlYXNlX2xvY2FsaXR5KGNoaXAsIDApOwogCQkJfQog
CQl9IGVsc2UgewogCQkJdHBtX3Rpc19wcm9iZV9pcnEoY2hpcCwgaW50bWFzayk7Ci0tIAoyLjM2
LjEKCg==
