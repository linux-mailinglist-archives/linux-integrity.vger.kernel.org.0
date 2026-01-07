Return-Path: <linux-integrity+bounces-8197-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA94ED00198
	for <lists+linux-integrity@lfdr.de>; Wed, 07 Jan 2026 22:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAE1F30194C3
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jan 2026 21:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D1334AB0B;
	Wed,  7 Jan 2026 21:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkfrLCvh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8693E26FA5B;
	Wed,  7 Jan 2026 21:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767820215; cv=none; b=p+MOdT1ooyMC3wAuT5zpA/dI2InOG+A0PpHSzLtOcCn+KYzYk2rb6+LT5gdgJOUGANFpH1TfJzq7l5+btQakP7DPIxu3DqOJHAvLLFL428FJ30Z+ET2dZ8jfFbnslBTzZ/VfYxkBV26n9Zp08CNmwtpRd0dZWDnA8demMV1Xprw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767820215; c=relaxed/simple;
	bh=LXih7MfEiSXktj0voMkKh/LDAHXHCoz68bnEqx47CFo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IindE7f5kodueLEEMQf1nYhXlKmltHCZkrTebYnWKDuaGT7lyA8Fimf2DOi00fNJ6OzLOTSul6h82cNX3HW5Brr1kK5wMIwkw1RUpROv0iQIm9Qnd9M5MCb3c8T1vh+qU0bE+3fwu8VEvHBKL4oxzY29dRVFrGkJidSIbl5SROw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkfrLCvh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F067C4CEF1;
	Wed,  7 Jan 2026 21:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767820215;
	bh=LXih7MfEiSXktj0voMkKh/LDAHXHCoz68bnEqx47CFo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=AkfrLCvhZ9K9TtB1bl3odnMYXTR+DE+al2wkT4QddvWUriTZZnPZsGvJPCvuRvLQY
	 EhG62iv1sOxpGPYF3LWUop+Z42IUQ6pY/XaUTyTABnJk3ytDGdkbAxzk35XMaHhJaN
	 wgGRdnQznEGZYkmf1hBzx1J8drLobSiqZwDJtEttU5lDk6EosQoZmqbarX6wYMs+Jv
	 53kiaVhy+bPysTJbDSe6lCmyHN13UcMKsk5EWABj6W4WU9b6SpeG4zkU8EalzvnLWs
	 hYAgBuzLA2+eCE5wHat9Pf2dHXhz630c6alDh//ltdZEzSn3PGXVAP4tqpkMcZgREo
	 jFTzMBv5GttvQ==
Message-ID: <bd98a7dd123a68c9a6481a451c1cc4e5132740ac.camel@kernel.org>
Subject: Re: [PATCH RFC] ima: Fallback to a ctime guard without i_version
 updates
From: Jeff Layton <jlayton@kernel.org>
To: Frederick Lawler <fred@cloudflare.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>,  Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore	
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn"	
 <serge@hallyn.com>, "Darrick J. Wong" <djwong@kernel.org>, Christian
 Brauner	 <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@cloudflare.com
Date: Wed, 07 Jan 2026 16:10:12 -0500
In-Reply-To: <aV66am9A5MmdNPbY@CMGLRV3>
References: <20251229-xfs-ima-fixup-v1-1-6a717c939f7c@cloudflare.com>
	 <3ad9ded9b3a269908eee6c79b70dbf432e60ce8d.camel@kernel.org>
	 <aV07lY6NOkNvUk3Z@CMGLRV3> <aV1jhIS24tE-dL9A@CMGLRV3>
	 <25b6d1b42ea07b058be4e4f48bb5a7c6b879b3ed.camel@kernel.org>
	 <aV66am9A5MmdNPbY@CMGLRV3>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-07 at 13:56 -0600, Frederick Lawler wrote:
