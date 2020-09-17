Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE3F26E6F4
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Sep 2020 22:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgIQUyB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Sep 2020 16:54:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726180AbgIQUyB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Sep 2020 16:54:01 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08HKWaNo039062;
        Thu, 17 Sep 2020 16:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=xQvwnAivXgUxH+l33TWWdZYCxIRDFo0lKCWSsGIqums=;
 b=LeKvkbkFzIV8dbkMqn8pr34ZDvibP5Ly5UBSmNCdfOIB96mGFZs+thLToamH0rEc7RtO
 vxf7efDFP4+Gw8vuy42x4hBQ48PKOeNPTvCyvIV3GnX4Fb6/6ema6Ab9GVwUZNHT6NGe
 0Lalfco2tHfX+XyJKw2t57dUgK+CeLh1CXIqkNpYIC+EXhPtufRzNVvcqgx0wfjnIKxu
 BAPjfNmSsF4k0gejqNiGXcyIKCvp19ghlV+S1aC9ljhnCnyH0TXShmEM0OPmJDvT7QJx
 0gZRdPFRJUBAawmfUUVZt07KWcqzGZzW7zVorD5emmS0hxk9sAV4lLFJ1le3j6UQ7yBP lA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33mea81bc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 16:53:56 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08HKrDYS027406;
        Thu, 17 Sep 2020 20:53:55 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 33k6f2h9cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 20:53:54 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08HKrpxc25624980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Sep 2020 20:53:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D79FA4053;
        Thu, 17 Sep 2020 20:53:52 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A02BEA404D;
        Thu, 17 Sep 2020 20:53:51 +0000 (GMT)
Received: from sig-9-65-208-105.ibm.com (unknown [9.65.208.105])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Sep 2020 20:53:51 +0000 (GMT)
Message-ID: <7488a57e29dd33440ae98d6883f8f92d5833b97a.camel@linux.ibm.com>
Subject: Re: LSM that blocks execution of the code from the anonymous pages
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Igor Zhbanov <i.zhbanov@omprussia.ru>,
        linux-integrity <linux-integrity@vger.kernel.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>
Date:   Thu, 17 Sep 2020 16:53:50 -0400
In-Reply-To: <88b9444e-08bc-4240-7943-298070dfc47c@omprussia.ru>
References: <5f166ecd-38e4-a808-c377-683aabf6bf65@omprussia.ru>
         <2ba01c4961b2b967bb314e2d618a92e91d4fe511.camel@linux.ibm.com>
         <88b9444e-08bc-4240-7943-298070dfc47c@omprussia.ru>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_17:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=62 malwarescore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170146
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Igor,

(Reminder the Linux kernel mailing lists convention is to inline/bottom
post.)

On Thu, 2020-09-17 at 23:39 +0300, Igor Zhbanov wrote:
> My question is more about whether this functionality fits into IMA's
> responsibility. I.e. I can propose the changes as the extension of IMA's
> functionality (which I think it would be better), or I could create a separate
> LSM if this functionality doesn't align with IMA's purpose for some reason.
> This is the first question.
> 
> And the second question, what kind of operation modes do you think would
> be useful?
> 
> 1) no anonymous code for privileged processes (as currently),
> 2) no anonymous code for all processes,
> 3) no anonymous code for all processes with xattr-based exceptions (may be
>       with xattr value signing)

These are generic questions not dependent on whether this would be
upstreamed as an independent LSM or as part of IMA.  For this reason,
I've Cc'ed the LSM mailing list.

Mimi

> 
> For #3 I definitely would prefer to implement the code as a part of IMA
> because of sharing of xattrs cache, etc. to avoid reinventing the wheel.

