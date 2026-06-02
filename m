Return-Path: <linux-integrity+bounces-9738-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GehLKPzPHmqhVQAAu9opvQ
	(envelope-from <linux-integrity+bounces-9738-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Jun 2026 14:43:40 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA60A62E1FC
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Jun 2026 14:43:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=qvsviC3M;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9738-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9738-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 478613050202
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jun 2026 12:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B6A383329;
	Tue,  2 Jun 2026 12:36:15 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B166636F905;
	Tue,  2 Jun 2026 12:36:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780403774; cv=none; b=tO9EfmrnzBBLHEVEAZD/45YIzS7OTeNVvyA2W5gSmb4u57yfxduR5IbNgfAqkeqoXNhNU/xAsvXf51m6WvvjGaH4da1u9bNHwIzpb5iMyju25ibfGKe+RU9xgNxZypLaycuQ1gJ/LnZmBX6EtfrNEVijf4rYyofbyEvlpwavNfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780403774; c=relaxed/simple;
	bh=XRq6zKHpHlP1MvVxwo3MkYW33LVbfZ3T7v5rSkW824s=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=qQO2WBIT0XEZ1y7D72RC6/Lne0npqjOIggd8XpmV/dmgl8WLej0mxj8zCNawqL5N+C67Bi49D/dc1a1s2vjM3oat3EcyluWIvT+e6kzlJ2FJfRSohzCXEI66mZMivZEaCsJW+Mx+tWniFhEBvNTvlNRGda7YNjgBugtBF6DACRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qvsviC3M; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6524vOsw1020056;
	Tue, 2 Jun 2026 12:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HAOfKD
	hVqXbuGYcybtGKmXC/vWUWMmB31pA4lWqG0wQ=; b=qvsviC3MLArerqMVZzSK4l
	bEx4EoffCiqkm0o8Lnnuz10/eanS81rujAc+D2Ewld+ccp2/6d8cRspeVYyVhdkz
	q/Wc/At0/fhzWDux+YyBqbkh1vO2+g7KdcDWkoebcgvtR/MCZH5vVlGY8xTSbqTX
	CjinS3LGFOUs6K0aCRCYh13+qsyjG3fJ+fQvmIOmFNe9AC+FVTjnKGTFyLPbkl9+
	fFoC2gkTQWTYvH2GI3wzUXNnZ88LIqOoVfNOGg0/79frGidaVo9r3V2UCGyumb+Z
	2GaO8xIkkArNSMjJ38Zcm82VZ+rL/XWPpwPVacwmtgHlpCS7tmyaE1rK2utTkjfw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjq5uf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 12:35:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652CO520031168;
	Tue, 2 Jun 2026 12:35:55 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegjyws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 12:35:55 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652CZs9218154012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 12:35:54 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 322E95805A;
	Tue,  2 Jun 2026 12:35:54 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F99A5805E;
	Tue,  2 Jun 2026 12:35:53 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.48.163])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 12:35:53 +0000 (GMT)
Message-ID: <1cb6e74f1d63bd256d70e5c026234d4535acb662.camel@linux.ibm.com>
Subject: Re: [PATCH v5 2/4] security: ima: introduce IMA_INIT_LATE_SYNC
 option
From: Mimi Zohar <zohar@linux.ibm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Cc: paul@paul-moore.com, roberto.sassu@huaweicloud.com, noodles@earth.li,
        jarkko@kernel.org, sudeep.holla@kernel.org, jmorris@namei.org,
        serge@hallyn.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        jgg@ziepe.ca
In-Reply-To: <20260601142749.3379697-3-yeoreum.yun@arm.com>
References: <20260601142749.3379697-1-yeoreum.yun@arm.com>
	 <20260601142749.3379697-3-yeoreum.yun@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 08:35:52 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: nc7uV9yATCrvZNBmArLTiUNP7afB-vEK
