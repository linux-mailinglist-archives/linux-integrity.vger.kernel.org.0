Return-Path: <linux-integrity+bounces-6230-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52673AB88FB
	for <lists+linux-integrity@lfdr.de>; Thu, 15 May 2025 16:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C7007AF60F
	for <lists+linux-integrity@lfdr.de>; Thu, 15 May 2025 14:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB06D19CC0E;
	Thu, 15 May 2025 14:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LWNwrxC2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AC74315F
	for <linux-integrity@vger.kernel.org>; Thu, 15 May 2025 14:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747318357; cv=none; b=gF0rquSUP5nmgJH5GHw6wZBynsDXCYeJ96evyELyTbCHmABhdPyid+V6nvQxbQ83FFs0TeiP0HNl5QjIl3rMy0FqCeSbWrnOsyz+fVo4eza2K7kyXLyIcOW+E2ucQIDQKaBYrqhPKi06Hr16YhhkKk4rGpRtiB8SbE2s8XDSSY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747318357; c=relaxed/simple;
	bh=r/mkDI9oyFKrFBWsJfAjSPO6s8IgcWiiwSiqyst0XP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZIrjZHNXD4gVSI5alAcWR/6Hi7/MQ15nkwfu4w+n63iSTzjmEcslQBwgz56GspYAe85HsfSi558J16vzCSfZRS3KMHQvjM1bmsCMZsAjFcCqg/wAngC7nm8hYqk97fc0+PZf0XjGbnuY78fbsqDHw6FnQlrBIBQfH74gJrqbAQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=LWNwrxC2; arc=none smtp.client-ip=66.163.190.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747318354; bh=t0gNI7vdEbkAek03QnMfylEWlcSHTuTn63QPqntwR7w=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=LWNwrxC2zm2GrtntKsqRmL8CBN4hj3fn4StGFE5ms1hgnH8k0gi1oysJSQbXWaMCBAt7wxEfLkhe29be0JlYyY9B4abJcS8bIKGib1OXRclWi8IaKYWaaZz3F6j0erLW5HQRg5IztdiUDsm1iDV1uiqVv+d49IjQaLkKFf2U7HaOYuSoaV0/ak69oE9gjijFQiwuq6BiDUV+WlOcMKFeymd8cKsK7yrHBCHs9EiMWcS5Vfexmoc3VXgqHEC6A9RvFxjGWOWqmN9fL4mJUcwPRaO8poP3psF3hK0NNDsIXUZ+0cjKW5JX7S2b6uaJVq+ufzYrdWaEkEecTEyaw7DlQQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747318354; bh=UrInA4SNZmaFSXATEK6uXfgns8KiGvdC+bcfatP4qPv=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=EU2s5Q/0cmIeSXhirdAuI7zdDvJvPkoFNM1jItcXPJOso4CkhbzvMojokCoKplRAb6j5I5xg86ZcAi6mmQWf89hDploY7nrsoIvGeE7lD/1x8uzXlJ0xFiAe5EFoO6lS73ePP2jqBxz/23uI77NYna5fhnZo41pM3jC9FSunCwIUNrPBKwZyYVQAOfHMNOOTQW4IGBVI1OWGHHvyFihESV3UOWV2x9MnukWw7c6MOXtP6zdzwvFtKo1LEqzKxZ3GXWyp5RsBfiZnabQhzDoULzUrLtVoyGXMzd4t4tv/VQgr2SeEFhe6EV4jgTVvd4rHaRIMdkoc6+ce9lQ9c0n5bA==