> On Tue, Jan 06, 2026 at 02:50:31PM -0500, Jeff Layton wrote:
> > On Tue, 2026-01-06 at 13:33 -0600, Frederick Lawler wrote:
> > > On Tue, Jan 06, 2026 at 10:43:01AM -0600, Frederick Lawler wrote:
> > > > Hi Jeff,
> > > >=20
> > > > On Tue, Jan 06, 2026 at 07:01:08AM -0500, Jeff Layton wrote:
> > > > > On Mon, 2025-12-29 at 11:52 -0600, Frederick Lawler wrote:
> > > > > > Since commit 1cf7e834a6fb ("xfs: switch to multigrain timestamp=
s"), IMA
> > > > > > is no longer able to correctly track inode.i_version due to the=
 struct
> > > > > > kstat.change_cookie no longer containing an updated i_version.
> > > > > >=20
> > > > > > Introduce a fallback mechanism for IMA that instead tracks a
> > > > > > integrity_ctime_guard() in absence of or outdated i_version
> > > > > > for stacked file systems.
> > > > > >=20
> > > > > > EVM is left alone since it mostly cares about the backing inode=
.
> > > > > >=20
> > > > > > Link: https://lore.kernel.org/all/aTspr4_h9IU4EyrR@CMGLRV3
> > > > > > Fixes: 1cf7e834a6fb ("xfs: switch to multigrain timestamps")
> > > > > > Suggested-by: Jeff Layton <jlayton@kernel.org>
> > > > > > Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> > > > > > ---
> > > > > > The motivation behind this was that file systems that use the
> > > > > > cookie to set the i_version for stacked file systems may still =
do so.
> > > > > > Then add in the ctime_guard as a fallback if there's a detected=
 change.
> > > > > > The assumption is that the ctime will be different if the i_ver=
sion is
> > > > > > different anyway for non-stacked file systems.
> > > > > >=20
> > > > > > I'm not too pleased with passing in struct file* to
> > > > > > integrity_inode_attrs_changed() since EVM doesn't currently use
> > > > > > that for now, but I couldn't come up with another idea to get t=
he
> > > > > > stat without coming up with a new stat function to accommodate =
just
> > > > > > the file path, fully separate out IMA/EVM checks, or lastly add=
 stacked
> > > > > > file system support to EVM (which doesn't make much sense to me
> > > > > > at the moment).
> > > > > >=20
> > > > > > I plan on adding in self test infrastructure for the v1, but I =
would
> > > > > > like to get some early feedback on the approach first.
> > > > > > ---
> > > > > >  include/linux/integrity.h           | 29 +++++++++++++++++++++=
+++-----
> > > > > >  security/integrity/evm/evm_crypto.c |  2 +-
> > > > > >  security/integrity/evm/evm_main.c   |  2 +-
> > > > > >  security/integrity/ima/ima_api.c    | 21 +++++++++++++++------
> > > > > >  security/integrity/ima/ima_main.c   | 17 ++++++++++-------
> > > > > >  5 files changed, 51 insertions(+), 20 deletions(-)
> > > > > >=20
> > > > > > diff --git a/include/linux/integrity.h b/include/linux/integrit=
y.h
> > > > > > index f5842372359be5341b6870a43b92e695e8fc78af..4964c0f2bbda0ca=
450d135b9b738bc92256c375a 100644
> > > > > > --- a/include/linux/integrity.h
> > > > > > +++ b/include/linux/integrity.h
> > > > > > @@ -31,19 +31,27 @@ static inline void integrity_load_keys(void=
)
> > > > > > =20
> > > > > >  /* An inode's attributes for detection of changes */
> > > > > >  struct integrity_inode_attributes {
> > > > > > +	u64 ctime_guard;
> > > > > >  	u64 version;		/* track inode changes */
> > > > > >  	unsigned long ino;
> > > > > >  	dev_t dev;
> > > > > >  };
> > > > > > =20
> > > > > > +static inline u64 integrity_ctime_guard(struct kstat stat)
> > > > > > +{
> > > > > > +	return stat.ctime.tv_sec ^ stat.ctime.tv_nsec;
> > > > > > +}
> > > > > > +
> > > > > >  /*
> > > > > >   * On stacked filesystems the i_version alone is not enough to=
 detect file data
> > > > > >   * or metadata change. Additional metadata is required.
> > > > > >   */
> > > > > >  static inline void
> > > > > >  integrity_inode_attrs_store(struct integrity_inode_attributes =
*attrs,
> > > > > > -			    u64 i_version, const struct inode *inode)
> > > > > > +			    u64 i_version, u64 ctime_guard,
> > > > > > +			    const struct inode *inode)
> > > > > >  {
> > > > > > +	attrs->ctime_guard =3D ctime_guard;
> > > > > >  	attrs->version =3D i_version;
> > > > > >  	attrs->dev =3D inode->i_sb->s_dev;
> > > > > >  	attrs->ino =3D inode->i_ino;
> > > > > > @@ -54,11 +62,22 @@ integrity_inode_attrs_store(struct integrit=
y_inode_attributes *attrs,
> > > > > >   */
> > > > > >  static inline bool
> > > > > >  integrity_inode_attrs_changed(const struct integrity_inode_att=
ributes *attrs,
> > > > > > -			      const struct inode *inode)
> > > > > > +			      struct file *file, struct inode *inode)
> > > > > >  {
> > > > > > -	return (inode->i_sb->s_dev !=3D attrs->dev ||
> > > > > > -		inode->i_ino !=3D attrs->ino ||
> > > > > > -		!inode_eq_iversion(inode, attrs->version));
> > > > > > +	struct kstat stat;
> > > > > > +
> > > > > > +	if (inode->i_sb->s_dev !=3D attrs->dev ||
> > > > > > +	    inode->i_ino !=3D attrs->ino)
> > > > > > +		return true;
> > > > > > +
> > > > > > +	if (inode_eq_iversion(inode, attrs->version))
> > > > > > +		return false;
> > > > > > +
> > > > > > +	if (!file || vfs_getattr_nosec(&file->f_path, &stat, STATX_CT=
IME,
> > > > > > +				       AT_STATX_SYNC_AS_STAT))
> > > > > > +		return true;
> > > > > > +
> > > > >=20
> > > > > This is rather odd. You're sampling the i_version field directly,=
 but
> > > > > if it's not equal then you go through ->getattr() to get the ctim=
e.
> > > > >=20
> > > > > It's particularly odd since you don't know whether the i_version =
field
> > > > > is even implemented on the fs. On filesystems where it isn't, the
> > > > > i_version field generally stays at 0, so won't this never fall th=
rough
> > > > > to do the vfs_getattr_nosec() call on those filesystems?
> > > > >=20
> > > >=20
> > > > You're totally right. I didn't consider FS's caching the value at z=
ero.
> > >=20
> > > Actually, I'm going to amend this. I think I did consider FSs without=
 an
> > > implementation. Where this is called at, it is often guarded by a
> > > !IS_I_VERSION() || integrity_inode_attrs_change(). If I'm
> > > understanding this correctly, the check call doesn't occur unless the=
 inode
> > > has i_version support.
> > >=20
> >=20
> >=20
> > It depends on what you mean by i_version support:
> >=20
> > That flag just tells the VFS that it needs to bump the i_version field
> > when updating timestamps. It's not a reliable indicator of whether the
> > i_version field is suitable for the purpose you want here.
> >=20
>=20
> So, it would make sense then to also remove those guards at the callsite
> then if the intention is to compare against the cookie & ctime regardless=
?
>=20

Yes, I'd say so. IS_I_VERSION() is not a reliable indicator of whether
the filesystem can provide a proper change attribute. For instance,
cephfs and NFS don't set that flag, but they can (sometimes) provide
STATX_CHANGE_COOKIE. Going through getattr() is a much more reliable
method.

> > The problem here and the one that we ultimately fixed with multigrain
> > timestamps is that XFS in particular will bump i_version on any change
> > to the log. That includes atime updates due to reads.
> >=20
> > XFS still tracks the i_version the way it always has, but we've stopped
> > getattr() from reporting it because it's not suitable for the purpose
> > that nfsd (and IMA) need it for.
> >=20
> > > It seems to me the suggestion then is to remove the IS_I_VERSION()
> > > checks guarding the call sites, grab both ctime and cookie from stat,
> > > and if IS_I_VERSION() use that, otherwise cookie, and compare
> > > against the cached i_version with one of those values, and then fall
> > > back to ctime?
> > >=20
> >=20
> > Not exactly.
> >=20
> > You want to call getattr() for STATX_CHANGE_COOKIE|STATX_CTIME, and
> > then check the kstat->result_mask. If STATX_CHANGE_COOKIE is set, then
> > use that. If it's not then use the ctime.
>=20
> Ok, I think I understand. To reiterate my understanding, ignore calling
> into inode_eq_iversion() all together.
>=20
> 	return other_checks || ((mask & cookie) ? cache->i_version =3D=3D cookie=
_val :
> 	compare_ctime())
>=20

Yes, that psuedocode looks about right. IS_I_VERSION(),
inode_eq_iversion(), etc. are really filesystem-internal APIs and not
something IMA should be relying on as a fstype-agnostic LSM.


> >=20
> > The part I'm not sure about is whether it's actually safe to do this.
> > vfs_getattr_nosec() can block in some situations. Is it ok to do this
> > in any context where integrity_inode_attrs_changed() may be called?=C2=
=A0
> >=20
> > ISTR that this was an issue at one point, but maybe isn't now that IMA
> > is an LSM?
>=20
> Poking around, callers to integrity_inode_attrs_changed() are currently b=
ehind
> mutex_lock(&iinit->mutex) (similar to vfs_getattr_nosec() calls), and cur=
rently
> only called from process_measurement().
>=20
> While I can't say for certain this will always be the case for future use
> use cases, would it be helpful to include a may_sleep() in
> integrity_inode_attrs_changed() to drive this point and make a comment?
>=20

Those kind of annotations do tend to be useful.

>=20
--=20
Jeff Layton <jlayton@kernel.org>

