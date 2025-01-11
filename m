Return-Path: <linux-integrity+bounces-4532-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A434A0A651
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jan 2025 23:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC411689C2
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jan 2025 22:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC521B87D8;
	Sat, 11 Jan 2025 22:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnFCiTEd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E25D1CFBC;
	Sat, 11 Jan 2025 22:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736636271; cv=none; b=ZF1CZi/pPISDV+/TsrLgBfvvSAev8xzuPaxUlooC+YSXa/2YXK1fI22uVpBy4qWKBr2+/AveMu8gESwZkcaNM1ht9uGkK1QJAzH/laoCNwziM1qt4zYE2xD2Glo1Sl/IWu96l/PkQ32g4jgz4x0z91ixKeFL3308O/MTOcDShuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736636271; c=relaxed/simple;
	bh=QdwmCQ8TIYQxPkMVefG7zhnNPlqpTIj45cxUSDtF048=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeHVjK9CcsjRdl0tgr3uVvmC0jQJQaLCHmNgLwVdSEBdk2CMLrYAPg4nrQ/H29Tt5dpgyXmDC3rRgD/oWxK7FKhoGo7WTsCroZAX8Xja9UgsIl3Scot9+8QTFViYgnWCdjSG+viM3HCJk4YI3gnk6soNrxtDMol/d60Gpt83zi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnFCiTEd; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385ef8b64b3so2813543f8f.0;
        Sat, 11 Jan 2025 14:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736636268; x=1737241068; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WCg8xb2Xo0sCdKeVm7YztXx4jNd36j2wC37CJSNkcMk=;
        b=JnFCiTEd1LhRNt5LhQX/vU8+71cyDpNiNbGc8awEHCwupyiJgnkxNamPrrLeRs8eth
         U6eBYtAQdrHzJ/+Tu8/Sp8NhiD/K3SwzwpKwds0WRh9JhUQWp6z0P6HwLDDPYBj7PW+8
         +qGChfLkmz4/g/MyzPhjeTm+WkJX2OflSo3yU78Ng7YkRWbGLJ3v+NB5PUd4H21wCBlU
         CXWRlzD8nEYFVOWL6L+L0SerqJdsaSsdbl5sL6laOll9FRcdjliWHiih0CpwEnyaP4E+
         3Lozp0NUBfsGANLHBU56j2/xq5/WnZ/0pA65+92ClUi/VO+E0dZfWgSX50Ebxe9Ax5f+
         d2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736636268; x=1737241068;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WCg8xb2Xo0sCdKeVm7YztXx4jNd36j2wC37CJSNkcMk=;
        b=LUQMtMiqvqk0ZyGtvD4iNiaAKi5BZ+K3sF3bCLaTlcUZ31u/vcHc/jbiRZn/0ehjJW
         dE/2JgbisMySa7Nr0DCYKiXvT7wdMMG2sTVnkvRzKvbffeF0OLtjJXMuAlfcU22C/r1R
         kpZ/tzSg7BlAzR9nZGk9um30QcV2a5EniCSnPIAK9oyLUPv5HEd9PuvFjksL/9toxYQq
         2CfGtXqrDzbFmPgN2veW0jnlKyIZ3ezp1PhWylMZV7gUfSDsg2rv2SZvJwfwbUKOM3bF
         vliNcIZlL2DsAF+lE2Dh803tR/tCmzdzj3EQFv7vnOy3I2PRUMKfXbZSS/RXe+0fkf6Z
         zEVg==
X-Forwarded-Encrypted: i=1; AJvYcCVcyYjSpiRbXZiNFGwMRemfQUsPbljoVaJMjf3kA/BfSzmqjI3XQWtQkbUERr2em/4K4eOeszRJgFIZz+T3Fw/Qu+vUwaPx@vger.kernel.org, AJvYcCXhe3cKyiABwuyOTBOJsineEuOT0ISn+e5t3tBJTylhwSv+puK/iGFXW9JKSfEt8z6vyFdLeZlkFyJ1WojY@vger.kernel.org, AJvYcCXv8u3j7kly5LRz979go8vs48FUSLzlEsaWVaiVW5VtuubSBW1fZBE1G4SP12B+QUd2UzCb5x8jJ1AS5fpPA04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz0wn9t4mmdvci05+1ISOb2gLU38pv/3Wc7uHncI7/SS83W7uY
	OCqrOumEFMzOFYKsU3Sk/v4vrFu7AgA2C0KAtFKvJBvQJmytVo9d
