Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51303613A5
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Apr 2021 22:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbhDOUoI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Apr 2021 16:44:08 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:34453
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234894AbhDOUoH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Apr 2021 16:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1618519423; bh=OH1Jhs0M2/ItlhbCePyj39PnGsZxt1agi51Yp9IbQOo=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=n47CZzSk0xB4D0IyEuc2jqwlGkSzhurDTvrCf+crlC35LH4CidGr27PnpEe0hI5cLkU3zNV/FJhk0zlhqwDSt0ivdmRv1nd9IpL179mZeEkgwiWQNh+UuU+iRuxbu0XUASyznNqsoTCUSA7XXPRdFMHMkmaKX7V89PPTt4DO18QNdYnNhR0U7peoA+ZE+VdvjV1e3WUO/tHFmWevjq6OrvphcPWYy4EJ0an9xsAEJT3FPd/oMvGhSBaICaxEOo7TejFGMAO2DCFT5pSX5YUA3yCYUF3MgRgWXoGL8nQKwjVPlFPDy8QcuQ6xaJSyLknJ9ig39SOb3aZyx2rVCQVkeQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1618519423; bh=IhoHGDa3j8eUaBExOrjpmaTd8MMnyoYIi83N8UbxEJN=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=uPR5yWdYnxFxwLbwTk/rTccRneNwhzQDvmdpb9MvGLwjQEJVM6ZckpyAYoLP1B7+nKmalnBt+D8OHdQuTKO4hmQma+ivjWn0rfT8dfNjSFVeX4hofzwKjhEmqdpn3IQfvQwUrmpxROK/GOFupnAbYbHj3F5WBKrWKpQTZVptNH8Jt5HsK4DWFFOl9oimGM6qbgo6vp0LMQTU3i1u+rc7is/5vCA1xXqPiqn4zcP+Ymq04UZq5PBnvKHrpdQ/zLb4gEk9lktrMd9nTbU2VJl5RBVWWa6HjMWfqyatQEpboCe60EsnB8s8x6bN+ly3HnSg9JaozlfXHyv7PPBBdE0YPQ==
X-YMail-OSG: _Gt41VkVM1lDOiACc1lPtTjRllzsdCj_Sx3RpJerxWh5vfLpkyDGBBtTY.mEmQl
 de5CxsDUztJFZJ.A11Y5wK13oEknpZRb.BTbvDKl14Ilmvy7l2ERGlf_JWbAoyYoigFplhmfiMib
 cQM5zVDjwWjvqKtP9ieZVtUFdEe4Brb7WEl4i0oQDcFr0teS0w1knWSi2yVFi5YOPAVSlkYI5Lhh
 PJljkO6l4xxiI8BERCTdV5Q1hajnvvD4LLRS2yThBz5ptIFp.UeJgJKPhYe3ZEUqrVFZrf_oUq9F
 JWwQAdnKf.pshfmJkDDUWtspI_RSn5PdFbAVuG7tc1WlmkKdr0ySSIhAYC7Gm9sfudrfpoCdVKqK
 oER8.NPU..Bc.JxRNp1adwW1_b__6g06AAtUCtN88GYbe5cJ5JrYmWclDCMyMzUk2jOwXNcQ07Ji
 dSv4450SC3oUUl4yGbeWDuHD72j.2YdhCexTwViVEnRqQqCwTQUUj2qEz.NnaN23EK3n0YyigZ8W
 dXek4fUsGtO.OLqOZnJmPsE5wIcOyH6BPPPXx8SjmPf4Kce4.1AiLsaydHt0kAYnE4GoFMIHz5rf
 _OAwibfrJROPIQeaUiuduQQ3um2vTWUyV1iz3ZUdSG_4zjhIjjASAcy1u4XWoC1G66m553.Za7XN
 Y2w7ZDbXvMdcy4riaYqiayUaArCtc.FQS9xissMhRkL7r7sllucP1zabqKGyDd1TkaXHkZkjCaaH
 0LeFLjeLZHPDCvECLok92he5cvAXUrZGh.YLFPbRo5nN0vyeoh3AFjBWXSfqiSfIorRwgaG3xyOW
 3_tG8gysgwXCa.Krs2ByvMvXNaquOQEtD1FBrrxNta.0D8XJdhm1kxoak0OyhoZgJG3VCJDyVIki
 aiCSokdvbIjd5buMV99Oc.vno.jQEVn6_GDcbGd.TYWDNzi4_WksjDSW5J6frRK8AJ0ZtyPRmemr
 o..dRV.ZZCbDjHT6AMSaPxGoOQahePCqdq0Qnx9mRG.ntDcKz1xhn.UFkAK1.cSoIqLocjXZ3DDZ
 RCWvdSHAFdybNo7jBwfpyIZK3gW7eZPLUhtbMIRh8UDE1fwxnHQgyCXO1uLPStzEf9B6Ulz4WI0w
 AGS4eETtLOqez7yZFw2wc70BcbCVi9_9xCBCfETzB1zrxhX0OWFHZ4Yg30MULatZTbPd_XAB7vxk
 XMgiLT_82tYgP.5aUaRQ9t4mH3plnp76KcqWBcltuaYEcfdRxhrLCBLxpNvLZpQjMKH0ZqEoQqTA
 W5XVqB0PzhUZu4IoQORPV4IsvkqrQeCMgJ.ISjMTuj57lHRyrf.HlHo0bhuH4nhFixHve5HwyUUw
 Bmxrxc3orQ7py4isLdNqFn6T3tM943xCFuHen7dA6i4hZD9p7bZOBUgSnRi4.zwFZ_DehKNVf.aC
 cqWOoP5aJus_wp3eWs1IYFTcG7ZR_dJ2k5kRR38toSPrqWRXbkIkV7Hm80OZ7DFHCZRs7KEM86vw
 TuExS40QDnAOQHJIPUkkFYm5QTpHTfSdQyHRWLCBD2kLwUhmE6.LRcN3NjYT7ggNDH.eDjWmnR0A
 qq9HXNKrMmkpzCMPK.j4W1S2Us3381EmABaE_gIg6VYezgXcDI.QEBWcqKI2wN2dBSBiVzPGnPVk
 96G5FXA377UeXIeDbW31.c8hWCfFVxIYKzsMTvfx5e_F1mWJIdMNZHXWCMJ7BxCwwsgJ6nQyOLaj
 aZZtS18Ixr6tthm02GoiA.fXt_A5RreHjRrcjDEKI10DrdNYZ4Tc4AGpn_XL0UjOJe9f3qrqIWi2
 B1JopEGwTUoMJwKhTNC2OTt7C0VgOvkL4QjpmPvcnhrZMtNGRzZ6Fs6p_K3TUnreqGWJqkHOosKl
 bt1h7iL0xhRBH1uQnAao8hq_1CohCQspYqeHbpj5TDYT0k_KCtTr1iZAU6LTCKRI1uLTmOtXA1wT
 wVggC8f4jNiolbwVtGDNWiIBmsydMM7YQrDPHI2CL4xM4QslKx36ErlAKsnToxOR22btnmgi3YBn
 9bbqnJRdK5dvKaFfQntOhidP8WY5Xd4m6nqV.wFmMHGBAMS3bWZ_xpHDvYqq0Ac.YjAAZ7XqFYbb
 LdpHvLIw7gDElo7W1kq1pHfx6TO_0HvLCESu3lJnhVAsuIOCZ_NtTSoGmme5536lN.DjkaV53sNd
 T8TnyPkBMNUd.jtrDhgWjs83sbqjJHBiYIq2Hp_3zt5DTbjtglUHOYNv62SSjgRGfq9AS3O8rGg_
 UcTkMLc13XPJErctmoQT78h53PiE7H0Dfq3oma1x6MgP6Wx55iRKXSDJHBSRnBCCqVlkPvzMbFIx
 6YpModXYQVdZ175qk7vxZx9dvOgU1tOuCCvMX0pz17r1aY4cwJ_lX1kFsBcTm.8G5AgxTPMWH.jK
 rm8aEW.FH_C.f06KIM4TYXYFTWirJfHZeNIsyjWLqaTboiZxivW8PAgEJWYtGXAQdrHOr5tVqKub
 QxJvoK5IGrLWTG1tEoAewKcOrXA4TvxxsepWaWct0f_lYWQXoVw36ivHWg_IznLLOzHgZItKTG2y
 QJOrxClItkRAL5qb7C9KVJeHu8aeZulrjjOa1ehYTXK4XtgkHpb3EcAjCQXv3FW09VKrqQeOfl_q
 w5PAFJ.HByifEjvBlnvCJtPzL.IA8Rc._ou8vFajrJK_nOHbBJUxtp7l_KgsW9O0oJhJfMSn_TC9
 61xt3Gorzf06mbverkTUZI_ojnEuTIsoCVCFr6mXjIgclGEfV3p8CaeU3x4TVtWwkX9lfrQZZWwg
 6iiEssDzI0mBtwTG2DYTIDCXwz83R.V94kIqlM2XXVhJk6XsV6AbBHOlEo6CFOJVHF81tKbrwI9z
 r_cpSsABAM62lkKaQ5_5p6SpWi2x_LS14mdjGqI2_sN4E4I0uwk5OHQ8QyrVPn0_RLGFm1fOplGq
 clyrkdKPEpG.m1U6CVjc.FmT_B9cjitIBaLQdjd7g_45twbOumiDDusgUfuobxSGwx0_OLsU6Bct
 7PUrs21JyHci_i5WwKWIcNI6PwmvAjc1aCrkiPSLDR7kx0mF3C0YzD8vfUhr6_u43SGmMFETQ7zJ
 UKyeG2u3fM.B0B.Rsc9MIJdj1UhygW6e.4CUkVJlB9RM.P8CuJtPyu5p8dA1eSYZDf7YtFD6HVWs
 ffHvdsVmujkFNYshfDrtdO6F4gVpje7PyikIX.UtXp54sheT8NYPQArQiaTvA7OsBzueq8u6bvXj
 n
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 15 Apr 2021 20:43:43 +0000
Received: by kubenode508.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 6da80e5b1c1c674fe1c1f161bfcf6378;
          Thu, 15 Apr 2021 20:43:41 +0000 (UTC)