X-YMail-OSG: xV7FwL0VM1ma4VYkVAS2mJjIAykA.j7gmTBR.24zxl87xHe6OrHfX2IRu5cgSp0
 HfL6ozUmkz4iE4pvXymmU9UrS6vSpcAW7nfjJizmCOXoupnGfHR5Mtt9VgoRO.jpsQRFD9477i32
 nKKO.UHkaJLop7DxrEW7J9O12OVMiQwgOCOaag2sYbhCcwiNU.mWPTYRVVKhXn5Qk81iCpfITxIP
 DdBp_JEtonJ_MN6IlFMANukgZ1yaM9OWu4V_PIL_Ieg1Qm56KrqE9zVpyBd96T7VV0Vj8W2WnDJz
 2GvSavxa4TP.S.J9cD8oiqOr81kKaGKb61eqKEJpQFeD0MEibCqG4AX2blUvT7P_wCaP6I1h.lQ_
 JplLYh9BWU1QCTlL8SpBUmwMZZvYtfHy.AM2xvIEHem90aRXBizhLVpTM_u1wwWSxGQGy_KKOBgg
 t0BjLcG9cpJAcQoUDQ1RMY8Tionvt1UiIG65G2t4QWxNIBYFqwF8J1Z09Oezzi6IO5LNYI86LVSx
 JuT9_nH7R2x11f_BW0p5tU2E8Jm_O0r9ti4eiXNP3Zo13IxuBWKuNUUsWfQe_JJPAi9hcyHwsnFl
 ker4v0SLraKsr7QDHXCyCaIeWYbySoGBsAX_xSmQj5lGRpa6SO_kYn5kS1QmaNASL7CLSLmd0OTb
 ZsnwPHU_m56N.VNEe9THYfpuXq3oyZS3vt.trgZuifdoaNbFM6SeoYnPQCuBViuAVNXzgXR6R9Sp
 CdjfGFZ_Ia40shgAS7GWteqqfsz8oUs0tou_REa9d_UzT_b_7ew6VucYRbaX9DF1PnqZAo55L3kJ
 KDC7bfHVycT0PhkixP4p0dQx9fIWkxPsZyAfAtcB15rIfCd8V3dcIoAB36fxHA_ajGJ7jgMq6Wik
 yoRen7_fg9W..FSF.JCA0oJRTcnGH5JJlx.2b6D1akbUOsCQqyTQmSQWsDUbvFYkACs9O02G_ESb
 gu4y0BANS_GyjmvR6a34RqAzoIV_7ayKOfpoeQ.AFqb7frFAxjIGRDx4G0IgY1T6xp30KlyKGasj
 uA8c3Qk6THBH7UXW8ygw.O.NHTYD9ikdwcsqyDxsGdJwGzHU4NPu8UK.ufjWKMhfd3NfwIlA7RJb
 V0Gqb.YG5Bh2lnI50bCRyRKwE7XJsXMKGjmZlDS6P19pz2qXo4OkKVLNNaj3t5BaTvlom_4mYHIa
 k2ihLQbVN2wyAc_O_AhK9vRyGZ25jtbt50E7f2PG_e4radavkutuVsBFv1CrSVKKfHWf0ki7Pbwk
 cAM6xKFW.kk.ScAjN8wi.vYa8_HJRmPne1D7Znhn59JfRGVmFhUJSSgMLAalRHYamAxxDn6Xrbwb
 LBD4NiPLjp08AQd9Oc8whRx2vsSDg4Sqk6EWZgZ5RzYg_StgRXcWc_zVv54utaH5KsFwJh2SIONg
 .AWzci0viqnAFth78LcuTIeXiL4qCwce1rPW7i178aeLOe.lV1_kkrWtj39nehA5xh3OjQd93hLB
 YuIxrAn58r0A4IWkmmqKs7XhZ96MziRg4cOJGuew2RlqJLvs8r5zoLV7IiIX5EemdnU8VHBebuQg
 uWiqHHEktOfKYQAvGfOpbbT2wf5RSvs7cmjzM.qfCZFyuInE7I2EeP8yFEYperMJEARLlo.pBykH
 acym5q2.XEiNU_TObAHloH5z65sdQsXkYO.npwBQVKlUV8OgcUkEzOimsyVwvna0_.pVZU53HJic
 KdCqYBKtm8tnm7Ckl2ixLRBf47J2oDH3jrY4tU9EjM4rsBCDcId644jS7ueNigYy04Vu_QycTGbR
 40ByGE33c0ld80Zx.XTuT.fzfGWD4Ud4QIC0.L6.V_FXO7q6ztIu5deYXiP2oiB7AnzmcA9ezCJt
 TmoV7DMOrXfjrj2ldmgtVePV5ujJEcFI49mA9OiEH0uzYy0MCw2pjspvxkv7pvZgtmMjvw.pvp0v
 Xa0QEgHEBVkTBK4f55jXCOvPmER0H7g3L.SqamiQczWQHk5onT74.o5csECXU1S51G9paqAjRchS
 plubfvJeJ9ONtJXZhPjU5aSOTfL2WIbkd3oL8DfSgRLhCHVB.RlHct3aQ2lTU554A0tXcpKp9Q1d
 qgFjLHK7DblM0KrauLiNtkuSudhqmgrdc3kPuxHZZFLdA1D.zcYoVerkW5OhSfJusovgNFbTrBXo
 6GJOKuBUakugf8tFao7KZixUWolCOli.pA8SLzY.4oLVCz9WUVnvXQtFx6E7TI_C51qMn2bY3km8
 9A.sGlWTSasqe6JagcJeuaH7.zMThMm9uLo5WFQBhmQos8mRQkEhb78x73ocRbUMW.8zXHbncH8k
 sVypty6_uyopttTaumHms4uY-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 6da77d25-55ea-4581-abf5-9343c9dfd048
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Thu, 15 May 2025 14:12:34 +0000
Received: by hermes--production-gq1-74d64bb7d7-khmfd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d4bed09cf381ad2d4b7ae6d00db4595d;
          Thu, 15 May 2025 14:12:32 +0000 (UTC)
