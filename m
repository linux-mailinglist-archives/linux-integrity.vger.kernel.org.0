Return-Path: <linux-integrity+bounces-3018-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5A7928A5C
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jul 2024 16:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84A82824AC
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jul 2024 14:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B15616848F;
	Fri,  5 Jul 2024 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r51Ul7A7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FE814A62E;
	Fri,  5 Jul 2024 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720188370; cv=none; b=DVJBY/HxRzcLw2iTG4i0Yux3lnVjGKl8nS/ylKhRZWQWFdy42HROiTT+QmgENeGxazXjgmy1XXxvJTE3oH3bpCwnOY7UsJOcBKWBOhPeKaBSiHI+8cwbgljRukzbLBp87A8eIYlvNEqrSauSot5cr0HLdeXqxIBANeT2kQJ0oEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720188370; c=relaxed/simple;
	bh=zOSrsIqDgw6nsS4xTIr0H79y6qZFeeth/rCwIFXjYVE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KfRs6KoAe+GUMkH4CoIkAotXUEOhUD/ZSeE0Tc+XT6J4uHUAaGTDpSt9DEoollRHYQfKIHekilDisZQyLdpagQljNbBcATmWvwBc3MFYABkPGGzZzU7e0tsFELzFyD4rF9yoKP+OnKlUIZo33DU3F8Mm9/fPaBL86lvmLXWBNZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r51Ul7A7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465DwaYE022369;
	Fri, 5 Jul 2024 14:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	jswmdaZpgdwezGBmtgUlt8LtKnBHchYGQHSMWl7LaB0=; b=r51Ul7A7DR2WMDgw
	F+YWbtgX2ZScu2gdxz9yGLB2ZSf8+y6ldMA4yVXg5Ebg1I0pAK1Zcv2sH+IIOduN
	Qu3BILfuhnOrqpaHXK5zwDfUsOepZCKGPQ+GZ5XyVnpRGn7aT72pUi4F5iwNdeRz
	ePa/ja/eGSV78c9+v8O1FROlnNraoFpgyHh8n3d78fv+SemopU8SnGLsOvoyyvR/
	+CA5kbe7mrCpfLope2VnnW5akk9cnL27GbPoKw+HwIaBKIXXoP+u1ZTwRJiq6dCs
	MoAou3gqUzj9Vk7Nt4+T9wTIrHl/UbtDNxIMvLqN0+bjYAZdAmcq5wMcowxJwnzi
	YDlW5w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 406j6b00jj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jul 2024 14:05:44 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 465E5hhS001371;
	Fri, 5 Jul 2024 14:05:43 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 406j6b00je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jul 2024 14:05:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 465CwfXH024085;
	Fri, 5 Jul 2024 14:05:42 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 402ya3wdre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jul 2024 14:05:42 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 465E5eXQ13566630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jul 2024 14:05:42 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38DAD5806A;
	Fri,  5 Jul 2024 14:05:40 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E212058056;
	Fri,  5 Jul 2024 14:05:38 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Jul 2024 14:05:38 +0000 (GMT)
Message-ID: <bffebaaa-4831-459f-939d-adf531e4c78b@linux.ibm.com>
Date: Fri, 5 Jul 2024 10:05:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tpm: Address !chip->auth in
 tpm_buf_append_hmac_session*()
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
        Linus Torvalds <torvalds@linux-foundation.org>, stable@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Ard Biesheuvel <ardb@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20240703182453.1580888-1-jarkko@kernel.org>
 <20240703182453.1580888-4-jarkko@kernel.org>
 <c90ce151-c6e5-40c6-8d3d-ccec5a97d10f@linux.ibm.com>
 <D2GJSLLC0LSF.2RP57L3ALBW38@kernel.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <D2GJSLLC0LSF.2RP57L3ALBW38@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qclVOdl1N7Mzp5Z8e73-uIgvKncococf
X-Proofpoint-ORIG-GUID: xQJxZA9UF3u8kVvQaJujMma6uFYtArgU
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407050099

On 7/4/24 02:41, Jarkko Sakkinen wrote:
> On Thu Jul 4, 2024 at 4:56 AM EEST, Stefan Berger wrote:
>>
>>
>> On 7/3/24 14:24, Jarkko Sakkinen wrote:
>>> Unless tpm_chip_bootstrap() was called by the driver, !chip->auth can
>>
>> Doesn't tpm_chip_register() need to be called by all drivers? This
>> function then calls tpm_chip_bootstrap().
>>
>>> cause a null derefence in tpm_buf_hmac_session*().  Thus, address
>>> !chip->auth in tpm_buf_hmac_session*() and remove the fallback
>>> implementation for !TCG_TPM2_HMAC.
>>>
>>> Cc: stable@vger.kernel.org # v6.9+
>>> Reported-by: Stefan Berger <stefanb@linux.ibm.com>
>>> Closes: https://lore.kernel.org/linux-integrity/20240617193408.1234365-1-stefanb@linux.ibm.com/
>>> Fixes: 1085b8276bb4 ("tpm: Add the rest of the session HMAC API")
>>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>>
>> I applied this series now but it doesn't solve the reported problem. The
> 
> It fixes the issues of which symptoms was shown by your transcript:
> 
> [    2.987131] tpm tpm0: tpm2_load_context: failed with a TPM error 0x01C4
> [    2.987140] ima: Error Communicating to TPM chip, result: -14
> 
> Your original thread identified zero problems, so thus your claim here
> is plain untrue.

