Return-Path: <linux-integrity+bounces-8209-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B104D145FF
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Jan 2026 18:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8DCE63020FF1
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Jan 2026 17:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3782ED873;
	Mon, 12 Jan 2026 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CB0HmYL1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D26E301704
	for <linux-integrity@vger.kernel.org>; Mon, 12 Jan 2026 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768238051; cv=none; b=HPBaznWqozai1mfLEX5L4IZAme9Bx07eFaHplgI40QWKxT8FCB2U4w2HAvc3ZH7vTtHyuofJBiOMmCaf85Bt5n4AQTLPu3b3myFtoN+QCqvPwCvt6DJApj8NctlhyOodZ5yxc+n7/cRLKSIQ9p/8GlAsIta8+NU5D0FLOzmw47E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768238051; c=relaxed/simple;
	bh=+6MD9U3/oNkwpZKjfey1D4wf+JNsO6goqtte5CPMt9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjWXKI9HXkp7fIbN9ds0oOO10JkrCt+Gz0X1V+wNzcz92BfJvyOvNSrHIOt4hA/UMh9bZ4EnJT6Xq5LVFvJAzWGInEw3v3H54Up0yZhTnCvj8xtxs5+I5o9/Fu3rd5foEQgQxaehWciDDuzp8pU2VkY0OLKMBj6RidM2vC2GyhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CB0HmYL1; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-45c60ecc0f8so102144b6e.3
        for <linux-integrity@vger.kernel.org>; Mon, 12 Jan 2026 09:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768238048; x=1768842848; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QyJinldTenjlTP9+ze0OVo2ZOUQ8sydojxDpmIKfmVc=;
        b=CB0HmYL1CSRbRXROWgXTdMCz+yLGPTbVAORnmBqVcQjpMt9W5SstZjeXQ1cLzrvxxg
         YBqGcDMS/sq3kToXEW6yeMtwS6E8ue9m5ljrfEJhB6Gf+ODcJT5x88Vk57B7uhLXlkwm
         DrRjxbWj/ZtX8YQ5kCIC7uqTDeCnRFf+cujsbrKjJ7/C9FTZmvkMK9vXKkoUW6GpHLH9
         27CsPRAaDprTV2XpspGXm6B4L7gUaLR5/QCzthqReqIEgbPc63qNLosAN2hNitKrqvOh
         LRc5prekQmaohXmeGlQbNIH4hF9tVk3Lq5P9tyPFdmhXz55gc8mxxrLgEOan1mFznwnl
         Mqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768238048; x=1768842848;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QyJinldTenjlTP9+ze0OVo2ZOUQ8sydojxDpmIKfmVc=;
        b=skcrUqcgqDVp8mLAOKgJYzT8xa9hZfBBFkEqtwnHF8uhPMot08vvbEGyJ0wr69W+Hc
         z4AIZNUXKh6bw+xHW88aPKusOrBM4eYCBn2zMoJqgt+O2emDh3vRiE1YAGtLf7MJ7gmm
         pSY35OsFbnN2d7nrRBtuaIvY2BziM9yb1idD0YH3C1tgdS4fQLIfH50j+s3Ynje2xGmA
         CjaobSwrkyBu8npie98P+8+y0GUCLfLRNa/VtsfETD/j6U8ZDp9lGnbhE7lgORLFj0xm
         YQpTYpgmwbt3zWCHrL+KKfz6M6C7lyDvl+aMjoBK6RWvMa+4nrnk5A+m5HND2rVR5DMy
         nulg==
X-Forwarded-Encrypted: i=1; AJvYcCUyJr0sJaRjyysAwhdAuzAbzrpceoJTQnnu4rBog3DF/1hqCTZU2K1xnrrtvdQ60t1Z7oTt8axS0myJXvWX3a0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRQv2yQoYB13xLTLb+IpuDCk1nTOWLCLBXhmL/3v52cFTlIZow
	ZHkge4+LRRPy721hbrNWhwCviMzu4on1YTJ/IhRg1m82fLqEsj/gUao6ynGUoeeLpYQ=
