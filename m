Return-Path: <linux-integrity+bounces-9191-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMGyDsD93mlINQAAu9opvQ
	(envelope-from <linux-integrity+bounces-9191-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 04:53:52 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ACE3FFDCC
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 04:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8513431977EB
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 02:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434AA335067;
	Wed, 15 Apr 2026 02:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPjr+LW1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217FA328B7B
	for <linux-integrity@vger.kernel.org>; Wed, 15 Apr 2026 02:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776220821; cv=none; b=QiwTgtvZlxtnqyowfC1dESGcetkbnDDon1kpPtgM5WZNPQBDagWfMpBOs5oQuJifDPnQimnotFae3X7un997ewSEBvT9yqVpmJUlfV0WdxBzJpsE16KIZ3+LmovsSBwAxXpk8NJGZ/MHAHogwHdJAdYOjC021pKBWyENCQbOwVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776220821; c=relaxed/simple;
	bh=GvMYdQDO9RGH9FMVjqSjcbhtQ3xhAxzGrHIs5G+AhbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLK1/eUV5YQ+m5YZ0cW5lQlhrZ8VpcWCAiOEhaZcrBpSVll76NAR+Xds+xuvfz9iVm+WVmfsKctgDdff2tUB2LiVpiDwqtkpmPE6DSQ79VhlbqqFNBJM4Nd6AgE/w7WszkqJ6noSFrNI/IXd8i9wPnrtwhaQCmHufETyoEiEiso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPjr+LW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41D6C2BCB3;
	Wed, 15 Apr 2026 02:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776220821;
	bh=GvMYdQDO9RGH9FMVjqSjcbhtQ3xhAxzGrHIs5G+AhbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gPjr+LW1jPBG5cn6E3K/fg8EetfzdetIibPJq9YTaEXoGZc1gOdPMcVP6jSLcDZE/
	 jhLjiapm+wL8MYHLxXNKKZSHAtGrgBFvADAI0EfBE613ji7iqen2lz3kNlbw+kHv9V
	 4h/BGvS2hOFuxxfN1hgqzybVzankLTB1hok0puG8Rb3Wn+d8T9h2pFEc87GYa1h7Sf
	 jemleFbIm2kzClpvala43IiMleyw3LbGcKi5xn1lmibkXWMDaa6oXdW+vDYjE6a1jv
	 HoodnMd+YqvZ2l5UtGXuyDszXlARplmI1C3Kp7jYhJToWTQWKsr18Toob+rYDhzu/b
	 zY4SQqh+rR8yA==
Date: Wed, 15 Apr 2026 05:40:17 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jacqueline Wong <jacqwong@google.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	axelrasmussen@google.com
Subject: Re: [PATCH v2 0/2] tpm_tis: fix retry exhaustion and add logging
Message-ID: <ad76kaEBsVIjeOX-@kernel.org>
References: <20260411003300.1823020-1-jacqwong@google.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411003300.1823020-1-jacqwong@google.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.de,ziepe.ca,google.com];
	TAGGED_FROM(0.00)[bounces-9191-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0ACE3FFDCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 11, 2026 at 12:32:58AM +0000, Jacqueline Wong wrote:
> The Fix:
> - Patch 1: Adds error logs to identify the specific hardware status mismatch.
> - Patch 2: Stops execution immediately when retries are exhausted.
> 
> v2 changes:
> - Split logging and logic into separate patches.
> - Added retry count to the error message.
> - Included dmesg traces below.
> 
> Testing:
> Dmesg traces obtained using error injection to simulate status register mismatches.
> 
> Before:
> [  130.288751] tpm tpm0: Operation Timed out
> [  250.306070] tpm tpm0: Operation Timed out
> [  250.310173] tpm tpm0: A TPM error (-62) occurred attempting to determine the timeouts
> 
> After:
> [   10.271547] tpm tpm0: TPM_STS_DATA_EXPECT should be unset. sts = 0x00000080
> ...
> [   10.646283] tpm tpm0: TPM_STS_DATA_EXPECT should be unset. sts = 0x00000080
> [   10.653461] tpm tpm0: Exhausted 50 tpm_tis_send_data retries
> [   10.659304] tpm tpm0: tpm_try_transmit: send(): error -5
> [   10.665435] tpm tpm0: TPM_STS_DATA_EXPECT should be unset. sts = 0x00000080
> ...
> [   11.037198] tpm tpm0: TPM_STS_DATA_EXPECT should be unset. sts = 0x00000080
> [   11.044441] tpm tpm0: Exhausted 50 tpm_tis_send_data retries
> [   11.050288] tpm tpm0: tpm_try_transmit: send(): error -5
> [   11.055723] tpm tpm0: A TPM error (-5) occurred attempting to determine the timeouts
> 
> Jacqueline Wong (2):
>   tpm: tpm_tis: add error logging for data transfer
>   tpm: tpm_tis: stop transmit if retries are exhausted
> 
>  drivers/char/tpm/tpm_tis_core.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> -- 
> 2.53.0.1213.gd9a14994de-goog
> 

OK, I dropped the patch that as I applied as I did not see this :-)

Now that we are cycling, please send v3 with checkpatch --strict passing

BR, Jarkko

