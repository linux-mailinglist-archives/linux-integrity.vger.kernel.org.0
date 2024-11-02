Return-Path: <linux-integrity+bounces-4003-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5050C9BA20B
	for <lists+linux-integrity@lfdr.de>; Sat,  2 Nov 2024 19:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E787C1F21A3A
	for <lists+linux-integrity@lfdr.de>; Sat,  2 Nov 2024 18:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEDC15ECD7;
	Sat,  2 Nov 2024 18:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAmHw9WH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F0A2E630;
	Sat,  2 Nov 2024 18:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730570436; cv=none; b=lBlci3ZZfd6LspscPo7dNeI20pAhkDFOqhDdkloGCpZX23ZBmH7iUukvSY7wctYejGTmplIHR6jYtfIgZbUcPBl7eebHLGL2gjvzSOQDlHKikwVZFLLSKt4gPODSZhuxGruU0+hf9QFj9MSHpvjA6K615VPAVg/Nc69r2BglfE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730570436; c=relaxed/simple;
	bh=x4VnLOwGXI8SrmlU8bb8al57dSkKK6H9BcMIMe1BPk4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=VU069FrxcGZ/dQZ45/qfwE1Hj4eOI+6mYhZZoL+rKIcTBJwq8G8ym+Bnjr6pPUgNkDaCeThaAfx6zwW1V+dgKSqDUWUZ/sjplf+WVGDCckEmxSMdxCYTHE1ih+Ap2wqlmERNqVIHDegG9hH1ydPm2sGKGnRSxKqE7jZWxL1UI4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAmHw9WH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1906C4CEC3;
	Sat,  2 Nov 2024 18:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730570436;
	bh=x4VnLOwGXI8SrmlU8bb8al57dSkKK6H9BcMIMe1BPk4=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=XAmHw9WHBmn3PNTuMu1N7V5vehTf+3p7nrgZC0dkJSQ+h5SbkNRq/TgbnibAoT8oe
	 w2eqqjbtSSR4tYCoq1UDwkPw7bjtbNcJR44bUEsECQEQK7uPPrpTT+8Ts0ELd+pJBc
	 yIpS7gY42fJAhyPq9xoeA/fSN+sgDW/uU6k84pBmC0S0j0WDfAVtsSI23VdVIbBxpV
	 SSagi7vBrFuIHS4/O04ZzGWFs1k7fwmOTNZ9DgPYUHY5s1ZEkhbsW2I3oifhuwMgrN
	 gpFYRu8p1c8dBotkhaULDdlaGGrGOKXS0XcJK2cT0VnAZnwpYFW8Ja2cJRXvVp/Rei
	 79x7CYePXg31A==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 02 Nov 2024 20:00:31 +0200
Message-Id: <D5BW0P0HH0QL.7Y4HBLJGEDL8@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: <x86@kernel.org>, "Daniel P. Smith" <dpsmith@apertussolutions.com>,
 "Ross Philipson" <ross.philipson@oracle.com>, "Ard Biesheuvel"
 <ardb@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>, "Peter Huewe"
 <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>, "open list:TPM
 DEVICE DRIVER" <linux-integrity@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] Alternative TPM patches for Trenchboot
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <20241102152226.2593598-1-jarkko@kernel.org>
In-Reply-To: <20241102152226.2593598-1-jarkko@kernel.org>

On Sat Nov 2, 2024 at 5:22 PM EET, Jarkko Sakkinen wrote:
> It is not really my problem but I'm also wondering how the
> initialization order is managed. What if e.g. IMA happens to
> initialize before slmodule?

The first obvious observation from Trenchboot implementation is that it
is 9/10 times worst idea ever to have splitted root of trust. Here it
is realized by an LKM for slmodule.

So based on that usually a literal and unquestionable truth, when it
comes to securing platforms, the next question is how to make a single
atomic root of trust for Trenchboot.

There is really only one answer I think of for this it to make slmodule
part of the tpm_tis_core and also init order will be sorted out.

I'll describe the steps forward.

Step 1: declare and refactor that module into
drivers/char/tpm/tpm_tis_slmodule.c and add this to the Makefile:

ifdef CONFIG_SECURE_LAUNCH
obj-$(CONFIG_TCG_TIS_CORE) +=3D tpm_tis_slmodule.o
endif

Step 2: add 'int kernel_locality;' to struct tpm_tis_data.
Step 3: implement tpm_tis_set_locality() internal function.
Step 4: drop sysfs-patch completely (solution is not generic).

BR, Jarkko

