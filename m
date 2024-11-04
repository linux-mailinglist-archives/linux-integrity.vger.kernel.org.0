Return-Path: <linux-integrity+bounces-4010-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 630F99BB36B
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 12:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B211C21022
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 11:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D011B3930;
	Mon,  4 Nov 2024 11:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9wfQdNF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182661AF0B9;
	Mon,  4 Nov 2024 11:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730719746; cv=none; b=ia9uObO+xXlLhHmtebFPvvjE/MVjZdlLyZUqvqDJ+50la87E0bbq0fddyc26JnT6ndQjm25C8/agz9AWbmuZo5q3e/ZM3m52ykbh9DvNiiFQao3nj7vLY1W2rxlyMwYxCeaDCJg2PXAnGx4i0WlN5LxuIakWJwmb9YgHR5BFObc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730719746; c=relaxed/simple;
	bh=YndyV64LlAcssMxxfdam3jL7dT/bXBUtGahkuxYP/uM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=T5Piog6+kRvue0Z3VbU6PXOzE417vNl4IaQgAYEmkBCEu/U+DZwoT2Qyxel9n0WJU80o+qLGFGrCLMaiWMQNV4r/gzYGkdSgfAduqxuFKG83RlUovEPeefwjsTTacgDJRwQvWB2Ze5ovJN/ZaP/+qXMZrnUMIwEv+sNQlBC9vx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9wfQdNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEF6C4CECE;
	Mon,  4 Nov 2024 11:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730719745;
	bh=YndyV64LlAcssMxxfdam3jL7dT/bXBUtGahkuxYP/uM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=q9wfQdNFhUk6QnXQCUVvt1o5IdzZ9Rfk1f7ikvz6J9qV3AQfGw8fFMVbN4regbZeG
	 sEHWP5hli1+5If8+ijpVSINfBW21eDtR00w6mWQLhQtQmMbI/ZSNIF5a1bx51UG/5v
	 BQh9fDXPkqxxJ4Frsnf1tUoat0SDlcTDukM2boleErBIGXptsZE9FFkRqCuxHAtd1G
	 5fyVmm2Zh5z+aoenzTfr05aycn9ZhWKw44Nvx1Ld/4t9OzYZOnQu2Tm79UYaOehI2w
	 /E7+7d0ZDNGtHe0Apv2Tr/UK8czzA21LT7Z1yw4CqQdWvOMl3d4ZR22Polc1cD88PU
	 kOM9KL9VliCrw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 Nov 2024 13:29:00 +0200
Message-Id: <D5DCY0MCPDC2.3C6FDTRKPFU8H@kernel.org>
Cc: <x86@kernel.org>, "Ross Philipson" <ross.philipson@oracle.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>, "open
 list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] Alternative TPM patches for Trenchboot
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Daniel P. Smith"
 <dpsmith@apertussolutions.com>
X-Mailer: aerc 0.18.2
References: <20241102152226.2593598-1-jarkko@kernel.org>
 <D5BW0P0HH0QL.7Y4HBLJGEDL8@kernel.org>
 <e745226d-4722-43ed-86ad-89428f56fcba@apertussolutions.com>
 <D5DCPWBQ2M7H.GAUEVUKGC3G0@kernel.org>
 <D5DCR279TZY5.1C7KRTFPGD3WU@kernel.org>
In-Reply-To: <D5DCR279TZY5.1C7KRTFPGD3WU@kernel.org>

On Mon Nov 4, 2024 at 1:19 PM EET, Jarkko Sakkinen wrote:
> > I don't categorically reject adding some code to early setup. We have
> > some shared code EFI stub but you have to explain your changes
> > proeprly. Getting rejection in some early version to some approach,
> > and being still pissed about that years forward is not really way
> > to go IMHO.
>
> ... and ignoring fixes that took me almost one day to fully get together
> is neither.
>
> These address the awful commit messages, tpm_tis-only filtering and not
> allowing repetition in the calls.

Also considering early setup: it is not part of uapi. It can be
reconsidered after the feature is landed as improvement (perhaps
also easier to project then). I don't think TPM2_PolicyLocality
potential conflict is important for kernel, and that is the only
known race I know at this point.

I don't really get the problem here. It's almost I like I should
not have mentioned potential concurrency issue in order to not
get slandered.

BR, Jarkko

