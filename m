Return-Path: <linux-integrity+bounces-4072-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BE89C0FEB
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 21:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C9AA1F239DC
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 20:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9BE217F5B;
	Thu,  7 Nov 2024 20:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBnqzg2h"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069F9215F58
	for <linux-integrity@vger.kernel.org>; Thu,  7 Nov 2024 20:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731012262; cv=none; b=jQ+T3oui5YmkF3AZOv7NPCHRF7hKomPrvncFQx2jDYF+/HV14cCywhH7shwWE+Tkzaxn+G0Tsx7G+iYIjI81lT5t51YR00hdJlCP9cwkuQfAaqsrxCB6GWRbTSLs9aVDSJHY1WhEA39aKPkKEeFAgutIuAX/c6XBOt0Uj0Iod2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731012262; c=relaxed/simple;
	bh=B8Y8OkGWI2fX/fv0BgHUAhEPwzz0uS/T6OS8xlAC0Xs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NJi1fWAE18HOeg98QJRjGqi/uvHE2mOmGHZyEU9EFLV5vlWEPJdqi13AHs5dUrVEB2GhSgV6NkZkRU7Zm66/zfAn7qhArFGhF6V6lQAOTy2Io/1pJhcanNxG1hiE88lE1aTzEKL0VVnVT92jEYhzY+ggn9iAG+kJq5A7tAX+l44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBnqzg2h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68919C4CECC;
	Thu,  7 Nov 2024 20:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731012261;
	bh=B8Y8OkGWI2fX/fv0BgHUAhEPwzz0uS/T6OS8xlAC0Xs=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=uBnqzg2hwmiCgUvFvyXjR/lUS3XOI2I+DvQWlS3q/bzZiCfmXP/wy1RFXTJeWhCCx
	 5os/vGoZ95P1/MRKlwyxMGquYXjRgKB/Szjo9bt/h5BQ12J72iMrHHCKyZChQC+zo6
	 1DzvS6QARsVzvtBHo3zdr7yxRYY36waFwRQqsUNslIGyHBojt/GBANOLeHFPZAA1oz
	 P+ZBUYeUfrgph4x11TmsXMhXXKrZ2jcTSkJPu4pe1AivWr2skv5T2CN99f6IHB1mN2
	 zgaK/o1ZB/nnn9pFAvJOFCwvV97lk34Fl8ZpI8K0riMWNWKHKlpYUS4tpNpv3ue1YX
	 sI1SaNlBkOc6A==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Nov 2024 22:44:17 +0200
Message-Id: <D5G8MT5N7M3M.3PW6KDINE6GEF@kernel.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <linux-integrity@vger.kernel.org>, "Andy Liang" <andy.liang@hpe.com>,
 <jenifer.golmitz@hpe.com>
Subject: Re: [PATCH] tpm/eventlog: Use kvmalloc() for event log buffer
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Takashi Iwai" <tiwai@suse.de>
X-Mailer: aerc 0.18.2
References: <20241107112054.28448-1-tiwai@suse.de>
 <D5G8DXQ15SFC.SDV9NC2LH1CF@kernel.org>
In-Reply-To: <D5G8DXQ15SFC.SDV9NC2LH1CF@kernel.org>

On Thu Nov 7, 2024 at 10:32 PM EET, Jarkko Sakkinen wrote:
> >
> > This patch replaces the devm_kmalloc() call with kvmalloc() to allow
> > larger sizes.  Since there is no devm variant for kvmalloc(), now it's
> > managed manually via devres_alloc() and devres_add().
> >
> > Reported-and-tested-by: Andy Liang <andy.liang@hpe.com>
> > Cc: jenifer.golmitz@hpe.com
> > Link: https://bugzilla.suse.com/show_bug.cgi?id=3D1232421
>
> "You are not authorized to access bug #1232421. To see this bug, you must
> first log in to an account with the appropriate permissions."
>
> Please remove  this link as it gives no information without login
> access, *or* make it available w/o acocunt, *or* repost a bug to the
> kernel bugzilla.
>
> I've been cursing SUSE accounts for over a year now. Never been able
> to successfully get either to the bugzilla or forums (still I get
> some weekly spam about the forums). And no, no interest to recall
> or figure out this problem.

Just a personal recommendation but I'd create a bug to kernel bugzilla
and link that to the SUSE bug, and call it a day ;-) It would be the
least friction approach.

BR, Jarkko

