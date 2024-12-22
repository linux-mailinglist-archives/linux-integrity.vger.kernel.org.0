Return-Path: <linux-integrity+bounces-4457-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B50C39FA670
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Dec 2024 16:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B461883655
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Dec 2024 15:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E877118C039;
	Sun, 22 Dec 2024 15:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N15z3iIX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF116290F;
	Sun, 22 Dec 2024 15:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734881611; cv=none; b=V4Bg1/ujS0+Kq0Z0/zY1Z0c3yk57HBCzZ+oP6aBqZSrBUnD4TMZJBQNRxc9YCQN2QxQDbTkoc57vVI1gM3tJA9RYIsMmYW5HquT/Cf6fqsY0xCNkZ3LtLW0nRQz+wqpotDfc3ojzWsUjyuHdmKDzQOANLzQfr/NumUqKQSst/B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734881611; c=relaxed/simple;
	bh=NtBt8GYRNsa8EuTfhe+4iwVcgPAYeTQxKGAAKWlTWdE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nqgs/pTUeLxoOD2bTcNStbZpUNOI++znvTA/uXwGSHul8oO2XouL5MZCTJw767Zr4uVx5OnB4t6+TpBrMaCOhYxQJNYuTCzCf92GtdiVIJjuTRiMw7Hb9qUFth4dRXEXPIGvJUpdz63Q3h+CtB0pDJ78MkYgg9mWzIOI2VsCyWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N15z3iIX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91EFC4CECD;
	Sun, 22 Dec 2024 15:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734881611;
	bh=NtBt8GYRNsa8EuTfhe+4iwVcgPAYeTQxKGAAKWlTWdE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=N15z3iIXyunP7irlOKxtetPcsqM28XrM2LGmn2g7/zpN7ZTFr5Xn+eJvTo914z2ql
	 IWd0NNqFbrUdDouu7A2vfBTbd4lggC1MViBOUqRyHlYHwxkkvRkERxDf3UHcrAvklR
	 sXx/v0FVZ33A6LOvXpdJXSvVOBnnijc4nYw4wkKktMPGG+5P5yPsh3t48EedR5AMcA
	 kufkwT1/KgVQo/WZxJ1yx+Eeh5+9Io76oTGvERsMl+1wN9acPnjD2obumzNUTVR+ub
	 sIczRQO1v4Vg3x6CdedD3aOejp6gPCOQ1INsM3f5uIlWybuYUSCFAuYRaW0hZ+U/hd
	 gIcqZ+Xr066iw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 22 Dec 2024 17:33:26 +0200
Message-Id: <D6IC7BH3A75U.31VJX6T6QRKKI@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Colin Ian King"
 <colin.i.king@gmail.com>, "Joe Hattori" <joe@pf.is.s.u-tokyo.ac.jp>,
 "Stefan Berger" <stefanb@linux.ibm.com>, "Roberto Sassu"
 <roberto.sassu@huawei.com>, "Al Viro" <viro@zeniv.linux.org.uk>, "Andy
 Liang" <andy.liang@hpe.com>, "Matthew Garrett" <mjg59@srcf.ucam.org>, "Mimi
 Zohar" <zohar@linux.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Map the ACPI provided event log
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Ard Biesheuvel" <ardb@kernel.org>
X-Mailer: aerc 0.18.2
References: <20241221113318.562138-1-jarkko@kernel.org>
 <CAMj1kXHPpz2sH_MSjJ3wRP64tB2pSZJDUoMv4uKXh-HpgHWfvQ@mail.gmail.com>
 <fc11e26d9a202d60a56403af9bd0bae4bd3a852f.camel@HansenPartnership.com>
 <D6HNHJM9L4BS.MNNTVW049NZJ@iki.fi>
 <e8037b6dd77c3105ac94e0fe68aad39e9f3b9656.camel@HansenPartnership.com>
 <D6IBZOIZPHG9.33MA1XLBELFNF@iki.fi>
In-Reply-To: <D6IBZOIZPHG9.33MA1XLBELFNF@iki.fi>

On Sun Dec 22, 2024 at 5:23 PM EET, Jarkko Sakkinen wrote:
> On Sun Dec 22, 2024 at 5:00 PM EET, James Bottomley wrote:
> > If event logs grow to greater than KMALLOC_MAX_SIZE then absolutely it
> > makes sense to map them instead of copying them.  But we'd have to do
> > that for all event log locators: ACPI, EFI and OF, because event log
> > size should be independent of the mechanism used to locate it.  So,
> > even as a long term fix (assuming we think there's a possibility of
> > logs expanding by 50x), this patch doesn't do the right thing because
> > it only maps ACPI logs.
>
> Because we have a test target only on ACPI where this happens fix
> should still fix only ACPI. It's not hard to reiterate this but=20
> precursory iteration is a bad idea.

Also, "event log size should be independent of the mechanism used to
locate it" is a sentence that is sky high too abstract to say much.

I don't know what it means to be frank.

BR, Jarkko

