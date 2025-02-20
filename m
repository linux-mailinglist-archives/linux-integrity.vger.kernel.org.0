Return-Path: <linux-integrity+bounces-4945-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB30A3E4AA
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 20:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB5219C3D1F
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 19:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC94626388E;
	Thu, 20 Feb 2025 19:04:22 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90753214200;
	Thu, 20 Feb 2025 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740078262; cv=none; b=DLVE2NBPHqtT5++fE3dSFiEQ6/jC4CEUePUMjEzz7OvrMjUN3wsg2QgaW1YB8w4LGB1u+CpAXbR+Ze6e+IUiDsDk/OYYAHEdto/1eTlDmiSUqay7slNYO2iB/qN6cFZyvSR5uukd73tzi7miileWh5Zp2RqpCwh58sjePSdtvU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740078262; c=relaxed/simple;
	bh=9+MGxImlt2d6gStwzBbL3qDomWlTxi21P36nqCq0rds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E1jJni1A0zgfFXjOJrelfBitS8vUGYUYXVFxbcqVo0GHpjnk0L8+qqSVWvnujEkuBbiWafrxg/t5BozmrDlOX1+2yTZ6yi8x//BwFqnRnoKhCDqwJH7xWO+QNhiGIC6u7CeeX/E0RKmqd7h3aiJ+AiLkCmfEaqrkcJVDa/qPPZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF56A1007;
	Thu, 20 Feb 2025 11:04:37 -0800 (PST)
Received: from [10.122.18.111] (unknown [10.122.18.111])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3E083F59E;
	Thu, 20 Feb 2025 11:04:19 -0800 (PST)
Message-ID: <7c913fc0-0f2c-4327-99ee-510bdff8a537@arm.com>
Date: Thu, 20 Feb 2025 13:04:19 -0600
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] tpm_crb: clean-up and refactor check for idle
 support
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
 sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250219201014.174344-1-stuart.yoder@arm.com>
 <20250219201014.174344-3-stuart.yoder@arm.com> <Z7b2BlllE6HVIZNN@kernel.org>
Content-Language: en-US
From: Stuart Yoder <stuart.yoder@arm.com>
In-Reply-To: <Z7b2BlllE6HVIZNN@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/20/25 3:29 AM, Jarkko Sakkinen wrote:
> On Wed, Feb 19, 2025 at 02:10:11PM -0600, Stuart Yoder wrote:
>> Refactor TPM idle check to tpm_crb_has_idle(), and reduce paraentheses
>> usage in start method checks
>>
>> Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
>> ---
>>   drivers/char/tpm/tpm_crb.c | 36 +++++++++++++++++++++---------------
>>   1 file changed, 21 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
>> index ea085b14ab7c..31db879f1324 100644
>> --- a/drivers/char/tpm/tpm_crb.c
>> +++ b/drivers/char/tpm/tpm_crb.c
>> @@ -115,6 +115,16 @@ struct tpm2_crb_pluton {
>>   	u64 reply_addr;
>>   };
>>   
>> +/*
>> + * Returns true if the start method supports idle.
>> + */
>> +static inline bool tpm_crb_has_idle(u32 start_method)
>> +{
>> +	return start_method == ACPI_TPM2_START_METHOD ||
>> +	       start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD ||
>> +	       start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC;
>> +}
>> +
>>   static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32 value,
>>   				unsigned long timeout)
>>   {
>> @@ -173,9 +183,7 @@ static int __crb_go_idle(struct device *dev, struct crb_priv *priv)
>>   {
>>   	int rc;
>>   
>> -	if ((priv->sm == ACPI_TPM2_START_METHOD) ||
>> -	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) ||
>> -	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC))
>> +	if (!tpm_crb_has_idle(priv->sm))
>>   		return 0;
>>   
>>   	iowrite32(CRB_CTRL_REQ_GO_IDLE, &priv->regs_t->ctrl_req);
>> @@ -222,9 +230,7 @@ static int __crb_cmd_ready(struct device *dev, struct crb_priv *priv)
>>   {
>>   	int rc;
>>   
>> -	if ((priv->sm == ACPI_TPM2_START_METHOD) ||
>> -	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) ||
>> -	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC))
>> +	if (!tpm_crb_has_idle(priv->sm))
>>   		return 0;
>>   
>>   	iowrite32(CRB_CTRL_REQ_CMD_READY, &priv->regs_t->ctrl_req);
>> @@ -423,13 +429,13 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t len)
>>   	 * report only ACPI start but in practice seems to require both
>>   	 * CRB start, hence invoking CRB start method if hid == MSFT0101.
>>   	 */
>> -	if ((priv->sm == ACPI_TPM2_COMMAND_BUFFER) ||
>> -	    (priv->sm == ACPI_TPM2_MEMORY_MAPPED) ||
>> -	    (!strcmp(priv->hid, "MSFT0101")))
>> +	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER ||
>> +	    priv->sm == ACPI_TPM2_MEMORY_MAPPED ||
>> +	    !strcmp(priv->hid, "MSFT0101"))
>>   		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
>>   
>> -	if ((priv->sm == ACPI_TPM2_START_METHOD) ||
>> -	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD))
>> +	if (priv->sm == ACPI_TPM2_START_METHOD ||
>> +	    priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)
>>   		rc = crb_do_acpi_start(chip);
>>   
>>   	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
>> @@ -449,8 +455,8 @@ static void crb_cancel(struct tpm_chip *chip)
>>   
>>   	iowrite32(CRB_CANCEL_INVOKE, &priv->regs_t->ctrl_cancel);
>>   
>> -	if (((priv->sm == ACPI_TPM2_START_METHOD) ||
>> -	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)) &&
>> +	if ((priv->sm == ACPI_TPM2_START_METHOD ||
>> +	     priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) &&
>>   	     crb_do_acpi_start(chip))
>>   		dev_err(&chip->dev, "ACPI Start failed\n");
>>   }
>> @@ -609,8 +615,8 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
>>   	 * the control area, as one nice sane region except for some older
>>   	 * stuff that puts the control area outside the ACPI IO region.
>>   	 */
>> -	if ((priv->sm == ACPI_TPM2_COMMAND_BUFFER) ||
>> -	    (priv->sm == ACPI_TPM2_MEMORY_MAPPED)) {
>> +	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER ||
>> +	    priv->sm == ACPI_TPM2_MEMORY_MAPPED) {
>>   		if (iores &&
>>   		    buf->control_address == iores->start +
>>   		    sizeof(*priv->regs_h)) 
>> -- 
>> 2.34.1
>>
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thanks for the review.  Do you want me to respin and send out
a v6 with your Reviewed-by tags on patches 2/5 and 5/5?

Thanks,
Stuart


