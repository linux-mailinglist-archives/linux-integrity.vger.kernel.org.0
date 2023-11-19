Return-Path: <linux-integrity+bounces-97-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F41E7F0948
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 23:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E83D1C20491
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 22:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1724119BDC;
	Sun, 19 Nov 2023 22:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2KftVpn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A2D19BD6;
	Sun, 19 Nov 2023 22:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3FDC433C7;
	Sun, 19 Nov 2023 22:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700431526;
	bh=Pzxiqai57lAvPPoMaJtYmMJ7Rcd1ryAvaKYqCq2JTTY=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=o2KftVpnwzLvNG8nWIH9Jpdn2uzr1B6ded8pnTmALq0UhE87t0XtfBo7PaXyhhfxI
	 jd/rgF0mWcNpRFHIu51Cqt+FfvD/LMQvrDrSeq//8gO/OBdsZMLXiX0RjeCp8zxtUZ
	 NkWdfctXQVcV+vqd5kUf4vJIBpVlxVd/97ASS9UpfASbDhy5wVpln0ZVXmcmLTpSrG
	 lAuGDGguOztuD1iLozEzRgqxlU48VHEWQX8ecCcPzEcZ13dcZiODt8c2QmZs/njwgu
	 Taq++7bftY6jzFDUDfpPszLiSXuc0X701gd57JUUFrt19FniOGlCIKXclwwToHZpYI
	 gzxFUJaycg8iQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Nov 2023 00:05:22 +0200
Message-Id: <CX34O1F9H8AO.1FP8YF01HGAQ3@kernel.org>
Cc: <keyrings@vger.kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "William Roberts"
 <bill.c.roberts@gmail.com>, "David Howells" <dhowells@redhat.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>
Subject: Re: [PATCH v3 0/6] Extend struct tpm_buf to support sized buffers
 (TPM2B)
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20231024011531.442587-1-jarkko@kernel.org>
 <ee054131-9d64-4945-b8aa-76b212effa7b@linux.ibm.com>
In-Reply-To: <ee054131-9d64-4945-b8aa-76b212effa7b@linux.ibm.com>

On Wed Nov 15, 2023 at 11:56 PM EET, Stefan Berger wrote:
>
>
> On 10/23/23 21:15, Jarkko Sakkinen wrote:
>
> > For TPM1 I tried:
> >=20
> > keyctl add trusted kmk "new 32" @u
> >=20
> > This caused TPM error 18, which AFAIK means that there is not SRK (?),
> > which is probably an issue in my swtpm configuration, which is visible
> > in board/qemu/start-qemu.sh.in.
>
> FYI: This would create a TPM 1.2 with an SRK with password 'sss':
>
> swtpm_setup --tpmstate=3D./ --create-ek-cert --take-ownership --overwrite=
=20
> --srkpass sss --ownerpass ooo

Thanks! I'll update my scripts in my BuildRoot repository.

BR, Jarkko

