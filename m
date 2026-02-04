Return-Path: <linux-integrity+bounces-8447-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHYfAFByg2mFmwMAu9opvQ
	(envelope-from <linux-integrity+bounces-8447-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 04 Feb 2026 17:22:40 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBEEEA242
	for <lists+linux-integrity@lfdr.de>; Wed, 04 Feb 2026 17:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9CFA30E0A2B
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Feb 2026 15:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D1341B36D;
	Wed,  4 Feb 2026 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="uQdhuzVj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5A13F23AF
	for <linux-integrity@vger.kernel.org>; Wed,  4 Feb 2026 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770220212; cv=none; b=geGUHhDFWlpCVB9y4fI99TUtn1+6/P2d2vnrgFtsxfoGcamOodfjU5dYOxMdmAfMWW3gfC/y0ihvfAKdUA2S/wXILe2CiFREHk8uqd+CRatFDmt1DHKG2qy+W8/No7EEpyXThmzE58hDtGbmtRz3KO5e6eycqnSeQB5ekr1vPp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770220212; c=relaxed/simple;
	bh=Iv6ceCD67TOkKQAVQ2Nt4LeyOIYSO+D5hmUYWlyO+rA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X868wkIP/v8FVVo63HHuKJ6uMRXT0TEqic62+FEu0JcNYyY6PFhnKbBaukcUflXgEfr3v3+fUoRF+VbA3AGBeLeDpc+IYEmD6q3hsQOgGbEASpS6pij2RE6t9I7maVZOHOLc0kLp5fsJbt4QWgec4i3pwi7M0+qjdotzQ39atJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=uQdhuzVj; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614EoM9X2536351
	for <linux-integrity@vger.kernel.org>; Wed, 4 Feb 2026 07:50:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=ChkmBy7CZof0BPx1r6UN
	8ALJ9ItnMaa8AwUM/o8GdWI=; b=uQdhuzVjmNDSkobt3LmqljqgR7I2qUh/tev3
	BsLxl1DgfA11KZlVrCQ1Ph02Az3LfcR+V53HLaZT8XXtlsv7uDvTigAoRA0OFH8t
	jpnAq6ImgUIFtjfaDMihtCbiHftAwqmXXVejNNIjzO1/zpEXl3h7idwVpy8Nm+QV
	/oeBx2R3EcjWqIx/H2uJAD95/zB21xvL9aJiLnMnbqJZdQm7X2tJEBsmIdUZHJmO
	+W5UbWJBccag9CNk5VBv6FFQO5VkHMCq/3lhF+3c3VqUnWw7sZsUuNonvugpbjop
	L/hX5/uM3lLtMDGLJim738GpudvdAnJ7R+iKKqXm6uzalT1JLw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c487hrnx3-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 04 Feb 2026 07:50:10 -0800 (PST)
Received: from twshared25002.15.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 4 Feb 2026 15:50:09 +0000
Received: by devbig010.atn3.facebook.com (Postfix, from userid 224791)
	id 5DBC99E3AE7; Wed,  4 Feb 2026 07:47:04 -0800 (PST)
Date: Wed, 4 Feb 2026 07:47:04 -0800
From: Daniel Hodges <hodgesd@meta.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
CC: <zohar@linux.ibm.com>, <roberto.sassu@huawei.com>,
        <dmitry.kasatkin@gmail.com>, <eric.snowberg@oracle.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] evm: check return values of crypto_shash functions
Message-ID: <aYNprpzxppKE0Gf2@fb.com>
References: <20260131182233.2365157-1-hodgesd@meta.com>
 <d1d63c522a3842ccaf74c4462ee06bf82ce3b3f5.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d1d63c522a3842ccaf74c4462ee06bf82ce3b3f5.camel@huaweicloud.com>
