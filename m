Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF561F69AF
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jun 2020 16:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgFKOLq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Jun 2020 10:11:46 -0400
Received: from linux.microsoft.com ([13.77.154.182]:42732 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgFKOLq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jun 2020 10:11:46 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5F4E220B4778;
        Thu, 11 Jun 2020 07:11:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5F4E220B4778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1591884705;
        bh=tFg7+PQWet+jeOWbFZlNUp3UpCdozWSTl7SoKYhodpI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=c+j19m82+ookhEBumbsDCgRzHEjVfsTJ6mu2qUgguNW9cIjPtSq80aH8kruY+s3E+
         QuIQA5NB7kuOXUnejTeDWTZYREY2otaR5OD/SVgQqT40joCciTp3JQ3RK8tQlFrsjL
         PMLUOJIYNN8bVysrFfSnC5RVmB+RK9UKvwr/rwfE=
Subject: Re: [PATCH] ima: fix mprotect checking
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <1591874363-28939-1-git-send-email-zohar@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <b9b75002-8c46-16c2-ba09-d7ff6b3d9889@linux.microsoft.com>
Date:   Thu, 11 Jun 2020 07:11:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1591874363-28939-1-git-send-email-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/11/20 4:19 AM, Mimi Zohar wrote:

> Make sure IMA is enabled before checking mprotect change.  Addresses
> report of a 3.7% regression of boot-time.dhcp.
> 
> Fixes: 8eb613c0b8f1 ("ima: verify mprotect change is consistent with mmap policy")
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   security/integrity/ima/ima_main.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 800fb3bba418..c1583d98c5e5 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -419,7 +419,8 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
>   	int pcr;
>   
>   	/* Is mprotect making an mmap'ed file executable? */
> -	if (!vma->vm_file || !(prot & PROT_EXEC) || (vma->vm_flags & VM_EXEC))
> +	if (!(ima_policy_flag & IMA_APPRAISE) || !vma->vm_file ||
> +	    !(prot & PROT_EXEC) || (vma->vm_flags & VM_EXEC))
>   		return 0;
>   
>   	security_task_getsecid(current, &secid);
> 

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
