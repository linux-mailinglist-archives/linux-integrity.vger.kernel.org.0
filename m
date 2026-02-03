Return-Path: <linux-integrity+bounces-8442-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJNuKxxngmmETgMAu9opvQ
	(envelope-from <linux-integrity+bounces-8442-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 22:22:36 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 108BFDED23
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 22:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04D4E30238EA
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Feb 2026 21:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA8730E83F;
	Tue,  3 Feb 2026 21:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="R/6G2dPD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B918F2DCF61;
	Tue,  3 Feb 2026 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770153751; cv=none; b=tQ5jMMG4m/vXKKHnZ8+Sb6PRc8HmQfN1m294/eKgb0588WMCfcpUoDoaixPWuD58NJ5QED5vH9aG2TugOEK6lOW3l4O1k9bidQnkXFXXOku6ruWLVACOUIOUp1iB94khggS6yO6r3Z5an1przPhJAxA+3sSPRbQaCbdeulK9B3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770153751; c=relaxed/simple;
	bh=/g5zX3YPTqscDXF6T3zgPUZtSMHSuRj/OQ9EbVXsZ+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4HAYeJeCgArNj5/WeuHCFdn5pR7NxJf5piHIZRitjtJ1wW7H43JBf27p1SkspqFF6MxQwfOdRFaraW1FMfKTgXjGXj3gqImEsbTqc53CBq2oO7XX24/wQQULyte4wEaekF7iLIUwYtwlSj5AymWvKIclhQr4Jmwdqxldo4aE0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=R/6G2dPD; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from killaraus.ideasonboard.com (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 30C11673;
	Tue,  3 Feb 2026 22:21:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1770153706;
	bh=/g5zX3YPTqscDXF6T3zgPUZtSMHSuRj/OQ9EbVXsZ+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R/6G2dPDW37zaHdjkWiIcCSfsJWXrt5pi9kOv7rPrswcUyfL8APMHbRJ8K1VbPsJE
	 Hf75leh0o9rGe/nGSWU/Goh15/2vCZqyRcY8Ux/EfKjivzxdYCZYjrEPn2fjR/1fox
	 Ad8r2mtl0KKF98qKzJIXdLsMP8yurvrWk2Bpm084=
Date: Tue, 3 Feb 2026 23:22:26 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	johannes.goede@oss.qualcomm.com, linux-media@vger.kernel.org,
	anisse@astier.eu, oleksandr@natalenko.name,
	linux-integrity@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] media: Virtual camera driver
Message-ID: <20260203212226.GF11369@killaraus>
References: <20260202204425.2614054-1-jarkko@kernel.org>
 <6b192c71-c389-4a6e-b7c3-ddcd5cc4aa34@oss.qualcomm.com>
 <37a0d91c2e78c97f3d956444c4f7a2a2fca9ae06@intel.com>
 <c6b5832f-d7b3-4bc2-834e-4ce7b0c0b4cd@oss.qualcomm.com>
 <2bda02cb3da6cb6ca7dcf545a5b7af27fb7a6e37@intel.com>
 <aYJHeOtZT9qBmLQu@kernel.org>
 <aYJJWPLr4Qxkmn7z@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aYJJWPLr4Qxkmn7z@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ideasonboard.com,none];
	R_DKIM_ALLOW(-0.20)[ideasonboard.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8442-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laurent.pinchart@ideasonboard.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[ideasonboard.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ideasonboard.com:dkim]
X-Rspamd-Queue-Id: 108BFDED23
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 09:15:36PM +0200, Jarkko Sakkinen wrote:
> On Tue, Feb 03, 2026 at 09:07:41PM +0200, Jarkko Sakkinen wrote:
> > On Tue, Feb 03, 2026 at 08:53:13PM +0200, Jani Nikula wrote:
> > > On Tue, 03 Feb 2026, johannes.goede@oss.qualcomm.com wrote:
> > > > OTHO evdi: https://github.com/DisplayLink/evdi has been kept out
> > > > of the kernel for pretty much the same reasons by the drm/kms folks.
> > > >
> > > > At least AFAIK there still is no way to present virtual kms capable
> > > > display outputs backed by userspace in the kernel.
> > > >
> > > > I completely understand where you're coming from wrt v4l2-loopback
> > > > support (or something equivalent) but asking for this really is
> > > > the same as asking for the evdi driver to get merged, which AFAIK
> > > > has been blocked for the reason of avoiding proprietary userspace
> > > > display output drivers (I guess there might be technical reasons too).
> > > 
> > > I'm not sure this is the same thing, though.
> > > 
> > > The DRM subsystem does require an open source userspace for new uAPI,
> > > which is stricter than most subsystems [1]. Other than that, I don't
> > > think anyone's actively keeping evdi out of the kernel. AFAIK there
> > > hasn't been a serious attempt at upstreaming it either. Which is pretty
> > > much because there's no open userspace. Nobody's cared enough to either
> > > write one or open source the existing one for a decade [2].
> > 
> > This is unrelated of ACK/NACK and not saying this as a "selling point"
> > but realistically speaking based on what I've read I have extremely hard
> > time to believe that my driver would enable a market of proprietary
> > camera drivers :-) Actually, after looking up mipi.org based on Hans
> > response, I even more so believe that this is the case.
> 
> With my maintainer hat on, I'd get the nack better if the driver was
> intrusive on changes to V4L2 subsystem itself. Then, it accumlates
> weight to other maintainers, and as we all have limited amount of time
> in our lives, I do get that. But since the driver would be compliance
> aligning leaf driver with a MAINTAINER entry of its own, it should not
> be a huge burden for V4L2 community and kernel maintainers.  And I do
> have a track record of being long-term on maintaining stuff that I vomit
> out.

I don't dispute that. Even though we haven't really worked together on
kernel development, I have no prejudice towards your commitment as a
driver maintainer :-) There's nothing personal in this mail thread.

> That also does make difference as there are some guarantees that the
> end product would not be left into rotten.

-- 
Regards,

Laurent Pinchart

