Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B552FF214
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Jan 2021 18:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388671AbhAURgH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 Jan 2021 12:36:07 -0500
Received: from linux.microsoft.com ([13.77.154.182]:58292 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388250AbhAURfv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Jan 2021 12:35:51 -0500
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 42F1420B7192;
        Thu, 21 Jan 2021 09:35:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 42F1420B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1611250508;
        bh=a4cCNjrAKs4+vz3aERM9jzdT7vtf1mGZiPbZ15KjmZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mv27Noc+Ifs08rNXx4cDHhfoP90JPBkoo09HeG1CZZO8jknWGmb7GgjeaTSl0oYOi
         v3HioJmVc+b9IQ2c0zBLrpNuOpnG7lpfrEvvg3Jd1Mcmqnm8GrbZme1tiLNFkjyhp4
         jqvT18W+uz0o+3+iGcx6H049pKv3IpwIO+7B5P8A=
Date:   Thu, 21 Jan 2021 11:35:05 -0600
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, bauerman@linux.ibm.com,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        gregkh@linuxfoundation.org, sashal@kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] ima: Free IMA measurement buffer on error
Message-ID: <20210121173505.GE259508@sequoia>
References: <20210121173003.18324-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121173003.18324-1-nramas@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2021-01-21 09:30:02, Lakshmi Ramasubramanian wrote:
> IMA allocates kernel virtual memory to carry forward the measurement
> list, from the current kernel to the next kernel on kexec system call,
> in ima_add_kexec_buffer() function.  In error code paths this memory
> is not freed resulting in memory leak.
> 
> Free the memory allocated for the IMA measurement list in
> the error code paths in ima_add_kexec_buffer() function.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> Fixes: 7b8589cc29e7 ("ima: on soft reboot, save the measurement list")

Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Tyler

> ---
>  security/integrity/ima/ima_kexec.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 121de3e04af2..212145008a01 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -119,12 +119,14 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	ret = kexec_add_buffer(&kbuf);
>  	if (ret) {
>  		pr_err("Error passing over kexec measurement buffer.\n");
> +		vfree(kexec_buffer);
>  		return;
>  	}
>  
>  	ret = arch_ima_add_kexec_buffer(image, kbuf.mem, kexec_segment_size);
>  	if (ret) {
>  		pr_err("Error passing over kexec measurement buffer.\n");
> +		vfree(kexec_buffer);
>  		return;
>  	}
>  
> -- 
> 2.30.0
> 
