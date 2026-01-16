Return-Path: <linux-integrity+bounces-8271-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75642D3884D
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jan 2026 22:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39BB93011A49
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jan 2026 21:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AAF3033E3;
	Fri, 16 Jan 2026 21:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="aBkq5+om"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDA228C009
	for <linux-integrity@vger.kernel.org>; Fri, 16 Jan 2026 21:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598747; cv=none; b=O8oZZVcyLbl+8AedjYhIyfvPPR/MDg9FSaWUySQVwmiuQRtJDe+V5pZpfPx/buETmnHBvf81pJ25WYMqnMr8ff5tt75YE/9tZ7HvcCT/gSgQaVvc3J7fsXUcUAGAIbXkI0hN4GYqtinWqb5ZObRZEl31SRnw+VFxUiTqdoI5VmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598747; c=relaxed/simple;
	bh=GH11s/Og6ezdP37yjYKuKFkO+ZrSs0HXiXJsnoV2ELU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LH69FpUPfZxKB78u49/UM5nI1Q8RG3XHarGSA5ijIcSHHADcRmcbsxrjCeSFnBb4RZ243xmt4vF1HYR8MCZY5JD7FR7hzfxVPhZ8Co3OR2rzSP2jXS8dMKLBUD+F/3qndV+p0nc+vonrHusTYoPi3b79ihba6MbstNi2pyWSpko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=aBkq5+om; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-45c7f3a9676so1400080b6e.1
        for <linux-integrity@vger.kernel.org>; Fri, 16 Jan 2026 13:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768598744; x=1769203544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kc/THUBwDKca+SRTZUTwABlvki2UPkQSfoab5UaWQIg=;
        b=aBkq5+omohx6fQlEapCT5ZosUhw0mXe7jTtOfguWVv2UBWn3jmzULXteOU9dSUhzeE
         xV6oU9mqW0thLIIoD+PiLlNB8C/Apu8UFE1acEhWDH6GtzJT+p0976tVOXFzMPheN7u2
         9kOvGZliVjffpO4rvRoZH596d3DhK9O+95o3k6ryse5O0HjfmX4bVEnDunR9SFX1kyIO
         Z8IaZdk3kgn9jZ3wJdHroMgjljy39LLFz/dnTlhQ8zjEl7bAh0eRo1P7Hh9yp9s5wN9b
         VxFyhgnI0Lmg3dMIIN5LH8k3tCgeXa7RfYNw8Eprewy78bA6VF4iatXBwmcSerbzQDMk
         25kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598744; x=1769203544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kc/THUBwDKca+SRTZUTwABlvki2UPkQSfoab5UaWQIg=;
        b=cs8Np1DxDRWtPlkV2GT2N61PUzkcBbRdjnLqPs1cbMkDMNuExLy0jo9zSJQi3Eys7e
         XnmEPdfufU6RQJ7Ezh1HZjrk5QuUIBmC3fUUNQ0F7Smz3kJY1+3MTnbcECpNIiLkvvEm
         CLCNbNP0uJzgejr1kbIHCY5MYgZhnkFmRAM806/rgxrEhaMBA7OHHNQfVuxCrbNNfXxL
         5vBBF9FUQENXV2CW9IsQCjUeup2h34rqM+vsCAN4jjbJ0WtxLQCBA8FSxozYXhOH1t+7
         SFD4dRWq0beIv6nUD7+UWYhytYMuNW0XOHmTUhnhMmaI6KAzDcnU6zsDM7tuSQhsdoXc
         Sx7g==
X-Forwarded-Encrypted: i=1; AJvYcCVXb0trRz3tdO5SITkxcnATh+KJ7xsMpSGfFS/H8mNPM59/XHBOaF9EvZf14bPv+8t6k6lHILP1zf9HQPRLTXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV8C91DicA8bCVIWYS7gQwR7FVpaTAWzrHbn366zbUmY7YfCYx
	MJ2kjhS9/BCsdc76ZS7C5j/DzA9j8GsL8dqtFHHYANWfg2oVaAANaua6+sMdkdF/W0s=
X-Gm-Gg: AY/fxX5qOstpkLJX60Gui8L5OwCCpb5OJhnNW18mX1SiAk8JYFqiDbMHWugKlWDUlbo
	Q/SUSq4uZMQvEoIi5onKiR1L/mAZnIIUXdGko4ZvqIloDPKNR2Vvp+HzY7+gIMC4us70pixwoX6
	jo9iRfZd2I4UFAFeNW0UIaXRNgZAZldR+A7JZopEIn80v0eSLgtIYM917qScQ+QmVEPkfWOFnpJ
	zCI4NFWU0T5Z3fkNHDZMRp5uN3Ah6gAFyzEwiICvRPqLh8ibUibx90HEoJCpFkP1HpL+IcJJK56
	Ib5x+37fkNbJCSMlLYk6o+TliCKuzVktBZ0daEV3d82eWo717v4Sl+QWI5PqtN8M+ubQB/vFAnR
	+aV0bkoWKarJeYVyESRz4cSoHXu0Vu6HXbKXbjnvFLQs0yU6x1Brgk0Vx+TRuDAVMZBId
