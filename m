Return-Path: <linux-integrity+bounces-7676-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 85335C86555
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Nov 2025 18:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B49CF34E12C
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Nov 2025 17:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABC432B991;
	Tue, 25 Nov 2025 17:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jewHqN6Q"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ECF32B988;
	Tue, 25 Nov 2025 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764093315; cv=none; b=e7LO7FVN2eQkAakeLwL+9XmsElLL9EexGcW5Zx7NNwF/xD4aR9kRIWVXF4IiaeZPkvhNdYQZt7hNslmjMFTQo4a2eCljnU4VQTh6juP0tlDM4Xa87o/M5Bi1h5OdKvvF8E7weL2A6x3iha6PO1joHBgvJYe65Jpd5KBuSmn6cCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764093315; c=relaxed/simple;
	bh=epd08UzdMlvmzqtj+HCY9DpuXClNxvJWcZbzRWQ7yAE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SDadgOCSbMU+tkuYZ6w66bVWhUgz43XFIY9+cZJOtbehN/YNQ7HV0rcTKYHG1QKlALyp+pLP0YtQJDQ7mBNIASZJ3wygXDkRIL6Otnk/18nLCUufl1fBvzCZVpOpAsL4X5iJaK+OpabFrjf+lsUjZHaM580Shy1og8ldMbIglC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=jewHqN6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E0DC116B1;
	Tue, 25 Nov 2025 17:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1764093314;
	bh=epd08UzdMlvmzqtj+HCY9DpuXClNxvJWcZbzRWQ7yAE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jewHqN6Q8JXpkrnO8xyEZ+THGP+SCskynQdPSBGorR64+rzOhymUYJF2Nnflkb09L
	 j4ZZ06SBTvDITg6FkFftLX0gVpDGQFBe2AZCLGI54GSYXYsYNiai9ioh1taHDTwwLs
	 ciKmZp1ML+SBY75bu4ZrIfPhWOIL9x0vhyvsDa+o=
Date: Tue, 25 Nov 2025 09:55:13 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>
Cc: Pingfan Liu <piliu@redhat.com>, kexec@lists.infradead.org,
 linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Roberto
 Sassu <roberto.sassu@huawei.com>, Alexander Graf <graf@amazon.com>, Steven
 Chen <chenste@linux.microsoft.com>, stable@vger.kernel.org
Subject: Re: [PATCHv2 1/2] kernel/kexec: Change the prototype of
 kimage_map_segment()
Message-Id: <20251125095513.d71dcf5aca95db49008cbc25@linux-foundation.org>
In-Reply-To: <aSU2jy/ujJILHH9n@MiWiFi-R3L-srv>
References: <20251106065904.10772-1-piliu@redhat.com>
	<20251124141620.eaef984836fe2edc7acf9179@linux-foundation.org>
	<aSU2jy/ujJILHH9n@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Nov 2025 12:54:39 +0800 Baoquan He <bhe@redhat.com> wrote:

> On 11/24/25 at 02:16pm, Andrew Morton wrote:
> > On Thu,  6 Nov 2025 14:59:03 +0800 Pingfan Liu <piliu@redhat.com> wrote:
> > 
> > > The kexec segment index will be required to extract the corresponding
> > > information for that segment in kimage_map_segment(). Additionally,
> > > kexec_segment already holds the kexec relocation destination address and
> > > size. Therefore, the prototype of kimage_map_segment() can be changed.
> > 
> > Could we please have some reviewer input on thee two patches?
> 
> I have some concerns about the one place of tiny code change, and the
> root cause missing in log. And Mimi sent mail to me asking why this bug
> can'e be seen on her laptop, I told her this bug can only be triggered
> on system where CMA area exists. I think these need be addressed in v3.

Great, thanks, I'll drop this version.

