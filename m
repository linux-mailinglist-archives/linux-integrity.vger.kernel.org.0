Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F2A20D0CD
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jun 2020 20:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgF2SgK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Jun 2020 14:36:10 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:44615
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726907AbgF2SgJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Jun 2020 14:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1593455767; bh=OuJSaS9Xnbydlb+uxydM0d2cO5uCSpCFE6dx2suBF2U=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=SJQyKLbperAJCLam4x7ndFR2CNf9cA1T1BlpSqC4VWPVIWAbz762Eb5+2slKUNcbxY4tD4F0GiaxqRnvKizuiL+WvKN0gN0KhAgJcrmbsPZ1QOvMxIk7cwO0zw/zv+TWJLoHLK0cZgcQj8JvZ3qGjEs+BQuj6m7EJokYeqiTMZWXi2yfsWero9v2WMYLju8GOkzuaN4DHLyYc6XVolucMKTfaZn1KIJj5LaoLWtjp8ptm8ipXcW+54Kk769ZzPGU4BGXYDuCI0NsQU08Yp3VO+9ntXEPgkaKzP2E1Nk2JmqRngrVCJL1ywFLqNRvSaIo2sQBHkMB1mWTa/q+0OUTXg==
X-YMail-OSG: 9ebNZ.UVM1n_um2PoRjGpiLzcpb1SWXBQaecD2JTFGrB6XDI61MyaOqnb8xJ_0D
 We7FFipbj.pKwojpUHk7tHX65vW3C4a6UK9MP3hhmL73a1.a2w25hBL1YCt5cHcsjqjufEWBo2IE
 oNC_N5ilQkI1XZcStEbdRhqfYbI3ZoqihweuR846B4q5gZOJABKoNw7FP1410z2tlod8SEb9NKcV
 ZdJaK7Fw2gXLkrbaiBjV_NLn9e.xEA7c4.URnXMItW3lg4qr.yvYDALd.6J5Mk.pvxQvUBhhT_Do
 F5RTUNa_unEC4Fk9fSL4JNFBEVVZGcN_4sl4h2nZ_i5DojkouJjRRoAtj9UoH4r0TAVeLGT_09T5
 RAFncVfEvddz81Di6LcYQ4VqpkyCs___UIZR0A5ZLKlsW81.MWcGboc.f2HRs12uJ2DDRsbBdhnN
 mAPwZpNkhJNEsruMUkSEFV41Ufj3qyhrWtFkXVw2cfHPQWNaytWlXQXt11EQX455D39KRTDMAcU_
 IYy9HklLh7xGChyiP.nxivPey_4kmTOUSTVeMFFBXjG5aMZnvZN4JPnPOZWvGTxU6Oh9Jrp8i03H
 5ML91XoEtarfR0w4w10o0ovZtAhQHbBhjkSFs9if4B2w3JkVZXGrIcFCaKhIA.Yf1sU.CHiUAKjs
 X7QGKHlIQmqVW6Wrf6AMxyOx.6aNFygy1c1I54w.gbKmGhMFQ.J4QVTlmlmiZnRGUUD09iXx7_7e
 iurg4AJmz5yT2_z5TETJCoYGVWfrC6XeROXwK0cipkY7.Dhe6zr219yCpRCqA.ys9nO28oNIUcFh
 aG5Y4BcO926sLNm9tVCTE.zFZuMLhJJPERXe_239rLjL5cE2eFBFFfLun2jyfSB1VGQNPIIWcs3c
 B5KTheQyYhep0.yb7RNLHeG3q4U5HaE8KGS.Sjc6eFmpsAHAxir1GIMtw.fDTLTJgImDcyvLRq_v
 BUmahotgMdKddL1nDn3IRqjPKuTrYjc216GChMYq1PXrlZn2.gMLzYEfHxHHWlDT3cotiDBbHGZ_
 npRbZYnPcZx53xeuaYhu7puFWiXBUMnvBjekpsFIRLkBEP0Hbpi61XeejN9dRxmcA4d892yubxRD
 5vUUKWWZDvvSWihdzoLLPU5NDCKD4aCIZaT4Y6cfGKl8o735xx7vckwMaLdrI.n5DLLzzvFg5URM
 rwCvibhe5Q7jHm3AjvRruI5hTGL3MRPChlOaNCGYE.0k9ytpAgp15MNYU.gV5b5wT7KsWvnQ178i
 UeCPztRWz6J7QC.XYpcY7wJ4DUa3xa5TGfekMniFmNlAmCUxAJYcehV0P45CQqW64ksuAMi3sKsv
 Y5d5DxDhYgmcmSiy7w5kVQ_YZMQlx0Yf1hoZuy58ybmgM2OqBaVLNbwDKx5uRPri0P7A4KYkT4zY
 g7pBK3muJtEffIfEturuhkpaC2OcY5ZBY8yrcDao1fYPTpPj3t9c-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 29 Jun 2020 18:36:07 +0000
Received: by smtp420.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID fe3990c2c42a706576896e64c3c5270d;
          Mon, 29 Jun 2020 16:24:38 +0000 (UTC)
