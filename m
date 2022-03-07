Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB514D0322
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Mar 2022 16:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243887AbiCGPnI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Mar 2022 10:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243924AbiCGPnD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Mar 2022 10:43:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AC176652;
        Mon,  7 Mar 2022 07:42:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 689B461479;
        Mon,  7 Mar 2022 15:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B34C340EB;
        Mon,  7 Mar 2022 15:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646667727;
        bh=vwimokoLmujACAs7ILvplWTc17PHeX1/UInnu8gaKw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IWGX3p+743ArJ22T83/9Z72NRV0Bgp+PWTHxZ+tGuKxnKIvXYX4lEN4ZyEiyCFhRc
         aVlKCRmHsEbLkPGUorJmFixVg6ri1DTyKti3DlmA8EIbRrjJrghfCtDw3vTC+FOxx/
         3uv3QU4Uc4UY0fBo3fftbiKxCrElM0u5KRWhk1csSDptwopQinmbLr8ojn7lmhOBoO
         QR+b3ZwJNO1sOXYEMLzQZ+2sfg3IPbCdQSHrJZ45GZSS1CpbE+XKkwMsyhd9ED6CLf
         t8dM14PHbJ2yFh5LXe+9zNEu2EZvkw7ovZCY1lZL6gvobR0HXt4+M27AyTKz68xVWe
         t5Rdnboa6AhiA==
Date:   Mon, 7 Mar 2022 17:41:26 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Sergey Temerkhanov <s.temerkhanov@gmail.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm: Rework open/close/shutdown to avoid races
Message-ID: <YiYnpsryEDlrryzU@iki.fi>
References: <20201215133801.546207-1-s.temerkhanov@gmail.com>
 <e7566e1e48f5be9dca034b4bfb67683b5d3cb88f.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7566e1e48f5be9dca034b4bfb67683b5d3cb88f.camel@HansenPartnership.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Dec 15, 2020 at 10:51:43AM -0800, James Bottomley wrote:
> On Tue, 2020-12-15 at 16:38 +0300, Sergey Temerkhanov wrote:
> > Avoid race condition at shutdown by shutting downn the TPM 2.0
> > devices synchronously. This eliminates the condition when the
> > shutdown sequence sets chip->ops to NULL leading to the following:
> > 
> > [ 1586.593561][ T8669] tpm2_del_space+0x28/0x73
> > [ 1586.598718][ T8669] tpmrm_release+0x27/0x33wq
> > [ 1586.603774][ T8669] __fput+0x109/0x1d
> > [ 1586.608380][ T8669] task_work_run+0x7c/0x90
> > [ 1586.613414][ T8669] prepare_exit_to_usermode+0xb8/0x128
> > [ 1586.619522][ T8669] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [ 1586.626068][ T8669] RIP: 0033:0x4cb4bb
> 
> An actual bug report would have been helpful.  However, from this trace
> it's easy to deduce that tpm2_del_space() didn't get converted to the
> get/put of the chip ops ... it's still trying to do its own half arsed
> thing with tpm_chip_start() and the mutex.  So isn't a much simpler fix
> simply to convert it as below?  compile tested only, but if you can
> test it out I'll send a proper patch.
> 
> James
> 
> ---
> 
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> index 784b8b3cb903..0c0cd225046f 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -58,12 +58,12 @@ int tpm2_init_space(struct tpm_space *space, unsigned int buf_size)
>  
>  void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
>  {
> -	mutex_lock(&chip->tpm_mutex);
> -	if (!tpm_chip_start(chip)) {
> +
> +	if (tpm_try_get_ops(chip) == 0) {
>  		tpm2_flush_sessions(chip, space);
> -		tpm_chip_stop(chip);
> +		tpm_put_ops(chip);
>  	}
> -	mutex_unlock(&chip->tpm_mutex);
> +
>  	kfree(space->context_buf);
>  	kfree(space->session_buf);
>  }
> 

James, would it possible for you to construct a proper patch from this and
send it so we could include it to the next PR (use my tree as baseline)?

BR, Jarkko
