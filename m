Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0DC211BA92
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2019 18:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbfLKRpm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Dec 2019 12:45:42 -0500
Received: from mga04.intel.com ([192.55.52.120]:59055 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729524AbfLKRpm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Dec 2019 12:45:42 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 09:45:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,302,1571727600"; 
   d="scan'208";a="210841921"
Received: from cmclough-mobl.ger.corp.intel.com (HELO localhost) ([10.251.85.152])
  by fmsmga008.fm.intel.com with ESMTP; 11 Dec 2019 09:45:38 -0800
Date:   Wed, 11 Dec 2019 19:45:36 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     Will Deacon <will@kernel.org>,
        Jeffrin Jose <jeffrin@rajagiritech.edu.in>,
        peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: [PROBLEM]: WARNING: lock held when returning to user space!
 (5.4.1 #16 Tainted: G )
Message-ID: <20191211174536.GG4516@linux.intel.com>
References: <20191207173420.GA5280@debian>
 <20191209103432.GC3306@willie-the-truck>
 <20191209202552.GK19243@linux.intel.com>
 <34e5340f-de75-f20e-7898-6142eac45c13@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34e5340f-de75-f20e-7898-6142eac45c13@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 09, 2019 at 01:34:29PM -0800, Tadeusz Struk wrote:
> I think that's expected for a non-blocking operation.

What do you mean by "expected"?

It is a locking bug. When you implemented the feature you failed
to free locks before going back to the user space and I failed to
notice this when I reviewed the code.

> To get rid of the warning it should be changed to something like this:
> 
> diff --git a/drivers/char/tpm/tpm-dev-common.c
> b/drivers/char/tpm/tpm-dev-common.c
> index 2ec47a69a2a6..47f1c0c5c8de 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -61,6 +61,12 @@ static void tpm_dev_async_work(struct work_struct *work)
> 
>  	mutex_lock(&priv->buffer_mutex);
>  	priv->command_enqueued = false;
> +	ret = tpm_try_get_ops(priv->chip);
> +	if (ret) {
> +		priv->response_length = ret;
> +		goto out;
> +	}
> +
>  	ret = tpm_dev_transmit(priv->chip, priv->space, priv->data_buffer,
>  			       sizeof(priv->data_buffer));
>  	tpm_put_ops(priv->chip);
> @@ -68,6 +74,7 @@ static void tpm_dev_async_work(struct work_struct *work)
>  		priv->response_length = ret;
>  		mod_timer(&priv->user_read_timer, jiffies + (120 * HZ));
>  	}
> +out:
>  	mutex_unlock(&priv->buffer_mutex);
>  	wake_up_interruptible(&priv->async_wait);
>  }
> @@ -205,6 +212,7 @@ ssize_t tpm_common_write(struct file *file, const
> char __user *buf,
>  		priv->command_enqueued = true;
>  		queue_work(tpm_dev_wq, &priv->async_work);
>  		mutex_unlock(&priv->buffer_mutex);
> +		tpm_put_ops(priv->chip);
>  		return size;
>  	}
> 
> 
> 
> -- 
> Tadeusz

The fix looks appropriate but needs to be formalized as a patch.

/Jarkko
