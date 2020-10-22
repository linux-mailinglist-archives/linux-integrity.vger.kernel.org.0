Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4648629675D
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Oct 2020 00:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372947AbgJVWgO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Oct 2020 18:36:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55118 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S372941AbgJVWf2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Oct 2020 18:35:28 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09MMVZuh058551;
        Thu, 22 Oct 2020 18:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=j9XsJrYwmd69hAlmharqLVM7LiBlchSRoT0dWPuOUlA=;
 b=og1B0xcg7eiRllSH+fQlz7FRLmTvsR3+RTaUzVPIG7zwDNtFSGFqHJvOH/kp3ALYUChr
 hB5DIZfGntE4RXmWNMZXVYQaaChMGXshlLseCyz+F9RP42bfrkInMMAePFeZRDbAfYrh
 XFIP9hmPzOudTJQ36++bKo4tukXizOmb+YYAXwv8m6ac/uAFMUpjs6Zt2PhXTkr3Alp/
 96hGlrLGqEY41tpWpEoR1sWThthEbsdlDXfMRnMj9/BRiqLftvC+WR5kYurVVTXNZ9fi
 IGC7BqUfn0DdlPKLjmDCHp9RczLlaP6flpY0VqKwhUUeSj+rnzuMXxGGoyfnJ115sKjx 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34be0u1n33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Oct 2020 18:35:22 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09MMZ8I2071182;
        Thu, 22 Oct 2020 18:35:21 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34be0u1n29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Oct 2020 18:35:21 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09MMWw6H011289;
        Thu, 22 Oct 2020 22:35:19 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 347qvhdxw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Oct 2020 22:35:19 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09MMZHDD32571854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Oct 2020 22:35:17 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 231B111C081;
        Thu, 22 Oct 2020 22:35:17 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5619311C080;
        Thu, 22 Oct 2020 22:35:13 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.54.44])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Oct 2020 22:35:13 +0000 (GMT)
Message-ID: <dc22359475f0c233abdb9257d1ca745d4be3f9af.camel@linux.ibm.com>
Subject: Re: [PATCH v4 5/6] IMA: add hook to measure critical data from
 kernel components
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Thu, 22 Oct 2020 18:35:11 -0400
In-Reply-To: <20200923192011.5293-6-tusharsu@linux.microsoft.com>
References: <20200923192011.5293-1-tusharsu@linux.microsoft.com>
         <20200923192011.5293-6-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-22_17:2020-10-20,2020-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010220140
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

On Wed, 2020-09-23 at 12:20 -0700, Tushar Sugandhi wrote:
> Currently, IMA does not provide a generic function for kernel components
> to measure their data. A generic function provided by IMA would
> enable various parts of the kernel with easier and faster on-boarding to
> use IMA infrastructure, would avoid code duplication, and consistent
> usage of IMA policy option "data_sources:=" across the kernel.
> 
> Add a new IMA func CRITICAL_DATA and a corresponding IMA hook
> ima_measure_critical_data() to support measuring various critical kernel
> components. Limit the measurement to the components that are specified
> in the IMA policy - CRITICAL_DATA+data_sources.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>

Normally the new LSM or IMA hook is defined before defining a method of
constraining that hook.  Please drop 2/6 (IMA: conditionally allow
empty rule data) and reverse the order of 4/6 and 5/6.   That will
allow each patch to update the Documentation appropriately, making the
change self contained.

> ---
>  Documentation/ABI/testing/ima_policy |  8 ++++++-
>  include/linux/ima.h                  |  8 +++++++
>  security/integrity/ima/ima.h         |  1 +
>  security/integrity/ima/ima_api.c     |  2 +-
>  security/integrity/ima/ima_main.c    | 26 +++++++++++++++++++++
>  security/integrity/ima/ima_policy.c  | 34 ++++++++++++++++++++++++----
>  6 files changed, 72 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index a81cf79fb255..d33bb51309fc 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -29,7 +29,7 @@ Description:
>  		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
>  				[FIRMWARE_CHECK]
>  				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
> -				[KEXEC_CMDLINE] [KEY_CHECK]
> +				[KEXEC_CMDLINE] [KEY_CHECK] [CRITICAL_DATA]
>  			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
>  			       [[^]MAY_EXEC]
>  			fsmagic:= hex value
> @@ -51,6 +51,8 @@ Description:
>  			data_sources:= list of kernel components
>  			(eg, selinux|apparmor|dm-crypt) that contain data critical
>  			to the security of the kernel.
> +			Only valid when action is "measure" and func is
> +			CRITICAL_DATA.
>  
>  		default policy:
>  			# PROC_SUPER_MAGIC
> @@ -128,3 +130,7 @@ Description:
>  		keys added to .builtin_trusted_keys or .ima keyring:
>  
>  			measure func=KEY_CHECK keyrings=.builtin_trusted_keys|.ima
> +
> +		Example of measure rule using CRITICAL_DATA to measure critical data
> +
> +			measure func=CRITICAL_DATA data_sources=selinux|apparmor|dm-crypt


As data sources are added, the documentation example should be updated
to reflect the new source.  Please do not include examples that don't
yet exist.


> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 6888fc372abf..d55896f28790 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -867,6 +867,32 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
>  	fdput(f);
>  }
>  
> +/**
> + * ima_measure_critical_data - measure critical data
> + * @event_name: name for the given data
> + * @event_data_source: name of the event data source
> + * @buf: pointer to buffer containing data to measure
> + * @buf_len: length of buffer(in bytes)
> + * @measure_buf_hash: if set to true - will measure hash of the buf,
> + *                    instead of buf
> + *
> + * Buffers can only be measured, not appraised.
> + */

Perhaps the reason for defining both the event_name and
event_data_source will become clearer with an example.  At this point I
can only guess as to why both are needed (e.g. perhaps a data source
defines multiple events).

While "Buffers can only be measured, not appraised" is true, it was cut
& pasted from ima_kexec_cmdline.  Measuring the kexec boot cmdline is
self describing.  Here, a larger, more detailed IMA hook description
would be appropriate.

thanks,

Mimi

