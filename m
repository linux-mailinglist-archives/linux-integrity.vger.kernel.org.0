Return-Path: <linux-integrity+bounces-3494-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1692196F9F7
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 19:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 927BCB235FA
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 17:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238241D3653;
	Fri,  6 Sep 2024 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiYAylp8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86D0200DE;
	Fri,  6 Sep 2024 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725644185; cv=none; b=ZgLq+elWhlqpWBxCWNTcckrPFg3xIIR/aFnXGT7iTaLtEIESt56f8T186I4ITkfgoy/gtZ9qQ0zH5wH37yABDxvFMx39WVzr5dDeezLBegK9KyAOlXACcoutO/ZNopKhzm1MOlc60fRIZiuRpTosTYcBmJsTrcgACnI9wuAhTTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725644185; c=relaxed/simple;
	bh=aRfeEhcEuH0P68oO5jth9G8d0DHMgdo2eFNaf8ND4CU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JumENf3Ju2AA7uF8t1cNux+H+YbA4J9XRXjdVBPBHpppyPTlyGfEn90GHHlpzo8/7GqoEEbi/3b0TLJQpCRsK3xUdZUUKumzATWq0/0dFI2IAgo/d4jOwfgFnDlc0a1D/MEI78Z+k7QFWQeR4UZkNedBYZcpYVcqJfWZwTsbQ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiYAylp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99CEC4CEC4;
	Fri,  6 Sep 2024 17:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725644183;
	bh=aRfeEhcEuH0P68oO5jth9G8d0DHMgdo2eFNaf8ND4CU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=IiYAylp8CKShIMa2CwTo5hOFj5Ou5ORqkhXh4ALP/uL5r2RmE3NQD4ikpySJ7yIe0
	 OV9Sa8tfznO4aV+9PBk99hAJWxcLYPqrlFaO1ANw8rDjXPdMudJqGceq7lMmYcERyz
	 cPNMd5b//NKZ6k089LXuwysoq3KdzVXUFnmIApsNI58w+2yzhfolz9bOzXEfX87X5x
	 cw09R36oznw9eF8jyrnRqk9MD8U33KcFILVqPBKCfFjGkhp23Vo9NUXpeIzqrDpV8x
	 pb/mhpnNdwCMy1MOI7jp2hn6JkjaqNlO3Vwt+1we3DH/LDpQvVrqIt4TYOCFwbu/4G
	 gXU/fb+3DM71A==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Sep 2024 20:36:19 +0300
Message-Id: <D3ZDT3Z8MZ40.1ZT3K2C7JPYMF@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <mpe@ellerman.id.au>,
 <naveen.n.rao@linux.ibm.com>, <zohar@linux.ibm.com>,
 <stable@vger.kernel.org>, "kernel test robot" <lkp@intel.com>, "Mingcong
 Bai" <jeffbai@aosc.io>
Subject: Re: [PATCH v2 RESEND] tpm: export tpm2_sessions_init() to fix
 ibmvtpm building
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, "Kexy Biscuit"
 <kexybiscuit@aosc.io>, <linux-integrity@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
X-Mailer: aerc 0.18.2
References: <20240905085219.77240-2-kexybiscuit@aosc.io>
 <D3YF52E4EVJ0.2ZJSCR5FCVIGX@kernel.org>
 <603acd64-0a6d-470b-9c9b-f6146443dc0c@linux.ibm.com>
In-Reply-To: <603acd64-0a6d-470b-9c9b-f6146443dc0c@linux.ibm.com>

On Fri Sep 6, 2024 at 8:02 PM EEST, Stefan Berger wrote:
>
>
> On 9/5/24 10:26 AM, Jarkko Sakkinen wrote:
> > On Thu Sep 5, 2024 at 11:52 AM EEST, Kexy Biscuit wrote:
> >> Commit 08d08e2e9f0a ("tpm: ibmvtpm: Call tpm2_sessions_init() to
> >> initialize session support") adds call to tpm2_sessions_init() in ibmv=
tpm,
> >> which could be built as a module. However, tpm2_sessions_init() wasn't
> >> exported, causing libmvtpm to fail to build as a module:
> >>
> >> ERROR: modpost: "tpm2_sessions_init" [drivers/char/tpm/tpm_ibmvtpm.ko]=
 undefined!
> >>
> >> Export tpm2_sessions_init() to resolve the issue.
> >>
> >> Cc: stable@vger.kernel.org # v6.10+
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Closes: https://lore.kernel.org/oe-kbuild-all/202408051735.ZJkAPQ3b-lk=
p@intel.com/
> >> Fixes: 08d08e2e9f0a ("tpm: ibmvtpm: Call tpm2_sessions_init() to initi=
alize session support")
> >> Signed-off-by: Kexy Biscuit <kexybiscuit@aosc.io>
> >> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
> >> ---
> >> V1 -> V2: Added Fixes tag and fixed email format
> >> RESEND: The previous email was sent directly to stable-rc review
> >>
> >>   drivers/char/tpm/tpm2-sessions.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-=
sessions.c
> >> index d3521aadd43e..44f60730cff4 100644
> >> --- a/drivers/char/tpm/tpm2-sessions.c
> >> +++ b/drivers/char/tpm/tpm2-sessions.c
> >> @@ -1362,4 +1362,5 @@ int tpm2_sessions_init(struct tpm_chip *chip)
> >>  =20
> >>   	return rc;
> >>   }
> >> +EXPORT_SYMBOL(tpm2_sessions_init);
> >>   #endif /* CONFIG_TCG_TPM2_HMAC */
> >=20
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> >=20
> Would have tested it but machine is down..
>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

I'll add this before the PR, thank you.

BR, Jarkko

