Return-Path: <linux-integrity+bounces-7681-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0357AC8C5F6
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 00:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97DBF3AEB96
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Nov 2025 23:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CFB4207A;
	Wed, 26 Nov 2025 23:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WxCdrwJz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944B42E5407;
	Wed, 26 Nov 2025 23:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764200425; cv=none; b=Z9fn6a0HZUTLUDNoRPTdg68ccFCTe9NtNal+0eqtvr7GEBg9ERiNyKTkg7LVai8yd6UtqlzxkHv/UauPY4r89nQcnAhnHVusipzx5tCadskcug4IEowC9qNNq9I4rrk3N638Cm5UejkuMcbaPmYd6ad/N7Tv/Ubzz/5TamZ0cqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764200425; c=relaxed/simple;
	bh=AUJ4qlqUqAYM+Nh3LeTVqfAKgtiB0m+riMUqyVUw/ao=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YRE6h4Ug8yn+hccEtP/31hqZU/oyUsiijfSeTvgOUGTIfixnaMt48HUJ/G+MZ+oFleiQq9mWSZwPr1Bw06eMf0DMtC8nGMKX4s7aIVYB49d6+NiGACeAiEjWCGU+DU1ajLjTTnI9A6k1WsD/3WkAEc8UogFkDtQMirs8oahu8UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WxCdrwJz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1235)
	id 23901200E9E3; Wed, 26 Nov 2025 15:40:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 23901200E9E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764200423;
	bh=whxG+tANrlaHzDR8XciJGYQV0WkcXtTthcPCrwyX/20=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=WxCdrwJzMv6raMyzeCOc2nwe3ktSj+JQ85lu1sQ0aq/x6lcJLICOsaejJksTHyzH0
	 mFUl83VFk5dTRkneDiNDqoeRTe2OyZJ0FxGShWoM14Kwh2fcEJZZhbqbIRienk6xTh
	 HFjkGEIa49qcWtOYUrJP07eGkvrsG7bmKr0FS3Po=
Received: from localhost (localhost [127.0.0.1])
	by linux.microsoft.com (Postfix) with ESMTP id 205B9307032A;
	Wed, 26 Nov 2025 15:40:23 -0800 (PST)
Date: Wed, 26 Nov 2025 15:40:23 -0800 (PST)
From: Gregory Lumen <gregorylumen@linux.microsoft.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
cc: Anirudh Venkataramanan <anirudhve@linux.microsoft.com>, 
    linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, 
    Roberto Sassu <roberto.sassu@huawei.com>, 
    Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
    Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
    James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
    linux-security-module@vger.kernel.org, 
    Steven Chen <chenste@linux.microsoft.com>, 
    Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
    Sush Shringarputale <sushring@linux.microsoft.com>
Subject: Re: [RFC v1 0/1] Implement IMA Event Log Trimming
In-Reply-To: <1e5a3b427fe2783e57e88ca14630f5e38e01fac5.camel@huaweicloud.com>
Message-ID: <bbafa611-3a6c-5cf8-631c-20f72f651d9@linux.microsoft.com>
References: <20251119213359.39397-1-anirudhve@linux.microsoft.com>  <7722dff4e68ef5fb7f39bd732a8a77422bad5549.camel@huaweicloud.com>  <a77e9609-f6bd-4e6d-88be-5422f780b496@linux.microsoft.com>
 <1e5a3b427fe2783e57e88ca14630f5e38e01fac5.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

Greetings Roberto,

If I may chime in a bit:

> The only way to make the verification of measurements list snapshots
> work is that the verification state is stored outside the system to
> evaluate (which can be assumed to be trusted), so that you are sure
> that the system is not advancing the PCR starting value by itself.

You are correct; to make the described approach work, an external source 
of trust is required in order to detect unexpected or unauthorized 
trimming of the event log (for example, by signing the trim-to PCR values 
from the previous verification/attestation cycle). This should be true 
regardless of the mechanism of trimming. More generally, I will go so far 
as to suggest that any attempt to attest the integrity of a system using 
IMA will likely fall into one of two general approaches: either the entire 
IMA event log is retained (either in kernel or user space) from boot and 
claims of system integrity are built by validating and examining the 
entire log for signs of tampering, or an external source of trust is 
introduced to allow incremental validation and examination of the log. 
Other more innovative approaches may exist, but we make no such claims.

I will also say that it should be possible to implement either approach to 
attestation (retaining the entire log, or relying on an external source of 
trust) with any sane implementation for IMA log trimming.

As for our proposed implementation, storing the starting PCR values in the 
kernel preserving the ability for any arbitrary user space entity to 
validate the retained portion of the IMA event log against the TPM PCRs at 
any time, without requiring awareness of other user space mechanisms 
implemented by other entities that may be initiating IMA trimming 
operations. My personal sense is that this capability is worth preserving, 
but it is entirely possible the general consensus is that the value 
offered does not balance against the additional technical complexity when 
compared to simpler alternatives (discussed in a moment). To stress the 
point, this capability would only enable validation of the integrity of 
the retained portion of the event log and its continuity with the PCRs, 
and could not be used to make any claims as to the overall integrity of 
the system since, as you observed, an attacker who has successfully 
compromised the system could simply trim the event log in order to discard 
evidence of the compromise.

If the ability to validate the retained portion of the IMA event log is 
not worth designing for, we could instead go with a simpler "Trim-to-N" 
approach, where the user space interface allows for the specification of 
an absolute index into the IMA log to be used as the trim position (as 
opposed to using calculated PCR values to indicate trim position in our 
current proposal). To protect against unexpected behavior in the event of 
concurrent trims, index counting would need to be fixed (hence absolute) 
such that index 0 would always refer to the very first entry written 
during boot, even if that entry has already been trimmed, with the number 
of trimmed entries (and thus starting index of the retained log) exposed 
to use space via a pseudo-file.

With such a trim approach, it should be possible to implement either 
general attestation approach: retaining the entire log (copy the log to 
user space, then trim the copied entries), or relying on an external 
source of trust (quote, determine the log index corresponding to the quote 
plus PCRs, trim, then securely store the trim position/starting PCRs for 
future cycles).

-Gregory Lumen


