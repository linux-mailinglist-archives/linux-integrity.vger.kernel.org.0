Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735585347E3
	for <lists+linux-integrity@lfdr.de>; Thu, 26 May 2022 03:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiEZBJa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 May 2022 21:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345497AbiEZBJ2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 May 2022 21:09:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139469156B;
        Wed, 25 May 2022 18:09:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 551DD6177E;
        Thu, 26 May 2022 01:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2D9C385B8;
        Thu, 26 May 2022 01:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653527365;
        bh=C2nPUN15wOe70gemBxcR2EGtWl29r9q5dZjSgGFDpnc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WaIjFwaTQaVa8J7S9OUWtvtFkunG3xw1f/2oJhJcdIH/Bm7zaKslh0DpDuFCtFY3R
         FCx7pCblqqHwdxMCSwVhMLNjIRe9iHM5vA5iltjYFcsaYtx7/Q1cKSdidOrS9bYk6s
         QPn4pCk9/izbIgINnGGTvqicFeJvBjfVaNDzwn0flYXZJQmXhR+6V5dC4PjzbZEcs8
         U4X/c8RLfEjUxVKppRBrIlZhZSGpCqj4itmcGQXniML5ZuWRxodju+Xl/Oq5jqH6ck
         Dn7lSKe1LPUXZ//UkKwtVw2uoQdvXYBssgTIKW3zyrdeIw4gOzHlMRnzMzB02I9/XA
         KqbbCo464qXBQ==
Message-ID: <e072359b408783c8941fc25e4a1da999605cf8bf.camel@kernel.org>
Subject: Re: [PATCH v4 2/3] tpm: Add tpm_tis_verify_crc to the
 tpm_tis_phy_ops protocol layer
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, krzysztof.kozlowski+dt@linaro.org,
        Johannes Holland <johannes.holland@infineon.com>,
        Amir Mizinski <amirmizi6@gmail.com>
Date:   Thu, 26 May 2022 04:07:42 +0300
In-Reply-To: <20220525165849.7789-3-Alexander.Steffen@infineon.com>
References: <20220525165849.7789-1-Alexander.Steffen@infineon.com>
         <20220525165849.7789-3-Alexander.Steffen@infineon.com>
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

