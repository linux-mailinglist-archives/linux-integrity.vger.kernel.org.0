Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2BC4466E6
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Nov 2021 17:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbhKEQX7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Nov 2021 12:23:59 -0400
Received: from linux.microsoft.com ([13.77.154.182]:56750 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhKEQX5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Nov 2021 12:23:57 -0400
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 625FC20ABAAD;
        Fri,  5 Nov 2021 09:21:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 625FC20ABAAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1636129277;
        bh=F2teXfs8nuzXu+yRspc/9E5HH9DMPlWFIm6tmxJE3Bg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YammnaUErp6Nw02WK7QR6e0ysb91Itbv9z60bkGKoFhulx/BP4wo9PypdT0kPVHqb
         Y6EojvXBPru9EAab2gTZIy0n+WVAY742jwTBfPqzdF1xlwDYeYBKsqeqEb1iVXqBiL
         /y/s8Iegz/tFw0wO/yBFxOys3IeM9bGDBVUURQ7Q=
Message-ID: <e7213f8c-a6f5-f73e-d88f-a264e6d231bb@linux.microsoft.com>
Date:   Fri, 5 Nov 2021 09:21:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: ima-evm-utils: version 1.4 released
Content-Language: en-US
To:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>
References: <9af9143c2c90f1ebae6cc34a7100673332cce1a1.camel@linux.ibm.com>
 <YYToG+8u/edIcc3u@pevik>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
In-Reply-To: <YYToG+8u/edIcc3u@pevik>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 11/5/2021 1:15 AM, Petr Vorel wrote:
> Hi Mimi,
> 
>> Please refer to the NEWS file for the short summary and the git history
>> for details of the ima-evm-utils v1.4 release.

Thanks for the info Mimi.

I checked both "master" and "next-testing" branches in the following, 
and I still see 1.3.2 version only.

	https://github.com/pevik/ima-evm-utils

Is there a different github url for the latest ima-evm-utils source?

I am seeing the following errors when trying to validate IMA measurement 
using the util. I'd like to try the latest (v1.4).

sudo ./evmctl ima_measurement
/sys/kernel/security/ima/binary_runtime_measurements  -vv

Error messages for the above command
------------------------------------
Using tsspcrread to read PCRs.

tpm2_pcr_supported:67 Found 'tsspcrread' in $PATHread_tpm_banks:1923
Failed to read sha1 PCRs: (TSS_Socket_Open: Error on connect to
localhost:2321)

read_tpm_banks:1923 Failed to read sha256 PCRs: (TSS_Socket_Open: Error
on connect to localhost:2321)

Failed to read any TPM PCRs

thanks,
  -lakshmi


