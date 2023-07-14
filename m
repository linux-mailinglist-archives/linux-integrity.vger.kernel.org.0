Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EC7752EFF
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jul 2023 03:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbjGNBz5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jul 2023 21:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjGNBz4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jul 2023 21:55:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5AB2D67
        for <linux-integrity@vger.kernel.org>; Thu, 13 Jul 2023 18:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689299709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t11z2xnva4fny6jsTsvYyK9TF2oEGJCt+IK9C2prKKY=;
        b=Go1uVO8gkHKymxP3g5XA255cUFIwocl3GXviKSB0T1Lo8Kb+nqFiEw9KC4Wzbuq3pByfjN
        Z6FeTtt9VcgSqYgmNuwcWWzLYDSyL6gbNARpRJv2lIOlhQPk/Nq7a/HVR98Lma5COU8MGO
        nrrLf3d4VWzcrzuxHXzXUBXUMttGbeU=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-Ur1I1OU8OLCk5OIjUbunfA-1; Thu, 13 Jul 2023 21:55:08 -0400
X-MC-Unique: Ur1I1OU8OLCk5OIjUbunfA-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-66871648c25so1196105b3a.1
        for <linux-integrity@vger.kernel.org>; Thu, 13 Jul 2023 18:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689299707; x=1691891707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t11z2xnva4fny6jsTsvYyK9TF2oEGJCt+IK9C2prKKY=;
        b=JHaH/YrB/GOJ87VdZrgqVNq8ZjSeEOqIe009C4TIS1ixkSzIhdyVh1/dwcUNMuHs2I
         WsmoEj3Bjc9s8Sbpl7kPfUbjEtYStFuS/DXnsae2I5aDf5GrP9ALF7cPuHiiTpvg4vTf
         BNJNzzyGdoWbBi59iui3Yn4wq8tvYVG69NNn5v1hgcS6mttcPd5zXiw7q8bpl+tTOwCy
         Gn+ifcThOmZwPDwD5H+U7Y4vy44PyCUk9FepEKTIKOQ9le/i1Wll1XsIQh5vYbp0skUu
         8dzpDlDr5RY+8/FSPdRqfqMogHms3Tyf0cPOjX0gSG6tL997/hWt3w4XBBGDZXU6QjeY
         TMtQ==
X-Gm-Message-State: ABy/qLao6yUTI7Nwkf/DNy8zCUZBF93iuq1B2nZk/EAzba8i9AP9XxON
        SOn17yXXN2sEE/snDwL5yc5fk61Yi5NtmHGi3lMorJlkxV0jg0MebxUNRkubNh8vE449pOpQ+eq
        icpybbZvNAJIHNrFuuEOx6K/LGo5L
X-Received: by 2002:a05:6a20:3d84:b0:12e:68af:dcfc with SMTP id s4-20020a056a203d8400b0012e68afdcfcmr3869004pzi.18.1689299707146;
        Thu, 13 Jul 2023 18:55:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFQDiz8QNDl10fiRzDQ8whsY+IzQwOJ0SezSEKyqNHzS749qb8dB3md3RyPi95svCJAa6qRlg==
X-Received: by 2002:a05:6a20:3d84:b0:12e:68af:dcfc with SMTP id s4-20020a056a203d8400b0012e68afdcfcmr3868989pzi.18.1689299706802;
        Thu, 13 Jul 2023 18:55:06 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902b18a00b001b9dfa8d884sm6537684plr.226.2023.07.13.18.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 18:55:06 -0700 (PDT)
Date:   Fri, 14 Jul 2023 09:46:29 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        "open list:KEXEC" <kexec@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kexec_file: ima: allow loading a kernel with its IMA
 signature verified
Message-ID: <dsiyhyusai6yvet3dd44c6ptumw3fq4j3xfvi5qy6ebwkoyk43@g3anjnbhzvqk>
References: <20230711031604.717124-1-coxu@redhat.com>
 <eaa1f1901abbceb2edc0aadaa94d9d959413c984.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <eaa1f1901abbceb2edc0aadaa94d9d959413c984.camel@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jul 12, 2023 at 02:31:43PM -0400, Mimi Zohar wrote:
>[Cc'ing the LSM mailing list.]
>
>On Tue, 2023-07-11 at 11:16 +0800, Coiby Xu wrote:
>> When IMA has verified the signature of the kernel image, kexec'ing this
>> kernel should be allowed.
>>
>> Fixes: af16df54b89d ("ima: force signature verification when CONFIG_KEXEC_SIG is configured")
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>
>The original commit  29d3c1c8dfe7 ("kexec: Allow kexec_file() with
>appropriate IMA policy when locked down") was not in lieu of the PE-
>COFF signature, but allowed using the IMA signature on other
>architectures.
>
>Currently on systems with both PE-COFF and IMA signatures, both
>signatures are verified, assuming the file is in the IMA policy.  If
>either signature verification fails, the kexec fails.
>
>With this patch, only the IMA signature would be verified.

Thanks for correcting me! I thought it's already a consensus that we could use
either signature to verify a kernel image because that's what the code of
commit 29d3c1c8dfe7 has done and the code comment seems to confirm it.  But if
we just read the commit message, it indeed didn't give an answer on whether x86
and ARM are only allowed to use PE-COFF signature.

>
>> ---
>>  kernel/kexec_file.c | 14 +++++++++-----
>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 881ba0d1714c..96fce001fbc0 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -162,6 +162,13 @@ kimage_validate_signature(struct kimage *image)
>>  	ret = kexec_image_verify_sig(image, image->kernel_buf,
>>  				     image->kernel_buf_len);
>>  	if (ret) {
>> +		/*
>> +		 * If the kernel image already has its IMA signature verified, permit it.
>> +		 */
>> +		if (ima_appraise_signature(READING_KEXEC_IMAGE)) {
>> +			pr_notice("The kernel image already has its IMA signature verified.\n");
>> +			return 0;
>> +		}
>>
>>  		if (sig_enforce) {
>>  			pr_notice("Enforced kernel signature verification failed (%d).\n", ret);
>> @@ -169,12 +176,9 @@ kimage_validate_signature(struct kimage *image)
>>  		}
>>
>>  		/*
>> -		 * If IMA is guaranteed to appraise a signature on the kexec
>> -		 * image, permit it even if the kernel is otherwise locked
>> -		 * down.
>> +		 * When both IMA and KEXEC_SIG fail in lockdown mode, reject it.
>>  		 */
>> -		if (!ima_appraise_signature(READING_KEXEC_IMAGE) &&
>> -		    security_locked_down(LOCKDOWN_KEXEC))
>> +		if (security_locked_down(LOCKDOWN_KEXEC))
>>  			return -EPERM;
>>
>>  		pr_debug("kernel signature verification failed (%d).\n", ret);
>
>

-- 
Best regards,
Coiby

