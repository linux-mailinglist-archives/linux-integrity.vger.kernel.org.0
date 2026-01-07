Return-Path: <linux-integrity+bounces-8196-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D97CFFEF9
	for <lists+linux-integrity@lfdr.de>; Wed, 07 Jan 2026 21:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19E1F300C6FA
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jan 2026 19:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EF93A0B39;
	Wed,  7 Jan 2026 19:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PH9ekTD5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528D81A4F3C
	for <linux-integrity@vger.kernel.org>; Wed,  7 Jan 2026 19:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767815792; cv=none; b=npN41H9uBSOFi3gCYFKdfG47M6X5/CH6du5kR/T2efSL3WbyBHGZQFceXtbNb2Jpac5kg4XTA4mJaKkBwwGlq3Zia8tSgKZpxbgQjbOjUBEFMqkQv/0AM2Tle7AKLDkfCV3RH6N4iT3HibeQHJW0CPpR8YasMvQu8dHUecmeeug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767815792; c=relaxed/simple;
	bh=Sinu5DdXb2jUUu9wjlqM9aGxiyeh/vBcC18cYGXLVxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qe+LmV4pRJcj41ByxFe94XlGoLDowS6REOa3LBBEpV5K0pYpygHDJ23DGTAp4+edPTntm8hWa/dNzyIzy2RnVoAHRv1trKXbrfHeHf4ad4pdNM1rpFTyXVnKjEL0XEgq3WrAQJEU9syzxVeTjRd8PJykmgaBryvamFatNHcL1bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=PH9ekTD5; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4537407477aso1583978b6e.1
        for <linux-integrity@vger.kernel.org>; Wed, 07 Jan 2026 11:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767815789; x=1768420589; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O41qUiOkW+VKyC7PrOLsySTinqwWnLxpgOca+Oi4RJQ=;
        b=PH9ekTD5RDQIjJhbHRwQUSCs1fGkbaY/yOuFrs/5CDSdoamccKABPFBvXbCvNg3OnJ
         K1T5gExYMhk6+Cc2Z4bPcdHsM7OnN9pl6dm2DNLaOMG//N6a7uGp2RWbEzYSpzpQqe/y
         FF/MMlRMHjx8kmjjqOzXSrH7FbjI3plY2xNLpmq+007EHESC7o03z1G5eU9rFgsAYNPR
         vo/P+ASmBHj2xBG9ustomVTDRpqaubGkLwH1oxz8iV50jusy6i3HIvoQrMUxCGTBMgcI
         0F51xiKUdN0afCx9Sc9Xt1nZHQ0qV19meeVYtrUXNgAiuFf9we0xAlbDos6RPTbdGzDM
         9wQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767815789; x=1768420589;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O41qUiOkW+VKyC7PrOLsySTinqwWnLxpgOca+Oi4RJQ=;
        b=PvFlOAv1MBFHqWSUcOdmgu30V/6JMobvtywmKeoVeLuTdiqOJLgt/II0kF0ztwY3CK
         DspcM0Ad+nZThu5x7jpea2LchSMcw8owtqS+8FgZdadrtKgx7WXg7WnCMwtVi4ZbgA8k
         pw98uPaCsG+QE4tFh5LJDef/cVNLY4aVwFP5iMA2VmYJlwKFSS4nCDRyEYZsZhSoL0ff
         s7bdqBpm9s41qcgyPkHZYAf3RokJDFQyPGVLL4Rgg2NPiqo+g782LxwshXfdKZX1Xp9S
         A1b69QdyBDLS1M7cq/TWlJDbymALAEDiuGO/DTxUi1yFo3hGWlN8/+RtkMB+lTuKaOEj
         5zVA==
