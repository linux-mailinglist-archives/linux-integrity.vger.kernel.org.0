Return-Path: <linux-integrity+bounces-332-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0682A802AAA
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 05:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384901C20849
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 04:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D70F23AD;
	Mon,  4 Dec 2023 04:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRHUNgm4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8D3211C
	for <linux-integrity@vger.kernel.org>; Mon,  4 Dec 2023 04:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89B3C433C7;
	Mon,  4 Dec 2023 04:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701662771;
	bh=CQmSqWt3OA1GTZbpAXyEg+KDYgBojMMz0LLLRTD1/Z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iRHUNgm4DlGyiHlknsIBK7D6NW5UBHJvylrpP3WVGEfALL1Kn9wOOdhhiUviUqA0R
	 cTtjN0rHcBYuHkuuQPKX3eNKtkVj/4ATIxUuNbApBix4C90GpX/SH347B/9e/lcDVt
	 82/OaQY17WFYIuU3MPSYkq6pPXTtaNCPtnfwA500sA/LYXoOaLfwu2NcEjRVMy8jxX
	 niUsR73pFxkZ2ZtHKRYXDnyhA4oP3x+JL6mCZgbqUY2ByOOEPMeFQiGXRuy32lfTc3
	 a2It0n7CPwQFpbIEFLyEtviIJL0H+XGpIeGuiTQi08kN6nB9vaGCH+wxr8YIxPlmZL
	 OOC66NyiMxauA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 Dec 2023 06:06:07 +0200
Message-Id: <CXF93VL1O8O7.2LPY54797XGBN@suppilovahvero>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: <linux-integrity@vger.kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "William Roberts"
 <bill.c.roberts@gmail.com>, "Stefan Berger" <stefanb@linux.ibm.com>, "David
 Howells" <dhowells@redhat.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Mimi
 Zohar" <zohar@linux.ibm.com>, "Mario Limonciello"
 <mario.limonciello@amd.com>, "Jerry Snitselaar" <jsnitsel@redhat.com>
Subject: Re: [PATCH v5 0/8] Extend struct tpm_buf to support sized buffers
 (TPM2B)
X-Mailer: aerc 0.15.2
References: <20231121223130.30824-1-jarkko@kernel.org>
 <20231128144235.GA44537@mail.hallyn.com>
In-Reply-To: <20231128144235.GA44537@mail.hallyn.com>

On Tue Nov 28, 2023 at 4:42 PM EET, Serge E. Hallyn wrote:
> On Wed, Nov 22, 2023 at 12:31:12AM +0200, Jarkko Sakkinen wrote:
> > This patch set extends struct tpm_buf to support TPM2 sized buffers, an=
d
> > adds reader functions for parsing more complex response data.  It is
> > implemented to support smooth landing of [2]. Sealing of the TPM2 trust=
ed
> > keys is updated to utilize the new functionality, and thus provides a
> > legit test case for it.
> >=20
> > TPM2 sized buffer, i.e. the buffers in TPM2 format, are defined in the
> > section 10.4 of the TPM2 Structures [1] specification.
> >=20
> > Here's the smoke test that I've run for TPM2:
> >=20
> > /usr/lib/kselftests/run_kselftest.sh
> > tpm2_createprimary --hierarchy o -G rsa2048 -c key.ctxt
> > tpm2_evictcontrol -c key.ctxt 0x81000001
> > keyctl add trusted kmk "new 32 keyhandle=3D0x81000001" @u
> > keyctl add encrypted 1000100010001000 "new ecryptfs trusted:kmk 64" @u
> >=20
> > [1] https://trustedcomputinggroup.org/resource/tpm-library-specificatio=
n/
> > [2] https://lore.kernel.org/linux-integrity/20230403214003.32093-1-Jame=
s.Bottomley@HansenPartnership.com/
> >=20
> > v5:
> > - Fixed glitch in tpm_buf_read() reported by James Bottomley to the v4.
> >   Was forgotten from v4.
> > - Remove a spurious memset() call introduced in v4.
> > - Allow command buffer tag to be initially set to zero (caused spurious
> >   warnings).
> > v4:
> > - Cleaned up the bit too spread code changes based on the v3 review.
> > - For testing instructions see the previous cover letter, and use
> >   linux-v6.6.y branch:
> >   https://lore.kernel.org/linux-integrity/20231024011531.442587-1-jarkk=
o@kernel.org/
> > v3:
> > - Resend with rebase to the latest upstream.
> >=20
> > Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Cc: William Roberts <bill.c.roberts@gmail.com>=20
> > Cc: Stefan Berger <stefanb@linux.ibm.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > Cc: Mario Limonciello <mario.limonciello@amd.com>
> > Cc: Jerry Snitselaar <jsnitsel@redhat.com>
>
> I'm not an expert in this area, but my interest is piqued when I see
> tpm/tpm2, so I took a pretty close look, and all looked good to me
>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>

Thanks for the review and comments!

BR, Jarkko

