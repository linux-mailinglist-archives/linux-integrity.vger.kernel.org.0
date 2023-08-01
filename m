Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8535576BEE8
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Aug 2023 23:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjHAVBQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Aug 2023 17:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjHAVBP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Aug 2023 17:01:15 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD1E7B4
        for <linux-integrity@vger.kernel.org>; Tue,  1 Aug 2023 14:01:13 -0700 (PDT)
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id F3AC7238AE9F;
        Tue,  1 Aug 2023 14:01:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F3AC7238AE9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1690923673;
        bh=neqUcw1bWdMlCVvlmZAMwLWfAKai4Nr455p592WKaO0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kj+PJM8kXyY7LUpTK9V9qqegjJMDPwZFNDvVEuE8jAmhIRqNH0p4wMBCE/Yp3S3FZ
         eCm5cFmceXfHO1Ar89tSKaPUFf1He4RIgARIv5H+uDSP6khnZUpJBe59zGHlVgpCeJ
         Qxxq4OIUmjU9xNrhy1Ps5BrLA9RdCoZ1UZ3vWmRo=
Message-ID: <1d592ca1-1f6c-9eef-ce71-b07a837372b0@linux.microsoft.com>
Date:   Tue, 1 Aug 2023 14:01:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/6] tpm: implement TPM2 function to get update counter
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, zohar@linux.ibm.com,
        noodles@fb.com, bauermann@kolabnow.com, ebiederm@xmission.com,
        bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        peterhuewe@gmx.de, jgg@ziepe.ca, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
 <20230801181917.8535-2-tusharsu@linux.microsoft.com>
 <CUHFWAAKMKJN.2EA3ZHLOOPPGB@suppilovahvero>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <CUHFWAAKMKJN.2EA3ZHLOOPPGB@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Thanks for the response Jarkko.

On 8/1/23 12:02, Jarkko Sakkinen wrote:
> The short summary is cryptic to say the least.
Do you mean the patch subject line, or the description below?
> "update counter" does not map it to have anything to do with PCRs.
Agreed.  I noticed that when I was testing the patches.
The update counter is same for all PCRs.  It was also the same for
the two hash algo's I tested it for (SHA1 and SHA256). But the spec
description and Kernel implementation requires to pass the
pcr_idx and hash algo to PCR_Read command to get the update counter.
> Why not "tpm: Read pcrUpdateCounter field from TPM2_PCR_Read"?
As I said in the patch description below, update counter is only
needed for IMA measurements.  None of the other code that calls
tpm2_pcr_read() use the update counter.

I was not sure if you were okay changing the function signature and
implementation of tpm2_pcr_read(). It felt disruptive.

But I can update tpm2_pcr_read() if you are ok with it.
Please let me know.

I also have a few more thoughts on this in the comment below.
> On Tue Aug 1, 2023 at 9:19 PM EEST, Tushar Sugandhi wrote:
>> The TPM2_PCR_Read command returns TPM2_PCR_Read Response struct[1].  It
>> contains pcrUpdateCounter member which contains the current value of TPM
>> PCR update counter.  The update counter provides the number of times the
>> PCRs are updated, which is essential for tracking changes and verifying
>> system integrity.  Thus, subsystems (like IMA) should measure
>> pcrUpdateCounter value.  Although tpm2_pcr_read_out struct is returned
>> by tpm2_pcr_read(), it is not used by it's caller function tpm_pcr_read().
>> Further, TPM2_PCR_Read Response struct and pcrUpdateCounter is not
>> available in tpm1_pcr_read().
>>
>> PcrUpdateCounter is only needed in a specific case (IMA for measurements).
>> Changing tpm_pcr_read() and tpm2_pcr_read() function signature to return
>> tpm2_pcr_read_out struct would be a more disruptive change, since these
>> functions are used elsewhere too.  Creating separate functions to get
>> pcrUpdateCounter when needed would be a cleaner approach.
>>
>> Add a function, 'tpm2_pcr_get_update_counter()' to retrieve
>> the update counter for a given PCR index and algorithm ID on a TPM2 chip.
>>
>> This function complements existing TPM functionalities such as reading
>> and extending PCRs, and enhances the ability to monitor PCR status
>> in the Linux Kernel.
>>
>> [1] https://trustedcomputinggroup.org/wp-content/uploads/TCG_TPM2_r1p59_Part3_Commands_pub.pdf
>> Section 22.4.2, Page 206.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> ---
>>   drivers/char/tpm/tpm.h      |  3 +++
>>   drivers/char/tpm/tpm2-cmd.c | 48 +++++++++++++++++++++++++++++++++++++
>>   2 files changed, 51 insertions(+)
>>
>> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
>> index 830014a26609..60489f21d3bd 100644
>> --- a/drivers/char/tpm/tpm.h
>> +++ b/drivers/char/tpm/tpm.h
>> @@ -288,6 +288,9 @@ static inline void tpm_add_ppi(struct tpm_chip *chip)
>>   int tpm2_get_timeouts(struct tpm_chip *chip);
>>   int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
>>   		  struct tpm_digest *digest, u16 *digest_size_ptr);
>> +int tpm2_pcr_get_update_counter(struct tpm_chip *chip,
>> +				u32 pcr_idx, u16 alg_id,
>> +				u32 *update_counter);
> tpm_pcr_read_update_cnt()
I can rename 'get' -> 'read'

