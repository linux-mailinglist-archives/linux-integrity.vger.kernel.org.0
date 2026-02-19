Return-Path: <linux-integrity+bounces-8519-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANyvN//blmlJpgIAu9opvQ
	(envelope-from <linux-integrity+bounces-8519-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Feb 2026 10:46:39 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F6215D7D7
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Feb 2026 10:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 653A43068F20
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Feb 2026 09:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6BF32572F;
	Thu, 19 Feb 2026 09:43:48 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773AB31AA96;
	Thu, 19 Feb 2026 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771494228; cv=none; b=EYm5gb5Ocf3Kb2wh9pfCSGHnkBj+AIp8/yTiTSLlHMXUDQCTh2udt3UZ3fyb5H6YGb16IM0GZducB/w4hk0C7Mq3npBdRt9vgszpH9enmVxFiJ7wLiKVkM1xWFvaaKiU5W8OCFASVB8wIbsBelTH1Ys5DWMFSuy/paii+Z+EBPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771494228; c=relaxed/simple;
	bh=5Kcto6AIU9mpMc8kIi5u4AbxNEjcqCzjVbfYEcEIOa0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oI+2f6R3694itomIKYHsOxXbsTpmHVldbRniWJJI7x1g7FdFTB7zOg7g14C4k18Vj/OT80l/xsvRYzl/uLsoOa2E7Ke7TaqVgGbalvq18b0wzLF7PFc7mNtqg3zUwCRHw7la+bhTa3bUn9OxFMH3fiFZpEOU4xIxC//KRxtCMt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4fGnxM5TSczpV1t;
	Thu, 19 Feb 2026 17:23:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 5CC4E40570;
	Thu, 19 Feb 2026 17:26:40 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDHUANH15Zp8FYbBA--.26910S2;
	Thu, 19 Feb 2026 10:26:39 +0100 (CET)
Message-ID: <6ce273a26b396232f3ee64a980575562e766c501.camel@huaweicloud.com>
Subject: Re: [PATCH v2 v2] evm: check return values of crypto_shash functions
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Daniel Hodges <git@danielhodges.dev>
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
 dmitry.kasatkin@gmail.com,  eric.snowberg@oracle.com, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com,  linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Thu, 19 Feb 2026 10:26:29 +0100
In-Reply-To: <20260206024240.19059-1-git@danielhodges.dev>
References: <aYNprpzxppKE0Gf2@fb.com>
	 <20260206024240.19059-1-git@danielhodges.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDHUANH15Zp8FYbBA--.26910S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKr1rZr1rGrykAryDCr1xZrb_yoW7uFy8pF
	W5WayDKrWDJF4UWF9ayan5Z34F9ay0yF42kry8W34IyFn7Xr1IqF4Ikw18uF98Gr1DJw1Y
	qa1I9w1Duw4aq3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAJBGmWgZ8GEAAAs4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8519-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DMARC_NA(0.00)[huaweicloud.com];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:mid]
X-Rspamd-Queue-Id: 35F6215D7D7
X-Rspamd-Action: no action

On Thu, 2026-02-05 at 21:42 -0500, Daniel Hodges wrote:
> The crypto_shash_update() and crypto_shash_final() functions can fail
> and return error codes, but their return values were not being checked
> in several places in security/integrity/evm/evm_crypto.c:
>=20
> - hmac_add_misc() ignored returns from crypto_shash_update() and
>   crypto_shash_final()
> - evm_calc_hmac_or_hash() ignored returns from crypto_shash_update()
> - evm_init_hmac() ignored returns from crypto_shash_update()
>=20
> If these hash operations fail silently, the resulting HMAC could be
> invalid or incomplete, which could weaken the integrity verification
> security that EVM provides.
>=20
> This patch converts hmac_add_misc() from void to int return type and
> adds proper error checking and propagation for all crypto_shash_*
> function calls. All callers are updated to handle the new return values.
> Additionally, error messages are logged when cryptographic operations
> fail to provide visibility into the failure rather than silently
> returning error codes.
>=20
> Fixes: 66dbc325afce ("evm: re-release")
> Signed-off-by: Daniel Hodges <git@danielhodges.dev>

After fixing the minor issue below:

Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

