Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB6136041
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Jun 2019 17:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfFEPXb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Jun 2019 11:23:31 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com ([66.163.186.211]:38901
        "EHLO sonic310-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728201AbfFEPXb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Jun 2019 11:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559748208; bh=4Gdinb0Atsndn+SDF1AN/4WxqQEuw6Bqs6vIZ1Ab45Q=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=aJnnkVXmQ6gvSj1zMRELwJSCLYUco2wWQjxJ6Q4jcQtBuhkP2UA3+HrIA7EaQvuKbKbD2HF7gcTiUl5wMN1uBwYwPdk++gIme7+HlIxfxLSwdSy5O6VlMU6+AYC7OTGqtvJMut0M9ncbhsVdbPhvfTzQ669PVz8qxVqqYPkzU/1zQjIYTDU796P+kBpJJGrlNZcieWRT+i4kzrDy5/yYXiAn0irTK9jv/jbu9XTLmD391/7oQYOSjiZWWDL1LiRwZ9lg1CNPJxBTmnAZkHryqiro4VFQRTizHebGo4PdIdD7Rw1PSu8i1dfDPN35gQTyEa6SzlzjbNBdWy2EBpho8w==
X-YMail-OSG: .WQVOLIVM1npwrCDDc4ibEmiLeKmYsIiQ.KphcYDBehcPlmE0MUDMA5lNES0uEo
 8u425uZIIZAukfnqB6OLpvGPXR2c7pDlqmFvXT8jYPLMHx3BRRznnmp_Y2mYIVaI2ONWOf5Hk2vO
 XdLBeTdVKiYb.ciXXc0dM0vWEe7mFa1Njoc3ClUV6YyBhek_bHlN2A_tDoZ3.4aA6n8ZhSWDOnMD
 u.GHhurikatAuUiail5AyIjlb4AIZhM9T5CpGYAHzdseoiepINA5dawnRfQy7eVDtXUkVO33lsSJ
 q4AKSXRRMDk4Cy1nTTyIGCd7Zjak74tnWFN.xaJvEMN8C5uFYTyrNZniX.fovYnMEEB_493ikqjJ
 .BgkgAOvKOFPmWiQqqkBiq0dF8cl_3dFhuAiq4nTwm0i1bcnjSNUyHSnNn5T6lz_ejwDA7Wg8HVJ
 QmrQeKKKevPEMpp_dCgCdwOoV246mqRzbsoxpBk1kPuHtlOeco2Wmr3afyc3IeUX4UGNSg5y6squ
 UzpnXYGxCy0OhPeuu1L6gYOXnQ3vGUERKz6uAZK30DzNqPKpqY8.HEEYiXKB5jXUYKkQDS5E7HRq
 Iw1YdbLEez6CetDAV0JGbOQJaixscbUCqTmVJzGBBR0481mZzSYRfIJLI0T3E4tbgukR7CibY.lw
 bUxHA45MzaSTnIw5uwBhEeVaFX6ESOAENDi88GTZuUO8nJegNzaLdQOelfESaKTpNNF3lTV74E5L
 rfI6DgUB_6VuJaCoDcUGAKniB3sMhsigvFZ9FKas2mNF.XEuZMLanwgOtzjXZh8G9gmwV5KTMeas
 ZVd6fG7CznLDgxo8wDlnbQhQHoFd45YdyTiExwN60JtG7.3TpdK0q5KE7QmO2GBj5z.gQx1TMIk_
 2ojDHLIcTK9Pa79eGZQk9dFj24zoEDbUgDH8sZODZC.EoLaujsNU_S2jiHshjZFGkyrti2MNk7iF
 BeMyUsqyHL.MaLdcqsnPPwqJ1IPa9IB6IjVNPGvIibgKMCkl8pMTi2q3o.U48hOIqMQm0qDd0h.R
 1PdQNK.1VHJmTcFKsZpYPThDYm.5gL3mo.7KEiBEvL.ZiHL.zxtx0P4J7E297x2mhKcVh1nBLswO
 7EI3_bjt7csmYq1awrIREKJSgiR0OoMVVEU796yxUvIKB7pX9vu2l.XEm2iCUAvSMrNXZ0q9wFV.
 tJLpUoelH_Tjin4GgLrSEVlaao79U2BgHG4nv5hQStKSGGJy_Vo6w4.dPVRDOV_vr4yKRmUjuN2R
 qOYL.qUd8CAIFbYl41NRQ9mskuAK2bx9jwuWoyIu_sQWB5g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 5 Jun 2019 15:23:28 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp420.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3350276471c3f3447bbdde04b2dc7c1a;
          Wed, 05 Jun 2019 15:23:27 +0000 (UTC)
Subject: Re: [PATCH 1/2] LSM: switch to blocking policy update notifiers
To:     Janne Karhunen <janne.karhunen@gmail.com>, sds@tycho.nsa.gov,
        zohar@linux.ibm.com, paul@paul-moore.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20190605083606.4209-1-janne.karhunen@gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 mQINBFzV9HABEAC/mmv3jeJyF7lR7QhILYg1+PeBLIMZv7KCzBSc/4ZZipoWdmr77Lel/RxQ
 1PrNx0UaM5r6Hj9lJmJ9eg4s/TUBSP67mTx+tsZ1RhG78/WFf9aBe8MSXxY5cu7IUwo0J/CG
 vdSqACKyYPV5eoTJmnMxalu8/oVUHyPnKF3eMGgE0mKOFBUMsb2pLS/enE4QyxhcZ26jeeS6
 3BaqDl1aTXGowM5BHyn7s9LEU38x/y2ffdqBjd3au2YOlvZ+XUkzoclSVfSR29bomZVVyhMB
 h1jTmX4Ac9QjpwsxihT8KNGvOM5CeCjQyWcW/g8LfWTzOVF9lzbx6IfEZDDoDem4+ZiPsAXC
 SWKBKil3npdbgb8MARPes2DpuhVm8yfkJEQQmuLYv8GPiJbwHQVLZGQAPBZSAc7IidD2zbf9
 XAw1/SJGe1poxOMfuSBsfKxv9ba2i8hUR+PH7gWwkMQaQ97B1yXYxVEkpG8Y4MfE5Vd3bjJU
 kvQ/tOBUCw5zwyIRC9+7zr1zYi/3hk+OG8OryZ5kpILBNCo+aePeAJ44znrySarUqS69tuXd
 a3lMPHUJJpUpIwSKQ5UuYYkWlWwENEWSefpakFAIwY4YIBkzoJ/t+XJHE1HTaJnRk6SWpeDf
 CreF3+LouP4njyeLEjVIMzaEpwROsw++BX5i5vTXJB+4UApTAQARAQABtChDYXNleSBTY2hh
 dWZsZXIgPGNhc2V5QHNjaGF1Zmxlci1jYS5jb20+iQJUBBMBCAA+FiEEC+9tH1YyUwIQzUIe
 OKUVfIxDyBEFAlzV9HACGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQOKUV
 fIxDyBG6ag/6AiRl8yof47YOEVHlrmewbpnlBTaYNfJ5cZflNRKRX6t4bp1B2YV1whlDTpiL
 vNOwFkh+ZE0eI5M4x8Gw2Oiok+4Q5liA9PHTozQYF+Ia+qdL5EehfbLGoEBqklpGvG3h8JsO
 7SvONJuFDgvab/U/UriDYycJwzwKZuhVtK9EMpnTtUDyP3DY+Q8h7MWsniNBLVXnh4yBIEJg
 SSgDn3COpZoFTPGKE+rIzioo/GJe8CTa2g+ZggJiY/myWTS3quG0FMvwvNYvZ4I2g6uxSl7n
 bZVqAZgqwoTAv1HSXIAn9muwZUJL03qo25PFi2gQmX15BgJKQcV5RL0GHFHRThDS3IyadOgK
 P2j78P8SddTN73EmsG5OoyzwZAxXfck9A512BfVESqapHurRu2qvMoUkQaW/2yCeRQwGTsFj
 /rr0lnOBkyC6wCmPSKXe3dT2mnD5KnCkjn7KxLqexKt4itGjJz4/ynD/qh+gL7IPbifrQtVH
 JI7cr0fI6Tl8V6efurk5RjtELsAlSR6fKV7hClfeDEgLpigHXGyVOsynXLr59uE+g/+InVic
 jKueTq7LzFd0BiduXGO5HbGyRKw4MG5DNQvC//85EWmFUnDlD3WHz7Hicg95D+2IjD2ZVXJy
 x3LTfKWdC8bU8am1fi+d6tVEFAe/KbUfe+stXkgmfB7pxqW5Ag0EXNX0cAEQAPIEYtPebJzT
 wHpKLu1/j4jQcke06Kmu5RNuj1pEje7kX5IKzQSs+CPH0NbSNGvrA4dNGcuDUTNHgb5Be9hF
 zVqRCEvF2j7BFbrGe9jqMBWHuWheQM8RRoa2UMwQ704mRvKr4sNPh01nKT52ASbWpBPYG3/t
 WbYaqfgtRmCxBnqdOx5mBJIBh9Q38i63DjQgdNcsTx2qS7HFuFyNef5LCf3jogcbmZGxG/b7
 yF4OwmGsVc8ufvlKo5A9Wm+tnRjLr/9Mn9vl5Xa/tQDoPxz26+aWz7j1in7UFzAarcvqzsdM
 Em6S7uT+qy5jcqyuipuenDKYF/yNOVSNnsiFyQTFqCPCpFihOnuaWqfmdeUOQHCSo8fD4aRF
 emsuxqcsq0Jp2ODq73DOTsdFxX2ESXYoFt3Oy7QmIxeEgiHBzdKU2bruIB5OVaZ4zWF+jusM
 Uh+jh+44w9DZkDNjxRAA5CxPlmBIn1OOYt1tsphrHg1cH1fDLK/pDjsJZkiH8EIjhckOtGSb
 aoUUMMJ85nVhN1EbU/A3DkWCVFEA//Vu1+BckbSbJKE7Hl6WdW19BXOZ7v3jo1q6lWwcFYth
 esJfk3ZPPJXuBokrFH8kqnEQ9W2QgrjDX3et2WwZFLOoOCItWxT0/1QO4ikcef/E7HXQf/ij
 Dxf9HG2o5hOlMIAkJq/uLNMvABEBAAGJAjwEGAEIACYWIQQL720fVjJTAhDNQh44pRV8jEPI
 EQUCXNX0cAIbDAUJEswDAAAKCRA4pRV8jEPIEWkzEACKFUnpp+wIVHpckMfBqN8BE5dUbWJc
 GyQ7wXWajLtlPdw1nNw0Wrv+ob2RCT7qQlUo6GRLcvj9Fn5tR4hBvR6D3m8aR0AGHbcC62cq
 I7LjaSDP5j/em4oVL2SMgNTrXgE2w33JMGjAx9oBzkxmKUqprhJomPwmfDHMJ0t7y39Da724
 oLPTkQDpJL1kuraM9TC5NyLe1+MyIxqM/8NujoJbWeQUgGjn9uxQAil7o/xSCjrWCP3kZDID
 vd5ZaHpdl8e1mTExQoKr4EWgaMjmD/a3hZ/j3KfTVNpM2cLfD/QwTMaC2fkK8ExMsz+rUl1H
 icmcmpptCwOSgwSpPY1Zfio6HvEJp7gmDwMgozMfwQuT9oxyFTxn1X3rn1IoYQF3P8gsziY5
 qtTxy2RrgqQFm/hr8gM78RhP54UPltIE96VywviFzDZehMvuwzW//fxysIoK97Y/KBZZOQs+
 /T+Bw80Pwk/dqQ8UmIt2ffHEgwCTbkSm711BejapWCfklxkMZDp16mkxSt2qZovboVjXnfuq
 wQ1QL4o4t1hviM7LyoflsCLnQFJh6RSBhBpKQinMJl/z0A6NYDkQi6vEGMDBWX/M2vk9Jvwa
 v0cEBfY3Z5oFgkh7BUORsu1V+Hn0fR/Lqq/Pyq+nTR26WzGDkolLsDr3IH0TiAVH5ZuPxyz6
 abzjfg==
Message-ID: <9121835b-d6ac-c9d5-349a-1ef7024c6192@schaufler-ca.com>
Date:   Wed, 5 Jun 2019 08:23:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605083606.4209-1-janne.karhunen@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uwAc77Ibny20mjPVSMjgMZMFyMaOaUboH"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uwAc77Ibny20mjPVSMjgMZMFyMaOaUboH
Content-Type: multipart/mixed; boundary="pVaD6GpzHpiBvGpvsAbzowRyFmJ6omCNw";
 protected-headers="v1"
From: Casey Schaufler <casey@schaufler-ca.com>
To: Janne Karhunen <janne.karhunen@gmail.com>, sds@tycho.nsa.gov,
 zohar@linux.ibm.com, paul@paul-moore.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Message-ID: <9121835b-d6ac-c9d5-349a-1ef7024c6192@schaufler-ca.com>
Subject: Re: [PATCH 1/2] LSM: switch to blocking policy update notifiers
References: <20190605083606.4209-1-janne.karhunen@gmail.com>
In-Reply-To: <20190605083606.4209-1-janne.karhunen@gmail.com>

--pVaD6GpzHpiBvGpvsAbzowRyFmJ6omCNw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

On 6/5/2019 1:36 AM, Janne Karhunen wrote:
> Atomic policy updaters are not very useful as they cannot
> usually perform the policy updates on their own. Since it
> seems that there is no strict need for the atomicity,
> switch to the blocking variant. While doing so, rename
> the functions accordingly.
>
> Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
> ---
>  drivers/infiniband/core/device.c |  6 +++---
>  include/linux/security.h         |  6 +++---
>  security/security.c              | 23 +++++++++++++----------
>  security/selinux/hooks.c         |  2 +-
>  security/selinux/selinuxfs.c     |  2 +-
>  5 files changed, 21 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core=
/device.c
> index 78dc07c6ac4b..61c0c93a2e73 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -2499,7 +2499,7 @@ static int __init ib_core_init(void)
>  		goto err_mad;
>  	}
> =20
> -	ret =3D register_lsm_notifier(&ibdev_lsm_nb);
> +	ret =3D register_blocking_lsm_notifier(&ibdev_lsm_nb);
>  	if (ret) {
>  		pr_warn("Couldn't register LSM notifier. ret %d\n", ret);
>  		goto err_sa;
> @@ -2518,7 +2518,7 @@ static int __init ib_core_init(void)
>  	return 0;
> =20
>  err_compat:
> -	unregister_lsm_notifier(&ibdev_lsm_nb);
> +	unregister_blocking_lsm_notifier(&ibdev_lsm_nb);
>  err_sa:
>  	ib_sa_cleanup();
>  err_mad:
> @@ -2544,7 +2544,7 @@ static void __exit ib_core_cleanup(void)
>  	nldev_exit();
>  	rdma_nl_unregister(RDMA_NL_LS);
>  	unregister_pernet_device(&rdma_dev_net_ops);
> -	unregister_lsm_notifier(&ibdev_lsm_nb);
> +	unregister_blocking_lsm_notifier(&ibdev_lsm_nb);
>  	ib_sa_cleanup();
>  	ib_mad_cleanup();
>  	addr_cleanup();
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 659071c2e57c..fc655fbe44ad 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -189,9 +189,9 @@ static inline const char *kernel_load_data_id_str(e=
num kernel_load_data_id id)
> =20
>  #ifdef CONFIG_SECURITY
> =20
> -int call_lsm_notifier(enum lsm_event event, void *data);
> -int register_lsm_notifier(struct notifier_block *nb);
> -int unregister_lsm_notifier(struct notifier_block *nb);
> +int call_blocking_lsm_notifier(enum lsm_event event, void *data);
> +int register_blocking_lsm_notifier(struct notifier_block *nb);
> +int unregister_blocking_lsm_notifier(struct notifier_block *nb);

Why is it important to change the names of these hooks?
It's not like you had call_atomic_lsm_notifier() before.
It seems like a lot of unnecessary code churn.

> =20
>  /* prototypes */
>  extern int security_init(void);
> diff --git a/security/security.c b/security/security.c
> index c01a88f65ad8..6bfc7636ddb7 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -39,7 +39,7 @@
>  #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
> =20
>  struct security_hook_heads security_hook_heads __lsm_ro_after_init;
> -static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
> +static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
> =20
>  static struct kmem_cache *lsm_file_cache;
>  static struct kmem_cache *lsm_inode_cache;
> @@ -430,23 +430,26 @@ void __init security_add_hooks(struct security_ho=
ok_list *hooks, int count,
>  		panic("%s - Cannot get early memory.\n", __func__);
>  }
> =20
> -int call_lsm_notifier(enum lsm_event event, void *data)
> +int call_blocking_lsm_notifier(enum lsm_event event, void *data)
>  {
> -	return atomic_notifier_call_chain(&lsm_notifier_chain, event, data);
> +	return blocking_notifier_call_chain(&blocking_lsm_notifier_chain,
> +					    event, data);
>  }
> -EXPORT_SYMBOL(call_lsm_notifier);
> +EXPORT_SYMBOL(call_blocking_lsm_notifier);
> =20
> -int register_lsm_notifier(struct notifier_block *nb)
> +int register_blocking_lsm_notifier(struct notifier_block *nb)
>  {
> -	return atomic_notifier_chain_register(&lsm_notifier_chain, nb);
> +	return blocking_notifier_chain_register(&blocking_lsm_notifier_chain,=

> +						nb);
>  }
> -EXPORT_SYMBOL(register_lsm_notifier);
> +EXPORT_SYMBOL(register_blocking_lsm_notifier);
> =20
> -int unregister_lsm_notifier(struct notifier_block *nb)
> +int unregister_blocking_lsm_notifier(struct notifier_block *nb)
>  {
> -	return atomic_notifier_chain_unregister(&lsm_notifier_chain, nb);
> +	return blocking_notifier_chain_unregister(&blocking_lsm_notifier_chai=
n,
> +						  nb);
>  }
> -EXPORT_SYMBOL(unregister_lsm_notifier);
> +EXPORT_SYMBOL(unregister_blocking_lsm_notifier);
> =20
>  /**
>   * lsm_cred_alloc - allocate a composite cred blob
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index c61787b15f27..c1e37018c8eb 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -197,7 +197,7 @@ static int selinux_lsm_notifier_avc_callback(u32 ev=
ent)
>  {
>  	if (event =3D=3D AVC_CALLBACK_RESET) {
>  		sel_ib_pkey_flush();
> -		call_lsm_notifier(LSM_POLICY_CHANGE, NULL);
> +		call_blocking_lsm_notifier(LSM_POLICY_CHANGE, NULL);
>  	}
> =20
>  	return 0;
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.=
c
> index 145ee62f205a..1e2e3e4b5fdb 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -180,7 +180,7 @@ static ssize_t sel_write_enforce(struct file *file,=
 const char __user *buf,
>  		selnl_notify_setenforce(new_value);
>  		selinux_status_update_setenforce(state, new_value);
>  		if (!new_value)
> -			call_lsm_notifier(LSM_POLICY_CHANGE, NULL);
> +			call_blocking_lsm_notifier(LSM_POLICY_CHANGE, NULL);
>  	}
>  	length =3D count;
>  out:


--pVaD6GpzHpiBvGpvsAbzowRyFmJ6omCNw--

--uwAc77Ibny20mjPVSMjgMZMFyMaOaUboH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEC+9tH1YyUwIQzUIeOKUVfIxDyBEFAlz33m4ACgkQOKUVfIxD
yBH+Pg/+OGPr5Pelvu1afTGwfB9SRRRDyS6Kmx/72OXwF42t/A6spnNrpp3sj1hE
MjPN4YDYDfe/8vbNCOLV42U3Gbu3OvX8VdzbE1UItUYuS1mxOStdkYqoNdSs3eVz
Emm17wuv2LZbNFDVmG6fWzKeZyb4IT9mL7DFybHGLzEq9w0DITemGzV8HZpCfxTt
P4q2+onNn4z5KnoRvkH271ksxZEwZiytclUsI3E5XYwhhOeKqPu++wFiaBX24Vgc
MDwIZvtX/DbXBFvPfYeKAOLbw9UCG1nJX2zSnG7X4qVsfTsRQ0F0Oao2VaHYz0WE
A6p5IG8Al+IxwvQA5hn/ohQqscLsTJ08e4iPqUBGskMYGTU0Y+UgBNrXZl1s2GO4
9jJTbIXZsQ53rvq9YbyOnA1PBzBzWbR99OipviMpmL2ol2vA2ZwHw/MDsyxi2cK5
558ikMJtQHF++9GFY9pz0G2UizpIIZczNbnsnUG2761z6szGNempggaCy7Vz4iCE
UNfWIXc+PCocwdC5NqvROOdNIlXRkFIiR9ZIaKWibOCSIlqnga4ogomvYZtVIM5J
7mPkwBkLWqr31Wez0HItfYAvRjxP3I/psliBaR46QoGJiOb5MmaWh+fP2GZ9GXkx
82Q45/cmpYMLppfkhEIwl9S9+0f+DWfzWgDkGJpd6/6x6uTEXYY=
=NOwh
-----END PGP SIGNATURE-----

--uwAc77Ibny20mjPVSMjgMZMFyMaOaUboH--
