Return-Path: <linux-integrity+bounces-7578-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D96C38729
	for <lists+linux-integrity@lfdr.de>; Thu, 06 Nov 2025 01:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55AE31A23A07
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Nov 2025 00:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8D642AB7;
	Thu,  6 Nov 2025 00:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IDYLs/+j"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8763AC39
	for <linux-integrity@vger.kernel.org>; Thu,  6 Nov 2025 00:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762388074; cv=none; b=N7mQLfNdqP6Ckfz4xha1QdCBGosrirVq5sNCA3VcJFtTmjSkarRkgQwM85YwjW9U30NRpczXM/O+O+rdw9sbBekojvsMEIVv3EnpLSQsRTgfaAfMRLTdeUw+e3ahNuA9WRKvc9VDgIrtvSw8WRFPzwbRaPQoif2P5k3n1LLlAO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762388074; c=relaxed/simple;
	bh=PqIMT15INbsDmi302tCo0x1agvgPMTbLwB2w2oCbItw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lYMIEFgbqfeqarp1Q1v6Rwj830llNZ1k71kKbBCzZ+r9Gsieget5rgjc+Z8If0JHQ5ohPd7M9JPo5zgz9HIWoT4GNCvzP12+7DcQ/I2on6cfff3k75fBSk8dwI+7Qmmm8CcyMyxHBydYlIjqKfDSwt1aDoIxzMT1FiCZ46M46QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IDYLs/+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA616C4CEFB;
	Thu,  6 Nov 2025 00:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762388073;
	bh=PqIMT15INbsDmi302tCo0x1agvgPMTbLwB2w2oCbItw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IDYLs/+jmgPawiu8djO7RICBEuZjVxeN9ymzOonINTrbeQax65Wnxq4h9asnvwHEA
	 ieAoDovK/pPjI3Glja3hmw0/iHT2rJo+tt58yKL6mU3UeQmk4hypgzaafJ+g+zZRle
	 6aIJ0CIV1GPmsCCktI0DeYf+svYMfb2GZ+jNhpTI=
Date: Wed, 5 Nov 2025 16:14:32 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org, Baoquan He
 <bhe@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Alexander Graf <graf@amazon.com>, Steven Chen
 <chenste@linux.microsoft.com>
Subject: Re: [PATCH 2/2] kernel/kexec: Fix IMA when allocation happens in
 CMA area
Message-Id: <20251105161432.98eb69f87f30627a9067e78e@linux-foundation.org>
In-Reply-To: <20251105130922.13321-2-piliu@redhat.com>
References: <20251105130922.13321-1-piliu@redhat.com>
	<20251105130922.13321-2-piliu@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Nov 2025 21:09:22 +0800 Pingfan Liu <piliu@redhat.com> wrote:

> When I tested kexec with the latest kernel, I ran into the following warning:
> 
> [   40.712410] ------------[ cut here ]------------
> [   40.712576] WARNING: CPU: 2 PID: 1562 at kernel/kexec_core.c:1001 kimage_map_segment+0x144/0x198
> [...]
> [   40.816047] Call trace:
> [   40.818498]  kimage_map_segment+0x144/0x198 (P)
> [   40.823221]  ima_kexec_post_load+0x58/0xc0
> [   40.827246]  __do_sys_kexec_file_load+0x29c/0x368
> [...]
> [   40.855423] ---[ end trace 0000000000000000 ]---
> 
> This is caused by the fact that kexec allocates the destination directly
> in the CMA area. In that case, the CMA kernel address should be exported
> directly to the IMA component, instead of using the vmalloc'd address.

This is something we should backport into tearlier kernels.

> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Alexander Graf <graf@amazon.com>
> Cc: Steven Chen <chenste@linux.microsoft.com>
> Cc: linux-integrity@vger.kernel.org
> To: kexec@lists.infradead.org

So I'm thinking we should add

Fixes: 0091d9241ea2 ("kexec: define functions to map and unmap segments")
Cc: <stable@vger.kernel.org>

yes?

