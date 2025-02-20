Return-Path: <linux-integrity+bounces-4929-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5165EA3DDEF
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 16:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 841E87AE322
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 15:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE4D1FA851;
	Thu, 20 Feb 2025 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="eZGl9Hgq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96886FB9;
	Thu, 20 Feb 2025 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063863; cv=none; b=p9z8nV0NagPwSxcBw+iORKHoJ3i5PRqBUgNR+awmRfGyOGozOSPtAgu2xZrbfLFe5bxNsbRFA0bPuv8zA+ZATrO8zjpQRL9EIRIDNEsBt+H+9KzWcRH3PJoR4yXW2XE2eK+ju2soo518Jvsm1TwoUcNDYGql6PtrF2nVMvcTn3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063863; c=relaxed/simple;
	bh=A7/Yz6iPqpOl1AQaKSL6cMZJ1TR+XUEScQ1/Yddl1p4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CEb2NC1Dig52Q7im9IMI8mWIFcNEAFQ/iqB6yIQ4wwf7HiMTEWMRhYFUusFJK7RpDdAxHzzcfKjg+gFMIMA4vp5NnY+qyiIpPPnoxMkVkVXQw1R0gyDNncRsOBrmwO6OtPcNV+ZtOBHhQ9l11rTwRQ4xYgA0TSbRJlyGU0Xit4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=eZGl9Hgq; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1740063859;
	bh=A7/Yz6iPqpOl1AQaKSL6cMZJ1TR+XUEScQ1/Yddl1p4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=eZGl9HgqGOv4cwfgOfl62WrZM/Qo+Ayk0yF3FP92tKsygSY2mlvkHL4gVdne7euNH
	 nmMjnr6NyzLVU07/LaxslNBd5txn1PBIkl+nxey3JB40SCq9SrQDdc+ENkO39uIfDK
	 HQIBqLwlPCQ1y+NFvNlVtTs7Gypk9f4m9K2koKis=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id E67991C2581;
	Thu, 20 Feb 2025 10:04:18 -0500 (EST)
Message-ID: <58e70121aaee33679ac295847197c1e5511b2a81.camel@HansenPartnership.com>
Subject: Re: [PATCH v8 1/7] ima: define and call ima_alloc_kexec_file_buf
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Mimi Zohar <zohar@linux.ibm.com>, steven chen
 <chenste@linux.microsoft.com>,  stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com, 
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com, 
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org, 
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 bhe@redhat.com,  vgoyal@redhat.com, dyoung@redhat.com
Date: Thu, 20 Feb 2025 10:04:18 -0500
In-Reply-To: <8023fa50a84817cc911a117db9bd3757c34fddfb.camel@linux.ibm.com>
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
	 <20250218225502.747963-2-chenste@linux.microsoft.com>
	 <8023fa50a84817cc911a117db9bd3757c34fddfb.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2025-02-20 at 09:53 -0500, Mimi Zohar wrote:
> On Tue, 2025-02-18 at 14:54 -0800, steven chen wrote:
[...
> > Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> 
> Steven, thank you again for picking up this patch set.
> 
> As previously explained, there is no tag named "Author" in
> https://www.kernel.org/doc/Documentation/process/submitting-patches.rst
> .  To give credit to the original author use "Co-developed-by".

Just on this, only use the co-developed-by if you actually *modified*
the patch.  If you're just transmitting the patch unmodified you can
give original author credit by including a 

From: original author <email>

Followed by a blank line at the beginning of the email.  That makes the
git author field contan whatever the From: line says.  You still need a
signoff from yourself in the original patch because you transmitted it.

Some people also consider minor modifications to be insufficient to
disturb the original copyright ownership and simply document what they
did in square brackets under their signoff, like this:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b5d1e6ee761a109400e97ac6a1b91c57d0f6a43a

Regards,

James


