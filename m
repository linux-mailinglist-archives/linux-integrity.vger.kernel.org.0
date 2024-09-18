Return-Path: <linux-integrity+bounces-3639-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CAD97C102
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Sep 2024 22:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70121B21F74
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Sep 2024 20:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658BF1CA6A1;
	Wed, 18 Sep 2024 20:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfI4HXkB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3682D6FC5;
	Wed, 18 Sep 2024 20:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726692818; cv=none; b=Q44EJgkSAbZHHQE1ARnVGOpKL2axnN/2TRw/L6mq0NGVNkR8G8Di0nqLOwe9hKYqLVu5RHFtjDflnpYlL7ddcV+v9srd8u7CYpF46nOtWFYZSSRKCRIJIV0W7WFUhWqpwDgprmRZ4dYpvPzuh7qvq4FaYXTVkmfj7uhrMPXGvMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726692818; c=relaxed/simple;
	bh=wIhDeXXB4S522gN8pLOWl4qQNJtr59P6PblsXYCvOKg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Lo5ODzNh7D6kmnyODDgRp84ivDZKoDqehyQrDwlZbSTo4BuEcS79YPeeInsr/60uHtWiPEOeiSPbMGIdlDOz/zfWOxsKWEMMYZXtjrnaQT8W1/TuhbQc+gm021+zACiewBkSwthB6LmgBGVC//ijH1xCWhS84YfX3duoUG1OzCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfI4HXkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F573C4CEC2;
	Wed, 18 Sep 2024 20:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726692817;
	bh=wIhDeXXB4S522gN8pLOWl4qQNJtr59P6PblsXYCvOKg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=SfI4HXkB1RGRwTg+i00/q530rNutAIXYOU2umJchPKMgfBDCZd5b2DdgLENCnsa7h
	 Oko1XLylpMUGZkLhKD9LxnBfdU2CBBA042M5Fk3NsbNzMs/WU5OelmOs5S5OUGf2AA
	 PMc62Qs1CpnyFMZLI4bwMjC6G+LiZtlxDDAL9iky+dyte7Donb/ZeMflDSIGFKrNTE
	 SkiqIAYAkiSBGBiBIuHTEugH5yCLJb81+9RliFV/w+5ETKv6iSRcU46NWiqkQEWVwl
	 b04BHDNLUJhCzMZgd2ShbzqQnKzKQbt7DPrC7nTI/+jqPzIzETtjp1fatX+hh9oCNv
	 Nq1XnZgdkIRHw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Sep 2024 23:53:34 +0300
Message-Id: <D49PIO2Z1B73.EQC8TYK16AL@kernel.org>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.12-rc1
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "David Howells" <dhowells@redhat.com>, <keyrings@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <D48OZ7EPSJB7.2YEWVMTAYHQXH@kernel.org>
In-Reply-To: <D48OZ7EPSJB7.2YEWVMTAYHQXH@kernel.org>

On Tue Sep 17, 2024 at 7:15 PM EEST, Jarkko Sakkinen wrote:
> 2. https://lore.kernel.org/linux-integrity/20240917154444.702370-1-jarkko=
@kernel.org/

I shrunk down the patch set to bare minimum and labeled all patches as
bug fixes, as we will need these also for 6.10/6.11 trees:

https://lore.kernel.org/linux-integrity/20240918203559.192605-1-jarkko@kern=
el.org/

With v3 boot went down to 8.9 seconds according to the reporter. I think
we can do small tweaks and take this a bit further over time (one thing
I'm looking into might be postponing hwrng registeration).

BR, Jarkko

