Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AD154651B
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jun 2022 13:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348748AbiFJLJZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jun 2022 07:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347791AbiFJLJW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jun 2022 07:09:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06B11455BC;
        Fri, 10 Jun 2022 04:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654859345;
        bh=HJYYp0bwrNF5C8gYN46qoheOfhuHaP68v0BHQ9qHpDY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=D6kYMg6GW9E/h0Lbwe993mV7qxqsZMl8/EuAJ22E93iTJDbLXiQvicx9vauCmJJnC
         eOb+/Cl9uxWMXjk30OT3l3OXd5GsLTCirj1oGWo8VPI03hF1Q8RSf81fDCfpkA4f7H
         Gv8kl/2L8qPEj5oWbv7LI+paMmg8oZicyAyoSNU0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.3.165]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWAOW-1oEWjq3QPS-00XawK; Fri, 10
 Jun 2022 13:09:04 +0200
From:   LinoSanfilippo@gmx.de
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, LinoSanfilippo@gmx.de, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: [PATCH v5 04/10] tpm, tmp_tis: Claim locality before writing interrupt registers
Date:   Fri, 10 Jun 2022 13:08:40 +0200
Message-Id: <20220610110846.8307-5-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
References: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:NAHbs6qnkD2A+YAgGc+z0d3gM2Lu/P3TMQtD1xYaQWoXrocevb+
 i1qhqFvmrn9IoGB9AsiKNbNAfAX8igRP+8vOJ0KChdAuY5Qn7YSTjd9MYCPJEe5b/djw26i
 OpHm0GORvZXwSSIga38RYO7zk1divOEH+eBYT9KxLIW6xpLrajlQT7ZmAyp8Z6ehaCeENDF
 61P2ssTVor1PDzx8Jzggg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nl6VUL5xV1g=:zddIOInR5fYQ59+fi1uA6I
 OwKSbx+eo4sl0iWiGEarOjU2QdBTBmqwqqcp7S2NUvwDC0nUY8MHn3eGryU6kxsKe8C+YoETp
 RSz58wKz9W/J5QPe0ANsuNxz1gBhETwZy9c+vKoSuzfMm/bhStq7H/GZEUxtwEq5ejdwxzdP+
 ULejMwDlkoitOXjZDP1dqks5r2TtrraC92up/JfM9yIpHXh9a93MFy0iimaZJu8WWT2V2sWeW
 DuLrvFEqLEjoau2zhMmWXUWWuKmICQNi+EW/KwYy5waFtBikvJG6CDbYZzdb01Bc952aDDlSC
 uZGTKhyUTnT7QKj1rMv+YpZhRzb2CUSGOf786MI0W67X5b5Q4mDTa6f14F305DO/ahsvLA1pv
 jIrcZaRLhdwSwe1tkthx5ABAH3vmyr7fkI4fphJp6DI6rgNbRjSsZAwOMEZwrD1t/IBUHWFuv
 i4/yhCJ1q+XOx5t0RS0ltpZMaRX+hUbXOEWEK1W5bUD+EhpSb3p0O+YNjv2u7P48nhFnfFPbJ
 /EH6OdWf5NsxwfxaY31FYPlKZvfHYFdfOSnAh1xR33M0biNPOZu+Je4cjVxD5cM99tkRd8kFK
 S7bSfWcnWnvxs3rv++FtLfdOIpY3lHUUNGUxToAIa9JkDUZUTAvkxKPdGXaBmBsuQz5+8OcXJ
 MlzLGZsxGvkaBqB3X6eCzBJSg4t/6hfvgft3F0sNF5dIwMynH/6uC1V5+P9JGRgRJbYjCCf/W
 1QY0fi4XEUN2aUoWkNphrxs/X2nbGMld7EoH/MK5If0fDSLge2QxorQgS7ro3AaXabAH1fUPs
 d0W3CfOfrwHCNbcW8iQM2tcuUN951I7fk8rBQ49TDUuABarQ4GrVewyhqTbUdNbL6iB6wL2D4
 O1WQZpxg6PBNj7R0wxYWHm5ODq27DBnZYVNO1T2l1T+DE1qdYGKk5mZB1xHhkbPx5Jh6WAXFd
 6JpkZ+5u4ErTCdyRX48aha0ASl9tog5UFiSeGR+1uoHmLOxBFyc73Xf1BO5TtUgIn69vHSp02
 ozWLgbQ1rpPRn8xH3z5Lkg2/MW9NXvu3PYXUREommk2c5GuiVb77KyzEc+Lwrj3Q7vHfpHHtI
 uMamiLxKI3N/w1QZygv8Tt2DPZ07rXc2B/A4drH8MNtRXU5KObyk0c/Ow==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkluIHRwbV90