X-Gm-Gg: ASbGncuTWd37Ln62UPvZD49QhfO7tuDfetIfAY4ppDgoq2jL/2dwzxEwEEKvqW91N8V
	mMPPjF68NRtnpXtPBx3b0GfngAbmLKoQrt3p3J8LH0pG8JEl7MEwMj2sr8uNhagRj8BXXWml9Nd
	Amw5yq13yQDmxSan11qdLQ8crq4lAUIeL9NoE1P7OirEDYKD3J23pT5eu6aUXgh4IEwrEY0kl+p
	JO+susTSPlZ1WMtdAISniomBi+Wi1GpOw0hoU7ulVnGmkVQllNKTg==
X-Google-Smtp-Source: AGHT+IERK75MQXlZrMsw5ugl1zvCvzHVzDpi46b4X8b1ULkGHE0Lp2HvsnlaXz59QeqobQgHNn2/vg==
X-Received: by 2002:a05:6000:144d:b0:386:3082:ee2d with SMTP id ffacd0b85a97d-38a8730fac5mr12551076f8f.41.1736636267724;
        Sat, 11 Jan 2025 14:57:47 -0800 (PST)
Received: from localhost ([2a02:168:59f0:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1d13sm8310900f8f.91.2025.01.11.14.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 14:57:47 -0800 (PST)
Date: Sat, 11 Jan 2025 23:57:41 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Tanya Agarwal <tanyaagarwal25699@gmail.com>
Cc: casey@schaufler-ca.com, takedakn@nttdata.co.jp,
	penguin-kernel@i-love.sakura.ne.jp, john.johansen@canonical.com,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	mic@digikod.net, gnoack@google.com, stephen.smalley.work@gmail.com,
	omosnace@redhat.com, linux-kernel@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org, skhan@linuxfoundation.org,
	anupnewsmail@gmail.com
Subject: Re: [PATCH] security: fix typos and spelling errors
Message-ID: <20250111.22fc32ae0729@gnoack.org>
References: <20250111194149.51058-1-tanyaagarwal25699@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250111194149.51058-1-tanyaagarwal25699@gmail.com>

Thanks for the fixes!

On Sun, Jan 12, 2025 at 01:11:50AM +0530, Tanya Agarwal wrote:
> From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> 
> Fix typos and spelling errors in security module comments that were
> identified using the codespell tool.
> No functional changes - documentation only.
> 
> Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> ---
>  security/apparmor/apparmorfs.c      | 6 +++---
>  security/apparmor/domain.c          | 4 ++--
>  security/apparmor/label.c           | 2 +-
>  security/apparmor/lsm.c             | 2 +-
>  security/apparmor/policy.c          | 4 ++--
>  security/integrity/evm/evm_crypto.c | 2 +-
>  security/integrity/evm/evm_main.c   | 2 +-
>  security/integrity/ima/ima_main.c   | 6 +++---
>  security/landlock/ruleset.c         | 2 +-
>  security/selinux/avc.c              | 2 +-
>  security/smack/smack.h              | 2 +-
>  security/smack/smack_access.c       | 4 ++--
>  security/smack/smack_lsm.c          | 6 +++---
>  security/smack/smackfs.c            | 2 +-
>  security/tomoyo/domain.c            | 2 +-
>  15 files changed, 24 insertions(+), 24 deletions(-)
>
> [...]
>
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index a93bdbf52fff..18cc88378d1d 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -121,7 +121,7 @@ create_rule(const struct landlock_id id,
>  		return ERR_PTR(-ENOMEM);
>  	RB_CLEAR_NODE(&new_rule->node);
>  	if (is_object_pointer(id.type)) {
> -		/* This should be catched by insert_rule(). */
> +		/* This should have beeen caught by insert_rule(). */

This is accidentally introducing another typo: s/beeen/been/

—Günther

-- 

