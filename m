Return-Path: <linux-integrity+bounces-5220-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D1FA5BCA2
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 10:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14AC169D49
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 09:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F9221D59F;
	Tue, 11 Mar 2025 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u66+noem"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601D11E2606;
	Tue, 11 Mar 2025 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741686535; cv=none; b=YGwAbyb55Geb4rKIkBCbyU3Sv8b8oi1lUSVP2QP7lTX++LgFK8QnQfXUYyS8SgqXlt8rKN6n6GJJ/uxun/GOeqT7CORFZfWZSV98w3Cas70FNsWvkEsm58QXJJG1BJ0rh+kKhS29pX3bo5D8v/HwyYhdq5YN75ist1+obWgmh/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741686535; c=relaxed/simple;
	bh=93UKU5mEDqUcsUeZDcr+iG6Ao50gKtx6g84cL8q5fDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0+NLb37CwD/zywX4imuKyOCm2ivNkc8MBgXbUAitF7P2aEoZvqmeRIagV93lE/XYFEFNVD5Qy0GJEG0T+8LqA6DTO2vNVuNaIX5pjyI/W08udbCsCli6W0z0aQY5BSczBUMztDqhSDiamJ71s9Tl/H60tWyq2JR4hrzLai1v4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u66+noem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66808C4CEE9;
	Tue, 11 Mar 2025 09:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741686534;
	bh=93UKU5mEDqUcsUeZDcr+iG6Ao50gKtx6g84cL8q5fDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u66+noemDSakjJYIpyrFjgSCoAaBk2CEmBnpxwmygmaccLXYnDe5+kF9fcsmsK0fF
	 TePbdK+6au9f4pxtTXKAQqYU9f9hjER3BQu1HFtH1kHQ14zlPSxtXQED3fz6G8S6zc
	 /Ethszp/7r1bXEXxarmL1ccgnSh4OUC0Xalv4W4oF9FyPNIyt9nRNcV6ODWnqhEIYn
	 q6hU/iIKLHURhq4jmKmSBNe5OD8T8xhuYpp8Je6FrzslFh9x9APyzZoZuhZo9dta3w
	 uaplBW+zcO/f5sqztbAhEf1q7785u8Z5KqLY6rAdeFoOdd6+tdZt2U5wjWdEqfzEyx
	 iOE66sYxnkpAw==
Date: Tue, 11 Mar 2025 11:48:51 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm, tpm_tis: Fix timeout handling when waiting for
 TPM status
Message-ID: <Z9AHA0rhq3A1bhGt@kernel.org>
References: <Z8gdKxsw2unC5UID@earth.li>
 <Z87ZcPZvoUXZ7M_f@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z87ZcPZvoUXZ7M_f@earth.li>

On Mon, Mar 10, 2025 at 12:22:08PM +0000, Jonathan McDowell wrote:
> The change to only use interrupts to handle supported status changes
> introduced an issue when it is necessary to poll for the status. Rather
> than checking for the status after sleeping the code now sleeps after
> the check. This means a correct, but slower, status change on the part
> of the TPM can be missed, resulting in a spurious timeout error,
> especially on a more loaded system. Switch back to sleeping *then*
> checking. An up front check of the status has been done at the start of
> the function, so this does not cause an additional delay when the status
> is already what we're looking for.
> 
> Cc: stable@vger.kernel.org # v6.4+
> Fixes: e87fcf0dc2b4 ("tpm, tpm_tis: Only handle supported interrupts")
> Signed-off-by: Jonathan McDowell <noodles@meta.com>
> Reviewed-by: Michal Suchánek <msuchanek@suse.de>
> Reviewed-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
> v2: Reword commit message
>     Don't needlessly wrap line
> 
>  drivers/char/tpm/tpm_tis_core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index fdef214b9f6b..c969a1793184 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -114,11 +114,10 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
>  		return 0;
>  	/* process status changes without irq support */
>  	do {
> +		usleep_range(priv->timeout_min, priv->timeout_max);
>  		status = chip->ops->status(chip);
>  		if ((status & mask) == mask)
>  			return 0;
> -		usleep_range(priv->timeout_min,
> -			     priv->timeout_max);
>  	} while (time_before(jiffies, stop));
>  	return -ETIME;
>  }
> -- 
> 2.48.1
> 

Probably apply late this and timeout fix late this week.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

