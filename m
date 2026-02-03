Return-Path: <linux-integrity+bounces-8439-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CnmM4FkgmkATgMAu9opvQ
	(envelope-from <linux-integrity+bounces-8439-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 22:11:29 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 473E8DEC08
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 22:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34510301FA47
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Feb 2026 21:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8871F2F90C4;
	Tue,  3 Feb 2026 21:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZYARaR9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A161A08BC;
	Tue,  3 Feb 2026 21:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770153085; cv=none; b=hMhQbcshpd88fjKp4uEUPTvzUyqA2gJf6agpDBX27uSvEOxKfR+EsC1wafuaUbkpdf4bUmX4FeaQ54e5yG6jBZ3fyxHCKZrlmlmcasX3jySFzfD7Ex3euyLLOC1Zxz0vfJSXxRiCUNM/E8gk54vmIZ08lpHZSm/DbDkVdwZ1M5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770153085; c=relaxed/simple;
	bh=NTZFLCwNdhv2d8qyf6fWYcj8dJBDdqRutv/GsTAS8sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6Xcd0Ndo8PW4SOZ8oo98Al/I4HQcn0vzLtJ5ljHcpShMumXBDuqxMK6Fx1If5i8tqIUN6jpN2ED2dGaAWQKC58AKXJwvS5fP15iK5cvg3RCcIclJT3PAdl856N/bhwgt7w8OCah4/i0rLcfUPxqfBVpvs5vI52soySQUM7ZvQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZYARaR9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE1FC116D0;
	Tue,  3 Feb 2026 21:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770153085;
	bh=NTZFLCwNdhv2d8qyf6fWYcj8dJBDdqRutv/GsTAS8sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mZYARaR9dIYkgQvwN1EDBd+/hYZYzMJG8jy1T45b0PQ+YA+gurbCx69DLknkV7pG0
	 I+Kpa7d/vtOzKRMbTpfUkcpgwiDycPZnV9TZFFf3aYGh/I1SVzrIs7NrRCGdcG6WBH
	 mzkvp6G2kP2TmmbqU0mn1WJ6c9XGqvyA7rxQr6h9UEZu1qips8BWJcUYTd1tyAHOqZ
	 TM5y+JFaljjKvgz1Gr39S3lK4P4KGYoSu5OMxuoLPMsauBokgMB3G8BVUgCG2SLvhN
	 AvErM1RXzDjzIobru+c0+ouXjJetm/T3RIjR7JXldXBR2VPg7ztrXXtZFyOoeoB1Cf
	 571dMrs6iXJKA==
Date: Tue, 3 Feb 2026 23:11:19 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-media@vger.kernel.org, jani.nikula@linux.intel.com,
	anisse@astier.eu, oleksandr@natalenko.name,
	linux-integrity@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] media: Virtual camera driver
Message-ID: <aYJkZEV6mX9Kl56X@kernel.org>
References: <20260202204425.2614054-1-jarkko@kernel.org>
 <aYEqHogDBqR1qGw3@kekkonen.localdomain>
 <aYE84i2GT5ntqZsO@kernel.org>
 <aYFRO1XdtEUkbSCg@kernel.org>
 <20260203205742.GB11369@killaraus>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203205742.GB11369@killaraus>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8439-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 473E8DEC08
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 10:57:42PM +0200, Laurent Pinchart wrote:
> Hello Jarkko,
> 
> On Tue, Feb 03, 2026 at 03:36:59AM +0200, Jarkko Sakkinen wrote:
> > On Tue, Feb 03, 2026 at 02:10:15AM +0200, Jarkko Sakkinen wrote:
> > > On Tue, Feb 03, 2026 at 12:50:06AM +0200, Sakari Ailus wrote:
> > > > On Mon, Feb 02, 2026 at 10:44:21PM +0200, Jarkko Sakkinen wrote:
> > > > > Already a quick Google survey backs strongly that OOT drivers (e.g.,
> > > > > v4l2loopback) are the defacto solution for streaming phone cameras in
> > > > > video conference calls, which puts confidential discussions at risk.
> > > > 
> > > > As I think it was pointed out in review comments for v1, the reason behind
> > > > using v4l2loopback is the use of a downstream driver, which itself is a
> > > > source of a security risk. If I understand correctly, supporting this
> > > > (proprietary/downstream vendor drivers) would be the main use case this
> > > > driver serves? Should this downstream driver be upstreamed to alleviate the
> > > > security risks, the need for v4l2loopback or similar drivers presumably
> > > > disappears.
> > > 
> > > My goal is not to proactively support proprietary drivers, and I don't
> > > know how to measure such incentive or risk, when it comes to video
> > > drivers.
> > > 
> > > And besides there is e.g. FUSE.
> > > 
> > > > Another of the downsides of such proprietary/downstream solutions is they
> > > > can never be properly integrated into the Linux ecosystem so functionality
> > > > will remain spotty (limited to specific systems and specific releases of
> > > > specific distributions) at best.
> > > > 
> > > > In other words, this driver appears to be orthogonal to solving either of
> > > > the above two problems the proprietary/downstream solutions have.
> > > > 
> > > > From the Open Source libcamera based camera software stack point of view
> > > > there doesn't seem to be a need for v4l2loopback or another similar driver.
> > > > The two main reasons for this is that (1) there's no need for glueing
> > > > something separate together like this and (2) V4L2 isn't a great
> > > > application interface for cameras -- use libcamera or Pipewire instead.
> > > 
> > > While I get this argument isolated, it does not match the observed
> > > reality, and does not provide tools to address the core issue. I
> > > will be in my grave before I've fixed the world like you are
> > > suggesting :-)
> 
> I really hope we'll provide a solution much faster than that :-)
> 
> > > Like, first off, where would I use libcamera or Pipewire? There's
> > > no well-defined target other than kernel in this problem.
> 
> PipeWire is becoming the de facto media server on desktop systems, for
> both audio and video. It has been shipped by distributions for a while
> for audio, and is the core component that allows screen capture (and
> therefore screen sharing in video conferencing) on Wayland-based
> systems. For video, PipeWire support has most notably been integrated in
> WebRTC, used by both Firefox and Chrome. The number of applications
> using PipeWire is growing, OBS has recently received support for
> PipeWire sources for instance. If you need to use it in an application
> that requires a V4L2 capture device, the pw-v4l2 script emulates the
> V4L2 API to provide a quick stopgap measure until applications get
> native PipeWire support.
> 
> libcamera solves an orthogonal problem, which is control of raw camera
> sensors and ISPs typically found in mobile and embedded devices, and now
> increasingly in laptops as well (Intel IPU3, IPU4, IPU6 and IPU7).
> Applications typically don't use libcamera directly, but interface it
> with GStreamer (libcamerasrc element) or PipeWire (which has native
> libcamera support).
> 
> While I understand that libcamera and PipeWire may be quite new for a
> large number of users, the ecosystem is moving in that direction, and
> both projects are very active.

Thanks for the information and I take this into account when/if considering
any updates.  The response is so informative that I need to purge this a
bit (thank you for that) :-) This does not disregard your response but
personally I'm not have huge a fan of LD_PRELOAD style compatibility
wrappers.

BR, Jarkko

