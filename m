Return-Path: <linux-integrity+bounces-7182-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2EDB86C50
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 21:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6C94164C67
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 19:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BC42EA483;
	Thu, 18 Sep 2025 19:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qtlC/w5o"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5E32EBDC0
	for <linux-integrity@vger.kernel.org>; Thu, 18 Sep 2025 19:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758225078; cv=none; b=SzRcGcju9CU7M08pj4a82Rh5tGW4O8THkyH7e0bkw/Y7pXdIDTvvPbmVsmbcB7VfB8FZLJ2mBVDCPBjmMCbnHRRfrojGNntm1NnNCbPQP2hXzLwXS1PeOBANjIm7skp/5B7X9m4pxQl8HmlZP/QvKDrmNg2FRGHC+RvRRTxaN00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758225078; c=relaxed/simple;
	bh=6syJdSpwOuKgxvfK6CJQXA1mo4R5z+GK0PPQjQL52Qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+VVgR8l5VI7cJKEnb+9OFMHXRowIF7LeO2Vq6r7yPuvU6H35pLmmeGgYIC2yOm02lj1YwuacJjp9bD57U/n2/c2dKxWpzYcnBDQipYpKZzaBEjl+ismRgkgBnQQduidlYN7sL3dAEFmPcu0H4SdSYnY7CPWE5lRnPE0YIoHzW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qtlC/w5o; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-80e2c52703bso134856685a.1
        for <linux-integrity@vger.kernel.org>; Thu, 18 Sep 2025 12:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758225076; x=1758829876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8krst8IwRhvi5nQ0njnzXjVOua4V4UJe+k0j+3GNts=;
        b=qtlC/w5o7oqOt5KSb8eVYY1qgdu3W7fm5pAqzP3WjBB5U7exzjiIZcbYBt0mm2kOxZ
         OIOV3SMCZF5x+Clo7Oafwv8CnJbMP2DICBWQuuv4WUo4My17i5uejgr7oqOl31kV6inJ
         1lEps0ZL4zreN8RteZmoMCipGv2TFW4VokO7tHk2Y5pPOSWq7DvlVVsHfsN9hW12BxTQ
         Ing7kEhgkMvZPosbxf75UJWJjWBbLlfRwtDNQGabgqrvmjNfFwEyD9ivpQA91ZqHuUI0
         DR5pTEkkFys3awuuAmviJb5LI0z4KBQPjaVmX1vex08ieXfUDxD+8YpBIC6Eqm5luwTJ
         wvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758225076; x=1758829876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8krst8IwRhvi5nQ0njnzXjVOua4V4UJe+k0j+3GNts=;
        b=ITXHJmrZN1++oZaiKCj8OiwXQl/XXGwkELL+Gj3somxXZpRfn2NR/W0ZSQ0hFgIf/Y
         F7FVQdglgGfUXT+nnBhN78A75RdCOKFIpPaZP6cYGkxtJL4vVRLQ7409wgFQ5Jon8bAX
         cH3fNpSJehakblOLl3K6V2HrItId5kTPM+FsWkKnYvIbptRSB65CFcpxUmdDW9r+mtf7
         e1JJb1nOpETNJm8tzocy+AocezI3BPN1zon67Iov4JSQY5y8HErGSv0r5DxEF8rwTEg7
         v9xGfuOoJXgScidH1M7s1xqIYg7KzH5VRwu2PhVMilXYg5sAgWZgZoFCZQfBmY42zIn6
         KA2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXwKfeEs++EywYwvaQX1NMSVBSbnQoIjvtttEWyi0WImcmS8EKOgAflJMOoYIxcgJtDgUW3LJRkrEnmg4VVKIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG2SQFHgscZQMkIL70aqecxGtEe7VIM4I9OhBu/HyhGMHC8/i6
	hgy9XcXP3J4m9DGOYZkmMLrahpJOZgq9iRcUt7Q5y/eAGKgc4ZW5/kzfdqVXz366dvp0dJ7KaCW
	Lkxvv4pXk+nS0OAyU502yriurwI0ZIbYQUvZJpK9D
