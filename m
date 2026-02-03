Return-Path: <linux-integrity+bounces-8440-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHbvEVFmgmlOTgMAu9opvQ
	(envelope-from <linux-integrity+bounces-8440-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 22:19:13 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9959CDEC96
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 22:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C2D2302614E
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Feb 2026 21:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C59A2F90C4;
	Tue,  3 Feb 2026 21:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="R8cnpdEp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC46F280CC9;
	Tue,  3 Feb 2026 21:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770153503; cv=none; b=P+zCHizV5xjO9/flTHpEanBjcWC2LpvtWIW2WHmWpXtprPYkRE8Z0t4ss7StHvQ4hF9dICDR/R7FtK8u1KBtB3URL8nYtp5kZD3r87mZC4n2bHQALnhivXMts9Xddv/wJLSRrgP1vPt0gT7bIb+n80U+Zo35B2YPIJZGgwIADZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770153503; c=relaxed/simple;
	bh=wKQ/vCSI4Fs56NbgbfPSvJ7FqZ6PZSVVyAUx3n2PNKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8V2GfBO0eAP4in1t3pLwtuSd6c+v9X+KQxOCax737pkV22asR+2R7qtME9FHuQxNQXHoN6T2vHqEgZdHZdzhJlyFS3bOTjt/xTsk1R0gGqgkb9bMTH4m9LpwdxJTSymA9r236lZwg/oNe/RKUhMbXnYAWCII+cUGx43SLJUvUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=R8cnpdEp; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from killaraus.ideasonboard.com (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 5485B673;
	Tue,  3 Feb 2026 22:17:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1770153458;
	bh=wKQ/vCSI4Fs56NbgbfPSvJ7FqZ6PZSVVyAUx3n2PNKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R8cnpdEpedhk7rrBVZPF47OVSJrftKrUCeMmvjWHpmDaAmPm39uOmnon1wm6xiP/0
	 anwJvFFov3svYt+JC4XNJuSGab+mOdrrE42ALC1p7cQvS7Mk3Rw3ffPjcGI1hE6cXv
	 Ngz3j8ySR7SqN8NNJ33qS7PX34ougN3oOLT7R3qs=
Date: Tue, 3 Feb 2026 23:18:18 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: johannes.goede@oss.qualcomm.com
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Jarkko Sakkinen <jarkko@kernel.org>, linux-media@vger.kernel.org,
	anisse@astier.eu, oleksandr@natalenko.name,
	linux-integrity@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] media: Virtual camera driver
Message-ID: <20260203211818.GD11369@killaraus>
References: <20260202204425.2614054-1-jarkko@kernel.org>
 <6b192c71-c389-4a6e-b7c3-ddcd5cc4aa34@oss.qualcomm.com>
 <37a0d91c2e78c97f3d956444c4f7a2a2fca9ae06@intel.com>
 <c6b5832f-d7b3-4bc2-834e-4ce7b0c0b4cd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c6b5832f-d7b3-4bc2-834e-4ce7b0c0b4cd@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ideasonboard.com,none];
	R_DKIM_ALLOW(-0.20)[ideasonboard.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8440-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laurent.pinchart@ideasonboard.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[ideasonboard.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9959CDEC96
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 03:19:13PM +0100, johannes.goede@oss.qualcomm.com wrote:
> On 3-Feb-26 14:20, Jani Nikula wrote:
> > On Tue, 03 Feb 2026, johannes.goede@oss.qualcomm.com wrote:
> >> The problem is that what you're suggesting is basically a much
> >> improved (using dma-buf is way better) v4l2-loopback driver and
> >> v4l2-loopback has been blocked from getting merged into the kernel
> >> because besides the mobile-phone camera use, the other main use-case
> >> is to allow running proprietary camera stacks like Intel's proprietary
> >> camerastack and then presenting that to userspace as a standard v4l2
> >> cam so that userspace apps will just work.
> > 
> > ...
> > 
> >> The community concensus is that the solution here is for apps to
> >> access cameras through pipewire. Together with the shift of laptops
> >> cameras from UVC to "raw" MIPI cameras there also is a shift to
> >> running applications sandboxed as flatpacks because of the changing
> >> "cyber" security landscape. This is why pipewire was chosen because
> >> it also solves the accessing cameras from a sandbox issue.
> > 
> > Why is v4l2-loopback problematic from the perspective of facilitating
> > running proprietary camera stacks, but pipewire isn't?
> 
> Once pipewire mostly works everywhere for camera access then indeed
> this will allow proprietary stacks to present themselves as a pipewire src.
> For now though most proprietary stacks seem to prefer v4l2loopback because
> pipewire is not supported as camera source yet by a lot of apps.

I agree, that's a perfectly valid assessment of the situation.

> As I indicated in my original email personally I'm a bit divided on
> whether a virtual camera driver should be kept out of the kernel
> to not promote proprietary userspace stacks, but this is not my call.

Even disregarding that argument, the camera ecosystem is moving towards
implementing those use cases entirely in userspace with PipeWire. I
believe that merging a new kernel driver for this purpose, especially
one that exposes a custom API on its sink side and would therefore
require developing support in all source applications, goes against the
direction we're taking overall.

> OTHO evdi: https://github.com/DisplayLink/evdi has been kept out
> of the kernel for pretty much the same reasons by the drm/kms folks.
> 
> At least AFAIK there still is no way to present virtual kms capable
> display outputs backed by userspace in the kernel.
> 
> I completely understand where you're coming from wrt v4l2-loopback
> support (or something equivalent) but asking for this really is
> the same as asking for the evdi driver to get merged, which AFAIK
> has been blocked for the reason of avoiding proprietary userspace
> display output drivers (I guess there might be technical reasons too).

-- 
Regards,

Laurent Pinchart

