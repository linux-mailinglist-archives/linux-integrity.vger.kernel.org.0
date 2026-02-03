Return-Path: <linux-integrity+bounces-8409-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJfAK+48gWk8FAMAu9opvQ
	(envelope-from <linux-integrity+bounces-8409-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 01:10:22 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DF13FD2D9F
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 01:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7119E300602F
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Feb 2026 00:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A446D2F872;
	Tue,  3 Feb 2026 00:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9jwU9c1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7067B286A7;
	Tue,  3 Feb 2026 00:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770077415; cv=none; b=e1A4Iwximrdxg8wgKc4pI5qNznOQiI9Br24HkQM7M6u3DshfYLY2aJ5DdnI8pxBmm9gF41zBf8+uWbZUFN7IipjbYMBXZFzz0QFRUCA97ldIa6nGFV7dK5LMo64VMmlH9y03aTxbpK32Jf/O2kkRll8KR6HZ0tow2SSrVkmknAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770077415; c=relaxed/simple;
	bh=pQbDcmtewWa2yjdxKfKtqWzgPlFPxdEm3ir44Cdhu88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h297lGvtmBS6fXZnfhPWO6Z2+0WubiCGX75zTVItLypEPtdczhee5PfLQARdD3fz17ktDWnhB0GDV7iAwpwEA4hFjxjl9nz7YTAe/tJS9ddcmHIFB1al2MzriLmiIpRfjzYk1Ortcz5Ff501HdnW0ZMsunYkDpls9XhihvXkyoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9jwU9c1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E125C116C6;
	Tue,  3 Feb 2026 00:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770077415;
	bh=pQbDcmtewWa2yjdxKfKtqWzgPlFPxdEm3ir44Cdhu88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r9jwU9c1z3oMvPX+hp/h4oxyPvJw2t3r93uJdCT+3VrY5u2gTp6MvAb18xH1v2ytQ
	 tOIjnqfpt4GMVyH6BEnDxPGemLkgFuSQJebrHeaVHVWzBB8sl1wf8GRrpvfEkCZpm4
	 fHdzU9+rvZx6YmFgpQq0dQGVqlwnCAcxZKPndu4RQ9oPXctzazudnUCda47w/b78su
	 G/rZq9m8+z87BLtZcq1WWpP9QhPh/1WXcWRi8Qm8yyBVDD67YoKorGtybUwFSyBYXN
	 duCnqrfxnWHUd0+jBeDFKkgiFWUGuCJh7bGOpK947wLRptoK4v0NvzEzNgmQFRY1a+
	 /+sVBLX6OA1zA==
Date: Tue, 3 Feb 2026 02:10:10 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, jani.nikula@linux.intel.com,
	anisse@astier.eu, oleksandr@natalenko.name,
	linux-integrity@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] media: Virtual camera driver
Message-ID: <aYE84i2GT5ntqZsO@kernel.org>
References: <20260202204425.2614054-1-jarkko@kernel.org>
 <aYEqHogDBqR1qGw3@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYEqHogDBqR1qGw3@kekkonen.localdomain>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8409-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF13FD2D9F
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 12:50:06AM +0200, Sakari Ailus wrote:
> Hi Jarkko,
> 
> On Mon, Feb 02, 2026 at 10:44:21PM +0200, Jarkko Sakkinen wrote:
> > Already a quick Google survey backs strongly that OOT drivers (e.g.,
> > v4l2loopback) are the defacto solution for streaming phone cameras in
> > video conference calls, which puts confidential discussions at risk.
> 
> As I think it was pointed out in review comments for v1, the reason behind
> using v4l2loopback is the use of a downstream driver, which itself is a
> source of a security risk. If I understand correctly, supporting this
> (proprietary/downstream vendor drivers) would be the main use case this
> driver serves? Should this downstream driver be upstreamed to alleviate the
> security risks, the need for v4l2loopback or similar drivers presumably
> disappears.

My goal is not to proactively support proprietary drivers, and I don't
know how to measure such incentive or risk, when it comes to video
drivers.

And besides there is e.g. FUSE.

> 
> Another of the downsides of such proprietary/downstream solutions is they
> can never be properly integrated into the Linux ecosystem so functionality
> will remain spotty (limited to specific systems and specific releases of
> specific distributions) at best.
> 
> In other words, this driver appears to be orthogonal to solving either of
> the above two problems the proprietary/downstream solutions have.
> 
> From the Open Source libcamera based camera software stack point of view
> there doesn't seem to be a need for v4l2loopback or another similar driver.
> The two main reasons for this is that (1) there's no need for glueing
> something separate together like this and (2) V4L2 isn't a great
> application interface for cameras -- use libcamera or Pipewire instead.

While I get this argument isolated, it does not match the observed
reality, and does not provide tools to address the core issue. I
will be in my grave before I've fixed the world like you are
suggesting :-)

Like, first off, where would I use libcamera or Pipewire? There's
no well-defined target other than kernel in this problem.

> 
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
> 
> I'd really try to avoid involving V4L2 in-kernel implementation when the
> source of the video is network. V4L2 is meant to be used (when it comes to
> video) for interfacing video related hardware such as cameras, ISPs and
> codecs. There are limited number of video output related devices, too, but
> network is something quite different from these.

I'd look at the usage patterns in the field too. It is pretty obvious
that there is a significant gap what users want and expect when it
comes to this debate.

> 
> -- 
> Kind regards,
> 
> Sakari Ailus

BR, Jarkko

