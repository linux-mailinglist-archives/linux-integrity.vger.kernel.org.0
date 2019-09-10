Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB1BAE984
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2019 13:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfIJLun (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Sep 2019 07:50:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35677 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfIJLun (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Sep 2019 07:50:43 -0400
Received: by mail-ed1-f66.google.com with SMTP id t50so16814130edd.2;
        Tue, 10 Sep 2019 04:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GpJfqKyJ8z5hMAdV00KswPvzHh3VewI6+H6ZsOLK7zA=;
        b=iySVbi3rYegbaHbAvu3fUzUvv+QAKgHHwUAoOjm5QXopZ2mOxyQObbvVduFMuYvSU2
         ExytaLUilI/MNDam3UDcBDWgUyqXZLCOrp775bstXZBeAcNY0FZC+ZDY69AD+RJtebtn
         HZIoUmyjVR79t9NBPwjT08PUTLCTroE3mSkaBIgC3PYIltAZDuaRcz+a7hTlLx0E02O+
         FqZV/sM/9zt9gkCHTfyydQ5atW2UYhsJiuFMNH0NKFD0cFPS1miSs7+ZmWMOEZwJD0Qi
         J0UeqVqYWhKc+jEyRifQqJECUXys8zah5kseAdVhKZ8OzmFrRDB7yF6Gkquut4+AHMgI
         s5qg==
X-Gm-Message-State: APjAAAVxmHxxEYFBFjJD7QCtcQCD1NuzfTVp4rT1PWODq3bG40xK+L2+
        FKovvjq/LGe6yRVMWiwWnCQch3wx
X-Google-Smtp-Source: APXvYqxJKNH20Vh7TGTW0P8oPEff0oLdDyjgN4uipK6Og+2bYei3QZ008inXV2706g5er5eiHMT5yg==
X-Received: by 2002:a17:906:85c8:: with SMTP id i8mr24508786ejy.178.1568116241277;
        Tue, 10 Sep 2019 04:50:41 -0700 (PDT)
Received: from [10.10.2.174] (bran.ispras.ru. [83.149.199.196])
        by smtp.gmail.com with ESMTPSA id r5sm3376145edd.56.2019.09.10.04.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2019 04:50:40 -0700 (PDT)
Reply-To: efremov@linux.com
Subject: Re: [RESEND PATCH] MAINTAINERS: keys: Update path to trusted.h
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, joe@perches.com,
        linux-kernel@vger.kernel.org, Denis Kenzior <denkenz@gmail.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
References: <20190815215712.tho3fdfk43rs45ej@linux.intel.com>
 <20190815221200.3465-1-efremov@linux.com>
 <20190816185823.kjuxqfegpsywulkn@linux.intel.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <b1a3742e-4d35-ebf6-2127-bc857c09997d@linux.com>
Date:   Tue, 10 Sep 2019 14:50:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816185823.kjuxqfegpsywulkn@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 8/16/19 9:58 PM, Jarkko Sakkinen wrote:
> On Fri, Aug 16, 2019 at 01:12:00AM +0300, Denis Efremov wrote:
>> Update MAINTAINERS record to reflect that trusted.h
>> was moved to a different directory in commit 22447981fc05
>> ("KEYS: Move trusted.h to include/keys [ver #2]").
>>
>> Cc: Denis Kenzior <denkenz@gmail.com>
>> Cc: James Bottomley <jejb@linux.ibm.com>
>> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> Cc: Mimi Zohar <zohar@linux.ibm.com>
>> Cc: linux-integrity@vger.kernel.org
>> Signed-off-by: Denis Efremov <efremov@linux.com>
> 
> Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> /Jarkko
> 

Could someone take this fix through his tree?

Thanks,
Denis
