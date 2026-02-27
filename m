Return-Path: <linux-integrity+bounces-8675-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Bb0ImpWoWk+sQQAu9opvQ
	(envelope-from <linux-integrity+bounces-8675-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Feb 2026 09:31:38 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2ED1B493B
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Feb 2026 09:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAF4C3096A7E
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Feb 2026 08:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56974389DE8;
	Fri, 27 Feb 2026 08:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rFZwGEED"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83B33876C5;
	Fri, 27 Feb 2026 08:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772180972; cv=none; b=gJBnqW4XIogSczJIUI7bxtBj9bg4EK5ruuGNiRJcmkdQZHRpYbmCFFFq+aBqZUfOVycqPaBgBTbFEpa0YKOkGNcXxmXpNOCSisk8kExP5hD0HCCs/928U2A2biwgZg0zzwEthKwga2Zqm3B4ToFi5HFsl9J/jQrkBKyqwbyviJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772180972; c=relaxed/simple;
	bh=zAzO+h48HV7s9pSiZJT07KsKhdg6LQT76aLPcKVBVmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UnutkohAJkJSYJgNJPVa42e0x8pzDwxXQtoGG6UPhms5AhVERyzGa2j3I/+Q2DFWUE/U1KFqjpxvDxUSRShyvmX/75ETiXvJZ3CbfK0FXwmpbAAyfWFRhJoFrhLrR1fUXI8esSyiYlViPcZynNuNy0U11bkTOD5W/lf2lobvimY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rFZwGEED; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R2K19s2935076;
	Fri, 27 Feb 2026 08:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WjUTBM
	Cek3Z8NujeohpUr7Q1Jg5lzgvRg/Kd1H3BpIc=; b=rFZwGEEDjDPaB/ANdESy94
	TO6krgNZIskePhF5hj8ZRHLwNrHTk12+nUhWgf0urOtSdCgQrQBl5F6vK2TC49dL
	gO6LniLcOqUQIi00Tb8IV53MEiZ90/6wEdzfy7dv0SmtwMAdV0l8/UDvXFvIat5W
	YTK2jL5fU2majG8iPIiyU7shfJ5/yjmSDb8Z5+4k1ubtwNiRPldkkhLS3B6OHQ1F
	HmHliACN4ZXYFl3bZ4n8Umam7qa6gnJhzp19pwpnm2JSVpzAa39kiy+9F2JTI2DY
	AawzE2MW4nrLFqLcPaTgpmHc1WGfL9g/lCDSkaXxgHIQHtiEmBTvF+bkjT1zFHfQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf24gtw60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 08:29:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61R7k5tB015983;
	Fri, 27 Feb 2026 08:29:15 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfq1t17ad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 08:29:15 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61R8TDps11272704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 08:29:13 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29EAA58059;
	Fri, 27 Feb 2026 08:29:13 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB43F58057;
	Fri, 27 Feb 2026 08:29:08 +0000 (GMT)
Received: from [9.98.107.249] (unknown [9.98.107.249])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Feb 2026 08:29:08 +0000 (GMT)
Message-ID: <5d316ad2-a842-4d29-b155-ecfc47aa1066@linux.ibm.com>
Date: Fri, 27 Feb 2026 13:59:07 +0530
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] Extend "trusted" keys to support a new trust
 source named the PowerVM Key Wrapping Module (PKWM)
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, nayna@linux.ibm.com, rnsastry@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20260201135930.898721-1-ssrish@linux.ibm.com>
 <31dfcf7a-5b3d-406d-bdd4-c8b09f7eb1f0@kernel.org>
Content-Language: en-US
From: Srish Srinivasan <ssrish@linux.ibm.com>
In-Reply-To: <31dfcf7a-5b3d-406d-bdd4-c8b09f7eb1f0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TNRIilla c=1 sm=1 tr=0 ts=69a155dc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=zIm8Uhvo-wyo9pAa0GkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ftecudPO92h21O9-uuzMyzd80otBlo3e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA2OCBTYWx0ZWRfXwpbjmUQTgC4u
 Ehy/QxKdbUadIYYvLL23tes8BFOFwCzmoZL2oIgujluNIS9TTyT42dTdlAesAtHZra4O+IvLIMq
 C351O6sdTT1SRwgUMv8gpRqRS+KbIiy4lIU/yAp+7UQS2I+V7/1aoB2ez8KtTk7nIMERsupJirk
 lxWj7HihPH6iJDTQiabEvunetvZbhg5vWcAmVlTpTRfTzANMjDGvtPMI4LEuvO1SCkypC/j8Kew
 l9xCuW65AvlizjOKMFho4XVmEnkBc2M6JcnrnB6i8Lj5BfuyG5ZjuH9V6i1nZJsF1uvShLk5rFE
 n0+YKBBkVrzTdo/oCUbvinICxhDTjwGIAnB2cADH0q4Lzubmm86IkikYzaE046ujazGhPRx1ZcT
 yi0ComgtwvUyED8oKcBAwq4byetHhVVdazdu0zQ3K2XAaiHWVVZOvrLjUvZ6qxDU5HZq4MGz/Jl
 hyIk/JjKi8SD15tJfRw==
X-Proofpoint-ORIG-GUID: L_WJThrLdBOahqN_YT_rFmFPZnfrogXt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602270068
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8675-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,HansenPartnership.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ssrish@linux.ibm.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 2D2ED1B493B
X-Rspamd-Action: no action

Hi Christophe,

