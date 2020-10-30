Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7ED429F9B8
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Oct 2020 01:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbgJ3AcX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Oct 2020 20:32:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbgJ3AcW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Oct 2020 20:32:22 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09U0VoVR006543;
        Thu, 29 Oct 2020 20:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=yCu1W6Us4NJ9GuAgohY813aWiiXCnsRGcrSqKs3EhI4=;
 b=nZTLGtByaFbLodUY9l67uXk5pQRyEn7ehuW9/aaGRqOejq/yDHxuLdrxmltCfjwjQ7/g
 MaRHa/98vdZLV7nVT9qTTc5AwXMab1CGWZJJEiSMwoFF0OK8eqdZysP8mSVWHDdRw3nn
 1O6dpaxMMKkUwnS0h5YNBZ0XXj0VLzG7/dVKh3J3Z0/HohdcI401MkDqvGQ/THRZjKg2
 W58+eu45hs5prVXIYSHUZ8kni93dalWdfuuR2KLSmsYB4tTz2ZUfspyxL+EleRDSH433
 po0dNaG6YLlnEy1J7sttehNpqghCwbuF+DdVWIPoxxgczmxJ34K6gMbk/QYHrnymWQ+z Ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34g6sya7yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Oct 2020 20:32:20 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09U0Vw6H006858;
        Thu, 29 Oct 2020 20:32:20 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34g6sya7xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Oct 2020 20:32:20 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09U0Gp27023837;
        Fri, 30 Oct 2020 00:32:17 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 34g41xr6hj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Oct 2020 00:32:17 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09U0WF1A19005908
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Oct 2020 00:32:15 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F8014C046;
        Fri, 30 Oct 2020 00:32:15 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A51824C052;
        Fri, 30 Oct 2020 00:32:13 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.78.12])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 30 Oct 2020 00:32:13 +0000 (GMT)
Message-ID: <f99f0f03aecc778826d79eb83d60cfd1a95196c5.camel@linux.ibm.com>
Subject: Re: [RFC] Finding the right target branch for patches that span IMA
 and SeLinux
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, paul@paul-moore.com
Cc:     SELinux <selinux@vger.kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Date:   Thu, 29 Oct 2020 20:32:12 -0400
In-Reply-To: <703ced1a-3a48-f29e-9141-af78415d8402@linux.microsoft.com>
References: <703ced1a-3a48-f29e-9141-af78415d8402@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-29_12:2020-10-29,2020-10-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0 suspectscore=0
 impostorscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010290167
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-10-29 at 16:33 -0700, Tushar Sugandhi wrote:
> Hello Mimi/Stephen/Paul,
> 
> As you are already aware, we have several patch-sets in review for
> IMA infrastructure for measurement of critical kernel data and it's
> usage.
> 
> [1] infrastructure for measurement of critical data patch-set:
> 
> https://patchwork.kernel.org/project/linux-integrity/list/?series=354437
> 
> [2] Using [1] to measure SeLinux data:
>      https://patchwork.kernel.org/patch/11801585/
> 
> [3] Using [1] to measure dm-crypt data:
> 
> https://patchwork.kernel.org/project/linux-integrity/list/?series=366903
> 
> [4] Using [1] to measure kernel_version:
>      https://patchwork.kernel.org/patch/11854625/
> 
> [5] built-in IMA policy rule to handle critical data before
>      a custom IMA policy is loaded:
>      {Patch is not yet sent for public review}
> 
> Mimi has suggested that patch-set [1] should include a demonstrative
> example use of the functionality in the same series. And that example
> should be SeLinux (patch-set [2]).
> 
> However, SeLinux patch-set [2] depends on the functionality in SeLinux
> branch [7], which is not yet merged in Integrity branch [6].
> Therefore SeLinux patch-set [2] does not apply on the Integrity branch
> at this time.
> 
> Further, SeLinux patch-set [2] also depends on the new code for
> critical data infrastructure (patch-set [1] and [5]) which is all
> IMA code. Patch-set [1] and [5], even though all IMA code, applies
> cleanly on SeLinux branch - along with patch-set [2].
> 
> For the above reason, the new series we are going to post, which
> combines [1], [2], and [5], needs to be based on SeLinux branch.
> 
> Since [1] and [5] contains IMA code - we wanted to confirm with the
> maintainers if there are any concerns to base the series on SeLinux
> branch.
> 
> Thanks,
> Tushar
> 
> [6] Integrity Repo/Branch:
> Repo: 
> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
> Branch: linux-integrity
> 
> [7] SeLinux Branch:
> Repo: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
> Branch: next

Unless this patch set is specifically dependent on the two patches in
the SELinux tree beyond v5.10.0-rc1, please base it on v5.10.0-rc1.

thanks,

Mimi


