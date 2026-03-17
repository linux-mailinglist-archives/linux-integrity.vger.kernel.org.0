Return-Path: <linux-integrity+bounces-9005-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBSJKzxkuWlsCwIAu9opvQ
	(envelope-from <linux-integrity+bounces-9005-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 15:25:00 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 393FB2ABD85
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 15:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47404315E475
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 14:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFB43E6DE4;
	Tue, 17 Mar 2026 14:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmSHWHx9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4271B3ED106
	for <linux-integrity@vger.kernel.org>; Tue, 17 Mar 2026 14:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756844; cv=pass; b=VEvdSk5T35JOa4Z++6Z3Pw0PGPm1F2MyxFBh0Om9vHMjoxksEY/6eqs+0w+DNJAiFPCb3vgPf4qCknKPeg5GAbpo3/qR/hjiuTgWqAWjBZF9C11SF6CQdm40c2kForhQmVuV8bBWUmaGV5cu120/bNuY36e3zojltkBfh4B+FSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756844; c=relaxed/simple;
	bh=EdqnQ/ee9hXi08kIYDisfAokTsXv/oY+z6ZTg1VNQQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWtdeaWM304U6ULg/6zQUEgc3YbjO5+/gIXSnLh1Fn0iRVk/EQcSWKIRR8v547DhCs3FMdnC2FEPlBCoOhHuvOkY+bO6gc0PcJ2DKcMMTQzE8tQP4NlnbZBA68wb3ycuY2dHhbfa/mnTga8tXC3hc0ab8JekUFZbKDuDzXXVxbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmSHWHx9; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12732165d1eso7526633c88.1
        for <linux-integrity@vger.kernel.org>; Tue, 17 Mar 2026 07:14:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773756842; cv=none;
        d=google.com; s=arc-20240605;
        b=DnFxC8JmPTh52D8Pa5TJdS7GwXJcDGZLGkSxiCo3GtiBdiJwTqRpQI42uFnqb5hB80
         mGGh7MRNDAteJMKR+ehrK8lp3bHMNToHTRjLUPmb54bu1qKeYXQfSDP7qXzA7a6SVO44
         8MAHPR1VvbHFmDo0pBbhv8E73zGx6p9ZRLSBUlxINSDCps0GlGOOG/q8u8oKTlK5/s1o
         i1cC5i09n5M+8dYrBcgil7IytukaCSKyFjEcS1GG486G924uDHBhr3LiO+mh4xLjF6xQ
         Ph+C5M7YF8YoNbDX5K2hnP7n1Ia4++v9k37N9hLh8uM+MBXI82SSKixxD7NLV3jiI1RA
         pZLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xn/itZbZbF5nwf/139mTUaS6349g0FmeD4vfOEoMPrU=;
        fh=uZDhXECgK8gpkAatwFNzDwNYftBE+gb4Iw1Ktw2DaGg=;
        b=QTwZcHRnhQP2iqAVRPhvKbVDVDfbk10CWbhP6h497JFKNZpZg5L4Yr8IUG431wXBKD
         tF8qgqR7NbHvYJVp0d5zHxGSTvokPliptuCHCsQuzvr4uNkowRvq+MrviGzFg9CstWBt
         S+8O2pPincUrFh9iyb3lP/mxKk5xnAySRxFrhA/oUaRr+n+bJ/FzvojwBPP1mKeIKAcs
         PxEm1szPHpIR0jXJhPIIxk2osiXQxCTTowFgKVHlzTJlLeSk5SobD/ZY8gTI3T1tV1zZ
         sHYGH9ImQR5GudDIsCFl6AyD93UodtYcUDaUzgwiToOfgx030rmxzR/kxwo8eGLTKgBv
         JLPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773756842; x=1774361642; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xn/itZbZbF5nwf/139mTUaS6349g0FmeD4vfOEoMPrU=;
        b=fmSHWHx9dXPAErt44YRpyvkLs8p4i3xNZnFGfcK4gzr/8x7XQFyJYPvrlWkMbE7Bb8
         QktYlpBuV8fCv5QYq4xuEcJ3GjSAlLURXw3j9A4l8RxSJ5b9axEzi+zs4chvMG70ucCO
         dm/SIroG2d3RbfaOKAfYbmbGbjRHG/LCvikZpLi+5h/M5fFim2qjhuGETWVH24RWVbQP
         iqOfF71+P4fNb8dSOge+OkjE6sUXwFR00xQpuY12e3wti5bO/d+fhaLH2Jee+tlA0q4Z
         ZXHF6oqZ6w2HflphSxZBZKXQIxPOtqc/WOlPHD9mNHGqfNYkXwX8wH4QpqqAaE0g0c7u
         m4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773756842; x=1774361642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xn/itZbZbF5nwf/139mTUaS6349g0FmeD4vfOEoMPrU=;
        b=qyCf35y3as1+z8Sr5fVC6Zeivun2dnYvcgj+sc2kin2Rt6XKVwbkjjHTVqm5xBvISt
         HWuvZPCk268s8m3cmmRmHFU6ew+wEVub51AsZOkb5Cep9GJL6pv1a5TtQmdg1BCDMbmS
         d37IzSGYZT0yRPQU4HLrkU2q7WgPCAQQNpGgboxwCk2lX3P2BtH3Ol6eWnqJHPnKKuU6
         MGFDfqS4gtO+e3KnlsICMxxyAH4DvRBfjBSA12cuymoG7Zlbeaa1fM0mRtdiX4VvnA6F
         v1LyVO3x9+apiOCQn7fv3GlxBdFK5TL9g15vXiqb4L72Ew5pQ4NeDF+1lZMIOVc9UQPy
         j0YA==
X-Forwarded-Encrypted: i=1; AJvYcCXynV/odJdFondLXD90DETJeH1IS69k4qGS3FcKl4+yIvWGFjwnMHUEht+YvGA7CFabL1HqHWVsJnujXwuIca4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz54jSXxQkVsn50tViN3waGpeYz6RQG3Y6RvuP8jGKMBlg1tlBR
	Rr/YwZLUZeIs8cdHAwIl9rkYBKs9bcP8nJYhPZ0ppkSKK8pVsbexygDe8yu2ztLxvV5JX4mhXUn
	TKWTqp9LdGxhwg3CZUyudXaEpisC5a+o=
X-Gm-Gg: ATEYQzySRXJR9sibrlO40lStQ+qYoe3DCktvw7FEOw5CO62kqJLJofIRhdcc7sFjKfc
	QFlbySxC+prefXf4W8XWpT/A+MwYN5AvVXbt7E+zaJFurTsammH5zmc55bHMYMcxxpfFrtsjjXD
	3D+l9VtXJS1WLBvZObeQ9I0uk9movIy4E8/F57hyty8olPracPhlCzKi2beb4o3djRcncdtuyT3
	o7caTMEDt3/q3bRK9O2ofhz3XOyfu99u+3VIWoHfu0crIHMqGscjiQiBWEEV7LfDDfSsoan1pvC
	YiGWS/LHdm/bjD4VnaveFM0HjyauaB+CFhNermklnOLfZk5W1AA=
X-Received: by 2002:a05:7022:51b:b0:128:d2d1:8a5c with SMTP id
 a92af1059eb24-128f3d4681fmr6943205c88.19.1773756842325; Tue, 17 Mar 2026
 07:14:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312053933.53012-1-ebiggers@kernel.org> <1c5f16f0913bae48bf2f24feaaaf3525ecdf4c97.camel@linux.ibm.com>
 <20260314182501.GA40504@quark>
In-Reply-To: <20260314182501.GA40504@quark>
From: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Tue, 17 Mar 2026 16:13:49 +0200
X-Gm-Features: AaiRm50EY-Jww0f9BnxQWlTlgvfUmiFvfTcAZE0nG1rtFf2YfTEdbV6WxDtjKlU
Message-ID: <CACE9dm9mZmPMYF7Soeo+ACgmQ-zH_JCaV1jyL8drZEZMq8cCtA@mail.gmail.com>
Subject: Re: [PATCH] ima: remove buggy support for asynchronous hashes
To: Eric Biggers <ebiggers@kernel.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9005-lists,linux-integrity=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrykasatkin@gmail.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 393FB2ABD85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 14 Mar 2026 at 20:25, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Thu, Mar 12, 2026 at 07:29:05PM -0400, Mimi Zohar wrote:
> > On Wed, 2026-03-11 at 22:39 -0700, Eric Biggers wrote:
> > > IMA computes hashes using the crypto_shash or crypto_ahash API.  The
> > > latter is used only when ima.ahash_minsize is set on the command line,
> > > and its purpose is ostensibly to make the hash computation faster.
> > >
> > > However, going off the CPU to a crypto engine and back again is actually
> > > quite slow, especially compared with the acceleration that is built into
> > > modern CPUs and the kernel now enables by default for most algorithms.
> > > Typical performance results for SHA-256 on a modern platform can be
> > > found at https://lore.kernel.org/linux-crypto/20250615184638.GA1480@sol/
> > >
> > > Partly for this reason, several other kernel subsystems have already
> > > dropped support for the crypto_ahash API.
> >
> > The performance benefit was the ability of reading and filling a buffer from
> > disk, which was slow, while the other buffer was sent to the crypto engine.
>
> On normal filesystems, sequential reads from a file already kick off
> async readahead.  So the hashing and disk reads can already happen
> concurrently anyway.
>
> - Eric

I think this is fine. It was developed to be used on OMAP processors a
long time ago.
It can go away..

Ack

