Return-Path: <linux-integrity+bounces-3909-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4829AE57B
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Oct 2024 15:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF0228409E
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Oct 2024 13:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BB51D9A6E;
	Thu, 24 Oct 2024 13:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="msQal4CE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D0D1D9A5B;
	Thu, 24 Oct 2024 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729774830; cv=none; b=KJyFzeQrnReBkLhHGdnKbh5XPOP1/Lb1YgbbVjtKwtoIiT/ct7xWJ8QMcizmDxzGmuQoGw1nr1sK2oRCJZTA+gjucxzHErqD00kr1NvC4Ff2GZyU4nfmpEQj+S2A/x6gjCJ2XlGKFN792nPVy9B/ObR6xkw8SzHRtuZO5ZyE9iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729774830; c=relaxed/simple;
	bh=RK8kCBuNkd+3zVoJoSiqFF447ojkzMRH/ErnnMN+Aik=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FkTjVbH0VM50KhrZKJAkbjQ+KP9BILlfg/kVYTP7BtPapk6PXXN79+hVM1e52jjfQldPO2+sjQbnA6gMnLg2cVMkP+FC2MAEPch9M0Gj+SMdPCD1AZkdsP3S9DlC5JOxMMsbMEd+35qKDfWLDqeamaAJ4p0cFCrZy6z0uwnogPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=msQal4CE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49O25JNV026355;
	Thu, 24 Oct 2024 12:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DpAXj2
	MSJyHnTZ2Xb1tOp5CVvCsAyxHh/cUttlApCJQ=; b=msQal4CECRe+vuxK3ywVjp
	sboq/cBYixuKoNqvWBJbynazh6g4mms4QQ2quIOvl/f9sUXcRTZWOMqJcn52wH/6
	JBdHr/6124qog47fEbgKniP9jLq+t70BiqU4oeUoLk7RzbvacN0wtXfUr+mzUX1n
	efoKHu4hGBA0VLYezJI+CijGpwt5Pac5VU53M7z24OgUdDFBxQwgCr1mcVC4fGUD
	Tu8Ubj2c/3CJmP7eJvfUARcNLUrl0TQQYtWqzNlb/nMZIQ8NhPzqx4U1fIiMAhGR
	VT6oqN2Kzn2KGaMt0bM4Kzg6SCmL/Ea1hMMFW4FO42LfEhLygdrrepYX2d/K5ZmQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emaf0het-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 12:59:12 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49OCxCIa009289;
	Thu, 24 Oct 2024 12:59:12 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emaf0hep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 12:59:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49OAgxCQ001557;
	Thu, 24 Oct 2024 12:59:11 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emk9gef8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 12:59:11 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49OCxAWh10289676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 12:59:10 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B29E58057;
	Thu, 24 Oct 2024 12:59:10 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41EB658063;
	Thu, 24 Oct 2024 12:59:09 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Oct 2024 12:59:09 +0000 (GMT)
Message-ID: <01edff76-2a66-4543-b1bf-4dc33d46c741@linux.ibm.com>
Date: Thu, 24 Oct 2024 08:59:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] tpm: Allocate chip->auth in
 tpm2_start_auth_session()
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20241021053921.33274-1-jarkko@kernel.org>
 <20241021053921.33274-5-jarkko@kernel.org>
 <588319e8-5983-4f15-abae-b5021f1e4fce@linux.ibm.com>
 <D5401CDJGBUG.1588B09HN21YS@kernel.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <D5401CDJGBUG.1588B09HN21YS@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Fi7jeYSJuBQzpNA-AiLfz-omgQg8MNpw
X-Proofpoint-ORIG-GUID: SlhCKi8OY3LW5MhnZw5YejosLM9BsxQf
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410240107



