Return-Path: <linux-integrity+bounces-1941-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F138389328A
	for <lists+linux-integrity@lfdr.de>; Sun, 31 Mar 2024 18:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7A91C21D9F
	for <lists+linux-integrity@lfdr.de>; Sun, 31 Mar 2024 16:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D68145349;
	Sun, 31 Mar 2024 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZfWMkzK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27641143C75;
	Sun, 31 Mar 2024 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711901386; cv=none; b=n/5Qi0sd6r/JAeF3jWKcxOohNY4sObr0rjksNB5vCautwoEdjq1Jk9iotceityeE7kBqoascUUlUE2HgFNFyUw54XTyuMdI/Naw60ail8QaeLzdKS2Gwz/AJyaDi5mYOwgpZBaP6VrnOdpfgCc91R0nmwx31mGrCUYg4fGjNhW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711901386; c=relaxed/simple;
	bh=Rb6XGdB+AQ+kJPgltpZhPihlCivUz2V/VWgrEPOniIM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Vn4ALSiEn8Hsf+2Ko0kqYRjlPdAbLE+P+xWcbVbadqwYOF7S+Usr7NIIZWIcwWSTPTEJjCwXBdhJN1ShwXyzISJd0juVVM21YN5lTxmNUhuo0ARgJK9jdOsRD9IGUidy7nOhgpEu161hsbm12dYKGD62cf0g5ckQlckyd43/COc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZfWMkzK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF40C433C7;
	Sun, 31 Mar 2024 16:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711901385;
	bh=Rb6XGdB+AQ+kJPgltpZhPihlCivUz2V/VWgrEPOniIM=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=NZfWMkzKTn+9jI5Vos3W+uTWpEEchFPDX8XZsv99rZQkroT5H2zBQzNF8t507/Q/J
	 SVOsUC/KocYIEZYhTOejLf/88ip5mWd6xmoB/r+8kp/C94h5xsWrjytL98zxzNnCbI
	 kQQO98i3Fnm+wHTBs/46FxgTkbUeCinShwLI2DaHTacU7cnwAtbyDS7HV38GZRyGMG
	 dk4EDysZpitf4fTXFO2ckNCLVxUgpqhG3gqNVpFTihTQM4ZnziWfksQUIMVBtFIrNV
	 Ka+UE8ur+BtUpDwNMoBdJoKIZfduJnYLe3EzwLyLNOblMFtI1ncfmkgL64GiQKyn3s
	 Ms4s8rMGOUXPA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 31 Mar 2024 19:09:42 +0300
Message-Id: <D082E6E1VBXE.2U3RU4ZKXUZ9A@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>,
 =?utf-8?q?Gabr=C3=ADel_Arth=C3=BAr_P=C3=A9tursson?= <gabriel@system.is>,
 "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v7 12/21] tpm: Add NULL primary creation
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
 <20240213171334.30479-13-James.Bottomley@HansenPartnership.com>
 <05c7d10b23e74269efd720eedbb1773931b0ad46.camel@system.is>
 <D08273C2C8HD.2QT57ZPAWPS9H@kernel.org>
In-Reply-To: <D08273C2C8HD.2QT57ZPAWPS9H@kernel.org>

On Sun Mar 31, 2024 at 7:00 PM EEST, Jarkko Sakkinen wrote:
> On Sat Mar 30, 2024 at 8:48 PM EET, Gabr=C3=ADel Arth=C3=BAr P=C3=A9turss=
on wrote:
> > On Tue, 2024-02-13 at 12:13 -0500, James Bottomley wrote:
> > > +	/* unique: key specific; for ECC it is two points */
> > > +	tpm_buf_append_u16(&template, 0);
> > > +	tpm_buf_append_u16(&template, 0);
> >
> > Shouldn't the points be 32 bytes each in size, filled with zeros?
> >
> > The TCP TPM 2.0 Provisioning Guidance defines the SRK Template as a
> > diff on top of Template L-2 (for ECC keys) as defined in the EK
> > Credential Profile 2.0 document.
> >
> > Template L-2 calls for the X and Y points to be of 32 bytes each,
> > filled with zeros. The Provisioning Guidance does not call for zero-
> > sized points.
> >
> > For example, let's create an ECC Endorsement Key using the standard
> > template then print its name:
> >
> >    tpm2_createek -G ecc -c /dev/null -u ./ek.pub
> >    tpm2_loadexternal -c n -u ./ek.pub
> >
> > Equivalently using tpm2_createprimary:
> >
> >    perl -e 'print "\0"x64' | tpm2_createprimary -C e -o ./ek.pub -G ecc=
 -a 'fixedtpm|fixedparent|sensitivedataorigin|adminwithpolicy|restricted|de=
crypt' -L 837197674484b3f81a90cc8d46a5d724fd52d76e06520b64f2a1da1b331469aa =
-u -
> >    tpm2_loadexternal -c n -u ./ek.pub
> >
> > You'll find that the key's public modulus matches that of the EK
> > Certificate imprinted by the manufacturer, indicating we got the
> > template correct.
> >
> > To generate a standard SRK key, the TCG TPM2 Provisioning Guidance
> > states we should:
> >
> > 	1. set userWithAuth,
> > 	2. clear adminWithPolicy
> > 	3. set noDA, and
> > 	4. clear the authorization policy.
> >
> > There's no mention of alterations to the unique field.
> >
> > Let's also create the key in the null hierarchy:
> >
> >    perl -e 'print "\0"x64' | tpm2_createprimary -C n -o ./null.pub -G e=
cc -a 'fixedtpm|fixedparent|sensitivedataorigin|userwithauth|noda|restricte=
d|decrypt' -u -
> >    tpm2_loadexternal -c n -u ./null.pub
> >
> > The name does not match the kernel's name for the null key.
>
> Null key is not provisioned, what is the motivation here?
>
> Not saying no, just asking for details...
>
> There's couple of things that lack in this patch set ATM:
>
> 1. Neither kselftest additions nor not even proper testing
>    instructions. Why 21 patches and zero tests? How one should
>    decide when the work is "complete"?
> 2. I still don't know what version of QEMU I should patch to
>    test corner cases from an URL, which I cannot recall :-)
>    Highlights the first issue.
>
> So for the time being the patch set is NAK just because we lack
> clear definition of done here. I revisit it only when I know how
> to test it.

Your feedback was great because it highlights the issue that the
excepted behaviour is non-existent at this point.

BR, Jarkko

