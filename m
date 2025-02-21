Return-Path: <linux-integrity+bounces-4962-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35198A3F6A8
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 15:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D92A1891B9A
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 14:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049771BCA07;
	Fri, 21 Feb 2025 14:02:26 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9142F2D05E;
	Fri, 21 Feb 2025 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740146545; cv=none; b=fswGjdPJjTvi0q4ExX4j1kXWKJqQ+7a/D+MXnX2jcpKfkh+wlJaiYgTKqXYGEjseTyuv2AjQlHRHJyCb9XuUmRtSoTdl/WKD/6Mo+/g9bj9DUmR5pDKjyt5aAbRPSWCDvXRQLszyLNxFjYPpjNqjcAvo4heWkdnKxppPsGD2xtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740146545; c=relaxed/simple;
	bh=LllIJWlInIu28fom361MYi5lsTeITv3lVS0i1lQ+RKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grLe+EJeZ4Svxkynu14Isr04A+fDHBsd7Q0pMvUZAa2paVLtEvh23uaoffeOH6FqJOZql0AxEdBxlFnlVCAqvDX5ewH0ZLhd+P8jJ7DgKt0OizlnATbHZHPbT9MZPRM9BcMGlIwBOLcQW3gIDzUy1f/kNptNyT0WPOBD3g+BT90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BB42168F;
	Fri, 21 Feb 2025 06:02:40 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58A9F3F5A1;
	Fri, 21 Feb 2025 06:02:20 -0800 (PST)
Date: Fri, 21 Feb 2025 14:02:17 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Stuart Yoder <stuart.yoder@arm.com>, Sumit Garg <sumit.garg@linaro.org>,
	linux-integrity@vger.kernel.org, jarkko@kernel.org,
	peterhuewe@gmx.de, jgg@ziepe.ca, rafael@kernel.org, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 0/4] Add support for the TPM FF-A start method
Message-ID: <Z7iHaWPyq3KDG7J2@bogus>
References: <20250210232227.97761-1-stuart.yoder@arm.com>
 <CAFA6WYM7K4_toy5_n1arW4po4SOX0R9624rCgO=_MvcMeySwUA@mail.gmail.com>
 <4bb3cefa-b843-45ca-82c5-d96b13454baa@arm.com>
 <CAFA6WYM3UA9+TE8L2U5Qd8FZfaGZnbba=QzWU7fEu3LKQVm-tw@mail.gmail.com>
 <fdaa9a58-790f-4839-8db7-1b9a81eb8edf@arm.com>
 <CAFA6WYM0ANqc--ScYtJFRjOsCCjzO3NX46=F5V=rza_6Q-Q96g@mail.gmail.com>
 <e142afd2-38ec-4640-b9be-cb414bccc807@arm.com>
 <Z7LGbZsOh_w-HRY2@sumit-X1>
 <5dae96fa-0e54-4274-bcc6-1c20fe846f60@arm.com>
 <Z7iDuwLDA2rFPZK6@sumit-X1>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7iDuwLDA2rFPZK6@sumit-X1>

Hi Sumit,

On Fri, Feb 21, 2025 at 07:16:35PM +0530, Sumit Garg wrote:
> On Mon, Feb 17, 2025 at 10:56:58AM -0600, Stuart Yoder wrote:
> >
> > I don't see how changing TPM discovery to be via FF-A directly
> > would improve maintainability.
>
> You are considering ACPI at this point but when people want to use this
> TPM over FF-A on a platform using DT then it will require corresponding
> DT bindings. After that each platform has to enable TPM over FF-A in
> their corresponding ACPI/DT. All that won't be needed with auto
> discovery over FF-A.

I hear you and completely agree. However, someone thought it was a good idea
to align with other start methods and duplicate information in the TCG ACPI
specification. This is definitely a bad idea, as it may contradict the
firmware. All we needed was a simple flag to indicate whether FF-A is the
start method.

It sounds like a classic case of misalignment between specification authors
and practical implementation needs. Instead of a simple flag to indicate FF-A
as the start method, duplicating information in the TCG ACPI specification
seems unnecessary and potentially problematic—especially if it risks
conflicting with firmware behavior.

Anyway, I can't comment on how we ended up here, but this seems to be the reality.

--
Regards,
Sudeep

