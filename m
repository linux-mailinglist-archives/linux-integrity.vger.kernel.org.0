Return-Path: <linux-integrity+bounces-6221-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A631AB780A
	for <lists+linux-integrity@lfdr.de>; Wed, 14 May 2025 23:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6CE83B69EA
	for <lists+linux-integrity@lfdr.de>; Wed, 14 May 2025 21:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8B21F4C96;
	Wed, 14 May 2025 21:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ewokmhnz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE2061FF2
	for <linux-integrity@vger.kernel.org>; Wed, 14 May 2025 21:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747258632; cv=none; b=iQWEvLNCv55TpZ8L7dzlQsAmET2SwgvF7N46dT/gvywsagpxH/U7dJ0ylLWgtB4K8UqHlZ2wKwY3DHiOulHsglRlA2zD50Ii4GosEl/iskG1SzY/dTKmZuHToQPsJLr+L54r1Q2zLSCgom7bXF1hMN0075it8W/lOB9wT9iETYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747258632; c=relaxed/simple;
	bh=j5YwuITK4pcNxtqbVas0MbbU4h9BklRndVWWiAVdeTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UVwMvd/OdBlTJ/rGr9cYG1uAZy1yv65NNGomaIrNtq127kcp7kG5LtlT4I7bYC+cgICLDrS/swGZ7m5sN3OoSCa33QOnkhCaEOJZ+XozgeQPy3l5us/BGdTAgLKc++ffJpsmBhc5arWdKG3J6Hi6m8B8lIcTRpOMH5pJN8C+1uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ewokmhnz; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747258629; bh=aq8QipgkRkFzzw51J/EbqZY3BxWmjQKsp1yEuEBSAsk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ewokmhnzmU+HVQaxEe5lY4XM1k5PniIn5DLdSJn6tN8Kt4KC3S8jI0Jst/tFwg+RnNf4sTYh+FmfzNXtmxiAbSG0cJvn+epJGW7NV5RkDRZQzC8fgkVxdUnMT5YQBHB2cjGq/hI4bsnfu17F2DYpkrbNNYs8tf5322JPQ0QNXVVN/q5tWF0Li4ML81aCu2BPmIeEGC5xb+8dzB+KebD1HV6/AtFlzH1r9TXVUoTUtYHxrtHcRM8+ala+rbZUeADTntEVaaGDbFWtlKk2FzN7wH37uakaQZDsviU4yqjfJM6tSejAdNzLDUcoxJTAEggGQJ/jcHsuIy8lglwQ3wzV9g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747258629; bh=1ZDvcedoosQw47S3sX2NLNsMu913bIfKFRBcpjEv6jU=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=YYJ+BnRJY1LiQ829mpipK9GwzbYxd4qATOlsASr8/4bkvc0Y1gDYzHMs8L5bct3olfGoImoOnsnmkaIxA0YYSDYKATUx+4Pi3GN1+z+RRhZVnrvMVgW2Qy6HhkrQM5JwwdFHMHXX1HKHe2Sx2zFVMEPUYHSfcYR7s1mJYGkmvOGiVgREI+BkO40vpsQnT26ozWVIabx/fTACanwxJww7qaq+CzAyjz2ybD3GOY/qk+sNw75FZZ5IHU8Gftz1B0yOcq/N80RCwCt05Ydw+1PpqrcTEgrk4AMoFuXDNq32SRQUzWKQTiaxW+dZ1KLCzVj+U/GW8zTEAXZGCTtUAO3Y/w==
