Return-Path: <linux-integrity+bounces-7572-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE35C35F91
	for <lists+linux-integrity@lfdr.de>; Wed, 05 Nov 2025 15:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BAFD3A4839
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Nov 2025 14:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F676328B7E;
	Wed,  5 Nov 2025 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kpbSCE/U"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B006B2FB97B;
	Wed,  5 Nov 2025 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762351668; cv=none; b=BOpFtxZV24gSZyja5msECi3TctqcSudfveJrX8tl2YHaC45IoC3dld2XN/MQvIiCDd70sUNvgZbYaJSRz3QieZjBnADcR2YiIrkRke8vhFSXEwdGBKSfigmbHwPr626hF8+90J77UZGf/vu7gbTViIqM2x3zNo2nE/D1X0Du6T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762351668; c=relaxed/simple;
	bh=tkdeOi7cY12aMcnr2J+SO43SXIWe+71wa+sOYjd1tME=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=jQQha9zvXDEkwa6Opd+8fyk42SBRKA/8NsEdAIJzx9Kpf8MlZ1pUH/X0nxcQ+YJZyNZljRoOOPytmweMVavRCqsSiyAPP48Qxdr7A+Z6H0oyg1AIfeApQdrByCq1WUE7uYPSKiLU8ryLH/mlWMTI04F8BAovmQeQtaohL3s6Syk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kpbSCE/U; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A550KcT001308;
	Wed, 5 Nov 2025 14:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tkdeOi
	7cY12aMcnr2J+SO43SXIWe+71wa+sOYjd1tME=; b=kpbSCE/Uz032aVhAyocG6o
	XPWHUtkwkmbMy8BRT1C09ac0T+e3B3EzS/u+RKqinc4I1hKlXWI0ROqjmo4q46/q
	4+EGoojfaUXuKXBAPb5W+eHYKBpexexlv8ex/2u3zR8/RmhK+oQ51zp+taheZf4w
	1RlzV84cQF/rvcnzs7W4sWbr88NJl1T7MQUyYblcQogYIl6drc8RW1QMhsTU54Ig
	e6tTNuIbDqYKT3wP3oGTnZm9McBEyFWeGMQSoWyugt8IBIMRmcxWkHZrac8K92vy
	e+zhyqIzH8vSZafpMCpkVMHc7gLg1XwmTxqqti/fbGfnR5uiOlIzwgah6NJyU17A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a57mr9ed4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 14:07:16 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A5DhEOo029586;
	Wed, 5 Nov 2025 14:07:16 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a57mr9ecu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 14:07:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5CZHQd018804;
	Wed, 5 Nov 2025 14:07:15 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5whngcw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 14:07:15 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A5E7EVj25428572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 14:07:14 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 606A15803F;
	Wed,  5 Nov 2025 14:07:14 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7CC858055;
	Wed,  5 Nov 2025 14:07:12 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.10.126])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Nov 2025 14:07:12 +0000 (GMT)
Message-ID: <0c7e94a436a3742003e5e1155a48480d8307a9c7.camel@linux.ibm.com>
Subject: Re: [PATCH v2] lsm,ima: new LSM hook
 security_kernel_module_read_file to access decompressed kernel module
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>, Coiby Xu <coxu@redhat.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        Karel Srot <ksrot@redhat.com>, James Morris <jmorris@namei.org>,
        "Serge E.
 Hallyn" <serge@hallyn.com>,
        Luis Chamberlain	 <mcgrof@kernel.org>,
        Petr
 Pavlu <petr.pavlu@suse.com>, Daniel Gomez	 <da.gomez@kernel.org>,
        Sami
 Tolvanen <samitolvanen@google.com>,
        Roberto Sassu	
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        open list
 <linux-kernel@vger.kernel.org>,
        "open list:MODULE SUPPORT"
 <linux-modules@vger.kernel.org>
