Return-Path: <linux-integrity+bounces-5775-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F04D4A84641
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 16:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DAA44E56B2
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 14:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D50128C5B0;
	Thu, 10 Apr 2025 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="MlxOY5vR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic313-14.consmr.mail.ne1.yahoo.com (sonic313-14.consmr.mail.ne1.yahoo.com [66.163.185.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFCB1F873E
	for <linux-integrity@vger.kernel.org>; Thu, 10 Apr 2025 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744295010; cv=none; b=liPnar7mDh68KmjpgRH6OngfrTyIAy5T12z55K5gBArGd7r63cc1Uxi/loKO9aReLVSjjix9hg8z8G9jsyt6jl7IGM5eYWYsCdWzFQ029q4JrvOZDXrdnmF7Okj3DpUzN+GiDxHBAvSf9f09J66daXApOaGipj6azrfVdfQw844=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744295010; c=relaxed/simple;
	bh=DlhBjDC589ymMPZwvNxVKrOMQcIGogUm/W7kQ61OZvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S8vWmq3fR0l79545j54hHJIz0I90Qs6IVeTqWXKI6YPm0M4ZDjUypMbmgFdRE82Sg5n64eJbUk7vnBZ2gGa2KvyYje7PWRclNhhEz39ioE7iC4WSL6RfJYo5XbT5VhNJyp4j9IR537OEBl0pkUzfIsTyK6UzHEW21U4unHBTFtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=MlxOY5vR; arc=none smtp.client-ip=66.163.185.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744295001; bh=bHL+4Fsshn+gJrmHLJBnHewFXwt2kD1aPUfieqqyVkg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=MlxOY5vR86su0eWjJu+nFbwOnVhN+KmxEiu+wE3UWaCcbUeo9J/t+4+ewMqc/yU8mKTMWGgmO6/g8Iae8ctlfyGHRvojO1on8eAT9491LYxHT5jJ4c4mD2bS7aSMpG6MTFwtxTj5RmCBLW7E7k86pLxOgDiJzEzqqLJbwE8Lhio/OUNNzFNa4yXvusrbYBe0HiayZL9YhBRiNmfuWQ5XsqYXcQz93cIXNHTnvUb5cp6oOjS0k3m32j0ZtFWxqOFVguC47SNcNyB+so4ZULJd2WGcsVBO6pbEFkuYx67hVvy5W4zR5fTeaViVpBCxnnUk55fM176onBuJ2IKMcypMrg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744295001; bh=FWAuqvB4zT3jI78W4LC5uKSvhyws6fIXsgdwsgQhcYS=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=bcp0ocqXKUjKKJ2y7EX9tCE04AwZai0I2g8KQ7JelysYI+BtLYqjcPiA7/0TZYFgVvz58sKnDdtRI+dmFVQHSHF9R0ENDmlp0KpMXpZ/c09j8KrxGaHq98bz9rZf0kZJW0RbN2iuVtftDkKEALh2fdg8+FbnLhyjDTqvIdhW1cspAjHm8vw0HUI2YRRCxV2d73IukXwFHc6G7WWQuUkPAwLF75KTuxKhzgmBOgKZk0Rj6NLznv3KV8m1csLsY1yL5w1QMFekHteNmPhP8U0KUuIOw8briK+N++I/w+h4Xf/ExjQ8MIzxzcLlzHWAt1zuA0Npwo5h+wXzHeSV+qWTaQ==
