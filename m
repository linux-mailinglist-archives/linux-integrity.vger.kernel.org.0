Return-Path: <linux-integrity+bounces-8186-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DACB4CF96B9
	for <lists+linux-integrity@lfdr.de>; Tue, 06 Jan 2026 17:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A37B23015D29
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jan 2026 16:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923AA33ADB7;
	Tue,  6 Jan 2026 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Z044DVmx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A70533AD96
	for <linux-integrity@vger.kernel.org>; Tue,  6 Jan 2026 16:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767717787; cv=none; b=jboD5Xg8CsXQ6j4mtSbNX/Vsj2HBrCIX/5A6/TLnIuNVZmSbkDYQwKllQ5MbBz0Wko49uz0X0yY0sqn1C9BXrBN1cWappth4iggnUoNoSd8Naq2ORn0xQIS1S9i89kftKegJ1s4tOKRCeW3td9Ok3aOhddKgNV5Z0qhei+ZPyRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767717787; c=relaxed/simple;
	bh=T/eYcxI6LLyxrh7x6PmhHOwNeEd/ze46Sd7WRH1+Bqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOrTurNiUU5XKetVdTSwztjtSdIbPkI7XOAd5apWJfDY1m87xDJrqm7gxxUBzU+9Lzp5H2OmcucHH+SYCV3yKvW/wgKVFw+aGbnodD3A40gSrFmG+XROrBYqPcjHf1VLzMdx87F/qAMRa4n2VPWSsPVPomtUeBiviO5zuq/YFoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Z044DVmx; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3f4f9ea26aaso852821fac.0
        for <linux-integrity@vger.kernel.org>; Tue, 06 Jan 2026 08:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767717784; x=1768322584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qSUurpCmFJ65Ayl0xRg/9I5cX5+uuG9A8wizwTKYsrA=;
        b=Z044DVmxfegUz2LfPDrzn40w/ZZDiBH8JU2ifHLNUiDvnGRdIYaa1Y45UCUZnSEon/
         /cpGfHoNxXrAb+EwYlcWBfS14jHUI1/+rfoTIbi9XmSnnCnxIWxyq6bdgNkEvhKmAkU4
         ndqX5JoePKVFNQbT5xn1uaHK6dGBor8EPjeWaTI46C4LDCl3qwn9PfLgMoMElF/rw5+4
         pZwJWPSbOWBKk/DMC04XsWZgVqnYgt1JmFiwJ1mQ3BodQg1Qbxuf/UKFpX6PBSHJ/u9K
         V6Ne60RLVZ2hv2cMUpKWXEku4NWzFI2KbC6+BIDblpt6/0jIWg5vJtfCJbdLc6BqNGIJ
         oToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767717784; x=1768322584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSUurpCmFJ65Ayl0xRg/9I5cX5+uuG9A8wizwTKYsrA=;
        b=dXkkI7dlkF3tW+PdOe/Okpm/teuJYBP8Pbl4UDlwvmwzycLgHbLpr8ptp6yUbdKCLg
         EHBsLckg8BhIvGQqVzLoTiSbbMKsF2ZzxWc7BRLVqly+aQFX5fgWk9+qSu8bVUbZ+eGn
         k+2TyxbwoTSJqCKXsgZB2lOLTTDyoJHl7tIuREJXstFSgGEQ6BfGjn9QToyaUawXfDS0
         Q3Ht1bIu9jH60RQz15E4paWXI8N/QB2Fst1OTgT3VbFiG3mZNiQsUsZzSaIQSeFNzCcX
         EUEQYcDuDtGti5VarcArxeoUrtHnsmnwiO9o3v513H+6iHRV1vDsiE0ngKJpfVWqK4hu
         6C8A==
X-Forwarded-Encrypted: i=1; AJvYcCVVTyCcDeWnEqtnfjiC27htX9tq2/nQFqo6UPf7fm8Fx6cJLcC6f64O27xSn/d2KDtTi2nAGbc3GtT+DtGNqyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi2xdCzCq1iJqqsCbPok9dpbfhF+qx0kXnv7yRU6MMA6JwZq3J
	b7HzgqvuE5vhqWy46of9Or6/x8p2s8zhAWqxEjPed0/R/+P/pp/AHcp1FgIpCIn1I+Y=