Subject: Re: [PATCH 0/5] evm: Prepare for moving to the LSM infrastructure
To:     Roberto Sassu <roberto.sassu@huawei.com>, zohar@linux.ibm.com,
        jmorris@namei.org, paul@paul-moore.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        reiserfs-devel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210415100435.18619-1-roberto.sassu@huawei.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <7659b8cf-71cc-33b5-dbf1-3eb1ff159fe6@schaufler-ca.com>
Date:   Thu, 15 Apr 2021 13:43:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210415100435.18619-1-roberto.sassu@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18121 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/16)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 4/15/2021 3:04 AM, Roberto Sassu wrote:
> This patch set depends on:
>
> https://lore.kernel.org/linux-integrity/20210409114313.4073-1-roberto.s=
assu@huawei.com/
> https://lore.kernel.org/linux-integrity/20210407105252.30721-1-roberto.=
sassu@huawei.com/
>
> One of the challenges that must be tackled to move IMA and EVM to the L=
SM
> infrastructure is to ensure that EVM is capable to correctly handle
> multiple stacked LSMs providing an xattr at file creation. At the momen=
t,
> there are few issues that would prevent a correct integration. This pat=
ch
> set aims at solving them.
>
> From the LSM infrastructure side, the LSM stacking feature added the
> possibility of registering multiple implementations of the security hoo=
ks,
> that are called sequentially whenever someone calls the corresponding
> security hook. However, security_inode_init_security() and
> security_old_inode_init_security() are currently limited to support one=

