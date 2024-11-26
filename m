Return-Path: <linux-integrity+bounces-4203-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B969D92C9
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Nov 2024 08:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AB59B233D7
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Nov 2024 07:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D034D199924;
	Tue, 26 Nov 2024 07:50:30 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8664C190072;
	Tue, 26 Nov 2024 07:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732607430; cv=none; b=fI0bv7Uslk1H28f8i0lv+XTq4rIajxcptP+OI9Ki9Pqp0k2LpyKf/tqvIyCfK9VG9xZ+pwJGZ4vdAvvn8L8CazgFCcGP351OqrAGmzbDsNPhwRs6hgBD0VOcT4Y7KkMTMlCT4i3pf3sKWQATDf7KtN1F5kqm+5hft2oNmEn8XZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732607430; c=relaxed/simple;
	bh=Ng0CqI/QswNyp0LtIzxZD+B8Cj05Geu2R/eOST9w10o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fDQ38buItMnJGQvi0UucF7I6Bs8rq6ilpIENPtFedGNZinq4zyicG1/ONlPVaY0U9wdyzxH9Z4iVIumM+l5ez6lFSQ5nFKMvK3Z/PGFSXZ2/IEueX3IMyubJuaOSHV9dzfYH3bKPqpPYXnNg6eOa+4qwj82fXvUqgrjWw28zj6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4XyDjC3DYXz9v7J5;
	Tue, 26 Nov 2024 15:29:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 94F7414040D;
	Tue, 26 Nov 2024 15:50:12 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwD3XHyrfUVngopTAg--.23041S2;
	Tue, 26 Nov 2024 08:50:12 +0100 (CET)
Message-ID: <91a227f3b57374a8aece5480f285c433d3888572.camel@huaweicloud.com>
Subject: Re: ima: property parameter unused in ima_match_rules()
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Casey Schaufler <casey@schaufler-ca.com>, Christian
	=?ISO-8859-1?Q?G=F6ttsche?=
	 <cgzones@googlemail.com>, linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, "M: Roberto Sassu"
 <roberto.sassu@huawei.com>, "M: Dmitry Kasatkin"
 <dmitry.kasatkin@gmail.com>,  "R: Eric Snowberg"
 <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, LSM List
 <linux-security-module@vger.kernel.org>
Date: Tue, 26 Nov 2024 08:49:59 +0100
In-Reply-To: <92e5fd64-8c75-4e82-981a-846364fc7a38@schaufler-ca.com>
References: 
	<CAJ2a_DeUX9UdAYOo9OwG-yXSH1etKQZortPcyxfzG70K3N+g7g@mail.gmail.com>
	 <92e5fd64-8c75-4e82-981a-846364fc7a38@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwD3XHyrfUVngopTAg--.23041S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4kKr4rJFW8ZFWfKF18uFg_yoW8ZF4Upa
	1kKFWUGr1kZFy7KFnrC3Wj9ayFgFW5W3W7Gry5Ka4qvF98JF1jqr4rJrya9r45XF1rAw4S
	qw4qkr4aywsF9aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBGdD4PMHhgAFsm

On Mon, 2024-11-25 at 10:23 -0800, Casey Schaufler wrote:
> On 11/25/2024 3:38 AM, Christian G=C3=B6ttsche wrote:
> > Hi,
> >=20
> > I noticed that the `prop` parameter of `ima_match_rules()` is
> > currently unused (due to shadowing).
> > Is that by design or a mishap of the recent rework?
> >=20
> > Related commits:
> >=20
> > 37f670a ("lsm: use lsm_prop in security_current_getsecid")
> > 870b7fd ("lsm: use lsm_prop in security_audit_rule_match")
> > 07f9d2c ("lsm: use lsm_prop in security_inode_getsecid")
>=20
> The shadowing was inadvertent. The use of lsm_prop data is
> corrected by this patch.

Thanks Casey. Yes, this is what I had in mind.

Roberto

> ---
>  security/integrity/ima/ima_policy.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima=
/ima_policy.c
> index dbfd554b4624..21a8e54c383f 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -635,7 +635,7 @@ static bool ima_match_rules(struct ima_rule_entry *ru=
le,
>  		return false;
>  	for (i =3D 0; i < MAX_LSM_RULES; i++) {
>  		int rc =3D 0;
> -		struct lsm_prop prop =3D { };
> +		struct lsm_prop inode_prop =3D { };
> =20
>  		if (!lsm_rule->lsm[i].rule) {
>  			if (!lsm_rule->lsm[i].args_p)
> @@ -649,15 +649,16 @@ static bool ima_match_rules(struct ima_rule_entry *=
rule,
>  		case LSM_OBJ_USER:
>  		case LSM_OBJ_ROLE:
>  		case LSM_OBJ_TYPE:
> -			security_inode_getlsmprop(inode, &prop);
> -			rc =3D ima_filter_rule_match(&prop, lsm_rule->lsm[i].type,
> +			security_inode_getlsmprop(inode, &inode_prop);
> +			rc =3D ima_filter_rule_match(&inode_prop,
> +						   lsm_rule->lsm[i].type,
>  						   Audit_equal,
>  						   lsm_rule->lsm[i].rule);
>  			break;
>  		case LSM_SUBJ_USER:
>  		case LSM_SUBJ_ROLE:
>  		case LSM_SUBJ_TYPE:
> -			rc =3D ima_filter_rule_match(&prop, lsm_rule->lsm[i].type,
> +			rc =3D ima_filter_rule_match(prop, lsm_rule->lsm[i].type,
>  						   Audit_equal,
>  						   lsm_rule->lsm[i].rule);
>  			break;
>=20