In-Reply-To: <CAHC9VhRGwXvhU64Nk5jdmtPfrt9bbkzpLVqS0LRbtN3Q3HhnCw@mail.gmail.com>
References: <20250928030358.3873311-1-coxu@redhat.com>
	 <20251031074016.1975356-1-coxu@redhat.com>
	 <CAHC9VhRBXkW+XuqhxJvEOYR_VMxFh4TRWUtXzZky=AG_nyBYEQ@mail.gmail.com>
	 <baa39fcd1b6b485f14b8f06dcd96b81359e6e491.camel@linux.ibm.com>
	 <CAHC9VhToe-VNqbh6TY2iYnRvqTHRfQjnHYSRWYgt8K7NcLKMdg@mail.gmail.com>
	 <fftfj4o3kqxmfu3hb655xczqcddoeqjv55llsnwkrdu5isdm4z@6sqe3k24a6kk>
	 <CAHC9VhRGwXvhU64Nk5jdmtPfrt9bbkzpLVqS0LRbtN3Q3HhnCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Date: Wed, 05 Nov 2025 09:07:12 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eGRNDIJmH03w3Ati_fcyHVM2BapRwb3X
X-Authority-Analysis: v=2.4 cv=MKhtWcZl c=1 sm=1 tr=0 ts=690b5a14 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ouyXqMZaNgMXvW1HyOUA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: F6O3LgHbdETKh35Acolo2MDmhTEF-8n0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAwMSBTYWx0ZWRfXwgxkNudsW+/Z
 c4V8kB9fvoPo1uLUcZT4ADOgL33NRgN0fxLRhoY0hfX0CH4ihXzFVXSXAjNw11g4DTwdqTTuDTr
 bIa0jBJNeHo1Zb0TFPO7kvgu2N85xQGhYzybvwyXMe9N/mAXVnKt/wPAbkgUIodSwp+VwkdwmuX
 XH2WRZpwWKhTIxhlP72sQh/cbr2TgkppEou1P4Uk6v9+Hl+9q2QQjIp97lpGoIRSggWt82iZj+X
 7hN1x54bLh30VNwtaaN2EKcmJnlmrGpAN8URzk4dzkFpCMdmG+MGX25MPiYdstte7ZTZ6zTJkwc
 9rFT4d059QAfcfFGxuNPsUMuwM3bEjKWoAi7Z7l9Q43PUFRiz1Qf25DnHU9AH0++eJCTmi5q4I5
 ThbLz8FHREkyLZumasPEX5ruvMsfUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_05,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010001

