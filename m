Return-Path: <linux-integrity+bounces-5894-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F8DA8AB26
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Apr 2025 00:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 588FC444ADA
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Apr 2025 22:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D470327A116;
	Tue, 15 Apr 2025 22:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Km+XnxWT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DA127A106
	for <linux-integrity@vger.kernel.org>; Tue, 15 Apr 2025 22:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744755324; cv=none; b=CT982iu+6al+rnRLcOkwtH6ly50X5FsNOsSPTnK/jzlWa+K2DyAZ6BQP2sAhpoi9y5J3whcn0WaVGWQ6jMkkmU9lNzt5GPfrxZgKpEwhmVLgSEwjAQxqVs+31Li67ILnPEtIJFrFpP/whNBQ/Ta+rhJnphBdYpdyZXd1XlPF9X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744755324; c=relaxed/simple;
	bh=wiubO1rowJJ7Bd/abC83QrnLeIgusBUrsszAL9POhpQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MJdh9PLQcfNaL/W2L/u2Ndcy6Ss5DonPS4NGEiPf8525r1wvW1tHubxwTI1ey0Jf1AB1qMQy3C1VaH9uxr8ChK9F2ZN6jzdDCjW0gVN9J72lR/oNAQ7wGHZF/dLFnVFVplhUumEBbmwh5M0iOmDT4rT/mm0XbelDnqqhvAQa+R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Km+XnxWT; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff6167e9ccso7144203a91.1
        for <linux-integrity@vger.kernel.org>; Tue, 15 Apr 2025 15:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744755322; x=1745360122; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ry9xEwNaBzqQYPUr2sJCAn+hzw6WkQUhzGrae9Rjk7I=;
        b=Km+XnxWTWEXmcoi4EJAFrph0ly+biRnMcNohDNRhRN4kpbbeVKVfQR1qm5U88N3GZ8
         cG92m7nceKFaTkQvsDkgY5Dimo4bTzdJqcI2itzLvb67MSw2epzv5cNrR6bwZMO5k+6L
         FAZsSoxrcBWo/9GR2M14pEfOIb2Wndp2y0BybN8rH58K4yOMPJbRJ2IYEPTvzBydfKtd
         1wt7J/TUO+WpF00wrO7gSihZX8F7TUdZwQNzme7uC8rm2dvLOurV6H+m1wT1Chr6p98d
         eIVPDjE3SK8pqgC/dSx6NbcPhUr6BFzOT1XlB/TgjrRcrj98jtM9j7e7UMwDJxtgvRjF
         7dkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744755322; x=1745360122;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ry9xEwNaBzqQYPUr2sJCAn+hzw6WkQUhzGrae9Rjk7I=;
        b=c2fvkbetSLrtwvhUuo7FcBzDJItsqKMWgY6rk570/3h4xu3Ko/gN5ABLocccH/IU0o
         SSudeulMMsjDIs+1QFpY9Dr1Yi9ExkROK8RRX6i9Z8UVcbI3iEx2DxyaNID8p1CDPicn
         03IPm2H3eCena9HVFeD0dJFyJ+aK7I25Z0W7qc9qxXy14VT0fYYs5NEnfgBucnXpjCg1
         g02eVans8T0yH0/rq0+NoZ2oKKKL9x/RuNKPEnogG1LIzX/gJQpv7Ezxb770V9qekmhg
         ETQX8EHoPqKJknvaJAZ1XbojEvulXeAdq6xYiqcg4awvHhISicevzYnf6a12gdsfI/F/
         heOw==
X-Forwarded-Encrypted: i=1; AJvYcCUE+DD0SxEpNIKBXRbHuBpI8NxarL2lY0/eZOvEwxAKz0pTjgk5NpTNgy9VsTr+bSXWDgu5B2k4mKgdoYYEovU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDQuIIqk/ogkIVmhuAsPDbZ+ibYtDcmMPlKd1YnzLTlWuUXlQA
	p3JzeDZR0JmqEzZoIqECVywIFbB3KQImQQj+ultstbDLqFTW9QQHMSdmmEIUWwRjaZ7i5/SLjFQ
	cmQ==
X-Google-Smtp-Source: AGHT+IG9a+i7AqRB2/IlyNo5DtSnN1pt7IPfUfiPrFvNunVgOzcitRLYND0tYsvNeLieAMV60IKunKQjhZg=
X-Received: from pjci30.prod.google.com ([2002:a17:90a:3da1:b0:2fa:2891:e310])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5484:b0:2fa:137f:5c61
 with SMTP id 98e67ed59e1d1-3085eeb5078mr1496593a91.12.1744755322545; Tue, 15
 Apr 2025 15:15:22 -0700 (PDT)
Date: Tue, 15 Apr 2025 15:15:21 -0700
In-Reply-To: <e781cabc-90ee-48cf-9a09-116a8edace1e@citrix.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410204149.2576104-1-ross.philipson@oracle.com>
 <20250410204149.2576104-10-ross.philipson@oracle.com> <Z_mMaAykU0IVKsjU@google.com>
 <e781cabc-90ee-48cf-9a09-116a8edace1e@citrix.com>
Message-ID: <Z_7aeWAxBSdU6cvc@google.com>
Subject: Re: [PATCH v13 09/19] x86: Secure Launch kernel early boot stub
From: Sean Christopherson <seanjc@google.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux.dev, 
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 15, 2025, Andrew Cooper wrote:
> On 11/04/2025 10:40 pm, Sean Christopherson wrote:
> > On Thu, Apr 10, 2025, Ross Philipson wrote:
> >> +	 * instruction can return for a number of reasons. Test to see if it returned
> >> +	 * because the monitor was written to.
> >> +	 */
> >> +	monitor
> >> +
> >> +1:
> >> +	mfence
> >> +	mwait
> >> +	movl	(%eax), %edx
> > Why load the value into EDX?  At a glance, the value is never consumed.
> >
> >> +	testl	%edx, %edx
> >> +	jz	1b
> > This usage of MONITOR/MWAIT is flawed.  The monitor needs to be re-armed in each
> > loop, otherwise mwait will be a glorified nop.
> >
> > More importantly, the exit condition needs to be checked before monitor,
> 
> after monitor and before mwait.

Gah, yeah, I mean to say "before mwait".

