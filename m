Return-Path: <linux-integrity+bounces-3002-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEAD927B97
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2024 19:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E5C1F2566A
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2024 17:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AF41B3743;
	Thu,  4 Jul 2024 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GCmFU+vj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB6C1B11EA
	for <linux-integrity@vger.kernel.org>; Thu,  4 Jul 2024 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112897; cv=none; b=qUI3cGlXs3ATbk9+1SEKYEZckYdSeAbcmTO4ceHLcUHHjkRsRLNzkHlpPR0qWlmZSsOXxpMBxo9iyURKNJt1Rf+YJ32Z2cu84dq6upaNZsKUxPT46jNu0JsS8TIAe/PPe1w8rt9q9J3GsWmHqZUigdX2ha8LCUHkpPIheiEN6vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112897; c=relaxed/simple;
	bh=QguQgLZBBttmrru34w9QMLWo5wJFt+WRZM0wpZpr6UY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/z//t3S/Wyn2oTNhA8fg88xmCtb0YoxmR4/+qkaxuetSodIx93azTBEyKjtymCs87Vt5rFZOXNt7a1TKpZiOhDrEYvk2c+/LrcarMRjlI+aWg6RcCBcWf2iNXt6rF0vI/vEETF66jH0Z4PbLhSDxXur2fTpe8JRKgkE7Pf9lXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GCmFU+vj; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ee794ebffbso14185491fa.1
        for <linux-integrity@vger.kernel.org>; Thu, 04 Jul 2024 10:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720112894; x=1720717694; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UlrKQa45wt6qlKqqrZr7W5l7lANNYZzO1+mSmOq7i9c=;
        b=GCmFU+vjTvyzSneyN7I8hdFl4DW1ZAvLTsY4E/mnHvsWKC9RbjOPc5mf2KDqk0e44l
         F5SnDbjCIsGvjVucQsslqESmxvSsucLsNvaemwINZYRdok/Zw/bzYx63z4YYkpUhrx6T
         5slX9AP6k7xzM+ynG0lDcAba+960v4ZrJrybQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720112894; x=1720717694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UlrKQa45wt6qlKqqrZr7W5l7lANNYZzO1+mSmOq7i9c=;
        b=FgduMA6i1ZI9ZPWuYlDzSd2SQSg/dmPaI/NFixw6x8WdngRElNMLmJT3QgIhOC8EIq
         4elViH8rVZDNA+o/Py2sRRA/gD3a5ye3NvRsDsNyk6Mbw/5JRJ+bDyVUvqukxBg7WtMu
         KL5HmnzrpEY5wGjv2FipdejKgZrVcC4oC2vclLsrDcZ/F977AtmYcIJM+HIut3SJAyAk
         qAU8Y1oCP3OTWrDmxS1U3f6gVEjD45RqusQVxZywCZBy8D4yuEB2YyzYKAmkKG/3w+Kp
         EYUkNBmUaHvM5THHBsso584L5rBOqIRv1XXI94WbdKqdUG2WcT04hBswiy+qE8KGFdrD
         PBnA==
X-Forwarded-Encrypted: i=1; AJvYcCXZCqYtuLJH+QmLspH2zYi5hNnW4xXwifAZwKwVMlnDkhpw960/ZGW9JtTg+OLpGgb6CMveqlRLFpsKhjuN/fYF7+JCN8LnNz+wxBrQq3TJ
X-Gm-Message-State: AOJu0Yzm4aOqwfXoW78d+lE0ovTJHTJq8abmFNEpoQejvC6tEZkSNzu+
	AwHs9JWR5YuW5NLVuU1ebsAjz99WyUVZMOSm4Ks8DOgNm2y94gQlOSjiQZdaxOkDV7d1ksJrqkS
	2ynAUTw==
X-Google-Smtp-Source: AGHT+IHKvGKX2MBVTNFxzVtbZKFc3bpBTvjwZOA2n3msq5c7S1+t7WX4LxIcZ86pKa+6bUeinVp6Ag==
X-Received: by 2002:a2e:9515:0:b0:2ec:5843:2fb8 with SMTP id 38308e7fff4ca-2ee8ee0e795mr17866401fa.42.1720112892414;
        Thu, 04 Jul 2024 10:08:12 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee5160e349sm23259951fa.7.2024.07.04.10.08.12
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 10:08:12 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52cd80e55efso1456694e87.0
        for <linux-integrity@vger.kernel.org>; Thu, 04 Jul 2024 10:08:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUj79UqNysuBt34hD1GZF82QTn/UH8VTy6dC5umiQD1Mf2oqWdCvwMsgUxgJS5pySRYahi1pLIhjZs5yO8N6zmEappjyVz7F2cLn4M6RmRM
X-Received: by 2002:a05:6512:204:b0:52c:8075:4f3 with SMTP id
 2adb3069b0e04-52ea0632781mr2063767e87.36.1720112891664; Thu, 04 Jul 2024
 10:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703182453.1580888-1-jarkko@kernel.org> <20240703182453.1580888-3-jarkko@kernel.org>
 <922603265d61011dbb23f18a04525ae973b83ffd.camel@HansenPartnership.com>
In-Reply-To: <922603265d61011dbb23f18a04525ae973b83ffd.camel@HansenPartnership.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jul 2024 10:07:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiM=Cyw-07EkbAH66pE50VzJiT3bVHv9CS=kYR6zz5mTQ@mail.gmail.com>
Message-ID: <CAHk-=wiM=Cyw-07EkbAH66pE50VzJiT3bVHv9CS=kYR6zz5mTQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] tpm: Address !chip->auth in tpm_buf_append_name()
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org, 
	Thorsten Leemhuis <regressions@leemhuis.info>, stable@vger.kernel.org, 
	Stefan Berger <stefanb@linux.ibm.com>, Peter Huewe <peterhuewe@gmx.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, linux-kernel@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jul 2024 at 13:11, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> if (__and(IS_ENABLED(CONFIG_TCG_TPM2_HMAC), chip->auth))

Augh. Please don't do this.

That "__and()" thing may work, but it's entirely accidental that it does.

It's designed for config options _only_, and the fact that it then
happens to work for "first argument is config option, second argument
is C conditional".

The comment says that it's implementing "&&" using preprocessor
expansion only, but it's a *really* limited form of it. The arguments
are *not* arbitrary.

So no. Don't do this.

Just create a helper inline like

    static inline struct tpm2_auth *chip_auth(struct tpm_chip *chip)
    {
    #ifdef CONFIG_TCG_TPM2_HMAC
        return chip->auth;
    #else
        return NULL;
    #endif
    }

and if we really want to have some kind of automatic way of doing
this, we will *NOT* be using __and(), we'd do something like

        /* Return zero or 'value' depending on whether OPTION is
enabled or not */
        #define IF_ENABLED(option, value) __and(IS_ENABLED(option), value)

that actually would be documented and meaningful.

Not this internal random __and() implementation that is purely a
kconfig.h helper macro and SHOULD NOT be used anywhere else.

             Linus

