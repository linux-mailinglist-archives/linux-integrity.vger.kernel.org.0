Return-Path: <linux-integrity+bounces-4066-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC2F9C0BEC
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 17:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B29062827A8
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 16:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C9C200B9A;
	Thu,  7 Nov 2024 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGwe81Pj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643F9DDBE;
	Thu,  7 Nov 2024 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730997940; cv=none; b=MPCATpW3Ar9xKNCI7SWUgd4os+RdzcKZCV3mbUC5/Ce4AdkodqOSsOpJ7FSvGWwVQ2NEmZ1iPsxhc3Uk70ypUql72EaVMuIwJMn8Pkb7J27t4uCfGJUx9nPy0if+Kic5IdgbK/supLNhBaBvJVkkpbtEUIIqoownfN1KS/IWTDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730997940; c=relaxed/simple;
	bh=Be7kVOqc9oDldRngyHDx9b/u8eyDM+L+Oo7d4LCyzzE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Apa3JuB32dA4V7uPYobV3x9+AECx76zuISWmXy29OV0nb71CtIeFsUn76uZMO+tWw2w8s1SiLKDtrDQZtwhmmqQpJpL78GICEMP3JyAj6pXwBVugIwZxBTTxzwG33ABzBx0fgTtEaVbQqv32s7mhFSc4tnespcvPyGuw3s6PMo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGwe81Pj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671C3C4CECC;
	Thu,  7 Nov 2024 16:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730997939;
	bh=Be7kVOqc9oDldRngyHDx9b/u8eyDM+L+Oo7d4LCyzzE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=qGwe81PjHYQN7GxX/Ql27Z+dHxd7xgchW+3Pfzi52Lo8B20FXA+byY1BJC6ZrUHYY
	 h9oZpbQIfGI6qHDfPdKwHo5TLsYFSzywTAWXLxvusHMZvIA7g8YDvnksK7adgv/S8/
	 +5QzeqPPauL9SaNfaW0DoMmLaeMU8CRaf4D7wmgU1PKN+YDcstXnKzQhNYa5A6MYWP
	 6fMHRKp9oRcA/lPRbROwSNasiAAvbxpxSH2TKErlHDKVx+zjZuKUXD8DzixxhyeOvB
	 3nc8GJ05I127RIjYNsuyQRBN3lyesC/CbUBtm4RAjF3SEJyL5a9YJ/jKOcweSwU0fM
	 gf+GDGvF+QNOA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Nov 2024 18:45:35 +0200
Message-Id: <D5G3K1QSPRNS.153H4EMMWEEBU@kernel.org>
Cc: "Roberto Sassu" <roberto.sassu@huawei.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tpm: Opt-in in disable PCR integrity protection
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Mimi Zohar" <zohar@linux.ibm.com>, <linux-integrity@vger.kernel.org>,
 "Jonathan Corbet" <corbet@lwn.net>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>
X-Mailer: aerc 0.18.2
References: <20241107095138.78209-1-jarkko@kernel.org>
 <e015a939893d35efe75e598152725adcc2befdd8.camel@linux.ibm.com>
 <D5FZRXBCH2B4.1GQIIVQHVB2XI@kernel.org>
 <7f77c0e8b481fd813b3a76b84d33d8db62e235f7.camel@linux.ibm.com>
In-Reply-To: <7f77c0e8b481fd813b3a76b84d33d8db62e235f7.camel@linux.ibm.com>

On Thu Nov 7, 2024 at 4:00 PM EET, Mimi Zohar wrote:
> On Thu, 2024-11-07 at 15:47 +0200, Jarkko Sakkinen wrote:
> > On Thu Nov 7, 2024 at 3:44 PM EET, Mimi Zohar wrote:
> > > >=20
> > > > @@ -232,18 +236,26 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u3=
2 pcr_idx,
> > > >  	int rc;
> > > >  	int i;
> > > > =20
> > > > -	rc =3D tpm2_start_auth_session(chip);
> > > > -	if (rc)
> > > > -		return rc;
> > > > +	if (!disable_pcr_integrity_protection) {
> > > > +		rc =3D tpm2_start_auth_session(chip);
> > > > +		if (rc)
> > > > +			return rc;
> > > > +	}
> > > > =20
> > > >  	rc =3D tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
> > > >  	if (rc) {
> > > > -		tpm2_end_auth_session(chip);
> > > > +		if (!disable_pcr_integrity_protection)
> > > > +			tpm2_end_auth_session(chip);
> > > >  		return rc;
> > > >  	}
> > > > =20
> > > > -	tpm_buf_append_name(chip, &buf, pcr_idx, NULL);
> > > > -	tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
> > > > +	if (!disable_pcr_integrity_protection) {
> > > > +		tpm_buf_append_name(chip, &buf, pcr_idx);
> > >=20
> > > tpm_buf_append_name() parameters didn't change.  Don't remove the 'na=
me' field
> > > here.
> >=20
> > Hmm... weird I'll check this. Maybe I had something left to staging...

Yes! This was correct in my clone but not in the patch.

Clearly a sign that I wait until next week before sending a new version
:-)


> >=20
> > >=20
> > >=20
> > > > +		tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
> > > > +	} else {
> > > > +		tpm_buf_append_handle(chip, &buf, pcr_idx);
> > >=20
> >=20
> > > Or here.
> >=20
> > Here I think it is appropriate
>
> Agreed

Great

BR, Jarkko

