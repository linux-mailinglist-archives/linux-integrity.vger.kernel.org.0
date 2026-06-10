Return-Path: <linux-integrity+bounces-9786-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t4c6CD94KWpiXQMAu9opvQ
	(envelope-from <linux-integrity+bounces-9786-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Jun 2026 16:44:15 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 814B066A592
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Jun 2026 16:44:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=eOG+YCS5;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9786-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9786-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F1AA314E945
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Jun 2026 14:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B96E1A9F83;
	Wed, 10 Jun 2026 14:32:52 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21D132B9A1
	for <linux-integrity@vger.kernel.org>; Wed, 10 Jun 2026 14:32:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781101972; cv=none; b=bXjqCvnQXavRMpQCFGb8bCHK66NohHKLDmowQOvr0+Se+rDwAnx2doBPawtiV/OJdYl5lnsKnQEHO/FBSpJQgncy3nUm2MQa+sJ1sFmIL/PKVQF131oW43/hcSZyyW7PCxGNWOHxTt9JQ4VxnFkRD8hVuqOiSZAgAqKqjpTLKAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781101972; c=relaxed/simple;
	bh=Q9t7o+aPAP1oyEoGdLw9qN6K2JGO4HpeWDaErWHuWZ0=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Ns2MITNDYPFeAq6G3ikToT0g8FaX/UQQNebPd1bpOJCuAsy+nkqb1KSFvRnlfpmbafsx9gF6u4no5sqqYxQt2MX7Xc47GrR6C0dFQd7AQXShidMjsTUB0Mc4k3GxhRujMAPMVFE6Cm7ROq4hx4F/8GX4zzDUH+3h2YY5DcidqTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eOG+YCS5; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A6d0sd3652627;
	Wed, 10 Jun 2026 14:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZDQICk
	XtUu3TTsVfzhCaD3W5LxtxLnW0SZxKQ7MJyHY=; b=eOG+YCS5qSLmjtmlM/+wRU
	KMLI5TRMbbLeG5LdsuFEJCLxSnj7kC1BwzYtcri+9h3Op6n8GKzHIyuzmrJ8wZ2+
	uaKSwQXjHMGiUYqJkoZj+Bp4jpv9WREckVfS8Zd3r0v8Il4gsppiKbHbcSu2JIWb
	OiIyymOpmemBrCFgeHP3j/kC6xivUQRJtClUR+NqIfWcbpS8DMOg3O7Gd+9JuwZY
	J2YyesNm178w5TFNj84KdG9fVI6xvLCN7DYF7ir6/TUKLyCgAtbFJy9nRRRCObEg
	n5Jm5nGcFYeYLDjFbzzDcPH2m6OIhI84TxF1f6B8TkbAP3s4bedDXDtEyq4TT9IA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yj1c6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:32:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AEJpS9009331;
	Wed, 10 Jun 2026 14:32:30 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emych6x0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:32:30 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65AEWTxr14221928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 14:32:30 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABBFE58050;
	Wed, 10 Jun 2026 14:32:29 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 187CB58045;
	Wed, 10 Jun 2026 14:32:29 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.2.140])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 14:32:28 +0000 (GMT)
Message-ID: <f48148da72e9111235cb06d9c4d6c959d5c67035.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH v3 1/2] ima: measure loaded policy after write on
 securityfs policy file
From: Mimi Zohar <zohar@linux.ibm.com>
To: Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org,
        dmitry.kasatkin@gmail.com, roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com
In-Reply-To: <20260526135118.289633-2-enrico.bravi@polito.it>
References: <20260526135118.289633-1-enrico.bravi@polito.it>
	 <20260526135118.289633-2-enrico.bravi@polito.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 10:32:28 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEzNSBTYWx0ZWRfX1FR1ccEGqEtO
 d1QSfMnXwx1L/3jPeQdUwuiLoLmG3ykiTQfhbQmGpzMboaZAv8PHBJvc5X0x5Nf7GP5b0HN1uxc
 ghYg3I1MnCfuPmRSrxo2bG9Y9vSEd8dJsgJ9nwPyKm25ufdo0NWYdPRAM9lJC1gqsm2G/gor54i
 +AkGSsJCwmgTQQeFXuQYkybI+heG83Tv+1T+DT6EOADbiaSQGaszoGM8GHM9EeR34fg2HfPqOE0
 eKpt4GAKB2hlIJyvTNy23916PJnZmqE+S4ANlWSMoumsrJCye+nqCwYVjYpHY2rtYZYXamaIsgk
 iM+0K7BXtyZSCGG829av8GEBEBIqWqTzNCSVB/wT+K1CJVnUnzACTbjybevH0AZhlIa+7wd4Jzm
 wrenK8S/KP3qdr5Mj02HmF0jzSFz8s9OgGQ/PDbBYLHKzvV9d1BJmpNYiBjemjqHq83n50ETEqk
 57jL+qj8egLzHrbJfUg==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a29757f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=8aJ_icMB-xk5cG5sArUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: aCjwzqZaOlYKBq_UcEgO3kE4U4ZN_jv2
