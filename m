Return-Path: <linux-integrity+bounces-4132-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A85619D1CE7
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Nov 2024 02:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C52E1F2212E
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Nov 2024 01:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB4117BD5;
	Tue, 19 Nov 2024 01:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="msMHyPUU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E68A93D;
	Tue, 19 Nov 2024 01:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731978339; cv=none; b=DFMQqONdnvNgwOYNUbYx9DgpNZVmHvXhTXDf2hc7L9Wx5fg+QtlXzTUnGiH2I8oN04CmWBdnmqjKyzzsWOA1QKO3pIxcC46cXpfTu6SX/nWacPj7JeUinuuhGGF2hHuHkZNBPKGpAa92jLYDfe7VhMCKZrwrGquLCL2xemu3qJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731978339; c=relaxed/simple;
	bh=dJfvBSfmbjhQ6llfWcJivt4BmuuxtAnrWORyR3RQ23E=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 MIME-Version:Date; b=Fu9jFD0zFVVTWdi/Q5C5zpjcuPfAZObCnHDz1lcLU9BU7x3g9+1/7w3HmaZk7uGeruIJdo+KpAxyuJ/5U41aZlkNydZwSJPLPNnZrpsfY1siuvlTB0zpL6FTEvM4V/ppyVLLv6U20lx7grPda1LdNCksXI5l6vRsKQTura9POVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=msMHyPUU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AILwE0l023275;
	Tue, 19 Nov 2024 01:05:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tEZ5Pr
	bHuWe3wqw/gvWY8LMX5+E2VHOII1rRZd2Op/k=; b=msMHyPUUnpTlkIROlBtp/h
	qgNmxcBcdGILUR6lnQOme6HzAkg1X+AB7TxhHIJFb0KwUIWgsoO5SvdM6XMB6PyL
	IyeDkccur9tZOgCBE3OmoZVugguJCHmUtBpmBTTF7kDYTOYmVzQKrkt6uQCWqnSd
	KxrRHmYV7Mg+a7NE3ZmYDH/0jNjtpU7G4z1iHEiJVB4EABdbBCMvqk1lNoHSxKOe
	RmyIJP8BDnUNUSckhXvi+7IL1TrWNy8Ee9v+l2gbKI9D9Hr44T+UQyxOKBCI8557
	bXh0aJ0Bb8bDz3qKCLdkQwbjrDXAt/k0IUPkvfQfXOE49J0dao94vbP1T/1ILk/g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xhtjmdct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 01:05:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ0AqIL031179;
	Tue, 19 Nov 2024 01:05:20 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42y5qsbp0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 01:05:20 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AJ15JfO46924380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 01:05:19 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD87D5805A;
	Tue, 19 Nov 2024 01:05:19 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 067B558054;
	Tue, 19 Nov 2024 01:05:19 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.30.225])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Nov 2024 01:05:18 +0000 (GMT)
Message-ID: <539ec9eb95fbb5fd0a092ffb9b3c1adb1031de5c.camel@linux.ibm.com>
Subject: Re: [PATCH v3] ima: Suspend PCR extends and log appends when
 rebooting
From: Mimi Zohar <zohar@linux.ibm.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, roberto.sassu@huawei.com,
        Stefan Berger
	 <stefanb@linux.ibm.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <20241118145732.1258631-1-stefanb@linux.vnet.ibm.com>
References: <20241118145732.1258631-1-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 18 Nov 2024 19:56:53 -0500
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: r-TXCmcYMB2Lyl_1TYvS70rbnX9LaQTh
X-Proofpoint-GUID: r-TXCmcYMB2Lyl_1TYvS70rbnX9LaQTh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411190003

On Mon, 2024-11-18 at 09:57 -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
>=20
> To avoid the following types of error messages due to a failure by the TP=
M
> driver to use the TPM, suspend TPM PCR extensions and the appending of
> entries to the IMA log once IMA's reboot notifier has been called. This
> avoids trying to use the TPM after the TPM subsystem has been shut down.
>=20
> [111707.685315][    T1] ima: Error Communicating to TPM chip, result: -19
> [111707.685960][    T1] ima: Error Communicating to TPM chip, result: -19
>=20
> Synchronization with the ima_extend_list_mutex to set
> ima_measurements_suspended ensures that the TPM subsystem is not shut dow=
n
> when IMA holds the mutex while appending to the log and extending the PCR=
.
> The alternative of reading the system_state variable would not provide th=
is
> guarantee.
>=20
> This error could be observed on a ppc64 machine running SuSE Linux where
> processes are still accessing files after devices have been shut down.
>=20
> Suspending the IMA log and PCR extensions shortly before reboot does not
> seem to open a significant measurement gap since neither TPM quoting woul=
d
> work for attestation nor that new log entries could be written to anywher=
e
> after devices have been shut down. However, there's a time window between
> the invocation of the reboot notifier and the shutdown of devices. This
> includes all subsequently invoked reboot notifiers as well as
> kernel_restart_prepare() where __usermodehelper_disable() waits for all
> running_helpers to exit. During this time window IMA could now miss log
> entries even though attestation would still work. The reboot of the syste=
m
> shortly after may make this small gap insignificant.
>=20
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Thank you for updating the patch description and the comment below.  The pa=
tch
is now queued in next-integrity-testing.

Mimi

> ---

[...]=20
> 						       int pcr)
> @@ -168,6 +175,18 @@ int ima_add_template_entry(struct ima_template_entry=
 *entry, int violation,
>  	int result =3D 0, tpmresult =3D 0;
> =20
>  	mutex_lock(&ima_extend_list_mutex);
> +
> +	/*
> +	 * Avoid appending to the measurement log when the TPM subsystem has
> +	 * been shut down while preparing for system reboot.
> +	 */
> +	if (ima_measurements_suspended) {
> +		audit_cause =3D "measurements_suspended";
> +		audit_info =3D 0;
> +		result =3D -ENODEV;
> +		goto out;
> +	}
> +
>  	if (!violation && !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE)) {
>  		if (ima_lookup_digest_entry(digest, entry->pcr)) {
>  			audit_cause =3D "hash_exists";
> @@ -211,6 +230,31 @@ int ima_restore_measurement_entry(struct ima_templat=
e_entry *entry)
>  	return result;
>  }


