Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86814CE125
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Mar 2022 00:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiCDXqo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Mar 2022 18:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiCDXqo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Mar 2022 18:46:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2495C85A;
        Fri,  4 Mar 2022 15:45:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38ACC61E62;
        Fri,  4 Mar 2022 23:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45400C340E9;
        Fri,  4 Mar 2022 23:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646437554;
        bh=kxEwkIIH3N4yAPxz2bl/0pR+zT9bsamEmj5iFbTaZhk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=vBmLYUTTeISNhFYkF3AOsLMtrMesAKJeMvIwvtjxhvYOWQ+sauQqowF9QJ2BUUZyB
         btFTYObW3yRODc9jN85vB+U88DGx1GVSC0t22K11gdikQ/VCjLPpMt7u9kcDieyl2t
         KmAhFk3oVH+7o6ViFclQK/W62le7qTL7jxtaU6Z1rOefAL0uipwXHPym2Ye2/Pq5HJ
         W1uxbVRj8SNi2sZo2KquHQMmSUCDN+yTqBkW56tvE0fzcSo3Z8jEdWb5sSO2o0CfyM
         gIJY7QP4sPuFXOPRWG3LML887FMC5Af5nuSsqpVfbGaJhXzHjLo5B262S1nyTIl1dU
         SAkjJDJE1imtQ==
Message-ID: <293a795f4d1ffabb263ef06de677ea5827765be5.camel@kernel.org>
Subject: Re: [PATCH v9 0/3] integrity: support including firmware
 ".platform" keys at build time
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, rnsastry@linux.ibm.com
Date:   Sat, 05 Mar 2022 01:45:08 +0200
In-Reply-To: <20220304175403.20092-1-nayna@linux.ibm.com>
References: <20220304175403.20092-1-nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

