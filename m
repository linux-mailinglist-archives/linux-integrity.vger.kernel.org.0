Return-Path: <linux-integrity+bounces-6106-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB019AA5FC2
	for <lists+linux-integrity@lfdr.de>; Thu,  1 May 2025 16:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8858A1BC59AF
	for <lists+linux-integrity@lfdr.de>; Thu,  1 May 2025 14:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30E11F1500;
	Thu,  1 May 2025 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="33VStrY3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155AC1F1301
	for <linux-integrity@vger.kernel.org>; Thu,  1 May 2025 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746109192; cv=none; b=cqIp+CrMBI0jq8jpHrmIKGpZpaWe8JVz8K+Vf8KkKNOF/Gar91hwn0hLw+LTvbWLiJcZr6+fg3aHyIoy1JbFqyoosNh6Z9AA4u752LG6Z4SQmK0whNRnjs1HcdtLhX8vIgxzrAP85rQ+KXf5tYvA088zYUxeYvKqxGhGqX4ln1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746109192; c=relaxed/simple;
	bh=RFwLAdDJzHnRsl1AiuqY7ErKiNdGVq/+PnAbJFngrNc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hoh9jvuzfRfr3aztizNCoCmdV8UFrUnqWn2uZ/EBmrHS26qGSkGauLYw0WNzqmq9BLW5PmcBtk/6BjGz39/1CsttvNxRvQMjYXCobxG8+lPgacqdANs8FWVR/y/KK5zpfnzJPyb2xdAlfoEKMnEd4cEXRygOTWCsb3qUTti1E+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=33VStrY3; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43d00017e9dso4366275e9.0
        for <linux-integrity@vger.kernel.org>; Thu, 01 May 2025 07:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746109189; x=1746713989; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TmEF1yP8U0niebBh9hfc5iyUEhI2jhPWqahRuFkaIQM=;
        b=33VStrY3M+0grhQPsFBLTNP+0qv1sXruXkpSi2qEN4NhjcNIKTQAYuEJAYQ0BoKIG8
         jb1Yh1UjzmsDgorOQsKiP4KrIIHxdd6+u63LJm9Mk6YBdmv+M5ucvN338dOoNyfhR91V
         CRopi2hiNlsOiVOnOGjvjSqk0dyxZVVJMP9cAtAG0Gv9Mfe2atHMzdiix7UpzcOTDR81
         HdiGvh1S3AxVRQUaa8BWaKBSzXZveALkGfi7lxoo80GAa/pMY0eqsZWpNchsWSXRH3vQ
         GboPpGf0LcbzX5ppqQYS7OkW9x9vE+a3kPnyLt8rVX4WJGf8xuIz8rv5M9LRxfloCJ3e
         +4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746109189; x=1746713989;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TmEF1yP8U0niebBh9hfc5iyUEhI2jhPWqahRuFkaIQM=;
        b=djARHw/ePdb3lgk0H+pb7hx/XbKzZq+vMARBO3nboqXGmLQaIP3Ilp6fojH3ZaDSxs
         mMUxDWqc9wRFZzvlHlt50XyfzEKCMeyx0AJ0jVMqO6nLc3AqLM3dCGauBm6W9RqlyKax
         A7qWIL4/nYFz84D1sINNFtgkNps9JD7nGkDSTixunLXMBGksiiVBNL66Y2d4vBjYz3nm
         vgMZpBhsE7LCpT9gbUBBNaQi1bB3hsO5MMep9NCG6E76F7Xud2WUyTBqWfMRF5buqaYl
         c1CVlv2oqT/m7nYZhpy+FRuuM5CG+1g0DpDaX7V238XAUcnsBJ/ly/wCrbHMPH684Due
         Jo4w==
X-Forwarded-Encrypted: i=1; AJvYcCVxkOIMf9XV5LuEVTBU/eW5APWNhlEIyoA1l927I6s/8ssg0j/GRxZX/oblwqL4SLw/jB3wGxtePY3n7B3CgY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw180F+BiYRV1jXuHOR1sSn7iBYK0fbCawYSPgkLNVRdBDBdFWC
	1cZiqe8/IX9rHKEjQR65w/y7kUqqUwFShuPvYSBjfO1K5/5oKeywWrSuZ8n3MKaTstq43AGA4Bl
	FOA4H5kP1WQ==
X-Google-Smtp-Source: AGHT+IE4OWD5XxcERH4cgRX5gY9PM+u+mzYGVEd/YlTx4e+t3SrV5tDi5azUj0xMuNVR7NdRXpnF4uWQLtuxPQ==
X-Received: from wmbhe15.prod.google.com ([2002:a05:600c:540f:b0:441:b79a:76cf])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:35d6:b0:43c:f8fc:f686 with SMTP id 5b1f17b1804b1-441b64ed9d8mr27510245e9.3.1746109189194;
 Thu, 01 May 2025 07:19:49 -0700 (PDT)
Date: Thu, 01 May 2025 14:19:47 +0000
In-Reply-To: <20250429123504.GA13093@lst.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250429-noautoinline-v3-0-4c49f28ea5b5@uniontech.com> <20250429123504.GA13093@lst.de>
X-Mailer: aerc 0.20.0
Message-ID: <D9KW1QQR88EY.2TOSTVYZZH5KN@google.com>
Subject: Re: [PATCH RFC v3 0/8] kernel-hacking: introduce CONFIG_NO_AUTO_INLINE
From: Brendan Jackman <jackmanb@google.com>
To: Christoph Hellwig <hch@lst.de>, <chenlinxuan@uniontech.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Sagi Grimberg <sagi@grimberg.me>, Andrew Morton <akpm@linux-foundation.org>, 
	Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex.williamson@redhat.com>, Peter Huewe <peterhuewe@gmx.de>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, <linux-nvme@lists.infradead.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <kvm@vger.kernel.org>, 
	<virtualization@lists.linux.dev>, <linux-integrity@vger.kernel.org>, 
	<linux-kbuild@vger.kernel.org>, <llvm@lists.linux.dev>, 
	Winston Wen <wentao@uniontech.com>, <kasan-dev@googlegroups.com>, 
	<xen-devel@lists.xenproject.org>, Changbin Du <changbin.du@intel.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Tue Apr 29, 2025 at 12:35 PM UTC, Christoph Hellwig wrote:
> On Tue, Apr 29, 2025 at 12:06:04PM +0800, Chen Linxuan via B4 Relay wrote:
>> This series introduces a new kernel configuration option NO_AUTO_INLINE,
>> which can be used to disable the automatic inlining of functions.
>> 
>> This will allow the function tracer to trace more functions
>> because it only traces functions that the compiler has not inlined.
>
> This still feels like a bad idea because it is extremely fragile.

Can you elaborate on that - does it introduce new fragility?

