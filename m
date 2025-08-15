Return-Path: <linux-integrity+bounces-6857-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC95B28327
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 17:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541D23AFA95
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 15:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB84119F137;
	Fri, 15 Aug 2025 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d+lXkgku"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4C3308F21
	for <linux-integrity@vger.kernel.org>; Fri, 15 Aug 2025 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755272724; cv=none; b=LnMQudhDhLrz8EI2cKAjgaBIdTbhl6H3kN6cGWP4+XGiuY8seId28plq95TCqUbIVx5KEAXxx9lzo5jj9JNSkVvoxLXR6Wd7hg+3pIqup28PkYkyJimrPESepmLLZgig1xm88fUIVN8zuqwPyIxedOSuyMRK/RP+Kdqcc7z0+mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755272724; c=relaxed/simple;
	bh=+3I80yhydYWASTAsGzbCh7I+Hc87GBAqCuiWOJrapxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T9QbFjJffSwBnzpyqW6N8n1K7nwYkoDWavXOWhA3ol5P6DkF3OcKxNO2ofRLJURcNVmUWfztdoKjeU3XQhEUgqYiZq5G22t/yiDwu13t6GwqB/8YQy++JnxBgMYIV/J5DIfLjD9N67I07XbNeHCJZjEu/KaOqh/q+9/DZPwOQms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d+lXkgku; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55ce5247da6so2152345e87.2
        for <linux-integrity@vger.kernel.org>; Fri, 15 Aug 2025 08:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755272721; x=1755877521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkJuyXAciH/8/iDD4LG9SPwRCgzsmG2xUR336CxdJe4=;
        b=d+lXkgkubfntayKp0QjDnp5e79cXtgZu9DB0T7NnXOpwNy53zqbmDn41Ngg4nrRmcY
         LnypaBik/KqBulubs/9mIEuu67wOQBBYHs0rHmP1vpLZBGU7CQtnzfwmRadv46Ux51+O
         qhNrJ9sehKypOsq0LhURGtVMO2FGxP//UFW6KvL3jYVP9eUtkwwbdjho4eg1gq5VMmZk
         ZPFnjrV7gH5p04EMgnVsvLbJLOMJbpE9G3IJuHZVrkJZPLxhp+sfA60gNsd2go7iM3ew
         3drx4qiNO1eDtVV2gmzwWNOhEhTn7+D2z7F4jTBGAIH16ifAjtKiV0YA7jzxGK0n0VqL
         IOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755272721; x=1755877521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkJuyXAciH/8/iDD4LG9SPwRCgzsmG2xUR336CxdJe4=;
        b=e6Bie+5QYcaY+YIgW2anajNijpqHxPD1ZtoPCjD92s3dlOmp36dOHccVmLwzyRklTY
         L3zgfdNr99goT0fu+c/JPO0fUzD4ReZuQ4Ux2/hrgSxW67zEbd/uOqiXKVUS8nQkzeGk
         aJ+kuPH2AQxSpIh68ZCk8udU5LqU4AInZs+EGmwq4JJgyJuRHBBEhdGA+baETOa5H8gb
         IH7y7vTDrULQHjvIE84BS/dboChEbsR4HRFk5EZlXfoRFQcFu7or4CXybWr75RaqnJdl
         RrhyguzwwTUnOkP0irTKOPoKrY2OBhGwqSsa5tMdp+ZTiq6d2PcxxibNFpWLWei/FEg2
         a5pA==
X-Forwarded-Encrypted: i=1; AJvYcCWNGj+xsuzNaaGYqIgsJvEdlP3rs7QS2n2DhXpiZ1QoE+tWVkY3ZKQuhFx1x5ni2Ch0EpJTp0GIDb+7b+QvfKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi8s/V2rsJYQj66twJqsLxkVD9VcoLY1hwlc7gsIJz2L4d0Dad
	Q3mlwsww/1H8Jm9RFYshWI0YYC+Iypxemt2zD21jFNj+aqYnyA1eEexHlVtOLRP4zcuNev+9jYC
	NWdmMYoNNtcrvGmwepwRRX8XwghsqOkVZMghKLLFD
