Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C55546524
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jun 2022 13:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347505AbiFJLJc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jun 2022 07:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348835AbiFJLJ1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jun 2022 07:09:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E4F14640A;
        Fri, 10 Jun 2022 04:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654859347;
        bh=5mv2L2DeQtB9WAxWjQEkuqF+lIxHB5iiZmw17kddLBE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZAsLZG65uKhet/wJCH1L6tN32sLsqMSBYtktiwhXTZTtbUyiN9iln1S2ebTeNYDdC
         JYiV27tO/eQ20904tYn5JV+q5TzjbYe9PB0rvQD9/mWi42Wq0n17x4301YNzS8wLte
         QHeO0qUhMoVbHSCQBl8InSpY/dy7WQJB0BQY8zAA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.3.165]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MjjCL-1nJ6pl3YgF-00lIF7; Fri, 10
 Jun 2022 13:09:06 +0200
From:   LinoSanfilippo@gmx.de
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, LinoSanfilippo@gmx.de, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: [PATCH v5 10/10] tpm, tpm_tis: Enable interrupt test
Date:   Fri, 10 Jun 2022 13:08:46 +0200
Message-Id: <20220610110846.8307-11-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
References: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:qYfihU3Jxj2U0goYEWYlcSqbgqtc13j943e/09qd+M9OufS+/dA
 YbAOE9tf33yMOARUfdxAg+lJ0yYfbQEtt/FNYNykyAM8VLCxCFvuPQ6+4GuoBofHXaX6CSs
 2g7cIWGl/puLAP/zC59vjAO5HtF0cSg0Beu9+95mF9HaQoq/ovRofSbMA5ixLNcW/hM2uGY
 swcBPpNEXP84OZ/U3DT+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:01WtxPALruo=:0cjONS1HN29ihMExGaaW9f
 vdK2+HqSs4v4/m4hLNz0ubjO6mWJS3jUjwN3vbeqkVkkGkRTAW4gVfVL+4RimSpKsvAWMetqy
 9x5I2x7BNsLlf8Smvrxd9phzwvFoDLgJdVrPzsfab8CpQeMREdgbjRMoL5Qvlw/01yOYnFEjz
 Xtj2MuB2RUjqgt7HGVbPMYudyiNit8w8Ja0OaMWue99tKJdznF+YB8MFw29G0nHf0J0jcdg9N
 VNvAwfF93T/xIjBcd1+Oz+fzMPQB0RdbHfb7sG+XWuC58hHtgje526DqEBnpb8IAvc45Bt7Xf
 T+1mRQKE7tPVN6ZPBedORNdOBCJ8yBCnGvbyMUXeQkV2EdhNYRsduB3EyqQTokf1HFkhvbzGk
 eK7MtZulaN5ZyzrENm1bsAMH28uMtbd+pxP9BIKAiqExgDNyMmtB0AO2U2hzVVp4uvYZfYdzp
 rAnnn8uHYtP3+wgrJ9CtyBJEzqlWyO91WU4BrvpA1OIIHvtdrUAAaF5MgHqfqWI6sz8GDbzF/
 8va01jXiKBKKYiSPBtrzZaBDjUSMnT1guUaD7miy9OxMhpvWorUIbyyQSVg/BjVf8KVeH6OKc
 CF2xdu5U4vP4TZqdPvgYztumyC6YyGMEbMUVODuiTWeYCxT4/JI5TfFSvvGZp/k+ZiTSseSdT
 HCEerX8wkyEH6Fl5pA/FO9rX7eCUfGeKzdfS7wiH/KsfwZUeN+HDHKnOs7/d2cbUD21FMLOE2
 3r9FqLfZuxsoOe+osu9EF3TSytH9vuC1GzFdmbP5mxFBXqQQyGDMazCcv3PVkP0N9zfGykPSp
 mGrRrAPKZnP4QzOq3VPayPnOWzbawCH+zKAhYwEtreQs1D/nYTVOoYMJfqA+XPbfY5+BT4l5e
 Hc+fHOtlMZ9khhOkzypyKQYc/wN6GC6dZYVVC4CYwUI4tZw1dscTGje3sHTPZhDJcazs8o+Tc
 OAng8fQkHxgfISUBr8hoaFi6G5wdfEb3JmQxeKrnZqvbJKDqvCYVVD05y4k8vcrMyAmm5VDYL
 5L/6NJ1V3V5olB+AZS7hb3tigKHvgr0wB5fXYWwD99vDFkNM5ha6c69seisQGxKrui/0xadrp
 vPh/X+OgHTCTU2/g6/SnKQqTA8NaUN4hZMfQWjmh+i5n1/Gryun6UpaIw==
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
aHQgYWZ0ZXIKaW50ZXJydXB0cyBoYXZlIGJlZW4gZW5hYmxlZC4KClNpZ25lZC1vZmYtYnk6IExp
bm8gU2FuZmlsaXBwbyA8bC5zYW5maWxpcHBvQGt1bmJ1cy5jb20+Ci0tLQogZHJpdmVycy9jaGFy
L3RwbS90cG1fdGlzX2NvcmUuYyB8IDUgKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jIGIvZHJp
dmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwppbmRleCBlNWVkZjc0NWZiMjMuLmJlMjI5YzE3
M2YxMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYworKysgYi9k
cml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCkBAIC03NzQsMTEgKzc3NCwxNiBAQCBzdGF0
aWMgaW50IHRwbV90aXNfZ2VuX2ludGVycnVwdChzdHJ1Y3QgdHBtX2NoaXAgKmNoaXApCiAJaWYg
KHJldCA8IDApCiAJCXJldHVybiByZXQ7CiAKKwljaGlwLT5mbGFncyB8PSBUUE1fQ0hJUF9GTEFH
X0lSUTsKKwogCWlmIChjaGlwLT5mbGFncyAmIFRQTV9DSElQX0ZMQUdfVFBNMikKIAkJcmV0ID0g
dHBtMl9nZXRfdHBtX3B0KGNoaXAsIDB4MTAwLCAmY2FwMiwgZGVzYyk7CiAJZWxzZQogCQlyZXQg
PSB0cG0xX2dldGNhcChjaGlwLCBUUE1fQ0FQX1BST1BfVElTX1RJTUVPVVQsICZjYXAsIGRlc2Ms
IDApOwogCisJaWYgKHJldCkKKwkJY2hpcC0+ZmxhZ3MgJj0gflRQTV9DSElQX0ZMQUdfSVJROwor
CiAJcmVsZWFzZV9sb2NhbGl0eShjaGlwLCAwKTsKIAogCXJldHVybiByZXQ7Ci0tIAoyLjM2LjEK
Cg==
