Return-Path: <linux-integrity+bounces-6811-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEBFB24313
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Aug 2025 09:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF5367208EF
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Aug 2025 07:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4032DEA7D;
	Wed, 13 Aug 2025 07:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtbufPc1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068241E9919
	for <linux-integrity@vger.kernel.org>; Wed, 13 Aug 2025 07:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071305; cv=none; b=WCgv3Wp06POawHNbKOFMnxoNVu0nW2I9fFlFeo8w/ANf9vWXDdPxJ9lri5/8nuavav1bONYvKvwMTKPJOVkZybo0UezT1E99WXov/KpT1rFus07MNIBAo1pqgc5btWD4RT7wlxxYmCQA5Sx5fT7lHucT7cHMEy8m8mfePJug6Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071305; c=relaxed/simple;
	bh=/qe7/veHT/8a86yjIcY4zZHWegwAdhC1Or/F4GIykqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSkCyDqBq9bIilr3I2W3o67BPCeYV5FjZIBjifMpAkf07sLb1Odr9UcRX+8qj3aXCgaXeyyBicDxI/foFtgvaVr0Mt00Z4gyJ9jD/szbhAUcPvyGnPHEBMLTGle1TYP3Q3oKhoInGAvv+DoXoZgwWuruQN7pAFmZrelG2eJ1hhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtbufPc1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49608C4CEEB;
	Wed, 13 Aug 2025 07:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755071304;
	bh=/qe7/veHT/8a86yjIcY4zZHWegwAdhC1Or/F4GIykqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QtbufPc1P+IMRgUkqH5nA2XMUfx9CQmeb5FPgJDCAeL6MVnOFZrcR6eKdCbVXc3TM
	 +7dRczbFXEIV3wrjEjkxD0SGSe1AIL82ANe4z5OdCLs5SzLiWdcngO17wtD3ni3eNh
	 dr6ccJiUefTmsrFJUrk11oa/s+GRPdpk3uM/nWWVV/IGyosLyTS0HCkGrv+d/YxbID
	 X8IwhMdxaVCXWcFY9anVd8gx6290fY1/1poc/BOKWVbtc/9akPmuGTk1crdq8YWjVi
	 Q23+y+5AMnVxhEHBlWMqcrQL2wdoukwVQD0HhC4RJQAynJJKtHxuidAoLFpsANBzm8
	 dqCPwp42M521A==
Date: Wed, 13 Aug 2025 10:48:21 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Denis Aleksandrov <daleksan@redhat.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	Jan Stancek <jstancek@redhat.com>
Subject: Re: [PATCH] tpm: prevents local DOS via tpm/tpm0/ppi/*operations
Message-ID: <aJxDRb5KJUTc-dL9@kernel.org>
References: <20250702202851.33344-1-daleksan@redhat.com>
 <aGW2wabMXtdBEQxR@kernel.org>
 <CAG+gbFfKLCQND-TT8DEZ09T=Nhb39_CJfM5imv341Pen03bHjw@mail.gmail.com>
 <CAG+gbFfLP1Y=HgRfzjhT4uJ121keQ0ZKo=4saB3uqnZYyoV8JA@mail.gmail.com>
 <CAG+gbFcgfZALHCAxaMmWkNQX2sKgkc-HBJrYXdmehsqLidG_tA@mail.gmail.com>
 <aJtl4MOJ5hYU7mWy@kernel.org>
 <CAG+gbFfY=YZZ24dZpBtShc+4ypGJgngsz7X32XKaHZ90s3okFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG+gbFfY=YZZ24dZpBtShc+4ypGJgngsz7X32XKaHZ90s3okFg@mail.gmail.com>

On Tue, Aug 12, 2025 at 05:13:32PM -0400, Denis Aleksandrov wrote:
> Hi Jarkko,
> 
> Thanks again for taking the time to review this patch.
> 
> Regarding the `Closes:` tag warning, this issue is linked to an internal Red
> Hat page, which is why 
> it was omitted. Therefore, this warning might need to be ignored.
> 
> For the other warnings, I considered using either symbolic or octal permissions
> before submitting the
> patch. I decided on symbolic permissions because that style is used
> consistently throughout
> `drivers/char/tpm/tpm_ppi.c`.
> 
> When I tried changing the permissions to octal format, `scripts/checkpatch.pl
> --strict` still flagged those
> lines with the following warnings:
> 
> ```
> WARNING: Reported-by: should be immediately followed by Closes: with a URL to
> the report
> #13:
> Reported-by: Jan Stancek <jstancek@redhat.com>
> Signed-off-by: Denis Aleksandrov <daleksan@redhat.com>

Lemme check today, if I could give some feedback and help out with
this.

BTW could you use plain text in your emails? I know kernel people who
drop automatically HTML on this address. It's cool, I'm tolerant but
it's the standard :-)

There's a page for this too:

https://www.kernel.org/doc/html/latest/process/email-clients.html

Also, vger drops HTML mails, meaning that this response will arrive
there but your response that I'm responding most likely not (at least
vger used behave this way).

BR, Jarkko