X-Gm-Gg: ASbGnctnD1iSbCGCIlfe1l+fmjdl1JSrlXwF6dgTfKOV46FCrGxbj/WeBp1aViU85Ss
	82Bu4V7tHHkS14AsA6I0fI9+nFVXOC/dr99ZACOUJj9/bfrVoW58Jr5SUP4M8Vr2Gct4XNurE44
	lE/YZJz7KNNd1gvajocCq0a1AojmhAGTeAtCfNGSm+yNqcI/vZNQdYWma1YY9qcvWY3zyA4nGfJ
	xwEcQezvvkZsr1qItajSEA=
X-Google-Smtp-Source: AGHT+IHoUFUHs//SPTxeubB1wws/VR/cpYf2jq9guM4+F0Lgc2jiIll1Ixu0aj4hL6zgMqosy6FJALEoU8vCtGB4YI4=
X-Received: by 2002:a05:6512:3d29:b0:55c:c937:111a with SMTP id
 2adb3069b0e04-55ceeb7d4famr765325e87.35.1755272720612; Fri, 15 Aug 2025
 08:45:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814162252.3504279-1-cfenn@google.com> <aJ8iNLwlf4PAC0h1@kernel.org>
In-Reply-To: <aJ8iNLwlf4PAC0h1@kernel.org>
From: Chris Fenner <cfenn@google.com>
Date: Fri, 15 Aug 2025 08:45:06 -0700
X-Gm-Features: Ac12FXyc0wnfWnQIcqGBAtmirRVKc85vzbeMWwmIrLl029870yED6L63LTkgz6U
Message-ID: <CAMigqh1RTVzz0ffY8M3mZuc7NDaBKpMmCU4q0LuNyM2eAi+NFg@mail.gmail.com>
Subject: Re: [PATCH] tpm: Disable TCG_TPM2_HMAC by default
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Jarkko,

By the way, I noticed you and James (in your earlier version of this
patch from 2024, see [1]) both characterized the TCG_TPM2_HMAC feature
as being cheap or free, since ECC primary key generation is pretty
fast (few hundred ms depending on the TPM). I think this analysis
might be missing some of the hidden costs of the feature. Under the
hood, it looks to me like the kernel is doing an ECDH session
establishment with the TPM on _each_ PCR extension (see the call to
tpm2_start_auth_session inside tpm2_pcr_extend). Each ECDH handshake
means the TPM is performing an ECC private key operation, which is
significantly slower than the PCR extension itself. On top of that,
you have the overhead of shuffling the context around.

To illustrate some of the hidden costs of the TCG_TPM2_HMAC solution
(and perhaps explain why people are complaining about severe boot time
impact), I created a small tool at [2] that you can use to profile
salted session PCR extension on any TPM.

I have a Linux machine with a standard off-the-shelf Infineon SLB9670
TPM. Without the session salting, each PCR extension takes just 4-5
ms. With session salting, it takes:
* 30ms to load the null key from its context blob
* 108ms to start the auth session and extend the PCR inside it
* 1ms to flush the null key

for an overhead of about 2880%. Depending on the configuration of the
kernel/IMA and how many PCR measurements it's making, this could add
up to a good chunk of time and explain reports like [3] where people
are noting that turning this feature on adds minutes to or triples the
boot time.

Personally, I would recommend disabling the feature by default until
someone finds the time to fix it (perhaps as you described, with a
tri-state; perhaps the performance characteristics can be improved as
well). I am personally skeptical of any defense-in-depth benefits
since it is not hard for the interposer attacker to also interpose the
session salting, but everyone's threat model varies.

Since the feature breaks userspace (for atypical TPM hardware), slows
down boot (for all TPM hardware), and has unclear security value,
Google has already disabled the feature in our Kconfigs. I sent this
patch in case it can help save others some trouble. Understood if
that's not the way the team would prefer to go with this.

[1] https://lore.kernel.org/linux-integrity/aJ8iNLwlf4PAC0h1@kernel.org/T/#=
t
[2] https://github.com/chrisfenner/salty
[3] https://lore.kernel.org/linux-integrity/bf67346ef623ff3c452c4f968b7d900=
911e250c3.camel@gmail.com/#t

Thanks
Chris


