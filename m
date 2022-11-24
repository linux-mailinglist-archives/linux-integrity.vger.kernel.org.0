Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F16637AA7
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Nov 2022 14:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiKXN5C (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Nov 2022 08:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiKXN4g (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Nov 2022 08:56:36 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23ED116046;
        Thu, 24 Nov 2022 05:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1669298171; bh=vmr8i0HILdqGMwVhgOxfm//3j+C4M5iWtBnT+hrsrRw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=aeYWtnKXEc4nQzzb3bzdwrlz7OJzg4yLtj9IudBGnc9B+VDwKYdPnvW+V0kU78oFU
         VEX7a2ngjwnJc8Nop4ZG8m+DlbdsQAdv3QQLY3MrMRIReB1z6kSmG+msV8QGqN3xmO
         dugS+OIT6BYcl1FQQC9a2AvGkWM8v+xNaf65IHBcWHiyANnmo4TgrbFAJNXThXMCKB
         hmwOe1eVxr8u4YjM4NdfpEeHhzUBQ1gDIpZ9K0i5FXGd4nkfoOKFZBRCdZzfaPu8us
         BWLp9H78rm2TGSwuAUvTIbtBmB/qPOIOGoKr0CyK+4PrVkFJPqak1mHSL1kpl+hVzU
         mMWJZdBrGqy3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.7.17]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCsU6-1opN0M3yoi-008p3Y; Thu, 24
 Nov 2022 14:56:11 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v11 03/14] tpm, tpm_tis: Disable interrupts if tpm_tis_probe_irq() failed
Date:   Thu, 24 Nov 2022 14:55:27 +0100
Message-Id: <20221124135538.31020-4-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
References: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:J4RfakH6lXbtsfGkrYwY7v5IByUOUdOvSQVf5Cc74pzRKb//+s1
 uZCUlng01wMqRHxrd+8wsIdck8EFmK1mC/4hRDdvpb1HEj5oTC0n/V/RAITCJ8aIti8Kc0U
 OUDsMtfeL4iTStHyzP/FJSyjn78+465o/f2JWjxk6frWbS4dHIMpaJGZw1eMyzAoj0PX6ry
 0jkVPHrN7ywsh+wlw2hPA==
UI-OutboundReport: notjunk:1;M01:P0:ltTGGu0PJSg=;eIk+5LoGT7XTQjLpNW0DUWjp2Nw
 jzA33pBS5udjjETZrAL1VKho2FxCsHpjafOJCSzQqtASCj1sPzfWY7SVLGHJ0RhjZxe7BS1yE
 luJYLg2ZhhNWkudEskl1oUco6ChPSnxWtb5YXeFYAIi518ibB/AUplrlaAJDWa1j269vj6FIS
 M/GDvDsQP8KjsG1lUv0OfheHfrwtATphwZlDJ0L3LN1l/M2plYNvAfsR6xzDPOWNse89H3L3U
 x5ANK/79jk1M8Za3Zwbq6yl9QVx0PvdDbNqPwd1BiUEGuqtaFmeJ2J1Bgv/Lquhhv4tsjgB/o
 h/f0n4s8MoB+ZFJp8q+06E+r76SIyIt54kG4fQefccmo3mfd4YDtzI/QSMrOYvRJTc2xIdhXr
 x1XUTpwzvjx6TSeicWwq+Sl8/dirjGZeU4ASnyGyJNtJIgf+tHnuC0Hp752QZZDlK3WKbRAnT
 cLiZ9Rd2uD1E+iIZ1tyvg0EuLLZpycGw4GDlesevlRE4KtlYxvtIfYlaFLzrZGDR5XMYxorm+
 b+TJzCdFtZPhxiW/XcRDIC9X0Terwy6khKZfEY2TUNGbqMd/LS4c3t9UL3+0bkr79eYFhJsn9
 Qau2u40jUFQRpcXP1aJTZHsDDA0zwJC6rnM7pNJoXqcG+nSDT+5GnAfQFj+1AtyaKpkH1y/ux
 TXCNyrn80Qa854T7lC9joaYgPCGWvP1HMO6rtMAyp08TItH+Fbb/NonfqQBRPrFvAOvOEkzdl
 RCRdQ8X6RKyuPwMYfBdSAGXwHTH6+imoj3askaOHNdNgZ7zy5VptV+VpKOkN1qPwnMFyzwv+j
 s6Jnfw28NLUnMvVAXAq86iV1LX7gX+Jk8vTzYn6K1M4N1Y1QLTi+sozsA7MDuZmH4DYuzBdiO
 ZsYsVfYOWZujCFBuOa044k7d5ONle9uRKwzEafHBWMP1oBa2PZDQXRlpHkAHgk0up2paYkNIf
 RoY+Fw==
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