> xattr provided by LSM and one by EVM.

That is correct. At present the only two modules that provide extended
attributes are SELinux and Smack. The LSM infrastructure requires more
change, including change to security_inode_init_security(), before those
modules can be used together.

> In addition, using the call_int_hook() macro causes some issues. Accord=
ing
> to the documentation in include/linux/lsm_hooks.h, it is a legitimate c=
ase
> that an LSM returns -EOPNOTSUPP when it does not want to provide an xat=
tr.
> However, the loop defined in the macro would stop calling subsequent LS=
Ms
> if that happens. In the case of security_old_inode_init_security(), usi=
ng
> the macro would also cause a memory leak due to replacing the *value
> pointer, if multiple LSMs provide an xattr.

As there is no case where there will be multiple providers of hooks for
inode_init_security this isn't an issue.

> From EVM side, the first operation to be done is to change the definiti=
on
> of evm_inode_init_security() to be compatible with the security hook
> definition. Unfortunately, the current definition does not provide enou=
gh
> information for EVM, as it must have visibility of all xattrs provided =
by
> LSMs to correctly calculate the HMAC. This patch set changes the securi=
ty
> hook definition by adding the full array of xattr as a parameter.

Why do you want to call evm_inode_init_security() as a regular LSM hook?
Except for the names evm_inode_init_security() and selinux_inode_init_sec=
urity()
have nothing in common. They do very different things and require differe=
nt
data, as comes out in the patches.

