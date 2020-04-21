Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F6C1B3181
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2020 22:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgDUU5l (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Apr 2020 16:57:41 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:37969 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726024AbgDUU5k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Apr 2020 16:57:40 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03LKr0TD006612;
        Tue, 21 Apr 2020 22:56:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=j9SS1EZoUQtOPJD0uGSwclXLav/m2BIW5dcTQ3lolI0=;
 b=auQaSA8fmyIq88q5+XHso/dP1TEvl6y44cPA9uQ1ceUBOEcSplObm1mEYGsBaTi8Neob
 xei+861dxTTkBemhfD4BTW5Atn8cs/pf7X/+oSCFLWEDI/8lhiiYXJTSrCec/fKiNJ3J
 oGXAjFXgqFsCMVwN/QAARU9gFCs+VDD0Fb3pTdiuZfSAc39+iYhsSgKPB6v62UyuODXP
 Zw8ccqMjdMIfMNA81xs7ob7du6VEGH9/bEsjjn7wuDwh7LmW00YbBvSKPwECleu70C+l
 ynBpwmEfyplYvMVJzb1MROpLlddTi+DPOVZhDiHr1kG/VUXyZgAqd6dDpYusnSL72s/H ZA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30fqawa6x4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Apr 2020 22:56:12 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 63AEE10002A;
        Tue, 21 Apr 2020 22:56:10 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 51C7E206494;
        Tue, 21 Apr 2020 22:56:10 +0200 (CEST)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 Apr
 2020 22:56:09 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Tue, 21 Apr 2020 22:56:09 +0200
From:   Benoit HOUYERE <benoit.houyere@st.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Omar Sandoval <osandov@osandov.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
CC:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "James Bottomley" <James.Bottomley@hansenpartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: RE: [PATCH v2] tpm_tis: work around status register bug in
 STMicroelectronics TPM
Thread-Topic: [PATCH v2] tpm_tis: work around status register bug in
 STMicroelectronics TPM
Thread-Index: AQHWF+MBKczi/o3brkCk2ElxkuJuPKiDvqJA
Date:   Tue, 21 Apr 2020 20:56:09 +0000
Message-ID: <3766ead79aa4415198bc5a8324f02f6e@SFHDAG3NODE3.st.com>
References: <c0ba1e2931ca7c46a21a43f2b9a6add2e188d6c8.1586996553.git.osandov@fb.com>
         <19d930ef-4090-3339-1088-c3579e8a080f@molgen.mpg.de>
         <20200416190249.GC701157@vader>
 <1587476664.5149.14.camel@linux.ibm.com>
In-Reply-To: <1587476664.5149.14.camel@linux.ibm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-21_09:2020-04-21,2020-04-21 signatures=0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQo+SGkgT21hciwNCj4NCj5PbiBUaHUsIDIwMjAtMDQtMTYgYXQgMTI6MDIgLTA3MDAsIE9tYXIg
U2FuZG92YWwgd3JvdGU6DQo+PiBPbiBUaHUsIEFwciAxNiwgMjAyMCBhdCAwODoyMjoxMEFNICsw
MjAwLCBQYXVsIE1lbnplbCB3cm90ZToNCj4+ID4gRGVhciBPbWFyLA0KPj4gPiANCj4+ID4gDQo+
PiA+IEFtIDE2LjA0LjIwIHVtIDAyOjIzIHNjaHJpZWIgT21hciBTYW5kb3ZhbDoNCj4+ID4gPiBG
cm9tOiBPbWFyIFNhbmRvdmFsIDxvc2FuZG92QGZiLmNvbT4NCj4+ID4gDQo+PiA+IFRoYW5rIHlv
dSBmb3IgdGhlIHBhdGNoLg0KPj4gPiANCj4+ID4gPiBXZSd2ZSBlbmNvdW50ZXJlZCBhIHBhcnRp
Y3VsYXIgbW9kZWwgb2YgU1RNaWNyb2VsZWN0cm9uaWNzIFRQTSANCj4+ID4gPiB0aGF0DQo+PiA+
IA0KPj4gPiBQbGVhc2UgYWRkIG1vZGVscyB5b3UgYXJlIGVuY291bnRlcmluZyB0aGlzIHdpdGgg
dG8gdGhlIGNvbW1pdCBtZXNzYWdlLg0KPj4gPiANCj4+ID4gPiB0cmFuc2llbnRseSByZXR1cm5z
IGEgYmFkIHZhbHVlIGluIHRoZSBzdGF0dXMgcmVnaXN0ZXIuIFRoaXMgDQo+PiA+ID4gY2F1c2Vz
IHRoZQ0KPj4gPiANCj4+ID4gSGF2ZSB5b3UgY29udGFjdGVkIFNUTU1pY3JvZWxlY3Ryb25pY3M/
DQo+DQo+QWxzbyBob3cgdHJhbnNpZW50IGlzIGl0PyDCoElzIHRoaXMgc29tZXRoaW5nIHRoYXQg
b25seSBoYXBwZW5zIGVhcmx5LCBmb3IgZXhhbXBsZSBiZWZvcmUgc2VsZnRlc3RzIGZpbmlzaGVz
PyDCoENvdWxkIHlvdSBnZXQgc29tZSBzdGF0aXN0aWNzIGhlcmU/DQo+DQo+PiA+IA0KPj4gPiA+
IGtlcm5lbCB0byBiZWxpZXZlIHRoYXQgdGhlIFRQTSBpcyByZWFkeSB0byByZWNlaXZlIGEgY29t
bWFuZCB3aGVuIA0KPj4gPiA+IGl0IGFjdHVhbGx5IGlzbid0LCB3aGljaCBpbiB0dXJuIGNhdXNl
cyB0aGUgc2VuZCB0byB0aW1lIG91dCBpbiANCj4+ID4gPiBnZXRfYnVyc3Rjb3VudCgpLiBJbiB0
ZXN0aW5nLCByZWFkaW5nIHRoZSBzdGF0dXMgcmVnaXN0ZXIgb25lIA0KPj4gPiA+IGV4dHJhIHRp
bWUgY29udmluY2VzIHRoZSBUUE0gdG8gcmV0dXJuIGEgdmFsaWQgdmFsdWUuDQo+DQo+SXMgdGhp
cyBvbmx5IGFmZmVjdGluZyBnZXRfYnVyc3Rjb3VudCgpPw0KPg0KSXNzdWUgc2VlbiBpcyB0aGF0
IFRQTSBoYXMgbm90IGhhZCB0aW1lIHRvIHVwZGF0ZSBTVFMgcmVnaXN0ZXIgYWZ0ZXIgbG9jYWxp
dHkgcmVxdWVzdCAoU1RTIEluaXRpYWwgdmFsdWUgPSAweEZGKSB3aGVuIFNUUyByZWdpc3RlciBy
ZWFkaW5nICh0cG1fdGlzX3N0YXR1cyhjaGlwKSkgb2NjdXJzIChmb3IgbGVzcyB0aGFuIDHCtXMp
LiBJdCdzIGhhcHBlbiB3aGVuIHRpbWUgYmV0d2VlbiB0d28gZXZlbnRzIGlzIHZlcnkgc2hvcnQg
KHdpdGggUEMgY2hpcHNldCwgSGlnaCBTUEkgY2xvY2sgZnJlcXVlbmN5IGFuZCBzbyBvbikuDQpB
cyBleHBsYWluZWQsIGF0IG5leHQgY29uZGl0aW9uIChpZiAoKHN0YXR1cyAmIFRQTV9TVFNfQ09N
TUFORF9SRUFEWSkgPT0gMCkgeykgIHN0YXR1cyB3aWxsIGJlIGF0IDB4RkYgYW5kIGNvbnNpZGVy
IHdyb25nbHkgaW4gVFBNIFJlYWR5IHN0YXRlIChjaGVjayBvbmx5IG9uZSBiaXQpLCBUUE0gaXMg
aW4gZmFjdCBpbiBpZGxlIHN0YXRlIGFuZCByZW1haW5zIGluIHRoaXMgc3RhdGUgYmVjYXVzZSAg
ZG9lcyBub3QgZXhlY3V0ZSAodHBtX3Rpc19yZWFkeShjaGlwKTspLg0KVFBNIGRyaXZlciBnb2Vz
IHRvICJvdXRfZXJyIiBhbmQgc3RvcHBlZCBhZnRlciB0aW1lb3V0ICg3NTAgbXMpIGR1cmluZyBn
ZXRfYnVyc3Rjb3VudCBmdW5jdGlvbiB3aGVyZSBUUE0gcmVwb3J0IDB4MDAgKGNvcnJlY3QgdmFs
dWUgaW4gVFBNIGlkbGUgc3RhdGUgYnV0IG5vdCBleHBlY3RlZCBpbiBSZWFkeSBTdGF0ZSkuDQoN
CnN0YXRpYyBpbnQgdHBtX3Rpc19zZW5kX2RhdGEoc3RydWN0IHRwbV9jaGlwICpjaGlwLCBjb25z
dCB1OCAqYnVmLCBzaXplX3QgbGVuKQ0Kew0KLi4uLi4NCglib29sIGl0cG0gPSBwcml2LT5mbGFn
cyAmIFRQTV9USVNfSVRQTV9XT1JLQVJPVU5EOw0KDQoJc3RhdHVzID0gdHBtX3Rpc19zdGF0dXMo
Y2hpcCk7DQoNCglpZiAoKHN0YXR1cyAmIFRQTV9TVFNfQ09NTUFORF9SRUFEWSkgPT0gMCkgew0K
CQl0cG1fdGlzX3JlYWR5KGNoaXApOw0KCQlpZiAod2FpdF9mb3JfdHBtX3N0YXQNCgkJICAgIChj
aGlwLCBUUE1fU1RTX0NPTU1BTkRfUkVBRFksIGNoaXAtPnRpbWVvdXRfYiwNCgkJICAgICAmcHJp
di0+aW50X3F1ZXVlLCBmYWxzZSkgPCAwKSB7DQoJCQlyYyA9IC1FVElNRTsNCgkJCWdvdG8gb3V0
X2VycjsNCgkJfQ0KCX0NCg0KCXdoaWxlIChjb3VudCA8IGxlbiAtIDEpIHsNCgkJYnVyc3RjbnQg
PSBnZXRfYnVyc3Rjb3VudChjaGlwKTsNCgkJaWYgKGJ1cnN0Y250IDwgMCkgew0KCQkJZGV2X2Vy
cigmY2hpcC0+ZGV2LCAiVW5hYmxlIHRvIHJlYWQgYnVyc3Rjb3VudFxuIik7DQoJCQlyYyA9IGJ1
cnN0Y250Ow0KCQkJZ290byBvdXRfZXJyOw0KCQl9DQo+PiA+ID4gDQo+PiA+ID4gU2lnbmVkLW9m
Zi1ieTogT21hciBTYW5kb3ZhbCA8b3NhbmRvdkBmYi5jb20+DQo+PiA+ID4gLS0tDQo+PiA+ID4g
ICBkcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jIHwgMTkgKysrKysrKysrKysrKysrKysr
Kw0KPj4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKykNCj4+ID4gPiANCj4+
ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYyANCj4+ID4g
PiBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMgaW5kZXggMjdjNmNhMDMxZTIzLi41
YTJmNmFjYWY3NjggDQo+PiA+ID4gMTAwNjQ0DQo+PiA+ID4gLS0tIGEvZHJpdmVycy9jaGFyL3Rw
bS90cG1fdGlzX2NvcmUuYw0KPj4gPiA+ICsrKyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19j
b3JlLmMNCj4+ID4gPiBAQCAtMjM4LDYgKzIzOCwyNSBAQCBzdGF0aWMgdTggdHBtX3Rpc19zdGF0
dXMoc3RydWN0IHRwbV9jaGlwICpjaGlwKQ0KPj4gPiA+ICAgCXJjID0gdHBtX3Rpc19yZWFkOChw
cml2LCBUUE1fU1RTKHByaXYtPmxvY2FsaXR5KSwgJnN0YXR1cyk7DQo+PiA+ID4gICAJaWYgKHJj
IDwgMCkNCj4+ID4gPiAgIAkJcmV0dXJuIDA7DQo+PiA+ID4gKwkvKg0KPj4gPiA+ICsJICogU29t
ZSBTVE1pY3JvZWxlY3Ryb25pY3MgVFBNcyBoYXZlIGEgYnVnIHdoZXJlIHRoZSBzdGF0dXMgcmVn
aXN0ZXIgaXMNCj4+ID4gPiArCSAqIHNvbWV0aW1lcyBib2d1cyAoYWxsIDFzKSBpZiByZWFkIGlt
bWVkaWF0ZWx5IGFmdGVyIHRoZSBhY2Nlc3MNCj4+ID4gPiArCSAqIHJlZ2lzdGVyIGlzIHdyaXR0
ZW4gdG8uIEJpdHMgMCwgMSwgYW5kIDUgYXJlIGFsd2F5cyBzdXBwb3NlZCB0byByZWFkDQo+PiA+
ID4gKwkgKiBhcyAwLCBzbyB0aGlzIGlzIGNsZWFybHkgaW52YWxpZC4gUmVhZGluZyB0aGUgcmVn
aXN0ZXIgYSBzZWNvbmQgdGltZQ0KPj4gPiA+ICsJICogcmV0dXJucyBhIHZhbGlkIHZhbHVlLg0K
Pj4gPiA+ICsJICovDQo+PiA+ID4gKwlpZiAodW5saWtlbHkoc3RhdHVzID09IDB4ZmYpKSB7DQo+
PiA+IA0KPj4gPiBJ4oCZZCBsaWtlIHRvIHNlZSBhIGRlYnVnIG1lc3NhZ2UgaGVyZSwgc2F5aW5n
IHRoZSBUUE0gaXMgYnVnZ3kuIE1heWJlIA0KPj4gPiB0aGUgbW9kZWwgY2FuIGJlIHByaW50ZWQg
dG8sIGFuZCB0aGF0IHRoZSBUUE0gbWFudWZhY3R1cmVyIHNob3VsZCBiZSBjb250YWN0ZWQuDQo+
PiANCj4+IEhvdyBjYW4gSSBnZXQgdGhlIG1vZGVsIGluZm9ybWF0aW9uPyAoU29ycnksIEknbSBu
b3QgdmVyeSBmYW1pbGlhciANCj4+IHdpdGggVFBNcywgSSdtIGp1c3QgdGhlIGd1eSBvbiB0aGUg
dGVhbSB0aGF0IGVuZGVkIHVwIHRyYWNraW5nIHRoaXMgDQo+PiBkb3duLikNCj4NCj4NCj5LZW4n
cyBwb3N0IHllc3RlcmRheSBzdWdnZXN0ZWQgdXNpbmcgYSB1c2Vyc3BhY2UgdG9vbC4NCj4NCj5J
biBnZW5lcmFsLCBMaW51eCBkb2VzIHN1cHBvcnQgYnVnZ3kgSFcsIGxpa2UgdGhlIGlUUE0gc3Vw
cG9ydC4gwqBBcyBQYXVsIHNhaWQsIHNlZSBpZiB0aGVyZSBpcyBhIHZlbmRvciBzb2x1dGlvbiBm
aXJzdC4gwqBXaGF0ZXZlciBmaXggaXMgdXBzdHJlYW1lZCBzaG91bGQgYmUgPnZlcnkgc3BlY2lm
aWMgd2l0aCBhIGNsZWFyIGV4cGxhbmF0aW9uIG9mIHRoZSBwcm9ibGVtLg0KDQo+dGhhbmtzLA0K
DQo+TWltaQ0KDQpJc3N1ZSBvY2N1cnMgb24gc2V2ZXJhbCBsZWdhY3kgbW9kZWxzIGFuZCBjb3Jy
ZWN0ZWQgb24gbGF0ZXN0IFRQTSB2ZXJzaW9ucy4gU2V2ZXJhbCBjb3JyZWN0aW9ucyBhcmUgcG9z
c2libGUuIE9tYXIncyBwcm9wb3NhbCBpcyBxdWl0ZSBzaW1wbGUsIHNob3J0IGFuZCBlZmZpY2ll
bnQuIFBlbmFsdHkgdGltZSBpcyBvbmx5IGNvbmRpdGlvbiBjaGVjayBidXQgZm9yIGFsbCBUUE1f
c3RhdHVzIGFjY2Vzcy4NCg0KT3RoZXIgcG9zc2liaWxpdHkgIGlzIHRvIGNoZWNrIHN0YXR1cyBy
ZWdpc3RlciB2YWxpZGl0eSAoYml0IDUgaXMgYWx3YXlzIGF0IDApIGF0IHRoZSBmaXJzdCByZWFk
aW5nIGFuZCBtb2RpZnkgd2FpdF9mb3Jfc3RhdCBmdW5jdGlvbiAoYWxyZWFkeSBpbnNlcnRlZCBm
b3IgSTJDIHBhdGNoKS4NCiANCnN0YXRpYyBpbnQgdHBtX3Rpc19zZW5kX2RhdGEoc3RydWN0IHRw
bV9jaGlwICpjaGlwLCBjb25zdCB1OCAqYnVmLCBzaXplX3QgbGVuKQ0Kew0KLi4uLi4NCglib29s
IGl0cG0gPSBwcml2LT5mbGFncyAmIFRQTV9USVNfSVRQTV9XT1JLQVJPVU5EOw0KDQoJLSBzdGF0
dXMgPSB0cG1fdGlzX3N0YXR1cyhjaGlwKTsNCgkrIGlmICh3YWl0X2Zvcl90cG1fc3RhdF9yZXN1
bHQNCgkJICAgIChjaGlwLCBUUE1fU1RTX0dPLCAwICxjaGlwLT50aW1lb3V0X2MsDQoJCSAgICAg
JnByaXYtPmludF9xdWV1ZSwgZmFsc2UpIDwgMCkgew0KCQkJcmMgPSAtRVRJTUU7DQoJCQlnb3Rv
IG91dF9lcnI7DQoJCX0NCglpZiAoKHN0YXR1cyAmIFRQTV9TVFNfQ09NTUFORF9SRUFEWSkgPT0g
MCkgew0KCQl0cG1fdGlzX3JlYWR5KGNoaXApOw0KDQoNCg0KLXN0YXRpYyBpbnQgd2FpdF9mb3Jf
dHBtX3N0YXQoc3RydWN0IHRwbV9jaGlwICpjaGlwLCB1OCBtYXNrLA0KLQkJdW5zaWduZWQgbG9u
ZyB0aW1lb3V0LCB3YWl0X3F1ZXVlX2hlYWRfdCAqcXVldWUsDQotCQlib29sIGNoZWNrX2NhbmNl
bCkNCitzdGF0aWMgaW50IHdhaXRfZm9yX3RwbV9zdGF0X3Jlc3VsdChzdHJ1Y3QgdHBtX2NoaXAg
KmNoaXAsIHU4IG1hc2ssDQorCQkJCSAgICB1OCBtYXNrX3Jlc3VsdCwgdW5zaWduZWQgbG9uZyB0
aW1lb3V0LA0KKwkJCQkgICAgd2FpdF9xdWV1ZV9oZWFkX3QgKnF1ZXVlLA0KKwkJCQkgICAgYm9v
bCBjaGVja19jYW5jZWwpDQogew0KIAl1bnNpZ25lZCBsb25nIHN0b3A7DQogCWxvbmcgcmM7DQpA
QCAtNTUsNyArNTYsNyBAQCBzdGF0aWMgaW50IHdhaXRfZm9yX3RwbV9zdGF0KHN0cnVjdCB0cG1f
Y2hpcCAqY2hpcCwgdTggbWFzaywNCiANCiAJLyogY2hlY2sgY3VycmVudCBzdGF0dXMgKi8NCiAJ
c3RhdHVzID0gY2hpcC0+b3BzLT5zdGF0dXMoY2hpcCk7DQotCWlmICgoc3RhdHVzICYgbWFzaykg
PT0gbWFzaykNCisJaWYgKChzdGF0dXMgJiBtYXNrKSA9PSBtYXNrX3Jlc3VsdCkNCiAJCXJldHVy
biAwOw0KIA0KIAlzdG9wID0gamlmZmllcyArIHRpbWVvdXQ7DQpAQCAtODMsNyArODQsNyBAQCBz
dGF0aWMgaW50IHdhaXRfZm9yX3RwbV9zdGF0KHN0cnVjdCB0cG1fY2hpcCAqY2hpcCwgdTggbWFz
aywNCiAJCQl1c2xlZXBfcmFuZ2UoVFBNX1RJTUVPVVRfVVNFQ1NfTUlOLA0KIAkJCQkgICAgIFRQ
TV9USU1FT1VUX1VTRUNTX01BWCk7DQogCQkJc3RhdHVzID0gY2hpcC0+b3BzLT5zdGF0dXMoY2hp
cCk7DQotCQkJaWYgKChzdGF0dXMgJiBtYXNrKSA9PSBtYXNrKQ0KKwkJCWlmICgoc3RhdHVzICYg
bWFzaykgPT0gbWFza19yZXN1bHQpDQogCQkJCXJldHVybiAwOw0KIAkJfSB3aGlsZSAodGltZV9i
ZWZvcmUoamlmZmllcywgc3RvcCkpOw0KIAl9DQoNCkJlc3QgUmVnYXJkcywNCg0KQmVub2l0IA0K
