Return-Path: <linux-integrity+bounces-7595-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C21C3E01A
	for <lists+linux-integrity@lfdr.de>; Fri, 07 Nov 2025 01:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE6F188AD57
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Nov 2025 00:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE662E6100;
	Fri,  7 Nov 2025 00:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="klfNDB+x"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0609F2E5D17
	for <linux-integrity@vger.kernel.org>; Fri,  7 Nov 2025 00:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476284; cv=none; b=Z6stHahJkDwArVlI3rACXe5fbeOG3EEE4sTbIx5urPei+yBtPkvQ/g8F7bJAyf4u1zwul/6A0ja0fPwn2eEV67GpjIAchIgNrvM9fUVy9cq2PjjOeQ7MvZFYA94PV30j7PJ87QysfH6IAEE5fq27hyCWmeHJKmSJ5Feg7YaQo6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476284; c=relaxed/simple;
	bh=FNNCunyUX0kB5m9NXDlr3Oe0w0tL0R99MwjN2aO0MOs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qfqnTLhXkzpABLS/10/Mtggz7quAudL3PjGTXj27loYwIlPA0H7eRMU2vtvMfvoh9Cec9ws9blZGt61jxmGBUupv5smM8n3gKtzewW/OC0lVfBpg0y2KiqWoYPyAUMILwsyOHmGGRG/sYMFjbFA1eKJDOuazVpTP4gxCU6+oLEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=klfNDB+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4DAC4CEF7;
	Fri,  7 Nov 2025 00:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762476283;
	bh=FNNCunyUX0kB5m9NXDlr3Oe0w0tL0R99MwjN2aO0MOs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=klfNDB+xoOmbhTMaQHdVe84uRgh4JR1UTkHpwV1D2Pag+idktoUa8DQJDR+c6/zZe
	 uqLtvvCNrDyY7fE8Igl8LSiqnEoACcQXDBBaUMvEGj2b2fit1uNLaSYbeMpwmMi1x6
	 OjR7To/ktTFY6YDXMHePh9nvgxVW209MBaYD7X+Y=
Date: Thu, 6 Nov 2025 16:44:42 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org, Baoquan He
 <bhe@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Alexander Graf <graf@amazon.com>, Steven Chen
 <chenste@linux.microsoft.com>
Subject: Re: [PATCH 2/2] kernel/kexec: Fix IMA when allocation happens in
 CMA area
Message-Id: <20251106164442.f0158876667a18d0f31a127a@linux-foundation.org>
In-Reply-To: <CAF+s44Qoai54qUDqmVQoqWspneuuYF=SLYezoew_EHb_0By77w@mail.gmail.com>
References: <20251105130922.13321-1-piliu@redhat.com>
	<20251105130922.13321-2-piliu@redhat.com>
	<20251105161432.98eb69f87f30627a9067e78e@linux-foundation.org>
	<CAF+s44Qoai54qUDqmVQoqWspneuuYF=SLYezoew_EHb_0By77w@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Nov 2025 10:57:33 +0800 Pingfan Liu <piliu@redhat.com> wrote:

> > > This is caused by the fact that kexec allocates the destination directly
> > > in the CMA area. In that case, the CMA kernel address should be exported
> > > directly to the IMA component, instead of using the vmalloc'd address.
> >
> > This is something we should backport into tearlier kernels.
> >
> > > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Baoquan He <bhe@redhat.com>
> > > Cc: Alexander Graf <graf@amazon.com>
> > > Cc: Steven Chen <chenste@linux.microsoft.com>
> > > Cc: linux-integrity@vger.kernel.org
> > > To: kexec@lists.infradead.org
> >
> > So I'm thinking we should add
> >
> > Fixes: 0091d9241ea2 ("kexec: define functions to map and unmap segments")
> Should be:
> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> 
> Because 07d24902977e came after 0091d9241ea2 and introduced this issue.

Thanks, I updated the mm.git copy of this patch.


