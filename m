Return-Path: <linux-integrity+bounces-7340-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A4DBAEB4B
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Oct 2025 00:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72BD91925561
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 22:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CA02D0275;
	Tue, 30 Sep 2025 22:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8YoDIEc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EAB28643B;
	Tue, 30 Sep 2025 22:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759271487; cv=none; b=nlAdgl66k7jQh48+/OrHQLrP2zNSbfO29v1ML48q2IL16UVrvd4E/n4fs/yjQmmnVOKeI5zyLRajFJ9+EjSFhU5T2zf2l7jxcGKNtIzSaXk2lWa0rFHPnmGPvIGiuhgKTakffQsM18dP4kmJfwnNkcEL4qpRTOSSZ2MZaf0AAio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759271487; c=relaxed/simple;
	bh=tWMNXqI0Vr2OCzvQtaEQ1VIqMKFgHjDe1LaNyvak7vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/bbf4DuBjXxfGHS+nz4kzBAOrDgAUvxXaS68tMBPHFvUGKmHj8F73UTxWJyAgwHp63YA2ikFyuiIlnPEPJB0XGQtLQLpUf3vm0FjbDR5tfRyo7IYIIcibAEw7p4YfYDgFmcxKQkGOyPGtfUx4iYh1Ztk0szxe5vNipyIcSWL2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8YoDIEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538BDC4CEF0;
	Tue, 30 Sep 2025 22:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759271486;
	bh=tWMNXqI0Vr2OCzvQtaEQ1VIqMKFgHjDe1LaNyvak7vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z8YoDIEcwfHjNIZZg3R7+ORJAjqjX/f/kP8VjaK7n86BScEEK+2AR6GYBDg46XSVv
	 +iyFTWlHTjjC22dCx+WYrJi+i7HVROF79MFBA7HUnB+tQMC/T4cjvWNlQVs0ObF8vz
	 kq3uIT1pUHwoW6Z1Ec78ZJWPfZ8X7ilmOVHKJaxH3RwW/UMUg4B2hGFZUw7bGoAWUR
	 XQpPcf+K7mw21LHZw5AQQql+weJI4Lp35JuaRJLh4NJ40h7Sc7b9qo0t5VDoa6y8vM
	 6W/pwHreA9GtQmH8h2+NrgpnpNvv5zfSQloIpJdW8xujwyB2FzCowljRnaDLDgvC9Y
	 4SnESOKR8aPJw==
Date: Wed, 1 Oct 2025 01:31:23 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: dpsmith@apertussolutions.com, ross.philipson@oracle.com,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/9] tpm: Decouple Trenchboot dependencies
Message-ID: <aNxaO6HGSDzyUIBI@kernel.org>
References: <20250930221707.1373912-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930221707.1373912-1-jarkko@kernel.org>

On Wed, Oct 01, 2025 at 01:16:58AM +0300, Jarkko Sakkinen wrote:
> Overview
> ========
> 
> Decouple TPM driver features relevant for Trenchboot and make tpm-buf
> robust and decoupled entity from the rest of driver. By doing this, code
> can be easily linked to the early boot code.
> 
> Goals and scope
> ===============
> 
> This patch set contains only changes, which are acceptable to mainline
> driver without existence Trenchboot feature.
> 
> At the same the primary goal of the included is to make driver code 
> robust enough to meet Trenchboot's requirements.
> 
> These constraints should define a meaningful DoD for this patch set.
> 
> v4:
> - PCR patch has been removed because it does not fly without Trenchboot
>   context.
> v3:
> - I think 6.19 is a better goal for this and thus expanded the series to
>   be a generic Trenchboot enablers series. This version also consolidates my two separate ongoing series.
> v2:
> - While including fixes from v1, this patch set has a refocus in order to
>   do minimal changes to make code base more compatible  Trenchboot.
> 
> Jarkko Sakkinen (9):
>   tpm: Cap the number of PCR banks
>   tpm: Use -EPERM as fallback error code in tpm_ret_to_err
>   KEYS: trusted: Use tpm_ret_to_err() in trusted_tpm2
>   tpm2-sessions: Remove 'attributes' from tpm_buf_append_auth
>   tpm2-sessions: Unmask tpm_buf_append_hmac_session()
>   KEYS: trusted: Open code tpm2_buf_append()
>   tpm-buf: check for corruption in tpm_buf_append_handle()
>   tpm-buf: Remove chip parameter from tpm_buf_append_handle
>   tpm-buf: Enable managed and stack allocations.
> 
>  drivers/char/tpm/tpm-buf.c                | 141 ++++++----
>  drivers/char/tpm/tpm-chip.c               |  13 +-
>  drivers/char/tpm/tpm-sysfs.c              |  21 +-
>  drivers/char/tpm/tpm.h                    |   2 -
>  drivers/char/tpm/tpm1-cmd.c               | 185 +++++--------
>  drivers/char/tpm/tpm2-cmd.c               | 313 ++++++++++------------
>  drivers/char/tpm/tpm2-sessions.c          | 129 +++++----
>  drivers/char/tpm/tpm2-space.c             |  44 ++-
>  drivers/char/tpm/tpm_vtpm_proxy.c         |  30 +--
>  include/linux/tpm.h                       |  65 ++---
>  security/keys/trusted-keys/trusted_tpm1.c |  34 ++-
>  security/keys/trusted-keys/trusted_tpm2.c | 237 +++++++---------
>  12 files changed, 542 insertions(+), 672 deletions(-)
> 
> -- 
> 2.39.5
> 

I've done testing in sequence of the patch set for every patch by
running:

1. https://codeberg.org/jarkko/linux-tpmdd-test/src/branch/main/board/pc_x86_64/test_tpm2_kselftest.exp.in
2. https://codeberg.org/jarkko/linux-tpmdd-test/src/branch/main/board/pc_x86_64/test_tpm2_trusted.exp.in

I also separately booted for the managed allocations patch with
swtpm in TPM 1.2 mode and did some manual testing.

Changes have been tested with HMAC encryption on to make sure that
tpm2-sessions changes have beeen applied correctly.

BR, Jarkko

