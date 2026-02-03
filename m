Return-Path: <linux-integrity+bounces-8443-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SD2KImVrgmkpUAMAu9opvQ
	(envelope-from <linux-integrity+bounces-8443-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 22:40:53 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A6694DEE5F
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 22:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 362F9300C557
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Feb 2026 21:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1FC37106D;
	Tue,  3 Feb 2026 21:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2k+KUSC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96D133985A;
	Tue,  3 Feb 2026 21:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770154833; cv=none; b=NtpfrcH5DBIJq5AP4sRvjp45C7dd805AYln/0jF9OXDMDOh5YssWKnU47K/rtllVmmL7ZpG1phQtSd4aewWK3FqthWqZGoF7UnYBui12GN/l9Pgx10xoqr2fVka90pSNFKDzkuC0GxyJDRqJR52HlIIBmP/XYeZvpuB7/v0cExk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770154833; c=relaxed/simple;
	bh=xk6hSF5V+5b2PHodbBhcUfr7/vd2d7OrNJYmZhHpJtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEkWGKROUiZj46lBWsVVTlLk4Um1p/MVgHcUFNIYYbaUi56mwcBK03o6ItVFh+4A2kPpcIQ6DIE0boxBiC3T81qtRsuQ14imME+9SZrXCRqYwwHjP85gQ9ZDFgvCKakD6wH9RUD2/x/LYPvWjZXisu30sNeDUG3B8LY1IJR/b4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2k+KUSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1E4C116D0;
	Tue,  3 Feb 2026 21:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770154833;
	bh=xk6hSF5V+5b2PHodbBhcUfr7/vd2d7OrNJYmZhHpJtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n2k+KUSCQGS2HIl4lOxN6SSEJHrKToFPcCZ378Qj8QaaJ7omGy6OoiCE9HzIXHZT1
	 FNXu428ovxNgTejVZICaeMynyXsZx2XwNXhKPx0npX6ULP+tEyJv0orAUIel0ebEaU
	 7/StXeti70dowR9YNsU1HDZfBb+/6PcwKHlzZxpjViZMSv7C4nxuCZY8M/f8QDHWNT
	 mq7TMmsaihRmMqdzJL2/8ckDvp2fX9VkRxQKEpTbiuyymCGit6bisXLVbsmK7syO5z
	 bOAO7pSBBYN3Hy+/XA11QkfZHVouSGKDhEUUUSkelrUPW6nntZK2cLWe224+Hznhmp
	 IDOrpTzg7gmuw==
Date: Tue, 3 Feb 2026 23:40:30 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
Message-ID: <aYJrTj8QDenVKuyv@kernel.org>
References: <20260202204425.2614054-1-jarkko@kernel.org>
 <6b192c71-c389-4a6e-b7c3-ddcd5cc4aa34@oss.qualcomm.com>
 <37a0d91c2e78c97f3d956444c4f7a2a2fca9ae06@intel.com>
 <c6b5832f-d7b3-4bc2-834e-4ce7b0c0b4cd@oss.qualcomm.com>
 <2bda02cb3da6cb6ca7dcf545a5b7af27fb7a6e37@intel.com>
 <aYJHeOtZT9qBmLQu@kernel.org>
 <aYJJWPLr4Qxkmn7z@kernel.org>
 <20260203212226.GF11369@killaraus>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203212226.GF11369@killaraus>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8443-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mipi.org:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: A6694DEE5F
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 11:22:26PM +0200, Laurent Pinchart wrote:
> On Tue, Feb 03, 2026 at 09:15:36PM +0200, Jarkko Sakkinen wrote:
> > On Tue, Feb 03, 2026 at 09:07:41PM +0200, Jarkko Sakkinen wrote:
> > > On Tue, Feb 03, 2026 at 08:53:13PM +0200, Jani Nikula wrote:
> > > > On Tue, 03 Feb 2026, johannes.goede@oss.qualcomm.com wrote:
> > > > > OTHO evdi: https://github.com/DisplayLink/evdi has been kept out
> > > > > of the kernel for pretty much the same reasons by the drm/kms folks.
> > > > >
> > > > > At least AFAIK there still is no way to present virtual kms capable
> > > > > display outputs backed by userspace in the kernel.
> > > > >
> > > > > I completely understand where you're coming from wrt v4l2-loopback
> > > > > support (or something equivalent) but asking for this really is
> > > > > the same as asking for the evdi driver to get merged, which AFAIK
> > > > > has been blocked for the reason of avoiding proprietary userspace
> > > > > display output drivers (I guess there might be technical reasons too).
> > > > 
> > > > I'm not sure this is the same thing, though.
> > > > 
> > > > The DRM subsystem does require an open source userspace for new uAPI,
> > > > which is stricter than most subsystems [1]. Other than that, I don't
> > > > think anyone's actively keeping evdi out of the kernel. AFAIK there
> > > > hasn't been a serious attempt at upstreaming it either. Which is pretty
> > > > much because there's no open userspace. Nobody's cared enough to either
> > > > write one or open source the existing one for a decade [2].
> > > 
> > > This is unrelated of ACK/NACK and not saying this as a "selling point"
> > > but realistically speaking based on what I've read I have extremely hard
> > > time to believe that my driver would enable a market of proprietary
> > > camera drivers :-) Actually, after looking up mipi.org based on Hans
> > > response, I even more so believe that this is the case.
> > 
> > With my maintainer hat on, I'd get the nack better if the driver was
> > intrusive on changes to V4L2 subsystem itself. Then, it accumlates
> > weight to other maintainers, and as we all have limited amount of time
> > in our lives, I do get that. But since the driver would be compliance
> > aligning leaf driver with a MAINTAINER entry of its own, it should not
> > be a huge burden for V4L2 community and kernel maintainers.  And I do
> > have a track record of being long-term on maintaining stuff that I vomit
> > out.
> 
> I don't dispute that. Even though we haven't really worked together on
> kernel development, I have no prejudice towards your commitment as a
> driver maintainer :-) There's nothing personal in this mail thread.

Absolutely non taken either (and neither from my side).

> 
> > That also does make difference as there are some guarantees that the
> > end product would not be left into rotten.
> 
> -- 
> Regards,
> 
> Laurent Pinchart

BR, Jarkko

