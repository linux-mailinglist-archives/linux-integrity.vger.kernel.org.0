Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9FBC42C786
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Oct 2021 19:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhJMR0a (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Oct 2021 13:26:30 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:44547
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229967AbhJMR03 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Oct 2021 13:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1634145865; bh=YfWdFeNX9j8HGBH6/puh7ZcMtMPOePbBXN+kznyhhSY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=G/ZGqQHutTll0M8fSbqQr7iFNVfGc8KSmGM9HvoAbAn6xdSPi8G1PQwKoH80+uOmmXD+f3LCw95rgFArEzhmTMPZiG9VDpaPCgTdkOK73ET7aRVZcUf6dZlt1Ez4k2PAc1+1N+4dFhhLYXyh84ABa58dEgcyzbX1FAivDqiSy3uyQeDVl+Nh3o8/koMx9C6ezuO0jAJ7/8UK3vdzyp2jBMG/0lGDjzuudXGAERGw1GV/VW4fPIDojlyz1NPe0CWx8I4hR8O9HHd8x0FZxnOrbRH4sahRHClNuDhOWmSElW0AkeluxcQdfy0RSE7kUHSFgq/8ks1kjduZAuqGPfal7Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1634145865; bh=QCeugzJnpQYOF442BowmyKhkM0fxyl09S2QaVxCOpHX=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=Afi1Yd2APpFrBxp4u+Vw35+a9IhTKivanbvlG8+/xkr2KRRW7eC75T1bB/GtYZVkW0azm0KqHlSSzSNiE5k9sYAFGu2tWQeR6Gb0V8bVcujslabACShH1m5LjmJ2hh2GNNtv2Kak0nS8fXi/iuW9zgXNdB93VL4Yo/4KfD1FgAXu0vhiIaZ764CNNKktQYT15jYf3sFWfh9AyNi7gZpSrtJu0VDxqKWdtdzG2lL5K4BuSo1AjoOpZIwP+2o28+li8iuOEB7h5P3ahdCQkx/A0slvRoaveQOoWMTs8DZICpMJQ4HXkg4BGjBifeIUmSZmQaLYaVGVH0oSz0sBG2y5+Q==
X-YMail-OSG: NiryiCoVM1lwH9Ia1yKJc1ljAA4_ghmPFOjBCJL8CnrPLxmdo76MIRPfEHvRZKD
 .G4M_yxm7_RlIpTPrFGWLH7258ANn6f2Uwvvqrwb7Pv2Di.QldK6WUkTyzNVhB9UTOeXT1kcU4uW
 v2n433NnuKHQQfBUiXuH616VHtAm_mQnKO0N3GDOjSacqpTF0LESRJiT6aDMK0z..aX8waHLpeBh
 PiHccNVeax3Xf5x891DpDeCn5_iq4Az3jCeyB14iXQmIujE4DqKqJAbHfV7FNkVtuz15rVVhFOjf
 0eLHWEbBP.Qf5z0HLT1oHEEd5iMbjdbPRFHz7.YfLmSLRjtdLTiXqmt0OAvFOLmhgDqQMM.tXwMX
 84NEm.LApMzHd86lNHrYT6DnihOA_Dui0eungGFUyUMPGg7GPF359pR59xHeTRnG8lmPM_2SDKpX
 pjuVybXJ0xmKGCIXLrsBNfD7gTagg6U0RvtjCEJOnhdlEwzCTL36mU2.l9h8kJHXleq0YFQSCK3j
 IIWzfGqOH4KxS7JcYM40B8rbf4sR6eIvW1h5bj6hwBMOKR0EeAFb2.Lwx_kciJaFzM1aEUBGyNJ2
 CI1hBKB6HGt4y0SkrweTKpm8KMMWBLtegfy4fV4KP9yr7v5sbE6kyoDsW6q9C0DszXyMjT8ypwao
 bE9ZYQRziSxm8MM3bZgIeWcy9aFE.XzXauIOvDsLc1xvZNdGEfpeD5Pw7jogqiaG6tyh2S5wette
 1XksY54.Ho.yPmeKcXBowF4A1udwoJMkA2bVwIWIRr0feBHyNp7FJ9E0mN4k9WyXgq4RY1ffRuxh
 .YaJtEp9LYeAdmZHZcvpUaWJJXNS3XnEn8c38CFJjFiITd5MAz5tDZ6sQ7Fcx8n7E60087e7xRb1
 ghhUNdn2biP5zFk_UvQ52xX6jr0VXrkNM_gx1JEJTcOGaVh__NYAkS8E0DRqWD0jD2pPAKgL5oaH
 SPFdpPwFE2Bdd2Fpql0naen265TGz1LvTQhw_ePgZgfffnLVCuoRArJEejVKAXxAlFNvHDoz_mzQ
 0tu6xEZV1udyDUvmOEY4y9yhYPGlxesBiiplhivsg2qvaVFDOTq03OzpKsJ.86EISM6JVo9h3txO
 bSsLOL3Ej.pQ4xgrQBf4w27AR_exdxkP6JlPe5MhCOJPeoysOmoNB8v9HWevs4quZjMD7_AcihvX
 vVYwtVowYexKwvbyLfDDNz0NqFFnA9w5EyQCcltvHF3yD0A_H8svETwtp3huPUyFV48T258crma1
 veNjq5urIUxsek.psU4a5N39WNDZgOzdhkT3CFZiGwjhb1NnP_qPWJgbao_x3q3W8BEFFhjkum9N
 QFiOGeCbtcseh4WdnJm7.14p9z7ghRE8n7gjSFDtQ8ftUVRpSvqSlRa5vG06rcTJlXuJUPt8FTaJ
 pDvp.Idm7bzeuGJJyPBWoC8XZOkR2dqfhGK6A4VkE5WePr5RwOhPtLFSz6mP48i9eQI1W0p6c6dJ
 Nw3RXXAVXjGjpg5PV_bkC2XV8NQefiOzQ9_ksLa018Fwij.dgHeIASI66wnR_PS_HxNuqF_uyI61
 EFlnjbJ0xoQzzxTB49VkKaRlbu40Fc_IC1N7IiJkS75KbByE5JJmdORE3kn8TWvQpoRN3g61QcFO
 p3Hxh5jG7NLkw5yR3v2NTqHj1tR7775cx57ryp2z_IoqHy7oux5.ydfkcv8N.LIyv29j43RVGiCJ
 2bydw0Y6plZhTVxPmrQ3KlEooXpcA6iGIZVut9xvdKKiihUFgw3QlyHnq4r9MDlAZ8TvynUycuR9
 omBB2zcFUHcc9Sp2pDH6vE3D9cZVWhNSX1B9ER.fDCR6tDBmTMDQHvyIsXPIPlFHTFjTcjg7wuce
 mUkKocv.ZH_076ySmuRQsb0iVoYxn4T1nCgg7mZdoNgw7yn6jhZbIuKCQVk8rBAfRTp3_j1_ZKVj
 x2Oa1of87dRDn.zIU4_sY0werSIa13En5r7INQjC997a2WoWZ5WphmQ6URg1q3HXsMrkLNE7UpGc
 g7F5LM0Lcwq6zX5d0X7sTqR6kDaXi8hhSMSUbsv0CUViWu5MTOrYjaieHp2AbD6lw7U5Xu3aUBCe
 ekTCN3g59mUuCSJCLeieIhpV3op3wVg4YsQVqbsXwwohz5GY3i6BAxdca._PoF0yWiLBuxppWPRw
 b8DBu7caXnjC_xJTfipc.8s9JumNrQ.73ui44NhYArQHZI7Lyf0Iu2IDgdgVV5.wXWIT.szr.gVg
 PusaWMtQJAJghEtlpbmle6RwUJrR0qpAy4mPaPGREYc.HljMPOb17v4cQ..20cTHQe5meZNX7Mrs
 NopWiVgqo8DOKbxpd
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Oct 2021 17:24:25 +0000
Received: by kubenode504.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 15281eb7306d6ee34512e3b2f6b2cc89;
          Wed, 13 Oct 2021 17:24:22 +0000 (UTC)
Subject: Re: [PATCH 2/2] fs: extend the trusted_for syscall to call IMA
To:     Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20211013110113.13239-1-zohar@linux.ibm.com>
 <20211013110113.13239-2-zohar@linux.ibm.com>
 <d4273866-607e-37be-076b-a920bbf08bf9@digikod.net>
 <e1c2d34acb37d85e94af15ca1edd162e1e7f9a2a.camel@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <4df99ebd-ca38-a829-b437-bd42dc4b6b1a@schaufler-ca.com>
Date:   Wed, 13 Oct 2021 10:24:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <e1c2d34acb37d85e94af15ca1edd162e1e7f9a2a.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.19116 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/13/2021 8:45 AM, Mimi Zohar wrote:
> [CC'ing Casey]
>
> On Wed, 2021-10-13 at 17:26 +0200, Micka=EBl Sala=FCn wrote:
>> Nice!
>>
>> On 13/10/2021 13:01, Mimi Zohar wrote:
>>> Extend the trusted_for syscall to call the newly defined
>>> ima_trusted_for hook.
>>>
>>> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
>>> ---
>>>  fs/open.c           | 3 +++
>>>  include/linux/ima.h | 9 +++++++++
>>>  2 files changed, 12 insertions(+)
>>>
>>> diff --git a/fs/open.c b/fs/open.c
>>> index c79c138a638c..4d54e2a727e1 100644
>>> --- a/fs/open.c
>>> +++ b/fs/open.c
>>> @@ -585,6 +585,9 @@ SYSCALL_DEFINE3(trusted_for, const int, fd, const=
 enum trusted_for_usage, usage,
>>>  	err =3D inode_permission(file_mnt_user_ns(f.file), inode,
>>>  			mask | MAY_ACCESS);
>>> =20
>>> +	if (!err)
>>> +		err =3D ima_trusted_for(f.file, usage);
>> Could you please implement a new LSM hook instead? Other LSMs may want=

>> to use this information as well.
> Casey normally pushes back on my defining a new LSM hook, when IMA is
> the only user.  If any of the LSM maintainers are planning on defining
> this hook, please chime in.

That's correct. Adding the overhead of checking for security module hooks=

when we know there aren't any does nothing to dispel the perception that
security developers don't care about performance.


> thanks,
>
> Mimi
>

