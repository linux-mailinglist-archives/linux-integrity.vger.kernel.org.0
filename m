Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6C45347D2
	for <lists+linux-integrity@lfdr.de>; Thu, 26 May 2022 03:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237798AbiEZBI1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 May 2022 21:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiEZBI1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 May 2022 21:08:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AA58FD68;
        Wed, 25 May 2022 18:08:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2FC0B81EAA;
        Thu, 26 May 2022 01:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6CCC385B8;
        Thu, 26 May 2022 01:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653527303;
        bh=gDDrEY7sgaGJOrQUYQSqeNXloYLlY5ohey7aeNaAxGo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=trCDKrrqNXFZ5xieMRC7p7UTPmT8ijrHz+cAlwytH98Xh5wphnah5v/ztbWFBqiI7
         FWRmIIHxdAIWKRVJNIGrqw3M6sDNIDgWxdcl5HYbAkCs3Su7e3QEb1TfP0ohMG9Ruv
         bQFxe68zF+T8hf69vbiLsvBSiUY5Sr7yJUb4gkKSuoLHUKuRQoz+IoKI6VTw/d6oXT
         L2JBULmjOv3aIP7Ht8Lq59haGPcaI8gUA+D8C6nB+YzH18bB6K+IgSacNSt9rpn0+N
         HTK5Zw/R9jS1Ap1HH5x7PtqMQ8xsgZryYQiRQdsfebQdmVvK6r7JJfpyjCM1dLvgee
         B4lDadf1/x1VA==
Message-ID: <1bfdca4f564eb812d86eb2f3f2b191aee171cdbd.camel@kernel.org>
Subject: Re: [PATCH v3] keys: Use struct_size and size_add helper with alloc
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     GUO Zihua <guozihua@huawei.com>, linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, dhowells@redhat.com, keyrings@vger.kernel.org,
        gustavoars@kernel.org
Date:   Thu, 26 May 2022 04:06:40 +0300
In-Reply-To: <20220525012617.6915-1-guozihua@huawei.com>
References: <20220525012617.6915-1-guozihua@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

