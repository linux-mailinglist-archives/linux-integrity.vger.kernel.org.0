Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69F46245BA
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Nov 2022 16:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiKJP0q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Nov 2022 10:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiKJP03 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Nov 2022 10:26:29 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD77C40926;
        Thu, 10 Nov 2022 07:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668093944; bh=vmr8i0HILdqGMwVhgOxfm//3j+C4M5iWtBnT+hrsrRw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=l6NcozitBJOn/pRw0n3a9CgOrLtnM8YlA1d8jZtTFwPPvvU7Uw8RlNv36aQxrVrDc
         jO/lk2UZgewHknat5X1SMky/rs0cxy+zKwWj13rYjWEuPvPJkVsmWrdsfbWLL0MC1a
         5G66ZhceVqdZ9Dguo/GaDgaVAPht+21cXuKqNujgyqvQlFGum240rpWCzxG7WsF86s
         tYvWiMzxeVNa0OAFOinONbYCPVRaRfZBVEp5UbMqp9CjevF7xQL4hrXuxWLHDX72jY
         rqVqLabBjcaw4U7NjQ5j9jWGG/IFxGFBlN3cU6uD5e8jQzHdZDFV7AcQoAlgfvi0HG
         +ffSnocqK481w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.7.17]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M89Gt-1oxnzo3GrL-005L2E; Thu, 10
 Nov 2022 16:25:43 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v9 03/12] tpm, tpm_tis: Disable interrupts if tpm_tis_probe_irq() failed
Date:   Thu, 10 Nov 2022 16:25:24 +0100
Message-Id: <20221110152533.24243-4-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221110152533.24243-1-LinoSanfilippo@gmx.de>
References: <20221110152533.24243-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:pM1M1Hc/4r3ew4oifeUS7mZ1Y9Ljsr4ABery3qVtBcuLO7/zlv7
 gFYRo5fz8/wLYU0MK3psPh/O/bkkSbz+iZRBEF3VmbmChhSmtfnUxVIsKNUW+wV2up6Z7Ll
 ug2oXwHvSHth714q79SbJk+LpHWKSUemEddh5LyvLmQkhxdBD3u4vJe/XqZTa0Kkac/v4Q/
 zwjk3Zz7241RR6XK7MReg==
UI-OutboundReport: notjunk:1;M01:P0:AYfreQn/zm4=;T/7Y5nb/wGFzkRCd0y1uGLSzRRq
 NVQpG4fGGPcd6GI9Pz1n7S5NS7ZZ4Vj5MnA/0Dk7m4P+k2f0N0hyJl/DxSJgxaCCPsxP3kCMh
 LUlP3rZNA1CYjxNt5ULhwfTZ9E+rILTQRUhRVQk18TsBX8CG0HhfDzWXNs8ycea0aAU+bWCZ/
 Vs/nic5NJiuzXBEAesZi9Q384TwU3wWCYlx4e88LHnNGp8175wJgj2WhgCVll41gF1m6sxdW4
 QMSeBcTWQ2h/wlp11U6w4+/eK1Bf2Z/9IpqkFocUHExEjwnyGLByh/SPjAh/3oXYgHgEnPpzH
 pWZFIjKf2Lk7HuKzagion6EqlrtsShtcIwF/gY746f0gKjZrLpKUNsbCKAiteLuBETQE3Rz2f
 wrgnGxOuP1yOhcs5E59s//MZ/i0nsaRfjq2VNJfJar4rZlSYT7JRsOe5tUHLmDtsJXV7uW6YO
 Uy7Y5ofyplkXqm+bfxMTNyKhPyvHAhq3BUj96X0Q4L+VdV762lb5eDwJ6jrI4AiyC6ZlajFGr
 yfuNe1UnvQxV/Xo/KGpLBtV7uo4yUmMY/MY9G/2Zui9eWqx56Lkb55ZPJHdCQ30DdMZBNrmo3
 LaBnluUAS4gG+nvdpNpEkT+u4jVvVpVSddhV8eV7E0ED/rQwoIIQD+lLesawyiTzfwvenvU2F
 yvnQvFreEID+6t4jn7W9c7UBQPPnloF5ndCZHwvk1a1rOVY2lpHVLiWScHJ+1nK/JFIrEM0Th
 01OoI6T5iA0UB7E4JtTKbYddecVa/qKs9tOFXwXEqZa1xNak+AMJeeWx3vc58lHHHg9Sjxi6M
 WXOIoIP9ELwSDpMuRAWuShmDxO/YHJY1iMOtrwt1R3inMBG9C27rpsx5lNVDPrYsMxzwfT/Mx
 MVNz9DWOER33VqnkzOFKwYwjbJqsLL0tI+BpMPtS2VTFP2Evbv8OBK9tjaSIgprs+mDs9S/8r
 3c64GQ==
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
