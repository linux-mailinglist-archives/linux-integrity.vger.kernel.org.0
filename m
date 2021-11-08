Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F76449D3C
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Nov 2021 21:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbhKHUs4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Nov 2021 15:48:56 -0500
Received: from linux.microsoft.com ([13.77.154.182]:58602 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbhKHUsw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Nov 2021 15:48:52 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 310C720B4183;
        Mon,  8 Nov 2021 12:46:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 310C720B4183
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1636404363;
        bh=6KCqm1lA1z9E/eJq6WUCU8PZPBXb87lLm4CmQ28ERpk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oztc5gFl9EDDC/AMTlb64X5u0tGHmlz/au9bWgONE+LJsNJvplEqARRtkkGN+eiLL
         TfhrY3HHFC1uLGhKii0xAmw2TQDRxIKXOX4+t26ETwC6AEritq/a4uBPPAFt03h0EH
         z7Mrak9wGi7+p4ncSH/XYLQsi6JeMRSFR8wqKQDo=
Message-ID: <e7bdd3d2-8928-b3d4-852e-83ff3e988bc0@linux.microsoft.com>
Date:   Mon, 8 Nov 2021 12:46:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: ima-evm-utils: version 1.4 released
Content-Language: en-US
To:     Ken Goldman <kgold@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>
References: <9af9143c2c90f1ebae6cc34a7100673332cce1a1.camel@linux.ibm.com>
 <YYToG+8u/edIcc3u@pevik>
 <e7213f8c-a6f5-f73e-d88f-a264e6d231bb@linux.microsoft.com>
 <36ee20b3-cdd7-e879-7c8b-235578e41628@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
In-Reply-To: <36ee20b3-cdd7-e879-7c8b-235578e41628@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Thanks for the response Ken.

>> I am seeing the following errors when trying to validate IMA 
>> measurement using the util. I'd like to try the latest (v1.4).
>>
>> sudo ./evmctl ima_measurement
>> /sys/kernel/security/ima/binary_runtime_measurements  -vv
>>
>> Error messages for the above command
>> ------------------------------------
>> Using tsspcrread to read PCRs.
>>
>> tpm2_pcr_supported:67 Found 'tsspcrread' in $PATHread_tpm_banks:1923
>> Failed to read sha1 PCRs: (TSS_Socket_Open: Error on connect to
>> localhost:2321)
>>
>> read_tpm_banks:1923 Failed to read sha256 PCRs: (TSS_Socket_Open: Error
>> on connect to localhost:2321)
>>
>> Failed to read any TPM PCRs
>>
> 
> This sounds like your program is trying to connect to a SW TPM,
> and the SW TPM process is not running.
> 

There is a physical TPM on the machine where I am running ima-evm-utils 
to verify IMA measurements. I want to use that physical TPM and not a 
software TPM.

I am seeing the error with v1.4 sources as well.

I will review ima-evm-utils code and check how to get it to use the 
physical TPM for validating the IMA measurements.

  -lakshmi

