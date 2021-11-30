Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB47463CBF
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Nov 2021 18:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244855AbhK3Ra5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Nov 2021 12:30:57 -0500
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:40510
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244824AbhK3Ra4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Nov 2021 12:30:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1638293256; bh=Ll/htjmjzlwAw6nkkFJdkVnnaTjQ5Hrp/qvezecSysE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=QvAF2f10YFvYA4kImh7smBKka3QCooqEZ0mkbH/y/tscBwEm0+TTobtyo0u7mM6UmGp3gQ7z+tYfd1kWLtC3h+w4oIOVKmI90BDPB8dsxJ9yKnsQJeslC1dLxLyhrC4v1vTbG9mt6iyimlM9GZGsMYaR/+Dl1e149m3y0HSEbSfEYmcyclvDNjpK5xQWFfq2WZizFeC/B0FsmViORYQ9AyMGCf9DPOY04GtBStB1WtFJY20vaXg74DgIyTNkfCet7YkkXxtC7/PprNEGDXmsBPVZvoDrfcm2FfSsUkVRLiONkvgA3pX8JtX7Dfx+tEeHu4+RYxPn9iZ05VE8zMHOIg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1638293256; bh=RayyAnTyfeNNRO8T5TBZZ73BaFbL+nYu9L1yKKlE2EI=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=uoKFAYYZbDbQDPjDCSsRl40eMQqa64Xb2Ezzam1TgHG7DBQNft5RatZkUqi33+UG+LSjbVOKYOXKjdHo9qaihqatGahbEZEIWDo7BrpBRktjfEQjoNOpydpUtzYBDKP8FGF3bAggOgFYLIbh4P3/2SBxz7CEAZ0z3rMt6nEZg1mQwa5u1dqZoxofkSWxt0VMIhnwo4swuYBm4BtRQwrxyhj7PqcuIFp0aahmsAkpxzfS4L9YoXUZFNqH8WEKTohYrKWzs+2/0FEUbWMNRuM6rDOALsWLFnM6hnBw5TVFfNiI3QOINc7tH4WaP0ERJB75wyhT/6XW/cUscsJfzQxf/Q==
X-YMail-OSG: _djuMj0VM1mKzUOchqUULqm6xtGx_pWPrQUrgckGg5A2JEZ4O5eJYuOgeTWuKak
 rEEzE4mGUFrBBTBY_gRnE6u2AqhZ.CeK_90JAal1lUm22k8PxzYcdV0xX8sGAXOlOEB8QSkHPtev
 chxjMWCyL3g.FFJbteUhqCTHmD1BLyKm7rNxERd28LaNuJvyyrDrDHYqVyecX6q.MczkmzfSJdki
 98FyrHFvH4CUpiTffLz1TS9kJQK9vPoZg4bS0cRQDz5FiIGPoDSP8Gg9VKmq9GpdaFVlsaDlv3fD
 ypUSCSbftnDz4Py84djudSF8pr5yy8.d1v42YS4kZRFr_xsw9U52m4VCxTUDzCfgbMhN3gRvxNOk
 srDEeElH9DMpC854e2Pjwz3G3a.uppzHr7X4xCJ5Yyoc6vlycTQHTBvglbd0eRzmbgllU1MIwNBC
 .9kvi981QBhQOdhIMClEKIAdWkFfcehnl1Jx0V3wYtz1CCVkMr5I1203lFz5dQCH9tEjDuflWfOJ
 e4vBFACgQ9mIKValqwwX6qZPdFttftH6JIZlnrots4oZCPjI6O.bsrSdkJ8gthZng17mJkalWmgU
 7VOWJL13bAf2pcmKijzj9J8S6Mum1btItZyoCL4csQBuaF6HSZwcX8Hc2wxw3CFwF0idkxHmndqn
 77PGhCzw4dTgbeLraTZM71ao1SMw1.rPCvie3OoXOihhIYFu3ZkKkRNivHIv1vwTP15NkYKqGBCe
 MxPufv9RvEbIgAxEtiDHuvd0f18G0fEvk7lvXGLNSoxaFdTDtCZMvSU5z.7N7xAZ7v1zxd36nUwW
 oBmOx0WnTrMwPay4H9UxjzMxtlsmSdr52ag0EG1NEgG4qGPzplzewzly5nRe2X0ngBZKkXTku5nW
 I3qM_Bbge9Z2f_jZ6ybXbD1oIDfhzlZsNEc5nW9AxMfrcr7wIZiQL5n4tfSGcnMRZQNSS90_B62b
 znHG3KHepLuWzYRAUyHwLdi046bAnF3E_8TekyGKtOLEApvDL3Dhxxk2ijX3BBUzlMHLUQV8DBX8
 5Obe.JuVxc_jwdZVflCtjKPsDJoL5.lG7MlG..5gnfcpPW5H9_IcGxh2TSdMmfwn7YhtuBKNr7tp
 Fv._drd7Md4UCdSh82Uee1Gb_BhGppLeTyXWCN.2tW29q4CcMjoDkdU.DIMhRKnuWMFgZ6Qvcx93
 bO_P0f1fQ46zr1f5gODCwi6fTs4jdCH9qU4RT0ZEEYKJWDAxKvAsL0vpiJzxvQ7h05pjnQeZgodM
 kpsJp327wgybdP8vUj6EasFBioQFEBjrCt3hEsLBoSV7QBth6ABZPuJl1z2YiqSPcmENA75LoUlS
 Su7uHiJEIvc02JZP5mdQSWzm2fG9ZrZK9jFjnd6Unvu3OPvcibjCXJge9wk62J_VXP4JuErIZR1i
 WoJgD1Ph5TDyqV6Eu3T2Tlmn3wCiVbn4_QhuhnWVfKvisz1FRFThyfSA.v7jgCP1TYMhBQxDfh8a
 xrx2SrR3oByduVT2nVrlDKF_x1LlU_EFJdfFNqKQTRYFNNDRIGID7yLkZvaSoXghcf9tQKUAmazF
 hx4CtP.bkECvWCcn7dzsJ4roeAeu8cNusJ66dirwGRAdhQhXPvTz8iJQAYS3DFQlgqT0NP_kTga.
 H3xcZB6DWa1Y3gq8qEf4tU_hdX0w3taFehCMz03gstApjL1HeUUosb0KZ2wb_LwuFC2MTntf.BRW
 QddfsyztcmvYPgbDzf9Q946AsdvvDRfiZ5lHhc1uCGFq8xK0Gk3mRzZeOdlRiatwaCISdnjl3Df5
 .T0q8TzLyHlZ0Z9sIRgZmbrKqNG483Ajos_vk23w_qZDejMWovfrL1dGo6JcQqTFwVDmDXCYafEl
 hJqf9Y3ZngbErYeL2qDVJN3rBfLtnf5Ju4JAQW4KEBQJWvQesm.ET7Kgz_P8rKzTxF0RKwQzWP.Y
 nPsiu6SpuCVWbDZy7.5W4rO3qicnIRyNmoRwAFF7Yin4t0tFodnD5eif5APVx7O.foK8J1E9NlM_
 wrqJtHETTtG2HtDLU5rMarYEoj_AktdQa1.KDMiui9bApPy.a_hg9ZmljJ6QHRfvnJz29Q.tMq7k
 LZv4g7HH_pY9SuFUMATc.9d4Nty2jzJYa4kpBMkF4fS6ROBN0jQTkZFIGNsR_EjEFfOUsHYEzDuy
 6FNkSo9NMS8Taf7IBZxLo5Q6MBJzV4k2VQhhRV_gCej4RT_Hank37nlmjHGqyfwtTeVGvf03NNAR
 GRuEDwsgEar3ozNY-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 30 Nov 2021 17:27:36 +0000
