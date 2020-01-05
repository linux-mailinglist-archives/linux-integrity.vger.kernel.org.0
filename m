Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA1B130959
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Jan 2020 18:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgAER47 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 5 Jan 2020 12:56:59 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33494 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgAER47 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 5 Jan 2020 12:56:59 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0EAE3200766E;
        Sun,  5 Jan 2020 09:56:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0EAE3200766E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1578247018;
        bh=6CXaoxlr6WIvThI7SBjJ13uAUKBA1Y/vi5or5707H70=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WAZ2RgpdWxyL9Y0o+CFpGsCwnL7FAc+E2qQx/QemT6Apl/+RjOSI2Etpegpg1OhD7
         V1dg+ww6npT10QD4oauE6FCr2Z+xCfODoxS5R0kU4Oo1uh7mKPXFmJlq+wWJo3J+ZI
         qOybB7CTSTbafZqiUkXTYybWcwKmkQuS1i+cUVos=
Subject: Re: [integrity:next-integrity-testing 5/5]
 security/integrity/ima/ima_asymmetric_keys.c:53:6: error: redefinition of
 'ima_init_key_queue'
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
References: <202001051708.DO90I9sl%lkp@intel.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <48389231-dfcf-be6d-b543-6da8e3d55886@linux.microsoft.com>
Date:   Sun, 5 Jan 2020 09:57:12 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <202001051708.DO90I9sl%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/5/2020 1:00 AM, kbuild test robot wrote:

> 
>>> security/integrity/ima/ima_asymmetric_keys.c:53:6: error: redefinition of 'ima_init_key_queue'
>      void ima_init_key_queue(void)
>           ^~~~~~~~~~~~~~~~~~
>     In file included from security/integrity/ima/ima_asymmetric_keys.c:16:0:
>     security/integrity/ima/ima.h:222:20: note: previous definition of 'ima_init_key_queue' was here
>      static inline void ima_init_key_queue(void) {}

In the given config file the following configs are specified

	CONFIG_IMA=y
	CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=m

If CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is selected 
ima_asymmetric_keys.c file is built and linked (as given in the 
Makefile). ima_init_key_queue() is declared in ima.h

But if CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is not selected 
ima_asymmetric_keys.c is not built. ima_init_key_queue() is declared as 
an empty function (static inline in ima.h)

#ifdef CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
void ima_init_key_queue(void);
#else
static inline void ima_init_key_queue(void) {}
#endif /* CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE */

If I understand the reported build error, it looks like 
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE was disabled first and then enabled 
later - in the same build sequence.

Is that correct?

thanks,
  -lakshmi
