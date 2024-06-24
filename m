Return-Path: <linux-integrity+bounces-2928-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CF6915991
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Jun 2024 00:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3835C282971
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jun 2024 22:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493EA1A0B04;
	Mon, 24 Jun 2024 22:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XGql1k/o"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BF9135A46
	for <linux-integrity@vger.kernel.org>; Mon, 24 Jun 2024 22:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719266602; cv=none; b=N1AV3g4Xj/fWake6uk6MgNgPJ6Qqbe9xYgwiRIKBeQ8yzre0I22ErgDfrMTI3YxOjzkAOqMH+zuBCenadRNtlcrepJ01Fr2MJAM5eiXYSXGyP7fCXRQOI+o6CnSXwVhDVOjgQ1M/FeJPg/IEvbCQxDh30rr3kyFIQzloEzkDQbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719266602; c=relaxed/simple;
	bh=yH8MfUsxyrSONQCCxY9KuK40EJoit1iS7xUJ625+yHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIAtnzX/oNHCCVOW1YlGvGLCxJUb6VPevfRN7D1VIZEtXTN+G5mWEYfXulB7wkq7iLPLQ/IJocAmVzXAs5n92Zc1IC/xGdcnoDzrIU2ID+toDXI92pYWkwi8VPk3S1afXF/pMSIt988FQmphxYdXu4/kVE/0Islx81lTh9Ony9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XGql1k/o; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e026a2238d8so4776006276.0
        for <linux-integrity@vger.kernel.org>; Mon, 24 Jun 2024 15:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1719266599; x=1719871399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52bKNmTPMX1ld5a7SIGDY7nHZbkLXq2rSTU0Z66Dx80=;
        b=XGql1k/ooTfR7P9hrEG0198RrU7si26Qf2OhTlOZA9tTb/i0jbkTdnshvkn7Dp+cwX
         ZraAKuEDk/LqUGYo4C+aw0CRegziNRns9JQjoA8genXXTxzpR/TzXD/s9ilfGn9Yy7GK
         qJxPwuuruw4mtiql9F6VVp95RFmdHVYj6kodrAWMVHiuqdJzZrKwdfrQTdprKmMLNg7d
         o6Qrssqep86q25ZQxaYeq+hRREzWXNRx54idMFb2Ds/6/xnCbzwV2wuQOGozBZfqtnhD
         MjLZtuUuz0rZEOHwnqR7YARy+s/0TIci0a7rC8TElLnoHmxDNwAFsISiuV9cgh1epRc4
         tgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719266599; x=1719871399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52bKNmTPMX1ld5a7SIGDY7nHZbkLXq2rSTU0Z66Dx80=;
        b=mUjARnDgZFygSvXVIL3F321A9dZuC6GCiHQdieA4wT8oFzkvDuC0Hm+sapFwWjQa1W
         VcB3kgAAelXGvdUH6mFuxpAfwptTjEqs683iYZHqKOGuuoCIUrthKEu0hYJu4Q1VuKhG
         lCss/ua3z/IITHbb6xKXeMomQUKsW9DuO3g6GmafP1+d3vHToCKwAeDRbXzFzcjLvo3v
         mUx0mpYgKfUbXt8hP4+yQWG53+5wfyTkLKqaxC/2O6TWfjchgyhmn/EsOVeupFEGxWHB
         EE4RM9RtGpTXFHoUF+TmcFwflIdcw8BNUSmIh/Za5E9lOy8REk6Za5JaP1PcMgWRM6k/
         AO3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhDlBhQVDgRjviQi+cAWLav2j2Leq/D3Nzq5rW7icuxEl8pLi/iI8e+RJh4z/4LSFewxi9kTUjWO0xnkdhvUbviNOxVzdr4UxYzMD3Dna2
X-Gm-Message-State: AOJu0Yyi414A09tt2mw80ZoOS3zcpCfJS5EkllgQhNQ5D/01WgNou9L5
	RTCr2vuCjOCL+zF4nAY3PIOUnHKx3hfQGUgFNP+lAt3Oac4wXWNPAhlzELjGPPEtC32LLHW2FsM
	xOF9aHlFfnlGq+UvsQl3r8PdXyZBQWX11hWSq
X-Google-Smtp-Source: AGHT+IFUpMslya+1feOYS/lW/ARrTRBvD2ducNjI+59U24eltD8K3QjUiXHcvx0G4S+F77LJwubGJrAIyigNmk0ZP6Q=
X-Received: by 2002:a25:8709:0:b0:e02:68d4:69e5 with SMTP id
 3f1490d57ef6-e0303f2ac79mr5746142276.2.1719266599569; Mon, 24 Jun 2024
 15:03:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215221636.105680-1-casey@schaufler-ca.com>
 <20231215221636.105680-2-casey@schaufler-ca.com> <CAHC9VhT+QUuwH9Dv2PA9vUrx4ovA_HZsJ4ijTMEk9BVE4tLy8g@mail.gmail.com>
 <CAHC9VhSY2NyqTD35H7yb8qJtJF5+1=Z4MHy_ZpP_b7YDT-Mmtw@mail.gmail.com>
 <fbf7f344c518d70833398c2365bb2029480bd628.camel@linux.ibm.com>
 <d953fac4-9dbe-42a0-82eb-35eac862ca6a@huaweicloud.com> <CAHC9VhRKmkAPgQRt0YXrF4hLXCp7RyCSkG0K9ZchJ6x4bKKhEw@mail.gmail.com>
 <aecad5ea129946dbf9cf5013331f9368ceb84326.camel@huaweicloud.com> <52bffc64dc7db2cc1912544514008eada1e058a7.camel@linux.ibm.com>
In-Reply-To: <52bffc64dc7db2cc1912544514008eada1e058a7.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 24 Jun 2024 18:03:08 -0400
Message-ID: <CAHC9VhS8mC0NC=-gbK_xBq2Ry6Be76ARZSg9Zm3y0bsocGEtTQ@mail.gmail.com>
Subject: Re: [PATCH v39 01/42] integrity: disassociate ima_filter_rule from security_audit_rule
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, mic@digikod.net, 
	linux-integrity@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 9:57=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Mon, 2024-06-24 at 10:45 +0200, Roberto Sassu wrote:
> > My only comment would be that I would not call the new functions with
> > the ima_ prefix, being those in security.c, which is LSM agnostic, but
> > I would rather use a name that more resembles the differences, if any.
>
> Commit 4af4662fa4a9 ("integrity: IMA policy") originally referred to thes=
e hooks
> as security_filter_rule_XXXX, but commit b8867eedcf76 ("ima: Rename inter=
nal
> filter rule functions") renamed the function to ima_filter_rule_XXX) to a=
void
> security namespace polution.
>
> If these were regular security hooks, the hooks would be named:
> filter_rule_init, filter_rule_free, filter_rule_match with the matching
> "security" prefix functions. Audit and IMA would then register the hooks.
>
> I agree these functions should probably be renamed again, probably to
> security_ima_filter_rule_XXXX.

It's funny, my mind saw that the patch was removing those preprocessor
macros and was so happy it must have shut off, because we already have
security_XXX functions for these :)

See security_audit_rule_init(), security_audit_rule_free(), and
security_audit_rule_match().

Casey, do you want to respin this patch to use the existing LSM
functions?  It looks like you should have Mimi's and Roberto's support
in this.  Please submit this as a standalone patch as it really is a
IMA/LSM cleanup.

Thanks all.

--=20
paul-moore.com

