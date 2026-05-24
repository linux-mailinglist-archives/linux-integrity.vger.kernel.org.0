Return-Path: <linux-integrity+bounces-9646-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kRfxL+9WEmqfyAYAu9opvQ
	(envelope-from <linux-integrity+bounces-9646-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 24 May 2026 03:39:59 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC115C108A
	for <lists+linux-integrity@lfdr.de>; Sun, 24 May 2026 03:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8B3B300F5F1
	for <lists+linux-integrity@lfdr.de>; Sun, 24 May 2026 01:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0F41DFDAF;
	Sun, 24 May 2026 01:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8k6GqZV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3CA1DDC38
	for <linux-integrity@vger.kernel.org>; Sun, 24 May 2026 01:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779586796; cv=none; b=K/BaeV62QIshv79URDjiewJH6yAuCLIg8KvNlVFFHublLXU1xjw1YhF2feBpcjVqMXIl0PvNP3k68/9KXZybIO9nrFZukcb/5y47EshUyHIheiv8i+bIWBitAWN/BTwUTCf/2FOtOd14+poyI4WaDrorjy0nvZgfgJxpJwfG4eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779586796; c=relaxed/simple;
	bh=rwIIg4Z2p2m9t0mjqyz0adIOiHIb1pbQ6vm28q31QUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=La+Wo5xXoQ0/URaRpUCxg3hwwu/LLzS44wh04rLTgUWgRZytZYhKyI3/3Ihg2CpJzK2/2VeXwfQSe7dBmY2Cwe4FTIJY7m3cZMy3H3ur9BWRZhmBQCE6LNRTE+Hq1GVAwUvGQILPVi+aDOhq1LoOiKpdu6EIx4xuo7ZX3lC/DcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8k6GqZV; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-824c9da9928so3746456b3a.3
        for <linux-integrity@vger.kernel.org>; Sat, 23 May 2026 18:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779586794; x=1780191594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vXQx8sp/1mlGOh839phUqYZokRTxQ/SO0fzQl6UHMdo=;
        b=X8k6GqZVZYVRkPvhTmejSM6TzIB7+WWvXYeiLNf+7G4IYwksApP3u+Z2w8tED/X4wc
         1WQkV2FWvBpt4004w1BCmMBIRQPZfk2y3f1fX/8pz64Hh6UOOcn3tp8Z2ZYAxiIVpxX8
         LLXqIjaThzIbFc0Sl5bnbmUSjn7+ukmzenkoaJax0kDjHYEObCWSAd9W357sGsJQ7dA4
         n3i/LUP4SlCxYJQciD198EkvqkUa3xIsVNBEoC7s3b1XKGQuMN0CmiAVl18Ov4Z0v/TZ
         atzcLw0ZeXBZ3hWboQCy3J2Ev78EvFWF6KW1RE/smeTQfNnE3t5aUwDRM7yKrw49xTzC
         LukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779586794; x=1780191594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vXQx8sp/1mlGOh839phUqYZokRTxQ/SO0fzQl6UHMdo=;
        b=WWkQGDLctexw9E7LMbbZ/sdskLyRLhSjGzaBWo9qOVrdRrozdccSuz9oyN1X8uTNta
         zuH0kDi9Mdo6qqfhplIURWRXj7hKcBOr17qdYHA2xrECFnMO2t+YOA7VXbk6bOQWlRqI
         NtuKJqrfOnhOEI7bonMWxEt0kUCeglv8SnH+JqUAIj1NwXSABo6Du6+h+fOjmZaJp/bV
         rJPfT/cR4bao33uFeX4z7vo8Gf568IVBYsXIKyDj2LPiPOIHVIRrauqJa2TS4mF+Kx4N
         2Ie6iUVrTiLHbeRy+OuJjBFXBqSJ+mzRNxbHLOAi3/9pN2pz4hUKOAgvN+XG3dTnKP2J
         revA==
X-Gm-Message-State: AOJu0Yys0x3aEvTx96QX8kzAWU8AaP+MIGO3jcg3HQcwo/ttQPWNjJam
	qtWqoMHdZClWdDOqjv044Az6uEZC7WhwiGnBTB/nzgqScF6bLrsQN5Y6
X-Gm-Gg: Acq92OHIwmyny2Y3tu7IdtOGCvpnXzmNVAEqSuqXK7SpAaBgJ5Q7rfsinI9BDzx4Ja/
	RXfv8XrSI+cp3nVOHoiTcNYuTxwVFFZzyFyrQbSvuKWJ+yleI1nwFpoyHjH7IPW/QsstTYhdmlH
	Bv7Urt7VvqGhxD639UBB/1OrdCPkcavXN+G46V8Xj4U/9Gzmev/1wQaD3OKkTXXjWQ5YFNsEz0F
	nN4vv/pdV5G0JNONJN4K/GsrXzlC9J/97Y9ekeA7XqmTCw11e1AGknmxPRNzo7q4zcXjx85rgvh
	NLrB0YILwhdtOrU+xBPjCDG31Ql/2QXcMe/nWGJZ6HNSWwKVCx3NEu5fj2vLeznMcoadevpeJ+2
	Gvs5o1urwmAlqcJVlkaamxZS+CqUeqSd2W43NhqqQU01k2Zb6zRTjEO1gxcZxCDJAn9fdz/ezZR
	Iyi7vMxgt4eotq0VZMmsKYhcSA6ryXqpQiyw8/lhyPXnPPuaSFdDc9ZNjqQ2owsg==
X-Received: by 2002:a05:6a00:4299:b0:838:af72:fb37 with SMTP id d2e1a72fcca58-8415f0f02e2mr8616345b3a.7.1779586793939;
        Sat, 23 May 2026 18:39:53 -0700 (PDT)
Received: from [192.168.0.176] (c-73-83-32-130.hsd1.wa.comcast.net. [73.83.32.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84165009852sm5660631b3a.59.2026.05.23.18.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2026 18:39:53 -0700 (PDT)
Message-ID: <9553191e-b061-4fa1-a11c-5ad87cbf6862@gmail.com>
Date: Sat, 23 May 2026 18:39:52 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: tpm_tis: Add optional delay after relinquish
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
 peterhuewe@gmx.de, jgg@ziepe.ca
References: <20260519060926.103727-1-jbroadus@gmail.com>
 <ag-ZuEt4uXnrO8AK@kernel.org>
 <CAKgEEwswj4in29_hoy_dQQ18+GF=Uwf0LnwS=w7bwZCSW=mwjw@mail.gmail.com>
 <ahBN9vCLmHLBqnch@kernel.org>
Content-Language: en-US
From: Jim Broadus <jbroadus@gmail.com>
In-Reply-To: <ahBN9vCLmHLBqnch@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.de,ziepe.ca];
	TAGGED_FROM(0.00)[bounces-9646-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jbroadus@gmail.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1FC115C108A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jarkko. The current manufacturer_id is in tpm_tis_data, not tpm_chip. 
I think it makes sense to move the new did_vid to tpm_chip so it can be 
used in tpm-sysfs, but it would only be set (at least initially) for the 
tpm_tis driver. What do you think?

Thank you,
Jim

On 5/22/26 5:37 AM, Jarkko Sakkinen wrote:
> On Thu, May 21, 2026 at 11:03:29PM -0700, Jim Broadus wrote:
>> Thank you Jarkko. I'll do that.
>>
>> Jim
> Yeah, in this form it is quite unsable e.g., for any Linux distribution,
> and somewhat involved for the user :-)
>
> Conditionally on is much better with appropriate detection. Also, this
> way the change improves the code base a bit given that chip->did_vid is
> much more applicable than chip->manufaturer_id.
>
> BR, Jarkko