X-YMail-OSG: jF3N4MQVM1lAyrTcBqDkUTbH56uin0g36bVYWwtDfy3_hqqeRFQ7v9n.W.teM10
 Wy0Ia867G8Dw2EER73qHTtOu5cjlWixnHyjf6K5t3DC_STqzr.UrD45OtC7dv9SujlpWMsZajWA1
 _TxbMSVAxsu2Bsf9nId0b_ZLl8fLlc47JmqB2hSHcIcSprQ2dgpzNShsm5.Jw1kjmWI.CQLAOLgU
 yskQYu67JcfQp_Yg9lS4SYhdY9Ve68nEmpPg8re5zwEwIiU.BruzJVNBsgSHLo7UA9PKnnQVhC5i
 BcI8W2TiyKyaqq_8oo_b8xCxhwNSUEm78NhNwO5DZVlp9FmFbVK6cnoyS0lR8qMiAUbqnQ98V_.8
 hXFLXuhhp8br8HhXPaYrfsRYU_s1e7Z_FEsxLFIWqN6ByOsa3XBpDVHZtSp0LnCh5WRKvF57rNlj
 yESDv7VQzMjbt2xmcN4TIWvX6fkLUF09o02pKwfPDrKEj7pRqtIVu2Bs8Rjmcw959KPtuWOq7V_5
 kBaeWC5H6ILlyRZQbSjdTXCks_Jn1r_0gM039OLAXMzzpYw1rlcdI3lkgJl5qNetT5IghNo8D.ZZ
 lWk07bhPKgEgLIpqGRo04ISJ0MH837NzOxt2uh7SmZHl8B7xiswmlj2WLOdvtLg_5eoVKAtyJ8o8
 JaSEO6fbHZzZz2BH7Bd6uUMC9EqsvnlXb3YJTY6sKaIrT9y6zblGdfVqJ9TJPWdKARhNkarfFPuT
 WjnpDvO.SXv_3Q4jrDWL8cyVcCfYJAoApAa0kb3zPdT6AqNQvmTADiFGdHo6YnU7Ydlw2PRClxKZ
 NbWYbz_9UC.VqA57ws6chleRlwMNyd788hB.ickKqv4mBTtlYzm8p9Q35l0aL5RyyEHlDHEvMEas
 IE.TxgUKj5eSTuL7V_AZyHxwGAWDLwJpTm.9s0i8eFdpbWgykadySHey0pH1an2U8FIJqaIizWqX
 hsvGO6o3SBsJeg0eFg2MHO0vbch9n4DPQQO.4R8Xi8BGzTCC71LYHPE1C3mg3n_n3Vws6e6IUwGP
 6jUlbjbpTSZxUgclO8lLxYhfl3NjSNPqcyir5CREhg7dVYI_qfJDFzhx029NApXDZDUHGQJt7wJk
 eMayyBBy4GqLskHJdWuqH33x89hDc1WcXpE.kARqpU5hdldAj8Jlvhg_beRXzglboYz9RH.r34ME
 12YnFw_u9iUeDbkJjj3C3_.8_a8oU9lHz7NDtqIfQ3Jnqd9osTA8Z91y4kr9cl9UisIgR5hbIoCj
 Gb7KWU4yF5HsAOjuXSB.ZAGSPKY6npCh7_aiLJP0AXxJQmfY9f_Q1w2j0zyr6O_oq7au4mYEhgCJ
 l.N4g940yUFysQQPNQpmWomu6.67VHClS9eYIAi_4AgsOMt2s.qakEAe9d5d.ZjGLtqwm6J7hpq7
 XLU_Cj0ppVbzBjvfX8fRFDnPxrINEXMMU8YQdkgROQ4la4QpV.Z_IiaYD.qygkHsuZuvpR4xecIX
 vQSDdD3ifjH7xHNZVwQ.zUhAQWUaDjH3O.TbPQ6WiD8thBFm7rqt5v0crBv0UeuBeYvHBSE3U1CU
 TX1eOLk4q54z4fYZykxySgEF.047CvxuC1gmFf6Wq3GNJYWJ9_xcAMtki7HXzl.ODBxOeYOB.EiT
 ToUoVa1cujeU6SBTVeA0D6B5jN3mO80Vfl26gs.PyoC6jvE62ZLJhP.JDE1nZYBqelP5eBKTM9TD
 UVCQFkmkbMc09GSvAd2Ygf35jrmsfcLJu.HpMBYLxFPT7phly3oW.fxQPo.cBdYkA0.OxwwgpfE7
 D0yl5m1.jh6zyEdjavSWincm7IBGyy.gmDMcVsnJ6cith.7IvNO.Pz_lkXchlEfMHx7WFym6ANDS
 uiGiSLapo72g6FQust9TrnHwD7MZiLPzI5xxLyRrZ4f7H_MkTyNexNb_Mp9b6OAq1YIcdW6nQYmH
 GXfAAripwEWJhumUEKHnH4Pzbnb6zPQzYZBhsojVXV5qvV4RtdbLdVJdL6322PNvUn8JYzXAF6fB
 eS4sW4Dcm6mCq8ZapC6mszuowobBc5jISizs9VUPS07jWW2u1JbzrogzSFDYm75qkak49iM.uOhB
 CZVVo1fX_3MnemxFTOsJj1VvCA.xMYb7BoNboq03WkE570tjW9LcOfQMibwr9Pq0jEkAt6v3RNqf
 Z_sLoqnW6YsSwCNJPo8vhROEb8iaQiBB5sdajRi7wKfifsAjLUN6LvincxZMTQfY5f26Hjoj9Mnw
 RFJVStAiHKSwKbxsyCb7HX.ZttGwmBBNPshQbIYRK7ZtCH_5uy653.74yrqt6grtH2v9y3pfGLTl
 QBkQWVlWCagHLqfdTDXHJz0B4pawPUModug--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 1ee793a3-13b3-4062-ac31-5d88ddecf6b5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 10 Apr 2025 14:23:21 +0000
