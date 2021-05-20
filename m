Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA2B38AD23
	for <lists+linux-integrity@lfdr.de>; Thu, 20 May 2021 13:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242308AbhETL5f (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 May 2021 07:57:35 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3091 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236669AbhETLzf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 May 2021 07:55:35 -0400
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Fm7Bn1QpXz6J68Q;
        Thu, 20 May 2021 19:42:25 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 13:54:09 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Thu, 20 May 2021 13:54:09 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "mjg59@srcf.ucam.org" <mjg59@srcf.ucam.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/7] ima: Introduce template fields mntuidmap and
 mntgidmap
Thread-Topic: [PATCH 3/7] ima: Introduce template fields mntuidmap and
 mntgidmap
Thread-Index: AQHXTVYl5/ijYWmHy0e6NDJab3clu6rr+yiAgAABJoCAAEZSAA==
Date:   Thu, 20 May 2021 11:54:08 +0000
Message-ID: <f3dfccf2aa5f4c5b96ff6c55a222b7dd@huawei.com>
References: <20210520085701.465369-1-roberto.sassu@huawei.com>
 <20210520085701.465369-4-roberto.sassu@huawei.com>
 <20210520093659.oeeytegx2tvzp33e@wittgenstein>
 <20210520094105.x2k3bc53xejfl5b2@wittgenstein>
In-Reply-To: <20210520094105.x2k3bc53xejfl5b2@wittgenstein>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.221.98.153]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

PiBGcm9tOiBDaHJpc3RpYW4gQnJhdW5lciBbbWFpbHRvOmNocmlzdGlhbi5icmF1bmVyQHVidW50
dS5jb21dDQo+IFNlbnQ6IFRodXJzZGF5LCBNYXkgMjAsIDIwMjEgMTE6NDEgQU0NCj4gT24gVGh1
LCBNYXkgMjAsIDIwMjEgYXQgMTE6Mzc6MDdBTSArMDIwMCwgQ2hyaXN0aWFuIEJyYXVuZXIgd3Jv
dGU6DQo+ID4gT24gVGh1LCBNYXkgMjAsIDIwMjEgYXQgMTA6NTY6NTdBTSArMDIwMCwgUm9iZXJ0
byBTYXNzdSB3cm90ZToNCj4gPiA+IFRoaXMgcGF0Y2ggaW50cm9kdWNlcyB0aGUgbmV3IHRlbXBs
YXRlIGZpZWxkcyBtbnR1aWRtYXAgYW5kIG1udGdpZG1hcCwNCj4gPiA+IHdoaWNoIGluY2x1ZGUg
cmVzcGVjdGl2ZWx5IHRoZSBVSUQgYW5kIEdJRCBtYXBwaW5ncyBvZiB0aGUgaWRtYXBwZWQNCj4g
bW91bnQsDQo+ID4gPiBpZiB0aGUgdXNlciBuYW1lc3BhY2UgaXMgbm90IHRoZSBpbml0aWFsIG9u
ZS4NCj4gPiA+DQo+ID4gPiBUaGVzZSB0ZW1wbGF0ZSBmaWVsZHMsIHdoaWNoIHNob3VsZCBiZSBp
bmNsdWRlZCB3aGVuZXZlciB0aGUgaXVpZCBhbmQgdGhlDQo+ID4gPiBpZ2lkIGZpZWxkcyBhcmUg
aW5jbHVkZWQsIGFsbG93IHJlbW90ZSB2ZXJpZmllcnMgdG8gZmluZCB0aGUgb3JpZ2luYWwgVUlE
DQo+ID4gPiBhbmQgR0lEIG9mIHRoZSBpbm9kZSBkdXJpbmcgc2lnbmF0dXJlIHZlcmlmaWNhdGlv
bi4gVGhlIGl1aWQgYW5kIGlnaWQNCj4gPiA+IGZpZWxkcyBpbmNsdWRlIHRoZSBtYXBwZWQgVUlE
IGFuZCBHSUQgd2hlbiB0aGUgaW5vZGUgaXMgaW4gYW4gaWRtYXBwZWQNCj4gPiA+IG1vdW50Lg0K
PiA+ID4NCj4gPiA+IFRoaXMgc29sdXRpb24gaGFzIGJlZW4gcHJlZmVycmVkIHRvIHByb3ZpZGlu
ZyBhbHdheXMgdGhlIG9yaWdpbmFsIFVJRCBhbmQNCj4gPiA+IEdJRCwgcmVnYXJkbGVzcyBvZiB3
aGV0aGVyIHRoZSBpbm9kZSBpcyBpbiBhbiBpZG1hcHBlZCBtb3VudCBvciBub3QsIGFzDQo+ID4g
PiB0aGUgbWFwcGVkIFVJRCBhbmQgR0lEIGFyZSB0aG9zZSBzZWVuIGJ5IHByb2Nlc3NlcyBhbmQg
bWF0Y2hlZCB3aXRoDQo+IHRoZSBJTUENCj4gPiA+IHBvbGljeS4NCj4gPg0KPiA+IEhtLCBsb29r
aW5nIGF0IHRoZSBjb2RlIHRoaXMgZG9lc24ndCBzZWVtIGxpa2UgYSBnb29kIGlkZWEgdG8gbWUu
IEkNCj4gPiB0aGluayB3ZSBzaG91bGQgYXZvaWQgdGhhdCBhbmQganVzdCByZWx5IG9uIHRoZSBv
cmlnaW5hbCB1aWQgYW5kIGdpZC4NCj4gDQo+IEl0J2QgYmUgb2sgdG8gaW5jbHVkZSB0aGUgbWFw
cGVkIHVpZC9naWQgYnV0IGRvbid0IGNvcHkgdGhlIG1hcHBpbmcNCj4gaXRzZWxmLg0KDQpVaG0s
IHdlIHdvdWxkIG5lZWQgYSB3YXkgdG8gb2J0YWluIHRoZSBvcmlnaW5hbCBVSUQgYW5kIEdJRCB0
bw0KdmVyaWZ5IHRoZSBwb3J0YWJsZSBzaWduYXR1cmUuDQoNClJvYmVydG8NCg0KSFVBV0VJIFRF
Q0hOT0xPR0lFUyBEdWVzc2VsZG9yZiBHbWJILCBIUkIgNTYwNjMNCk1hbmFnaW5nIERpcmVjdG9y
OiBMaSBQZW5nLCBMaSBKaWFuLCBTaGkgWWFubGkNCg==
