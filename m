Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0C75019A3
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Apr 2022 19:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbiDNRKS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Apr 2022 13:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245598AbiDNRHh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Apr 2022 13:07:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4889735DFA;
        Thu, 14 Apr 2022 09:53:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9445B82AE8;
        Thu, 14 Apr 2022 16:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35736C385A1;
        Thu, 14 Apr 2022 16:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649955183;
        bh=IpYYeAQ6KoLNRNaExAXyGq7eNl9eMq0NHJWTamim55k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ObwEW4Ah7UXpwECxgpa2X5sokAilNrRPzW+6qFKNiKfeHVqVQ1dj3fExDrJ9AIkNO
         4Nf+WAtxvnNXvMMDk1P6SrCxUcUUzxRYGO1y8mMhawQb39KB1KoshZx1MhE81z2xAV
         ty0gwxV+q7OPvfCJT3SfXQqhgHx7V7UE5eIqn4WdiRGEqXIyf3/JzlDCeP0NwSMg06
         4LmMZrgY34Mh+NUpVXz5yT82ohgvQSsubh6cHslAkS+frCg5CokA/6PJE1gDoth6gU
         C2E+sNVjbav+WHoEhGuluC4zE75owTxlUUrv2/ZLf2H8qaMJ69Und0iU9bkOVDpcni
         6HUNbHbRZwrWQ==
Message-ID: <047c3145c93a35ec3096aad44b221bda7d9e12c7.camel@kernel.org>
Subject: Re: [PATCH] tpm: cr50: Add new device/vendor ID 0x504a6666
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     "Jes B. Klinke" <jbk@chromium.org>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org
Date:   Thu, 14 Apr 2022 19:51:55 +0300
In-Reply-To: <068becdf-2d88-65a1-5977-1fedd34a8f0b@molgen.mpg.de>
References: <20220405173741.4023216-1-jbk@chromium.org>
         <6528eec1-0ab1-a5ff-3e30-2e06256dfd04@molgen.mpg.de>
         <YlgOqpe85pe3P/JP@kernel.org>
         <068becdf-2d88-65a1-5977-1fedd34a8f0b@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

