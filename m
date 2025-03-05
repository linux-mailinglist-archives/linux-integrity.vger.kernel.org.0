Return-Path: <linux-integrity+bounces-5099-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EFCA4F3A1
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 02:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6F73AB3F7
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 01:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AB313E40F;
	Wed,  5 Mar 2025 01:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A16I2H7i"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3972113D8A3;
	Wed,  5 Mar 2025 01:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741138017; cv=none; b=r7oZpR+2EbY2v8u7iCrUBcncfupbaR6Qju2xde08BuI97mb8q/PBcwpk9JjIHCDoC96Q2ZElRWfGc6cIR9+msceGhz756CJp01w7mNj3PvqRZEW5VQLxhUHkGAfSaGdwPEHj+GsyYlG+hS9Z5VwggdLJvc/UpRSJ71yRLy85lsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741138017; c=relaxed/simple;
	bh=YOOQJ9TyKIHAYBy14/1WKrRIG8jkNv2bKTA6Sm1UngY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GY/1AhIbPjbgmC/Z5GCUfALCsh1uzNLnnkeaRJhcpu5uvInZVcQCOD3iQVWA5wUVvdlBqZxph4mMJmasuBO+B4r6GZuyE6d8ALSzUaBCiNWFuU1M7u5VSJNvZZMvFNlIFdnypdB/rgm6DS0oW1MrTv+VhfnYPaVmGRUnCgJoIR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A16I2H7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E235DC4CEE5;
	Wed,  5 Mar 2025 01:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741138016;
	bh=YOOQJ9TyKIHAYBy14/1WKrRIG8jkNv2bKTA6Sm1UngY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A16I2H7iiqzfsbvkKwtE2dR64gsS0boUzr5gUE6OVhzy6szLnJRERRbzGPe1VNWoo
	 EyG2ss6/f4AYi7SQh8EGUdt3kQLr4zpKFxj0LyQjFzvdgUtLWxU9YdUtH5L5EYINMm
	 074LL6cz151GYNcyzk6ys7RwdftsNW/Trj0rsSIaPjbHF83qGdd2T2WnbSRf4UDyA1
	 aL9RBKuV7C7CV1U96Q/Pm+1PobKVUORm8m7NPExgowY+5DPJdxKoBOlkxuZza1HGln
	 73qPJ2MbFMugOn6t19uUeGn4jHGkM/QR8QS12/WIpFLED+EknZQT8qulJsp/cF1nqf
	 tuKk6ZtewwKjw==
Date: Wed, 5 Mar 2025 03:26:51 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-integrity@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Dan Carpenter <dan.carpenter@linaro.org>, linux-sgx@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arch/x86: Fix size overflows in sgx_encl_create()
Message-ID: <Z8eoW4rUV5U9JUci@kernel.org>
References: <20250305000602.127665-1-jarkko@kernel.org>
 <8255b211-5510-4c09-b13f-c4e3bd0d0aba@intel.com>
 <Z8eYfALmwN68F39V@kernel.org>
 <379e2198-55bb-4fd9-bf54-7fe0b3e33803@intel.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <379e2198-55bb-4fd9-bf54-7fe0b3e33803@intel.com>

On Tue, Mar 04, 2025 at 04:30:21PM -0800, Dave Hansen wrote:
> On 3/4/25 16:19, Jarkko Sakkinen wrote:
> > On Tue, Mar 04, 2025 at 04:18:03PM -0800, Dave Hansen wrote:
> >> On 3/4/25 16:06, Jarkko Sakkinen wrote:
> >>> +	/*
> >>> +	 * This is a micro-architectural requirement. ECREATE would detect this
> >>> +	 * too without mentionable overhead but this check guarantees also that
> >>> +	 * the space calculations for EPC and shmem allocations never overflow.
> >>> +	 */
> >>> +	if (!is_power_of_2(secs->size))
> >>> +		return -EINVAL;
> >> Isn't it a plain old documented architectural requirement?
> > Yes, but it requires some explanation why it exists here instead of
> > counting on ECREATE.
> > 
> > What do you suggest?
> 
> 	/*
> 	 * ECREATE would detect this too, but checking here also ensures
> 	 * that the 'encl_size' calculations below can never overflow.
> 	 */

Looks reasonable to me!

BR, Jarkko

