Return-Path: <linux-integrity+bounces-8139-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA526CE486E
	for <lists+linux-integrity@lfdr.de>; Sun, 28 Dec 2025 04:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 830333008E9C
	for <lists+linux-integrity@lfdr.de>; Sun, 28 Dec 2025 03:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7339F8287E;
	Sun, 28 Dec 2025 03:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="csensrfK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B832C1096F
	for <linux-integrity@vger.kernel.org>; Sun, 28 Dec 2025 03:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766891810; cv=none; b=otTwUzBPJudsVA4bjh1s1a0LWJgLPwXoii5dMFMeIM7HZdzPb1nh1O2zMF3oF+v6Ps7zNoiM2Nt+/6NF8JCUzAO/2WN7WZB9I6c3Q271BQ+kAnNmIsFTaGRLzyELJdJUvdaGmFrEh26CMmvpj0pyXtqezv7gCNnIdJjHMQMlN6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766891810; c=relaxed/simple;
	bh=D1B/8qGaIULiyrWZIU7ksue6i2ruRWEPGXnLBNYaHYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pe9NuN5j/qdSS8nr2AxwyvPzZUubgUlymbWnr38Ay/D2uFD8w4DPK0jksOzAzW8OnLWqs0ukIcVbs2pZ6UjA2q/BZWMpt2jFHxVuqm4NvfP4GWz9zJpd8uD8rCB1vwHJKVfoo+glQ+6UTGbWUkPgMIfVTaV/pdcmHyrNn/3WCxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=csensrfK; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79018a412edso12165517b3.0
        for <linux-integrity@vger.kernel.org>; Sat, 27 Dec 2025 19:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1766891808; x=1767496608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dcfnVkad9dNalZK5dHkAImODCCJ6qAXWtwQcj5QBYRw=;
        b=csensrfKIjE+PjRi4xUdwBQsVW32ewX8MGM3S2PyiaKc/li8w5/QEvXP8mcLJGcm5Q
         kmJoe3glggjFQbFE57oRyArHuSsp3u9MEIuYBLJefVGfmoWfkhlC76/a8JY3YGYTam17
         2akpp8b1l6smLC8n3LrtMrH7ssPatv4wAn4ccJ33oagPAIMj38O7Z6d3kmv0WnBAhNGn
         hOB1i4NQsUftPdBICWTntAe6J4AKUqRMtjUoXy2WE0U8OLKH2t+8Hgh743vUNeSYnBar
         KlVZTiysmVvD5K2I6Xrbyicl5ehp5L8k+1E3B07i5hLKxlZg9Ze8yRuZVz9c8yEgRi05
         ZUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766891808; x=1767496608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcfnVkad9dNalZK5dHkAImODCCJ6qAXWtwQcj5QBYRw=;
        b=LmzRLRoMeZRmfqpS+KSkmLAntfBoUU2UyaHuu5Dhb+Cfhdn7AZejul9+vFCSYH8tmf
         yg81WHW/Xt7CEao5Esvpn9115qR5gB5IOLnXsYGUO7VjC+GqMd9rX3GrBmlnlpDsiyzA
         IbkJPox/kF48hyT5GI4gErbL1AQeADQD2AX6zW+14wbduURIcqOGquNJe0/JlcaW9tyu
         ZPxpcofGqd5bHC/wV3kLGrpytGAMxPCfyrwIIFYf87u0KJmPiCsjSa6OKh6wBP0cB++6
         CN9OzMYNPIK3S/7P6eEMT8chOlool0TbWRHIJCGk3xROU+XJquRyd+2ooiBcGFAwAhMX
         fe9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4q81knfFgb6BxMaOQvueEXtswUGnsbH+T4TdD6KcTXbFnqEya72EILXZuATUp7LIyIGqY7l6miDPJj2P46Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjZTIeeR1uaY0g6nh3yXG7BsfQ8bFC3+lpfXev2+vwHZCipH2M
	GcrF8wAK5zzd4dfoR+zrGGQe5upW7aKK2GSi3nkqow2BLpk8NXWSkpdvA4LVFhTmsrc=
