Return-Path: <linux-integrity+bounces-8446-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALj3LFVGg2nqkgMAu9opvQ
	(envelope-from <linux-integrity+bounces-8446-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 04 Feb 2026 14:15:01 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1630CE6447
	for <lists+linux-integrity@lfdr.de>; Wed, 04 Feb 2026 14:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A6503046B9E
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Feb 2026 13:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84333EDABD;
	Wed,  4 Feb 2026 13:09:35 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5213D5223;
	Wed,  4 Feb 2026 13:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770210575; cv=none; b=hMjaeh0cceRXSmiYsL1HjCw6b5UO6DBja6VwoyZdCayzTS41DiaaFC8Ua8GwkzGiE52EH9e8YVs0ua3rvKxupqJEpAdnQvFWI07kwaYfMp4pRRDNRSKsVgPviMx91neZcaOcgAxbm9BwqiiUV+psxHJEDb968f78Amta9wsyqRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770210575; c=relaxed/simple;
	bh=QedXh/Z8LWUeFoC+cwUx3QkVa6ENN9IAYxpzg4ogkVQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uiwJZPg7DENjzGm9MoKNX2C4jmHEgwlcTIpdbI07m1ge1zrz4i03ZTku9EYUz8qeeRw4A1XsEbA6REsAfFXXkWlD8dh3lsbUM6iC50pwpyqlcCxdtiBQZrLfFiyycO6UlHHD4KdcE+xBFKRQjn/Bx6oBRdML5VaE9HxIkLepe6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4f5gB252WtzpV7X;
	Wed,  4 Feb 2026 20:47:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 072EE40565;
	Wed,  4 Feb 2026 20:50:41 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCn4wWYQINp8ZM2Aw--.40514S2;
	Wed, 04 Feb 2026 13:50:40 +0100 (CET)
Message-ID: <d1d63c522a3842ccaf74c4462ee06bf82ce3b3f5.camel@huaweicloud.com>
Subject: Re: [PATCH] evm: check return values of crypto_shash functions
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Daniel Hodges <hodgesd@meta.com>, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com
Cc: dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
 paul@paul-moore.com,  jmorris@namei.org, serge@hallyn.com,
 linux-integrity@vger.kernel.org,  linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 04 Feb 2026 13:50:29 +0100
In-Reply-To: <20260131182233.2365157-1-hodgesd@meta.com>
References: <20260131182233.2365157-1-hodgesd@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwCn4wWYQINp8ZM2Aw--.40514S2
X-Coremail-Antispam: 1UD129KBjvJXoW3ArW5CF43GFyDur1DWFy5XFb_yoWxtw1rpF
	W5GayDKrn8JF4UGFZaya18Z34S9ay0yr17trWUu34FvFnrWr1IqrWIkw18uFyrCrWDJr1Y
	qF4xKwnruw4aq3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOB
	MKDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAOBGmCuxkM6wAAsl
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8446-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1630CE6447
X-Rspamd-Action: no action

On Sat, 2026-01-31 at 10:22 -0800, Daniel Hodges wrote:
> The crypto_shash_update() and crypto_shash_final() functions can fail
> and return error codes, but their return values were being ignored in
> several places in evm_crypto.c:
>=20
>   - hmac_add_misc(): ignores returns from crypto_shash_update() and
>     crypto_shash_final()
>   - evm_calc_hmac_or_hash(): ignores returns from crypto_shash_update()
>   - evm_init_hmac(): ignores returns from crypto_shash_update()
>=20
> If these hash operations fail silently, the resulting HMAC could be
> invalid or incomplete. This could potentially allow integrity
> verification to pass with incorrect HMACs, weakening EVM's security
> guarantees.
>=20
> Fix this by:
>   - Changing hmac_add_misc() from void to int return type
>   - Checking and propagating error codes from all crypto_shash calls
>   - Updating all callers to check the return values
>=20
> Fixes: 66dbc325afce ("evm: re-release")
> Signed-off-by: Daniel Hodges <hodgesd@meta.com>
> ---
>  security/integrity/evm/evm_crypto.c | 45 +++++++++++++++++++----------
>  1 file changed, 30 insertions(+), 15 deletions(-)
>=20
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm=
/evm_crypto.c
> index a5e730ffda57..286f23a1a26b 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -132,58 +132,65 @@ static struct shash_desc *init_desc(char type, uint=
8_t hash_algo)
>  	}
>  	return desc;
>  }
> =20
>  /* Protect against 'cutting & pasting' security.evm xattr, include inode
>   * specific info.
>   *
>   * (Additional directory/file metadata needs to be added for more comple=
te
>   * protection.)
>   */
> -static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
> -			  char type, char *digest)
> +static int hmac_add_misc(struct shash_desc *desc, struct inode *inode,
> +			 char type, char *digest)
>  {
>  	struct h_misc {
>  		unsigned long ino;
>  		__u32 generation;
>  		uid_t uid;
>  		gid_t gid;
>  		umode_t mode;
>  	} hmac_misc;
> +	int ret;
> =20
>  	memset(&hmac_misc, 0, sizeof(hmac_misc));
>  	/* Don't include the inode or generation number in portable
>  	 * signatures
>  	 */
>  	if (type !=3D EVM_XATTR_PORTABLE_DIGSIG) {
>  		hmac_misc.ino =3D inode->i_ino;
>  		hmac_misc.generation =3D inode->i_generation;
>  	}
>  	/* The hmac uid and gid must be encoded in the initial user
>  	 * namespace (not the filesystems user namespace) as encoding
>  	 * them in the filesystems user namespace allows an attack
>  	 * where first they are written in an unprivileged fuse mount
>  	 * of a filesystem and then the system is tricked to mount the
>  	 * filesystem for real on next boot and trust it because
>  	 * everything is signed.
>  	 */
>  	hmac_misc.uid =3D from_kuid(&init_user_ns, inode->i_uid);
>  	hmac_misc.gid =3D from_kgid(&init_user_ns, inode->i_gid);
>  	hmac_misc.mode =3D inode->i_mode;
> -	crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac_misc));
> +	ret =3D crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac_m=
isc));
> +	if (ret)
> +		return ret;
>  	if ((evm_hmac_attrs & EVM_ATTR_FSUUID) &&
> -	    type !=3D EVM_XATTR_PORTABLE_DIGSIG)
> -		crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid, UUID_SIZE);
> -	crypto_shash_final(desc, digest);
> +	    type !=3D EVM_XATTR_PORTABLE_DIGSIG) {
> +		ret =3D crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid, UUID_SIZ=
E);
> +		if (ret)
> +			return ret;
> +	}
> +	ret =3D crypto_shash_final(desc, digest);

