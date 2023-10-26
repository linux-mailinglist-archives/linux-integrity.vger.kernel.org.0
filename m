Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223ED7D8829
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Oct 2023 20:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjJZSUh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Oct 2023 14:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjJZSUg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Oct 2023 14:20:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2046C1A5
        for <linux-integrity@vger.kernel.org>; Thu, 26 Oct 2023 11:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698344386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BwyRkm9CvRYtMmIRNgg5uHUq98r7ivjgyyg2sWiRN70=;
        b=TDT+PSwY8fYYY7BCmKDHxiV90czUhHBrVW3CZr1BG9PLabvYkAyyidR3RK7xvGdT+jM8tq
        7A7GIAInIu3wcYftz1RpzrcunHwjhaElyDfW4p3YOrgUi5alm+muwwAa50tPPqS9xmZqyI
        s42UUAm0Hb38VQv4zOG0wv0eCcuVTUo=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-gKzqQ1kwOOWkQop3qWFRMA-1; Thu, 26 Oct 2023 14:19:44 -0400
X-MC-Unique: gKzqQ1kwOOWkQop3qWFRMA-1
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-49e0cd82066so579328e0c.2
        for <linux-integrity@vger.kernel.org>; Thu, 26 Oct 2023 11:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698344384; x=1698949184;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BwyRkm9CvRYtMmIRNgg5uHUq98r7ivjgyyg2sWiRN70=;
        b=tb8ncMsqFNqiRtMV4sQfpCOKXvxh0cV+FS0yVt+5ybSbyZ90SrGHWEn46DZqZAAko/
         +AaUEF4iVLmcAG2aXvfdBb/ZlVHTSPi87+5i5LydrNscEgGxDWpjKrZc0NLrln/VBYEz
         V+3sl85vaKSnxPogZ44NH1GqOrIjsPKTGSqFfB6WWq20aquS6mYKdfM1F9FTzq6+kSL8
         EApCkn4KB8RPHbyhsdxKThr/ZLTYZJ7+NpyKIpHapVr3gqNYyowAqDAG8kels0mCnyAd
         bNNxhETaxtiKHQJxLz3cRTqurXldTB80gPNB7VJLbqZJ9NDP8GxxhBoM3KuA3H2Ctze/
         c2eg==
X-Gm-Message-State: AOJu0YzQieWpDnW7+RinJ6zurQSb8xx0six4Kj6NQwlRea+ywZf3ie+a
        987lh48l7ytmucyhKazMYj/Ahs8lLQ4xa48Vo65Of2HYm4ieLxX67tr9o6P3nJCI2t/qcMbjb8G
        ZXpYy8jLdWi+l2EGoNbj4ROKsXH+n
X-Received: by 2002:a1f:a90d:0:b0:4a0:6fd4:4334 with SMTP id s13-20020a1fa90d000000b004a06fd44334mr717485vke.12.1698344384310;
        Thu, 26 Oct 2023 11:19:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUwEXudtmWceC4lxLdpyNeAKe/B4NAsLqoUzNk5qTEo36PXWSYt6qzZ1L7KIKLTo7tkUwh1w==
X-Received: by 2002:a1f:a90d:0:b0:4a0:6fd4:4334 with SMTP id s13-20020a1fa90d000000b004a06fd44334mr717467vke.12.1698344384030;
        Thu, 26 Oct 2023 11:19:44 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id v14-20020ac8748e000000b0041815bcea29sm5149414qtq.19.2023.10.26.11.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 11:19:43 -0700 (PDT)
Date:   Thu, 26 Oct 2023 11:19:42 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        William Roberts <bill.c.roberts@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Julien Gomes <julien@arista.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] tpm: Move buffer handling from static inlines to
 real functions
