Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADFE8A688F
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Sep 2019 14:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfICM0L (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Sep 2019 08:26:11 -0400
Received: from mx0b-00176a03.pphosted.com ([67.231.157.48]:3230 "EHLO
        mx0a-00176a03.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726631AbfICM0L (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Sep 2019 08:26:11 -0400
Received: from pps.filterd (m0048300.ppops.net [127.0.0.1])
        by m0048300.ppops.net-00176a03. (8.16.0.27/8.16.0.27) with SMTP id x83C8PdG037956;
        Tue, 3 Sep 2019 08:26:09 -0400
From:   "Safford, David (GE Global Research, US)" <david.safford@ge.com>
To:     Seunghun Han <kkamagui@gmail.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Thread-Topic: Re: [PATCH 2/2] tpm: tpm_crb: enhance resource mapping
 mechanism for supporting AMD's fTPM
Thread-Index: AQHVXxlOrNmKX2KHXEaevQ/odv4D9acT5e0AgAAT9ID//79NoIAAcvSA///KVoCABgn4gP//4Hww
Date:   Tue, 3 Sep 2019 12:26:00 +0000
Message-ID: <BCA04D5D9A3B764C9B7405BBA4D4A3C035F1CF04@ALPMBAPA12.e2k.ad.ge.com>
References: <20190830095639.4562-1-kkamagui@gmail.com>
 <20190830095639.4562-3-kkamagui@gmail.com> <20190830124334.GA10004@ziepe.ca>
 <CAHjaAcQ0MrPCZUit7s0Rmqpwpp0w5jiYjNUNEEm2yc1AejZ3ng@mail.gmail.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035F1CC59@ALPMBAPA12.e2k.ad.ge.com>
 <CAHjaAcQu3jOSj0QV3u4GSgnhpkTmJTMqckY_cnuzeTY-HNUWcA@mail.gmail.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035F1CD06@ALPMBAPA12.e2k.ad.ge.com>
 <CAHjaAcRPg9-9MXiLH7AfJO6P1k25CSwJrSiuUwzFLwN5Ynr0DQ@mail.gmail.com>
In-Reply-To: <CAHjaAcRPg9-9MXiLH7AfJO6P1k25CSwJrSiuUwzFLwN5Ynr0DQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jTWpFeU5EY3pPVFV3WEdGd2NHUmhkR0ZjY205aGJXbHVaMXd3T1dRNE5E?=
 =?utf-8?B?bGlOaTB6TW1RekxUUmhOREF0T0RWbFpTMDJZamcwWW1FeU9XVXpOV0pjYlhO?=
 =?utf-8?B?bmMxeHRjMmN0Wm1JMFpEVmtZemt0WTJVME5TMHhNV1U1TFRobE16Z3RZVFJq?=
 =?utf-8?B?TTJZd1lqVTVPR0UyWEdGdFpTMTBaWE4wWEdaaU5HUTFaR05oTFdObE5EVXRN?=
 =?utf-8?B?VEZsT1MwNFpUTTRMV0UwWXpObU1HSTFPVGhoTm1KdlpIa3VkSGgwSWlCemVq?=
 =?utf-8?B?MGlNalE1TVNJZ2REMGlNVE15TVRFNU9EY3hOVGc1TURBNE1ETTVJaUJvUFNK?=
 =?utf-8?B?MmFEZFBjRUZRWldWRFdFSjZhbUZtWkhsNk1rMUdVazVqZUdjOUlpQnBaRDBp?=
 =?utf-8?B?SWlCaWJEMGlNQ0lnWW04OUlqRWlJR05wUFNKalFVRkJRVVZTU0ZVeFVsTlNW?=
 =?utf-8?B?VVpPUTJkVlFVRkZiME5CUVVOdVVYUlhPVlZ0VEZaQlpVZzVUbXgzUjBaVVNG?=
 =?utf-8?B?RTBaakF5V0VGWlZrMWtRVVJCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJTRUZCUVVGRVlVRlJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlJVRkJVVUZDUVVGQlFVWjBSMlZSZDBGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VW8wUVVGQlFtNUJSMVZCV0hkQ2FrRkhPRUZpWjBKdFFVZHJRVnBCUW14QlJ6?=
 =?utf-8?B?UkJaRUZDY0VGSFJVRmlRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGRlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFXZEJRVUZCUVVGdVowRkJRVWRqUVZwUlFtWkJSMmRCWVZGQ2JrRkhaMEZp?=
 =?utf-8?B?UVVJMVFVZE5RV0ozUW5WQlIxbEJZVkZDYTBGSFZVRmlaMEl3UVVkclFWbFJR?=
 =?utf-8?B?bk5CUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJV?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVU5CUVVGQlFVRkRaVUZCUVVGYWQwSnNRVVk0UVdKblFu?=
 =?utf-8?B?WkJSelJCWTBGQ01VRkhTVUZpUVVKd1FVZE5RVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUWtGQlFVRkJRVUZCUVVGSlFVRkJRVUZCUVQwOUlpOCtQQzl0?=
 =?utf-8?B?WlhSaFBnPT0=?=
x-dg-rorf: 
x-originating-ip: [3.159.19.191]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [PATCH 2/2] tpm: tpm_crb: enhance resource mapping mechanism for supporting
 AMD's fTPM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-03_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030129
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

PiA+ID4gPiBGaXJzdCwgeW91IG9ubHkgZm9yY2UgdGhlIHJlbWFwIGlmIHRoZSBvdmVybGFwIGlz
IHdpdGggTlZTLCBidXQgSQ0KPiA+ID4gPiBoYXZlIHN5c3RlbXMgd2hlcmUgdGhlIG92ZXJsYXAg
aXMgd2l0aCBvdGhlciByZXNlcnZlZCByZWdpb25zLiBZb3UNCj4gPiA+ID4gc2hvdWxkIGZvcmNl
IHRoZSByZW1hcCByZWdhcmRsZXNzLCBidXQgaWYgaXQgaXMgTlZTLCBncmFiIHRoZSBzcGFjZSBi
YWNrDQo+ID4gPiA+IGZyb20gTlZTLg0KPiA+ID4NCj4gPiA+IEkgZGlkbid0IGtub3cgYWJvdXQg
dGhhdC4gSSBqdXN0IGZvdW5kIHRoZSBjYXNlIGZyb20geW91ciB0aHJlYWQNCj4gPiA+IHRoYXQg
QU1EIHN5c3RlbSBhc3NpZ25lZCBUUE0gcmVnaW9uIGludG8gdGhlIHJlc2VydmVkIGFyZWEuIEhv
d2V2ZXIsDQo+ID4gPiBhcyBJIGtub3csIHRoZSByZXNlcnZlZCBhcmVhIGhhcyBubyBidXN5IGJp
dCBzbyB0aGF0IFRQTSBDUkIgZHJpdmVyDQo+ID4gPiBjb3VsZCBhc3NpZ24gYnVmZmVyIHJlc291
cmNlcyBpbiBpdC4gUmlnaHQ/IEluIG15IHZpZXcsIGlmIHlvdQ0KPiA+ID4gcGF0Y2hlZCB5b3Vy
IFRQTSBkcml2ZXIgd2l0aCBteSBwYXRjaCBzZXJpZXMsIHRoZW4gaXQgY291bGQgd29yay4NCj4g
PiA+IFdvdWxkIHlvdSBleHBsYWluIHdoYXQgaGFwcGVuZWQgaW4gVFBNIENSQiBkcml2ZXIgYW5k
IHJlc2VydmVkIGFyZWE/DQo+ID4NCj4gPiBHb29kIHF1ZXN0aW9uLiBJJ2xsIHRyeSBpdCBvdXQg
dGhpcyB3ZWVrZW5kLg0KPiANCj4gVGhhbmsgeW91IGZvciB5b3VyIGhlbHAuDQogDQpJIHRyaWVk
IHlvdXIgcGF0Y2ggb3V0IG9uIG15IHN5c3RlbXMgd2l0aCBhICJyZXNlcnZlZCIgYnV0IG5vdCAi
TlZTIg0KcmVnaW9uIGNvbmZsaWN0LCBhbmQgeW91IGFyZSBjb3JyZWN0IC0gdGhlIHJlZ2lvbiBp
cyBub3QgYnVzeSwgYW5kDQp0aGUgZHJpdmVyIGlzIGFibGUgdG8gbWFwIHRoZSBidWZmZXJzIHdp
dGggeW91ciBwYXRjaC4NCg0KPiBGaXJzdCBvZiBhbGwsIEkgbWlzdW5kZXJzdG9vZCB5b3VyIG1l
c3NhZ2UuDQo+IEkgaGF2ZSB0byB0ZWxsIHlvdSBhYm91dCB0aGUgYnVmZmVyIHNpemUgZXhhY3Rs
eS4gVGhlIGNvbW1hbmQgYW5kIHJlc3BvbnNlDQo+IGJ1ZmZlciBzaXplcyBpbiBBQ1BJIHRhYmxl
IHdlcmUgMHgxMDAwIGFuZCB0aGlzIHdhcyA0Sywgbm90IDFLLiBUaGUgc2l6ZXMgaW4NCj4gdGhl
IGNvbnRyb2wgcmVnaXN0ZXIgd2VyZSAweDQwMDAgYW5kIHRoaXMgd2FzIDE2SyAobGFyZ2UgYnVm
ZmVyIHNpemUpLCBub3QgNEsuDQo+IEkgaGF2ZSBiZWVuIHVzaW5nIHRoZSBUUE0gZm9yIG15IHJl
c2VhcmNoIGFuZCB0aGUgdHlwaWNhbCBjYXNlcyBsaWtlIGNyZWF0aW5nDQo+IHB1YmxpYy9wcml2
YXRlIGtleXMsIGVuY3J5cHRpbmcvZGVjcnlwdGluZyBkYXRhLCBzZWFsaW5nL3Vuc2VhbGluZyBh
IHNlY3JldGUsDQo+IGFuZCBnZXR0aW5nIHJhbmRvbSBudW1iZXJzIGFyZSBub3Qgb3ZlciA0SyBi
dWZmZXIuIFNvLCBhcyB5b3Uga25vdywgSSB0aGluaw0KPiB0aGUgNEsgYnVmZmVyIGNhbiBoYW5k
bGUgdGhlIG1vc3QgY2FzZXMgYW5kIHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIG9mDQo+IGNy
Yl9maXh1cF9jbWRfc2l6ZSgpIHdvcmtzIHdlbGwuIElmIHlvdSBjb25jZXJuIHRoZSBzcGVjaWZp
YyBjYXNlIHRoYXQgdXNlcw0KPiBvdmVyIDRLIGJ1ZmZlciwgcGxlYXNlIGxldCBtZSBrbm93Lg0K
DQpJIGhhdmUgcmVhZCBwb3N0aW5ncyBvZiBzb21lIHN5c3RlbXMgd2hlcmUgQUNQSSBzYXlzIDFL
LCBidXQgaW4gYWxsIG9mIG15IGNhc2VzDQp0aGF0IEkgY2FuIHRlc3QsICB5b3UgYXJlIGNvcnJl
Y3QgdGhhdCBBQ1BJIGlzIHNheWluZyA0SyBpbnN0ZWFkIG9mIHRoZSBkZXZpY2UncyAxNksuDQpJ
IHRyaWVkIHJlYWxseSBoYXJkLCBidXQgY291bGRuJ3Qgc2VuZCBhbnkgdmFsaWQgcmVxdWVzdHMg
b3ZlciA0SywgKEkgYmVsaWV2ZSB0aGF0J3MNCmFjdHVhbGx5IHRoZSBtYXggYnkgdGhlIHNwZWMp
LCBhbmQgdGhlcmVmb3JlIG5ldmVyIHNhdyBhbnkgZmFpbHVyZXMgb24gbXkNCnN5c3RlbXMuIEkg
dGhpbmsgdGhlIGRyaXZlciBiZWhhdmlvciBpcyB3cm9uZyBmb3IgdGhvc2Ugb3RoZXIgY2FzZXMs
IGJ1dCBwZXJoYXBzDQp0aGlzIHNob3VsZCB3YWl0IHVudGlsIHNvbWVvbmUgY2FuIGdldCBhY2Nl
c3MgYW5kIGRvIHRoZSB0ZXN0aW5nLg0KDQpTbyBJJ20gaGFwcHkgd2l0aCB5b3VyIHBhdGNoZXMs
IG90aGVyIHRoYW4gd2hhdCBpcyBkZWNpZGVkIGZvciB0aGUgbnZzIGRyaXZlcg0KY29uZmxpY3Qu
IEknbSB0ZXN0aW5nIHRoZW0gb24gc29tZSBwcm9kdWN0aW9uIHN5c3RlbXMsIGFuZCBoYXZlIHNl
ZW4gbm8gb3RoZXINCmlzc3Vlcy4NCg0KZGF2ZQ0K
