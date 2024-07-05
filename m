Return-Path: <linux-integrity+bounces-3019-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1455928AC8
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jul 2024 16:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 570EE1F225E9
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jul 2024 14:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841B916C685;
	Fri,  5 Jul 2024 14:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edn+Xqdj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C16716C444;
	Fri,  5 Jul 2024 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720190113; cv=none; b=L/vAGw4Dq7GBkRZbjdV7HEQl9WL0o0aksApKhGWIHmK8dXQcri9woRS0/e6DBkTqSn/x4204FuO8tTOMnqXwX5tO+XkOlrDhFcQ/84LHrS3EpilwY/ALLOt2LDBSCbZTyTTeFKPqVH2ow4FDdH/Piz1twRwiN18KUAbMJp3C+PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720190113; c=relaxed/simple;
	bh=VlgJjr/VJ8dDWRH6EvR9EdtJ5JA7lCef8hi6JrtfQS8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=VrgX+lcJrFc5u46wnhSBWPMcZkk0di5eVjst8heZJAp2jshHKpTaSl3AOBaBESbdLz+MWIE0mwGsILk8WoBd8JC/C3iYcZkn2kMN5KOspNeEkDhzJYwOc6VzQ6CQynLSW8hgSr8kZAspQ7JHBd54y+68LfLJ7oM9b7E40wMqaU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edn+Xqdj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372DFC116B1;
	Fri,  5 Jul 2024 14:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720190112;
	bh=VlgJjr/VJ8dDWRH6EvR9EdtJ5JA7lCef8hi6JrtfQS8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=edn+XqdjyRhZIT10+kvJqkewRhmj36TYqAUa7hBTubTpeLGRKMVjxvUOfz29hTQNj
	 NsZysK0UETcD4CyLM203NsBKWl1fG0Xuu/F9eOxz5rDJ2t+38GPYtCfwq4ZqHEmNkD
	 RF18SHslTejZvy2p5Q3gIWZCaXtQZX8XhQuMZwOKprhb5n/t2/kuLKm4I6TMbLaSz/
	 HkrHjG6H+NrlwrDJFsQOzqE1oCUfUNyT5vmA2z5G22wUg0/NB6ILqERnyXianUEPZY
	 MNsrhzzsIo5bgf5yuPp4zHd1TUPjNg9jOf7vOGjue/UpHIQhU+uh0iQI7uViNvTOQe
	 rnliuSEqqEW1A==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jul 2024 17:35:05 +0300
Message-Id: <D2HOI1829XOO.3ERITAWX9N5IC@kernel.org>
Subject: Re: [PATCH v2 3/3] tpm: Address !chip->auth in
 tpm_buf_append_hmac_session*()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>,
 <linux-integrity@vger.kernel.org>
Cc: "Thorsten Leemhuis" <regressions@leemhuis.info>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, <stable@vger.kernel.org>, "Peter Huewe"
 <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Ard Biesheuvel" <ardb@kernel.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>, <linux-kernel@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-security-module@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240703182453.1580888-1-jarkko@kernel.org>
 <20240703182453.1580888-4-jarkko@kernel.org>
 <c90ce151-c6e5-40c6-8d3d-ccec5a97d10f@linux.ibm.com>
 <D2GJSLLC0LSF.2RP57L3ALBW38@kernel.org>
 <bffebaaa-4831-459f-939d-adf531e4c78b@linux.ibm.com>
In-Reply-To: <bffebaaa-4831-459f-939d-adf531e4c78b@linux.ibm.com>

On Fri Jul 5, 2024 at 5:05 PM EEST, Stefan Berger wrote:
> The original thread here
>
> https://lore.kernel.org/linux-integrity/656b319fc58683e399323b88072243446=
7cf20f2.camel@kernel.org/T/#t
>
> identified the fact that tpm2_session_init() was missing for the ibmvtpm=
=20
> driver. It is a non-zero problem for the respective platforms where this=
=20
> driver is being used. The patched fixed the reported issue.

All bugs needs to be fixed always before features are added. You are
free now to submit your change as a feature patch, which will be
reviewed and applied later on.

> Now that you fixed it in v4 are you going to accept my original patch=20
> with the Fixes tag since we will (likely) have an enabled feature in=20
> 6.10 that is not actually working when the ibmvtpm driver is being used?

There's no bug in tpm_ibmvtpm driver as it functions as well as in 6.9.

I can review it earliest in the week 31, as feature patch. This was my
holiday week, and I came back only to fix the bug in the authentication
session patch set.

> I do no think that this is true and its only tpm_ibmvtpm.c that need the=
=20
> call to tpm2_session_init. All drivers that use TPM_OPS_AUTO_STARTUP=20
> will run tpm_chip_register -> tpm_chip_bootstrap -> tpm_auto_startup ->=
=20
> tpm2_auto_startup -> tpm2_sessions_init

Right my bad. I overlooked the call sites and you're correct in that
for anything with that flag on, it will be called.

It still changes nothing, as the commit you were pointing out in the
fixes tag does not implement initialization code, and we would not have
that flag in the first place, if it was mandatory [1].

[1] It could be that it is mandatory perhaps, but that is a different
story. Then we would render the whole flag out. I think this was anyway
good insight, even if by unintentionally, and we can reconsider removing
it some day.

BR, Jarkko

