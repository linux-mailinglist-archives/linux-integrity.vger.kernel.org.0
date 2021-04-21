Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7629A367590
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Apr 2021 01:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343661AbhDUXK2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Apr 2021 19:10:28 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:44146
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234826AbhDUXK1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Apr 2021 19:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1619046594; bh=J26x1w023ecUL/6MxhVFKfp+hf3nFHwJodfkAA19G0w=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=YTJ9PAE/K0UMwdsKfarpJNRp2LIrpfxSra5knvIk0Y6uUvjmJToV55tQOERp5C1fUEw5Qa4nK4IR0U2JFwqFMRwhgJrr+gWMaD2P1jM82tItJiz5BoaS2Cj+8MkMX1zLiQibgXenOa+4j9/YU/Cl8wNMpiXsxqLrrP+2AScjvNXgzu/H3nMVmP6X1oWkIqD67rHQXsLIrZSUQ+6RXQv8zSlFmqUXiNLLkJSEL/R+CTtTZwPRPpQauP2Ix6REBkm4nrzF8/X7aTgJHJBc32XL6EZ7f0/u0kksASm2fb9YC906qFS43Tt6CiLlP65F/yCSAk17sGaPGENnZ1ZU9pVQKg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1619046594; bh=dy4g19nJy8tRXIFC1dOJdAPjB4HnQ3cd1ymhu/c4h3N=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=aU6aW73BO7HKSa50BO34Hz5vAbtR3QMqDVdHnqw0xq20aku2wyJ07gwLIRYfq0s8FsKOM+QT96G8s0fN08kucpma5FEk0+Yqd3/b1hRgh58oZwK1VAt3SlNVenL5q82xrh8ZTs36bgjIBzTP9dGxEJeT+BZr0geS8bTkIY9JkRXSIoMopoX2HhmFTpuF7vhVIhzdKXJPW0ywmUkvVu6ixXn8egI3sk30/hsxt0fQQ9epjNEX67IwpjQOulKyfzpNgLrRxX93oD0GUZf0dbxzxuXK1sE8NhcJaKI8hb0cu5thaGheZvCrwf+tLPav8DaHZrnFIWhkwLDs7fOYGRYDPg==
X-YMail-OSG: p3RZ69cVM1n88lcPqyFCaYMHahk2R4YbMbx4kxTKY8IqYnupybXy86jWAJ4YZfS
 Z1JiYLave0Txk14KBCWcsfis_S5J8U0.oymh.VC9DzySxn4xs2ZMZgafnUVgH6SxrkzFM7HsUCdv
 UDeB1uzMz28aTgrmh4zdZp0kkPME1gjPG.y9RW258no4TLKGaSrw13dRXUzajoSCjw0wP4gWrs_C
 QDKuWv9BzZS3V_5R1EmwD4ghCdHn0T4n7EvGnj5i7LlhLZGw3NnjgzZjK5.fH6jBHnKSG7bVzNJP
 aT.qGusRJCGbOm8rgySx36l3NCGGsws2su1nQxFkqToba0jEqVzoDh3u9u.q5M3NAnY9c.SIH8sk
 7AgwIQRd0K21HS6doJQAmgiEJx0q5rgUtcyF5K0.XkCsY74oesvow7VbXmle7wlHKNNcfUZh7onS
 9TObajLQ2DIkdJrq5to_08pxX4s978JgjORJmxwsqKgDE7CRvEtzaqKZkIlYjHzSydW8MORsd8rK
 LH0aAv6cutQnCykHIy1vLIcArcsnutA6Rzgld5JiqjgrQfqLJXyoPS8.lHnKDiTNovpKaNBLXPvX
 mV2A_Rtu8sFXVEgjNewnYm5WeyRa8bIKglI4k2wA2qQgHhEA5keGydnSI9gIHaekalBshxmRJwCn
 b6m8pjmb9DNjw_wDgt4W3YdL0NKEsa44wRZBYbqf_7QaF7n1Nezg9W4Ybslk7nlQqr._0Ib4Iz.z
 pF.WFNUFiwFM8WjS1Xr4e0kyLkR_WThRibvrDSlxUbqgEuvhKlFGllmxexwG9WuCZ.IDBDKSYvEf
 TKn_4KpKrvG4c.atN3JoGPBZHmHDFxcO0S3SdXWq1ck1CeIrYM1cqw1z01EOl_sKjgQvgH2cjB5o
 x_3xdGkxvNKi4yDwEK2ZxmrWkUaPj07y4qzz0..LgcqWonvbuOJvRb_aAFbljkj.ESQtX5bYn6kb
 F528q4nBi9.RHTqo2GdR6BxPGmFe0pvRhehiTbMt1.zP0sUhYdfjlPw5wrPQcBX_ZUWbZeqzMsjG
 pVjHLf0ej_V3xoR0yV21xUXeEJm0IIrt8kuZUc32s849xxew7pU4kcOLNTmlv8FTRL4Qx33rEjBi
 vxefl_B70b4TDPYyoHI8OaJ3zWTdbm88iuG2hwI8RA9WTe3RNmvXWQRrjNi.XywmRuTPEypEYyN7
 s7dw8P6berUTdlqOvVb.70xLRXxyNe_xWI7h.O3ARy1XZRvSW5kSLD.u1lrNgUqfAXW.hh8ikpkm
 dY.YU.Y2ccEhf3dZxb2d0MaRGgoVF9YYQDLi.HRQhOWV5ju1_VkUgCuLvUTWw380ZV_6qNcnYcTM
 9bIaPMrXtyuDhUVsJ0xkwbn9ab_4U3o7tG_xmZcCS5q_wlPtNM7VRIj4lPnyKHQd1Tsp8LlhddAz
 QK2c4VBLfMmnAT9Xf0DHnfUA9rGdPObJZ2U5KOX7u7pHIMGFguqfs2wYillDAq0z70qKDzvE6Zf3
 2.75xV9WFsY75xM3t0vIMO9O8TrgAzfgN_vUzj0FH7gj80iCwkdta4ZM28bUOhPGiGc9kFOEBI7e
 4VGpMlGhimiktVhPjVC8b5Y4RR8AiSPlwEzbRScTrR_taDrkqb7D1.nJbFyRyZp2LHCsfrfoO0xf
 N3nLp_PBBSlsXjIyYeqKCfIS_JioRodskz6uo9CVTxTMz7Fg5AW4OoAliQD4DHN1NwJPeW.I_F.s
 mfHLZi3ir8SfqDRrpqFSk4ZnmkaUPhq4VV22OFPRuXvd0jNMqeSmVBJ7FhMReMdqj.cblygheq8o
 CqU_RLWBPc3OlMbtPeUIiaJq8PC38aOLNAx6AtYRmCJpG6yZCEAvfsMIjaXU_XmTjlOaCsk5HvLl
 L89_9blE1QV8KVq6YqvOSuF797emDliaYNtW_IbAPu.JxCzibZ6htCyccJLtqMNE1sDljaaFcw9R
 0VFUoSML0arFrKT6gl8JPBwtkAQpUfW4HZf5jrAa4tNyXeDoxMz2RGmiefaV8teu04sNjSaGEISB
 CSC_oIxfy4AO3nqxUaY67yQsNioJ9La3Aj9qVcNt9ZAT4opZABEKmeoFf9G9aLzYCa9uR_bUCzgj
 2YrusVVbjvLU07kijHXhqTse4URNw9O2iC9wa0oUYKpvhiujSqqjh8RN0ZRfnSqVvpku8YbApE0G
 sF2Eb_RehTLLxWo_VCUJDBINvG69YZMTaVCm.uxx.yF6_OFm6NuaBQECGfI7zEnG6Vp9cI1aauG8
 R.dxR4_J6fNSE28VmJh5EwsZnRyMuJNMvRFdlkzBmcwAXVNhNo4xfoISOpsewbNp8VWUP4r1b5iU
 mTG8pytkIbATS8cW6s17TfbgE23mSd1li7afDG_0nE1qbrBlnUhQceuPpioGs0VLZ0fQeKsmChJg
 koVe3pgdl1.DtPCp.PgZFSDt4nzqYIY0JrH0nN1q_B.XMwd7pnC5WEcfzYW.Njk2ryaSXP9USRVq
 ggEJs15aL_7WpAugwyZRWtN075VtotUO57dVXJtMPQlikm1VHD5jbCKQ8roa3HIylLqWlM6iGV05
 rWVsMFs50Fg5S1zhv4MEEGEPDT4etM4YmefbUBU7ARHQvCK5z0qQ3yUGeSriSQ9R9tLDrQNmAKDs
 aQQoIk2Yrs0nCmU8tPYoPoTeQ.RH4GBE0QL5LsFUE1xtl7XwaSQZcVrH4msuE9KY0nDPGQ7pJrRz
 OhOBVqYGoKIqcPdBGegmWX_yx45Z_uupsLgDFwMr0jhOG0Xj.rlRfhh8UB.mGYrelyj8AM.bx00l
 amogdA5r4ut.e77_ZwEYur_8BN1zIOxzMuWQjTQiydaz5G6BPwdD5gBIjDA.gRl9HQVUfgJ0lbiR
 n45yHUERgeCufhUmhoOc1cjzdQfVOBpX5p5fxAuRXZbzQ6BFDvbVsIhpiM4sG0frDST1pOfZ9Fkq
 j1JVAK_Pqax3XXwXI5KFgxTYMxMOMqPfWiGF8MrGbhS426kJVY93EfEpZf4tfqtX.fRGCSk0Q7PA
 zigUFFfgiYH5h7WoYILBBPukA_8YBv4RsF0TBpECBUgiY9Hq0lVYr7_Y_QP_UfwftDJmVpKKWQAy
 d6TXPPJIcRQo5ZyvAulkon.gIe1OdzKcHak.W7PkqNyKOSpKhSA_BIF9o_ElcvGwFXmmRH1Q-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 21 Apr 2021 23:09:54 +0000
