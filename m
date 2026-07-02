Return-Path: <linux-integrity+bounces-9873-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0edbHmSzRmp0bwsAu9opvQ
	(envelope-from <linux-integrity+bounces-9873-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 02 Jul 2026 20:52:20 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C44356FC520
	for <lists+linux-integrity@lfdr.de>; Thu, 02 Jul 2026 20:52:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=paul-moore.com header.s=google header.b=RBNjGbk8;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9873-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9873-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=paul-moore.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C1AB317FE4F
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Jul 2026 18:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2B13403F9;
	Thu,  2 Jul 2026 18:36:35 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ABB344D9D
	for <linux-integrity@vger.kernel.org>; Thu,  2 Jul 2026 18:36:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783017395; cv=pass; b=K7qkc2FLpSCbtfzWonz3DS0K6ax/zBTbgOnEa8YBjEs2F7zHtqocvAlrA97t9UsalIx0ocyhFLjDTWJSunPEv0+XxXqiGFEPGNQkG2x/LodN7RIGIiog9ev8utD9GNEPRlnfcn+hO1Xj42nySmql58tneZKwB9CgToDL6ZvGCdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783017395; c=relaxed/simple;
	bh=PCLOCX/Eob7+UKaMpmopGS629KwyCWVOuoZRf07w48Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=THT9K4jehb21kffEkCMoxbqvVtZdg2FYMKaWYASuRE+7QEQcK7bOu/0rO2dNciS9WWe4IoaBn+6Ix395cQv0tEGts5/kDVqVvFY01E1NqwWzAZGtbb1ln47Seej2VZrC5lrDm6Dh7monqZTewEXs2kfXCLZ1tuqmO3EldgvV26w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RBNjGbk8; arc=pass smtp.client-ip=209.85.210.177
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso2178309b3a.2
        for <linux-integrity@vger.kernel.org>; Thu, 02 Jul 2026 11:36:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783017393; cv=none;
        d=google.com; s=arc-20260327;
        b=swSb2acFfeyNgHVbNsHC6Ir+1O9scyaMGuLiOvVA1KoY4hb7GEU2UDTQZIrCSjAws/
         hiWjDpXN9McspRLY0td3LuhzjJFtDrzccFqiW2fTVuwJV+ULtMbcSSYIk+T/jd92LOx6
         /Kdj0+GPcuLLoPgRSjE6rUPPlVVEZjGLGcGYUc1bAvcIOgD52/m/BOnPko3PlBMgkkgB
         RXcD0EuuaT12Q76FvezHy1DfD/F+2VN8NaHLGQ38sFPvMbjoPWEMvyd2uY5RXxQ//eq3
         cbHX0YqQ/Zm+0efNSouI/RXY7B4LCvexsy4aQqKHZqP3B99H5AE9N9Az0SCH4NES4CDi
         ZLVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NEhwGG3IOip9xw+ht5KLaONZ3M052iL+ytO4+Vh6eQQ=;
        fh=v2NmFqWSeJRUz5OFPlccLtv+pcHH/wMmMvsYod/xneY=;
        b=ntnHwMh8uvmeeMGanRdduyEo3N+Jx/VWiWGFjv0hgm2iIW9zSGjTWJwGF/wDgQpNIV
         lYn5x/yJ3IRfGWWqIZ+i5Q2nQ8NMsWfEskNO7BHUphD9nfB5KVl2KWEL0tmCuCqxAv2/
         eQSg5Kae5z6PCXTLXsTgcTVQk2JmNCnV9hM491CZvSNLfLCz+wKOR7tlpQn17f7w/ef9
         ifjrigJGqWD9WrLtogevKUoqmjez7AAZ8txTrsK1lEVmRRSYmvmOJpSNom01UJQOYHbz
         L4z6/nIQtGDOyoMYLgCOIcyF/AqwqlLcQY+ldVwKV0/AYIscAnbsmWXaAawCdIu7p130
         o8iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783017393; x=1783622193; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NEhwGG3IOip9xw+ht5KLaONZ3M052iL+ytO4+Vh6eQQ=;
        b=RBNjGbk8i5/xgotV+JBaOfWeSOdDiynADhSQxWoRRSQMuxEi3WdOU42fs9vBQhXdhs
         YhIy2A1PmuBEwa3TBr0qBITZpf0LKvvtbf/eB5s4gWWwd0NYZgDfsAQTQKQ1ELGhODDb
         phHTdWZlhuflWfxQU/nyzcyD08ql99iy9nv8tzdUXFDpxdkaVaM5DncklG0jbTd8xLuT
         YxcNAovY2kc/Eegyv7QE76FsbGUFLEGbGtD+CbbAJ5nGuocC4VOrChCE7REe3YMJk21S
         p4hB62b651Zz2ZgopsmHvXpOjofboKNNRId04EAbAg6tlW9Cme9+Woy+fBfomWyMi/1O
         5MsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783017393; x=1783622193;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NEhwGG3IOip9xw+ht5KLaONZ3M052iL+ytO4+Vh6eQQ=;
        b=T7xuC33WzyUmJ0N3Mzxzit6HyKLx/rL1SEnmA3R6/TaARph2Ch3e8Jxi8u6sHc2qHf
         PoFcQp/EIO4fn2YZ+QHqQRjNk9FCLvs71UZLoxfMgU9VTnnT/G6kk7R2U5cZQiL4LcBY
         /M1o0vC6VA7nY5RqSzM+7bhbJAoJRKDSE+jWheOrlqFOAQszFRwd+VHfZTprS+cBkClX
         3JH2DNlixcatC89OGBATmcOhanO2vvI6zTiqYaFdqsexzuRAYsRsmGmVYSDcRpiCwhOr
         QeabsgvGeWuTV9CTNI/30vcFTWETjxPN4lV4wBruKCZBKvwGSjhD3Fk4WelfHWXlwgKt
         O6uA==
X-Forwarded-Encrypted: i=1; AHgh+RolAYp+zfz/OiGULtVtg0Bg9oiHVU9KV+l/ibRSlrQlPU+ynRLB/rIKung92QjP9PjR1wnytIGvn6ncxlAC11Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlTSoEV+3YbxX93EOgJl295qGPKKQmdLpDj6Ph9gJAUPsZ8IYt
	QgLQUjDOKkTt/kp0cpbnZfJaRv7+0FGhobsmj7gTXxlDmqE3DIzsFbdcZy0vPWCWTccVMNRsWfQ
	RDuwdrgCg8P+004vtVwSn39aVouvsWYnjEuYCvJ2T
X-Gm-Gg: AfdE7ckdnskdSbjcPVNo/dHFNMDOaOqznWrNQKDP51S43MzdnPgczJjn4Um+TN63sKe
	f+Osu3aGJlPx2H5xDoNDCJhxED+CKugK3Opd566ze2FQ50blHxrRJaLDpb6kj6+UZz+VzQo9vKn
	n1wUMAotTdHmQ1QkxoBnM8LHX9fgUuD1sT4RH5xIHKJHEfo56eYoVJbFufFE9KwXyJFlyludIWo
	09W6vHKL9RA+iosDqzREWEFlGErZXpOM0HegrG9vzChFQD00QLZDmu01X6cN66GOHagYIeP
X-Received: by 2002:aa7:88c9:0:b0:845:dde9:ab62 with SMTP id
 d2e1a72fcca58-847c07a0812mr7482037b3a.19.1783017393051; Thu, 02 Jul 2026
 11:36:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605144325.434436-1-yeoreum.yun@arm.com> <20260605144325.434436-2-yeoreum.yun@arm.com>
In-Reply-To: <20260605144325.434436-2-yeoreum.yun@arm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 2 Jul 2026 14:36:21 -0400
X-Gm-Features: AVVi8CeOOyE2Od7gNJBo3j-LLr7BLyJYgunVuD-VezKTeBhB5ZlmzgqKWCJuEks
Message-ID: <CAHC9VhQXwXHjKcr0SRNQyzKZgCwG1RLPT6kWDLLwEKExfXzzOw@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] security: lsm: allow LSMs to register for
 late_initcall_sync init
