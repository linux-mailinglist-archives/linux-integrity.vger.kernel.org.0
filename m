Return-Path: <linux-integrity+bounces-9330-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A83AvXb62kgSQAAu9opvQ
	(envelope-from <linux-integrity+bounces-9330-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 23:09:09 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C8046368C
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 23:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9B1C300916A
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 21:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C34231E838;
	Fri, 24 Apr 2026 21:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="N2LJTSm/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FA833F8D9
	for <linux-integrity@vger.kernel.org>; Fri, 24 Apr 2026 21:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777064946; cv=pass; b=emc0gzMtx+LwFmwcACfY73uKHJdPAEIbYPNAcGFM2zAEYU0bmoNh13wFSXbRqwXizjxzbvLcvM4LuaEL+rI/b8jk+wU+WTV2hXkbxQU5IZ/J7Xkri6mk8ZZspP0vXBgDZ5+sQ+xTcoJecf8dKt+1/ZlSatn/868fo+pMmqLTftQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777064946; c=relaxed/simple;
	bh=zeoP/9P2pLhahz91nxn+4EYf85rGHyQaiFHaei/lRpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQPM6z/PE26vlsgijDwIWQVAa6mAxg4wpjkVLHuxqWuIfusOKOlMGBX5kg3uoFWMbhvC0/sfQsAVwZXAIZ+KMuFkzfhSWcvuggTNPp+ZwfyL5U6W7t6CCzPiyNbffi7GzvWT1MDOU7hAuR8olOhnv1Au24CEcWscanwJ6+wUks0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=N2LJTSm/; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82f8b60e54dso5554654b3a.2
        for <linux-integrity@vger.kernel.org>; Fri, 24 Apr 2026 14:09:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777064944; cv=none;
        d=google.com; s=arc-20240605;
        b=RaSjpi38vd9X9NOnpw95yVPUVQrOIsiklwFElRZwslTScCXTt0pg/zcO1pYkvnKmh8
         Cn+VhSdxFcTFOp4TrPYEPjAM+OqTWsYlCQx18M9nQsfh0+NbR4NhmTpPDsvjVigHatEv
         fSpj7t3BEl0yCxn10JaCFkSu8/Bgrn+zceiWa8GTvySTPJrbDgvZmy+SYIzGXVlAEris
         KvvOpRl/UkdV25sxx3/u9al1Zi34hwzJDhtpZzUE9iTjRKYx2s0kSdrHEg49gt3s9GWn
         NK/R4b9dP3/D2wcTqPuq8rAY28WOhoKc/phd/GmyLu2lkMl3uDvwQGleH3nOpxrZBBft
         QkCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n1d+xjduzAM/MSTs6YplaFj6vz27O1vUoV9FGHND4Bg=;
        fh=YKTadAHkizwJAHNOsFyATjF+ka3AvDztHSReeIV/prk=;
        b=AJcuoM5SMTbLNx2+Q9rYXl3WhpYuzjgPocJt8Z0OfKud00QE0C6ZhXayaG442TW3ko
         KJXD8Q1kZdjG5A7rCE7+KdX9YhyfThUkqnshTmnCTl/u2NN4AKpB9iH5CFNPuiZZyp8h
         OJ1usRqOdxDNFe55EKXzkemGxx5focHlZQPkuUvPNiDJbolzAzgnnOInfs6U3jiyDtmH
         SVWh5AhP092JSagSYXCkqWfrpcjTVQBXw8vtIz8LGQs0mBEhacaCnG7kv6Yq+82h1BQa
         T2jIvR49acVNxff4R9l1dOxK4sooOxCdSmD8symynctg1G71D0RgU/GEXQIJ9sj0p6cc
         o3eQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777064944; x=1777669744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1d+xjduzAM/MSTs6YplaFj6vz27O1vUoV9FGHND4Bg=;
        b=N2LJTSm/KHpJhLjpXOk5CUvaf8N9Z2lWvCSN4T+aN8J024Tmi1rxa7XFbAn6SQoNVV
         GUH3RsEkkUcLb2mEil8n2lWVSgsqUHWzopkEn5SZOLtscsK58OJnlzSEIBtyUNQUYdvH
         +byH8FgfLqfo8JyqoDDaX13/nD89RlBBLIHlEC7StSUNl6H3Vy+2ru/vr7Pyh6KiTO77
         Ktu7kfiDHpGgJAO3HpK3SHkufojtSfEknYyaEYMPN2CzO2fOMf6IPeE80U1zOvPoPnRF
         YKVO3FZw3ZPo6kT4V9n3eWHRgTMdy32T8LzXSNotCcCqFEr1uCowrPfhLnDz66W+1ZwM
         dHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777064944; x=1777669744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n1d+xjduzAM/MSTs6YplaFj6vz27O1vUoV9FGHND4Bg=;
        b=q1MwLEsGMTQbqrI2tFgwhLVGssXrc4rT5XkCD9a6/XIKtcTDQ5ijWyAm55PSnXbvkC
         T99PgMtJaKwFmmHPDfd5OwbxW7NbVLT7fdq++CZtjzjqw/toohsh9KDEAMyWrOy+6rpJ
         GbSzfREMJG6u5fLsnqMcfar5CV6DQlGEGw3f21tDHlbJdrWcBRbYR4oa1ep8Ei4tXUyf
         d8TsA6Ogr+Eg5vZB3xjZT9f2VjGr9SSz9D7AtP0hr9KHnNxXwTxC56BVsty/EkqbA904
         fcrN7gE2Jypg4RhFCddoadZvl9+4pT9oq6IbcXPgqtaMkQ/1A1BEq6DVp8at3wlQhfJN
         sidg==
X-Forwarded-Encrypted: i=1; AFNElJ+gvlFaKPzBKbfVA39uU+5qBStqYbDHSwIt9hjVuw94VmiIdXEKUDuvUYNfXg60ZAVAhVFY/VwLGFtsFg5b9QY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaes/ZrhgjZDvDomjf9nYoAyliKBRPwvdNk8IhFCsEHrNHmhrN
	aMZeY0Phksj3+W19lDq4kPLS9+XNgWYoG/e0zdEGD5z19jwv2XuQzAezu/AVtRsiChc+OTw6+ON
	mEz6lSFjif/qh+ZQDvjyhl0fZ+Wg1nCJIW1pteuyK
X-Gm-Gg: AeBDies9DQ2ubjAKdHTlx1jdL4nZDStPWVKsJ9FcsA32xLndgBy8vcF5aPMZ36qM/1Z
	3QLdRqAmOeBXkXYy0zsmjmMzIB9MALe12Hh5nFlQgA9uTWc/TANmM3sMbVvLvJ+ih7Qz/3Dh/KJ
	vjoNIsdzlR1jeOD+gftRf6MuB0JjflDaaDc3zvF8KwoSgrqmFiTx+H35uOLEQ1Vc72jzYwx3C8g
	G1QW+gbUnLCqV30A0i8CLm7DW4GtLHiMzq2wyp7IRzOWRDmx9szEi8NjMlV2rsLNROKbMCvdpRh
	9LNG/pex4mlYf24O3A==
X-Received: by 2002:a05:6a00:b4b:b0:81f:3f03:6846 with SMTP id
 d2e1a72fcca58-82f8c97b854mr34295308b3a.47.1777064943538; Fri, 24 Apr 2026
 14:09:03 -0700 (PDT)
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
In-Reply-To: <014cf39aa8d6a0bcfa1a95c069675977ac67b843.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 24 Apr 2026 17:08:51 -0400
X-Gm-Features: AQROBzD9P2TWOpZi4hSjY4N4Nov3CnXh30sPXe4h_cg3LpJPQQpo1U__Q_DVo84
Message-ID: <CAHC9VhTW3=RJ8L91RWXYYA9tFjfSXGN-DMEEwdiD6big9H57Ew@mail.gmail.com>
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
X-Rspamd-Queue-Id: 64C8046368C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9330-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]