Received: by kubenode542.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID b3571271959590a36da338570ed6e49f;
          Wed, 21 Apr 2021 23:09:51 +0000 (UTC)
Subject: Re: [PATCH v2 4/6] security: Support multiple LSMs implementing the
 inode_init_security hook
To:     Roberto Sassu <roberto.sassu@huawei.com>, zohar@linux.ibm.com,
        jmorris@namei.org, paul@paul-moore.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        reiserfs-devel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210421161925.968825-1-roberto.sassu@huawei.com>
 <20210421161925.968825-5-roberto.sassu@huawei.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <e888aa66-25d3-f72c-1aa9-cd5bc6df3789@schaufler-ca.com>
Date:   Wed, 21 Apr 2021 16:09:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210421161925.968825-5-roberto.sassu@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18121 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/16)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 4/21/2021 9:19 AM, Roberto Sassu wrote:
> The current implementation of security_inode_init_security() is capable=20
of
> handling only one LSM providing an xattr to be set at inode creation. T=
hat
> xattr is then passed to EVM to calculate the HMAC.
>
> To support multiple LSMs, each providing an xattr, this patch makes the=

> following modifications:
>
> security_inode_init_security():
> - dynamically allocates new_xattrs, based on the number of
>   inode_init_security hooks registered by LSMs;
> - replaces the call_int_hook() macro with its definition, to correctly
>   handle the case of an LSM returning -EOPNOTSUPP (the loop should not =
be
>   stopped).
>
> security_old_inode_init_security():
> - replaces the call_int_hook() macro with its definition, to stop the l=
oop
>   at the first LSM providing an xattr, to avoid a memory leak (due to
>   overwriting the *value pointer).
>
> The modifications necessary for EVM to calculate the HMAC on all xattrs=

