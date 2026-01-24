Return-Path: <linux-integrity+bounces-8303-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAVpFPyYdGlJ7wAAu9opvQ
	(envelope-from <linux-integrity+bounces-8303-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 24 Jan 2026 11:03:40 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4057D2D7
	for <lists+linux-integrity@lfdr.de>; Sat, 24 Jan 2026 11:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F13363013710
	for <lists+linux-integrity@lfdr.de>; Sat, 24 Jan 2026 10:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EC01DF97C;
	Sat, 24 Jan 2026 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Alu5FVsI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E39883F;
	Sat, 24 Jan 2026 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769249014; cv=none; b=um79o3FcjKewH1aoUD1wCYh/hEmc93djKjosTz3ThioDnE9ThqHWuo+FTWHMLlB695sLJVyYmblhcbkNxGGRaQTme43PUAYl9PDnnLl0gu2y/oNAGbydrOeA8NmUmSVvr5MgbrlG5Y8Gj3yFRaNn9jY6D/JwwQWoy4AYO6FFpAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769249014; c=relaxed/simple;
	bh=7HjDQFsrIZZ2O+jImAdR17W4tRJbmz1pkyFCEQRRsMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tlgyl97tsqxKKyuvt1/Kse/E+MWVAL2VJW9OuQ7/1YYyiw0VpRRCahACzBO0Lv+Ngkr2CAbjC7Yj+EzpHHuy5sE5ha/bbqAKThljzWF8JSBsKte2ct8n82zRSq/sgCLVjIz8oq5XOOB7D4GmuBMJmigiOIuroucBsfjkUD0trhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Alu5FVsI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547E6C116D0;
	Sat, 24 Jan 2026 10:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769249013;
	bh=7HjDQFsrIZZ2O+jImAdR17W4tRJbmz1pkyFCEQRRsMk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Alu5FVsI2zbhiRtD7RJkfmJSHGHQgYngFB/7n2nLVto/ZSDMawxTA2QkO1vyAZUmS
	 CwRDUC8Clu+dWE8EcJSNMJfjPzSU0OipPIepMk7lyKZ5/CUcGhe6+Tnast6xPQXZeT
	 I/hWWGmsXGglhRMK0KBk2t474zRIdpkecJG1q9FyXujjaQ0xYhS1m64eVUXS2IjJL9
	 07n7V73N2GTPIiSHpzgBOezKOsJrykZnNS9xxVSe5BuZ5eUcpZW3DXMD6L+y+x916P
	 FJO7OOI51oS+TxxDdxl3LXA8HTWs1Xx/JGzkxplCSG3Pho1WbPmjWuL+2kr2hq+psn
	 31JN6oWp9jqUg==
Message-ID: <6182e996-f5fb-41fb-a100-a6baca5be540@kernel.org>
Date: Sat, 24 Jan 2026 11:03:28 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] pseries/plpks: add HCALLs for PowerVM Key Wrapping
 Module
To: Nayna Jain <nayna@linux.ibm.com>, Srish Srinivasan
 <ssrish@linux.ibm.com>, linux-integrity@vger.kernel.org,
 keyrings@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
 zohar@linux.ibm.com, rnsastry@linux.ibm.com, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20260115100504.488665-1-ssrish@linux.ibm.com>
 <20260115100504.488665-5-ssrish@linux.ibm.com>
 <5b29327e-9175-416f-b34b-da4f6ac03a96@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <5b29327e-9175-416f-b34b-da4f6ac03a96@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8303-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,HansenPartnership.com,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AF4057D2D7
X-Rspamd-Action: no action



Le 15/01/2026 à 21:45, Nayna Jain a écrit :
> 
> On 1/15/26 5:05 AM, Srish Srinivasan wrote:
>> The hypervisor generated wrapping key is an AES-GCM-256 symmetric key 
>> which
>> is stored in a non-volatile, secure, and encrypted storage called the 
>> Power
>> LPAR Platform KeyStore. It has policy based protections that prevent it
>> from being read out or exposed to the user.
>>
>> Implement H_PKS_GEN_KEY, H_PKS_WRAP_OBJECT, and H_PKS_UNWRAP_OBJECT 
>> HCALLs
>> to enable using the PowerVM Key Wrapping Module (PKWM) as a new trust
>> source for trusted keys. Disallow H_PKS_READ_OBJECT, H_PKS_SIGNED_UPDATE,
>> and H_PKS_WRITE_OBJECT for objects with the 'wrapping key' policy set.
>> Capture the availability status for the H_PKS_WRAP_OBJECT interface.
> 
> Reviewed-by: Nayna Jain <nayna@linux.ibm.com>
>>
>> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
>> ---
>>   Documentation/arch/powerpc/papr_hcalls.rst |  43 +++
>>   arch/powerpc/include/asm/plpks.h           |  10 +
>>   arch/powerpc/platforms/pseries/plpks.c     | 342 ++++++++++++++++++++-
>>   3 files changed, 393 insertions(+), 2 deletions(-)

[...]

>> diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/ 
>> platforms/pseries/plpks.c
>> index 4a08f51537c8..b97b7750f6a8 100644
>> --- a/arch/powerpc/platforms/pseries/plpks.c
>> +++ b/arch/powerpc/platforms/pseries/plpks.c
>> @@ -9,6 +9,32 @@
>>   #define pr_fmt(fmt) "plpks: " fmt
>> +#define PLPKS_WRAPKEY_COMPONENT    "PLPKSWR"
>> +#define PLPKS_WRAPKEY_NAME    "default-wrapping-key"
>> +
>> +/*
>> + * To 4K align the {input, output} buffers to the {UN}WRAP H_CALLs
>> + */
>> +#define PLPKS_WRAPPING_BUF_ALIGN    4096
>> +
>> +/*
>> + * To ensure the output buffer's length is at least 1024 bytes greater
>> + * than the input buffer's length during the WRAP H_CALL
>> + */
>> +#define PLPKS_WRAPPING_BUF_DIFF    1024
>> +
>> +#define PLPKS_WRAP_INTERFACE_BIT    3
>> +#define PLPKS_WRAPPING_KEY_LENGTH    32
>> +
>> +#define WRAPFLAG_BE_BIT_SET(be_bit) \
>> +    BIT_ULL(63 - (be_bit))
>> +
>> +#define WRAPFLAG_BE_GENMASK(be_bit_hi, be_bit_lo) \
>> +    GENMASK_ULL(63 - (be_bit_hi), 63 - (be_bit_lo))
>> +
>> +#define WRAPFLAG_BE_FIELD_PREP(be_bit_hi, be_bit_lo, val) \
>> +    FIELD_PREP(WRAPFLAG_BE_GENMASK(be_bit_hi, be_bit_lo), (val))

I get following build failure:

   CC      arch/powerpc/platforms/pseries/plpks.o
arch/powerpc/platforms/pseries/plpks.c: In function 'plpks_wrap_object':
arch/powerpc/platforms/pseries/plpks.c:36:9: error: implicit declaration 
of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
    36 |         FIELD_PREP(WRAPFLAG_BE_GENMASK(be_bit_hi, be_bit_lo), 
(val))
       |         ^~~~~~~~~~
arch/powerpc/platforms/pseries/plpks.c:1049:25: note: in expansion of 
macro 'WRAPFLAG_BE_FIELD_PREP'
  1049 |         objwrapflags |= WRAPFLAG_BE_FIELD_PREP(60, 63, 0x1);
       |                         ^~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors


>> +
>>   #include <linux/delay.h>
>>   #include <linux/errno.h>
>>   #include <linux/io.h>

