Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849B94D666C
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Mar 2022 17:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350058AbiCKQgC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Mar 2022 11:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349790AbiCKQgA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Mar 2022 11:36:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81753157216;
        Fri, 11 Mar 2022 08:34:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D58661CD1;
        Fri, 11 Mar 2022 16:34:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEC2C340E9;
        Fri, 11 Mar 2022 16:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647016496;
        bh=88dEO49EYRZrqvsY+olsRToa9k5YpIsIllLOXHqmIWw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=B4brTrnis1myJ5EmBicdUkx23akFAkcQoHRB7DLMTfm0rDVFRxMJvwP+Q54YxVA4H
         SHgDqOJF8yEsipYGfAs2SY1gNXnDaQiIdBkF0BYSMEOPfvajvaEz438tGar8HjLcq8
         lYq56ujzt2ImKuJ3SEHzbAgfUIUfs+SICRN2SZgmDN6hVg3SDE6cV1qqFrl8yHLKrU
         LWKHLMNIN6abzgeWVXWGk/9UAZJ8d3/R+naolhbNa9bvJKoMCPiVi3A8Axppt/JtjV
         /Doq2uicda5g4adxFddOW7ohy8zrGIOh2sQn57stTPMuw2rLwvhG7yZuJBKmBbpooe
         FaiRSec95sBiw==
Message-ID: <22e6a4b4b01a219282e4da6a941eaad68897841f.camel@kernel.org>
Subject: Re: [PATCH] tpm: Fix memory leak in tpmm_chip_alloc
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Guozihua (Scott)" <guozihua@huawei.com>
Cc:     linux-integrity@vger.kernel.org, wangweiyang2@huawei.com,
        xiujianfeng@huawei.com, weiyongjun1@huawei.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org
Date:   Fri, 11 Mar 2022 18:34:10 +0200
In-Reply-To: <aa1b89b5-d13e-3dc8-ec2c-62823ea10021@huawei.com>
References: <20220307104827.40843-1-guozihua@huawei.com>
         <YiYMgnpnf3Y6l8IY@iki.fi> <aa1b89b5-d13e-3dc8-ec2c-62823ea10021@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