X-Received: by 2002:a05:6808:4f53:b0:459:b3ff:f856 with SMTP id 5614622812f47-45c9c78dbd4mr1803007b6e.12.1768598744272;
        Fri, 16 Jan 2026 13:25:44 -0800 (PST)
Received: from CMGLRV3 ([2a09:bac5:947d:1b37::2b6:30])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45c9dec6619sm1875672b6e.3.2026.01.16.13.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:25:43 -0800 (PST)
Date: Fri, 16 Jan 2026 15:25:41 -0600
From: Frederick Lawler <fred@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH] ima: Detect changes to files via kstat changes rather
 than i_version
Message-ID: <aWqs1bRhkuKpyIUo@CMGLRV3>
References: <20260112-xfs-ima-fixup-v1-1-8d13b6001312@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112-xfs-ima-fixup-v1-1-8d13b6001312@cloudflare.com>

On Mon, Jan 12, 2026 at 04:32:23PM -0600, Frederick Lawler wrote:
> Commit 1cf7e834a6fb ("xfs: switch to multigrain timestamps")
> introduced a means to track change detection for an inode
> via ctime updates, opposed to setting kstat.change_cookie when
> calling into xfs_vn_getattr().
> 
> This introduced a regression because IMA caches kstat.change_cookie
> to compare against an inode's i_version directly in
> integrity_inode_attrs_changed(), and thus could be out of date
> depending on how file systems increment i_version.
> 
> To address this, require integrity_inode_attrs_changed() to query
> vfs_getattr_nosec() to compare the cached version against
> kstat.change_cookie directly. This ensures that when updates occur,
> we're accessing the same changed inode version on changes, and fallback
> to compare against an artificial version generated from kstat.ctime
> via integrity_ctime_guard() when there's no detected change
> to the kstat.change_cookie.
> 
> This ensures that in the absence of i_version support for file systems,
> and in the absence of a kstat.change_cookie update, we ultimately have a
> unique-enough version to compare against.
> 
> The exact implementation for integrity_ctime_guard() is to ensure that
> if tv_sec or tv_nsec are zero, there's some value to store back into
> struct integrity_inode_attributes.version. This also avoids the need to
> add additional storage and comparisons.
> 
> Lastly, because EVM still relies on querying and caching a backing inode's
> i_version, the integrity_inode_attrs_changed() falls back to the
> original inode.i_version != cached comparison. This maintains the
> invariant that a re-evaluation in unknown change detection circumstances
> is required.
> 
> Link: https://lore.kernel.org/all/aTspr4_h9IU4EyrR@CMGLRV3
> Suggested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> ---
> We uncovered a case in kernels >= 6.13 where XFS is no longer updating
> struct kstat.change_cookie on i_op getattr() access calls. Instead, XFS is
> using multigrain ctime (as well as other file systems) for
> change detection in commit 1cf7e834a6fb ("xfs: switch to
> multigrain timestamps").
> 
> Because file systems may implement i_version as they see fit, IMA
> caching may be behind as well as file systems that don't support/export
> i_version. Thus we're proposing to compare against the kstat.change_cookie
> directly to the cached version, and fall back to a ctime guard when
> that's not updated.
> 
> EVM is largely left alone since there's no trivial way to query a file
> directly in the LSM call paths to obtain kstat.change_cookie &
> kstat.ctime to cache. Thus retains accessing i_version directly.
> 
> Regression tests will be added to the Linux Test Project instead of
> selftest to help catch future file system changes that may impact
> future evaluation of IMA.
> 
> I'd like this to be backported to at least 6.18 if possible.
> 
> Below is a simplified test that demonstrates the issue:
> 
> _fragment.config_
> CONFIG_XFS_FS=y
> CONFIG_OVERLAY_FS=y
> CONFIG_IMA=y
> CONFIG_IMA_WRITE_POLICY=y
> CONFIG_IMA_READ_POLICY=y
> 
> _./test.sh_
> 
> IMA_POLICY="/sys/kernel/security/ima/policy"
> TEST_BIN="/bin/date"
> MNT_BASE="/tmp/ima_test_root"
> 
> mkdir -p "$MNT_BASE"
> mount -t tmpfs tmpfs "$MNT_BASE"
> mkdir -p "$MNT_BASE"/{xfs_disk,upper,work,ovl}
> 
> dd if=/dev/zero of="$MNT_BASE/xfs.img" bs=1M count=300
> mkfs.xfs -q "$MNT_BASE/xfs.img"
> mount "$MNT_BASE/xfs.img" "$MNT_BASE/xfs_disk"
> cp "$TEST_BIN" "$MNT_BASE/xfs_disk/test_prog"
> 
> mount -t overlay overlay -o \
> "lowerdir=$MNT_BASE/xfs_disk,upperdir=$MNT_BASE/upper,workdir=$MNT_BASE/work" \
> "$MNT_BASE/ovl"
> 
> echo "audit func=BPRM_CHECK uid=$(id -u nobody)" > "$IMA_POLICY"
> 
> target_prog="$MNT_BASE/ovl/test_prog"
> setpriv --reuid nobody "$target_prog"
> setpriv --reuid nobody "$target_prog"
> setpriv --reuid nobody "$target_prog"
> 
> audit_count=$(dmesg | grep -c "file=\"$target_prog\"")
> 
> if [[ "$audit_count" -eq 1 ]]; then
>         echo "PASS: Found exactly 1 audit event."
> else
>         echo "FAIL: Expected 1 audit event, but found $audit_count."
>         exit 1
> fi
> ---
> Changes since RFC:
> - Remove calls to I_IS_VERSION()
> - Function documentation/comments
> - Abide IMA/EVM change detection fallback invariants
> - Combined ctime guard into version for attributes struct
> - Link to RFC: https://lore.kernel.org/r/20251229-xfs-ima-fixup-v1-1-6a717c939f7c@cloudflare.com
> ---
>  include/linux/integrity.h         | 42 +++++++++++++++++++++++++++++++++++----
>  security/integrity/evm/evm_main.c |  5 ++---
>  security/integrity/ima/ima_api.c  | 11 +++++++---
>  security/integrity/ima/ima_main.c | 15 +++++---------
>  4 files changed, 53 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/integrity.h b/include/linux/integrity.h
> index f5842372359be5341b6870a43b92e695e8fc78af..5eca8aa2769f9238c68bb40885ecc46910524f11 100644
> --- a/include/linux/integrity.h
> +++ b/include/linux/integrity.h
> @@ -9,6 +9,7 @@
>  
>  #include <linux/fs.h>
>  #include <linux/iversion.h>
> +#include <linux/kernel.h>
>  
>  enum integrity_status {
>  	INTEGRITY_PASS = 0,
> @@ -36,6 +37,14 @@ struct integrity_inode_attributes {
>  	dev_t dev;
>  };
>  
> +/*
> + * Wrapper to generate an artificial version for a file.
> + */
> +static inline u64 integrity_ctime_guard(struct kstat stat)
> +{
> +	return stat.ctime.tv_sec ^ stat.ctime.tv_nsec;
> +}
> +
>  /*
>   * On stacked filesystems the i_version alone is not enough to detect file data
>   * or metadata change. Additional metadata is required.
> @@ -51,14 +60,39 @@ integrity_inode_attrs_store(struct integrity_inode_attributes *attrs,
>  
>  /*
>   * On stacked filesystems detect whether the inode or its content has changed.
> + *
> + * Must be called in process context.
>   */
>  static inline bool
>  integrity_inode_attrs_changed(const struct integrity_inode_attributes *attrs,
> -			      const struct inode *inode)
> +			      struct file *file, struct inode *inode)
>  {
> -	return (inode->i_sb->s_dev != attrs->dev ||
> -		inode->i_ino != attrs->ino ||
> -		!inode_eq_iversion(inode, attrs->version));
> +	struct kstat stat;
> +
> +	might_sleep();
> +
> +	if (inode->i_sb->s_dev != attrs->dev || inode->i_ino != attrs->ino)
> +		return true;
> +
> +	/*
> +	 * EVM currently relies on backing inode i_version. While IS_I_VERSION
> +	 * is not a good indicator of i_version support, this still retains
> +	 * the logic such that a re-evaluation should still occur for EVM, and
> +	 * only for IMA if vfs_getattr_nosec() fails.
> +	 */
> +	if (!file || vfs_getattr_nosec(&file->f_path, &stat,
> +				       STATX_CHANGE_COOKIE | STATX_CTIME,
> +				       AT_STATX_SYNC_AS_STAT))
> +		return !IS_I_VERSION(inode) ||
> +			!inode_eq_iversion(inode, attrs->version);
> +
> +	if (stat.result_mask & STATX_CHANGE_COOKIE)
> +		return stat.change_cookie != attrs->version;
> +
> +	if (stat.result_mask & STATX_CTIME)
> +		return integrity_ctime_guard(stat) != attrs->version;
> +
> +	return true;
>  }
>  
>  
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 73d500a375cb37a54f295b0e1e93fd6e5d9ecddc..6a4e0e246005246d5700b1db590c1759242b9cb6 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -752,9 +752,8 @@ bool evm_metadata_changed(struct inode *inode, struct inode *metadata_inode)
>  	bool ret = false;
>  
>  	if (iint) {
> -		ret = (!IS_I_VERSION(metadata_inode) ||
> -		       integrity_inode_attrs_changed(&iint->metadata_inode,
> -						     metadata_inode));
> +		ret = integrity_inode_attrs_changed(&iint->metadata_inode,
> +						    NULL, metadata_inode);
>  		if (ret)
>  			iint->evm_status = INTEGRITY_UNKNOWN;
>  	}
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index c35ea613c9f8d404ba4886e3b736c3bab29d1668..8096986f3689781d3cdf6595f330033782f9cc45 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -272,10 +272,15 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
>  	 * to an initial measurement/appraisal/audit, but was modified to
>  	 * assume the file changed.
>  	 */
> -	result = vfs_getattr_nosec(&file->f_path, &stat, STATX_CHANGE_COOKIE,
> +	result = vfs_getattr_nosec(&file->f_path, &stat,
> +				   STATX_CHANGE_COOKIE | STATX_CTIME,
>  				   AT_STATX_SYNC_AS_STAT);
> -	if (!result && (stat.result_mask & STATX_CHANGE_COOKIE))
> -		i_version = stat.change_cookie;
> +	if (!result) {
> +		if (stat.result_mask & STATX_CHANGE_COOKIE)
> +			i_version = stat.change_cookie;
> +		else if (stat.result_mask & STATX_CTIME)
> +			i_version = integrity_ctime_guard(stat);
> +	}
>  	hash.hdr.algo = algo;
>  	hash.hdr.length = hash_digest_size[algo];
>  
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 5770cf691912aa912fc65280c59f5baac35dd725..3a4c32e254f925bba85cb91b63744ac142b3b049 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -22,6 +22,7 @@
>  #include <linux/mount.h>
>  #include <linux/mman.h>
>  #include <linux/slab.h>
> +#include <linux/stat.h>
>  #include <linux/xattr.h>
>  #include <linux/ima.h>
>  #include <linux/fs.h>
> @@ -191,18 +192,13 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
>  
>  	mutex_lock(&iint->mutex);
>  	if (atomic_read(&inode->i_writecount) == 1) {
> -		struct kstat stat;
> -
>  		clear_bit(IMA_EMITTED_OPENWRITERS, &iint->atomic_flags);
>  
>  		update = test_and_clear_bit(IMA_UPDATE_XATTR,
>  					    &iint->atomic_flags);
>  		if ((iint->flags & IMA_NEW_FILE) ||
> -		    vfs_getattr_nosec(&file->f_path, &stat,
> -				      STATX_CHANGE_COOKIE,
> -				      AT_STATX_SYNC_AS_STAT) ||
> -		    !(stat.result_mask & STATX_CHANGE_COOKIE) ||
> -		    stat.change_cookie != iint->real_inode.version) {
> +		    integrity_inode_attrs_changed(&iint->real_inode, file,
> +						  inode)) {

I'm working through my tests, and I don't think I can get away with this
change. The check for the inode->i_ino != attr->ino may result in a
re-evaluation because we're not updating the attr->ino while collecting
measurement on non-stacked file systems checks. Same for attr->dev not
updating.

I'll put this back in the next patch version, and still check ctime here
similar to the RFC version.

>  			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
>  			iint->measured_pcrs = 0;
>  			if (update)
> @@ -328,9 +324,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
>  	real_inode = d_real_inode(file_dentry(file));
>  	if (real_inode != inode &&
>  	    (action & IMA_DO_MASK) && (iint->flags & IMA_DONE_MASK)) {
> -		if (!IS_I_VERSION(real_inode) ||
> -		    integrity_inode_attrs_changed(&iint->real_inode,
> -						  real_inode)) {
> +		if (integrity_inode_attrs_changed(&iint->real_inode,
> +						  file, real_inode)) {
>  			iint->flags &= ~IMA_DONE_MASK;
>  			iint->measured_pcrs = 0;
>  		}
> 
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251212-xfs-ima-fixup-931780a62c2c
> 
> Best regards,
> -- 
> Frederick Lawler <fred@cloudflare.com>
> 

