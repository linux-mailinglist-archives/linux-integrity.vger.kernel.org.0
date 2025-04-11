Return-Path: <linux-integrity+bounces-5833-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2726A857DB
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 11:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6634C6580
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 09:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FF4298CD1;
	Fri, 11 Apr 2025 09:17:55 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E4F29DB61;
	Fri, 11 Apr 2025 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744363075; cv=none; b=RBrY9INtLtJMyl/JoZUSTv31CRVD5u6SAKpdBxqDHd3B/38L3iifJFi8K9u8BBMhoi8ceJmdY8ywFkQjDtVKS/clrdueA5qE2BlPHy4wAv3A+8+2IOYCNEsspF9aS+HQKDJZ1NeWLLp64KOPuaVnEbRsyd5ANTOK/v4aRYXTVl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744363075; c=relaxed/simple;
	bh=N4eTL6WIHRbdnA83qpIhZxPELiqtSuWeaMVjW27k1EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niEGPztdM5t6lgcsGPFuzAZxsnE1SAwN9xBeLdWZ9r4yzggTixbEihCjdpAzeGXPIJltKC9Bb4RauWNibx1C3vNHzVfMXE3bvVYfkEnnR6pEXSJnvF5Fx1tgJ0GC4URz8SCX4TdRX0se/edBW8hv5cVgdqob1w2wCPrSinLyDs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7137D1596;
	Fri, 11 Apr 2025 02:17:53 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C6AC3F792;
	Fri, 11 Apr 2025 02:17:52 -0700 (PDT)
Date: Fri, 11 Apr 2025 10:17:49 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: <peterhuewe@gmx.de>, <jarkko@kernel.org>, <jgg@ziepe.ca>,
	Sudeep Holla <sudeep.holla@arm.com>, <stuart.yoder@arm.com>,
	<linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tpm_ffa_crb: access tpm service over FF-A direct
 message request v2
Message-ID: <20250411-olive-wolverine-of-chaos-513a2b@sudeepholla>
References: <20250411090856.1417021-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411090856.1417021-1-yeoreum.yun@arm.com>

On Fri, Apr 11, 2025 at 10:08:56AM +0100, Yeoreum Yun wrote:
> For secure partition with multi service, tpm_ffa_crb can access tpm
> service with direct message request v2 interface according to chapter 3.3,
> TPM Service Command Response Buffer Interface Over FF-A specification [0].
> 
> This patch reflects this spec to access tpm service over
> FF-A direct message request v2 ABI.
> 

From FF-A interface usage perspective,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>


-- 
Regards,
Sudeep

