Return-Path: <linux-integrity+bounces-5090-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B886A4F24D
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 01:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 521CA7A58E6
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 00:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BCC38DFC;
	Wed,  5 Mar 2025 00:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieJN7/kM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4D538DE1;
	Wed,  5 Mar 2025 00:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741133953; cv=none; b=h6VFJTSy28GabKvzPEj+DZPEKsW1qMlkw4PVtB1ygC9YyDNmvhPG+/i/833kCzHmsKS6p6kAPrHkNWyfN0IKlrxRG8oLnY9LkV4HqYpX5GC4KR6RqyGUGSFs9uzabuVhKSD/78CoifUad815BPV91u9TLVdXqBVWPQkt/PU+oFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741133953; c=relaxed/simple;
	bh=LvuMnlvN9J07K8g58fWqbDkGdxz8BL6D4q8fb+iXypU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adet/B4Yyhq/Fl6qijaARXP2uxwwyAdBDDNrJ/+cqtEJ1s+o2Bo2XNf/h58ADx0g1oJGwMU+gJtePeDntsXI8RXbrL4b4snVviVO7XmD8CXlRIWbfKqsGqM4eBLAyU2yuZ8ViqgVxCNoa80OR+rtu9qgM8ah03ubR8HsUVIm9EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieJN7/kM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC09C4CEE5;
	Wed,  5 Mar 2025 00:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741133953;
	bh=LvuMnlvN9J07K8g58fWqbDkGdxz8BL6D4q8fb+iXypU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ieJN7/kMl4Ef2TMN0t+mICwSeXBYuE/24BZzt+zAK+BmFWAeqVIN2ibVgQBqKc6j9
	 Mw8zzwVjvwhAX9jLMQ6um0u9JAWHXawzNZqln/UnbNqMnc7CeQVuCf+jf/n2fDiGnX
	 Ydklh3Sq7rD0a7ZMW6BYuUL1pKPWvzkuVL0YA67aM7PAIZUEzPs/mqgzjFwvg/CIBL
	 rmi5yGtIRmFCtch/m1I0DT8TQsYiZaK5+VS79SROj5ef5URjkAnXqL+EpMwnR92uw1
	 aXURXJwfb5lBgxwMTY+cYteyTPQD/haf4NNLAoG7p3WE1UE+3CYwDkEPfyJD6vCTsM
	 JLryDI3iIwClw==
Date: Wed, 5 Mar 2025 02:19:08 +0200
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
Message-ID: <Z8eYfALmwN68F39V@kernel.org>
References: <20250305000602.127665-1-jarkko@kernel.org>
 <8255b211-5510-4c09-b13f-c4e3bd0d0aba@intel.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8255b211-5510-4c09-b13f-c4e3bd0d0aba@intel.com>

On Tue, Mar 04, 2025 at 04:18:03PM -0800, Dave Hansen wrote:
> On 3/4/25 16:06, Jarkko Sakkinen wrote:
> > +	/*
> > +	 * This is a micro-architectural requirement. ECREATE would detect this
> > +	 * too without mentionable overhead but this check guarantees also that
> > +	 * the space calculations for EPC and shmem allocations never overflow.
> > +	 */
> > +	if (!is_power_of_2(secs->size))
> > +		return -EINVAL;
> 
> Isn't it a plain old documented architectural requirement?

Yes, but it requires some explanation why it exists here instead of
counting on ECREATE.

What do you suggest?

BR, Jarkko

