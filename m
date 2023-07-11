Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C0474F842
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jul 2023 21:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjGKTI2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jul 2023 15:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjGKTI1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jul 2023 15:08:27 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7FAC170A
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jul 2023 12:08:26 -0700 (PDT)
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id B729821C3A93;
        Tue, 11 Jul 2023 12:08:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B729821C3A93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1689102506;
        bh=LPli2HTbXE2281jdsnFjMad67IlCVJdzYiNCSMTBkA0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XbEja+wqWTOfCry2WJiDw9gszkL3yQ4+gRp6Y0iVTp8xnRmEv5gU8YIkVrsRZuHSN
         aJV27StOq1uSKOLB7VYf1kNDefTfeCLtj6agHLA8Nl1eFHcI5ks0vnrp+412nvtEnY
         sV1cmwj3Q0V2G09/sR9+tcPJk5JVg2Nk6FyBQIQw=
Message-ID: <9b7db004-0517-9163-e9d5-9555b416144c@linux.microsoft.com>
Date:   Tue, 11 Jul 2023 12:08:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 06/10] ima: update buffer at kexec execute with ima
 measurements
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, noodles@fb.com,
        bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com,
        Eric Biederman <ebiederm@xmission.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
 <20230703215709.1195644-7-tusharsu@linux.microsoft.com>
 <5cd5b5efc443cbdce9dce3b121f4dbfd2db6dea3.camel@linux.ibm.com>
 <a3f141d0585580676e6738ff6596dad106f7bf18.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <a3f141d0585580676e6738ff6596dad106f7bf18.camel@linux.ibm.com>
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

On 7/7/23 12:49, Mimi Zohar wrote:
> On Fri, 2023-07-07 at 11:01 -0400, Mimi Zohar wrote:
>> Hi Tushar,
>>
>> On Mon, 2023-07-03 at 14:57 -0700, Tushar Sugandhi wrote:
>>
>>> +/*
>>> + * Called during kexec execute so that IMA can update the measurement list.
>>> + */
>>> +static int ima_update_kexec_buffer(struct notifier_block *self,
>>> +				   unsigned long action, void *data)
>>> +{
>>> +	void *new_buffer = NULL;
>>> +	size_t new_buffer_size, cur_buffer_size;
>>> +	bool resume = false;
>>> +
>>> +	if (!kexec_in_progress) {
>>> +		pr_info("%s: No kexec in progress.\n", __func__);
>>> +		return NOTIFY_OK;
>>> +	}
>>> +
>>> +	if (!ima_kexec_buffer) {
>>> +		pr_err("%s: Kexec buffer not set.\n", __func__);
>>> +		return NOTIFY_OK;
>>> +	}
>>> +
>>> +	ima_measurements_suspend();
>>> +
>>> +	cur_buffer_size = kexec_segment_size - sizeof(struct ima_kexec_hdr);
>>> +	new_buffer_size = ima_get_binary_runtime_size();
>>> +	if (new_buffer_size > cur_buffer_size) {
>>> +		pr_err("%s: Measurement list grew too large.\n", __func__);
>>> +		resume = true;
>>> +		goto out;
>>> +	}
>> This changes the current behavior of carrying as many measurements
>> across kexec as possible.  True the measurement list won't verify
>> against the TPM PCRs, but not copying the measurements leaves the
>> impression there weren't any previous measurements.
>>
>> This also explains the reason for allocating an IMA buffer (patch 1/10)
>> and not writing the measurements directly into the kexec buffer.
> If not carrying even a partial measurement list across kexec is
> desired, then in addition to the "boot_aggregate" record, define a new
> record containing the TPM pcrcounter.  With this information,
> attestation servers will at least be able to detect if the measurement
> list was truncated.
>
> thanks,
>
> Mimi
Sure.  Recording TPM pcrcounter at boot aggregate and
Kexec 'load' should provide the necessary information to the
attestation servers.  We can implement this if needed, based on how
rest of the series evolves.

~Tushar
>>> +	ima_populate_buf_at_kexec_execute(&new_buffer_size, &new_buffer);
>>> +
>>> +	if (!new_buffer) {
>>> +		pr_err("%s: Dump measurements failed.\n", __func__);
>>> +		resume = true;
>>> +		goto out;
>>> +	}
>>> +	memcpy(ima_kexec_buffer, new_buffer, new_buffer_size);
>>> +out:
>>> +	kimage_unmap_segment(ima_kexec_buffer);
>>> +	ima_kexec_buffer = NULL;
>>> +
>>> +	if (resume)
>>> +		ima_measurements_resume();
>>> +
>>> +	return NOTIFY_OK;
>>> +}
>>> +
>>>   #endif /* IMA_KEXEC */
>>>   
>>>   /*
