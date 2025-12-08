Return-Path: <linux-integrity+bounces-7855-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DECCADE88
	for <lists+linux-integrity@lfdr.de>; Mon, 08 Dec 2025 18:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DB4B308C399
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Dec 2025 17:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A267320A10;
	Mon,  8 Dec 2025 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SEyagsfs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE03D320A0E;
	Mon,  8 Dec 2025 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765214515; cv=none; b=cs9E++JkAFl1HP+oSmwG/n8hYBH/FVqCvgzAJ/yK9Z1bshIrZx6az0uuWA5wy/NV7Or21x4ZraDEFIrgEvW0JtnQ35NCGxTyz18Stcm1Lbdg/DjN7XBQ1fo3yxf/rGmMXwVO4J8zj89DWK46sfxHzjoc9dm6WrCdep6LFaSAYKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765214515; c=relaxed/simple;
	bh=Q5rUgop7VQ6z5WRebShPIHcJnNNegv72oUY6tpU1W4s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YX20fgZYY/98doF3PbnnEho3mvm4EQ4sHjnE/7jnHz7NbrIYLWoYoBK1Q4uSmSLegiXfueRd16iK/+YYxDzmjQ0BRW1OX2draUyFvA67E6hdml9weepWNrMzLfqrF8TacfPC3xhDMMRCUiuk66cxCG62lxTH+rjQIMp9e9BuVEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SEyagsfs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1235)
	id 4A4962038B75; Mon,  8 Dec 2025 09:21:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4A4962038B75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765214513;
	bh=g0FqMiZkhqj7AVrLUNf31zYp1sWWJMHm1Xdo+UNxEoA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=SEyagsfssKDepvNX76TlLMmcRPJaxj9byr1TDCVVJk+I8tIdeuej31iIp/OPnRfIz
	 0H6bjoSqIBf3QTGwCAzr6U1O+QjpbTxmFS2Grx9tlKdKKVvSgPlNDlSBUcR7h5iUca
	 UMmCjkJT+6egtVKC9gpYD40C4SoTicY2nIBS6RfI=
Received: from localhost (localhost [127.0.0.1])
	by linux.microsoft.com (Postfix) with ESMTP id 46D363070339;
	Mon,  8 Dec 2025 09:21:53 -0800 (PST)
Date: Mon, 8 Dec 2025 09:21:53 -0800 (PST)
From: Gregory Lumen <gregorylumen@linux.microsoft.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
cc: James Bottomley <James.Bottomley@HansenPartnership.com>, 
    steven chen <chenste@linux.microsoft.com>, linux-integrity@vger.kernel.org, 
    zohar@linux.ibm.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, 
    eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org, 
    serge@hallyn.com, linux-security-module@vger.kernel.org, 
    anirudhve@linux.microsoft.com, nramas@linux.microsoft.com, 
    sushring@linux.microsoft.com
Subject: Re: [PATCH 1/1] IMA event log trimming
In-Reply-To: <1ca00e3238e804db9280abf8655364c2662754ca.camel@huaweicloud.com>
Message-ID: <862fa081-df51-084-ae2c-efa0eae0ca7e@linux.microsoft.com>
References: <20251202232857.8211-1-chenste@linux.microsoft.com>  <20251202232857.8211-2-chenste@linux.microsoft.com>  <099492ee58996b6f18d73232677757ecadb14cb7.camel@huaweicloud.com>  <34d739c2cf15baf78dff5acb7ae3ddd7ad47f219.camel@HansenPartnership.com>
 <1ca00e3238e804db9280abf8655364c2662754ca.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="656392-1258731384-1765214513=:26665"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--656392-1258731384-1765214513=:26665
Content-Type: text/plain; format=flowed; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT

> Rather than designing the interface absent use cases, could we give use
> cases first so we know it fits?

I would also like to request that we include operational considerations in 
the interface design; specifically, which additional signals can or should 
be made available to UM to assist in diagnosing log validation failures. 
This seems called for as any form of log trimming will introduce a new 
potential cause for validation failures (unexpected trimming).

With the proposed changes, the only signal available to system operators 
is the validation failure itself, with no signal that could be used to 
determine if the failure was the result of an unexpected trim or a loss of 
synchronization between the log and the PCRs (either through an unexpected 
PCR extend, or tampering with the measurement list). Any of these may 
indicate malicious activity, but they may also result from system 
configuration issues that operators would need to diagnose and resolve.

Tracking and exposing either the total number of trimmed measurements or 
the most recent trimmed-to PCR values by the kernel would allow system 
operators to determine whether a failure was caused by unexpected trimming 
or integrity issues. (Storing the PCR values also enables validation of 
the retained measurements even after an unexpected trim, though I¢m unsure 
how often that signal would prove useful.)

Neither approach appears to add any additional attack surface beyond 
raising the likelihood of incorrectly or insecurely implemented UM 
attestation agents. Though that risk (and the additional kernel 
complexity) should be weighed against the value of the additional 
diagnostic signals.

-Gregory Lumen

--656392-1258731384-1765214513=:26665--

