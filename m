Return-Path: <linux-integrity+bounces-5326-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 739BEA699DC
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Mar 2025 20:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923B41671F8
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Mar 2025 19:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063372139CE;
	Wed, 19 Mar 2025 19:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="btEM9Gmh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655DE17D355
	for <linux-integrity@vger.kernel.org>; Wed, 19 Mar 2025 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742414301; cv=none; b=gFj9ag7svpUdzd/En+HLDFLaEfEbemVSgEbIm/DWaHHrmWlNFhYOBO4XtSFIx0+9ay+1LtpkpYpl0KoUWIUdzjc8z7kgJk0orHmy+FnuqRlwmuH8qaxBVn5fjiVvSjIVWCMi/PbmOvMvthHY+ibFfOf2h4vhnSpmXZLMLQ7YERk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742414301; c=relaxed/simple;
	bh=4PAuKV8GTcYbrbN6cu4KCjfX2Idj5fDdJDCql+ZtTeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dv74RewDuMZJg1YuSQZeYjCI3WPFCqivIPErrwi3Kvr6ay0VEkCAUvrDovOEcVkkI26n1TWjebIqcyp5ca1unVAOfdqh/L7VKtHcmfM2HWSGxriVnDzaVkVAiGf8nIPoaN18WiBj4+xwyxDG+zp94RgTK7YVwvUobIOCizqZrhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=btEM9Gmh; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-47662449055so426721cf.1
        for <linux-integrity@vger.kernel.org>; Wed, 19 Mar 2025 12:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742414299; x=1743019099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LCYkccOc0ntzBQ3bHOsOPYrpatM51UPOQJ0ehcRQaYk=;
        b=btEM9GmhveMDjXdXMekss2lM/2qo1llhgIgX5EjJXyvEr5Jj6VV+DyLtIojm8tOTmi
         tOd9U30do9a8UICVc5Qiy3N/xjl6doq6FRpIN4J11a16mSGyqUcUpeQMmaEjIh7YxWIN
         ywEDZHJObIVsZqqyieziaBBSOJwR89LRz/cfHT40+2nsfd2RvTrvMHpT5bP+gENVBTYC
         ncKPIC1V3+QT2zbQzUXebF8DcYoICD0AljCFmXP4/o1N9NHlWLhCP+pYlvEoyVWxf6ef
         tNygG/RTHqwI0CJgAU9lMUR3Ig0Mj49aQIRcoWXE5+KFWRZ99Jl/s1JtNxMOONnG3Mw1
         qhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742414299; x=1743019099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCYkccOc0ntzBQ3bHOsOPYrpatM51UPOQJ0ehcRQaYk=;
        b=mjGimZ+0+8J4uyKe8IJSrVnigePc3stNdTUvr8hk6O1es3NiGuG3S+EiYOfeByZXks
         P1DJznWUmXjJMHTluDs/I7QryZKwi09I283Rl+S0lp/TfFR5n5VRRZ+2RmZoqOTTii6t
         0BDp+5cbtazu9m3BSH8uZh0V2r1lYwp4kC3w5fPqBW+87Q8GY6RqY+JvaKp9pxrC2tGK
         Nq/w7ycUCwj6ogCLI+i4K6492xGFnHWc/eLfvuxgmwdxJAhcItDSKYy81ObnVz1mi3JQ
         nozQOnFqfoF10ugM7sEoRSrNdFWyRuKrq+H9x23ftpyWgHaFvspqO5UAjvPeUyJo7dCx
         O39w==
X-Forwarded-Encrypted: i=1; AJvYcCWZfQNg/QUQqMSAw1xZOjg3eXC/FNVeFbbr4ub9D0BLq3KvYBl8fF0Hnk5fJyu17JbOVNIb2wYGzRl5LT4KCf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx31idRMg614z0j3QabcHrMk3khn4ZWQv5OvEJMHQz6JG7Huvmg
	yh+lUXTZgC4SNxASodC4OG6lq/3OqbUZZCXGhJaPZnQj0cyTtLNO1DPLzLTqQYo=
X-Gm-Gg: ASbGnctJHEiV6V4Z0Nz5h/pf6r8lO6piDGq5blkjpUza7igV8S9Cap44VkPHv5SMmvt
	0SG3CDwlf3rHCcFecPZ7D0dg8B2zu4EDY6UziS+6tFiSTXVtTbToB+flcwfkN9aXss4XHBJ0OmS
	yB77/9rTJ0T1h9JRO7kwy2Xt6gHWJtInJTvaGPk0Fzamjlwc7Epx9nOhkgq+cpFn1nYqZWlfJRt
	286DW7/N23GSVvZwIlpIJe8FMOdMyULCrQuW8oatGC9sBesB5ELhGMZAWIyb9XP3ufFz9+BskO5
	CD6BoVX5lIAZMMxfk6xj+fsZh0k4ZQoDP7Vr/EpUAVIe0Im4XpdG0yxkPBKtEpPVBIbFRRwZ4wX
	YpkEXtfDH6OGv59Dvfg==
X-Google-Smtp-Source: AGHT+IG53s8RQIGxUBD86DpXMIw0IDcEe+RmX3GLFguy7uWXatNqzU3QlP/Blh82b4rIVQ0M6FejlA==
X-Received: by 2002:a05:622a:5447:b0:476:7dfd:fd7a with SMTP id d75a77b69052e-47710aedc24mr13012781cf.0.1742414299183;
        Wed, 19 Mar 2025 12:58:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb611c83sm83409521cf.2.2025.03.19.12.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 12:58:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tuzYQ-00000000XcU-0zGM;
	Wed, 19 Mar 2025 16:58:18 -0300
Date: Wed, 19 Mar 2025 16:58:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [RFC PATCH 3/3] tpm/tpm_svsm: use send_recv() op
Message-ID: <20250319195818.GC126678@ziepe.ca>
References: <20250311100130.42169-1-sgarzare@redhat.com>
 <20250311100130.42169-4-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311100130.42169-4-sgarzare@redhat.com>

On Tue, Mar 11, 2025 at 11:01:30AM +0100, Stefano Garzarella wrote:
> This driver does not support interrupts, and receiving the response is
> synchronous with sending the command.
> 
> Let's simplify the driver by implementing the new send_recv() op.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> Note: this is based on "[PATCH v3 0/4] Enlightened vTPM support for SVSM
> on SEV-SNP" series [1].
> If we will merge this series before it, we can just ignore this patch
> and I'll squash these changes in that series.
> 
> [1] https://lore.kernel.org/linux-integrity/20250311094225.35129-1-sgarzare@redhat.com/
> ---
>  drivers/char/tpm/tpm_svsm.c | 46 ++++++++-----------------------------
>  1 file changed, 9 insertions(+), 37 deletions(-)

I think the diffstat speaks for itself, you should send this as
non-RFC

Jason