T24gVHVlLCAyMDI1LTExLTA0IGF0IDIxOjQ3IC0wNTAwLCBQYXVsIE1vb3JlIHdyb3RlOgo+IEFz
c3VtaW5nIEknbSB1bmRlcnN0YW5kaW5nIHRoZSBwcm9ibGVtIGNvcnJlY3RseSwgSSB0aGluayB5
b3UncmUKPiBtYWtpbmcgdGhpcyBoYXJkZXIgdGhhbiBpdCBuZWVkcyB0byBiZS7CoCBJIGJlbGll
dmUgc29tZXRoaW5nIGxpa2UgdGhpcwo+IHNob3VsZCBzb2x2ZSB0aGUgcHJvYmxlbSB3aXRob3V0
IGhhdmluZyB0byBhZGQgbW9yZSBjb25kaXRpb25hbHMKPiBhcm91bmQgdGhlIGhvb2tzIGluIGtl
cm5lbF9yZWFkX2ZpbGUoKSwgYW5kIGxpbWl0aW5nIHRoZSBtdWx0aXBsZQo+IHNlY3VyaXR5X2tl
cm5lbF9wb3N0X3JlYWRfZmlsZSgpIGNhbGxzIHRvIGp1c3QgdGhlIGNvbXByZXNzZWQgY2FzZSAu
Li4KPiBhbmQgaG9uZXN0bHkgaW4gZWFjaCBvZiB0aGUgX3Bvc3RfcmVhZF9maWxlKCkgY2FsbHMg
aW4gdGhlIGNvbXByZXNzZWQKPiBjYXNlLCB0aGUgYnVmZmVyIGNvbnRlbnRzIGhhdmUgY2hhbmdl
ZCBzbyBpdCBzb21ld2hhdCBtYWtlcyBzZW5zZS4KCj4gR2l2ZW4gdGhlIGNvZGUgYmVsb3csIElN
QSBjb3VsZCBzaW1wbHkgaWdub3JlIHRoZQo+IFJFQURJTkdfTU9EVUxFX0NPTVBSRVNTRUQgY2Fz
ZSAob3Igd2hhdGV2ZXIgaXQgaXMgdGhlIElNQSBuZWVkcyB0byBkbwo+IGluIHRoYXQgY2FzZSkg
YW5kIGZvY3VzIG9uIHRoZSBSRUFESU5HX01PRFVMRSBjYXNlIGFzIGl0IGRvZXMgdG9kYXkuCj4g
SSBleHBlY3QgdGhlIGFzc29jaWF0ZWQgSU1BIHBhdGNoIHdvdWxkIGJlIGJvdGggdHJpdmlhbCBh
bmQgc21hbGwuCj4gCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9tb2R1bGUvbWFpbi5jIGIva2VybmVs
L21vZHVsZS9tYWluLmMKPiBpbmRleCBjNjZiMjYxODQ5MzYuLmI0MzVjNDk4ZWMwMSAxMDA2NDQK
PiAtLS0gYS9rZXJuZWwvbW9kdWxlL21haW4uYwo+ICsrKyBiL2tlcm5lbC9tb2R1bGUvbWFpbi5j
Cj4gQEAgLTM2NzUsMTcgKzM2NzUsMTkgQEAgc3RhdGljIGludCBpZGVtcG90ZW50X3dhaXRfZm9y
X2NvbXBsZXRpb24oc3RydWN0IGlkZW1wb3QKPiBlbnQgKnUpCj4gCj4gc3RhdGljIGludCBpbml0
X21vZHVsZV9mcm9tX2ZpbGUoc3RydWN0IGZpbGUgKmYsIGNvbnN0IGNoYXIgX191c2VyICogdWFy
Z3MsIGludAo+IGZsYWdzKQo+IHsKPiArwqDCoMKgwqDCoMKgIGJvb2wgY29tcHJlc3NlZCA9ICEh
KGZsYWdzICYgTU9EVUxFX0lOSVRfQ09NUFJFU1NFRF9GSUxFKTsKPiDCoMKgwqDCoMKgwqAgc3Ry
dWN0IGxvYWRfaW5mbyBpbmZvID0geyB9Owo+IMKgwqDCoMKgwqDCoCB2b2lkICpidWYgPSBOVUxM
Owo+IMKgwqDCoMKgwqDCoCBpbnQgbGVuOwo+IAo+IC3CoMKgwqDCoMKgwqAgbGVuID0ga2VybmVs
X3JlYWRfZmlsZShmLCAwLCAmYnVmLCBJTlRfTUFYLCBOVUxMLCBSRUFESU5HX01PRFVMRSk7Cj4g
K8KgwqDCoMKgwqDCoCBsZW4gPSBrZXJuZWxfcmVhZF9maWxlKGYsIDAsICZidWYsIElOVF9NQVgs
IE5VTEwsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgY29tcHJlc3NlZCA/IFJFQURJTkdfTU9EVUxFX0NPTVBSRVNTRUQgOiBSRUFE
SU5HXwo+IE1PRFVMRSk7Cj4gwqDCoMKgwqDCoMKgIGlmIChsZW4gPCAwKSB7Cj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBtb2Rfc3RhdF9pbmMoJmZhaWxlZF9rcmVhZHMpOwo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGxlbjsKPiDCoMKgwqDCoMKgwqAgfQo+IAo+
IC3CoMKgwqDCoMKgwqAgaWYgKGZsYWdzICYgTU9EVUxFX0lOSVRfQ09NUFJFU1NFRF9GSUxFKSB7
Cj4gK8KgwqDCoMKgwqDCoCBpZiAoY29tcHJlc3NlZCkgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaW50IGVyciA9IG1vZHVsZV9kZWNvbXByZXNzKCZpbmZvLCBidWYsIGxlbik7Cj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2ZnJlZShidWYpOyAvKiBjb21wcmVzc2VkIGRh
dGEgaXMgbm8gbG9uZ2VyIG5lZWRlZCAqLwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aWYgKGVycikgewo+IEBAIC0zNjkzLDYgKzM2OTUsMTQgQEAgc3RhdGljIGludCBpbml0X21vZHVs
ZV9mcm9tX2ZpbGUoc3RydWN0IGZpbGUgKmYsIGNvbnN0IGNoCj4gYXIgX191c2VyICogdWFyZ3Ms
IGludAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1vZF9z
dGF0X2FkZF9sb25nKGxlbiwgJmludmFsaWRfZGVjb21wcmVzc19ieXRlcyk7Cj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGVycjsKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiArCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZXJyID0gc2VjdXJpdHlfa2VybmVsX3Bvc3RfcmVhZF9maWxlKGYsCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoY2hhciAqKWluZm8uaGRyLCBpbmZv
LmxlbiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJF
QURJTkdfTU9EVUxFKTsKCldpdGhvdXQgY2hhbmdpbmcgdGhlIGVudW1lcmF0aW9uIGhlcmUsIElN
QSB3b3VsZCBub3QgYmUgYWJsZSB0byBkaWZmZXJlbnRpYXRlCnRoZSBmaXJzdCBjYWxsIHRvIHNl
Y3VyaXR5X2tlcm5lbF9wb3N0X3JlYWRfZmlsZSgpIGFuZCB0aGlzIG9uZS4gIFRoZSBmaXJzdCBj
YWxsCndvdWxkIHJlc3VsdCBpbiB1bm5lY2Vzc2FyeSBlcnJvciBtZXNzYWdlcy4KCkFkZGluZyBh
biBhZGRpdGlvbmFsIGNhbGwgdG8gc2VjdXJpdHlfa2VybmVsX3Bvc3RfcmVhZF9maWxlKCkgaGVy
ZSwgd291bGQKcmVxdWlyZSBkZWZpbmluZyAyIGFkZGl0aW9uYWwgZW51bWVyYXRpb25zOiBSRUFE
SU5HX01PRFVMRV9DT01QUkVTU0VELApSRUFESU5HX01PRFVMRV9ERUNPTVBSRVNTRUQuCgo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChlcnIpIHsKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbW9kX3N0YXRfaW5jKCZmYWlsZWRfa3JlYWRz
KTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IGVycjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gwqDCoMKgwqDCoMKgIH0g
ZWxzZSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbmZvLmhkciA9IGJ1ZjsKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGluZm8ubGVuID0gbGVuOwoKRGVmZXJyaW5nIHRo
ZSBzZWN1cml0eV9rZXJuZWxfcG9zdF9yZWFkX2ZpbGUoKSBjYWxsIHRvIGhlcmUsIGVsaW1pbmF0
ZXMgdGhlIG5lZWQKZm9yIGRlZmluaW5nIGFkZGl0aW9uYWwgZW51bWVyYXRpb25zLiAgKENvaWJ5
J3MgZmlyc3QgbGluay4pCgpBZGRpbmcgYW4gYWRkaXRpb25hbCBjYWxsIHRvIHNlY3VyaXR5X2tl
cm5lbF9wb3N0X3JlYWRfZmlsZSgpIGhlcmUsIHJlcXVpcmVzIDEKYWRkaXRpb25hbCBlbnVtZXJh
dGlvbi4gIChDb2lieSdzIDJuZCBsaW5rLikKCk1pbWkKCgo=