X-Proofpoint-GUID: LhdA4PDDIdj9pQxaTFh6GVNKH6oxJtgF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100135
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9786-lists,linux-integrity=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[polito.it,vger.kernel.org,gmail.com,huawei.com];
	FORGED_RECIPIENTS(0.00)[m:enrico.bravi@polito.it,m:linux-integrity@vger.kernel.org,m:dmitry.kasatkin@gmail.com,m:roberto.sassu@huawei.com,m:eric.snowberg@oracle.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,linux.ibm.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,polito.it:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 814B066A592

On Tue, 2026-05-26 at 15:51 +0200, Enrico Bravi wrote:
> IMA policy can be written multiple times in the securityfs policy file
> at runtime if CONFIG_IMA_WRITE_POLICY=3Dy. When IMA_APPRAISE_POLICY is
> required, the policy needs to be signed to be loaded, writing the absolut=
e
> path of the file containing the new policy:
>=20
> echo /path/of/custom_ima_policy > /sys/kernel/security/ima/policy
>=20
> When this is not required, policy can be written directly, rule by rule:
>=20
> echo -e "measure func=3DBPRM_CHECK mask=3DMAY_EXEC\n" \
>         "audit func=3DBPRM_CHECK mask=3DMAY_EXEC\n" \
>      > /sys/kernel/security/ima/policy
>=20
> In this case, a new policy can be loaded without being measured or
> appraised.
>=20
> Add a new critical data record to measure the textual policy
> representation when it becomes effective.
> To verify the template data hash value, convert the buffer policy data
> to binary:
> grep "ima_policy_loaded" \
> 	/sys/kernel/security/integrity/ima/ascii_runtime_measurements | \
> 	tail -1 | cut -d' ' -f 6 | xxd -r -p | sha256sum
>=20
> Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>

Thanks, Enrico.  Just a few inline comments.

> ---
>  security/integrity/ima/ima.h        |  1 +
>  security/integrity/ima/ima_efi.c    |  2 ++
>  security/integrity/ima/ima_fs.c     |  1 +
>  security/integrity/ima/ima_policy.c | 55 +++++++++++++++++++++++++++--
>  4 files changed, 57 insertions(+), 2 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 89ebe98ffc5e..a223d3f30d88 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -425,6 +425,7 @@ void *ima_policy_start(struct seq_file *m, loff_t *po=
s);
>  void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos);
>  void ima_policy_stop(struct seq_file *m, void *v);
>  int ima_policy_show(struct seq_file *m, void *v);
> +void ima_measure_loaded_policy(void);
> =20
>  /* Appraise integrity measurements */
>  #define IMA_APPRAISE_ENFORCE	0x01
> diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/im=
a_efi.c
> index 138029bfcce1..8e9f85ec9a86 100644
> --- a/security/integrity/ima/ima_efi.c
> +++ b/security/integrity/ima/ima_efi.c
> @@ -60,6 +60,8 @@ static const char * const sb_arch_rules[] =3D {
>  #endif
>  #if IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) && IS_ENABLED(CONFIG_IM=
A_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY)
>  	"appraise func=3DPOLICY_CHECK appraise_type=3Dimasig",
> +#else
> +	"measure func=3DCRITICAL_DATA label=3Dima_policy",
>  #endif

 None of the other arch "measure" policy rules are conditional.  Should the=
 new
"measure" rule be limited?