aXNfcHJvYmVfc2luZ2xlX2lycSBpbnRlcnJ1cHQgcmVnaXN0ZXJzIFRQTV9JTlRfVkVDVE9SLApU
UE1fSU5UX1NUQVRVUyBhbmQgVFBNX0lOVF9FTkFCTEUgYXJlIG1vZGlmaWVkIHRvIHNldHVwIHRo
ZSBpbnRlcnJ1cHRzLgpDdXJyZW50bHkgdGhlc2UgbW9kaWZpY2F0aW9ucyBhcmUgZG9uZSB3aXRo
b3V0IGhvbGRpbmcgYSBsb2NhbGl0eSB0aHVzIHRoZXkKaGF2ZSBubyBlZmZlY3QuIEZpeCB0aGlz
IGJ5IGNsYWltaW5nIHRoZSAoZGVmYXVsdCkgbG9jYWxpdHkgYmVmb3JlIHRoZQpyZWdpc3RlcnMg
YXJlIHdyaXR0ZW4uCgpTaWduZWQtb2ZmLWJ5OiBMaW5vIFNhbmZpbGlwcG8gPGwuc2FuZmlsaXBw
b0BrdW5idXMuY29tPgotLS0KIGRyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMgfCAyNSAr
KysrKysrKysrKysrKysrKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygr
KSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNf
Y29yZS5jIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwppbmRleCBkZWU3MDE2MDli
ODAuLjcxODUyNWZjYWRjMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2Nv
cmUuYworKysgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCkBAIC03NTYsMzAgKzc1
Niw0NSBAQCBzdGF0aWMgaW50IHRwbV90aXNfcHJvYmVfaXJxX3NpbmdsZShzdHJ1Y3QgdHBtX2No
aXAgKmNoaXAsIHUzMiBpbnRtYXNrLAogCX0KIAlwcml2LT5pcnEgPSBpcnE7CiAKKwlyYyA9IHJl
cXVlc3RfbG9jYWxpdHkoY2hpcCwgMCk7CisJaWYgKHJjIDwgMCkKKwkJcmV0dXJuIHJjOworCiAJ
cmMgPSB0cG1fdGlzX3JlYWQ4KHByaXYsIFRQTV9JTlRfVkVDVE9SKHByaXYtPmxvY2FsaXR5KSwK
IAkJCSAgICZvcmlnaW5hbF9pbnRfdmVjKTsKLQlpZiAocmMgPCAwKQorCWlmIChyYyA8IDApIHsK
KwkJcmVsZWFzZV9sb2NhbGl0eShjaGlwLCBwcml2LT5sb2NhbGl0eSk7CiAJCXJldHVybiByYzsK
Kwl9CiAKIAlyYyA9IHRwbV90aXNfd3JpdGU4KHByaXYsIFRQTV9JTlRfVkVDVE9SKHByaXYtPmxv
Y2FsaXR5KSwgaXJxKTsKLQlpZiAocmMgPCAwKQorCWlmIChyYyA8IDApIHsKKwkJcmVsZWFzZV9s
b2NhbGl0eShjaGlwLCBwcml2LT5sb2NhbGl0eSk7CiAJCXJldHVybiByYzsKKwl9CiAKIAlyYyA9
IHRwbV90aXNfcmVhZDMyKHByaXYsIFRQTV9JTlRfU1RBVFVTKHByaXYtPmxvY2FsaXR5KSwgJmlu
dF9zdGF0dXMpOwotCWlmIChyYyA8IDApCisJaWYgKHJjIDwgMCkgeworCQlyZWxlYXNlX2xvY2Fs
aXR5KGNoaXAsIHByaXYtPmxvY2FsaXR5KTsKIAkJcmV0dXJuIHJjOworCX0KIAogCS8qIENsZWFy
IGFsbCBleGlzdGluZyAqLwogCXJjID0gdHBtX3Rpc193cml0ZTMyKHByaXYsIFRQTV9JTlRfU1RB
VFVTKHByaXYtPmxvY2FsaXR5KSwgaW50X3N0YXR1cyk7Ci0JaWYgKHJjIDwgMCkKKwlpZiAocmMg
PCAwKSB7CisJCXJlbGVhc2VfbG9jYWxpdHkoY2hpcCwgcHJpdi0+bG9jYWxpdHkpOwogCQlyZXR1
cm4gcmM7CisJfQogCiAJLyogVHVybiBvbiAqLwogCXJjID0gdHBtX3Rpc193cml0ZTMyKHByaXYs
IFRQTV9JTlRfRU5BQkxFKHByaXYtPmxvY2FsaXR5KSwKIAkJCSAgICAgaW50bWFzayB8IFRQTV9H
TE9CQUxfSU5UX0VOQUJMRSk7Ci0JaWYgKHJjIDwgMCkKKwlpZiAocmMgPCAwKSB7CisJCXJlbGVh
c2VfbG9jYWxpdHkoY2hpcCwgcHJpdi0+bG9jYWxpdHkpOwogCQlyZXR1cm4gcmM7CisJfQogCisJ
cmVsZWFzZV9sb2NhbGl0eShjaGlwLCBwcml2LT5sb2NhbGl0eSk7CiAJY2xlYXJfYml0KFRQTV9U
SVNfSVJRX1RFU1RFRCwgJnByaXYtPmlycXRlc3RfZmxhZ3MpOwogCiAJLyogR2VuZXJhdGUgYW4g
aW50ZXJydXB0IGJ5IGhhdmluZyB0aGUgY29yZSBjYWxsIHRocm91Z2ggdG8KLS0gCjIuMzYuMQoK
