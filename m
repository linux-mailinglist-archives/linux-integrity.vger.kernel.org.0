Return-Path: <linux-integrity+bounces-4122-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D289C8244
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2024 05:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C931F21D13
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2024 04:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E5A1632DA;
	Thu, 14 Nov 2024 04:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+AF3Pap"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16EB1553AA
	for <linux-integrity@vger.kernel.org>; Thu, 14 Nov 2024 04:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731560271; cv=none; b=dBFDf6Cn9TBIPErUwCHxUN/D/dMsxaDWnPdEpckzOYe5J+DtYRIkZXLaoMK65qvAuMQHHxheQONWrSMMTNPTUcnIgH7001fTmicW5aTv+RE+yNaMpmOGWKbYc/muT4CQVMlmfk7ja7FcMLvq7beOyfW4xV/tbGD1jv6Bv2kZpxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731560271; c=relaxed/simple;
	bh=1B+mlijhN2cFMHycNnNZWopYMGwXUkUC/MSps4eX0Ko=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:From:
	 References:In-Reply-To; b=WpSoHhXdx/UgyJj10QmGcNRj55+N5NyaltcffIZ2mRocjZONpShxZBCAxe6IO5Irwyl56YO6+o8KfdXWV0je6PosB7Uu+8G8ryUS0luUNWAplLn42OIZMDirFfy+JZOSJBbtYbTQCFBdE3znvHi7CWFRC9IP9LIiWSt+X6IEf/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+AF3Pap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42410C4CED0;
	Thu, 14 Nov 2024 04:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731560270;
	bh=1B+mlijhN2cFMHycNnNZWopYMGwXUkUC/MSps4eX0Ko=;
	h=Date:To:Subject:From:References:In-Reply-To:From;
	b=L+AF3PapQOMutEOlojHv3WdswtACAxRPzHKhpM3UfAJzmVFd9g4hUwDaTcwcaWCQt
	 gjdYRsQVzlJgE2A7nXoTNfBO03XYYsEDe/NBJpcfqKLSgO6jJEDHFJfBRpnjCc411C
	 P7FAPTK2pnu0KgAqFRUrL8UgK2HCWHs7vEyvQ0ynnz3Lt4jj/GtSoU3cJ3pweZZlQr
	 jBb1bf1iHdZsviD/Ln5erkGxlSz4Fsboc0FQPwQBUmQR7mbv1UR/tvILmBhSFutKRT
	 bbAWjJUVyOKEVcaKwh1YuVgJzvm+C3/1iK8qLjfaiikTiSy07YaLaFCwMACICEJgAa
	 VGgvgKvgJb+DA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Nov 2024 06:57:46 +0200
Message-Id: <D5LMVWUBX2FK.205ZHBLQKY7SB@kernel.org>
To: "Christoph Anton Mitterer" <calestyo@scientia.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, <linux-integrity@vger.kernel.org>
Subject: Re: regression: kernel log "flooded" with tpm tpm0: A TPM error
 (2306) occurred attempting to create NULL primary
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <693caa85c3ee1b3117a562894971de60b6842d00.camel@scientia.org>
 <8fe12e2eb9beb159d2af8462fa0b9b1f946deacb.camel@HansenPartnership.com>
 <c1b56e93bd7e92d5313fde89dc0ee09fdd4c8577.camel@scientia.org>
 <05f511502a5918fe81d69201ec3df01b25803bcd.camel@HansenPartnership.com>
 <6b66684616408e2f9576bd5eca5ab58254a69438.camel@scientia.org>
In-Reply-To: <6b66684616408e2f9576bd5eca5ab58254a69438.camel@scientia.org>

On Thu Nov 14, 2024 at 4:17 AM EET, Christoph Anton Mitterer wrote:
> On Wed, 2024-11-13 at 18:06 -0800, James Bottomley wrote:
> >=20
> > Getting the TPM messages to quiet by disabling the chip fixes the
> > message spew, but it doesn't get you a working TPM chip back on
> > resume.
> > I'll take a look at the hibernation path and see if I can see a hook
> > we
> > can use to bring the TPM back.
>
> Sure, but actually I don't use TPM anyway so for me the main point was
> really just the nuisance of the repetitive log messages O:-)
>
> Still, it would of course be nice if you get it properly running after
> hibernation.

Yeah, my point and fix was about denoting that there was actually
*logically* not one but two bugs, you can blame for the noise bug
:-)

Rare occasion but in this case it was for better that I caused the
noise bug so that we noticed hibernate having issue....

>
> Thanks,
> Chris

BR, Jarkko

