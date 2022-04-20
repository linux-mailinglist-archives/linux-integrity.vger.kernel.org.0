Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10C05081E4
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Apr 2022 09:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359643AbiDTHVw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Apr 2022 03:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359633AbiDTHVv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Apr 2022 03:21:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1793AA66;
        Wed, 20 Apr 2022 00:19:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3439A6184B;
        Wed, 20 Apr 2022 07:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3D1C385A0;
        Wed, 20 Apr 2022 07:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650439145;
        bh=MlSQ8xFc5OFPhZ5ibnCLrulKg/FV8GBRSMSgv0s5I4c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HgCkESrOlnMkphJpGEHXgzPzsX/QoMzdnsbrZ378/RSgjUiXtU0/oQlL3gDERpIdn
         9W0/UaSo1gj0n4dpr1Na4jN6mli+MAwBQkfrfQ9L4LRMAPUTYNUBFInTkzdpe1NnSh
         XOe2TUQveooelo6aJlCKNaSVSmrdvl6CoSvkJOgScY3Qww14sbx/bN2HQ2zmBztj23
         mWyzYVil7IZSi+KytkiYg2vDZa9gD1+QfXKWryrgqSuj3oWZG53c37L3E0NXhHhrpj
         kn0vbAWnRSe3ZOvJjxJDeACSBHCCmTa9uMl98ekAG6Xz9ZClK7Gy947Y9RJySZwmNN
         e9wx1J64x+vkw==
Message-ID: <201df1fcf9f54283518ef2811cd7fa7b8ad37d0a.camel@kernel.org>
Subject: Re: [PATCH v2] tpm: cr50: Add new device/vendor ID 0x504a6666
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Jes B. Klinke" <jbk@chromium.org>, linux-integrity@vger.kernel.org
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org
Date:   Wed, 20 Apr 2022 10:17:51 +0300
In-Reply-To: <20220419163749.1.Ica39bd8d1494f750a70a668e5929f6e5e63241f2@changeid>
References: <20220419163749.1.Ica39bd8d1494f750a70a668e5929f6e5e63241f2@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