On 10/24/24 7:28 AM, Jarkko Sakkinen wrote:
> On Wed Oct 23, 2024 at 10:15 PM EEST, Stefan Berger wrote:
>>
>>
>> On 10/21/24 1:39 AM, Jarkko Sakkinen wrote:
>>> Move allocation of chip->auth to tpm2_start_auth_session() so that the
>>> field can be used as flag to tell whether auth session is active or not.
>>>
>>> Cc: stable@vger.kernel.org # v6.10+
>>> Fixes: 699e3efd6c64 ("tpm: Add HMAC session start and end functions")
>>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>>> ---
>>> v5:
>>> - No changes.
>>> v4:
>>> - Change to bug.
>>> v3:
>>> - No changes.
>>> v2:
>>> - A new patch.
>>> ---
>>>    drivers/char/tpm/tpm2-sessions.c | 43 +++++++++++++++++++-------------
>>>    1 file changed, 25 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
>>> index 78c650ce4c9f..6e52785de9fd 100644
>>> --- a/drivers/char/tpm/tpm2-sessions.c
>>> +++ b/drivers/char/tpm/tpm2-sessions.c
>>> @@ -484,7 +484,8 @@ static void tpm2_KDFe(u8 z[EC_PT_SZ], const char *str, u8 *pt_u, u8 *pt_v,
>>>    	sha256_final(&sctx, out);
>>>    }
>>>    
>>> -static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip)
>>> +static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
>>> +				struct tpm2_auth *auth)
>>>    {
>>>    	struct crypto_kpp *kpp;
>>>    	struct kpp_request *req;
>>> @@ -543,7 +544,7 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip)
>>>    	sg_set_buf(&s[0], chip->null_ec_key_x, EC_PT_SZ);
>>>    	sg_set_buf(&s[1], chip->null_ec_key_y, EC_PT_SZ);
>>>    	kpp_request_set_input(req, s, EC_PT_SZ*2);
>>> -	sg_init_one(d, chip->auth->salt, EC_PT_SZ);
>>> +	sg_init_one(d, auth->salt, EC_PT_SZ);
>>>    	kpp_request_set_output(req, d, EC_PT_SZ);
>>>    	crypto_kpp_compute_shared_secret(req);
>>>    	kpp_request_free(req);
>>> @@ -554,8 +555,7 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip)
>>>    	 * This works because KDFe fully consumes the secret before it
>>>    	 * writes the salt
>>>    	 */
>>> -	tpm2_KDFe(chip->auth->salt, "SECRET", x, chip->null_ec_key_x,
>>> -		  chip->auth->salt);
>>> +	tpm2_KDFe(auth->salt, "SECRET", x, chip->null_ec_key_x, auth->salt);
>>>    
>>>     out:
>>>    	crypto_free_kpp(kpp);
>>> @@ -854,6 +854,8 @@ int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
>>>    			/* manually close the session if it wasn't consumed */
>>>    			tpm2_flush_context(chip, auth->handle);
>>>    		memzero_explicit(auth, sizeof(*auth));
>>> +		kfree(auth);
>>> +		chip->auth = NULL;
>>>    	} else {
>>>    		/* reset for next use  */
>>>    		auth->session = TPM_HEADER_SIZE;
>>> @@ -882,6 +884,8 @@ void tpm2_end_auth_session(struct tpm_chip *chip)
>>>    
>>>    	tpm2_flush_context(chip, auth->handle);
>>>    	memzero_explicit(auth, sizeof(*auth));
>>> +	kfree(auth);
>>> +	chip->auth = NULL;
>>>    }
>>>    EXPORT_SYMBOL(tpm2_end_auth_session);
>>>    
>>> @@ -970,25 +974,29 @@ static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
>>>     */
>>>    int tpm2_start_auth_session(struct tpm_chip *chip)
>>>    {
>>> +	struct tpm2_auth *auth;
>>>    	struct tpm_buf buf;
>>> -	struct tpm2_auth *auth = chip->auth;
>>> -	int rc;
>>>    	u32 null_key;
>>> +	int rc;
>>>    
>>> -	if (!auth) {
>>> -		dev_warn_once(&chip->dev, "auth session is not active\n");
>>> +	if (chip->auth) {
>>> +		dev_warn_once(&chip->dev, "auth session is active\n");
>>>    		return 0;
>>>    	}
>>>    
>>> +	auth = kzalloc(sizeof(*auth), GFP_KERNEL);
>>> +	if (!auth)
>>> +		return -ENOMEM;
>>> +
>>>    	rc = tpm2_load_null(chip, &null_key);
>>>    	if (rc)
>>> -		goto out;
>>> +		goto err;
>>>    
>>>    	auth->session = TPM_HEADER_SIZE;
>>>    
>>>    	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_START_AUTH_SESS);
>>>    	if (rc)
>>> -		goto out;
>>> +		goto err;
>>>    
>>>    	/* salt key handle */
>>>    	tpm_buf_append_u32(&buf, null_key);
>>> @@ -1000,7 +1008,7 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
>>>    	tpm_buf_append(&buf, auth->our_nonce, sizeof(auth->our_nonce));
>>>    
>>>    	/* append encrypted salt and squirrel away unencrypted in auth */
>>> -	tpm_buf_append_salt(&buf, chip);
>>> +	tpm_buf_append_salt(&buf, chip, auth);
>>>    	/* session type (HMAC, audit or policy) */
>>>    	tpm_buf_append_u8(&buf, TPM2_SE_HMAC);
>>>    
>>> @@ -1021,10 +1029,13 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
>>>    
>>>    	tpm_buf_destroy(&buf);
>>>    
>>> -	if (rc)
>>> -		goto out;
>>> +	if (rc == TPM2_RC_SUCCESS) {
>>> +		chip->auth = auth;
>>> +		return 0;
>>> +	}
>>>    
>>> - out:
>>> +err:
>>
>> like in many other cases before kfree(auth):
>> memzero_explicit(auth, sizeof(*auth));
>>
>> With this:
>>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> Thanks, or should we use kfree_sensitive()?
> 
> It has some additional functionality, which is missed now:
> 
> https://elixir.bootlin.com/linux/v6.11.5/source/mm/slab_common.c#L1339
> 
> I.e. kasan_unpoison().

And change the other ones that use memzero_explicit()?

> 
> BR, Jarkko
> 