X-FB-Internal: Safe
X-Authority-Analysis: v=2.4 cv=eu3SD4pX c=1 sm=1 tr=0 ts=69836ab3 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VabnemYjAAAA:8 a=tRd023x4sL2B9Mxxro0A:9 a=CjuIK1q_8ugA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: AtSloIIobBRGmssLM_pjjfOEur8HTqV3
X-Proofpoint-ORIG-GUID: AtSloIIobBRGmssLM_pjjfOEur8HTqV3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDExOSBTYWx0ZWRfX4R38xXT8x06E
 KJCyb6H8nKZ0i4UFkFdlQSg8Gr/Nu1xC7/jQZyzsy2bY+sNfl58H4/AiJ+fS5lwzIIhFMl9ylLM
 5YV17g1zSoI2YRBIlu/VPE3CiYrcU0pK04eyOz4niqZQadGsMsRaSxun5INtQYjrUeauHut09tM
 VrIOeEGaEMYAo0YpCqQ5do3rCyB8gXfD/RBPqJtzpUjiiOvvxa+87NbJUcqfixgy7Q07n1ARMg/
 WxtHoMCk2QWpBbngJ0taRMK8TnMI77L3Kt/pfhbCKEsfsC/Kg65mhAA7/ia0xVllr3WQZf23l7d
 1XdmKjtCwglHeYJEmxZOzxeXUbgI0bCiDOtaskSTE7rNEcsMa6YJx/sdhN0q0WzsRBK0Zj1zwc9
 gphzlf0e/Sc4BiPj+PKT6dHHhoj8baXqJzAOIsge1IPVBdR5hvaRAOKiK5ZDfVeq2Db5lseZ2Pf
 gwdCGWa9655AjgO4Caw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_04,2026-02-04_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email,meta.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8447-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[meta.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hodgesd@meta.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6BBEEEA242
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 01:50:29PM +0100, Roberto Sassu wrote:
> On Sat, 2026-01-31 at 10:22 -0800, Daniel Hodges wrote:
> > The crypto_shash_update() and crypto_shash_final() functions can fail
> > and return error codes, but their return values were being ignored in
> > several places in evm_crypto.c:
> > 
> >   - hmac_add_misc(): ignores returns from crypto_shash_update() and
> >     crypto_shash_final()
> >   - evm_calc_hmac_or_hash(): ignores returns from crypto_shash_update()
> >   - evm_init_hmac(): ignores returns from crypto_shash_update()
> > 
> > If these hash operations fail silently, the resulting HMAC could be
> > invalid or incomplete. This could potentially allow integrity
> > verification to pass with incorrect HMACs, weakening EVM's security
> > guarantees.
> > 
> > Fix this by:
> >   - Changing hmac_add_misc() from void to int return type
> >   - Checking and propagating error codes from all crypto_shash calls
> >   - Updating all callers to check the return values
> > 
> > Fixes: 66dbc325afce ("evm: re-release")
> > Signed-off-by: Daniel Hodges <hodgesd@meta.com>
> > ---
> >  security/integrity/evm/evm_crypto.c | 45 +++++++++++++++++++----------
> >  1 file changed, 30 insertions(+), 15 deletions(-)
> > 
> > diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> > index a5e730ffda57..286f23a1a26b 100644
> > --- a/security/integrity/evm/evm_crypto.c
> > +++ b/security/integrity/evm/evm_crypto.c
> > @@ -132,58 +132,65 @@ static struct shash_desc *init_desc(char type, uint8_t hash_algo)
> >  	}
> >  	return desc;
> >  }
> >  
> >  /* Protect against 'cutting & pasting' security.evm xattr, include inode
> >   * specific info.
> >   *
> >   * (Additional directory/file metadata needs to be added for more complete
> >   * protection.)
> >   */
> > -static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
> > -			  char type, char *digest)
> > +static int hmac_add_misc(struct shash_desc *desc, struct inode *inode,
> > +			 char type, char *digest)
> >  {
> >  	struct h_misc {
> >  		unsigned long ino;
> >  		__u32 generation;
> >  		uid_t uid;
> >  		gid_t gid;
> >  		umode_t mode;
> >  	} hmac_misc;
> > +	int ret;
> >  
> >  	memset(&hmac_misc, 0, sizeof(hmac_misc));
> >  	/* Don't include the inode or generation number in portable
> >  	 * signatures
> >  	 */
> >  	if (type != EVM_XATTR_PORTABLE_DIGSIG) {
> >  		hmac_misc.ino = inode->i_ino;
> >  		hmac_misc.generation = inode->i_generation;
> >  	}
> >  	/* The hmac uid and gid must be encoded in the initial user
> >  	 * namespace (not the filesystems user namespace) as encoding
> >  	 * them in the filesystems user namespace allows an attack
> >  	 * where first they are written in an unprivileged fuse mount
> >  	 * of a filesystem and then the system is tricked to mount the
> >  	 * filesystem for real on next boot and trust it because
> >  	 * everything is signed.
> >  	 */
> >  	hmac_misc.uid = from_kuid(&init_user_ns, inode->i_uid);
> >  	hmac_misc.gid = from_kgid(&init_user_ns, inode->i_gid);
> >  	hmac_misc.mode = inode->i_mode;
> > -	crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac_misc));
> > +	ret = crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac_misc));
> > +	if (ret)
> > +		return ret;
> >  	if ((evm_hmac_attrs & EVM_ATTR_FSUUID) &&
> > -	    type != EVM_XATTR_PORTABLE_DIGSIG)
> > -		crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid, UUID_SIZE);
> > -	crypto_shash_final(desc, digest);
> > +	    type != EVM_XATTR_PORTABLE_DIGSIG) {
> > +		ret = crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid, UUID_SIZE);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +	ret = crypto_shash_final(desc, digest);
> 
> Maybe we should also indicate if an error occurred, with a separate
> error message, or adding the result in the message below.
> 
> Thanks
> 
> Roberto

That makes sense, I'll send a V2. I'm having trouble with my corporate
email mail delivery so it might come from my personal email.

