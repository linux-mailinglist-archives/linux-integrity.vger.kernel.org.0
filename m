Return-Path: <linux-integrity+bounces-8284-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJbAAykBcGmUUgAAu9opvQ
	(envelope-from <linux-integrity+bounces-8284-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jan 2026 23:26:49 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C99144CF2C
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jan 2026 23:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1EF0772EAE0
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jan 2026 21:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0143557FC;
	Tue, 20 Jan 2026 21:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ed7keOel"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993D63A640C
	for <linux-integrity@vger.kernel.org>; Tue, 20 Jan 2026 21:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768945758; cv=none; b=O67Y03XVcunjvRN5D8Ld/BZ8zp4mWj9XAt+3fGvN9B4GNyoF3ltYsbxuaQ4YWMPs5qjB2p9/TXYnNAdif0OqZEOqYIqc2pR3E+qt+gEv8gEQLav3UNSkBEpwwYgvv67CICsfI40Y5v509FmqRuwUuuSjDJ8yLiCCLWHw+WDmVQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768945758; c=relaxed/simple;
	bh=5vh+EKX9R4IHRz5BsnEoqYRU09j4wk35OOLeEQoA/jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UL7ssoVrb3J0zPdgS3b7HA0aNX6FrTdw89UC3O0/zIlQeHFXtXMVVqPlNeeRpC1DEYD2fprLayX2GRnuLwoz3uiXhj8EtkoHKomyJBfkW6uByr0ZqOPH6NZKYyx6ScxakCYw3j/kSfBZ/+fJft+5ETbQz61f2bz8bDgo1lIlmGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ed7keOel; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6610b241d19so2807130eaf.0
        for <linux-integrity@vger.kernel.org>; Tue, 20 Jan 2026 13:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768945754; x=1769550554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H8/fVZ8iASTIDnU7ZzSAgDryw/2hAD0ugtih00x/oiE=;
        b=ed7keOelaHpiQAEXs/kC3plN/IvEYKPxWvK/+XUuv4bdo9Li2DiL94reLUC+RLlHd6
         vXr7WQFGVBNk4okUptdur5A0z+45mNM0w5IWGeAd+uvy4QfBPxbsEoVE9QswGA+frEX3
         u368Nr7Zja6xmVZ9l9wN3S2+LWM2vLPBdyr1MDTtwLmeKv3C2DjS+pCpx15VbGTwja5i
         DK4MQ2mPTOwlx8qrGzdRaDdDjom6UPF3RwXbwZiE7paBqv6Hbh76gaAoZQ/UzAmugqdh
         h+SaBOF28XzT9iHZVeb/zmoGZZTX0ruexc3UMEPGPObEnuaEiI5/RPkW9zfspj3x7jaY
         3fbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768945754; x=1769550554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8/fVZ8iASTIDnU7ZzSAgDryw/2hAD0ugtih00x/oiE=;
        b=GRRT1/+8jQyAuDQSVSMf4/aAZP0A0Qyd9DKTE7cx4h1OQGyWWhVR3rCO4JAcKJ+VFw
         a7QxxxjpvsEsO+9LIQAu0KfRvyjNIHILsJNva/54ewbYrGWPjD+gh70zm1qKQdOSPZXu
         mmi8EzPWlEXgE8fzTdMJAO3RU6pjK7giS0wyn9kcWHFRJ7Z93cRUNLxBgiLcaCYS1Z3J
         V8p0bk4sSaIZyEvCBxL/eYbT6yGiSxaZpmHeeXifMwMapxdjr68067ZMM9DD9+ODIQqS
         6JP9+uq8wDKQ43xHKASxoOcfc4zm7/dICvJzJwwW/KnHr53YDSS69Ns5gGlxZKyPX+Fa
         Odyw==
X-Forwarded-Encrypted: i=1; AJvYcCUjspKcfpbx/MND8XY1Z3mbr5Tsz0ApgJbqzvIbjfoLb6KAfyViSM9vdWB/RDU7Hde5raRpg4mfiBDjZ9slBuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFlrD7K/XKD1bkp5t4Ba4ir4F1QZdYpL9MK5+AKs6mr5TCSMVN
	7Z/jVfdyZBLlgJSPopO0ttWqP4YSY6rT5VnTA2oCvEWoiWnuJ95v2atYa+IYKBpXxuWEH8ag5uC
	YaTjk
X-Gm-Gg: AY/fxX76kH0hhaNspiPHOknWmI9JE21aaT39adUCk0KJXluCabqkQf9aedYAYyHOPol
	lfufOzm9YbEDOf8saSjFvPs1FIyO1t1QHSTQj/t+u1XfU9lIBJY2r/MEtKbz/pvDvhVXE6HDyCS
	b9gg5q7i6Z93Y9d7wpDW9Ry2CJqXiRQHPB8sMLn7EYXB7F5IcyK6SwTYlveTl77C5oFYgLmY3kx
	1KoxFoF7wkhf9Z8EMcOv25uz1Zu9lKlv1tHF+PvjBBOvJjbEvYh/QHqVSCdBZdyDb1Qr4e7HuZR
	6Iv0hxoOxDGa8u2kjdpRL/0ymdSo6Jx8OSTWh1TV02WX663txTzbQTI61Tftjk+6nX/UIgVwOv9
	ZqkV2povhX9jJQVSdS/bBLtdG1rkq7uPr+aheiovwW5mPT1SzAHMsMQeU7YsoajHn3Q==
X-Received: by 2002:a05:6820:99a:b0:65b:2a82:d700 with SMTP id 006d021491bc7-662b00a5473mr1210499eaf.44.1768945754374;
        Tue, 20 Jan 2026 13:49:14 -0800 (PST)
Received: from CMGLRV3 ([2a09:bac5:947d:4e6::7d:47])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-662b5fa5625sm618456eaf.6.2026.01.20.13.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 13:49:14 -0800 (PST)
Date: Tue, 20 Jan 2026 15:49:11 -0600
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
Subject: Re: [PATCH v2] ima: Fallback to ctime check for FS without
 kstat.change_cookie
Message-ID: <aW_4V93kczhzFjQ3@CMGLRV3>
References: <20260120-xfs-ima-fixup-v2-1-f332ead8b043@cloudflare.com>
 <1a7985c825cf4af3b2a87e89793ae0daf2bb9c49.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a7985c825cf4af3b2a87e89793ae0daf2bb9c49.camel@kernel.org>
X-Spamd-Result: default: False [-6.96 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,kernel.org,toxicpanda.com,vger.kernel.org,cloudflare.com];
	TAGGED_FROM(0.00)[bounces-8284-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[cloudflare.com,reject];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fred@cloudflare.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,cloudflare.com:email,cloudflare.com:dkim]
X-Rspamd-Queue-Id: C99144CF2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 04:22:55PM -0500, Jeff Layton wrote:
> On Tue, 2026-01-20 at 14:20 -0600, Frederick Lawler wrote:
> > Commit 1cf7e834a6fb ("xfs: switch to multigrain timestamps")
> > introduced a means to track change detection for an inode
> > via ctime updates, opposed to setting kstat.change_cookie to
> > an i_version when calling into xfs_vn_getattr().
> > 
> > This introduced a regression for IMA such that an action
> > performed on a LOWER inode on a stacked file systems always
> > requires a re-evaluation if the LOWER file system does not
> > leverage kstat.change_cookie to track inode i_version or lacks
> > i_version support all together.
> > 
> > In the case of stacking XFS on XFS, an action on either the LOWER or UPPER
> > will require re-evaluation. Stacking TPMFS on XFS for instance, once the
> > inode is UPPER is mutated, IMA resumes normal behavior because TMPFS
> > leverages generic_fillattr() to update the change cookie.
> > 
> > This is because IMA caches kstat.change_cookie to compare against an
> > inode's i_version directly in integrity_inode_attrs_changed(), and thus
> > could be out of date depending on how file systems set
> > kstat.change_cookie.
> > 
> > To address this, require integrity_inode_attrs_changed() to query
> > vfs_getattr_nosec() to compare the cached version against
> > kstat.change_cookie directly. This ensures that when updates occur,
> > we're accessing the same changed inode version on changes, and fallback
> > to compare against kstat.ctime when STATX_CHANGE_COOKIE is missing from
> > result mask.
> > 
> > Lastly, because EVM still relies on querying and caching a inode's
> > i_version directly, the integrity_inode_attrs_changed() falls back to the
> > original inode.i_version != cached comparison.
> > 
> > Link: https://lore.kernel.org/all/aTspr4_h9IU4EyrR@CMGLRV3
> > Suggested-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> > ---
> > We uncovered a case in kernels >= 6.13 where XFS is no longer updating
> > struct kstat.change_cookie on i_op getattr() access calls. Instead, XFS is
> > using multigrain ctime (as well as other file systems) for
> > change detection in commit 1cf7e834a6fb ("xfs: switch to
> > multigrain timestamps").
> > 
> > Because file systems may implement i_version as they see fit, IMA
> > caching may be behind as well as file systems that don't support/export
> > i_version. Thus we're proposing to compare against the kstat.change_cookie
> > directly to the cached version, and fall back to a ctime guard when
> > that's not updated.
> > 
> > EVM is largely left alone since there's no trivial way to query a file
> > directly in the LSM call paths to obtain kstat.change_cookie &
> > kstat.ctime to cache. Thus retains accessing i_version directly.
> > 
> > Regression tests will be added to the Linux Test Project instead of
> > selftest to help catch future file system changes that may impact
> > future evaluation of IMA.
> > 
> > I'd like this to be backported to at least 6.18 if possible.
> > 
> > Below is a simplified test that demonstrates the issue:
> > 
> > _fragment.config_
> > CONFIG_XFS_FS=y
> > CONFIG_OVERLAY_FS=y
> > CONFIG_IMA=y
> > CONFIG_IMA_WRITE_POLICY=y
> > CONFIG_IMA_READ_POLICY=y
> > 
> > _./test.sh_
> > 
> > IMA_POLICY="/sys/kernel/security/ima/policy"
> > TEST_BIN="/bin/date"
> > MNT_BASE="/tmp/ima_test_root"
> > 
> > mkdir -p "$MNT_BASE"
> > mount -t tmpfs tmpfs "$MNT_BASE"
> > mkdir -p "$MNT_BASE"/{xfs_disk,upper,work,ovl}
> > 
> > dd if=/dev/zero of="$MNT_BASE/xfs.img" bs=1M count=300
> > mkfs.xfs -q "$MNT_BASE/xfs.img"
> > mount "$MNT_BASE/xfs.img" "$MNT_BASE/xfs_disk"
> > cp "$TEST_BIN" "$MNT_BASE/xfs_disk/test_prog"
> > 
> > mount -t overlay overlay -o \
> > "lowerdir=$MNT_BASE/xfs_disk,upperdir=$MNT_BASE/upper,workdir=$MNT_BASE/work" \
> > "$MNT_BASE/ovl"
> > 
> > echo "audit func=BPRM_CHECK uid=$(id -u nobody)" > "$IMA_POLICY"
> > 
> > target_prog="$MNT_BASE/ovl/test_prog"
> > setpriv --reuid nobody "$target_prog"
> > setpriv --reuid nobody "$target_prog"
> > setpriv --reuid nobody "$target_prog"
> > 
> > audit_count=$(dmesg | grep -c "file=\"$target_prog\"")
> > 
> > if [[ "$audit_count" -eq 1 ]]; then
> >         echo "PASS: Found exactly 1 audit event."
> > else
> >         echo "FAIL: Expected 1 audit event, but found $audit_count."
> >         exit 1
> > fi
> > ---
> > Changes since RFC:
> > - Remove calls to I_IS_VERSION()
> > - Function documentation/comments
> > - Abide IMA/EVM change detection fallback invariants
> > - Combined ctime guard into version for attributes struct
> > - Link to RFC: https://lore.kernel.org/r/20251229-xfs-ima-fixup-v1-1-6a717c939f7c@cloudflare.com
> > ---
> > Changes in v2:
> > - Updated commit description + message to clarify the problem.
> > - compare struct timespec64 to avoid collision possibility [Roberto].
> > - Don't check inode_attr_changed() in ima_check_last_writer()
> > - Link to v1: https://lore.kernel.org/r/20260112-xfs-ima-fixup-v1-1-8d13b6001312@cloudflare.com
> > ---
> >  include/linux/integrity.h           | 40 ++++++++++++++++++++++++++++++++-----
> >  security/integrity/evm/evm_crypto.c |  4 +++-
> >  security/integrity/evm/evm_main.c   |  5 ++---
> >  security/integrity/ima/ima_api.c    | 20 +++++++++++++------
> >  security/integrity/ima/ima_main.c   | 18 ++++++++++-------
> >  5 files changed, 65 insertions(+), 22 deletions(-)
> > 
> > diff --git a/include/linux/integrity.h b/include/linux/integrity.h
> > index f5842372359be5341b6870a43b92e695e8fc78af..46f57402b790c9c275b85f0b30819fa196fc20c7 100644
> > --- a/include/linux/integrity.h
> > +++ b/include/linux/integrity.h
> > @@ -9,6 +9,8 @@
> >  
> >  #include <linux/fs.h>
> >  #include <linux/iversion.h>
> > +#include <linux/kernel.h>
> > +#include <linux/time64.h>
> >  
> >  enum integrity_status {
> >  	INTEGRITY_PASS = 0,
> > @@ -31,6 +33,7 @@ static inline void integrity_load_keys(void)
> >  
> >  /* An inode's attributes for detection of changes */
> >  struct integrity_inode_attributes {
> > +	struct timespec64 ctime;
> >  	u64 version;		/* track inode changes */
> >  	unsigned long ino;
> >  	dev_t dev;
> > @@ -42,8 +45,10 @@ struct integrity_inode_attributes {
> >   */
> >  static inline void
> >  integrity_inode_attrs_store(struct integrity_inode_attributes *attrs,
> > -			    u64 i_version, const struct inode *inode)
> > +			    u64 i_version, struct timespec64 ctime,
> > +			    const struct inode *inode)
> >  {
> > +	attrs->ctime = ctime;
> >  	attrs->version = i_version;
> >  	attrs->dev = inode->i_sb->s_dev;
> >  	attrs->ino = inode->i_ino;
> > @@ -51,14 +56,39 @@ integrity_inode_attrs_store(struct integrity_inode_attributes *attrs,
> >  
> >  /*
> >   * On stacked filesystems detect whether the inode or its content has changed.
> > + *
> > + * Must be called in process context.
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
> > +	might_sleep();
> > +
> > +	if (inode->i_sb->s_dev != attrs->dev || inode->i_ino != attrs->ino)
> > +		return true;
> > +
> > +	/*
> > +	 * EVM currently relies on backing inode i_version. While IS_I_VERSION
> > +	 * is not a good indicator of i_version support, this still retains
> > +	 * the logic such that a re-evaluation should still occur for EVM, and
> > +	 * only for IMA if vfs_getattr_nosec() fails.
> > +	 */
> > +	if (!file || vfs_getattr_nosec(&file->f_path, &stat,
> > +				       STATX_CHANGE_COOKIE | STATX_CTIME,
> > +				       AT_STATX_SYNC_AS_STAT))
> > +		return !IS_I_VERSION(inode) ||
> > +			!inode_eq_iversion(inode, attrs->version);
> 
> Seems like a reasonable way to handle getattr failure, given the
> limitations on EVM.
> 
> > +
> > +	if (stat.result_mask & STATX_CHANGE_COOKIE)
> > +		return stat.change_cookie != attrs->version;
> > +
> > +	if (stat.result_mask & STATX_CTIME)
> > +		return !timespec64_equal(&stat.ctime, &attrs->ctime);
> > +
> > +	return true;
> >  }
> >  
> >  
> > diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> > index a5e730ffda57fbc0a91124adaa77b946a12d08b4..361ee7b216247a0d6d2f518e82fb6e92dc355afe 100644
> > --- a/security/integrity/evm/evm_crypto.c
> > +++ b/security/integrity/evm/evm_crypto.c
> > @@ -297,10 +297,12 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
> >  	hmac_add_misc(desc, inode, type, data->digest);
> >  
> >  	if (inode != d_backing_inode(dentry) && iint) {
> > +		struct timespec64 ctime = {0};
> > +
> >  		if (IS_I_VERSION(inode))
> >  			i_version = inode_query_iversion(inode); 
> 
> It would be nice if you could change this codepath as well, but that
> looks like a much bigger project. FWIW, I took a quick look:
> 
> The problematic codepath is get/setxattr, which can call into this but
> currently only receives a dentry and not a struct path. That would
> probably have to be changed. I think it's doable but it's a fair bit of
> yak shaving.

Agreed. I was looking at that a couple weeks ago to include a patch 2
for EVM, and came to the same conclusion. I did find struct iattr on the
setxattr which has struct file *, but that seemed dubious to at best.

Alternatively, create security_get/setxattr() equivalent hooks, or
have an internal mapping of sorts.

> 
> >  		integrity_inode_attrs_store(&iint->metadata_inode, i_version,
> > -					    inode);
> > +					    ctime, inode);
> >  	}
> >  
> >  	/* Portable EVM signatures must include an IMA hash */
> > diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> > index 73d500a375cb37a54f295b0e1e93fd6e5d9ecddc..6a4e0e246005246d5700b1db590c1759242b9cb6 100644
> > --- a/security/integrity/evm/evm_main.c
> > +++ b/security/integrity/evm/evm_main.c
> > @@ -752,9 +752,8 @@ bool evm_metadata_changed(struct inode *inode, struct inode *metadata_inode)
> >  	bool ret = false;
> >  
> >  	if (iint) {
> > -		ret = (!IS_I_VERSION(metadata_inode) ||
> > -		       integrity_inode_attrs_changed(&iint->metadata_inode,
> > -						     metadata_inode));
> > +		ret = integrity_inode_attrs_changed(&iint->metadata_inode,
> > +						    NULL, metadata_inode);
> >  		if (ret)
> >  			iint->evm_status = INTEGRITY_UNKNOWN;
> >  	}
> > diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> > index c35ea613c9f8d404ba4886e3b736c3bab29d1668..0d8e0a3ebd34b70bb1b4cc995aae5d4adc90a585 100644
> > --- a/security/integrity/ima/ima_api.c
> > +++ b/security/integrity/ima/ima_api.c
> > @@ -254,6 +254,7 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
> >  	int length;
> >  	void *tmpbuf;
> >  	u64 i_version = 0;
> > +	struct timespec64 ctime = {0};
> >  
> >  	/*
> >  	 * Always collect the modsig, because IMA might have already collected
> > @@ -272,10 +273,15 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
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
> > +		if (stat.result_mask & STATX_CTIME)
> > +			ctime = stat.ctime;
> > +	}
> >  	hash.hdr.algo = algo;
> >  	hash.hdr.length = hash_digest_size[algo];
> >  
> > @@ -305,11 +311,13 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
> >  
> >  	iint->ima_hash = tmpbuf;
> >  	memcpy(iint->ima_hash, &hash, length);
> > -	if (real_inode == inode)
> > +	if (real_inode == inode) {
> >  		iint->real_inode.version = i_version;
> > -	else
> > +		iint->real_inode.ctime = ctime;
> > +	} else {
> >  		integrity_inode_attrs_store(&iint->real_inode, i_version,
> > -					    real_inode);
> > +					    ctime, real_inode);
> > +	}
> >  
> >  	/* Possibly temporary failure due to type of read (eg. O_DIRECT) */
> >  	if (!result)
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index 5770cf691912aa912fc65280c59f5baac35dd725..54b638663c9743d39e5fb65711dbd9698b38e39b 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -22,12 +22,14 @@
> >  #include <linux/mount.h>
> >  #include <linux/mman.h>
> >  #include <linux/slab.h>
> > +#include <linux/stat.h>
> >  #include <linux/xattr.h>
> >  #include <linux/ima.h>
> >  #include <linux/fs.h>
> >  #include <linux/iversion.h>
> >  #include <linux/evm.h>
> >  #include <linux/crash_dump.h>
> > +#include <linux/time64.h>
> >  
> >  #include "ima.h"
> >  
> > @@ -199,10 +201,13 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
> >  					    &iint->atomic_flags);
> >  		if ((iint->flags & IMA_NEW_FILE) ||
> >  		    vfs_getattr_nosec(&file->f_path, &stat,
> > -				      STATX_CHANGE_COOKIE,
> > -				      AT_STATX_SYNC_AS_STAT) ||
> > -		    !(stat.result_mask & STATX_CHANGE_COOKIE) ||
> > -		    stat.change_cookie != iint->real_inode.version) {
> > +			    STATX_CHANGE_COOKIE | STATX_CTIME,
> > +			    AT_STATX_SYNC_AS_STAT) ||
> > +		    ((stat.result_mask & STATX_CHANGE_COOKIE) ?
> > +		      stat.change_cookie != iint->real_inode.version :
> > +		      (!(stat.result_mask & STATX_CTIME) ||
> > +			!timespec64_equal(&stat.ctime,
> > +					  &iint->real_inode.ctime)))) {
> >  			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
> >  			iint->measured_pcrs = 0;
> >  			if (update)
> > @@ -328,9 +333,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
> >  	real_inode = d_real_inode(file_dentry(file));
> >  	if (real_inode != inode &&
> >  	    (action & IMA_DO_MASK) && (iint->flags & IMA_DONE_MASK)) {
> > -		if (!IS_I_VERSION(real_inode) ||
> > -		    integrity_inode_attrs_changed(&iint->real_inode,
> > -						  real_inode)) {
> > +		if (integrity_inode_attrs_changed(&iint->real_inode,
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
> Looks like a good change overall. Thanks for fixing this up. I don't
> know IMA or EVM very well, so FWIW:

Thanks! Fun investigation & fix.

> 
> Acked-by: Jeff Layton <jlayton@kernel.org>