Maybe we should also indicate if an error occurred, with a separate
error message, or adding the result in the message below.

Thanks

Roberto
=20
>  	pr_debug("hmac_misc: (%zu) [%*phN]\n", sizeof(struct h_misc),
>  		 (int)sizeof(struct h_misc), &hmac_misc);
> +	return ret;
>  }
> =20
>  /*
>   * Dump large security xattr values as a continuous ascii hexadecimal st=
ring.
>   * (pr_debug is limited to 64 bytes.)
>   */
>  static void dump_security_xattr_l(const char *prefix, const void *src,
>  				  size_t count)
>  {
>  #if defined(DEBUG) || defined(CONFIG_DYNAMIC_DEBUG)
> @@ -253,23 +260,24 @@ static int evm_calc_hmac_or_hash(struct dentry *den=
try,
> =20
>  		/*
>  		 * Skip non-enabled xattrs for locally calculated
>  		 * signatures/HMACs.
>  		 */
>  		if (type !=3D EVM_XATTR_PORTABLE_DIGSIG && !xattr->enabled)
>  			continue;
> =20
>  		if ((req_xattr_name && req_xattr_value)
>  		    && !strcmp(xattr->name, req_xattr_name)) {
> -			error =3D 0;
> -			crypto_shash_update(desc, (const u8 *)req_xattr_value,
> -					     req_xattr_value_len);
> +			error =3D crypto_shash_update(desc, (const u8 *)req_xattr_value,
> +						    req_xattr_value_len);
> +			if (error)
> +				goto out;
>  			if (is_ima)
>  				ima_present =3D true;
> =20
>  			dump_security_xattr(req_xattr_name,
>  					    req_xattr_value,
>  					    req_xattr_value_len);
>  			continue;
>  		}
>  		size =3D vfs_getxattr_alloc(&nop_mnt_idmap, dentry, xattr->name,
>  					  &xattr_value, xattr_size, GFP_NOFS);
> @@ -279,29 +287,32 @@ static int evm_calc_hmac_or_hash(struct dentry *den=
try,
>  		}
>  		if (size < 0)
>  			continue;
> =20
>  		user_space_size =3D vfs_getxattr(&nop_mnt_idmap, dentry,
>  					       xattr->name, NULL, 0);
>  		if (user_space_size !=3D size)
>  			pr_debug("file %s: xattr %s size mismatch (kernel: %d, user: %d)\n",
>  				 dentry->d_name.name, xattr->name, size,
>  				 user_space_size);
> -		error =3D 0;
>  		xattr_size =3D size;
> -		crypto_shash_update(desc, (const u8 *)xattr_value, xattr_size);
> +		error =3D crypto_shash_update(desc, (const u8 *)xattr_value, xattr_siz=
e);
> +		if (error)
> +			goto out;
>  		if (is_ima)
>  			ima_present =3D true;
> =20
>  		dump_security_xattr(xattr->name, xattr_value, xattr_size);
>  	}
> -	hmac_add_misc(desc, inode, type, data->digest);
> +	error =3D hmac_add_misc(desc, inode, type, data->digest);
> +	if (error)
> +		goto out;
> =20
>  	if (inode !=3D d_backing_inode(dentry) && iint) {
>  		if (IS_I_VERSION(inode))
>  			i_version =3D inode_query_iversion(inode);
>  		integrity_inode_attrs_store(&iint->metadata_inode, i_version,
>  					    inode);
>  	}
> =20
>  	/* Portable EVM signatures must include an IMA hash */
>  	if (type =3D=3D EVM_XATTR_PORTABLE_DIGSIG && !ima_present)
> @@ -394,37 +405,41 @@ int evm_update_evmxattr(struct dentry *dentry, cons=
t char *xattr_name,
>  		rc =3D __vfs_removexattr(&nop_mnt_idmap, dentry, XATTR_NAME_EVM);
>  	}
>  	return rc;
>  }
> =20
>  int evm_init_hmac(struct inode *inode, const struct xattr *xattrs,
>  		  char *hmac_val)
>  {
>  	struct shash_desc *desc;
>  	const struct xattr *xattr;
> +	int ret;
> =20
>  	desc =3D init_desc(EVM_XATTR_HMAC, HASH_ALGO_SHA1);
>  	if (IS_ERR(desc)) {
>  		pr_info("init_desc failed\n");
>  		return PTR_ERR(desc);
>  	}
> =20
>  	for (xattr =3D xattrs; xattr->name; xattr++) {
>  		if (!evm_protected_xattr(xattr->name))
>  			continue;
> =20
> -		crypto_shash_update(desc, xattr->value, xattr->value_len);
> +		ret =3D crypto_shash_update(desc, xattr->value, xattr->value_len);
> +		if (ret)
> +			goto out;
>  	}
> =20
> -	hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
> +	ret =3D hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
> +out:
>  	kfree(desc);
> -	return 0;
> +	return ret;
>  }
> =20
>  /*
>   * Get the key from the TPM for the SHA1-HMAC
>   */
>  int evm_init_key(void)
>  {
>  	struct key *evm_key;
>  	struct encrypted_key_payload *ekp;
>  	int rc;


