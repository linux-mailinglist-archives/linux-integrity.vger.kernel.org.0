Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA961A2742
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Apr 2020 18:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgDHQey (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Apr 2020 12:34:54 -0400
Received: from sonic313-14.consmr.mail.ne1.yahoo.com ([66.163.185.37]:39651
        "EHLO sonic313-14.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726891AbgDHQex (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Apr 2020 12:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586363692; bh=ZQr7Q2qY6Wc0DlLcKkZzE7OQpG6wWH4Sa9CraMNSEYg=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=q/syMqU6vsGIGIOCwn3ZhguA7ms5Oe9g3NSC4+IkZeyVkX+0XXPzgpHKdfD/8eCLaq+qd1rxvgW6EieF2KeNkqR+BrHKlEb1RZLKoGFBlW19H2gfIjcSNxayoNXClNFsRoN6Lr4yY/7GC59bLDjjRq5boDfqRhey02UblB45vEmTCYmRSjtZIuSsEY6jI/bSbWEk8aC8rTRkt7yP1B6o+61Q4taEbCTcdQupIibvUNA68AZz4xOxvHjNTQ/d8f+YJNSNH5xcUcrhyhdNYbSf+eyhx+xXbCitI4tamFummTS87WzbKvddYIXkbWHHvIeMdaPvjG/RaOIrmPq0DS/efg==
X-YMail-OSG: eXtDKrAVM1lucytYIwgHC4F6jw_UHyLUs1KOQ.0sbca2lrY4SdUhor3C_s0yG2L
 K.WI.fR7YaIVK5fjW8UcFRG8mhHRs3_58bLnpSBS1xnxHvVrmhYvcY6OVcssviLx9TnhoSU5g9QE
 9M_.bB_KskVt6T4_mrwQl8YGMd4v7nExU3vHjcxhbQS.J_HBc84wdbqeWtuAcJawYof8wQEz3cb8
 llnahc4V1ZFJEH8o0U0QwMYi6JtrqFO86dPZdCWuXgHfoGOUoql4WTTxDscwiTI8R7LqnHTBUWUQ
 T8JmV4V4AzhDjs8Qya2GNeczkcz6HYsNLmO_TUldxvQYzSY1fSYCW3m7ED1WbY65G7tXl1JG7Ypc
 g8JxmmrxcCpLRyqSN9w4zf_W5g0PoZ60u4sdbgXSWoI7mCUA50SHRKvLH.stHW372gDwkl25vRlw
 NaFsLiztPGO70XRFN8u4DhDGusEI3J3RU79ENWQPfrdrreuPdnzvtdT.Kh2ppd.e46a_1GqzN_zY
 5FGDzIz3XtXAGy3ioXlDJsAJYljf.xHKgycw2kNW2dsHeJbecZToNlHte27GkmN9S3bOsV8x1BUo
 iviFBDzvBHkiTG8_0ACtrGbrG2fJYmHgJyx.F1vR1W8rWoEPge9ZswEm1dZsAsekPqagdvgm.cc4
 iy3__glq55dL3PkjWJnVv608uj5N7BmH366j1Cwpw8ybaQpBdzuHmWwZQH42WSHDoZi_pDybxEHX
 8vXzMxd9XsI3zm.HHEvBU39I9kQPO0feDo5zEuiFDQ8JdxGfji9sRLPuWT9023mCf28K5xDd_x5y
 aI5oT.X3ika4yesw96Qyv7tfISxt5DsH2.wZ5bKsPVsOgSQ9x3_AwAukiIHr_yTzxm4AGVXqIMX5
 XRxiWhdPQ4rXv.hN_bqSeZ7ESbqjcVQ1nmXqJ1iEJi9Lo3wTb9_.Jtnd2Js0Rxm47ScWsbj4kb.1
 JGzXmmQnTV5BG36QB2RLyXic0w0rJcOnKcp1DbqCz84Sw9axxfesfFKaq6WZYD2aUz9GlbuqgOQ7
 npNeiJAFjJjlvAgRetInk1CtbgKR1DoLaUZ32WxLZdC88OTysQZdyhWNoMtYDtVQgkZlWpNzBTkW
 1gbiSzL23oWfJ9dPi_PBD3eAbhErUnbZnt37EfJBOZ9At5o_kWCn5XtidoX8R3etPhKdMFQ_aQo4
 BKI57IQRcSnvs8al0PbuSnzhRTikuxivUOcitWc.sYuTWY_4A3.BTkg0YVJQDBC1wy2kUROz2neo
 UrT8IV45s1s.Ee..4qzkDkJIy7kK84VOYqT5DW36bPP2ZWIrZaQluSAEc0bVAMlpXYyYdlN4ommK
 z2WVaZAmPw9BCNUhDmSY.Ra_alZr7j04cyhCUc7UKpweWY_umlOViaOvuMyB9Vx9z4Jy6TdY6.oR
 PVNf.8Q2RINYGVCcI0Ua5dtcAK6PhwDM.lhsyzuu99kY1OAMm4GdGTb.cVOHWIbH9SjkCkojH7PL
 9WRoAQsE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 8 Apr 2020 16:34:52 +0000
Received: by smtp405.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8ba99bdb05956187df044f24edf8a52b;
          Wed, 08 Apr 2020 16:34:48 +0000 (UTC)
Subject: Re: [RFC] IMA: New IMA measurements for dm-crypt and selinux
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        dm-devel@redhat.com
Cc:     jmorris@namei.org, chpebeni@linux.microsoft.com,
        nramas@linux.microsoft.com, balajib@microsoft.com,
        sashal@kernel.org, suredd@microsoft.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <f92bef0f-eb40-0e07-540c-321134e4b070@linux.microsoft.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <b8dcaa3d-5006-2730-aa57-fb99e13c4472@schaufler-ca.com>
Date:   Wed, 8 Apr 2020 09:34:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <f92bef0f-eb40-0e07-540c-321134e4b070@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Content-Language: en-US
X-Mailer: WebService/1.1.15620 hermes Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

T24gNC84LzIwMjAgMzoxOSBBTSwgVHVzaGFyIFN1Z2FuZGhpIHdyb3RlOg0KPiBUaGUgZ29h
bHMgb2YgdGhlIGtlcm5lbCBpbnRlZ3JpdHkgc3Vic3lzdGVtIGFyZSB0byBkZXRlY3QgaWYg
ZmlsZXMgaGF2ZQ0KPiBiZWVuIGFjY2lkZW50YWxseSBvciBtYWxpY2lvdXNseSBhbHRlcmVk
LCBib3RoIHJlbW90ZWx5IGFuZCBsb2NhbGx5LA0KPiBhcHByYWlzZSBhIGZpbGUncyBtZWFz
dXJlbWVudCBhZ2FpbnN0IGEgImdvb2QiIHZhbHVlIHN0b3JlZCBhcyBhbg0KPiBleHRlbmRl
ZCBhdHRyaWJ1dGUsIGFuZCBlbmZvcmNlIGxvY2FsIGZpbGUgaW50ZWdyaXR5IFsxXS4NCj4N
Cj4gVG8gYWNoaWV2ZSB0aGVzZSBnb2FscywgSU1BIHN1YnN5c3RlbSBtZWFzdXJlcyBzZXZl
cmFsIGluLW1lbW9yeQ0KPiBjb25zdHJ1Y3RzIGFuZCBmaWxlcy4NCj4NCj4gV2UgcHJvcG9z
ZSB0byBtZWFzdXJlIGNvbnN0cnVjdHMgaW4gZG0tY3J5cHQgYW5kIHNlbGludXggdG8gZnVy
dGhlcg0KPiBlbmhhbmNlIG1lYXN1cmluZyBjYXBhYmlsaXRpZXMgb2YgSU1BLg0KPg0KPiBJ
ZiB0aGVyZSBpcyBleGlzdGluZyBvciBwbGFubmVkIHdvcmsgdG8gbWVhc3VyZSBkbS1jcnlw
dCBhbmQgc2VsaW51eA0KPiBjb25zdHJ1Y3RzLCB3ZSB3b3VsZCBsaWtlIHRvIGNvbnRyaWJ1
dGUgdG8gdGhhdC4NCj4NCj4gZG0tY3J5cHQgaXMgYSBzdWJzeXN0ZW0gdXNlZCBmb3IgZW5j
cnlwdGlvbiBvZiB0aGUgYmxvY2sgZGV2aWNlLCB3aGljaA0KPiBpcyBlc3NlbnRpYWwgZm9y
IGVuc3VyaW5nIHByb3RlY3Rpb24gb2YgZGF0YSBhbmQgc2VjcmV0cyBhdCByZXN0Lg0KPg0K
PiBNZWFzdXJpbmcgZW5jcnlwdGlvbiBzdGF0dXMgb2YgdGhlIGRldmljZSB3aWxsIGVuc3Vy
ZSB0aGUgZGV2aWNlIGlzIG5vdA0KPiBtYWxpY2lvdXNseSByZXBvcnRpbmcgZmFsc2UgZW5j
cnlwdGlvbiBzdGF0dXMgLSB0aHVzLCBpdCBjYW4gYmUNCj4gZW50cnVzdGVkIHdpdGggc2Vu
c2l0aXZlIGRhdGEgdG8gYmUgcHJvdGVjdGVkIGF0IHJlc3QuDQo+DQo+IFNFTGludXggaXMg
YW4gaW1wbGVtZW50YXRpb24gb2YgbWFuZGF0b3J5IGFjY2VzcyBjb250cm9scyAoTUFDKSBv
bg0KPiBMaW51eC4gTWFuZGF0b3J5IGFjY2VzcyBjb250cm9scyBhbGxvdyBhbiBhZG1pbmlz
dHJhdG9yIG9mIGEgc3lzdGVtIHRvDQo+IGRlZmluZSBob3cgYXBwbGljYXRpb25zIGFuZCB1
c2VycyBjYW4gYWNjZXNzIGRpZmZlcmVudCByZXNvdXJjZXMgLSBzdWNoDQo+IGFzIGZpbGVz
LCBkZXZpY2VzLCBuZXR3b3JrcyBhbmQgaW50ZXItcHJvY2VzcyBjb21tdW5pY2F0aW9uLiBX
aXRoDQo+IFNFTGludXggYW4gYWRtaW5pc3RyYXRvciBjYW4gZGlmZmVyZW50aWF0ZSBhIHVz
ZXIgZnJvbSB0aGUgYXBwbGljYXRpb25zDQo+IGEgdXNlciBydW5zIFsyXS4NCj4NCj4gTWVh
c3VyaW5nIFNFTGludXggc3RhdHVzIGFuZCB2YXJpb3VzIFNFTGludXggcG9saWNpZXMgY2Fu
IGhlbHAgZW5zdXJlDQo+IG1hbmRhdG9yeSBhY2Nlc3MgY29udHJvbCBvZiB0aGUgc3lzdGVt
IGlzIG5vdCBjb21wcm9taXNlZC4NCj4NCj4gUHJvcG9zYWw6DQo+IC0tLS0tLS0tLQ0KPiBB
LiBNZWFzdXJpbmcgZG1jcnlwdCBjb25zdHJ1Y3RzOg0KPiDCoMKgwqAgV2UgY2FuIGFkZCBh
biBJTUEgaG9vayBpbiBjcnlwdF9jdHIoKSBwcmVzZW50IGluDQo+IMKgwqDCoCBkcml2ZXJz
L21kL2RtLWNyeXB0LmMsIHNvIHRoYXQgSU1BIGNhbiBzdGFydCBtZWFzdXJpbmcgdGhlIHN0
YXR1cyBvZg0KPiDCoMKgwqAgdmFyaW91cyBkbS1jcnlwdCB0YXJnZXRzIChyZXByZXNlbnRl
ZCBieSBjcnlwdF90YXJnZXQgc3RydWN0IC0gYWxzbw0KPiDCoMKgwqAgZGVmaW5lZCBpbiBk
bS1jcnlwdC5jKS4NCj4gwqDCoMKgIFRoZSBtYXBwaW5nIHRhYmxlWzNdIGhhcyBpbmZvcm1h
dGlvbiBvZiBkZXZpY2VzIGJlaW5nIGVuY3J5cHRlZA0KPiDCoMKgwqAgKHN0YXJ0IHNlY3Rv
ciwgc2l6ZSwgdGFyZ2V0IG5hbWUsIGN5cGhlciwga2V5LCBkZXZpY2UgcGF0aCwgYW5kDQo+
IMKgwqDCoCBvdGhlciBvcHRpb25hbCBwYXJhbWV0ZXJzLikNCj4gwqDCoMKgIGUuZy4NCj4g
wqDCoMKgIDAgNDE3NzkyIGNyeXB0IHNlcnBlbnQtY2JjLWVzc2l2OnNoYTI1Ng0KPiDCoMKg
wqAgYTdmNjdhZDUyMGJkODNiOTcyNWRmNmViZDc2YzNlZWUgMCAvZGV2L3NkYiAwIDEgYWxs
b3dfZGlzY2FyZHMNCj4NCj4gwqDCoMKgIFdlIGNhbiBwYXNzIHZhcmlvdXMgYXR0cmlidXRl
cyBvZiBtYXBwaW5nIHRhYmxlIHRvIElNQSB0aHJvdWdoIGEga2V5DQo+IMKgwqDCoCB2YWx1
ZSBwYWlyIG9mIHZhcmlvdXMgZG1jcnlwdCBjb25zdHJ1Y3RzLg0KPg0KPiDCoMKgwqAgUHJv
cG9zZWQgRnVuY3Rpb24gU2lnbmF0dXJlIG9mIHRoZSBJTUEgaG9vazoNCj4gwqDCoMKgIHZv
aWQgaW1hX2RtY3J5cHRfc3RhdHVzKHZvaWQgKmRtY3J5cHRfc3RhdHVzLCBpbnQgbGVuKTsN
Cj4NCj4gQi4gTWVhc3VyaW5nIHNlbGludXggY29uc3RydWN0czoNCj4gwqDCoMKgIFdlIHBy
b3Bvc2UgdG8gYWRkIGFuIElNQSBob29rIGluIGVuZm9yY2luZ19zZXQoKSBwcmVzZW50IHVu
ZGVyDQo+IMKgwqDCoCBzZWN1cml0eS9zZWxpbnV4L2luY2x1ZGUvc2VjdXJpdHkuaC4NCj4g
wqDCoMKgIGVuZm9yY2luZ19zZXQoKSBzZXRzIHRoZSBzZWxpbnV4IHN0YXRlIHRvIGVuZm9y
Y2luZy9wZXJtaXNzaXZlIGV0Yy4NCj4gwqDCoMKgIGFuZCBpcyBjYWxsZWQgZnJvbSBrZXkg
cGxhY2VzIGxpa2Ugc2VsaW51eF9pbml0KCksDQo+IMKgwqDCoCBzZWxfd3JpdGVfZW5mb3Jj
ZSgpIGV0Yy4NCj4gwqDCoMKgIFRoZSBob29rIHdpbGwgbWVhc3VyZSB2YXJpb3VzIGF0dHJp
YnV0ZXMgcmVsYXRlZCB0byBzZWxpbnV4IHN0YXR1cy4NCj4gwqDCoMKgIE1ham9yaXR5IG9m
IHRoZSBhdHRyaWJ1dGVzIGFyZSBwcmVzZW50IGluIHRoZSBzdHJ1Y3Qgc2VsaW51eF9zdGF0
ZQ0KPiDCoMKgwqAgcHJlc2VudCBpbiBzZWN1cml0eS9zZWxpbnV4L2luY2x1ZGUvc2VjdXJp
dHkuaA0KPiDCoMKgwqAgZS5nLg0KPiDCoMKgwqAgJHNlc3RhdHVzDQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgIFNFTGludXggc3RhdHVzOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVu
YWJsZWQNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgU0VMaW51eGZzIG1vdW50OsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAvc3lzL2ZzL3NlbGludXgNCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqAgU0VMaW51eCByb290IGRpcmVjdG9yeTrCoMKgwqDCoMKgIC9ldGMvc2VsaW51eA0KPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBMb2FkZWQgcG9saWN5IG5hbWU6wqDCoMKgwqDCoMKgwqDC
oMKgIGRlZmF1bHQNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgQ3VycmVudCBtb2RlOsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwZXJtaXNzaXZlDQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgIE1vZGUgZnJvbSBjb25maWcgZmlsZTrCoMKgwqDCoMKgwqAgcGVybWlzc2l2ZQ0K
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBQb2xpY3kgTUxTIHN0YXR1czrCoMKgwqDCoMKgwqDC
oMKgwqDCoCBlbmFibGVkDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIFBvbGljeSBkZW55X3Vu
a25vd24gc3RhdHVzOsKgIGFsbG93ZWQNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgTWVtb3J5
IHByb3RlY3Rpb24gY2hlY2tpbmc6wqAgcmVxdWVzdGVkIChpbnNlY3VyZSkNCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqAgTWF4IGtlcm5lbCBwb2xpY3kgdmVyc2lvbjrCoMKgIDMyDQo+DQo+
IMKgwqDCoCBUaGUgYWJvdmUgYXR0cmlidXRlcyB3aWxsIGJlIHNlcmlhbGl6ZWQgaW50byBh
IHNldCBvZiBrZXk9dmFsdWUNCj4gwqDCoMKgIHBhaXJzIHdoZW4gcGFzc2VkIHRvIElNQSBm
b3IgbWVhc3VyZW1lbnQuDQo+DQo+IMKgwqDCoCBQcm9wb3NlZCBGdW5jdGlvbiBTaWduYXR1
cmUgb2YgdGhlIElNQSBob29rOg0KPiDCoMKgwqAgdm9pZCBpbWFfc2VsaW51eF9zdGF0dXMo
dm9pZCAqc2VsaW51eF9zdGF0dXMsIGludCBsZW4pOw0KPg0KPiBQbGVhc2UgcHJvdmlkZSBj
b21tZW50c1xmZWVkYmFjayBvbiB0aGUgcHJvcG9zYWwuDQoNClRMO0RSIC0gV2h5IG1ha2Ug
dGhpcyBTRUxpbnV4IHNwZWNpZmljPw0KDQpJbnRlZ3JhdGluZyBJTUEgYW5kIFNFTGludXgg
aXMgYSBsYXllcmluZyB2aW9sYXRpb24gYXQgYmVzdC4NCldoeSBpc24ndCB0aGlzIGltYV9s
c21fc3RhdHVzKHZvaWQgKmxzbV9zdGF0dXMsIGludCBsZW4pPw0KT3IsIGJldHRlciB5ZXQs
IGhvdyBhYm91dCBpbWFfbHNtX3N0YXR1cyhjaGFyICpuYW1lLCB2b2lkICp2YWx1ZSwgaW50
IGxlbiksDQphbmQgeW91IHBhc3MgZWFjaCBuYW1lL3ZhbHVlIHBhaXIgc2VwYXJhdGVseT8g
VGhhdCBtYWtlcyB0aGUNCmludGVyZmFjZSBnZW5lcmFsbHkgdXNlZnVsLg0KDQpCZWxpZXZl
IGl0IG9yIG5vdCwgdGhlcmUgKkFSRSogc2VjdXJpdHkgbW9kdWxlcyB0aGF0DQphcmUgbm90
IFNFTGludXguIA0KDQo+DQo+IFRoYW5rcywNCj4gVHVzaGFyDQo+DQo+IFsxXSBodHRwczov
L3NvdXJjZWZvcmdlLm5ldC9wL2xpbnV4LWltYS93aWtpL0hvbWUvDQo+IFsyXSBodHRwczov
L3NlbGludXhwcm9qZWN0Lm9yZy9wYWdlL0ZBUQ0KPiBbM10gaHR0cHM6Ly9naXRsYWIuY29t
L2NyeXB0c2V0dXAvY3J5cHRzZXR1cC93aWtpcy9ETUNyeXB0DQo=
