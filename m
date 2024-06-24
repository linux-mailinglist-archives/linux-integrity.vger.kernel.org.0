Return-Path: <linux-integrity+bounces-2929-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2784A9159C4
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Jun 2024 00:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0E322814B1
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jun 2024 22:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14A61A0AF8;
	Mon, 24 Jun 2024 22:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Vl5HyIl8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED50E19D88A
	for <linux-integrity@vger.kernel.org>; Mon, 24 Jun 2024 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267601; cv=none; b=uk1HmDSysGZUaTr+GghXJqYUbxhmFYuKQcKiP/x5BXPTtfufzeYHIwCWmxBo7aTP+AJfvZfYa8KtjEcqaHEVW3waTxP+FcF3w4X+mElt79TR2OC7fjowYZtc73nV9PpYVbwQbaE0DSU4/a21XOFFJFIGhcj8ATYI1TekXPcqJYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267601; c=relaxed/simple;
	bh=BKGm5gwaFpnYPpQNdywTO3l10iR6DYFav3y0TJoew0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dvdR0meZ/bzNpi0mA5tkRtBj/PqRNTtl/rli+oVIzQsQJFW4sII9nHqXqTciEXBFiiKTVoSTcdF+pag5O7xvlh6Abz1TnbUMN+c390K7oW7ZqF/GlWs/iFS7g1aHD41/8bKQdJ469500m6NQYdaX47PRaSi1lEJancSu4jWAIDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Vl5HyIl8; arc=none smtp.client-ip=66.163.185.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1719267592; bh=hE7eNJJRDjHe4vjYW313nr4XeITqLOBk9KHHOFE2hRs=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Vl5HyIl8ryvRTH9FX17Kl0AgQkbNMzmLPdpnwGQfO/OlsAxVv2Im6aOK/svx4ujnWGtUjGBW+VLBQ8Co8pZnw7tFbOe8sZhKaX+AloOoNbvBCeNA3bcoL76yk0n21xgWnbMg5UcfQihZnS+G5RF2ofCaCq7AJWGtnJPNpbAUPeeExkKJS66fnVLRaXrHtASSyaPw51t59Yl7/FnR4QhZmwKC/bX+77m4T52vcOPEfse5cG/maj96mHUQnZL7X5d/xQL9LS+z1plMtl3/bleaTPwT71X9FYpCYJY2h/M7x0LdgaYWEZ4GXJ6N5/EN8v//GXOrzpUqYhl8OhiYXeaGHg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1719267592; bh=tS6Kb32Oa+GQ7xTfFxWXTarwmQMcJuC65lgkdNAF34S=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=MdP4YP6GMXlH8zYLG9uS6bfaK80KIfFXBG3fqg5aYTZAdHymX0wHwfg+ZBUsl/Rq3HXRUUI5Mbj0NqtdK7bGiZ84HlbLE0Qv76g8aPK4ENczEAvPXaTjYVBJfH5orahoq+DDBD1tUzPkx3AvdzYPqWyk35cAVrY8/2XXzbSi1Hd7eacsWMudOV4IJD2jOixw1k3Y2f1dyKNLjucwWvBNTtkPO4/aEh8Q6NEc6y/HqdURYlQCv89H6A2jNT5UoTVrhuWlciYpuj2ZgBCOaahAkTbJ0lqZNrlNrtJfcs132A8eEKGSIYmlXk83oa7Mk5DMgdy3jo+pGZCtHa2bL+CDGg==
