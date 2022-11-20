Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89108631445
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Nov 2022 14:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiKTNcY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Nov 2022 08:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKTNcX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Nov 2022 08:32:23 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5D128E13;
        Sun, 20 Nov 2022 05:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668951125; bh=vmr8i0HILdqGMwVhgOxfm//3j+C4M5iWtBnT+hrsrRw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=TMP3jz03SMBORLJ1Osq4NJBLaCq5d0dw8jsLS1ocyJhst++3mlOZzBTmQBqZWjKWv
         Voxzb/CQ6RCoeo7qn6/J/9C71Ry/WZsSFaulE6y7ESVN793wcmhDVAj4MNXBq0AP9i
         qdDmg6LDUbciSZdaXi+No2YJpxW3W0J+D//iRMt8zl5D6anEc723u8h63zHiFywoUn
         L2a+9hPW0AOGMc4wG450lLEID/gHX41CCJoWqkV1f9yuO2eIHhJmZlZoyMAvXHHPhG
         29ZrSrj2z8vJlqhCF83PQLt/o1ecqy2FmXV2Y4U5L8n/yy4g2SHxLP58OTgMWQ8r8+
         SWTw8fUQKRfOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.7.17]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXp5a-1oQt8j2T4W-00Y6vT; Sun, 20
 Nov 2022 14:32:05 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v10 03/14] tpm, tpm_tis: Disable interrupts if tpm_tis_probe_irq() failed
Date:   Sun, 20 Nov 2022 14:31:23 +0100
Message-Id: <20221120133134.28926-4-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221120133134.28926-1-LinoSanfilippo@gmx.de>
References: <20221120133134.28926-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:b4C2M5Qz3awQq0TkuQ6vgiwoMtTbqIlRfmnv0OiMblSzZLZq228
 BaaIfCHUp0oCYSs1lVBZoDmGSQvGKfk9Znbbm1oKwMdK2GDQaSlNOQZOsHVfh1BDxtrFT+k
 Yi6UqX2Us0VDNI6jgP4INwB8nW5Yb4JMr6X+4AO4MkeXetbnwqeuafOMSrROsMP/or/mK8t
 xuz7RZR61pEoZ12pTwE7A==
UI-OutboundReport: notjunk:1;M01:P0:Z7y9UfKX6mM=;Q1Umg7DU5Dvyq+vxVLBm7PMycSI
 L2FyUFkk5FKNJrGCKp5FvID1bZEq0odl/FRjq0YEwP3L4dQQovH6krb1gCk14wDVhiVK4wJNu
 a8HELXz+JRZ512cQkSVNSAMkAcspVnucQY0pqK6jta2zxSIGp34sKkK/77stXgNHYbWwRdS6T
 fbW6ZWy7y7eaWYE5Ts3a9fFietpRoed7fxzdomjClJsP1RTUxJpMezu95k3UnsQjc4RFqZixf
 w9f/KP6fAWomT6HBgYx1CxSasp8jOgIZN7wUDOpRy3TUF+wUSGVX/ldKJKNtRJDFI82D1haMl
 syvZxABa8z0D+R6j3tpKL5VAmrlPShNx7y9JSaehAikJYGvLqnB+ezSLxGHBrrfZXPvMVmbj9
 UeJ3OB/DQe2SLkLvX9noAAf5G9K3tOSXyB+YrgdRRF6DJ6NfK0sI+4AjYgOFgsxUil7UFky1a
 687Ll/PTJXIfWnCJHh5wVC3GBhuU7ydCH9JuGT2PA/X+OtW1MYLORZKwWFEk1YgPQCCMTI2Kn
 /7oy/r4/IN8diVkGJ62JSEj6BhXqj7nNgMyFH2KHONxDMIm0Wk08mzEq/O3zEraaKB4daXJIP
 pmabEL0l3tts7IFCzaqBg65iFjtxDe8nOQvXtEEjU9tilCSCcc4mWmn8q9UIB1evQIFi55LM2
 pohbrFj958CkB1EG9ZoRFwMFgp3W/yPhknNFV5JGKAq6cz0xSfk4Spd8EqUEAZ38kuycZT9nN
 y7VCtKo9PfT6zU9MUBbqfSWH1g0vsQQd2g4bk5xOZTkUtIfDhOn0R2d9TMfBEv5b3PXJDKtjw
 mLmZ2KSzWJRmgVpe87AAWYJNgLzkx7jXTU4hwvV+iDQ6wZAXBbkH3JHcC7up42Lggmn/r1Ec8
 VoWJ8eq03qGNaAmXmXPCWlcslbajAJEYMIO4NC4UlCpljM7flBilgxD+o/HwV4ZgGnWEuC5x1
 GnvWiA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