T24gVHVlLCAyMDIyLTA0LTE5IGF0IDE2OjM3IC0wNzAwLCBKZXMgQi4gS2xpbmtlIHdyb3RlOgo+
IEFjY2VwdCBvbmUgYWRkaXRpb25hbCBudW1lcmljYWwgdmFsdWUgb2YgRElEOlZJRCBmb3IgbmV4
dCBnZW5lcmF0aW9uCj4gR29vZ2xlIFRQTSB3aXRoIG5ldyBmaXJtd2FyZSwgdG8gYmUgdXNlZCBp
biBmdXR1cmUgQ2hyb21lYm9va3MuCj4gCj4gVGhlIFRQTSB3aXRoIHRoZSBuZXcgZmlybXdhcmUg
aGFzIHRoZSBjb2RlIG5hbWUgVEk1MCwgYW5kIGlzIGdvaW5nIHRvCj4gdXNlIHRoZSBzYW1lIGlu
dGVyZmFjZXMuCj4gCj4gU2lnbmVkLW9mZi1ieTogSmVzIEIuIEtsaW5rZSA8amJrQGNocm9taXVt
Lm9yZz4KPiBSZXZpZXdlZC1ieTogSmFya2tvIFNha2tpbmVuIDxqYXJra29Aa2VybmVsLm9yZz4K
PiAtLS0KPiAKPiDCoGRyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19pMmNfY3I1MC5jIHwgNyArKysr
LS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+
IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfaTJjX2NyNTAuYyBiL2Ry
aXZlcnMvY2hhci90cG0vdHBtX3Rpc19pMmNfY3I1MC5jCj4gaW5kZXggZjZjMGFmZmJiNDU2Ny4u
NGRkYjhmZjNhODU2OSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfaTJj
X2NyNTAuYwo+ICsrKyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19pMmNfY3I1MC5jCj4gQEAg
LTMxLDYgKzMxLDcgQEAKPiDCoCNkZWZpbmUgVFBNX0NSNTBfVElNRU9VVF9TSE9SVF9NU8KgwqDC
oMKgwqDCoDLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKiBTaG9ydCB0aW1lb3V0IGR1
cmluZyB0cmFuc2FjdGlvbnMgKi8KPiDCoCNkZWZpbmUgVFBNX0NSNTBfVElNRU9VVF9OT0lSUV9N
U8KgwqDCoMKgwqDCoDIwwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qIFRpbWVvdXQgZm9y
IFRQTSByZWFkeSB3aXRob3V0IElSUSAqLwo+IMKgI2RlZmluZSBUUE1fQ1I1MF9JMkNfRElEX1ZJ
RMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAweDAwMjgxYWUwTMKgwqDCoMKgwqAvKiBEZXZpY2UgYW5k
IHZlbmRvciBJRCByZWcgdmFsdWUgKi8KPiArI2RlZmluZSBUUE1fVEk1MF9JMkNfRElEX1ZJRMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAweDUwNGE2NjY2TMKgwqDCoMKgwqAvKiBEZXZpY2UgYW5kIHZl
bmRvciBJRCByZWcgdmFsdWUgKi8KPiDCoCNkZWZpbmUgVFBNX0NSNTBfSTJDX01BWF9SRVRSSUVT
wqDCoMKgwqDCoMKgwqAzwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyogTWF4IHJldHJp
ZXMgZHVlIHRvIEkyQyBlcnJvcnMgKi8KPiDCoCNkZWZpbmUgVFBNX0NSNTBfSTJDX1JFVFJZX0RF
TEFZX0xPwqDCoMKgwqA1NcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKiBNaW4gdXNlY3Mg
YmV0d2VlbiByZXRyaWVzIG9uIEkyQyAqLwo+IMKgI2RlZmluZSBUUE1fQ1I1MF9JMkNfUkVUUllf
REVMQVlfSEnCoMKgwqDCoDY1wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qIE1heCB1c2Vj
cyBiZXR3ZWVuIHJldHJpZXMgb24gSTJDICovCj4gQEAgLTc0MiwxNSArNzQzLDE1IEBAIHN0YXRp
YyBpbnQgdHBtX2NyNTBfaTJjX3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQpCj4gwqDC
oMKgwqDCoMKgwqDCoH0KPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqB2ZW5kb3IgPSBsZTMyX3RvX2Nw
dXAoKF9fbGUzMiAqKWJ1Zik7Cj4gLcKgwqDCoMKgwqDCoMKgaWYgKHZlbmRvciAhPSBUUE1fQ1I1
MF9JMkNfRElEX1ZJRCkgewo+ICvCoMKgwqDCoMKgwqDCoGlmICh2ZW5kb3IgIT0gVFBNX0NSNTBf
STJDX0RJRF9WSUQgJiYgdmVuZG9yICE9IFRQTV9USTUwX0kyQ19ESURfVklEKSB7Cj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfZXJyKGRldiwgIlZlbmRvciBJRCBkaWQgbm90
IG1hdGNoISBJRCB3YXMgJTA4eFxuIiwgdmVuZG9yKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHRwbV9jcjUwX3JlbGVhc2VfbG9jYWxpdHkoY2hpcCwgdHJ1ZSk7Cj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVOT0RFVjsKPiDCoMKgwqDCoMKgwqDC
oMKgfQo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgZGV2X2luZm8oZGV2LCAiY3I1MCBUUE0gMi4wIChp
MmMgMHglMDJ4IGlycSAlZCBpZCAweCV4KVxuIiwKPiArwqDCoMKgwqDCoMKgwqBkZXZfaW5mbyhk
ZXYsICIlcyBUUE0gMi4wIChpMmMgMHglMDJ4IGlycSAlZCBpZCAweCV4KVxuIiwKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZlbmRvciA9PSBUUE1fVEk1MF9JMkNfRElEX1ZJRCA/
ICJ0aTUwIiA6ICJjcjUwIiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjbGll
bnQtPmFkZHIsIGNsaWVudC0+aXJxLCB2ZW5kb3IgPj4gMTYpOwo+IC0KPiDCoMKgwqDCoMKgwqDC
oMKgcmV0dXJuIHRwbV9jaGlwX3JlZ2lzdGVyKGNoaXApOwo+IMKgfQo+IMKgCgpUaGFuayB5b3Us
IEkganVzdCBwaWNrZWQgdGhpcy4KCkJSLCBKYXJra28KCg==

