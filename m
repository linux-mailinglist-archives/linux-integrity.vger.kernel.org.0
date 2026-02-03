Return-Path: <linux-integrity+bounces-8432-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMseCfkTgmkgPAMAu9opvQ
	(envelope-from <linux-integrity+bounces-8432-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 16:27:53 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F11DB490
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 16:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E3C230DFF69
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Feb 2026 15:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26423B8D6C;
	Tue,  3 Feb 2026 15:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rh1LB/0Z"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA0D3B8D62;
	Tue,  3 Feb 2026 15:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770132350; cv=none; b=gaQmLJ0TQ3PdoPonP8n/2htuxt/G6/mofEp4sqB42YmpJGaqKuNd+DrN6WnI9Xg7MjKoysQkp9j2NEQiZ6moY2uyd88LnoOzPJwOXfeXtUf4R3EBqNLL+xpEAJR6mQfndMLzZorT5LJyGJWU14i8kCBSYaSOu2D8QXE3162FGlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770132350; c=relaxed/simple;
	bh=Du5Koej1C4nV9G8aQrwA6mXWCCiESbqfzFqmYQY42hk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aXIS5UcNZuq2d5lB7IMxTgAqy+9k0Qcli2W56XV8w4l6XLuxRXay+yyzko5qCRY2R9YJdcfrQPybKwr8/OMDDDQILQ2xjKZw0DjlibDtONIdByuqJ3vL8Z1QEXO14G8SAj2zsN4X4gi2xCJ7gNCHWLfJPtE5uzPu+smyoLQrqww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rh1LB/0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BC6C116D0;
	Tue,  3 Feb 2026 15:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770132350;
	bh=Du5Koej1C4nV9G8aQrwA6mXWCCiESbqfzFqmYQY42hk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rh1LB/0Zvkmvig32AMBUxKl9zSTgCzJQQA798s1NrUepj/r1koRQRvxJr3kZUICrd
	 fV4bNShYGB1w7OIEwDg1O1suCaTYWBGMH/v9YKvCZfOuDuVcEj++zwPCIH0B29mPpw
	 hlBQGeu+mDG7gvUF+q8Tk3v7iUcjO3gfHtNuzddc1ru99+nQROgDe3Rtu1KTmgdV/N
	 e2PZ+I0lfVGLOar0YqD3tuDEOjVfwcwrnUXCooIQOt7XMPdD61UxhCY6/dVBlJUygs
	 zSSU+Jut0MPmhISbzZJZW3vI2SrMsKjq6Xp6ziyyRp7+yemo5Dh2S9J0UDUX2hncSk
	 hmECZn7/MGYRQ==
Date: Tue, 3 Feb 2026 16:25:44 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: johannes.goede@oss.qualcomm.com
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Jarkko Sakkinen
 <jarkko@kernel.org>, linux-media@vger.kernel.org, anisse@astier.eu,
 oleksandr@natalenko.name, linux-integrity@vger.kernel.org, Mauro Carvalho
 Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Jacopo Mondi
 <jacopo.mondi@ideasonboard.com>, Ricardo Ribalda <ribalda@chromium.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] media: Virtual camera driver
Message-ID: <20260203162544.09635a09@foz.lan>
In-Reply-To: <c6b5832f-d7b3-4bc2-834e-4ce7b0c0b4cd@oss.qualcomm.com>
References: <20260202204425.2614054-1-jarkko@kernel.org>
	<6b192c71-c389-4a6e-b7c3-ddcd5cc4aa34@oss.qualcomm.com>
	<37a0d91c2e78c97f3d956444c4f7a2a2fca9ae06@intel.com>
	<c6b5832f-d7b3-4bc2-834e-4ce7b0c0b4cd@oss.qualcomm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8432-lists,linux-integrity=lfdr.de,huawei];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 95F11DB490
X-Rspamd-Action: no action

On Tue, 3 Feb 2026 15:19:13 +0100
johannes.goede@oss.qualcomm.com wrote:

> Hi Jani,
> 
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
> 
> As I indicated in my original email personally I'm a bit divided on
> whether a virtual camera driver should be kept out of the kernel
> to not promote proprietary userspace stacks, but this is not my call.
> 
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
> display output drivers 

> (I guess there might be technical reasons too).

There are technical reasons too: streaming requires mutexes and
semaphores inside the Kernel to manage buffer requests.
Semaphores, in particular, can't depend on anything that sleeps,
but there are even some mutexes that could be affected inside
Linux core. Holding them while waiting for an user event is
complex, untested and can cause all sorts of issues.

Thanks,
Mauro

