Return-Path: <linux-integrity+bounces-8437-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBdZJlthgmkzTQMAu9opvQ
	(envelope-from <linux-integrity+bounces-8437-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 21:58:03 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AB5DEAEF
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 21:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 468F23020A7B
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Feb 2026 20:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C8F2FD1CA;
	Tue,  3 Feb 2026 20:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LDoLj6Sv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6702F513;
	Tue,  3 Feb 2026 20:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770152268; cv=none; b=nsTnK7kwMzyiP8/wBXnatWcuLGPJ1rLJJXoljgfok5yfjLCDa0KEdKqjpLksilV8n9l1Ch81lvGQ/Dqo4wZPhHRHlQA2/GQhNmct/3gvzfzsYHBGFnDwcMaiUNTJVvFfUUL/ZanKErbpNmWOqayr7MdwkYadIyp4cvjSsvN5+QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770152268; c=relaxed/simple;
	bh=OFM8TlozEflfNpuoe5MpLqlAdbKoFajG6yXFMB9EBgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmiqENsVbUkhBjTFt++dvL2/QHacYBe9pKeY7lyc/vneGsT84uXC+U1SGF272GL3BNV+Jc7wsZ7N91pGh8vhIBLwnSWBxoj9yVgC5ECeeLWoEGYhgTreh9JJ2UJshahbGpFFVPR4UYRDsUwlnP7M09zxv9LR5dphOu8SMXNMdG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=LDoLj6Sv; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from killaraus.ideasonboard.com (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id B2E696DC;
	Tue,  3 Feb 2026 21:57:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1770152222;
	bh=OFM8TlozEflfNpuoe5MpLqlAdbKoFajG6yXFMB9EBgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LDoLj6SvHC2jaO2UKVtPk2nNUwI+KZk2KoyfQOA54DIL0Q7Woi1ryDlTDj3yUT2q6
	 fFp3H3fmVIQCAYA/ljinr/nygdw0uYcwAJHJTZ9Nf/OfuLSxDz51DMperyAyFAsWnO
	 f4tVx1ykUCxA20V401+3JqAmEvOyBoPN+NrRNOkw=
Date: Tue, 3 Feb 2026 22:57:42 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
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
Message-ID: <20260203205742.GB11369@killaraus>
References: <20260202204425.2614054-1-jarkko@kernel.org>
 <aYEqHogDBqR1qGw3@kekkonen.localdomain>
 <aYE84i2GT5ntqZsO@kernel.org>
 <aYFRO1XdtEUkbSCg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aYFRO1XdtEUkbSCg@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ideasonboard.com,none];
	R_DKIM_ALLOW(-0.20)[ideasonboard.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8437-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ideasonboard.com:dkim]
X-Rspamd-Queue-Id: F3AB5DEAEF
X-Rspamd-Action: no action

Hello Jarkko,

On Tue, Feb 03, 2026 at 03:36:59AM +0200, Jarkko Sakkinen wrote:
> On Tue, Feb 03, 2026 at 02:10:15AM +0200, Jarkko Sakkinen wrote:
> > On Tue, Feb 03, 2026 at 12:50:06AM +0200, Sakari Ailus wrote:
> > > On Mon, Feb 02, 2026 at 10:44:21PM +0200, Jarkko Sakkinen wrote:
> > > > Already a quick Google survey backs strongly that OOT drivers (e.g.,
> > > > v4l2loopback) are the defacto solution for streaming phone cameras in
> > > > video conference calls, which puts confidential discussions at risk.
> > > 
> > > As I think it was pointed out in review comments for v1, the reason behind
> > > using v4l2loopback is the use of a downstream driver, which itself is a
> > > source of a security risk. If I understand correctly, supporting this
> > > (proprietary/downstream vendor drivers) would be the main use case this
> > > driver serves? Should this downstream driver be upstreamed to alleviate the
> > > security risks, the need for v4l2loopback or similar drivers presumably
> > > disappears.
> > 
> > My goal is not to proactively support proprietary drivers, and I don't
> > know how to measure such incentive or risk, when it comes to video
> > drivers.
> > 
> > And besides there is e.g. FUSE.
> > 
> > > Another of the downsides of such proprietary/downstream solutions is they
> > > can never be properly integrated into the Linux ecosystem so functionality
> > > will remain spotty (limited to specific systems and specific releases of
> > > specific distributions) at best.
> > > 
> > > In other words, this driver appears to be orthogonal to solving either of
> > > the above two problems the proprietary/downstream solutions have.
> > > 
> > > From the Open Source libcamera based camera software stack point of view
> > > there doesn't seem to be a need for v4l2loopback or another similar driver.
> > > The two main reasons for this is that (1) there's no need for glueing
> > > something separate together like this and (2) V4L2 isn't a great
> > > application interface for cameras -- use libcamera or Pipewire instead.
> > 
> > While I get this argument isolated, it does not match the observed
> > reality, and does not provide tools to address the core issue. I
> > will be in my grave before I've fixed the world like you are
> > suggesting :-)

