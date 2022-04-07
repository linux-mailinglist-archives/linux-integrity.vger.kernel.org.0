Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75D34F7DD2
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Apr 2022 13:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242859AbiDGLVc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Apr 2022 07:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiDGLVb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Apr 2022 07:21:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9726C1959E8;
        Thu,  7 Apr 2022 04:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649330356;
        bh=8+Ed4/Sk7YmKxE2+H6gLFIszmuVfpTFo89GEwLDQvjM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gwR+Su/wKww55S5KHPTSPALQNWHweiOUgaGMbWrGLCuNFiAhhtPEu/700nmiyweCA
         P/kXs/5hN5HVuAsBD2XPgKD6RoX4O+RBJmCsZLEfzoiIMZVlIVNzjj5OgXMdnamP7F
         OrUME/68IiKxIpCYSUM1h65sB2l1fP5YSeDzEyzQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.2.23]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MK3W0-1nGtyf3FoE-00LV7V; Thu, 07
 Apr 2022 13:19:15 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        =robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefanb@linux.ibm.com,
        p.rosenberger@kunbus.com, lukas@wunner.de,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: [PATCH 2/5] dt-bindings: tpm: document reset gpio property
Date:   Thu,  7 Apr 2022 13:18:46 +0200
Message-Id: <20220407111849.5676-3-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407111849.5676-1-LinoSanfilippo@gmx.de>
References: <20220407111849.5676-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:KAyX7I1H2OH3HUkDXTIoswDEn5u9rTZYqAw5z/f9OeWo7DsSyVC
 wzcxumnnCuyV16A9fVoudFURznMgsRjnVWH3t4GEHA+D8TYdk31iSa0wcOdGOjZxhtcKO1V
 y/sfoPmu+PJ+lxZIxTbL9IVcy8gsTyNWgpnj3VSZ8SoZUHH+xkyV6wNTKh/592fZEybmrWC
 gZe0c6u3zCwktUFUamWHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6nE/fpNYvVA=:ejbA+nLwX8F5lxNNvY6cK8
 00ed0WLTTJevJMgTBP18YK69yawHfN+XhSisJ81Ojp+BqG45t3pcI+mV9VV6UluxbBu6p9MEI
 QK5HX/dRWJz3TbiFDy/VPnmO0DrsfZKnukuq4JknRNE/PO0oguuoyh2ZTeFxtC6orNtrTaC9x
 UXlveMpZmKZNsQkWjOzZ5crg8lpamfRysLGsZQVqx5R6UR+vryRHRHEH9UBp+/MYuqfWfNPFy
 elVmw13NbhHKiOXmOW6Zmo0BSjicgKsMebg4fqFUfcJeJdFxs6zhtLrfsYcnKU+rydhPl5s6b
 gpTj9CxmltveeVJy4/zYPDErP+s4AWwR5BvyVHC/TwWEetXbi+6acFW7HODL23mj+ixmmRNCY
 qhaXIUbJtMMkdDBB0sT3Eb2bQAvRmtCu1SROxAwNZKvySoxLPUSRVkArx2lK6AH0+Mg+tlWZH
 0lNkAcKlUYP1eHjhu0oEWjLJgIUYJMK8g3DtIU2APnUTrwGCPzkbv8r9EkIaYK7L+q6B9saI3
 lzT6OYZT8631AuNk0y/BQmu9NN7hamZzWTRH+eO27uT6uA2h1rmt307Y3mx4+AJDikf8idf7V
 NK/lDslzcngulGr8vxUuTFERkMSnQ9tT8w16eitAEu7lLjWTpYxqCiWbrZsX1wC/RObaxL/tW
 dETvnaEDioHt6qzUs3weOpJt/evEjZjhP7hEHIKqguPfPz2foPbwBSf208ajJxk71vh1j6OOe
 lXWe1R4t4uxHQcdct6EGgnL8eLeJxeNhSE8YdqDiHppZRi23lbLtqaGNEDVvv2NAmOoOBC2NT
 KjN8MptTu88sDaaaA0rQ2tuFZ64vf/+D54YB0cet6cI61k8+FMiMx5349wavKhxTctP0sOGY7
 3g3lSekGDHLExBBdaJN25Pvjpq1LV7q7KWQUKDMibyhROk2g+HL8b2ScT6HTBd5BLI9Iakx7w
 xdtvMP7waQl+MDGl71RtKpO6lFGeksrBPzdNpMsadNKMaOTdyXpQf9I2ZVxOd0JPf/IbzEPIV
 bOM3LZ1L5I0CZgrsyUmI6e0mKgHQ/49fS1ffrqB1N3exPTG5QN3WdpZ0l5+ZUuhajkaX/2/pu
 QYSxiAkqfU8CkM=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

