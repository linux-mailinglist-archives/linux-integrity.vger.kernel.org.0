Return-Path: <linux-integrity+bounces-4121-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A2D9C8243
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2024 05:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2721F2172E
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2024 04:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F05166F06;
	Thu, 14 Nov 2024 04:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQBKufPW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622BF1553AA
	for <linux-integrity@vger.kernel.org>; Thu, 14 Nov 2024 04:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731560173; cv=none; b=AZucNeg4WkOuGuKrfK/3xSO1cxUd7N3lHlJ/9NEjLNBlYrVVt5TgEmKAMvVTNPm4dVUou1UIB8pgK9aMZC5zd+C7kzl5l5aEjvVXx99TT1RFXJMWXYFM6KUFdar9/K4cPyg3i6Kr+y2Z92jodUELAJ9C2k1UgDTixx3kcfEkwSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731560173; c=relaxed/simple;
	bh=p60hAPPH21jwDnMY9oEW+Q22IUamAUeNy9tcW7EMmSg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=rc9RMsCei2P4T3r65FnrEQY2IFA21+GmRu5pZcfhB6pszXiMb57zGkXIOn0N5OGrUF6NAELMPwVDxiy+izy9+ic1njzPONshLpYlPTKHuRfGn/vWmkGJGXDwIY6PC/2ffXNq5vxOLDEvBpXDFPIKW/OfjT74tlJfSUAYCl8wUAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQBKufPW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72350C4CED0;
	Thu, 14 Nov 2024 04:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731560173;
	bh=p60hAPPH21jwDnMY9oEW+Q22IUamAUeNy9tcW7EMmSg=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=oQBKufPWcaAwgvqeU+uEwJwtE5dMxUUvA2vJRhcrqQq2H8xSB98unm8KQspfDejQQ
	 sbIuNeaiP4r70PAmc43R1nQ73YuycbDKVvue1BCBIme8m4XISSxRKWSnvQg/dxxVW6
	 UENFMZjDXOyEcRfIRyHOlpCM7ebN5hhXvAhUYPo2dohwq/ULHk++66NcP8RxHNQAGI
	 NKzBU7DjeY8zM12Vqna216jjrim8CkyrbNq04+Wh1N1o8YqIdDEthuAWnkpOJtTAyW
	 PtdXSad5tvK2kD+DaVlgNdWAdxpEUsAV8s3kQ2DePrStZfDAL6p7poohNmNOdlmRLa
	 t5Ep5LKMx1qQQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Nov 2024 06:56:08 +0200
Message-Id: <D5LMUO2NNWFK.390DHBIZ06SMD@kernel.org>
Subject: Re: regression: kernel log "flooded" with tpm tpm0: A TPM error
 (2306) occurred attempting to create NULL primary
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>, "Christoph
 Anton Mitterer" <calestyo@scientia.org>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <693caa85c3ee1b3117a562894971de60b6842d00.camel@scientia.org>
 <8fe12e2eb9beb159d2af8462fa0b9b1f946deacb.camel@HansenPartnership.com>
 <c1b56e93bd7e92d5313fde89dc0ee09fdd4c8577.camel@scientia.org>
 <05f511502a5918fe81d69201ec3df01b25803bcd.camel@HansenPartnership.com>
In-Reply-To: <05f511502a5918fe81d69201ec3df01b25803bcd.camel@HansenPartnership.com>

On Thu Nov 14, 2024 at 4:06 AM EET, James Bottomley wrote:
> Getting the TPM messages to quiet by disabling the chip fixes the
> message spew, but it doesn't get you a working TPM chip back on resume.
> I'll take a look at the hibernation path and see if I can see a hook we
> can use to bring the TPM back.

Fixing hibernate issue could not be done in the same patch as it is=20
a different bug logically that I fixed. The hibernate bug pre-existed
in your original code.

So my fix was not about at all masking a bug, it was about fixing a
bug in my own previous fix. I.e. even you had a fix for hibernate, this
patch would have been needed separately.

BR, Jarkko

