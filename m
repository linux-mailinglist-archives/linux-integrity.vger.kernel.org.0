Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0808927A2
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2019 16:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfHSOyD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Aug 2019 10:54:03 -0400
Received: from sonic312-56.consmr.mail.gq1.yahoo.com ([98.137.69.238]:35964
        "EHLO sonic312-56.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726661AbfHSOyD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Aug 2019 10:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1566226442; bh=fB+7Aa6spLImgQaCe5u8uBi1+r68dF9AANzhbIfNuT8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=al7+rHfURZVS5DEytTL4ScZYa9TJ+Ns/DkEqwuvWpExQaIrV1VpaM7STfCADVFDS6tosTmVBRO3id34j1BfZjkmSl/DMMH1xIPCzRi6RyBCAtfZbbtbkCi5ayFWEjwLK5BfG9FwdvkmFyaY2aaDQ2IquOYX8wEWZPjRir6lnrvdFwHcLXMd/pbwYZDZm819bd+tSCaQmE1Tn33+RByORCqlQuSC/Nl3Ww/N4GCY+QG+L3wHPomjEkJcJczSAM1faEDtlrxdQGG8k33MU8eolxkKWWM8+22mLN6JUefv9MO00N65yqmrgLia4pjlffWl82Z8tuAyV5A/RsIhp4+k6kg==
X-YMail-OSG: HIkLjh0VM1mQTIL2qfooEn2QJY0O9LF0cBcRA5EH7XiJwn0Ul40WMz59KjwYHRi
 WCkCAWVpbDG3xaoYlY4ya7lsC0JtjNV1xVQwHC7.xUSR2UaeYUvVAY_yasjFEV9Wsfzj8a0kHkoU
 PHm_2EYmZQdXC5GpJElvJ.56kp1CSo_XQ9PLoIqqHvE7nca0MmN1f8TocCZ134QitSJD4S7ZYnPs
 7i4.dScD4J0eA8oi4XwpwOQbIK1aAkiDjHO1EZTyNSGJL6OAlb71zN7PF5ZnEqltQR39MXTV0Yrk
 wVlbNizVF8ouJiXHiMCcXz3iyZrL71ry2nt0wTBibNt6VzG1jSCwWFENT4ab1I1IWOEJ7m3ee0Ta
 YSsnjEupqgEezWG8bJmNQkN4Ggwbm8DaHRQUgW92n2GlAu_JXW1O10LJiTJ6NR1FVC6RCydMOOf2
 DCv7wUx04_wNPU.WFGSnFjH8Psz3uTni1qtXlDBOPd3xoXKONUrclwYfnwPWLcTZtSUN.Th1fdtE
 1viMg4JYwF44EypFEMiBFMbIMATeZfngv0auZh.YkCcdwZfPpuWseQhDGVufGYkDPA9Uj4UTRvrm
 S4wioLUekw8UQfkwxSiXf.oc0bxN2bCn_aoW5EkryE.kn5mXtvLFS3RI_aFo7NiGyKl..86sDs5S
 nJGs1V1NoJEGAm2fp.R_mdvCfg7QBjB8m6Vq28MESnY6ZrDrvBQs2nokMxS4_HjQeaGHZz0RSDWw
 Tk0X7djxAfXM5Aykkv9VBR__c7Ubq_X626dMMdqy6ZSe.uPny4tuPvJqYh0cE.Bz3OzE_FgkNL_T
 OphqPbqnEWifayucjKAJAnkua9jCWRouwQP_0pucJz8ofoLlALxUGqZ2hMgupDdk56corrxh1coD
 P2fbN_3zy1sbSqPPLDHxa5l8.O3sYqkzyNd3g.1Xwb.KzYj8UpUk1HOQeGHu7Qi5jtAkwwKWnzmU
 SLK5EFqhcnj6bHxs3_4g_7cZo2Y.5WaS4RiDaBqJzMzNUhR7utk3OmVXSYVgPRhY51U5C.OfxGA9
 h9c_ZWzDaGlyELyLuxkA23PUIIiEqFq_ueHKWA1xb3U.vg1rGOG.MPSe4jBz2aicHFn0gnswzITi
 yEUU4Jm2q4IU59kzl7uNZ3n09TTVWVb0bQ21fHviCaryqxq6IWMDzBC6Hb_u4pvzu1RfGgt56OOd
 w2ibuvMSCMQ64iM3rPgTjIBojpQ_dJGgUY6c4iY2hVD_gXluFDmeY7uv75zN2UJyDhVeB5E0Gi_C
 4R5hAa6zmWiPCmE7jLHsQeybq_aRRiYXobDA0Wuvzruo2kg9wj.tQwWF4vWfeVpEcgEXS1kiaL5K
 YwM1vDji3uSYnB8V29n12hP1bSwGxSR98ViLAb0yaA7nc.L6h3qu3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.gq1.yahoo.com with HTTP; Mon, 19 Aug 2019 14:54:02 +0000
Received: by smtp431.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 27ac39f8c39afc0ed4dd7a96fdca8562;
          Mon, 19 Aug 2019 14:52:01 +0000 (UTC)
Subject: Re: [WIP][RFC][PATCH 1/3] security: introduce call_int_hook_and()
 macro
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, zohar@linux.ibm.com,
        dmitry.kasatkin@huawei.com, silviu.vlasceanu@huawei.com
References: <20190818235745.1417-1-roberto.sassu@huawei.com>
 <20190818235745.1417-2-roberto.sassu@huawei.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <4c13c8a7-e255-a3a8-c19a-cae85a71cae9@schaufler-ca.com>
Date:   Mon, 19 Aug 2019 07:52:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190818235745.1417-2-roberto.sassu@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/18/2019 4:57 PM, Roberto Sassu wrote:
> The LSM hooks audit_rule_known() and audit_rule_match() define 1 as
> result for successful operation. However, the security_ functions use
> call_int_hook() which stops iterating over LSMs if the result is not
> zero.
>
> Introduce call_int_hook_and(), so that the final result returned by the=

> security_ functions is 1 if all LSMs return 1.

I don't think this is what you want. You want an audit record
generated if any of the security modules want one, not only if
all of the security modules want one.

>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/security.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/security/security.c b/security/security.c
> index cbee0b7915d5..ff1736ee3410 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -634,6 +634,20 @@ static void __init lsm_early_task(struct task_stru=
ct *task)
>  	RC;							\
>  })
> =20
> +#define call_int_hook_and(FUNC, IRC, ...) ({			\
> +	int RC =3D IRC;						\
> +	do {							\
> +		struct security_hook_list *P;			\
> +								\
> +		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
> +			RC =3D P->hook.FUNC(__VA_ARGS__);		\
> +			if (!RC)				\
> +				break;				\
> +		}						\
> +	} while (0);						\
> +	RC;							\
> +})
> +
>  /* Security operations */
> =20
>  int security_binder_set_context_mgr(struct task_struct *mgr)
> @@ -2339,7 +2353,7 @@ int security_audit_rule_init(u32 field, u32 op, c=
har *rulestr, void **lsmrule)
> =20
>  int security_audit_rule_known(struct audit_krule *krule)
>  {
> -	return call_int_hook(audit_rule_known, 0, krule);
> +	return call_int_hook_and(audit_rule_known, 0, krule);
>  }
> =20
>  void security_audit_rule_free(void *lsmrule)
> @@ -2349,7 +2363,8 @@ void security_audit_rule_free(void *lsmrule)
> =20
>  int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmr=
ule)
>  {
> -	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);=

> +	return call_int_hook_and(audit_rule_match, 0, secid, field, op,
> +				 lsmrule);
>  }
>  #endif /* CONFIG_AUDIT */
> =20

