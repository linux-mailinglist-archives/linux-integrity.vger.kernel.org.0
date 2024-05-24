Return-Path: <linux-integrity+bounces-2613-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 246728CE620
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 15:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D161F21822
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 13:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC3F12BF1F;
	Fri, 24 May 2024 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVXJK5Oc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DFC12BF1C;
	Fri, 24 May 2024 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716557100; cv=none; b=agtI+jyL4QgoAI7upqsUQxH/f4zUZ9kpa3eYHyKJ+fn97S1dqKActFULDDahuovZrNXpPN6omqMblF9BMNyqkN66ZpDVRMSyH562gg03nlz3MwLI9ra+msPUe1d7zA0lPIyPtAfmjrZaQ5oWMCGNRV2Ew8ThR45UIAybBxEmv/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716557100; c=relaxed/simple;
	bh=xL8uzd1oIc10Wg29iI8MwFCtlqyFY6so5XJJ8/iNP2M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JC6o2jCz/sV/gvWmx5rW4ADTU44qSrrZBMasB/vosWPC4yGGTwt38n186I4pZDI/jTpFHYurQJppu5gVN7ilF+qfkEA8QYXYQ/newNILMtcThAXs9tIRZPhiF90hz86MTeLd4F9upI5g9mTYkxbaK3F4ljddA9pOKGe9GED+Gqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVXJK5Oc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB20C2BBFC;
	Fri, 24 May 2024 13:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716557100;
	bh=xL8uzd1oIc10Wg29iI8MwFCtlqyFY6so5XJJ8/iNP2M=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=qVXJK5OchE7OrfEHTy1jhE/SvJoy/lWcCZuQ6NrsPE0TGjBxjrnk3ZE9OPaiUgeEy
	 ZAoaMktG+N49WBKo9MoNqlZ/CtAi/AJymLEpMD69Sqh+fH3OhCXnXppWk8Bdtp5QAN
	 wJu0IvxPpoOmnQ3i/SzN55hNySjNofkMlK0NfjX/4TgrH4UGOz0k/gY3StgBGDuoxO
	 inmXJXIaUdMJdMBibccUZGk1frEJv0z7i/rObSWg9/C6njcOLBQ5IQGwi4GO9VW3Gk
	 ezVmSn7A6NHhhZOEoqqCOQPyCIXmMPwtvQOaMAQ7plgYownqSEdy3r+KmYgJ5OEwSC
	 Gd8YF064I3XAg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 May 2024 16:24:57 +0300
Message-Id: <D1HWPG2VGX2W.2FN9EC7JTDU9I@kernel.org>
Cc: <keyrings@vger.kernel.org>
Subject: Re: [PATCH 0/6] Add policy to sealed keys
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240524130459.21510-1-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240524130459.21510-1-James.Bottomley@HansenPartnership.com>

On Fri May 24, 2024 at 4:04 PM EEST, James Bottomley wrote:
> TPM2 policy is much more complicated than the original TPM 1.2 which
> only supported PCR value binding.  TPM2 policy may be a sequence of
> policy statements each of which must be correctly executed and may
> include choices in which set of policy statements will execute
> correctly.  The actual policy is identified in the key by a single
> hash, which is the end result of extending all the policy statements.
> However, since it is impossible to reverse engineer the policy
> statements from the hash value, the ASN.1 key format is extended to
> give a broken out list of statements the kernel must execute to get
> the correct policy hash value.
>
> In order to create policy sessions (which are usable as HMAC sessions,
> but also respond to policy statements), the TPM HMAC code is reused to
> create the required policy sessions (while preserving bus security).
> However, because the session hash algorithm must match the name
> algorithm of the sealed data (which is used for the policy hash), the
> TPM session code is changed to use a variable hash algorithm.
>
> The first patch consolidates the hash definitions and conversion
> routines, the second adds both variable hash type and policy support
> and the remaining patches add specific policy statement
> implementations.
>
> James
>
> ---
>
> James Bottomley (6):
>   tpm: consolidate TPM to crypto hash algorithm conversion
>   tpm: add policy sessions
>   KEYS: trusted: add PCR policy to TPM2 keys
>   KEYS: trusted: add ability to specify arbitrary policy
>   KEYS: trusted: implement counter/timer policy
>   KEYS: trusted: add support for TPM keys with signed policy
>
>  .../security/keys/trusted-encrypted.rst       |  99 ++-
>  drivers/char/tpm/tpm2-cmd.c                   |   8 -
>  drivers/char/tpm/tpm2-sessions.c              | 313 ++++++---
>  include/keys/trusted-type.h                   |   8 +-
>  include/linux/tpm.h                           |  81 ++-
>  security/keys/trusted-keys/Kconfig            |   2 +
>  security/keys/trusted-keys/Makefile           |   3 +
>  security/keys/trusted-keys/tpm2-policy.c      | 662 ++++++++++++++++++
>  security/keys/trusted-keys/tpm2-policy.h      |  61 ++
>  security/keys/trusted-keys/tpm2key.asn1       |  21 +
>  security/keys/trusted-keys/trusted_core.c     |   7 +-
>  security/keys/trusted-keys/trusted_tpm1.c     |  15 +
>  security/keys/trusted-keys/trusted_tpm2.c     | 206 ++++--
>  13 files changed, 1314 insertions(+), 172 deletions(-)
>  create mode 100644 security/keys/trusted-keys/tpm2-policy.c
>  create mode 100644 security/keys/trusted-keys/tpm2-policy.h

I'd prefer to this postponed after asymmetric keys and also when
the issues have been fixed from HMAC.

Also I fixed myself some bugs like memory leak and useless WARN
from existing trusted keys code so those needs to be fixed too.

So NAK at the time can be rebased later on top.

BR, Jarkko

