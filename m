Return-Path: <linux-integrity+bounces-5180-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F399A56DF2
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Mar 2025 17:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C921670EE
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Mar 2025 16:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148D12405E4;
	Fri,  7 Mar 2025 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+aIeW9G"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D6C2405E3;
	Fri,  7 Mar 2025 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365367; cv=none; b=NCsG8OGLAGPY25tn9Yh4DYrYz9jQXjeSqOqUNoRHv/xfyINp0KCpPjYtceZp/6a2aGhraZTt5lgLH+hBCIIm+v8NFefXQN/Io47oc3tcMNngoYMIN1Gs+uA6TQyJqB1+jVG3flamhD5F6kXEKVg3K7EmZ/qwEJjPjh9iNplld6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365367; c=relaxed/simple;
	bh=Lc/mT5ByZu/wXZSgW4FnNIk9VOvE0eb2zgZZvxT8bZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXVmIsk5nbo5NLbRztzt70kOT36KBmQ9Sr+zco8/3r4fn/gli+KSAdUjfc4z4tvJKc4Sq2okDwCVrMdmwt1J+yUa0Zk5G14oPGbhE9ix1Mz4fNtE1oj5vvm6UDkgCoGl+eE+EwGWPO1XN23neLVaHKfA42bR7aEY39EGBfGsb5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+aIeW9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBABC4CED1;
	Fri,  7 Mar 2025 16:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741365367;
	bh=Lc/mT5ByZu/wXZSgW4FnNIk9VOvE0eb2zgZZvxT8bZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N+aIeW9GCIEe2MPY6WBBPeKQEIw6/3ZZlxcNJS6o9pr6yIbRgbx5ZN3mWhU1lq8/b
	 iVzLCmYQml966e0ucomkEATMrqTmFQuAqCKKVIsD30TaAklvPd8W4pgMIevU25AzK7
	 GytjpvwLCb1f4PYeedRsNigovO8qWzbYD0hq6mcH+e2wpO5fRUvtJzL6ispx97eRFA
	 MsXezXVgRIkTZrq53SICIQlFAJZ0aCxXhUVWzyJfqxstmsoZAhHH/qf8Ggw3s25e28
	 +PgNHJp6v4kec2SRqhvRb8s85xM81gRWNyDTlMmOPZkCNJ4RwgF15v2CoZAWJTNPvD
	 U3vXegyn2ji/Q==
Date: Fri, 7 Mar 2025 18:36:02 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Drop warning when an auth session is active
Message-ID: <Z8sgcquTyx1ICvS_@kernel.org>
References: <Z8m8G0RfiRyYGH_t@earth.li>
 <Z8oV9lJ4hsHualcP@kernel.org>
 <Z8rQ7Mxf_G6227HP@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8rQ7Mxf_G6227HP@earth.li>

On Fri, Mar 07, 2025 at 10:56:44AM +0000, Jonathan McDowell wrote:
> Auth sessions are lazily flushed since commit df745e25098dc ("tpm:
> Lazily flush the auth session"), so it's expected that we might try to
> start a new session when one is still active.
> 
> Signed-off-by: Jonathan McDowell <noodles@meta.com>
> ---
>  drivers/char/tpm/tpm2-sessions.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> index b70165b588ec..2d2c192ebb14 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -982,7 +982,6 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
>  	int rc;
>  
>  	if (chip->auth) {
> -		dev_warn_once(&chip->dev, "auth session is active\n");
>  		return 0;
>  	}

OK so curly faces should be also removed but I can adjust this
(if you don't mind), so we save all of us from trouble of
going through additional review round?

>  
> -- 
> 2.48.1
> 

BR, Jarkko

