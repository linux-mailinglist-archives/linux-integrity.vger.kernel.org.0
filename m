Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F95367546
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Apr 2021 00:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbhDUWoc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Apr 2021 18:44:32 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:42489
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231128AbhDUWo3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Apr 2021 18:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1619045035; bh=MB9zO7McvPmioxzhN+e5Vh39AUmsx8/cXEwQ1feTM0s=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=DmWXKFnjz2d6JUBIVczNc/zjMfKTXbm21VW1dfa04ONIPY/snL8uluYvp4jhdUFbhYqzLMjOIcl+d/2/Z4LwOaQGug4Z4bsBS2ia9MbexNzsp9M6ILAmUepHbk5gizG8gz9vFB/dbajGuCXHBWXyFpbGPm1SbY1ObVSTlRdQDN/DPGFIbaVgTemQXlMqOhfLdflpaWELfFm2+TeqPSq2ntY6GNQIawXiXA0NfA6eRQF7B72QrhHQZZd/JEo+7XXr7N3ZBkSk6q6zqfhWMbsMYSjfGcVix2tCOFEKMSUrXms88Kp0WWkhx1Bb6W8iNIcivZ9U3SN5PTNyLrJOCpqRnw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1619045035; bh=ieU2/qrLV3IRmLoQ5YVtfxGudHH/5aHFGm4V7Cjzbn/=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=m0VEMvyJmp5V4/4vWO/oZNTF6YsEEOVXru4LJTSxzIL3agH6vo3FPyV4QqWDU2/LKPOS/RbnatmjFe3qcGQMo5n8dunCsKTgCSVwIi3YuXo6Kn2zzVynmEt3pbae457O6iFVsQdSKrG30U6qrMf2c+c+cBLGPmUsB86tvhTivDPy/nPkQcs/GX3VdX9nCZbGnPL10viUpT1gXIGpsz+9DTEGpLHn31dqbjhplbxPxgyF0R8O8AKaNtcebKidWrYkX8MAenoWuDDRght7U4KeZCs/hIh91QnDJeglqRsHtm6iWdj0OtG7DsPVPtKh3+WpBUlAQ52jg1Vt9RpbabfvgA==
X-YMail-OSG: w4_T9IsVM1lo0vQsGUg7FNdeFw5ptn1Qeu6cH7ya3W8UEYwEOoKNJahzvoMGyB0
 8lWOcyitwXfVtWxxUJ.iVVFseVkDPr5C3ylbJOt22qoiq51vVRuZ.VBkPJ825jX2tKLbeKrpwr4w
 OEXHitYaDjDbw8ojfyKU7tMdLCyRJttKnUIzHg._UUxf4rEmMBw7VMU12ULENjxjwk9bWU2NxwMZ
 iHAf.2q1ACgNUyt21jHhKSoG2TtMzVtwu787nhqCimwn7ahVV3cgoEkMX2YsYBcjF_B4rCQypS5b
 _.TcTtxZsOe_aIpXj0bwKUDEL_DWCqYoH8qq9yvpUHfG0NlVsb_oGJavmld4ZKr9WEyIwEmLysUC
 ba3B5BlQ0IJoEezLHKUF__w2OZPceAY_3Qt_YxdcbPG2T.N1ELHQc7BjLIXfUP486Wo0qs3YKeJJ
 Wcdq1PjpG2Or7r7BjWt9qV5bNNA3zuc22VBI4GamHca4w4xYC5Is2GaKozF4DtR.vZ.TIeyAONZS
 ANPBZ1em9frMAPKsc_VZPSrt2moMo1nSmuIvHyY4tx6DV_BvGM48SgZlBlTKtqPqRtQlCDpgHU0i
 dVSOnrwbfsWSVsEAlo78IN.kFf6R0zUb4AJV0rdKUEAsx_YJ0EAD_guveRQRXt3GNOKfJazH9Xvj
 MxcLlULwxnyMNFGLB9c2ng0TFdlSjXPQMvSlWFu0QkJAk0LDo_lGk.T8YDlDgcND2CzjAMi_veic
 kI7v..i16mlZRSUUXtvirjG0WWfYGi4YOgau8_JVgn4190MvMPZsuizj.5Rzt8nF5Gz3RankfhLw
 CFRt2OfhWV_hPin_i61e2I2sqT_XV0ccXdrILiSXsHtrRFJDUxgzl4yYMQQ5M_tY_4XoNEUMqwGL
 .smJwblb0jS8_roHfpGKHoEaknKGbC5bTEOdPARxtiYXkOD2Y5VJ6ZxGRn2ZUSq04jYRIHgeokm2
 N9sVxcA3mxYikjM9abMFjhIzhgDbAyWRGm.qUJf1bAI77j7jfBq0_KmLDYRhSTigeXnmMMVyVRLJ
 PJDgCpncfZAqZPXuF4mcstrOqreSRrF5m9PMVV8nWKBNfxvzXLpfoJFNAnXdTYg7cnTgxEjwsA_n
 xejld8ew6uPeMuvCXfwWDJOjxPAeMdEalfJ7S1Ap517il0IOlKFWrecBoYQN5DFeW_RN8bAp2P1u
 pI6v1JXHI9k06ENIoacHJaYNIdzJ1LiFX_B0StR5J9IQwBBePSA4xe5dmDp2.Yd4mW9Ee05QaVOM
 73e4LMP1WFU0q7necIA6McW.yNHHDthFLOqwTxGY5NefiZ8Sw.sUJp52afK1ag3jf.Q8z2pBeNcz
 5g5xWSDuMUXTmWJN.trN7ye.qH.3UGWkAqpC.Of1osKsahw1DllVic5hQU6_U53Ed9U8mKBGzaG_
 VCyOasdlUS8waacSg7xRk4rtTPcyqcZZ1MEu9mjZ_r64a52PQQ1aalDZ6J8a.J4kCi01qBgTc38D
 .qIaXJM9WktiNlnw__D9cUdKTa5H_jcn1KPv8Ub_YD917rQpps7yHEJvQBMfaEoMRARkZ7NG6E8k
 6fgYoImQS3VGT8iWgASOkphfWp81mBRys62GwOslWkyDaTxbI3cUPUyHModP7V6jpKrdUA9er5Su
 Aqnt8S6hGwryGMNEQMtElPOsjog.1sHtlmPi3vrMa.2NyhB20gDPwjTxCKqhNUQx9ZTmDTuffnFt
 XGuegsoOq3Al77K33IYNJRXQs0g3wLSIhRffeARRAW0iOob2wo1hkDlC4ORlUW2cApXcGSDjfkDp
 77f6ApVOvn_q0olMcKEGzw2lP0X0yv00Vf.nU45o1qJgyU9kvh510VqUxom03Ps_s.bT_Pr3LCgF
 uaPPYyJfLXHRJ9owl54T765tmnH1EmG35wJrAqn.Bp.gtsL_n.kp6uAwmJQY4Y6NP6Qoq5yjSNJY
 uN102BT4F2X707qSSydOlnct3lfvb4JlprFTwBfag6heAWPX2eMfTCxinYqRjUPNrN2TJX8DjazZ
 GIQ33l1wt.SeEOo.GEB1R3lcfv212bfyx.f_6PItk_PYKqSkeSCcCDgq8bHrd0vcyOd0h5DYZLNP
 u0DrGg28CG5HVTdtOOlQ3PwXNFzKf92ioV7KYywf3w0KFlLyQ_KpUjfprO63_soQi3RnI7SvCCHq
 8g6MB9jKsnSY8ea4p5gLkhjUDOdACMDRrJQt1UjfAU03P79VOB58H.h1itnIMSCXIGSUtf6L4efL
 eSkpgQR_YkfchtaSbAzsvFz3_6E8tlk9kms3k5xlicR73onbOEBHgRSr0aDqakKq6V0Ilvw3fxTG
 BZC.d1s5vd5pHoxlOQfQoYxBo282EeeytlzgD37siWYry.IgGdCjqlk4a2Nb6O6CSK06d7KG1pOj
 xNKWIvmk1Gh3ICNEkT6F8o0BTz1m0UHqX9R03_jVQWxA5mM8P4SySye6z9tP4lH2M6KYOeg2Huyj
 5fE1v_UnNE9ncTpEVK8_XttWxinoTQAk703aZcHCYTYjcQNc40mHILrqBe0O38nt58Wtfj.W2N1I
 gOh1lTm62P3MafcsZwhc2qQANTfew1d78rxI.12lvGWUjSawzsGHTC9UL4bUSGzf_yZNXlLuh0Z0
 NjfRNINbJCQFaP5m9rxtP9IsD0jYgmQzWDbO9QS1oqPiV6dxX_vh7R3a3cBAJ6ucMvA.BGSpAHiC
 LozmVd1noItGTAax8HHXjOoEBVpIfi_6L3jUZe7gp0o0ycM9O4L7LiuyYePPLKIYu5wXq82bBQe0
 UoxgVXK2wxQa_mYvIPKifSZWwoQJfAlQXHRyn2geJ0jeabI59l93vMHdNcH17PrBzREqxbLFM_bf
 _wH_ifcfiYsR2.rdXW5ftwRZLmk574KwkTKWcecthxiOyXIpYMrTy9wmvB69OOAdvICxyBZzPIfY
 DiKgdY3wnNnrh.zCH6a18zi0jBSmjPszZfjCUlXpKpeWMzOCTUTuX3LzdsAWH65gFGMp1wUEIv63
 4SWd4eEHVkLTou1reciNJGTs9WKGuNvwG44FzRjptJTYwj_aoYroUKeutjpf3zow8tnoRb6N7bt8
 8fAOcJG7ulzv5tfsDVrizfg_hBYyOnS1kYKyZS19cPFepFSPEgS.3vvpB
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 21 Apr 2021 22:43:55 +0000
Received: by kubenode512.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 8d5fac0008ab4c1e871a17521cafc02e;
          Wed, 21 Apr 2021 22:43:49 +0000 (UTC)
