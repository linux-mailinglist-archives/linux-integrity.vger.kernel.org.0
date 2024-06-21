Return-Path: <linux-integrity+bounces-2908-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A73BD912BBE
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 18:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C53A28901A
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 16:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B5E15FCFB;
	Fri, 21 Jun 2024 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="D1OZOPJD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612E115FA94
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 16:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988666; cv=none; b=raeeG+CZD3DIsnx/CGD/AxonNt9NyRc4fI23Nr35SkqHmY7fHTb3r6S7HeAt1BN2qMQSt+96iIF26gB8m7cIlOH7bSBCM5l6wHQX9p8GLVEyh9Wo8pvrTxEcp6tsHp+A2dVE5fYzu9BNMEk3OSCwm3HwER4OniU9FbAGXQW2yGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988666; c=relaxed/simple;
	bh=IZ4Cnnxk3XF7uvCUsWi/i38UQ2fJzqrI6jo78DbBRUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lrqQF8MSVs7l8KzP5cYnYqMSspLP0thxSd4b6g0xekEGl0jAn1QG3p7IYWHyZZuybHgYak2tbDDc5v0iBobgJeSrnkqS/lCizYOMW/i5YiKIM5374qyFTsL48nZsMk4ZuXLFVi5mApKKTWo6hfvGnhOH0FGjcRblABFipl1d35Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=D1OZOPJD; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-63bce128c70so17279077b3.0
        for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 09:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718988663; x=1719593463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSrhlkWdX6A/JwQnL1qGyp7h9CQ4fvs211cMTRuxiNQ=;
        b=D1OZOPJDKqfKk8kKH2DSz5kN68XqSbmDRPGVtdetr0D+mzIrCCkISOJVimj9i7iFpx
         pg2gNK9MYGg6jZDx/e7/VtqrFfE0+CKTU20yx5tG8PklFeT2PguoLYUoV0vBE2M/np+F
         AODEQ1AEkAwgzNUc5iPrCO1YmFJRXsA0o/96u1r5ljE47CHHvzq4yIdPeGDhTtpVEYMs
         /ObRwcypxgB0vw1YB8g7K4l2LspjvN+lsQBZmdesF4svh2ipVpcW7VOqZ4wi7kQ8sjc3
         xKBfPAVJZTn5uq+VIfeO4Q6+Ar/g0Q1dlpzxDdQDUE/72qkdfdfxEcsOMvGNoaGve7VL
         YfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718988663; x=1719593463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tSrhlkWdX6A/JwQnL1qGyp7h9CQ4fvs211cMTRuxiNQ=;
        b=DHDpRF5BtPfSo35//2jsnyQgvmQt6GKtXcgnF1Cy7aKJhUNYIaHl8V7SbxQ0/3C8Q4
         aNq/cAgO6c5+2M0pOhhq528U0wYrWm4sr/x1q26SwFmunP3D2fSeAjhLXiGOWiDdweqp
         1cJatTdDzXATg6mWzYWThfgs+F/qK/Foz253gZCEFWr4bPuOmX2ljbd9O4gu7lTMbevo
         3er6uHpliVn8HgnnyslctmwdNL+De8xqcKo8uRlvTD46R8Ob8N2fjvqowkFpsPRRYzC2
         xCg876dV/DrVR3Laou0DlLWlp9FLiOUuHxUxsGqOH+LP7YuDsos6lNbRsow7lLpaiB4k
         1FvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg91PcN1dCiGr5iNQCa5/ForbsqNbhmKiWtS6CTw3hdLWq8BNih5iLXRMUCe/aqTH+P8HIHGp2E8SLcwzPSy3CrTUfnDkbbmwPIzsucihj
X-Gm-Message-State: AOJu0Yz6vub/bPePvjfxzMLWqBeNvDcC2tsPsmZRbTGAY9jbIZ94dKJy
	vr979pn4ow5wJzjHOCLe2mHvRdZVKbzpwYF4RpRYB+ihJzJGDuVIcXTUN+MvhnlFplY7cKUU0uG
	1+o9fP+qbmTsc0MAmtGTIWOH0d1XfEeZfTE7L0pmht9A5k7c=
X-Google-Smtp-Source: AGHT+IFgmp5RsbF5wpzYfKgtVbH0mSqcmQYprYV8KJXjbZUbpr+S0cYL1rPczjsK1o6CAOpABdLrNgJCmL2S+1BoVtU=
X-Received: by 2002:a0d:d692:0:b0:63b:ab21:4f8f with SMTP id
 00721157ae682-64134290c70mr3646647b3.12.1718988663220; Fri, 21 Jun 2024
 09:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215221636.105680-1-casey@schaufler-ca.com> <20231215221636.105680-2-casey@schaufler-ca.com>