X-Gm-Gg: AY/fxX4YBraX/RmDWxDNykonWnje7Ww+qKwrnC7sqGb9KVZ6yIeljSO/81d7nuLW8o4
	igCdlzFo7RCXSSnmq+flFi/dq/x4+iTuTdwZaSy0A8jOyx4vWvw9vpbdDkll8chzVnOn/QFLCZ7
	ep0I3BhH0SpBL+LLYoKkXcolcEu60fxV+3aOIhjbOdGOMsu2nUmqBag6MhRWX5MV/xVnk0gN0Z0
	JvbVJXYY8d1COSAjIGZn2NBRMRVdaLvHc9xYVxVZJZSSvP0RtswWm4F/nCxQ5ozGEHRhzxLmhDJ
	FzTDy9f7rTX+rBqMbTDbeDDOcrXPDvKPtf1HNsvaKd1BYXOr5ocMohM55tY+HZ48lsyf4rZC0c2
	m9EZ1pdWAqn3p/ol349bhsJCOSL1IB31S1yp2f8sodYJ49P9dbqoQdz5r1GK04jyQVA==
X-Google-Smtp-Source: AGHT+IFIaKMtyawC/OWOGWmoBvUdx3zCsTqeQlrYplqywPRGCfRqKr2DjUxcvZicfdTVHnWs+A/XJw==
X-Received: by 2002:a05:6820:2202:b0:659:9a49:901b with SMTP id 006d021491bc7-65f47a6fddamr1941939eaf.72.1767717784370;
        Tue, 06 Jan 2026 08:43:04 -0800 (PST)
Received: from CMGLRV3 ([2a09:bac5:947d:4e6::7d:7b])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65f48ab2d00sm1157993eaf.0.2026.01.06.08.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 08:43:04 -0800 (PST)
Date: Tue, 6 Jan 2026 10:43:01 -0600
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
Message-ID: <aV07lY6NOkNvUk3Z@CMGLRV3>
References: <20251229-xfs-ima-fixup-v1-1-6a717c939f7c@cloudflare.com>
 <3ad9ded9b3a269908eee6c79b70dbf432e60ce8d.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ad9ded9b3a269908eee6c79b70dbf432e60ce8d.camel@kernel.org>

Hi Jeff,