Received: by hermes--production-gq1-6f8bfcd964-pbc56 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ee5e9965a808f684b189ecfde41e6d54;
          Thu, 10 Apr 2025 14:13:11 +0000 (UTC)
Message-ID: <1c13537f-b088-464c-87ee-3e81fb909f92@schaufler-ca.com>
Date: Thu, 10 Apr 2025 07:13:11 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/29] Rework the LSM initialization
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Fan Wu <wufan@kernel.org>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23665 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 4/9/2025 11:49 AM, Paul Moore wrote:
> This is one of those patchsets that started out small and then quickly
> expanded to what you see here.  I will warn you that some of the
> individual patches are a bit ugly to look at, but I believe the end
> result is much cleaner than what we have now, fixes some odd/undesirable
> behavior on boot, and enables some new functionality.
>
> The most obvious changes are the extraction of the LSM notifier and
> initialization code out of security/security.c and into their own files,
> security/lsm_notifier.c and security/lsm_init.c.  While not strictly
> necessary, I think we can all agree that security/security.c has grown
> to be a bit of a mess, and these are two bits of functionality which
> can be extracted out into their own files without too much fuss.  I
> personally find this to be a nice quality-of-life improvement, and while
> I'm open to keeping everything in security.c, the argument for doing so
> is going to need to be *very* persuasive.

It's something I've considered doing as part of the stacking work,
but that I have eschewed in the spirit of churn reduction. I've no
problem with it.

> The other significant change is moving all of the LSM initcalls into the
> LSM framework.  While I've always pushed to keep the LSM framework as
> minimal as possible, there are some things that we really can't defer to
> the individual LSMs and with the LSM framework responsible for enabling
> or disabling the individual LSMs at boot, I believe management and
> execution of the LSM initcalls needs to be handled in the framework as
> well.  Not only does this move ensure that we aren't running initcalls
> for LSMs which are disabled, it also provides us with a convenient spot
> to signal when all of the LSMs have been actived (see the LSM_STARTED_ALL
> patch towards the end of the patchset).  This is not a feature we
> currently need, but I'm aware of some future work that does require this
> so I thought it would be good to think about it now while doing this
> work.
>
> Related to the LSM_STARTED_ALL patch, the final patch in this series
> adds support for LSMs to indicate if they provide lsm_prop values for
> subjects and/or objects.  Casey needs this functionality for his recent
> audit changes, and I personally find the counting approach presented
> here to be ... less ugly I guess?

The flags approach works for me. I was going to propose adding a call
audit_lsm_secctx() that LSMs would call to identify that a secctx was
being supported, but I had considered the flag approach as well. As for
ugly, I can't say one way or the other.

> This patchset is marked as a RFC for a number of reasons: additional
> testing is required, the commit descriptions could benefit from some
> extra attention, and I still have hopes that some of the individual
> patches could be cleaned up a bit (I still like the end result, but how
> we get there could be improved).  I would really appreciate if the
> individual LSM maintainers could give this a quick look, especially
> the individual LSM patches that move the initcalls into the LSM
> framework as some of those are non-trivial.

General comments:

Adjacent patches with no more commit message than "cleanup" should
be combined, as that message is telling me "these aren't the changes
you're looking for".

And about that. I believe that missing or uninformative commit messages
are on your list of things that displease you. You will need to improve
them to get them past yourself. :)

There's a lot of churn here due to unnecessary name changes. I can't
say they're unjustified, but the patch set is bigger than it needs to
be, and more disruptive.

I haven't tested it, but I don't see any substantial problems so far.

