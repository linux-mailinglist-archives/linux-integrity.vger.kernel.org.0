Return-Path: <linux-integrity+bounces-6586-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AACCBAF64FB
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 00:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1995E1899EAD
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Jul 2025 22:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5314F2405F5;
	Wed,  2 Jul 2025 22:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="As7IgWve"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2853123A99E;
	Wed,  2 Jul 2025 22:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751494587; cv=none; b=R5OZPaw60oyYaYmW8vAAbn2KklaTPDoheh6n2QKJvmbkFWlLFF4o7cBvRrL1VBuJCHT5R0C2DnIoLuOHhAeJqxTZz0Nw74JqLb4KR2bsr+z68xU29VEm1jvzKQzxp18DyjJVTeIeBC/h4LWEoCOSX3inI8hEJS3DDU75KETi3pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751494587; c=relaxed/simple;
	bh=OflNvxLEH1O2akJhieop+xklRvAmN34N3d8ULpZQG0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=py8RhVOiC0QeSSJjK4YvzVSFiqqYitb9ucSn/+vkVnVxgOCQmtDFzn8NGSFlK2DA9APXYFKlkTAqehk0B8GABDVSUy/jUogx+nj+/YWeffHlaXWMf0T7auEjkQhxuxO3KKGCZCh7FuJxhPbm8z/ebknE2LZFF/zJ3JXizmUxNRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=As7IgWve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551E1C4CEE7;
	Wed,  2 Jul 2025 22:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751494586;
	bh=OflNvxLEH1O2akJhieop+xklRvAmN34N3d8ULpZQG0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=As7IgWveWOsFaxLCVh3pMZry9ZjKHuccBmbB08fOLUpswyf1zivN+ZCDMYncNZqyf
	 DCICeex/UMS50m4vGrc5dzusWMG3sVY0fg19mnCHXsVd0Qt0K/krwhqJ6e1UQ1p4or
	 ur5XJY+AcJjDeGZk+pFsRVkFRjQlJSGhdb+Xq0xMgs80v/rkPTPyWSj1XElW3AJtxw
	 hO6mt+kJEOsejuq0px+OkOWKQqT3ZF8uN8K+kxUKbkKOT0t/PwmshnINbtoyPIj3F6
	 4thUabcQh2S6wVgp7Yhb6wN48JRzd4zcia/guR6OKVHduVTe8omBkl9LDrBUeIr4lC
	 WgI4emNSV/l0w==
Date: Thu, 3 Jul 2025 01:16:23 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Prachotan Bathi <prachotan.bathi@arm.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/3] tpm_crb_ffa:Introduce memzero macro to replace
 memset
Message-ID: <aGWvtzhs5ksKgaYo@kernel.org>
References: <20250626184521.1079507-1-prachotan.bathi@arm.com>
 <20250626184521.1079507-3-prachotan.bathi@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626184521.1079507-3-prachotan.bathi@arm.com>

On Thu, Jun 26, 2025 at 01:45:20PM -0500, Prachotan Bathi wrote:
> Add a memzero macro to simplify and standardize zeroing
> FF-A data args, replacing direct uses of memset for
> improved readability and maintainability.
> 
> Signed-off-by: Prachotan Bathi <prachotan.bathi@arm.com>
> ---
>  drivers/char/tpm/tpm_crb_ffa.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
> index 089d1e54bb46..397cc3b0a478 100644
> --- a/drivers/char/tpm/tpm_crb_ffa.c
> +++ b/drivers/char/tpm/tpm_crb_ffa.c
> @@ -12,6 +12,8 @@
>  #include <linux/arm_ffa.h>
>  #include "tpm_crb_ffa.h"
>  
> +#define memzero(s, n) memset((s), 0, (n))
> +
>  /* TPM service function status codes */
>  #define CRB_FFA_OK			0x05000001
>  #define CRB_FFA_OK_RESULTS_RETURNED	0x05000002
> @@ -192,7 +194,7 @@ static int __tpm_crb_ffa_send_receive(unsigned long func_id,
>  	msg_ops = tpm_crb_ffa->ffa_dev->ops->msg_ops;
>  
>  	if (ffa_partition_supports_direct_req2_recv(tpm_crb_ffa->ffa_dev)) {
> -		memset(&tpm_crb_ffa->direct_msg_data2, 0x00,
> +		memzero(&tpm_crb_ffa->direct_msg_data2,
>  		       sizeof(struct ffa_send_direct_data2));
>  
>  		tpm_crb_ffa->direct_msg_data2.data[0] = func_id;
> @@ -205,7 +207,7 @@ static int __tpm_crb_ffa_send_receive(unsigned long func_id,
>  		if (!ret)
>  			ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data2.data[0]);
>  	} else {
> -		memset(&tpm_crb_ffa->direct_msg_data, 0x00,
> +		memzero(&tpm_crb_ffa->direct_msg_data,
>  		       sizeof(struct ffa_send_direct_data));
>  
>  		tpm_crb_ffa->direct_msg_data.data1 = func_id;
> -- 
> 2.43.0
> 

It adds a ross-reference to the source code, meaning that you have to
jump back and forth in the source code just to see that there is a
function that wraps up a single memset() call.

How does that map to "readability"?

BR, Jarkko

