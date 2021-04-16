Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF6B362A46
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Apr 2021 23:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344384AbhDPVZo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Apr 2021 17:25:44 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:33205
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344367AbhDPVZn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Apr 2021 17:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1618608318; bh=PPLdm2iavpSoX4yP6O9bp5lB/lkadgMP3fsSb8Y4PF4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=ShOqKtE42hhm6Ory455zZqHgSaqHwaNqOmCFK8W1CvSTJcomHkbnig3jKPMgf+B8zarSwa79KHLS4I2895werj1IaPMEj1hp+yrn6GbsdwdCJnP8BDHZtPgQwHJayMTFOFM771pQfJju/K6HhlzxTW8UE39fsDwb4M1t/Ai7Aj3ytOKjB7eKtEftJgxvII9kiyqgbmrrRjcY0cBofS1YZrt/+WZqFZfYh73hxUQymgommOOprhPwX36XYrdvfTJnSJF4ljnGZi8uVV2+L1bpaieJOmYNXPVFy/zvvW4yTOXU46nekC6wS/J3JgBALVlOpl/5z2HZRP74fUGk7VyDAg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1618608318; bh=TJZATh59Yidg9ILM8W0eX3kjT2YUpd9RT06KyqK0tVK=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=lTzahCtRjcHBg8mmp1eYVegktknTz0JmzIHK0hqD1U8JoJEtAXPopJgUxhSYbxxZpQVhSIca8MaRi6XoJ45PxZCevwiEQZIlaQ3sySAng6YNCmegQFqaNqwwId67QajXpEiKFe5egFP5h3EAp4kcrsMNjAXYXXpO9fT0oiN82Sib5NVW6yEGpOpVtQSO7W8VEhQgJL0uuhyMGHPPEyHkFsAZu/BhA4zS292XnMBXR048pnnx7KJoBIFWCJlU0dci04UZOkByiLefj13TRy98Nbe7R579b7KR9IcyZUSg7pSe1XVJyrSliia3dYe+GZIPACZS3uAP3ZP5om8rvhYmtQ==
X-YMail-OSG: WBFBVgUVM1kW.XKyp.l4q7e3n2667nlp3Az4ioESy7ZPrPcsbSPqh5rwN9REEjv
 sjChxsADg_EezrfGtjdE8T.No..B4K7cZ7l8dvcd0jEv9gZhgBc_cSLrHNYsu1R4i9Doe27Grqml
 Yi6QC1IQ4W9mg0R0tgD2hXFUyKv6umRLNhb5fsdzpXSvV.pjoV_EtlLhgCUJ8.cZxbj0XXWNEmE5
 Ahh4jU_uEqeQZXVYYeHGKvjlKI6ZPjmwrxITINUkgTYFhf4685sh6fwxD3CPdBRzn2FGeCFW8CBy
 K3jONBrlrVmiixjmIGW.cBTCZPIKcgfmBGSKzgLKhhns2FbJ6W40Z0SmFep1gCh3pyVrXgK7QjFp
 EvkkkSHRW0WQpW7N59fS02wI4xiwBqtifmvpgqBymA3kxPGW5VZ8mkioNgyVH_ZaqPmPWywn3u9J
 atP3fkeautGoRBjO973MR1TmcfWECqvLyG.Vqjpjj2Wj6IjP6SAYC2cibWruI5TLbnSPuIm4quPB
 7pMpn1d7FvvQB.IoElrBW6YTCXUN4pKJ5d3N7gwFCeW_ypGf0HCAc918RB5st0lpCJIK3r9jBPD0
 UwFukZ2gjpv6Hgo32Kmhl36wIK2Ch4yw.AqiW9YKVq_N3c81dRpSX4Am95pd6Eyz0VkU_bGhfUfA
 YxRv7tEncXYfSKrP72DXxgkdZSVC5ZadnfK1D9mpW6PwKyv0qPw8G90VGKZFqrscwwJbFfSxxkWi
 ovsw2Gtu15t7SePC11Mj7r_VYuEA8c_MPZ4X114dZmyjmO5t_pB0BLYSycVRH1LlYSz9ns3MhLgJ
 tX27mP5526rIdIB3qGGEs2F6.UkR24ylOjVDJzgK5Z.QdVIHnSMsZfdCh4k89fDkRmsbvwhzv8of
 6irZUCiWLOHt3dTczPaKVX9wF93M5uC92dz2g8jiylhAfcK1jVQBBEPeZnKlr4TMMYSqtU9i8Dnn
 vfWkIZbRZwt8iSbiy.7IBjlqZ1I_QTaceTqtJmcMQJ31YuGXPoY8XtegdprHrXnb9M8PG9cTbc.G
 G8IF4SOWcrFhqCzFNy_XKQ5PwikoLEtfG41LKpFbRgS4g4D9X9y.aEhR94ggIcsoFbWDg_yeF4Wo
 dkwPipzjCq1lTt0Pya3Bk3w7UCf5VBc4NdqEd9y0iOhJR0cAywI_tgVKpGkVrhMYYC3iVFaiFi.t
 nLFT.8WPE6o.LCDxGZsMNrzAfSo3J5l0fBzgnAou.Axa4MGo4deTL2xrAs.pgDKRAuMfTh8czQvt
 m9HlIUCKgOUKQ6bANwCrBVRD4ZHw5pt4AS3d9joti68LH.M8dUIEz4v2t3A9ZlGCpeyBSIWLCIUN
 SmwvBNmCDe1OE0ER_b6rrQjyeTbOrS4TVElnUyRUmbm0sAHi1hjwYTBbIAo.Z468X_CN3g8w0YT6
 L8Wh_.uDKRHdxK.yno1.weIugsutJ1HxzsBsu5VzyX_HI497mdGPBWCb6qQ0wKUBQQGyl8GkyJJj
 TWiIvyZHjx7fDEzHxOY2ZHlynCegmUpb.3JxXVlJk_nGLKKTlyaft27zYNj6N1UlrDNIJDvZ6yrq
 1KErKV0FQCnHiIn4UP7ivhH7urgB_9gVCC.Bp_BRwGx0sq.M4qC0xv8LFBvBVgbI5ng5y6KPqstG
 Cj27_my6FJKbdWmUVU7YVuU_NoM5dl8lGS.ONcDnn6ShTcGv3SC3HDlRTdCxR.1Jf8TDuxiECCwT
 .KkdHDfPLqHkWDcv8m8n1eGBl5.ccc3ic.p24nHgEMbZp78ygWUvrabCsm3mzRf1oAZ.MLc8hbmG
 N9eO8s7Y.dIU9KshLwwvSA6OwYhGE7zTAGdamprwUDE4oEi1fnggxpP3tfF_UI2J1zDoZ1zhK3C.
 EVnz3wcCSbWkUenV9k0z32COwpQBA69X70A7NMF3QorfX7V5YCYAGxCHNe26tWsIIkr7pglLrP44
 DU3RO_uzSqHpuvYqEQgLpEasdzgAHQmE26Vw.xce9efAgnfR..9b_R8pHjoHF0SfcxxOpFj2V_1p
 nhZiom1RySWyXksGbg96LQb90TePX90DUZjrENwMLvIHkwU09zdKEZ64u4lUduxpzz7vVe4oyw3m
 o_uxNUrvn99V7uByfsinzEFPfSMmWeprESfiABoDLrRrDYseh5FjGwBpEyvVg0mBBOjv5GRVxdln
 vG4PWOcyoZstS52zYE3VqvDPtbAVFkH6OG5H03.2BJ_l9tyZ1cIuFDfHiFgjOsK7VRcfSi0R6otl
 2w5et6mqrRriwriMyocX7dYeFDs.LFNmQ3jxwVaUb6fo9xe6_pCtoYfQervHM5RyaqrN0EffUcpn
 m10fzfjRWCi2lDIhON4xT_XrYt3pj4yEyfAUJXrh22NxpKywLfnliZZI2aldaeCst2KaLUqt7Zos
 t_1wRbiqI0Ff3CuqAgZvP6SiS3HDDx8bggQlxmMIOi6HVwH1WSRTm1t2enKCTRxUi5sUPZlFojBp
 LbNh2V7xZueii6WoOyaAxD34ZEt8yEJMLOdFjlAQozR7MpKDZ805HQJBAF_pw_2RIHreasxJNBXl
 wzsYZoywjMKfxIteXVfuZDzVGXSVIXYl49Lj9sejGrxqQ9K_OsvHAKQk3wsMLjc98sqOFmeIBnWc
 9kPVH9zP9U.MBJ8ZQXqKS4nyVTDVap424b5z9z5B1qCyXQ6t6aWUH4zMZBsRuI1zVjtWbslBSJRn
 QoqAA8FRGEUvihDH4GUwxyE9pVrvyfjZMpztCArL2NFTkAtG4RV.JHCaOM84ckpaGTtw129qksTn
 xZYmSRv.4nJYtwQxgoD5M0uaITrZ_ZCwaZR_WyRV2vTYuK1XAaiKWgGhNkxN6KJsGRMTbuXP96.x
 eRYGSh1PKWWC6rh_tAGw1.1IaftNMpwK5f8vMwv2zELsI5F4aRJiRasC.k5mPDUpQx4tBaQZ6O6J
 Td9U2sRWXDD7XEx9LyAu_tsgHhHS_WrdGg8QMdlPONXdmgsmgx0q2eabq68kvozYf_0gCSg8Pd5u
 KKk5CE1RGWDWnWXntpAVW5yzTCAxaJNG4Xw5lOMA5oJ7ZWJuA15NYfmjvZQvYcBfyw1EdsLOjm83
 6V3WeIKXBbbRrCBXzVbx3zbsVNFmaMzDuAKBt.AcTuv628_XD0sRrz6SsACq0KWJoHPdq9dIexsO
 Xj1oy.coLRU2jQNHPe7GPF4HXxbGEXNlZI9o8QksXpzcfz_h.yQC6evOkX3NcdDgJLscG2U9KVzt
 b2wWXKhrQq69T1Hz794S.XRaiclBIaoSHBPuEzyBmQs1qLFIctUhHNIbeQBGfMqLT1T0YJ3X98zX
 xHl4QbzWhsA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Fri, 16 Apr 2021 21:25:18 +0000
