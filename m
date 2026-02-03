Return-Path: <linux-integrity+bounces-8419-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0M7gJfGzgWnNIwMAu9opvQ
	(envelope-from <linux-integrity+bounces-8419-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 09:38:09 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0E6D648C
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 09:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79E383095C9F
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Feb 2026 08:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E347439446E;
	Tue,  3 Feb 2026 08:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyXvwaCP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485CE2D9499;
	Tue,  3 Feb 2026 08:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770107537; cv=none; b=LB/arjcce2oUa4E8MiHWRJ44aXvHJEuloTJWK7mp9nnhIboANJN9KoNx0Mq9bZntBCje2ADbd0yjDG0LEO7bL5lnewR4VAlPZ1HrHAnfFgyQMDq+LiXmSvYZLEFkjHsA4iJEZUYo8gZl3OUlL9UHda+INmMAIZXep52Zlp3rLb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770107537; c=relaxed/simple;
	bh=AaGvZ6MNlA5k2IKQAdwa/l89TAkY8OiHHDWQNGJqX7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUC39fU6bLI4rK8vpEQoqWmprNDhRmgxf3pnL8H56H9UHyuNZI7MJxyAK0yXOE+Iy/rJlDVVxkUn2qinN6ONLX48B5XyHiGa4TS98eW8AI7diQAXVI3wtAzNYQe1W2WTqiPfFmoo4k4/Qp7xyJidV8LkVLTUaEfT+b8rruuhNuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyXvwaCP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABAFC116D0;
	Tue,  3 Feb 2026 08:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770107536;
	bh=AaGvZ6MNlA5k2IKQAdwa/l89TAkY8OiHHDWQNGJqX7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QyXvwaCP/7sk7pWDMaymAVGUrldlKJTszeoHZ/hWPQz+6Z0VXYu9Kv8Cqa8hXA5uL
	 bLnGiBl4gjVX9HDs/+N9O0dEkEn2rz9ij9HSMH6dRWOk+EJRQzaggf6/GC8Arkx8F3
	 jidlSYKpXpy+GjnWnSB0SKpovh37tvdKLJtzH+FEc6Ef5lDCZQZyJau7+j+b1u0fLD
	 ECoXIPoRRFbBglffufP8QQWA4uZnYSdFi8uE5C2YflPWL5ae2eQpnkSzkf78PVAFte
	 kaK5Urgrf2qxyjCIgmCaaKlxQIYiDSHzY62exYnAqwhqh4MtBGUaLriT5rpfxewb+U
	 /T0PTTw9D7wKA==
Date: Tue, 3 Feb 2026 10:32:12 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-media@vger.kernel.org
Cc: jani.nikula@linux.intel.com, anisse@astier.eu, oleksandr@natalenko.name,
	linux-integrity@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] media: Virtual camera driver
Message-ID: <aYGyjK76DGLK3HBK@kernel.org>
References: <20260202204425.2614054-1-jarkko@kernel.org>
 <aYGsyk5SnzktKM3m@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYGsyk5SnzktKM3m@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8419-lists,linux-integrity=lfdr.de];
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
X-Rspamd-Queue-Id: EF0E6D648C
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 10:09:25AM +0200, Jarkko Sakkinen wrote:
> On Mon, Feb 02, 2026 at 10:44:21PM +0200, Jarkko Sakkinen wrote:
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
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> After learning a bit more about the topic and for future updates I will
> drop YUYV. NV12, MJPEG, and additionally RGBX32 and XRGB32 for testing
> and GPUs define pretty well the requirements for a software define device,
> and limit the applicability of "proprietary risk" (as that was the main
> concern raised). I honestly did not have idea what would be an
> appropriate subset of formats to constraint the driver initially.
> 
> In addition, a better name for this module would probably be swcam as it
> does not  mix up with those pre-existing devices starting with the
> letter 'v'.

In addition to phones, there's also category of devices called IP
cameras, and managing them ubiquitos to other camera device is a
convenience to say the least.

And when it comes to pure testing, not all testing where V4L2 is
involved is neither about simulating V4L2 hardware nor centered around
V4L2 as a topic. It could be e.g., embedded system testing where you
want to mock the cameras with simulated content  in software only
testing (QEMU has V4L2 passthrough)

BR, Jarkko