QWRkIGEgZGVzcHJpcHRpb24gZm9yIHRoZSBwcm9wZXJ0eSAicmVzZXQtZ3Bpb3MiIHdoaWNoIGNh
biBiZSB1c2VkIHRvCnNwZWNpZnkgdGhlIGdwaW8gY29ubmVjdGVkIHRvIHRoZSB0cG0gY2hpcHMg
cmVzZXQgcGluLiBBbHNvIGFkZCBhbiBleGFtcGxlCmZvciBob3cgdG8gdXNlIGl0IHdpdGhpbiB0
aGUgdHBtIG5vZGUuCgpTaWduZWQtb2ZmLWJ5OiBMaW5vIFNhbmZpbGlwcG8gPExpbm9TYW5maWxp
cHBvQGdteC5kZT4KLS0tCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc2VjdXJp
dHkvdHBtL3RwbV90aXNfc3BpLnR4dCB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc2Vj
dXJpdHkvdHBtL3RwbV90aXNfc3BpLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9zZWN1cml0eS90cG0vdHBtX3Rpc19zcGkudHh0CmluZGV4IGI4MDA2NjdkYTkyYi4uMDA5
MGExOTQ4Y2E1IDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
c2VjdXJpdHkvdHBtL3RwbV90aXNfc3BpLnR4dAorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc2VjdXJpdHkvdHBtL3RwbV90aXNfc3BpLnR4dApAQCAtOCw2ICs4LDcgQEAg
UmVxdWlyZWQgcHJvcGVydGllczoKIE9wdGlvbmFsIFNvQyBTcGVjaWZpYyBQcm9wZXJ0aWVzOgog
LSBwaW5jdHJsLW5hbWVzOiBDb250YWlucyBvbmx5IG9uZSB2YWx1ZSAtICJkZWZhdWx0Ii4KIC0g
cGludGN0cmwtMDogU3BlY2lmaWVzIHRoZSBwaW4gY29udHJvbCBncm91cHMgdXNlZCBmb3IgdGhp
cyBjb250cm9sbGVyLgorLSByZXNldC1ncGlvczogU3BlY2lmaWVzIHRoZSByZXNldCBHUElPLgog
CiBFeGFtcGxlIChmb3IgQVJNLWJhc2VkIEJlYWdsZUJvYXJkIHhNIHdpdGggVFBNX1RJUyBvbiBT
UEk0KToKIApAQCAtMTksNSArMjAsNiBAQCBFeGFtcGxlIChmb3IgQVJNLWJhc2VkIEJlYWdsZUJv
YXJkIHhNIHdpdGggVFBNX1RJUyBvbiBTUEk0KToKICAgICAgICAgICAgICAgICBjb21wYXRpYmxl
ID0gInRjZyx0cG1fdGlzLXNwaSI7CiAKICAgICAgICAgICAgICAgICBzcGktbWF4LWZyZXF1ZW5j
eSA9IDwxMDAwMDAwMD47CisJCXJlc2V0LWdwaW9zID0gPCZncGlvIDMgR1BJT19BQ1RJVkVfTE9X
PjsKICAgICAgICAgfTsKIH07Ci0tIAoyLjM1LjEKCg==
