Return-Path: <linux-integrity+bounces-4118-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D47069C805D
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2024 03:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 585091F21EAD
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2024 02:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBAA17C20F;
	Thu, 14 Nov 2024 02:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="J2brp4n/";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="J2brp4n/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8830B18641
	for <linux-integrity@vger.kernel.org>; Thu, 14 Nov 2024 02:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731550001; cv=none; b=gKp/etjEGG8L2sFhedWZ2dOnEZNo90ZkQPL+it0QTaqecrAth8c38suExVgjSFVhDH3MK+nHX5PX+LYq4OFIR8nXqvhpyQMVJXf4bembhJkqe+6RZNieYk/PieD1SJkhJ5xVk/+tPUMUIMqqjyeo4thhwxSYCyXjHy0oC6wDAgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731550001; c=relaxed/simple;
	bh=osM3LGf/Vlv/e/gwQZy2oKyV/Kb2b0sES8y5GQy7wGs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CuFpQWNBUPWxWRXv0cJe1Ly/Zn0iKyJ4qqtKbWX29OVyK0vl5KGdEyGXLb1EkxJsHnS9qoafEwOHIugsya2q8rbJy9vF1z6Ug9pUyWf5EaYNaIpKliv4OmVv8NXchCAbopKNwhvTNpPNhlsg7YcOM1yV+ZdKriszAokBikvJocU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=J2brp4n/; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=J2brp4n/; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1731549998;
	bh=osM3LGf/Vlv/e/gwQZy2oKyV/Kb2b0sES8y5GQy7wGs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=J2brp4n/9b38HX8OjOrUQWyk4ANjOtKXPpb22VxPn04LilgnQk1OGZeuEgDCFF8yP
	 BRMl2QJK0AFsBmb81ErtgxxD1xoOUxSxGpkS5uUvejmU5QLkIPYQnjcDGgODVnL5gd
	 RF31/xEZq4ZqNdPh6zFLfcxlMC+o2EwHZduQpm4c=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id C31A01281383;
	Wed, 13 Nov 2024 21:06:38 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 7oK7ZV1tdRpS; Wed, 13 Nov 2024 21:06:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1731549998;
	bh=osM3LGf/Vlv/e/gwQZy2oKyV/Kb2b0sES8y5GQy7wGs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=J2brp4n/9b38HX8OjOrUQWyk4ANjOtKXPpb22VxPn04LilgnQk1OGZeuEgDCFF8yP
	 BRMl2QJK0AFsBmb81ErtgxxD1xoOUxSxGpkS5uUvejmU5QLkIPYQnjcDGgODVnL5gd
	 RF31/xEZq4ZqNdPh6zFLfcxlMC+o2EwHZduQpm4c=
Received: from [10.106.168.49] (unknown [167.220.104.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7450012810CC;
	Wed, 13 Nov 2024 21:06:38 -0500 (EST)
Message-ID: <05f511502a5918fe81d69201ec3df01b25803bcd.camel@HansenPartnership.com>
Subject: Re: regression: kernel log "flooded" with tpm tpm0: A TPM error
 (2306) occurred attempting to create NULL primary
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Christoph Anton Mitterer <calestyo@scientia.org>, 
	linux-integrity@vger.kernel.org
Date: Wed, 13 Nov 2024 18:06:37 -0800
In-Reply-To: <c1b56e93bd7e92d5313fde89dc0ee09fdd4c8577.camel@scientia.org>
References: <693caa85c3ee1b3117a562894971de60b6842d00.camel@scientia.org>
	 <8fe12e2eb9beb159d2af8462fa0b9b1f946deacb.camel@HansenPartnership.com>
	 <c1b56e93bd7e92d5313fde89dc0ee09fdd4c8577.camel@scientia.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2024-11-14 at 00:56 +0100, Christoph Anton Mitterer wrote:
> On Wed, 2024-11-13 at 07:47 -0800, James Bottomley wrote:
> > That could be more significant, especially with this in the log:
> > 
> > > Nov 13 12:33:06 heisenberg kernel: tpm tpm0: NULL Seed name
> > > comparison failed
> > > Nov 13 12:33:16 heisenberg kernel: tpm tpm0: NULL Seed name
> > > comparison failed
> > > Nov 13 12:33:26 heisenberg kernel: tpm tpm0: NULL Seed name
> > > comparison failed
> > 
> > I think we might have to expect the NULL name to change on actual
> > hibernation because unlike suspend to ram it does power off the
> > TPM.
> > 
> > However, the code that causes the above message was also in 6.10
> > ...
> > are you sure kernels 6.10 and beyond hibernate without producing
> > this
> > message?
> 
> Quite sure. At least the "flooding" wasn't the case, and `grep`ing
> some
> older kernel logs (these should all be 6.11.5) I get:
> $ zgrep tpm /var/log/kern.log.2.xz
> 2024-10-29T21:03:39.499295+01:00 heisenberg kernel: tpm_tis
> NTC0702:00: Ignoring error -5 while suspending
> 2024-10-30T14:23:34.460371+01:00 heisenberg kernel: tpm_tis
> NTC0702:00: Ignoring error -5 while suspending
> 2024-10-30T17:50:53.559651+01:00 heisenberg kernel: tpm_tis
> NTC0702:00: 2.0 TPM (device-id 0xFC, rev-id 1)
> 2024-10-31T14:28:10.449727+01:00 heisenberg kernel: tpm tpm0: NULL
> key integrity failure!
> 2024-10-31T14:28:10.529662+01:00 heisenberg kernel: tpm tpm0: NULL
> Seed name comparison failed
> 2024-10-31T14:28:10.529673+01:00 heisenberg kernel: tpm tpm0: NULL
> name has changed, disabling TPM due to interference
> 2024-10-31T19:52:23.385845+01:00 heisenberg kernel: tpm_tis
> NTC0702:00: Ignoring error -5 while suspending
> 2024-11-01T06:55:20.138812+01:00 heisenberg kernel: tpm_tis
> NTC0702:00: Ignoring error -5 while suspending
> 2024-11-01T15:41:22.428940+01:00 heisenberg kernel: tpm_tis
> NTC0702:00: Ignoring error -5 while suspending
> 2024-11-01T18:33:47.141633+01:00 heisenberg kernel: tpm_tis
> NTC0702:00: Ignoring error -5 while suspending
> 2024-11-01T22:28:13.469085+01:00 heisenberg kernel: tpm_tis
> NTC0702:00: Ignoring error -5 while suspending
> 2024-11-02T06:12:26.424367+01:00 heisenberg kernel: tpm_tis
> NTC0702:00: Ignoring error -5 while suspending
> 
> But this is probably anyway obsolete as Jarkko seems to have found
> the issue :-)

Getting the TPM messages to quiet by disabling the chip fixes the
message spew, but it doesn't get you a working TPM chip back on resume.
I'll take a look at the hibernation path and see if I can see a hook we
can use to bring the TPM back.

Regards,

James
 

