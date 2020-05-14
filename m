Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4E61D370E
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 18:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgENQ4E (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 May 2020 12:56:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47538 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725975AbgENQ4D (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 May 2020 12:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589475362;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=rmIwHFtRNlCmo7NFOKDxENdp5ZMLSrmQJPjBjGyfYgw=;
        b=AMmjfNUUeMIzwgQN4ouoB99prj4JZYEKS+SdvGlMen9emf8FLHA1+XIWrasYJz68s1PT+D
        hJYvhHrF6Ub0+ssU6CkPlZs+BY4XXNMP4DU6mY7179wg5CSaMjaeW6FkEIkVPVWKlyAcB4
        AXKa3Guw+WBeoyMCMdqZn+8S7p6TVxI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-Pu6OvfSBOJ-tLKZ3VGwpvA-1; Thu, 14 May 2020 12:55:59 -0400
X-MC-Unique: Pu6OvfSBOJ-tLKZ3VGwpvA-1
Received: by mail-qk1-f200.google.com with SMTP id o73so3690746qka.22
        for <linux-integrity@vger.kernel.org>; Thu, 14 May 2020 09:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=rmIwHFtRNlCmo7NFOKDxENdp5ZMLSrmQJPjBjGyfYgw=;
        b=Zm04U400aJEGiXQ3t1UtwLdLxuJtG4bkJoncIPX4x+1/px1CgjECESPS2fjdW/l38E
         hF+gMcLkz+2b5CwkdE6Inu/vK85aM7GW9L0Hmvlh+x71AhZbXuHDgT3+wqmAKQGzttHq
         2coaYfB3H9rcRmuLtN3qJzNe3O4aX6a/JZaFc3bz1RocoCpzLHsogyQ8fnqT6UMWns6z
         xucBJmlYBhJpp8FBiUUHfD+al72bYQck34ldd5WHwGG1RctIwfHnVODo+xDEWOsIwB49
         zD7E+wDvXy1l7brpx3zOkc54jcsaTA+Amr0AmxkMUIbhM2KA1Hynv5LNcgN5Q6tu6oBQ
         D/cQ==
X-Gm-Message-State: AOAM532+HpMQvFuULEau13SXCZkv3IKL3n1RqLmJJXKMYzpSezHbedX+
        cZ0hr7v+ZY8pytDZKdBYZX1SLSalOQAWymQ6Ui3BFiVCCvbGMg2KirhxwoydAb6coVTkCr51wb5
        xdeU6IKh3uZdz+gFlIqkvbLZIF206
X-Received: by 2002:ac8:4749:: with SMTP id k9mr5720183qtp.184.1589475358589;
        Thu, 14 May 2020 09:55:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYbi3Gdb4+ArJcxlOR7KFAh93YiUT2Qe9nQkyp7uJ8u7j0Z97AOr8teqxbE4O55zA5fM/+lg==
X-Received: by 2002:ac8:4749:: with SMTP id k9mr5720153qtp.184.1589475358300;
        Thu, 14 May 2020 09:55:58 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id v4sm2782805qkv.43.2020.05.14.09.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 09:55:56 -0700 (PDT)
Date:   Thu, 14 May 2020 09:55:55 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Matthew Garrett <mjg59@google.com>
Subject: Re: Disparity in tpm pcr5 value
Message-ID: <20200514165555.h4jti3wl4r3juc5c@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20200505222731.whnkisag7tlrbcie@cantor>
 <20200513171052.GD25598@linux.intel.com>
 <20200513175931.xte33asq5nskjflh@cantor>
 <a158d1a51710309995af3a2d5faf2641f51d82b5.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <a158d1a51710309995af3a2d5faf2641f51d82b5.camel@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu May 14 20, Jarkko Sakkinen wrote:
>On Wed, 2020-05-13 at 10:59 -0700, Jerry Snitselaar wrote:
>> On Wed May 13 20, Jarkko Sakkinen wrote:
>> > On Tue, May 05, 2020 at 03:27:31PM -0700, Jerry Snitselaar wrote:
>> > > On some systems we've had reports of the value of pcr5 doesn't match the digests in the tpm event log.
>> > > It looks like I'm able to reproduce here with 5.7-rc4 on a dell system using this parser:
>> > >
>> > > https://github.com/ValdikSS/binary_bios_measurements_parser
>> > >
>> > > Any thoughts on where to start digging? Is there another tool I should use to parse this?
>> >
>> > ExitBootServices() extends PCR5. My 1st intuition would be to look at
>> > final event table handling, which I documented here:
>> >
>> > https://www.kernel.org/doc/Documentation/security/tpm/tpm_event_log.rst
>> >
>> > It is somewhat quirky how it nees to be managed (had to read that
>> > myself to recall how it went).
>> >
>> > /Jarkko
>> >
>>
>> Yes, my guess is the problem is that when the bios is set to use sha1 it
>> does not present a final events log to the os.
>
>Do these relate:
>
>https://patchwork.kernel.org/patch/11542035/
>
>?
>
>/Jarkko
>

I think the case I'm looking at is different. When it is calling
match_config_table it doesn't even see a Final Events log table in
this case, which is prior to calling efi_tpm_eventlog_init.