The original thread here

https://lore.kernel.org/linux-integrity/656b319fc58683e399323b880722434467cf20f2.camel@kernel.org/T/#t

identified the fact that tpm2_session_init() was missing for the ibmvtpm 
driver. It is a non-zero problem for the respective platforms where this 
driver is being used. The patched fixed the reported issue.

> 
> Before the null derefence is fixed all other patches related are
> blocked, including ibm_tpmvtpm patches, because it would be insane
> to accept them when there is known memory corruption bug, which
> this patch set fixes.
> 
> What is so difficult to understand in this?
> 
>> error message is gone but the feature can still be enabled
>> (CONFIG_TCG_TPM2_HMAC=y) but is unlikely actually doing what it is
>> promising to do with this config option. So you either still have to
>> apply my patch, James's patch, or your intended "depends on
>> !TCG_IBMVTPM" patch.
> 
> Well this somewhat misleading imho...
> 
> None of the previous patches, including your, do nothing to fix the null
> derefence bug and that is the *only* bug we care about ATM. With these
> fixes drivers that do not call tpm_chip_bootstrap() will be fully
> working still but without encryption.
> 

Now that you fixed it in v4 are you going to accept my original patch 
with the Fixes tag since we will (likely) have an enabled feature in 
6.10 that is not actually working when the ibmvtpm driver is being used?

Original patch:

https://lore.kernel.org/linux-integrity/656b319fc58683e399323b880722434467cf20f2.camel@kernel.org/T/#t

> There's five drivers which would require update for that:
> 
> drivers/char/tpm/tpm_ftpm_tee.c:        pvt_data->chip->flags |= TPM_CHIP_FLAG_TPM2;
> drivers/char/tpm/tpm_i2c_nuvoton.c:             chip->flags |= TPM_CHIP_FLAG_TPM2;
> drivers/char/tpm/tpm_ibmvtpm.c:         chip->flags |= TPM_CHIP_FLAG_TPM2;
> drivers/char/tpm/tpm_tis_i2c_cr50.c:    chip->flags |= TPM_CHIP_FLAG_TPM2;
> drivers/char/tpm/tpm_vtpm_proxy.c:              proxy_dev->chip->flags |= TPM_CHIP_FLAG_TPM2;

I do no think that this is true and its only tpm_ibmvtpm.c that need the 
call to tpm2_session_init. All drivers that use TPM_OPS_AUTO_STARTUP 
will run tpm_chip_register -> tpm_chip_bootstrap -> tpm_auto_startup -> 
tpm2_auto_startup -> tpm2_sessions_init

$ grep AUTO_START *.c
tpm_crb.c:      .flags = TPM_OPS_AUTO_STARTUP,
tpm_ftpm_tee.c: .flags = TPM_OPS_AUTO_STARTUP,
tpm_i2c_atmel.c:        .flags = TPM_OPS_AUTO_STARTUP,
tpm_i2c_infineon.c:     .flags = TPM_OPS_AUTO_STARTUP,
tpm_i2c_nuvoton.c:      .flags = TPM_OPS_AUTO_STARTUP,
tpm-interface.c:        if (!(chip->ops->flags & TPM_OPS_AUTO_STARTUP))
tpm_tis_core.c: .flags = TPM_OPS_AUTO_STARTUP,
tpm_tis_i2c_cr50.c:     .flags = TPM_OPS_AUTO_STARTUP,
tpm_vtpm_proxy.c:       .flags = TPM_OPS_AUTO_STARTUP,

All the above drivers are also calling tpm_chip_register.

tpm_atmel.c:    rc = tpm_chip_register(chip);
tpm-chip.c: * tpm_chip_register() - create a character device for the 
TPM chip
tpm-chip.c:int tpm_chip_register(struct tpm_chip *chip)
tpm-chip.c:EXPORT_SYMBOL_GPL(tpm_chip_register);
tpm-chip.c: * cleans up all the resources reserved by tpm_chip_register().
tpm_crb.c:      rc = tpm_chip_register(chip);
tpm_ftpm_tee.c: rc = tpm_chip_register(pvt_data->chip);
tpm_ftpm_tee.c:         dev_err(dev, "%s: tpm_chip_register failed with 
rc=%d\n",
tpm_i2c_atmel.c:        return tpm_chip_register(chip);
tpm_i2c_infineon.c:     return tpm_chip_register(chip);
tpm_i2c_nuvoton.c:      return tpm_chip_register(chip);
tpm_ibmvtpm.c:  return tpm_chip_register(chip);
tpm_infineon.c:         rc = tpm_chip_register(chip);
tpm_nsc.c:      rc = tpm_chip_register(chip);
tpm_tis_core.c: rc = tpm_chip_register(chip);
tpm_tis_i2c_cr50.c:     return tpm_chip_register(chip);
tpm_vtpm_proxy.c:       rc = tpm_chip_register(proxy_dev->chip);
xen-tpmfront.c: return tpm_chip_register(priv->chip)


   Stefan

> 
> 
> BR, Jarkko