U2Fra2luZW4gPGphcmtrb0BrZXJuZWwub3JnPgpUZXN0ZWQtYnk6IE1pY2hhZWwgTmlld8O2aG5l
ciA8bGludXhAbW5pZXdvZWhuZXIuZGU+Ci0tLQogZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2Nv
cmUuYyB8IDIyICsrKysrKysrKysrLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNl
cnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdHBt
L3RwbV90aXNfY29yZS5jIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwppbmRleCBk
MmM5YzlkNzY4OTMuLjYwM2I4MmNhNTZkYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9jaGFyL3RwbS90
cG1fdGlzX2NvcmUuYworKysgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCkBAIC0x
MDkxLDIxICsxMDkxLDIxIEBAIGludCB0cG1fdGlzX2NvcmVfaW5pdChzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHN0cnVjdCB0cG1fdGlzX2RhdGEgKnByaXYsIGludCBpcnEsCiAJCQlnb3RvIG91dF9lcnI7
CiAJCX0KIAotCQlpZiAoaXJxKSB7CisJCWlmIChpcnEpCiAJCQl0cG1fdGlzX3Byb2JlX2lycV9z
aW5nbGUoY2hpcCwgaW50bWFzaywgSVJRRl9TSEFSRUQsCiAJCQkJCQkgaXJxKTsKLQkJCWlmICgh
KGNoaXAtPmZsYWdzICYgVFBNX0NISVBfRkxBR19JUlEpKSB7Ci0JCQkJZGV2X2VycigmY2hpcC0+
ZGV2LCBGV19CVUcKKwkJZWxzZQorCQkJdHBtX3Rpc19wcm9iZV9pcnEoY2hpcCwgaW50bWFzayk7
CisKKwkJaWYgKCEoY2hpcC0+ZmxhZ3MgJiBUUE1fQ0hJUF9GTEFHX0lSUSkpIHsKKwkJCWRldl9l
cnIoJmNoaXAtPmRldiwgRldfQlVHCiAJCQkJCSJUUE0gaW50ZXJydXB0IG5vdCB3b3JraW5nLCBw
b2xsaW5nIGluc3RlYWRcbiIpOwogCi0JCQkJcmMgPSByZXF1ZXN0X2xvY2FsaXR5KGNoaXAsIDAp
OwotCQkJCWlmIChyYyA8IDApCi0JCQkJCWdvdG8gb3V0X2VycjsKLQkJCQlkaXNhYmxlX2ludGVy
cnVwdHMoY2hpcCk7Ci0JCQkJcmVsZWFzZV9sb2NhbGl0eShjaGlwLCAwKTsKLQkJCX0KLQkJfSBl
bHNlIHsKLQkJCXRwbV90aXNfcHJvYmVfaXJxKGNoaXAsIGludG1hc2spOworCQkJcmMgPSByZXF1
ZXN0X2xvY2FsaXR5KGNoaXAsIDApOworCQkJaWYgKHJjIDwgMCkKKwkJCQlnb3RvIG91dF9lcnI7
CisJCQlkaXNhYmxlX2ludGVycnVwdHMoY2hpcCk7CisJCQlyZWxlYXNlX2xvY2FsaXR5KGNoaXAs
IDApOwogCQl9CiAJfQogCi0tIAoyLjM2LjEKCg==
