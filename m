Return-Path: <linux-integrity+bounces-8435-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJtfOTpIgmnzRgMAu9opvQ
	(envelope-from <linux-integrity+bounces-8435-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 20:10:50 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D503DE10E
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 20:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 146C230BE11E
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Feb 2026 19:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C1230DED1;
	Tue,  3 Feb 2026 19:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyjsgjQL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5592F12CF;
	Tue,  3 Feb 2026 19:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770145661; cv=none; b=EmE7rdWVDl+e/iAp5iT6OPBV4g9NaB/j7eloKVhzO8y+dssVRnqu+Ciz85a/2Kquerj+i3FNGwE+ltyVi9GRkB+LPEhgJYHUaI5aGRZGs7NiPE8j/7NSoa9JmA3OVEyMfOSW5pig4MK5cjCwHBqmjowCCzvVYi8p5qq2NmxDSJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770145661; c=relaxed/simple;
	bh=VwJIx44EhETKZxwlRXznjjwVe6CV2CZLC2YOmSVlKyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0Q1wz5Q+nj7Aei10usDMbScroPvJtQrBOQu9XxdWsDs2Xr0w4227QlnoQCRMLc3eaSA3yvzGRYF3fxXQqcUluoGoqZ44N2AmDkRKTBvrtGAtouZtw/CgSdiDpq6+7f1xKCcvhHd4dY5rNmnGQvzKRhljqSYGenXQSz2hjsGuq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyjsgjQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56026C116D0;
	Tue,  3 Feb 2026 19:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770145660;
	bh=VwJIx44EhETKZxwlRXznjjwVe6CV2CZLC2YOmSVlKyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tyjsgjQL3lxe3nAEGssKksqxPzbOdJGkAM2yha9eyjbjF5naZneeE/g5H3TOygO+I
	 LkRmFZYYQBjxjumVVJTTx+xZHj8liAG24VOUMt+0n9qcyUMNXmRsS5uQ5FtnDChjLz
	 goXsa+fsZntUuKJk/4/GVYQaC5qXSQ18lK7yktEk95fr8LSsuat7IbckG5cUm6UQmQ
	 Mo0qPOlvfimLMdft42UCesXKyvKZrCQXWbx30OwWDnDXMsXXrxNedgWu2XdU74k7p4
	 E0N5DDhpJkw0wmlr6CyafzVm7bcPhEu1XBDizRtqmb5vJY8xKKPhhMdJjnp7VWqUig
	 sKid+idBmWYYg==
Date: Tue, 3 Feb 2026 21:07:36 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: johannes.goede@oss.qualcomm.com, linux-media@vger.kernel.org,
	anisse@astier.eu, oleksandr@natalenko.name,
	linux-integrity@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] media: Virtual camera driver
Message-ID: <aYJHeOtZT9qBmLQu@kernel.org>
References: <20260202204425.2614054-1-jarkko@kernel.org>
 <6b192c71-c389-4a6e-b7c3-ddcd5cc4aa34@oss.qualcomm.com>
 <37a0d91c2e78c97f3d956444c4f7a2a2fca9ae06@intel.com>
 <c6b5832f-d7b3-4bc2-834e-4ce7b0c0b4cd@oss.qualcomm.com>
 <2bda02cb3da6cb6ca7dcf545a5b7af27fb7a6e37@intel.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bda02cb3da6cb6ca7dcf545a5b7af27fb7a6e37@intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8435-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mipi.org:url]
X-Rspamd-Queue-Id: 4D503DE10E
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 08:53:13PM +0200, Jani Nikula wrote:
> On Tue, 03 Feb 2026, johannes.goede@oss.qualcomm.com wrote:
> > OTHO evdi: https://github.com/DisplayLink/evdi has been kept out
> > of the kernel for pretty much the same reasons by the drm/kms folks.
> >
> > At least AFAIK there still is no way to present virtual kms capable
> > display outputs backed by userspace in the kernel.
> >
> > I completely understand where you're coming from wrt v4l2-loopback
> > support (or something equivalent) but asking for this really is
> > the same as asking for the evdi driver to get merged, which AFAIK
> > has been blocked for the reason of avoiding proprietary userspace
> > display output drivers (I guess there might be technical reasons too).
> 
> I'm not sure this is the same thing, though.
> 
> The DRM subsystem does require an open source userspace for new uAPI,
> which is stricter than most subsystems [1]. Other than that, I don't
> think anyone's actively keeping evdi out of the kernel. AFAIK there
> hasn't been a serious attempt at upstreaming it either. Which is pretty
> much because there's no open userspace. Nobody's cared enough to either
> write one or open source the existing one for a decade [2].

This is unrelated of ACK/NACK and not saying this as a "selling point"
but realistically speaking based on what I've read I have extremely hard
time to believe that my driver would enable a market of proprietary
camera drivers :-) Actually, after looking up mipi.org based on Hans
response, I even more so believe that this is the case.

> BR,
> Jani.

BR, Jarkko

