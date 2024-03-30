Return-Path: <linux-integrity+bounces-1937-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2114892DA1
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Mar 2024 23:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5041C20CEB
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Mar 2024 22:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10A32E3E8;
	Sat, 30 Mar 2024 22:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ft0qMpZG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B709028F8
	for <linux-integrity@vger.kernel.org>; Sat, 30 Mar 2024 22:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711837947; cv=none; b=fQjNgspvIlGoh+NhDc4+UD8spVlskbGPuXlw9jRBx+14pszgqSq9Mci90l4UdxuzfIgyyW3zllVJufsRlCEGGLvgYLLunq+DR9AhA3QmASMNHSF0yZVJArfSDf0X20rROq5vaObqBGclAop2Mfn1JygcJAidfzIUAJqt8LqgVnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711837947; c=relaxed/simple;
	bh=U43Wuq55vMxCLBzqGRdkR/mMGx+zO2GmUgWVZu6Gawg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MC2kKYr7hZxlvL4KY6eIEyVXE7a7fBRrGhPrDC0/4KsNGWlhsMhIj4cXEGurZOT0YSKrAxzHJWIz9Vk7XbeQZguP+jmFM20dS23QbMdlZHlCeFtpqxpfuheSfe6YkBVGB1lsv0z3cmlb1gvf8abB75czUYTMAg6dXTIlGZM4UfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ft0qMpZG; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-515c3eeea5dso3295105e87.1
        for <linux-integrity@vger.kernel.org>; Sat, 30 Mar 2024 15:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711837944; x=1712442744; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qh7m7AzKE9zxgcmaZLpWEMMQFO2AQlI5WB3LlhW1I44=;
        b=Ft0qMpZGU9No1lDtNY6m+QEK9VUB3iCBlXDau5eoyGUjPfc6s69wYnViDKOvrtDhts
         4cteyZ0It7eEa6xzoND8JiNqN5EYI1zb+xyCXMFw7oyiXZJ0e159qI4flnyp2Dpvbz+y
         8Jle660pX/0lAxvng8Eu5kDc0+bfz5sKol1pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711837944; x=1712442744;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qh7m7AzKE9zxgcmaZLpWEMMQFO2AQlI5WB3LlhW1I44=;
        b=uZmImrQm4SXmB4TGEPq6ym/UA6jvFxlgSXbMIKHTQVoQqvCDseXzwofmEjZxeVWfr0
         RmmwII87VGcrVcg5phUdT61OqKJ3Dh+Gayrz33zHX6Ugibm+GO5Jy7nC5J59qlKgTKQf
         9Cs0nUOXu1S23BaIJosIZ9YYHQtVLmMIP4WQfFO56z1SE6CD2gC/bonXNAuNUKzDCuax
         M4g3+HL/ntOHMsUNsYdMyABFT6G8QsMFk/UxGNR2Zd+lsDwJrzTNJnaewJKbisJYh8bG
         CBzUWfbPYkg01nrkC5UFEEk2X3RoHLBJG1rr4ysiJeLw0GMRk54vwfhnZV2v1dgeKHCx
         C2jA==
X-Forwarded-Encrypted: i=1; AJvYcCUuVQmvY1BwcxrjP8H0/75gCxQ7lKo8TuNGlm7WELoi4u7J7RAWgtvZWCtEdmrKIeEI1C7c/fGSinspzbwL7ySN1biFYsqCoUaQeXCrIHIT
X-Gm-Message-State: AOJu0Yxp/DCle32m4JiHC9otGM3q4ILwif76fmNNLgMLqWmSZGXWpLKX
	B0Q2HdJNdv6vb7RTo8So92b/OAsDax3QyA98AuZho2PhzJ9UzILcjiWSGR4ZbpNEd2288/bZgC6
	bt34=
X-Google-Smtp-Source: AGHT+IGOyEhgzCD6hStCWiW90Il43XMZJqHYg0axotlYQOfmgrYCJlgNa3hx1mxFCKCACeAnBfCLJw==
X-Received: by 2002:a19:7608:0:b0:516:9fbe:3b93 with SMTP id c8-20020a197608000000b005169fbe3b93mr1288057lff.15.1711837943849;
        Sat, 30 Mar 2024 15:32:23 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id q17-20020a0565123a9100b00515d1c97053sm583003lfu.223.2024.03.30.15.32.22
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 15:32:22 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-513cf9bacf1so3629194e87.0
        for <linux-integrity@vger.kernel.org>; Sat, 30 Mar 2024 15:32:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2iJfF/X6OT9o9TIB4Cw+ThgSRe/NcYyRs39xDY3xK2l4im/VgE4JYRUrlcuWqk9cDi7cgFjGyYs8hRX94YLqXE+ybXwUvZw0hynTXSXJ1
X-Received: by 2002:a19:5517:0:b0:515:90e5:4555 with SMTP id
 n23-20020a195517000000b0051590e54555mr3507469lfe.16.1711837942133; Sat, 30
 Mar 2024 15:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326143838.15076-1-jarkko@kernel.org>
In-Reply-To: <20240326143838.15076-1-jarkko@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 30 Mar 2024 15:32:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNpPQFJyLe5dwEVH66ubviuiwM1_tjbyzQv4BytPw7dQ@mail.gmail.com>
Message-ID: <CAHk-=wgNpPQFJyLe5dwEVH66ubviuiwM1_tjbyzQv4BytPw7dQ@mail.gmail.com>
Subject: Re: [GIT PULL] tpmdd changes for v6.9-rc2
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	keyrings@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Mar 2024 at 07:38, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.9-rc2

So I haven't pulled this, because the subject line (and tag name)
talks about tpmdd, but this is clearly about key handling.

Also, the actual contents seem to be very much an "update", not fixes.
And it doesn't seem to be an actual improvement, in how it now does
things from interrupts. That seems to be going backward rather than
forward.

            Linus