Received: by kubenode520.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID d51b9e078109949b27131e96f91e4eb0;
          Fri, 16 Apr 2021 21:25:14 +0000 (UTC)
Subject: Re: [PATCH 0/5] evm: Prepare for moving to the LSM infrastructure
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "paul@paul-moore.com" <paul@paul-moore.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "reiserfs-devel@vger.kernel.org" <reiserfs-devel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210415100435.18619-1-roberto.sassu@huawei.com>
 <7659b8cf-71cc-33b5-dbf1-3eb1ff159fe6@schaufler-ca.com>
 <2c944d6ddeed4519bdbf3733d7318a3d@huawei.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <db1bc545-9389-7b86-1582-7de1a8a1435e@schaufler-ca.com>
Date:   Fri, 16 Apr 2021 14:25:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <2c944d6ddeed4519bdbf3733d7318a3d@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18121 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/16)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 4/16/2021 9:37 AM, Roberto Sassu wrote:
>> From: Casey Schaufler [mailto:casey@schaufler-ca.com]
>> Sent: Thursday, April 15, 2021 10:44 PM
>> On 4/15/2021 3:04 AM, Roberto Sassu wrote:
>>> This patch set depends on:
>>>
>>> https://lore.kernel.org/linux-integrity/20210409114313.4073-1-
>> roberto.sassu@huawei.com/
>>> https://lore.kernel.org/linux-integrity/20210407105252.30721-1-
>> roberto.sassu@huawei.com/
>>> One of the challenges that must be tackled to move IMA and EVM to the=20
LSM
>>> infrastructure is to ensure that EVM is capable to correctly handle
>>> multiple stacked LSMs providing an xattr at file creation. At the mom=
ent,
>>> there are few issues that would prevent a correct integration. This p=
atch
>>> set aims at solving them.
>>>
>>> From the LSM infrastructure side, the LSM stacking feature added the
>>> possibility of registering multiple implementations of the security h=
ooks,
>>> that are called sequentially whenever someone calls the corresponding=