X-Proofpoint-GUID: AJDCnNif32ltOqcHKMorUU8_FQV0uIeA
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a1ece2c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8 a=UcpHEPep0OYEHb0RgzgA:9 a=QEXdDO2ut3YA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDExNiBTYWx0ZWRfX9Q6g0ddg1aid
 +OKl1eadSB9k8/tsYRN+/uqCn8b9ScJq9emcjOuM5270Bhrb9hzPf8kSJc1h7oMKuBHBQCHFIfg
 wkEMX9j96iTSHkb0/yX6Xr5sOmHx5sHrJcoKkOHDwUrBXwVVfZknNSQQdmZYga+IFGj6OE8Sw3q
 Z+dWaL6ftJm0qGbQKZHEuMWoQ8FNbmgMo9sNJ332W87R4zax5Unnwd8aVVYj1MURyLjG0AooJ5/
 H6/R9T69qLxeskcEWQxB1mCqyZnYrNM8X1Zg/w1klEb9Nq3/L68l5bSBbitNNyQRgVDfDvnrGWP
 gjKzG+VoPxSyUh1XbJW3iFb6GdvD9ibbc7jLez55t842zIYe4qwx35LRNihXB3FQug+fV7M/8QO
 75BOuk5mBiCXAh7SO4ApdyeOXWEJZ9JvD1Awl/kwz888Lz+5eXqGp4jPlqgtG2ShcY/XDYNu5rV
 BsnvOmxfcc2epPoy5EA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020116
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9738-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yeoreum.yun@arm.com,m:linux-security-module@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:paul@paul-moore.com,m:roberto.sassu@huaweicloud.com,m:noodles@earth.li,m:jarkko@kernel.org,m:sudeep.holla@kernel.org,m:jmorris@namei.org,m:serge@hallyn.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:jgg@ziepe.ca,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c0a:e001:db::12fc:5321:from];
	FORGED_SENDER(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[paul-moore.com,huaweicloud.com,earth.li,kernel.org,namei.org,hallyn.com,gmail.com,oracle.com,ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,linux.ibm.com:from_mime,linux.ibm.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ALIAS_RESOLVED(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[9.61.48.163:received,50.22.158.221:received,148.163.156.1:received,100.90.174.1:received,10.241.53.101:received];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA60A62E1FC

On Mon, 2026-06-01 at 15:27 +0100, Yeoreum Yun wrote:
> To generate the boot_aggregate log in the IMA subsystem with TPM PCR valu=
es,
> the TPM driver must be built as built-in and
> must be probed before the IMA subsystem is initialized.
>=20
> However, when the TPM device operates over the FF-A protocol using
> the CRB interface, probing fails and returns -EPROBE_DEFER if
> the tpm_crb_ffa device =E2=80=94 an FF-A device that provides the communi=
cation
> interface to the tpm_crb driver =E2=80=94 has not yet been probed.
>=20
> To ensure the TPM device operating over the FF-A protocol with
> the CRB interface is probed before IMA initialization,
> the following conditions must be met:
>=20
> 1. The corresponding ffa_device must be registered,
>    which is done via ffa_init().
>=20
> 2. The tpm_crb_driver must successfully probe this device via
>    tpm_crb_ffa_init().
>=20
> 3. The tpm_crb driver using CRB over FF-A can then
>    be probed successfully. (See crb_acpi_add() and
>    tpm_crb_ffa_init() for reference.)
>=20
> Unfortunately, ffa_init(), tpm_crb_ffa_init(), and crb_acpi_driver_init()=
 are
> all registered with device_initcall, which means crb_acpi_driver_init() m=
ay
> be invoked before ffa_init() and tpm_crb_ffa_init() are completed.
>=20
> When this occurs, probing the TPM device is deferred.
> However, the deferred probe can happen after the IMA subsystem
> has already been initialized, since IMA initialization is performed
> during late_initcall, and deferred_probe_initcall() is performed
> at the same level.
>=20
> And the similar situation is reported on TPM devices attached on SPI
> bus[0].
>=20
> To resolve this, introduce IMA_INIT_LATE_SYNC option to initialise
> IMA at late_inicall_sync so that IMA is initialized with the TPM
> device probed deferred.
>=20
> When this option is enabled, modules that access files in the
> initramfs through usermode helper calls such as request_module()
> during initcall must not be built-in. Otherwise, IMA may miss
> measuring those files [1].
>=20
> Link: https://lore.kernel.org/all/aYXEepLhUouN5f99@earth.li/ [0]
> Link: https://lore.kernel.org/all/2b3782398cc17ce9d355490a0c42ebce9120a9a=
e.camel@linux.ibm.com/ [1]
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>

Reviewed-by:  Mimi Zohar <zohar@linux.ibm.com>

