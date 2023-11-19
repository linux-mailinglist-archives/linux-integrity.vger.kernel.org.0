Return-Path: <linux-integrity+bounces-98-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 493EC7F0953
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 23:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA1C280C52
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 22:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041B118E08;
	Sun, 19 Nov 2023 22:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBeBWdLb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D844711CB2;
	Sun, 19 Nov 2023 22:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78996C433C7;
	Sun, 19 Nov 2023 22:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700431963;
	bh=Y6E/q5+mdfnnezjfgP6j/OoQzXm+L6UpAxyma7lxXdU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=gBeBWdLbcc/6ExfMeb66WgTsPT3BEgdchXHkT4DdWUM3EsdVacW1pUfu2C/ONuaFA
	 kFIb4NJbIFbc9amyKB38CAB9D5MF7ZhBZN/FJDSk0GHC+E+nchD+Y5q2ufKs1Rbiqm
	 N2lxjBLl/Nbc1//UEwU+5zrUO5I4XJwBuIl6d2Fy5ohfhyRANWfGPNNlfg93vGVeXt
	 PdfoaOoGlWwk0CDvadNuTLT/0elPqhDnNoiXvW3Kz+HGyzpl7zFpW/HEAb0a4SVfGc
	 LVz+3d98mAQqVPp1hmo8N7HnRmogWOIRiU65u3NKwZcuqWBMWZK5brJLueepxtjlRw
	 JtI/2dN5vrPMQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Nov 2023 00:12:39 +0200
Message-Id: <CX34TM0NSPYT.3I002JNUTH5NL@kernel.org>
Cc: <keyrings@vger.kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "William Roberts"
 <bill.c.roberts@gmail.com>, "David Howells" <dhowells@redhat.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>
Subject: Re: [PATCH v3 0/6] Extend struct tpm_buf to support sized buffers
 (TPM2B)
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Stefan Berger"
 <stefanb@linux.ibm.com>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20231024011531.442587-1-jarkko@kernel.org>
 <ee054131-9d64-4945-b8aa-76b212effa7b@linux.ibm.com>
 <CX34O1F9H8AO.1FP8YF01HGAQ3@kernel.org>
In-Reply-To: <CX34O1F9H8AO.1FP8YF01HGAQ3@kernel.org>

On Mon Nov 20, 2023 at 12:05 AM EET, Jarkko Sakkinen wrote:
> On Wed Nov 15, 2023 at 11:56 PM EET, Stefan Berger wrote:
> >
> >
> > On 10/23/23 21:15, Jarkko Sakkinen wrote:
> >
> > > For TPM1 I tried:
> > >=20
> > > keyctl add trusted kmk "new 32" @u
> > >=20
> > > This caused TPM error 18, which AFAIK means that there is not SRK (?)=
,
> > > which is probably an issue in my swtpm configuration, which is visibl=
e
> > > in board/qemu/start-qemu.sh.in.
> >
> > FYI: This would create a TPM 1.2 with an SRK with password 'sss':
> >
> > swtpm_setup --tpmstate=3D./ --create-ek-cert --take-ownership --overwri=
te=20
> > --srkpass sss --ownerpass ooo
>
> Thanks! I'll update my scripts in my BuildRoot repository.

The repository helps to verify that tpm_buf changes don't break
anything. I created it because I saw it as too high risk not to
verify tpm_buf changes properly, as everything uses them.

Any bug in HMAC session feature itself would be optimally only
local to the feature and not something that spreads everywhere.

So both the patch set itself and also the BuildRoot repository
effectively manages this risk.

BR, Jarkko