> will be done in a separate patch.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/security.c | 93 +++++++++++++++++++++++++++++++++++++++------=

>  1 file changed, 82 insertions(+), 11 deletions(-)
>
> diff --git a/security/security.c b/security/security.c
> index 2c1fe1496069..2ab67fa4422e 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -30,8 +30,6 @@
>  #include <linux/msg.h>
>  #include <net/flow.h>
> =20
> -#define MAX_LSM_EVM_XATTR	2
> -
>  /* How many LSMs were built into the kernel? */
>  #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
> =20
> @@ -1028,9 +1026,10 @@ int security_inode_init_security(struct inode *i=
node, struct inode *dir,
>  				 const struct qstr *qstr,
>  				 const initxattrs initxattrs, void *fs_data)
>  {
> -	struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
> +	struct xattr *new_xattrs;
>  	struct xattr *lsm_xattr, *evm_xattr, *xattr;
> -	int ret;
> +	struct security_hook_list *P;
> +	int ret, max_new_xattrs =3D 0;
> =20
>  	if (unlikely(IS_PRIVATE(inode)))
>  		return 0;
> @@ -1038,14 +1037,52 @@ int security_inode_init_security(struct inode *=
inode, struct inode *dir,
>  	if (!initxattrs)
>  		return call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
>  				     dir, qstr, NULL, fs_data);
> -	memset(new_xattrs, 0, sizeof(new_xattrs));
> +
> +	/* Determine at run-time the max number of xattr structs to allocate.=20
*/
> +	hlist_for_each_entry(P, &security_hook_heads.inode_init_security, lis=
t)
> +		max_new_xattrs++;

Don't do this here! You can count the number of modules providing inode_i=
nit_security
hooks when the modules register and save the value for use here. It's not=20
going to
change.

> +
> +	if (!max_new_xattrs)
> +		return 0;
> +
> +	/* Allocate +1 for EVM and +1 as terminator. */
> +	new_xattrs =3D kcalloc(max_new_xattrs + 2, sizeof(*new_xattrs), GFP_N=
OFS);
> +	if (!new_xattrs)
> +		return -ENOMEM;
> +
>  	lsm_xattr =3D new_xattrs;
> -	ret =3D call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, q=
str,
> -			    lsm_xattr, fs_data);
> -	if (ret)
> +	hlist_for_each_entry(P, &security_hook_heads.inode_init_security,
> +			     list) {
> +		ret =3D P->hook.inode_init_security(inode, dir, qstr, new_xattrs,
> +						  fs_data);
> +		if (ret) {
> +			if (ret !=3D -EOPNOTSUPP)
> +				goto out;
> +
> +			continue;
> +		}
> +
> +		/* LSM implementation error. */
> +		if (lsm_xattr->name =3D=3D NULL || lsm_xattr->value =3D=3D NULL) {
> +			WARN_ONCE(
> +				"LSM %s: ret =3D 0 but xattr name/value =3D NULL\n",
> +				P->lsm);
> +			ret =3D -ENOENT;
> +			goto out;
> +		}
> +
> +		lsm_xattr++;
> +
> +		if (!--max_new_xattrs)
> +			break;
> +	}
> +
> +	if (!new_xattrs->name) {
> +		ret =3D -EOPNOTSUPP;
>  		goto out;
> +	}
> =20
> -	evm_xattr =3D lsm_xattr + 1;
> +	evm_xattr =3D lsm_xattr;
>  	ret =3D evm_inode_init_security(inode, new_xattrs, evm_xattr);

 +	ret =3D evm_inode_init_security(inode, new_xattrs, lsm_xattr);