X-Forwarded-Encrypted: i=1; AJvYcCXxIdF1W0AbLFTEIIuZpg0ng4qGD2kbCC5GASSWYd00BVBdrMhvguS6z5g/ggUHSaZfADNVxqKGFiAVijM113s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+OOvKEigTi4SZVqPezAJQUYW5WrbfFxF6dr/rva6LgCDtV00q
	qSvh7M6BFYcvNtfsWItkpM/0pHHoMIfxNaMSvHj1eptvaTHDAHjRfTjtGqNhAJZI2zc=
X-Gm-Gg: AY/fxX6gd8vVa1PJ2eeGm7haWGGMIsvBmsXfZ/fPNIgHLo+xeUs2hfaH5gQKZ+KOv/G
	zGfLMcKVvxEcRW8bZ8je5v3dwD6PCad9o0rbS8XC50dAS36/RWR3+7q82RKBV493ZWesCwjX77Z
	rMvbdYllbpO9SBwaoaYlvEPPYj9kNfTW5OVwCIZNZFD75xqWtMxy6EIil8+DV+wq21n475ggAsV
	POtP59BA3IwGYNcqfcJMtTgwGvto5zCLowX+VXQ95tK/gV797boaEjNcQLYwEh81fM+BHm9sij7
	GnFwO1T8tDOKPAzzQofrbsY025GjqSseDif3jT3RWUzlqg02dC3UYQwURUuKPGULc9YMCBKOHo/
	TeqA+TKp8fxdzRW1deRL0tzmB6T0muVNNjYO3yBcmqhgZEE3CYGZcc66sr3i4J+SuVA==
X-Google-Smtp-Source: AGHT+IGAdoZqHpSptnY8ATxWImZshM/+1JEbbxBg/VXWW3OUExxmEYiwsph4CrhPl6fpX6D6e/TTlQ==
X-Received: by 2002:a05:6808:c2b4:b0:44f:8f65:1e24 with SMTP id 5614622812f47-45a6bf4d451mr1658822b6e.60.1767815789034;
        Wed, 07 Jan 2026 11:56:29 -0800 (PST)
Received: from CMGLRV3 ([2a09:bac5:947d:4e6::7d:80])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e17cd81sm2694073b6e.2.2026.01.07.11.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 11:56:28 -0800 (PST)
Date: Wed, 7 Jan 2026 13:56:26 -0600
From: Frederick Lawler <fred@cloudflare.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH RFC] ima: Fallback to a ctime guard without i_version
 updates
Message-ID: <aV66am9A5MmdNPbY@CMGLRV3>
References: <20251229-xfs-ima-fixup-v1-1-6a717c939f7c@cloudflare.com>
 <3ad9ded9b3a269908eee6c79b70dbf432e60ce8d.camel@kernel.org>
 <aV07lY6NOkNvUk3Z@CMGLRV3>
 <aV1jhIS24tE-dL9A@CMGLRV3>
 <25b6d1b42ea07b058be4e4f48bb5a7c6b879b3ed.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25b6d1b42ea07b058be4e4f48bb5a7c6b879b3ed.camel@kernel.org>

