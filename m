Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E17467BA4
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Dec 2021 17:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245579AbhLCQoV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Dec 2021 11:44:21 -0500
Received: from sonic310-30.consmr.mail.ne1.yahoo.com ([66.163.186.211]:45351
        "EHLO sonic310-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239002AbhLCQoV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Dec 2021 11:44:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1638549657; bh=c2P971YFCP40uAn3CYc2G9P6gOoB0KRQFi921M3wZxI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=mwufKtwCFdY4fBrlIHgdzofem7PzeLbI0t8C85xKPx310SmJM+l07G7QoXznfdBjcv6Pxf6G/VB6DuvC8oJ1xFQ791Vm3bPLogFrDf5SNIpjwr+ZZQFOCTLnVniNgWg1PEZblmT1QWudr4UcRNzOiJYvdfLJTj+Lja7sC0Y5obd0XdlFI5BqKL1/pQn6cAB0Jdn7ufwntuDcn8JjVRyaW0xgz8NnKF6QUegvMewxZaAr8A2qDTKrsR3bGian/Vig+bIdysHKuSPycoqpsgFOrb1gQrrd8/+GfcmCe3DfXxh9K4vTiH/Zgq6uL1R+WRC3WnMn8TZmRC6G/1aehDO4dg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1638549657; bh=6Oxq7lppYd77ukytNlxuUnM5qMU6gQzxOECkPFaHuj/=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=iFvAFbgZBMR1BTqGiJfu8IaN6TC8FNQuW9aNymiThY7bgUVLBPmZv79cFxH8yLX9oWQ623lFYOr7Ygpvg097cr4xsSgiliTRIBfaHFtPI34+BL0wqg3GX/oLFS8zV+3bLOAiAS4e+Ic4tEEfzwlR+lYzTTYKRNF+6cWEQdHABLNHpnE+9auKmZ5BnVdlfnkUz8idTA/cbpCszNBhhC1uulO5KJgFj8SH6Ry2ZpafAX2am2f47XD4AuydpZTyX91jtqWncHNNqHEy6l2F7H0/2D9uVx0cukNwJBdhhHX/sIiWetFCYbSa5iXvfD27ZQXn4Rq5PXss9Ns5hOnieT6ZvA==
X-YMail-OSG: mITKy.IVM1lMac0bD0wYbCUaz18Avc1.XVws_RR3iKP6t7d_j3rncPaT4JLEwZm
 eW_N2fmESZeMSsP_w1Lh1LO34LUgdsM9db.c1LM_MB2chrSegnGsrQVp94LHR.yZ4JOm2k7b8cRv
 fFZU4j9.K8BXcHBzyxFh9K3dsa0FyJRHkVr7aMuIPE6e51RHIGNUE_PwA.2cht4dWdrNJk4tD0lp
 1GaHnHN68nVufs8bmFYhLdfH0D2zM1NjFe4gweRR2Zoz.g5fyoj6iPAUK4MyuyDN_YdTBLV0xqMP
 Z6BXT_duyHTXUhiwoXTKTvbip5Oc5JYDw.0gxCQYZGBfp6btfkvJ97Qx.nJYpsR8x7e_2uN3a3kZ
 FJbCvnR3VBMqHO_x_yW3zbUxFr9AtiHnPSjfN51fdDuxRdY3.BVJKH1o6WH5s6luqmYkrGuhAInn
 BBXK7JHNPxntPfKl4jYYIBOoQcpWeFrnJaYubUK9xrOtDnGgTEsJEaRKngOIcOCBxZM8C2IH2.Hp
 77xxcFucKz2TYbGVPUKePNUvOS3HoxeEX747aZMUMaeAnb6WvPzDCrWkAVByEYrckBmYrCL3O8X.
 GIpGzvOdlUkXzr_RTTvPWPJuqC37Mta0.v3b4b1DIRb3EmfmdWaIklIo_mLAG7f_6mFMfpiPRsWC
 wWYYMBYKjDAIkyui9ElBcVmlgfJtmRVXLwN1xoHquz.E5WMPguOlrvhZERjsbUVj.T2hiGpCSYw4
 ykwIG90hpQUZBbfS49IkzionaUtZaA3p1kYumVXSDD8A7xfG6mZIYwWF8XopiNg2j3e1kyv3hFyy
 Byz62x5yxU8A9DUoC3BCynagkWoPvMKPNBIrUcDH8svt2tPL3WH249558mQFuKxHw.TWafmCoQ.P
 PFxy62ukpKTIBplaEnxHFp6KvcJsxhDnKLlUGcBTcCr.hiqd4Vcj8ovJnvvARDHqSJgvOfOiG13G
 V.BViGdLD8x7gjENDoHYQeRwlPwJHSQJcEJWcSEpWK4pMU8.pui662uiqb6WIY74dk8syg86OkHH
 yZJHO2Mnyab.Y1dO3k.isk.uddW_QPG99Gkp7mbHVOkPOT4jy831PAmf.3PvDAXV7PDrMSZ2otjI
 0rs4WH.C1BAOuSOoG_yDwYDsDvoSeYEkVVYVOhkyXgKznfJeyOf5i9TBr2DEskgjiVvyaFA2oNt7
 Basmn3oZbn2wnPXgX63TgVPn75BcR3CkjNvwsaRvQmQF7WbqSxHqwavm9NZplIefhrl8sBvlY7pE
 lHHrq54WcRBa2UavkYHGH6y5t77DYNCsUeSwA5WTBlusUqFizDZLeyilU9pazHdIL9hFJHwOi4zQ
 C3rfYF_nXVUJ_CgcA8DgxEpoU5rwAKlVf_uzr62hqmV9IyKNdZqcNGHFOEepYUov4iXYGeJU.zfi
 .CkRJlXQ.oCbu_MqQE.G2sUJB5UReOFl9b8DXEprWG0tKy6cSHH4FJGTe6lg.PXJk3pl598k.EB7
 o7bY2shV5TmkZtND1Tuy9WxGfmu7rHoznOdhRmawfiWQ58Ov1TwAvfuiXtsZa7XpBY50ndAzECuG
 Xhq1NDMvUC.ACPl_ECLkPtr9Fp6TzRMBNV0vMihLfG43wvPceiXR4H.5HoLffr8OHaWNLOHlmcG3
 c9GR6BLjl3P02ekkqrPkDm3XcJmhh405Cm5HcNROC6Np2Uc3burqqOwS6PHmCPU9.XnwlXaYoLKq
 96UiMmy.QZNIgbtiYZH74v2YOqnJWvS5cjZw2mCnOyyls9AFoVoGCLz._a4u_1LOZ9KzG9ayQsUF
 vrrbTosdk_4PNXUitm5HEe83WKs1nmH_2oKxlQvI6rjaXfTscLoVOLfnyMkCUgrO4Sd7q7d_NRWV
 Krcgxmvik_XiviTxS0FX17ltd31CYTmFAaoZMys2OlHjAg68OGlwENSiKtODP8KbpZNT.IV7Rnnr
 CWpxuG2tcLl7LgpNE9.t0uW82rbyPp5nuDBg4nYIbJpmTugyL9XcwQCHypME4sw_vDzcUmzhDTQx
 z2qD4yakgIv6VQvsCfOXGktmckQyol45glzOZ1Bcs5HZdFz4QfEdOedqC6ePiuE61SdRqeUHlwXA
 IxQMjPu9GyeNmGVJJrScVmWh1irgN.agZSZMlUqiZiPdYjbJoQSnIMFF6Ev0FE4HsbAYTf2XqswY
 lZdWjtZMNQmXzmgrq4D4gf2rwREcwfR7Ia_Ure37O0Z8qJPSAo2uWsd14knGoGL2Bl1fDr00F7hI
 Vyp4wmkk1GdtbsaD5fueEfySq_a5CsalpvDoPvuAEHA6NXp4Pgfc-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 3 Dec 2021 16:40:57 +0000
Received: by kubenode516.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 7ad22f36cef124daaa6f5ae0c128a4df;
          Fri, 03 Dec 2021 16:40:52 +0000 (UTC)
Message-ID: <2f145bcf-72a7-3697-0bce-f7a74e6ecc93@schaufler-ca.com>
Date:   Fri, 3 Dec 2021 08:40:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [RFC v2 15/19] capabilities: Introduce CAP_INTEGRITY_ADMIN
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
References: <20211203023118.1447229-1-stefanb@linux.ibm.com>
 <20211203023118.1447229-16-stefanb@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20211203023118.1447229-16-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19306 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/2/2021 6:31 PM, Stefan Berger wrote:
> From: Denis Semakin <denis.semakin@huawei.com>
>
> This patch introduces CAP_INTEGRITY_ADMIN, a new capability that allows
> to setup IMA (Integrity Measurement Architecture) policies per container
> for non-root users.
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

Please use CAP_MAC_ADMIN, as discussed on the previous submission.

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
