Return-Path: <linux-integrity+bounces-9810-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m5CBHw2RNGpxbgYAu9opvQ
	(envelope-from <linux-integrity+bounces-9810-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jun 2026 02:45:01 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9FE6A3672
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jun 2026 02:45:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="WEu/X/eE";
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9810-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9810-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2549D30819E4
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jun 2026 00:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6923382C7;
	Fri, 19 Jun 2026 00:38:58 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97B31A0712
	for <linux-integrity@vger.kernel.org>; Fri, 19 Jun 2026 00:38:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781829538; cv=none; b=RcfKt1ZU3Hn/zNSMRNZEVgwckSXk+znU4ziecmmKbfTtH/HJYcAJ3asF82qVWYD9/TWmqUic3xKn0tVv9BjtYo7is8ah3LjLIxQNE5aIM9tzbkBwLTwNejleHpPG0MWQs99CkZJlgw8/ftBjvzUQB+64FCVAH4TdeR8HWLL+YVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781829538; c=relaxed/simple;
	bh=9zgS42P6dVGFf3vXCfitysvgt9GlwceOik9xKhnJ9+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTWrzXR8tlfp8bj5H7yNUoeToAshBIr3HwL8Qh1FDaS8VTb0I4bZ/Y1ZdyTGY1D73AARY21CWgA2OhaNa+zBfnRZQTkDVQYKH7reAZ8Zaiq4nDcsqcyZjSu98jBSj72o3rXHIP6KwUdvaOHS0yK0LNs1D8WBu2n+OyMOF8E9NOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEu/X/eE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D1DD31F000E9;
	Fri, 19 Jun 2026 00:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781829537;
	bh=a4QMWcRC5dXQfGeulB7F56knbKAB5E4qVMDM52H4rr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WEu/X/eEywYJ79rtroITHzN3Rlv5rmqatNbrYoyjyPDJHM8hfvQkeVD8Xd56vEZ3j
	 hnsoXvSPd2k/yX1W4hW4BJkV09cCNYkQ8Z4empeOs3ftzr+GuE6nJ0rDd90DlJK0qF
	 dOAykpmAYdCURbiQi+b5UmyyhSWTkwrQFgIui5H03+FLDFvay/37nqRp/qOhRdolHW
	 L11VEb8BRdJgi3p8D+1fpuDltp3VLhbnWm8Ktgk2cok0dpnNKdrW7DxOGaU1zdsiIp
	 5Bfl+MxkaWWI7YMd9h+cUEwD5UNI9Q6y4493MCYkcpJxdZvJweWs/hVHkL8TAs75s7
	 8ZEqBFJ0oIDPQ==
Date: Fri, 19 Jun 2026 03:38:53 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Christoph Anton Mitterer <calestyo@scientia.org>,
	linux-integrity@vger.kernel.org
Subject: Re: inherit null-key across hibernate (was: Re: regression: kernel
 log "flooded" with tpm tpm0: A TPM error (2306) occurred attempting to
 create NULL primary)
Message-ID: <ajSPndgTYFJgpTaE@kernel.org>
References: <693caa85c3ee1b3117a562894971de60b6842d00.camel@scientia.org>
 <8fe12e2eb9beb159d2af8462fa0b9b1f946deacb.camel@HansenPartnership.com>
 <89542959611252d64572ffad438f48b4f54131f0.camel@HansenPartnership.com>
 <D5LEQGJ9X3NF.3K3YVPNE6KQJK@kernel.org>
 <ajDIDcW_EzgLB0qX@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajDIDcW_EzgLB0qX@makrotopia.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9810-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:daniel@makrotopia.org,m:James.Bottomley@hansenpartnership.com,m:calestyo@scientia.org,m:linux-integrity@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E9FE6A3672

On Tue, Jun 16, 2026 at 04:50:37AM +0100, Daniel Golle wrote:
> Hi Jarkko,
> Hi James,
> 
> first of all, sorry for hijacking a thread from 2 years ago.
> 
> On Thu, Nov 14, 2024 at 12:34:30AM +0200, Jarkko Sakkinen wrote:
> > On Wed Nov 13, 2024 at 8:12 PM EET, James Bottomley wrote:
> > > > I think we might have to expect the NULL name to change on actual
> > > > hibernation because unlike suspend to ram it does power off the TPM.
> > >
> > > I checked the code: we're coming in on the correct path to renew the
> > > null seed after hibernation, so it should all work.  The problem seems
> > > to be that your TPM itself is doing something invalid because the name
> > > we calculate for the primary key doesn't match what your TPM says it
> > > should be.  Absent some form of attack or bus integrity problem, that
> > > shouldn't ever happen, so I'm even more curious to know why it worked
> > > in 6.11.5 and before and whether current upstream works.
> > >
> > > I haven't found it yet, but I think the every 10s signature is because
> > > the hibernation path is trying to restart the TPM device and won't take
> > > no for an answer.
> > 
> > My fix returned the behavior how it was before my earlier fix in this
> > corner case (i.e. disable TPM). The issue has gone unnoticed before
> > since it has emitted only a single klog entry.
> > 
> > On suspend this has not happened to me so obvious deduction is that
> > hibernate resets the null seed.
> > 
> > Hibernate needs an addition a fix to disable bus encryption from kernel
> > command-line completely, i.e. tpm.disable_integrity following the
> > convention from my earlier fix [1].
> 
> I'd like to offer a way it might be resolvable with the null key after
> all, without provisioning a persistent NV key -- by changing the
> question from "re-derive the null primary and compare" to "inherit the
> trust the resume has already established".
> 
> Resume-from-hibernation is a TPM Restart (Shutdown(STATE) ->
> Startup(CLEAR)), i.e. a firmware cold-init of the (f)TPM, after which
> the boot/initramfs kernel establishes a fresh, genuine null primary.
> In the common configuration (FDE with the resume/swap device inside
> a TPM-sealed LUKS2 container) that same TPM has, moments earlier and
> *before* the hibernation image is restored, cryptographically attested
> itself by unsealing the resume device. A substituted or interposed TPM
> cannot produce that unseal.
> 
> So rather than letting the resumed kernel re-derive the null name,
> find a mismatch and disable the chip, the boot kernel's
> freshly-established and unseal-validated null primary could be
> inherited by the resumed image. The existing null-seed TOFU model is
> preserved; nothing new is provisioned.
> 
> The gate is the unseal, and the adversary case shows why it is the
> right gate:
> 
>   Malice swaps (or interposes on) the TPM while the machine is
>   hibernated, then leaves. Alice powers on. The initramfs attempts the
>   TPM unseal of the resume device; with a foreign TPM it fails, so
>   systemd-cryptsetup falls back to the passphrase, which Alice --
>   seeing a prompt -- types. The disk opens and the system resumes.
> 
> If trust were re-established here, Alice would have personally vouched
> for Malice's TPM. But the unseal *failed*, so under this scheme
> nothing is inherited and the chip stays fail-closed exactly as today.
> The passphrase proves a human is present; it never proves the TPM is
> the genuine one.
> Hence: unseal succeeded -> inherit the validated null primary;
> passphrase fallback -> trust is lost, stay disabled.
> 
> This keeps the property the null-seed design wants -- an in-session
> reset is not on the hibernate-restore path and is still caught --
> while removing the false positive only where the platform has already
> re-attested the TPM.
> 
> The hard parts, and where I'd value direction:
> 
>  - systemd-cryptsetup would need to signal "the resume device was
>    unsealed by the TPM this boot" (vs. the passphrase fallback).
>    This is per-resume runtime state; a static command-line parameter
>    (and obviously build-time config as well) cannot represent it.
> 
>  - the validated null primary has to cross the boot -> resumed memory
>    discontinuity (the initramfs kernel's state is overwritten by the
>    restored image). Boot and image kernel are the same binary, so
>    patching chip->null_key_name in the restored image is mechanically
>    possible; a small reserved/nosave hand-off area may be cleaner.
>    I don't know the hibernate path well enough to say which is right.
> 
> It is admittedly cross-subsystem (tpm + pm/hibernate +
> systemd/cryptsetup), which is presumably why it hasn't been done.
> Compared with the persistent NV-key route
> (tpm.integrity_key=<handle>): that avoids the carry-across but needs
> the key provisioned and managed, and a persistent key's name no longer
> changes on a genuine reset, so the implicit reset detection has to be
> reconstructed. The null-key-inherit approach keeps the existing model
> and defers "is this the same TPM?" to the unseal that has already
> happened.
> 
> Does this seem viable, or is there a reason the unseal-as-attestation
> gate does not hold that I'm missing?
> 
> (For motivation: on a firmware TPM -- Intel PTT here -- there is no
> external bus to interpose, so the protection has no benefit on this
> class of hardware at all, yet the legitimate hibernation power-cycle
> still trips the disable. For fTPMs specifically, not enabling the
> feature is arguably the better answer; but for discrete TPMs that
> hibernate, a real solution seems a good idea if doable.)

I think this has at least changed since 2024: bootc container type
of deployment is where you can realistically configure hibernate,
and use it in a real application.

> 
> 
> Cheers
> 
> 
> Daniel

BR, Jarkko