Message-ID: <5df7b895-888e-4aa0-a21f-0a8264158bfa@schaufler-ca.com>
Date: Thu, 15 May 2025 07:12:31 -0700
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
 <c5b81e66-7e73-41cb-a626-9f18f6074e53@schaufler-ca.com>
 <CAHC9VhSiGc16g36gtZvWKYdtdx-3WG7HbWWhNXvPSBRfA7uphQ@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhSiGc16g36gtZvWKYdtdx-3WG7HbWWhNXvPSBRfA7uphQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23840 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 5/14/2025 3:11 PM, Paul Moore wrote:
> On Wed, May 14, 2025 at 5:16 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 5/14/2025 1:57 PM, Paul Moore wrote:
>>> On Wed, May 14, 2025 at 3:30 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> On 5/13/2025 1:23 PM, Paul Moore wrote:
>>>>> On Tue, May 13, 2025 at 12:39 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>>> On 4/9/2025 11:50 AM, Paul Moore wrote:
> ..
>
>>>> In my coming audit patch I changed where the counts of properties are
>>>> maintained from the LSM infrastructure to the audit subsystem, where they are
>>>> actually used. Instead of the LSM init code counting the property users, the
>>>> individual LSM init functions call an audit function that keeps track. BPF
>>>> could call that audit function if it loads a program that uses contexts. That
>>>> could happen after init, and the audit system would handle it properly.
>>>> Unloading the bpf program would be problematic. I honestly don't know whether
>>>> that's permitted.
>>> BPF programs can definitely go away, so that is something that would
>>> need to be accounted for in any solution.  My understanding is that
>>> once all references to a BPF program are gone, the BPF program is
>>> unloaded from the kernel.
>>>
>>> Perhaps the answer is that whenever the BPF LSM is enabled at boot,
>>> the audit subsystem always queries for subj/obj labels from the BPF
>>> LSM and instead of using the normal audit placeholder for missing
>>> values, "?", we simply don't log the BPF subj/obj fields.  I dislike
>>> the special case nature of the solution, but the reality is that the
>>> BPF is a bit "special" and we are going to need to have some special
>>> code to deal with it.
>> If BPF never calls audit_lsm_secctx() everything is fine, and the BPF
>> context(s) never result in an aux record. If BPF does call audit_lsm_secctx()
>> and there is another LSM that uses contexts you get the aux record, even
>> if the BPF program goes away. You will get an aux record with only one context.
>> This is not ideal, but provides the correct information. This all assumes that
>> BPF programs can call into the audit system, and that they deal with multiple
>> contexts within BPF. There could be a flag to audit_lsm_secctx() to delete the
>> entry, but that seems potentially dangerous.
> I think the answer to "can BPF programs call into the audit subsystem"
> is dependent on if they have the proper BPF kfuncs for the audit API.
> I don't recall seeing them post anything to the audit list about that,
> but it's also possible they did it without telling anyone (ala move
> fast, break things).  I don't think we would want to prevent BPF
> programs from calling into the normal audit API that other subsystems
> use, but we would need to look at that as it comes up.

I suggest that until the "BPF auditing doesn't work!!!" crisis hits
there's not a lot of point in going to heroic efforts to ensure all
the bases are covered. I'll move forward assuming that an LSM could
dynamically decide to call audit_lsm_secctx(), and that once it does
it will always show up in the aux record, even if that means subj_bpf=?
shows up every time.