>   Mimi and Roberto, the
> IMA/EVM work here was particularly "fun"; from what I've seen thus far
> it appears to work correctly, but I have no idea if that code is good
> or bad from you perspective.  It's perfectly okay if you want to
> reject the approach taken in IMA/EVM, but we do need to move the
> initcalls up to the LSM framework, so please suggest some code that
> would allow us to do that for IMA/EVM.
>
> --
> Paul Moore (29):
>       lsm: split the notifier code out into lsm_notifier.c
>       lsm: split the init code out into lsm_init.c
>       lsm: simplify prepare_lsm() and rename to lsm_prep_single()
>       lsm: simplify ordered_lsm_init() and rename to lsm_init_ordered()
>       lsm: replace the name field with a pointer to the lsm_id struct
>       lsm: cleanup and normalize the LSM order symbols naming
>       lsm: rework lsm_active_cnt and lsm_idlist[]
>       lsm: get rid of the lsm_names list and do some cleanup
>       lsm: cleanup and normalize the LSM enabled functions
>       lsm: cleanup the LSM blob size code
>       lsm: cleanup initialize_lsm() and rename to lsm_init_single()
>       lsm: cleanup the LSM ordered parsing
>       lsm: fold lsm_init_ordered() into security_init()
>       lsm: add missing function header comment blocks in lsm_init.c
>       lsm: cleanup the debug and console output in lsm_init.c
>       lsm: output available LSMs when debugging
>       lsm: introduce an initcall mechanism into the LSM framework
>       loadpin: move initcalls to the LSM framework
>       ipe: move initcalls to the LSM framework
>       smack: move initcalls to the LSM framework
>       tomoyo: move initcalls to the LSM framework
>       safesetid: move initcalls to the LSM framework
>       apparmor: move initcalls to the LSM framework
>       lockdown: move initcalls to the LSM framework
>       ima,evm: move initcalls to the LSM framework
>       selinux: move initcalls to the LSM framework
>       lsm: consolidate all of the LSM framework initcalls
>       lsm: add a LSM_STARTED_ALL notification event
>       lsm: add support for counting lsm_prop support among LSMs
>
>  include/linux/lsm_hooks.h                            |   73 -
>  include/linux/security.h                             |    3 
>  security/Makefile                                    |    2 
>  security/apparmor/apparmorfs.c                       |    4 
>  security/apparmor/crypto.c                           |    4 
>  security/apparmor/include/apparmorfs.h               |    2 
>  security/apparmor/include/crypto.h                   |    1 
>  security/apparmor/lsm.c                              |   12 
>  security/bpf/hooks.c                                 |    3 
>  security/commoncap.c                                 |    3 
>  security/inode.c                                     |   29 
>  security/integrity/Makefile                          |    2 
>  security/integrity/evm/evm_main.c                    |   10 
>  security/integrity/iint.c                            |    4 
>  security/integrity/ima/ima_main.c                    |   10 
>  security/integrity/ima/ima_mok.c                     |    4 
>  security/integrity/initcalls.c                       |   97 +
>  security/integrity/initcalls.h                       |   23 
>  security/integrity/platform_certs/load_ipl_s390.c    |    4 
>  security/integrity/platform_certs/load_powerpc.c     |    4 
>  security/integrity/platform_certs/load_uefi.c        |    4 
>  security/integrity/platform_certs/machine_keyring.c  |    4 
>  security/integrity/platform_certs/platform_keyring.c |   14 
>  security/ipe/fs.c                                    |    4 
>  security/ipe/ipe.c                                   |    4 
>  security/ipe/ipe.h                                   |    2 
>  security/landlock/setup.c                            |    3 
>  security/loadpin/loadpin.c                           |   16 
>  security/lockdown/lockdown.c                         |    6 
>  security/lsm.h                                       |   46 
>  security/lsm_init.c                                  |  566 ++++++++++
>  security/lsm_notifier.c                              |   31 
>  security/lsm_syscalls.c                              |    8 
>  security/min_addr.c                                  |    5 
>  security/safesetid/lsm.c                             |    4 
>  security/safesetid/lsm.h                             |    2 
>  security/safesetid/securityfs.c                      |    3 
>  security/security.c                                  |  620 -----------
>  security/selinux/Makefile                            |    2 
>  security/selinux/hooks.c                             |   12 
>  security/selinux/ibpkey.c                            |    5 
>  security/selinux/include/audit.h                     |    5 
>  security/selinux/include/initcalls.h                 |   19 
>  security/selinux/initcalls.c                         |   50 
>  security/selinux/netif.c                             |    5 
>  security/selinux/netlink.c                           |    5 
>  security/selinux/netnode.c                           |    5 
>  security/selinux/netport.c                           |    5 
>  security/selinux/selinuxfs.c                         |    5 
>  security/selinux/ss/services.c                       |   26 
>  security/smack/smack.h                               |    6 
>  security/smack/smack_lsm.c                           |   19 
>  security/smack/smack_netfilter.c                     |    4 
>  security/smack/smackfs.c                             |    4 
>  security/tomoyo/common.h                             |    2 
>  security/tomoyo/securityfs_if.c                      |    4 
>  security/tomoyo/tomoyo.c                             |    4 
>  security/yama/yama_lsm.c                             |    3 
>  58 files changed, 1102 insertions(+), 724 deletions(-)
>

