Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1AD83688AA
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Apr 2021 23:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239583AbhDVVk3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Apr 2021 17:40:29 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:43389
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238818AbhDVVk2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Apr 2021 17:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1619127592; bh=PgMB4o5po6W5zAFv5yPvhGHpAp965o5pe37/xWOLGDs=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=mZmz4RWw9a+CnzZ0CU8dntd2A1YPvKRp7XYnUQBBYx3Bfipt5YR2TyQBHYBXCMeJH+a3wfFyUbrgTtkjjvi1VWmDKS6l2neiRKEksjH4IO5kq9ZtPwInrtntzGOwx55jZe3UgGCQlQswU+JS36cDwMWKX/YqcCbDRNUF1qKVB7nZ0geMxrbpw/wn3swifF7W23/MqPcU01bkqn+HQcfo+b+facjjSPUuFnQe7iAY0krquPDBq9pHh65q/YAYxxd4AihRgHvdjqUjKaoVZsrLlax6BAy3guvZFPgMNvJkxKSQVuL71bvmUta9opmjMAvTT06YtHBbHU5mNkkS6NIE6A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1619127592; bh=FJQHKga/Scl6qYUoRm5xRQRLgq0v10OT7L6Ndeypr3W=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=bniQRZOM8SKg6+Mrg8XwVtoLGhWfZuOZcrxclqaGewRGQ/nAaxwudXrjF465hSR7Sj7vrN+IRN4bkAPeas0OpI6p410hFEX8E225Rqja8FxZxPjDD3oEFxzWd2wsxE+TVAFPgaKJYw3eywLYe6KiYdVAJHT3zgc3SaMO12M7fapX6CM2SCQI+vVkbyN26A4WYmeDdrKp+qmAusvQMknDP3WMp92mI4+erv15YVwpBITeIlj+cedUp5J+x3PpdsDEv/9sSueuFb0ZWkGChxt/oMEr3YMxuKiwQf31F78rOwBOREZJkzYeWwTOUpOzQKWkD/V4B4GQTg2D0jxWakKZiA==
X-YMail-OSG: LShvm6oVM1llI8oh2A69h_vlKwZOpD84bk.D9c4t9KfC5B1e_lp5i7QzQPS1Pv_
 qzWasi9sJVhF8umpRRVZb_MVjKr34J8vk81JgU3mL3O9lAKya_zqVjYWR1CCL5QGN9HEjWGdidGS
 4feddWAoov9uACBrVN8mS6RuPULzq21v83aSLWzxmgjw0f.RiUNah57UGrYCuaM9OvdXeEePQi6A
 XhBmMPvoL2dxOM5d3TN.k1nhYGwZSGkg4tW7mNSWcZoWDXA41kF8anuj6idrPLZ5mCWGQQXS3yb8
 0wmXZfsyXJw5CKSSqGXWnzcA_JOao1YdZT3qm.ZmYSkGCRMS9YgwLDdszdJ7shljgwVTLhv.deuT
 qXnyKdDqtqN1v9SVKBJ5qO08trVEpnI9lTrqrMhzOTILtdrdrgBQ3fXZpSYuzsjqSqria8oPmkec
 V2V5b5QYEW7ouLDZNmx7qEm7pt2scoS7ndF5gI4Enp0U72V_ZzDEnloEPxizNFRk2g9WONTfh4F9
 G1w3RFTiQFclw7PmSVPhy1F89ZPG196C.EtLkn1MkhBoF8_x0NBFQvhjk3KIY5xmqifRHpkb12r5
 Zgq0We526EiJy9Mhk8K_bNGxRfgehkDs_uht8.cq_x3646VcPBVc5hnupXWoloM.4e8OeIDl6RHE
 HfGYw6AA2K0ui.G9E2iPUcc0C.q56aaGP3U.v68j4frWI1DKq8E8_bCW22FlLjvnZlBb4rpiljs6
 ymeqZSsGTGDlXUsbDqmDiaX.awko1oTE0EeVDmfLP6Faf7kr96i_6hLLmb_tyB.fmF9BVh90fiZf
 LZKKpnxPkRKnO5OSQB_89f1S.7OxALEN.pf97Hes85jY3MXPFcdvBtHTL01767.YHFqPSBcASxjT
 gd87mpaIUsnmY5ikYoIibV6F6wfkwUt6l0ySVIBkIg1MSsjvKSpqjSksPN1ZsHZ.N4p9tVwgmYAR
 74nfypTAH0CI_vSNsf8JYkSFDapqiaCV8vXKQ7l6WuzPznRsAMGQGLs7MJWLc6E4PddJuEpLbBm0
 AWEXnVwo5I6otEZRg7K6h4ox6ibzmlDvXvWw6_BxkGhZlV5U8xh.VYMBxPsNx6.K0d_ZRK_8qYN9
 e.GJu84gV5JctPM8x3mvvZUvD6izLlqQNXCb9bI_9QJlNSsWsa9JTNsUUmoPJtYXbrczzDjYLtFZ
 Y18h9o619T7pVVL75jmQUv1U3CD8TfyNI7qKNwJsQSuhcVQgSn3TJLgioKqK2gdopByUpsgMPP9H
 MTel2pI393AqLSQxVnMq6uBhP3pL6K8Sif1hQbNLmDuvggyVBnkE0ya7U60Ldcxees3T4UKTfUq5
 iupx6p_giGwhG1FYE8Iemj.ZdRDr6Y5UrzyPMs_NRgH527X_Z_Nfh4z7mEb1I1aNE5FbtBVji10_
 Watx_CMPY_LQEz_m01Kig_SX7uYGdOocIiGHa4QuBhantAL0cqnHXN.gaxQkdw7f.WMAYE13M3gg
 n9JJcqxT2U56PGZIH4S76rBQHHP_c9CE34VGS3QJyf0UzlZ.L1VW3HP_QH9tpKfpKCDQ4isfnHK4
 ulTdZyIlqsaeZxAuOXApv.5inIaGwQwi.mFKtcSGgmjMHXZp2IIrF.5FWVBrq7lc9QuSpE14cocs
 qSMoWBmGg__0vYIt6TjvXiT1pt0VuVpgr5mCfX50wH8eDd4IzMME63CfXAcCc3ucLstgYmJSLYFG
 chSr1dPVpRwjoFbcA67G762XVaZetdMXPsTIgmef.zonG3sqPn7J3klIY106OwsCYLzHEfUfcYKg
 g_5n9AWrFoyvC5Vm3d2EQeVBf5NleGYr2vyaQp0y9OzYzkG9WFbXSZG3uv4ugQKUOuV3ih3k46BA
 p.KxWQMw5RSRcHbSRdVYFJQzpM_LElV7R.bkwVrYcPiKxIxVsTcyQOyVgDXN4V1SWf3vbAMTmwhJ
 GkjcWejJHfqzRYlA089BjPFmJ0Ofqg9rvObEYpfdfEyuuSkLzr5PsFDdZ4cchdV3kcE5XbQwpRG1
 LvGTr4iBQOdRbpRPYUuy9pzIll11GV.9zgia4P6aAH25Rqk8L.wTKeDrGde6hYIht2ifymG57qUk
 pFsFiAJKBRq9OI1RW0MDnGzWt1qxakIqAzAyz9w6HQ5lN4SEZucHEjLsMUrT9SrqiMpgzb3KFFgp
 j1UJ7E2F1h1Bq_EpXjQx1m5nQyFT_ASkc72PcjCVkauzcLiFzZ05tOG2grCtGF59XRreD3.a3vTK
 fIWeP5gfvytHF6ZN4_jqoMv2mRRqVciiu2pZCIdXkHM55peozkc4Sna0BG5lGVWI7Cvz.9jUueGZ
 vpzOb9tSHKX_8uGzZ1MvLZcW0DS_0jSqZdYbTHUJkNPX.eL5wHOmmucSU.8R43KU5irGK.vIRfbd
 OuprrY0yrdsHL5fx.noRVDu.uRY66z_Koepio6TeK8djFREt7W25vwM1Kck8wLaLonYswD96fCU3
 y8uvOyjVp1Fz7a3sze1.pvlk8QWMDm2cRdTVyxcvLwuCaavlAHqIvDD5rA23FhMM5k6aDwEjVnHF
 w5bqBViTHA1bpwU9ZwqoYBn2PsaAr1NLEXVEAOrScfL207Y2371f5SUNEKOr3n98ZR2pXQvsFh7D
 ZlLHKcfnBufclkimvvwKtJxSibW0BGfQLhTCeRPDI3QcY1i12iwZtrxJZLLEHuGtZ6pVXN20gA3w
 s.QtANhC71JJvpaplw0bCpB37DAemhpq2NakuiDTElYnqPoxB_G53VkZ1_6SllbQLI1Uuj6fLHdJ
 ZM5y43Rx4hvp1sw8Cbh7tma.oUBicN..KgBtlUwtok9DHGnb4DAmTOgyRtyBqZGt7JPPgnDY82Rj
 wOlQAYOQOEdtZjHkaOu.LFulN8xaeynHtc4Zy9W9C0ZkXNaGVwMgXjHsopm8JiexzYJXGPeDFqWg
 OwjpaTelEYKeFCilU_oZ_TQPAQfabtPyTA6YWNe5ml3bOUq0kkAtx4Wu2nSdkd2hvGknDohR8ptT
 8RqYmJ_j5Qgo_tKBpiVSQZ1B6IlxjodSo5LUxbZLXe0DKOMJC2QftxiDGv3s6s1xkmu_PniSFxW4
 BeZtcUNp0_QWk7HlWH44__NpvXj0pMzGQQChoK64OZto8bvN0L10Ksty1DErb2AOLzyGRCaw_dCN
 ZybxJXnmAk9hI9B0yrM6hX1YJJE56.DwgEV9OBjZyZppDyAj8fYqn2G1LdpIltN9S85nAOJ1DYTN
 lEudKPsTKzeHRzF9t8ZwIzP5pBSiER.iMSG670rC2xcskpyE66b3.W9wfrduy4HPuPca43fEASRl
 BS2Pyhuv59Mok3terFxpwvLUDyEJUNuRT_d88nJe.SlmmDqKVYlaap9NY8kWN0ugP
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Thu, 22 Apr 2021 21:39:52 +0000
Received: by kubenode540.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 8b4601400a8c97d60e8afb27fa64b98c;
          Thu, 22 Apr 2021 21:39:48 +0000 (UTC)
