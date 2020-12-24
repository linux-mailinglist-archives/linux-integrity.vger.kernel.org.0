Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96DE82E2715
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Dec 2020 14:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgLXNHD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Dec 2020 08:07:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42178 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727990AbgLXNHC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Dec 2020 08:07:02 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BOD395a176508;
        Thu, 24 Dec 2020 08:06:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=IUmscQiWMT2Gh65vXKqEbJxWQ1hBGwlNodldsHCeSdQ=;
 b=UboHnPPwEBMekbu1SYaQEWxltl5/2UGfIkIyWGbmJFZapmmx5IdHE6iouwoXBtwDZG+e
 e6BrjxvAxvEWVEqVudZ69WUW4pPl8qGFTSoJ3b8kxwXtMSqlveBX075eNJgRNL3kc8Ra
 2rGkjKtI+ZfRCdGIiD4gblcfXNv1oVPvoKW9hdsCDI521N+MfZ+Igjih1wGW3LTVn9wk
 7woCe2XFLyib/U4djEHoyndBzkrJp/2qXuGQCwkR0dFq2KhvoTFpTKHlCVDFzVZLM+47
 eY84/EGjSxw7nq5+TosSj+edQnhzgTjm6axKnBl+OqBHb7QpQXGiGt+R4AjanggnVKWH Nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35mu1a8pse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Dec 2020 08:06:16 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BOD3YCt179407;
        Thu, 24 Dec 2020 08:06:16 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35mu1a8prh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Dec 2020 08:06:16 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BOD2jaa027488;
        Thu, 24 Dec 2020 13:06:13 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 35h8sh4xme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Dec 2020 13:06:13 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BOD6B8O43581744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Dec 2020 13:06:11 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3325342042;
        Thu, 24 Dec 2020 13:06:11 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07B7E4203F;
        Thu, 24 Dec 2020 13:06:08 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.1.132])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 24 Dec 2020 13:06:07 +0000 (GMT)
Message-ID: <5ae72a76664ce7011d3041689efbfe1a2c67d44f.camel@linux.ibm.com>
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
Date:   Thu, 24 Dec 2020 08:04:40 -0500
In-Reply-To: <20201212180251.9943-4-tusharsu@linux.microsoft.com>
References: <20201212180251.9943-1-tusharsu@linux.microsoft.com>
         <20201212180251.9943-4-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-24_08:2020-12-24,2020-12-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012240081
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2020-12-12 at 10:02 -0800, Tushar Sugandhi wrote:
> IMA provides capabilities to measure file data, and in-memory buffer

No need for the comma here.

Up to this patch set, all the patches refer to "buffer data", not "in-
memory buffer data".  This patch introduces the concept of measuring
"in-memory buffer data".   Please remove "in-memory" above.

> data. However, various data structures, policies, and states

Here and everywhere else, there are two blanks after a period.

> stored in kernel memory also impact the integrity of the system.
> Several kernel subsystems contain such integrity critical data. These
> kernel subsystems help protect the integrity of a device. Currently,

^integrity of the system.

> IMA does not provide a generic function for kernel subsystems to measure
> their integrity critical data.

The emphasis should not be on "kernel subsystems".  Simplify to "for
measuring kernel integrity critical data".

>  
> Define a new IMA hook - ima_measure_critical_data to measure kernel
> integrity critical data.

Either "ima_measure_critical_data" is between hyphens or without any
hyphens.  If not hyphenated, then you could say "named
ima_measure_critical_data", but "named" isn't necessary.  Or reverse "a
new IMA hook" and "ima_measure_critical_data", adding comma's like: 
Define ima_measure_critical_data, a new IMA hook, to ...

Any of the above options work, just not a single hyphen.

> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---

<snip>

> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 0f8409d77602..dff4bce4fb09 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -922,6 +922,40 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
>  	fdput(f);
>  }
>  
> +/**
> + * ima_measure_critical_data - measure kernel integrity critical data
> + * @event_name: event name to be used for the buffer entry

Why future tense?   By "buffer entry" do you mean a record in the IMA
measurement list?

> + * @buf: pointer to buffer containing data to measure

^pointer to buffer data

> + * @buf_len: length of buffer(in bytes)

^length of buffer data (in bytes)

> + * @measure_buf_hash: measure buffer hash

As requested in 2/8, please abbreviate the boolean name to "hash".  
Refer to section "4) Naming" in Documentation/process/coding-style.rst
for variable naming conventions.

^@hash: measure buffer data hash

> + *
> + * Measure the kernel subsystem data, critical to the integrity of the kernel,
> + * into the IMA log and extend the @pcr.
> + *
> + * Use @event_name to describe the state/buffer data change.
> + * Examples of critical data (@buf) could be various data structures,
> + * policies, and states stored in kernel memory that can impact the integrity
> + * of the system.
> + *
> + * If @measure_buf_hash is set to true - measure hash of the buffer data,
> + * else measure the buffer data itself.
> + * @measure_buf_hash can be used to save space, if the data being measured
> + * is too large.
> + *
> + * The data (@buf) can only be measured, not appraised.

The "/**" is the start of kernel-doc.  Have you seen anywhere else in
the kernel using the @<variable name> in the longer function
description?  Have you seen this style of longer   function
description?  Refer to Documentation/doc-guide/kernel-doc.rst and other
code for examples.

> + */
> +void ima_measure_critical_data(const char *event_name,
> +			       const void *buf, int buf_len,

As "buf_len" should always be >= 0, it should not be defined as a
signed variable.

> +			       bool measure_buf_hash)
> +{
> +	if (!event_name || !buf || !buf_len)
> +		return;
> +
> +	process_buffer_measurement(NULL, buf, buf_len, event_name,
> +				   CRITICAL_DATA, 0, NULL,
> +				   measure_buf_hash);

^hash

thanks,

Mimi

> +}
> +
>  static int __init init_ima(void)
>  {
>  	int error;