On 2/27/26 1:21 PM, Christophe Leroy (CS GROUP) wrote:
>
>
> Le 01/02/2026 à 14:59, Srish Srinivasan a écrit :
>> Power11 has introduced a feature called the PowerVM Key Wrapping Module
>> (PKWM), where PowerVM in combination with Power LPAR Platform KeyStore
>> (PLPKS) [1] supports a new feature called "Key Wrapping" [2] to protect
>> user secrets by wrapping them using a hypervisor generated wrapping key.
>> This wrapping key is an AES-GCM-256 symmetric key that is stored as an
>> object in the PLPKS. It has policy based protections that prevents it 
>> from
>> being read out or exposed to the user. This wrapping key can then be 
>> used
>> by the OS to wrap or unwrap secrets via hypervisor calls.
>>
>> This patchset intends to add the PKWM, which is a combination of IBM
>> PowerVM and PLPKS, as a new trust source for trusted keys. The 
>> wrapping key
>> does not exist by default and its generation is requested by the 
>> kernel at
>> the time of PKWM initialization. This key is then persisted by the 
>> PKWM and
>> is used for wrapping any kernel provided key, and is never exposed to 
>> the
>> user. The kernel is aware of only the label to this wrapping key.
>>
>> Along with the PKWM implementation, this patchset includes two 
>> preparatory
>> patches: one fixing the kernel-doc inconsistencies in the PLPKS code and
>> another reorganizing PLPKS config variables in the sysfs.
>>
>> Changelog:
>>
>> v6:
>
> Seems like v5 was applied, if needed can you send followup patch ?
>
> Christophe


I had sent out a patch on top of v5 to take care of this, and it has 
been applied.

thanks,
Srish.


>
>>
>> * Patch 1 to Patch 3:
>>    - Add Nayna's Tested-by tag
>> * Patch 4
>>    - Fix build error reported by kernel test robot <lkp@intel.com>
>>    - Add Nayna's Tested-by tag
>> * Patch 5
>>    - Add Nayna's Tested-by tag
>>
>> v5:
>>
>> * Patch 1 to Patch 3:
>>    - Add Nayna's Reviewed-by tag
>> * Patch 4:
>>    - Fix build error identified by chleroy@kernel.org
>>    - Add Nayna's Reviewed-by tag
>> * Patch 5:
>>    - Add Reviewed-by tags from Nayna and Jarkko
>>
>> v4:
>>
>> * Patch 5:
>>    - Add a per-backend private data pointer in trusted_key_options
>>      to store a pointer to the backend-specific options structure
>>    - Minor clean-up
>>
>> v3:
>>
>> * Patch 2:
>>    - Add Mimi's Reviewed-by tag
>> * Patch 4:
>>    - Minor tweaks to some print statements
>>    - Fix typos
>> * Patch 5:
>>    - Fix typos
>>    - Add Mimi's Reviewed-by tag
>> * Patch 6:
>>    - Add Mimi's Reviewed-by tag
>>
>> v2:
>>
>> * Patch 2:
>>    - Fix build warning detected by the kernel test bot
>> * Patch 5:
>>    - Use pr_debug inside dump_options
>>    - Replace policyhande with wrap_flags inside dump_options
>>    - Provide meaningful error messages with error codes
>>
>> Nayna Jain (1):
>>    docs: trusted-encryped: add PKWM as a new trust source
>>
>> Srish Srinivasan (5):
>>    pseries/plpks: fix kernel-doc comment inconsistencies
>>    powerpc/pseries: move the PLPKS config inside its own sysfs directory
>>    pseries/plpks: expose PowerVM wrapping features via the sysfs
>>    pseries/plpks: add HCALLs for PowerVM Key Wrapping Module
>>    keys/trusted_keys: establish PKWM as a trusted source
>>
>>   .../ABI/testing/sysfs-firmware-plpks          |  58 ++
>>   Documentation/ABI/testing/sysfs-secvar        |  65 --
>>   .../admin-guide/kernel-parameters.txt         |   1 +
>>   Documentation/arch/powerpc/papr_hcalls.rst    |  43 ++
>>   .../security/keys/trusted-encrypted.rst       |  50 ++
>>   MAINTAINERS                                   |   9 +
>>   arch/powerpc/include/asm/hvcall.h             |   4 +-
>>   arch/powerpc/include/asm/plpks.h              |  95 +--
>>   arch/powerpc/include/asm/secvar.h             |   1 -
>>   arch/powerpc/kernel/secvar-sysfs.c            |  21 +-
>>   arch/powerpc/platforms/pseries/Makefile       |   2 +-
>>   arch/powerpc/platforms/pseries/plpks-secvar.c |  29 -
>>   arch/powerpc/platforms/pseries/plpks-sysfs.c  |  96 +++
>>   arch/powerpc/platforms/pseries/plpks.c        | 688 +++++++++++++++++-
>>   include/keys/trusted-type.h                   |   7 +-
>>   include/keys/trusted_pkwm.h                   |  33 +
>>   security/keys/trusted-keys/Kconfig            |   8 +
>>   security/keys/trusted-keys/Makefile           |   2 +
>>   security/keys/trusted-keys/trusted_core.c     |   6 +-
>>   security/keys/trusted-keys/trusted_pkwm.c     | 190 +++++
>>   20 files changed, 1207 insertions(+), 201 deletions(-)
>>   create mode 100644 Documentation/ABI/testing/sysfs-firmware-plpks
>>   create mode 100644 arch/powerpc/platforms/pseries/plpks-sysfs.c
>>   create mode 100644 include/keys/trusted_pkwm.h
>>   create mode 100644 security/keys/trusted-keys/trusted_pkwm.c
>>
>