X-YMail-OSG: aZopYxwVM1l1S1Cl4VS1XF27XsWdbNMhVL9G3pMLnsCTUz2Zx6lzy0tOYUQOAqs
 456kOIFHel.hAqqfFc6z_dCvPKkIHNx8zgHwsSYv7GPf31jhx5dN34QRYNBUn.qxZSgu9YoviM8G
 rKqKhT5618W0TZ_H3tJPCue8xRgg9meQAfzQI7_W8lQ9S4VYC83mJdSjHfGbqRIedn2WT2QPWsS1
 qkp.icEeWmEWuzCgh7rPcChb6K.91QFctmXYpH3nscp58O1561EZgbEjp_e6lmAfLcMwjfk6Hrcd
 N9NcrWxbqpIuzfNR1N2bJh7px7XUT8X.PYPCjalR1MMUV5sxy1kXpyNTnLylfr_dD6358mSu8Ln0
 Mv95UgS02N19bRCRzAx09FoSboK2DouXu0Q3DUajs8LLJke.N.JC7xgmVe_6VHk3_SyzKyxBKXL2
 s4imAUXn46rza6IEFDqdHLn6KNgJNEDB60x5A.ag09vByP4qWJ9nJZpJ8Y7RA5m0jA7LMkPRVsqw
 qXHYX_0S0cLI6QN98NGaFdfC0GUtq.qQUQSrf847XkgdY1Yu.Z.YZgbGbujgkGtRtwxvhl5XH3Bk
 Ktr37TJVUVyIJxisHM8HXF_JmA_aJL.UWVNpAo8mfyQMnHU0cFwW8i6oEri2j_AdkOp5GEtRSSS.
 l80XdqnytjcZlwp9D0QZ83LEV6_u.WMAUABlF2gEoK.5I0_A7Q0nmvg3PNfKfHL1WOjbKjWOnlcs
 LviQ7SbfqsebsRR2Rdkmyb2UQlzinYq7H3slpIWmo8I_GoNqmoDINRT.UBWlG_O2T5ICRaN_3kSv
 z04UdE8nxUgxJofVYczlqgYcsPftCd0XF8DlgRLai4oq7HB6TjuSei7JbMCjAWq4Lcq5VGQGTKqK
 XqEDeUg2is8q7JPDxgTo3dQ65rOFLbgUUoYJsaQXvjn4byb58sIn46AoFFZ2vL1ImuhxVftJhom4
 0DOYtZcdNmASSmC6u3tA6_VPiTCGk72olprHFZ7Ul6HnP5LtWJ4KhifpPf1EaUm7aKCrAWRhicgy
 PKQQnweT0OOf9qGc0evvDrA0fGwGQtIzZZeGAULR6olvCZeaU0ieg8ESXasnDZkfgVUzKG.TdEw4
 p_c3ds6Ydd16.aPTKrkvJnx4WoVkBrTxVyTGrSAYif1ie8BVF2sTocQfykvT_.AcZMf0Z0P_pAnq
 jZW_LVG8AptAmm8dmOm8zqqNqAlsSG9Yj11LUf_DiWzcJLxkkylUryiyMs8YGbPGFWrbSXtofN4l
 vBNo_azPQDd6bPqWdI9v9ojUoFun1BWVyWGBQFp08QxhbXJjx80o2zWjQAf4eN8XoBFMa3nLF72G
 Fn1MHX9YLKU24q8HFaKuLtCU2L2g22qX1Q_i4HAGf6FInLRN3u5F82xHkAHQ1c9Qwv7_7xL_Ckhd
 vGbyE43vJtefTRqVs7uYTcuzbdOwfTnO9BWT4ypiswBRW9OVtm1ZxpADV.OS5TeusT0z9gstwrJz
 _sGCYSO6w_ViGiKDo_cZU7P9dbkDe1tNsO5eCJT5dcCD2_x_6KxSAfSDla90snuDXvUTXNlmwlkP
 EyRNHawp8RcS4qaA8zdqiTXoc3bE0O8nwpNeGHsFG05eAiMgrc91_nombRmUE.7MQ7F4ObAVPxky
 xqA7ji2VoMO4vZT_CpOPUaAHkEmqKJqzNtMVRvQGCGEyXS2R_0AZoI_FdWDO2XbmkK8m8w3nfYwQ
 dcpnKVjEZw1CMmAdPQn2vq.brFe5HPzeM9BIeSjFdjRrTULES4.Syq15ZeJUonE_Pxigl.uwA8Uw
 A7.A1QRHmIV_qx0C3wzk5_b8g.pj2yClKaSbvmkUsgWQleGNK4TY.T1x9sTNlpv7eH_0eVr0mTfT
 nZcHyDUYWYFvx8jYWkCk_BK28ElbtN4Vd_OYtz0eyJvkeUvcxPycKyThdfxJI1YNuqg8L3VLWXMP
 mCFH4IusrBxEJgQWhGY4QVM2Y9nHD.Q55PHB5X7WabtXBZs825T0YIvy4odvcgmVbgWM.WeooycN
 8pEZbyEMrQKNRjonFR2ObHETQBXRXO2KJyvu6dKg5f3rZtjCWad1MoUOtMwIOh0nroP.dXA2gWVB
 cHdhjJVjn.vZCpSRH9UjIpyc_CLZXT6uDnm7VYifurPpe4WXV8hFcXs6ESx0QUb1y7PwLu0qI9mD
 47GlPv3loaaIShUeBBOLxjDx0U2q4wprXnjiiDZ33xLVdELbkFGeWO6bDze5mxX4A_7doDtU5Rzz
 CH3HrTkO_VxK2aYoE2ft9FDHPKRsHxERHGrIwtXkdGEz7Nfq2cqpcuXvdOxvd_UoFB1Dey8PZ_Pc
 Jp2FkfvW4_fU2QddkKQuOY1YPGe4-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 51903e5c-bbb7-4a2b-923d-9c4a76128bb1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 14 May 2025 21:37:09 +0000
Received: by hermes--production-gq1-74d64bb7d7-lbnk4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1a3debea870299291c33f635b17b6e3a;
          Wed, 14 May 2025 21:16:52 +0000 (UTC)