Subject: Re: [PATCH v2 3/6] security: Pass xattrs allocated by LSMs to the
 inode_init_security hook
To:     Roberto Sassu <roberto.sassu@huawei.com>, zohar@linux.ibm.com,
        jmorris@namei.org, paul@paul-moore.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        reiserfs-devel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210421161925.968825-1-roberto.sassu@huawei.com>
 <20210421161925.968825-4-roberto.sassu@huawei.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <0caf1e58-1e2d-c781-3f71-18aaf55cada2@schaufler-ca.com>
Date:   Wed, 21 Apr 2021 15:43:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210421161925.968825-4-roberto.sassu@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18121 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/16)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 4/21/2021 9:19 AM, Roberto Sassu wrote:
> In preparation for moving EVM to the LSM infrastructure, this patch
> replaces the name, value, len triple with the xattr array pointer provi=
ded
> by security_inode_init_security(). LSMs are expected to call the new
> function lsm_find_xattr_slot() to find the first unused slot of the arr=
ay
> where the xattr should be written.
>
> This patch modifies also SELinux and Smack to search for an unused slot=
, to
> have a consistent behavior across LSMs (the unmodified version would
> overwrite the xattr set by the first LSM in the chain). It is also
> desirable to have the modification in those LSMs, as they are likely us=
ed
> as a reference for the development of new LSMs.

