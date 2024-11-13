Return-Path: <linux-integrity+bounces-4106-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C26939C7799
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 16:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83659281866
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 15:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A6E3A8D2;
	Wed, 13 Nov 2024 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="GKWWDnnq";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="M+nPUxyz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BC32582
	for <linux-integrity@vger.kernel.org>; Wed, 13 Nov 2024 15:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731512832; cv=none; b=uNlBqfK5QdZlCExoRoCm9jKVvfFXh3A3n6//vGW/kVYM5PPmJFp4HboMMndoYbqMeD5q3kYQeVUxAz8apDNmUDXPYYC2zafhECAz94DV+WoddT8NGH3OCVLYZBTJ7LOA55KdGvSGVnUS2qhQAq1GJo+dKr5agFDs1jfutuHAHEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731512832; c=relaxed/simple;
	bh=yirum8pwgtZ8wz99peKExyVsqN3TaDDOP/uxojCzxrU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wamr+OxrFDCmfbKg+te4PDzaXhsjD1HaL7Y+3HoK0OBGkV5IZfyD21jcotdM+Nzap2l7n06/+6Z8tzs0Ziexn0zYtLm432K+zTJhpgWMOkYitRNRrr4GQqVli7/2sEtyAOX4hreL4JjmsGpgYkZTGc0ss03LeXk0EDeM27B7AZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=GKWWDnnq; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=M+nPUxyz; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1731512829;
	bh=yirum8pwgtZ8wz99peKExyVsqN3TaDDOP/uxojCzxrU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=GKWWDnnq5BGvR51v9+o84txhJ5Qjk2QZcAOfyRUF5+qad+w/znbpivckfBytjk7nj
	 tIYI6tjLUb/CQhCYFaDO4YDRSywzjsObsHfX6uts9SzzHopXucqwZazYRxws4fS0DO
	 v4rJx+YNI5cIzB1EyPvrP0m2h7rE2CB8gC7aYHsA=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 39F8812809CC;
	Wed, 13 Nov 2024 10:47:09 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id dkfyI9YxD4FF; Wed, 13 Nov 2024 10:47:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1731512828;
	bh=yirum8pwgtZ8wz99peKExyVsqN3TaDDOP/uxojCzxrU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=M+nPUxyzFD9S1txwy0ZIP2tnFdpHXvBV0Q82MiLh6/Aj0KZXBI4dFrOtOtAubXuRR
	 GJhPh1PCbNa+beAEWFdSN1aGkzQK+TtD7ZmLGc+dXmN5qzjRgAJ8/Whw28L5RQcJ9S
	 7ZmIRHCxH6hDKQa+my8TygWKDMgBpSB9UBG6kahc=
Received: from [172.20.7.66] (unknown [74.85.233.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C0ED312807DB;
	Wed, 13 Nov 2024 10:47:08 -0500 (EST)
Message-ID: <8fe12e2eb9beb159d2af8462fa0b9b1f946deacb.camel@HansenPartnership.com>
Subject: Re: regression: kernel log "flooded" with tpm tpm0: A TPM error
 (2306) occurred attempting to create NULL primary
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Christoph Anton Mitterer <calestyo@scientia.org>, 
	linux-integrity@vger.kernel.org
Date: Wed, 13 Nov 2024 07:47:07 -0800
In-Reply-To: <693caa85c3ee1b3117a562894971de60b6842d00.camel@scientia.org>
References: <693caa85c3ee1b3117a562894971de60b6842d00.camel@scientia.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2024-11-13 at 15:44 +0100, Christoph Anton Mitterer wrote:
> Hey.
> 
> Forwarding myself from:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1087331
> 
> Since 6.11.7 (might have also happened with .6, which I've skipped,
> but
> wasn't the case at least in 6.11.5).
> 
> I get:
> Nov 11 17:50:20 heisenberg kernel: tpm tpm0: A TPM error (2306)
> occurred attempting to create NULL primary
> Nov 11 17:50:30 heisenberg kernel: tpm tpm0: A TPM error (2306)
> occurred attempting to create NULL primary
> Nov 11 17:50:41 heisenberg kernel: tpm tpm0: A TPM error (2306)
> occurred attempting to create NULL primary
> Nov 11 17:50:51 heisenberg kernel: tpm tpm0: A TPM error (2306)
> occurred attempting to create NULL primary
> Nov 11 17:51:01 heisenberg kernel: tpm tpm0: A TPM error (2306)
> occurred attempting to create NULL primary
> Nov 11 17:51:11 heisenberg kernel: tpm tpm0: A TPM error (2306)
> occurred attempting to create NULL primary

2306 is TPM_RC_OBJECT_MEMORY - out of memory for object contexts.  What
it's saying is that somewhere we're missing a context flush.  I'll take
a look.  Does this happen with the current upstream kernel?  It could
be a flush got lost as a result of a bad stable backport.

> It seems that this doesn't occur on a fresh boot, but only when I
> resume from hibernation:

That could be more significant, especially with this in the log:

> Nov 13 12:33:06 heisenberg kernel: tpm tpm0: NULL Seed name
> comparison failed
> Nov 13 12:33:16 heisenberg kernel: tpm tpm0: NULL Seed name
> comparison failed
> Nov 13 12:33:26 heisenberg kernel: tpm tpm0: NULL Seed name
> comparison failed

I think we might have to expect the NULL name to change on actual
hibernation because unlike suspend to ram it does power off the TPM.

However, the code that causes the above message was also in 6.10 ...
are you sure kernels 6.10 and beyond hibernate without producing this
message?

Regards,

James