Subject: Re: [PATCH v2 3/6] security: Pass xattrs allocated by LSMs to the
 inode_init_security hook
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
References: <20210421161925.968825-1-roberto.sassu@huawei.com>
 <20210421161925.968825-4-roberto.sassu@huawei.com>
 <0caf1e58-1e2d-c781-3f71-18aaf55cada2@schaufler-ca.com>
 <406d450699034f54b6c184f286acccfe@huawei.com>
 <37460a6a-da6c-3fdc-7460-0cec024e49db@schaufler-ca.com>
 <3881d532a1f743ca9678944a1b35bc54@huawei.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <cc3c108d-cbf5-0792-5aa4-8783ed4a11dc@schaufler-ca.com>
Date:   Thu, 22 Apr 2021 14:39:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <3881d532a1f743ca9678944a1b35bc54@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18138 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/16)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 4/22/2021 9:12 AM, Roberto Sassu wrote:
>> From: Casey Schaufler [mailto:casey@schaufler-ca.com]
>> Sent: Thursday, April 22, 2021 5:46 PM
>> On 4/22/2021 6:46 AM, Roberto Sassu wrote:
>>>> From: Casey Schaufler [mailto:casey@schaufler-ca.com]
>>>> Sent: Thursday, April 22, 2021 12:44 AM
>>>> On 4/21/2021 9:19 AM, Roberto Sassu wrote:
>>>>> In preparation for moving EVM to the LSM infrastructure, this patch=

