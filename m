Return-Path: <linux-integrity+bounces-2820-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A778FBEFB
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Jun 2024 00:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5D711F21442
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jun 2024 22:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9CF1442FE;
	Tue,  4 Jun 2024 22:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/nfl/5c"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8341A28DC7;
	Tue,  4 Jun 2024 22:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540418; cv=none; b=DfyDTsi0Ae7lRUVb8UPmYBZlqJ4N+2jWRYGTEcYory4V/6DW93mZVPOrVeUBdY9AodqHMkEz1PohM7hLzP17tF/NDM+5OueDnOp1YyH8SX18MJMMk5iWPkIkOo6mx6iYniunVpp3yZMFYSba2nOncHb34R4IWa4+uM3MQ1DWScM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540418; c=relaxed/simple;
	bh=vKk54H5hajLqoyQvgP+yXe9n5V6epR2sgSb7GL/pKD0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JhbobHZ4nsJ+vulHff510SYYrkLuQuRNhPdmxR5BeWa9z+ZrYL6081UVOQVOPl4/QWHG76+fTwj4DbsnswDRk8rAzn+OwO8f6k+Yf1LqBS76EdX5a4pT5jmGyRKJ0BjHJHO0fbcBKyxoGs/6BR43uSI70iBqPm1TPO4jSBDqA0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/nfl/5c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD4AC3277B;
	Tue,  4 Jun 2024 22:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717540417;
	bh=vKk54H5hajLqoyQvgP+yXe9n5V6epR2sgSb7GL/pKD0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=G/nfl/5cR0PwMZa8J22uWo0KSFIzBt74P8cN/OEhgB/00aKhX9xMV9qd8jZhHm//G
	 teAehz1lQgqYECpI7jnVW/ck4etFZDkML6JfvX0Py2zN5rt8amp2VC1/cG5MGHCGlq
	 2hojjdMPUs+seAOX6ZZvyAKv+vOXSbj+WIOqZ10Uhf4PWrzmnTGr+7KvmoPvcDdxqV
	 7AxsIxMbgqtXMSNHPZ5mlHYXIYYPAtvp8uPjBjmTgZl6P7gMDUPHztTT4BJmgasNko
	 KEBdo7wgfp6PWKv/P3yqQ6I3UyhVdjviylkfGi4XEzuMxN+BqIisBrKAVC7rOpnDwD
	 /6PeY1X9SDS5A==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Jun 2024 01:33:32 +0300
Message-Id: <D1RL9GZKU6Y3.2HFU56T053FQB@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <Andreas.Fuchs@infineon.com>, "James Prestwood" <prestwoj@gmail.com>,
 "David Woodhouse" <dwmw2@infradead.org>, "Eric Biggers"
 <ebiggers@kernel.org>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>, <linux-crypto@vger.kernel.org>,
 "Lennart Poettering" <lennart@poettering.net>, "David S. Miller"
 <davem@davemloft.net>, "open list" <linux-kernel@vger.kernel.org>, "Mimi
 Zohar" <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul
 Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "open list:SECURITY SUBSYSTEM"
 <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v7 3/5] crypto: tpm2_key: Introduce a TPM2 key type
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>
X-Mailer: aerc 0.17.0
References: <20240528210823.28798-1-jarkko@kernel.org>
 <20240528210823.28798-4-jarkko@kernel.org>
 <97dd7485-51bf-4e47-83ab-957710fc2182@linux.ibm.com>
 <D1REOCZ2XHRY.4U47RZ20QET1@kernel.org>
 <6f0e04c2-4602-4407-9af5-f72610021a6a@linux.ibm.com>
In-Reply-To: <6f0e04c2-4602-4407-9af5-f72610021a6a@linux.ibm.com>

On Tue Jun 4, 2024 at 9:41 PM EEST, Stefan Berger wrote:
>
>
> On 6/4/24 13:23, Jarkko Sakkinen wrote:
> > On Fri May 31, 2024 at 3:35 AM EEST, Stefan Berger wrote:
> >>
>
> >>>   =20
> >>> -	rc =3D tpm2_key_decode(payload, options, &blob);
> >>> -	if (rc) {
> >>> -		/* old form */
> >>> +	key =3D tpm2_key_decode(payload->blob, payload->blob_len);
> >>> +	if (IS_ERR(key)) {
> >>> +		/* Get the error code and reset the pointer to the key: */
> >>> +		rc =3D PTR_ERR(key);
> >>> +		key =3D NULL;
> >>> +
> >>> +		if (rc =3D=3D -ENOMEM)
> >>> +			return -ENOMEM;
> >>> +
> >>> +		/* A sanity check, as only -EBADMSG or -ENOMEM are expected: */
> >>> +		if (rc !=3D -EBADMSG)
> >>> +			pr_err("tpm2_key_decode(): spurious error code %d\n", rc);
> >>
> >> tpm2_key_decode seems simple enough that it only returns key, -ENOMEM =
or
> >> EBADMSG.
> >=20
> > So what is your suggestion here?
>
> You can remove the check resuling in pr_err().

OK, I think so too. Just had to (sanity) check.

>
> >=20
> > The reasoning here is that asymmetric keys use -EBADMSG not only as
> > error but also iterator, when probing which can load a specific key.
> >=20

BR, Jarkko