X-Gm-Gg: ASbGncuO0Dd/lMpvZIrLyiG5B3Xfd1HPz5S4rIsjhUOiS1E6yFEch00qmynt6hlwqrg
	x2gUx+csOEwm1pw9QNydTjzfiUkbtbqXvVNhShx0DSxK+jUfCr09sSLolkROKxc1G4zh+g3jaX7
	3GbCY7+gLJClJ6Jge1zS4HNSobTLFZrUNW77ETCZOaAzCQCZiD+rix90D/lG/xX1rqMzzyEo8EZ
	nSLohWKB4isHIZFXK0Wn+QgEW6Lh0piEWBkhHzncdJaLvdJ42CD2FhCVKzzJ0s=
X-Google-Smtp-Source: AGHT+IEBRicdafJf3u77ctjkGg0qQE01vvq76y8OfmUEZq9l+r7vlVJkRpkH6O+HQWrp9aS+8G9GRAXwfO+KbOCqR1U=
X-Received: by 2002:a05:620a:2615:b0:82b:15c2:509 with SMTP id
 af79cd13be357-83ba29b6776mr106004485a.1.1758225075919; Thu, 18 Sep 2025
 12:51:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825203223.629515-1-jarkko@kernel.org> <aMxV9fB0E72QQY2G@earth.li>
 <aMxZlHn9bfa5LGEU@kernel.org>
In-Reply-To: <aMxZlHn9bfa5LGEU@kernel.org>
From: Chris Fenner <cfenn@google.com>
Date: Thu, 18 Sep 2025 12:50:57 -0700
X-Gm-Features: AS18NWCj6f0C0cTQbPavL2yzofztQlVPZRuus3lDO36bJFzWpZEEGANZWXKMSrk
Message-ID: <CAMigqh2gJ+ALqxb8RcNFENJg-Z0FfKE2DZjaGdOER7G3AGZvKg@mail.gmail.com>
Subject: Re: [PATCH] tpm: Disable TPM2_TCG_HMAC by default
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jonathan McDowell <noodles@earth.li>, linux-integrity@vger.kernel.org, 
	stable@vger.kernel.or, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Agreed, the feature needs some work in order to provide meaningful
security value, and disabling it by default facilitates that work.

Reviewed-By: Chris Fenner <cfenn@google.com>

On Thu, Sep 18, 2025 at 12:12=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org=
> wrote:
>
> On Thu, Sep 18, 2025 at 07:56:53PM +0100, Jonathan McDowell wrote:
> > On Mon, Aug 25, 2025 at 11:32:23PM +0300, Jarkko Sakkinen wrote:
> > > After reading all the feedback, right now disabling the TPM2_TCG_HMAC
> > > is the right call.
> > >
> > > Other views discussed:
> > >
> > > A. Having a kernel command-line parameter or refining the feature
> > >   otherwise. This goes to the area of improvements.  E.g., one
> > >   example is my own idea where the null key specific code would be
> > >   replaced with a persistent handle parameter (which can be
> > >   *unambigously* defined as part of attestation process when
> > >   done correctly).
> > >
> > > B. Removing the code. I don't buy this because that is same as saying
> > >   that HMAC encryption cannot work at all (if really nitpicking) in
> > >   any form. Also I disagree on the view that the feature could not
> > >   be refined to something more reasoable.
> > >
> > > Also, both A and B are worst options in terms of backporting.
> > >
> > > Thus, this is the best possible choice.
> >
> > I think this is reasonable; it's adding runtime overhead and not adding
> > enough benefit to be the default upstream.
>
> Yes, I think this is a balanced change. I agree what you say and at the
> same time this gives more space to refine it something usable. Right now
> it is much harder to tackle those issue, as it is part of the default
> config. By looking at things from this angle, the change is also
> benefical for the feature itself (in the long run).
>
> > Reviewed-By: Jonathan McDowell <noodles@earth.li>
>
> Thank you! I appreciate this and will append this to the commit.
>
> BR, Jarkko