On Fri, Aug 15, 2025 at 5:04=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Thu, Aug 14, 2025 at 09:22:52AM -0700, Chris Fenner wrote:
> > This change disables the TCG_TPM2_HMAC feature by default to resolve
> > some driver initialization failures (with certain TPMs) and performance
> > regressions (with all TPMs). See "Security remarks" below for why this
> > does not meaningfully downgrade security.
> >
> > When the TCG_TPM2_HMAC feature fails to initialize the "null key" (see
> > tpm-security.rst), it will cause tpm_tis_core_init to bail out early an=
d
> > skip device registration, causing all userspace requests to /dev/tpm0 t=
o
> > return ENODEV ("No such device").
> >
> > TCG_TPM2_HMAC depends on the following being implemented in the TPM:
> >
> > - TPM_RH_NULL
> > - TPM2_CreatePrimary
> > - TPM2_ContextSave
> > - ECDH-P256
> > - AES-128-CFB
> >
> > While the majority of TPMs in the ecosystem conform to the PC Client
> > Platform TPM Profile, which currently mandates most of these, not all
> > versions of that profile did, and not all other TPM profiles (e.g.,
> > Mobile, Automotive, Server) will. The TPM 2.0 specification itself is a
> > "Library" specification and does not mandate any particular commands
> > (and very few features) in order to maximize flexibility for
> > implementors.
> >
> > The TPM driver should not break userspace for a TPM that conforms to an
> > atypical profile, therefore this change makes TCG_TPM2_HMAC disabled by
> > default. It also adds a remark about what will happen if this feature i=
s
> > enabled and used with a non-supporting TPM to the Kconfig.
> >
> > Some real-world public examples of problems posed by this feature:
> >
> > TPMs that do not support the feature result in broken userspace startin=
g
> > from 6.10:
> >
> > https://wiki.archlinux.org/title/Trusted_Platform_Module\
> >
> > Significant (around 200%) boot up latency due to all the added TPM
> > private key operations:
> >
> > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2080322
> >
> > Security remarks:
> >
> > tpm-security.rst describes the threat model of the TPM2_HMAC feature,
> > wherein an active interposer adversary on the TPM (e.g., SPI) bus
> > tampers with TPM commands and/or responses to interfere with the bootin=
g
> > or running system. The TPM2_HMAC feature uses something called "salted
> > sessions" to establish per-request keys that can be used to protect TPM
> > traffic.
> >
> > Because the kernel does not have a priori knowledge of a cryptographic
> > identity for the correct TPM for the system, and because the kernel doe=
s
> > not have any cryptographic identity of its own with which to
> > authenticate itself to the TPM, the session is established using a
> > one-sided, unauthenticated key establishment protocol, wherein the
> > kernel asks the TPM for the so-called "null key" and uses it to
> > establish the shared session secret.
> >
> > This poses a serious problem for the threat model of the TCG_TPM2_HMAC
> > feature, which it resolves by asserting that userspace will attest to
> > the "null key" using the EK after boot and compare it to the contents o=
f
> > /sys/class/tpm/tpm0/null_name, exposed by the TPM driver. However, this
> > creates a trust cycle: we do not trust userspace to perform this action
> > correctly, because we do not trust that kernel correctly measured
> > userspace, because nobody has checked the null key yet. An implicitly
> > trusted remote attestation verifier also cannot be relied upon to do
> > this check, because it has no way of knowing for certain which key the
> > kernel actually used to establish the TPM sessions during the boot.
>
> All we care here is actually the external verifier scenario because most
> of this type of crypto where software must attest breaks without that,
> including all confidential computing technologies.
>
> It's true that in the current form the whole feature is at most defense
> in depth. It could be e.g. extended with persistent keys and productized
> more in the future (e.g., trusted keys were mostly useless for multiple
> years).
>
> I'd personally would like to keep it on at least on my own laptop and
> there's a risk that there's a group of people who would either:
>
> 1. want to have that small amount defense in depth.
> 2. want to refine the feature.
>
> It's by practical means already "relaxed" but outcomes are objectively
> plain wrong (as you stated) so I'd take a bit more conservative approach
> on changing the mainline and propose three state option:
>
> 1. off: fully turn off
> 2. relaxed: mark just a info or at most marning to klog that hmac
>    encryption is not enable. Keep timeout short as ECC generation
>    does not take long (if it is working) (at least according to
>    my tests). It should also address the lack of TPM2_ContextSave.
>    We really should probe that anyhow in the driver init and
>    disable also /dev/tpmrm0 accordingly.
> 3. strict: enforce. This is good to have albeit now not really
>    useful
>
> The 'relaxed' is of course default.
>
> BR, Jarkko
>
>

