Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B09742B0E
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jun 2023 19:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjF2RHq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Jun 2023 13:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjF2RHp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Jun 2023 13:07:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB6235AA
        for <linux-integrity@vger.kernel.org>; Thu, 29 Jun 2023 10:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688058413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A/N1q1JcWIXlbNgkIYZVnaEQ46bfA3UQYlq1BYT9Ptg=;
        b=gFMAwsz4uMz7gSJdEz4bQLzUV3NVAdUD5t126Eee8QIRlfbq+kY4W7WaEHoPDr9UIF2Xh9
        2NHnnCS0P4zTOqi/D7CMErS0MN08o++gjSJsNVzd0sG7D9S3HMLXToGilicBH04e2+o72V
        YZDXza276gpvaJTr0RHOuzQfDiwqELU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-ZU20FC03Mx6WcaTmg8Wy4g-1; Thu, 29 Jun 2023 13:06:50 -0400
X-MC-Unique: ZU20FC03Mx6WcaTmg8Wy4g-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-635e10763f3so8307086d6.1
        for <linux-integrity@vger.kernel.org>; Thu, 29 Jun 2023 10:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688058410; x=1690650410;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A/N1q1JcWIXlbNgkIYZVnaEQ46bfA3UQYlq1BYT9Ptg=;
        b=HTdn0s6UH6jGwHxytrGBB/of7xHjJgksyB++wEdxKsUsZaVkvmStvSVKy8nKkPta2T
         95hIMWLuAIm+TVuDMXCuVcM+zGTibE7zDrWR2lbUVmfQBPj4bT5yePljYRF/hnUmnLhf
         QEKx+Jm42tjdB+UKiVrZx/j1zf8APdi8Wysmlm2hi7YHVfY8a9B7WRkVb1fZ7201ZVkk
         Itb57QjlyM0Q7mCbVe24triMwVxgxTPpit32TQK5/cb7cvb+wgFw/hHJSR5MN+q1mrRG
         UrM5jYCOEad+UiCrXMT7UoReqL9Dg9f84UfO3TNe5GYus1G08QYN60UYrNXjhItwa5CF
         o8ug==
X-Gm-Message-State: ABy/qLZZhCcGMMPaRRnpWbS3HlK+tCmAf8rb+oghiac2fEJfOiNTW2r6
        FvSC1x02GbCRYqg/QVoufURM9V3v5C/r7quoGzUcVkULR620AfHHY74AS04e/XGmezPWus9sPAd
        Qq5WTkflGJ3DD+0l8/6RlHwsbEMk7MMnj2w96
X-Received: by 2002:a05:6214:c62:b0:635:f412:6a70 with SMTP id t2-20020a0562140c6200b00635f4126a70mr201041qvj.47.1688058410037;
        Thu, 29 Jun 2023 10:06:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFZM+GVL4jbhfP9zasY2tqCDNztP4bkyURAOopcPQX4hdKl1OEm2B1JeATQ8vjOF5cd1WWHxw==
X-Received: by 2002:a05:6214:c62:b0:635:f412:6a70 with SMTP id t2-20020a0562140c6200b00635f4126a70mr201016qvj.47.1688058409582;
        Thu, 29 Jun 2023 10:06:49 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id z15-20020a0ce98f000000b006300ff90e71sm7197174qvn.122.2023.06.29.10.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 10:06:49 -0700 (PDT)
Date:   Thu, 29 Jun 2023 10:06:47 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Sachin Sant <sachinp@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, jarkko@kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [6.4-rc6] Crash during a kexec operation
 (tpm_amd_is_rng_defective)
Message-ID: <c53ihvuesmymj2o5jyqz7gw7mvbrxjifmphuuhiux3qjabjnic@wcak4hfb77td>
References: <99B81401-DB46-49B9-B321-CF832B50CAC3@linux.ibm.com>
 <87o7lhfmoh.fsf@mail.lhotse>
 <CA0088E4-2851-4AFF-94F8-2A07C5CDA8D8@linux.ibm.com>
 <675a8893-429d-05be-b647-089b249c814c@leemhuis.info>
 <87o7l7oer1.fsf@mail.lhotse>
 <3f5a37f1-70e0-3dcf-3bd3-acc8a04e53ee@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f5a37f1-70e0-3dcf-3bd3-acc8a04e53ee@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 22, 2023 at 09:38:04AM -0500, Limonciello, Mario wrote:
> 
> On 6/22/2023 7:36 AM, Michael Ellerman wrote:
> > "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info> writes:
> > > Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> > > for once, to make this easily accessible to everyone.
> > > 
> > > As Linus will likely release 6.4 on this or the following Sunday a quick
> > > question: is there any hope this regression might be fixed any time
> > > soon?
> > No.
> > 
> > I have added the author of the commit to Cc, maybe they can help?
> > 
> > The immediate question is, is it expected for chip->ops to be NULL in
> > this path? Obviously on actual AMD systems that isn't the case,
> > otherwise the code would crash there. But is the fact that chip->ops is
> > NULL a bug in the ibmvtpm driver, or a possibility that has been
> > overlooked by the checking code.
> > 
> > cheers
> 
> All that code assumes that the TPM is still functional which
> seems not to be the case for your TPM.
> 
> This should fix it:
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 5be91591cb3b..7082b031741e 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -525,6 +525,9 @@ static bool tpm_amd_is_rng_defective(struct tpm_chip
> *chip)
>         u64 version;
>         int ret;
> 
> +       if (!chip->ops)
> +               return false;
> +
>         if (!(chip->flags & TPM_CHIP_FLAG_TPM2))
>                 return false;


Should tpm_amd_is_rng_defective compile to nothing on non-x86 architectures? This code is all about
working around an issue with the AMD fTPM, right?

Regards,
Jerry