T24gV2VkLCAyMDIyLTA1LTI1IGF0IDE4OjU4ICswMjAwLCBBbGV4YW5kZXIgU3RlZmZlbiB3cm90
ZToKPiBTb21lIFRQTXMsIGUuZy4gdGhvc2UgaW1wbGVtZW50aW5nIHRoZSBJMkMgdmFyaWFudCBv
ZiBUSVMsIGNhbiB2ZXJpZnkKPiBkYXRhIHRyYW5zZmVycyB0by9mcm9tIHRoZSBGSUZPIHdpdGgg
YSBDUkMuIFRoZSBDUkMgaXMgY2FsY3VsYXRlZCBvdmVyCj4gdGhlIGVudGlyZXR5IG9mIHRoZSBG
SUZPIHJlZ2lzdGVyLiBTaW5jZSB0aGUgcGh5X29wcyBsYXllciBpcyBub3QgYXdhcmUKPiB3aGVu
IHRoZSBjb3JlIGxheWVyIGlzIGRvbmUgcmVhZGluZy93cml0aW5nIHRoZSBGSUZPLCBDUkMgdmVy
aWZpY2F0aW9uCj4gbXVzdCBiZSB0cmlnZ2VyZWQgZnJvbSB0aGUgY29yZSBsYXllci4gVG8gdGhp
cyBlbmQsIGFkZCBhbiBvcHRpb25hbAo+IHBoeV9vcHMgQVBJIGNhbGwuCj4gCj4gQ28tZGV2ZWxv
cGVkLWJ5OiBKb2hhbm5lcyBIb2xsYW5kIDxqb2hhbm5lcy5ob2xsYW5kQGluZmluZW9uLmNvbT4K
PiBTaWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBIb2xsYW5kIDxqb2hhbm5lcy5ob2xsYW5kQGluZmlu
ZW9uLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgU3RlZmZlbiA8QWxleGFuZGVyLlN0
ZWZmZW5AaW5maW5lb24uY29tPgo+IC0tLQo+IMKgZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2Nv
cmUuYyB8IDE0ICsrKysrKysrKysrKysrCj4gwqBkcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29y
ZS5oIHwgMTAgKysrKysrKysrKwo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCsp
Cj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMgYi9kcml2
ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCj4gaW5kZXggZGM1NmI5NzZkODE2Li43NTc2MjNi
YWNmZDUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwo+ICsr
KyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMKPiBAQCAtMjg5LDYgKzI4OSw3IEBA
IHN0YXRpYyBpbnQgdHBtX3Rpc19yZWN2KHN0cnVjdCB0cG1fY2hpcCAqY2hpcCwgdTggKmJ1Ziwg
c2l6ZV90IGNvdW50KQo+IMKgwqDCoMKgwqDCoMKgwqBpbnQgc2l6ZSA9IDA7Cj4gwqDCoMKgwqDC
oMKgwqDCoGludCBzdGF0dXM7Cj4gwqDCoMKgwqDCoMKgwqDCoHUzMiBleHBlY3RlZDsKPiArwqDC
oMKgwqDCoMKgwqBpbnQgcmM7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKGNvdW50IDwgVFBN
X0hFQURFUl9TSVpFKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzaXplID0g
LUVJTzsKPiBAQCAtMzI4LDYgKzMyOSwxMyBAQCBzdGF0aWMgaW50IHRwbV90aXNfcmVjdihzdHJ1
Y3QgdHBtX2NoaXAgKmNoaXAsIHU4ICpidWYsIHNpemVfdCBjb3VudCkKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0Owo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqAKPiAr
wqDCoMKgwqDCoMKgwqByYyA9IHRwbV90aXNfdmVyaWZ5X2NyYyhwcml2LCAoc2l6ZV90KXNpemUs
IGJ1Zik7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKHJjIDwgMCkgewo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBkZXZfZXJyKCZjaGlwLT5kZXYsICJDUkMgbWlzbWF0Y2ggZm9yIHJlc3Bv
bnNlLlxuIik7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNpemUgPSByYzsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBvdXQ7Cj4gK8KgwqDCoMKgwqDCoMKg
fQo+ICsKPiDCoG91dDoKPiDCoMKgwqDCoMKgwqDCoMKgdHBtX3Rpc19yZWFkeShjaGlwKTsKPiDC
oMKgwqDCoMKgwqDCoMKgcmV0dXJuIHNpemU7Cj4gQEAgLTQ0Myw2ICs0NTEsMTIgQEAgc3RhdGlj
IGludCB0cG1fdGlzX3NlbmRfbWFpbihzdHJ1Y3QgdHBtX2NoaXAgKmNoaXAsIGNvbnN0IHU4ICpi
dWYsIHNpemVfdCBsZW4pCj4gwqDCoMKgwqDCoMKgwqDCoGlmIChyYyA8IDApCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmM7Cj4gwqAKPiArwqDCoMKgwqDCoMKgwqBy
YyA9IHRwbV90aXNfdmVyaWZ5X2NyYyhwcml2LCBsZW4sIGJ1Zik7Cj4gK8KgwqDCoMKgwqDCoMKg
aWYgKHJjIDwgMCkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfZXJyKCZj
aGlwLT5kZXYsICJDUkMgbWlzbWF0Y2ggZm9yIGNvbW1hbmQuXG4iKTsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJjOwo+ICvCoMKgwqDCoMKgwqDCoH0KPiArCj4gwqDC
oMKgwqDCoMKgwqDCoC8qIGdvIGFuZCBkbyBpdCAqLwo+IMKgwqDCoMKgwqDCoMKgwqByYyA9IHRw
bV90aXNfd3JpdGU4KHByaXYsIFRQTV9TVFMocHJpdi0+bG9jYWxpdHkpLCBUUE1fU1RTX0dPKTsK
PiDCoMKgwqDCoMKgwqDCoMKgaWYgKHJjIDwgMCkKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFy
L3RwbS90cG1fdGlzX2NvcmUuaCBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmgKPiBp
bmRleCA2YzIwM2YzNmI4YTEuLjY2YTVhMTNjZDFkZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2No
YXIvdHBtL3RwbV90aXNfY29yZS5oCj4gKysrIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2Nv
cmUuaAo+IEBAIC0xMjEsNiArMTIxLDggQEAgc3RydWN0IHRwbV90aXNfcGh5X29wcyB7Cj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdTggKnJlc3Vs
dCwgZW51bSB0cG1fdGlzX2lvX21vZGUgbW9kZSk7Cj4gwqDCoMKgwqDCoMKgwqDCoGludCAoKndy
aXRlX2J5dGVzKShzdHJ1Y3QgdHBtX3Rpc19kYXRhICpkYXRhLCB1MzIgYWRkciwgdTE2IGxlbiwK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNv
bnN0IHU4ICp2YWx1ZSwgZW51bSB0cG1fdGlzX2lvX21vZGUgbW9kZSk7Cj4gK8KgwqDCoMKgwqDC
oMKgaW50ICgqdmVyaWZ5X2NyYykoc3RydWN0IHRwbV90aXNfZGF0YSAqZGF0YSwgc2l6ZV90IGxl
biwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNv
bnN0IHU4ICp2YWx1ZSk7Cj4gwqB9Owo+IMKgCj4gwqBzdGF0aWMgaW5saW5lIGludCB0cG1fdGlz
X3JlYWRfYnl0ZXMoc3RydWN0IHRwbV90aXNfZGF0YSAqZGF0YSwgdTMyIGFkZHIsCj4gQEAgLTE4
OCw2ICsxOTAsMTQgQEAgc3RhdGljIGlubGluZSBpbnQgdHBtX3Rpc193cml0ZTMyKHN0cnVjdCB0
cG1fdGlzX2RhdGEgKmRhdGEsIHUzMiBhZGRyLAo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmM7
Cj4gwqB9Cj4gwqAKPiArc3RhdGljIGlubGluZSBpbnQgdHBtX3Rpc192ZXJpZnlfY3JjKHN0cnVj
dCB0cG1fdGlzX2RhdGEgKmRhdGEsIHNpemVfdCBsZW4sCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3Qg
dTggKnZhbHVlKQo+ICt7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKCFkYXRhLT5waHlfb3BzLT52ZXJp
ZnlfY3JjKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiArwqDC
oMKgwqDCoMKgwqByZXR1cm4gZGF0YS0+cGh5X29wcy0+dmVyaWZ5X2NyYyhkYXRhLCBsZW4sIHZh
bHVlKTsKPiArfQo+ICsKPiDCoHN0YXRpYyBpbmxpbmUgYm9vbCBpc19ic3codm9pZCkKPiDCoHsK
PiDCoCNpZmRlZiBDT05GSUdfWDg2CgpSZXZpZXdlZC1ieTogSmFya2tvIFNha2tpbmVuIDxqYXJr
a29Aa2VybmVsLm9yZz4KCkJSLCBKYXJra28KCg==