X-Gm-Gg: AY/fxX7g3S/gIc0elTsohEhouAtvJjvgLpOd4VV7rfQ/DOkXYSRabAP/LgkRbamFt+0
	nlZ6Dpohs2PRUsT9Q+md/FJqNZDo4sRCSLdeRxb+tAA8NIfiO2j7WYx5eVgNqKYlUH+dOr2pyYw
	hUE8Koq4aEUPDCAtILPfBA3vnIkNfuBD+lT6K5YwF+5umny5jdk2xyzy1VAmktSH1HDTixubSO/
	ehw+IWoqs8PBPE0sXUH/oR2w46OjvO9ddEX1GlRBg3A5UaArOZGQhuMqV432PtNsnVCkZd2UMsg
	PvWl5ytTNFcwfHbWBDMXZMBxQBPnVvCAGuTQ3ADXuUc7nmOX9Bfs2iLMBp9bAxuDk6lZWVYsWut
	8fGGyC5qryWXZueG5NnhQ2JydV45W4yH04oOhLb6TbPPatKpcWBTspFgVnLbcIqr9YvI=
X-Google-Smtp-Source: AGHT+IG/ePwN35HG0w/1p2sUU3s0fuKkedonKLVhqDCc4g/8Nl3LR2SCuPk6C+diJOjLOmIc+3i9aQ==
X-Received: by 2002:a05:6808:148a:b0:44f:e912:ea97 with SMTP id 5614622812f47-45a6bdb94b7mr9876320b6e.18.1768238047536;
        Mon, 12 Jan 2026 09:14:07 -0800 (PST)
Received: from CMGLRV3 ([2a09:bac5:947d:1b37::2b6:f])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e2e903dsm8171148b6e.20.2026.01.12.09.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 09:14:07 -0800 (PST)
Date: Mon, 12 Jan 2026 11:14:04 -0600
From: Frederick Lawler <fred@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Jeff Layton <jlayton@kernel.org>,
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
Message-ID: <aWUr3K__4Y21fSoe@CMGLRV3>
References: <20251229-xfs-ima-fixup-v1-1-6a717c939f7c@cloudflare.com>
 <3ad9ded9b3a269908eee6c79b70dbf432e60ce8d.camel@kernel.org>
 <aV07lY6NOkNvUk3Z@CMGLRV3>
 <aV1jhIS24tE-dL9A@CMGLRV3>
 <25b6d1b42ea07b058be4e4f48bb5a7c6b879b3ed.camel@kernel.org>
 <15eaa3613b0552cc48b55972b81882ac1e1d1150.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15eaa3613b0552cc48b55972b81882ac1e1d1150.camel@linux.ibm.com>