X-YMail-OSG: v.9_yrwVM1lvYpqAYcSoH76agblang1qSMYj6MWDsmU8Vj8YryE4QynehZQWL4I
 pyYbWUzwuzcyYZVAzrGf1K6yWsxLXXgJHX.gA9b27RFZzLRI.D0d7.eP4c5uzpFEG5ses_KBvFHN
 Fu2rZDxIRhXXnBzJswEjQ5RouhZUnfkBLCMOsp.2gld9PcJCaZ.SYB8sFF7dCkhVeZ.88SooKGio
 _HgDmK8.4X3JVboWfo9yci.zTZFFYU0zECkRHj30EbcyRRFwKq_LCjFwiRyo_zlY137J5AVO7kpn
 uGdhekdFEubTvk_A1fI2ikTXAuTyaHFEq821rLEry05Ke0Ec9jp5_xQEJrOYBfTchc5p1jVq6sg.
 .oOuDNLPmNVUKkchwMHPsDlzZTz4BJ8C.XnfeOPt6oR3rrjR0lxlrOgeaBtvNix.NCgrGBncqtyh
 ZFP4oD.WAw6jWsS49z1GV2XFf8qDTdk0u1rsFHAE8_yV7lrMCWENvcbn_ZzbeiPVA4SRIzjIVi_n
 bl7zbtFj13JoqXGRmckpEe7U2UptwgedbEV6fZDi.Mwl.B31b0Ki9of5Wgl5v.qoOatLWQGuZWUa
 x.BbnDkdjdHfm1TiDSoaSRRyyKSzDfFR0EZ1WbEmc9Ish_dd5uWUkdv12Gp96PHXtiNrBN_uP.Qc
 pwobq4t1RstTkaoG2DX_isW0DZ6Rk2MLeGQnWsxOLczynkcWzwD8Su4qmpA19e_IfBjT0Qzo4byj
 IVWxkv4563knGIuDBu3FzrfrzZ7Mqd5X5jcHJwd81HjAqjdVQsse3fZZJ2c7mM9AcGm_MpsJrP8t
 ngtCc0QnY28.Li4DTzgEKzGgWrZNrAh571SvSFcPXZ3dW75EBX8cUUWuLb05nkKZXojz1zJ6l4aB
 9x1EfgXvIYdScjW5KerNltieX8lCplZu_HQ.JlDPjW6nyoZaEm9HT6lC3m7ECPNqTE3epoKdv3Zm
 zsyUtban7jlsJyBI.R0ixPDPGk3IRjJFSfsPbClteepmS5HXpt6z2tipMlgZn2lRIYQX_0qOJtIA
 avxFExnMExvQeIVxswa2MYISaSf.Bbu4AUNLOUJMVV8NUACaJNmsRKsuxmQl7ncAZ30TcvOs04Uo
 C5DgXtlJcwuFl1ngVKkd9p3nmBY_9Q3HWrzgPTWTi6ZHjoSy_yJ8GK84bPLJmugrrdTRIZYWgWa7
 u0ci4kd528eSfa.LI6nsw2wbsFfzQMwmWkOwJ3jq.e_YBuIfyUXNjwZ_irkwMs2otodyYEXATdH1
 SI6lBXTDMEUfvT0UySAQ7CcijBvMQsL_v0c6rPgSzJCKIhcid4dqXaaSA71T1e7tIH1w3hucMkR_
 8gIIJbk7LTQ3n1fmaZB7yDUKMyuc7YZocvQij.rPUWgW3u2GZII9RtJP9WqcrlM2P37fzIs_Ehvg
 8FlgOhqqdvvWq.l0Y0m9EJTYa8avXRulOxGAqbO4SczhlMAQb571tlnqTz3iTepeuyXQNWCo3SQ1
 9ujvsHoCYiB5N3i1fQPt8MwNe0_sNxOd8qPBcXjCUURyTBeip3duqt1pRndVTI.6xt1SnYkjny4y
 ZVDkEj8MON.Rwgcu1H4re4..MjB65792_ap4ND_ser4NizYXd4mckYtmSTQnUj4UWtt6fgMd5pgp
 YcG3b_e0e5Dse9E5.jl8lq05QYR9or91QMHl9M3xzih3tDHRZsQIAXhqUVrYi0ssu.xtz97nBUdJ
 FwmO_musR_mDVIf7EyDu9_cTwqCcwYuDDx7lCnTojmz0K.CYyqhWJ21jHipdZs2f52_YbIYNZWW2
 o1OSKb8zQh2mtVKWPT_22bU6JgzPSyWeu1f29bQXglg48IAYjTDWIqDEGjKnItgCSPB0u04i406V
 UVucBR5hcfrhAOIOU0737HjHYnN153Oeh7VhtLISdYWMRiNmAzMHc4n1lfwbcQHFUOf_GVUfeQ_T
 8UmMQ16ret.2ocoMoDGvFS0CfMfg163QWvwedAg7n0m5S_MjVXtckF11gJYWTgmvgWmWxt.mrYow
 MUzLeuCjlJYwq20tYDcg_yq0TGgbf6FRdiM5Pckv9A5k78n36vNcATSoHMQPd_ziP8L6.gwyOhMH
 Z2TiuKY1vjtLMx7UcYUku5Dl6WzlXtRkL6.JAyEjlIwddrJURV4.OgZVTnmR4gsWI.OkaOMW2hhk
 XGCrydyvnz5nVSFkJ8uvhJ8RVbKgF_Rc7DSCv0zd5ApsxsW_BV4Aqi7hKfPT9olgo5QgT4pfbXm8
 Ao3rm_ADSoYCEJepcWOsDfAv9MgdJQYIBwc1C9EH4gdGc3tYvSMDki2HiqoVoOiPyj4I3I82dGL3
 HlJL78Wz_iNJ_pg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 8075b96d-d4d4-4dec-878c-7eb65d0bd4b2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 24 Jun 2024 22:19:52 +0000
