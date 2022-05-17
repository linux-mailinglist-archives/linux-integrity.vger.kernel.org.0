Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0484752AA41
	for <lists+linux-integrity@lfdr.de>; Tue, 17 May 2022 20:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352112AbiEQSNd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 May 2022 14:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352028AbiEQSNX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 May 2022 14:13:23 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55AF51329;
        Tue, 17 May 2022 11:12:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B4372CE1B8B;
        Tue, 17 May 2022 18:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8B1C34100;
        Tue, 17 May 2022 18:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652811153;
        bh=p7jmOET1fg/asHsIyFWI9moVO8ao+wZmw/Hn3Cysut8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sZr50USaCN4pVIx4i6btT6YLqq+PnmiI1/cxIPefMD6VbsfxIpC4mI0mwv4nVDQdj
         J210APDwuC0nGAy78Q3/aHExJfXhP+sF/dTrCmkfCkdA5COSMQLs86Uzz/UpO9BZiE
         unA5mJRQVuH19mtBdbCe7yc9RahmXZw3FcZyGKOiTsrRET/SRQT1/TcgjCEOTajTe5
         4uvuWW3HKJwGvtpG4H+3hBWgXvBRukmPm1y0qs/7PucLSriU22O8q49fqyonsr3NE1
         2t1O8zQCIqBzr+zVblb5BAdkqahmB2S1KNWrLXSTIzmFHdY+O3ePwApR+jqGSqbi1Y
         jm/AZXabctd0A==
Message-ID: <0e8da958a222e5c1dccaaf1600b08bdb8705b48e.camel@kernel.org>
Subject: Re: [PATCH v10 2/7] KEYS: trusted: allow use of kernel RNG for key
 material
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, kernel@pengutronix.de,
        Sumit Garg <sumit.garg@linaro.org>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        David Gstir <david@sigma-star.at>,
        Michael Walle <michael@walle.cc>,
        John Ernberg <john.ernberg@actia.se>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Horia =?UTF-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Tue, 17 May 2022 21:10:57 +0300
In-Reply-To: <YoPa7C8xs8lgKtwv@zx2c4.com>
References: <20220513145705.2080323-1-a.fatoum@pengutronix.de>
         <20220513145705.2080323-3-a.fatoum@pengutronix.de>
         <YoPa7C8xs8lgKtwv@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

T24gVHVlLCAyMDIyLTA1LTE3IGF0IDE5OjI3ICswMjAwLCBKYXNvbiBBLiBEb25lbmZlbGQgd3Jv
dGU6Cj4gT24gRnJpLCBNYXkgMTMsIDIwMjIgYXQgMDQ6NTc6MDBQTSArMDIwMCwgQWhtYWQgRmF0
b3VtIHdyb3RlOgo+ID4gK8KgwqDCoMKgwqDCoMKgdHJ1c3RlZC5ybmc9wqDCoMKgwqBbS0VZU10K
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgRm9ybWF0
OiA8c3RyaW5nPgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBUaGUgUk5HIHVzZWQgdG8gZ2VuZXJhdGUga2V5IG1hdGVyaWFsIGZvciB0cnVzdGVkIGtl
eXMuCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoENh
biBiZSBvbmUgb2Y6Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoC0gImtlcm5lbCIKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgLSB0aGUgc2FtZSB2YWx1ZSBhcyB0cnVzdGVkLnNvdXJjZTogInRwbSIgb3Ig
InRlZSIKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
LSAiZGVmYXVsdCIKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgSWYgbm90IHNwZWNpZmllZCwgImRlZmF1bHQiIGlzIHVzZWQuIEluIHRoaXMgY2FzZSwK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdGhlIFJO
RydzIGNob2ljZSBpcyBsZWZ0IHRvIGVhY2ggaW5kaXZpZHVhbCB0cnVzdCBzb3VyY2UuCj4gPiAr
Cj4gCj4gQXMgYSBnZW5lcmFsIG1lY2hhbmlzbSwgSSBvYmplY3QgdG8gdGhpcy4gVGhlIGtlcm5l
bCdzIFJORyBtdXN0IGJlCj4gdHJ1c3RlZCBpbiB0aGUgZmlyc3QgcGxhY2UgZm9yIGtleSBtYXRl
cmlhbC4gVGhhdCdzIHRoZSB3aG9sZSBwb2ludCBvZgo+IGl0LgoKSSB3b3VsZCByZWxheCB0aGlz
ICBhIGJpdDoga2VybmVsJ3MgUk5HIG11c3QgYmUgaW1wbGljaXRseSBtdXN0IGJlCnRydXN0ZWQu
IElmIHRoZSBwYXJhbWV0ZXIgaXMgdXNlZCwgeW91IG1ha2UgYW4gZXhwbGljaXQgY2hvaWNlIHRo
YXQKeW91IGFyZSBhd2FyZSBvZiB0aGUgdHJ1c3QuCgpJZiB0aGlzIHdhcyBvcHQtb3V0IHBhcmFt
ZXRlciwgaW5zdGVhZCBvZiBvcHQtaW4sIEkgd291bGQgZ2V0IHlvdXIKYXJndW1lbnQuCgo+IEhv
d2V2ZXIsIGl0IHNvdW5kcyBsaWtlIHlvdSdyZSBub3QgcHJvcG9zaW5nIGEgZ2VuZXJhbCBtZWNo
YW5pc20sIGJ1dAo+IGp1c3Qgc29tZXRoaW5nIHBhcnRpY3VsYXIgdG8gdGhpcyAidHJ1c3RlZCBr
ZXlzIiBidXNpbmVzcy4gSW4gdGhhdCBjYXNlLAo+IHRoaXMgc2hvdWxkIGJlIGEgbW9kdWxlIGZs
YWcsIGFuZCB0aHVzIG5vdCBkb2N1bWVudGVkIGhlcmUsIGJ1dCByYXRoZXIKPiBzb21lIHBsYWNl
IG5hbWVzcGFjZWQgdG8geW91ciB0cnVzdGVkIGtleXMgc3R1ZmYuICJ0cnVzdGVkX2tleXMucHJl
ZmVycmVkX3JuZz17d2hhdGV2ZXJ9IgoKSG93ZXZlciwgSSB0aGluayB0aGlzIGEgZ29vZCBwcm9w
b3NhbC4gTGV0J3MgbWFrZSBpdCBhIG1vZHVsZSBwYXJhbWV0ZXIKaW5zdGVhZC4KCj4gSmFzb24K
CkJSLCBKYXJra28K

