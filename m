Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9BA1BF560
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2020 12:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgD3K3Q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Apr 2020 06:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726127AbgD3K3Q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Apr 2020 06:29:16 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437DFC035494;
        Thu, 30 Apr 2020 03:29:16 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z6so1288789wml.2;
        Thu, 30 Apr 2020 03:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=KHpNLJMS3mu2V09RaaLnnYRUJwfut2dVA8xoIPufxks=;
        b=oeLytCEGaH/rofZN/yNpDszUHyJ0X32104xC8+aTBe4mX32nz2AURmDDWgwu9g6qXJ
         oIJUpk0XC1NkmPDpywPDTNN2xT7qf8TlCQeI+qF2zsHB2rJ9vQxzNpm9Adt4WyVUDvHJ
         SSnE76fPC83wV6AofqkxMI/p12PzsVok1Ud5MAAjBXNgw5W7gM6+cVQ3vKsmOaJDhYG2
         pkEfV5iE6erfSXnAIx9vgTjLZCwt9U/j4I1Jj+1fLNNoosGGJ7jRqGm4Wc2U6kLOtedL
         02YQDP+aQpGDYVKKHVwADxnYTdCnTPh2FiMyaqHpTm9nxqmTmGHBpIhGy9sTnQqkQwZ9
         nXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KHpNLJMS3mu2V09RaaLnnYRUJwfut2dVA8xoIPufxks=;
        b=qnMLami22sdUSmEFkenlgWTpwUTCcClDBBBW4oPvJdMtNMZtWhqvDROktGqsRskaXN
         L22bSNnwWOB9RlhL3TAMVAKnxTWQLVONXFKse/eB8nSjp9mNDjqsOO+Akz1TjXAlamkO
         NEBFlbMDkp6KAHPgfLVUBnCmIh66cmoM0idXULHnwR0dkBVimLQT/TUR6l4z6DkRToXN
         VcLu7zbRjfsWFGTiQHpvTsKpKdWih0YPPI2GdEEI+1dhTPSlBRTq0ANWEeYI9lEsVrIe
         ICRCmdnMlONI3y8vEuzRosywNBP3D8FmJwoXnGB6TAfLAjcDkxgV25QO5HEsZHfz/VP5
         jwrg==
X-Gm-Message-State: AGi0PuYnCbX3PGywQxnqfsUwS1ZYGUkvzDdbISqh5sR61laI+5VuMpFv
        1amaw1bAI88JqOYH7vwD9N4=
X-Google-Smtp-Source: APiQypKTabP3IH+sEVHf+m5JSdymF9eA/BbYpwtxCF6TlSLWdp2QHMQ9rTYPLEhiw7qSWNMsyHFHGA==
X-Received: by 2002:a1c:64c5:: with SMTP id y188mr2189457wmb.130.1588242554995;
        Thu, 30 Apr 2020 03:29:14 -0700 (PDT)
Received: from [192.168.43.138] ([37.142.166.235])
        by smtp.gmail.com with ESMTPSA id x18sm3209513wrs.11.2020.04.30.03.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 03:29:14 -0700 (PDT)
Subject: Re: [PATCH v7 3/7] tpm: tpm_tis: Rewrite "tpm_tis_req_canceled()"
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Eyal.Cohen@nuvoton.com, oshrialkoby85@gmail.com,
        alexander.steffen@infineon.com, robh+dt@kernel.org,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org, benoit.houyere@st.com,
        eajames@linux.ibm.com, joel@jms.id.au, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        oshri.alkoby@nuvoton.com, tmaimon77@gmail.com, gcwilson@us.ibm.com,
        kgoldman@us.ibm.com, Dan.Morav@nuvoton.com,
        oren.tanami@nuvoton.com, shmulik.hager@nuvoton.com,
        amir.mizinski@nuvoton.com
References: <20200427124931.115697-1-amirmizi6@gmail.com>
 <20200427124931.115697-4-amirmizi6@gmail.com>
 <20200429053703.GF8452@linux.intel.com>
From:   Amir Mizinski <amirmizi6@gmail.com>
Message-ID: <41fd551b-e678-32bb-781d-48cfe1a3c5bb@gmail.com>
Date:   Thu, 30 Apr 2020 10:29:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429053703.GF8452@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2020-04-29 05:37, Jarkko Sakkinen wrote:
> On Mon, Apr 27, 2020 at 03:49:27PM +0300, amirmizi6@gmail.com wrote:
>> From: Amir Mizinski <amirmizi6@gmail.com>
>>
>> Using this function while reading/writing data resulted in an aborted
>> operation.
>> After investigating the issue according to the TCG TPM Profile (PTP)
>> Specifications, I found that "request to cancel" should occur only if
>> TPM_STS.commandReady bit is lit.
>> Note that i couldn't find a case where the present condition
>> (in the linux kernel) is valid, so I'm removing the case for
>> "TPM_VID_WINBOND" since we have no need for it.
>>
>> Also, the default comparison is wrong. Only cmdReady bit needs to be
>> compared instead of the full lower status register byte.
>>
>> Fixes: 1f86605 (tpm: Fix cancellation of TPM commands (polling mode))
>
> Needs to have exactly 12 hex digits of the hash.
>

Ok, i'll fix this for version 8. Thank you.

> /Jarkko