T24gVGh1LCAyMDIyLTA0LTE0IGF0IDE3OjA2ICswMjAwLCBQYXVsIE1lbnplbCB3cm90ZToKPiBE
ZWFyIEphcmtrbywKPiAKPiAKPiBBbSAxNC4wNC4yMiB1bSAxNDowOCBzY2hyaWViIEphcmtrbyBT
YWtraW5lbjoKPiA+IE9uIFRodSwgQXByIDA3LCAyMDIyIGF0IDEyOjIxOjQ0UE0gKzAyMDAsIFBh
dWwgTWVuemVsIHdyb3RlOgo+IAo+ID4gPiBUaGFuayB5b3UgZm9yIHlvdXIgcGF0Y2guCj4gPiA+
IAo+ID4gPiBBbSAwNS4wNC4yMiB1bSAxOTozNyBzY2hyaWViIEplcyBCLiBLbGlua2U6Cj4gPiA+
ID4gQWNjZXB0IG9uZSBhZGRpdGlvbmFsIG51bWVyaWNhbCB2YWx1ZSBvZiBESUQ6VklEIGZvciBu
ZXh0IGdlbmVyYXRpb24KPiA+ID4gPiBHb29nbGUgVFBNLCB0byBiZSB1c2VkIGluIGZ1dHVyZSBD
aHJvbWVib29rcy4KPiA+ID4gCj4gPiA+IE1heWJlIGV4dGVuZDoKPiA+ID4gCj4gPiA+IOKApiBH
b29nbGUgVFBNIHdpdGggbmV3IGZpcm13YXJlIOKApgo+ID4gPiAKPiA+ID4gVGhlIFRQTSB3aXRo
IHRoZSBuZXcgZmlybXdhcmUgaGFzIHRoZSBjb2RlIG5hbWUgVEk1MCwgYW5kIGdvaW5nIHRvIHVz
ZSB0aGUKPiA+ID4gc2FtZSBpbnRlcmZhY2VzLgo+ID4gPiAKPiA+ID4gPiBUaGlzIHBhdGNoIHRv
dWNoZXMgbW9yZSBsaW5lcyB0aGFuIG1heSBzZWVtIG5lY2Vzc2FyeSwgYXMgYSByZXN1bHQgb2YK
PiA+ID4gPiB0aGUgbmVlZCB0byBtb3ZlIHRoZSBlcnJvciBjYXNlIHRvIHNpdCBhZnRlciB0aGUg
dHdvIHJlY29nbml6ZWQgY2FzZXMuCj4gPiA+ID4gCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSmVz
IEIuIEtsaW5rZSA8amJrQGNocm9taXVtLm9yZz4KPiA+ID4gPiAtLS0KPiA+ID4gPiAKPiA+ID4g
PiDCoMKgIGRyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19pMmNfY3I1MC5jIHwgMjEgKysrKysrKysr
KysrKy0tLS0tLS0tCj4gPiA+ID4gwqDCoCAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygr
KSwgOCBkZWxldGlvbnMoLSkKPiA+ID4gPiAKPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9j
aGFyL3RwbS90cG1fdGlzX2kyY19jcjUwLmMgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfaTJj
X2NyNTAuYwo+ID4gPiA+IGluZGV4IGY2YzBhZmZiYjQ1NjcuLmJmNTRlYmQ2NzI0YjAgMTAwNjQ0
Cj4gPiA+ID4gLS0tIGEvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2kyY19jcjUwLmMKPiA+ID4g
PiArKysgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfaTJjX2NyNTAuYwo+ID4gPiA+IEBAIC0z
MSw2ICszMSw3IEBACj4gPiA+ID4gwqDCoCAjZGVmaW5lIFRQTV9DUjUwX1RJTUVPVVRfU0hPUlRf
TVPCoMKgwqDCoDLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKiBTaG9ydCB0aW1lb3V0
IGR1cmluZyB0cmFuc2FjdGlvbnMgKi8KPiA+ID4gPiDCoMKgICNkZWZpbmUgVFBNX0NSNTBfVElN
RU9VVF9OT0lSUV9NU8KgwqDCoMKgMjDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyogVGlt
ZW91dCBmb3IgVFBNIHJlYWR5IHdpdGhvdXQgSVJRICovCj4gPiA+ID4gwqDCoCAjZGVmaW5lIFRQ
TV9DUjUwX0kyQ19ESURfVklEwqDCoMKgwqDCoMKgwqDCoMKgMHgwMDI4MWFlMEzCoMKgwqDCoMKg
LyogRGV2aWNlIGFuZCB2ZW5kb3IgSUQgcmVnIHZhbHVlICovCj4gPiA+ID4gKyNkZWZpbmUgVFBN
X1RJNTBfSTJDX0RJRF9WSUTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMHg1MDRhNjY2NkzCoMKgwqDC
oMKgLyogRGV2aWNlIGFuZCB2ZW5kb3IgSUQgcmVnIHZhbHVlICovCj4gPiA+ID4gwqDCoCAjZGVm
aW5lIFRQTV9DUjUwX0kyQ19NQVhfUkVUUklFU8KgwqDCoMKgwqAzwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgLyogTWF4IHJldHJpZXMgZHVlIHRvIEkyQyBlcnJvcnMgKi8KPiA+ID4gPiDC
oMKgICNkZWZpbmUgVFBNX0NSNTBfSTJDX1JFVFJZX0RFTEFZX0xPwqDCoDU1wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoC8qIE1pbiB1c2VjcyBiZXR3ZWVuIHJldHJpZXMgb24gSTJDICovCj4g
PiA+ID4gwqDCoCAjZGVmaW5lIFRQTV9DUjUwX0kyQ19SRVRSWV9ERUxBWV9IScKgwqA2NcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKiBNYXggdXNlY3MgYmV0d2VlbiByZXRyaWVzIG9uIEky
QyAqLwo+ID4gPiA+IEBAIC03NDIsMTYgKzc0MywyMCBAQCBzdGF0aWMgaW50IHRwbV9jcjUwX2ky
Y19wcm9iZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50KQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKg
wqB9Cj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoHZlbmRvciA9IGxlMzJfdG9fY3B1cCgoX19sZTMy
ICopYnVmKTsKPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqBpZiAodmVuZG9yICE9IFRQTV9DUjUwX0ky
Q19ESURfVklEKSB7Cj4gPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9l
cnIoZGV2LCAiVmVuZG9yIElEIGRpZCBub3QgbWF0Y2ghIElEIHdhcyAlMDh4XG4iLCB2ZW5kb3Ip
Owo+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0cG1fY3I1MF9yZWxlYXNl
X2xvY2FsaXR5KGNoaXAsIHRydWUpOwo+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqByZXR1cm4gLUVOT0RFVjsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqBpZiAodmVuZG9yID09
IFRQTV9DUjUwX0kyQ19ESURfVklEKSB7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGRldl9pbmZvKGRldiwgImNyNTAgVFBNIDIuMCAoaTJjIDB4JTAyeCBpcnEgJWQgaWQg
MHgleClcbiIsCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgY2xpZW50LT5hZGRyLCBjbGllbnQtPmlycSwgdmVuZG9yID4+IDE2KTsKPiA+ID4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHRwbV9jaGlwX3JlZ2lzdGVy
KGNoaXApOwo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoH0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqBp
ZiAodmVuZG9yID09IFRQTV9USTUwX0kyQ19ESURfVklEKSB7Cj4gPiA+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGRldl9pbmZvKGRldiwgInRpNTAgVFBNIDIuMCAoaTJjIDB4JTAy
eCBpcnEgJWQgaWQgMHgleClcbiIsCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgY2xpZW50LT5hZGRyLCBjbGllbnQtPmlycSwgdmVuZG9yID4+
IDE2KTsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHRwbV9j
aGlwX3JlZ2lzdGVyKGNoaXApOwo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiA+IAo+ID4g
PiBCb3RoIGJyYW5jaGVzIGFyZSBxdWl0ZSBzaW1pbGFyLiBDYW4gYSB0ZXJuYXJ5IG9wZXJhdG9y
IGJlIHVzZWQ/Cj4gPiA+IAo+ID4gPiDCoMKgwqDCoCBkZXZfaW5mbyhkZXYsICIlcyBUUE0gMi4w
IChpMmMgMHglMDJ4IGlycSAlZCBpZCAweCV4KVxuIiwKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoCAo
dmVuZG9yID09IFRQTV9DUjUwX0kyQ19ESURfVklEKSA/ICJjcjUwIiA6ICJ0aTUwIiwgY2xpZW50
LT5hZGRyLAo+ID4gPiBjbGllbnQtPmlycSwgdmVuZG9yID4+IDE2KTsKPiA+ID4gwqDCoMKgwqAg
cmV0dXJuIHRwbV9jaGlwX3JlZ2lzdGVyKGNoaXApOwo+ID4gPiAKPiA+ID4gYW5kIHRoZSBvcmln
aW5hbCBmbG93IGJlIGxlZnQ/IChBIHNlcGFyYXRlIHZhcmlhYmxlIGNhbiBhbHNvIGJlIGFkZGVk
LikKPiA+ID4gCj4gPiA+ID4gLcKgwqDCoMKgwqDCoMKgZGV2X2luZm8oZGV2LCAiY3I1MCBUUE0g
Mi4wIChpMmMgMHglMDJ4IGlycSAlZCBpZCAweCV4KVxuIiwKPiA+ID4gPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGNsaWVudC0+YWRkciwgY2xpZW50LT5pcnEsIHZlbmRvciA+PiAx
Nik7Cj4gPiA+ID4gLQo+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoHJldHVybiB0cG1fY2hpcF9yZWdp
c3RlcihjaGlwKTsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqBkZXZfZXJyKGRldiwgIlZlbmRvciBJ
RCBkaWQgbm90IG1hdGNoISBJRCB3YXMgJTA4eFxuIiwgdmVuZG9yKTsKPiA+ID4gPiArwqDCoMKg
wqDCoMKgwqB0cG1fY3I1MF9yZWxlYXNlX2xvY2FsaXR5KGNoaXAsIHRydWUpOwo+ID4gPiA+ICvC
oMKgwqDCoMKgwqDCoHJldHVybiAtRU5PREVWOwo+ID4gPiA+IMKgwqAgfQo+ID4gPiA+IMKgwqAg
LyoqCj4gCj4gPiBPSywgdGhlc2UgYXJlIGxlZ2l0IHN1Z2dlc3Rpb25zLiBQYXVsLCBjYW4geW91
IGRvIHRoZXNlIGNoYW5nZXMgYW5kIGFkZCBteQo+ID4gcmV2aWV3ZWQtYnkgZm9yIHRoZSArMSB2
ZXJzaW9uPwo+IAo+IEkgZ3Vlc3MgeW91IG1lYW4gSmVzPwo+IAo+IAo+IEtpbmQgcmVnYXJkcywK
ClllYWgsIEkgbWVhbnQgSmVzIDotKQoKL0phcmtrbwo=