X-Gm-Gg: AY/fxX4fSwgTDdqGlPeXxb9xHhcCKMtfLqxvJ9YyK63gjyCg13UkdY9bcBhT8tcLDIk
	yawAN+WGsakK6e9Z1plFkOxczvBPF+LNsrQnYmTYBm7iteL3vp1B+6eEv6nBFxuyf0Otf1iIUhx
	VIBLg8nrpZSi5k/QKx7X5V/oqCf0mU5rc/25knRIdgAXraIlG6h4iaeNnHPlc1yF4cf6DXoTtP0
	s+yOp01XSAUF3dqGhOeuCnLt/IbVqBUzUXSQb/qWSDIE5syC71bP/YzK3v151+CVNOkNbvRfYje
	kVlYF0HGYBNwGsMkg3k2LbA2SP1ARBS/nif9Barmz7/mOAsLIbpjQvkUGonkZlfv7Rq9qq3y64S
	1M5WPFV4Bmf/h1ZspnkmYTviFvw/XJpyS3r4AuGHNWjaAmnGsr+ezwUZtJlDuCUSN4RbD
X-Google-Smtp-Source: AGHT+IH69knnQP2R2Roi5tRt4UtkALVf5KehNg9TwvQPoK1c5m2Uq1ktnZ6i74jJJapPSNUswT/RaA==
X-Received: by 2002:a05:690c:48c8:b0:788:20ec:aeda with SMTP id 00721157ae682-78fb40b0a83mr229397877b3.68.1766891807785;
        Sat, 27 Dec 2025 19:16:47 -0800 (PST)
Received: from 861G6M3 ([2a09:bac1:76a0:780::5e:1f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb416b32csm102409507b3.0.2025.12.27.19.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 19:16:46 -0800 (PST)
Date: Sat, 27 Dec 2025 21:16:43 -0600
From: Chris Arges <carges@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: roberto.sassu@huawei.com, kernel-team@cloudflare.com,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Kees Cook <kees@kernel.org>, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ima: Fix stack-out-of-bounds in
 is_bprm_creds_for_exec()
Message-ID: <aVChG8bjcAqOBEJi@861G6M3>
References: <20251219195456.912190-1-carges@cloudflare.com>
 <20251221180128.1026760-1-carges@cloudflare.com>
 <3aeed1ff9388f09555bf5c6ade03cbe9ce93ff14.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aeed1ff9388f09555bf5c6ade03cbe9ce93ff14.camel@linux.ibm.com>

On 2025-12-23 16:58:26, Mimi Zohar wrote:
> Hi Chris,
> 
> On Sun, 2025-12-21 at 12:01 -0600, Chris J Arges wrote:
> > KASAN reported a stack-out-of-bounds access in ima_appraise_measurement
> > from is_bprm_creds_for_exec:
> > 
> > BUG: KASAN: stack-out-of-bounds in ima_appraise_measurement+0x12dc/0x16a0
> >  Read of size 1 at addr ffffc9000160f940 by task sudo/550
> > The buggy address belongs to stack of task sudo/550
> > and is located at offset 24 in frame:
> >   ima_appraise_measurement+0x0/0x16a0
> > This frame has 2 objects:
> >   [48, 56) 'file'
> >   [80, 148) 'hash'
> > 
> > This is caused by using container_of on the *file pointer. This offset
> > calculation is what triggers the stack-out-of-bounds error.
> > 
> > In order to fix this, pass in a bprm_is_check boolean which can be set
> > depending on how process_measurement is called. If the caller has a
> > linux_binprm pointer and the function is BPRM_CHECK we can determine
> > is_check and set it then. Otherwise set it to false.
> > 
> > Fixes: 95b3cdafd7cb7 ("ima: instantiate the bprm_creds_for_exec() hook")
> > 
> > Signed-off-by: Chris J Arges <carges@cloudflare.com>
> 
> Thank you!  I'd appreciate your limiting the line lengths to 80 chars (e.g.
> scripts/checkpatch.pl --max-line-length=80).
> 
> -- 
> thanks,
> 
> Mimi

Sure thing, I'll make that adjustment and send v3.
--chris

