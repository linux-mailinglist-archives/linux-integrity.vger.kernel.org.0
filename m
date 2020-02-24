Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 671E116AB44
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Feb 2020 17:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgBXQXU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Feb 2020 11:23:20 -0500
Received: from linux.microsoft.com ([13.77.154.182]:38688 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbgBXQXU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Feb 2020 11:23:20 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2DF5820B9C02;
        Mon, 24 Feb 2020 08:23:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2DF5820B9C02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1582561399;
        bh=R8hTPYQqDrNUi0y6hhzMys/hXPO9LcfPiXtdMT63Z30=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rMG006gDb4sYdaogCe5sPL0Qnk108XZEh+z6qmb13n6q8iImHc5M/TJHCxbJpPwW8
         KBq31oW50vKKZHYOSSFB1iGnGWaZIsKLiPufyAUxsKe18cPEXHvZwRX4n9O2HWT7d/
         JYu/41eYIgHAlEBpN71wYgB+S28SCcglhuXAzW4A=
Subject: Re: [RFC PATCH 0/8] ima-evm-utils: calculate per TPM bank template
 digest
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Petr Vorel <pvorel@suse.cz>
References: <1582310338-1562-1-git-send-email-zohar@linux.ibm.com>
 <ed6849bf-0988-3807-1b8f-151871f702d1@linux.microsoft.com>
 <1582420362.10443.18.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <bb7370d7-6c20-69ef-edfa-f50d75859100@linux.microsoft.com>
Date:   Mon, 24 Feb 2020 08:23:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1582420362.10443.18.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/22/20 5:12 PM, Mimi Zohar wrote:

> 
> There are two aspects to Roberto's changes - extending the TPM banks
> with the bank specific template digest and verifying the boot
> aggregate.  This patch set only addresses the first aspect.
> 
> Assuming both the sha1 and sha256 TPM banks are enabled,
> 
> # tssgetcapability -cap 5
> 2 PCR selections
>      hash TPM_ALG_SHA1
>      TPMS
> _PCR_SELECTION length 3
>      ff ff ff
>      hash TPM_ALG_SHA256
>      TPMS_PC
> R_SELECTION length 3
>      ff ff ff
> 
> the output would look like:
>   
> # evmctl ima_measurement -v --list
> /sys/kernel/security/integrity/ima/binary_runtime_measurements
> 
> sha1: PCRAgg  10: 7723f6d980725507e5d0eb643dc179aae0efb719
> sha1: TPM PCR-10: 7723f6d980725507e5d0eb643dc179aae0efb719
> sha1 PCR-10: succeed
> 
> sha256: PCRAgg  10:
> 5254d6dce62765f884dc67dac8d59a8721ae14495ae4a0cb73426d0c013a82b2
> sha256: TPM PCR-10:
> 5254d6dce62765f884dc67dac8d59a8721ae14495ae4a0cb73426d0c013a82b2
> sha256 PCR-10: succeed
> 

Thanks Mimi and Roberto for the update.

tpm2_pcrread command outputs the PCR values.
The one for PCR-10 matches the data output by evmctl.

  -lakshmi


