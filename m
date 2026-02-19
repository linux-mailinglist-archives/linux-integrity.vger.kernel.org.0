Return-Path: <linux-integrity+bounces-8520-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBIEBd0Hl2lmtwIAu9opvQ
	(envelope-from <linux-integrity+bounces-8520-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Feb 2026 13:53:49 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7572515EC57
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Feb 2026 13:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DFA1302CD23
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Feb 2026 12:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FCA33A9D1;
	Thu, 19 Feb 2026 12:53:39 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AD9339870;
	Thu, 19 Feb 2026 12:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771505619; cv=none; b=Slh4P4V6w4ecLT9tFY0X17idAeKExZTyoX/RSJSrorK2DymSHrWKk1wMO3T6o2azsIjh81sR6FjAZLI19t7i69Xw4phh6zJ8lMulPzR0R2iubeEyOAhcKKgSJjwFNOBxZ36InreYp3oA6FEXc1Y5aFkKEdW7I5Q3Tga8Md3IXFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771505619; c=relaxed/simple;
	bh=u55ozhuDE3TvvlswohoaCws7cTMoUmej3a3xQzcUFy0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aWdDJ29OxUi0zFO6Cf+iSIGLYb4f56z71ChndrFbWcRQSMk1kCw545y20c7IBvexvymdJ3Kro+XX5mCsUjM/DnqqvenukEpUf6R7cKpunZ2kGykW07bZdN4yTSkNEWGDNCCXV6uqqkb+pKgR5IpM+Qf6gqCzjEmsk41SUfdRlN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fGt8z1tHKzsZj3;
	Thu, 19 Feb 2026 20:33:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id EAF8640568;
	Thu, 19 Feb 2026 20:36:50 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCX0wXaA5dpOmkdBA--.54558S2;
	Thu, 19 Feb 2026 13:36:50 +0100 (CET)
Message-ID: <cfbd9e3c63e03500279198ec7a80ba009dfccc63.camel@huaweicloud.com>
Subject: Re: [PATCH v2 v2] evm: check return values of crypto_shash functions
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Daniel Hodges <git@danielhodges.dev>
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
 dmitry.kasatkin@gmail.com,  eric.snowberg@oracle.com, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com,  linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Thu, 19 Feb 2026 13:36:39 +0100
In-Reply-To: <6ce273a26b396232f3ee64a980575562e766c501.camel@huaweicloud.com>
References: <aYNprpzxppKE0Gf2@fb.com>
	 <20260206024240.19059-1-git@danielhodges.dev>
	 <6ce273a26b396232f3ee64a980575562e766c501.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwCX0wXaA5dpOmkdBA--.54558S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtr1DGrWkWryUur1kKw1ftFb_yoWxGw17pF
	Z8WayDKrWDJFWUCF9aya1kZ34F9ay0yF1IyrW8W34IyFn2vr1IqFWIkw18uF98Cr4UGw1F
	qr4xKwnruw4Sv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAJBGmWgZsJ3QABs8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8520-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DMARC_NA(0.00)[huaweicloud.com];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:mid,huawei.com:email,danielhodges.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7572515EC57
X-Rspamd-Action: no action

On Thu, 2026-02-19 at 10:26 +0100, Roberto Sassu wrote:
> On Thu, 2026-02-05 at 21:42 -0500, Daniel Hodges wrote:
> > The crypto_shash_update() and crypto_shash_final() functions can fail
> > and return error codes, but their return values were not being checked
> > in several places in security/integrity/evm/evm_crypto.c:
> >=20
> > - hmac_add_misc() ignored returns from crypto_shash_update() and
> >   crypto_shash_final()
> > - evm_calc_hmac_or_hash() ignored returns from crypto_shash_update()
> > - evm_init_hmac() ignored returns from crypto_shash_update()
> >=20
> > If these hash operations fail silently, the resulting HMAC could be
> > invalid or incomplete, which could weaken the integrity verification
> > security that EVM provides.
> >=20
> > This patch converts hmac_add_misc() from void to int return type and
> > adds proper error checking and propagation for all crypto_shash_*
> > function calls. All callers are updated to handle the new return values=
.
> > Additionally, error messages are logged when cryptographic operations
> > fail to provide visibility into the failure rather than silently
> > returning error codes.
> >=20
> > Fixes: 66dbc325afce ("evm: re-release")
> > Signed-off-by: Daniel Hodges <git@danielhodges.dev>
>=20
> After fixing the minor issue below:

Already did it. The patch is here (after fixing a conflict with
0496fc9cdc38 "evm: Use ordered xattrs list to calculate HMAC in
evm_init_hmac()"):

https://github.com/robertosassu/linux/commit/d5aba42198b602c6de002ef02a4e6c=
c1d75652d7

Roberto

> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> > ---
> >  security/integrity/evm/evm_crypto.c | 55 ++++++++++++++++++++++-------
> >  1 file changed, 42 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/e=
vm/evm_crypto.c
> > index a5e730ffda57..402eb1ca64ce 100644
> > --- a/security/integrity/evm/evm_crypto.c
> > +++ b/security/integrity/evm/evm_crypto.c
> > @@ -139,7 +139,7 @@ static struct shash_desc *init_desc(char type, uint=
8_t hash_algo)
> >   * (Additional directory/file metadata needs to be added for more comp=
lete
> >   * protection.)
> >   */
> > -static void hmac_add_misc(struct shash_desc *desc, struct inode *inode=
,
> > +static int hmac_add_misc(struct shash_desc *desc, struct inode *inode,
> >  			  char type, char *digest)
> >  {
> >  	struct h_misc {
> > @@ -149,6 +149,7 @@ static void hmac_add_misc(struct shash_desc *desc, =
struct inode *inode,
> >  		gid_t gid;
> >  		umode_t mode;
> >  	} hmac_misc;
> > +	int error;
> > =20
> >  	memset(&hmac_misc, 0, sizeof(hmac_misc));
> >  	/* Don't include the inode or generation number in portable
> > @@ -169,14 +170,28 @@ static void hmac_add_misc(struct shash_desc *desc=
, struct inode *inode,
> >  	hmac_misc.uid =3D from_kuid(&init_user_ns, inode->i_uid);
> >  	hmac_misc.gid =3D from_kgid(&init_user_ns, inode->i_gid);
> >  	hmac_misc.mode =3D inode->i_mode;
> > -	crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac_misc));
> > +	error =3D crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hm=
ac_misc));
> > +	if (error) {
> > +		pr_err("crypto_shash_update() failed: %d\n", error);
> > +		return error;
> > +	}
> >  	if ((evm_hmac_attrs & EVM_ATTR_FSUUID) &&
> > -	    type !=3D EVM_XATTR_PORTABLE_DIGSIG)
> > -		crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid, UUID_SIZE);
> > -	crypto_shash_final(desc, digest);
> > +	    type !=3D EVM_XATTR_PORTABLE_DIGSIG) {
> > +		error =3D crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid, UUID=
_SIZE);
> > +		if (error) {
> > +			pr_err("crypto_shash_update() failed: %d\n", error);
> > +			return error;
> > +		}
> > +	}
> > +	error =3D crypto_shash_final(desc, digest);
> > +	if (error) {
> > +		pr_err("crypto_shash_final() failed: %d\n", error);
> > +		return error;
> > +	}
> > =20
> >  	pr_debug("hmac_misc: (%zu) [%*phN]\n", sizeof(struct h_misc),
> >  		 (int)sizeof(struct h_misc), &hmac_misc);
> > +	return 0;
> >  }
> > =20
> >  /*
> > @@ -260,9 +275,12 @@ static int evm_calc_hmac_or_hash(struct dentry *de=
ntry,
> > =20
> >  		if ((req_xattr_name && req_xattr_value)
> >  		    && !strcmp(xattr->name, req_xattr_name)) {
> > -			error =3D 0;
> > -			crypto_shash_update(desc, (const u8 *)req_xattr_value,
> > +			error =3D crypto_shash_update(desc, (const u8 *)req_xattr_value,
> >  					     req_xattr_value_len);
>=20
> Please align this.
>=20
> Thanks
>=20
> Roberto
>=20
> > +			if (error) {
> > +				pr_err("crypto_shash_update() failed: %d\n", error);
> > +				goto out;
> > +			}
> >  			if (is_ima)
> >  				ima_present =3D true;
> > =20
> > @@ -286,15 +304,20 @@ static int evm_calc_hmac_or_hash(struct dentry *d=
entry,
> >  			pr_debug("file %s: xattr %s size mismatch (kernel: %d, user: %d)\n"=
,
> >  				 dentry->d_name.name, xattr->name, size,
> >  				 user_space_size);
> > -		error =3D 0;
> >  		xattr_size =3D size;
> > -		crypto_shash_update(desc, (const u8 *)xattr_value, xattr_size);
> > +		error =3D crypto_shash_update(desc, (const u8 *)xattr_value, xattr_s=
ize);
> > +		if (error) {
> > +			pr_err("crypto_shash_update() failed: %d\n", error);
> > +			goto out;
> > +		}
> >  		if (is_ima)
> >  			ima_present =3D true;
> > =20
> >  		dump_security_xattr(xattr->name, xattr_value, xattr_size);
> >  	}
> > -	hmac_add_misc(desc, inode, type, data->digest);
> > +	error =3D hmac_add_misc(desc, inode, type, data->digest);
> > +	if (error)
> > +		goto out;
> > =20
> >  	if (inode !=3D d_backing_inode(dentry) && iint) {
> >  		if (IS_I_VERSION(inode))
> > @@ -401,6 +424,7 @@ int evm_init_hmac(struct inode *inode, const struct=
 xattr *xattrs,
> >  {
> >  	struct shash_desc *desc;
> >  	const struct xattr *xattr;
> > +	int error;
> > =20
> >  	desc =3D init_desc(EVM_XATTR_HMAC, HASH_ALGO_SHA1);
> >  	if (IS_ERR(desc)) {
> > @@ -412,12 +436,17 @@ int evm_init_hmac(struct inode *inode, const stru=
ct xattr *xattrs,
> >  		if (!evm_protected_xattr(xattr->name))
> >  			continue;
> > =20
> > -		crypto_shash_update(desc, xattr->value, xattr->value_len);
> > +		error =3D crypto_shash_update(desc, xattr->value, xattr->value_len);
> > +		if (error) {
> > +			pr_err("crypto_shash_update() failed: %d\n", error);
> > +			goto out;
> > +		}
> >  	}
> > =20
> > -	hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
> > +	error =3D hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
> > +out:
> >  	kfree(desc);
> > -	return 0;
> > +	return error;
> >  }
> > =20
> >  /*


