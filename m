Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906DF1C9EFC
	for <lists+linux-integrity@lfdr.de>; Fri,  8 May 2020 01:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgEGXMj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 May 2020 19:12:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25937 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726514AbgEGXMj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 May 2020 19:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588893157;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rdRFLYYJMNCbccjIYx9pUAfHwyQ1QtQrFmV7wZWi5j4=;
        b=eeq7SMMcTZfW1RflMn3uSRdRs/XU9IjJpb1OYMp5u58WnRHtXmArNNHY9en6US0KCnB5Yx
        qXxEmyQJJ0aCluy8YS71j/CuYpCaWugGBKL2EQlPJH3I9rIm6PmElK+27UsPd7+5wp12+8
        hyH1Kfp7nf/LEZly3rh+9M6TsoBC/t8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-CJwfQuj7NN2RGDwVSk8d4w-1; Thu, 07 May 2020 19:12:35 -0400
X-MC-Unique: CJwfQuj7NN2RGDwVSk8d4w-1
Received: by mail-qt1-f198.google.com with SMTP id v18so8649461qtq.22
        for <linux-integrity@vger.kernel.org>; Thu, 07 May 2020 16:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=rdRFLYYJMNCbccjIYx9pUAfHwyQ1QtQrFmV7wZWi5j4=;
        b=g1dNQyNobgbozaa6DmwPbL296eh3/cL8Twv9s89FabI+T4hUNl8VqiMwdyC5R31/om
         qiy+YirsPs1YGrZmnfMuPl8p+zbfAZOmjojawCbsSw8n4FSauP56lnYki68RviLg+pVj
         w/8nIFqlW4qQT7ErNkugf13iI1+G/Zn4fybdJ08mYjZ7aLfXTM2d56hZHQer5y0n81Fu
         u0KUjjrjyjPD7vhZ5jw7q5DqTJ4xsIvYAngNySlxgidoaS6ii3V85gOymSEPEXmTmDbg
         Kcs8vo03JMkwtTbd3zLeUVAC+kLx8LF5rdz37mTgnmD6vMYD8NKR7vRU+mDh3GT6Woq+
         bXqQ==
X-Gm-Message-State: AGi0PuZQM76b9KkfbcypTNrewYrDEA64nDIqg7F1QhT1CK4dCmTPFQZb
        ZVi5WE4sVQicrYzYw1sueH8wULmzkSDdNaEj23mLpTZuQvpOzm/9WkligtXQSoZeutHfTbuoyyj
        5SBfLPY7RvbT32H8U06scMi3sSG2z
X-Received: by 2002:aed:3f21:: with SMTP id p30mr16381173qtf.335.1588893154365;
        Thu, 07 May 2020 16:12:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypIHHumXlMugE+qZp9PnjMskuvAbMSHHncUCYOm0qs205cQodLrMSGfj9yALgQObwpJlrY93Vg==
X-Received: by 2002:aed:3f21:: with SMTP id p30mr16381150qtf.335.1588893154044;
        Thu, 07 May 2020 16:12:34 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id e27sm4473355qkl.47.2020.05.07.16.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 16:12:33 -0700 (PDT)
Date:   Thu, 7 May 2020 16:12:31 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Ken Goldman <kgold@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Matthew Garrett <mjg59@google.com>,
        Ken Goldman <kgoldman@us.ibm.com>
Subject: Re: Disparity in tpm pcr5 value
Message-ID: <20200507231231.vi5he2my42ngnbm4@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20200505222731.whnkisag7tlrbcie@cantor>
 <4b3be2e9-35f7-d730-8e3b-b252ba5cb095@linux.ibm.com>
 <20200507073548.zpyv3u7rv3u7jqrs@cantor>
 <1588863053.5685.62.camel@linux.ibm.com>
 <20200507162624.4eqi6tvfmfabn6vj@cantor>
 <1588885034.5685.121.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1588885034.5685.121.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu May 07 20, Mimi Zohar wrote:
>On Thu, 2020-05-07 at 09:26 -0700, Jerry Snitselaar wrote:
>> On Thu May 07 20, Mimi Zohar wrote:
>> >On Thu, 2020-05-07 at 00:35 -0700, Jerry Snitselaar wrote:
>> >> On Wed May 06 20, Ken Goldman wrote:
>> >> >On 5/5/2020 6:27 PM, Jerry Snitselaar wrote:
>> >> >>On some systems we've had reports of the value of pcr5 doesn't match
>> >> >>the digests in the tpm event log.
>> >> >>It looks like I'm able to reproduce here with 5.7-rc4 on a dell
>> >> >>system using this parser:
>> >> >>
>> >> >>https://github.com/ValdikSS/binary_bios_measurements_parser
>> >> >>
>> >> >>Any thoughts on where to start digging? Is there another tool I
>> >> >>should use to parse this?
>> >> >
>> >> >If you email me the event log in binary, I can run it through the IBM
>> >> >calculator and see if I get the same error.
>> >> >
>> >> >
>> >>
>> >> A couple other data points:
>> >>
>> >> - On the Dell system where I did this if I change it in the bios to use sha256
>> >>    instead of sha1, then using tsseventextend to parse matches the value in the tpm.
>> >>    In the sha256 case there is a final events log.
>> >>
>> >> - I have a nuc5 here, which also extends into sha1, and the parse matches there.
>> >>
>> >> - Javier has also reproduced it when passing through swtpm to a vm.
>> >>
>> >> - I added some debugging code, and there is nothing extending pcr5 with tpm_pcr_extend.
>> >>
>> >> - Ken's parse of the log also shows the disparity, which I've now done as well with
>> >>    the tpm1.2 version of the tsseventextend tool.
>> >
>> >Thanks, Jerry.  You've eliminated the kernel extending into the PCR.
>> > For SHA256, the event log has to be TPM 2.0 format.  I've seen TPM
>> >2.0's for SHA1 use the TPM 1.2 event log format.  When using SHA1, is
>> >it a TPM 1.2 or 2.0 event log format?
>>
>> It is the 1.2 event log format.
>
>From everything you've said, it sounds like buggy firmware.  Either an
>additional event is added to the list, but does not extend the TPM.
> Or an event extends the TPM, but is not added to the event log.  This
>isn't a kernel problem and can't be addressed by the kernel.
> Hopefully the vendor will be willing to address it.
>
>Mimi
>

It appears to be the latter case. The value in the tpm doesn't show up
in the intermediate values of the parse. Yeah, it doesn't seem to be
an issue on the kernel side.