T24gRnJpLCAyMDIyLTAzLTA0IGF0IDEyOjU0IC0wNTAwLCBOYXluYSBKYWluIHdyb3RlOgo+IFNv
bWUgZmlybXdhcmUgc3VwcG9ydCBzZWN1cmUgYm9vdCBieSBlbWJlZGRpbmcgc3RhdGljIGtleXMg
dG8gdmVyaWZ5IHRoZQo+IExpbnV4IGtlcm5lbCBkdXJpbmcgYm9vdC4gSG93ZXZlciwgdGhlc2Ug
ZmlybXdhcmUgZG8gbm90IGV4cG9zZSBhbgo+IGludGVyZmFjZSBmb3IgdGhlIGtlcm5lbCB0byBs
b2FkIGZpcm13YXJlIGtleXMgb250byB0aGUgIi5wbGF0Zm9ybSIKPiBrZXlyaW5nLCBwcmV2ZW50
aW5nIHRoZSBrZXJuZWwgZnJvbSB2ZXJpZnlpbmcgdGhlIGtleGVjIGtlcm5lbCBpbWFnZQo+IHNp
Z25hdHVyZS4KPiAKPiBUaGlzIHBhdGNoc2V0IGV4cG9ydHMgbG9hZF9jZXJ0aWZpY2F0ZV9saXN0
KCkgYW5kIGRlZmluZXMgYSBuZXcgZnVuY3Rpb24KPiBsb2FkX2J1aWx0aW5fcGxhdGZvcm1fY2Vy
dCgpIHRvIGxvYWQgY29tcGlsZWQgaW4gY2VydGlmaWNhdGVzIG9udG8gdGhlCj4gIi5wbGF0Zm9y
bSIga2V5cmluZy4KPiAKPiBDaGFuZ2Vsb2c6Cj4gdjk6Cj4gKiBSZWJhc2VkIG9uIHRwbWRkIG1h
c3RlciBicmFuY2ggcmVwbyAtIAo+IGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC9qYXJra28vbGludXgtdHBtZGQuZ2l0Cj4gCj4gdjg6Cj4gKiBJbmNsdWRlcyBK
YXJra28ncyBmZWVkYmFjayBvbiBwYXRjaCBkZXNjcmlwdGlvbiBhbmQgcmVtb3ZlZCBSZXBvcnRl
ZC1ieQo+IGZvciBQYXRjaCAxLgo+IAo+IHY3Ogo+ICogSW5jbGR1ZXMgSmFya2tvJ3MgZmVlZGJh
Y2sgb24gcGF0Y2ggZGVzY3JpcHRpb24gZm9yIFBhdGNoIDEgYW5kIDMuCj4gCj4gdjY6Cj4gKiBJ
bmNsdWRlcyBKYXJra28ncyBmZWVkYmFjazoKPiDCoCogU3BsaXQgUGF0Y2ggMiBpbnRvIHR3by4K
PiDCoCogVXBkYXRlIFBhdGNoIGRlc2NyaXB0aW9uLgo+IAo+IHY1Ogo+ICogUmVuYW1lZCBsb2Fk
X2J1aWx0aW5fcGxhdGZvcm1fY2VydCgpIHRvIGxvYWRfcGxhdGZvcm1fY2VydGlmaWNhdGVfbGlz
dCgpCj4gYW5kIGNvbmZpZyBJTlRFR1JJVFlfUExBVEZPUk1fQlVJTFRJTl9LRVlTIHRvIElOVEVH
UklUWV9QTEFURk9STV9LRVlTLCBhcwo+IHN1Z2dlc3RlZCBieSBNaW1pIFpvaGFyLgo+IAo+IHY0
Ogo+ICogU3BsaXQgaW50byB0d28gcGF0Y2hlcyBhcyBwZXIgTWltaSBab2hhciBhbmQgRGltaXRy
aSBKb2huIExlZGtvdgo+IHJlY29tbWVuZGF0aW9uLgo+IAo+IHYzOgo+ICogSW5jbHVkZWQgSmFy
a2tvJ3MgZmVlZGJhY2sKPiDCoCoqIHVwZGF0ZWQgcGF0Y2ggZGVzY3JpcHRpb24gdG8gaW5jbHVk
ZSBhcHByb2FjaC4KPiDCoCoqIHJlbW92ZWQgZXh0ZXJuIGZvciBmdW5jdGlvbiBkZWNsYXJhdGlv
biBpbiB0aGUgLmggZmlsZS4KPiAqIEluY2x1ZGVkIGxvYWRfY2VydGlmaWNhdGVfbGlzdCgpIHdp
dGhpbiAjaWZkZWYgQ09ORklHX0tFWVMgY29uZGl0aW9uLgo+IAo+IHYyOgo+ICogRml4ZWQgdGhl
IGVycm9yIHJlcG9ydGVkIGJ5IGtlcm5lbCB0ZXN0IHJvYm90Cj4gKiBVcGRhdGVkIHBhdGNoIGRl
c2NyaXB0aW9uIGJhc2VkIG9uIEphcmtrbydzIGZlZWRiYWNrLgo+IAo+IE5heW5hIEphaW4gKDMp
Ogo+IMKgIGNlcnRzOiBleHBvcnQgbG9hZF9jZXJ0aWZpY2F0ZV9saXN0KCkgdG8gYmUgdXNlZCBv
dXRzaWRlIGNlcnRzLwo+IMKgIGludGVncml0eTogbWFrZSBpbnRlZ3JpdHlfa2V5cmluZ19mcm9t
X2lkKCkgbm9uLXN0YXRpYwo+IMKgIGludGVncml0eTogc3VwcG9ydCBpbmNsdWRpbmcgZmlybXdh
cmUgIi5wbGF0Zm9ybSIga2V5cyBhdCBidWlsZCB0aW1lCj4gCj4gwqBjZXJ0cy9NYWtlZmlsZcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoCA1ICsrLS0KPiDCoGNlcnRzL2JsYWNrbGlzdC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgLQo+IMKgY2VydHMvY29t
bW9uLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqAgMiArLQo+IMKgY2VydHMvY29tbW9uLmjCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgOSAtLS0tLS0t
Cj4gwqBjZXJ0cy9zeXN0ZW1fa2V5cmluZy5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqAgMSAtCj4gwqBpbmNsdWRlL2tleXMvc3lzdGVtX2tleXJpbmcu
aMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA2ICsrKysrCj4gwqBzZWN1cml0
eS9pbnRlZ3JpdHkvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHwgMTAgKysrKysrKwo+IMKgc2VjdXJpdHkvaW50ZWdyaXR5L01ha2VmaWxlwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTUgKysrKysrKysrKy0KPiDCoHNlY3VyaXR5L2lu
dGVncml0eS9kaWdzaWcuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAg
MiArLQo+IMKgc2VjdXJpdHkvaW50ZWdyaXR5L2ludGVncml0eS5owqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoCA2ICsrKysrCj4gwqAuLi4vaW50ZWdyaXR5L3BsYXRmb3JtX2NlcnRz
L3BsYXRmb3JtX2NlcnQuU8KgIHwgMjMgKysrKysrKysrKysrKysrKwo+IMKgLi4uL3BsYXRmb3Jt
X2NlcnRzL3BsYXRmb3JtX2tleXJpbmcuY8KgwqDCoMKgwqDCoMKgwqAgfCAyNiArKysrKysrKysr
KysrKysrKysrCj4gwqAxMiBmaWxlcyBjaGFuZ2VkLCA5MCBpbnNlcnRpb25zKCspLCAxNiBkZWxl
dGlvbnMoLSkKPiDCoGRlbGV0ZSBtb2RlIDEwMDY0NCBjZXJ0cy9jb21tb24uaAo+IMKgY3JlYXRl
IG1vZGUgMTAwNjQ0IHNlY3VyaXR5L2ludGVncml0eS9wbGF0Zm9ybV9jZXJ0cy9wbGF0Zm9ybV9j
ZXJ0LlMKPiAKPiAKPiBiYXNlLWNvbW1pdDogYzllNTRmMzg5NzZhMWMwZWM2OWMwYTYyMDhiM2Zk
NTVmY2ViMDFkMQoKVGhhbmtzIGZvciB0aGUgdHJvdWJsZSEgSSdsbCBwaWNrIHRoZXNlLgoKQlIs
IEphcmtrbwoK

