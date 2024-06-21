Return-Path: <linux-integrity+bounces-2911-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEC6912E76
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 22:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFFD287893
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 20:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3734816D311;
	Fri, 21 Jun 2024 20:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f1uC/MeS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25D615F30F;
	Fri, 21 Jun 2024 20:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719001661; cv=none; b=KwjTxaingAPQ3VKVzcEmb1wM5puDU45x8pIs6ohenKEAVyMIbwOkbhG89kHp77GjySg/fLw/yR0aPnEUG6LkNNzNYhcjYzC1XLzSPF5dQAVwTFIUrv7OKUYCRA3Dic6jbnwIkPDFwOHvLh+S//StClOQcIZTr91WxjL2BEtwenI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719001661; c=relaxed/simple;
	bh=K0QZysU1629Ws0/mb6DaaP3/T+9bd+m8dEky9H/JeT8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=uUt55ZwTHnQaGuDgPMne3NVtaBp95saSzoN8fAP408yNw8gorB2oXNTgPBGbJH7jkjE/B4SWjIRFIEf0qFGe5noUEm6xCo5q/lfo/fNZTJAvr7Hx8yW7osn9jYg5kHitWnG9bnqZsyM624iomBoj3X78xoYsZ+L9oLySlK8YwsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f1uC/MeS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LKR88t020798;
	Fri, 21 Jun 2024 20:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=pp1; bh=
	v/ZzAE1siODvXHguAt3ifGrf70nhriEjbUc1a8Jzwq0=; b=f1uC/MeSyAaea6JF
	raI9jhotxCGfD9Zve1CRguweGG8yRqnUl/4dZDV7uv1IbVhIbmYKm3C/QyjAIa1o
	tVIX/f8jSvjqSWbkTf+vbiemUWffpdZxiTc8HC1rDS2Kzl+tSUKyKFF+Kg+TYxJh
	gZFn/h4ChsdN5UNo4bgr15eF1kPt+mXJFJt2pYDjxz6Dr7ua/BIwe6q9Y4YR9ubE
	0j1N29WwpGyhjkCPR6xiCw1s7Je4FQjL/0UzEGVo+lduQoZQrXIc8n4KIKfJHB7c
	Dso1bSWPy9B1fWNZZdgtM5MEaHVwaHGARATfz4FkYlDcIIwgvx90rleyRwOeItwb
	/JkFFg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ywfy483sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 20:27:09 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45LKR85F020797;
	Fri, 21 Jun 2024 20:27:08 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ywfy483r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 20:27:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45LJORPR031899;
	Fri, 21 Jun 2024 20:23:46 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yvrsps3q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 20:23:46 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45LKNhC616974394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 20:23:46 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A766758056;
	Fri, 21 Jun 2024 20:23:43 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C2B25803F;
	Fri, 21 Jun 2024 20:23:42 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.41.136])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Jun 2024 20:23:42 +0000 (GMT)
Message-ID: <fbf7f344c518d70833398c2365bb2029480bd628.camel@linux.ibm.com>
Subject: Re: [PATCH v39 01/42] integrity: disassociate ima_filter_rule from
 security_audit_rule
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>,
        Roberto Sassu
 <roberto.sassu@huawei.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, mic@digikod.net,
        linux-integrity@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
Date: Fri, 21 Jun 2024 16:23:41 -0400
In-Reply-To: <CAHC9VhSY2NyqTD35H7yb8qJtJF5+1=Z4MHy_ZpP_b7YDT-Mmtw@mail.gmail.com>
References: <20231215221636.105680-1-casey@schaufler-ca.com>
	 <20231215221636.105680-2-casey@schaufler-ca.com>
	 <CAHC9VhT+QUuwH9Dv2PA9vUrx4ovA_HZsJ4ijTMEk9BVE4tLy8g@mail.gmail.com>
	 <CAHC9VhSY2NyqTD35H7yb8qJtJF5+1=Z4MHy_ZpP_b7YDT-Mmtw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-25.el8_9) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tbOBu7IVJSbRsLNFJ_9ruX3sQWtqca8s
X-Proofpoint-GUID: ol-Mel3agjLg5v6p1Q1qylzGa5vy-XlB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_12,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210149

