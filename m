Return-Path: <linux-integrity+bounces-8416-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBPDLMOugWn0IQMAu9opvQ
	(envelope-from <linux-integrity+bounces-8416-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 09:16:03 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E29D61B3
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 09:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7FBC30D4988
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Feb 2026 08:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB4C392C53;
	Tue,  3 Feb 2026 08:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LS5FGJua"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD6E18C33;
	Tue,  3 Feb 2026 08:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770106165; cv=none; b=jPi4RKeaG+5ZqBCpt6GOb69vFSHBOtlTMjw6wXq9uwPOiLf9ot9I/ll6FJponX7fF7MZnmQDUx2HCmqtPbdR6Q/roaoaJ1kvV1z0kR9PCSDCmTv+hPukPWxCeFvjlYRi2K8dEkBgXKqZGcZmFlWW5ZPMjs7KTrOeULNXcQohF6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770106165; c=relaxed/simple;
	bh=XlCZCTHFs/gfGWT/y4AlgyeEiKxWcKld6JkaIVjZYno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9U6/ko55XWBWUcpaw0Aw8hn5VzoDZBXwI1LFImaktF9Ybk/IhiUfmXJtD2Sp9rc6FhFKHzuZtWwYO1YIQq9YzAbGvSnqhWWmYV7Z8mth92ptIyAmIfEn9aKVQJscx5tdqDmmDF2hPosFnNlkUlGjxql5Jy7V4YEneoe+UArzOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LS5FGJua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7200EC116D0;
	Tue,  3 Feb 2026 08:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770106165;
	bh=XlCZCTHFs/gfGWT/y4AlgyeEiKxWcKld6JkaIVjZYno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LS5FGJuauA/HjtPQh7tAkMFf95Jwyaxr8BazthGe6dLoplMn5xT2u3qMMkhbTVO9a
	 +M/C/q5OIOK6T8JoFVRd2Iwd121l/EF1MsNuTxQWYGKbsibadQLFuyA5zE2HUyexhc
	 atCpriVwN2ogQQEkB5i6ErVPv1h9Fhy0GeowsNjKQY9gqp5rwXgxxoYEV9l4n+EwIF
	 cTUgGhQxAOU3yXEtITAUj9Qku8CQJ1orc/u0GmB/X9EDB40M4fPSbj7J4ietjUNSPl
	 4wLY0BV0mRaVjwCcW10DvGl42N8e+ZFQPxGg501IhbZTbwryGcKGL20XaV+DYQr0vk
	 ugY+lmQukUztg==
Date: Tue, 3 Feb 2026 10:09:20 +0200
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
Message-ID: <aYGsyk5SnzktKM3m@kernel.org>
References: <20260202204425.2614054-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202204425.2614054-1-jarkko@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8416-lists,linux-integrity=lfdr.de];
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
X-Rspamd-Queue-Id: E8E29D61B3
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 10:44:21PM +0200, Jarkko Sakkinen wrote:
> Already a quick Google survey backs strongly that OOT drivers (e.g.,
> v4l2loopback) are the defacto solution for streaming phone cameras in
> video conference calls, which puts confidential discussions at risk.
> 
> It can be also claimed that there's enough OOT usage in the wild that
> possible security bugs could be considered as potential zerodays for the
> benefit of malicious actors.
> 
> The situation has been stagnated for however many years, which is
> unsastainable situation, and it further factors potential security
> risks. Therefore, a driver is needed to address the popular use case.
> 
> vcam is a DMA-BUF backed virtual camera driver capable of creating video
> capture devices to which data can be streamed through /dev/vcam after
> calling VCAM_IOC_CREATE. Frames are pushed with VCAM_IOC_QUEUE and recycled
> with VCAM_IOC_DEQUEUE. Zero-copy semantics are supported for shared DMA-BUF
> between capture and output.
> 
> This enables efficient implementation of software, which can manage network
> video streams from phone cameras, and map those streams to video devices.
> 
> PipeWire or any other specific pick of userspace software cannot really
> address the issue at scale, as e.g., the use of v4l2loopback is both wide
> and scattered.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

After learning a bit more about the topic and for future updates I will
drop YUYV. NV12, MJPEG, and additionally RGBX32 and XRGB32 for testing
and GPUs define pretty well the requirements for a software define device,
and limit the applicability of "proprietary risk" (as that was the main
concern raised). I honestly did not have idea what would be an
appropriate subset of formats to constraint the driver initially.

In addition, a better name for this module would probably be swcam as it
does not  mix up with those pre-existing devices starting with the
letter 'v'.

BR, Jarkko

