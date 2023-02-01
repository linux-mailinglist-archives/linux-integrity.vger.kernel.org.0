Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61827685FC8
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Feb 2023 07:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjBAGce (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Feb 2023 01:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjBAGc3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Feb 2023 01:32:29 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031D1521FA;
        Tue, 31 Jan 2023 22:32:27 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3116VZsd013970;
        Wed, 1 Feb 2023 06:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=KtvOWY/RgxQHLtnWYGAXoYBF9LHCjUdaD3Hg5fuLSKg=;
 b=G8MuzEAqxXIQHnNKHt+5nv/2bbGvNYROuKwd9gAK5Lbmtae3028T0vQVzO4nyk3t8EI9
 bt89HlMYORJdnS/ABCjjVq2AGiY2/7sVZk8j31jKDSmr57jHOJEo2V0iGy9ftZi15SvN
 hInarY7a/PsJkEYLmBZyerijd/Tc1NpGOCWj3drC2JJE2SprIixGlXEqY0N4iN2ZabfL
 N5X2hakmWKK/jsA71FH0UokJSS2XgzOEjrAIVFfPp9aMA5kX67LWEmPGLJM+jpSQrBVt
 VkJNMzLBDThQEWpvd5snq299dqRet2msal/dnCsC9huUzbfQC5MluPjbShlXcNcUoFWI 1w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nfjw180g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 06:32:15 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3116WEH2015822;
        Wed, 1 Feb 2023 06:32:14 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nfjw180fe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 06:32:14 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30VG30OU001561;
        Wed, 1 Feb 2023 06:32:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3ncvv6b5b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 06:32:12 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3116WAS344040486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Feb 2023 06:32:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26CB220043;
        Wed,  1 Feb 2023 06:32:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 270AB2004B;
        Wed,  1 Feb 2023 06:32:09 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  1 Feb 2023 06:32:09 +0000 (GMT)
Received: from [10.61.2.128] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 219FE6051E;
        Wed,  1 Feb 2023 17:32:04 +1100 (AEDT)
Message-ID: <126118f816e9b24b2e459a3802a9ca01db64a24c.camel@linux.ibm.com>
Subject: Re: [PATCH v5 23/25] powerpc/pseries: Implement secvars for dynamic
 secure boot
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     ruscur@russell.cc, bgray@linux.ibm.com, nayna@linux.ibm.com,
        gcwilson@linux.ibm.com, gjoyce@linux.ibm.com, brking@linux.ibm.com,
        sudhakar@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        zohar@linux.ibm.com, joel@jms.id.au, npiggin@gmail.com
Date:   Wed, 01 Feb 2023 17:32:03 +1100
In-Reply-To: <00aa1164-5a90-7a72-1f0d-67a9561419cb@linux.ibm.com>
References: <20230131063928.388035-1-ajd@linux.ibm.com>
         <20230131063928.388035-24-ajd@linux.ibm.com>
         <00aa1164-5a90-7a72-1f0d-67a9561419cb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NBaQxBOlmqpQNQN8Qlv7wgp3LgI8YMWf
X-Proofpoint-ORIG-GUID: oP8rJGJhs628wLn65pZvMvNZUapA596D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_02,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 clxscore=1015 adultscore=0 mlxlogscore=642 malwarescore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

T24gVHVlLCAyMDIzLTAxLTMxIGF0IDEyOjExIC0wNTAwLCBTdGVmYW4gQmVyZ2VyIHdyb3RlOgo+
ID4gK3N0YXRpYyBpbnQgcGxwa3NfZ2V0X3ZhcmlhYmxlKGNvbnN0IGNoYXIgKmtleSwgdTY0IGtl
eV9sZW4sIHU4Cj4gPiAqZGF0YSwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1NjQgKmRhdGFfc2l6ZSkKPiA+ICt7Cj4gPiArwqDC
oMKgwqDCoMKgwqBzdHJ1Y3QgcGxwa3NfdmFyIHZhciA9IHswfTsKPiA+ICvCoMKgwqDCoMKgwqDC
oGludCByYyA9IDA7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqAvLyBXZSBzdWJ0cmFjdCAxIGZy
b20ga2V5X2xlbiBiZWNhdXNlIHdlIGRvbid0IG5lZWQgdG8KPiA+IGluY2x1ZGUgdGhlCj4gPiAr
wqDCoMKgwqDCoMKgwqAvLyBudWxsIHRlcm1pbmF0b3IgYXQgdGhlIGVuZCBvZiB0aGUgc3RyaW5n
Cj4gPiArwqDCoMKgwqDCoMKgwqB2YXIubmFtZSA9IGtjYWxsb2Moa2V5X2xlbiAtIDEsIHNpemVv
Zih3Y2hhcl90KSwKPiA+IEdGUF9LRVJORUwpOwo+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKCF2YXIu
bmFtZSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVOT01FTTsK
PiA+ICvCoMKgwqDCoMKgwqDCoHJjID0gdXRmOHNfdG9fdXRmMTZzKGtleSwga2V5X2xlbiAtIDEs
IFVURjE2X0xJVFRMRV9FTkRJQU4sCj4gPiAod2NoYXJfdCAqKXZhci5uYW1lLAo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBrZXlfbGVu
IC0gMSk7Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAocmMgPCAwKQo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGdvdG8gZXJyOwo+ID4gK8KgwqDCoMKgwqDCoMKgdmFyLm5hbWVsZW4g
PSByYyAqIDI7Cj4gCj4gQXJlIHlvdSBzdXJlIHRoaXMgaXMgbm90IGp1c3Qgc3VwcG9zZWQgdG8g
YmUgJ3JjJz8KCm5hbWVsZW4gaXMgYSBsZW5ndGggaW4gYnl0ZXMsIG5vdCBjaGFyYWN0ZXJzLCB3
aGlsZSB1dGY4c190b191dGYxNnMoKQpyZXR1cm5zIHRoZSBudW1iZXIgb2YgY2hhcmFjdGVycy4g
SSBzdXBwb3NlIHRoaXMgY291bGQgYmUgY2xlYXJlciBieQpjaGFuZ2luZyAyIHRvIHNpemVvZih3
Y2hhcl90KS4KCj4gCj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqB2YXIub3MgPSBQTFBLU19WQVJf
TElOVVg7Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoZGF0YSkgewo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHZhci5kYXRhID0gZGF0YTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqB2YXIuZGF0YWxlbiA9ICpkYXRhX3NpemU7Cj4gPiArwqDCoMKgwqDCoMKgwqB9
Cj4gPiArwqDCoMKgwqDCoMKgwqByYyA9IHBscGtzX3JlYWRfb3NfdmFyKCZ2YXIpOwo+ID4gKwo+
ID4gK8KgwqDCoMKgwqDCoMKgaWYgKHJjKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGdvdG8gZXJyOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgKmRhdGFfc2l6ZSA9IHZhci5k
YXRhbGVuOwo+ID4gKwo+ID4gK2VycjoKPiA+ICvCoMKgwqDCoMKgwqDCoGtmcmVlKHZhci5uYW1l
KTsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChyYyAmJiByYyAhPSAtRU5PRU5UKSB7Cj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcHJfZXJyKCJGYWlsZWQgdG8gcmVhZCB2YXJpYWJs
ZSAnJXMnOiAlZFxuIiwga2V5LAo+ID4gcmMpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoC8vIFJldHVybiAtRUlPIHNpbmNlIHVzZXJzcGFjZSBwcm9iYWJseSBkb2Vzbid0Cj4g
PiBjYXJlIGFib3V0IHRoZQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8vIHNw
ZWNpZmljIGVycm9yCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmMgPSAtRUlP
Owo+ID4gK8KgwqDCoMKgwqDCoMKgfQo+ID4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIHJjOwo+ID4g
K30KPiA+ICsKPiA+ICtzdGF0aWMgaW50IHBscGtzX3NldF92YXJpYWJsZShjb25zdCBjaGFyICpr
ZXksIHU2NCBrZXlfbGVuLCB1OAo+ID4gKmRhdGEsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdTY0IGRhdGFfc2l6ZSkKPiA+ICt7
Cj4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcGxwa3NfdmFyIHZhciA9IHswfTsKPiA+ICvCoMKg
wqDCoMKgwqDCoGludCByYyA9IDA7Cj4gPiArwqDCoMKgwqDCoMKgwqB1NjQgZmxhZ3M7Cj4gPiAr
Cj4gPiArwqDCoMKgwqDCoMKgwqAvLyBTZWN1cmUgdmFyaWFibGVzIG5lZWQgdG8gYmUgcHJlZml4
ZWQgd2l0aCA4IGJ5dGVzIG9mCj4gPiBmbGFncy4KPiA+ICvCoMKgwqDCoMKgwqDCoC8vIFdlIG9u
bHkgd2FudCB0byBwZXJmb3JtIHRoZSB3cml0ZSBpZiB3ZSBoYXZlIGF0IGxlYXN0Cj4gPiBvbmUg
Ynl0ZSBvZiBkYXRhLgo+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKGRhdGFfc2l6ZSA8PSBzaXplb2Yo
ZmxhZ3MpKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRUlOVkFM
Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgLy8gV2Ugc3VidHJhY3QgMSBmcm9tIGtleV9sZW4g
YmVjYXVzZSB3ZSBkb24ndCBuZWVkIHRvCj4gPiBpbmNsdWRlIHRoZQo+ID4gK8KgwqDCoMKgwqDC
oMKgLy8gbnVsbCB0ZXJtaW5hdG9yIGF0IHRoZSBlbmQgb2YgdGhlIHN0cmluZwo+ID4gK8KgwqDC
oMKgwqDCoMKgdmFyLm5hbWUgPSBrY2FsbG9jKGtleV9sZW4gLSAxLCBzaXplb2Yod2NoYXJfdCks
Cj4gPiBHRlBfS0VSTkVMKTsKPiBoZXJlIEkgd291bGQgdGhpbmsgdGhhdCBpdCBzaG91bGQgYmUg
a2V5X2xlbiAqIDIgLSAxIHNpbmNlCj4gdXRmOHNfdG9fdXRmMTZzIHByZXN1bWFibHkgbWFrZXMg
dGhlIHN0cmluZyBsb25nZXIKCk5vLCB3Y2hhcl90IGlzIHUxNiwgc28gdGhpcyBhbGxvY2F0ZXMg
KGtleV9sZW4gLSAxKSpzaXplb2YodTE2KSA9CihrZXlfbGVuIC0gMSkqMiBieXRlcy4KCi0tIApB
bmRyZXcgRG9ubmVsbGFuICAgIE96TGFicywgQURMIENhbmJlcnJhCmFqZEBsaW51eC5pYm0uY29t
ICAgSUJNIEF1c3RyYWxpYSBMaW1pdGVkCg==

