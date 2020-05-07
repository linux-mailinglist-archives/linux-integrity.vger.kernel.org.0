Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9D11C9675
	for <lists+linux-integrity@lfdr.de>; Thu,  7 May 2020 18:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgEGQ0d (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 May 2020 12:26:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37640 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726636AbgEGQ0c (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 May 2020 12:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588868791;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DtpmifdZVltweHRusfE5X8VRHfeIU9bIYgL82hdmxQg=;
        b=AqAt+X+sD8GRMIS33zqEcWgIKMxSjSPTj9bP/o9bowllEJspo2FpF70f8421UKpa6gm89y
        AYvXJcGvqkEQf7+uLtrXhXFfq/d+EoT0piUifTi3tywsqayUdL5EZHm1NQd/ARabUbIL5y
        jfUp/w+v1VUwxvQl6PfS8OIj0GxtIzg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-NAOva2vXNz2oPEOhh0f2Aw-1; Thu, 07 May 2020 12:26:27 -0400
X-MC-Unique: NAOva2vXNz2oPEOhh0f2Aw-1
Received: by mail-qv1-f69.google.com with SMTP id bm3so6425314qvb.0
        for <linux-integrity@vger.kernel.org>; Thu, 07 May 2020 09:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=DtpmifdZVltweHRusfE5X8VRHfeIU9bIYgL82hdmxQg=;
        b=SXlMOrRaldUCSLrfhuCsSDUC5ycJIg6oH07N66I1REy1kcJEeFlsPNdRhFXdkfWX6X
         UZ55S7sJWXok1ciYiSWw1SEkSJrPe6ZWusMI/kFpW6q52RXuNhnYz2rGrozY7/17evcY
         mcjT8X/0S071zZsBJ6d9J8iD0Q+9BZTDiqhukxC0Epy3qDrDpVAS9pWX2yCy9BL9m3kK
         MP7uifBeW30jFR5SiApLKE3MlNr0gvb22yVa225jeO3Yvd94zJ47E2b0VHlBLMFirwc9
         BYpnqzmbMzzYUDZCKKZOO7CJ5QYLucdRmNq4p3+55+0iiDx+WiYpUWWCe6aQm1dx8FsS
         A2Vg==
X-Gm-Message-State: AGi0PuZ35AVaRuyVex8kVVt27O2qhlWr3SO8AgcB9BoGGDbSQc1tclms
        yROupCDsSHhQ7lmzwzUcrWUfn41YWuACrwRaHT8MEZkaVD2saSg49mYrBrmhgeYFhiZeD0QxuCA
        GaAcF7Hb9pCZHO4/CbZm3caCwAwVO
X-Received: by 2002:a05:6214:188a:: with SMTP id cx10mr14205388qvb.119.1588868786838;
        Thu, 07 May 2020 09:26:26 -0700 (PDT)
X-Google-Smtp-Source: APiQypKJ8QitiMlwdEtTw55Tphs2ib5S8jmz/TAlYmMgbxHiSY6ZYnPeWmHe0kAZyUkdsPrjHsmyrg==
X-Received: by 2002:a05:6214:188a:: with SMTP id cx10mr14205364qvb.119.1588868786579;
        Thu, 07 May 2020 09:26:26 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id 33sm4508181qtc.82.2020.05.07.09.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 09:26:25 -0700 (PDT)
Date:   Thu, 7 May 2020 09:26:24 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Ken Goldman <kgold@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Matthew Garrett <mjg59@google.com>,
        Ken Goldman <kgoldman@us.ibm.com>
Subject: Re: Disparity in tpm pcr5 value
Message-ID: <20200507162624.4eqi6tvfmfabn6vj@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20200505222731.whnkisag7tlrbcie@cantor>
 <4b3be2e9-35f7-d730-8e3b-b252ba5cb095@linux.ibm.com>
 <20200507073548.zpyv3u7rv3u7jqrs@cantor>
 <1588863053.5685.62.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1588863053.5685.62.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu May 07 20, Mimi Zohar wrote:
>On Thu, 2020-05-07 at 00:35 -0700, Jerry Snitselaar wrote:
>> On Wed May 06 20, Ken Goldman wrote:
>> >On 5/5/2020 6:27 PM, Jerry Snitselaar wrote:
>> >>On some systems we've had reports of the value of pcr5 doesn't match
>> >>the digests in the tpm event log.
>> >>It looks like I'm able to reproduce here with 5.7-rc4 on a dell
>> >>system using this parser:
>> >>
>> >>https://github.com/ValdikSS/binary_bios_measurements_parser
>> >>
>> >>Any thoughts on where to start digging? Is there another tool I
>> >>should use to parse this?
>> >
>> >If you email me the event log in binary, I can run it through the IBM
>> >calculator and see if I get the same error.
>> >
>> >
>>
>> A couple other data points:
>>
>> - On the Dell system where I did this if I change it in the bios to use sha256
>>    instead of sha1, then using tsseventextend to parse matches the value in the tpm.
>>    In the sha256 case there is a final events log.
>>
>> - I have a nuc5 here, which also extends into sha1, and the parse matches there.
>>
>> - Javier has also reproduced it when passing through swtpm to a vm.
>>
>> - I added some debugging code, and there is nothing extending pcr5 with tpm_pcr_extend.
>>
>> - Ken's parse of the log also shows the disparity, which I've now done as well with
>>    the tpm1.2 version of the tsseventextend tool.
>
>Thanks, Jerry.  You've eliminated the kernel extending into the PCR.
> For SHA256, the event log has to be TPM 2.0 format.  I've seen TPM
>2.0's for SHA1 use the TPM 1.2 event log format.  When using SHA1, is
>it a TPM 1.2 or 2.0 event log format?
>
>Mimi
>

It is the 1.2 event log format.

