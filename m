Return-Path: <linux-integrity+bounces-2103-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 707198A3ED5
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Apr 2024 23:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B12281547
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Apr 2024 21:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2983548F0;
	Sat, 13 Apr 2024 21:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mX2Kll+Y"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE5F5473D
	for <linux-integrity@vger.kernel.org>; Sat, 13 Apr 2024 21:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713044605; cv=none; b=di7xAv/AZhRN/jBppdrveoqDZnAP8JFXbUfe/s7RrJQhYpXKHk+3VyOAt4u3cvBkCbKIneJ6gDnzgXTd5fU1knHhF9+SgBATcZ97NTTs1qADrh+wkUw6Wqj8uyRREHKoyxsj8MwRKmWrPYhp1j8n3I+yC1Gb/klVB6vWXdsLJ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713044605; c=relaxed/simple;
	bh=Zp37eyYFV7+VD40b7IFn8E0PLAAldwpnR38yPH0w/90=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=InSkYGlE3ucLIFcwnJXErfa8lJsrEsUx+1Dsat1Wsgvdee2byxPerX9ha5oJMxEKfjfCgFJkyIxXHv+vUmoNUcoqdgAiBLqSDTmfVz/xJHww3dOc+BxYxMRKV7fUNr9KCweFoR+WxREiLCp+D/pWAVj6gP1SY7NDzgcSr4nypD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mX2Kll+Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FE6C113CD;
	Sat, 13 Apr 2024 21:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713044605;
	bh=Zp37eyYFV7+VD40b7IFn8E0PLAAldwpnR38yPH0w/90=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=mX2Kll+Ykk5lK3LVX5vra5ESNsBoWhL5HIIuW59QMuC5RIG6KXQkMw904VNbF9ISh
	 2gNcmefnrk0WQ869qhLej3n3p/+aBtNhGnBRdoy69KAayw42IzpIgaarbK5g2jO3ZE
	 aWWMrB07ZdK1v8drCym1UlAJPvyVs8TMXQZVZw6LaTlGPJRF2anfm5wZ92ifNHuScP
	 5QdR9ZAcankhDNlYI8TfewbIX7VkC6b3miZB0U/3s7kZa+/bLxpCNSTVf4zD7yG0AG
	 d4I5d9nnnjDI4jHGsonVyZo7i/7ERZU11+bwSM2d8M7JJILAfGRGD7qJRWZFqCVMMB
	 MuSjud6oKkbhg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Apr 2024 00:43:22 +0300
Message-Id: <D0JBMQ8POIZ5.3A7ZIQY5PW9SM@kernel.org>
Cc: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>, <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
 "Takashi Iwai" <tiwai@suse.de>
Subject: Re: TPM error 0x0901, possibly related to TPM2_PT_CONTEXT_GAP_MAX
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "William Brown" <wbrown@suse.de>
X-Mailer: aerc 0.17.0
References: <424B3F10-D91C-4F47-B33C-BB66FE4DB91A@suse.de>
 <D0BFJLQ0JKO4.20EW2ZA8GIS5Z@kernel.org>
 <D0BFMGM02V7A.1HEWQ05350K07@kernel.org>
 <6857f043301a100ee93b3ea120a2d1d60e83efdb.camel@HansenPartnership.com>
 <D0HNST37O7G8.3A722951U878Z@kernel.org>
 <C1E92886-E7ED-4425-8A31-22FE196C5218@suse.de>
In-Reply-To: <C1E92886-E7ED-4425-8A31-22FE196C5218@suse.de>

On Fri Apr 12, 2024 at 2:21 AM EEST, William Brown wrote:
>
>
> > On 12 Apr 2024, at 08:50, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >=20
> > On Thu Apr 4, 2024 at 6:49 PM EEST, James Bottomley wrote:
> >> On Thu, 2024-04-04 at 18:09 +0300, Jarkko Sakkinen wrote:
> >>> [...]
> >>> Emphasis that I might have forgotten something but this is what I can
> >>> remember right now.
> >>=20
> >> What you forgot is that I did originally proposed session degapping in
> >> the kernel resource manager but it was rather complex, so you made me
> >> take it out for lack of a use case.  It dates back to when we used the
> >> old sourceforge tpmdd list which seems to have caused message loss, so
> >> I'm not sure how complete this thread is:
> >=20
> > I might be forgetting some detail to contxt gap but since kernel flushe=
s
> > every single object per transaction contextCounter should be updated al=
l
> > the time and thus there should not be too large gap that would cause
> > emitting this error.
> >=20
> > I quickly reviewed section 30.5 for architecture specificaton to check
> > if I got it right and it says that: "On receiving this error, the
> > management software either would explicitly flush old session contexts
> > or would load the old session contexts to update their associated
> > counter values.."
>
> The issue is that we *are* flushing session contexts and this error is st=
ill occurring.

Was there a way that I could reproduce the same workload or something
simpler that would reproduce the issue on my side?

BR, Jarkko

