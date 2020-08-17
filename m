Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9004F24687F
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Aug 2020 16:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgHQOhT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Aug 2020 10:37:19 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47258 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbgHQOhT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Aug 2020 10:37:19 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 58E3120B4908;
        Mon, 17 Aug 2020 07:37:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 58E3120B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597675038;
        bh=eV/AWxZV1FrXw2fb5PQwYBji5wQXR/YIeAvGqYlOYlU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Xt4r1PXWuTeEZ5V7ta1WdLRKieqK2DgtlXlioYRUuyXf/CjfA3kSQQttUaIu/tqtn
         1DusYIHSTyWe1yh2H57jNVyQ9Hu8wx9IozwKEp8du5bVCIBiRZD/28FtaTj1FAAQcI
         pd66W98nUug36szFOhG1pRPotbN4WeecxiDzvFyM=
Subject: Re: [PATCH v3 0/4] IMA: verify measurement of certificate imported
 into a keyring
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
References: <20200817130916.27634-1-pvorel@suse.cz>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <2aa76946-02d1-17c2-557a-5a5f3bd05319@linux.microsoft.com>
Date:   Mon, 17 Aug 2020 07:37:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817130916.27634-1-pvorel@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/17/20 6:09 AM, Petr Vorel wrote:

Hi Petr,

> Hi Mimi, Lakshmi,
> 
> changes v2->v3:
> fixed regression in my third commit.
> (please verify it on installed LTP, or at least run make install in
> testcases/kernel/security/integrity/ima/datafiles/ima_keys/)
> 

Verified keys tests and also kexec tests. Thanks.

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

> 
> Lachlan Sneff (1):
>    IMA: Add a test to verify measurement of certificate imported into a
>      keyring
> 
> Petr Vorel (3):
>    IMA/ima_keys.sh: Fix policy content check usage
>    IMA: Refactor datafiles directory
>    IMA/ima_keys.sh: Enhance policy checks
> 
>   .../kernel/security/integrity/ima/README.md   |  12 +-
>   .../security/integrity/ima/datafiles/Makefile |  10 +-
>   .../ima/datafiles/ima_kexec/Makefile          |  11 ++
>   .../datafiles/{ => ima_kexec}/kexec.policy    |   0
>   .../integrity/ima/datafiles/ima_keys/Makefile |  11 ++
>   .../datafiles/{ => ima_keys}/keycheck.policy  |   2 +-
>   .../ima/datafiles/ima_keys/x509_ima.der       | Bin 0 -> 650 bytes
>   .../ima/datafiles/ima_policy/Makefile         |  11 ++
>   .../datafiles/{ => ima_policy}/measure.policy |   0
>   .../{ => ima_policy}/measure.policy-invalid   |   0
>   .../security/integrity/ima/tests/ima_keys.sh  | 104 +++++++++++++++---
>   11 files changed, 133 insertions(+), 28 deletions(-)
>   create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_kexec/Makefile
>   rename testcases/kernel/security/integrity/ima/datafiles/{ => ima_kexec}/kexec.policy (100%)
>   create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_keys/Makefile
>   rename testcases/kernel/security/integrity/ima/datafiles/{ => ima_keys}/keycheck.policy (59%)
>   create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_keys/x509_ima.der
>   create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_policy/Makefile
>   rename testcases/kernel/security/integrity/ima/datafiles/{ => ima_policy}/measure.policy (100%)
>   rename testcases/kernel/security/integrity/ima/datafiles/{ => ima_policy}/measure.policy-invalid (100%)
> 

