Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137A3633369
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Nov 2022 03:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiKVCh4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Nov 2022 21:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiKVChy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Nov 2022 21:37:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F963C4B50
        for <linux-integrity@vger.kernel.org>; Mon, 21 Nov 2022 18:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669084620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xvIIlAJedlMA1IAN6mozxkUlISNRY72m50Y0CwedFi4=;
        b=a/U+NUgTyahnfyxcC8MyIoEZQ3ZQZLNqB6agIZDKvGHS1pUzcozEEz9s1CwJ2bk8P6Ru16
        BS3mlhEqWf4TGYgPFmljA4+N4WOojfRPeq6jawY7AO+hgzjnzfCYhZiztm9bIgwpFXJBxm
        VJE/XKC/74uCrHvDx7v3AfD7ifxvxZA=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-124-r5kl8GwaNWKVzZPqj0PMvA-1; Mon, 21 Nov 2022 21:36:58 -0500
X-MC-Unique: r5kl8GwaNWKVzZPqj0PMvA-1
Received: by mail-pg1-f197.google.com with SMTP id 186-20020a6301c3000000b0046fa202f720so7871932pgb.20
        for <linux-integrity@vger.kernel.org>; Mon, 21 Nov 2022 18:36:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvIIlAJedlMA1IAN6mozxkUlISNRY72m50Y0CwedFi4=;
        b=JOAa8WTetf97hljcGdhZBTyy469NHFhHhMSjIcaK/Hu+hIPCwQYiEMtjG5p4hUUs54
         iHRD4mOBEi3mkbr5FSJdQO+Q6pZf/857h1FIJfERQymxmQQiYiRzgANOL9SmNGLkWSZi
         8MA32QRl7lXfcUa3zQM+ctLWaRMnlYVGBrzZpv7ESrLWukE4AtE5+2juyMqbVJ/An1M5
         dejDeQ8Fks8Pqm4MmkXJYRjOUayLVdl8ic77C0KBm+sxESIS9XESETmf9uKIDP8bqzVd
         4/nUO6of9tly4GPfjTjUHnyYcZXWavyv1jMtZK3BwDsVP0eG1bT9TrcZVimAW9frUVUP
         zo/w==
X-Gm-Message-State: ANoB5plR9DAC6zfkLJ11wyzTwVn87udc5S3jG59fil+s2cFEhO7M9nCb
        hyLQKGe4+SofuC3yi5jJ9yRz733lc8fN6wJMN88TrO1WjOXG4Yym3itB8A3aHt6jy8mFQcErGaV
        THmeQI9neOpbdh9clI8OOWQVsC9cD
X-Received: by 2002:a17:902:bd42:b0:188:ca57:8945 with SMTP id b2-20020a170902bd4200b00188ca578945mr1672924plx.116.1669084617019;
        Mon, 21 Nov 2022 18:36:57 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5u80bNrcNaRgL0fQ5kRBTesC/rxRbN9BLu4B5mZ4iRUSxKXsFzA1wq6uSnG3iu384vaVg/tg==
X-Received: by 2002:a17:902:bd42:b0:188:ca57:8945 with SMTP id b2-20020a170902bd4200b00188ca578945mr1672913plx.116.1669084616745;
        Mon, 21 Nov 2022 18:36:56 -0800 (PST)
Received: from localhost ([240e:3a1:2e3:6280:f5b8:e7c9:62bf:459])
        by smtp.gmail.com with ESMTPSA id k186-20020a6324c3000000b0046fd180640asm8185870pgk.24.2022.11.21.18.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 18:36:56 -0800 (PST)
Date:   Tue, 22 Nov 2022 10:36:06 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     kexec@lists.infradead.org, Matthew Garrett <mjg59@srcf.ucam.org>,
        Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>,
        linux-integrity@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        James Morris <jmorris@namei.org>,
        Matthew Garrett <mjg59@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lockdown: kexec_file: prevent unsigned kernel image when
 KEXEC_SIG not enabled
Message-ID: <20221122023606.nrifkrng5nbfmkka@Rk>
References: <20221121072947.836672-1-coxu@redhat.com>
 <5d98172d77a8a0f1e3daab44ad51bf38978cc053.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5d98172d77a8a0f1e3daab44ad51bf38978cc053.camel@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

On Mon, Nov 21, 2022 at 01:23:57PM -0500, Mimi Zohar wrote:
>Hi Coiby,
>
>On Mon, 2022-11-21 at 15:29 +0800, Coiby Xu wrote:
>> A kernel builder may not enable KEXEC_SIG and some architectures like
>> ppc64 simply don't have KEXEC_SIG. In these cases, unless both
>> IMA_ARCH_POLICY and secure boot also enabled, lockdown doesn't prevent
>> unsigned kernel image from being kexec'ed via the kexec_file_load
>> syscall whereas it could prevent one via the kexec_load syscall. Mandate
>> signature verification for those cases.
>>
>> Fixes: 155bdd30af17 ("kexec_file: Restrict at runtime if the kernel is locked down")
>> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
>> Cc: Jiri Bohac <jbohac@suse.cz>
>> Cc: David Howells <dhowells@redhat.com>
>> Cc: kexec@lists.infradead.org
>> Cc: linux-integrity@vger.kernel.org
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>
>Other than correcting the function name to mandate_signature_verificati
>on(),

Applied to v2, thanks for correcting me! Btw, I realize I overwrote the
return code of kexec_image_verify_sig with
mandate_signature_verification's. v2 has fixed this issue as well.

>
>Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

And thanks for the review!

-- 
Best regards,
Coiby

-- 
Best regards,
Coiby

