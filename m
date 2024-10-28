Return-Path: <linux-integrity+bounces-3928-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EEF9B384C
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2024 18:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 192491C221F0
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2024 17:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EC21DF26F;
	Mon, 28 Oct 2024 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oXSJr+9O"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C356D1DF246;
	Mon, 28 Oct 2024 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730138082; cv=none; b=HszoO+HuGDaXb3X+mAjtgk2nr7+9BVhQvJSlqiuZkNXhRtAjji6B4zRODxkOt2w7xgrIjqfvo1fXS4x125zhx1ARDYvE/bbOndyEDN7k6ososCkGXinjlv+HEP5dlTPmFF9poEMdRgqnesO3I1GyruEOkGfWakXwdN6Nc18Y8PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730138082; c=relaxed/simple;
	bh=5PONTzBitjn4EwPUNlqoSLiMuUPACsV0LudwV/dJ6K0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bauNizPLduNp9BP/S73ylG+bo9vFLr1SS9g2ZRRTMbx+02XUYQ2DpBqfOMjBXn7bmJHK4+r+9OmWGvQIvSmKgYgO3Uytta8QpygQwX0CCEaw7jk9XU8Ymm7MaSehAfdxxUtXxllDU03aWrnTdtpU0OQngpu35ItE2Z5UjffGHJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oXSJr+9O; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SHnM5P031179;
	Mon, 28 Oct 2024 17:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iE5nk2
	ixncegS/3AbmITdOIOJVsbmX/tX9dnOVr5mE8=; b=oXSJr+9Ow7hO2PkvqhMs7R
	WDeVZmCiYOiLcAuTNxRDeUWSoHwWFgue2Tq+ZHtqQLV/SjBu/MSTi4u+R5lou/eO
	DKaQcq750DoGm7qoFDBMWoqe9giIIkFnDCascqZ/3cTqODt1H33Iu9+XbO6GziBA
	Jkp4lc14z6jz/XeDkO9lAVdLZ2B7a49Yvbn2oazOeiauzUUFs8arM2Dcyq5TZ25j
	YhCrR07wUnqdDLnMNfFL2YlG6MVAy0ZlmdNyGM61M/OUNNE6hXcmMFyiZ3T8ftOK
	mxdaKdvOnIPt6gYznyLGs1Vn/DY4Ih2aD+5ssSQEFbH588YuZTkMs0RMd4V+/gsw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42jb7qhb6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 17:52:13 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49SHoC0B002848;
	Mon, 28 Oct 2024 17:52:13 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42jb7qhb6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 17:52:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49SHcP4v024535;
	Mon, 28 Oct 2024 17:52:12 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42hcyj742k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 17:52:12 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49SHqBo730278048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 17:52:11 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23EB35805A;
	Mon, 28 Oct 2024 17:52:11 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29E0E58052;
	Mon, 28 Oct 2024 17:52:10 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Oct 2024 17:52:10 +0000 (GMT)
Message-ID: <fa6b6c7d-1b90-40ad-b7f4-73e1a0eef1d5@linux.ibm.com>
Date: Mon, 28 Oct 2024 13:52:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/3] tpm: Lazily flush the auth session
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
        Pengyu Ma <mapengyu@gmail.com>, stable@vger.kernel.org
References: <20241028055007.1708971-1-jarkko@kernel.org>
 <20241028055007.1708971-4-jarkko@kernel.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20241028055007.1708971-4-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8QHMdygOQ_15fX3jEs9sEBGPXVZQ6f7s
X-Proofpoint-GUID: jEwr1Tf097hsjt9C9ZN8DzkfL1ixeTK2
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410280134