About 'tpm2' -> 'tpm':
I already have tpm_pcr_get_update_counter() defined in patch 2.

I was following the existing pattern here in patch 1 and 2 i. e.
  - Implementing the tpm1/tpm2 specific functionality in
    drivers/char/tpm/tpm.h, drivers/char/tpm/tpm2-cmd.c,
    drivers/char/tpm/tpm1-cmd.c.

  - And combining that functionality in drivers/char/tpm/tpm-interface.c
    and exposing it to other subsystems (like IMA) through 
include/linux/tpm.h
    (patch 2 of this series)

BTW, if I understand correctly, the update counter is not available in 
TPM 1.2.

Please let me know if you want me to expose the functionality directly
from drivers/char/tpm/tpm2-cmd.c and getting rid of patch #2 of this series.

~Tushar

>>   int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>>   		    struct tpm_digest *digests);
>>   int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
>> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
>> index 93545be190a5..55f4e102289a 100644
>> --- a/drivers/char/tpm/tpm2-cmd.c
>> +++ b/drivers/char/tpm/tpm2-cmd.c
>> @@ -216,6 +216,54 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
>>   	return rc;
>>   }
>>   
>> +/**
>> + * tpm2_pcr_get_update_counter() - gets an update counter value for a PCR bank
>> + * @chip: TPM chip to use
>> + * @pcr_idx: PCR index used to retrieve the update counter
>> + * @alg_id:	alg id used to retrieve the update counter
>> + * @update_counter: output update counter value
>> + *
>> + * Return: Same as with tpm_transmit_cmd.
>> + */
>> +int tpm2_pcr_get_update_counter(struct tpm_chip *chip,
>> +				u32 pcr_idx, u16 alg_id, u32 *update_counter)
>> +{
>> +	int rc;
>> +	struct tpm_buf buf;
>> +	struct tpm2_pcr_read_out *read_out;
>> +	u8 pcr_select[TPM2_PCR_SELECT_MIN] = {0};
>> +
>> +	if (pcr_idx >= TPM2_PLATFORM_PCR)
>> +		return -EINVAL;
>> +
>> +	if (!update_counter)
>> +		return -EINVAL;
>> +
>> +	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_PCR_READ);
>> +	if (rc)
>> +		return rc;
>> +
>> +	pcr_select[pcr_idx >> 3] = 1 << (pcr_idx & 0x7);
>> +
>> +	tpm_buf_append_u32(&buf, 1);
>> +	tpm_buf_append_u16(&buf, alg_id);
>> +	tpm_buf_append_u8(&buf, TPM2_PCR_SELECT_MIN);
>> +	tpm_buf_append(&buf, (const unsigned char *)pcr_select,
>> +		       sizeof(pcr_select));
>> +
>> +	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to read a pcr value");
>> +	if (rc)
>> +		goto out;
>> +
>> +	read_out = (struct tpm2_pcr_read_out *)&buf.data[TPM_HEADER_SIZE];
>> +
>> +	*update_counter = be32_to_cpu(read_out->update_cnt);
>> +
>> +out:
>> +	tpm_buf_destroy(&buf);
>> +	return rc;
>> +}
>> +
>>   struct tpm2_null_auth_area {
>>   	__be32  handle;
>>   	__be16  nonce_size;
>> -- 
>> 2.25.1
> BR, Jarkko
