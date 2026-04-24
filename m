Return-Path: <linux-integrity+bounces-9313-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHMnEBfH6mlhDgAAu9opvQ
	(envelope-from <linux-integrity+bounces-9313-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 03:27:51 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E7C458B7B
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 03:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00755300D69D
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 01:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8614223BD06;
	Fri, 24 Apr 2026 01:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JrEsM9iF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1045F23EAB0
	for <linux-integrity@vger.kernel.org>; Fri, 24 Apr 2026 01:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776994065; cv=pass; b=qQmuDETki9Ablbn8lKqGnA+OsBuuFd9n5Tta6zfmQBI/2Vi5kSpGQG/+EcrDPFa3gdm1W9ZJkZVR1N8VFSL8IjwHubVSOftjKd5M6M9aLdEYzwW5qVy2Ki9pOa2LPqAKC2ZIUMojkl0Zjs0jnLDWz7sCCnsqIWvwuuql9LFgfWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776994065; c=relaxed/simple;
	bh=omKa/2WdgusmHEfGk+KJhSzPUsH5UhfYeEoCCOvHE4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VV8cCTTFc9/qyjv5FzSq/sWKuXqpht3V2FIbJ2vcpgTMbm15r7ta4XN5SlyI8NzdXHxFNwUTWGpZqtJAAPLn/AKgxI031FAx0+SdHl5FcHzKlzc4CRqKdIKX76HDwEoev6g7MXZgvAWBbLVX/LP9BLuYeY9LVVmTiBc/Vi/wqZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JrEsM9iF; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-674a44b84fcso9577471a12.1
        for <linux-integrity@vger.kernel.org>; Thu, 23 Apr 2026 18:27:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776994062; cv=none;
        d=google.com; s=arc-20240605;
        b=Q337seJGpIs+PErfrx9mlUI/nNrLsHTyt2GBd4M9aPkE0fHmnac4A0Q/q3ef8/7Trr
         TDtVGyU+prZDFfn2L0wRdWOtnQaAasj2kyHg3JbRsbfERmRqUFW5xUqm7/DimtcPmO6q
         RSUIJvpgiIG+QQ4yCJDkvCsXreizr9e8gRBF4/X1OsjMfe5b4CTcsvpX1BYFH9P8FZa1
         QMxW7BNHx9XXxI8831flaHRpFBPsuWyYERorExped5pklRNg5mlZY9FpgZa+W4I4XM1N
         xoQTnbg0Ql86YLVzB0kF9Xso0TMgLuxjptEj7/vefhs7EziV+OEK+gCtsN8Ze0rX0N1O
         n2wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RYR42p7JO/QHsKTGPNBeEQu2D0vGgM3DHEt/tjHMAQQ=;
        fh=h5TTGXzT4o0Ma53epSJMuUDG7RsV4dBvQ4Qyn2mPg9I=;
        b=O061ADpHc2k2jKxC71YiH7CcGJEX34iIYIMR7EGdxv3DaOTpX/ww8Lz1IulbH+mp2H
         JNkYQ1Rf/NZrzYB9NHdtHVzAhrfSkHu83RDWxgR3qGMUdGH6HeGjxes4n5TsT1WdDjDB
         hvYvqojb3Jx/vkmfZ2x+xRW0oFe6DnFJbg729OOGPyHJb29KfzDhsgZAdp/fMP3RUpnS
         Knap+Ew4+hI901lGG1nGDkjcnUYQukH+KaKkq55fIE4D3/65MzUWI2o60qgzF3HonwOn
         MZ5KyX90DK1lRMEEvrE7MgFQ/Ohy9snhs4xuc42UViTJaN1M7iTIJTMROOV0fkPSpQz8
         LRJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776994062; x=1777598862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYR42p7JO/QHsKTGPNBeEQu2D0vGgM3DHEt/tjHMAQQ=;
        b=JrEsM9iFt/sejyQa35LiP8Dq5cNpHlGt5/aaRcTkGq7mpXlONG2rPE+YhdCcJhbAKP
         qd1GGGEkQ+ldyZ+7Dn61Cjk1qm46BvCq9DO0RVHVHaBFL3U/l2K/DjQIE7oRUAfjvize
         PcwgAt95PeIuLA7BHo2KrnDz2YUDRIj6FjhdgPWYfZx0umumFlyCYLTRTOe/WdzYVQ6c
         TUDsksgmlKz5t7FP6PK8ei7HzUPpJgjtoT6CdRqiTTb5mYi4MR0Ec7bmhKTLPCqTqp/p
         pArLgcH3iSfosqaC91dH4HmDLTcwYBZeftXwcLRGaZbkt+1itAU6gkrmxENRMsCr7Pq7
         bwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776994062; x=1777598862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RYR42p7JO/QHsKTGPNBeEQu2D0vGgM3DHEt/tjHMAQQ=;
        b=ezqWFmWYlhoHzgSbDWVqI305jPdyviOAXRq2Pb4d6RXGEjMWrwKx3gaM/QFbQ0vK3W
         j+lWcReJ+XPDJ3dDfXQPdc7iVB0kvYTb3ULGDc2AXn8s9b2DDAku5mhRHvHZdzHTVD3i
         GKXDAm+glS/jFNNK7hoN/BLdJsa+nKyXgVD/RF0nwPC03IWHpKXBvYedCrlVgomtefM1
         HUmfDUyofKOiA+COFCw/75rYMnqXSoMnnecvyLelxiS85G+JHv8kSkr7LSUb775sShXA
         HQEHaLOpFGBy4jx3A4M+EHM8djy7/D/yNxUyl7BUuRxm6YNTYn9vkoqychsZhATjwWaT
         +TMA==
X-Forwarded-Encrypted: i=1; AFNElJ/EkhM+/97D3B+WEXud0dglRkdmCH2m9Lu91v7Xo1CtAov98t0v+ff8rdzmVgoF7aJGhMim/zqLSfBWnjAgMRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMTafv8zpYHXhQin1ZFLmH6cCQJp/y17SHmsj5M99M04fEnGY9
	PNfblcj6jIzKxvtNsztDRRpbUXtxEAZtaPuYqVmsrpiAWrX+i6ZkwEkeIAtLcIIVK6OyCAJkEpG
	2KJV3i0du3hGTnUY83rpTiphtj0W2csSfC9ofUVwO
X-Gm-Gg: AeBDieu9KnACksARlR9iZME6GLgEc199OfFf/Z9lfcf0jSYIuXpdwnyW3i+rfPOQYIa
	ky4Kh0h+RmojJUIbevjCprIFBbNIyponVzd2j9Hn3QOsNGswImJyCODVGRKfYZChY0bkut6Ihwl
	IFR9SH5j7OyD+tbY86TWisdHNLHRAz1FmUPLEtu0019AItKNNeEd0xYQXEdVxe5LpHOYHUXdMyw
	zoeEK1bR1a8p8b2XeLDUOnkLdaY9j0tJ/HzWOf/jEZxgwLO5RRECCgbtT/uc+Yu8aFmfVlyNT3X
	jIycBDWt582MFhUwMW1PDv3Vo9dX
X-Received: by 2002:a05:6402:28c5:b0:678:7da5:2346 with SMTP id
 4fb4d7f45d1cf-6787da52508mr2108038a12.25.1776994062317; Thu, 23 Apr 2026
 18:27:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aem0SSQuE1e3pGOS@e129823.arm.com> <56a8aab50a3b5ce0a345fc2079fb2abc7d0f1b23.camel@linux.ibm.com>
 <aeoAlVEwzRUPrlVe@e129823.arm.com> <aeoRxWPyOHGJd+Jh@e129823.arm.com>
 <aeoWO2Cwo04YYu2l@earth.li> <bd908e28298d968740d03c97bc7e441de188b7b4.camel@linux.ibm.com>
 <aeokwrC86WI7uT+K@e129823.arm.com> <aeomlp3I0eVE5mce@earth.li>
 <aeotq8nPVu4wvEx5@e129823.arm.com> <e4e242ae5533d5762a3647186a178764881bf9ff.camel@linux.ibm.com>
 <aephL3MzYoqFGaT5@e129823.arm.com>
In-Reply-To: <aephL3MzYoqFGaT5@e129823.arm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 23 Apr 2026 21:27:27 -0400
X-Gm-Features: AQROBzCKchqlqq4fwimM8FvKvU-_em0HAaY4O5iQxKuvqQBuL1WqJdLvyk10CT8
Message-ID: <CAHC9VhRQWHEWQ5NzOPiu8jtYv6UsRm8WVS4fd74AbkOcAd4y_g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] security: ima: call ima_init() again at
 late_initcall_sync for defered TPM
To: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huawei.com
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan McDowell <noodles@earth.li>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, jmorris@namei.org, serge@hallyn.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jarkko@kernel.org, 
	jgg@ziepe.ca, sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, noodles@meta.com, 
	sebastianene@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B3E7C458B7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9313-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[arm.com,earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,namei.org,hallyn.com,gmail.com,oracle.com,kernel.org,ziepe.ca,huawei.com,meta.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Thu, Apr 23, 2026 at 2:13=E2=80=AFPM Yeoreum Yun <yeoreum.yun@arm.com> w=
rote:
>
> Sounds good. Once the patch is posted, I=E2=80=99ll review it as well.
> Sorry again for the noise, and thanks for your patience ;)

My apologies for not getting a chance to look at this patchset sooner.

This seems like an obvious, perhaps even stupid, question, but I have
to ask: if IMA can be properly initialized via late_initcall_sync(),
why not simply do the initialization in late_initcall_sync() and drop
the late_initcall() initialization?

Does any IMA functionality suffer if initialization waits until
late_initcall_sync()?  If so, it seems non-critical if waiting until
_sync() is acceptable, as it appears in these patches/comments.

--
paul-moore.com