> ---
>  security/integrity/evm/evm_crypto.c | 55 ++++++++++++++++++++++-------
>  1 file changed, 42 insertions(+), 13 deletions(-)
>=20
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm=
/evm_crypto.c
> index a5e730ffda57..402eb1ca64ce 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -139,7 +139,7 @@ static struct shash_desc *init_desc(char type, uint8_=
t hash_algo)
>   * (Additional directory/file metadata needs to be added for more comple=
te
>   * protection.)
>   */
> -static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
> +static int hmac_add_misc(struct shash_desc *desc, struct inode *inode,
>  			  char type, char *digest)
>  {
>  	struct h_misc {
> @@ -149,6 +149,7 @@ static void hmac_add_misc(struct shash_desc *desc, st=
ruct inode *inode,
>  		gid_t gid;
>  		umode_t mode;
>  	} hmac_misc;
> +	int error;
> =20
>  	memset(&hmac_misc, 0, sizeof(hmac_misc));
>  	/* Don't include the inode or generation number in portable
> @@ -169,14 +170,28 @@ static void hmac_add_misc(struct shash_desc *desc, =
struct inode *inode,
>  	hmac_misc.uid =3D from_kuid(&init_user_ns, inode->i_uid);
>  	hmac_misc.gid =3D from_kgid(&init_user_ns, inode->i_gid);
>  	hmac_misc.mode =3D inode->i_mode;
> -	crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac_misc));
> +	error =3D crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac=
_misc));
> +	if (error) {
> +		pr_err("crypto_shash_update() failed: %d\n", error);
> +		return error;
> +	}
>  	if ((evm_hmac_attrs & EVM_ATTR_FSUUID) &&
> -	    type !=3D EVM_XATTR_PORTABLE_DIGSIG)
> -		crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid, UUID_SIZE);
> -	crypto_shash_final(desc, digest);
> +	    type !=3D EVM_XATTR_PORTABLE_DIGSIG) {
> +		error =3D crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid, UUID_S=
IZE);
> +		if (error) {
> +			pr_err("crypto_shash_update() failed: %d\n", error);
> +			return error;
> +		}
> +	}
> +	error =3D crypto_shash_final(desc, digest);
> +	if (error) {
> +		pr_err("crypto_shash_final() failed: %d\n", error);
> +		return error;
> +	}
> =20
>  	pr_debug("hmac_misc: (%zu) [%*phN]\n", sizeof(struct h_misc),
>  		 (int)sizeof(struct h_misc), &hmac_misc);
> +	return 0;
>  }
> =20
>  /*
> @@ -260,9 +275,12 @@ static int evm_calc_hmac_or_hash(struct dentry *dent=
ry,
> =20
>  		if ((req_xattr_name && req_xattr_value)
>  		    && !strcmp(xattr->name, req_xattr_name)) {
> -			error =3D 0;
> -			crypto_shash_update(desc, (const u8 *)req_xattr_value,
> +			error =3D crypto_shash_update(desc, (const u8 *)req_xattr_value,
>  					     req_xattr_value_len);

Please align this.

Thanks

Roberto

> +			if (error) {
> +				pr_err("crypto_shash_update() failed: %d\n", error);
> +				goto out;
> +			}
>  			if (is_ima)
>  				ima_present =3D true;
> =20
> @@ -286,15 +304,20 @@ static int evm_calc_hmac_or_hash(struct dentry *den=
try,
>  			pr_debug("file %s: xattr %s size mismatch (kernel: %d, user: %d)\n",
>  				 dentry->d_name.name, xattr->name, size,
>  				 user_space_size);
> -		error =3D 0;
>  		xattr_size =3D size;
> -		crypto_shash_update(desc, (const u8 *)xattr_value, xattr_size);
> +		error =3D crypto_shash_update(desc, (const u8 *)xattr_value, xattr_siz=
e);
> +		if (error) {
> +			pr_err("crypto_shash_update() failed: %d\n", error);
> +			goto out;
> +		}
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
> @@ -401,6 +424,7 @@ int evm_init_hmac(struct inode *inode, const struct x=
attr *xattrs,
>  {
>  	struct shash_desc *desc;
>  	const struct xattr *xattr;
> +	int error;
> =20
>  	desc =3D init_desc(EVM_XATTR_HMAC, HASH_ALGO_SHA1);
>  	if (IS_ERR(desc)) {
> @@ -412,12 +436,17 @@ int evm_init_hmac(struct inode *inode, const struct=
 xattr *xattrs,
>  		if (!evm_protected_xattr(xattr->name))
>  			continue;
> =20
> -		crypto_shash_update(desc, xattr->value, xattr->value_len);
> +		error =3D crypto_shash_update(desc, xattr->value, xattr->value_len);
> +		if (error) {
> +			pr_err("crypto_shash_update() failed: %d\n", error);
> +			goto out;
> +		}
>  	}
> =20
> -	hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
> +	error =3D hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
> +out:
>  	kfree(desc);
> -	return 0;
> +	return error;
>  }
> =20
>  /*


