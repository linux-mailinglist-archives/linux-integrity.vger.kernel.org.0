Return-Path: <linux-integrity+bounces-9333-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOfuOIjq62nhSwAAu9opvQ
	(envelope-from <linux-integrity+bounces-9333-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 25 Apr 2026 00:11:20 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC5A463BB0
	for <lists+linux-integrity@lfdr.de>; Sat, 25 Apr 2026 00:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EE8B300E70C
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 22:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B955E3D4117;
	Fri, 24 Apr 2026 22:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aDhY2VwX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2B934B1AD
	for <linux-integrity@vger.kernel.org>; Fri, 24 Apr 2026 22:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777068629; cv=pass; b=GxMCBkKTMdmDOBMbOyrw+FHn9pcLQMC1qB3Jde62wQxOL5Svr97fBBZa4+to1H2XEpLdiYen3u+xSjtK0B6bywrgmHLOvKVWrbn9apltWQC5ziQuLmwnEdguWh0+bF2/Oh+fKoqAKmCvY/Taa2kQVFgCFEzpXFfecHoLikEn6QY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777068629; c=relaxed/simple;
	bh=6w7q+JRY4PyPX6nQEYfB2IZ2WiHoYGMKfvmYc+6h3js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qz2AhTH/mrRJT+c8114khqULB/TIgET2unoFarhkz6pxHSXtOLXo72UoB4TMzzAxGb1FYmDIkuGv79lC9iTL/L5jU/pn6owO1n3sIAIC+Kxt09TDyPk8CHmHZ5zkYr68+ZhJ5EUA2NisZlhQ2r8w6h7kjoWgJSgPyH314vybQcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aDhY2VwX; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c79467f124dso3179394a12.2
        for <linux-integrity@vger.kernel.org>; Fri, 24 Apr 2026 15:10:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777068627; cv=none;
        d=google.com; s=arc-20240605;
        b=CeWIJPbZB3bBydqpsMiAnRHUP2YFqkFEU+fXNciDr3XMngBpjvXEG0Z9/FpW8ivMKY
         93aLIHOdMXyqs9YH1YT7fHmVbQxgQQdpUvF4/9S9oq+SBzXB6F3+2lX1+abC7FJF/b/3
         /bmlj+8PR6iBXpomIGnMSDqTylLnYzRG2TQ0GGOJwgJJRYLLpJi8t8qDA+3rFDLwi7Tx
         R2t/JCYc/tN2hs9u5D7WWWgUqIobcxh2Ui1xgLhMHh+sQKoYySrwZw6GcCwyUu2dpCLy
         G8oeYgzqErEc0JD+xjFi9FxzaoA8mm/rOyk3wW9NwvQZnuxLYseNVl7QpupmsWAItnBw
         IMtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hAcyp6tj20FtAf4IQx3ifIttGPMFNnHtv6J7kGhC8TM=;
        fh=fi9P3lHbFZt2sU1IOoQ6803N9g83ND5kYBiHMVvCH1E=;
        b=LpZk1L74ee4kDpf4bLMCN9hmqYkZJRrOMTkbByYbCv+Aj74ncF22s/2eYRGb+XNtvi
         67TIf/Sh7fFs4BuIqsV4DsPbElT+PrKj3Vc3rOeujbM6f0axfXdyNRrU8NA1aftC2jsG
         DBlbx5ao2kWi01LI0ayto7xv4KVVzxwf2oL4davqtVFoH32bPnafqFK3hgihpyzgtdba
         zw1Vhl5t1wNe3dBehvFtcsePJEB73J4FlRtPYbXlEnV11LMS0K1Oa0MFAPwvI+05WNn3
         yuSGkoXH0x2DDdv0LWi6YgGXe5igtc5C3BnncQyx+0rmpDSF09uw5lkjNtBfmrHAXnIJ
         Xc/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777068627; x=1777673427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAcyp6tj20FtAf4IQx3ifIttGPMFNnHtv6J7kGhC8TM=;
        b=aDhY2VwXyMyVBI0EPvDpLDRNus142EZqQTDoOcZ5ZOk3WEKViHxmrogrhvcqq6bGzM
         xDWhcKaHyeSmomA++lZDAEDNI0GKEIgyciTAB4Z729KxJHT1teiZcPS/U3D8du1a5Y/C
         dzQHnCc6A38kiIPJVQlRvW/V7nxkY9Qu/jAl2YHbhlx5eJaPs6W7OYJGkSbgvVOS4kH5
         bZq/f+fe3CFmuHg/oAJJMe3JKiLq5db81JCQwTdaFcxYZ0oZhAVIYeA9HtB3GfrzB4D5
         BQr9vMn5oAA1fsNjWHHl9HlD3KCJLA//YRp+3g7s5/CPHUkAKwOqbMB2oS/74p8KPicj
         haAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777068627; x=1777673427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hAcyp6tj20FtAf4IQx3ifIttGPMFNnHtv6J7kGhC8TM=;
        b=hvUOKAW1tn5wYvr3J6FSL8RbQ0uQsHA3ysJ71uWBH6GMHxgnHR+JtimrsTMkzse0Ci
         0+fX6DyOvMeodPnLunUkcruIA4z8HpSi8F3w2n4V4aQf1H7a8KnDdcUYdlAimLWG4VJk
         S1411n0OWHqa5PFvuUgWtQXcKAKoA0hX2onfccoMC+BacRqySkHnKfwt6ZDgmfsVjwA5
         ZISbjkXR06+3bOdv4/42Uzor7z5ef1OWEPmkV4dE3iWQwg6W+P2XlVzTmVa7CXDPt1HU
         D2UO7HjzxjjxjHPPiFpytUT4Ce6z33f8RjiXkbMe9tZAzBzl3PsmYCwJTTyiAoSuQBqB
         8YEA==
X-Forwarded-Encrypted: i=1; AFNElJ9ufGGMHLvJCZQaC3vEOxhdOMHgHgGVhFt0CDRk/KmXcW3FTVV0o2rTBsGDSey/X5UdH7Lrs+Jj1precpPzMD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/N4EKy3Dg1c/1ObT2Qptkfu43ZtDXVIC/Y/j3cAbuh9QmYdM7
	KO/Nu+6K9atQgDxfpPAT/C6YTN2r29fTyluuvaPwzZgrA0U0S/kol787cAFnWKpkylbBIJER3at
	lu3PmVrUnJXVltxmFwjFZaEUeIHb79rGpncRvoBnn
X-Gm-Gg: AeBDieuNoliMHJdGRurJTYA4x67Eni/pFetfz/qTudtlZ5opzq1yIj0SSFVfAbuA7c0
	w+WLc2+rckIk0gDNOtoRDaRiFaf4+224P1ayaCylXH0QtTLsuuUbxIUN6MWKBQ1tnW9VyeSmajN
	ydhWWiWKkmsi0ToIXTz2v0u50ss83vPuVRbbhBwUdvcMuQ9h/eSOe1CGXp+JBix/FDmnP4znWh4
	ToTV0RuPRtMo4O1s1RSg2NnGGcvijwsFb2mG9TZzhpaeKYh3TChwFh7QIU30R13h+fRS1W3XksN
	OTDaVzD+fg1z83qHGw==
X-Received: by 2002:a05:6a21:e082:b0:39f:91e9:cada with SMTP id
 adf61e73a8af0-3a08d677abemr37340839637.9.1777068627375; Fri, 24 Apr 2026
 15:10:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aeoAlVEwzRUPrlVe@e129823.arm.com> <aeoRxWPyOHGJd+Jh@e129823.arm.com>
 <aeoWO2Cwo04YYu2l@earth.li> <bd908e28298d968740d03c97bc7e441de188b7b4.camel@linux.ibm.com>
 <aeokwrC86WI7uT+K@e129823.arm.com> <aeomlp3I0eVE5mce@earth.li>
 <aeotq8nPVu4wvEx5@e129823.arm.com> <e4e242ae5533d5762a3647186a178764881bf9ff.camel@linux.ibm.com>
 <aephL3MzYoqFGaT5@e129823.arm.com> <CAHC9VhRQWHEWQ5NzOPiu8jtYv6UsRm8WVS4fd74AbkOcAd4y_g@mail.gmail.com>
 <aesGU8a3mbVzvteH@e129823.arm.com> <CAHC9VhSaT_quKYnpFjAfqvL07JNbWMgM6c4pB9F46NHawX3DCA@mail.gmail.com>
 <014cf39aa8d6a0bcfa1a95c069675977ac67b843.camel@linux.ibm.com>
 <CAHC9VhTW3=RJ8L91RWXYYA9tFjfSXGN-DMEEwdiD6big9H57Ew@mail.gmail.com> <1f78fc75b2e95239973612a4b6c4cc782960b7ac.camel@linux.ibm.com>
In-Reply-To: <1f78fc75b2e95239973612a4b6c4cc782960b7ac.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 24 Apr 2026 18:10:15 -0400
X-Gm-Features: AQROBzAx1ZA_SOme2lQN7_v2fyTxeQpFzpK5JHTmeoRh2Wyy1mmm1jq2VzT2o90
Message-ID: <CAHC9VhS4JmPmCJrYTdbjxb3TO-uK6cB3Zij-ef=wswGce2BGzg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] security: ima: call ima_init() again at
 late_initcall_sync for defered TPM
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, roberto.sassu@huawei.com, 
	Jonathan McDowell <noodles@earth.li>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	jmorris@namei.org, serge@hallyn.com, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, jarkko@kernel.org, jgg@ziepe.ca, 
	sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, noodles@meta.com, 
	sebastianene@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5DC5A463BB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9333-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[arm.com,huawei.com,earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,namei.org,hallyn.com,gmail.com,oracle.com,kernel.org,ziepe.ca,meta.com,google.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]

