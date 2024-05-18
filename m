Return-Path: <linux-integrity+bounces-2446-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58D18C909A
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 13:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB0AC1C20C76
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 11:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A20262A8;
	Sat, 18 May 2024 11:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oETXNJqZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEBF22079;
	Sat, 18 May 2024 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716031678; cv=none; b=nU3Pt7099FVh51tr9oJChfa4WtT6UVRlC8r4M8qqAd/kAz8CFK0n8KXKyy+MST4DXnpNgXOd2vKMOHTHnnVUKFJ1wKJ1EJuXYGbtyjK+2IZ+KEc5rPgFQcDUSZkDQq//6cMXoN/omzliGUtBDexHXPRG4DUETP+oG382vkyouTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716031678; c=relaxed/simple;
	bh=DSiwIrn4SE/zp/8AK9oz+97KO4hgc4iAT3wlLd/xSWA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ifrZSIcSSRHL9dZcy3Mt23V5+vYAjgoiv4jmMIXqbEKl+kBrUn+zE2uO2c/LBk9ZFmRzQU2+kVI1n4Xa1K0bK+YDfPU+xMxbKVRLUJpKDFwMP4yUJWxY5BAkrKpRsoCGggS/8U/XvONE00a5sTg1TjNeUndU/y3fCx3s4vxnFII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oETXNJqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D982C113CC;
	Sat, 18 May 2024 11:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716031677;
	bh=DSiwIrn4SE/zp/8AK9oz+97KO4hgc4iAT3wlLd/xSWA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=oETXNJqZH76GuSx1Nw5cJwJkm1LspY/0SY7I7t/2jDfrDBnJaFYrEAQS56ekvyL0W
	 7xGTqg0lMYaaKWGUCtS5cORRAlNgfedNQLqDHf6lDGqYuoOF+JR9piPevT3iqvMV/f
	 EeymFf4zjm8Ocn+CqIWvc9iM4jljVdwn7lfBN4GFM/E2kNsqB5nmtKPv5QypMRZ+XG
	 b71Ew0Gpgo37fYm2q01DNX8lKG1eTLw/yp9FaFSyE0tQBm88Yzh5lH0JR0Wv08i+Cs
	 eqrxsVYNaT1Ii0TKtZDOhn95pCeniUYeAJaeaj2lzOB0YlE5u6o0TJ5ew3pwpg5pe+
	 bzr2fR/4bJ3yA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 May 2024 14:27:54 +0300
Message-Id: <D1CQGK8GY5UO.179S3ITUXL00Z@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <peterhuewe@gmx.de>, <jgg@ziepe.ca>
Subject: Re: SLB9670 TPM module crash
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Parthiban"
 <parthiban@linumiz.com>, <James.Bottomley@HansenPartnership.com>
X-Mailer: aerc 0.17.0
References: <7955419c-ccc2-4a20-8ff5-07b119258415@linumiz.com>
 <D1CQEN4ROQFK.1NHMZGCIL1YC5@kernel.org>
In-Reply-To: <D1CQEN4ROQFK.1NHMZGCIL1YC5@kernel.org>

On Sat May 18, 2024 at 2:25 PM EEST, Jarkko Sakkinen wrote:
> On Sat May 18, 2024 at 2:21 PM EEST, Parthiban wrote:
> > Dear James Bottomley,
> >
> > The following crash is observed in the current mainline kernel and I ha=
ve tried the
> > git bisect to narrow it down. Bisect points to the below commit, which =
got merged as
> > part of [1]. I tried reverting the below commit and the TPM loads fine.
> >
> > commit 1b6d7f9eb150305dcb0da4f7101a8d30dcdf0497
> > Author: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Date:   Mon Apr 29 16:28:07 2024 -0400
> >
> >     tpm: add session encryption protection to tpm2_get_random()
> >    =20
> >     If some entity is snooping the TPM bus, they can see the random
> >     numbers we're extracting from the TPM and do prediction attacks
> >     against their consumers.  Foil this attack by using response
> >     encryption to prevent the attacker from seeing the random sequence.
> >    =20
> >     Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.c=
om>
> >     Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> >     Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
> >     Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> >
> >  drivers/char/tpm/tpm2-cmd.c | 21 +++++++++++++++++----
> >  1 file changed, 17 insertions(+), 4 deletions(-)
> >
> > [   11.551988] tpm_tis_spi spi0.1: 2.0 TPM (device-id 0x1B, rev-id 22)
> > [   11.563036] spi_master spi0: will run message pump with realtime pri=
ority
>
>
> Explanation and workaround: https://lore.kernel.org/linux-integrity/D1C1K=
L7Q27P9.39BH0Z4EMBBUG@kernel.org/

Oops completely wrong for this issue! Sorry I overlooked.

So fix is in progress for __request_module() issue. See this
discussion for reference:

https://lore.kernel.org/linux-integrity/119dc5ed-f159-41be-9dda-1a056f29888=
d@notapiano/

BR, Jarkko

