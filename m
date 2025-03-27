Return-Path: <linux-integrity+bounces-5473-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C74BDA73322
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 14:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DA9B3AA287
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 13:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D768F4C6C;
	Thu, 27 Mar 2025 13:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3Moa8Nm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16184409
	for <linux-integrity@vger.kernel.org>; Thu, 27 Mar 2025 13:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743081326; cv=none; b=GZDYsC9MSBTcSuqs6m+2OrfaFBqnpLIXQzyFsDKUHFmnCsCsuc692/kZfrpUThZ3fnxMNBAEOPKM0P13ygpNq8oyM8M7RPhmzl3Z7ds1uJkfXthbRQQhXMdvxdGW/u614XqbYZ+X3uySOqpTREwP9cAk8/57ffO47NY34/+5LFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743081326; c=relaxed/simple;
	bh=uz15+RwhvbrVTIpm3heuGs+gwObHr+xG+vEXx78nkwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcA6OHyFwOQ33O1JaKxcOaRTmLmJY5yG48ssBO97rXukEHdJJPu9Z4Y38guoyPyr39vPOm+SmtxMJxGZ+DiiCJdlo03ehPxrT8+g/HopeEmVifUVVKX6dF2SI5ap4wCyAKo18ffIUP7LTnxQ16cxdjOXcfbHgcvYKS9tsKardgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3Moa8Nm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39F3C4CEDD;
	Thu, 27 Mar 2025 13:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743081326;
	bh=uz15+RwhvbrVTIpm3heuGs+gwObHr+xG+vEXx78nkwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F3Moa8NmDVNBLwYxethNzTePIxjNaUEhrUQiDHfnZzpFg4PSrZVeqA5hK5pmtFO4d
	 m7WmsXqzxkG1bNNmUQTBHKZ8mEYxKvze2/Hbpe53e2bHzEqZxMTkd3/JYs9TTraJhN
	 T7le/kaf1Er1avM2+esTipXYVCG1FdCDjRTlEA/kksuaAev2bQHMfvS0AtURheLBrQ
	 vNfPIjaVAtV3X0g9BGu5EIdF/+IduDuXLhMDNYtJz/FDEI2kTPOga31wXWNs4DhLEb
	 6I6OBmOljsXESFCpGKi5+yH4/KNRwv6rI0hkScA81AiHHLmgHXC7HNmKv3w0hx4bHo
	 mD1aa2G/7hc/A==
Date: Thu, 27 Mar 2025 15:15:22 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Jonathan McDowell <noodles@earth.li>, linux-integrity@vger.kernel.org
Subject: Re: TPM operation times out (very rarely)
Message-ID: <Z-VPaqDKMo2RR61w@kernel.org>
References: <D7FSS837QLNR.5XOU66J6FBTU@kernel.org>
 <Z5yLYVBn6inIH8cG@kitsune.suse.cz>
 <D7G6P7W7AY65.257WPBC8I3HAF@kernel.org>
 <Z5zJ7R6vDU4h9iDk@kitsune.suse.cz>
 <D7GFCNGDK7S6.1X0KPPHF1TXBO@kernel.org>
 <Z50IKdYe42_n2B0b@kitsune.suse.cz>
 <D7GIBDO5KJMD.118CQO10LJ79Y@kernel.org>
 <Z6Nm7Y8TFF8YG56Z@kitsune.suse.cz>
 <Z6N10NQY75hpX0Ed@earth.li>
 <Z-VLTKkB_-PoNAly@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-VLTKkB_-PoNAly@kitsune.suse.cz>

On Thu, Mar 27, 2025 at 01:57:48PM +0100, Michal Suchánek wrote:
> This does not address the other problem that when the rimeout triggers
> on something like LOAD CONTEXT then the kernel and the TPM don't agree
> on what the state of the context is.

In the case of tpm2-sessions, and in-kernel callers, we could try to
improve the situation in some of the edge cases.

Out-of-my sleeve ideas:

1. E.g., tpm2_load_null() could potentially have retries instead of
   single trial.
2. Perhaps timeout in tpm_tis should be adaptive? It could be by
   defaault 2s and would grow on trials.


> 
> Thanks
> 
> Michal

BR, Jarkko