>>> security hook. However, security_inode_init_security() and
>>> security_old_inode_init_security() are currently limited to support o=
ne
>>> xattr provided by LSM and one by EVM.
>> That is correct. At present the only two modules that provide extended=

>> attributes are SELinux and Smack. The LSM infrastructure requires more=

>> change, including change to security_inode_init_security(), before tho=
se
>> modules can be used together.
> One of the goals of this patch set is to solve the specific problem
> of security_inode_init_security(), when arbitrary LSMs are added
> to the LSM infrastructure. Given that some problems have
> been already identified, and will arise when a new LSM
> providing an implementation for the inode_init_security hook
> will be added to the LSM infrastructure, it seems a good idea
> fixing them. We could discuss about the solution, if there is
> a better approach.
>
>>> In addition, using the call_int_hook() macro causes some issues. Acco=
rding
>>> to the documentation in include/linux/lsm_hooks.h, it is a legitimate=20
case
>>> that an LSM returns -EOPNOTSUPP when it does not want to provide an x=
attr.
>>> However, the loop defined in the macro would stop calling subsequent =
LSMs
>>> if that happens. In the case of security_old_inode_init_security(), u=
sing
>>> the macro would also cause a memory leak due to replacing the *value
>>> pointer, if multiple LSMs provide an xattr.
>> As there is no case where there will be multiple providers of hooks fo=
r
>> inode_init_security this isn't an issue.
> I could skip the patches that are not required to support
> multiple LSMs registering to the inode_init_security hook
> and just do the EVM changes (see below for the motivation).
>
>>> From EVM side, the first operation to be done is to change the defini=
tion
>>> of evm_inode_init_security() to be compatible with the security hook
>>> definition. Unfortunately, the current definition does not provide en=
ough
>>> information for EVM, as it must have visibility of all xattrs provide=
d by
>>> LSMs to correctly calculate the HMAC. This patch set changes the secu=
rity
>>> hook definition by adding the full array of xattr as a parameter.
>> Why do you want to call evm_inode_init_security() as a regular LSM hoo=
k?
>> Except for the names evm_inode_init_security() and
>> selinux_inode_init_security()
>> have nothing in common. They do very different things and require diff=
erent
>> data, as comes out in the patches.
> I thought that it would be more clean if all hooks are registered
> to the LSM infrastructure. Otherwise, it could happen that some
> hooks are still executed even if the LSM is not active, from the
> perspective of the LSM infrastructure.
>
> evm_inode_init_security() is still a provider of xattrs, like the
> other LSMs, just it requires an extra parameter to calculate
> the HMAC.
>
>> There are evm functions that could be implemented as LSM hooks. I don'=
t think
>> this is one of them. There's no point in going overboard.
> IMA and EVM both use a cache to store the integrity verification,
> which is currently not managed by the LSM infrastructure but
> by an ad-hoc mechanism implemented with an rbtree.
>
> One of the benefits of defining both IMA and EVM as an LSM
> is that we can switch from this ad-hoc mechanism to the one
> implemented for the LSM infrastructure, with a search in
> constant time. Given that evm_inode_init_security() would
> update the integrity status (xattrs are good at inode creation
> time), I would add it as well to the LSM infrastructure.
>
> One additional motivation for defining EVM as an LSM is that
> it would solve one of the EVM limitations that affects its
> usability: partial copy of xattrs (e.g. by cp and tar) would not
> work when an HMAC key is loaded because, since EVM in
> the post set/removexattr hook does not know the status
> of the last integrity verification, it has to deny the permission
> to perform the xattr operation, to avoid that the HMAC is
> calculated on corrupted xattrs. Having the status in the
> per-inode blob would solve this issue more efficiently than
> adding a cache for each verified inode in the rbtree.
>
> Would you see this as an useful modification?

