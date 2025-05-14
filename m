Return-Path: <linux-integrity+bounces-6219-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E28AB75E1
	for <lists+linux-integrity@lfdr.de>; Wed, 14 May 2025 21:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9132A17ACD9
	for <lists+linux-integrity@lfdr.de>; Wed, 14 May 2025 19:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55752918EA;
	Wed, 14 May 2025 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mFVlZWii"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4594A193402
	for <linux-integrity@vger.kernel.org>; Wed, 14 May 2025 19:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747251015; cv=none; b=ErDp4NyUY7V224ALRecyjR613qDNAq44XGIgVpQH8bANA5yOXPu1pulrQTaGeCS6EAOu3tLqjWddswNtM4S14E9mp6Kp4bYSJfNLNUxoa0LTagFGXZxTX8v9ralupkjeXGcsBLA8Y12AkJdKoi1aWxHUXj56KWdXFuoL/sWKVMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747251015; c=relaxed/simple;
	bh=2Zy1aZqE+i24iCRAI49izHCbQ76Qy3ZXY73GfHlQZt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LbEN06QeFjZTpjZptkxKfowOv89H0NyYHnt/fmkrDxKqB7zdZFBkgCGU9eIuwqnd9P9EJXRuzkxePqlm5zizyurFkuppEKM2pJqFDlsFZjxPTmU41evihN2WZuc0ouL5yI5p5IlVhnUzG9m8gEavV5OlvKBVp8+T6s/gnQkqunk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=mFVlZWii; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747251012; bh=juEO7uvn9BDdZTDIWbVkNt97llfM9pA1CWyodPLggxc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=mFVlZWii5xkCb6LOdu2PASmRSvjRhV+ziItzkN7+m30cj4b2j71WbKASCHfhgHQ3fcsdmMjQV1FLYUbrnA17piRYep1r9nPv0i5yMFCeSH7EYW+J/xQTaLZ+IKyl+MKJ7wOW0bto8Igs1ev0nApqoBeK8dSF4mV1PVTa0Im6L0lTX8Q+OJA7T1NMLTggvxDwZUqlvfG3/mVUGb5j6WnlHqMCOvUaDVKiG43FhZv+7YVH2WFxEybH2RP9w2QaP0PifgX4PwcyfOdorSeF25IyWoLpMDmTuYs8sSpOXCKV7D6ZtAZFTK1gEX427Uvtr3Ck5pWHaU651zHFaFvxkycd2A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747251012; bh=CsMARUMCT/5y7py+/CXPuN8SrTaw1CJcFEVN5UXRX5C=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=W6fyhxOyc80Si7ib4pkklLxJb8qr7QsjArRVOGIh5Uoo3tYTtrgLBVR93sX8o8+sD+c4EP9ezKSMC8ed3BBWjvzxQyWX1Wj4cAS8jpBRjmlNkp531nHpFgC8QADMCAquzKCGD5kwCJnDlptdaYMRntZu9e+aFemT08c7y109CJFzSuQyayk6QgHpcLJGtW+ZajfkRfpdkHKNb21JNyQjlpWFiL6ZNBp9ajSua4VcQxkRDuOAG2kh8LQz67wE74tKEnY5Z3MYbMrDyi0n6tqAX64srzbMr8zcB1i99WNJ1rHtMVcKtIn+9C0TjAKxS7WyfqQea4D5uWwDYo3PWyvJFg==