>>>>> replaces the name, value, len triple with the xattr array pointer p=
rovided
>>>>> by security_inode_init_security(). LSMs are expected to call the ne=
w
>>>>> function lsm_find_xattr_slot() to find the first unused slot of the=20
array
>>>>> where the xattr should be written.
>>>>>
>>>>> This patch modifies also SELinux and Smack to search for an unused =
slot, to
>>>>> have a consistent behavior across LSMs (the unmodified version woul=
d
>>>>> overwrite the xattr set by the first LSM in the chain). It is also
>>>>> desirable to have the modification in those LSMs, as they are likel=
y used
>>>>> as a reference for the development of new LSMs.
>>>> This looks better than V1. One safety comment below.
>>>>
>>>>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>>>>> ---
>>>>>  include/linux/lsm_hook_defs.h |  4 ++--
>>>>>  include/linux/lsm_hooks.h     | 18 +++++++++++++++---
>>>>>  security/security.c           | 13 +++++++------
>>>>>  security/selinux/hooks.c      | 13 ++++++-------
>>>>>  security/smack/smack_lsm.c    | 20 +++++++++-----------
>>>>>  5 files changed, 39 insertions(+), 29 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/lsm_hook_defs.h
>> b/include/linux/lsm_hook_defs.h
>>>>> index 477a597db013..afb9dd122f60 100644
>>>>> --- a/include/linux/lsm_hook_defs.h
>>>>> +++ b/include/linux/lsm_hook_defs.h
>>>>> @@ -111,8 +111,8 @@ LSM_HOOK(int, 0, path_notify, const struct path=

>>>> *path, u64 mask,
>>>>>  LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
>>>>>  LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode
>> *inode)
>>>>>  LSM_HOOK(int, 0, inode_init_security, struct inode *inode,
>>>>> -	 struct inode *dir, const struct qstr *qstr, const char **name,
>>>>> -	 void **value, size_t *len)
>>>>> +	 struct inode *dir, const struct qstr *qstr, struct xattr *xattrs=
,
>>>>> +	 void *fs_data)
>>>>>  LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
>>>>>  	 const struct qstr *name, const struct inode *context_inode)
>>>>>  LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *d=
entry,
>>>>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>>>>> index c5498f5174ce..e8c9bac29b9d 100644
>>>>> --- a/include/linux/lsm_hooks.h
>>>>> +++ b/include/linux/lsm_hooks.h
>>>>> @@ -27,6 +27,7 @@
>>>>>
>>>>>  #include <linux/security.h>
>>>>>  #include <linux/init.h>
>>>>> +#include <linux/xattr.h>
>>>>>  #include <linux/rculist.h>
>>>>>
>>>>>  /**
>>>>> @@ -227,9 +228,11 @@
>>>>>   *	@inode contains the inode structure of the newly created inode.=

>>>>>   *	@dir contains the inode structure of the parent directory.
>>>>>   *	@qstr contains the last path component of the new object
>>>>> - *	@name will be set to the allocated name suffix (e.g. selinux).
>>>>> - *	@value will be set to the allocated attribute value.
>>>>> - *	@len will be set to the length of the value.
>>>>> + *	@xattrs contains the full array of xattrs allocated by LSMs whe=
re
>>>>> + *	->name will be set to the allocated name suffix (e.g. selinux).=

>>>>> + *	->value will be set to the allocated attribute value.
>>>>> + *	->len will be set to the length of the value.
>>>>> + *	@fs_data contains filesystem-specific data.
>>>>>   *	Returns 0 if @name and @value have been successfully set,
>>>>>   *	-EOPNOTSUPP if no security attribute is needed, or
>>>>>   *	-ENOMEM on memory allocation failure.
>>>>> @@ -1661,4 +1664,13 @@ static inline void security_delete_hooks(str=
uct
>>>> security_hook_list *hooks,
>>>>>  extern int lsm_inode_alloc(struct inode *inode);
>>>>>
>>>> Some "security researcher" with a fuzz tester is going to manage to =
dump
>> junk
>>>> into the slots and ruin your week. I suggest a simple change to make=20
bounds
>>>> checking
>>>> possible. It should never happen, but if that was sufficient people =
would
>>>> love C
>>>> string processing better.
>>>>
>>>>> +static inline struct xattr *lsm_find_xattr_slot(struct xattr *xatt=
rs)
>>>> +static inline struct xattr *lsm_find_xattr_slot(struct xattr *xattr=
s,
>> int available)
>>> Ok. I looked at how I should do that. Initially, I thought that I cou=
ld
>>> use a global variable storing the number of inode_init_security
>>> implementations, determined at LSM registration time. Then,
>>> I realized that this would not work, as the number of array elements
>>> when security_old_inode_init_security() is called is 1.
>> You can address that by expanding the call_int_hook MACRO in
>> security_old_inode_init_security() in place and change it to stop
>> after the first call. The two callers of security_old_inode_init_secur=
ity()
>> are going to need to be converted to security_inode_init_security()
>> when the "complete" stacking (i.e. SELinux + Smack) anyway, so I don't=

>> see that as an issue.
> The current version already does it. I was more concerned about LSMs
> requesting more than one slot. In this case, lsm_find_xattr_slot()
> could return a slot outside the array, unless we pass the correct size.=


That would be a bit of a problem. It would be possible to add the number
of inode_init "slots" to struct lsm_info or to struct lsm_blob_sizes.
That would require dynamic allocation, but you've been advocating
that anyway. Ding! If we add the number of slots required to lsm_blob_siz=
es
we can replace that with the slot number to use in the inode_init_securit=
y
array. This is the same technique used for blob offsets in the LSM manage=
d
blobs. The EVM hook will know the size of the array. We pass the base of
array to the module inode_init_security hooks, and they know what slot(s)=

they've been told to use. The EVM hook starts with base and any slot that=
's
filled get processed.

Unfortunately, security_old_inode_init_security() will have to allocate
the array and copy results from the right slot into the parameters passed=
=2E
Essentially a complete rewrite.

=20

>
> If we convert ocfs2 and reiserfs to use security_inode_init_security(),=

> we could use the global variable set at LSM registration time, and we
> don't need to add a new parameter.
>
> Roberto
>
> HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
> Managing Director: Li Peng, Li Jian, Shi Yanli
>
>> Is anyone concerned that ocfs2 and reiserfs aren't EVM capable?
>>
>>> I modified the patch set to pass also the number of array elements.
>>>
>>> Roberto
>>>
>>> HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
>>> Managing Director: Li Peng, Li Jian, Shi Yanli
>>>
>>>>> +{
>>>>> +	struct xattr *slot;
>>>>> +
>>>>> +	for (slot =3D xattrs; slot && slot->name !=3D NULL; slot++)
>>>> +	for (slot =3D xattrs; slot && slot->name !=3D NULL; slot++)
>>>>  		if (WARN_ON(slot > xattrs[available]))
>>>> 			return NULL;
>>>>
>>>>> +		;
>>>>> +
>>>>> +	return slot;
>>>>> +}
>>>>>  #endif /* ! __LINUX_LSM_HOOKS_H */
>>>>> diff --git a/security/security.c b/security/security.c
>>>>> index 7f14e59c4f8e..2c1fe1496069 100644
>>>>> --- a/security/security.c
>>>>> +++ b/security/security.c
>>>>> @@ -1037,18 +1037,16 @@ int security_inode_init_security(struct ino=
de
>>>> *inode, struct inode *dir,
>>>>>  	if (!initxattrs)
>>>>>  		return call_int_hook(inode_init_security, -EOPNOTSUPP,
>>>> inode,
>>>>> -				     dir, qstr, NULL, NULL, NULL);
>>>>> +				     dir, qstr, NULL, fs_data);
>>>>>  	memset(new_xattrs, 0, sizeof(new_xattrs));
>>>>>  	lsm_xattr =3D new_xattrs;
>>>>>  	ret =3D call_int_hook(inode_init_security, -EOPNOTSUPP, inode, di=
r,
>> qstr,
>>>>> -						&lsm_xattr->name,
>>>>> -						&lsm_xattr->value,
>>>>> -						&lsm_xattr->value_len);
>>>>> +			    lsm_xattr, fs_data);
>>>>>  	if (ret)
>>>>>  		goto out;
>>>>>
>>>>>  	evm_xattr =3D lsm_xattr + 1;
>>>>> -	ret =3D evm_inode_init_security(inode, lsm_xattr, evm_xattr);
>>>>> +	ret =3D evm_inode_init_security(inode, new_xattrs, evm_xattr);
>>>>>  	if (ret)
>>>>>  		goto out;
>>>>>  	ret =3D initxattrs(inode, new_xattrs, fs_data);
>>>>> @@ -1071,10 +1069,13 @@ int security_old_inode_init_security(struct=

>> inode
>>>> *inode, struct inode *dir,
>>>>>  				     const struct qstr *qstr, const char **name,
>>>>>  				     void **value, size_t *len)
>>>>>  {
>>>>> +	struct xattr xattr =3D { .name =3D NULL, .value =3D NULL, .value_=
len =3D 0 };
>>>>> +	struct xattr *lsm_xattr =3D (name && value && len) ? &xattr : NUL=
L;
>>>>> +
>>>>>  	if (unlikely(IS_PRIVATE(inode)))
>>>>>  		return -EOPNOTSUPP;
>>>>>  	return call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir=
,
>>>>> -			     qstr, name, value, len);
>>>>> +			     qstr, lsm_xattr, NULL);
>>>>>  }
>>>>>  EXPORT_SYMBOL(security_old_inode_init_security);
>>>>>
>>>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>>>> index ddd097790d47..806827eb132a 100644
>>>>> --- a/security/selinux/hooks.c
>>>>> +++ b/security/selinux/hooks.c
>>>>> @@ -2916,11 +2916,11 @@ static int
>> selinux_dentry_create_files_as(struct
>>>> dentry *dentry, int mode,
>>>>>  static int selinux_inode_init_security(struct inode *inode, struct=20
inode
>> *dir,
>>>>>  				       const struct qstr *qstr,
>>>>> -				       const char **name,
>>>>> -				       void **value, size_t *len)
>>>>> +				       struct xattr *xattrs, void *fs_data)
>>>>>  {
>>>>>  	const struct task_security_struct *tsec =3D selinux_cred(current_=
cred());
>>>>>  	struct superblock_security_struct *sbsec;
>>>>> +	struct xattr *xattr =3D lsm_find_xattr_slot(xattrs);
>>>>>  	u32 newsid, clen;
>>>>>  	int rc;
>>>>>  	char *context;
>>>>> @@ -2947,16 +2947,15 @@ static int selinux_inode_init_security(stru=
ct
>>>> inode *inode, struct inode *dir,
>>>>>  	    !(sbsec->flags & SBLABEL_MNT))
>>>>>  		return -EOPNOTSUPP;
>>>>>
>>>>> -	if (name)
>>>>> -		*name =3D XATTR_SELINUX_SUFFIX;
>>>>> +	if (xattr) {
>>>>> +		xattr->name =3D XATTR_SELINUX_SUFFIX;
>>>>>
>>>>> -	if (value && len) {
>>>>>  		rc =3D security_sid_to_context_force(&selinux_state, newsid,
>>>>>  						   &context, &clen);
>>>>>  		if (rc)
>>>>>  			return rc;
>>>>> -		*value =3D context;
>>>>> -		*len =3D clen;
>>>>> +		xattr->value =3D context;
>>>>> +		xattr->value_len =3D clen;
>>>>>  	}
>>>>>
>>>>>  	return 0;
>>>>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.=
c
>>>>> index 12a45e61c1a5..af7eee0fee52 100644
>>>>> --- a/security/smack/smack_lsm.c
>>>>> +++ b/security/smack/smack_lsm.c
>>>>> @@ -962,26 +962,24 @@ static int smack_inode_alloc_security(struct
>> inode
>>>> *inode)
>>>>>   * @inode: the newly created inode
>>>>>   * @dir: containing directory object
>>>>>   * @qstr: unused
>>>>> - * @name: where to put the attribute name
>>>>> - * @value: where to put the attribute value
>>>>> - * @len: where to put the length of the attribute
>>>>> + * @xattrs: where to put the attribute
>>>>>   *
>>>>>   * Returns 0 if it all works out, -ENOMEM if there's no memory
>>>>>   */
>>>>>  static int smack_inode_init_security(struct inode *inode, struct i=
node
>>>> *dir,
>>>>> -				     const struct qstr *qstr, const char **name,
>>>>> -				     void **value, size_t *len)
>>>>> +				     const struct qstr *qstr,
>>>>> +				     struct xattr *xattrs, void *fs_data)
>>>>>  {
>>>>>  	struct inode_smack *issp =3D smack_inode(inode);
>>>>>  	struct smack_known *skp =3D smk_of_current();
>>>>>  	struct smack_known *isp =3D smk_of_inode(inode);
>>>>>  	struct smack_known *dsp =3D smk_of_inode(dir);
>>>>> +	struct xattr *xattr =3D lsm_find_xattr_slot(xattrs);
>>>>>  	int may;
>>>>>
>>>>> -	if (name)
>>>>> -		*name =3D XATTR_SMACK_SUFFIX;
>>>>> +	if (xattr) {
>>>>> +		xattr->name =3D XATTR_SMACK_SUFFIX;
>>>>>
>>>>> -	if (value && len) {
>>>>>  		rcu_read_lock();
>>>>>  		may =3D smk_access_entry(skp->smk_known, dsp->smk_known,
>>>>>  				       &skp->smk_rules);
>>>>> @@ -999,11 +997,11 @@ static int smack_inode_init_security(struct i=
node
>>>> *inode, struct inode *dir,
>>>>>  			issp->smk_flags |=3D SMK_INODE_CHANGED;
>>>>>  		}
>>>>>
>>>>> -		*value =3D kstrdup(isp->smk_known, GFP_NOFS);
>>>>> -		if (*value =3D=3D NULL)
>>>>> +		xattr->value =3D kstrdup(isp->smk_known, GFP_NOFS);
>>>>> +		if (xattr->value =3D=3D NULL)
>>>>>  			return -ENOMEM;
>>>>>
>>>>> -		*len =3D strlen(isp->smk_known);
>>>>> +		xattr->value_len =3D strlen(isp->smk_known);
>>>>>  	}
>>>>>
>>>>>  	return 0;

