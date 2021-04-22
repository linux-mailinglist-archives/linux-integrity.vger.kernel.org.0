Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1ACD36841C
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Apr 2021 17:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236485AbhDVPq6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Apr 2021 11:46:58 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:36203
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236571AbhDVPq5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Apr 2021 11:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1619106382; bh=UkCXK1QR81Y+wUBBsIECzyf3fHkMEHIz6oyKrszYCLw=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=XdIWTjdLinm7tygufPd9U9D47z15qW0CYsGuOkY+EIFUYNUgwoO3/ifdyZV4J0Iux/6TmV1ishJSdPOLf65ZjtPSFM0H1L5eEKCB8W5lumwfdf2pJqohaab5Yn2hPw+08+hDDdUq+dnLuD5WQEGDkC7r20jsYKvU0MY3HtuZcEZ6Lj6dpyj7PMpJ2VTfwu9DXq3tlzhP4TY92qtrhx7F3q/xmeX5euIWgUSdU2g0358byHwCV2vQBl/8dLEIgl3/s9SNzSkPAwTskRd1qTvMbapE4WwPBQYra3K7fUfX9h7uFa5/MI1YG0QSUKgM5nh6nic28gVni22IkXWhvnxomQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1619106382; bh=DxGkQOBmA5ReLu8Ucogr5a2dHtQiPc2hDsinlPW+9E9=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=fjMYpURNFyT4RIM4YUTO0NV+fpgjERjrbmdvMp23FW0puP8row5PHgVx6+CoHpRUs8TiymBfeoGEk7mhzbOjSYVYchi3FnBV4cLHXj8yUO9VJuVgwB8GUojeAWdWdYJ4yVgTYOdBeFTY3tQS3BbgTtPS+JCACHp0h0fzhxHQujBPfWRUtVv/669NJVob30MhS/essxjiQGdSd16yz1FJNT3i7bXf3ZTM4GjlHRSJopQpEW9Uvu8gdco8O/S2SYUGOuuHnDNfaSZ4nwSvzeosDu+/K/TelS3AMZ2sRoZmn2nLzcekCf6hMraa3+J/W9ktXL//NnR6LB2L+/07ejHwnQ==
X-YMail-OSG: ajU57xwVM1l_NVOkNrGKOtYd1U316VNSTctfTvTzv1.ulh7gx64_ftjslXVsmyL
 hgoRGzm2oH09hN.ITqHIHJETuejnrs1zVYkCRnrLqocceB1nMbBCDdx7dvhmwHzcyCGXOjGRdLpV
 ZBjPz6X994IfOMEeprW2iHFNI2122YJufLyW0BHAgpzcCs8rj_yCTGuAktaO0VRxC7wdMxBH6vb_
 HX9VBQzzGrRDVV4nbwzx5Y7dc3TE8doJzet6rIlBPCjexF1z.xXyY37YZGHwhsIpNefUfzxb2arZ
 fVeXpg_DJmgxw9gIkN1pat0Mv_CwpvgFpD4qgzDsZmSV_C7MbGKK3dLVC6A85j9u0r3xs8YOqFvg
 v3bwpxNeiA9ob106mIYXjWT6ueUyg9P4rrEKS77dnYA6VWKCzWftQQ8RoWfw3iFX2aGye3Ln50LJ
 R6NxpZVKk4qB.n_moABYaVBeUdiROK0Hq6b7WMkf4NNAxqs_x128HREw0FhHpxtvBTHPXaA.9fNx
 eAPfqSwL5GFGQi5zU8yUmVlEGXqBFEKymgWZWiISyudeVlnD2MYbUkafq4Xf9gtQezDkYJOKf_mz
 G_jMEpCROEbYyt28kimXZNk38leRGwgoAwPLE8NsZ48axib7tlcp8cWQSc0IPrvnQ8Ivi4TBwCQ.
 mUOlj0xg8HadqoWHlRpJ8GYz8Me_I4mka3OJgScJUQb95TpLELEv9KzhWQodZyn_xIuPHdibNcvw
 sgiG.SmfpqK2sFN.ajno.PuceS3zg10YFBwsetBjeiX6v3XkgQPF1hkq.fOoTh0tE5dUOqFlaROn
 6H3HbShOT1NDbqso5QoN4SiP9j1KphHTsmI7NTL5zuzTx_ERM68PNLby9KCtBSmaE0HnzXaLUbF0
 sWgoEpupwNa6axuJ7e25xjT28ACI34lKgfOe.GGIYbSeleIxM5hKHDprZ5mvbt1STdavgb2xkzwP
 lwGv1uB7PKTYTxzxEWtoWdlJUnBEhdW2BZivtaMYQ9PRq_C_ji_SO.1N8_sn_vImYzgk9q_TZsIK
 ugLAUOqIj_43E2d4_Qlpr3i3fiFoRY1MPkM6LpGP6hlY33XMXM1.ag.0XOc.gTk4xFdQ_v90zrnT
 8GpO1ZoE7mw71hbbuyM5fX1PCUkDWKNDMmkBN1J0B5LhbAPUcQq8zYRSO2hSd4ZBNrs.nft0utyL
 CydlAERqe.iZXZ8BFm.YiuCgz6qiopM4hVU1WQJXZ6Zc0lCg_TU0MqJbkh7UUfe3n6iYwrhf7kpj
 yAawpNVFBfkZIJXo9bmCAE_jssrE05sUYhI9dgB0eglVDkRZiWHmQrv_wvcXqMLFyiTdr4XZg5xc
 jX3y52fuG0noEuegGTvJ5a5oSNQo47Yz677O3_3tfjMvm7inswUOR359I19_dnbWG_mJD5rgwW6U
 _l4YgCkW3AmEQnnVwfM7sdByyYptRF6.IUlChpAkLMUvOko1czrnTSJlYM8xC47pJj1BcbDsIklW
 k1mEShN6MddeMRq_gZUmEjK8oZAxEW09Fw_O88gV5a3Oqy_1x9BEtSlVWbm3.enedUVFpGtrlvoP
 PcVqS5DGCp9oW3Pa8Q8G7cM5Y_fowkf8nlR2Xc5FbXNoyggv7aNQfQjSFqbKl1fL31YCy3wEtjCc
 _IAFaX3eOJL.vpodFJ98gEyrQSwV4huuFTs949G7dJsQSx.tJ66VpUiUYDTEFBDjCvI4u6oTezJL
 qMTgT_gwyA2R2H.U6GrwjIjy0gDp5QSlB0D5NtMo.gUZhpWTSlGP5y8O_ptoiCCQGJY0ZcBtadJY
 bjdlSwGTR9PVLk8Duvrd_L93e5Cl8c.dY4OzOILh72hZhqFA3uAO4Y3WLnt8GhD7KeysJ35tTX.N
 v9bSXEFZsU1vTHDO._UziRc7F3d2qLKlCEXbaDNjvZFem0j9nr1aF6pips.Tjc.07VxgpNU_HMhX
 w69vx5uSGgSG5YYBRlxA1GRero6WYtmHdaaktgf.kLVD1YK1zsP.5cgqZwC9r2HIt6G7retBhJ6J
 tWINbAvtX777bISTXvy2eqdYcKBbI1tPC7tI2hryHVUKmo.Wt9D6S8.NDooD7.KlvJkXHdY3v41A
 OLbLhE_kC5ezWPrbvt3ej5YIF.SURGoaYw1yPGsy2un_0qKSzfIGi.XLWqS2i3BwErEYdtwVr22.
 o8deWymFaH57rWVEGNqsypN.08GR5grgc_mQ.uMz_6E4zARA9WsXINIRHnyLWqXkkv2E_3HMHy97
 UbhFplqe_Tkjt76bPYKti0d5LqFWqRiqBepZCOL._4FCKUzieR16LZo.coOyVXRKZfbqGyhVYUli
 uESAFvs1OX4Tjhg1vQfMZG0fWqxevne_c86PYL_2Cwj5GTgdLovkuEW2xSEJFOUa4RV4D6YDWy_e
 CVjNFWWL0YqkBVw1osFVHxdWF9B8yZAF1tgubS971Rz301AAHwGED24GdNdn4ULezN.dcPlibczW
 fMAsOJaPrI8OcgOg0..bWEN8QUbEWCkgNFkawfHTLDObnQtufJqgjvC72uQ_xeLbnwivO1AEj0Es
 udSYiUw0wOHywDpkCv2ysz2OVi6LnHZm7enUrs.WEhYbImZIHHLr8Lya7xAtcnD4UIDGhqeFlCxI
 dk8d.7HZVIHBVe0DxNmugM7i9RKW9ucnGIBhs5vVslyEZW2defU.ZMTCrQGd0TdqebPReVkaZQEZ
 Wpmt72NOmungsxSqEx0ph_XbiQAk3o2LNSaB4VQErNlhKoPOK9wrXAir3uKQdPrL8kgB_HY56MR.
 xi8ffAK4xSm0lPOb4UejAHqeK3tgA14wDpuwh16peyDOVIv2QOQoqQhkQTjASl2p1YulPCJkIChi
 vngWO2onFYP.YXxFfwpUDIp0wohnPG7vFOWWPe7QhOH94JjgXvWFUzA7kR6CQOOHzqUY8jtZgSYp
 crQPjNPP59kqfQ809M37MU3quBJHRnyDzTj8EMK7zYL6pdqNHr.loiulrgYk.cndTUV13c8HUoS3
 EmsbpRhjwsm80C_V1voaYR2aiVhaVoV4UCTqnVdV5MPR48GVQzq24U7fdCYLJhH3pbC8FIKWxjZn
 Mh2P4dRjH2WhtboPpB.InawRTTd8I.5tmJcvWOyWc4VVhm.XgyjWf0FOpyvJZQ3.UDH3kiMvFfUR
 sxjv0Ae8Y8G55XKJQBF6EU10YLqT0UUPU71bgzAoDQJxruMC1m3yZd0cCF39dJinZZQcOYTOGMa5
 enL5skDA3WAIQgMWweTZvKTSeo1Fs7dO50gwqsd9dTj3aRn8p55p8fd11Gvv1y9ax.lBFzks6UUb
 HRtPtO0Yx
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 22 Apr 2021 15:46:22 +0000
Received: by kubenode533.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 8c99ac3b8b3ac92e5023df89796bef93;
          Thu, 22 Apr 2021 15:46:21 +0000 (UTC)
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
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <37460a6a-da6c-3fdc-7460-0cec024e49db@schaufler-ca.com>
Date:   Thu, 22 Apr 2021 08:46:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <406d450699034f54b6c184f286acccfe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18121 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/16)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 4/22/2021 6:46 AM, Roberto Sassu wrote:
>> From: Casey Schaufler [mailto:casey@schaufler-ca.com]
>> Sent: Thursday, April 22, 2021 12:44 AM
>> On 4/21/2021 9:19 AM, Roberto Sassu wrote:
>>> In preparation for moving EVM to the LSM infrastructure, this patch
>>> replaces the name, value, len triple with the xattr array pointer pro=
vided
>>> by security_inode_init_security(). LSMs are expected to call the new
>>> function lsm_find_xattr_slot() to find the first unused slot of the a=
rray
>>> where the xattr should be written.
>>>
>>> This patch modifies also SELinux and Smack to search for an unused sl=
ot, to
>>> have a consistent behavior across LSMs (the unmodified version would
>>> overwrite the xattr set by the first LSM in the chain). It is also
>>> desirable to have the modification in those LSMs, as they are likely =
used
>>> as a reference for the development of new LSMs.
>> This looks better than V1. One safety comment below.
>>
>>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>>> ---
>>>  include/linux/lsm_hook_defs.h |  4 ++--
>>>  include/linux/lsm_hooks.h     | 18 +++++++++++++++---
>>>  security/security.c           | 13 +++++++------
>>>  security/selinux/hooks.c      | 13 ++++++-------
>>>  security/smack/smack_lsm.c    | 20 +++++++++-----------
>>>  5 files changed, 39 insertions(+), 29 deletions(-)
>>>
>>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_d=
efs.h
>>> index 477a597db013..afb9dd122f60 100644
>>> --- a/include/linux/lsm_hook_defs.h
>>> +++ b/include/linux/lsm_hook_defs.h
>>> @@ -111,8 +111,8 @@ LSM_HOOK(int, 0, path_notify, const struct path
>> *path, u64 mask,
>>>  LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
>>>  LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inod=
e)
>>>  LSM_HOOK(int, 0, inode_init_security, struct inode *inode,
>>> -	 struct inode *dir, const struct qstr *qstr, const char **name,
>>> -	 void **value, size_t *len)
>>> +	 struct inode *dir, const struct qstr *qstr, struct xattr *xattrs,
>>> +	 void *fs_data)
>>>  LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
>>>  	 const struct qstr *name, const struct inode *context_inode)
>>>  LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *den=
try,
>>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>>> index c5498f5174ce..e8c9bac29b9d 100644
>>> --- a/include/linux/lsm_hooks.h
>>> +++ b/include/linux/lsm_hooks.h
>>> @@ -27,6 +27,7 @@
>>>
>>>  #include <linux/security.h>
>>>  #include <linux/init.h>
>>> +#include <linux/xattr.h>
>>>  #include <linux/rculist.h>
>>>
>>>  /**
>>> @@ -227,9 +228,11 @@
>>>   *	@inode contains the inode structure of the newly created inode.
>>>   *	@dir contains the inode structure of the parent directory.
>>>   *	@qstr contains the last path component of the new object
>>> - *	@name will be set to the allocated name suffix (e.g. selinux).
>>> - *	@value will be set to the allocated attribute value.
>>> - *	@len will be set to the length of the value.
>>> + *	@xattrs contains the full array of xattrs allocated by LSMs where=

>>> + *	->name will be set to the allocated name suffix (e.g. selinux).
>>> + *	->value will be set to the allocated attribute value.
>>> + *	->len will be set to the length of the value.
>>> + *	@fs_data contains filesystem-specific data.
>>>   *	Returns 0 if @name and @value have been successfully set,
>>>   *	-EOPNOTSUPP if no security attribute is needed, or
>>>   *	-ENOMEM on memory allocation failure.
>>> @@ -1661,4 +1664,13 @@ static inline void security_delete_hooks(struc=
t
>> security_hook_list *hooks,
>>>  extern int lsm_inode_alloc(struct inode *inode);
>>>
>> Some "security researcher" with a fuzz tester is going to manage to du=
mp junk
>> into the slots and ruin your week. I suggest a simple change to make b=
ounds
>> checking
>> possible. It should never happen, but if that was sufficient people wo=
uld
>> love C
>> string processing better.
>>
>>> +static inline struct xattr *lsm_find_xattr_slot(struct xattr *xattrs=
)
>> +static inline struct xattr *lsm_find_xattr_slot(struct xattr *xattrs,=20
int available)
> Ok. I looked at how I should do that. Initially, I thought that I could=

> use a global variable storing the number of inode_init_security
> implementations, determined at LSM registration time. Then,
> I realized that this would not work, as the number of array elements
> when security_old_inode_init_security() is called is 1.

You can address that by expanding the call_int_hook MACRO in
security_old_inode_init_security() in place and change it to stop
after the first call. The two callers of security_old_inode_init_security=
()
are going to need to be converted to security_inode_init_security()
when the "complete" stacking (i.e. SELinux + Smack) anyway, so I don't
see that as an issue.

Is anyone concerned that ocfs2 and reiserfs aren't EVM capable?

>
> I modified the patch set to pass also the number of array elements.
>
> Roberto
>
> HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
> Managing Director: Li Peng, Li Jian, Shi Yanli
>
>>> +{
>>> +	struct xattr *slot;
>>> +
>>> +	for (slot =3D xattrs; slot && slot->name !=3D NULL; slot++)
>> +	for (slot =3D xattrs; slot && slot->name !=3D NULL; slot++)
>>  		if (WARN_ON(slot > xattrs[available]))
>> 			return NULL;
>>
>>> +		;
>>> +
>>> +	return slot;
>>> +}
>>>  #endif /* ! __LINUX_LSM_HOOKS_H */
>>> diff --git a/security/security.c b/security/security.c
>>> index 7f14e59c4f8e..2c1fe1496069 100644
>>> --- a/security/security.c
>>> +++ b/security/security.c
>>> @@ -1037,18 +1037,16 @@ int security_inode_init_security(struct inode=

>> *inode, struct inode *dir,
>>>  	if (!initxattrs)
>>>  		return call_int_hook(inode_init_security, -EOPNOTSUPP,
>> inode,
>>> -				     dir, qstr, NULL, NULL, NULL);
>>> +				     dir, qstr, NULL, fs_data);
>>>  	memset(new_xattrs, 0, sizeof(new_xattrs));
>>>  	lsm_xattr =3D new_xattrs;
>>>  	ret =3D call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir,=20
qstr,
>>> -						&lsm_xattr->name,
>>> -						&lsm_xattr->value,
>>> -						&lsm_xattr->value_len);
>>> +			    lsm_xattr, fs_data);
>>>  	if (ret)
>>>  		goto out;
>>>
>>>  	evm_xattr =3D lsm_xattr + 1;
>>> -	ret =3D evm_inode_init_security(inode, lsm_xattr, evm_xattr);
>>> +	ret =3D evm_inode_init_security(inode, new_xattrs, evm_xattr);
>>>  	if (ret)
>>>  		goto out;
>>>  	ret =3D initxattrs(inode, new_xattrs, fs_data);
>>> @@ -1071,10 +1069,13 @@ int security_old_inode_init_security(struct i=
node
>> *inode, struct inode *dir,
>>>  				     const struct qstr *qstr, const char **name,
>>>  				     void **value, size_t *len)
>>>  {
>>> +	struct xattr xattr =3D { .name =3D NULL, .value =3D NULL, .value_le=
n =3D 0 };
>>> +	struct xattr *lsm_xattr =3D (name && value && len) ? &xattr : NULL;=

>>> +
>>>  	if (unlikely(IS_PRIVATE(inode)))
>>>  		return -EOPNOTSUPP;
>>>  	return call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir,
>>> -			     qstr, name, value, len);
>>> +			     qstr, lsm_xattr, NULL);
>>>  }
>>>  EXPORT_SYMBOL(security_old_inode_init_security);
>>>
>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>> index ddd097790d47..806827eb132a 100644
>>> --- a/security/selinux/hooks.c
>>> +++ b/security/selinux/hooks.c
>>> @@ -2916,11 +2916,11 @@ static int selinux_dentry_create_files_as(str=
uct
>> dentry *dentry, int mode,
>>>  static int selinux_inode_init_security(struct inode *inode, struct i=
node *dir,
>>>  				       const struct qstr *qstr,
>>> -				       const char **name,
>>> -				       void **value, size_t *len)
>>> +				       struct xattr *xattrs, void *fs_data)
>>>  {
>>>  	const struct task_security_struct *tsec =3D selinux_cred(current_cr=
ed());
>>>  	struct superblock_security_struct *sbsec;
>>> +	struct xattr *xattr =3D lsm_find_xattr_slot(xattrs);
>>>  	u32 newsid, clen;
>>>  	int rc;
>>>  	char *context;
>>> @@ -2947,16 +2947,15 @@ static int selinux_inode_init_security(struct=

>> inode *inode, struct inode *dir,
>>>  	    !(sbsec->flags & SBLABEL_MNT))
>>>  		return -EOPNOTSUPP;
>>>
>>> -	if (name)
>>> -		*name =3D XATTR_SELINUX_SUFFIX;
>>> +	if (xattr) {
>>> +		xattr->name =3D XATTR_SELINUX_SUFFIX;
>>>
>>> -	if (value && len) {
>>>  		rc =3D security_sid_to_context_force(&selinux_state, newsid,
>>>  						   &context, &clen);
>>>  		if (rc)
>>>  			return rc;
>>> -		*value =3D context;
>>> -		*len =3D clen;
>>> +		xattr->value =3D context;
>>> +		xattr->value_len =3D clen;
>>>  	}
>>>
>>>  	return 0;
>>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>>> index 12a45e61c1a5..af7eee0fee52 100644
>>> --- a/security/smack/smack_lsm.c
>>> +++ b/security/smack/smack_lsm.c
>>> @@ -962,26 +962,24 @@ static int smack_inode_alloc_security(struct in=
ode
>> *inode)
>>>   * @inode: the newly created inode
>>>   * @dir: containing directory object
>>>   * @qstr: unused
>>> - * @name: where to put the attribute name
>>> - * @value: where to put the attribute value
>>> - * @len: where to put the length of the attribute
>>> + * @xattrs: where to put the attribute
>>>   *
>>>   * Returns 0 if it all works out, -ENOMEM if there's no memory
>>>   */
>>>  static int smack_inode_init_security(struct inode *inode, struct ino=
de
>> *dir,
>>> -				     const struct qstr *qstr, const char **name,
>>> -				     void **value, size_t *len)
>>> +				     const struct qstr *qstr,
>>> +				     struct xattr *xattrs, void *fs_data)
>>>  {
>>>  	struct inode_smack *issp =3D smack_inode(inode);
>>>  	struct smack_known *skp =3D smk_of_current();
>>>  	struct smack_known *isp =3D smk_of_inode(inode);
>>>  	struct smack_known *dsp =3D smk_of_inode(dir);
>>> +	struct xattr *xattr =3D lsm_find_xattr_slot(xattrs);
>>>  	int may;
>>>
>>> -	if (name)
>>> -		*name =3D XATTR_SMACK_SUFFIX;
>>> +	if (xattr) {
>>> +		xattr->name =3D XATTR_SMACK_SUFFIX;
>>>
>>> -	if (value && len) {
>>>  		rcu_read_lock();
>>>  		may =3D smk_access_entry(skp->smk_known, dsp->smk_known,
>>>  				       &skp->smk_rules);
>>> @@ -999,11 +997,11 @@ static int smack_inode_init_security(struct ino=
de
>> *inode, struct inode *dir,
>>>  			issp->smk_flags |=3D SMK_INODE_CHANGED;
>>>  		}
>>>
>>> -		*value =3D kstrdup(isp->smk_known, GFP_NOFS);
>>> -		if (*value =3D=3D NULL)
>>> +		xattr->value =3D kstrdup(isp->smk_known, GFP_NOFS);
>>> +		if (xattr->value =3D=3D NULL)
>>>  			return -ENOMEM;
>>>
>>> -		*len =3D strlen(isp->smk_known);
>>> +		xattr->value_len =3D strlen(isp->smk_known);
>>>  	}
>>>
>>>  	return 0;

