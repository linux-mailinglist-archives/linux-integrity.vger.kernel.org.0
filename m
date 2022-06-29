Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121F1560D32
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jun 2022 01:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiF2X1m (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Jun 2022 19:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiF2X1i (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Jun 2022 19:27:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9900225597;
        Wed, 29 Jun 2022 16:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656545246;
        bh=iNwUdaKb68n0qxpDMrgDE5swA3FwnfSS8OFF1YKICm0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=MYURaPEE07eP0U6aG73dPHNWtgGNzNW5U0k8L39BjGFDdBOkvcoUMBu6MNKiQ21EL
         1phQhH0rvCFz+ihcSw4ICOmig3dA3GMpCt9/Ip/flZCHbd44iRFOGtMxXnMj+R/ZR2
         9j7xM5c0PsL1OGYytIgTXEOw2ZsxshsT795FU+ao=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.23]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7b6l-1nzEpf0yk9-007yws; Thu, 30
 Jun 2022 01:27:26 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, LinoSanfilippo@gmx.de, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: [PATCH v7 08/10] tpm, tpm_tis: Request threaded interrupt handler
Date:   Thu, 30 Jun 2022 01:26:51 +0200
Message-Id: <20220629232653.1306735-9-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629232653.1306735-1-LinoSanfilippo@gmx.de>
References: <20220629232653.1306735-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:+4tCCSaPV7LTvCzpch7DT6xJYWP7yrxgAb8FnoGQ3n6/FjHKRhB
 Ub9aP6Bm8GCGDTzGt9q+wg7OtoUJdXfIGGAkDj62pPblbV4S8lCHWC45tBzTi1F76nXNVZM
 OUnCbABk1CSPnovmF0gLfM9yuO82eqPvvz+t9llCBV4+76xStwsZFtLHwpq+XUMDGCPB919
 wet9FfJeImK8fQEgBSx6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BoTu01VJatw=:olh2Myk9n4aF5al80hc26h
 1ugJ+5HO8oMiRmwKhkUqK8A+xeE+AfWlh5GL7aq4s9UF5ZLZy2DHTjSUpCKmUDSjREdwklqvj
 xrASFdQPHQc+6iUXnaLaqcB8IwS4kw0IdWwBUU8LXn4f+ypcce3bgRK1vr/HUejg8+TQy77vd
 iXpLOG/QW4S3TvJ03IiXyoAorYugCftuPbslRfDOrX3Ywconf5rm+E3q/oS1Ky1ZfHhiL/IL4
 I08csF7thlEeCIAbt05vx7jbNvcO/AcQGHIhqoI3+xOszcgTpqZIVmUYBFTnrT17z9X5bjjoT
 USWozb56Jl/uzyx3DioytHcCAxrQtrZC553ycqNr12k8Oj1A7vw6qpypIUzooSzqu+9t8CB0u
 XDxtHwwAVy/VAn+ZTbUbEPRIIf/sTq16i9DWJQvY7wgcah/9T/EYX5BxR+TesJCf6J+lU0gpL
 zMZFeXSjbhRtpy+t5hma/3iJQrTPcfp+ljbkS9iTbr9fNQLP10zCttZfURfSa53GYnWZOf31C
 76djt+bWm8p6v62jOwFjuIcObYXupYzH+g4HaI2LxJb9VY/RGMyjg/W4RGe3HzIFW6j7GVnxZ
 FPbcowyTh8hDqbDGo3YX24fPvAhYakinC5F4eyGv4nsA9y46YxZiKkulcPi3iUEReYHWzyvBU
 YaTHTZhfI9NKa3T1TNKosskPOgcVfe9NHtA7bglYpVkVeliRuvh93UwZEATfMZB0IyfnxEDGn
 joVlK6/NzNWR4eIPaqOmuCJiq9MRXfG7Roj2W5R/uDYRyGxPfkiFPdtNGoBefksdNblYz2MSI
 8+tdS4u/M6x3USHfvmVFk2xLY/A5Ledd4abU14IIGvlGXfTBFYj6Do/eiyD5mYD/7fb2AhMnQ
 N5EK19E3DKUFbEg6NkAP4HRzUP2WeB9tmL+2OWSZnq/uwiOfudWSRGOBu3OXd/s7XPpRICu2K
 m30PbXik8QP/n/oCDOULUDRrdrInr5MT8fo77LTiyAqgAqHzzMbf7IyjSQrOJd/NBn5nYdXG1
 w8SDMZefzB/43C0OOUYHphUFY0KBGmGoSv2JtkJ49HigvkVo5g4h6zX3WEUAI4onxpnOmC6ut
 ushdtOawGjmmM6BUoGnvrals7aBZVcW1m8ebdU3R27xe7CEOW+D4Ziciw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KClRoZSBUSVMg
aW50ZXJydXB0IGhhbmRsZXIgYXQgbGVhc3QgaGFzIHRvIHJlYWQgYW5kIHdyaXRlIHRoZSBpbnRl
cnJ1cHQKc3RhdHVzIHJlZ2lzdGVyLiBJbiBjYXNlIG9mIFNQSSBib3RoIG9wZXJhdGlvbnMgcmVz
dWx0IGluIGEgY2FsbCB0bwp0cG1fdGlzX3NwaV90cmFuc2ZlcigpIHdoaWNoIHVzZXMgdGhlIGJ1
c19sb2NrX211dGV4IG9mIHRoZSBzcGkgZGV2aWNlCmFuZCB0aHVzIG11c3Qgb25seSBiZSBjYWxs
ZWQgZnJvbSBhIHNsZWVwYWJsZSBjb250ZXh0LgoKVG8gZW5zdXJlIHRoaXMgcmVxdWVzdCBhIHRo
cmVhZGVkIGludGVycnVwdCBoYW5kbGVyLgoKU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBv
IDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KVGVzdGVkLWJ5OiBNaWNoYWVsIE5pZXfDtmhuZXIg
PGxpbnV4QG1uaWV3b2VobmVyLmRlPgotLS0KIGRyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3Jl
LmMgfCA3ICsrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYyBiL2Ry
aXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMKaW5kZXggZTUwYTJjNzhkZTlmLi44M2IzMWMy
NWU1NWMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMKKysrIGIv
ZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwpAQCAtODAyLDggKzgwMiwxMSBAQCBzdGF0
aWMgaW50IHRwbV90aXNfcHJvYmVfaXJxX3NpbmdsZShzdHJ1Y3QgdHBtX2NoaXAgKmNoaXAsIHUz
MiBpbnRtYXNrLAogCWludCByYzsKIAl1MzIgaW50X3N0YXR1czsKIAotCWlmIChkZXZtX3JlcXVl
c3RfaXJxKGNoaXAtPmRldi5wYXJlbnQsIGlycSwgdGlzX2ludF9oYW5kbGVyLCBmbGFncywKLQkJ
CSAgICAgZGV2X25hbWUoJmNoaXAtPmRldiksIGNoaXApICE9IDApIHsKKworCXJjID0gZGV2bV9y
ZXF1ZXN0X3RocmVhZGVkX2lycShjaGlwLT5kZXYucGFyZW50LCBpcnEsIE5VTEwsCisJCQkJICAg
ICAgIHRpc19pbnRfaGFuZGxlciwgSVJRRl9PTkVTSE9UIHwgZmxhZ3MsCisJCQkJICAgICAgIGRl
dl9uYW1lKCZjaGlwLT5kZXYpLCBjaGlwKTsKKwlpZiAocmMpIHsKIAkJZGV2X2luZm8oJmNoaXAt
PmRldiwgIlVuYWJsZSB0byByZXF1ZXN0IGlycTogJWQgZm9yIHByb2JlXG4iLAogCQkJIGlycSk7
CiAJCXJldHVybiAtMTsKLS0gCjIuMjUuMQoK
