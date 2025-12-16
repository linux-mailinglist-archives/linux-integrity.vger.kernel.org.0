Return-Path: <linux-integrity+bounces-8058-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA91CC15C4
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 08:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F07D23028C40
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 07:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FBB325730;
	Tue, 16 Dec 2025 07:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIbql9Ka"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FA230C606;
	Tue, 16 Dec 2025 07:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765871315; cv=none; b=B+4Lg3DX3rejTW2wG2aBJjc96i8YNyhVF+qP5KBED3WAAgW95W2HA4cfN5qn6WgEb5bNTGohJlECxN/1N0lnjEd5vOqPMekhyFOjUBOrO33oGAxZa0wlGhkygZ0humQeguV1AwkysL/QZsPjc3oyX4PhAEpTnSz6m908/hPNxTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765871315; c=relaxed/simple;
	bh=KKHEVN5x0ev46lkAmT+VBGA/kta0x+ZlLwCFhS+HqeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKPk2N8wh0YgLGM8mDb5z9MwTMobDvcoc9l32PsFJ7h9/m9mLBYudkyUHuefLHCAne3gfB+YdIAcF5O2woqf37Kz5Rom1u+sBPCCE112LGWPraOKJr2GpOwf53TKyczWj0a1wD2d6ehP5GlTy7DFvTKBfvU4cI2USvP3NXArZsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIbql9Ka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7BEC4CEF1;
	Tue, 16 Dec 2025 07:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765871315;
	bh=KKHEVN5x0ev46lkAmT+VBGA/kta0x+ZlLwCFhS+HqeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jIbql9KaxmXJc3I8wR1pqrmRPuAjCcpyypLbc7eqfwPv9hFhKmHQJfes5zWNex6oI
	 SmC13phbeugUWhBOgTdassd83AjxIqJL8SZzj+U9Pjqw/qyDN8B5G//lTfhZcS3ZWR
	 djz5GtFa6o2ANUj8QNs6V3kwlekWyoisZjBnZOBvFnSgfvqjFQRTly9CvgmdoxYykW
	 19FZ6UBaIhGgmBNthaZ8Xna5tEMFbYT4XqCG5EzwGEB9ChP91LbgswiohsOUKMHl3O
	 /3Udxglu4D2uh4c47QVGR2vj2Xx7eLj1A39aCyMuoA2yhoDNWKN302Q1hSP6STmCAb
	 KpISimXHBwYEg==
Date: Tue, 16 Dec 2025 09:48:31 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 00/12] Streamline TPM2 HMAC sessions
Message-ID: <aUEOz_dwDv7gGMRW@kernel.org>
References: <20251216074454.2192499-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216074454.2192499-1-jarkko@kernel.org>

On Tue, Dec 16, 2025 at 09:44:41AM +0200, Jarkko Sakkinen wrote:
> This patch set contains accumulated patches, which gradually improve 
> TPM2 HMAC session management and TPM driver memory management.
> 
> RNG test
> ========
> 
> I run this test both TPM1 and TPM2 chips using QEMU and swtpm:
> 
> #!/bin/sh
> 
> ctrl_c() {
>   kill -15 $TEST_PID
>   echo 0 > tracing_on
>   echo nop > current_tracer
>   echo > kprobe_events
>   echo > set_ftrace_filter
>   echo BYE
>   exit
> }
> 
> trap ctrl_c EXIT INT
> mount -t tracefs none /sys/kernel/tracing
> 
> set -e
> 
> cd /sys/kernel/tracing
> echo function > current_tracer
> echo p:tpm_get_random tpm_get_random > kprobe_events
> echo tpm_get_random > set_ftrace_filter
> echo 1 > tracing_on
> TEST_PID=$(cat /dev/hwrng > /dev/null &)
> echo > trace
> cat trace_pipe &
> sleep 10

Oops, and old version. This was the one I run:

#!/bin/sh

ctrl_c() {
  set +e
  echo 0 > tracing_on
  echo nop > current_tracer
  echo BYE
  exit
}

trap ctrl_c EXIT INT
mount -t tracefs none /sys/kernel/tracing

set -e
cd /sys/kernel/tracing
echo function > current_tracer
echo p:tpm_get_random tpm_get_random > kprobe_events
echo tpm_get_random > set_ftrace_filter
echo 1 > tracing_on
cat /dev/hwrng > /dev/null &
echo > trace
cat trace_pipe &
sleep 10


> 
> Change Log
> ==========
> 
> v7:
> - Updated cover letter to match better the current state of the patch
>   set.
> v6:
> - OK, so I decided to send one more update with managed allocations
>   moved to the tail so that it does not block reviewing more trivial
>   patches.
> - Trimmed some of the patches and improved commit messages.
> v5:
> - I decided to add the managed allocation patch to this and take it from
>   the master branch for the time being, as it needs more eyes despite
>   having already one reviewed-by tag (especially tested-by tags).
> 
> Jarkko Sakkinen (12):
>   KEYS: trusted: Use get_random-fallback for TPM
>   KEYS: trusted: Use get_random_bytes_wait() instead of tpm_get_random()
>   tpm2-sessions: Define TPM2_NAME_MAX_SIZE
>   KEYS: trusted: Open code tpm2_buf_append()
>   KEYS: trusted: Remove dead branch from tpm2_unseal_cmd
>   KEYS: trusted: Re-orchestrate tpm2_read_public() calls
>   tpm2-sessions: Remove AUTH_MAX_NAMES
>   tpm: Orchestrate TPM commands in tpm_get_random()
>   tpm: Change tpm_get_random() opportunistic
>   tpm-buf: Merge TPM_BUF_BOUNDARY_ERROR and TPM_BUF_OVERFLOW
>   tpm-buf: Implement managed allocations
>   tpm-buf: Remove tpm_buf_append_handle
> 
>  drivers/char/tpm/tpm-buf.c                | 154 ++++-----
>  drivers/char/tpm/tpm-interface.c          | 145 ++++++++-
>  drivers/char/tpm/tpm-sysfs.c              |  23 +-
>  drivers/char/tpm/tpm.h                    |   3 -
>  drivers/char/tpm/tpm1-cmd.c               | 198 ++++--------
>  drivers/char/tpm/tpm2-cmd.c               | 371 +++++++---------------
>  drivers/char/tpm/tpm2-sessions.c          | 272 ++++++----------
>  drivers/char/tpm/tpm2-space.c             |  44 ++-
>  drivers/char/tpm/tpm_vtpm_proxy.c         |  30 +-
>  include/linux/tpm.h                       |  77 +++--
>  security/keys/trusted-keys/trusted_tpm1.c |  70 ++--
>  security/keys/trusted-keys/trusted_tpm2.c | 329 ++++++++++---------
>  12 files changed, 776 insertions(+), 940 deletions(-)
> 
> -- 
> 2.39.5
> 

BR, Jarkko