To: Yeoreum Yun <yeoreum.yun@arm.com>, zohar@linux.ibm.com
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, roberto.sassu@huaweicloud.com, 
	noodles@earth.li, jarkko@kernel.org, sudeep.holla@kernel.org, 
	jmorris@namei.org, serge@hallyn.com, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, jgg@ziepe.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:yeoreum.yun@arm.com,m:zohar@linux.ibm.com,m:linux-security-module@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:roberto.sassu@huaweicloud.com,m:noodles@earth.li,m:jarkko@kernel.org,m:sudeep.holla@kernel.org,m:jmorris@namei.org,m:serge@hallyn.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:jgg@ziepe.ca,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9873-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,huaweicloud.com,earth.li,kernel.org,namei.org,hallyn.com,gmail.com,oracle.com,ziepe.ca];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:email,vger.kernel.org:from_smtp,mail.gmail.com:mid,paul-moore.com:dkim,paul-moore.com:email,paul-moore.com:url,paul-moore.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C44356FC520

On Fri, Jun 5, 2026 at 10:43=E2=80=AFAM Yeoreum Yun <yeoreum.yun@arm.com> w=
rote:
>
> There are situations where LSMs have dependencies that might mean they
> want to be initialised later in the boot process, to ensure those
> dependencies are available. In particular there are some TPM setups (Arm
> FF-A devices, SPI attached TPMs) required by IMA which are not
> guaranteed to be initialised for regular initcall_late.
>
> Add an initcall_late_sync option that can be used in these situations.
>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  include/linux/lsm_hooks.h |  2 ++
>  security/lsm_init.c       | 13 +++++++++++--
>  2 files changed, 13 insertions(+), 2 deletions(-)

Looks good to me, thanks for working on sorting this out.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

