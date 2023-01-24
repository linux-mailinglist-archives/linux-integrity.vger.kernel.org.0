Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A86C678F65
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Jan 2023 05:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjAXEkj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Jan 2023 23:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjAXEki (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Jan 2023 23:40:38 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A26C367D9;
        Mon, 23 Jan 2023 20:40:37 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30O3hoIi017523;
        Tue, 24 Jan 2023 04:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=QXLqE/T7bAwvJzJIWwATw3ktqa0p9YuklkWDkkB+t7Y=;
 b=ewHPJkLr6OXLDUZLAlBlk4wz0aEuXKApKPl7oMDA76Npz8ZxMWBxRd5pLCUjnuRM0T4c
 TylpAVYWeXaaK4int1Mnr/BEgckwbIfsTqRR2dPF1o7gMcpfEEi7K+r5CXFsv/1CoPOp
 vR9AQXO5lYjF2h1Q+Y7ovRLSjPRDkmgqvQ75sEAmt/ov/IbNfGPS9TlbuW/txwjTlrhW
 xkCvEjWZw5cDUmhrZUJ28bN8WFU0jTNx9addQec6FwF5YpFaIro5Lb21BYN4xsd+/DIO
 kkyOJklx/by8ysYRaPYP8I4K7VRFmv5T0v45QBVaBknzL4gYLbr31zAh/UqpmzQ34Lid ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3na7pb0vf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 04:40:25 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30O4TMZZ020274;
        Tue, 24 Jan 2023 04:40:25 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3na7pb0ven-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 04:40:25 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30NImXpl015356;
        Tue, 24 Jan 2023 04:40:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n87afb6kv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 04:40:23 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30O4eKdg46989570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 04:40:21 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E49262004D;
        Tue, 24 Jan 2023 04:40:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69CC420040;
        Tue, 24 Jan 2023 04:40:20 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 24 Jan 2023 04:40:20 +0000 (GMT)
Received: from [10.61.2.128] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id BE41C60142;
        Tue, 24 Jan 2023 15:40:18 +1100 (AEDT)
Message-ID: <700184879c5f78c72930ba69f09c9d4eddaf933f.camel@linux.ibm.com>
Subject: Re: [PATCH v4 21/24] powerpc/pseries: Pass PLPKS password on kexec
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        linux-integrity@vger.kernel.org
Cc:     sudhakar@linux.ibm.com, bgray@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, nayna@linux.ibm.com,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        gjoyce@linux.ibm.com, ruscur@russell.cc, gcwilson@linux.ibm.com,
        joel@jms.id.au
Date:   Tue, 24 Jan 2023 15:40:13 +1100
In-Reply-To: <CQ053TUZQIPP.1OHV7MVS4F4HT@bobo>
References: <20230120074306.1326298-1-ajd@linux.ibm.com>
         <20230120074306.1326298-22-ajd@linux.ibm.com>
         <CQ053TUZQIPP.1OHV7MVS4F4HT@bobo>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HAUHhfmb7pqsS75y3Dq3ZvgVkJnnapud
X-Proofpoint-ORIG-GUID: Js0yc_bJV1-sIKYIoa7j66PpAaWLICbF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=679
 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301240039
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

T24gVHVlLCAyMDIzLTAxLTI0IGF0IDE0OjM2ICsxMDAwLCBOaWNob2xhcyBQaWdnaW4gd3JvdGU6
Cj4gCj4gPiArwqDCoMKgwqDCoMKgwqBwcm9wID0gb2ZfZmluZF9wcm9wZXJ0eShvZl9jaG9zZW4s
ICJpYm0scGxwa3MtcHciLCAmbGVuKTsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChwcm9wKSB7Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgb3NwYXNzd29yZGxlbmd0aCA9ICh1MTYp
bGVuOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG9zcGFzc3dvcmQgPSBremFs
bG9jKG9zcGFzc3dvcmRsZW5ndGgsIEdGUF9LRVJORUwpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGlmICghb3NwYXNzd29yZCkgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBvZl9yZW1vdmVfcHJvcGVydHkob2ZfY2hvc2VuLCBw
cm9wKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmV0dXJuIC1FTk9NRU07Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1lbWNweShvc3Bhc3N3b3JkLCBwcm9wLT52
YWx1ZSwgbGVuKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gb2Zf
cmVtb3ZlX3Byb3BlcnR5KG9mX2Nob3NlbiwgcHJvcCk7Cj4gCj4gV2h5IGRvIHlvdSByZW1vdmUg
dGhlIHByb3BlcnR5IGFmdGVyd2FyZD8KCkJlY2F1c2Ugb3RoZXJ3aXNlIHRoZSBwYXNzd29yZCB3
aWxsIGJlIHNpdHRpbmcgYXJvdW5kIGluIC9wcm9jL2RldmljZS0KdHJlZSBmb3IgdGhlIHdvcmxk
IHRvIGdvIGFuZCByZWFkLgoKLS0gCkFuZHJldyBEb25uZWxsYW4gICAgT3pMYWJzLCBBREwgQ2Fu
YmVycmEKYWpkQGxpbnV4LmlibS5jb20gICBJQk0gQXVzdHJhbGlhIExpbWl0ZWQK

