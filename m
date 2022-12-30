Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8217659595
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Dec 2022 08:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbiL3HCC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Dec 2022 02:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbiL3HBg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Dec 2022 02:01:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFEC140D4
        for <linux-integrity@vger.kernel.org>; Thu, 29 Dec 2022 23:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672383648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ImmGCQvbrQbubKMSG6ameYopLxKvK1Dq+0f6WyefBN0=;
        b=RIngTd50tR6O/qAfM6mO1ulLnNQkKYA5P0OVF55jSYVGtxliTGejtUT8L8f7CQxiR2s26I
        epdLVRRUbEFkrBD+DIfOX8wDB8APf7OoWXpekWJnGR3kzeCXNQxDbj4Yy8ZQyIDQQUDoXe
        ppBE71Nt29G886OLlAbJkhp640l7ei0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-531-K0CPnczGODa9XTK5IOebng-1; Fri, 30 Dec 2022 02:00:44 -0500
X-MC-Unique: K0CPnczGODa9XTK5IOebng-1
Received: by mail-pj1-f71.google.com with SMTP id hg4-20020a17090b300400b002215a3c02c3so8700996pjb.4
        for <linux-integrity@vger.kernel.org>; Thu, 29 Dec 2022 23:00:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImmGCQvbrQbubKMSG6ameYopLxKvK1Dq+0f6WyefBN0=;
        b=tkHu0E1CtsoqlVEHCOjdNUy/KbllUAvpluqSLczSWCYBe5gi0Wj91OWyhTeWczXq0Y
         BSSj/xiNbANzA1hCJ+KbglDjfM8cME/6px9juGtxYqEqznsjzHpOdqFbqeAHUtni6SXQ
         RsfmqT864RX4p9tVr4jC1m6mp14iCI6sUS6djfD/U1YEMdQdxV94Fs4XUuJ+mERdOl62
         2dq8gRDMP/tAylGnf4os+4t2wp0ZHtGgUjOcVtrIesVZ/3CpqPXyKa14ATFng3f70X6W
         +qNwNe/8lZDQBIQeFSiNqlhEHQ2AxhsuMkQNOf7YwJ7Y8P8drhci30oX/JU4g5Pr+T26
         Ns8g==
X-Gm-Message-State: AFqh2kpCDYGSXPCSJQD8rGC6//Zk85UfPVmaXlfrzMHuG/aGYrt5adf9
        e8NyM5kmEHLn293ZJppwmxERQ111Ab96vKCe9sO0bH6TKqbfXC936tgnGN4MGdkFXEO3uIC5xHo
        TSQiMNxrMC2iN2LSt92XShe54iUFo
X-Received: by 2002:a17:902:f30a:b0:192:5d9b:5881 with SMTP id c10-20020a170902f30a00b001925d9b5881mr21193544ple.31.1672383643006;
        Thu, 29 Dec 2022 23:00:43 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuFyJMAfM2ex+xnuBDCSnUVb8vWNZEix+IQzpCxtuyT8dY7U9e4J7L3ewHS7tRYBThynAwxpw==
X-Received: by 2002:a17:902:f30a:b0:192:5d9b:5881 with SMTP id c10-20020a170902f30a00b001925d9b5881mr21193531ple.31.1672383642759;
        Thu, 29 Dec 2022 23:00:42 -0800 (PST)
Received: from localhost ([240e:478:10:2273:12cf:a540:d79b:db49])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902650700b00189c536c72asm14085355plk.148.2022.12.29.23.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 23:00:42 -0800 (PST)
Date:   Fri, 30 Dec 2022 15:00:28 +0800
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
Message-ID: <20221230070028.7i4w57xmhwa44c4z@Rk>
References: <20221121072947.836672-1-coxu@redhat.com>
 <5d98172d77a8a0f1e3daab44ad51bf38978cc053.camel@linux.ibm.com>
 <20221122023606.nrifkrng5nbfmkka@Rk>
 <2204915d319ff9acf80f68ccba8600aaeb5578d7.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2204915d319ff9acf80f68ccba8600aaeb5578d7.camel@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 28, 2022 at 12:16:08PM -0500, Mimi Zohar wrote:
>On Tue, 2022-11-22 at 10:36 +0800, Coiby Xu wrote:
>> Hi Mimi,
>>
>> On Mon, Nov 21, 2022 at 01:23:57PM -0500, Mimi Zohar wrote:
>> >Hi Coiby,
>> >
>> >On Mon, 2022-11-21 at 15:29 +0800, Coiby Xu wrote:
>> >> A kernel builder may not enable KEXEC_SIG and some architectures like
>> >> ppc64 simply don't have KEXEC_SIG. In these cases, unless both
>> >> IMA_ARCH_POLICY and secure boot also enabled, lockdown doesn't prevent
>> >> unsigned kernel image from being kexec'ed via the kexec_file_load
>> >> syscall whereas it could prevent one via the kexec_load syscall. Mandate
>> >> signature verification for those cases.
>> >>
>> >> Fixes: 155bdd30af17 ("kexec_file: Restrict at runtime if the kernel is locked down")
>> >> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
>> >> Cc: Jiri Bohac <jbohac@suse.cz>
>> >> Cc: David Howells <dhowells@redhat.com>
>> >> Cc: kexec@lists.infradead.org
>> >> Cc: linux-integrity@vger.kernel.org
>> >> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> >
>> >Other than correcting the function name to mandate_signature_verificati
>> >on(),
>>
>> Applied to v2, thanks for correcting me! Btw, I realize I overwrote the
>> return code of kexec_image_verify_sig with
>> mandate_signature_verification's. v2 has fixed this issue as well.
>>
>> >
>> >Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>>
>> And thanks for the review!
>
>You're welcome.
>
>Without either IMA_ARCH or KEXEC_SIG enabled, the kexec selftest
>test_kexec_file_load.sh properly failed with "kexec_file_load failed
>[PASS]", but from the informational messages output, it isn't clear why
>it failed.  This should be corrected.

Thanks for the suggestion! I've added some tests in v3 and now the
message is "# kexec_file_load failed (missing IMA sig) [PASS]".

>
>-- 
>thanks,
>
>Mimi
>

-- 
Best regards,
Coiby

