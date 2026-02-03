Return-Path: <linux-integrity+bounces-8436-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GSVmEGFJgmlaRwMAu9opvQ
	(envelope-from <linux-integrity+bounces-8436-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 20:15:45 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97758DE16F
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 20:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 383553082F5E
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Feb 2026 19:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9526F2F6164;
	Tue,  3 Feb 2026 19:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPDzTrnB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D91220F08C;
	Tue,  3 Feb 2026 19:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770146142; cv=none; b=MfNHyntXcDlMWx50ZnuGpki9gHlx14XQs89ZexF/H2y6Az+GbyOv5C3OK2oOPe08t4jxlMcm/C6slfMSG7P34VgOGXiSjVzIvaMe+nD2kY86mUqn0dnJY0MS/ghqkD/zarh+VbYpu0Cyo1VY4fCekySeuie7h4kdCDxY2kQ8YOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770146142; c=relaxed/simple;
	bh=sl0BtruQkIrV0HlP8TIUq3ol+uLcKUPX3EUkpsCSIMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGNbCUJR7aUYoEN1KXaOHQlsJbAngF9Xm6MW9IppsyWgllShRq8H8+ve9GrC9elxafD7dEn3ZfkhjKWCQlkaTN/02jQUYl3PsBuWoWNljkXiYoZ6dU67sZGOgXnV9Ya1AMO7YfbsCvo1RMVs9F1po/Ct1ps6iCqV0X5WB7lHWSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPDzTrnB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B17EC116D0;
	Tue,  3 Feb 2026 19:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770146142;
	bh=sl0BtruQkIrV0HlP8TIUq3ol+uLcKUPX3EUkpsCSIMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bPDzTrnByg/JkDApn8j4/NhiQwpQr0PxbIMCBVPgj817qoZUJASDgu72R7S+khPYr
	 tcnHmTinbqwOL4x0W7BB6ArP7XlaYsIJDOyMeAf3kpeS43ZGkkDFghD5SS549Pf+d6
	 2cKh0rMs760jasGpwsGFK3jwv5mNiXgGR7VurVvR7Ba7Ocheenn7XdslY7j8c71UEA
	 UWbZfS0a6h1Uq3/rm2P/LknR8BzQt8XIhlMqMMU/JILr5FIL0ke28w8+ns9pJmQwSo
	 z00wibvRqBCbJWqJi/GPKXONDzyvXWXspumwY3sLqFUYNH3xPd4pSQjtWGD8rZExul
	 imUgW89Oag86w==
Date: Tue, 3 Feb 2026 21:15:36 +0200
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
Message-ID: <aYJJWPLr4Qxkmn7z@kernel.org>
References: <20260202204425.2614054-1-jarkko@kernel.org>
 <6b192c71-c389-4a6e-b7c3-ddcd5cc4aa34@oss.qualcomm.com>
 <37a0d91c2e78c97f3d956444c4f7a2a2fca9ae06@intel.com>
 <c6b5832f-d7b3-4bc2-834e-4ce7b0c0b4cd@oss.qualcomm.com>
 <2bda02cb3da6cb6ca7dcf545a5b7af27fb7a6e37@intel.com>
 <aYJHeOtZT9qBmLQu@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYJHeOtZT9qBmLQu@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8436-lists,linux-integrity=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mipi.org:url,qualcomm.com:email]
X-Rspamd-Queue-Id: 97758DE16F
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 09:07:41PM +0200, Jarkko Sakkinen wrote:
> On Tue, Feb 03, 2026 at 08:53:13PM +0200, Jani Nikula wrote:
> > On Tue, 03 Feb 2026, johannes.goede@oss.qualcomm.com wrote:
> > > OTHO evdi: https://github.com/DisplayLink/evdi has been kept out
> > > of the kernel for pretty much the same reasons by the drm/kms folks.
> > >
> > > At least AFAIK there still is no way to present virtual kms capable
> > > display outputs backed by userspace in the kernel.
> > >
> > > I completely understand where you're coming from wrt v4l2-loopback
> > > support (or something equivalent) but asking for this really is
> > > the same as asking for the evdi driver to get merged, which AFAIK
> > > has been blocked for the reason of avoiding proprietary userspace
> > > display output drivers (I guess there might be technical reasons too).
> > 
> > I'm not sure this is the same thing, though.
> > 
> > The DRM subsystem does require an open source userspace for new uAPI,
> > which is stricter than most subsystems [1]. Other than that, I don't
> > think anyone's actively keeping evdi out of the kernel. AFAIK there
> > hasn't been a serious attempt at upstreaming it either. Which is pretty
> > much because there's no open userspace. Nobody's cared enough to either
> > write one or open source the existing one for a decade [2].
> 
> This is unrelated of ACK/NACK and not saying this as a "selling point"
> but realistically speaking based on what I've read I have extremely hard
> time to believe that my driver would enable a market of proprietary
> camera drivers :-) Actually, after looking up mipi.org based on Hans
> response, I even more so believe that this is the case.

With my maintainer hat on, I'd get the nack better if the driver was
intrusive on changes to V4L2 subsystem itself. Then, it accumlates
weight to other maintainers, and as we all have limited amount of time
in our lives, I do get that. But since the driver would be compliance
aligning leaf driver with a MAINTAINER entry of its own, it should not
be a huge burden for V4L2 community and kernel maintainers.  And I do
have a track record of being long-term on maintaining stuff that I vomit
out.

That also does make difference as there are some guarantees that the
end product would not be left into rotten.

> 
> > BR,
> > Jani.
> 
> BR, Jarkko


BR, Jarkko

