Return-Path: <linux-integrity+bounces-9350-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOhlJ+cN8GnTNgEAu9opvQ
	(envelope-from <linux-integrity+bounces-9350-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Apr 2026 03:31:19 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8BF47C63A
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Apr 2026 03:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59419301EC76
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Apr 2026 01:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381671FDA61;
	Tue, 28 Apr 2026 01:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Jshz+lx4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B545C1A6816
	for <linux-integrity@vger.kernel.org>; Tue, 28 Apr 2026 01:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777339874; cv=pass; b=POga1xrv7XzFRHdlH9mTSW/igZlLyjLW09aOUV7vKQHHIjNLo6iCcWU3U/Y6o17DXf8X9U0C737o1mGoJT/yEmAdMclaTOVc7oF4v3RcDUJKAukGMitNMiPBDKvZd7Lu6+PohfFPbPr6n1n/IYpIE5CXsM25cS82DeNZZBjNFMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777339874; c=relaxed/simple;
	bh=4LjWAlj5OfE6nPz04HGOSDf6N9TOZWCWJub84K9Shb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nLld++xSdQvH5S5TlsjYP/qtpislMNm0AURdXZPHW3c1gMf7VFDAey4vwY8K4mGfslFcdEUP2fSMU+Rh6R6MgDeoB0CL/PihmhrGtJmU7jVlHdc8nnDbiv/tIs8Hk25UzHHS4Vtl5lKr08fz/wLIgV4TzduV7Mes+ilcUtLBy2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Jshz+lx4; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b788a98557so53887125ad.2
        for <linux-integrity@vger.kernel.org>; Mon, 27 Apr 2026 18:31:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777339872; cv=none;
        d=google.com; s=arc-20240605;
        b=FPOV5hsTyGecEJc0c1+OSyj4X4wGrGSDrIP+4e24Tk9yeRdDFkJ+FnZMQOKni4XMrD
         eV8OQPF7eCCucrk2/EdNJArsimHHGm2Z0AZLJoXLbTOz7N5Uj5a4qrjF54RyR9WZR2aI
         6GqsB279t5O62cRVz7D6j7XID5C/WmwV7durDn9v6ACO45Th8/znJu0Vd4Ejzxc7sOgz
         WC2XaROFAw9aABbnSyJzHEEw2CIarjakr2C/QCU+aW69A25tCDNXLSxS2txG6YjIFlxY
         52cMUGhp1Wt7n/lHvT2fAe3Ic4d0fTsQHLzSVQwPPlIhTIAyrXFzPjNvXCCRtV/rd8MS
         eN3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HVDB/J4GDc58D/rJhBbvpxXUYt1f3iejtI1opWBv6+Y=;
        fh=oL0RhAF0eyNRERze3zr2DJ35Ieody1KDbAUkaAPOT7s=;
        b=KiU6blIf4N/S5p66Z3JhQ1AprQaQoAMHHeQgS9xLz+6jOqsdQDowkEv/F+bGzMQp8j
         tPJ9nQNrrUbMBnl5GYxV8qvOWxM3HCXDIqJhX1NuLcsPBk+OfeAHtlcZ6XVFqpdF70+x
         /xAcs6cGDKGRoT4TvdVngry2EVsWazeeqFm61RKiwnuRZoeliLeJmgr6H3q3gKNEsg1J
         KL6zG/5ama/DuvStGvbdiNCMHXAPnfwquW4Rnmc8lEb3y0tTxZ28Px/H8Z9bwpIs3xHH
         TdlLPsid0JejKkZicpQn5B+nyv7NLQPqj027pAU4r/l8KEzSu74jMVHRlsjd5rG9i6Jd
         BH9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777339872; x=1777944672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVDB/J4GDc58D/rJhBbvpxXUYt1f3iejtI1opWBv6+Y=;
        b=Jshz+lx4V6ToxrGPKq5mfuy6KD4lr2wru9VyoQgBQb7JRcPMdXlWKbvz06kOJQOD2f
         hwpjUS0olBK3xC5Egm4efbPD9fRY5T+DVLvCH3RZR7GEnlj+oej4WIj+nBLEHNw6A598
         7JJqLEw/0PGyYGRztUTiE23EhZl+TXDheZ6I/uosHB0WB7ElOXARF2xmiRFxcsEU5/b3
         13g+LCMEIN+RMdRxFW6Q2AX+prm/ulYcYzrJ6ZQKukdfpPGxLnBYuKXzfzogEgmExGoZ
         zvw0RW27eGJ17R1pvo5HX/LlzTrGtLCVJMFm7IcPvfvAPZeSstw/hPgD4jNgprmWLB27
         9UxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777339872; x=1777944672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HVDB/J4GDc58D/rJhBbvpxXUYt1f3iejtI1opWBv6+Y=;
        b=otBIZTm8I/9oleU2Do3C8sQu3633lDt6W+YRin89/e4jl06q7F9l0/bJGl7HQvARL+
         ofDxN50euEiRK9mLRN0OZc5o8ghpBm0XlhJim4D1Jiuf1xdsd3mR1fRl/AWijmLx8f/y
         YJDXK7J8SwHVygCjfO6BKvtDmnO3FDdyzkXVu8hrq7pZIe6uKgE8bp0Zk9fr5/R9QMgg
         kPFyx0rXdvKlTtIwTN13GCpkYCZyNLsUTQrNiQ7Ny9/CwgyftxT9NwqyezZsWC4Z9NxY
         TLGmxzQ0Kw0WRbirLrREKSbaBjdT1SpgEgPil8yS5ovD1unJJTboBN/4Kw0jHTEZX8jN
         EAOw==
X-Forwarded-Encrypted: i=1; AFNElJ97mcCgI10xLcA90ipPHO4s1qDCEe7Z1A8+yoxIhONqqhdTS1YbRAai3oQES/0lMFNpfydx/kK7k1eDJJaW/JA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVk30MUD6+lNpBgubrwDTsc6fi3QcG2yPQWVKkrpHpZpkAGhU1
	tB2c78kSDE1qOKABoDEOSqolB7Ki0tqARy74DgqZpFHwxiV19pay6GsnlsDQBIzLSELIc9hrNCm
	+YOBsQeXlgXRDJK5vjwTyzYQubjci9Jr6XeSplAOS
X-Gm-Gg: AeBDieux0ovQet8NHrV+ygLkCb9cT0aWO8Hz6QtKIOLdtTRWDZmr77aKPSRs1UmzP2L
	mSr5IYI2JCVvDHtiMu0Zbmv/pYzqnK7FQydfmVszt2Ze8jexr9kIc+uabDa8+PqnFn3Z3v4Ifsp
	pQbTaDHRqVqdkaGl0oMnjhUTh5u4IPJYfAb6LBLHVUlhJGi5wryVkcy/sD11lrtjcVljiPOZQD9
	MwMNlzsiKhExHo1Dp8/uFf5iA9AlscF/oPp8sJN/72hXXFahY37Chc6uJpSH38F8vLFQxodVtdO
	imj0c+fhfwZAVgBf9Q==
X-Received: by 2002:a17:902:ef52:b0:2b7:88d8:efee with SMTP id
 d9443c01a7336-2b97c479823mr8581955ad.28.1777339871992; Mon, 27 Apr 2026
 18:31:11 -0700 (PDT)
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
 <CAHC9VhTW3=RJ8L91RWXYYA9tFjfSXGN-DMEEwdiD6big9H57Ew@mail.gmail.com>
 <1f78fc75b2e95239973612a4b6c4cc782960b7ac.camel@linux.ibm.com>
 <CAHC9VhS4JmPmCJrYTdbjxb3TO-uK6cB3Zij-ef=wswGce2BGzg@mail.gmail.com> <1e51c2fd090e5ceb07b1d09e50650c70fd3ccdb1.camel@linux.ibm.com>
In-Reply-To: <1e51c2fd090e5ceb07b1d09e50650c70fd3ccdb1.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 27 Apr 2026 21:31:00 -0400
X-Gm-Features: AVHnY4KFlOUWIpfP4Gb0UYo42YH7fwp4lG0sflhn6Go0itDdLXH-l_OT6jI63ko
Message-ID: <CAHC9VhS_WgwhW_NDO91LoTeSzdieGqbwqnwPq8KpavH1_Lwi7g@mail.gmail.com>
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
X-Rspamd-Queue-Id: 1F8BF47C63A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9350-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[arm.com,huawei.com,earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,namei.org,hallyn.com,gmail.com,oracle.com,kernel.org,ziepe.ca,meta.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

On Fri, Apr 24, 2026 at 6:49=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Fri, 2026-04-24 at 18:10 -0400, Paul Moore wrote:
> > (I'm assuming you meant initcall and not syscall above, but if you're
> > talking about something else, please let me know.)
> >
> > Saying that you aren't comfortable moving IMA initialization to
> > late-sync is inconsistent with allowing IMA initialization to be
> > deferred to late-sync.  Either it is okay to initialize IMA in
> > late-sync or it isn't.  You must pick one.
>
> Yes, we're discussing late_initcall and late_initcall_sync.
>
> I prefer to look at it as being pragmatic. I'd rather err on the side of =
caution
> and not move the syscall to late_initcall_sync, than move it.

If you were truly erring on the side of caution you wouldn't allow
late-sync initialization without knowing if it was safe or not.
Determine whether IMA initialization is safe at late-sync.  If it is
safe, move the init to late-sync; if not, keep it at late and figure
out another mechanism to sync with the TPM availability.  If needed,
you could probably use the LSM notifier to enable the TPM driver to
signal when it is up and running.

--=20
paul-moore.com

