Return-Path: <linux-integrity+bounces-4456-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 442119FA66B
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Dec 2024 16:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE102162F2B
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Dec 2024 15:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983F7188CA9;
	Sun, 22 Dec 2024 15:23:33 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C49121345;
	Sun, 22 Dec 2024 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734881013; cv=none; b=BkIj4uQwmaVyLbdUWDFmFzL9bb7oHXbjAvkFP1t5zksN3DD4V8Htyfwv0ntY4l3Xg+EWC3Ad5kedFjtJJ2falV+0tE5HMb6zNmITkgEuG56235SlmYzRP5dUVOPDrfbADuuDKzGGuYPa7ntuN0ctipN7u3X+PeVPS0LpKxITmuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734881013; c=relaxed/simple;
	bh=bzY/le8nsdIZqknA1e2jVzHlvCzOVqQWEAH6N7fKyec=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OKL7FfP8gltj2rTzb9j2zzWd+q0RwvHuRMoDuUrUGu8ClxdyPDIudqQw4/8TNkaTJMWoLeQr1kW/0X0Gxn8DqUQuLOjDY3hECP7LtSXC+uMNA82FI3LDyWfkbt+BDoCU9eUEjS0gawSUsScmygn7D5KMf2HmWQYH2Q2K1HKMYP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853DBC4CECD;
	Sun, 22 Dec 2024 15:23:32 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 22 Dec 2024 17:23:28 +0200
Message-Id: <D6IBZOIZPHG9.33MA1XLBELFNF@iki.fi>
Cc: <linux-integrity@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Colin Ian King"
 <colin.i.king@gmail.com>, "Joe Hattori" <joe@pf.is.s.u-tokyo.ac.jp>,
 "Stefan Berger" <stefanb@linux.ibm.com>, "Roberto Sassu"
 <roberto.sassu@huawei.com>, "Al Viro" <viro@zeniv.linux.org.uk>, "Andy
 Liang" <andy.liang@hpe.com>, "Matthew Garrett" <mjg59@srcf.ucam.org>, "Mimi
 Zohar" <zohar@linux.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Map the ACPI provided event log
From: "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <20241221113318.562138-1-jarkko@kernel.org>
 <CAMj1kXHPpz2sH_MSjJ3wRP64tB2pSZJDUoMv4uKXh-HpgHWfvQ@mail.gmail.com>
 <fc11e26d9a202d60a56403af9bd0bae4bd3a852f.camel@HansenPartnership.com>
 <D6HNHJM9L4BS.MNNTVW049NZJ@iki.fi>
 <e8037b6dd77c3105ac94e0fe68aad39e9f3b9656.camel@HansenPartnership.com>
In-Reply-To: <e8037b6dd77c3105ac94e0fe68aad39e9f3b9656.camel@HansenPartnership.com>

On Sun Dec 22, 2024 at 5:00 PM EET, James Bottomley wrote:
> If event logs grow to greater than KMALLOC_MAX_SIZE then absolutely it
> makes sense to map them instead of copying them.  But we'd have to do
> that for all event log locators: ACPI, EFI and OF, because event log
> size should be independent of the mechanism used to locate it.  So,
> even as a long term fix (assuming we think there's a possibility of
> logs expanding by 50x), this patch doesn't do the right thing because
> it only maps ACPI logs.

Because we have a test target only on ACPI where this happens fix
should still fix only ACPI. It's not hard to reiterate this but=20
precursory iteration is a bad idea.

BR, Jarkko

