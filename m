Return-Path: <linux-integrity+bounces-8433-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILmVOx84gmmVQgMAu9opvQ
	(envelope-from <linux-integrity+bounces-8433-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 19:02:08 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3636CDD3EB
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 19:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6016330247FF
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Feb 2026 17:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0997361DAB;
	Tue,  3 Feb 2026 17:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFbK8W5e"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA4A31A041;
	Tue,  3 Feb 2026 17:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770141365; cv=none; b=hlLdvlB/8yv1vUpH617K/7tqCLWbmTUrcTe1rADD4bobHnH224hJIBFNFJvxdF7Fu1/udnZCCKMnU0ICnp3jljlsew+W2YhQtVm76ea87uZEbiajL0KMiCYU2q/hhH608fD9A0bj3rBq74rmNNKnn3U0l22XR/qBaDICpc/SE2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770141365; c=relaxed/simple;
	bh=Y4SZIml0t634w6UGWmB3OQ3+N8G57uT5k0lE2O+AaFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dwvwvg+yI0BJb3HYhwjNU1xUnsDAl9IVFTzQ3fdlwukzz1mdBeFhdTrMoWR9rCH1uHkKUOpWEPu10jtyFRAZCYAnEpr2fHBtmBX5I+FH3PCshk0XK930MQ5Dc+qC+QUt0K2Fz2NGu2VMwqRVTPBS5o0m0xYl3nOxOngCpljQLfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFbK8W5e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1030C116D0;
	Tue,  3 Feb 2026 17:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770141365;
	bh=Y4SZIml0t634w6UGWmB3OQ3+N8G57uT5k0lE2O+AaFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UFbK8W5eAyEIH6Pb6JIgpybutSS12W8Z1z3RzTOC3cFSzjbTbDjbVjc+FpYCQHohr
	 RDlYRVa4wYuFsFh9ulQ1P5G9XwyhuZtM5nFOK7v6JMV/4ikZMiYz2F5JMDsLS5nBWQ
	 GpBZ4PPfBXFqZbIQChPf1GAjCGtqjQXcZYvzdkpYTE1KaKw+E5THPzAa8bqQiOBHbg
	 1iRQ0R0Ode51LENRFtgE/rIbU/6Imn9UjvCib0VX0yNyqQbxNIu4x8NBrg1P4TcUq3
	 4QS3SfO+MMpKZJmWu6T+bPTbPOn74+kdl66DwK/ujFyipYuzl/jNduQDhuo17hy82I
	 tcvTe0bhra5HA==
Date: Tue, 3 Feb 2026 19:56:00 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: johannes.goede@oss.qualcomm.com
Cc: linux-media@vger.kernel.org, jani.nikula@linux.intel.com,
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
Message-ID: <aYI2sESZFU6TzeAQ@kernel.org>
References: <20260202204425.2614054-1-jarkko@kernel.org>
 <6b192c71-c389-4a6e-b7c3-ddcd5cc4aa34@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b192c71-c389-4a6e-b7c3-ddcd5cc4aa34@oss.qualcomm.com>
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
	TAGGED_FROM(0.00)[bounces-8433-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email]
X-Rspamd-Queue-Id: 3636CDD3EB
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 11:27:10AM +0100, johannes.goede@oss.qualcomm.com wrote:
> Hi Jarkko,
> 
> On 2-Feb-26 21:44, Jarkko Sakkinen wrote:
> > Already a quick Google survey backs strongly that OOT drivers (e.g.,
> > v4l2loopback) are the defacto solution for streaming phone cameras in
> > video conference calls, which puts confidential discussions at risk.
> > 
> > It can be also claimed that there's enough OOT usage in the wild that
> > possible security bugs could be considered as potential zerodays for the
> > benefit of malicious actors.
> > 
> > The situation has been stagnated for however many years, which is
> > unsastainable situation, and it further factors potential security
> > risks. Therefore, a driver is needed to address the popular use case.
> > 
> > vcam is a DMA-BUF backed virtual camera driver capable of creating video
> > capture devices to which data can be streamed through /dev/vcam after
> > calling VCAM_IOC_CREATE. Frames are pushed with VCAM_IOC_QUEUE and recycled
> > with VCAM_IOC_DEQUEUE. Zero-copy semantics are supported for shared DMA-BUF
> > between capture and output.
> > 
> > This enables efficient implementation of software, which can manage network
> > video streams from phone cameras, and map those streams to video devices.
> > 
> > PipeWire or any other specific pick of userspace software cannot really
> > address the issue at scale, as e.g., the use of v4l2loopback is both wide
> > and scattered.
> 
> I appreciate your efforts here and if I understand things correctly
> your main goal is to allow people to use the camera of there mobile
> phone for e.g. video-conferencing on a standard linux distro
> (Debian/Fedora/Arch) laptop/desktop right ?
> 
> The problem is that what you're suggesting is basically a much
> improved (using dma-buf is way better) v4l2-loopback driver and
> v4l2-loopback has been blocked from getting merged into the kernel
> because besides the mobile-phone camera use, the other main use-case
> is to allow running proprietary camera stacks like Intel's proprietary
> camerastack and then presenting that to userspace as a standard v4l2
> cam so that userspace apps will just work.

v4l2-loopback is a bit like, or the difference to this at least, is that
it does not really have any life-cycle model or constraints what it is.

And in terms of "if this was  in terms of dual-VB2 pipeline and on
producer side locking into DMA-BUF is how you would want to approach the
topic.

> 
> Personally I think that there are enough valid use-cases for something
> like your proposed vcam driver, also for e.g. CI purposes that I think
> that maybe the V4L2 maintainers should reconsider. But this is not my
> call to make and with both Laurent (in the v1 thread) and Sakari pretty
> much having NACK-ed this, I do not think this is going to go very far
> if you want a mainline solution.

I will phase down attention to the topic a bit. It's been noted. I'm not
sending a new version at least any time soon.

> 
> As Sakari mentioned in this day and age raw V4L2 access is really not
> the best API to acccess cameras. Especially modern smartphone like
> CSI2 MIPI cameras which consist of quite a complex graph of building
> blocks which need to be configured to work together to get a picture.

I will look into this topic.

> 
> So now even when running directly on the hardware (vs the network case)
> apps can no longer directly access v4l2 devices because of the complexity.
> 
> This is already the case on newer x86_64 laptops with MIPI cameras
> instead of USB UVC cams and also on phones running postmarketos.
> 
> The community concensus is that the solution here is for apps to
> access cameras through pipewire. Together with the shift of laptops
> cameras from UVC to "raw" MIPI cameras there also is a shift to
> running applications sandboxed as flatpacks because of the changing
> "cyber" security landscape. This is why pipewire was chosen because
> it also solves the accessing cameras from a sandbox issue.
> 
> Both Firefox and chrome(ium) already support pipewire for cameras
> OOTB. In chrome it requires setting a config setting and maybe for
> upstream Firefox too (it is enabled in Fedora's Firefox by default).
> 
> Given that pipewire is seen as the way to access all cameras in
> the future and that we are already moving in that direction (e.g.
> Fedora has been shipping this OOTB since Fedora 42) IMHO your time
> would be better spend helping out there.
> 
> E.g. add support to popular software for sharing smartphone cameras
> to represent the frames received over the network as a video sources
> in pipewire and check if this works in Firefox + Chrome and write
> patches or file issues for other apps to also add pipewire camera
> access support.
> 
> As was mentioned in the earlier thread for making the camera show
> up as a source in pipewire you could try using the pipewire sink
> element in gstreamer, assuming you can make the phone-cam available
> as a gstreamer src element, you may be able to prototype things
> then using just a gst-launch cmd from the shell.

With a quick ACM search mocking /dev/videoX is not alien approach. And
when it is done it's not focused-on-V4L2 type of situation but more like
being able to drive a software platform without associated hardware. And
when doing something like this with QEMU, it is really nice to still
have uncluttered and stackless-as-possible data paths,

[and I at lest would not try to run 'qemu' through camerify from
libcamera-tools]

You can project from that at least that there are other applications too
for "software-defined camera", and what people do in academic world has
reflection to R&D in industry (e.g. drone industry). It's an asset to
use software as far as possible even when doing embedded platforms.

Thanks for the pointers anyhow. This was very informative. These are
great lore references too.

> 
> Regards,
> 
> Hans

BR, Jarkko