This looks better than V1. One safety comment below.

>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/lsm_hook_defs.h |  4 ++--
>  include/linux/lsm_hooks.h     | 18 +++++++++++++++---
>  security/security.c           | 13 +++++++------
>  security/selinux/hooks.c      | 13 ++++++-------
>  security/smack/smack_lsm.c    | 20 +++++++++-----------
>  5 files changed, 39 insertions(+), 29 deletions(-)
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_def=
s.h
> index 477a597db013..afb9dd122f60 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -111,8 +111,8 @@ LSM_HOOK(int, 0, path_notify, const struct path *pa=
th, u64 mask,
>  LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
>  LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)=

>  LSM_HOOK(int, 0, inode_init_security, struct inode *inode,
> -	 struct inode *dir, const struct qstr *qstr, const char **name,
> -	 void **value, size_t *len)
> +	 struct inode *dir, const struct qstr *qstr, struct xattr *xattrs,
> +	 void *fs_data)
>  LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
>  	 const struct qstr *name, const struct inode *context_inode)
>  LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentr=
y,
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index c5498f5174ce..e8c9bac29b9d 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -27,6 +27,7 @@
> =20
>  #include <linux/security.h>
>  #include <linux/init.h>
> +#include <linux/xattr.h>
>  #include <linux/rculist.h>
> =20
>  /**
> @@ -227,9 +228,11 @@
>   *	@inode contains the inode structure of the newly created inode.
>   *	@dir contains the inode structure of the parent directory.
>   *	@qstr contains the last path component of the new object
> - *	@name will be set to the allocated name suffix (e.g. selinux).
> - *	@value will be set to the allocated attribute value.
> - *	@len will be set to the length of the value.
> + *	@xattrs contains the full array of xattrs allocated by LSMs where
> + *	->name will be set to the allocated name suffix (e.g. selinux).
> + *	->value will be set to the allocated attribute value.
> + *	->len will be set to the length of the value.
> + *	@fs_data contains filesystem-specific data.
>   *	Returns 0 if @name and @value have been successfully set,
>   *	-EOPNOTSUPP if no security attribute is needed, or
>   *	-ENOMEM on memory allocation failure.
> @@ -1661,4 +1664,13 @@ static inline void security_delete_hooks(struct =
security_hook_list *hooks,
> =20
>  extern int lsm_inode_alloc(struct inode *inode);
> =20

Some "security researcher" with a fuzz tester is going to manage to dump =
junk
into the slots and ruin your week. I suggest a simple change to make boun=
ds checking
possible. It should never happen, but if that was sufficient people would=20
love C
string processing better.

> +static inline struct xattr *lsm_find_xattr_slot(struct xattr *xattrs)

+static inline struct xattr *lsm_find_xattr_slot(struct xattr *xattrs, in=
t available)

> +{
> +	struct xattr *slot;
> +
> +	for (slot =3D xattrs; slot && slot->name !=3D NULL; slot++)

+	for (slot =3D xattrs; slot && slot->name !=3D NULL; slot++)
 		if (WARN_ON(slot > xattrs[available]))
			return NULL;=20

> +		;
> +
> +	return slot;
> +}
>  #endif /* ! __LINUX_LSM_HOOKS_H */
> diff --git a/security/security.c b/security/security.c
> index 7f14e59c4f8e..2c1fe1496069 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1037,18 +1037,16 @@ int security_inode_init_security(struct inode *=
inode, struct inode *dir,
> =20
>  	if (!initxattrs)
>  		return call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
> -				     dir, qstr, NULL, NULL, NULL);
> +				     dir, qstr, NULL, fs_data);
>  	memset(new_xattrs, 0, sizeof(new_xattrs));
>  	lsm_xattr =3D new_xattrs;
>  	ret =3D call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, q=
str,
> -						&lsm_xattr->name,
> -						&lsm_xattr->value,
> -						&lsm_xattr->value_len);
> +			    lsm_xattr, fs_data);
>  	if (ret)
>  		goto out;
> =20
>  	evm_xattr =3D lsm_xattr + 1;
> -	ret =3D evm_inode_init_security(inode, lsm_xattr, evm_xattr);
> +	ret =3D evm_inode_init_security(inode, new_xattrs, evm_xattr);
>  	if (ret)
>  		goto out;
>  	ret =3D initxattrs(inode, new_xattrs, fs_data);
> @@ -1071,10 +1069,13 @@ int security_old_inode_init_security(struct ino=
de *inode, struct inode *dir,
>  				     const struct qstr *qstr, const char **name,
>  				     void **value, size_t *len)
>  {
> +	struct xattr xattr =3D { .name =3D NULL, .value =3D NULL, .value_len =
=3D 0 };
> +	struct xattr *lsm_xattr =3D (name && value && len) ? &xattr : NULL;
> +
>  	if (unlikely(IS_PRIVATE(inode)))
>  		return -EOPNOTSUPP;
>  	return call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir,
> -			     qstr, name, value, len);
> +			     qstr, lsm_xattr, NULL);
>  }
>  EXPORT_SYMBOL(security_old_inode_init_security);
> =20
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index ddd097790d47..806827eb132a 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2916,11 +2916,11 @@ static int selinux_dentry_create_files_as(struc=
t dentry *dentry, int mode,
> =20
>  static int selinux_inode_init_security(struct inode *inode, struct ino=
de *dir,
>  				       const struct qstr *qstr,
> -				       const char **name,
> -				       void **value, size_t *len)
> +				       struct xattr *xattrs, void *fs_data)
>  {
>  	const struct task_security_struct *tsec =3D selinux_cred(current_cred=
());
>  	struct superblock_security_struct *sbsec;
> +	struct xattr *xattr =3D lsm_find_xattr_slot(xattrs);
>  	u32 newsid, clen;
>  	int rc;
>  	char *context;
> @@ -2947,16 +2947,15 @@ static int selinux_inode_init_security(struct i=
node *inode, struct inode *dir,
>  	    !(sbsec->flags & SBLABEL_MNT))
>  		return -EOPNOTSUPP;
> =20
> -	if (name)
> -		*name =3D XATTR_SELINUX_SUFFIX;
> +	if (xattr) {
> +		xattr->name =3D XATTR_SELINUX_SUFFIX;
> =20
> -	if (value && len) {
>  		rc =3D security_sid_to_context_force(&selinux_state, newsid,
>  						   &context, &clen);
>  		if (rc)
>  			return rc;
> -		*value =3D context;
> -		*len =3D clen;
> +		xattr->value =3D context;
> +		xattr->value_len =3D clen;
>  	}
> =20
>  	return 0;
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 12a45e61c1a5..af7eee0fee52 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -962,26 +962,24 @@ static int smack_inode_alloc_security(struct inod=
e *inode)
>   * @inode: the newly created inode
>   * @dir: containing directory object
>   * @qstr: unused
> - * @name: where to put the attribute name
> - * @value: where to put the attribute value
> - * @len: where to put the length of the attribute
> + * @xattrs: where to put the attribute
>   *
>   * Returns 0 if it all works out, -ENOMEM if there's no memory
>   */
>  static int smack_inode_init_security(struct inode *inode, struct inode=20
*dir,
> -				     const struct qstr *qstr, const char **name,
> -				     void **value, size_t *len)
> +				     const struct qstr *qstr,
> +				     struct xattr *xattrs, void *fs_data)
>  {
>  	struct inode_smack *issp =3D smack_inode(inode);
>  	struct smack_known *skp =3D smk_of_current();
>  	struct smack_known *isp =3D smk_of_inode(inode);
>  	struct smack_known *dsp =3D smk_of_inode(dir);
> +	struct xattr *xattr =3D lsm_find_xattr_slot(xattrs);
>  	int may;
> =20
> -	if (name)
> -		*name =3D XATTR_SMACK_SUFFIX;
> +	if (xattr) {
> +		xattr->name =3D XATTR_SMACK_SUFFIX;
> =20
> -	if (value && len) {
>  		rcu_read_lock();
>  		may =3D smk_access_entry(skp->smk_known, dsp->smk_known,
>  				       &skp->smk_rules);
> @@ -999,11 +997,11 @@ static int smack_inode_init_security(struct inode=20
*inode, struct inode *dir,
>  			issp->smk_flags |=3D SMK_INODE_CHANGED;
>  		}
> =20
> -		*value =3D kstrdup(isp->smk_known, GFP_NOFS);
> -		if (*value =3D=3D NULL)
> +		xattr->value =3D kstrdup(isp->smk_known, GFP_NOFS);
> +		if (xattr->value =3D=3D NULL)
>  			return -ENOMEM;
> =20
> -		*len =3D strlen(isp->smk_known);
> +		xattr->value_len =3D strlen(isp->smk_known);
>  	}
> =20
>  	return 0;

