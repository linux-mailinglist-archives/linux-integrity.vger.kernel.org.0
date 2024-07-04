Return-Path: <linux-integrity+bounces-3001-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD16692791A
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2024 16:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0CD1C22948
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2024 14:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAD51AED31;
	Thu,  4 Jul 2024 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxJiLyDO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121EF1AE0AB;
	Thu,  4 Jul 2024 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720104358; cv=none; b=sRIymJfShbzb9UZ+rRY64yj1BenRUMrQjNJVBCan8+X8rPl77DYOBoF6v4JYa369JiJPlSoxiDvTmSJHVqvF1zehEQAdQ2JZkzcv7l/bCo0eypGqSyZs/ekiCn4bHSMQZ+5UBinwRiMqkEWXnGh02sdhfifzXUCOMnusbhWym0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720104358; c=relaxed/simple;
	bh=VNx0ZjDb8+kmHLzs3w/SQLmxZ0fgDInqhkK3KV20yJ4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JbiNHpUfluVpwlqgR6XPopH7+nqzim+LmMF/HtWr6Q20334t2SUzqYpv9z2z/Y+L1G5fl8cZfhpzui2QXoSVUlMT/BOFFTOOpQasfFDOmsdPUFIKGXdwReDNAXLztjeijMhXJoUCbXZfBA83oeps5PSc9QsS4ewGRnbLlm5wSbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxJiLyDO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE8BC3277B;
	Thu,  4 Jul 2024 14:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720104357;
	bh=VNx0ZjDb8+kmHLzs3w/SQLmxZ0fgDInqhkK3KV20yJ4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=YxJiLyDO1LviZNkUfgCBFmukLUJQv7uznSUB+E4eqnKPoc5/L2KhEZ7Fs8/e4ZlF1
	 w5wzheSyUgxWuIVb2Erx2TnbpuX4aaK/L8e4gB1hdZQnHFNf6YdsQid2uiJO5m0r6L
	 ZgMof75k7DCWitUEfO0szLfKD6Ay6g/xmcxmm8NrV4zMU4S2JeW3FMqT+2HqGNuvLo
	 VGfkkPeBYYcZcXg823H2+wR/Elv+yjgFfFVkJs1jIdHbQFulDeKDu4Yx4kW8gumAAq
	 zGac+VEZG5sH/o3PdOXIGiENnwpkYFBBhleIJYpxqa+XHJpMlLxGccj1y1NkyGyjfG
	 ft6dsUOy7X3/A==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 17:45:52 +0300
Message-Id: <D2GU3QOR9Y2O.2OXK62J2V9C2T@kernel.org>
Cc: "James Bottomley" <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, <keyrings@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/3] Address !chip->auth
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Michael Ellerman" <mpe@ellerman.id.au>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240703170815.1494625-1-jarkko@kernel.org>
 <D2G2QR0DMG8B.R0B95Z5T5YAF@kernel.org> <87v81lia1d.fsf@mail.lhotse>
In-Reply-To: <87v81lia1d.fsf@mail.lhotse>

On Thu Jul 4, 2024 at 4:03 PM EEST, Michael Ellerman wrote:
> "Jarkko Sakkinen" <jarkko@kernel.org> writes:
> > On Wed Jul 3, 2024 at 8:08 PM EEST, Jarkko Sakkinen wrote:
> >> Tested on x86-64 with:
> >>
> >> - TCG_TPM2_HMAC disabled.
> >> - TCG_TPM2_HMAC enabled.
> >> - TCG_TPM2_HMAC enabled, and "/* rc =3D tpm2_sessions_init(chip); */".
> >>
> >> Jarkko Sakkinen (3):
> >>   tpm: Address !chip->auth in tpm2_*_auth_session()
> >>   tpm: Address !chip->auth in tpm_buf_append_name()
> >>   tpm: Address !chip->auth in tpm_buf_append_hmac_session*()
> >>
> >>  drivers/char/tpm/Makefile        |   2 +-
> >>  drivers/char/tpm/tpm2-sessions.c | 400 +++++++++++++++++-------------=
-
> >>  include/linux/tpm.h              |  75 ++----
> >>  3 files changed, 245 insertions(+), 232 deletions(-)
> >
> > Aiming these still to 6.10 so that there would not be known regressions
> > in hmac authenticated sessions. Note that issue is wider than "just"
> > tpm_ibmvtpm.
>
> This seems OK on my PowerVM box using tpm_ibmvtpm and TCG_TPM2_HMAC=3Dy.
> I do see one new message:
>
>   [    2.475208] tpm2_start_auth_session: encryption is not active
>
> But no error messages like on mainline.
>
> Tested-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Thank you, appreciate this!

BR, Jarkko

