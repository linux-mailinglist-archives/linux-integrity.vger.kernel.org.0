Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9089010F14E
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Dec 2019 21:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfLBUGH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Dec 2019 15:06:07 -0500
Received: from mail.hallyn.com ([178.63.66.53]:55390 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727927AbfLBUGH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Dec 2019 15:06:07 -0500
X-Greylist: delayed 579 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Dec 2019 15:06:06 EST
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 00443A1D; Mon,  2 Dec 2019 13:56:26 -0600 (CST)
Date:   Mon, 2 Dec 2019 13:56:26 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com
Subject: Re: [v11-ima PATCH 20/25] LSM: Verify LSM display sanity in binder
Message-ID: <20191202195626.GA32116@mail.hallyn.com>
References: <20191127213718.18267-1-casey@schaufler-ca.com>
 <20191127213718.18267-21-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127213718.18267-21-casey@schaufler-ca.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Nov 27, 2019 at 01:37:13PM -0800, Casey Schaufler wrote:
> Verify that the tasks on the ends of a binder transaction
> use the same "display" security module. This prevents confusion
> of security "contexts".
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/security.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/security/security.c b/security/security.c
> index 101063b00aeb..0e8c61cceecd 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -738,9 +738,38 @@ int security_binder_set_context_mgr(struct task_struct *mgr)
>  	return call_int_hook(binder_set_context_mgr, 0, mgr);
>  }
>  
> +/**
> + * security_binder_transaction - Binder driver transacton check

nit - mis-spelled transaction

> + * @from: source of the transaction
> + * @to: destination of the transaction
> + *
> + * Verify that the tasks have the same LSM "display", then
> + * call the security module hooks.
> + *
> + * Returns -EINVAL if the displays don't match, or the
> + * result of the security module checks.
> + */
>  int security_binder_transaction(struct task_struct *from,
>  				struct task_struct *to)
>  {
> +	int from_display = lsm_task_display(from);
> +	int to_display = lsm_task_display(to);
> +
> +	/*
> +	 * If the display is LSMBLOB_INVALID the first module that has
> +	 * an entry is used. This will be in the 0 slot.
> +	 *
> +	 * This is currently only required if the server has requested
> +	 * peer contexts, but it would be unwieldly to have too much of
> +	 * the binder driver detail here.
> +	 */
> +	if (from_display == LSMBLOB_INVALID)
> +		from_display = 0;
> +	if (to_display == LSMBLOB_INVALID)
> +		to_display = 0;
> +	if (from_display != to_display)
> +		return -EINVAL;
> +
>  	return call_int_hook(binder_transaction, 0, from, to);
>  }
>  
> -- 
> 2.20.1
