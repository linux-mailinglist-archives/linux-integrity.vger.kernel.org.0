Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798F4228D37
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Jul 2020 02:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgGVAv7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Jul 2020 20:51:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31673 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728403AbgGVAv6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jul 2020 20:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595379117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8NxmQ6O7OmdAkBSR6tC/j8ZYcXi87Me7QoNartRSj2Y=;
        b=NjZ3swYgiN+YtuSv4+yCDHuczz+87YZx4XLr+MXZvp/yZgKd1THR1rt03tWOt5OS899Frs
        5Zb5lN9UB2ZrzqCbaXWbMisD+djubyRwjOtZ+oShw8r35zeIoLx/+Vtj9FkHQmWFAHvdkm
        amnPj5mRbGF0jHhQaEKlYQguLGg4LRM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-D8HqDaXkO2avIkio-rqcNg-1; Tue, 21 Jul 2020 20:51:55 -0400
X-MC-Unique: D8HqDaXkO2avIkio-rqcNg-1
Received: by mail-qv1-f72.google.com with SMTP id r12so457685qvk.3
        for <linux-integrity@vger.kernel.org>; Tue, 21 Jul 2020 17:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=8NxmQ6O7OmdAkBSR6tC/j8ZYcXi87Me7QoNartRSj2Y=;
        b=a+d1i1QhXJ093XVKwZ7ejpjFJMbSazrnX54Lniwe1upIyCYcFnzr5slBiURHpqV5pP
         HSahUYj+vqhHr+PTmgGHTKL0Tf9Bym5w1djO63ap4UKv5jDlQbUyEgpEjhKhd6xdxffw
         m3lIZ4ByI4NW/RYDGFRxmUJIm66COstQIQ6at2HIaqYxL+zOPwaPPAe85iZn26AJlODo
         yhdWAZRC9oKoUm+b14iUlNKVr3dYoQ8fTKl7toSUVnXXE6GR/q8r6hd0Pc8+rVxBdvyq
         RI9YV/tBot6vjtYP/PO4Flm3YATo7e+dFtyCTRIvM9I3l3FfZ9JU7MonHEDAafIrxoju
         a7DQ==
X-Gm-Message-State: AOAM530n3Eju7AM+VUPSgVISx0ovTbT/X7IUsoASVswV/SgwXa+Eco1j
        37DVtpG7CZa714pFgIn6Lg3YW9dNstHUud07uywx/aHbD1z3TMhtdpCTGpI8/xK6mWs1BF1hjYr
        DoO79gsArozBP8D53lTaVvckd5gbD
X-Received: by 2002:a05:620a:12b8:: with SMTP id x24mr27539527qki.158.1595379114624;
        Tue, 21 Jul 2020 17:51:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynFzBgyvCPDBmfX/VMchCz7KdWznynDnVrgPIxUbKhrcR6oD3dFN4bVlNxyM09qChSbBgKLA==
X-Received: by 2002:a05:620a:12b8:: with SMTP id x24mr27539516qki.158.1595379114327;
        Tue, 21 Jul 2020 17:51:54 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id n63sm3452169qkf.21.2020.07.21.17.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 17:51:53 -0700 (PDT)
References: <20200721155615.12625-1-James.Bottomley@HansenPartnership.com> <20200721155615.12625-2-James.Bottomley@HansenPartnership.com> <87a6zslar5.fsf@redhat.com> <1595374674.3575.28.camel@HansenPartnership.com> <877duwl8n9.fsf@redhat.com> <1595378385.3575.31.camel@HansenPartnership.com>
User-agent: mu4e 1.4.10; emacs 26.3
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH v2 1/1] tpm: add sysfs exports for all banks of PCR registers
In-reply-to: <1595378385.3575.31.camel@HansenPartnership.com>
Date:   Tue, 21 Jul 2020 17:51:52 -0700
Message-ID: <874kq0l6c7.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


James Bottomley @ 2020-07-21 17:39 MST:

> On Tue, 2020-07-21 at 17:02 -0700, Jerry Snitselaar wrote:
>> James Bottomley @ 2020-07-21 16:37 MST:
>> 
>> > On Tue, 2020-07-21 at 16:16 -0700, Jerry Snitselaar wrote:
>> > > James Bottomley @ 2020-07-21 08:56 MST:
>> > 
>> > [...]
>> > > > +	/*
>> > > > +	 * This will only trigger if someone has added an
>> > > > additional
>> > > > +	 * hash to the tpm_algorithms enum without
>> > > > incrementing
>> > > > +	 * TPM_MAX_HASHES.  This has to be a BUG_ON because
>> > > > under
>> > > > this
>> > > > +	 * condition, the chip->groups array will overflow
>> > > > corrupting
>> > > > +	 * the chips structure.
>> > > > +	 */
>> > > > +	BUG_ON(chip->groups_cnt > TPM_MAX_HASHES);
>> > > 
>> > > Should this check be 3 + TPM_MAX_HASHES like below?
>> > 
>> > No, because at this point only a single additional group has been
>> > addedin addition to the hashes groups.  The first line of
>> > tpm_sysfs_add_device is
>> > 
>> > 	WARN_ON(chip->groups_cnt != 0);
>> > 
>> > And then we add the unnamed group.  This loop over the banks
>> > follows it, so chip->groups_cnt should be nr_banks_allocated by the
>> > end (it's the index, which is one fewer than the number of entries
>> > in chip->groups[]).  We have a problem if nr_banks_allocated >
>> > TPM_MAX_HASHES
>> > 
>> > which is what the BUG_ON checks.
>> > 
>> > James
>> 
>> If the chip supported all 5 listed cases wouldn't groups_cnt be 6 at
>> this point?
>
> Actually, yes, I think it would be because it's pointing at the next
> free index not the current one.  So it should be BUG_ON (chip-
>>groups_cnt > TPM_MAX_HASHES + 1)
>
> James

One other thought, should a note be added above tpm_algorithms to note
that when that is changed TPM_MAX_HASHES should be changed as well?

With the above change to the BUG_ON you can add to v3:

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

