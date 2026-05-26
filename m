Return-Path: <linux-integrity+bounces-9683-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAmEEojkFWrdeAcAu9opvQ
	(envelope-from <linux-integrity+bounces-9683-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 20:20:56 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2235DB457
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 20:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E3733010F25
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 18:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DFC4218BA;
	Tue, 26 May 2026 18:20:38 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE764218A5
	for <linux-integrity@vger.kernel.org>; Tue, 26 May 2026 18:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779819638; cv=none; b=gq9LMct+nhA3NkVruFDerw6sj6mzigReCEXCI2RimR9ChK2jMutCXb7UNxQYqAoOr5//+Zsutmec/IeEgKGe45ZWrfFHw8TaEYdsfUszKhbzTThpGFaKx1kWpBIbcSnAz1c4T11al+ZFjJTbVG7Po8G5HCrjymOfSd4j8QQONEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779819638; c=relaxed/simple;
	bh=I4ytr2AWirUEzmeLuOnc/4U0/hxql28G8RhQSyhu0CI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tqr7hRW60tkY2VMr/wTPjyqB89ggGzGlVAK716vfhh+Bl7hfTYHleBm60/VOpj300Cw14tvFFZh2nvoUr5K+dGHLlMjgjFax5dKgEA2k1S5V7+Y09JJtjhh9iFSg9yc6utDBqiClQ97D4MpjARgfzHk6DcXCA9uW7Q5Kxstmgxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso52523095e9.3
        for <linux-integrity@vger.kernel.org>; Tue, 26 May 2026 11:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779819633; x=1780424433;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MHH3yPE1r4W1hBBuLJyFdGXQJe8rCYCaC0Nwz7rJsCs=;
        b=bmxxapsYledc+2RaMHLCL36ipnUKmDGb+tYhHZ9QqOkRHOvb3EHLpU28m0Z5coirw8
         XBk1Rp5lqk6uIipYF7WkdeWRHVKIssaG4s3ApimZFO3rWDu4TaolwTX2V7hbGHF8MdjB
         TRlS6DK9HkapHXWp8pdexIzwThaVE8N79eTMjJeS8ZP49dh09EdYtBaRn/gE7ge8nvJ5
         L8amcJQaxijVfu2m2UbbkXBPtGcIODVopyW1HnMln9Ih6OdaDcjVWdB7PkAfQwRvW7dB
         JylEAsQFf5EEG1c/X5YLsWtiEs2ojQ9lKPrM61OAED/S9U2WN1EIttIb0AteLQo7Ibbr
         9yGg==
X-Forwarded-Encrypted: i=1; AFNElJ9KP9pPp06hhcM6UFVRHJCLUrXywexft+kjbmmsq49jRdAU/gLTUqtXdLe1T0OqMGWywiPb2kGR7Axb0IH+PXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZL0dAvb5MPI4/nE3AdioCsommkYEeQQWFCXO8s/S9xgH9bRUa
	TjDjOlQtHue5XvT6PKBbK5LYfDLrOZ2P0y8gPHwtKHmImY8Czs2JaPCJ
X-Gm-Gg: Acq92OGWgx4PsiliAu3B5Adc7obToqnC3YOqZrj8uA8sxTsyAty/p9H88Bl02mppe9c
	8Jsww38KfbDclwScDeNAJtjWclAbZj1l9DdUDSiVvG1ttQ8vhkcNXB/gcI60O1DXcb+8wh9pRB8
	iq8/dLm2jLeW1FRgdZ2c3rtM6Hwd3xf8BwKGAy9iaHqD4RheAk8ssY1ERiigBxhudlohoEqo4Ie
	3/puHVPEPC7lrjstjSbQ4TnvYmjzzL4XCTiJ9uUwl/x6nsvAXc8hqR4kSYlPIh20mAwj5wJcnVR
	rP+3k5T437BJXbBcclHCzOsuJB9VM8BMqppxarqxxTWr+4ubWgsLdZJpcmt+BJR4N9QfzzHPFLx
	+kGyTvbhhh/1/FsyGw6VZUAoMLLLUHTzpcyV/Avyck0p0jNBYcKZox5OSZ6SJLK5wcXxqBIMJmR
	oEgwgRJhuoZdseX7Ar2sIdBfUm1pFxPITiEmCKfnQnm52VfaA=
X-Received: by 2002:a05:600c:444b:b0:490:b07:5fd1 with SMTP id 5b1f17b1804b1-490424aa00fmr304755965e9.11.1779819633114;
        Tue, 26 May 2026 11:20:33 -0700 (PDT)
Received: from gmail.com ([62.197.47.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb9asm40641882f8f.27.2026.05.26.11.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 11:20:32 -0700 (PDT)
Date: Tue, 26 May 2026 19:20:31 +0100
From: Breno Leitao <leitao@debian.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, noodles@fb.com, 
	James.Bottomley@hansenpartnership.com, kernel-team@meta.com
Subject: Re: [PATCH] tpm: cap tpm_buf_append() at TPM_BUFSIZE, not PAGE_SIZE
Message-ID: <ahXijb7wF6BKrT9d@gmail.com>
References: <20260524-tpm-v1-1-2420a5977da6@debian.org>
 <ahOItgfj4k-NLAPa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahOItgfj4k-NLAPa@kernel.org>
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[debian.org : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,vger.kernel.org,fb.com,hansenpartnership.com,meta.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9683-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-integrity@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4F2235DB457
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Jarkko,

On Mon, May 25, 2026 at 02:24:38AM +0000, Jarkko Sakkinen wrote:
> On Sun, May 24, 2026 at 10:01:17AM -0400, Breno Leitao wrote:
> > tpm_buf_append() guards against overflow of the underlying buffer by
> > comparing the running length against PAGE_SIZE. Every other site in the
> > TPM core uses TPM_BUFSIZE (4096) as the protocol-level cap on TPM
> > command and response sizes.
> > 
> > On 4K-page kernels PAGE_SIZE == TPM_BUFSIZE, so the two caps coincide
> > and the inconsistency is invisible. On kernels with a larger base page
> > size, e.g. CONFIG_ARM64_64K_PAGES=y or 16K pages, PAGE_SIZE exceeds
> > TPM_BUFSIZE.
> > 
> > This is a latent bug rather than user-visible bug, given most of the
> > cases PAGE_SIZE = 4096. The mismatch is still worth fixing because
> > future callers (e.g. the proposed TPM_BUFSIZE increase to 8 KiB, and the
> > Secure Launch tpm_buf rework) rely on the overflow flag being
> > authoritative.
> > 
> > Use TPM_BUFSIZE instead of PAGE_SIZE so the append-time check
> > matches the transmit-time cap on every page size.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Fixes: a74f8b36352e ("tpm: introduce tpm_buf")
> > ---
> 
> There is no bug w/o a sympton of some sort. Not sure what the problem is here.

Sorry, there is no current problem in here, but there is inconsistency.

There isn't a real problem today, just an inconsistency and what I
called a latent bug, let me justify myself.

Everywhere else in the TPM core uses TPM_BUFSIZE as the protocol cap,
but this particular site uses PAGE_SIZE instead. Since PAGE_SIZE >=
TPM_BUFSIZE, it doesn't cause any issue at the moment.

That said, I still think the change is worthwhile for two reasons:

1. Consistency with the rest of the TPM core.
2. Decoupling TPM_BUFSIZE from PAGE_SIZE, so that if TPM_BUFSIZE ever
   grows beyond PAGE_SIZE[1], this code won't silently break. That's what I
   was referring to as a "latent bug" — though admittedly that phrasing
   was probably too strong.

Link: https://lore.kernel.org/all/20260518151724.730443-6-armenon@redhat.com/ [1]

Thanks for the review,
--breno