Message-ID: <thgffvdfi6ctko3mkb4gngcaei2wvthm5ry2xdm3elbrhdigsw@onundiibvit5>
References: <20231024011531.442587-1-jarkko@kernel.org>
 <20231024011531.442587-2-jarkko@kernel.org>
 <qktrbbbqrz3z4jh4h7pz42leikmyg2mdevzl2brapn32kst55e@s5thpstdtlxp>
 <CWHPA3T3YIJT.148L3L98EXBXD@suppilovahvero>
 <g6grxamrilogiy4vjrvwwn6iz2xm26oeq2y7redbskvcreil6w@seavf5djd4ph>
 <d468a3f18e871f2af4db9c104d393866849ff2d0.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d468a3f18e871f2af4db9c104d393866849ff2d0.camel@HansenPartnership.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 26, 2023 at 01:55:55PM -0400, James Bottomley wrote:
> On Thu, 2023-10-26 at 10:10 -0700, Jerry Snitselaar wrote:
> > On Wed, Oct 25, 2023 at 08:35:55PM +0300, Jarkko Sakkinen wrote:
> > > On Wed Oct 25, 2023 at 12:03 PM EEST, Jerry Snitselaar wrote:
> > > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > 
> > > On Wed, 2023-10-25 at 02:03 -0700, Jerry Snitselaar wrote:
> > > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > > 
> > > 
> > > Thanks I'll add it to the next round.
> > > 
> > > For the tpm_buf_read(), I was thinking along the lines of:
> > > 
> > > /**
> > >  * tpm_buf_read() - Read from a TPM buffer
> > >  * @buf:        &tpm_buf instance
> > >  * @pos:        position within the buffer
> > >  * @count:      the number of bytes to read
> > >  * @output:     the output buffer
> > >  *
> > >  * Read bytes from a TPM buffer, and update the position. Returns
> > > false when the
> > >  * amount of bytes requested would overflow the buffer, which is
> > > expected to
> > >  * only happen in the case of hardware failure.
> > >  */
> > > static bool tpm_buf_read(const struct tpm_buf *buf, off_t *pos,
> > > size_t count, void *output)
> > > {
> > >         off_t next = *pos + count;
> > > 
> > >         if (next >= buf->length) {
> > >                 pr_warn("%s: %lu >= %lu\n", __func__, next,
> > > *offset);
> > >                 return false;
> > >         }
> > > 
> > >         memcpy(output, &buf->data[*pos], count);
> > >         *offset = next;
> > >         return true;
> > > }
> > > 
> > > BR, Jarkko
> > > 
> > 
> > Then the callers will check, and return -EIO?
> 
> Really, no, why would we do that?
> 
> The initial buffer is a page and no TPM currently can have a command
> that big, so if the buffer overflows, it's likely a programming error
> (failure to terminate loop or something) rather than a runtime one (a
> user actually induced a command that big and wanted it to be sent to
> the TPM).  The only reason you might need to check is the no-alloc case
> and you passed in a much smaller buffer, but even there, I would guess
> it will come down to a coding fault not a possible runtime error.
> 
> James
> 

I was clarifying based on this exchange below between Jarkko and Mario discussing patch 5/6.
From https://lore.kernel.org/all/CWGM2YH00DJ3.JKSYNNEWVRW4@suppilovahvero/ :


> > In the overflow case wouldn't you want to pass an error code up instead 
> > of just showing a WARN trace?
> >
> > The helper functions can't tell the difference, and the net outcome is 
> > going to be that if there is overflow you get a warning trace in the 
> > kernel log and whatever garbage "value" happened to have going to the 
> > caller.  It's a programmer error but it's also unpredictable what 
> > happens here.
> >
> > I think it's cleaner to have callers of 
> > tpm_buf_read_u8/tpm_buf_read_u16/tpm_buf_read_u32 to to be able to know 
> > something wrong happened.
>
> I think you have a fair point here and I also think it is also a bigger
> issue for the response parsing than programmer error. I.e. faulty or
> malicious TPM could return corrupted data, which makes WARN() wrong
> choice.
>
> So, as a corrective measure I think it should be pr_warn() instead, and
> instead of returning u8/u16/u32, all functions should return 'ssize_t'
> and -EIO in the case of overflow.
>
> Thank you, it was a really good catch.
>
> BR, Jarkko