On Fri, 2024-06-21 at 15:07 -0400, Paul Moore wrote:
> On Fri, Jun 21, 2024 at 12:50 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Dec 15, 2023 at 5:16 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > Create real functions for the ima_filter_rule interfaces.
> > > These replace #defines that obscure the reuse of audit
> > > interfaces. The new functions are put in security.c because
> > > they use security module registered hooks that we don't
> > > want exported.
> > > 
> > > Acked-by: Paul Moore <paul@paul-moore.com>
> > > Reviewed-by: John Johansen <john.johansen@canonical.com>
> > > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > > To: Mimi Zohar <zohar@linux.ibm.com>
> > > Cc: linux-integrity@vger.kernel.org
> > > ---
> > >  include/linux/security.h     | 24 ++++++++++++++++++++++++
> > >  security/integrity/ima/ima.h | 26 --------------------------
> > >  security/security.c          | 21 +++++++++++++++++++++
> > >  3 files changed, 45 insertions(+), 26 deletions(-)
> > 
> > Mimi, Roberto, are you both okay if I merge this into the lsm/dev
> > branch?  The #define approach taken with the ima_filter_rule_XXX
> > macros likely contributed to the recent problem where the build
> > problem caused by the new gfp_t parameter was missed during review;
> > I'd like to get this into an upstream tree independent of the larger
> > stacking effort as I believe it has standalone value.
> 
> ... and I just realized neither Mimi or Roberto were directly CC'd on
> that last email, oops.  Fixed.

Paul, I do see things posted on the linux-integrity mailing list pretty quickly.
Unfortunately, something came up midday and I'm just seeing this now.  As for
Roberto, it's probably a time zone issue.

The patch looks ok, but I haven't had a chance to apply or test it.  I'll look
at it over the weekend and get back to you.

Mimi

> 
> > > diff --git a/include/linux/security.h b/include/linux/security.h
> > > index 750130a7b9dd..4790508818ee 100644
> > > --- a/include/linux/security.h
> > > +++ b/include/linux/security.h
> > > @@ -2009,6 +2009,30 @@ static inline void security_audit_rule_free(void *lsmrule)
> > >  #endif /* CONFIG_SECURITY */
> > >  #endif /* CONFIG_AUDIT */
> > > 
> > > +#if defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY)
> > > +int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
> > > +int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
> > > +void ima_filter_rule_free(void *lsmrule);
> > > +
> > > +#else
> > > +
> > > +static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
> > > +                                          void **lsmrule)
> > > +{
> > > +       return 0;
> > > +}
> > > +
> > > +static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
> > > +                                           void *lsmrule)
> > > +{
> > > +       return 0;
> > > +}
> > > +
> > > +static inline void ima_filter_rule_free(void *lsmrule)
> > > +{ }
> > > +
> > > +#endif /* defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY) */
> > > +
> > >  #ifdef CONFIG_SECURITYFS
> > > 
> > >  extern struct dentry *securityfs_create_file(const char *name, umode_t mode,
> > > diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> > > index c29db699c996..560d6104de72 100644
> > > --- a/security/integrity/ima/ima.h
> > > +++ b/security/integrity/ima/ima.h
> > > @@ -420,32 +420,6 @@ static inline void ima_free_modsig(struct modsig *modsig)
> > >  }
> > >  #endif /* CONFIG_IMA_APPRAISE_MODSIG */
> > > 
> > > -/* LSM based policy rules require audit */
> > > -#ifdef CONFIG_IMA_LSM_RULES
> > > -
> > > -#define ima_filter_rule_init security_audit_rule_init
> > > -#define ima_filter_rule_free security_audit_rule_free
> > > -#define ima_filter_rule_match security_audit_rule_match
> > > -
> > > -#else
> > > -
> > > -static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
> > > -                                      void **lsmrule)
> > > -{
> > > -       return -EINVAL;
> > > -}
> > > -
> > > -static inline void ima_filter_rule_free(void *lsmrule)
> > > -{
> > > -}
> > > -
> > > -static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
> > > -                                       void *lsmrule)
> > > -{
> > > -       return -EINVAL;
> > > -}
> > > -#endif /* CONFIG_IMA_LSM_RULES */
> > > -
> > >  #ifdef CONFIG_IMA_READ_POLICY
> > >  #define        POLICY_FILE_FLAGS       (S_IWUSR | S_IRUSR)
> > >  #else
> > > diff --git a/security/security.c b/security/security.c
> > > index d7b15ea67c3f..8e5379a76369 100644
> > > --- a/security/security.c
> > > +++ b/security/security.c
> > > @@ -5350,6 +5350,27 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
> > >  }
> > >  #endif /* CONFIG_AUDIT */
> > > 
> > > +#ifdef CONFIG_IMA_LSM_RULES
> > > +/*
> > > + * The integrity subsystem uses the same hooks as
> > > + * the audit subsystem.
> > > + */
> > > +int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
> > > +{
> > > +       return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
> > > +}
> > > +
> > > +void ima_filter_rule_free(void *lsmrule)
> > > +{
> > > +       call_void_hook(audit_rule_free, lsmrule);
> > > +}
> > > +
> > > +int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
> > > +{
> > > +       return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
> > > +}
> > > +#endif /* CONFIG_IMA_LSM_RULES */
> > > +
> > >  #ifdef CONFIG_BPF_SYSCALL
> > >  /**
> > >   * security_bpf() - Check if the bpf syscall operation is allowed
> > > --
> > > 2.41.0


