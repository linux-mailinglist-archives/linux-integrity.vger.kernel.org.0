Return-Path: <linux-integrity+bounces-8445-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEB4BsNBg2kPkQMAu9opvQ
	(envelope-from <linux-integrity+bounces-8445-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 04 Feb 2026 13:55:31 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA26E6100
	for <lists+linux-integrity@lfdr.de>; Wed, 04 Feb 2026 13:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 297F23028360
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Feb 2026 12:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBBF3E9F88;
	Wed,  4 Feb 2026 12:49:38 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C69319C566;
	Wed,  4 Feb 2026 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770209378; cv=none; b=NWPKbraQDM/831xfxcFfS+AolPGh/WYgehawWHYSrM8XGNXvShqbZSZq26+iVoktGh7aXh4v1m/xIm/ci3XVMMVLobzQGP9hCYwVzLInBrV5hdz+odD7oWdbSPyLQVtgGRBlaJ9PQ7cwP61PHNzr6Yq6YBpA1Oo3VgrgCx1dasw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770209378; c=relaxed/simple;
	bh=g1vaSMymo8FLy7olTHFi1KE86zDIniJbzr4OSyLwiUY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KIFC2M9uAmL5MfU88i6mx2m+h8YAMSdiVJUWRW+oQvVGWvPZg9TRS+pdFg+an6s9Aqw3xwGQVn7Xda2AtSBOdUQR0yNL3ZwSzHdmRHJUaYOba6+BafrRzO2kKKYqP4uo2wwF3Ou9PhR1Rf3mb9EVdG1sRqg8a3HOJIHv09UVNqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f5fqG1QFGz1HCfm;
	Wed,  4 Feb 2026 20:31:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 82DEF40565;
	Wed,  4 Feb 2026 20:34:22 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAn8WvDPINpdiUyAw--.20311S2;
	Wed, 04 Feb 2026 13:34:21 +0100 (CET)
Message-ID: <9c25c201f384d7320fd83e648d61a0086016ee36.camel@huaweicloud.com>
Subject: Re: [PATCH v5 2/3] ima: Make integrity_inode_attrs_changed() call
 into vfs
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
Date: Wed, 04 Feb 2026 13:34:09 +0100
In-Reply-To: <20260130-xfs-ima-fixup-v5-2-57e84ea91712@cloudflare.com>
References: <20260130-xfs-ima-fixup-v5-0-57e84ea91712@cloudflare.com>
	 <20260130-xfs-ima-fixup-v5-2-57e84ea91712@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwAn8WvDPINpdiUyAw--.20311S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGrykJr15Zw1DXr48XrWUurg_yoWrAw18pF
	9FkFy8Gw18JFyIkF1vy3W7Za1rKa40g3y0g3W5Cw1FyFnrZrnFqr98Cry5CF1rGrZ0kw42
	qan0yry5ua1qy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBGmCux4MWgAAsQ
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8445-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FREEMAIL_TO(0.00)[cloudflare.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,kernel.org,toxicpanda.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.972];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:email,huaweicloud.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CA26E6100
X-Rspamd-Action: no action

On Fri, 2026-01-30 at 16:39 -0600, Frederick Lawler wrote:
> Align integrity_inode_attrs_changed() to ima_check_last_writer()'s
> semantics when detecting changes.
>=20
> For IMA, stacked file systems that do not set kstat.change_cookie,
> integrity_inode_attrs_changed() will compare zero to zero, thus no

I setup overlay with two xfs filesystems, kept the file I want to be
audited in the lower filesystem.

Without this patch set, if I modify the lower file, changes are
detected, because actually the i_version is incremented.

In which situation there is a comparison zero to zero?

Thanks

Roberto

> change detected. This is not dissimilar to what
> ima_check_last_writer() does.
>=20
> No logical change intended for EVM.
>=20
> Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> ---
>  include/linux/integrity.h         | 28 ++++++++++++++++++++++++----
>  security/integrity/evm/evm_main.c |  5 ++---
>  security/integrity/ima/ima_main.c |  5 ++---
>  3 files changed, 28 insertions(+), 10 deletions(-)
>=20
> diff --git a/include/linux/integrity.h b/include/linux/integrity.h
> index beb9ab19fa6257e79266b58bcb5f55b0c5445828..382c783f0fa3ae4a938cdf955=
9291ba1903a378e 100644
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
> @@ -62,14 +63,33 @@ integrity_inode_attrs_stat_changed
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
> +				       STATX_CHANGE_COOKIE,
> +				       AT_STATX_SYNC_AS_STAT))
> +		return !IS_I_VERSION(inode) ||
> +		       !inode_eq_iversion(inode, attrs->version);
> +
> +	return integrity_inode_attrs_stat_changed(attrs, &stat);
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
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index 6570ad10887b9ea1172c78274cf62482350e87ff..8cb17c9d446caaa5a98f5ec8f=
027c17ba7babca8 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -328,9 +328,8 @@ static int process_measurement(struct file *file, con=
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


