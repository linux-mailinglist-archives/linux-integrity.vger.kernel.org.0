Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD36736FAAB
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Apr 2021 14:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbhD3Mmg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Apr 2021 08:42:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31812 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233271AbhD3Ml1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Apr 2021 08:41:27 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13UCWmd7044950;
        Fri, 30 Apr 2021 08:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=RX1IGI9YG082b0TpjoZS3giF1I3GNKmiwVBJU+5xV68=;
 b=ARbe4hMtZ3yJfzcM02i9TBTsuAfZRzOvwNnjNlR2SOw31Ggu5YqVQ+YyD2nk3c83sxk8
 kSNd2FtMizRwrQ+gf1UZUqU1IFUV30JaqzPD/p75mRqR0agJTqb0R1GxqCsNdyAt2OX5
 1tRzlnxg6/0ijEABUqaU705B3bBOFCvgEP4toGCM1pWLJe4I88vTFDgumN9OV2R+KuD5
 7ytI3CVcdUlzB7x7OCmUcpKIDRSU0cvVWgMJdx+wVHHLHHmbkUeemVdbTnXWQZRnr/P6
 yhJorC8sJirqPOptJHjEYm6pS+Z6mRbFxLmZQFh0ZPtRwm+aE5HunjxmL/fZ6pPAngAW MA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 388h931np0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Apr 2021 08:40:36 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13UCU3Ei011640;
        Fri, 30 Apr 2021 12:40:34 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 384ay8sqsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Apr 2021 12:40:34 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13UCeWWb36241834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 12:40:32 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13937A405B;
        Fri, 30 Apr 2021 12:40:32 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0544FA4054;
        Fri, 30 Apr 2021 12:40:31 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.32.5])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 30 Apr 2021 12:40:30 +0000 (GMT)
Message-ID: <07d6895b02ea3818b0687d79f66575fc08ff6c97.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] travis: Fix Fedora
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>
Date:   Fri, 30 Apr 2021 08:40:29 -0400
In-Reply-To: <20210429053918.10240-1-pvorel@suse.cz>
References: <20210429053918.10240-1-pvorel@suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rvLkvxdN0TBYmwp3Jz0VzcmDyKAsNwb2
X-Proofpoint-GUID: rvLkvxdN0TBYmwp3Jz0VzcmDyKAsNwb2
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-30_06:2021-04-30,2021-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104300091
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

On Thu, 2021-04-29 at 07:39 +0200, Petr Vorel wrote:
> Fedora recently got 2.33, which requires on Travis CI to use podman.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi Mimi,
> 
> Tested [1].
> 
> Previously Fedora fails on autoconf issue [2], which is caused by
> faccessat2 incompatibility on glibc 2.33:
> 
> /usr/bin/autoconf: This script requires a shell more modern than all
> /usr/bin/autoconf: the shells that I found on your system.
> /usr/bin/autoconf: Please tell bug-autoconf@gnu.org about your system,
> /usr/bin/autoconf: including any error possibly output before this
> /usr/bin/autoconf: message. Then install a modern shell, or manually run
> /usr/bin/autoconf: the script under such a shell if you do have one.
> autoreconf: /usr/bin/autoconf failed with exit status: 1
> 
> [1] https://travis-ci.org/github/pevik/ima-evm-utils/builds/768789641
> [2] https://travis-ci.org/github/pevik/ima-evm-utils/jobs/767259578

The "boot_aggregate" test should succeed, but for some reason is now
being skipped.

PASS: ima_hash.test
PASS: sign_verify.test
SKIP: boot_aggregate.test

I tested with/without this patch on our internal travis.   I was seeing
the Tumbleweed problem, but am not seeing this problem with Fedora
latest yet.  Both with/without the patch, Fedora latest works properly
on our internal travis.

Mimi

