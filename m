Return-Path: <linux-integrity+bounces-8292-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gO1DK7n1cWmvZwAAu9opvQ
	(envelope-from <linux-integrity+bounces-8292-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Jan 2026 11:02:33 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCF664F45
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Jan 2026 11:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BA3F84A8B3
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Jan 2026 09:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7855B3D3CE4;
	Thu, 22 Jan 2026 09:52:35 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C352346A04;
	Thu, 22 Jan 2026 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769075554; cv=none; b=LiWWxp8cX8EgAfWfC7KdkMr3BuNlGm5PjH1pMgjt8qXXKqI5jrud1D3+PyX3hcK9vvtQL8CwvV+eU87JcKioDR8cQHdAK/hQ7xLEFDA5BJGqjg+7Mg03mpC0tmn86Ou/DXZ7bSRoJAGuUENJ8e1R5REDdYr/4T8QrZ6WZXfZBPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769075554; c=relaxed/simple;
	bh=MdqN7K787ge452ie2U+35WLZ4A1AcHcak00AWYVNxuw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iTWeGqajjkw7ixxyAMIGa03/tJuCqSuiyQhfXoQ3/J+NGJeaF/w3FHYrzlvSmVFNV06S15+LGe34e9HAMm7HrP5+kLqCeXXZEqZxXJ7wmiOGVUs5MJKE9HQeym9Sx0kcT7SZ1BlVQuX4ETUk0qBnA+EOHtnfkt0asypRPsy2c8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4dxbrb0zSTzpTs1;
	Thu, 22 Jan 2026 17:49:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 57E944009B;
	Thu, 22 Jan 2026 17:52:21 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwBHhAZG83FpkZRrAg--.29849S2;
	Thu, 22 Jan 2026 10:52:20 +0100 (CET)
Message-ID: <fc0f5dd0fe6a7c55e76e58913a7794574705dcd6.camel@huaweicloud.com>
Subject: Re: [PATCH v2] ima: Fallback to ctime check for FS without
 kstat.change_cookie
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
Date: Thu, 22 Jan 2026 10:52:04 +0100
In-Reply-To: <20260120-xfs-ima-fixup-v2-1-f332ead8b043@cloudflare.com>
References: <20260120-xfs-ima-fixup-v2-1-f332ead8b043@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwBHhAZG83FpkZRrAg--.29849S2
X-Coremail-Antispam: 1UD129KBjvAXoWfGr47XrWkKrykGFyxKF13twb_yoW8Gr1DCo
	WftanxCr4rGr13Ca1Ik3W7AF97W3y3Gw4fJ345Xw4DG3W2yFyDC3yYvF45Xa17Xw4rXr1D
	J3s3G3WUZFWktas5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY77kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	aFAJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQABBGlxl5gOFQABsJ
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[cloudflare.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,kernel.org,toxicpanda.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8292-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,huaweicloud.com:mid]
X-Rspamd-Queue-Id: 4CCF664F45
X-Rspamd-Action: no action

On Tue, 2026-01-20 at 14:20 -0600, Frederick Lawler wrote:
> Commit 1cf7e834a6fb ("xfs: switch to multigrain timestamps")
> introduced a means to track change detection for an inode
> via ctime updates, opposed to setting kstat.change_cookie to
> an i_version when calling into xfs_vn_getattr().
>=20
> This introduced a regression for IMA such that an action
> performed on a LOWER inode on a stacked file systems always
> requires a re-evaluation if the LOWER file system does not
> leverage kstat.change_cookie to track inode i_version or lacks
> i_version support all together.
>=20
> In the case of stacking XFS on XFS, an action on either the LOWER or UPPE=
R
> will require re-evaluation. Stacking TPMFS on XFS for instance, once the
> inode is UPPER is mutated, IMA resumes normal behavior because TMPFS
> leverages generic_fillattr() to update the change cookie.
>=20
> This is because IMA caches kstat.change_cookie to compare against an
> inode's i_version directly in integrity_inode_attrs_changed(), and thus
> could be out of date depending on how file systems set
> kstat.change_cookie.
>=20
> To address this, require integrity_inode_attrs_changed() to query
> vfs_getattr_nosec() to compare the cached version against
> kstat.change_cookie directly. This ensures that when updates occur,
> we're accessing the same changed inode version on changes, and fallback
> to compare against kstat.ctime when STATX_CHANGE_COOKIE is missing from
> result mask.
>=20
> Lastly, because EVM still relies on querying and caching a inode's
> i_version directly, the integrity_inode_attrs_changed() falls back to the
> original inode.i_version !=3D cached comparison.
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
> Changes in v2:
> - Updated commit description + message to clarify the problem.
> - compare struct timespec64 to avoid collision possibility [Roberto].
> - Don't check inode_attr_changed() in ima_check_last_writer()
> - Link to v1: https://lore.kernel.org/r/20260112-xfs-ima-fixup-v1-1-8d13b=
6001312@cloudflare.com
> ---
>  include/linux/integrity.h           | 40 +++++++++++++++++++++++++++++++=
+-----
>  security/integrity/evm/evm_crypto.c |  4 +++-
>  security/integrity/evm/evm_main.c   |  5 ++---
>  security/integrity/ima/ima_api.c    | 20 +++++++++++++------
>  security/integrity/ima/ima_main.c   | 18 ++++++++++-------
>  5 files changed, 65 insertions(+), 22 deletions(-)
>=20
> diff --git a/include/linux/integrity.h b/include/linux/integrity.h
> index f5842372359be5341b6870a43b92e695e8fc78af..46f57402b790c9c275b85f0b3=
0819fa196fc20c7 100644
> --- a/include/linux/integrity.h
> +++ b/include/linux/integrity.h
> @@ -9,6 +9,8 @@
> =20
>  #include <linux/fs.h>
>  #include <linux/iversion.h>
> +#include <linux/kernel.h>
> +#include <linux/time64.h>
> =20
>  enum integrity_status {
>  	INTEGRITY_PASS =3D 0,
> @@ -31,6 +33,7 @@ static inline void integrity_load_keys(void)
> =20
>  /* An inode's attributes for detection of changes */
>  struct integrity_inode_attributes {
> +	struct timespec64 ctime;

I found the helper timespec64_to_ns(), I think it would be better for
memory occupation perspective to fit in the version field.

Thanks

Roberto

>  	u64 version;		/* track inode changes */
>  	unsigned long ino;
>  	dev_t dev;
> @@ -42,8 +45,10 @@ struct integrity_inode_attributes {
>   */
>  static inline void
>  integrity_inode_attrs_store(struct integrity_inode_attributes *attrs,
> -			    u64 i_version, const struct inode *inode)
> +			    u64 i_version, struct timespec64 ctime,
> +			    const struct inode *inode)
>  {
> +	attrs->ctime =3D ctime;
>  	attrs->version =3D i_version;
>  	attrs->dev =3D inode->i_sb->s_dev;
>  	attrs->ino =3D inode->i_ino;
> @@ -51,14 +56,39 @@ integrity_inode_attrs_store(struct integrity_inode_at=
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
> +		return !timespec64_equal(&stat.ctime, &attrs->ctime);
> +
> +	return true;
>  }
> =20
> =20
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm=
/evm_crypto.c
> index a5e730ffda57fbc0a91124adaa77b946a12d08b4..361ee7b216247a0d6d2f518e8=
2fb6e92dc355afe 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -297,10 +297,12 @@ static int evm_calc_hmac_or_hash(struct dentry *den=
try,
>  	hmac_add_misc(desc, inode, type, data->digest);
> =20
>  	if (inode !=3D d_backing_inode(dentry) && iint) {
> +		struct timespec64 ctime =3D {0};
> +
>  		if (IS_I_VERSION(inode))
>  			i_version =3D inode_query_iversion(inode);
>  		integrity_inode_attrs_store(&iint->metadata_inode, i_version,
> -					    inode);
> +					    ctime, inode);
>  	}
> =20
>  	/* Portable EVM signatures must include an IMA hash */
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
> index c35ea613c9f8d404ba4886e3b736c3bab29d1668..0d8e0a3ebd34b70bb1b4cc995=
aae5d4adc90a585 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -254,6 +254,7 @@ int ima_collect_measurement(struct ima_iint_cache *ii=
nt, struct file *file,
>  	int length;
>  	void *tmpbuf;
>  	u64 i_version =3D 0;
> +	struct timespec64 ctime =3D {0};
> =20
>  	/*
>  	 * Always collect the modsig, because IMA might have already collected
> @@ -272,10 +273,15 @@ int ima_collect_measurement(struct ima_iint_cache *=
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
> +		if (stat.result_mask & STATX_CTIME)
> +			ctime =3D stat.ctime;
> +	}
>  	hash.hdr.algo =3D algo;
>  	hash.hdr.length =3D hash_digest_size[algo];
> =20
> @@ -305,11 +311,13 @@ int ima_collect_measurement(struct ima_iint_cache *=
iint, struct file *file,
> =20
>  	iint->ima_hash =3D tmpbuf;
>  	memcpy(iint->ima_hash, &hash, length);
> -	if (real_inode =3D=3D inode)
> +	if (real_inode =3D=3D inode) {
>  		iint->real_inode.version =3D i_version;
> -	else
> +		iint->real_inode.ctime =3D ctime;
> +	} else {
>  		integrity_inode_attrs_store(&iint->real_inode, i_version,
> -					    real_inode);
> +					    ctime, real_inode);
> +	}
> =20
>  	/* Possibly temporary failure due to type of read (eg. O_DIRECT) */
>  	if (!result)
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index 5770cf691912aa912fc65280c59f5baac35dd725..54b638663c9743d39e5fb6571=
1dbd9698b38e39b 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -22,12 +22,14 @@
>  #include <linux/mount.h>
>  #include <linux/mman.h>
>  #include <linux/slab.h>
> +#include <linux/stat.h>
>  #include <linux/xattr.h>
>  #include <linux/ima.h>
>  #include <linux/fs.h>
>  #include <linux/iversion.h>
>  #include <linux/evm.h>
>  #include <linux/crash_dump.h>
> +#include <linux/time64.h>
> =20
>  #include "ima.h"
> =20
> @@ -199,10 +201,13 @@ static void ima_check_last_writer(struct ima_iint_c=
ache *iint,
>  					    &iint->atomic_flags);
>  		if ((iint->flags & IMA_NEW_FILE) ||
>  		    vfs_getattr_nosec(&file->f_path, &stat,
> -				      STATX_CHANGE_COOKIE,
> -				      AT_STATX_SYNC_AS_STAT) ||
> -		    !(stat.result_mask & STATX_CHANGE_COOKIE) ||
> -		    stat.change_cookie !=3D iint->real_inode.version) {
> +			    STATX_CHANGE_COOKIE | STATX_CTIME,
> +			    AT_STATX_SYNC_AS_STAT) ||
> +		    ((stat.result_mask & STATX_CHANGE_COOKIE) ?
> +		      stat.change_cookie !=3D iint->real_inode.version :
> +		      (!(stat.result_mask & STATX_CTIME) ||
> +			!timespec64_equal(&stat.ctime,
> +					  &iint->real_inode.ctime)))) {
>  			iint->flags &=3D ~(IMA_DONE_MASK | IMA_NEW_FILE);
>  			iint->measured_pcrs =3D 0;
>  			if (update)
> @@ -328,9 +333,8 @@ static int process_measurement(struct file *file, con=
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