There are evm functions that could be implemented as LSM hooks. I don't t=
hink
this is one of them. There's no point in going overboard.

> Secondly, EVM must know how many elements are in the xattr array. It se=
ems
> that it is not necessary to add another parameter, as all filesystems t=
hat
> define an initxattr function, expect that the last element of the array=20
is
> one with the name field set to NULL. EVM reuses the same assumption.
>
> This patch set has been tested by introducing several instances of a
> TestLSM (some providing an xattr, some not, one with a wrong implementa=
tion
> to see how the LSM infrastructure handles it). The patch is not include=
d
> in this set but it is available here:
>
> https://github.com/robertosassu/linux/commit/0370ff0fbc16e5d63489836a95=
8e65d697f956db
>
> The test, added to ima-evm-utils, is available here:
>
> https://github.com/robertosassu/ima-evm-utils/blob/evm-multiple-lsms-v1=
-devel-v1/tests/evm_multiple_lsms.test
>
> The test takes a UML kernel built by Travis and launches it several tim=
es,
> each time with a different combination of LSMs. After boot, it first ch=
ecks
> that there is an xattr for each LSM providing it, and then calculates t=
he
> HMAC in user space and compares it with the HMAC calculated by EVM in
> kernel space.
>
> A test report can be obtained here:
>
> https://www.travis-ci.com/github/robertosassu/ima-evm-utils/jobs/498699=
540
>
> Lastly, running the test on reiserfs to check
> security_old_inode_init_security(), some issues have been discovered: a=

> free of xattr->name which is not correct after commit 9548906b2bb7 ('xa=
ttr:
> Constify ->name member of "struct xattr"'), and a misalignment with
> security_inode_init_security() (the old version expects the full xattr =
name
> with the security. prefix, the new version just the suffix). The last i=
ssue
> has not been fixed yet.
>
> Roberto Sassu (5):
>   xattr: Complete constify ->name member of "struct xattr"
>   security: Support multiple LSMs implementing the inode_init_security
>     hook
>   security: Pass xattrs allocated by LSMs to the inode_init_security
>     hook
>   evm: Align evm_inode_init_security() definition with LSM
>     infrastructure
>   evm: Support multiple LSMs providing an xattr
>
>  fs/reiserfs/xattr_security.c        |  2 -
>  include/linux/evm.h                 | 21 ++++---
>  include/linux/lsm_hook_defs.h       |  2 +-
>  include/linux/lsm_hooks.h           |  5 +-
>  security/integrity/evm/evm.h        |  2 +
>  security/integrity/evm/evm_crypto.c |  9 ++-
>  security/integrity/evm/evm_main.c   | 35 +++++++----
>  security/security.c                 | 95 +++++++++++++++++++++++------=

>  security/selinux/hooks.c            |  3 +-
>  security/smack/smack_lsm.c          |  4 +-
>  10 files changed, 135 insertions(+), 43 deletions(-)
>