Yes, I think that would be worthwhile.

My biggest objection is to adding a parameter to the hook calls.
The security_inode_init_security() - security_old_inode_init_security()
organization looks wrong to me as written.

There are really three cases here:
	Neither EVM nor initxattrs - taken care of by the "old" variant.
	EVM, but no initxattrs - which doesn't gather the EVM data.
	EVM and initxattrs - which gathers and uses the EVM data.

The code we have now is cleanest for the least common "old" variant,
which is used in only two places, reiserfs and ocfs2. I would suggest
a slightly different approach to getting you what you're after.

Let's change the hook definition for inode_init_security to take a
struct xattr * and the fs_data rather than the name/value/length triple.
It will require a temporary struct xattr in security_old_init_inode_secur=
ity,
but that's a corner case anyway. The security module specific code would =
be
easy to adapt. In the current environment, where there can only be one
module providing a hook, SELinux or Smack will fill in the xattr and retu=
rn.
In the future the modules will have to find an empty slot for their data.=


If your evm_init_inode_security() is registered last you will get
the desired behavior.=20

The MAX_LSM_EVM_XATTR value can be easily computed at compile time:

#define MAX_LSM_EVM_XATTR ( 1 + \
	( IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0 ) + \
	( IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) )
Yes, you'll waste stack if only one of the modules is active.
On the other hand, if you only compile in one the value will be
perfect and you'll avoid allocation and associated headaches.

