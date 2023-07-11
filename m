Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC0A74F7BE
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jul 2023 20:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjGKSFr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jul 2023 14:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjGKSFq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jul 2023 14:05:46 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6D7D10EF
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jul 2023 11:05:44 -0700 (PDT)
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4159121C3A89;
        Tue, 11 Jul 2023 11:05:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4159121C3A89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1689098744;
        bh=gnwBbc0096fk8sZcdWqSOaZsZqqh1DSnlH3gad1n/+E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=THjKfdiysIOyvbKoNcNWEfFb93HpTGW13bGEC+OQ443cFcjarc1OD4AJNZpJ4QLlS
         jffffuFtGMFQockrlU3g9YhjWZ5CJ/NwX+NLDVe6KGHP4tr+llo0kNjRQDgVSZR1hP
         D5Kn6oeP0LU8k8JpHKMTL0pJwFn3F7n/ycQWZ31M=
Message-ID: <1bd07f48-0580-1db2-18f2-a8c268e876b3@linux.microsoft.com>
Date:   Tue, 11 Jul 2023 11:05:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 02/10] ima: implement function to populate buffer at kexec
 execute
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, noodles@fb.com,
        bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com,
        Eric Biederman <ebiederm@xmission.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
 <20230703215709.1195644-3-tusharsu@linux.microsoft.com>
 <7ecb8c00ca03831c68c3cdae8b402b119463f4f3.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <7ecb8c00ca03831c68c3cdae8b402b119463f4f3.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Adding Eric to cc.

On 7/7/23 06:00, Mimi Zohar wrote:
> Hi Tushar,
>
> On Mon, 2023-07-03 at 14:57 -0700, Tushar Sugandhi wrote:
>> There is no existing IMA functionality to just populate the buffer at
>> kexec execute with IMA measurements.
> The same function that copies the measurement list at kexec 'load',
> could be re-used at kexec 'exec'.   Why is a new function that is very
> similar to the existing ima_dump_measurement_list() needed?
The current implementation of ima_dump_measurement_list() does both -
(1) allocation of buffer and (2) copying the measurements at kexec ‘load’.

The goal is to copy the measurements at kexec ‘execute’.

As I mentioned earlier, my understanding is the buffer must be allocated
at kexec ‘load’ time.  And the segment size cannot change between kexec
‘load’ and kexec ‘execute’.

That’s why I believe the two new functions are needed.
So I split the functionality in ima_dump_measurement_list() into
two functions –
  (1) ima_allocate_buf_at_kexec_load() in patch 01/10 and
  (2) ima_populate_buf_at_kexec_execute()  in patch 02/10

and then deprecated ima_dump_measurement_list() in patch 7/10.

If I call ima_dump_measurement_list() both at kexec ‘load’
as well as kexec ‘execute’, it will result in double memory allocation.

As you said, if the functionality can be achieved by simply moving
ima_dump_measurement_list() from kexec ‘load’ to kexec ‘execute’ –
then you are right, we don’t need the two separate functions.

~Tushar

>
>> Implement a function to iterate over ima_measurements and populate the
>> ima_kexec_file buffer.  After the loop, populate ima_khdr with buffer
>> details (version, buffer size, number of measurements).  Copy the ima_khdr
>> data into ima_kexec_file.buf and update buffer_size and buffer.
>>
>>
>> The patch assumes that the ima_kexec_file.size is sufficient to hold all
>> the measurements.  It returns an error and does not handle scenarios where
>> additional space might be needed.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> ---
>>   security/integrity/ima/ima_kexec.c | 52 ++++++++++++++++++++++++++++++
>>   1 file changed, 52 insertions(+)
>>
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index 48a683874044..858b67689701 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -62,6 +62,58 @@ static int ima_allocate_buf_at_kexec_load(void)
>>   	return 0;
>>   }
>>   
>> +static int ima_populate_buf_at_kexec_execute(unsigned long *buffer_size, void **buffer)
>> +{
>> +	struct ima_queue_entry *qe;
>> +	int ret = 0;
>> +
>> +	/*
>> +	 * Ensure the kexec buffer is large enough to hold ima_khdr
>> +	 */
>> +	if (ima_kexec_file.size < sizeof(ima_khdr)) {
>> +		pr_err("%s: Kexec buffer size too low to hold ima_khdr\n",
>> +			__func__);
>> +		ima_clear_kexec_file();
>> +		return -ENOMEM;
>> +	}
>> +
>> +	list_for_each_entry_rcu(qe, &ima_measurements, later) {
>> +		if (ima_kexec_file.count < ima_kexec_file.size) {
>> +			ima_khdr.count++;
>> +			ima_measurements_show(&ima_kexec_file, qe);
>> +		} else {
>> +			ret = -ENOMEM;
>> +			pr_err("%s: Kexec ima_measurements buffer too small\n",
>> +				__func__);
>> +			break;
>> +		}
>> +	}
>> +	if (ret < 0)
>> +		goto out;
>> +
>> +	/*
>> +	 * fill in reserved space with some buffer details
>> +	 * (eg. version, buffer size, number of measurements)
>> +	 */
>> +	ima_khdr.buffer_size = ima_kexec_file.count;
>> +	if (ima_canonical_fmt) {
>> +		ima_khdr.version = cpu_to_le16(ima_khdr.version);
>> +		ima_khdr.count = cpu_to_le64(ima_khdr.count);
>> +		ima_khdr.buffer_size = cpu_to_le64(ima_khdr.buffer_size);
>> +	}
>> +
>> +	memcpy(ima_kexec_file.buf, &ima_khdr, sizeof(ima_khdr));
>> +	*buffer_size = ima_kexec_file.count;
>> +	*buffer = ima_kexec_file.buf;
>> +
>> +out:
>> +	if (ret < 0)
>> +		ima_clear_kexec_file();
>> +
>> +	return ret;
>> +}
>> +
>> b+
>>   static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>>   				     unsigned long segment_size)
>>   {
