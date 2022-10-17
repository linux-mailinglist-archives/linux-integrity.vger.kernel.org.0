Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4801A601E01
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Oct 2022 01:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJQX6Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Oct 2022 19:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiJQX6T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Oct 2022 19:58:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDC586802;
        Mon, 17 Oct 2022 16:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666051074;
        bh=buEw+w1lPaY9DnLnvIwHNA83JT8Bq6RdLmvLWuRAigo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=C1uKCl14AdWDIjY1KVavFgtxvfuBAr1j1iTRRE/BySwSCXiv6Znp7HDjevv+52ZID
         L1oHKz2kXBovl1q6qaBsK9Sw+91gJEssdVR4zM8qDq+nDiG7aiigu6TWCIsjcsNbNQ
         J/E5jgQvsUCswnLf0b4ztRBa8Q1kZMVVMcRT4TXk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.speedport.ip ([84.162.5.241]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbivG-1pGsbn48pq-00dDlQ; Tue, 18
 Oct 2022 01:57:54 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v8 11/11] tpm, tpm_tis: Enable interrupt test
Date:   Tue, 18 Oct 2022 01:57:32 +0200
Message-Id: <20221017235732.10145-12-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221017235732.10145-1-LinoSanfilippo@gmx.de>
References: <20221017235732.10145-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:G/UrceEJMQh7OfbfZywk0mbMyJC0ez0JbQCh2fp8L4GbW1scecR
 MxktYbhNp81XSKlyTQJ9vnG6diNUOeH78L/NAZ9vhiEXcVtFynmKRzz3nYChxYS4ruB1vlX
 c3JAuk7x+zRnawWu9mdx0UDlSiTfd/PpqXNk/HrpCzt2sdHotAWRVFu+YP9KDWNu+kvLiWs
 nDp0MCO/1CCqktZHvXHsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QTPKhxW+/Y4=:DG+4oVkJurEO+P5euZJ65W
 +XszL3dIXeK5rBI1aCcaCbZZpX9P7Ypn5tQWM7sDBQoOrzXCDmqU2tHzYkDqnQYSrMdXuvv6n
 Zrovy232IVy2kjyJlgCryOZFxou+pjJjKw4sgWK7TVcaCga1Xc4uAYTxiAJtVB7/60NCqueRB
 Lf6xDWT+XRbF4LEvKBA02sN2s2y2NvSNZ2vyIZCXvoHLCYia6mW+e4t978YmNDhEwKYClw9BB
 VKgRh8qSuVC1cdrsga1oXnAq3Xjko6Qpv809rG7emQdIXTobUrJWABP2kLVNNuipIbcJCLXBQ
 g6DQNbp89PBGuG8BhhcZpIK4s0FNi1zyhcWgUfotHgUX01WDG9R97gXoEvHePLmT/jIyndYOg
 y5VAOMKM97I+99xQMyDxOwRHNV+DWH4iMn0yYba1Opy6twgkUzmjnWBov1pV4j9HSSlxsHXCX
 kcSEbmAV0P3oi2BVyJyevTUrTT1YryvvVMjuo0wRJKKG+3DFwuMBWXcYekuRh53q5jC4oly1x
 H3ojD/DvhFbs2bJpBNTw3mfvvswo51uiAj4k+nT42tJSxHiJIR1LJWB3zYHy9j5dIJ4m7PkJR
 Dtoa1sjP3ex3j4ffyJklALDrbjnR3rg+iU9S3Mkgo1Pcgfji9sdFK6UlpZArta3cVa5FlzzKn
 49H8HWSvQ8yPrWRZIKbHwVc4TGRPZBqRuMLYZ6a/0ozJkv86nVA/X2fIoXLymhLkLpizWG7fX
 BwPq8A+eKQrA8RKLfAm9JBLGJP7G1dwIb3P5mLtzoMHRPNmrrKP70jUpkAowqYhI3FbvpHBql
 cUuK0TStSz5uBSsqMC6iemzElA9jP6D1Rsjt7vGaWrNGULwJFCXTJiKu0hbEChlpEX/5I0S3y
 T/FYk3pMOybO4XTedIcgfV69Kn3iV4pH8Dm9G6FjJPmDNpXwlMOSGZblsFKcvOpbUiiBrSQOv
 aTJmSnrw7nDxR/9jTlvk88AYa/sWMlcSq0nwwr+fwFSSW78DpfPJUlHiS5D8aU/vNbESyx7xX
 GrTPV8WzEytkk3wOm3usd8513weXHEQqhfHh2YRIVM1lTs2yRfeZiz2+VDogMQH/FHBLKH55H
 HhiEFLv7ZDWjX+OQbfGdptMcqyQRdgRUu3kFjOBx7ZrbcYNEfT43K92mV709W5bQhhxOInP41
 b7p1Nwh/ZsBYZ5ieM16+ck81WmukEzB0umQSlQLz6NcrmRq4JPZjK5plWGe75KECuxzNvFyRh
 XH4sMpp9trEufWmlshbGeXCKJt/0wdpgD9i+z5D0MW2Lr6KjByg9VqXtMhZhs6bOcIC1v5ZkF
 BO9tMQQLZDmvRXm6A7kSGT7LXt/ISdsMOgs1UgUT6oA9Y8/DQKRI/EuvTBd7BwdxqA+unFIeI
 m0XtwrFn2aBlLpqr5KOFKb6PeVUvg9Zxf/6+jfsIB6iD4EcSJ5zLehjsBL14BofJAnLEEZzvu
 VXExgh1HDTr/+FoqN9FpG7r3qg9eG7rwn3HW2/eJmB0vwy5kpsB3lthlMrpYdWpWhFirlKz0q
 NRG0ebXnmw9p8AJg404PCV7nGEN75uhCARkSFONWkKy6b
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
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
aHQgYWZ0ZXIKaW50ZXJydXB0cyBoYXZlIGJlZW4gZW5hYmxlZCBhbmQgYmVmb3JlIHRoZSB0ZXN0
IGlzIGV4ZWN1dGVkLgoKU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlw
cG9Aa3VuYnVzLmNvbT4KVGVzdGVkLWJ5OiBNaWNoYWVsIE5pZXfDtmhuZXIgPGxpbnV4QG1uaWV3
b2VobmVyLmRlPgotLS0KIGRyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMgfCA1ICsrKysr
CiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9j
aGFyL3RwbS90cG1fdGlzX2NvcmUuYyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMK
aW5kZXggNDJmNjI4ZTUyY2RlLi45Nzc4ODYwZTE1OTggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY2hh
ci90cG0vdHBtX3Rpc19jb3JlLmMKKysrIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUu
YwpAQCAtNzkzLDExICs3OTMsMTYgQEAgc3RhdGljIGludCB0cG1fdGlzX2dlbl9pbnRlcnJ1cHQo
c3RydWN0IHRwbV9jaGlwICpjaGlwKQogCWlmIChyZXQgPCAwKQogCQlyZXR1cm4gcmV0OwogCisJ
Y2hpcC0+ZmxhZ3MgfD0gVFBNX0NISVBfRkxBR19JUlE7CisKIAlpZiAoY2hpcC0+ZmxhZ3MgJiBU
UE1fQ0hJUF9GTEFHX1RQTTIpCiAJCXJldCA9IHRwbTJfZ2V0X3RwbV9wdChjaGlwLCAweDEwMCwg
JmNhcDIsIGRlc2MpOwogCWVsc2UKIAkJcmV0ID0gdHBtMV9nZXRjYXAoY2hpcCwgVFBNX0NBUF9Q
Uk9QX1RJU19USU1FT1VULCAmY2FwLCBkZXNjLCAwKTsKIAorCWlmIChyZXQpCisJCWNoaXAtPmZs
YWdzICY9IH5UUE1fQ0hJUF9GTEFHX0lSUTsKKwogCXRwbV90aXNfcmVsZWFzZV9sb2NhbGl0eShj
aGlwLCAwKTsKIAogCXJldHVybiByZXQ7Ci0tIAoyLjM2LjEKCg==