On Mon, Jan 12, 2026 at 09:02:02AM -0500, Mimi Zohar wrote:
> On Tue, 2026-01-06 at 14:50 -0500, Jeff Layton wrote:
> > > > > > @@ -54,11 +62,22 @@ integrity_inode_attrs_store(struct integrity_inode_attributes *attrs,
> > > > > >    */
> > > > > >   static inline bool
> > > > > >   integrity_inode_attrs_changed(const struct integrity_inode_attributes *attrs,
> > > > > > -			      const struct inode *inode)
> > > > > > +			      struct file *file, struct inode *inode)
> > > > > >   {
> > > > > > -	return (inode->i_sb->s_dev != attrs->dev ||
> > > > > > -		inode->i_ino != attrs->ino ||
> > > > > > -		!inode_eq_iversion(inode, attrs->version));
> > > > > > +	struct kstat stat;
> > > > > > +
> > > > > > +	if (inode->i_sb->s_dev != attrs->dev ||
> > > > > > +	    inode->i_ino != attrs->ino)
> > > > > > +		return true;
> > > > > > +
> > > > > > +	if (inode_eq_iversion(inode, attrs->version))
> > > > > > +		return false;
> > > > > > +
> > > > > > +	if (!file || vfs_getattr_nosec(&file->f_path, &stat, STATX_CTIME,
> > > > > > +				       AT_STATX_SYNC_AS_STAT))
> > > > > > +		return true;
> > > > > > +
> > > > > 
> > > > > This is rather odd. You're sampling the i_version field directly, but
> > > > > if it's not equal then you go through ->getattr() to get the ctime.
> > > > > 
> > > > > It's particularly odd since you don't know whether the i_version field
> > > > > is even implemented on the fs. On filesystems where it isn't, the
> > > > > i_version field generally stays at 0, so won't this never fall through
> > > > > to do the vfs_getattr_nosec() call on those filesystems?
> > > > > 
> > > > 
> > > > You're totally right. I didn't consider FS's caching the value at zero.
> > > 
> > > Actually, I'm going to amend this. I think I did consider FSs without an
> > > implementation. Where this is called at, it is often guarded by a
> > > !IS_I_VERSION() || integrity_inode_attrs_change(). If I'm
> > > understanding this correctly, the check call doesn't occur unless the inode
> > > has i_version support.
> > > 
> > 
> > 
> > It depends on what you mean by i_version support:
> > 
> > That flag just tells the VFS that it needs to bump the i_version field
> > when updating timestamps. It's not a reliable indicator of whether the
> > i_version field is suitable for the purpose you want here.
> > 
> > The problem here and the one that we ultimately fixed with multigrain
> > timestamps is that XFS in particular will bump i_version on any change
> > to the log. That includes atime updates due to reads.
> > 
> > XFS still tracks the i_version the way it always has, but we've stopped
> > getattr() from reporting it because it's not suitable for the purpose
> > that nfsd (and IMA) need it for.
> > 
> > > It seems to me the suggestion then is to remove the IS_I_VERSION()
> > > checks guarding the call sites, grab both ctime and cookie from stat,
> > > and if IS_I_VERSION() use that, otherwise cookie, and compare
> > > against the cached i_version with one of those values, and then fall
> > > back to ctime?
> > > 
> > 
> > Not exactly.
> > 
> > You want to call getattr() for STATX_CHANGE_COOKIE|STATX_CTIME, and
> > then check the kstat->result_mask. If STATX_CHANGE_COOKIE is set, then
> > use that. If it's not then use the ctime.
> > 
> > The part I'm not sure about is whether it's actually safe to do this.
> > vfs_getattr_nosec() can block in some situations. Is it ok to do this
> > in any context where integrity_inode_attrs_changed() may be called? 
> 
> Frederick, before making any changes, please describe the problem you're
> actually seeing. From my limited testing, file change IS being detected. A major
> change like Jeff is suggesting is not something that would or should be back
> ported.  Remember, Jeff's interest is remote filesystems, not necessarily with
> your particular XFS concern.
> 
> So again, what is the problem you're trying to address?

It's easier if I paste a simpler version of test I've been promising
for v1 to help show this (below).

In 6.12 the test snippet passes, for >= 6.13 we get an audit
evaluation on the each execution when there should only be 1.

The struct integrity_inode_attributes.version stays at zero for XFS
in the below test, as well as file systems that calls into
generic_fillattr() or otherwise that doesn't set the change cookie
request mask.

When file systems have a mutated file, the cookie is then updated,
but the compare against inode.i_version could be out of date depending
on file system implementation. Thus we see since 6.13, XFS an atime change
will cause another evaluation due to stale cache.

I'm not expecting a backport to 6.13 as there has been a lot of changes
in IMA/EVM, but I think to the 6.18 LTS is reasonable. With leaving
EVM alone, it's a small diff.

I have a updated patch that hopefully addresses all your concerns
from other responses in this thread. I want to point out that the updated
code is more EVM/IMA invariant mindful than this RFC. I'd
like to submit that, and then move discussion over there if possible.

Hopefully this helps,
Fred

_fragment.config_
CONFIG_XFS_FS=y
CONFIG_OVERLAY_FS=y
CONFIG_IMA=y
CONFIG_IMA_WRITE_POLICY=y
CONFIG_IMA_READ_POLICY=y

_./test.sh_
#!/bin/bash -e

IMA_POLICY="/sys/kernel/security/ima/policy"
TEST_BIN="/bin/date"
MNT_BASE="/tmp/ima_test_root"

mkdir -p "$MNT_BASE"
mount -t tmpfs tmpfs "$MNT_BASE"
mkdir -p "$MNT_BASE"/{xfs_disk,upper,work,ovl}

dd if=/dev/zero of="$MNT_BASE/xfs.img" bs=1M count=300
mkfs.xfs -q "$MNT_BASE/xfs.img"
mount "$MNT_BASE/xfs.img" "$MNT_BASE/xfs_disk"
cp "$TEST_BIN" "$MNT_BASE/xfs_disk/test_prog"

mount -t overlay overlay -o \
"lowerdir=$MNT_BASE/xfs_disk,upperdir=$MNT_BASE/upper,workdir=$MNT_BASE/work" \
"$MNT_BASE/ovl"

echo "audit func=BPRM_CHECK uid=$(id -u nobody)" > "$IMA_POLICY"

target_prog="$MNT_BASE/ovl/test_prog"
setpriv --reuid nobody "$target_prog"
setpriv --reuid nobody "$target_prog"
setpriv --reuid nobody "$target_prog"

audit_count=$(dmesg | grep -c "file=\"$target_prog\"")

if [[ "$audit_count" -eq 1 ]]; then
	echo "PASS: Found exactly 1 audit event."
else
	echo "FAIL: Expected 1 audit event, but found $audit_count."
	exit 1
fi

> 
> Mimi
> 
> > 
> > ISTR that this was an issue at one point, but maybe isn't now that IMA
> > is an LSM?
> 