On Tue, Jan 06, 2026 at 07:01:08AM -0500, Jeff Layton wrote:
> On Mon, 2025-12-29 at 11:52 -0600, Frederick Lawler wrote:
> > Since commit 1cf7e834a6fb ("xfs: switch to multigrain timestamps"), IMA
> > is no longer able to correctly track inode.i_version due to the struct
> > kstat.change_cookie no longer containing an updated i_version.
> > 
> > Introduce a fallback mechanism for IMA that instead tracks a
> > integrity_ctime_guard() in absence of or outdated i_version
> > for stacked file systems.
> > 
> > EVM is left alone since it mostly cares about the backing inode.
> > 
> > Link: https://lore.kernel.org/all/aTspr4_h9IU4EyrR@CMGLRV3
> > Fixes: 1cf7e834a6fb ("xfs: switch to multigrain timestamps")
> > Suggested-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> > ---
> > The motivation behind this was that file systems that use the
> > cookie to set the i_version for stacked file systems may still do so.
> > Then add in the ctime_guard as a fallback if there's a detected change.
> > The assumption is that the ctime will be different if the i_version is
> > different anyway for non-stacked file systems.
> > 
> > I'm not too pleased with passing in struct file* to
> > integrity_inode_attrs_changed() since EVM doesn't currently use
> > that for now, but I couldn't come up with another idea to get the
> > stat without coming up with a new stat function to accommodate just
> > the file path, fully separate out IMA/EVM checks, or lastly add stacked
> > file system support to EVM (which doesn't make much sense to me
> > at the moment).
> > 
> > I plan on adding in self test infrastructure for the v1, but I would
> > like to get some early feedback on the approach first.
> > ---
> >  include/linux/integrity.h           | 29 ++++++++++++++++++++++++-----
> >  security/integrity/evm/evm_crypto.c |  2 +-
> >  security/integrity/evm/evm_main.c   |  2 +-
> >  security/integrity/ima/ima_api.c    | 21 +++++++++++++++------
> >  security/integrity/ima/ima_main.c   | 17 ++++++++++-------
> >  5 files changed, 51 insertions(+), 20 deletions(-)
> > 
> > diff --git a/include/linux/integrity.h b/include/linux/integrity.h
> > index f5842372359be5341b6870a43b92e695e8fc78af..4964c0f2bbda0ca450d135b9b738bc92256c375a 100644
> > --- a/include/linux/integrity.h
> > +++ b/include/linux/integrity.h
> > @@ -31,19 +31,27 @@ static inline void integrity_load_keys(void)
> >  
> >  /* An inode's attributes for detection of changes */
> >  struct integrity_inode_attributes {
> > +	u64 ctime_guard;
> >  	u64 version;		/* track inode changes */
> >  	unsigned long ino;
> >  	dev_t dev;
> >  };
> >  
> > +static inline u64 integrity_ctime_guard(struct kstat stat)
> > +{
> > +	return stat.ctime.tv_sec ^ stat.ctime.tv_nsec;
> > +}
> > +
> >  /*
> >   * On stacked filesystems the i_version alone is not enough to detect file data
> >   * or metadata change. Additional metadata is required.
> >   */
> >  static inline void
> >  integrity_inode_attrs_store(struct integrity_inode_attributes *attrs,
> > -			    u64 i_version, const struct inode *inode)
> > +			    u64 i_version, u64 ctime_guard,
> > +			    const struct inode *inode)
> >  {
> > +	attrs->ctime_guard = ctime_guard;
> >  	attrs->version = i_version;
> >  	attrs->dev = inode->i_sb->s_dev;
> >  	attrs->ino = inode->i_ino;
> > @@ -54,11 +62,22 @@ integrity_inode_attrs_store(struct integrity_inode_attributes *attrs,
> >   */
> >  static inline bool
> >  integrity_inode_attrs_changed(const struct integrity_inode_attributes *attrs,
> > -			      const struct inode *inode)
> > +			      struct file *file, struct inode *inode)
> >  {
> > -	return (inode->i_sb->s_dev != attrs->dev ||
> > -		inode->i_ino != attrs->ino ||
> > -		!inode_eq_iversion(inode, attrs->version));
> > +	struct kstat stat;
> > +
> > +	if (inode->i_sb->s_dev != attrs->dev ||
> > +	    inode->i_ino != attrs->ino)
> > +		return true;
> > +
> > +	if (inode_eq_iversion(inode, attrs->version))
> > +		return false;
> > +
> > +	if (!file || vfs_getattr_nosec(&file->f_path, &stat, STATX_CTIME,
> > +				       AT_STATX_SYNC_AS_STAT))
> > +		return true;
> > +
> 
> This is rather odd. You're sampling the i_version field directly, but
> if it's not equal then you go through ->getattr() to get the ctime.
> 
> It's particularly odd since you don't know whether the i_version field
> is even implemented on the fs. On filesystems where it isn't, the
> i_version field generally stays at 0, so won't this never fall through
> to do the vfs_getattr_nosec() call on those filesystems?
>

You're totally right. I didn't consider FS's caching the value at zero.

> Ideally, you should just call vfs_getattr_nosec() early on with
> STATX_CHANGE_COOKIE|STATX_CTIME to get both at once, and only trust
> STATX_CHANGE_COOKIE if it's set in the returned mask.
> 

Yes, that makes sense.

I'll spin that in v1, thanks!

> > +	return attrs->ctime_guard != integrity_ctime_guard(stat);
> >  }
> >  
> >  
> > diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> > index a5e730ffda57fbc0a91124adaa77b946a12d08b4..2d89c0e8d9360253f8dad52d2a8168127bb4d3b8 100644
> > --- a/security/integrity/evm/evm_crypto.c
> > +++ b/security/integrity/evm/evm_crypto.c
> > @@ -300,7 +300,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
> >  		if (IS_I_VERSION(inode))
> >  			i_version = inode_query_iversion(inode);
> >  		integrity_inode_attrs_store(&iint->metadata_inode, i_version,
> > -					    inode);
> > +					    0, inode);
> >  	}
> >  
> >  	/* Portable EVM signatures must include an IMA hash */
> > diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> > index 73d500a375cb37a54f295b0e1e93fd6e5d9ecddc..0712802628fd6533383f9855687e19bef7b771c7 100644
> > --- a/security/integrity/evm/evm_main.c
> > +++ b/security/integrity/evm/evm_main.c
> > @@ -754,7 +754,7 @@ bool evm_metadata_changed(struct inode *inode, struct inode *metadata_inode)
> >  	if (iint) {
> >  		ret = (!IS_I_VERSION(metadata_inode) ||
> >  		       integrity_inode_attrs_changed(&iint->metadata_inode,
> > -						     metadata_inode));
> > +			       NULL, metadata_inode));
> >  		if (ret)
> >  			iint->evm_status = INTEGRITY_UNKNOWN;
> >  	}
> > diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> > index c35ea613c9f8d404ba4886e3b736c3bab29d1668..72bba8daa588a0f4e45e4249276edb54ca3d77ef 100644
> > --- a/security/integrity/ima/ima_api.c
> > +++ b/security/integrity/ima/ima_api.c
> > @@ -254,6 +254,7 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
> >  	int length;
> >  	void *tmpbuf;
> >  	u64 i_version = 0;
> > +	u64 ctime_guard = 0;
> >  
> >  	/*
> >  	 * Always collect the modsig, because IMA might have already collected
> > @@ -272,10 +273,16 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
> >  	 * to an initial measurement/appraisal/audit, but was modified to
> >  	 * assume the file changed.
> >  	 */
> > -	result = vfs_getattr_nosec(&file->f_path, &stat, STATX_CHANGE_COOKIE,
> > +	result = vfs_getattr_nosec(&file->f_path, &stat,
> > +				   STATX_CHANGE_COOKIE | STATX_CTIME,
> >  				   AT_STATX_SYNC_AS_STAT);
> > -	if (!result && (stat.result_mask & STATX_CHANGE_COOKIE))
> > -		i_version = stat.change_cookie;
> > +	if (!result) {
> > +		if (stat.result_mask & STATX_CHANGE_COOKIE)
> > +			i_version = stat.change_cookie;
> > +
> > +		if (stat.result_mask & STATX_CTIME)
> > +			ctime_guard = integrity_ctime_guard(stat);
> > +	}
> >  	hash.hdr.algo = algo;
> >  	hash.hdr.length = hash_digest_size[algo];
> >  
> > @@ -305,11 +312,13 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
> >  
> >  	iint->ima_hash = tmpbuf;
> >  	memcpy(iint->ima_hash, &hash, length);
> > -	if (real_inode == inode)
> > +	if (real_inode == inode) {
> >  		iint->real_inode.version = i_version;
> > -	else
> > +		iint->real_inode.ctime_guard = ctime_guard;
> > +	} else {
> >  		integrity_inode_attrs_store(&iint->real_inode, i_version,
> > -					    real_inode);
> > +				ctime_guard, real_inode);
> > +	}
> >  
> >  	/* Possibly temporary failure due to type of read (eg. O_DIRECT) */
> >  	if (!result)
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index 5770cf691912aa912fc65280c59f5baac35dd725..6051ea4a472fc0b0dd7b4e81da36eff8bd048c62 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/mount.h>
> >  #include <linux/mman.h>
> >  #include <linux/slab.h>
> > +#include <linux/stat.h>
> >  #include <linux/xattr.h>
> >  #include <linux/ima.h>
> >  #include <linux/fs.h>
> > @@ -185,6 +186,7 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
> >  {
> >  	fmode_t mode = file->f_mode;
> >  	bool update;
> > +	int ret;
> >  
> >  	if (!(mode & FMODE_WRITE))
> >  		return;
> > @@ -197,12 +199,13 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
> >  
> >  		update = test_and_clear_bit(IMA_UPDATE_XATTR,
> >  					    &iint->atomic_flags);
> > -		if ((iint->flags & IMA_NEW_FILE) ||
> > -		    vfs_getattr_nosec(&file->f_path, &stat,
> > -				      STATX_CHANGE_COOKIE,
> > -				      AT_STATX_SYNC_AS_STAT) ||
> > -		    !(stat.result_mask & STATX_CHANGE_COOKIE) ||
> > -		    stat.change_cookie != iint->real_inode.version) {
> > +		ret = vfs_getattr_nosec(&file->f_path, &stat,
> > +					STATX_CHANGE_COOKIE | STATX_CTIME,
> > +					AT_STATX_SYNC_AS_STAT);
> > +		if ((iint->flags & IMA_NEW_FILE) || ret ||
> > +		    (!ret && stat.change_cookie != iint->real_inode.version) ||
> > +		    (!ret && integrity_ctime_guard(stat) !=
> > +		     iint->real_inode.ctime_guard)) {
> >  			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
> >  			iint->measured_pcrs = 0;
> >  			if (update)
> > @@ -330,7 +333,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
> >  	    (action & IMA_DO_MASK) && (iint->flags & IMA_DONE_MASK)) {
> >  		if (!IS_I_VERSION(real_inode) ||
> >  		    integrity_inode_attrs_changed(&iint->real_inode,
> > -						  real_inode)) {
> > +						  file, real_inode)) {
> >  			iint->flags &= ~IMA_DONE_MASK;
> >  			iint->measured_pcrs = 0;
> >  		}
> > 
> > ---
> > base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> > change-id: 20251212-xfs-ima-fixup-931780a62c2c
> > 
> > Best regards,
> 
> -- 
> Jeff Layton <jlayton@kernel.org>