On Fri, Apr 24, 2026 at 4:58=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Fri, 2026-04-24 at 16:15 -0400, Paul Moore wrote:
> > On Fri, Apr 24, 2026 at 1:57=E2=80=AFAM Yeoreum Yun <yeoreum.yun@arm.co=
m> wrote:
> > > > On Thu, Apr 23, 2026 at 2:13=E2=80=AFPM Yeoreum Yun <yeoreum.yun@ar=
m.com> wrote:
> > > > >
> > > > > Sounds good. Once the patch is posted, I=E2=80=99ll review it as =
well.
> > > > > Sorry again for the noise, and thanks for your patience ;)
> > > >
> > > > My apologies for not getting a chance to look at this patchset soon=
er.
> > > >
> > > > This seems like an obvious, perhaps even stupid, question, but I ha=
ve
> > > > to ask: if IMA can be properly initialized via late_initcall_sync()=
,
> > > > why not simply do the initialization in late_initcall_sync() and dr=
op
> > > > the late_initcall() initialization?
> > > >
> > > > Does any IMA functionality suffer if initialization waits until
> > > > late_initcall_sync()?  If so, it seems non-critical if waiting unti=
l
> > > > _sync() is acceptable, as it appears in these patches/comments.
> > >
> > > This is the way first patch did, and here is some discussion for this
> > > (Might you have seen, but in case of you missed):
> > >   - https://lore.kernel.org/all/a6a0e15286c983d720de227c6827adbe976c5=
b9b.camel@linux.ibm.com/
> >
> > Thanks for the pointer.
> >
> > Unfortunately, my concern remains the same: it's either "safe" to
> > initialize IMA at late_initcall_sync() or it isn't.  Attempting to
> > initialize IMA twice seems both odd and wrong.
>
> Agreed.  However, IMA should be initialized as soon as the TPM becomes
> available, not delayed.
>
> In patch 2/4 patch description, Jonathan describes the reasoning:
>
> Unfortunately some TPM drivers (such as Arm FF-A, or SPI attached TPM
> devices) are not reliably available during the initcall_late stage,
> resulting in a log error:
>
>   ima: No TPM chip found, activating TPM-bypass!
>
> and no measurements into the TPM by IMA. We can avoid this by doing IMA
> init in the initcall_late_sync stage, after the drivers have completed
> their init + registration.
>
> Rather than do this everywhere, and needlessly delay the initialisation
> of IMA when there is no need to do so, we continue to try to initialise
> at the earlier stage, only deferring to the later point if the TPM is
> not available yet.

