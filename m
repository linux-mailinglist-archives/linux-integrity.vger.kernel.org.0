Return-Path: <linux-integrity+bounces-4045-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 305B59BFAFD
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 01:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7D41F22AD7
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 00:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B668E53BE;
	Thu,  7 Nov 2024 00:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLAltaiv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887466FB0;
	Thu,  7 Nov 2024 00:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730940853; cv=none; b=aFl4nfIc8f1UWOTO8UAaMB3xgJAHJNFD1/o94r+7b5Rf4n4+uPneE9ijw7IPsidFLnLax3tUGvPNv2irzUM/6oDu2sDMPctcc0v9iHP2DRDZs8Fpot/5Bpwbb0EzoHRbWMmB9CkvNyALfSVFTn0GRleq/c8QyXzONRbz03mbk7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730940853; c=relaxed/simple;
	bh=QVkV01TgCCZQGuMOm/6A+ScfjpttzoC0niUpm4u+fhQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Uh0z+7lMLSr5pk5j8Qk729lkQ3f83+vxax/4YNP3JgMiQKe84BBOOY0nh6+MldZKtC2o/BTMMbNLKDlrEOeaC+wdgIq9iAy/LbNyPehNMN4XkbOlNW86m1bUDbyKePVwW+Mfa9GtRo2lVA6vwGho2OkxDPvtVokAlHRYZnTNZT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLAltaiv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607DAC4CEC6;
	Thu,  7 Nov 2024 00:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730940853;
	bh=QVkV01TgCCZQGuMOm/6A+ScfjpttzoC0niUpm4u+fhQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=XLAltaiv4124D68kxQOYDHRzNE7CWL4XO9E59lzkBWYxxVU+iWb5SuNc8oGnzcyiv
	 a22MhpXr12vH3g+nT4hBj2GbwrSJyr10F9g3NlAipJonqo5zPbCvWRVcUSHFvjwWRV
	 djbUv6wCubCn3exTMFX4frmAp4blAwWuJCMxMDgwBhG2TqY0Utet10tmPHYsoPPUu2
	 MmugxKSE+hmp98A4JTgKvFYX4AZzWuBWgy0hmp+WcJABkdvDvlRDhd7EeQPDvtdoja
	 a4Lkr2x1hnHtG7PMlBIRNQ0rlhJgddSt3C4yyRtARQkyqPSH+926p4vHZT95+x12Os
	 qyu6M5mgI19vw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Nov 2024 02:54:08 +0200
Message-Id: <D5FJBKBSLIXR.3MRIPCQA5CSJD@kernel.org>
Subject: Re: [PATCH] tpm: Opt-in in disable PCR encryption on TPM2 chips
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>,
 <linux-integrity@vger.kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto Sassu"
 <roberto.sassu@huawei.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20241107004708.108667-1-jarkko@kernel.org>
 <D5FJ9VCD1JBL.22MQYQHUYJLJ8@kernel.org>
In-Reply-To: <D5FJ9VCD1JBL.22MQYQHUYJLJ8@kernel.org>

On Thu Nov 7, 2024 at 2:51 AM EET, Jarkko Sakkinen wrote:
> On Thu Nov 7, 2024 at 2:47 AM EET, Jarkko Sakkinen wrote:
> > From: Mimi Zohar <zohar@linux.ibm.com>
> >
> > The initial encrypted HMAC session feature added TPM bus encryption to
> > various in-kernel TPM operations. This can cause performance bottleneck=
s
> > with IMA, as it heavily utilizes PCR extend operations.
> >
> > In order to address this performance issue, introduce disable_encrypt_p=
crs
> > kernel command-line parameter to the TPM driver.
> >
> > Cc: James Bottomley <James.Bottomley@HansenPartnership.com>

We also probably want this:

Cc: stable@vger.kernel.org # v6.10+

BR, Jarkko

