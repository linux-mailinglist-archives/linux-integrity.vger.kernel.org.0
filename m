Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A3D20465B
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2020 02:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731716AbgFWA4S (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Jun 2020 20:56:18 -0400
Received: from sonic310-31.consmr.mail.ne1.yahoo.com ([66.163.186.212]:41651
        "EHLO sonic310-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732420AbgFWA4S (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jun 2020 20:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1592873761; bh=pzoSBVgHzCBLrlJt0oGf4p1Cu2m7OZpq/AvXD0rhxC4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=RrDbxLGdSUk6U1+4EOKkXdi771FIJCTxJa+g/4R6n7qpglLY0jcCjehqVCJM6pDKAXby0deTm79/BOQHObfWFzgp3cQtXYH4mwzhLtJagECRDR61s4OkRHnvI5mXjhsNc0ndISSfX3BU31yZL0jU+QCJKkcQusD2xPJXQC6voVlfgTRtQphwYa2JhZQ3PzPuJVLLPXe7OXYEOUyBdVcX9/Wq2K88suLTu81FXbOeR8IBeVSrkjBkVZrU32ljJD5+HBULsPFTer7aX4j32G656TLJ1RvZQ4RyW6TJr0x3ZyD0rIBFHI8Q3QFRYM29mWPYLy5A2/XWhojqH1eTY4XUYw==
X-YMail-OSG: c5MhKkkVM1lxLADYX0UCLxNmMuXyhF43uoYf.AYKxeHNTDRRgLIgsS0IDh8qPBw
 RhFBKumfR4l0Gh6Qq7BzPwh1G6iPLtLh6uEKFmK8B3sW5dQ2UELzxNIGsM5T01KU4CjZC97wTBZV
 T0FMgSrbMFBV5agdL47aQORFCI0dvfgrYb7SB7BcFGfzrgs4AGnm5hf.yE8mU_537wdSMVpZTP6M
 z.gCWE1XK5FBHrp1swgjLtzVFwsqsGWn7yBMku6nhnyHTd1AEupnb_jJTzBr3xlivqV9frGlfOdu
 F_cgz0Gr19VVx201UyTkWVQ9j.43.V6wKVBpR27s20vAZec8o7fslYQSNvKfH9Ud9WW1RCPPNrKM
 IFDao5XmHDbs8x96Xn5R.L8Wzrsjt6XdXtWoQItA7xa5654uYVACikun58ZLf7CC3tlHNgXNWU8h
 9XvA7MZbmO4QIMzebuYUpXtlN64EauSyRPwhq6QD5wVyUbff0ZnLp4Vo3gZVqiyD3BBdyb0FJDXL
 mmF1ZgZZaC7s4BRbq8SU_dOa.8nfXvC189hyG6Klj8XbZe9.PzmK5eWltav_9FdHVbIlO5nCqDTb
 SSXneOVzx33uTmj3vSF5kQAptQSBR88W.VwNxGi..3Yp9XBB_qTuHfuzdTu25KLqR3tEkVsS4282
 EBemDPRa8iaB90yP1WjOkTIBDELjkI_BLTt1wFCkQOxDvJKp1eoXlo0LWUO4B7fbb5p8P.0U7ncA
 NrDA.cMrkm7XdT.SEXFnANZh4uduZZ92suONNTC7mvdjhJx4L_weThPXz.Ul.BZGgfeGtFoYjY1n
 HcCk0YyTosT6fFNl.KNDuJ91HHRdwb4i40w2MhfCzFLOcb8dZLINAragk8IsWWrHcWKYLfrv3fiq
 dLW8XFUXr2GNP2hoN24LVLuBtsEe_N4grVwsARQSy8MMIkOX_Ol8_KcbNtKBl9XLOwN0kGk4KhM3
 _noFY7RW9pBnjNyEubg_FJBgHhPS64BVXxZ1H5nCv5rsNfgJxBgpxK1DVNP1k.z0wel1_d92NXv0
 9mm44dN2QvCgeUbsvM5yXSMAy1PIEysXTvn6FFZ8mYJGyglCGPwXGDhjAe.SKuih2J0madt_vfAW
 7rEhW_2stgsX8qIUQLzD6zvXl_4DFrr3glZ81uNqA.cNw_MncOH2gr93lGmM_pk9obJFg83KpmAz
 N8cs2c_bJF7Er9jY95IhnJIyYr8DEL.XytS5uOx16i_WiuBcM2LTZXr0WQ6VNSrvjyXpwCLmbvhn
 Lx9m.FVevpYUd6X2B9kCP_P_OVu20z9IT1IWluxGykCHqp6JmUg_m076nJnmOijp4b4nB_XB9NSj
 8bYWZWqH8yUJDotpjyHXwx.egweJhnrzfiiy8Y..wXNrRxmhhylwlXQuRdfhBnapJ6WxZkxNIwQv
 NRvawWXItnyF8uzNchICRcL8tZpH2qPRYU5aVkuVyK7aA
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Tue, 23 Jun 2020 00:56:01 +0000
Received: by smtp427.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 0ef61bdd18007080b2d4ae4c54f37684;
          Tue, 23 Jun 2020 00:56:00 +0000 (UTC)
Subject: Re: [PATCH 01/12] ima: Have the LSM free its audit rule
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200623003236.830149-1-tyhicks@linux.microsoft.com>
 <20200623003236.830149-2-tyhicks@linux.microsoft.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <277dd210-c443-c067-e731-44ac53418fa5@schaufler-ca.com>
Date:   Mon, 22 Jun 2020 17:55:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623003236.830149-2-tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.16138 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/22/2020 5:32 PM, Tyler Hicks wrote:
> Ask the LSM to free its audit rule rather than directly calling kfree()=
=2E
> Both AppArmor and SELinux do additional work in their audit_rule_free()=

> hooks. Fix memory leaks by allowing the LSMs to perform necessary work.=

>
> Fixes: b16942455193 ("ima: use the lsm policy update notifier")
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> Cc: Janne Karhunen <janne.karhunen@gmail.com>
> ---
>  security/integrity/ima/ima.h        | 6 ++++++
>  security/integrity/ima/ima_policy.c | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.=
h
> index df93ac258e01..de05d7f1d3ec 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -404,6 +404,7 @@ static inline void ima_free_modsig(struct modsig *m=
odsig)
>  #ifdef CONFIG_IMA_LSM_RULES
> =20
>  #define security_filter_rule_init security_audit_rule_init
> +#define security_filter_rule_free security_audit_rule_free
>  #define security_filter_rule_match security_audit_rule_match

In context this seems perfectly reasonable. If, however, you're
working with the LSM infrastructure this set of #defines is maddening.
The existing ones have been driving my nuts for the past few years,
so I'd like to discourage adding another. Since the security_filter_rule
functions are IMA specific they shouldn't be prefixed security_. I know
that it seems to be code churn/bikesheading, but we please change these:

static inline int ima_filter_rule_init(.....)
{
	return security_audit_rule_init(.....);
}

and so forth. I understand if you don't want to make the change.
I have plenty of other things driving me crazy just now, so this
doesn't seem likely to push me over the edge.

> =20
>  #else
> @@ -414,6 +415,11 @@ static inline int security_filter_rule_init(u32 fi=
eld, u32 op, char *rulestr,
>  	return -EINVAL;
>  }
> =20
> +static inline void security_filter_rule_free(void *lsmrule)
> +{
> +	return -EINVAL;
> +}
> +
>  static inline int security_filter_rule_match(u32 secid, u32 field, u32=
 op,
>  					     void *lsmrule)
>  {
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/i=
ma/ima_policy.c
> index e493063a3c34..236a731492d1 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -258,7 +258,7 @@ static void ima_lsm_free_rule(struct ima_rule_entry=
 *entry)
>  	int i;
> =20
>  	for (i =3D 0; i < MAX_LSM_RULES; i++) {
> -		kfree(entry->lsm[i].rule);
> +		security_filter_rule_free(entry->lsm[i].rule);
>  		kfree(entry->lsm[i].args_p);
>  	}
>  	kfree(entry);

