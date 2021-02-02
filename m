Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E81130C675
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Feb 2021 17:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbhBBQt2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Feb 2021 11:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236776AbhBBQq6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Feb 2021 11:46:58 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23E1C06178C
        for <linux-integrity@vger.kernel.org>; Tue,  2 Feb 2021 08:46:17 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id ew18so10189301qvb.4
        for <linux-integrity@vger.kernel.org>; Tue, 02 Feb 2021 08:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iG1Q0vNpoJNYp+p7nQgLqNoSVoZ6ajMT7nzr7abfvUc=;
        b=cwnsOI2ILjJNKAJToh+6tP7YvfRuyB2tFi1L411sRQHhzZgPAmkkEmyTcxIJZfrCgq
         BwFibDmV0cUOsCijyBcRhFPkQ7LgLVsLPuNUIz6qB/HMjBA2Zbyrx8okhH1U6/1P7SAz
         YhZC5j4fVxxZsyBGBx3IYO6zk0+1aNrkbBR7tXhd5SVC7xiU9R7Shkrze7v7DaYM2kSb
         3h09AsP56mqIL2M8lcPcI/c/PnCu6weeP2VSzgdsXij9b8GKQlYAXOKE7O/8fe1Z4+yB
         sKyMxc55u6ExgDEbMfWk+8TCaTqvg7gZJpR167J+BP3zhZWWMnAQLcgI4dOROoyp5Uln
         tOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iG1Q0vNpoJNYp+p7nQgLqNoSVoZ6ajMT7nzr7abfvUc=;
        b=C8Lzh9VlRwDumf2HaqJtRzNuvlSLQjTbevuviu7rQH1cYQmuQl2TDf/d40rQrsZfxp
         iccQy/rnnLtfHTTFSjCKRMGBdJnJoRkMP5nHNDmSS8LhRhUxrxyBBjtrMyv/QwRr8Jbu
         BOMCoz+0/eEOl1dmN00uHWjbBDuIVs91sfyvEYmAxtfisq0RmcSDOt2EZ7usEK21FQy6
         p+yXMSYGW8Fl+ebC53ftIVY9gFwZJsXjvQKPnjIkdNvt2hBsV6izf0mdoqrymOcmY9PA
         ogLA/jRgysxllGYXrWBlcipcCR43qsHVkrIwVjqENomsMwqXukDF2uX7AITXFF3MxWEQ
         +GRg==
X-Gm-Message-State: AOAM533KifanXfhc4mdweJuBrJgR9Qe/OaBwWydIugC4iU4sX+briMFH
        eYKBw34cMxTpkZ+ddOD7qelMvA==
X-Google-Smtp-Source: ABdhPJyNqyX/vaoWfZLur/BWx++gnztIlZ41HfdxIL8QoMdG9MnMhxV80FnwPuBl3pCh7uiqYN0LXw==
X-Received: by 2002:ad4:5884:: with SMTP id dz4mr21324911qvb.46.1612284376826;
        Tue, 02 Feb 2021 08:46:16 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id h185sm17397751qkd.122.2021.02.02.08.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:46:16 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l6yoh-002bjB-Qm; Tue, 02 Feb 2021 12:46:15 -0400
Date:   Tue, 2 Feb 2021 12:46:15 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     jarkko@kernel.org
Cc:     linux-integrity@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Wang Hai <wanghai38@huawei.com>
Subject: Re: [PATCH] tpm: WARN_ONCE() -> pr_warn_once() in tpm_tis_status()
Message-ID: <20210202164615.GM4718@ziepe.ca>
References: <20210202153317.57749-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202153317.57749-1-jarkko@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 02, 2021 at 05:33:17PM +0200, jarkko@kernel.org wrote:
> From: Jarkko Sakkinen <jarkko@kernel.org>
> 
> An unexpected status from TPM chip is not irrecovable failure of the
> kernel. It's only undesirable situation. Thus, change the WARN_ONCE
> instance inside tpm_tis_status() to pr_warn_once().
> 
> In addition: print the status in the log message because it is actually
> useful information lacking from the existing log message.
> 
> Suggested-by:  Guenter Roeck <linux@roeck-us.net>
> Cc: stable@vger.kernel.org
> Fixes: 6f4f57f0b909 ("tpm: ibmvtpm: fix error return code in tpm_ibmvtpm_probe()")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>  drivers/char/tpm/tpm_tis_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 431919d5f48a..21f67c6366cb 100644
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -202,7 +202,7 @@ static u8 tpm_tis_status(struct tpm_chip *chip)
>  		 * acquired.  Usually because tpm_try_get_ops() hasn't
>  		 * been called before doing a TPM operation.
>  		 */
> -		WARN_ONCE(1, "TPM returned invalid status\n");
> +		pr_warn_once("TPM returned invalid status: 0x%x\n", status);

Use dev_warn_once since we have a chip->dev here

Jason
