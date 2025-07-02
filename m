Return-Path: <linux-integrity+bounces-6593-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DBEAF659D
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 00:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE1651C462F5
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Jul 2025 22:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D291247298;
	Wed,  2 Jul 2025 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2TOkb76"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA6E24679A
	for <linux-integrity@vger.kernel.org>; Wed,  2 Jul 2025 22:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751496391; cv=none; b=CpJkRtASRtlzvS7EGAukin/+R9MfM4/c2Yj/jmSq4NAbIpPqLIa21+QnUllaVdEgb3dg72QynZEIUge8B+y+3LKx8lnsr/zzB1XmWFZ8yUpqNoxY30vr5pyBlezBuXsnesWDE/jnglD47IRJRIE5knrhZfXuElW3hm5AIHJA6fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751496391; c=relaxed/simple;
	bh=YJZDpJ4WPdgUAWJ8luDJqi5MpU/82ToTDmJsSuKzI9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0phPw5aEH4hGzN8iU8+0OS02kIX1tJEdW7DEqE5CJQLOWqyIdvepi1cm0Y2GTsDQWPexnlwzNhVZDg1EisoctHbU7GV0+53boicnC86mke+keTElaDaXXYLURSoayxUz0u3C/sEIN393+ndlKh4OJzM057MgwXoIMjYIX3nA9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2TOkb76; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6BEC4CEEE;
	Wed,  2 Jul 2025 22:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751496389;
	bh=YJZDpJ4WPdgUAWJ8luDJqi5MpU/82ToTDmJsSuKzI9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c2TOkb76ewCVkkx7NNu12g2zQmmF1eGq5WUsNDrxx+vGyDPuaRfuMIJ/j2D1o7l6/
	 lxtkGpXFpqkmGa2oLCjN/YByPSc6hKkzOtZx90JX2NjS7+6z/ht8Mu7aLbFSwZUuSy
	 eUkf714kvWhBjGeLxw0/zOXHYN8YAui57XnhXvPFyIU9LxONBT8NhFhC4t2P3x3H5x
	 aG5SGqnOfz6WAyEGDDLn7hbaIPtDSYczPCaaq71Jmf/RfMS80FJfka4iF/Tj4JyJZD
	 uwWiJAUwYU14KIyYTDZbJYQWhoEdj4WhrSvd563bTFHDPv4KnZos3MwHS/N0pK+YO/
	 yABPfpS5IMlVg==
Date: Thu, 3 Jul 2025 01:46:25 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Denis Aleksandrov <daleksan@redhat.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	Jan Stancek <jstancek@redhat.com>
Subject: Re: [PATCH] tpm: prevents local DOS via tpm/tpm0/ppi/*operations
Message-ID: <aGW2wabMXtdBEQxR@kernel.org>
References: <20250702202851.33344-1-daleksan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702202851.33344-1-daleksan@redhat.com>

On Wed, Jul 02, 2025 at 04:28:51PM -0400, Denis Aleksandrov wrote:
> This bug is not seen on most machines. Reads on tpm/tpm0/ppi/*operations
> can become very long on misconfigured systems. Reading the TPM is a
> blocking operation, thus a user could effectively trigger a DOS.
> 
> Resolve this by restricting unprivileged user from reading the
> above-mentioned device files.

I suppose we can do this. I'm going to holiday for one week next
week so I'll hold for additional feedback for that period and
apply this if nothing comes up.

There's no use case for unprivileged user, or app that stops
working because of this. If you cut hairs, with patch shifting
uapi you have to we always prepared that tree falls down
somewhere but I'm willing to take risk with this :-)


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

> 
> Reported-by: Jan Stancek <jstancek@redhat.com>
> Signed-off-by: Denis Aleksandrov <daleksan@redhat.com>
> ---
> 
> Running scripts/checkpatch.pl suggested that the permissions be
> changed to octal format. What do the maintainers think of this?
> The rest of the permissions in the file are macros.
> 
> Lastly, this bug was reproduced and the fix was tested accordingly.
> 
>  drivers/char/tpm/tpm_ppi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
> index bc7b1b4501b3..ac6e0aee566e 100644
> --- a/drivers/char/tpm/tpm_ppi.c
> +++ b/drivers/char/tpm/tpm_ppi.c
> @@ -347,8 +347,8 @@ static DEVICE_ATTR(request, S_IRUGO | S_IWUSR | S_IWGRP,
>  static DEVICE_ATTR(transition_action, S_IRUGO,
>  		   tpm_show_ppi_transition_action, NULL);
>  static DEVICE_ATTR(response, S_IRUGO, tpm_show_ppi_response, NULL);
> -static DEVICE_ATTR(tcg_operations, S_IRUGO, tpm_show_ppi_tcg_operations, NULL);
> -static DEVICE_ATTR(vs_operations, S_IRUGO, tpm_show_ppi_vs_operations, NULL);
> +static DEVICE_ATTR(tcg_operations, S_IRUSR | S_IRGRP, tpm_show_ppi_tcg_operations, NULL);
> +static DEVICE_ATTR(vs_operations, S_IRUSR | S_IRGRP, tpm_show_ppi_vs_operations, NULL);
>  
>  static struct attribute *ppi_attrs[] = {
>  	&dev_attr_version.attr,
> -- 
> 2.48.1
> 

BR, Jarkko

