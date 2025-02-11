Return-Path: <linux-integrity+bounces-4781-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F07A307CE
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Feb 2025 10:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87551882242
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Feb 2025 09:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25DA1F2B8A;
	Tue, 11 Feb 2025 09:57:34 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B706B1F191E;
	Tue, 11 Feb 2025 09:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739267854; cv=none; b=el/X+sr34jv5Yze+Btqte8ZiGolJfIWBKE0zI3K1wnd4Wda5CvWHINeEkKonKq7mz1YB7k8cgFUOU2mbR1OS0gI0FE7G6uYYGcTwrc4PMK9dAB+A0cKJPoJOVF+EEgYDlGEpGrqY7FdmknO9989Bg/A/TI6p1rb2uoMja0eEvCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739267854; c=relaxed/simple;
	bh=by8WG+w14XHwoJH21F6z58cPh7djLHUpG3TJkXmqTH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4k9PxDpi6coJT8IQdJaTt/qLqBC9xYQ7wQiOTahv/0tltv2Q6r8fWED6FOTmN8Wg9nkhvtuNxo85v9bfrp1+7RBOc0uNnJEub/lf3LusGuBNGuSHdtYlyWyTEG2mj1EIbEdZ1LZZD2tDOMVpq/rfTBr/wMXN4dOTGnnknP2ZNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E9691477;
	Tue, 11 Feb 2025 01:57:53 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED2493F6A8;
	Tue, 11 Feb 2025 01:57:29 -0800 (PST)
Date: Tue, 11 Feb 2025 09:57:27 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: <linux-integrity@vger.kernel.org>, <jarkko@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, <peterhuewe@gmx.de>,
	<jgg@ziepe.ca>, <rafael@kernel.org>, <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] ACPICA: add start method for Arm FF-A
Message-ID: <Z6sfB-tvhNhTek-Y@bogus>
References: <20250210232227.97761-1-stuart.yoder@arm.com>
 <20250210232227.97761-4-stuart.yoder@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210232227.97761-4-stuart.yoder@arm.com>

On Mon, Feb 10, 2025 at 05:22:26PM -0600, Stuart Yoder wrote:
> Add TPM start method for Arm FF-A defined in the TCG ACPI
> specification v1.4.
>

ACPICA changes require (at least) a pull request to be submitted to
the upstream ACPICA project on GitHub from where the changes get pulled
into the kernel along with other changes.

If such a pull request is already created, please resend the Linux patch
with a link pointing to that pull request to inform the maintainer about
the same so that it helps in the review of the patches here.

-- 
Regards,
Sudeep

