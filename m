Return-Path: <linux-integrity+bounces-2932-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88936915A48
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Jun 2024 01:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F7BB28474B
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jun 2024 23:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B6C19E7F4;
	Mon, 24 Jun 2024 23:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="D1KkE71A"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153EB49655
	for <linux-integrity@vger.kernel.org>; Mon, 24 Jun 2024 23:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719270997; cv=none; b=HniOy4/+U5Ur3j7tEWwQEYJ/MJyCNN4NpjsXLeNYM0xjVUBnrzflMcwWet0BOFUDklscrc6wYyY3+9k/eW4YG3MlxWldDF5f0iUAA1PJAHNCendbxMxIlbBQKsChw6TPnm4MDpiXo3RKgMXIl0oo8zw7i3A7t9U+tijMEt9No6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719270997; c=relaxed/simple;
	bh=G2ND1c+Q6ycTaD9U+MzX0R5Od2Up/QHJRFnz9vhzQsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cyCPOx3In4uTDtlL+j1X4lV4JQ5pZcSbhrJf5G2KlWlrrds5yx25HnMBtVPv2zmC1tOUGGqLn0cXRLTsAijlFajJ3uaLZWfE5y2NXZYUzRTP+KcQsoUxMRIsNnLrDLCDbsKwL0aDkiv1uQIq3hIKrHMgQSguxoKAWYvFBJaAgzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=D1KkE71A; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1719270989; bh=xHY4A2Lgmw6D/IlUTOJ1nqgiihzyUuZqVbuoKHMCoGw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=D1KkE71Abh2QV2YQk6SIIXb66XyGlSlOd7G5VpakA/HUsMe2WYpZvxFGSWXrKh4Pp85WKOzsz4T9FrovAN/oLpCiLL4dsQ050Rl+i+VOuSUwrzabh2X6/KjrN7KOlgYeMO0HagbIiPpyas9R5z1EvJ2t/vYMnH8jrlFXIXz1sfUM/BO3k1/GJUB3LNxTzj53+xtzAC2XBZypY7ONUVnJDpbI5K4USGNXfgEVPtSQ5eQUdjD4o94e2h3M8p0vNTonfoJf4y8q/65BHuOOw8YDmKKu8aybnr/2KNUAng+JWIZyK8169UHZrZwR7p4dDpotizcfpT+h7J/GEI3qdxBDqw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1719270989; bh=NzqBSkui2qdcsyaQS5pLeMrt26k8YLjs5aFewG7uBy3=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=A5lC3vCm0OdVdCaCYeAeg+DxSyUtSo+HL3Nj65unb+I+f/kG/TqaH26XnJkZVdifqj2vLa3Tb4KS5ntK5lppUpSkqDQk2o6M0JLNhkzUI8toYhjLRzg7jrUlJ9hHSlnODfFs0WQ4ZPdsMmflWEX4eUOl7bNORvAc5bAql8C/TkyFuUad+ijEhtkGLg1iexHQErHVKZQWiNy4MeMVdHkqIZh6lX19+hHT+jZSvyLm5xNcwfwaZrRSuqX9Xu6NKL9erzVotHfQdSdAwua1eeMroI6LdhAOWLmK8mjZV4ojZaItNLVuQdL0NwH+KtOGjDq/3kLeU9deddHlG0+yLon+og==