On 10/28/24 1:50 AM, Jarkko Sakkinen wrote:
> Move the allocation of chip->auth to tpm2_start_auth_session() so that this
> field can be used as flag to tell whether auth session is active or not.
> 
> Instead of flushing and reloading the auth session for every transaction
> separately, keep the session open unless /dev/tpm0 is used.
> 
> Reported-by: Pengyu Ma <mapengyu@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219229
> Cc: stable@vger.kernel.org # v6.10+
> Fixes: 7ca110f2679b ("tpm: Address !chip->auth in tpm_buf_append_hmac_session*()")
> Tested-by: Pengyu Ma <mapengyu@gmail.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
> v8:
> - Since auth session and null key are flushed at a same time, only
>    either needs to be checked. Addresses and a remark from James
>    Bottomley few revisions ago.
> - kfree_sensitive()
> - Effectively squash top three patches given the simplifications.
> v7:
> - No changes.
> v6:
> - No changes.
> v5:
> - No changes.
> v4:
> - Changed as bug.
> v3:
> - Refined the commit message.
> - Removed the conditional for applying TPM2_SA_CONTINUE_SESSION only when
>    /dev/tpm0 is open. It is not required as the auth session is flushed,
>    not saved.
> v2:
> - A new patch.
> ---
>   drivers/char/tpm/tpm-chip.c       | 10 +++++++
>   drivers/char/tpm/tpm-dev-common.c |  3 +++
>   drivers/char/tpm/tpm-interface.c  |  6 +++--
>   drivers/char/tpm/tpm2-sessions.c  | 45 ++++++++++++++++++-------------
>   4 files changed, 44 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 854546000c92..1ff99a7091bb 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -674,6 +674,16 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
>    */
>   void tpm_chip_unregister(struct tpm_chip *chip)
>   {
> +#ifdef CONFIG_TCG_TPM2_HMAC
> +	int rc;
> +
> +	rc = tpm_try_get_ops(chip);
> +	if (!rc) {
> +		tpm2_end_auth_session(chip);
> +		tpm_put_ops(chip);
> +	}
> +#endif
> +
>   	tpm_del_legacy_sysfs(chip);
>   	if (tpm_is_hwrng_enabled(chip))
>   		hwrng_unregister(&chip->hwrng);
> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> index 30b4c288c1bb..c7a88fa7b0fc 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -27,6 +27,9 @@ static ssize_t tpm_dev_transmit(struct tpm_chip *chip, struct tpm_space *space,
>   	struct tpm_header *header = (void *)buf;
>   	ssize_t ret, len;
>   
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> +		tpm2_end_auth_session(chip);
> +
>   	ret = tpm2_prepare_space(chip, space, buf, bufsiz);
>   	/* If the command is not implemented by the TPM, synthesize a
>   	 * response with a TPM2_RC_COMMAND_CODE return for user-space.
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 5da134f12c9a..8134f002b121 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -379,10 +379,12 @@ int tpm_pm_suspend(struct device *dev)
>   
>   	rc = tpm_try_get_ops(chip);
>   	if (!rc) {
> -		if (chip->flags & TPM_CHIP_FLAG_TPM2)
> +		if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +			tpm2_end_auth_session(chip);
>   			tpm2_shutdown(chip, TPM2_SU_STATE);
> -		else
> +		} else {
>   			rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
> +		}
>   
>   		tpm_put_ops(chip);
>   	}
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> index 950a3e48293b..03145a465b5d 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -333,6 +333,9 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
>   	}
>   
>   #ifdef CONFIG_TCG_TPM2_HMAC
> +	/* The first write to /dev/tpm{rm0} will flush the session. */
> +	attributes |= TPM2_SA_CONTINUE_SESSION;
> +
>   	/*
>   	 * The Architecture Guide requires us to strip trailing zeros
>   	 * before computing the HMAC
> @@ -484,7 +487,8 @@ static void tpm2_KDFe(u8 z[EC_PT_SZ], const char *str, u8 *pt_u, u8 *pt_v,
>   	sha256_final(&sctx, out);
>   }
>   
> -static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip)
> +static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
> +				struct tpm2_auth *auth)
>   {
>   	struct crypto_kpp *kpp;
>   	struct kpp_request *req;
> @@ -543,7 +547,7 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip)
>   	sg_set_buf(&s[0], chip->null_ec_key_x, EC_PT_SZ);
>   	sg_set_buf(&s[1], chip->null_ec_key_y, EC_PT_SZ);
>   	kpp_request_set_input(req, s, EC_PT_SZ*2);
> -	sg_init_one(d, chip->auth->salt, EC_PT_SZ);
> +	sg_init_one(d, auth->salt, EC_PT_SZ);
>   	kpp_request_set_output(req, d, EC_PT_SZ);
>   	crypto_kpp_compute_shared_secret(req);
>   	kpp_request_free(req);
> @@ -554,8 +558,7 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip)
>   	 * This works because KDFe fully consumes the secret before it
>   	 * writes the salt
>   	 */
> -	tpm2_KDFe(chip->auth->salt, "SECRET", x, chip->null_ec_key_x,
> -		  chip->auth->salt);
> +	tpm2_KDFe(auth->salt, "SECRET", x, chip->null_ec_key_x, auth->salt);
>   
>    out:
>   	crypto_free_kpp(kpp);
> @@ -853,7 +856,9 @@ int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
>   		if (rc)
>   			/* manually close the session if it wasn't consumed */
>   			tpm2_flush_context(chip, auth->handle);
> -		memzero_explicit(auth, sizeof(*auth));
> +
> +		kfree_sensitive(auth);
> +		chip->auth = NULL;
>   	} else {
>   		/* reset for next use  */
>   		auth->session = TPM_HEADER_SIZE;
> @@ -881,7 +886,8 @@ void tpm2_end_auth_session(struct tpm_chip *chip)
>   		return;
>   
>   	tpm2_flush_context(chip, auth->handle);
> -	memzero_explicit(auth, sizeof(*auth));
> +	kfree_sensitive(auth);
> +	chip->auth = NULL;
>   }
>   EXPORT_SYMBOL(tpm2_end_auth_session);
>   
> @@ -962,16 +968,20 @@ static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
>    */
>   int tpm2_start_auth_session(struct tpm_chip *chip)
>   {
> +	struct tpm2_auth *auth;
>   	struct tpm_buf buf;
> -	struct tpm2_auth *auth = chip->auth;
> -	int rc;
>   	u32 null_key;
> +	int rc;
>   
> -	if (!auth) {
> -		dev_warn_once(&chip->dev, "auth session is not active\n");
> +	if (chip->auth) {
> +		dev_warn_once(&chip->dev, "auth session is active\n");
>   		return 0;
>   	}
>   
> +	auth = kzalloc(sizeof(*auth), GFP_KERNEL);
> +	if (!auth)
> +		return -ENOMEM;
> +
>   	rc = tpm2_load_null(chip, &null_key);
>   	if (rc)
>   		goto out;
> @@ -992,7 +1002,7 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
>   	tpm_buf_append(&buf, auth->our_nonce, sizeof(auth->our_nonce));
>   
>   	/* append encrypted salt and squirrel away unencrypted in auth */
> -	tpm_buf_append_salt(&buf, chip);
> +	tpm_buf_append_salt(&buf, chip, auth);
>   	/* session type (HMAC, audit or policy) */
>   	tpm_buf_append_u8(&buf, TPM2_SE_HMAC);
>   
> @@ -1014,10 +1024,13 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
>   
>   	tpm_buf_destroy(&buf);
>   
> -	if (rc)
> -		goto out;
> +	if (rc == TPM2_RC_SUCCESS) {
> +		chip->auth = auth;
> +		return 0;
> +	}
>   
> - out:
> +out:
> +	kfree_sensitive(auth);
>   	return rc;
>   }
>   EXPORT_SYMBOL(tpm2_start_auth_session);
> @@ -1367,10 +1380,6 @@ int tpm2_sessions_init(struct tpm_chip *chip)
>   		return rc;
>   	}
>   
> -	chip->auth = kmalloc(sizeof(*chip->auth), GFP_KERNEL);
> -	if (!chip->auth)
> -		return -ENOMEM;
> -
>   	return rc;
>   }
>   #endif /* CONFIG_TCG_TPM2_HMAC */


