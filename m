Return-Path: <linux-integrity+bounces-8177-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22697CF832B
	for <lists+linux-integrity@lfdr.de>; Tue, 06 Jan 2026 13:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12ECC30360C0
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jan 2026 12:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C141EA7DF;
	Tue,  6 Jan 2026 12:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHZaMkPt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5BA327BEC;
	Tue,  6 Jan 2026 12:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767700874; cv=none; b=EFSu9A1CPa/QnuvXaXku9FX+T/sGXgywfCLS8R9niiyId7FEsz6JcFhZkBDluZBxwzNxJPv2QukW9xcra6Rom3yq+iLUHnPyPdj/FpkeZO2RJ3LOMeOWLqSRhM7Z7PDmzaKT4cVVkW0dHQ5h1hb51gf9zIVQygJHKjwasSZ/+Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767700874; c=relaxed/simple;
	bh=UcacE+SqlCr+98fJ+8mPmshhMJoJlJr+MTNmvPzmR5I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ogh1JlSrnFDa09k1ICrxnduN9WFaTpfydIkjs7C8hMCiBzHeOKQPL5rA3ut9B3Rgv3oohFpFi8VwAWMrZ5TUgkz/sNgg1xKiLCkLVrjNfcU1yrz7z1T3HAmJZ5VgXO1bBAFo55Is59rXKamH6V36NpzUm8YfLn/+Ek27m7R4KVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHZaMkPt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06A1C116C6;
	Tue,  6 Jan 2026 12:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767700871;
	bh=UcacE+SqlCr+98fJ+8mPmshhMJoJlJr+MTNmvPzmR5I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=eHZaMkPt9GAXHn+A/t1YHQ1SNmR4WdlnxRFzYG/ubtHM7/TQixpY5mm1vmT+0ySZw
	 5LeZle1I85dTJ1/FYULf38Z/tLVaiQikl4hB8UtqZxLqF0SYngvVZpdm2Y5vB8YDff
	 AEMe0A1B+I2UKRFTQlkcbCv7OlG42x24vCitWjXu6R2xy7s6Vu3/kO1jUKHPLI5A5c
	 P08+4C90+QQYHBG9oxxIi3ztvcog62xe5g1rIqcTUwIf6VQ2EX3H0hMqR8rTr5EzF4
	 URvTyfn68Y7M17upsBBUVoWd9p0iQ0nhrgYKAVfF4uNpqqiMtWarY3m+hKJciqz/hH
	 7WmcMlXD8UPuQ==
Message-ID: <3ad9ded9b3a269908eee6c79b70dbf432e60ce8d.camel@kernel.org>
Subject: Re: [PATCH RFC] ima: Fallback to a ctime guard without i_version
 updates
From: Jeff Layton <jlayton@kernel.org>
To: Frederick Lawler <fred@cloudflare.com>, Mimi Zohar
 <zohar@linux.ibm.com>,  Roberto Sassu <roberto.sassu@huawei.com>, Dmitry
 Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg	
 <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, James Morris	
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "Darrick J.
 Wong"	 <djwong@kernel.org>, Christian Brauner <brauner@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@cloudflare.com
Date: Tue, 06 Jan 2026 07:01:08 -0500
In-Reply-To: <20251229-xfs-ima-fixup-v1-1-6a717c939f7c@cloudflare.com>
References: <20251229-xfs-ima-fixup-v1-1-6a717c939f7c@cloudflare.com>
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