In-Reply-To: <20231215221636.105680-2-casey@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 21 Jun 2024 12:50:51 -0400
Message-ID: <CAHC9VhT+QUuwH9Dv2PA9vUrx4ovA_HZsJ4ijTMEk9BVE4tLy8g@mail.gmail.com>
Subject: Re: [PATCH v39 01/42] integrity: disassociate ima_filter_rule from security_audit_rule
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, mic@digikod.net, 
	linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 5:16=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> Create real functions for the ima_filter_rule interfaces.
> These replace #defines that obscure the reuse of audit
> interfaces. The new functions are put in security.c because
> they use security module registered hooks that we don't
> want exported.
>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> To: Mimi Zohar <zohar@linux.ibm.com>
> Cc: linux-integrity@vger.kernel.org
> ---
>  include/linux/security.h     | 24 ++++++++++++++++++++++++
>  security/integrity/ima/ima.h | 26 --------------------------
>  security/security.c          | 21 +++++++++++++++++++++
>  3 files changed, 45 insertions(+), 26 deletions(-)

Mimi, Roberto, are you both okay if I merge this into the lsm/dev
branch?  The #define approach taken with the ima_filter_rule_XXX
macros likely contributed to the recent problem where the build
problem caused by the new gfp_t parameter was missed during review;
I'd like to get this into an upstream tree independent of the larger
stacking effort as I believe it has standalone value.

> diff --git a/include/linux/security.h b/include/linux/security.h
> index 750130a7b9dd..4790508818ee 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -2009,6 +2009,30 @@ static inline void security_audit_rule_free(void *=
lsmrule)
>  #endif /* CONFIG_SECURITY */
>  #endif /* CONFIG_AUDIT */
>
> +#if defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY)
> +int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrul=
e);
> +int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
> +void ima_filter_rule_free(void *lsmrule);
> +
> +#else
> +
> +static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
> +                                          void **lsmrule)
> +{
> +       return 0;
> +}
> +
> +static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
> +                                           void *lsmrule)
> +{
> +       return 0;
> +}
> +
> +static inline void ima_filter_rule_free(void *lsmrule)
> +{ }
> +
> +#endif /* defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY) */
> +
>  #ifdef CONFIG_SECURITYFS
>
>  extern struct dentry *securityfs_create_file(const char *name, umode_t m=
ode,
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index c29db699c996..560d6104de72 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -420,32 +420,6 @@ static inline void ima_free_modsig(struct modsig *mo=
dsig)
>  }
>  #endif /* CONFIG_IMA_APPRAISE_MODSIG */
>
> -/* LSM based policy rules require audit */
> -#ifdef CONFIG_IMA_LSM_RULES
> -
> -#define ima_filter_rule_init security_audit_rule_init
> -#define ima_filter_rule_free security_audit_rule_free
> -#define ima_filter_rule_match security_audit_rule_match
> -
> -#else
> -
> -static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
> -                                      void **lsmrule)
> -{
> -       return -EINVAL;
> -}
> -
> -static inline void ima_filter_rule_free(void *lsmrule)
> -{
> -}
> -
> -static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
> -                                       void *lsmrule)
> -{
> -       return -EINVAL;
> -}
> -#endif /* CONFIG_IMA_LSM_RULES */
> -
>  #ifdef CONFIG_IMA_READ_POLICY
>  #define        POLICY_FILE_FLAGS       (S_IWUSR | S_IRUSR)
>  #else
> diff --git a/security/security.c b/security/security.c
> index d7b15ea67c3f..8e5379a76369 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -5350,6 +5350,27 @@ int security_audit_rule_match(u32 secid, u32 field=
, u32 op, void *lsmrule)
>  }
>  #endif /* CONFIG_AUDIT */
>
> +#ifdef CONFIG_IMA_LSM_RULES
> +/*
> + * The integrity subsystem uses the same hooks as
> + * the audit subsystem.
> + */
> +int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrul=
e)
> +{
> +       return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmr=
ule);
> +}
> +
> +void ima_filter_rule_free(void *lsmrule)
> +{
> +       call_void_hook(audit_rule_free, lsmrule);
> +}
> +
> +int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
> +{
> +       return call_int_hook(audit_rule_match, 0, secid, field, op, lsmru=
le);
> +}
> +#endif /* CONFIG_IMA_LSM_RULES */
> +
>  #ifdef CONFIG_BPF_SYSCALL
>  /**
>   * security_bpf() - Check if the bpf syscall operation is allowed
> --
> 2.41.0
>


--=20
paul-moore.com

