Return-Path: <linux-integrity+bounces-4537-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5A9A0BA5E
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jan 2025 15:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E07165F5E
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jan 2025 14:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB1923A10F;
	Mon, 13 Jan 2025 14:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fg3NxmFu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBA023A117;
	Mon, 13 Jan 2025 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779851; cv=none; b=fNsjlN9IMlo8Fr6t40NNULvrSyVRJxEdKBYHXyOLgo26iwK4v791ePSluyUe3gbPemsZVMxZJtIWylakhWjy1Qx85X0j3Qj5Mr2PaOFl0TChTXAStgTAMvPB5eQo01nKwG/B9owfnG4Xi3QN5oK5rISkUKS+YiNF64V6N97lXSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779851; c=relaxed/simple;
	bh=L9MrAFXeWGJEebUslcYCuY+qo9s/EjEgrLtokZZ0m3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lj6FEXZnjVhB94wkXYfijmuddJtxW0f4GDCMAdoMYJolpx7+qllIgpNniUoBNyrsAjTBjx3GZLTZMzg67nEpvJDZbPfUdhhG+dbCpJV7hXuHKHhzG99/sSRxRCWoOGjpTR9f/2W3osYUYdf+4TCB4vUZx0i1a3u9sYBOCDzhs/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fg3NxmFu; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43626213fffso33101705e9.1;
        Mon, 13 Jan 2025 06:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736779848; x=1737384648; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d0NjS1II12TMN7g1xhUgyqXDJMjrZfAmxWycmrEMMZc=;
        b=Fg3NxmFu3sC8I7d0A7b5x+h/My6QJwnOnUUYPBOeGdyVI+VsPsPvhhplkKOgOrpYbJ
         HOiQGnW5mlnTyTPeORxoKVnte54tX0qRGHUq96EzJKS+LWlGDypKgtqIxXWa7FQq+hr8
         XuYQkFMDvxtVD1GdexXAFAEz8fKMgNhahFzLlMu9xGyzqBAPzYdVU1qJ8vHRLWml0YLr
         K/h+eEyhSorZMxW7aAy0IbHNkzAyaL3eRmBJNdnpcgbKrQf7qpQH54OGXbwMS+N+RmOP
         IaX15ksQsrtknyniccEeaOGpkheosWgmxavhh+mNfTdNsUGMJqxKf4hAz2/il5W4mVYk
         VyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779848; x=1737384648;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d0NjS1II12TMN7g1xhUgyqXDJMjrZfAmxWycmrEMMZc=;
        b=OFTt990CRSMlOmQKvNEEZ41FWW5Rhwkz+e8aQ8BeBcHpZD7PiiGDbHBXkQT0XUgoPi
         ejAWIDc2k62QghShXrfEOa8oiogJMqn5d2+nZ5lYfaa9Ky+diga7qjlNBK5JjbBJGkCO
         0Qpl4wJwa9yZJqR7gmjlinW4NOBaNQ2nJfIV6EkN+ACW05UdVL4mnxvHCXQ5QFRba3Qi
         zY2lT1vb062zaadD3zyMMBAknRzbJ1C0O3n9Yb3M6hkqLoiyKoWnLL5tcrGojdWZLTAe
         ibGEFTt8e2WhjAJP7mACIUgJlsCajSoffNiRguKWP8qls7VmovfrNvx9bdf3k063uVyM
         lrVg==
X-Forwarded-Encrypted: i=1; AJvYcCVkz29ctr90HHf5ekRPWi3nh8xpre9wfmEr3EAXpFI7Dgwdp6TqffZMCeIJ3PbQX0C2BtZAHJbVNq1Bx6zWv/JIRMLkD/gP@vger.kernel.org, AJvYcCWrrbiQaubxFulgjdyigwYc2OoTQe0FyXHARwFcOOidAHJ+dmScNB/biQ/A00/m6wvlu8WNxmUYxKunqSLN@vger.kernel.org, AJvYcCXG/Ff3Rs2Od/HjMC1YzH4H8BsS08h4UuQXlFhptZ1WThEtOCo23bov2K7H8+m64iLlOqOPql6bSJbiA7RWFYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPChKN/+qtKMn6iOFCHiZ3J4mKnW734+TabwayZYYPr0Bua+Si
	Urr49dRE1L+PrpzLRoJI2e6nmx1aZKarDLyz8M8Ez61OkbeKr1fW
