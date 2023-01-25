Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514F867A970
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jan 2023 04:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjAYD7y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Jan 2023 22:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjAYD7x (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Jan 2023 22:59:53 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A96C3B3DD;
        Tue, 24 Jan 2023 19:59:52 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30P2G2Sr002408;
        Wed, 25 Jan 2023 03:59:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=uuiJH8YjO2+c+q+zzr4MO1DxH/FNu9H2XTbtEmBynsI=;
 b=ku5DMrJp7p9pIzkgme7aE+7kpx9kvlNOMQXK0Kh4TM5A5F5+4GWLNev6FL9WdifkMhZE
 zjrgZ+26x07Gsm4P2tK3xQZjwFsL8DlPruMpJXZaj7BnRoXyd41BCO5byZDbUJrvXC/d
 Ui8GADcT7EgTjA+6/Hzp+uHTmZcY856B+/94eZjHGJtxAWGZhECHwrUPRRhDRa9BPthj
 3WV7si3C7mlLK1ssnaq9+7wXaSteSUhzt6mtqTlfnzNcqJem50NzMgzSixs8spqyecSo
 Nfine21x5q+9Mp+7/dMwxKej2cV6+4ihjTqDsliLDJQdEOE2/JlKpGDtxNwIN3vkmjxS lA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3na838wfte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 03:59:40 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30P3uLDH016680;
        Wed, 25 Jan 2023 03:59:39 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3na838wfsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 03:59:39 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30P3dEdE019104;
        Wed, 25 Jan 2023 03:59:37 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6mjv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 03:59:37 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30P3xZZ322610280
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 03:59:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF64D20043;
        Wed, 25 Jan 2023 03:59:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71A5A20040;
        Wed, 25 Jan 2023 03:59:34 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 03:59:34 +0000 (GMT)
Received: from localhost (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id B9CF6600D5;
        Wed, 25 Jan 2023 14:59:30 +1100 (AEDT)
From:   Michael Ellerman <michaele@au1.ibm.com>
To:     Andrew Donnellan <ajd@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     sudhakar@linux.ibm.com, bgray@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, nayna@linux.ibm.com,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        gjoyce@linux.ibm.com, ruscur@russell.cc, gcwilson@linux.ibm.com,
        joel@jms.id.au
Subject: Re: [PATCH v4 21/24] powerpc/pseries: Pass PLPKS password on kexec
In-Reply-To: <700184879c5f78c72930ba69f09c9d4eddaf933f.camel@linux.ibm.com>
References: <20230120074306.1326298-1-ajd@linux.ibm.com>
 <20230120074306.1326298-22-ajd@linux.ibm.com>
 <CQ053TUZQIPP.1OHV7MVS4F4HT@bobo>
 <700184879c5f78c72930ba69f09c9d4eddaf933f.camel@linux.ibm.com>
Date:   Wed, 25 Jan 2023 14:59:30 +1100
Message-ID: <874jsfqn6l.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AgAjsWGpYHV2XTXQpjMH7k-gf4lfKQj6
X-Proofpoint-ORIG-GUID: 78vV16f0SF1vqq5MSoZDpsLm-ddIFycf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-24_17,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 mlxlogscore=819 adultscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1011 malwarescore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301250029
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

QW5kcmV3IERvbm5lbGxhbiA8YWpkQGxpbnV4LmlibS5jb20+IHdyaXRlczoNCj4gT24gVHVlLCAy
MDIzLTAxLTI0IGF0IDE0OjM2ICsxMDAwLCBOaWNob2xhcyBQaWdnaW4gd3JvdGU6DQo+PiANCj4+
ID4gK8KgwqDCoMKgwqDCoMKgcHJvcCA9IG9mX2ZpbmRfcHJvcGVydHkob2ZfY2hvc2VuLCAiaWJt
LHBscGtzLXB3IiwgJmxlbik7DQo+PiA+ICvCoMKgwqDCoMKgwqDCoGlmIChwcm9wKSB7DQo+PiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBvc3Bhc3N3b3JkbGVuZ3RoID0gKHUxNils
ZW47DQo+PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBvc3Bhc3N3b3JkID0ga3ph
bGxvYyhvc3Bhc3N3b3JkbGVuZ3RoLCBHRlBfS0VSTkVMKTsNCj4+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGlmICghb3NwYXNzd29yZCkgew0KPj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG9mX3JlbW92ZV9wcm9wZXJ0eShvZl9jaG9z
ZW4sIHByb3ApOw0KPj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJldHVybiAtRU5PTUVNOw0KPj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgfQ0KPj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbWVtY3B5KG9zcGFzc3dv
cmQsIHByb3AtPnZhbHVlLCBsZW4pOw0KPj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmV0dXJuIG9mX3JlbW92ZV9wcm9wZXJ0eShvZl9jaG9zZW4sIHByb3ApOw0KPj4gDQo+PiBX
aHkgZG8geW91IHJlbW92ZSB0aGUgcHJvcGVydHkgYWZ0ZXJ3YXJkPw0KPg0KPiBCZWNhdXNlIG90
aGVyd2lzZSB0aGUgcGFzc3dvcmQgd2lsbCBiZSBzaXR0aW5nIGFyb3VuZCBpbiAvcHJvYy9kZXZp
Y2UtDQo+IHRyZWUgZm9yIHRoZSB3b3JsZCB0byBnbyBhbmQgcmVhZC4NCg0KVGhlIGFib3ZlIHJl
bW92ZXMgaXQgZnJvbSB0aGUgdW5mbGF0dGVuZWQgdHJlZSwgYnV0IGl0IHdpbGwgc3RpbGwgZXhp
c3QNCmluIHRoZSBmbGF0dGVuZWQgdHJlZSwgd2hpY2ggaXMgcmVhZGFibGUgYnkgcm9vdCBpbiAv
c3lzL2Zpcm13YXJlL2ZkdC4NCg0KSSdtIG5vdCBzdXJlIGlmIHRoYXQncyBhIG1ham9yIHNlY3Vy
aXR5IHByb2JsZW0sIGJ1dCBpdCBkb2VzIHNlZW0gcmlza3kuDQoNClRvIHNjcnViIGl0IGZyb20g
dGhlIGZsYXQgdHJlZSB5b3UnZCBuZWVkIHRvIGhhdmUgYW4gZWFybHlfaW5pdF9kdCBzdHlsZQ0K
cm91dGluZSB0aGF0IGZpbmRzIHRoZSBwYXNzd29yZCBlYXJseSwgc2F2ZXMgdGhlIHZhbHVlIHNv
bWV3aGVyZSBmb3IgdGhlDQpwbHBrcyBkcml2ZXIsIGFuZCB0aGVuIHplcm9lcyBvdXQgdGhlIHZh
bHVlIGluIHRoZSBmbGF0IHRyZWUuIFNlZSB0aGUNCmV4YW1wbGUgb2Ygcm5nLXNlZWQgaW4gZWFy
bHlfaW5pdF9kdF9zY2FuX2Nob3NlbigpLg0KDQpjaGVlcnMNCg==