then you don't need evm_xattr at all.

>  	if (ret)
>  		goto out;
> @@ -1053,6 +1090,7 @@ int security_inode_init_security(struct inode *in=
ode, struct inode *dir,
>  out:
>  	for (xattr =3D new_xattrs; xattr->value !=3D NULL; xattr++)
>  		kfree(xattr->value);
> +	kfree(new_xattrs);
>  	return (ret =3D=3D -EOPNOTSUPP) ? 0 : ret;
>  }
>  EXPORT_SYMBOL(security_inode_init_security);
> @@ -1071,11 +1109,44 @@ int security_old_inode_init_security(struct ino=
de *inode, struct inode *dir,
>  {
>  	struct xattr xattr =3D { .name =3D NULL, .value =3D NULL, .value_len =
=3D 0 };
>  	struct xattr *lsm_xattr =3D (name && value && len) ? &xattr : NULL;
> +	struct security_hook_list *P;
> +	int ret;
> =20
>  	if (unlikely(IS_PRIVATE(inode)))
>  		return -EOPNOTSUPP;
> -	return call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir,
> -			     qstr, lsm_xattr, NULL);
> +
> +	hlist_for_each_entry(P, &security_hook_heads.inode_init_security,
> +			     list) {
> +		ret =3D P->hook.inode_init_security(inode, dir, qstr, lsm_xattr,
> +						  NULL);
> +		if (ret) {
> +			if (ret !=3D -EOPNOTSUPP)
> +				return ret;
> +
> +			continue;
> +		}
> +
> +		if (!lsm_xattr)
> +			continue;
> +
> +		/* LSM implementation error. */
> +		if (lsm_xattr->name =3D=3D NULL || lsm_xattr->value =3D=3D NULL) {
> +			WARN_ONCE(
> +				"LSM %s: ret =3D 0 but xattr name/value =3D NULL\n",
> +				P->lsm);
> +
> +			/* Callers should do the cleanup. */
> +			return -ENOENT;
> +		}
> +
> +		*name =3D lsm_xattr->name;
> +		*value =3D lsm_xattr->value;
> +		*len =3D lsm_xattr->value_len;
> +
> +		return ret;
> +	}
> +
> +	return -EOPNOTSUPP;
>  }
>  EXPORT_SYMBOL(security_old_inode_init_security);
> =20