Received: by hermes--production-gq1-5b4c49485c-z272f (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c15a6e52e4eb98dea173ef919a765bd4;
          Mon, 24 Jun 2024 22:19:49 +0000 (UTC)
Message-ID: <40c8ec3f-32fc-4bff-a50c-c1a868fcc776@schaufler-ca.com>
Date: Mon, 24 Jun 2024 15:19:47 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v39 01/42] integrity: disassociate ima_filter_rule from
 security_audit_rule
To: Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
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
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhS8mC0NC=-gbK_xBq2Ry6Be76ARZSg9Zm3y0bsocGEtTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22407 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 6/24/2024 3:03 PM, Paul Moore wrote:
> On Mon, Jun 24, 2024 at 9:57 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>> On Mon, 2024-06-24 at 10:45 +0200, Roberto Sassu wrote:
>>> My only comment would be that I would not call the new functions with
>>> the ima_ prefix, being those in security.c, which is LSM agnostic, but
>>> I would rather use a name that more resembles the differences, if any.
>> Commit 4af4662fa4a9 ("integrity: IMA policy") originally referred to these hooks
>> as security_filter_rule_XXXX, but commit b8867eedcf76 ("ima: Rename internal
>> filter rule functions") renamed the function to ima_filter_rule_XXX) to avoid
>> security namespace polution.
>>
>> If these were regular security hooks, the hooks would be named:
>> filter_rule_init, filter_rule_free, filter_rule_match with the matching
>> "security" prefix functions. Audit and IMA would then register the hooks.
>>
>> I agree these functions should probably be renamed again, probably to
>> security_ima_filter_rule_XXXX.
> It's funny, my mind saw that the patch was removing those preprocessor
> macros and was so happy it must have shut off, because we already have
> security_XXX functions for these :)
>
> See security_audit_rule_init(), security_audit_rule_free(), and
> security_audit_rule_match().
>
> Casey, do you want to respin this patch to use the existing LSM
> functions?

If you want to use shared functions they shouldn't be security_audit_blah().
I like Mimi's suggestion. Rename security_audit_filter_rule_init() to
security_filter_rule_init() and use that in both places.

>   It looks like you should have Mimi's and Roberto's support
> in this.  Please submit this as a standalone patch as it really is a
> IMA/LSM cleanup.
>
> Thanks all.
>

