Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC311301CDA
	for <lists+linux-integrity@lfdr.de>; Sun, 24 Jan 2021 15:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbhAXOzv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 24 Jan 2021 09:55:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2350 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725268AbhAXOzv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 24 Jan 2021 09:55:51 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10OEWRtF025352;
        Sun, 24 Jan 2021 09:55:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=VncG4nBH5QBHrVm7Xi1rK86Lm7h0SIkOi1mHT8+90ic=;
 b=Cqy4AF7VTspmuX+A+SkLEwcvm9WUW8BPdrrXJOTtYeCryjt6igu4fQLax8qx03iA+xVH
 dm7pw8HVTens90SKIgjPDdyZcFXm1CgAuXef0vCSI5XR3qa2WqVWISHHH8DQJWSxzqCe
 wBL6btI4cKUBLOG/73RC/IVsTI7lvkqYFMcAkedlFszyP+w7TGvbhoLNMgIsefvZBGdS
 ucCK9XmXwpbTbAvDOgOAQIsDElimBbWiYuLT7wTGqS0QfWcCYOu8eDBRCYysIhqugChp
 /TDbuIPOolVqeQnhjgADnbg+EBJdbNviNmx5Ws5+U4eua8N/izpbLJyp/4s/0DnN56Hu xg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3697crubc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 Jan 2021 09:55:08 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10OEs025000761;
        Sun, 24 Jan 2021 14:55:06 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 368b2h132w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 Jan 2021 14:55:06 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10OEsuU632964894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 24 Jan 2021 14:54:56 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36846A404D;
        Sun, 24 Jan 2021 14:55:03 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3039A4051;
        Sun, 24 Jan 2021 14:55:01 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.83.155])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 24 Jan 2021 14:55:01 +0000 (GMT)
Message-ID: <14d842487913031cc2ad12ada6b4d108946b02e2.camel@linux.ibm.com>
Subject: Re: [PATCH v2] IMA: Measure kernel version in early boot
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Raphael Gianotti <raphgi@linux.microsoft.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        tusharsu@linux.microsoft.com, nramas@linux.microsoft.com,
        tyhicks@linux.microsoft.com
Date:   Sun, 24 Jan 2021 09:55:00 -0500
In-Reply-To: <20210122232827.12840-1-raphgi@linux.microsoft.com>
References: <20210122232827.12840-1-raphgi@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-24_04:2021-01-22,2021-01-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101240092
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-01-22 at 15:28 -0800, Raphael Gianotti wrote:
> The integrity of a kernel can be verified by the boot loader on cold
> boot, and during kexec, by the current running kernel, before it is
> loaded. However, it is still possible that the new kernel being
> loaded is older than the current kernel, and/or has known
> vulnerabilities. Therefore, it is imperative that an attestation
> service be able to verify the version of the kernel being loaded on
> the client, from cold boot and subsequent kexec system calls,
> ensuring that only kernels with versions known to be good are loaded.
> 
> Measure the kernel version using ima_measure_critical_data() early on
> in the boot sequence, reducing the chances of known kernel
> vulnerabilities being exploited. With IMA being part of the kernel,
> this overall approach makes the measurement itself more trustworthy.
> 
> To enable measuring the kernel version "ima_policy=critical_data"
> needs to be added to the kernel command line arguments.
> For example,
> 	BOOT_IMAGE=/boot/vmlinuz-5.11.0-rc3+ root=UUID=fd643309-a5d2-4ed3-b10d-3c579a5fab2f ro nomodeset ima_policy=critical_data
> 
> If runtime measurement of the kernel version is ever needed, the
> following should be added to /etc/ima/ima-policy:
> 
> 	measure func=CRITICAL_DATA label=kernel_version
> 
> To extract the measured data after boot, the following command can be used:
> 
>         grep -m 1 "kernel_version" \
>         /sys/kernel/security/integrity/ima/ascii_runtime_measurements
> 
> Sample output from the command above:
> 
> 	10 a8297d408e9d5155728b619761d0dd4cedf5ef5f ima-buf
> 	sha256:5660e19945be0119bc19cbbf8d9c33a09935ab5d30dad48aa11f879c67d70988
> 	kernel_version 352e31312e302d7263332d31363138372d676564623634666537383234342d6469727479
> 
> The above corresponds to the following (decoded) version string:
> 
> 	5.11.0-rc3-16187-gedb64fe78244-dirty
> 
> This patch is based on
> commit e58bb688f2e4 "Merge branch 'measure-critical-data' into next-integrity"
> in "next-integrity-testing" branch
> 
> Change Log v2:
> 	- Changed the measurement to align with the latest version of
> 	  ima_measure_critical_data(), without the need for queueing
> 	- Scoped the measurement to only measure the kernel version,
> 	  found in UTS_RELEASE, instead of the entire linux_banner
> 	  string
> 
> Signed-off-by: Raphael Gianotti <raphgi@linux.microsoft.com>
> ---
>  security/integrity/ima/ima_main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 6a429846f90a..0a33f570725c 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -26,6 +26,7 @@
>  #include <linux/ima.h>
>  #include <linux/iversion.h>
>  #include <linux/fs.h>
> +#include <generated/utsrelease.h>
>  
>  #include "ima.h"
>  
> @@ -994,8 +995,11 @@ static int __init init_ima(void)
>  	if (error)
>  		pr_warn("Couldn't register LSM notifier, error %d\n", error);
>  
> -	if (!error)
> +	if (!error) {
>  		ima_update_policy_flag();
> +		ima_measure_critical_data("kernel_version", "kernel_version",
> +					  UTS_RELEASE, strlen(UTS_RELEASE), false);
> +	}
>  
>  	return error;
>  }

Consider defining a new critical data label grouping (e.g.
"kernel_info",  ...).

Please move ima_measure_critical_data() to ima_init() and update the
critical data "label:=" in Documentation/ABI/testing/ima_policy.

thanks,

Mimi