X-Gm-Gg: ASbGncuLX89mE+MNUAgsD2ccej5pbggNZIejtmV5WYI+6KTyT4yBZRgD8kdWyEam3D3
	BFDX/znhuPPpu7WyXYvIVN5Gj7/J/ud0t56opDVCP0TwrAbXwCu1xr+51lBVOuzfjzbc30gsomC
	qA4Er4RF7daFWO3UM+NtC5ia9R8vwPpJFn2/pvt5stw58nk1sn/gB4nzVvhALPKAZLVBcJuGREJ
	PK8GLsM0qgwboMsXXOa80PmADtjBG3N4cby1+Gc7awQDpZSEfW+fQ==
X-Google-Smtp-Source: AGHT+IFFNmsPhbFB0SkryX+GHfN4UCZ+BS4WzQbbvfLIbB5I7Ed31UF72Wgu7bCYXm7jNM02zGWjNw==
X-Received: by 2002:a05:600c:5028:b0:434:fa73:a906 with SMTP id 5b1f17b1804b1-436e9d6fe9emr136818765e9.4.1736779847430;
        Mon, 13 Jan 2025 06:50:47 -0800 (PST)
Received: from localhost ([2a02:168:59f0:1:b0ab:dd5e:5c82:86b0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e6263fsm149560315e9.39.2025.01.13.06.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:50:47 -0800 (PST)
Date: Mon, 13 Jan 2025 15:50:42 +0100
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
Subject: Re: [PATCH V2] security: fix typos and spelling errors
Message-ID: <20250113.a860b47a11c7@gnoack.org>
References: <20250111.22fc32ae0729@gnoack.org>
 <20250112072925.1774-1-tanyaagarwal25699@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250112072925.1774-1-tanyaagarwal25699@gmail.com>

On Sun, Jan 12, 2025 at 12:59:27PM +0530, Tanya Agarwal wrote:
> From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> 
> Fix typos and spelling errors in security module comments that were
> identified using the codespell tool.
> No functional changes - documentation only.
> 
> Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> ---
> Thanks Günther, for catching this error.
> The irony of having a spelling mistake in a patch that fixes spelling
> mistakes is not lost on me :) 
> 
> I've fixed it in V2 of the patch. Thank you for the careful review!
> 
> V2: fix spelling mistake - s/beeen/been/ 
> 
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

[...]

> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 9b87556b03a7..cdb8c7419d7e 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -983,9 +983,9 @@ int process_buffer_measurement(struct mnt_idmap *idmap,
>  	}
>  
>  	/*
> -	 * Both LSM hooks and auxilary based buffer measurements are
> -	 * based on policy.  To avoid code duplication, differentiate
> -	 * between the LSM hooks and auxilary buffer measurements,
> +	 * Both LSM hooks and auxiliary based buffer measurements are
> +	 * based on policy. To avoid code duplication, differentiate
                          ^^^

(Small nit:) This change from two-spaces-after-the-dot to a single
space looks like it happened accidentally.  The two-space style is
dominant in the ima_main.c file.

(However, I am not involved in IMA and others have more authority to
review this part.  As Paul also said, reviews tend to go smoother when
the scope for the patch is a single subsystem - it makes the
responsibilities clearer.)

> +	 * between the LSM hooks and auxiliary buffer measurements,
>  	 * retrieving the policy rule information only for the LSM hook
>  	 * buffer measurements.
>  	 */

–Günther

