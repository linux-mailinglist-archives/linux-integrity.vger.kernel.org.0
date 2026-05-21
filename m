Return-Path: <linux-integrity+bounces-9624-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GYyKRh/D2otMwYAu9opvQ
	(envelope-from <linux-integrity+bounces-9624-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 23:54:32 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C568D5AC34F
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 23:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE4623018F4A
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 21:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A7032FA29;
	Thu, 21 May 2026 21:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJGcKO1x"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA19B2DC79B;
	Thu, 21 May 2026 21:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779400434; cv=none; b=AMbv871BxN/NWjfcGJlOGHvJu4VY/cy2NbkTiJzm768EN+UGe0LtVkutcjtKdeNpCRY/eehjzy6ZzfXZuPc3uxXS0kJ4jZ/70AorGjzgazkUN+ss7PipeqRQreglq8pTNrnY82DEocbzgUcHzsqE2Yc1kK8aD1e+PloWJIWs5Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779400434; c=relaxed/simple;
	bh=55ydIiCWZiBd2/tRLCeNhN94gwvw/mkduaD9CApCRLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsPagW0nFiPuAsMrL2iyeXB2TLBBnNHW3/w4CQ4P58cNG2XsOxOPdy2dnM/fHG1CGwEMIoRihzi+pAGcWLkW4NM2KBY3i/w3Mp4TFH5EsLS+j68Waiv3tdFKONwL750PQb86om0tOzV5ie1xGYDn54CXQXQQpEfKcI2wCGXVo5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJGcKO1x; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 405271F000E9;
	Thu, 21 May 2026 21:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779400432;
	bh=n8Kv8UoyIZ7XkgflVG0FJ2h6VKknqwaJkgqdnOooapw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XJGcKO1x7A3m3GceZVzO65wWepuc+EFiBnMNiaAva7A8hg3DyTgy3kXtHMzZgMcIs
	 3og4ov5W3gQ5Tr2NI6o9k7P7LVBdlUZaDv6MFssvmZXFxe2JAwMG9+AGkVM9K14msa
	 O7LJJNEsrVrB7rvBxO66wQNnkZXqn9vlvpSFk7UqHYYYqN+rlK1Qetguya3WdzTuB0
	 1vEEJT4xK2//s9ZKfs0tKWLbwc2nZF9YO7gmYjDn8xfJNpa06Ly0CTmGQaUHPGjHrp
	 rVVNb/1n32UgB0jtjoFc8YzdKyfMlPEQv1XljTr+qndZoMPNFgBn8wlIrzZA+PDT2x
	 zV8HBbWwkG3gg==
Date: Fri, 22 May 2026 00:53:48 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arun Menon <armenon@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v3 0/6] tpm_crb: Add command and response buffer chunking
 support
Message-ID: <ag9-7EI10ZxbUH2z@kernel.org>
References: <20260518151724.730443-1-armenon@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518151724.730443-1-armenon@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9624-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,gmx.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	HAS_WP_URI(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,trustedcomputinggroup.org:url]
X-Rspamd-Queue-Id: C568D5AC34F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 08:47:18PM +0530, Arun Menon wrote:
> The new version of TCG TPM v185 [1] supports sending data/commands in
> chunks for the CRB (Command Response Buffer) interface. This is in line
> with the initiative to support PQC algorithms.
> 
> This series implements the logic to send and receive larger TPM
> cmd/rsp between the linux guest and the TPM backend in chunks.
> Currently, the TPM CRB driver is limited by the physical size of the
> MMIO window. When userspace attempts to send a payload that exceeds this
> size, the driver rejects it.
> 
> This series introduces chunking support. The driver now checks the CRB
> interface capability for CRB_INTF_CAP_CRB_CHUNK. If supported by the
> backend, the driver will slice oversized commands into MMIO-sized
> chunks, signalling the backend via CRB_START_NEXT_CHUNK, and finalizing
> with CRB_START_INVOKE. Responses are also read back in a similar chunked
> manner.
> 
> If the backend does not support chunking, the driver retains its legacy
> behaviour and enforces the standard size limits.
> 
> This feature also requires the QEMU to interpret the data in chunks and
> forward it to the TPM backend and subsequently dispatch the TPM response
> in chunks back to the linux guest. This is implemented in [2]
> 
> This series depends on Jarkko's unmerged patch from the mailing list:
> [PATCH v9 11/11] tpm-buf: Implement managed allocations.
> 
> Depends-on: <http://lore.kernel.org/20260125192526.782202-12-jarkko@kernel.org>

I'll rebase this to the latest master so that it can be included to the
series.

> 
> The whole series applied on top of for-next-tpm branch (with prerequisite)
> can be found here:
> https://github.com/armenon-rh/linux/tree/tpm-crb-linux
> 
> [1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_Pub.pdf
> [2] https://lore.kernel.org/qemu-devel/20260506075813.120781-1-armenon@redhat.com/
> 
> v3
> --
> - Split patch 2, so that the code is cleaner.
> - Re-order the buffer size adjustment patch.
> - Rename crb_trigger_tpm to tpm_crb_start.
> - Add dispatching logic in send and recv functions. Chunking is
>   separated from no-chunking for clarity.
> - Increase TPM_BUFSIZE in the common file include/linux/tpm.h following,
>   [PATCH v9 11/11] tpm-buf: Implement managed allocations
>   https://lore.kernel.org/linux-integrity/20260125192526.782202-12-jarkko@kernel.org/
> 
> v2
> --
> - Add size checks before copying memory.
> - Update TPM_BUFSIZE to 8KB.
> - Commit messages updated to indicate motivation and logic of the change.
> 
> Arun Menon (6):
>   tpm_crb: Add register definitions of TPM CRB chunking fields
>   tpm_crb: Split start method into a separate header
>   tpm_crb: Add start_cmd parameter to tpm_crb_start wrapper
>   tpm: tis_i2c: Use local 4KB buffer to limit memory usage
>   tpm: Increase TPM_BUFSIZE to 8kB for chunking support
>   tpm_crb: Implement command and response chunking logic
> 
>  drivers/char/tpm/tpm_crb.c     | 257 +++++++++++++++++++++++++--------
>  drivers/char/tpm/tpm_tis_i2c.c |   6 +-
>  include/linux/tpm.h            |   2 +-
>  3 files changed, 204 insertions(+), 61 deletions(-)
> 
> -- 
> 2.54.0
> 

BR, Jarkko

