Return-Path: <linux-integrity+bounces-5381-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92696A6CC95
	for <lists+linux-integrity@lfdr.de>; Sat, 22 Mar 2025 22:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E1A179C0E
	for <lists+linux-integrity@lfdr.de>; Sat, 22 Mar 2025 21:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90F51EF38A;
	Sat, 22 Mar 2025 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOGO7Nx6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE1037160;
	Sat, 22 Mar 2025 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742677812; cv=none; b=NnJlAd/6ERG/WfSSM9Sczio6qYGKkgfWVhj+NtZyvCSQeXQ9aI04Nuz1+a8bZJqC625DpODq++gCEetWnP7q719hyyoh2HC6aGFERt77ySiOXGrjuRzZQGBKsiYLUTEjKb5jJ0oiugAt9wHB4OSGJXtQKiBDcLLimEkmf8qAKfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742677812; c=relaxed/simple;
	bh=253N/PzBFBuwQnC0JHoJgHSfsloq0t1CvPxbViUcp2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1KNnuoH77AecXYgG74u4xToEhm5GfJDYHhVL54F1+ER0RsgyDnU/ZdKm0HcQAyjmXmBaZ7GwDZnTCzwkolFJGM15/LRADb09LUCaDW9ERG8o0aWywS+evGuKB7ZbiJ7qoVQZGLlx8Aghr07EMbYm8i154OANaD36cMsBmwzYhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOGO7Nx6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B1EC4CEDD;
	Sat, 22 Mar 2025 21:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742677812;
	bh=253N/PzBFBuwQnC0JHoJgHSfsloq0t1CvPxbViUcp2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dOGO7Nx6X2LGTuemY7rLKTm6dwVrsPYzGHUR3s8FbsvdJTyWXpI53syQNnVLssSYi
	 J1TcN2sZsIYDeSXNzPOMG6u9jert9AnItZPP9/3rJKL2Ls9EE8+g6kLjPTV0Fwai1E
	 8CGH1YT8ElE5NPxj3qW6uRelsMtzW3PTJ/NuvxuJL4pn4jXPflh4FV5XoFoOYFej3c
	 pt/eGXYjQMX8PBv/rXFF2+jXWTSsXIA03WkJQ5Ss8X3+3HBdHyZi86BBcn7oXepRs3
	 IFzd0LMgGSBMM0q9bHx59jhuwCJZgXnv6HxkFv/ZorE3rhgpRLLz+jT8i0RwnXy8JS
	 XkY60qLdE899g==
Date: Sat, 22 Mar 2025 23:10:08 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm, tpm_tis: Workaround failed command reception on
 Infineon devices
Message-ID: <Z98nMDH5Anhwuwox@kernel.org>
References: <Z8lkSKOqBgt78pU2@earth.li>
 <Z8ogT_gERUYstPbK@kernel.org>
 <Z8sgfMmsfn894yLj@earth.li>
 <Z8sixTuKG5sxO-D1@kernel.org>
 <Z87Y69l5_GbzlLfp@earth.li>
 <Z92YiwubEvzsm1SO@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z92YiwubEvzsm1SO@earth.li>

On Fri, Mar 21, 2025 at 04:49:15PM +0000, Jonathan McDowell wrote:
> Jarkko, I've realised I've somehow introduced a typo in the patch below that
> means it doesn't fire correctly; I'm not sure how this happened as my local
> copy I was testing on is definitely correct. Would you like a one line fix
> up patch, or can you manually fix it up in your tree?
> 
> This hunk:
> 
> > @@ -545,9 +551,11 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
> > 		if (rc >= 0)
> > 			/* Data transfer done successfully */
> > 			break;
> > -		else if (rc != -EIO)
> > +		else if (rc != EAGAIN && rc != -EIO)
> > 			/* Data transfer failed, not recoverable */
> > 			return rc;
> > +
> > +		usleep_range(priv->timeout_min, priv->timeout_max);
> > 	}
> > 	/* go and do it */
> 
> should be "rc != -EAGAIN" - the "-" sign has somehow been lost.
> 
> Apologies for this, let me know what's easiest for you in terms of resolving
> it.

NP, I missed it too so we're in the same boat ;-)

I did:

$ git -P diff
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 4ab69c3e103c..ed0d3d8449b3 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -551,7 +551,7 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 		if (rc >= 0)
 			/* Data transfer done successfully */
 			break;
-		else if (rc != EAGAIN && rc != -EIO)
+		else if (rc != -EAGAIN && rc != -EIO)
 			/* Data transfer failed, not recoverable */
 			return rc;

Ping, if anything else.

BR, Jarkko