T24gV2VkLCAyMDIyLTA1LTI1IGF0IDA5OjI2ICswODAwLCBHVU8gWmlodWEgd3JvdGU6Cj4gVXNl
IHN0cnVjdF9zaXplIGhlbHBlciBmb3IgY2FsY3VsYXRpbmcgc2l6ZSBvZiBmbGV4aWJsZSBzdHJ1
Y3QsIGZvbGxvd2luZwo+IHRoZSBiZXN0IHByYWN0aWNlLgo+IAo+IE5vdGU6IEhBU0hfU0laRSBo
ZXJlIGlzIGEgU0hBMjU2X0RJR0VTVF9TSVpFIHdob2VzIHZhbHVlIGlzIDMyLCBzbwogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH5+fn5+Cgo+IGFkZGluZyAx
IHNob3VsZCBiZSBmaW5lIGhlcmUuCgpXaGVyZT8gJzEnIGlzIHdpdGhvdXQgYSBjb250ZXh0LiBJ
IGRvbid0IHJlYWxseSBrbm93IGhvdyB0byBpbnRlcnByZXQKdGhpcyBzZW50ZW5jZS4KCj4gCj4g
TGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL0NBSGstPXdpR1dqeHM3RVZVcGNjWkVp
NmVzdmpwSEpkZ0hRPXZ0VWVKNWNyTDYyaHg5QUBtYWlsLmdtYWlsLmNvbS8KPiBTaWduZWQtb2Zm
LWJ5OiBHVU8gWmlodWEgPGd1b3ppaHVhQGh1YXdlaS5jb20+Cj4gCj4gLS0tCj4gCj4gdjM6Cj4g
wqDCoMKgIFVwZGF0ZSBjb21taXQgbWVzc2FnZSBmb3JtYXQgYWNjb3JkaW5nIHRvIEphcmtrbydz
IGZlZWRiYWNrLgo+IHYyOgo+IMKgwqDCoCBVcGRhdGUgdGhlIGNvbW1pdCBtZXNzYWdlLCByZW1v
dmluZyB0aGUgcGFydCBhYm91dCAicG90ZW50aWFsIGlzc3VlIgo+IMKgwqDCoCBmb2xsb3dpbmcg
SmFya2tvJ3Mgc3VnZ2VzdGlvbi4KPiAKPiAtLS0KPiDCoHNlY3VyaXR5L2tleXMvZW5jcnlwdGVk
LWtleXMvZW5jcnlwdGVkLmMgfCA3ICsrKysrLS0KPiDCoHNlY3VyaXR5L2tleXMvdXNlcl9kZWZp
bmVkLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyICstCj4gwqAyIGZpbGVzIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvc2VjdXJp
dHkva2V5cy9lbmNyeXB0ZWQta2V5cy9lbmNyeXB0ZWQuYyBiL3NlY3VyaXR5L2tleXMvZW5jcnlw
dGVkLWtleXMvZW5jcnlwdGVkLmMKPiBpbmRleCBlMDVjZmMyZTQ5YWUuLjM3MzQ5NTgwZTg1NSAx
MDA2NDQKPiAtLS0gYS9zZWN1cml0eS9rZXlzL2VuY3J5cHRlZC1rZXlzL2VuY3J5cHRlZC5jCj4g
KysrIGIvc2VjdXJpdHkva2V5cy9lbmNyeXB0ZWQta2V5cy9lbmNyeXB0ZWQuYwo+IEBAIC02MTMs
NiArNjEzLDcgQEAgc3RhdGljIHN0cnVjdCBlbmNyeXB0ZWRfa2V5X3BheWxvYWQgKmVuY3J5cHRl
ZF9rZXlfYWxsb2Moc3RydWN0IGtleSAqa2V5LAo+IMKgwqDCoMKgwqDCoMKgwqBsb25nIGRsZW47
Cj4gwqDCoMKgwqDCoMKgwqDCoGludCBpOwo+IMKgwqDCoMKgwqDCoMKgwqBpbnQgcmV0Owo+ICvC
oMKgwqDCoMKgwqDCoHNpemVfdCBlcGF5bG9hZF9kYXRhbGVuID0gMDsKPiDCoAo+IMKgwqDCoMKg
wqDCoMKgwqByZXQgPSBrc3RydG9sKGRhdGFsZW4sIDEwLCAmZGxlbik7Cj4gwqDCoMKgwqDCoMKg
wqDCoGlmIChyZXQgPCAwIHx8IGRsZW4gPCBNSU5fREFUQV9TSVpFIHx8IGRsZW4gPiBNQVhfREFU
QV9TSVpFKQo+IEBAIC02NjcsOCArNjY4LDEwIEBAIHN0YXRpYyBzdHJ1Y3QgZW5jcnlwdGVkX2tl
eV9wYXlsb2FkICplbmNyeXB0ZWRfa2V5X2FsbG9jKHN0cnVjdCBrZXkgKmtleSwKPiDCoMKgwqDC
oMKgwqDCoMKgaWYgKHJldCA8IDApCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBy
ZXR1cm4gRVJSX1BUUihyZXQpOwo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgZXBheWxvYWQgPSBremFs
bG9jKHNpemVvZigqZXBheWxvYWQpICsgcGF5bG9hZF9kYXRhbGVuICsKPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGF0YWJsb2JfbGVuICsgSEFT
SF9TSVpFICsgMSwgR0ZQX0tFUk5FTCk7Cj4gK8KgwqDCoMKgwqDCoMKgZXBheWxvYWRfZGF0YWxl
biA9IHNpemVfYWRkKHBheWxvYWRfZGF0YWxlbiwgZGF0YWJsb2JfbGVuKTsKPiArwqDCoMKgwqDC
oMKgwqBlcGF5bG9hZF9kYXRhbGVuID0gc2l6ZV9hZGQoZXBheWxvYWRfZGF0YWxlbiwgSEFTSF9T
SVpFICsgMSk7Cj4gK8KgwqDCoMKgwqDCoMKgZXBheWxvYWQgPSBremFsbG9jKHN0cnVjdF9zaXpl
KGVwYXlsb2FkLCBwYXlsb2FkX2RhdGEsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXBheWxvYWRfZGF0YWxlbiksIEdGUF9L
RVJORUwpOwo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoIWVwYXlsb2FkKQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7Cj4gwqAKPiBkaWZmIC0t
Z2l0IGEvc2VjdXJpdHkva2V5cy91c2VyX2RlZmluZWQuYyBiL3NlY3VyaXR5L2tleXMvdXNlcl9k
ZWZpbmVkLmMKPiBpbmRleCA3NDllMmE0ZGNiMTMuLjMzNGZlZDM2ZTlmMyAxMDA2NDQKPiAtLS0g
YS9zZWN1cml0eS9rZXlzL3VzZXJfZGVmaW5lZC5jCj4gKysrIGIvc2VjdXJpdHkva2V5cy91c2Vy
X2RlZmluZWQuYwo+IEBAIC02NCw3ICs2NCw3IEBAIGludCB1c2VyX3ByZXBhcnNlKHN0cnVjdCBr
ZXlfcHJlcGFyc2VkX3BheWxvYWQgKnByZXApCj4gwqDCoMKgwqDCoMKgwqDCoGlmIChkYXRhbGVu
IDw9IDAgfHwgZGF0YWxlbiA+IDMyNzY3IHx8ICFwcmVwLT5kYXRhKQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FSU5WQUw7Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqB1
cGF5bG9hZCA9IGttYWxsb2Moc2l6ZW9mKCp1cGF5bG9hZCkgKyBkYXRhbGVuLCBHRlBfS0VSTkVM
KTsKPiArwqDCoMKgwqDCoMKgwqB1cGF5bG9hZCA9IGttYWxsb2Moc3RydWN0X3NpemUodXBheWxv
YWQsIGRhdGEsIGRhdGFsZW4pLCBHRlBfS0VSTkVMKTsKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKCF1
cGF5bG9hZCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRU5PTUVN
Owo+IMKgCgpCUiwgSmFya2tvCg==