X-YMail-OSG: D7qQzhAVM1kBEwmaKGHL5qa6xu_.Upuj2Ya5UUeg1.5VCx3KJs1VNZXdkTBQOfE
 iARGDlR72Xao3dCMl0EedhoczVsZk9fqj9CiK1Fu9WVHMyHpy6QJcpDWlk6jzd1tddMDPuAZfejq
 mWBR.nGj3.ihS0E.ElIHDo08KlhzYjp9biIIBTRnTttJ1v4QR4h6WcAp_b3GL3thkZ88wra3oIBx
 AJuO78FKFYbK_OTYp82TttDagFydu2MLz8T7AB0lOZDGsi5qIPBatcxHGq8d74piw0bf.nAj0109
 .78fDhffgNawRB0QwAQnFGbu9cHhJrEC2Ro2CLxlrw9GHBK8y4QqFMXf4qb4rWjErqhKgK3W3T1d
 WjM6EjjcUslqcdFrNuZlf_ArqiSsDKxztbKniYkci9_qsJ_YblFlgS95jGXOWoqoFmWVS4WUx2oT
 j4mAB90Qxmll9kkql.40GUi5oxBxg1_2Wx82qauOIFv5_yMglqogiIwzrLnAsyarMiIgOBhh8gxo
 MwIkG3x_XNbF58PfMrXySXxxAA3JuTsS.60SlGSw21zUjToCRpOpJgu82DEHIVrQDyyq5tQyQQ.j
 CwjRTdw4VfsI4MOqRxMSItBm1HH_a1CNsz8V3IzH19onrOmNTrb1ddlSIVzDxBkcjlsje0dLJtCY
 WCTdQRFHH9nzU91dFTZkLfJ5TaUxlQKFni1q3CciiowJUz1fpsYA_ytzqoJ3K1OrxQJ5j2lL_C23
 i5bP_o_Y67mI37ADE_EM0DXWNf7gp5Q4eMl._S8kaX8BspYXQxvmCHJBPzKTvSQ70p3K3Of6TAdA
 6t52jQP_WFdeIniQ4mE2ykCRSKnA4ls.knH_iC5v7ZsNfK_QkpSpuIGt.JS4lk4X8Cezm8KE2akR
 6Qac2.0L5KxTd5.IwLPEm5pB1.5byMqtT1m6zIUsbWr.E7uPJCf4OQZI252.VvteLjyTkXE7iQT5
 ePsaK3_4v7xsuYDb3kvKSR_3AmTztj.3xPg0zAK7pRCcYAIKuvDUZARXXqE0jzAb2cgJ08EtD42X
 AiKMLjgQ3zZbCapiXpqjfqs5i2wqSpp8HmcNzOkdBsaaKsPwZYVETy2ocBsZgFU1M0j2vSxp3iq3
 IFv7VKlOwD2VsmxbkFHl7h6IBvVdXZ5H2jpVqpWPwDTzv8vWQGQ.VbI5qZGVB8c4obXqpo_HfXnO
 qWjwPtiCOqDtO0LFTRnu2UPyJkckmXE0LRjLoJiJxiD_JSRe2acERRgG8kZIqd7rhnH5FruIh_Lw
 YDK2ZFmaishT1SHVbvoHfrHozonS3EAjUFMhuCvwKJqRE77TiweUElEa.Sc_cDein30bAtIXwrPc
 sRBCYVoQw6dcUdRrfruvum4atCSbKsJldX.ewBS4dP1Khls0FZCg2Hx0YNtcY8ebpFT0mCzDIgvk
 LLnhS3LDHDh2dKnmZML8duiW85MRLeMsK4E.hqcv0lwdSlAvXyI5VUlNOx1ulqouvhQ9wYMZ2Q67
 FrCf_p.fsnlA2zmNEbdWKdRAEo0p2zB30BumsFxEg_wgSfowDOmgjl6dWg.EgoKXSxQkC5RDdlG4
 8qGMvxQNvqOwPzoultjRSG1lUGHE0jpytnHfi0wdbJWG.zmlcTIxfdaXGfD8QoDTeLy08X3b1AGQ
 wa1SMV37jTr.Bx.lfC2nWEZWnEmuqW1iu23Gf0_jV9bb.Dz1sMDee5qFJAegJ5.lq_6BH9Bu0xji
 t2CiyAJX2Ipt3P37dH52hXC7XG3lgRR3uh1hvy1Zpd.RnBhUfI8lCg6fKdux8Z7FMYx7xODWlEzC
 rJIBjpFrl.6muEvlsEcIw91_5PG5hOtV9icvTaBEE5dDZgOhXo0qVuGndu4W2Fs_6SJKX8UdXmB_
 SvcPsnQXJwPSrfBEs6o_A99J9SUYXs_wtjjiStBwmYz3wiUIOzy8fLN1cHOPtZu7YC9t.XiDZwuH
 4Rk5S1AM0Rwx3cJhVb.8frzYkjXpOCEvpMFOE9jYYRcKNz.RuG8ZWz4TrJfCSY1E1UoSYChZV.jv
 s8GBHjtOaJw6d82rvzOYEy7WtmMEho8qoLb3H4cENgXB4yw3HLnonT6hXWdx1.KanJPjJ0MelUQV
 YKrhufoYcaxFOT79rVpZSffUl3DC_0XwXXAyFZECYiaHsIqIq3CUeYCu16i4.dMayjIiMxOX4KZj
 I9rmhNT4Zq5TYm0I9Hx4HUC7Ielr2XbwhRPMyw3seWx3kNBzmmlsxWp0ahl5hLywY7L7UIwhaOQU
 ZopJJHXK.cop4wo6XWbnlQe5baYxkR3E7dbzOmnxr0zEY0mmK9GYni6GZdHGTb0OUnO09007Iyry
 Mn6KXyTsPd20y
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 986ec05e-1a64-4b9c-8db0-8417941d955e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Mon, 24 Jun 2024 23:16:29 +0000
Received: by hermes--production-gq1-5b4c49485c-sbfr9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 20dddb9a63c6f8e5552486f1df88fe13;
          Mon, 24 Jun 2024 23:16:27 +0000 (UTC)
