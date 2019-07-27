Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF7DC77613
	for <lists+linux-integrity@lfdr.de>; Sat, 27 Jul 2019 04:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfG0CtF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jul 2019 22:49:05 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:53660 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfG0CtF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jul 2019 22:49:05 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 131F972CC6C;
        Sat, 27 Jul 2019 05:49:03 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id F0E414A4AE8;
        Sat, 27 Jul 2019 05:49:02 +0300 (MSK)
Date:   Sat, 27 Jul 2019 05:49:02 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v1 4/5] ima-evm-utils: Allow multiple files in ima_verify
Message-ID: <20190727024902.zbbcibkrulqcautd@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20190707234837.4866-1-vt@altlinux.org>
 <20190707234837.4866-5-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20190707234837.4866-5-vt@altlinux.org>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Mon, Jul 08, 2019 at 02:48:36AM +0300, Vitaly Chikunov wrote:
> This allows testing multiple verify in a row, similar to ima_measurement.
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>  src/evmctl.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index fac593a..7ce2022 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -850,9 +850,11 @@ static int cmd_verify_ima(struct command *cmd)
>  		return -1;
>  	}
>  
> -	err = verify_ima(file);
> -	if (!err && params.verbose >= LOG_INFO)
> -		log_info("%s: verification is OK\n", file);
> +	do {
> +		err = verify_ima(file);
> +		if (!err && params.verbose >= LOG_INFO)
> +			log_info("%s: verification is OK\n", file);
> +	} while ((file = g_argv[optind++]));

Currently `err' is affected only by the last verified file. But I think
value of err should be affected by results from all files. But how?
Should we AND verification results or OR? I think it should be ANDed and
will send new version of this patch.

Thanks,

>  	return err;
>  }
>  
> -- 
> 2.11.0