X-YMail-OSG: HlpItOgVM1m_gsVRLhIgZgI2s4tHlqB8Gk.190qWjSoPxYkPA3TVG_izWU_xg_S
 ScD61FA_.aNz_vFzS.QPAH5TENNmMOlBUPxQzWiRpb7VwL3dI1SeBD7Gd6dETqvxFg_Cgz7.O2qX
 FOHxXPbWDo.aAPUaNlAxW39oj4cdpAo2PAwK.eQ0RU7ZehURZgCRi06NXP.nmbYnklsJe0Eootz8
 BZgmBimLzYVlYSPRbE4c33HbEYt4s1w16qu_T5QUQcZgJr.Y6mOfMb22ARUzZFJfiZEcw2Tcg3CL
 PeYUdUPbkCohKcZTM77dqvvxQk4VXuti1hCCaQrMMPDSgSZTZryRAEZJNW9TxST7ZuX40Spwq4Kb
 pE_c64GHNWNOI4kNOxbbZCLnLG1F4gxAPQ7cffygUfPlMFWulhKNyd_jykiB2AJV44f6qf0X09sP
 W_Md1EKlhpuPDRfvWmITaCHx.X9uBonEMGGTJhMuEScK8Nh.Z.yYpksyLSydAfEz8DSzru9Jwt8N
 vQeH.BDQClWbc0SlWr_BSP0hYaL5ppvyozI40DzvtjJSHTbeGFadBik0ffCrNYbAvtFv3F9EDs6o
 orEyDGZ.3sx3jjEPUu0XUXHQ3UXcBDxmSgILsmlDFmqRxG5fgqRZLsOi.gOGcxRTscZ0phpSlyX.
 E1PnhQ2wZlnTW_k58t1DmeMQ6uzQ_WG0tx8_tGiij9NRrGI0EE9udXQRTVeOR0Wkl39Fs439Uh3Q
 2K8odBbMosYJOPmhY1OSj4HujU9NKlWAOPEdhgnE2yYaQ5CgVA2FlQDhEW2W73xZd19eRA2xY.iX
 lcxy.HKGxrMX0BfAFK4nxC2Ybqnc4AKK9QNxm9hfDxiN_.nky4dimemQkJk5q9qo3JdPhPV1nk7_
 pkc7qwZGfuIAM9e.tDQloM5dO0f4z8crFuY65A0HH5BW8hYCXA9gu1PGotuoXmuNRM0tfUZK2dr8
 CkAJ2DhPoQaLOwCgmQgKOgbS9Y0mYIv102RkQeq6yCJUwU.5ui39wthDGcLemx2JZjYdll8WWGkh
 GHh7Fgxfbp9ZkK1uHZ7WeEefegOWAbGJYoZHqgfSY6LCQMngd4UGH8FQhc8MiDly3erwlfWMtZ3P
 Oaic3xUqDWwJ6AIBEL8s744tX5fX1ZcqH.AeasKG4wOxo1nba3b9fFf9Mj60MxTR4TxYUD6woPOI
 Z9BbfZ_yKRBtWheT8uRwhZu0_x8sKIW2aHW2VKWpwwJovE2Q7lMHPVc9MyBL_QX.vLl59HHYFLtq
 EEKTcBChrHawkJvOpT7uuxAghTshwG0A8j.7Ffm0l8PIpBOjdY68ydobMVZOM2S6BdCGEjMQmQzL
 mOHvT1DZV6itTCrCXaostiZuu_xKZVmU7fgdRXCsXi8oVFNquOBC3KMXP.5foW95tTrVKfNlHiDK
 coYl79wrntGH8DAJsJY67CUtgeene1koTRdI0QOTIbe.fDbcDq.DzMEiI2amMOnTzIovQQskF4DA
 wnb4prC5eG.zjw.GvyUcW0mAIoXYabIOT_AF7Spsy6.f8YG15WHavU5NW_bQUdA4GA9_s_317vrF
 ZO7NlrGHHZN2Lg.jqZ4Ymb6_FR523xar0yb0Z8Dx_eehEeI.EsLx2gDXrDsDAYqTr9HZaoLID6yK
 pOQJltG2eKNLsBsPreOFb6IEMTirWvk7yvI0GpxwEITTZ4DDI2KrZaeVN9vX2M.hLlS8DPQLJcRL
 8o9tuGi9wlS2nq9T5YAfUmko52GsDcjLCOTy22YucXrtSwjkFNXewQscWG4Ptk3j4l2vp13qX5Dj
 LUXFOtupq1vARj76QGnRK8PK6fFYOT2PBgR_HOE8KP8_biHI9lD0E1ZopMHdVI0KfOZ3xN4otlRZ
 claXbEXhAhqzAOF_VW_Eb0xlyspCqrI2I7DcjBm3vhBRikG5si7Vns2Jvs7Q35C9Gb4RGQJBMoqq
 5HeqJUitZVD4dWcPr5cbC_ebSe2JtG7LjLsHM3nt6Jb7eEzb0pyKD0SUk7ofL6f8fS3IINztKj1E
 UamSsU9MnlfKPvMymNomPVroqcWYhuDdVbE3jd3XClj77Cnd_0iGgmb9BEj0fm5PZd693s51FHCY
 o7ozU7crU1duuw91f3tAIOAfYAwk63rF_LZ6MiUmKmZKPjkuWyAVicf1TJqL8tYLDyZ0xbZ2gTJp
 WJhd5Fa2v5c69nnbeExCntcAdtW4_usiTEoaSPsN.odX7WCNvfHKjqa4eR8NqVI1FN6ba2e2Vdna
 tmoNyxyU50fz1oPizULRwv9UVKGFLVfVJYQrnbDv93g87wM8Jif1wuZcqD2Dne1XkxO4QO6RDRMY
 d3r41aQUoNGQMKLqZNoU.pOMEJwU-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ff037e00-870a-4d6c-815d-d886fb8cbdc7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 14 May 2025 19:30:12 +0000
