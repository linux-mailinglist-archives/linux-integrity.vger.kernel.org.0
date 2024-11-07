Return-Path: <linux-integrity+bounces-4062-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B20EF9C0804
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 14:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4FE61C22A98
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 13:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D71220FAB1;
	Thu,  7 Nov 2024 13:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOyjClu4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0884D9450;
	Thu,  7 Nov 2024 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987359; cv=none; b=oBrs4d0yI3VABKFuC4aQefhCgFyv3I9qzuxy0s6O6Pw65QC89YUj8VBGzGc0WygVhdeyrutYL8SRHg+RJvzYxvWNO/gg0ACAwcXoYbkYILwH0ssmPw04+huHSZvWjZqBD1EuTBs7KApxxxc+bF83EhA73aix32AB433TpE99DWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987359; c=relaxed/simple;
	bh=xkdSuqK3r0vUf8de9C7k1IoPlQeMvXHhSuucCxgETxU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gD4z8CEcw1zQeXU70kaL8ys5YBfJw7WgrvKL82kt5JHf9Uq3l6iw5nDKoj7KQzpvc0TXvk6x7iBsURU7NIWlaDwHtqHD1nbJ+CVRvmLEADjdg2hoa3DQ4PErvj4DhErJKRV5VUaXD9Sc7/+s2VxJE2FIZlo+cd1edVUAkxS7ais=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOyjClu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13768C4CECC;
	Thu,  7 Nov 2024 13:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730987358;
	bh=xkdSuqK3r0vUf8de9C7k1IoPlQeMvXHhSuucCxgETxU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=QOyjClu4O3NmeTBrShlXT/WKsAjeF3REe16UvfDGP4OkrgVMdToegp9LoVHvDbYab
	 JoTEzZUgoNDDuK6Zd8HO5p2goqt5rdeSCQ7aAdtDXJEOzEXfbANGDw7DavIgVf0Xa/
	 5SbNNzox7et6gMqEjX5OhKI7VcfDF2YaCyBmx+/mZJk2+V6lQykOVqHyq+2zO8ohYQ
	 L6fwQoCTJ2Vwlr9lujOK2NfLv2LENsiI9MLMBCGq2uG7zcLtCR21ezGFR04Kmp4vqr
	 ASV5PbPylogay7VjWfjkalIlmBsjD4fu3YrA8rvwyNExqCARJfy5y09OmgF91l3ZQW
	 kKPrnZ9pRXFGw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Nov 2024 15:49:14 +0200
Message-Id: <D5FZT0QPHL0O.231WD6VUHC48X@kernel.org>
Cc: "Roberto Sassu" <roberto.sassu@huawei.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tpm: Opt-in in disable PCR integrity protection
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>
X-Mailer: aerc 0.18.2
References: <20241107095138.78209-1-jarkko@kernel.org>
 <76d9ae11c339b589a8ec94f010e7439b7ce7d283.camel@HansenPartnership.com>
In-Reply-To: <76d9ae11c339b589a8ec94f010e7439b7ce7d283.camel@HansenPartnership.com>

On Thu Nov 7, 2024 at 3:20 PM EET, James Bottomley wrote:
> On Thu, 2024-11-07 at 11:51 +0200, Jarkko Sakkinen wrote:
> [...]
> > +void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 at=
tributes, u8 *passphrase, int
> > passphrase_len)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* offset tells us where the=
 sessions area begins */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int offset =3D buf->handles =
* 4 + TPM_HEADER_SIZE;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 len =3D 9 + passphrase_l=
en;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (tpm_buf_length(buf) !=3D=
 offset) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0/* not the first session so update the existing
> > length */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0len +=3D get_unaligned_be32(&buf->data[offset]);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0put_unaligned_be32(len, &buf->data[offset]);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0tpm_buf_append_u32(buf, len);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* auth handle */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm_buf_append_u32(buf, TPM2=
_RS_PW);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* nonce */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm_buf_append_u16(buf, 0);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* attributes */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm_buf_append_u8(buf, 0);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* passphrase */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm_buf_append_u16(buf, pass=
phrase_len);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm_buf_append(buf, passphra=
se, passphrase_len);
> > +}
> > +
>
> The rest of the code looks fine, but if you're going to extract this as
> a separate function instead of doing the open coded struct
> tpm2_null_auth that was there originally, you should probably extract
> and use the tpm2_buf_append_auth() function in trusted_tpm2.c

So this was straight up from Mimi's original patch :-)

Hmm... was there duplicate use for this in the patch? I'll check this.

>
> James

BR, Jarkko