Message-ID: <d346199f-276f-4893-b09d-81a542e35741@schaufler-ca.com>
Date: Mon, 24 Jun 2024 16:16:25 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v39 01/42] integrity: disassociate ima_filter_rule from
 security_audit_rule
To: Paul Moore <paul@paul-moore.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com,
 keescook@chromium.org, john.johansen@canonical.com,
 penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
 linux-kernel@vger.kernel.org, mic@digikod.net,
 linux-integrity@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20231215221636.105680-1-casey@schaufler-ca.com>
 <20231215221636.105680-2-casey@schaufler-ca.com>
 <CAHC9VhT+QUuwH9Dv2PA9vUrx4ovA_HZsJ4ijTMEk9BVE4tLy8g@mail.gmail.com>
 <CAHC9VhSY2NyqTD35H7yb8qJtJF5+1=Z4MHy_ZpP_b7YDT-Mmtw@mail.gmail.com>
 <fbf7f344c518d70833398c2365bb2029480bd628.camel@linux.ibm.com>
 <d953fac4-9dbe-42a0-82eb-35eac862ca6a@huaweicloud.com>
 <CAHC9VhRKmkAPgQRt0YXrF4hLXCp7RyCSkG0K9ZchJ6x4bKKhEw@mail.gmail.com>
 <aecad5ea129946dbf9cf5013331f9368ceb84326.camel@huaweicloud.com>
 <52bffc64dc7db2cc1912544514008eada1e058a7.camel@linux.ibm.com>
 <CAHC9VhS8mC0NC=-gbK_xBq2Ry6Be76ARZSg9Zm3y0bsocGEtTQ@mail.gmail.com>
 <40c8ec3f-32fc-4bff-a50c-c1a868fcc776@schaufler-ca.com>
 <CAHC9VhTFOLeoQjXk_fMq8NDoG69wU5KV=Db7m20V02bto6NHNg@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTFOLeoQjXk_fMq8NDoG69wU5KV=Db7m20V02bto6NHNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22464 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 6/24/2024 4:05 PM, Paul Moore wrote:
> On Mon, Jun 24, 2024 at 6:19 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 6/24/2024 3:03 PM, Paul Moore wrote:
>>> On Mon, Jun 24, 2024 at 9:57 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>>>> On Mon, 2024-06-24 at 10:45 +0200, Roberto Sassu wrote:
>>>>> My only comment would be that I would not call the new functions with
>>>>> the ima_ prefix, being those in security.c, which is LSM agnostic, but
>>>>> I would rather use a name that more resembles the differences, if any.
>>>> Commit 4af4662fa4a9 ("integrity: IMA policy") originally referred to these hooks
>>>> as security_filter_rule_XXXX, but commit b8867eedcf76 ("ima: Rename internal
>>>> filter rule functions") renamed the function to ima_filter_rule_XXX) to avoid
>>>> security namespace polution.
>>>>
>>>> If these were regular security hooks, the hooks would be named:
>>>> filter_rule_init, filter_rule_free, filter_rule_match with the matching
>>>> "security" prefix functions. Audit and IMA would then register the hooks.
>>>>
>>>> I agree these functions should probably be renamed again, probably to
>>>> security_ima_filter_rule_XXXX.
>>> It's funny, my mind saw that the patch was removing those preprocessor
>>> macros and was so happy it must have shut off, because we already have
>>> security_XXX functions for these :)
>>>
>>> See security_audit_rule_init(), security_audit_rule_free(), and
>>> security_audit_rule_match().
>>>
>>> Casey, do you want to respin this patch to use the existing LSM
>>> functions?
>> If you want to use shared functions they shouldn't be security_audit_blah().
>> I like Mimi's suggestion. Rename security_audit_filter_rule_init() to
>> security_filter_rule_init() and use that in both places.
> They are currently shared, the preprocessor macros just hide that fact
> (which is not a good thing, IMO).  Renaming the existing LSM functions
> to drop the "audit" in the name doesn't really solve the problem as
> you still end up with "Audit_equal", etc. constants (which are awful
> for multiple reasons, some having nothing to do with the LSM) in the
> callers.
>
> .. and let me just get ahead of this, please do not do a macro-based
> rename of "Audit_equal" to something else to "fix" that problem;
> that's just as bad as what we have now.

Agreed.

> Properly fixing this may be worthwhile, but I think it's an
> unnecessary distraction at this point from improving that state of
> multiple LSMs.  If you aren't comfortable submitting a patch that just
> does a "/ima_filter_rule_match/security_audit_rule_match/" style
> rename, or if Mimi and Roberto aren't supportive of that, you might as
> well just drop this from the patchset.

There was a time (long ago by now) when the stacking patches really needed
the functions to be different. They don't now. I'd be perfectly happy with
dropping this patch from the set.

>
> --
> paul-moore.com
>

