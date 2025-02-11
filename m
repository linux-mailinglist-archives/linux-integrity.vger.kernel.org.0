Return-Path: <linux-integrity+bounces-4782-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E48A3082B
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Feb 2025 11:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845253A34D5
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Feb 2025 10:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF471F3D49;
	Tue, 11 Feb 2025 10:12:52 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29161F1539;
	Tue, 11 Feb 2025 10:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739268772; cv=none; b=kZr4Az3DJTwuuzrAtDbYqQ9Es6ZcHajyjhvuhHsoNSVVkPTNT8Wo/h2deqBfuUMEyrTq7lhTT1FIr3a4ooI4FwKKHepcWVrB/fC0wteZo3PkShAUq7KtyRRuU9s0CDEaeZ8enGhI0ue//N73YYQBSuOf5DUZsWuFkxqLjJ8/tFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739268772; c=relaxed/simple;
	bh=P17VEwpgggij5gPEXvR2lpCC6Mi4IMgXTN/cZV3KLT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYt/0xN79YmpJryVabGgFPN3cFnn9Io3AeB6YVbararRyrVVwNBFexekWxOhMxjnrrIPZiVrtE3w9teFgIvF5Ryd/mLynT5vYYzCt2LglnOx57Hmg0K2hhhxWiDieh7yYHWVfwlPXJAphmzFxcRuBh+3AAcnLiRnA/c7YIQ6HoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79F941477;
	Tue, 11 Feb 2025 02:13:11 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 473743F6A8;
	Tue, 11 Feb 2025 02:12:48 -0800 (PST)
Date: Tue, 11 Feb 2025 10:12:45 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: <linux-integrity@vger.kernel.org>, <jarkko@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, <peterhuewe@gmx.de>,
	<jgg@ziepe.ca>, <rafael@kernel.org>, <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] Add support for the TPM FF-A start method
Message-ID: <Z6sinfNeBynQH0zs@bogus>
References: <20250210232227.97761-1-stuart.yoder@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210232227.97761-1-stuart.yoder@arm.com>

On Mon, Feb 10, 2025 at 05:22:23PM -0600, Stuart Yoder wrote:
> These patches add support for the CRB FF-A start method defined
> in the TCG ACPI specification v1.4 and the FF-A ABI defined
> in the Arm TPM Service CRB over FF-A (DEN0138) specification. 
> (https://developer.arm.com/documentation/den0138/latest/)
> 
> FF-A is a messaging framework for Arm-based systems and in the
> context of the TPM driver is used to signal 'start' to a CRB-based
> TPM service which is hosted in an FF-A secure partition running in
> TrustZone.
> 
> The first patch adds an FF-A driver to handle the FF-A messaging when
> communicating with a CRB-based TPM secure partition built on FF-A.
> The driver is probed when the TPM secure partition is discovered by
> the Linux FF-A infrastructure.
>

All the FF-A related changes look good to me.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

