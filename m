Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AA12EB406
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Jan 2021 21:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbhAEURe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 5 Jan 2021 15:17:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24402 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729621AbhAEURd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Jan 2021 15:17:33 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 105JYl34170166;
        Tue, 5 Jan 2021 15:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=IitCUxfnQFJ8pL7B5kWAuVTYoWZfoGWE0zwB5kzMTRU=;
 b=ITUBadNeXF2IHRfWEOLoBfjZQaU17/em+0e4h2buLl5XEwWKGdRoBf99ueZo27L3DPEg
 vsk82F3eLGJHhFXeIg+J1K+uDV+oT7f9iDvsxQR9+rABwBIARpWi4yNkK4SIN8GSo5WN
 OkBBy5yspeGXMZqAdgWegUTXUjL1kzgev0dT1BDnx3BVhpJGpD7VCHuth0liV4duEbi/
 kYhEhQfBELbEh3DZ0I0/9ps8iFq8ET9KnFzXgwFszYoFIpvfGKfAKSXNgdLWEHybFUqq
 CVpZeq56vI79+mgTq5P1/aEJ0tqS/XWUVEuoBiPnyZJzPsUOJ71pPOZshRqsxbHVNYf9 aA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35vwc030jw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 15:16:49 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 105KF647144664;
        Tue, 5 Jan 2021 15:16:48 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35vwc030j3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 15:16:48 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 105KCU4o030045;
        Tue, 5 Jan 2021 20:16:46 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 35tgf8b6r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 20:16:46 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 105KGiCp41091494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Jan 2021 20:16:44 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0827111C04C;
        Tue,  5 Jan 2021 20:16:44 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B780511C050;
        Tue,  5 Jan 2021 20:16:40 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.22.135])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Jan 2021 20:16:40 +0000 (GMT)
Message-ID: <3b5dd02fab216746409ccede82f51382539824d3.camel@linux.ibm.com>
Subject: Re: [PATCH v9 3/8] IMA: define a hook to measure kernel integrity
 critical data
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Tue, 05 Jan 2021 15:16:39 -0500
In-Reply-To: <9afab02b-4b02-485d-cca2-bdf8b1cf87e7@linux.microsoft.com>
References: <20201212180251.9943-1-tusharsu@linux.microsoft.com>
         <20201212180251.9943-4-tusharsu@linux.microsoft.com>
         <5ae72a76664ce7011d3041689efbfe1a2c67d44f.camel@linux.ibm.com>
         <9afab02b-4b02-485d-cca2-bdf8b1cf87e7@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-05_06:2021-01-05,2021-01-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101050112
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-01-05 at 12:01 -0800, Tushar Sugandhi wrote:
> 
> >> data. However, various data structures, policies, and states
> > 
> > Here and everywhere else, there are two blanks after a period.
> > 
> I checked this patch file in multiple text editors, but couldn’t find
> any instance of period followed by two spaces. I will double check again 
> all the patches for multiple spaces, and remove them if any.

There should be two blanks after a period, not one blank.

<snip>

> >> + *
> >> + * Measure the kernel subsystem data, critical to the integrity of the kernel,
> >> + * into the IMA log and extend the @pcr.
> >> + *
> >> + * Use @event_name to describe the state/buffer data change.
> >> + * Examples of critical data (@buf) could be various data structures,
> >> + * policies, and states stored in kernel memory that can impact the integrity
> >> + * of the system.
> >> + *
> >> + * If @measure_buf_hash is set to true - measure hash of the buffer data,
> >> + * else measure the buffer data itself.
> >> + * @measure_buf_hash can be used to save space, if the data being measured
> >> + * is too large.
> >> + *
> >> + * The data (@buf) can only be measured, not appraised.
> > 
> > The "/**" is the start of kernel-doc.  Have you seen anywhere else in
> My impression was the hooks in ima_main.c e.g. ima_file_free()
> ima_file_mmap() required the double-asterisk ("/**"), and internal
> functions like ima_rdwr_violation_check() require a single-asterisk
> ("/*")
> 
> kernel-doc.rst suggest the double-asterisk ("/**") for function comment
> as well.
> 
> Function documentation
> ----------------------
> 
> The general format of a function and function-like macro kernel-doc 
> comment is::
> 
>    /**
>     * function_name() - Brief description of function.
> 
> Please let me know if you still want me to remove the double-asterisk
> ("/**") here.

Yes, of course this needs to be kernel-doc and requires "/**"

> 
> > the kernel using the @<variable name> in the longer function
> > description?  Have you seen this style of longer   function
> > description?  Refer to Documentation/doc-guide/kernel-doc.rst and other
> > code for examples.
> > 
> Thanks. I will remove the prefix "@" from <variable name> in the longer 
> function description.

Removing the @<variable name> isn't sufficient.  Please look at other
examples of longer function definitions before reposting.

thanks,

Mimi

