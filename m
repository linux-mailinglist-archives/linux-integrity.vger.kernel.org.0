Return-Path: <linux-integrity+bounces-7317-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E37FBACDED
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 14:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD541924A8C
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 12:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6781B2FC895;
	Tue, 30 Sep 2025 12:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIBoWmF3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F012BDC33;
	Tue, 30 Sep 2025 12:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235850; cv=none; b=YyWjSFxXYMEQdacvYvTy4bH9BD7MY2wkMeQkWPZnRpes4FLpWIag858tt737JZ3X3lPAd6fR1U9YEr6d0Vt1c3tc1AKwY0/1V0E4DSeXLDd1X0G0QIaFPZTtrHbVhk4UVe99GxfBlygx4AuDwP5vFfUp3pQewsah0U0vobDSv5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235850; c=relaxed/simple;
	bh=l5pHp5AlMzSxoQqIPpBHkZhplwb7eUU3H6QIlz+1zzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBu8vm0dXzy+CnA3Dql4srTlHwNhA9QADnLEFgYMjA8ngT7FTKhU3ly4tv5F3eKK6ABnQ/QOYT4p9444iStmOUX3n/BTUcbWlr/V4+UkzpLcLE59WLUqaPEfLCAMZVL8JiqtunlEK27lAJqjaWUYei7BGaKhngaya1YmkAC6+KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIBoWmF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67553C4CEF0;
	Tue, 30 Sep 2025 12:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759235849;
	bh=l5pHp5AlMzSxoQqIPpBHkZhplwb7eUU3H6QIlz+1zzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CIBoWmF34QduzaB45ayA20mH8hBPBoKJ0Sg29Z1SrIVfwup0iZA9PjXtyu6wiWXUd
	 qKVjCt41cMv4H8KJatGK+4h5al6NoWn7KJRZJUIHYBqEISUjUH3I3ayqSkOoHdT6rt
	 ToX4Jjdh7/UtRMdjIfXFQ63fQBghCU8Q5oiwI76AaLLlxg9h6a0h4EPJTci7+fkkLr
	 uD8oAgD95MF6qiRrUiJwT5jtCqX29Y0HQm20YADfwolazBo39+vi6FnftKGgvARpO2
	 tqDVTs88Q3NcwvYjvWdjrtzVKwLQy9xJONcdfUs0DLnNzBFlgF34fR9M1Sq4u7TZzv
	 dLbE1L9BoB33w==
Date: Tue, 30 Sep 2025 15:37:25 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-integrity@vger.kernel.org, dpsmith@apertussolutions.com,
	ross.philipson@oracle.com,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 02/10] tpm: Use -EPERM as fallback error code in
 tpm_ret_to_err
Message-ID: <aNvPBeldvMR5IjIq@kernel.org>
References: <20250929194832.2913286-1-jarkko@kernel.org>
 <20250929194832.2913286-3-jarkko@kernel.org>
 <hjay4b2lomj6k63tbnuk55q6mm4sdj2d7yycw64ybhu372l6bd@uqetr6ipbtg4>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hjay4b2lomj6k63tbnuk55q6mm4sdj2d7yycw64ybhu372l6bd@uqetr6ipbtg4>

On Tue, Sep 30, 2025 at 02:11:23PM +0200, Stefano Garzarella wrote:
> On Mon, Sep 29, 2025 at 10:48:24PM +0300, Jarkko Sakkinen wrote:
> > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > 
> > Using -EFAULT as the tpm_ret_to_err() fallback error code causes makes it
> > incompatible on how trusted keys transmute TPM return codes.
> > 
> > Change the fallback as -EPERM in order to gain compatibility with trusted
> > keys. In addition, map TPM_RC_HASH to -EINVAL in order to be compatible
> > with tpm2_seal_trusted() return values.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > ---
> > v3:
> > - Removed fixes tag as it hardly categorizes as a bug fix.
> > v2:
> > - Split trusted_tpm2 change to a separate patch.
> > ---
> > include/linux/tpm.h | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> 
> LGTM now!
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thank you.

> 
> > 
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > index fc7df87dfb9a..51846317d662 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -453,8 +453,10 @@ static inline ssize_t tpm_ret_to_err(ssize_t ret)
> > 		return 0;
> > 	case TPM2_RC_SESSION_MEMORY:
> > 		return -ENOMEM;
> > +	case TPM2_RC_HASH:
> > +		return -EINVAL;
> > 	default:
> > -		return -EFAULT;
> > +		return -EPERM;
> > 	}
> > }
> > 
> > -- 
> > 2.39.5
> > 
> > 
> 

BR, Jarkko