Once again, that heavily implies that it is safe to initialize IMA in late-=
sync.

Put another way, what breaks if IMA's initialization is delayed to
late-sync?  If the answer is nothing, just move the initialization to
late-sync.  However, if something *is* broken and we are just doing
this because of TPM delays at boot, this patchset just creates
additional problems and we need a different solution.  I can't
envision a scenario where it makes sense to attempt initialization
twice.

> > I understand the need to ensure that the TPM is available, but if it
> > isn't safe to wait to initialize IMA at late_initcall_sync() then it
> > would seem like this is a bad option and we need another mechanism to
> > synchronize IMA with TPM devices.  If it is safe to initalize IMA in
> > late_initcall_sync(), just do that and be done with it.
>
> Within the same initcall level there is no way of ordering the initializa=
tion.
> Yeorum attempted to address the ordering issue in commit 0e0546eabcd6
> ("firmware: arm_ffa: Change initcall level of ffa_init() to rootfs_initca=
ll"),
> which is being reverted in this patch set.
>
> Ordering within an initcall level needs to be fixed, but for now retrying=
 at
> late_initcall_sync works for some, hopefully most, cases.

That's not a good answer.  Ignoring the TPM issue for a moment, can
you confirm that moving IMA's initialization to late-sync is safe?  If
not, why is this approach being considered?

--=20
paul-moore.com

