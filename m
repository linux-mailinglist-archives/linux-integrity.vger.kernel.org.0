Return-Path: <linux-integrity+bounces-9700-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aINbMasbGmo+1ggAu9opvQ
	(envelope-from <linux-integrity+bounces-9700-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 30 May 2026 01:05:15 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5BA609978
	for <lists+linux-integrity@lfdr.de>; Sat, 30 May 2026 01:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C1D4300FC71
	for <lists+linux-integrity@lfdr.de>; Fri, 29 May 2026 23:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB0A36C5BB;
	Fri, 29 May 2026 23:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5GcoDha"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA278360751;
	Fri, 29 May 2026 23:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780095711; cv=none; b=mCIwVsvAU2ywG8ExBCjykXVxYBt7tW0zlDXFON3wCBqCMB9fAuIwv5s+AvKfLGnJs8et1HzkJVX4zYKhYjctehJDqFZVFFhbH/eTrpNW0/9qmHC2G7bliqLoGwRde8omMwXpm5thCgKGfGzYjK5E6a0sdP0LBlN5p7FzWLP2D94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780095711; c=relaxed/simple;
	bh=ii38ZSmKsDVlPZAbujyb8Hxn9+FNqpS8n/F87GKkMp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=px+DC/r6AeCcYR1TfbS/hvGCvtdy67TLeBVVHXKfziuwmquxfHQPXB11G9G67WpqUURz55Nm4nHDNgMb6KRukA9FkWoEhWxhB/yYl0liDp7Sx0C6H8hWYEWDlqexsGhlxOX8NB6v8O1Tsf91eU+hiyKJ0EGA7uFscqqcB4vyyTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5GcoDha; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C57A61F00893;
	Fri, 29 May 2026 23:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780095710;
	bh=EjUgsy/T9O/KcziuszcgcAirLPSLIH6eFC8qtkJOoDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y5GcoDhaEvUvdm8NhunNSmHRUdSSX9PD3nUioK+7JiHfHQeUkC/g7pi82W4rQv+eG
	 v1waZT6Nccd9+B0dZdg6WK3qpeYG3merKJjZtxf+MXYpPr9WV08iEoxuNs1F6L4MYM
	 ZBW45gdK/OlTvcVfoMjAvwRKey096ukn86Irt4citeoDW9NEIcJ7F9js0Zfst0FV4u
	 ++5kQ9+0GQ+kOV1kqOSBcSH+EgiQ/Wj4wTLXYwcTQ4Fq7N8cBGTDCe+25VsIpYC3Ci
	 2LvSHSfdHFKaTex3CfbC2tvv3hyY+7M6mYSx43qpqKWjJ4TXf3u8CLcTLKrQqj2qQb
	 6B+HWzJNYhaBA==
Date: Sat, 30 May 2026 02:01:46 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jim Broadus <jbroadus@gmail.com>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: [PATCH v3 0/2] tpm: tpm_tis: Fix probe of some older TPMs
Message-ID: <ahoa2s9NXW_gU0e9@kernel.org>
References: <20260519154530.6386-1-jbroadus@gmail.com>
 <20260526232245.5409-1-jbroadus@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526232245.5409-1-jbroadus@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9700-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.de,ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: CC5BA609978
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 04:22:42PM -0700, Jim Broadus wrote:
> Changes v3:
> - Renamed the series from "Add optional delay after relinquish" to
>   "Fix probe of some older TPMs"
> - Addressed review comment, saving entire did_vid in priv structure.
> - Use did_vid value to identify problem TPM and apply quirk.
> Changes v2:
> - Move delay from tpm_tis_relinquish_locality to
>   __tpm_tis_relinquish_locality.
> 
> Link to v2: https://lore.kernel.org/all/20260519154530.6386-1-jbroadus@gmail.com/
> 
> Jim Broadus (2):
>   tpm: tpm_tis: store entire did_vid
>   tpm: tpm_tis: Add settle time for some TPMs
> 
>  drivers/char/tpm/tpm_tis_core.c | 28 ++++++++++++++++++++--------
>  drivers/char/tpm/tpm_tis_core.h |  3 ++-
>  2 files changed, 22 insertions(+), 9 deletions(-)
> 
> -- 
> 2.54.0
> 

I think this now much better structured, thank you. I'll add this thread
to my TODO folder and try it out before any further feedback.

BR, Jarkko

