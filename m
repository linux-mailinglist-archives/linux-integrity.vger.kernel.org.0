Return-Path: <linux-integrity+bounces-9327-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hgoIHOXR62lERwAAu9opvQ
	(envelope-from <linux-integrity+bounces-9327-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 22:26:13 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F304632F0
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 22:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2DEFE300615E
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 20:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A054A37E2F9;
	Fri, 24 Apr 2026 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eURssOLp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53416347BDC;
	Fri, 24 Apr 2026 20:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777062370; cv=none; b=BImDjcZl7p4H2wVQG46MdOD7VNTZ+N59a1LUnV1zXRAaLjYZ8roRQoL2F47KJ6HCr6aZFRDjgjR3BCBK96k9KXIIBSivxAw2YoEJtU01uQC7cvmBUMv1I1H7Nyw0prZ+8LKfuqagnIKuZLM5/dI4TlAw2W3V6z9A4+jX9c19D4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777062370; c=relaxed/simple;
	bh=Koj4CUktlogAnNVhJjluP/UK0I95wXh5VIxD3ENSAyo=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=VGoKfs9WYnHnegYt4F+JZMf2wN4jDFzS5/u/i/gFhJ4L07q7AFhKTvEZvtb8zhZzgBC7RyPHZT20yUl64aQ0N1ADsMwZlvwPleQjYihjC56tyeZMbaZUkUn5Vo1A1xNkQsFH7i0lYAjFu76rcRtZaflo7//XjnpN1bFyIDDUpTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eURssOLp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63OK2d6f3657864;
	Fri, 24 Apr 2026 20:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qlBu7T
	NKzfpXasOOTL0wruUdS0hFrUoHwLMc6Celeck=; b=eURssOLpdkBlItoz8asJrY
	yJ/U89jyh5uOcODsiIObYY2XdX/9DWggtc0eiovDLm9vHeKUzAV0mQn6ticaa+ou
	MdDzsIPf17Qpp0VdKksledynFUt3NElFO320AO2rnS1b2qgcm8qdStfPJhLh5uB+
	qu+WMY+ClH5YfiAWmxyLdmd1o7QLJ69uF73nO7vNDSnZZi5C2ElEsLG9sJ2bklI5
	x6s43KUwN4DqHAk+GPSRRO5LdUlkc/EX04jgTanfUPfrWfMFSMPOUHrT7CwQ8DOI
	Pi9s9anAmdwJFLy7zOC2eDqbCRkT8zqvULxA11syTD+SISh4flXywUd0MtmxOMIw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu7xt00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 20:25:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63OKKHhC001937;
	Fri, 24 Apr 2026 20:25:34 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkycd2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 20:25:34 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63OKPXjv27656892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Apr 2026 20:25:33 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75C4558055;
	Fri, 24 Apr 2026 20:25:33 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A465E58043;
	Fri, 24 Apr 2026 20:25:31 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.11.225])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Apr 2026 20:25:31 +0000 (GMT)
Message-ID: <43ff6ca37df45ed53061dad46e9d31a5118e5714.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v3 2/4] security: ima: call ima_init() again at
 late_initcall_sync for defered TPM
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jonathan McDowell <noodles@earth.li>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, jarkko@kernel.org, jgg@ziepe.ca,
        sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org,
        joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org, noodles@meta.com,
        sebastianene@google.com, Yeoreum Yun <yeoreum.yun@arm.com>
In-Reply-To: <5552c20c6d6d2ae3bbb6b35124af5d98d2f79163.1777036497.git.noodles@meta.com>
References: <cover.1777036497.git.noodles@meta.com>
	 <5552c20c6d6d2ae3bbb6b35124af5d98d2f79163.1777036497.git.noodles@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 16:25:31 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: bIZjqaR-Z68OsHDjoYn96_ZIv_N3PmeO
X-Authority-Analysis: v=2.4 cv=Ksp9H2WN c=1 sm=1 tr=0 ts=69ebd1bf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=i188C8hGdHaRUZsAyrEA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: e8gVjJiNmvZd8ESYrbBmAUwz6zsi2-VM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE5OCBTYWx0ZWRfX4ZLpxJGMkFFq
 gmVmSQI97B7WqDu8cBd0ZQKiq0rs4XhnQkHQ8RCV6lO+cUmLTGrhbirIvRtlisb+25lSnbJOwKl
 RLLEt6KG46mTYH0U4Jjwg4RnTEXH4+3zMSdZigcF36LQtBSAPFwOvOEoZMulgG5CaDQ4CBomq1e
 TpUDpGe4wEIAmU1TiIWQiB1hSU9XvLUCvGwQQ8atT5lMlb85k8RI41cLowGSR8lGo6A143TDo1h
 QngrhJeH7YDT1k7OdwEzCPDfBE1x5xGlIFHX3prrmlZAv0/V5UgvmMi7KCaj3T12Nac+I7to1JY
 T59kIDws1gcyW0peoBR8WaMXePLI5/QJis8m4jldhSoRtyJqUwsYQXJFB0SpUfe/34zhm6vG7q1
 5PXOMFNbu2f2XYBKkhw3kEbLs6mYemYSVqzZZngWt8J6T8qy1lwo+LHDwnwgQTWFpW6de4xqrhq
 3fhfbe/zeyCE3G7msGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240198
X-Rspamd-Queue-Id: 09F304632F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9327-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[paul-moore.com,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]

Thanks, Jonathan!

On Fri, 2026-04-24 at 14:24 +0100, Jonathan McDowell wrote:
> -static int __init init_ima(void)
> +static int __init init_ima(bool late)
> =C2=A0{
> =C2=A0	int error;
> =C2=A0
> @@ -1247,10 +1247,26 @@ static int __init init_ima(void)
> =C2=A0		return 0;
> =C2=A0	}
> =C2=A0
> +	/*
> +	 * If we found the TPM during our first attempt, or we know there's no
> +	 * TPM, nothing further to do
> +	 */

Perhaps it's just me, but the comment wording is a bit off.  Could I change=
 it
to: If we either found the TPM or knew there's no TPM during our first atte=
mpt,
nothing futher to do.

Otherwise the patch looks good.

Mimi


> +	if (late && (ima_tpm_chip || !IS_ENABLED(CONFIG_TCG_TPM)))
> +		return 0;
> +
> +	ima_tpm_chip =3D tpm_default_chip();
> +	if (!ima_tpm_chip && !late && IS_ENABLED(CONFIG_TCG_TPM)) {
> +		pr_debug("TPM not available, will try later\n");
> +		return -EPROBE_DEFER;
> +	}
> +
> +	if (!ima_tpm_chip)
> +		pr_info("No TPM chip found, activating TPM-bypass!\n");
> +

