Return-Path: <linux-integrity+bounces-9238-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELoGL6BO5WmVgwEAu9opvQ
	(envelope-from <linux-integrity+bounces-9238-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Apr 2026 23:52:32 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23526425998
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Apr 2026 23:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FC8E300B471
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Apr 2026 21:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF6E2D3725;
	Sun, 19 Apr 2026 21:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MXJRmn3L"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698074400
	for <linux-integrity@vger.kernel.org>; Sun, 19 Apr 2026 21:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776635548; cv=none; b=jTVGnVito9NjuCChuQE5geJ6UcwxM/BrYZmDgOlSNeebBExkFT7KN4NUIZ7THx2uzcQJpUqtwZ9wVmdVS2IlZXEFYKEslLNz+hkYYjVTFSGvecwbTqWfPuossUOrXSOOB652JlWV0yCXZYjqqdSc1RwVxZZdTbF2otb9Zl5qLoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776635548; c=relaxed/simple;
	bh=CELBaovFracc44SNoSxFbtNzebiD4I6r4kbORD96oiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FtyFEKuTX/8qjuWMx6/anwruypmmuz3wPbMQc7Ck6a9MH4NezzUDZtMBjcrk9mEVA3bANmZbnz6bUOq+90CHJ/LZpr74kwrllLuVhREtrLcU5H0zAOAUcepqjdBo4b54XymxSh7rAPMLKrfA5cXHtuXtNrLsUpiICkDBpDSoo1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MXJRmn3L; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8f97c626aaso374340266b.2
        for <linux-integrity@vger.kernel.org>; Sun, 19 Apr 2026 14:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1776635545; x=1777240345; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VD5DcV46JWd7qyXcKhw0Tc1Gqb7giDqKcHIzejffB5E=;
        b=MXJRmn3LzoFuVkGZa64KscT7UV4R0mvicfcl+7AmJX6XWbcez4St0exE02g3fp/+VO
         fMWJg6GV9NhpQGkIlNhmzjVfLvidd1zOpI3W9iwwJmunpfCQFcgyll1994y9xi3FrRSc
         3FH4D7UZ3psyZD7dO+6IUi/zkxlFh//Bw/ZPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776635545; x=1777240345;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VD5DcV46JWd7qyXcKhw0Tc1Gqb7giDqKcHIzejffB5E=;
        b=gLH8XzQOBzZVnuq+P1jlKGLOo9noQD/kR/PIM4BLePeV0k/CzpxUBCnigyRjhdsikR
         K5M70JAsWexk8ECWKPF6w/l2JHr8p60rCruXROlIHJu8DslS/1WuLnAntiGOu9+5+tMA
         EErAxloMIp8ycMTRNOwFWbDpkfVAnN+AK26PfTzm7H6C0VVV+5wvy4cMrHgoetOgGP40
         qvu277WcmT2ATeVfBFQgDIzVz2qa7GyfzlFC15i7nchy0ViNuKn6XQI3scAKc57rwj41
         63BDiIz9IRnnWJ5JT/bRrFZEhhpoVsQp7rlwaW0mKEjPD8ei+GIwNJcKdQbTjHlFtnWG
         PDYA==
X-Forwarded-Encrypted: i=1; AFNElJ/xDuFX13Evr4vPJ/ekDAvFlwMjqJP1twz8Prt0MYL52JpQ35DxY//aqXELd6/AxwcIWLHlFbzN/p1wfZ3PZCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYoYRkKNY57XdttcCzNYm8NS2OOoKOuV2rjUj3BJyoEXhnYdSp
	HdX0xSa2E9h4ScK+awj8ED5wYqjwUNNZrS83UlVr8zr+N6hb6DuHNi8XSmezBP/skdSHHdKCF4e
	oYRdcMTg=
X-Gm-Gg: AeBDieteMpBIF6zQW4dbWAo+CSadBecyj69I+l7yo3SBVanUbbiKZ6t7jXnK2Twm8J1
	OTCc0f40X/oNV6QwFpWKlwd1tYMa4V4NCbm9ayG1evq2b04AVI5rOe/PdW5q1NMUovJxBZFE5x0
	yVG7mWLwLHdf1XytRA0uiu4QCZB2iAXfcNfPTLGLxLfygw5K+nnfIa/sx09d8MZft8CIxkVEowX
	kLeODpbZhQcGO4BX61I0+MvekTGqh+wpxp2K2iVuRiD5vrlkmsO8druapP90aMXLEh7FU51aVSW
	7CSEs9Ykz1AdGimCPo8EY2EDJ0Vg3nvvE2fVK4zlvEpDstT6nVrtDh4Z5ao3vPoWwA8tp/ojG8b
	Ar539OousVPwBouKYVEt8bPGoa253nKa6ZfDzeraA8Cyy7oV0SWCUF4+/QB1orh7pKQzEc2eAX/
	dJku1yiW7Cy+u1KH3bn7Si+YUx0McOdNSD0ZFZ+KRFowjx5hiYhs9Lm3By0jYzP1EsJMnCsM2o3
	kx5DYRhHbg=
X-Received: by 2002:a17:907:961b:b0:b9d:33b5:6ba1 with SMTP id a640c23a62f3a-ba41c1b6fbdmr490788766b.15.1776635545443;
        Sun, 19 Apr 2026 14:52:25 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba454d1bf61sm284033566b.40.2026.04.19.14.52.24
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 14:52:25 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6714fa8b955so4364722a12.0
        for <linux-integrity@vger.kernel.org>; Sun, 19 Apr 2026 14:52:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ86BCPrKQ3SifRePtZYSd5Hf9gtyn56Yi2fFvfkYzBa6sSERF+KYdfgnnhXpcHYS+jIT5R4LGBVcU3taMW0ljs=@vger.kernel.org
X-Received: by 2002:a05:6402:50c7:b0:674:bf55:6f40 with SMTP id
 4fb4d7f45d1cf-674bf557015mr1186535a12.26.1776635544304; Sun, 19 Apr 2026
 14:52:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aeTLzOgblMZRnDvF@kernel.org> <CAHk-=whjUfVy22QCcsCS2h8AkJVpQBjHyVW4_hKXpUxHn9S65w@mail.gmail.com>
 <aeVLPLa8JDLIEgDR@kernel.org>
In-Reply-To: <aeVLPLa8JDLIEgDR@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 19 Apr 2026 14:52:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjaGOBCsRpEhmPLcsuK6ggiaaeyz0rT6x3Zv7DMK7JNHA@mail.gmail.com>
X-Gm-Features: AQROBzCPZsvrw8UMZDVeqzWPc0XV4E0MHK0xN9XYvfTxGZMeyn0Y4OGkvbg9Y3I
Message-ID: <CAHk-=wjaGOBCsRpEhmPLcsuK6ggiaaeyz0rT6x3Zv7DMK7JNHA@mail.gmail.com>
Subject: Re: [GIT PULL] KEYS: keys-next-7.1-rc1
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org, 
	linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9238-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 23526425998
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 19 Apr 2026 at 14:38, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> I tested both PRs for the same baseline with two separate buildroot builds of

You threw away any and all testing that had been done by anybody else
in linux-next.

And you rebased things on top of a random commit-of-the-day during the
merge window, when things are possibly unstable due to all the *other*
churn going on.

In other words, you did *EVERYTHING* that you shouldn't be doing, and
that the documentation tells you not to do.

The WHOLE POINT of being in linux-next and being ready when the merge
window opens is gone. All for apparently nothing.

Those stable cc tags do not add *any* value, since you could just have
cc'd stable later instead.

I'm not pulling this. You need to stop doing this pointless churn, and
read the docs on rebasing. See

   Documentation/maintainer/rebasing-and-merging.rst

about how you are *not* supposed to randomly just rebase, and
_particularly_ not rebase on top of some random state during the merge
window.

          Linus