T24gVGh1LCAyMDIyLTAzLTEwIGF0IDExOjMzICswODAwLCBHdW96aWh1YSAoU2NvdHQpIHdyb3Rl
Ogo+IAo+IAo+IE9uIDIwMjIvMy83IDIxOjQ1LCBKYXJra28gU2Fra2luZW4gd3JvdGU6Cj4gPiBP
biBNb24sIE1hciAwNywgMjAyMiBhdCAwNjo0ODoyN1BNICswODAwLCBHVU8gWmlodWEgd3JvdGU6
Cj4gPiA+IEZpeCBhIG1lbW9yeSBsZWFrIGluIHRwbW1fY2hpcF9hbGxvYy4gZGV2bV9hZGRfYWN0
aW9uX29yX3Jlc2V0IHdvdWxkCj4gPiA+IGNhbGwgcHV0X2RldmljZSBvbiBlcnJvciwgd2hpbGUg
dHBtLT5kZXZzIGlzIGxlZnQgdW50b3VjaGVkLiBDYWxsCj4gPiA+IHB1dF9kZXZpY2Ugb24gdHBt
LT5kZXZzIGFzIHdlbGwgaWYgZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0IHJldHVybnMgYW4KPiA+
ID4gZXJyb3IuCj4gPiA+IAo+ID4gPiBGaXhlczogZmRjOTE1ZjdmNzE5ICgidHBtOiBleHBvc2Ug
c3BhY2VzIHZpYSBhIGRldmljZSBsaW5rIC9kZXYvdHBtcm0iKQo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBHVU8gWmlodWEgPGd1b3ppaHVhQGh1YXdlaS5jb20+Cj4gPiA+IC0tLQo+ID4gPiDCoCBkcml2
ZXJzL2NoYXIvdHBtL3RwbS1jaGlwLmMgfCAxMyArKysrKysrKystLS0tCj4gPiA+IMKgIDEgZmls
ZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gPiA+IAo+ID4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL3RwbS90cG0tY2hpcC5jIGIvZHJpdmVycy9jaGFyL3Rw
bS90cG0tY2hpcC5jCj4gPiA+IGluZGV4IGIwMDllNzQ3OWI3MC4uMGE5MjMzNGU4YzQwIDEwMDY0
NAo+ID4gPiAtLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbS1jaGlwLmMKPiA+ID4gKysrIGIvZHJp
dmVycy9jaGFyL3RwbS90cG0tY2hpcC5jCj4gPiA+IEBAIC0zMDgsNiArMzA4LDEyIEBAIHN0YXRp
YyBpbnQgdHBtX2NsYXNzX3NodXRkb3duKHN0cnVjdCBkZXZpY2UgKmRldikKPiA+ID4gwqDCoMKg
wqDCoMKgwqDCoHJldHVybiAwOwo+ID4gPiDCoCB9Cj4gPiA+IMKgIAo+ID4gPiArc3RhdGljIHZv
aWQgdHBtX2NoaXBfZnJlZShzdHJ1Y3QgdHBtX2NoaXAgKmNoaXApCj4gPiA+ICt7Cj4gPiA+ICvC
oMKgwqDCoMKgwqDCoHB1dF9kZXZpY2UoJmNoaXAtPmRldnMpOwo+ID4gPiArwqDCoMKgwqDCoMKg
wqBwdXRfZGV2aWNlKCZjaGlwLT5kZXYpOwo+ID4gPiArfQo+ID4gPiArCj4gPiA+IMKgIC8qKgo+
ID4gPiDCoMKgICogdHBtX2NoaXBfYWxsb2MoKSAtIGFsbG9jYXRlIGEgbmV3IHN0cnVjdCB0cG1f
Y2hpcCBpbnN0YW5jZQo+ID4gPiDCoMKgICogQHBkZXY6IGRldmljZSB0byB3aGljaCB0aGUgY2hp
cCBpcyBhc3NvY2lhdGVkCj4gPiA+IEBAIC0zOTYsOCArNDAyLDcgQEAgc3RydWN0IHRwbV9jaGlw
ICp0cG1fY2hpcF9hbGxvYyhzdHJ1Y3QgZGV2aWNlICpwZGV2LAo+ID4gPiDCoMKgwqDCoMKgwqDC
oMKgcmV0dXJuIGNoaXA7Cj4gPiA+IMKgIAo+ID4gPiDCoCBvdXQ6Cj4gPiA+IC3CoMKgwqDCoMKg
wqDCoHB1dF9kZXZpY2UoJmNoaXAtPmRldnMpOwo+ID4gPiAtwqDCoMKgwqDCoMKgwqBwdXRfZGV2
aWNlKCZjaGlwLT5kZXYpOwo+ID4gPiArwqDCoMKgwqDCoMKgwqB0cG1fY2hpcF9mcmVlKGNoaXAp
Owo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIEVSUl9QVFIocmMpOwo+ID4gPiDCoCB9Cj4g
PiA+IMKgIEVYUE9SVF9TWU1CT0xfR1BMKHRwbV9jaGlwX2FsbG9jKTsKPiA+ID4gQEAgLTQyMCw4
ICs0MjUsOCBAQCBzdHJ1Y3QgdHBtX2NoaXAgKnRwbW1fY2hpcF9hbGxvYyhzdHJ1Y3QgZGV2aWNl
ICpwZGV2LAo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBjaGlw
Owo+ID4gPiDCoCAKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoHJjID0gZGV2bV9hZGRfYWN0aW9uX29y
X3Jlc2V0KHBkZXYsCj4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHZvaWQgKCopKHZvaWQgKikpIHB1
dF9kZXZpY2UsCj4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmNoaXAtPmRldik7Cj4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgKHZvaWQgKCopKHZvaWQgKikpIHRwbV9jaGlwX2ZyZWUsCj4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgY2hpcCk7Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqBpZiAocmMpCj4gPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIEVSUl9QVFIocmMpOwo+ID4gPiDC
oCAKPiA+ID4gLS0gCj4gPiA+IDIuMTcuMQo+ID4gPiAKPiA+IAo+ID4gUGxlYXNlIHRlc3QgYWdh
aW5zdCB0aGUgbGF0ZXN0IGluCj4gPiAKPiA+IGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20v
bGludXgva2VybmVsL2dpdC9qYXJra28vbGludXgtdHBtZGQuZ2l0Cj4gPiAKPiA+IGFuZCBzaGFy
ZSB5b3VyIHJlc3VsdHMuCj4gPiAKPiA+IEJSLCBKYXJra28KPiA+IC4KPiAKPiBIaSBKYXJra28s
Cj4gCj4gSSdsbCBkbyB0aGF0LiBEbyB3ZSBoYXZlIGEgdGVzdCBzZXQgZm9yIFRQTT8gT3IgZG8g
d2UganVzdCBidWlsZCBhbmQgcnVuIAo+IGl0IGFuZCBzZWUgaWYgZXZlcnl0aGluZyB3b3JrcyBh
cyBleHBlY3RlZD8KPiAKPiBUaGlzIGlzIGFuIGVycm9yIGhhbmRsaW5nIG9wdGltaXphdGlvbiBC
VFcuCgpUaGVyZSBpcyBrc2VsZnRlc3QgaW4gdG9vbHMvdGVzdGluZy9rc2VsZnRlcy90cG0yIHRo
YXQgeW91IGNhbiB1c2UKYnV0IGRvIG5vdCBoYXZlIHRvLgoKQlIsIEphcmtrbwoKCg==