Subject: Re: [PATCH] ima: Rename internal audit rule functions
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200629153037.337349-1-tyhicks@linux.microsoft.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <71e9960a-cc98-a480-d65b-ac40f4de9a9c@schaufler-ca.com>
Date:   Mon, 29 Jun 2020 09:24:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200629153037.337349-1-tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.16138 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/29/2020 8:30 AM, Tyler Hicks wrote:
> Rename IMA's internal audit rule functions from security_filter_rule_*()
> to ima_audit_rule_*(). This avoids polluting the security_* namespace,
> which is typically reserved for general security subsystem
> infrastructure, and better aligns the IMA function names with the names
> of the LSM hooks.
>
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> Suggested-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>
> Developed on top of next-integrity-testing, commit cd1d8603df60 ("IMA:
> Add audit log for failure conditions"), plus this patch series:
>
>  [PATCH v2 00/11] ima: Fix rule parsing bugs and extend KEXEC_CMDLINE rule support
>  https://lore.kernel.org/linux-integrity/20200626223900.253615-1-tyhicks@linux.microsoft.com/T/#t
>
> This patch has dependencies on the above patch series.
>
> Tested with and without CONFIG_IMA_LSM_RULES enabled by attempting to
> load IMA policy with rules containing the subj_role=foo conditional.
> Build logs are clean in both configurations. The IMA policy was first
> loaded without and then with a valid AppArmor profile named "foo". The
> behavior is the same before and after this patch is applied:
>
>                   | CONFIG_IMA_LSM_RULES=n   | CONFIG_IMA_LSM_RULES=y
> -----------------------------------------------------------------------
>  Without Profile  |  IMA policy load fails   | IMA policy load fails
>  With Profile     |  IMA policy load fails   | IMA policy load succeeds
>
>  security/integrity/ima/ima.h        | 16 +++++++--------
>  security/integrity/ima/ima_policy.c | 30 +++++++++++++----------------
>  2 files changed, 21 insertions(+), 25 deletions(-)
>
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index ff2bf57ff0c7..5d62ee8319f4 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -419,24 +419,24 @@ static inline void ima_free_modsig(struct modsig *modsig)
>  /* LSM based policy rules require audit */
>  #ifdef CONFIG_IMA_LSM_RULES
>  
> -#define security_filter_rule_init security_audit_rule_init
> -#define security_filter_rule_free security_audit_rule_free
> -#define security_filter_rule_match security_audit_rule_match
> +#define ima_audit_rule_init security_audit_rule_init
> +#define ima_audit_rule_free security_audit_rule_free
> +#define ima_audit_rule_match security_audit_rule_match
>  
>  #else
>  
> -static inline int security_filter_rule_init(u32 field, u32 op, char *rulestr,
> -					    void **lsmrule)
> +static inline int ima_audit_rule_init(u32 field, u32 op, char *rulestr,
> +				      void **lsmrule)
>  {
>  	return -EINVAL;
>  }
>  
> -static inline void security_filter_rule_free(void *lsmrule)
> +static inline void ima_audit_rule_free(void *lsmrule)
>  {
>  }
>  
> -static inline int security_filter_rule_match(u32 secid, u32 field, u32 op,
> -					     void *lsmrule)
> +static inline int ima_audit_rule_match(u32 secid, u32 field, u32 op,
> +				       void *lsmrule)
>  {
>  	return -EINVAL;
>  }
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 294323b36d06..60894656a4b7 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -258,7 +258,7 @@ static void ima_lsm_free_rule(struct ima_rule_entry *entry)
>  	int i;
>  
>  	for (i = 0; i < MAX_LSM_RULES; i++) {
> -		security_filter_rule_free(entry->lsm[i].rule);
> +		ima_audit_rule_free(entry->lsm[i].rule);
>  		kfree(entry->lsm[i].args_p);
>  	}
>  }
> @@ -308,10 +308,9 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
>  		 */
>  		entry->lsm[i].args_p = NULL;
>  
> -		security_filter_rule_init(nentry->lsm[i].type,
> -					  Audit_equal,
> -					  nentry->lsm[i].args_p,
> -					  &nentry->lsm[i].rule);
> +		ima_audit_rule_init(nentry->lsm[i].type, Audit_equal,
> +				    nentry->lsm[i].args_p,
> +				    &nentry->lsm[i].rule);
>  		if (!nentry->lsm[i].rule)
>  			pr_warn("rule for LSM \'%s\' is undefined\n",
>  				entry->lsm[i].args_p);
> @@ -495,18 +494,16 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  		case LSM_OBJ_ROLE:
>  		case LSM_OBJ_TYPE:
>  			security_inode_getsecid(inode, &osid);
> -			rc = security_filter_rule_match(osid,
> -							rule->lsm[i].type,
> -							Audit_equal,
> -							rule->lsm[i].rule);
> +			rc = ima_audit_rule_match(osid, rule->lsm[i].type,
> +						  Audit_equal,
> +						  rule->lsm[i].rule);
>  			break;
>  		case LSM_SUBJ_USER:
>  		case LSM_SUBJ_ROLE:
>  		case LSM_SUBJ_TYPE:
> -			rc = security_filter_rule_match(secid,
> -							rule->lsm[i].type,
> -							Audit_equal,
> -							rule->lsm[i].rule);
> +			rc = ima_audit_rule_match(secid, rule->lsm[i].type,
> +						  Audit_equal,
> +						  rule->lsm[i].rule);
>  		default:
>  			break;
>  		}
> @@ -901,10 +898,9 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
>  		return -ENOMEM;
>  
>  	entry->lsm[lsm_rule].type = audit_type;
> -	result = security_filter_rule_init(entry->lsm[lsm_rule].type,
> -					   Audit_equal,
> -					   entry->lsm[lsm_rule].args_p,
> -					   &entry->lsm[lsm_rule].rule);
> +	result = ima_audit_rule_init(entry->lsm[lsm_rule].type, Audit_equal,
> +				     entry->lsm[lsm_rule].args_p,
> +				     &entry->lsm[lsm_rule].rule);
>  	if (!entry->lsm[lsm_rule].rule) {
>  		pr_warn("rule for LSM \'%s\' is undefined\n",
>  			entry->lsm[lsm_rule].args_p);
