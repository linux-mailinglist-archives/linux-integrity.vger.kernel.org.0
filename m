Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99EC1C49C5
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2020 00:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgEDWvx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 May 2020 18:51:53 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54530 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgEDWvx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 May 2020 18:51:53 -0400
Received: from [192.168.0.109] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id A901720B717B;
        Mon,  4 May 2020 15:51:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A901720B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1588632712;
        bh=TlGQvxa4ZoTlkS3uwvgeQHJhmGCbxfklMLyyEyAa7OY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SmNRMKW9loVFwCG/K0n82fcbSosLA5AlKHNh9PPxohuV+WIHiV7kQqXjgu1kId1Tz
         M7Znn2wPlci5ysddHzsZQCaXDe1/ZZEy7U73IFQ1h2apD6MkOAaEk8/FhAlnl3VQgg
         8R1enS/nld1g/KsJUf28+R+pyifNpF+kq0BnCvgo=
Subject: Re: [RFC PATCH] ima: verify mprotect change is consistent with mmap
 policy
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1588627060-7399-1-git-send-email-zohar@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <7812a3a7-f47d-c924-c12e-f417bb6f43dc@linux.microsoft.com>
Date:   Mon, 4 May 2020 15:51:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588627060-7399-1-git-send-email-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/4/20 2:17 PM, Mimi Zohar wrote:

Hi Mimi,

> +int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
> +{
> +	struct ima_template_desc *template;
> +	struct inode *inode;
> +	int result = 0;
> +	int action;
> +	u32 secid;
> +	int pcr;
> +
> +	if (vma->vm_file && (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {

Just a suggestion:
Maybe you could do the negative of the above check and return, so that 
the block within the if statement doesn't have to be indented.

> +		inode = file_inode(vma->vm_file);
> +
> +		security_task_getsecid(current, &secid);
> +		action = ima_get_action(inode, current_cred(), secid, MAY_EXEC,
> +					MMAP_CHECK, &pcr, &template, 0);
> +
> +		if (action & IMA_APPRAISE_SUBMASK)
> +			result = -EPERM;
> +
> +		if ((action & IMA_APPRAISE_SUBMASK) || (action & IMA_MEASURE)) {

action is checked for IMA_APPRAISE_SUBMASK bits in the previous if 
statement. Does it need to be checked again in the above if statement?

> +			struct file *file = vma->vm_file;
> +			char *pathbuf = NULL;
> +			const char *pathname;
> +			char filename[NAME_MAX];
> +
> +			pathname = ima_d_path(&file->f_path, &pathbuf,
> +					      filename);
> +			integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
> +					    pathname, "collect_data",
> +					    "failed-mprotect", result, 0);
> +
> +			if (pathbuf)
> +				__putname(pathbuf);
> +		}
> +	}
> +	return result;
> +}

thanks,
  -lakshmi

