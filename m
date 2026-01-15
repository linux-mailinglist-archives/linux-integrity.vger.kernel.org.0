Return-Path: <linux-integrity+bounces-8255-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D41BD245FC
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Jan 2026 13:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 020CE300DD94
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Jan 2026 12:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D4D36C5AF;
	Thu, 15 Jan 2026 12:03:47 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6525634846A;
	Thu, 15 Jan 2026 12:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768478627; cv=none; b=pXlMZ+n2SoGDUjlbPo8Leb2ucjexVUbwN9/JcWhU1EyVlyAikobCvNTgH06elAqh604tk/ud5ucxktnLca9YHBMlREh6ABlQr55ZLtemcn8MRRAz2NrLNiVchtJziMqxWzE4WvxE+KNtat0MYURF3Jcq3nbsr3p82KhDrixgcMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768478627; c=relaxed/simple;
	bh=5Re/9TQaT/1OKZBedSlDGCk/tHpfFxFDsIAZIxJ7S9U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iDQnBKNtJAmoJ9BcYTi2qk4zq4mMM6whltbdB0ATjywC6CplZ9bN/nojS+aJmW8Z2TxcjoU0naxIJjnWoVyPTtlIPltxBYQnILP10l5iq4swztchxH496i/E8Cfc6k8AlO8mu+tHjYg/4B5GAE1mWuYdWE/R3l9G+ghCFK07oEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dsLkG2dncztRph;
	Thu, 15 Jan 2026 19:44:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 5D08840568;
	Thu, 15 Jan 2026 19:46:53 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCn5Aag02hpYyAAAg--.13377S2;
	Thu, 15 Jan 2026 12:46:52 +0100 (CET)
Message-ID: <c825efc60cace922b45d0824f11cdaf44be9c0d3.camel@huaweicloud.com>
Subject: Re: [PATCH] ima: Detect changes to files via kstat changes rather
 than i_version
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Frederick Lawler <fred@cloudflare.com>, Mimi Zohar
 <zohar@linux.ibm.com>,  Roberto Sassu <roberto.sassu@huawei.com>, Dmitry
 Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg
 <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "Darrick J.
 Wong" <djwong@kernel.org>, Christian Brauner <brauner@kernel.org>, Josef
 Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@cloudflare.com
Date: Thu, 15 Jan 2026 12:46:37 +0100
In-Reply-To: <20260112-xfs-ima-fixup-v1-1-8d13b6001312@cloudflare.com>
References: <20260112-xfs-ima-fixup-v1-1-8d13b6001312@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwCn5Aag02hpYyAAAg--.13377S2
X-Coremail-Antispam: 1UD129KBjvJXoWfGr47tFyUuF4xKF1DXF1kZrb_yoWkWryfpa
	yqka47Gr48JFyIkFs7CF129a1FgrW0gFWUWry5Kw18AFnrZw1Igr9xCryYkF15KrW5Aw4j
	qayFyr13uw4qvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFk
	u4UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAOBGloXRcFDAACsL

On Mon, 2026-01-12 at 16:32 -0600, Frederick Lawler wrote:
> Commit 1cf7e834a6fb ("xfs: switch to multigrain timestamps")
> introduced a means to track change detection for an inode
> via ctime updates, opposed to setting kstat.change_cookie when
> calling into xfs_vn_getattr().
>=20
> This introduced a regression because IMA caches kstat.change_cookie
> to compare against an inode's i_version directly in
> integrity_inode_attrs_changed(), and thus could be out of date
> depending on how file systems increment i_version.
>=20
> To address this, require integrity_inode_attrs_changed() to query
> vfs_getattr_nosec() to compare the cached version against
> kstat.change_cookie directly. This ensures that when updates occur,
> we're accessing the same changed inode version on changes, and fallback
> to compare against an artificial version generated from kstat.ctime
> via integrity_ctime_guard() when there's no detected change
> to the kstat.change_cookie.
>=20
> This ensures that in the absence of i_version support for file systems,
> and in the absence of a kstat.change_cookie update, we ultimately have a
> unique-enough version to compare against.
>=20
> The exact implementation for integrity_ctime_guard() is to ensure that
> if tv_sec or tv_nsec are zero, there's some value to store back into
> struct integrity_inode_attributes.version. This also avoids the need to
> add additional storage and comparisons.
>=20
> Lastly, because EVM still relies on querying and caching a backing inode'=
s
> i_version, the integrity_inode_attrs_changed() falls back to the
> original inode.i_version !=3D cached comparison. This maintains the
> invariant that a re-evaluation in unknown change detection circumstances
> is required.
>=20
> Link: https://lore.kernel.org/all/aTspr4_h9IU4EyrR@CMGLRV3
> Suggested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> ---
> We uncovered a case in kernels >=3D 6.13 where XFS is no longer updating
> struct kstat.change_cookie on i_op getattr() access calls. Instead, XFS i=
s
> using multigrain ctime (as well as other file systems) for
> change detection in commit 1cf7e834a6fb ("xfs: switch to
> multigrain timestamps").
>=20
> Because file systems may implement i_version as they see fit, IMA
> caching may be behind as well as file systems that don't support/export
> i_version. Thus we're proposing to compare against the kstat.change_cooki=
e
> directly to the cached version, and fall back to a ctime guard when
> that's not updated.
>=20
> EVM is largely left alone since there's no trivial way to query a file
> directly in the LSM call paths to obtain kstat.change_cookie &
> kstat.ctime to cache. Thus retains accessing i_version directly.
>=20
> Regression tests will be added to the Linux Test Project instead of
> selftest to help catch future file system changes that may impact
> future evaluation of IMA.
>=20
> I'd like this to be backported to at least 6.18 if possible.
>=20
> Below is a simplified test that demonstrates the issue:
>=20
> _fragment.config_
> CONFIG_XFS_FS=3Dy
> CONFIG_OVERLAY_FS=3Dy
> CONFIG_IMA=3Dy
> CONFIG_IMA_WRITE_POLICY=3Dy
> CONFIG_IMA_READ_POLICY=3Dy
>=20
> _./test.sh_
>=20
> IMA_POLICY=3D"/sys/kernel/security/ima/policy"
> TEST_BIN=3D"/bin/date"
> MNT_BASE=3D"/tmp/ima_test_root"
>=20
> mkdir -p "$MNT_BASE"
> mount -t tmpfs tmpfs "$MNT_BASE"
> mkdir -p "$MNT_BASE"/{xfs_disk,upper,work,ovl}
>=20
> dd if=3D/dev/zero of=3D"$MNT_BASE/xfs.img" bs=3D1M count=3D300
> mkfs.xfs -q "$MNT_BASE/xfs.img"
> mount "$MNT_BASE/xfs.img" "$MNT_BASE/xfs_disk"
> cp "$TEST_BIN" "$MNT_BASE/xfs_disk/test_prog"
>=20
> mount -t overlay overlay -o \
> "lowerdir=3D$MNT_BASE/xfs_disk,upperdir=3D$MNT_BASE/upper,workdir=3D$MNT_=
BASE/work" \
> "$MNT_BASE/ovl"
>=20
> echo "audit func=3DBPRM_CHECK uid=3D$(id -u nobody)" > "$IMA_POLICY"
>=20
> target_prog=3D"$MNT_BASE/ovl/test_prog"
> setpriv --reuid nobody "$target_prog"
> setpriv --reuid nobody "$target_prog"
> setpriv --reuid nobody "$target_prog"
>=20
> audit_count=3D$(dmesg | grep -c "file=3D\"$target_prog\"")
>=20
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
> - Link to RFC: https://lore.kernel.org/r/20251229-xfs-ima-fixup-v1-1-6a71=
7c939f7c@cloudflare.com
> ---
>  include/linux/integrity.h         | 42 +++++++++++++++++++++++++++++++++=
++----
>  security/integrity/evm/evm_main.c |  5 ++---
>  security/integrity/ima/ima_api.c  | 11 +++++++---
>  security/integrity/ima/ima_main.c | 15 +++++---------
>  4 files changed, 53 insertions(+), 20 deletions(-)
>=20
> diff --git a/include/linux/integrity.h b/include/linux/integrity.h
> index f5842372359be5341b6870a43b92e695e8fc78af..5eca8aa2769f9238c68bb4088=
5ecc46910524f11 100644
> --- a/include/linux/integrity.h
> +++ b/include/linux/integrity.h
> @@ -9,6 +9,7 @@
> =20
>  #include <linux/fs.h>
>  #include <linux/iversion.h>
> +#include <linux/kernel.h>
> =20
>  enum integrity_status {
>  	INTEGRITY_PASS =3D 0,
> @@ -36,6 +37,14 @@ struct integrity_inode_attributes {
>  	dev_t dev;
>  };
> =20
> +/*
> + * Wrapper to generate an artificial version for a file.
> + */
> +static inline u64 integrity_ctime_guard(struct kstat stat)
> +{
> +	return stat.ctime.tv_sec ^ stat.ctime.tv_nsec;

Unfortunately, we cannot take the risk of a collision. Better use all
or a packed version.

> +}
> +
>  /*
>   * On stacked filesystems the i_version alone is not enough to detect fi=
le data
>   * or metadata change. Additional metadata is required.
> @@ -51,14 +60,39 @@ integrity_inode_attrs_store(struct integrity_inode_at=
tributes *attrs,
> =20
>  /*
>   * On stacked filesystems detect whether the inode or its content has ch=
anged.
> + *
> + * Must be called in process context.
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
> +	might_sleep();
> +
> +	if (inode->i_sb->s_dev !=3D attrs->dev || inode->i_ino !=3D attrs->ino)
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
> +		return stat.change_cookie !=3D attrs->version;
> +
> +	if (stat.result_mask & STATX_CTIME)
> +		return integrity_ctime_guard(stat) !=3D attrs->version;

Yes, switching to the new field I guess it works, but I'm wondering if
we could have more uniformity across the filesystems, otherwise one has
to use one source for filesystem X, another source for filesystem Y.

Thanks

Roberto

> +
> +	return true;
>  }
> =20
> =20
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/e=
vm_main.c
> index 73d500a375cb37a54f295b0e1e93fd6e5d9ecddc..6a4e0e246005246d5700b1db5=
90c1759242b9cb6 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -752,9 +752,8 @@ bool evm_metadata_changed(struct inode *inode, struct=
 inode *metadata_inode)
>  	bool ret =3D false;
> =20
>  	if (iint) {
> -		ret =3D (!IS_I_VERSION(metadata_inode) ||
> -		       integrity_inode_attrs_changed(&iint->metadata_inode,
> -						     metadata_inode));
> +		ret =3D integrity_inode_attrs_changed(&iint->metadata_inode,
> +						    NULL, metadata_inode);
>  		if (ret)
>  			iint->evm_status =3D INTEGRITY_UNKNOWN;
>  	}
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/im=
a_api.c
> index c35ea613c9f8d404ba4886e3b736c3bab29d1668..8096986f3689781d3cdf6595f=
330033782f9cc45 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -272,10 +272,15 @@ int ima_collect_measurement(struct ima_iint_cache *=
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
> +		else if (stat.result_mask & STATX_CTIME)
> +			i_version =3D integrity_ctime_guard(stat);
> +	}
>  	hash.hdr.algo =3D algo;
>  	hash.hdr.length =3D hash_digest_size[algo];
> =20
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index 5770cf691912aa912fc65280c59f5baac35dd725..3a4c32e254f925bba85cb91b6=
3744ac142b3b049 100644
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
> @@ -191,18 +192,13 @@ static void ima_check_last_writer(struct ima_iint_c=
ache *iint,
> =20
>  	mutex_lock(&iint->mutex);
>  	if (atomic_read(&inode->i_writecount) =3D=3D 1) {
> -		struct kstat stat;
> -
>  		clear_bit(IMA_EMITTED_OPENWRITERS, &iint->atomic_flags);
> =20
>  		update =3D test_and_clear_bit(IMA_UPDATE_XATTR,
>  					    &iint->atomic_flags);
>  		if ((iint->flags & IMA_NEW_FILE) ||
> -		    vfs_getattr_nosec(&file->f_path, &stat,
> -				      STATX_CHANGE_COOKIE,
> -				      AT_STATX_SYNC_AS_STAT) ||
> -		    !(stat.result_mask & STATX_CHANGE_COOKIE) ||
> -		    stat.change_cookie !=3D iint->real_inode.version) {
> +		    integrity_inode_attrs_changed(&iint->real_inode, file,
> +						  inode)) {
>  			iint->flags &=3D ~(IMA_DONE_MASK | IMA_NEW_FILE);
>  			iint->measured_pcrs =3D 0;
>  			if (update)
> @@ -328,9 +324,8 @@ static int process_measurement(struct file *file, con=
st struct cred *cred,
>  	real_inode =3D d_real_inode(file_dentry(file));
>  	if (real_inode !=3D inode &&
>  	    (action & IMA_DO_MASK) && (iint->flags & IMA_DONE_MASK)) {
> -		if (!IS_I_VERSION(real_inode) ||
> -		    integrity_inode_attrs_changed(&iint->real_inode,
> -						  real_inode)) {
> +		if (integrity_inode_attrs_changed(&iint->real_inode,
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


