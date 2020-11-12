Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493912B12E7
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Nov 2020 00:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbgKLX4Y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Nov 2020 18:56:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21500 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725894AbgKLX4X (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Nov 2020 18:56:23 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ACNVqxn147139;
        Thu, 12 Nov 2020 18:56:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=gpZ6qu8/NMvzR0Qg5R6sCequwTjXtgPzj/3Pxg/iCRg=;
 b=bw+3cHjxZkHG/efCIbVjEEktQ+G+1VE2KzVuIedZ2wxdAbXnQmhNufHlAz5S8WrcMQ4D
 WcYsFCaRtV/JvJ+OS6h8hU6ueLUhL4wG1wj36T+5UgRAqO4ilNWB4+qz3b4GLE4oO9p3
 SNwSlCLmXNQZJuqX8J77WTp8XpzIh2Zb1rlHnBzKJGwk+rGKSvhzP6ZhiyWGqtExqtOS
 pd+mLcDetQcj2vmu2ATrx7RpuMaLLYzdUw+eT/0gjir4cp0y+65kZrhihRK/qg/uMEyl
 cm7mkPwrRxDRsSlP4RnGKdO+t4NZ3fB1qUQ+Hzlr9uZ8YKfFGNvt4L1qrVM49NYD0Sn0 zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34sdd0tj8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 18:56:17 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0ACNuHkc042971;
        Thu, 12 Nov 2020 18:56:17 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34sdd0tj7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 18:56:17 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0ACNrdN9014028;
        Thu, 12 Nov 2020 23:56:15 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 34q084296e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 23:56:15 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0ACNu5sP8323784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Nov 2020 23:56:05 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BDB14204B;
        Thu, 12 Nov 2020 23:56:05 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E02D042042;
        Thu, 12 Nov 2020 23:56:01 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.105.204])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Nov 2020 23:56:01 +0000 (GMT)
Message-ID: <0f25c77c042f3e62405f12966c2358fe8cd82116.camel@linux.ibm.com>
Subject: Re: [PATCH v5 3/7] IMA: add hook to measure critical data
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Thu, 12 Nov 2020 18:56:01 -0500
In-Reply-To: <25622ca6-359d-fa97-c5e6-e314cba51306@linux.microsoft.com>
References: <20201101222626.6111-1-tusharsu@linux.microsoft.com>
         <20201101222626.6111-4-tusharsu@linux.microsoft.com>
         <1f83ec246cb6356c340b379ab00e43f0b5bba0ae.camel@linux.ibm.com>
         <25622ca6-359d-fa97-c5e6-e314cba51306@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-12_14:2020-11-12,2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011120129
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

On Thu, 2020-11-12 at 13:57 -0800, Tushar Sugandhi wrote:
> >> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> >> index 4485d87c0aa5..6e1b11dcba53 100644
> >> --- a/security/integrity/ima/ima_main.c
> >> +++ b/security/integrity/ima/ima_main.c
> >> @@ -921,6 +921,44 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
> >>   	fdput(f);
> >>   }
> >>   
> >> +/**
> >> + * ima_measure_critical_data - measure kernel subsystem data
> >> + * critical to integrity of the kernel
> > 
> > Please change this to "measure kernel integrity critical data".
> > 
> *Question*
> Thanks Mimi. Do you want us just to update the description, or do you
> want us to update the function name too?

Just the description.

> 
> I believe you meant just description, but still want to clarify.
> 
> ima_measure_kernel_integrity_critical_data() would be too long.
> Maybe ima_measure_integrity_critical_data()?
> 
> Or do you want us to keep the existing ima_measure_critical_data()?
> Could you please let us know?
> 
> >> + * @event_data_source: name of the data source being measured;
> >> + * typically it should be the name of the kernel subsystem that is sending
> >> + * the data for measurement
> > 
> > Including "data_source" here isn't quite right.  "data source" should
> > only be added in the first patch which uses it, not here.   When adding
> > it please shorten the field description to "kernel data source".   The
> > longer explanation can be included in the longer function description.
> > 
> *Question*
> Do you mean the parameter @event_data_source should be removed from this
> patch? And then later added in patch 7/7 – where SeLinux uses it?

Data source support doesn't belong in this patch.  Each patch should do
one logical thing and only that one thing.  This patch is adding
support for measuring critical data.  The data source patch will limit
the critical data being measured.

Other than updating the data source list in the documentation,
definitely do not add data source support to the SELinux patch.

thanks,

Mimi

