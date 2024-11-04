Return-Path: <linux-integrity+bounces-4017-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDEA9BB86F
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 16:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E2DE285197
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 15:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D412B9A2;
	Mon,  4 Nov 2024 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLiDcTN4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076291F60A;
	Mon,  4 Nov 2024 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730732591; cv=none; b=I9BCmc5GbTpdBaiqd5wgJ5oYbzwoNVSwPQTN3j4GhXqhSFSN047ZbMH6yAFybPEUz+ORluWDBf3pj8nD2AJXTsSDNx1yk2rZ3PDufCgulaPNC0hLPls81Bmb44Sc8FDmvHX/cjVg85lvbvm0vgadn+yClqyjpdEGxb89YcX6/to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730732591; c=relaxed/simple;
	bh=I+Iemdni1r4ezNIkVuzSxHpoUwW9c0TtSwmCFDUFbNo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=a2XqBjMdVFOK6r9fb4cd4OHGqRCxNj4nvodlCrsOYWWIxRxB6vT/jF6t8LKqa15v/DiKVUMwRpb71hlPRxMZUo92WFiMhZ3DxQW4ZHvfWMMpi/54BNkUecGzP2ZYecXsuBYIQRBpXht7yqMVl8gEwvfGM82AGD5fSqcPV3Wjayc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLiDcTN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A2BC4CECE;
	Mon,  4 Nov 2024 15:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730732590;
	bh=I+Iemdni1r4ezNIkVuzSxHpoUwW9c0TtSwmCFDUFbNo=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=vLiDcTN44gWDAk0Xbf8UKRvPzPaahJa5gByVdzvjsP5OD3kzLYjhiReyOxJrG5AV+
	 /7D3cLhIx+p8rvE8rZQB+sctRYRvqYDdl+jKqbSm0MftCX4MaD2+n/HnumvFXVkHML
	 m7UmHJ6FczBkarzqXRjf1hZZPC/ThswY+zqz0lNX2isdLFD7ImCoXurOFJBMLDI1L+
	 JG+nlIog6364wxyiU5CdUwoEbwuuiwO3G4epF3q2a11d/lNFjd3oJd/sO4raEe7zAY
	 YJffalDUYTTKHSnNhpTWyqglS5Qmto80q9h5nJtsOI618nfcpMR9udcBUE3ILOOqRc
	 iQw7rsnMVZ8yA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 Nov 2024 17:03:05 +0200
Message-Id: <D5DHHX9C7FX0.3PDP9DT4CWNWY@kernel.org>
Subject: Re: [RFC PATCH 0/4] Alternative TPM patches for Trenchboot
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Daniel P. Smith"
 <dpsmith@apertussolutions.com>
Cc: <x86@kernel.org>, "Ross Philipson" <ross.philipson@oracle.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>, "open
 list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20241102152226.2593598-1-jarkko@kernel.org>
 <D5BW0P0HH0QL.7Y4HBLJGEDL8@kernel.org>
 <e745226d-4722-43ed-86ad-89428f56fcba@apertussolutions.com>
 <D5DCPWBQ2M7H.GAUEVUKGC3G0@kernel.org>
In-Reply-To: <D5DCPWBQ2M7H.GAUEVUKGC3G0@kernel.org>

On Mon Nov 4, 2024 at 1:18 PM EET, Jarkko Sakkinen wrote:
> I don't categorically reject adding some code to early setup. We have
> some shared code EFI stub but you have to explain your changes
> proeprly. Getting rejection in some early version to some approach,
> and being still pissed about that years forward is not really way
> to go IMHO.

Still this sounds unrealistic given that this was tpm_tis only feature,
and even that driver spans to total three different types of drivers:
MMIO, SPI and I2C. It would be ridiculous amount of code pulled into
early setup.

If you still think that would make sense then you could migrate all the
functionality under lib/ which would be called by both tpm_tis_core's
drivers and Trenchboot.

Anyway, if past me did that call, honestly, I do actually get it. It's
not a counter-argument to a represented potential concurrency issue,
which can cause issues with at least one TPM2 command, or like
"it was caused by you because you thought it was a bad idea to accept
tons of code to early setup" ;-)

I can live with that concurrency issue as long as it is known decision
not to support TPM2_PolicyLocality in the in-kernel use cases. Then my
patches do address remaining issues and they can be picked given the
sob's.

If the concurrency issue is unacceptable, then I would merge slmodule
to tpm_tis_core. It does solve the concurrency bug.

I'm now done with this until new version or the series is applied with
my patches. I think I've done enough effort to get this merged and not
the contrary.

BR, Jarkko

