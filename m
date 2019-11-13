Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7B7FBA40
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2019 21:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfKMUww (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Nov 2019 15:52:52 -0500
Received: from linux.microsoft.com ([13.77.154.182]:59488 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMUwv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Nov 2019 15:52:51 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id CC9B520B4901;
        Wed, 13 Nov 2019 12:52:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CC9B520B4901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573678370;
        bh=fgQhQUz164u1Ek8QLM0DOcyCkmeH/6O7UhOsdVDDB+I=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=kDVOZLq3aB9m+A9OGzmuvC75nfcZhD/sjDjmXVT/MCU6x0biY6SEaTrpEujP6xAwB
         aYUHatP8kZVdB3hXXZeUhsqNKD5UunWJIDrPEQJJgQfuQW+xr4eG1ir0dlWIsMuWM9
         4oVdLgWug+n41qHO++J6sNXAptLa43mYGILzmBIw=
Subject: Re: [PATCH v6 2/3] IMA: Define an IMA hook to measure keys
To:     Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191113184658.2862-1-nramas@linux.microsoft.com>
 <20191113184658.2862-3-nramas@linux.microsoft.com>
 <1573675761.4843.13.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <8eba665e-637c-d341-c77d-4f2645d3b246@linux.microsoft.com>
Date:   Wed, 13 Nov 2019 12:52:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573675761.4843.13.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/13/19 12:09 PM, Mimi Zohar wrote:
>
> All that is is needed is the key and public_key structures, which are
> defined in include/linux/keys.h and include/crypto/public_key.h.  If
> the keys subsystem is disabled, then the new IMA hook won't be called.
>   There's no need for a new Kconfig option or a new file.
> 
> Please move the hook to just after ima_kexec_cmdline().
> 
> Mimi

Yes - IMA hook won't be called when KEYS subsystem is disabled.

But, build dependency is breaking since "struct key" is not defined 
without CONFIG_KEYS.

Sasha was able to craft a .config that enabled IMA without enabling KEYS 
and found the build break.

Please see the build output he'd shared.

***********************************************************************

In file included from security/integrity/ima/ima.h:25,
                 from security/integrity/ima/ima_fs.c:26:
./include/keys/asymmetric-type.h: In function ‘asymmetric_key_ids’:
./include/keys/asymmetric-type.h:72:12: error: dereferencing pointer to 
incomplete type ‘const struct key’
  return key->payload.data[asym_key_ids];
            ^~
make[3]: *** [scripts/Makefile.build:266: 
security/integrity/ima/ima_fs.o] Error 1
make[3]: *** Waiting for unfinished jobs....
In file included from security/integrity/ima/ima.h:25,
                 from security/integrity/ima/ima_queue.c:22:
./include/keys/asymmetric-type.h: In function ‘asymmetric_key_ids’:
./include/keys/asymmetric-type.h:72:12: error: dereferencing pointer to 
incomplete type ‘const struct key’
  return key->payload.data[asym_key_ids];

***********************************************************************

thanks,
  -lakshmi
