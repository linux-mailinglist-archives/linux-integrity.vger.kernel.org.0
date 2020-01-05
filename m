Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBE9130984
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Jan 2020 19:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgAES43 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 5 Jan 2020 13:56:29 -0500
Received: from linux.microsoft.com ([13.77.154.182]:54748 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgAES40 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 5 Jan 2020 13:56:26 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3F619200766E;
        Sun,  5 Jan 2020 10:56:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3F619200766E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1578250585;
        bh=2c0aust1yr83NmG9kjnG3qoa5IGYPhKkKECSrnsxX3w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VJ3TfMTYvsvLpYBh6NCA8iXx8ZeUPsBCOdRIhLQYVRVT8gJBzbefTw3QUpRd9HrYJ
         QYYlMikFaJvUn7h+PikTTYPc+8rcIYq7pvsDlAont/COUx7b4eqS2LI+rQDe8Vbj34
         gQW3XQQKuGFuQbbXP4zXhFjFZXlHgv9REI32wKPE=
Subject: Re: [integrity:next-integrity-testing 5/5]
 security/integrity/ima/ima_asymmetric_keys.c:53:6: error: redefinition of
 'ima_init_key_queue'
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
References: <202001051708.DO90I9sl%lkp@intel.com>
 <48389231-dfcf-be6d-b543-6da8e3d55886@linux.microsoft.com>
 <1578248115.3310.41.camel@HansenPartnership.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <2a24e191-fc31-a502-7463-b6e90f91e1c5@linux.microsoft.com>
Date:   Sun, 5 Jan 2020 10:56:39 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1578248115.3310.41.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/5/2020 10:15 AM, James Bottomley wrote:

>> #ifdef CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
>> void ima_init_key_queue(void);
>> #else
>> static inline void ima_init_key_queue(void) {}
>> #endif /* CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE */
>>
>> If I understand the reported build error, it looks like
>> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE was disabled first and then
>> enabled later - in the same build sequence.
>>
>> Is that correct?
> 
> I don't think so.  The specific problem is that
> ASYMMETRIC_PUBLIC_KEY_SUBTYPE is defined as a tristate in
> crypto/asymmetric_keys/Kconfig, so the above m setting for it is
> perfectly legal regardless of the IMA setting.  This line you
> introduced to the Makefile:
> 
> obj-$(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += ima_asymmetric_keys.o
> 
> Then causes ima_asymmetric_keys.o to be added to obj-m causing the
> kernel to think it's building it as a module.
> 
> To fix this, I think you have to force ASYMMETRIC_PUBLIC_KEY_SUBTYPE to
> be built in if IMA is.
> 
> James

Thanks for the info James. That explains the other error reported 
earlier - ima_asymmetric_keys.c being built as a kernel module.

Since IMA can currently be enabled without enabling the KEYS subsystem, 
I feel forcing ASYMMETRIC_PUBLIC_KEY_SUBTYPE to be built if IMA is may 
not be safe. Right?

Instead can CONFIG_ASYMMETRIC_KEY_TYPE be used to enable key measurement 
code in IMA?

crypto\asymmetric_keys\Kconfig

# SPDX-License-Identifier: GPL-2.0
menuconfig ASYMMETRIC_KEY_TYPE
	bool "Asymmetric (public-key cryptographic) key type"
	depends on KEYS
         help
	  This option provides support for a key type that holds the
           data for the asymmetric keys used for public key cryptographic
           operations such as encryption, decryption, signature
           generation and signature verification.

thanks,
  -lakshmi
