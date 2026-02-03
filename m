Return-Path: <linux-integrity+bounces-8438-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHURMkhkgmkATgMAu9opvQ
	(envelope-from <linux-integrity+bounces-8438-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 22:10:32 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28ECADEBF9
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 22:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FB7E3023370
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Feb 2026 21:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7D42E7F1C;
	Tue,  3 Feb 2026 21:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="fNbH4oeK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09301A08BC;
	Tue,  3 Feb 2026 21:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770152981; cv=none; b=NTRlOgVz+kmgx/sonBs0I0i6oaLGUze4PyiQEpwaHJERSfregcPpzNlf6aXdYwNNJeZEOx20gT0xkW3LuWS1SjVAF0hM2AFKhHq+mgpORDuFc5vCOEcKp1EVZY6IldihOzHwnk+ImPq/RBreLWi4nG63kDWCJLKzBwohHgvn46g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770152981; c=relaxed/simple;
	bh=H00ye2ODOuciJT1nMVKMdImZOVjN3PltQzEcXuGDH0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecH299Vey773P9+UadWh/niEXgMKFIBLG9Wryh3tFhYAS5fbGqvkzNUY8+yIcX3WxghpViR1mKsmgXahQfsP/01NRBY47PmcAnjQPXBMOoK9hwW5lY6mQfQjEmvQ5Saju1+QRuLQist2YrOO924IZRlagPfx0PP6vyXdZmvjQmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=fNbH4oeK; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from killaraus.ideasonboard.com (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 23280673;
	Tue,  3 Feb 2026 22:08:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1770152936;
	bh=H00ye2ODOuciJT1nMVKMdImZOVjN3PltQzEcXuGDH0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fNbH4oeKYm1j7VIYXgTjM9GB0oo+WQ2TTlp0Bb/1nASUkJsHm+tq3r7LqelfGdNZm
	 JVIQ01JnryNAfadVFAERzIPZZ5OpkejWUFX9EIOsns8CLF0ARgSq53Dap/RH6tE4Ms
	 CUA0aZTaGtEItVI5cTjb+ucK1bGaT5Jwqhpn6UUA=
Date: Tue, 3 Feb 2026 23:09:36 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: johannes.goede@oss.qualcomm.com, Jarkko Sakkinen <jarkko@kernel.org>,
	linux-media@vger.kernel.org, anisse@astier.eu,
	oleksandr@natalenko.name, linux-integrity@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] media: Virtual camera driver
Message-ID: <20260203210936.GC11369@killaraus>
References: <20260202204425.2614054-1-jarkko@kernel.org>
 <6b192c71-c389-4a6e-b7c3-ddcd5cc4aa34@oss.qualcomm.com>
 <906e9bd379456d4a861dc58d1504ee8546d8997d@intel.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <906e9bd379456d4a861dc58d1504ee8546d8997d@intel.com>
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
	TAGGED_FROM(0.00)[bounces-8438-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laurent.pinchart@ideasonboard.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[ideasonboard.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,ideasonboard.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28ECADEBF9
X-Rspamd-Action: no action

Hi Jarkko,

On Tue, Feb 03, 2026 at 03:16:24PM +0200, Jani Nikula wrote:
> On Tue, 03 Feb 2026, johannes.goede@oss.qualcomm.com wrote:
> > On 2-Feb-26 21:44, Jarkko Sakkinen wrote:
> >> Already a quick Google survey backs strongly that OOT drivers (e.g.,
> >> v4l2loopback) are the defacto solution for streaming phone cameras in
> >> video conference calls, which puts confidential discussions at risk.
> >> 
> >> It can be also claimed that there's enough OOT usage in the wild that
> >> possible security bugs could be considered as potential zerodays for the
> >> benefit of malicious actors.
> >> 
> >> The situation has been stagnated for however many years, which is
> >> unsastainable situation, and it further factors potential security
> >> risks. Therefore, a driver is needed to address the popular use case.
> >> 
> >> vcam is a DMA-BUF backed virtual camera driver capable of creating video
> >> capture devices to which data can be streamed through /dev/vcam after
> >> calling VCAM_IOC_CREATE. Frames are pushed with VCAM_IOC_QUEUE and recycled
> >> with VCAM_IOC_DEQUEUE. Zero-copy semantics are supported for shared DMA-BUF
> >> between capture and output.
> >> 
> >> This enables efficient implementation of software, which can manage network
> >> video streams from phone cameras, and map those streams to video devices.
> >> 
> >> PipeWire or any other specific pick of userspace software cannot really
> >> address the issue at scale, as e.g., the use of v4l2loopback is both wide
> >> and scattered.
> >
> > I appreciate your efforts here and if I understand things correctly
> > your main goal is to allow people to use the camera of there mobile
> > phone for e.g. video-conferencing on a standard linux distro
> > (Debian/Fedora/Arch) laptop/desktop right ?
> >
> > The problem is that what you're suggesting is basically a much
> > improved (using dma-buf is way better) v4l2-loopback driver and
> > v4l2-loopback has been blocked from getting merged into the kernel
> > because besides the mobile-phone camera use, the other main use-case
> > is to allow running proprietary camera stacks like Intel's proprietary
> > camerastack and then presenting that to userspace as a standard v4l2
> > cam so that userspace apps will just work.
> >
> > Personally I think that there are enough valid use-cases for something
> > like your proposed vcam driver, also for e.g. CI purposes that I think
> > that maybe the V4L2 maintainers should reconsider. But this is not my
> > call to make and with both Laurent (in the v1 thread) and Sakari pretty
> > much having NACK-ed this, I do not think this is going to go very far
> > if you want a mainline solution.
> >
> > As Sakari mentioned in this day and age raw V4L2 access is really not
> > the best API to acccess cameras. Especially modern smartphone like
> > CSI2 MIPI cameras which consist of quite a complex graph of building
> > blocks which need to be configured to work together to get a picture.
> >
> > So now even when running directly on the hardware (vs the network case)
> > apps can no longer directly access v4l2 devices because of the complexity.
> >
> > This is already the case on newer x86_64 laptops with MIPI cameras
> > instead of USB UVC cams and also on phones running postmarketos.
> >
> > The community concensus is that the solution here is for apps to
> > access cameras through pipewire. Together with the shift of laptops
> > cameras from UVC to "raw" MIPI cameras there also is a shift to
> > running applications sandboxed as flatpacks because of the changing
> > "cyber" security landscape. This is why pipewire was chosen because
> > it also solves the accessing cameras from a sandbox issue.
> >
> > Both Firefox and chrome(ium) already support pipewire for cameras
> > OOTB. In chrome it requires setting a config setting and maybe for
> > upstream Firefox too (it is enabled in Fedora's Firefox by default).
> >
> > Given that pipewire is seen as the way to access all cameras in
> > the future and that we are already moving in that direction (e.g.
> > Fedora has been shipping this OOTB since Fedora 42) IMHO your time
> > would be better spend helping out there.
> >
> > E.g. add support to popular software for sharing smartphone cameras
> > to represent the frames received over the network as a video sources
> > in pipewire and check if this works in Firefox + Chrome and write
> > patches or file issues for other apps to also add pipewire camera
> > access support.
> >
> > As was mentioned in the earlier thread for making the camera show
> > up as a source in pipewire you could try using the pipewire sink
> > element in gstreamer, assuming you can make the phone-cam available
> > as a gstreamer src element, you may be able to prototype things
> > then using just a gst-launch cmd from the shell.
> 
> I described my use case at [1]. Basically have OBS Studio output to a
> virtual camera that can be used by other apps. A very common use case
> for v4l2-loopback. Nothing to do with phone cameras or proprietary
> drivers.
> 
> So there appears to be an OBS Studio PR [2] to enable pipewire virtual
> camera, open for about five years now.

Thanks for the pointer, I wasn't aware of that.

> And it still won't work with any
> legacy apps that need the traditional camera device, until they're
> migrated to pipewire too, if ever.

Legacy apps that only support /dev/video* will increasingly not work
with mobile, embedded and even laptop devices as the industry is using
raw sensors with ISPs everywhere, requiring libcamera in userspace. In
the meantime, both libcamera and PipeWire provide LD_PRELOAD-able
libraries that emulate V4L2 entirely in userspace on top of the
respective project, for those legacy applications (wrapped in scripts
called libcamerify and pw-v4l2).

> Maybe it would take non-trivial effort to port OBS Studio to vcam too, I
> haven't looked, and I'm no expert anyway.

It would require some work, as the vcam driver uses a custom API. I
believe that the effort would be better spent on completing PipeWire
support.

> 'apt install v4l2loopback-dkms' remains the primary option for most
> people for the foreseeable future.
> 
> [1] https://lore.kernel.org/r/c6b719fdecbfc8a1c15a197b6ae51da56ed54f63@intel.com
> 
> [2] https://github.com/obsproject/obs-studio/pull/5377
> 
> >> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> >> ---
> >> v2:
> >> - Added motivation based on feedback to v1.
> >> - Provide a list of allowed modes for /dev/videoX in VCAM_IOC_CREATE.
> >> - Merged VCAM_IOC_WAIT and VCAM_IOC_STATUS.
> >> - Return state with operation flags in VCAM_IOC_WAIT.
> >> - Test program: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/vcam-test.git
> >> ---
> >>  .../driver-api/media/drivers/index.rst        |    1 +
> >>  .../driver-api/media/drivers/vcam.rst         |   16 +
> >>  MAINTAINERS                                   |    8 +
> >>  drivers/media/Kconfig                         |   13 +
> >>  drivers/media/Makefile                        |    1 +
> >>  drivers/media/vcam.c                          | 1935 +++++++++++++++++
> >>  include/uapi/linux/vcam.h                     |  141 ++
> >>  7 files changed, 2115 insertions(+)
> >>  create mode 100644 Documentation/driver-api/media/drivers/vcam.rst
> >>  create mode 100644 drivers/media/vcam.c
> >>  create mode 100644 include/uapi/linux/vcam.h

[snip]


-- 
Regards,

Laurent Pinchart

