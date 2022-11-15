Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903FA629AE3
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Nov 2022 14:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiKONnj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Nov 2022 08:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238476AbiKONnf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Nov 2022 08:43:35 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5488564C1
        for <linux-integrity@vger.kernel.org>; Tue, 15 Nov 2022 05:43:32 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFCpGq3011207;
        Tue, 15 Nov 2022 13:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=u3gCWquMOeUVHMWjV1qHCct2aGleYLZfBB8xkwjwHfs=;
 b=AfLkwjNxXKb7ZZ4ea+8GKkWlOivAF1H2JPgcoFHZpDDrY7ZCa/DhG3eH8QKIjDb1i+Ep
 ZIvGhfoXGFB060GCJNeMDyZWLBqKsHHMbZ3GRzumkBE0pxtnOpOnKZAIRbgN0jnbxEQA
 sraH0P28VLrHJrM5Ylt+JZqzZXmHhkwpY69ukvfENLjdTG2axqBRFIa8wm1dikHgWQ7H
 Fu7SWOVonI2piWxqAr+0wYXw19N4XZg+u1Uhu+9j2ooN30nJKrvRpXLyFsTh5X0As22O
 A2cSumg8Z5t/nrrt0CgOQ9djdofhrjAWD3CBaMEADGTL63MPmKy1uFJTI+/bO65atfPe kA== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kvb4rh9km-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 13:43:27 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AFDKZgs003619;
        Tue, 15 Nov 2022 13:43:26 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01dal.us.ibm.com with ESMTP id 3kt349hkgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 13:43:26 +0000
Received: from smtpav05.dal12v.mail.ibm.com ([9.208.128.132])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AFDhNAD7340790
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 13:43:23 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C62C5804C;
        Tue, 15 Nov 2022 13:43:25 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17D1958056;
        Tue, 15 Nov 2022 13:43:25 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.19.60])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 15 Nov 2022 13:43:25 +0000 (GMT)
Message-ID: <df8c5ff94c0297754c0649be0bc0ee1427a853c1.camel@linux.ibm.com>
Subject: Re: [RFC PATCH ima-evm-utils] Save ima-evm-utils sourceforge wiki
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>
Date:   Tue, 15 Nov 2022 08:43:24 -0500
In-Reply-To: <Y3OG3vzaPYCWntCa@pevik>
References: <20221114222451.832058-1-zohar@linux.ibm.com>
         <Y3OG3vzaPYCWntCa@pevik>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mG-YACZ6HNHm08P96Mas4p-bJi0MoR1G
X-Proofpoint-ORIG-GUID: mG-YACZ6HNHm08P96Mas4p-bJi0MoR1G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 phishscore=0 mlxscore=0 clxscore=1015 malwarescore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211150091
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

On Tue, 2022-11-15 at 13:32 +0100, Petr Vorel wrote:
> Hi Mimi, all,
> 
> > The sourceforge wiki info is dated and requires a major overhaul.  Some
> > of the information already exists in the linux kernel documentation.
> > For now, save it with the referenced html files.
> May I ask why you in the end reverted this from next-testing?
> fdd58fa ("Revert "Save ima-evm-utils sourceforge wiki"") has no explanation.
> Maybe I missed some email.
> 
> I like moving docs to git repository.

Oh!  It's not being removed permanently, just reverted temporarily. 
Since pandoc wasn't installed all of the tests failed.  The patch just
needs to be re-worked a bit.
(I tweaked the fsverity test and wanted to see the github action
results.)

thanks,

Mimi