On Mon, 2025-12-29 at 11:52 -0600, Frederick Lawler wrote:
> Since commit 1cf7e834a6fb ("xfs: switch to multigrain timestamps"), IMA
> is no longer able to correctly track inode.i_version due to the struct
> kstat.change_cookie no longer containing an updated i_version.
>=20
> Introduce a fallback mechanism for IMA that instead tracks a
> integrity_ctime_guard() in absence of or outdated i_version
> for stacked file systems.
>=20
> EVM is left alone since it mostly cares about the backing inode.
>=20
> Link: https://lore.kernel.org/all/aTspr4_h9IU4EyrR@CMGLRV3
> Fixes: 1cf7e834a6fb ("xfs: switch to multigrain timestamps")
> Suggested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> ---
> The motivation behind this was that file systems that use the
> cookie to set the i_version for stacked file systems may still do so.
> Then add in the ctime_guard as a fallback if there's a detected change.
> The assumption is that the ctime will be different if the i_version is
> different anyway for non-stacked file systems.
>=20
> I'm not too pleased with passing in struct file* to
> integrity_inode_attrs_changed() since EVM doesn't currently use
> that for now, but I couldn't come up with another idea to get the
> stat without coming up with a new stat function to accommodate just
> the file path, fully separate out IMA/EVM checks, or lastly add stacked
> file system support to EVM (which doesn't make much sense to me
> at the moment).
>=20
> I plan on adding in self test infrastructure for the v1, but I would
> like to get some early feedback on the approach first.
> ---
>  include/linux/integrity.h           | 29 ++++++++++++++++++++++++-----
>  security/integrity/evm/evm_crypto.c |  2 +-
>  security/integrity/evm/evm_main.c   |  2 +-
>  security/integrity/ima/ima_api.c    | 21 +++++++++++++++------
>  security/integrity/ima/ima_main.c   | 17 ++++++++++-------
>  5 files changed, 51 insertions(+), 20 deletions(-)
>=20
> diff --git a/include/linux/integrity.h b/include/linux/integrity.h
> index f5842372359be5341b6870a43b92e695e8fc78af..4964c0f2bbda0ca450d135b9b=
738bc92256c375a 100644
> --- a/include/linux/integrity.h
> +++ b/include/linux/integrity.h
> @@ -31,19 +31,27 @@ static inline void integrity_load_keys(void)
> =20
>  /* An inode's attributes for detection of changes */
>  struct integrity_inode_attributes {
> +	u64 ctime_guard;
>  	u64 version;		/* track inode changes */
>  	unsigned long ino;
>  	dev_t dev;
>  };
> =20
> +static inline u64 integrity_ctime_guard(struct kstat stat)
> +{
> +	return stat.ctime.tv_sec ^ stat.ctime.tv_nsec;
> +}
> +
>  /*
>   * On stacked filesystems the i_version alone is not enough to detect fi=
le data
>   * or metadata change. Additional metadata is required.
>   */
>  static inline void
>  integrity_inode_attrs_store(struct integrity_inode_attributes *attrs,
> -			    u64 i_version, const struct inode *inode)
> +			    u64 i_version, u64 ctime_guard,
> +			    const struct inode *inode)
>  {
> +	attrs->ctime_guard =3D ctime_guard;
>  	attrs->version =3D i_version;
>  	attrs->dev =3D inode->i_sb->s_dev;
>  	attrs->ino =3D inode->i_ino;
> @@ -54,11 +62,22 @@ integrity_inode_attrs_store(struct integrity_inode_at=
tributes *attrs,
>   */
>  static inline bool
>  integrity_inode_attrs_changed(const struct integrity_inode_attributes *a=
ttrs,
> -			      const struct inode *inode)
> +			      struct file *file, struct inode *inode)
>  {
> -	return (inode->i_sb->s_dev !=3D attrs->dev ||
> -		inode->i_ino !=3D attrs->ino ||
> -		!inode_eq_iversion(inode, attrs->version));
> +	struct kstat stat;
> +
> +	if (inode->i_sb->s_dev !=3D attrs->dev ||
> +	    inode->i_ino !=3D attrs->ino)
> +		return true;
> +
> +	if (inode_eq_iversion(inode, attrs->version))
> +		return false;
> +
> +	if (!file || vfs_getattr_nosec(&file->f_path, &stat, STATX_CTIME,
> +				       AT_STATX_SYNC_AS_STAT))
> +		return true;
> +

This is rather odd. You're sampling the i_version field directly, but
if it's not equal then you go through ->getattr() to get the ctime.

It's particularly odd since you don't know whether the i_version field
is even implemented on the fs. On filesystems where it isn't, the
i_version field generally stays at 0, so won't this never fall through
to do the vfs_getattr_nosec() call on those filesystems?

Ideally, you should just call vfs_getattr_nosec() early on with
STATX_CHANGE_COOKIE|STATX_CTIME to get both at once, and only trust
STATX_CHANGE_COOKIE if it's set in the returned mask.

> +	return attrs->ctime_guard !=3D integrity_ctime_guard(stat);
>  }
> =20
> =20
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm=
/evm_crypto.c
> index a5e730ffda57fbc0a91124adaa77b946a12d08b4..2d89c0e8d9360253f8dad52d2=
a8168127bb4d3b8 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -300,7 +300,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentr=
y,
>  		if (IS_I_VERSION(inode))
>  			i_version =3D inode_query_iversion(inode);
>  		integrity_inode_attrs_store(&iint->metadata_inode, i_version,
> -					    inode);
> +					    0, inode);
>  	}
> =20
>  	/* Portable EVM signatures must include an IMA hash */
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/e=
vm_main.c
> index 73d500a375cb37a54f295b0e1e93fd6e5d9ecddc..0712802628fd6533383f98556=
87e19bef7b771c7 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -754,7 +754,7 @@ bool evm_metadata_changed(struct inode *inode, struct=
 inode *metadata_inode)