>
> Thanks
>
> Roberto
>
> HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
> Managing Director: Li Peng, Li Jian, Shi Yanli
>
>>> Secondly, EVM must know how many elements are in the xattr array. It
>> seems
>>> that it is not necessary to add another parameter, as all filesystems=20
that
>>> define an initxattr function, expect that the last element of the arr=
ay
>> is
>>> one with the name field set to NULL. EVM reuses the same assumption.
>>>
>>> This patch set has been tested by introducing several instances of a
>>> TestLSM (some providing an xattr, some not, one with a wrong
>> implementation
>>> to see how the LSM infrastructure handles it). The patch is not inclu=
ded
>>> in this set but it is available here:
>>>
>>>
>> https://github.com/robertosassu/linux/commit/0370ff0fbc16e5d63489836a9=
5
>> 8e65d697f956db
>>> The test, added to ima-evm-utils, is available here:
>>>
>>> https://github.com/robertosassu/ima-evm-utils/blob/evm-multiple-lsms-=
v1-
>> devel-v1/tests/evm_multiple_lsms.test
>>> The test takes a UML kernel built by Travis and launches it several t=
imes,
>>> each time with a different combination of LSMs. After boot, it first =
checks
>>> that there is an xattr for each LSM providing it, and then calculates=20
the
>>> HMAC in user space and compares it with the HMAC calculated by EVM in=

>>> kernel space.
>>>
>>> A test report can be obtained here:
>>>
>>> https://www.travis-ci.com/github/robertosassu/ima-evm-
>> utils/jobs/498699540
>>> Lastly, running the test on reiserfs to check
>>> security_old_inode_init_security(), some issues have been discovered:=20
a
>>> free of xattr->name which is not correct after commit 9548906b2bb7 ('=
xattr:
>>> Constify ->name member of "struct xattr"'), and a misalignment with
>>> security_inode_init_security() (the old version expects the full xatt=
r name
>>> with the security. prefix, the new version just the suffix). The last=20
issue
>>> has not been fixed yet.
>>>
>>> Roberto Sassu (5):
>>>   xattr: Complete constify ->name member of "struct xattr"
>>>   security: Support multiple LSMs implementing the inode_init_securit=
y
>>>     hook
>>>   security: Pass xattrs allocated by LSMs to the inode_init_security
>>>     hook
>>>   evm: Align evm_inode_init_security() definition with LSM
>>>     infrastructure
>>>   evm: Support multiple LSMs providing an xattr
>>>
>>>  fs/reiserfs/xattr_security.c        |  2 -
>>>  include/linux/evm.h                 | 21 ++++---
>>>  include/linux/lsm_hook_defs.h       |  2 +-
>>>  include/linux/lsm_hooks.h           |  5 +-
>>>  security/integrity/evm/evm.h        |  2 +
>>>  security/integrity/evm/evm_crypto.c |  9 ++-
>>>  security/integrity/evm/evm_main.c   | 35 +++++++----
>>>  security/security.c                 | 95 +++++++++++++++++++++++----=
--
>>>  security/selinux/hooks.c            |  3 +-
>>>  security/smack/smack_lsm.c          |  4 +-
>>>  10 files changed, 135 insertions(+), 43 deletions(-)
>>>

