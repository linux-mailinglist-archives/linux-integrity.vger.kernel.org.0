Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C643D7C16
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 19:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbhG0RZZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Jul 2021 13:25:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25260 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229593AbhG0RZY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Jul 2021 13:25:24 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16RH9S10175837;
        Tue, 27 Jul 2021 13:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=PpyV2oSe5st6NYcIfUBXGqe/jyPr0gGOkPIwnYfNMgY=;
 b=C9vle9rIZtnrhVsS6NQFHy2y61RSz4NCsnNws3dTbhYdC8NIxpyrLFBDPHEpguyiksPk
 8a0ya0arQYE4UFrhAbELEzqDi9meVNf6n1yaakpYl8jxBsyfckF/K+9A6wWbRmIJB6Hl
 20HHQc8wxLqlnE7U0BhC44I0urtAoR2gBx4UTTYAm9R+BH4NHYL7V94UCfXpMHwlfV8l
 mFMb1bZxlunHAzJV1nskrGTDjQgPKlFcZ4B9EVs08Gi5R6N9Lvl6yavF3x5EvK9kpmpL
 +3wXGnEyhzKHvxBCqmDeWrZJOBkb68EIIxH5xKs9oOXd/Fha6TbNuxBXSxjn7bmI9FMt 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a2nsksyhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 13:25:23 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16RH9rQT180050;
        Tue, 27 Jul 2021 13:25:23 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a2nsksyh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 13:25:23 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16RH91jY004370;
        Tue, 27 Jul 2021 17:25:21 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 3a235prc3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 17:25:21 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16RHPI3726411324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 17:25:19 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D981152065;
        Tue, 27 Jul 2021 17:25:18 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.85.52])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9613A5204F;
        Tue, 27 Jul 2021 17:25:17 +0000 (GMT)
Message-ID: <f042f5df077cdaf50688c7cc3fa8896491abf2bd.camel@linux.ibm.com>
Subject: Re: [PATCH v4 5/5] IMA: introduce a new policy option
 func=SETXATTR_CHECK
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Date:   Tue, 27 Jul 2021 13:25:16 -0400
In-Reply-To: <20210727163330.790010-6-simon.thoby@viveris.fr>
References: <20210727163330.790010-1-simon.thoby@viveris.fr>
         <20210727163330.790010-6-simon.thoby@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ni4bIWZpCXA792Gkc5RBP-yTREFfl9e9
X-Proofpoint-ORIG-GUID: _gQmX0R8ibRKSm5xsCKyOAvw6TNCxDIZ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-27_10:2021-07-27,2021-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107270103
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

On Tue, 2021-07-27 at 16:33 +0000, THOBY Simon wrote:
> While users can restrict the accepted hash algorithms for the
> security.ima xattr file signature when appraising said file, users
> cannot restrict the algorithms that can be set on that attribute:
> any algorithm built in the kernel is accepted on a write.
> 
> Define a new value for the ima policy option 'func' that restricts
> globally the hash algorithms accepted when writing the security.ima
> xattr.
> 
> When a policy contains a rule of the form
> 	appraise func=SETXATTR_CHECK appraise_hash=sha256,sha384,sha512
> only values corresponding to one of these three digest algorithms
> will be accepted for writing the security.ima xattr.
> Attempting to write the attribute using another algorithm (or "free-form"
> data) will be denied with an audit log message.
> In the absence of such a policy rule, the default is still to only
> accept hash algorithms built in the kernel (with all the limitations
> that entails).
> 
> On policy update, the latest SETXATTR_CHECK rule is the only one
> that apply, and other SETXATTR_CHECK rules are deleted.
> 
> Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>

Sorry, I was just getting to this patch, when you re-posted the patch
set.  In the future, I'll make sure the responses are sent in quick
succession.

There are a number of assumptions related to the IMA policy:
- A builtin policy may be replaced by a custom policy.
- Depending on the Kconfig, the policy rules may not change be updated.
- Subsequent to replacing the builtin policy with a custom policy,
rules may only be appended, based on the Kconfig.

The locking around the policy rules is dependent on these assumptions. 
Removing policy rules is a major change that needs to be considered
carefully.  Why should "func=SETXATTR_CHECK"  be treated any
differently than any other policy rule?  How would an attestation
server know which setxattr rule was enabled at the time the file was
appraised?

thanks,

Mimi