Received: by kubenode514.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 2ec5ae8fbf93c3d61fd0794923068b9f;
          Tue, 30 Nov 2021 17:27:33 +0000 (UTC)
Message-ID: <e482c499-8bff-72c8-bbda-1ecc5a7f3452@schaufler-ca.com>
Date:   Tue, 30 Nov 2021 09:27:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [RFC 15/20] capabilities: Introduce CAP_INTEGRITY_ADMIN
Content-Language: en-US
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Denis Semakin <denis.semakin@huawei.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20211130160654.1418231-1-stefanb@linux.ibm.com>
 <20211130160654.1418231-16-stefanb@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20211130160654.1418231-16-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19306 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/30/2021 8:06 AM, Stefan Berger wrote:
> From: Denis Semakin <denis.semakin@huawei.com>
>
> This patch introduces CAP_INTEGRITY_ADMIN, a new capability that allows
> to setup IMA (Integrity Measurement Architecture) policies per container
> for non-root users.

Why not use CAP_MAC_ADMIN? IMA is a mandatory policy. The scope
is system security administration. It seems to fit your needs.
I introduced CAP_MAC_ADMIN for Smack, and believe that IMA using
it would be completely appropriate.

>
> The main purpose of this new capability is discribed in this document:
> https://kernsec.org/wiki/index.php/IMA_Namespacing_design_considerations
> It is said: "setting the policy should be possibly without the powerful
> CAP_SYS_ADMIN and there should be the opportunity to gate this with a new
> capability CAP_INTEGRITY_ADMIN that allows a user to set the IMA policy
> during container runtime.."
>
> In other words it should be possible to setup IMA policies while not
> giving too many privilges to the user, therefore splitting the
> CAP_INTEGRITY_ADMIN off from CAP_SYS_ADMIN.
>
> Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>   include/linux/capability.h          | 6 ++++++
>   include/uapi/linux/capability.h     | 7 ++++++-
>   security/selinux/include/classmap.h | 4 ++--
>   3 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/capability.h b/include/linux/capability.h
> index 65efb74c3585..ea6d58acb95e 100644
> --- a/include/linux/capability.h
> +++ b/include/linux/capability.h
> @@ -278,4 +278,10 @@ int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
>   int cap_convert_nscap(struct user_namespace *mnt_userns, struct dentry *dentry,
>   		      const void **ivalue, size_t size);
>   
> +static inline bool integrity_admin_ns_capable(struct user_namespace *ns)
> +{
> +	return ns_capable(ns, CAP_INTEGRITY_ADMIN) ||
> +		ns_capable(ns, CAP_SYS_ADMIN);
> +}
> +
>   #endif /* !_LINUX_CAPABILITY_H */
> diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
> index 463d1ba2232a..48b08e4b3895 100644
> --- a/include/uapi/linux/capability.h
> +++ b/include/uapi/linux/capability.h
> @@ -417,7 +417,12 @@ struct vfs_ns_cap_data {
>   
>   #define CAP_CHECKPOINT_RESTORE	40
>   
> -#define CAP_LAST_CAP         CAP_CHECKPOINT_RESTORE
> +/* Allow setup IMA policy per container independently */
> +/* No necessary to be superuser */
> +
> +#define CAP_INTEGRITY_ADMIN	41
> +
> +#define CAP_LAST_CAP		CAP_INTEGRITY_ADMIN
>   
>   #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
>   
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index 35aac62a662e..7ff532b90f09 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -28,9 +28,9 @@
>   
>   #define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog", \
>   		"wake_alarm", "block_suspend", "audit_read", "perfmon", "bpf", \
> -		"checkpoint_restore"
> +		"checkpoint_restore", "integrity_admin"
>   
> -#if CAP_LAST_CAP > CAP_CHECKPOINT_RESTORE
> +#if CAP_LAST_CAP > CAP_INTEGRITY_ADMIN
>   #error New capability defined, please update COMMON_CAP2_PERMS.
>   #endif
>   