On Tue, Jan 06, 2026 at 02:50:31PM -0500, Jeff Layton wrote:
> On Tue, 2026-01-06 at 13:33 -0600, Frederick Lawler wrote:
> > On Tue, Jan 06, 2026 at 10:43:01AM -0600, Frederick Lawler wrote:
> > > Hi Jeff,
> > > 
> > > On Tue, Jan 06, 2026 at 07:01:08AM -0500, Jeff Layton wrote:
> > > > On Mon, 2025-12-29 at 11:52 -0600, Frederick Lawler wrote:
> > > > > Since commit 1cf7e834a6fb ("xfs: switch to multigrain timestamps"), IMA
> > > > > is no longer able to correctly track inode.i_version due to the struct
> > > > > kstat.change_cookie no longer containing an updated i_version.
> > > > > 
> > > > > Introduce a fallback mechanism for IMA that instead tracks a
> > > > > integrity_ctime_guard() in absence of or outdated i_version
> > > > > for stacked file systems.
> > > > > 
> > > > > EVM is left alone since it mostly cares about the backing inode.
> > > > > 
> > > > > Link: https://lore.kernel.org/all/aTspr4_h9IU4EyrR@CMGLRV3
> > > > > Fixes: 1cf7e834a6fb ("xfs: switch to multigrain timestamps")
> > > > > Suggested-by: Jeff Layton <jlayton@kernel.org>
> > > > > Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> > > > > ---
> > > > > The motivation behind this was that file systems that use the
> > > > > cookie to set the i_version for stacked file systems may still do so.
> > > > > Then add in the ctime_guard as a fallback if there's a detected change.
> > > > > The assumption is that the ctime will be different if the i_version is
> > > > > different anyway for non-stacked file systems.
> > > > > 
> > > > > I'm not too pleased with passing in struct file* to
> > > > > integrity_inode_attrs_changed() since EVM doesn't currently use
> > > > > that for now, but I couldn't come up with another idea to get the
> > > > > stat without coming up with a new stat function to accommodate just
> > > > > the file path, fully separate out IMA/EVM checks, or lastly add stacked
> > > > > file system support to EVM (which doesn't make much sense to me
> > > > > at the moment).
> > > > > 
> > > > > I plan on adding in self test infrastructure for the v1, but I would
> > > > > like to get some early feedback on the approach first.
> > > > > ---
> > > > >  include/linux/integrity.h           | 29 ++++++++++++++++++++++++-----
> > > > >  security/integrity/evm/evm_crypto.c |  2 +-
> > > > >  security/integrity/evm/evm_main.c   |  2 +-
> > > > >  security/integrity/ima/ima_api.c    | 21 +++++++++++++++------
> > > > >  security/integrity/ima/ima_main.c   | 17 ++++++++++-------
> > > > >  5 files changed, 51 insertions(+), 20 deletions(-)
> > > > > 
> > > > > diff --git a/include/linux/integrity.h b/include/linux/integrity.h
> > > > > index f5842372359be5341b6870a43b92e695e8fc78af..4964c0f2bbda0ca450d135b9b738bc92256c375a 100644
> > > > > --- a/include/linux/integrity.h
> > > > > +++ b/include/linux/integrity.h
> > > > > @@ -31,19 +31,27 @@ static inline void integrity_load_keys(void)
> > > > >  
> > > > >  /* An inode's attributes for detection of changes */
> > > > >  struct integrity_inode_attributes {
> > > > > +	u64 ctime_guard;
> > > > >  	u64 version;		/* track inode changes */
> > > > >  	unsigned long ino;
> > > > >  	dev_t dev;
> > > > >  };
> > > > >  
> > > > > +static inline u64 integrity_ctime_guard(struct kstat stat)
> > > > > +{
> > > > > +	return stat.ctime.tv_sec ^ stat.ctime.tv_nsec;
> > > > > +}
> > > > > +
> > > > >  /*
> > > > >   * On stacked filesystems the i_version alone is not enough to detect file data
> > > > >   * or metadata change. Additional metadata is required.
> > > > >   */
> > > > >  static inline void
> > > > >  integrity_inode_attrs_store(struct integrity_inode_attributes *attrs,
> > > > > -			    u64 i_version, const struct inode *inode)
> > > > > +			    u64 i_version, u64 ctime_guard,
> > > > > +			    const struct inode *inode)
> > > > >  {
> > > > > +	attrs->ctime_guard = ctime_guard;
> > > > >  	attrs->version = i_version;
> > > > >  	attrs->dev = inode->i_sb->s_dev;
> > > > >  	attrs->ino = inode->i_ino;
> > > > > @@ -54,11 +62,22 @@ integrity_inode_attrs_store(struct integrity_inode_attributes *attrs,
> > > > >   */
> > > > >  static inline bool
> > > > >  integrity_inode_attrs_changed(const struct integrity_inode_attributes *attrs,
> > > > > -			      const struct inode *inode)
> > > > > +			      struct file *file, struct inode *inode)
> > > > >  {
> > > > > -	return (inode->i_sb->s_dev != attrs->dev ||
> > > > > -		inode->i_ino != attrs->ino ||
> > > > > -		!inode_eq_iversion(inode, attrs->version));
> > > > > +	struct kstat stat;
> > > > > +
> > > > > +	if (inode->i_sb->s_dev != attrs->dev ||
> > > > > +	    inode->i_ino != attrs->ino)
> > > > > +		return true;
> > > > > +
> > > > > +	if (inode_eq_iversion(inode, attrs->version))
> > > > > +		return false;
> > > > > +
> > > > > +	if (!file || vfs_getattr_nosec(&file->f_path, &stat, STATX_CTIME,
> > > > > +				       AT_STATX_SYNC_AS_STAT))
> > > > > +		return true;
> > > > > +
> > > > 
> > > > This is rather odd. You're sampling the i_version field directly, but
> > > > if it's not equal then you go through ->getattr() to get the ctime.
> > > > 
> > > > It's particularly odd since you don't know whether the i_version field
> > > > is even implemented on the fs. On filesystems where it isn't, the
> > > > i_version field generally stays at 0, so won't this never fall through
> > > > to do the vfs_getattr_nosec() call on those filesystems?
> > > > 
> > > 
> > > You're totally right. I didn't consider FS's caching the value at zero.
> > 
> > Actually, I'm going to amend this. I think I did consider FSs without an
> > implementation. Where this is called at, it is often guarded by a
> > !IS_I_VERSION() || integrity_inode_attrs_change(). If I'm
> > understanding this correctly, the check call doesn't occur unless the inode
> > has i_version support.
> > 
> 
> 
> It depends on what you mean by i_version support:
> 
> That flag just tells the VFS that it needs to bump the i_version field
> when updating timestamps. It's not a reliable indicator of whether the
> i_version field is suitable for the purpose you want here.
>

So, it would make sense then to also remove those guards at the callsite
then if the intention is to compare against the cookie & ctime regardless?

> The problem here and the one that we ultimately fixed with multigrain
> timestamps is that XFS in particular will bump i_version on any change
> to the log. That includes atime updates due to reads.
> 
> XFS still tracks the i_version the way it always has, but we've stopped
> getattr() from reporting it because it's not suitable for the purpose
> that nfsd (and IMA) need it for.
> 
> > It seems to me the suggestion then is to remove the IS_I_VERSION()
> > checks guarding the call sites, grab both ctime and cookie from stat,
> > and if IS_I_VERSION() use that, otherwise cookie, and compare
> > against the cached i_version with one of those values, and then fall
> > back to ctime?
> > 
> 
> Not exactly.
> 
> You want to call getattr() for STATX_CHANGE_COOKIE|STATX_CTIME, and
> then check the kstat->result_mask. If STATX_CHANGE_COOKIE is set, then
> use that. If it's not then use the ctime.

Ok, I think I understand. To reiterate my understanding, ignore calling
into inode_eq_iversion() all together.

	return other_checks || ((mask & cookie) ? cache->i_version == cookie_val :
	compare_ctime())

> 
> The part I'm not sure about is whether it's actually safe to do this.
> vfs_getattr_nosec() can block in some situations. Is it ok to do this
> in any context where integrity_inode_attrs_changed() may be called? 
> 
> ISTR that this was an issue at one point, but maybe isn't now that IMA
> is an LSM?

Poking around, callers to integrity_inode_attrs_changed() are currently behind
mutex_lock(&iinit->mutex) (similar to vfs_getattr_nosec() calls), and currently
only called from process_measurement().

While I can't say for certain this will always be the case for future use
use cases, would it be helpful to include a may_sleep() in
integrity_inode_attrs_changed() to drive this point and make a comment?

> 
> > > 
> > > > Ideally, you should just call vfs_getattr_nosec() early on with
> > > > STATX_CHANGE_COOKIE|STATX_CTIME to get both at once, and only trust
> > > > STATX_CHANGE_COOKIE if it's set in the returned mask.
> > > > 
> > > 
> > > Yes, that makes sense.
> > > 
> > > I'll spin that in v1, thanks!
> > > 
> > > > > +	return attrs->ctime_guard != integrity_ctime_guard(stat);
> > > > >  }
> > > > >  
> > > > >  
> > > > > diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> > > > > index a5e730ffda57fbc0a91124adaa77b946a12d08b4..2d89c0e8d9360253f8dad52d2a8168127bb4d3b8 100644
> > > > > --- a/security/integrity/evm/evm_crypto.c
> > > > > +++ b/security/integrity/evm/evm_crypto.c
> > > > > @@ -300,7 +300,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
> > > > >  		if (IS_I_VERSION(inode))
> > > > >  			i_version = inode_query_iversion(inode);
> > > > >  		integrity_inode_attrs_store(&iint->metadata_inode, i_version,
> > > > > -					    inode);
> > > > > +					    0, inode);
> > > > >  	}
> > > > >  
> > > > >  	/* Portable EVM signatures must include an IMA hash */
> > > > > diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> > > > > index 73d500a375cb37a54f295b0e1e93fd6e5d9ecddc..0712802628fd6533383f9855687e19bef7b771c7 100644
> > > > > --- a/security/integrity/evm/evm_main.c
> > > > > +++ b/security/integrity/evm/evm_main.c
> > > > > @@ -754,7 +754,7 @@ bool evm_metadata_changed(struct inode *inode, struct inode *metadata_inode)
> > > > >  	if (iint) {
> > > > >  		ret = (!IS_I_VERSION(metadata_inode) ||
> > > > >  		       integrity_inode_attrs_changed(&iint->metadata_inode,
> > > > > -						     metadata_inode));
> > > > > +			       NULL, metadata_inode));
> > > > >  		if (ret)
> > > > >  			iint->evm_status = INTEGRITY_UNKNOWN;
> > > > >  	}
> > > > > diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> > > > > index c35ea613c9f8d404ba4886e3b736c3bab29d1668..72bba8daa588a0f4e45e4249276edb54ca3d77ef 100644
> > > > > --- a/security/integrity/ima/ima_api.c
> > > > > +++ b/security/integrity/ima/ima_api.c
> > > > > @@ -254,6 +254,7 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
> > > > >  	int length;
> > > > >  	void *tmpbuf;
> > > > >  	u64 i_version = 0;
> > > > > +	u64 ctime_guard = 0;
> > > > >  
> > > > >  	/*
> > > > >  	 * Always collect the modsig, because IMA might have already collected
> > > > > @@ -272,10 +273,16 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
> > > > >  	 * to an initial measurement/appraisal/audit, but was modified to
> > > > >  	 * assume the file changed.
> > > > >  	 */
> > > > > -	result = vfs_getattr_nosec(&file->f_path, &stat, STATX_CHANGE_COOKIE,
> > > > > +	result = vfs_getattr_nosec(&file->f_path, &stat,
> > > > > +				   STATX_CHANGE_COOKIE | STATX_CTIME,
> > > > >  				   AT_STATX_SYNC_AS_STAT);
> > > > > -	if (!result && (stat.result_mask & STATX_CHANGE_COOKIE))
> > > > > -		i_version = stat.change_cookie;
> > > > > +	if (!result) {
> > > > > +		if (stat.result_mask & STATX_CHANGE_COOKIE)
> > > > > +			i_version = stat.change_cookie;
> > > > > +
> > > > > +		if (stat.result_mask & STATX_CTIME)
> > > > > +			ctime_guard = integrity_ctime_guard(stat);
> > > > > +	}
> > > > >  	hash.hdr.algo = algo;
> > > > >  	hash.hdr.length = hash_digest_size[algo];
> > > > >  
> > > > > @@ -305,11 +312,13 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
> > > > >  
> > > > >  	iint->ima_hash = tmpbuf;
> > > > >  	memcpy(iint->ima_hash, &hash, length);
> > > > > -	if (real_inode == inode)
> > > > > +	if (real_inode == inode) {
> > > > >  		iint->real_inode.version = i_version;
> > > > > -	else
> > > > > +		iint->real_inode.ctime_guard = ctime_guard;
> > > > > +	} else {
> > > > >  		integrity_inode_attrs_store(&iint->real_inode, i_version,
> > > > > -					    real_inode);
> > > > > +				ctime_guard, real_inode);
> > > > > +	}
> > > > >  
> > > > >  	/* Possibly temporary failure due to type of read (eg. O_DIRECT) */
> > > > >  	if (!result)
> > > > > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > > > > index 5770cf691912aa912fc65280c59f5baac35dd725..6051ea4a472fc0b0dd7b4e81da36eff8bd048c62 100644
> > > > > --- a/security/integrity/ima/ima_main.c
> > > > > +++ b/security/integrity/ima/ima_main.c
> > > > > @@ -22,6 +22,7 @@
> > > > >  #include <linux/mount.h>
> > > > >  #include <linux/mman.h>
> > > > >  #include <linux/slab.h>
> > > > > +#include <linux/stat.h>
> > > > >  #include <linux/xattr.h>
> > > > >  #include <linux/ima.h>
> > > > >  #include <linux/fs.h>
> > > > > @@ -185,6 +186,7 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
> > > > >  {
> > > > >  	fmode_t mode = file->f_mode;
> > > > >  	bool update;
> > > > > +	int ret;
> > > > >  
> > > > >  	if (!(mode & FMODE_WRITE))
> > > > >  		return;
> > > > > @@ -197,12 +199,13 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
> > > > >  
> > > > >  		update = test_and_clear_bit(IMA_UPDATE_XATTR,
> > > > >  					    &iint->atomic_flags);
> > > > > -		if ((iint->flags & IMA_NEW_FILE) ||
> > > > > -		    vfs_getattr_nosec(&file->f_path, &stat,
> > > > > -				      STATX_CHANGE_COOKIE,
> > > > > -				      AT_STATX_SYNC_AS_STAT) ||
> > > > > -		    !(stat.result_mask & STATX_CHANGE_COOKIE) ||
> > > > > -		    stat.change_cookie != iint->real_inode.version) {
> > > > > +		ret = vfs_getattr_nosec(&file->f_path, &stat,
> > > > > +					STATX_CHANGE_COOKIE | STATX_CTIME,
> > > > > +					AT_STATX_SYNC_AS_STAT);
> > > > > +		if ((iint->flags & IMA_NEW_FILE) || ret ||
> > > > > +		    (!ret && stat.change_cookie != iint->real_inode.version) ||
> > > > > +		    (!ret && integrity_ctime_guard(stat) !=
> > > > > +		     iint->real_inode.ctime_guard)) {
> > > > >  			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
> > > > >  			iint->measured_pcrs = 0;
> > > > >  			if (update)
> > > > > @@ -330,7 +333,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
> > > > >  	    (action & IMA_DO_MASK) && (iint->flags & IMA_DONE_MASK)) {
> > > > >  		if (!IS_I_VERSION(real_inode) ||
> > > > >  		    integrity_inode_attrs_changed(&iint->real_inode,
> > > > > -						  real_inode)) {
> > > > > +						  file, real_inode)) {
> > > > >  			iint->flags &= ~IMA_DONE_MASK;
> > > > >  			iint->measured_pcrs = 0;
> > > > >  		}
> > > > > 
> > > > > ---
> > > > > base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> > > > > change-id: 20251212-xfs-ima-fixup-931780a62c2c
> > > > > 
> > > > > Best regards,
> > > > 
> > > > -- 
> > > > Jeff Layton <jlayton@kernel.org>
> 
> -- 
> Jeff Layton <jlayton@kernel.org>