>  	if (iint) {
>  		ret =3D (!IS_I_VERSION(metadata_inode) ||
>  		       integrity_inode_attrs_changed(&iint->metadata_inode,
> -						     metadata_inode));
> +			       NULL, metadata_inode));
>  		if (ret)
>  			iint->evm_status =3D INTEGRITY_UNKNOWN;
>  	}
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/im=
a_api.c
> index c35ea613c9f8d404ba4886e3b736c3bab29d1668..72bba8daa588a0f4e45e42492=
76edb54ca3d77ef 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -254,6 +254,7 @@ int ima_collect_measurement(struct ima_iint_cache *ii=
nt, struct file *file,
>  	int length;
>  	void *tmpbuf;
>  	u64 i_version =3D 0;
> +	u64 ctime_guard =3D 0;
> =20
>  	/*
>  	 * Always collect the modsig, because IMA might have already collected
> @@ -272,10 +273,16 @@ int ima_collect_measurement(struct ima_iint_cache *=
iint, struct file *file,
>  	 * to an initial measurement/appraisal/audit, but was modified to
>  	 * assume the file changed.
>  	 */
> -	result =3D vfs_getattr_nosec(&file->f_path, &stat, STATX_CHANGE_COOKIE,
> +	result =3D vfs_getattr_nosec(&file->f_path, &stat,
> +				   STATX_CHANGE_COOKIE | STATX_CTIME,
>  				   AT_STATX_SYNC_AS_STAT);
> -	if (!result && (stat.result_mask & STATX_CHANGE_COOKIE))
> -		i_version =3D stat.change_cookie;
> +	if (!result) {
> +		if (stat.result_mask & STATX_CHANGE_COOKIE)
> +			i_version =3D stat.change_cookie;
> +
> +		if (stat.result_mask & STATX_CTIME)
> +			ctime_guard =3D integrity_ctime_guard(stat);
> +	}
>  	hash.hdr.algo =3D algo;
>  	hash.hdr.length =3D hash_digest_size[algo];
> =20
> @@ -305,11 +312,13 @@ int ima_collect_measurement(struct ima_iint_cache *=
iint, struct file *file,
> =20
>  	iint->ima_hash =3D tmpbuf;
>  	memcpy(iint->ima_hash, &hash, length);
> -	if (real_inode =3D=3D inode)
> +	if (real_inode =3D=3D inode) {
>  		iint->real_inode.version =3D i_version;
> -	else
> +		iint->real_inode.ctime_guard =3D ctime_guard;
> +	} else {
>  		integrity_inode_attrs_store(&iint->real_inode, i_version,
> -					    real_inode);
> +				ctime_guard, real_inode);
> +	}
> =20
>  	/* Possibly temporary failure due to type of read (eg. O_DIRECT) */
>  	if (!result)
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index 5770cf691912aa912fc65280c59f5baac35dd725..6051ea4a472fc0b0dd7b4e81d=
a36eff8bd048c62 100644
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
> @@ -185,6 +186,7 @@ static void ima_check_last_writer(struct ima_iint_cac=
he *iint,
>  {
>  	fmode_t mode =3D file->f_mode;
>  	bool update;
> +	int ret;
> =20
>  	if (!(mode & FMODE_WRITE))
>  		return;
> @@ -197,12 +199,13 @@ static void ima_check_last_writer(struct ima_iint_c=
ache *iint,
> =20
>  		update =3D test_and_clear_bit(IMA_UPDATE_XATTR,
>  					    &iint->atomic_flags);
> -		if ((iint->flags & IMA_NEW_FILE) ||
> -		    vfs_getattr_nosec(&file->f_path, &stat,
> -				      STATX_CHANGE_COOKIE,
> -				      AT_STATX_SYNC_AS_STAT) ||
> -		    !(stat.result_mask & STATX_CHANGE_COOKIE) ||
> -		    stat.change_cookie !=3D iint->real_inode.version) {
> +		ret =3D vfs_getattr_nosec(&file->f_path, &stat,
> +					STATX_CHANGE_COOKIE | STATX_CTIME,
> +					AT_STATX_SYNC_AS_STAT);
> +		if ((iint->flags & IMA_NEW_FILE) || ret ||
> +		    (!ret && stat.change_cookie !=3D iint->real_inode.version) ||
> +		    (!ret && integrity_ctime_guard(stat) !=3D
> +		     iint->real_inode.ctime_guard)) {
>  			iint->flags &=3D ~(IMA_DONE_MASK | IMA_NEW_FILE);
>  			iint->measured_pcrs =3D 0;
>  			if (update)
> @@ -330,7 +333,7 @@ static int process_measurement(struct file *file, con=
st struct cred *cred,
>  	    (action & IMA_DO_MASK) && (iint->flags & IMA_DONE_MASK)) {
>  		if (!IS_I_VERSION(real_inode) ||
>  		    integrity_inode_attrs_changed(&iint->real_inode,
> -						  real_inode)) {
> +						  file, real_inode)) {
>  			iint->flags &=3D ~IMA_DONE_MASK;
>  			iint->measured_pcrs =3D 0;
>  		}
>=20
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251212-xfs-ima-fixup-931780a62c2c
>=20
> Best regards,

--=20
Jeff Layton <jlayton@kernel.org>