>  	"measure func=3DMODULE_CHECK",
>  	NULL
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima=
_fs.c
> index 012a58959ff0..75cb308cf01f 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -476,6 +476,7 @@ static int ima_release_policy(struct inode *inode, st=
ruct file *file)
>  	}
> =20
>  	ima_update_policy();
> +	ima_measure_loaded_policy();
>  #if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY=
)
>  	securityfs_remove(file->f_path.dentry);
>  #elif defined(CONFIG_IMA_WRITE_POLICY)
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima=
/ima_policy.c
> index bf2d7ba4c14a..e0b4dae922b6 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -17,6 +17,7 @@
>  #include <linux/slab.h>
>  #include <linux/rculist.h>
>  #include <linux/seq_file.h>
> +#include <linux/vmalloc.h>
>  #include <linux/ima.h>
> =20
>  #include "ima.h"
> @@ -2022,7 +2023,6 @@ const char *const func_tokens[] =3D {
>  	__ima_hooks(__ima_hook_stringify)
>  };
> =20
> -#ifdef	CONFIG_IMA_READ_POLICY

Removing the ifdef, here, does not affect viewing the IMA measurement lists=
, but
allows copying and measuring the policy rules.  Please include a comment in=
 the
patch description.

>  enum {
>  	mask_exec =3D 0, mask_write, mask_read, mask_append
>  };
> @@ -2324,7 +2324,6 @@ int ima_policy_show(struct seq_file *m, void *v)
>  	seq_puts(m, "\n");
>  	return 0;
>  }
> -#endif	/* CONFIG_IMA_READ_POLICY */
> =20
>  #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEY=
RING)
>  /*
> @@ -2381,3 +2380,55 @@ bool ima_appraise_signature(enum kernel_read_file_=
id id)
>  	return found;
>  }
>  #endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
> +

Please add kernel-doc here, something like:

/**
 * ima_measure_loaded_policy - measure the active IMA policy ruleset
 *
 * Must be called with ima_write_mutex held, as it performs two
 * separate RCU read passes over ima_rules and relies on the mutex
 * to prevent concurrent policy updates between them.
 */
> +void ima_measure_loaded_policy(void)
> +{
> +	const char *event_name =3D "ima_policy_loaded";
> +	const char *op =3D "measure_loaded_ima_policy";
> +	const char *audit_cause =3D "ENOMEM";
> +	struct ima_rule_entry *rule_entry;
> +	struct list_head *ima_rules_tmp;
> +	struct seq_file file;
> +	int result =3D -ENOMEM;
> +	size_t file_len;
> +	char rule[255];

The 255-byte buffer may be insufficient for custom policy rules that includ=
e
additional fields such as LSM labels and other file metadata, unlike the si=
mpler
built-in and architecture-specific rules. Please increase the buffer size t=
o
accommodate the worst-case serialized rule length.

> +
> +	/* calculate IMA policy rules memory size */
> +	file.buf =3D rule;
> +	file.read_pos =3D 0;
> +	file.size =3D 255;
> +	file.count =3D 0;
> +

Please add "lockdep_assert_held(&ima_write_mutex);"  here.

> +	rcu_read_lock();
> +	ima_rules_tmp =3D rcu_dereference(ima_rules);
> +	list_for_each_entry_rcu(rule_entry, ima_rules_tmp, list) {
> +		ima_policy_show(&file, rule_entry);
> +		file_len +=3D file.count;
> +		file.count =3D 0;
> +	}

Variables defined on the stack need to be initialized before being used. Pl=
ease
iniitalize file_len to zero.

> +	rcu_read_unlock();
> +
> +	/* copy IMA policy rules to a buffer for measuring */
> +	file.buf =3D vmalloc(file_len);
> +	if (!file.buf) {
> +		integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, event_name,
> +				    op, audit_cause, result, 1);
> +		return;
> +	}
> +
> +	file.read_pos =3D 0;
> +	file.size =3D file_len;
> +	file.count =3D 0;
> +
> +	rcu_read_lock();
> +	ima_rules_tmp =3D rcu_dereference(ima_rules);
> +	list_for_each_entry_rcu(rule_entry, ima_rules_tmp, list) {
> +		ima_policy_show(&file, rule_entry);
> +	}
> +	rcu_read_unlock();
> +
> +	ima_measure_critical_data("ima_policy", event_name, file.buf,
> +				  file.count, false, NULL, 0);
> +
> +	vfree(file.buf);
> +}

Thanks,

Mimi

