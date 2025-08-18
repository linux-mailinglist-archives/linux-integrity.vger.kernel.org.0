Return-Path: <linux-integrity+bounces-6871-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6869B2ADDB
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Aug 2025 18:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7327D1B22B85
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Aug 2025 16:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547E8322545;
	Mon, 18 Aug 2025 16:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ONrl+cWu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF664278146
	for <linux-integrity@vger.kernel.org>; Mon, 18 Aug 2025 16:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755533595; cv=none; b=S63P7M4ADskqUgCNb+tzBPJDo+NEmr+ksBDuSNBhKgZgq2iI/0wi0QI8i2h5Ab4Y4YmaiPWj1EpoCtOl9MOAXlspuZW8V1x1D70xNqDQ7NppOB2brdDKGvi9v1xG9EHoqcqMqLyaPzW7R5oxbpoXRMxQJZWPm4Zw+GSvwQqxnZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755533595; c=relaxed/simple;
	bh=qdFUMuUZzhpNzIjokGfrhSFI/4o+Ugep417lW75oSrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQgE+x/6Wb06NypEShBGv2GQseSHZMNaVTkl7a6LmrkcHnMDQlXyH7EImEeiRN3CRcF1LTWXNAbmcKT7IExCR1k0Uxq2mISmu9TiPgljihEidEZf+soiSDiGf7rVmHWodhNwAdByNsyms1UISw3RxvSZWROecxYkXZT3O1UPHag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ONrl+cWu; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55ce509f80dso4225987e87.0
        for <linux-integrity@vger.kernel.org>; Mon, 18 Aug 2025 09:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755533590; x=1756138390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdFUMuUZzhpNzIjokGfrhSFI/4o+Ugep417lW75oSrU=;
        b=ONrl+cWuHvfjucINomm8IVxJqWNA5IVkbDh4HvE3I+WKi3SpwDQs9B5YFZmtE3nFma
         qliuFz/gHA6m30C5B/NV2BEPBsD5Bo3R44PIeGlo3STeYlmNuiIipK9tn1Uo1br1ssJT
         aWfkQz5FI1caBaDdHx12O82RM1sht97FUlTS6SkIROmMJrF/jLRvXQ/qhfn4ZCJ7GdQ8
         ODrYbCzLGF7QKqOUYa3VyTM0GIan+mnaqg5C53LnhM27d1F73pRurOmNw06Cneq3TWrO
         Z0tJFjuKbrAKsAX1f9L/NRSxqWE4EJ0kaQChwBGjeM+Qx2K+kkQxlxHcxCBhgaXZcYgP
         O+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755533590; x=1756138390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdFUMuUZzhpNzIjokGfrhSFI/4o+Ugep417lW75oSrU=;
        b=hdMoCNuRw4k/zvAIiUjwZNuLmsrh1uETWTbv46yo71orPsqcGlFQ/rSVDcDwEDmklV
         oBlpN9tnimSReNu8ghzXs0DAzBn9+frbOMzhWLFqQcVRH1eJ9hZdE77WDPQLw2xHKiVR
         VL8H6WObj5A+xgzv53vNkHGoNn73Or7gE62uFGO6yyfFg4vjPx2au0kHCb5ywlD6XA+q
         CJ82zL6jIEDSYtZ2o6Ml7oWHiUlcl932WknaxuOpstl2cKbg7w66eyz9xBh+q/Wv3Kty
         bXEcao4xYrV9X38+/fIlpKtVUuWgtBssyxR7kgTEWwKFLmLqlPNjfoKnWhXY4bQcJKCJ
         MVCA==
X-Gm-Message-State: AOJu0YxSk2MyE6wx5SYHZyuVU5yymPau6bmqUU5zdM/5Ca912j9XBsUn
	Aqz3zHXsodjIaleuQWttSztjaeJsZwNkUSAItSqTlCbGZJUJWXM6xdf40Mfs5h09OKqZnXjtVpH
	5zGfbisMaBomplrIRnL5JmN+OnNWnsWZEZgiWevtp/GmaUyzgPx9H+oNq5g8=
X-Gm-Gg: ASbGncvLOgzC6CADXZcVzudDXQokwwDwb80jtHUll4TdyN7vsSZQHSDWEzJLY9jAPjZ
	/0xAyGMTAxXYeoVdnpzVXB15obFgHyzBznjnehIfc8eNiSNuzUe6PqYrBo5Eh7BXWutBWwIyNdP
	mTIcjircUcuIdFnrkbtlALrM5XhyOtb80m4176WYLerzpEnvSVFFyiNiEleFgKE5AqKE1O3H9at
	f+0InTZlpbxIj8GxCETD1Fi/HftVLXFrwbFQCYqbgQ5IY7c
X-Google-Smtp-Source: AGHT+IFeOqwEhTRIGmYyEPv7VSjkBYt7kJQbYUmkI8p06Ty6Y3cddoOw8158OHMoBTVNzzS1fbyVf2xZHYuraTZb37w=
X-Received: by 2002:a05:6512:638a:b0:55c:c971:2271 with SMTP id
 2adb3069b0e04-55ceeb43b69mr2117899e87.25.1755533589465; Mon, 18 Aug 2025
 09:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMigqh2nwuRRxaLyOJ+QaTJ+XGmkQj=rMj5K9GP1bCcXp2OsBQ@mail.gmail.com>
 <8be73a3a6772c61387b93eae808a7e382462c6cc.camel@HansenPartnership.com>
In-Reply-To: <8be73a3a6772c61387b93eae808a7e382462c6cc.camel@HansenPartnership.com>
From: Chris Fenner <cfenn@google.com>
Date: Mon, 18 Aug 2025 09:12:57 -0700
X-Gm-Features: Ac12FXxy3N2Ufj5gMR7JJkp-Akac78FaCL10gyIJXeqWz6sxlNNfvMYbgF7GX2M
Message-ID: <CAMigqh019OxTs+VaUjpEN3WoAkJnr1fJaciAELczgM9g1BMZUQ@mail.gmail.com>
Subject: Re: Questions about CONFIG_TCG_TPM2_HMAC
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks James,

On Sun, Aug 17, 2025 at 1:34=E2=80=AFAM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:

> Supporting these commands was the reason the TPM2 volatile
> handle space was reduced to 3.

I think this may put the cart before the horse: You can do anything
you want to in the TPM with just 3 handles (actually I think 2 might
be enough). ContextSave and ContextLoad exist [1] so that you can
create a resource manager to share the TPM among concurrent
applications. If you aren't sharing the TPM among concurrent
applications, you neither need a resource manager nor context
commands. I want to make sure I'm not misunderstanding your message:
is it OK to break userspace over this or any other [2] missing
dependency of TCG_TPM2_HMAC, simply because that implies the TPM is
not a "mainstream" PC Client profile TPM?

> The way it is supposed to work is that the system stores (and
> validates if it can) the signing EK on install (this is constant for
> the lifetime of the TPM).

Some questions for the threat model here:
1. Where is the signing EK stored by the system?
2. When is this system (and its durable storage) validated or measured?
3. How do we avoid a circular trust dependency between the kernel and
this system here?

Thanks
Chris

[1] https://trustedcomputinggroup.org/wp-content/uploads/Trusted-Platform-M=
odule-2.0-Library-Part-1-Version-184_pub.pdf,
see 28: Context Management
[2] https://wiki.archlinux.org/title/Trusted_Platform_Module#A_TPM_error_(7=
14)_occurred_attempting_to_create_NULL_primary