I really hope we'll provide a solution much faster than that :-)

> > Like, first off, where would I use libcamera or Pipewire? There's
> > no well-defined target other than kernel in this problem.

PipeWire is becoming the de facto media server on desktop systems, for
both audio and video. It has been shipped by distributions for a while
for audio, and is the core component that allows screen capture (and
therefore screen sharing in video conferencing) on Wayland-based
systems. For video, PipeWire support has most notably been integrated in
WebRTC, used by both Firefox and Chrome. The number of applications
using PipeWire is growing, OBS has recently received support for
PipeWire sources for instance. If you need to use it in an application
that requires a V4L2 capture device, the pw-v4l2 script emulates the
V4L2 API to provide a quick stopgap measure until applications get
native PipeWire support.

libcamera solves an orthogonal problem, which is control of raw camera
sensors and ISPs typically found in mobile and embedded devices, and now
increasingly in laptops as well (Intel IPU3, IPU4, IPU6 and IPU7).
Applications typically don't use libcamera directly, but interface it
with GStreamer (libcamerasrc element) or PipeWire (which has native
libcamera support).

While I understand that libcamera and PipeWire may be quite new for a
large number of users, the ecosystem is moving in that direction, and
both projects are very active.

> > > > It can be also claimed that there's enough OOT usage in the wild that
> > > > possible security bugs could be considered as potential zerodays for the
> > > > benefit of malicious actors.
> > > > 
> > > > The situation has been stagnated for however many years, which is
> > > > unsastainable situation, and it further factors potential security
> > > > risks. Therefore, a driver is needed to address the popular use case.
> > > > 
> > > > vcam is a DMA-BUF backed virtual camera driver capable of creating video
> > > > capture devices to which data can be streamed through /dev/vcam after
> > > > calling VCAM_IOC_CREATE. Frames are pushed with VCAM_IOC_QUEUE and recycled
> > > > with VCAM_IOC_DEQUEUE. Zero-copy semantics are supported for shared DMA-BUF
> > > > between capture and output.
> > > > 
> > > > This enables efficient implementation of software, which can manage network
> > > > video streams from phone cameras, and map those streams to video devices.
> > > 
> > > I'd really try to avoid involving V4L2 in-kernel implementation when the
> > > source of the video is network. V4L2 is meant to be used (when it comes to
> > > video) for interfacing video related hardware such as cameras, ISPs and
> > > codecs. There are limited number of video output related devices, too, but
> > > network is something quite different from these.
> > 
> > I'd look at the usage patterns in the field too. It is pretty obvious
> > that there is a significant gap what users want and expect when it
> > comes to this debate.
> 
> As for the patch itself, it is RFC i.e., not request for immediate
> merge. I sent v2 quickly primarily to address the motivation part
> properly. I'll phase this down a bit, and rework on issues in the uAPI I
> observed (and remarked in a response to this patch) etc., and generally
> give people some time to digest.

-- 
Regards,

Laurent Pinchart

