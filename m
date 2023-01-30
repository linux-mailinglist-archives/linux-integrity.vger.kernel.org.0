Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C3D680522
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Jan 2023 05:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbjA3EoK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 29 Jan 2023 23:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbjA3EoJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 29 Jan 2023 23:44:09 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2812199C1;
        Sun, 29 Jan 2023 20:44:07 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30U4h8Uw024946;
        Mon, 30 Jan 2023 04:43:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=a1VbUdfCKkh85LqnWQgDBN3SbItROV7P6Ok7+fU7Lso=;
 b=bEjcx5Bg8/ylKWeysLb6XYsK8d035HRIrd5NEcSJC9iCMwurIz0dwl3Yq03TCTQ5uPe8
 8VKB5hzr/UYk8V5/oUg5Ea293tMW+1golft8WeFGBnemnQqdSpGlJ/E9wzQZ/i82cMtJ
 xqigstn/8jFSoZ9DDQA2eBQ1+JWk8Z4KwslFEIa9JywPDndgCxF/jxUFKA5oCbzqYi5k
 tDlBgNNeGk3u4f+rViOTT7GbfFaaijuYKbG/u5POIn/ztxujb943p2RzMY7tsYZZnRcY
 y0SfwNInFhGHJ/m8WZX2cth8CFsxbcQ7IbLnPxy5+sSpIT8+tFkmYpGmluAM4E18T8ct uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nddhpnaxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 04:43:54 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30U4hCC8025867;
        Mon, 30 Jan 2023 04:43:53 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nddhpnawv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 04:43:53 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30THRS2Y012460;
        Mon, 30 Jan 2023 04:43:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3ncvs7hr3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 04:43:51 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30U4hm7V49807708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 04:43:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A546620040;
        Mon, 30 Jan 2023 04:43:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F30F20043;
        Mon, 30 Jan 2023 04:43:47 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 30 Jan 2023 04:43:47 +0000 (GMT)
Received: from [10.61.2.128] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id B0AE160151;
        Mon, 30 Jan 2023 15:43:45 +1100 (AEDT)
Message-ID: <63aaa01d1649f2905b3bff8009bb9c3a47c82e50.camel@linux.ibm.com>
Subject: Re: [PATCH v4 16/24] powerpc/pseries: Implement signed update for
 PLPKS objects
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        linux-integrity@vger.kernel.org
Cc:     sudhakar@linux.ibm.com, bgray@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, nayna@linux.ibm.com,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        gjoyce@linux.ibm.com, ruscur@russell.cc, gcwilson@linux.ibm.com,
        joel@jms.id.au
Date:   Mon, 30 Jan 2023 15:43:45 +1100
In-Reply-To: <CQ04OOT6CW1A.MCLZN2B4BTWK@bobo>
References: <20230120074306.1326298-1-ajd@linux.ibm.com>
         <20230120074306.1326298-17-ajd@linux.ibm.com>
         <CQ04OOT6CW1A.MCLZN2B4BTWK@bobo>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zPrBAUej9z1KNEd5uLhd4M8Ldux6midO
X-Proofpoint-GUID: PUADR4r-iCyJNKM07QEW5qCw8rIqU9ec
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_02,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=976 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 mlxscore=0 adultscore=0 clxscore=1015
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300042
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