Message-ID: <c5b81e66-7e73-41cb-a626-9f18f6074e53@schaufler-ca.com>
Date: Wed, 14 May 2025 14:16:50 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 29/29] lsm: add support for counting lsm_prop support
 among LSMs
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
 selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Fan Wu <wufan@kernel.org>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-60-paul@paul-moore.com>
 <81106a29-90ce-4439-9b4c-60bb2962fe04@schaufler-ca.com>
 <CAHC9VhRUr+sXhLzDSjiG9bEVbzZd2u632dLMVpcCe6By_d_H4w@mail.gmail.com>
 <3d884912-6225-485b-a7dd-2aa4073265f2@schaufler-ca.com>
 <CAHC9VhR5OFDvJNJLy9jKMsB4ZVx=phm6k6iebT6VuXD96kNEEA@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhR5OFDvJNJLy9jKMsB4ZVx=phm6k6iebT6VuXD96kNEEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23840 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 5/14/2025 1:57 PM, Paul Moore wrote:
> On Wed, May 14, 2025 at 3:30 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 5/13/2025 1:23 PM, Paul Moore wrote:
>>> On Tue, May 13, 2025 at 12:39 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> On 4/9/2025 11:50 AM, Paul Moore wrote:
>>>>> Add two new variables, lsm_count_prop_subj and lsm_count_prop_obj, to
>>>>> count the number of lsm_prop entries for subjects and objects across all
>>>>> of the enabled LSMs.  Future patches will use this to continue the
>>>>> conversion towards the lsm_prop struct.
>>>>>
>>>>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>>>>> ---
>>>>>  include/linux/lsm_hooks.h         | 6 ++++++
>>>>>  security/apparmor/lsm.c           | 1 +
>>>>>  security/bpf/hooks.c              | 1 +
>>>>>  security/commoncap.c              | 1 +
>>>>>  security/integrity/evm/evm_main.c | 1 +
>>>>>  security/integrity/ima/ima_main.c | 1 +
>>>>>  security/ipe/ipe.c                | 1 +
>>>>>  security/landlock/setup.c         | 1 +
>>>>>  security/loadpin/loadpin.c        | 1 +
>>>>>  security/lockdown/lockdown.c      | 1 +
>>>>>  security/lsm.h                    | 4 ++++
>>>>>  security/lsm_init.c               | 6 ++++++
>>>>>  security/safesetid/lsm.c          | 1 +
>>>>>  security/security.c               | 3 +++
>>>>>  security/selinux/hooks.c          | 1 +
>>>>>  security/smack/smack_lsm.c        | 1 +
>>>>>  security/tomoyo/tomoyo.c          | 1 +
>>>>>  security/yama/yama_lsm.c          | 1 +
>>>>>  18 files changed, 33 insertions(+)
>>> ..
>>>
>>>>> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
>>>>> index 40efde233f3a..c72df6ff69f7 100644
>>>>> --- a/security/bpf/hooks.c
>>>>> +++ b/security/bpf/hooks.c
>>>>> @@ -18,6 +18,7 @@ static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
>>>>>  static const struct lsm_id bpf_lsmid = {
>>>>>       .name = "bpf",
>>>>>       .id = LSM_ID_BPF,
>>>>> +     .flags = LSM_ID_FLG_PROP_SUBJ | LSM_ID_FLG_PROP_OBJ,
>>>> There's a problem here. BPF can have properties, but usually does not.
>>>> Unless there's a bpf program loaded that provides them it is incorrect
>>>> to use these flags. You can't know that at initialization.
>>>>
>>>> I have an alternative that will address this that I will propose
>>>> shortly.
>>> Okay, thanks.
>> In my coming audit patch I changed where the counts of properties are
>> maintained from the LSM infrastructure to the audit subsystem, where they are
>> actually used. Instead of the LSM init code counting the property users, the
>> individual LSM init functions call an audit function that keeps track. BPF
>> could call that audit function if it loads a program that uses contexts. That
>> could happen after init, and the audit system would handle it properly.
>> Unloading the bpf program would be problematic. I honestly don't know whether
>> that's permitted.
> BPF programs can definitely go away, so that is something that would
> need to be accounted for in any solution.  My understanding is that
> once all references to a BPF program are gone, the BPF program is
> unloaded from the kernel.
>
> Perhaps the answer is that whenever the BPF LSM is enabled at boot,
> the audit subsystem always queries for subj/obj labels from the BPF
> LSM and instead of using the normal audit placeholder for missing
> values, "?", we simply don't log the BPF subj/obj fields.  I dislike
> the special case nature of the solution, but the reality is that the
> BPF is a bit "special" and we are going to need to have some special
> code to deal with it.

If BPF never calls audit_lsm_secctx() everything is fine, and the BPF
context(s) never result in an aux record. If BPF does call audit_lsm_secctx()
and there is another LSM that uses contexts you get the aux record, even
if the BPF program goes away. You will get an aux record with only one context.
This is not ideal, but provides the correct information. This all assumes that
BPF programs can call into the audit system, and that they deal with multiple
contexts within BPF. There could be a flag to audit_lsm_secctx() to delete the
entry, but that seems potentially dangerous.

>
> Of course I'm open to other ideas too ...
>

