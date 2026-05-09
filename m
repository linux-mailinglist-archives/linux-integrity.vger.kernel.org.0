Return-Path: <linux-integrity+bounces-9510-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PgH6C4CM/2m17gAAu9opvQ
	(envelope-from <linux-integrity+bounces-9510-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 09 May 2026 21:35:28 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 634205013A9
	for <lists+linux-integrity@lfdr.de>; Sat, 09 May 2026 21:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7711E300F5EF
	for <lists+linux-integrity@lfdr.de>; Sat,  9 May 2026 19:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833D92D5926;
	Sat,  9 May 2026 19:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrC31f/r"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603B82F8E85;
	Sat,  9 May 2026 19:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778355324; cv=none; b=LECeyE0PlC0IM/Fv77f0/hRlBRdBmaJaHklCDKmSBbmAWhxZ4IzD/T/gojJnWz3VnRZUZqok9epvjP5zDLtZo69y1su91QvSkqSV41X0tfZQsSuWjly0ARos7Dsy8DGX8fq/riAAKLNwYRlWYqLIbCc8Rw3HNSmO/0LU6iHTu04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778355324; c=relaxed/simple;
	bh=xSGnJ7KcfkRUiHf2HbukwczXc/20ydUTVbPhvweO1ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzkZ0/pQO4HygrdR2myfuahTHeoN/WvHS0rNy1E26T445GQNN/XWvkj4iGZXRw4uJX9plmHjR9+Y1IupmV2kc0otHs9PBqJ9m00K1f04McskZbqmwB6NTdE99sEJf6VHs/Uolsliu2b2s1Wvt5mNV62rQddKP9GRTRUVfZAxxKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrC31f/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85948C2BCB2;
	Sat,  9 May 2026 19:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778355323;
	bh=xSGnJ7KcfkRUiHf2HbukwczXc/20ydUTVbPhvweO1ac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FrC31f/rtSDMomxskzHjKQyWEn9cM/DlKjTEw7ZPzXzBYy01j+hYncucwX8OmP5Hc
	 49gmzDsjhAO+EQTG2oHl0ww0SOIhposKLzmuxQYdcCboZBvwjV6u1A4AYKcDIEdpEc
	 URVf0rgsJH62Stp+1s02tsd6dMYekBrrRMdwZ5nhYc2N8LOqoOejbzNwscNCC+EFXy
	 NjO4DqCB+ItYCG4/WWULiKl7gsnECIOk9Fst5is7Q9slW6p/cBS+2wnjVOmsKnZ5BQ
	 UZQonSWxW4AW0Fcoq2FkKEVv85WryMgBh8B1ysNVNcCACh7GTZjcFBgAzYSGEewcGW
	 ohn14fxmg/Rkw==
Date: Sat, 9 May 2026 22:35:20 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Gunnar Kudrjavets <gunnarku@amazon.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, noodles@meta.com,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Justinien Bouron <jbouron@amazon.com>,
	Muhammad Hammad Ijaz <mhijaz@amazon.com>
Subject: Re: [PATCH] tpm: Fix uninitialized name_size_alg in
 tpm_buf_append_name()
Message-ID: <af-MeEbJFmab4YQ8@kernel.org>
References: <20260507201837.8282-1-gunnarku@amazon.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507201837.8282-1-gunnarku@amazon.com>
X-Rspamd-Queue-Id: 634205013A9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,meta.com,vger.kernel.org,amazon.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9510-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 08:18:22PM +0000, Gunnar Kudrjavets wrote:
> When tpm_buf_append_name() is called with a non-NULL name for a
> handle, the code skips the tpm2_read_public() path (which sets
> name_size_alg from the return value) and falls through to memcpy()
> with an uninitialized name_size_alg as the size argument.
> 
> The contract for tpm_buf_append_name() supports callers passing a
> non-NULL name. No current in-tree callers do so, making this a latent
> bug that would trigger if a caller ever provides a pre-computed name
> for a handle.

This is great observation but it is not a regression technically.

Thus, this really should just state the issue and don't make it
look like a bug report based on transcript that does not happen
in the wild.

I guess this is better than parameter removal since name caching
would make sense [1] in future.

[1] Already done but gathered zero interest at the time:
    https://lore.kernel.org/linux-integrity/20260125192526.782202-1-jarkko@kernel.org/
    Probably patch set should be reworked to have only relevant patches
    as my tpm_get_random() patches did not gather too much following :-)

BR, Jarkko

