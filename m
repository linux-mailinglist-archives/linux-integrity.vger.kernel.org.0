Return-Path: <linux-integrity+bounces-5871-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE7DA886CC
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Apr 2025 17:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0AC16B1DA
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Apr 2025 15:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAEC198E75;
	Mon, 14 Apr 2025 15:18:19 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6B71B0435;
	Mon, 14 Apr 2025 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643899; cv=none; b=f8pgDyDy7JNz9pmld781niVRHorGvQOdvmE6GteMMdE+lvDS+a4uwIWTynXl4WhyEGEhZQ9bFc6xK2D0ajI8/bnhXLYukdr0vBj+DrsOyv517t0rQnUSfKz3/vSn7k0Hj7u8o2/6K1foNksm4ptAWYeT5AuK6/72ZTdwhIVpRVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643899; c=relaxed/simple;
	bh=o+5+l9A67F2ez/JZb3g7VeO8szwkk8adaSE+LF/2TRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlUFl6BPnJ2wksXZYuSjAGL0uookfegA1da56SaOpfsXADMbgCTH/GnIfLTx0xim3vAu10A8yso3quQPa0RwH6nLnEOmASxkZHlPMB+nFYj+hT/t32jPZDXcRL9imwQupAS1JpvITW+/n5rX5c4GEcz3sztZG4XdodG7GvOnPXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EE871007;
	Mon, 14 Apr 2025 08:18:10 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68F483F66E;
	Mon, 14 Apr 2025 08:18:10 -0700 (PDT)
Date: Mon, 14 Apr 2025 16:18:07 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: <linux-integrity@vger.kernel.org>, <jarkko@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, <peterhuewe@gmx.de>,
	<jgg@ziepe.ca>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm_crb: ffa_tpm: return errors from interface functions
 if no ffa-crb driver
Message-ID: <20250414-tiny-swan-of-tempest-ddcbdd@sudeepholla>
References: <20250414145235.938924-1-stuart.yoder@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414145235.938924-1-stuart.yoder@arm.com>

On Mon, Apr 14, 2025 at 09:52:35AM -0500, Stuart Yoder wrote:
> If ACPI advertises an FF-A based TPM but the tpm_crb_ffa driver is not
> enabled via Kconfig, inline stub versions of the interface functions
> are used. These functions incorrectly return 0, which indicates success.
> The result is that the tpm_crb probe function continues execution and
> eventually detects a timeout at the TPM.
> 
> Change the inline functions to return errors, so that probe() sees that
> tpm_crb_ffa is not present and aborts the probe.
> 

LGTM,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