Received: by hermes--production-gq1-74d64bb7d7-45lk9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 14c6e5f91765fc208f40e9664725c54e;
          Wed, 14 May 2025 19:30:07 +0000 (UTC)
Message-ID: <3d884912-6225-485b-a7dd-2aa4073265f2@schaufler-ca.com>
Date: Wed, 14 May 2025 12:30:06 -0700
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
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhRUr+sXhLzDSjiG9bEVbzZd2u632dLMVpcCe6By_d_H4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23840 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo


On 5/13/2025 1:23 PM, Paul Moore wrote:
> On Tue, May 13, 2025 at 12:39 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 4/9/2025 11:50 AM, Paul Moore wrote:
>>> Add two new variables, lsm_count_prop_subj and lsm_count_prop_obj, to
>>> count the number of lsm_prop entries for subjects and objects across all
>>> of the enabled LSMs.  Future patches will use this to continue the
>>> conversion towards the lsm_prop struct.
>>>
>>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>>> ---
>>>  include/linux/lsm_hooks.h         | 6 ++++++
>>>  security/apparmor/lsm.c           | 1 +
>>>  security/bpf/hooks.c              | 1 +
>>>  security/commoncap.c              | 1 +
>>>  security/integrity/evm/evm_main.c | 1 +
>>>  security/integrity/ima/ima_main.c | 1 +
>>>  security/ipe/ipe.c                | 1 +
>>>  security/landlock/setup.c         | 1 +
>>>  security/loadpin/loadpin.c        | 1 +
>>>  security/lockdown/lockdown.c      | 1 +
>>>  security/lsm.h                    | 4 ++++
>>>  security/lsm_init.c               | 6 ++++++
>>>  security/safesetid/lsm.c          | 1 +
>>>  security/security.c               | 3 +++
>>>  security/selinux/hooks.c          | 1 +
>>>  security/smack/smack_lsm.c        | 1 +
>>>  security/tomoyo/tomoyo.c          | 1 +
>>>  security/yama/yama_lsm.c          | 1 +
>>>  18 files changed, 33 insertions(+)
> ..
>
>>> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
>>> index 40efde233f3a..c72df6ff69f7 100644
>>> --- a/security/bpf/hooks.c
>>> +++ b/security/bpf/hooks.c
>>> @@ -18,6 +18,7 @@ static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
>>>  static const struct lsm_id bpf_lsmid = {
>>>       .name = "bpf",
>>>       .id = LSM_ID_BPF,
>>> +     .flags = LSM_ID_FLG_PROP_SUBJ | LSM_ID_FLG_PROP_OBJ,
>> There's a problem here. BPF can have properties, but usually does not.
>> Unless there's a bpf program loaded that provides them it is incorrect
>> to use these flags. You can't know that at initialization.
>>
>> I have an alternative that will address this that I will propose
>> shortly.
> Okay, thanks.

In my coming audit patch I changed where the counts of properties are
maintained from the LSM infrastructure to the audit subsystem, where they are
actually used. Instead of the LSM init code counting the property users, the
individual LSM init functions call an audit function that keeps track. BPF
could call that audit function if it loads a program that uses contexts. That
could happen after init, and the audit system would handle it properly.
Unloading the bpf program would be problematic. I honestly don't know whether
that's permitted.