On Fri, Apr 24, 2026 at 6:01=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Fri, 2026-04-24 at 17:08 -0400, Paul Moore wrote:
> > On Fri, Apr 24, 2026 at 4:58=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com=
> wrote:
> > > On Fri, 2026-04-24 at 16:15 -0400, Paul Moore wrote:
> > > > On Fri, Apr 24, 2026 at 1:57=E2=80=AFAM Yeoreum Yun <yeoreum.yun@ar=
m.com> wrote:
> > > > > > On Thu, Apr 23, 2026 at 2:13=E2=80=AFPM Yeoreum Yun <yeoreum.yu=
n@arm.com> wrote:
> > > > > > >
> > > > > > > Sounds good. Once the patch is posted, I=E2=80=99ll review it=
 as well.
> > > > > > > Sorry again for the noise, and thanks for your patience ;)
> > > > > >
> > > > > > My apologies for not getting a chance to look at this patchset =
sooner.
> > > > > >
> > > > > > This seems like an obvious, perhaps even stupid, question, but =
I have
> > > > > > to ask: if IMA can be properly initialized via late_initcall_sy=
nc(),
> > > > > > why not simply do the initialization in late_initcall_sync() an=
d drop
> > > > > > the late_initcall() initialization?
> > > > > >
> > > > > > Does any IMA functionality suffer if initialization waits until
> > > > > > late_initcall_sync()?  If so, it seems non-critical if waiting =
until
> > > > > > _sync() is acceptable, as it appears in these patches/comments.
> > > > >
> > > > > This is the way first patch did, and here is some discussion for =
this
> > > > > (Might you have seen, but in case of you missed):
> > > > >   - https://lore.kernel.org/all/a6a0e15286c983d720de227c6827adbe9=
76c5b9b.camel@linux.ibm.com/
> > > >
> > > > Thanks for the pointer.
> > > >
> > > > Unfortunately, my concern remains the same: it's either "safe" to
> > > > initialize IMA at late_initcall_sync() or it isn't.  Attempting to
> > > > initialize IMA twice seems both odd and wrong.
> > >
> > > Agreed.  However, IMA should be initialized as soon as the TPM become=
s
> > > available, not delayed.
> > >
> > > In patch 2/4 patch description, Jonathan describes the reasoning:
> > >
> > > Unfortunately some TPM drivers (such as Arm FF-A, or SPI attached TPM
> > > devices) are not reliably available during the initcall_late stage,
> > > resulting in a log error:
> > >
> > >   ima: No TPM chip found, activating TPM-bypass!
> > >
> > > and no measurements into the TPM by IMA. We can avoid this by doing I=
MA
> > > init in the initcall_late_sync stage, after the drivers have complete=
d
> > > their init + registration.
> > >
> > > Rather than do this everywhere, and needlessly delay the initialisati=
on
> > > of IMA when there is no need to do so, we continue to try to initiali=
se
> > > at the earlier stage, only deferring to the later point if the TPM is
> > > not available yet.
> >
> > Once again, that heavily implies that it is safe to initialize IMA in l=
ate-sync.
> >
> > Put another way, what breaks if IMA's initialization is delayed to
> > late-sync?  If the answer is nothing, just move the initialization to
> > late-sync.  However, if something *is* broken and we are just doing
> > this because of TPM delays at boot, this patchset just creates
> > additional problems and we need a different solution.  I can't
> > envision a scenario where it makes sense to attempt initialization
> > twice.
> >
> > > > I understand the need to ensure that the TPM is available, but if i=
t
> > > > isn't safe to wait to initialize IMA at late_initcall_sync() then i=
t
> > > > would seem like this is a bad option and we need another mechanism =
to
> > > > synchronize IMA with TPM devices.  If it is safe to initalize IMA i=
n
> > > > late_initcall_sync(), just do that and be done with it.
> > >
> > > Within the same initcall level there is no way of ordering the initia=
lization.
> > > Yeorum attempted to address the ordering issue in commit 0e0546eabcd6
> > > ("firmware: arm_ffa: Change initcall level of ffa_init() to rootfs_in=
itcall"),
> > > which is being reverted in this patch set.
> > >
> > > Ordering within an initcall level needs to be fixed, but for now retr=
ying at
> > > late_initcall_sync works for some, hopefully most, cases.
> >
> > That's not a good answer.  Ignoring the TPM issue for a moment, can
> > you confirm that moving IMA's initialization to late-sync is safe?  If
> > not, why is this approach being considered?
>
> I'm not seeing any measurements between late_initcall and late_initcall_s=
ync.
> Based on this very limited testing, I don't feel comfortable to actually =
move
> the syscall, but can see adding support to allow IMA initialization to be
> deferred.

(I'm assuming you meant initcall and not syscall above, but if you're
talking about something else, please let me know.)

Saying that you aren't comfortable moving IMA initialization to
late-sync is inconsistent with allowing IMA initialization to be
deferred to late-sync.  Either it is okay to initialize IMA in
late-sync or it isn't.  You must pick one.

--=20
paul-moore.com