T24gVHVlLCAyMDIzLTAxLTI0IGF0IDE0OjE2ICsxMDAwLCBOaWNob2xhcyBQaWdnaW4gd3JvdGU6
Cj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wc2VyaWVzL3BscGtzLmMK
PiA+IGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wc2VyaWVzL3BscGtzLmMKPiA+IGluZGV4IDEx
ODkyNDZiMDNkYy4uNzk2ZWQ1NTQ0ZWU1IDEwMDY0NAo+ID4gLS0tIGEvYXJjaC9wb3dlcnBjL3Bs
YXRmb3Jtcy9wc2VyaWVzL3BscGtzLmMKPiA+ICsrKyBiL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMv
cHNlcmllcy9wbHBrcy5jCj4gPiBAQCAtODEsNiArODEsMTIgQEAgc3RhdGljIGludCBwc2VyaWVz
X3N0YXR1c190b19lcnIoaW50IHJjKQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBlcnIgPSAtRU5PRU5UOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBicmVh
azsKPiA+IMKgwqDCoMKgwqDCoMKgwqBjYXNlIEhfQlVTWToKPiA+ICvCoMKgwqDCoMKgwqDCoGNh
c2UgSF9MT05HX0JVU1lfT1JERVJfMV9NU0VDOgo+ID4gK8KgwqDCoMKgwqDCoMKgY2FzZSBIX0xP
TkdfQlVTWV9PUkRFUl8xMF9NU0VDOgo+ID4gK8KgwqDCoMKgwqDCoMKgY2FzZSBIX0xPTkdfQlVT
WV9PUkRFUl8xMDBfTVNFQzoKPiA+ICvCoMKgwqDCoMKgwqDCoGNhc2UgSF9MT05HX0JVU1lfT1JE
RVJfMV9TRUM6Cj4gPiArwqDCoMKgwqDCoMKgwqBjYXNlIEhfTE9OR19CVVNZX09SREVSXzEwX1NF
QzoKPiA+ICvCoMKgwqDCoMKgwqDCoGNhc2UgSF9MT05HX0JVU1lfT1JERVJfMTAwX1NFQzoKPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXJyID0gLUVCVVNZOwo+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBicmVhazsKPiA+IMKgwqDCoMKgwqDCoMKgwqBjYXNl
IEhfQVVUSE9SSVRZOgo+IAo+IFRoaXMgaXMgYSBiaXQgc2FkIHRvIG1haW50YWluIGhlcmUuIEl0
J3MgZHVwbGljYXRpbmcgYml0cyB3aXRoCj4gaHZjc19jb252ZXJ0LCBhbmQgYSBidW5jaCBvZiBv
cGVuIGNvZGVkIHBsYWNlcy4gUHJvYmFibHkgbm90IHRoZQo+IHNlcmllcyB0byBkbyBhbnl0aGlu
ZyBhYm91dC4gV291bGQgYmUgbmljZSBpZiB3ZSBjb3VsZCBzdGFuZGFyZGlzZQo+IGl0IHRob3Vn
aC4KCkFncmVlZCAtIHRob3VnaCB3ZSdyZSBub3QgZ29pbmcgdG8gdG91Y2ggaXQgaW4gdGhpcyBz
ZXJpZXMuCgo+IAo+ID4gQEAgLTE4NCwxNCArMTkwLDE3IEBAIHN0YXRpYyBzdHJ1Y3QgbGFiZWwg
KmNvbnN0cnVjdF9sYWJlbChjaGFyCj4gPiAqY29tcG9uZW50LCB1OCB2YXJvcywgdTggKm5hbWUs
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgdTE2IG5hbWVsZW4pCj4gPiDCoHsKPiA+IMKgwqDCoMKgwqDC
oMKgwqBzdHJ1Y3QgbGFiZWwgKmxhYmVsOwo+ID4gLcKgwqDCoMKgwqDCoMKgc2l6ZV90IHNsZW47
Cj4gPiArwqDCoMKgwqDCoMKgwqBzaXplX3Qgc2xlbiA9IDA7Cj4gPiDCoAo+ID4gwqDCoMKgwqDC
oMKgwqDCoGlmICghbmFtZSB8fCBuYW1lbGVuID4gUExQS1NfTUFYX05BTUVfU0laRSkKPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7Cj4g
PiDCoAo+ID4gLcKgwqDCoMKgwqDCoMKgc2xlbiA9IHN0cmxlbihjb21wb25lbnQpOwo+ID4gLcKg
wqDCoMKgwqDCoMKgaWYgKGNvbXBvbmVudCAmJiBzbGVuID4gc2l6ZW9mKGxhYmVsLT5hdHRyLnBy
ZWZpeCkpCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIEVSUl9QVFIo
LUVJTlZBTCk7Cj4gPiArwqDCoMKgwqDCoMKgwqAvLyBTdXBwb3J0IE5VTEwgY29tcG9uZW50IGZv
ciBzaWduZWQgdXBkYXRlcwo+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKGNvbXBvbmVudCkgewo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNsZW4gPSBzdHJsZW4oY29tcG9uZW50KTsK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoc2xlbiA+IHNpemVvZihsYWJl
bC0+YXR0ci5wcmVmaXgpKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqByZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsKPiA+ICvCoMKgwqDCoMKgwqDCoH0K
PiAKPiBJcyB0aGlzIGFscmVhZHkgYSBidWc/IENvZGUgY2hlY2tzIGZvciBjb21wb25lbnQgIT0g
TlVMTCBidXQKPiBwcmV2aW91c2x5Cj4gY2FsbHMgc3RybGVuIHdoaWNoIHdvdWxkIG9vcHMgb24g
TlVMTCBjb21wb25lbnQgQUZBSUtTLiBHcmFudGVkCj4gbm90aGluZwo+IGlzIGFjdHVhbGx5IHVz
aW5nIGFueSBvZiB0aGlzIHRoZXNlIGRheXMuCgpUcnVlLCBpdCBzaG91bGQgaGF2ZSBiZWVuIGNo
ZWNraW5nIGZvciBOVUxMIGZpcnN0LCBidXQgYXMgeW91IHNheSBuby0Kb25lIGlzIHVzaW5nIGl0
LgoKPiAKPiBJdCBhbHJlYWR5IHNlZW1zIGxpa2UgaXQncyBzdXBwb3NlZCB0byBiZSBhbGxvd2Vk
IHRvIHJhZCBOVUxMCj4gY29tcG9uZW50Cj4gd2l0aCByZWFkX3ZhciB0aG91Z2g/IFdoeSB0aGUg
ZGlmZmVyZW5jZXMsIHdoeSBub3QgYWx3YXlzIGFsbG93IE5VTEwKPiBjb21wb25lbnQ/IChJIGFz
c3VtZSB0aGVyZSBpcyBzb21lIHJlYXNvbiwgSSBqdXN0IGRvbid0IGtub3cgYW55dGhpbmcKPiBh
Ym91dCBzZWN2YXIgb3Igc2VjdXJlIGJvb3QpLgoKSSB0aGluayB0aGUgY29tbWVudCBjb25mdXNl
cyBtb3JlIHRoYW4gaXQgY2xhcmlmaWVzLCBJJ2xsIHJlbW92ZSBpdC4KCkFzIHlvdSBzYXksIHJl
YWRfdmFyKCkgc2hvdWxkIHdvcmsgZmluZSB3aXRoIGNvbXBvbmVudCA9PSBOVUxMLCB0aG91Z2gK
d3JpdGVfdmFyKCkgY2hlY2tzIGl0LiBUaGUgb25seSBydWxlIEkgY2FuIGZpbmQgaW4gdGhlIHNw
ZWMgaXMgdGhhdApzaWduZWQgdXBkYXRlIGNhbGxzICptdXN0KiBzZXQgdGhlIGNvbXBvbmVudCB0
byBOVUxMLiBJJ20gc2Vla2luZwpjbGFyaWZpY2F0aW9uIG9uIHRoYXQuCgo+ID4gK0VYUE9SVF9T
WU1CT0wocGxwa3Nfc2lnbmVkX3VwZGF0ZV92YXIpOwo+IAo+IFNvcnJ5IEkgbWlzc2VkIGl0IGJl
Zm9yZSAtLSBjYW4gdGhpcyBiZSBhIF9HUEwgZXhwb3J0PwoKSW5kZWVkIGl0IHNob3VsZCBiZSAt
IGFjdHVhbGx5LCBJIHNob3VsZCBjaGVjayBpZiBJIGNhbiBnZXQgcmlkIG9mIHRoZQpleHBvcnQg
Y29tcGxldGVseS4uLgoKLS0gCkFuZHJldyBEb25uZWxsYW4gICAgT3pMYWJzLCBBREwgQ2FuYmVy
cmEKYWpkQGxpbnV4LmlibS5jb20gICBJQk0gQXVzdHJhbGlhIExpbWl0ZWQK

