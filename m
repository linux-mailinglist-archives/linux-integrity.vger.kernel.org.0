Return-Path: <linux-integrity+bounces-7213-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B5FB8DB56
	for <lists+linux-integrity@lfdr.de>; Sun, 21 Sep 2025 14:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88B203BD144
	for <lists+linux-integrity@lfdr.de>; Sun, 21 Sep 2025 12:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6922C11C9;
	Sun, 21 Sep 2025 12:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCbQCv/I"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199391E51D;
	Sun, 21 Sep 2025 12:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758459277; cv=none; b=PVFTZjKcl9HJ25JvUtgaKlBY1FyZ0TQ9Z8wU4vLOYPf3JXHbAjIfWUDS+rfApfO2XyMUEd6SDbrrc63mb7unQZt5w2um1q3DTLohlaRhrh4C5/Lqor3EIqG9aa67q+3Kx50Bx5o7SCoHdeOPSTVvkdRz4uVBQsRyRtzBqaSt6VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758459277; c=relaxed/simple;
	bh=jsUcLF3gj9QD/DeMLPoCgYNjJkokHF1gACOem3+AcJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdNYojBwPYA7FVQtC1jMSP5rJw5rmR/yFIVlz8Tc9lwEDlsijbQlaGVTfVN7e9/8rtnAlSTHClVqKIN/SAPd3PbL3cZEZNhO9Pn2h6NZZ3TZ5/fEtYBKaHZgUsbS9Q8zHo3RbNLDCVDGJ0vK87a9mA/hL3f8e0YWWpwbKPuyPEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCbQCv/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC6AC4CEE7;
	Sun, 21 Sep 2025 12:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758459276;
	bh=jsUcLF3gj9QD/DeMLPoCgYNjJkokHF1gACOem3+AcJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VCbQCv/IMTgEdAWfY2wBRtEqDBImw+HPC14iJ56JMHDX0vT66wZ8zk0jh/desx2YU
	 Wx5ehRf3r8EdlPLq458A0x8FL0bqquQCZhUJiWV19/ru9dBBkYTDU5osQMubWRfT6B
	 9l2Cgy+JfAu638gSzsqcuSiF00itOu1ZDCD6sutcp2LErgUJXIsFYcRlFlL1jpuJLK
	 bePnI9DpZVitgRbPm2C2/92Of2a3XZ6hG0nC1mRCPv7AJI9onEtVa5QwFXPRsZFAlK
	 s2Sot1vwrEkHVR3pxAQEqnolk4PKJfELOkYtYnVPCRV+sqVHFWTcRfTa54w7mmc5iU
	 QyDSk/I+meGvQ==
Date: Sun, 21 Sep 2025 15:54:32 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, ross.philipson@oracle.com
Subject: Re: [PATCH v10 0/4] tpm: robust stack allocations
Message-ID: <aM_1iLAsl1wpkl6n@kernel.org>
References: <20250921020804.1088824-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921020804.1088824-1-jarkko@kernel.org>

On Sun, Sep 21, 2025 at 05:08:00AM +0300, Jarkko Sakkinen wrote:
> 1. These are previous changes to tpm_buf, which make stack allocations
>    much more feasible than previously.
> 2. Migrate low-hanging fruit to use stack allocations.

I highly unlikely would put this to 6.18 PR. The first patch huge but at
the same time it is still a "logical change". Splitting it would make it
less understandable. It's also quite stable and the despite many
changes, most of them are mechanical changes (some of them I've even
done originally with an LLM called 'sed').

IMHO reason to split should not be based no size but exactly on logical
steps.

After these few quick rounds I take some time and work on tpm1/tpm2-cmd
to make them follow a builder pattern. This helps e.g., TrenchBoot to
accomplish their goals more easily as builders translate easily to
early boot situations. In addition, making memory management more
stack oriented usually tends to help with such situations.

So the next thing for this patch set is to make things work with parse,
build and transmission decoupled from each other, and it will be as
substantial change as the first patch but can be split into smaller
patches as it does not change the global economy.

An example with tpm2_pcr_read:

1. tpm2_build_pcr_read(), which takes pre-initialized
   tpm_buf() and same parameter as today.
2. tpm_transmit()
3. tpm2_parse_pcr_read(), which takes resulting tpm_buf
   and parses it to a struct, let's say tpm2_pcr_read_result.

And similar decoupling is done for TPM 1 commands as they also need
to translate between environments.

Obviously outer facing tpm-interface.c API can still respond to old
API calls for the time being.

Other stuff:

1. tpm_buf_* from include/linux/tpm.j migrate to include/linux/tpm_buf.h
2. builders: tpm1_build.c, tpm2_build.c
3. parsers: tpm1_parse.c, tpm2_parse.c

Most likely at least at first landing some redundancy is required for
Trenchboto and physical transmission path. By doing what I have
described we can set a limit to the amount redunancy :-)

> 
> Jarkko Sakkinen (4):
>   tpm: Make TPM buffer allocations more robust
>   tpm, tpm1-cmd: Use stack for trivial cases
>   tpm, tpm2-cmd: Use stack for trivial cases
>   tpm_vpm_proxy: Use stack for TPM_CC_SET_LOCALITY
> 
>  drivers/char/tpm/tpm-buf.c                | 137 ++++++----
>  drivers/char/tpm/tpm-dev-common.c         |   4 +-
>  drivers/char/tpm/tpm-dev.h                |   2 +-
>  drivers/char/tpm/tpm-interface.c          |   4 +-
>  drivers/char/tpm/tpm-sysfs.c              |  20 +-
>  drivers/char/tpm/tpm.h                    |   3 +-
>  drivers/char/tpm/tpm1-cmd.c               | 151 +++++------
>  drivers/char/tpm/tpm2-cmd.c               | 297 ++++++++++------------
>  drivers/char/tpm/tpm2-sessions.c          | 121 +++++----
>  drivers/char/tpm/tpm2-space.c             |  44 ++--
>  drivers/char/tpm/tpm_tis_i2c.c            |   4 +-
>  drivers/char/tpm/tpm_vtpm_proxy.c         |  34 +--
>  include/linux/tpm.h                       |  28 +-
>  security/keys/trusted-keys/trusted_tpm1.c |  34 ++-
>  security/keys/trusted-keys/trusted_tpm2.c | 156 ++++++------
>  15 files changed, 493 insertions(+), 546 deletions(-)
> 
> -- 
> 2.39.5
> 

BR, Jarkko

