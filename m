Return-Path: <linux-integrity+bounces-3109-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 311D7930FD0
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jul 2024 10:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F85281BDE
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jul 2024 08:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD54D185083;
	Mon, 15 Jul 2024 08:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kOsYXowy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9DA4A18
	for <linux-integrity@vger.kernel.org>; Mon, 15 Jul 2024 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721032196; cv=none; b=YLMT3Qsr179CH5DCg0LhWOzzsjREYCMsbV1tNMvEO3h0VEA0j+GjKBoIpc+vS38SmtUL01pUl+22p9UMDpHJvhTwcFMm9cDEhJ/NwNFVPXwuLdST25cOPuWUvO1dlU1hfcVwocnqM1S+k29wG/6XfX+j4VKnbIjbBH/p17FGeoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721032196; c=relaxed/simple;
	bh=NOnnq+61CxDOWMILVOgzIwIKxbt7n9msZtGOaXKmv1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HX9Mj90xcztVFbsIq2urekGdsHggwn44FPAJGFx01VFl5vIlSumvRWVg7IE4Xh4MiEU+nHRCCx7eNXIwohYWzYYLBVII/r13QvRHqeYPXs2Jx61g1H1xFSEAjxqxbuSUejyt018DxmD8Qn7poEJKdfSiRTlyTTob9CIPw4WReKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kOsYXowy; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: jarkko@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721032192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gI+AO5s/O2pz6h4ONw/V+YoYvCERCtp3v+pVErREphU=;
	b=kOsYXowyPGspLPXF9SVdQZ0V5kNNsx8jS+NossoDwzgm+9GnG5rp4hnx2YF7ZJMUQsOgNC
	DFYpI9vsuUaijnzyHEPdtU5ajiFxYXmUTNfAX1ISYjfx7HDHPU+Qx18emGGLzLaOA5pOTV
	3t18lqbK7SQndlhCGfvzKdPz0DqNkIc=
X-Envelope-To: peterhuewe@gmx.de
X-Envelope-To: jgg@ziepe.ca
X-Envelope-To: linux-integrity@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: gehao@kylinos.cn
Message-ID: <b69b55e8-eba8-3f3f-e65f-cc5e6cf3eb84@linux.dev>
Date: Mon, 15 Jul 2024 16:29:42 +0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] tpm: Move dereference after NULL check in
 tpm_buf_check_hmac_response
To: Jarkko Sakkinen <jarkko@kernel.org>, peterhuewe@gmx.de, jgg@ziepe.ca
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hao Ge <gehao@kylinos.cn>
References: <20240709023337.102509-1-hao.ge@linux.dev>
 <D2PDLHX51C3K.16A4U6XFXRE29@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <D2PDLHX51C3K.16A4U6XFXRE29@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Jarkko

On 7/14/24 23:43, Jarkko Sakkinen wrote:
> On Tue Jul 9, 2024 at 5:33 AM EEST, Hao Ge wrote:
>> From: Hao Ge <gehao@kylinos.cn>
>>
>> We shouldn't dereference "auth" until after we have checked that it is
>> non-NULL.
> Sorry for some latency in responses. I'm on holiday up until week 31 and
> only look at emerging issues but not every day.
Understand,I hope you enjoy your holiday.
> I do agree with the code change but the description contains no information
> of the bug and how the fix resolves it. Could you please rewrite the
> description?
>
> I can only think this realizing with tpm_ibmvtpm and TCG_TPM2_HMAC
> enabled because it was according to recent learnings a platform which
> does not end up calling tpm2_sessions_init().
>
> Since you bug report contains no bug report, I need to ask that did you
> realize a regression in some platform? Fix will get eventually accepted
> even if the bug was found by "looking at code" but the gist here is that
> your bug description contains no description how you found the bug,
> which it should.
Actually It's reported by smatch and Dan Carpenter also noticed this 
warning.

This is the email he sent

https://lore.kernel.org/all/3b1755a9-b12f-42fc-b26d-de2fe4e13ec2@stanley.mountain/ 

> When TCG_TPM2_HMAC is disable it should be safe because we have:
>
> static inline int tpm_buf_check_hmac_response(struct tpm_chip *chip,
> 					      struct tpm_buf *buf,
> 					      int rc)
> {
> 	return rc;
> }
>
> I also noticed that your fixes tag is incorrect as that null dereference
> pre-existed on tpm_ibmvtpm before my fixes. It is not a new regression
> introduced by my patches. So use git blame and check which commit
> introduced that one.
I'm a bit confused about fixes tag. Sometimes tool often fail to truly 
understand the context.

Form the logical perspective of the code,null deference indeed existed 
before your fixes.

But for smatch, It simply conducted a static code analysis and flagged a 
line with a warnning.

Its warning seems to be related to Commit 7ca110f2679b("tpm: Address 
!chip->auth in tpm_buf_append_hmac_session*()")

That's why I used the 'fixes' tag for Commit 7ca110f2679b.(Please 
forgive me for not being clear earlier. I discovered it through smatch.)

So, should I use the fix tag for Commit 7ca110f2679b ('tpm: Address 
!chip->auth in tpm_buf_append_hmac_session*()') or for Commit 
1085b8276bb4 ('tpm: Add the rest of the session HMAC API')?

Even though I have already send V2 which fixes tag using Commit 
1085b8276bb4 ('tpm: Add the rest of the session HMAC API'),

I still want to gain knowledge in this area so that I can more 
accurately use fxies tag and send patches in the future.
>
> Address these issues and send v2. Thank you!
>
> BR, Jarkko

Thanks

BR

Hao


