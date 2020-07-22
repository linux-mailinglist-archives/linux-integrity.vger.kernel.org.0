Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29D6228CF2
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Jul 2020 02:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgGVACJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Jul 2020 20:02:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46321 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726148AbgGVACJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jul 2020 20:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595376127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vWV7qmAUduoDhIydYfkym0IFVPU0vcwaW+6X4StgviE=;
        b=BOobZEH19rmSSfaBikHmIHI8s5M9KMrbNDbICO9mVUkg9oJ9x/15hUEWe/FD9m3jZwJlHc
        tOanJZ8uaQGzzZCjZKbEdkV7UgZ3BgweWI5QSYkw2sbDL+loBN4XcHjm7SmU4oF9dmj5iK
        qpV68qqx0ZSPdJPrjd1GwCKSt7pFAns=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-ea1VsD2MNre9POQyZZiXhw-1; Tue, 21 Jul 2020 20:02:06 -0400
X-MC-Unique: ea1VsD2MNre9POQyZZiXhw-1
Received: by mail-qk1-f200.google.com with SMTP id v16so216578qka.18
        for <linux-integrity@vger.kernel.org>; Tue, 21 Jul 2020 17:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=vWV7qmAUduoDhIydYfkym0IFVPU0vcwaW+6X4StgviE=;
        b=I6q8Yy5egIM2HXzj+KpYOyT0FSKEU49MripufvLDyvkeeQKhytfAFwRQIvzxI4u8Rl
         sIfXXpS3X4Ga5PLPWtaQcCFbTxN2kUDK0NVQ1Y2yQWusLAddnaZBMNm/37qTVWR4tv1S
         uKurttbEWtaTHTOqzlSym7JJrUXB3KmAwzqypi/2jFDreNv/0QRxFCecZu10LcS4DFgz
         F+HA6sLFpG5E+Q3SXNjqI9EWKWW3ieT8hAV00KlL1DUmFGhd0drhpfK4BG2WJVA1oTCV
         oTq8czsD/li8Fa91pn3cRTZytMtbZIS4ohV/XCAt0IJNh3A/vBh2el7iTmaXUbUxQ1r6
         JZFg==
X-Gm-Message-State: AOAM532ij+PlSGWLzZerWaY/W2P8LogNpl4sFRnmTkKlCgedgbYXXld+
        U6M+HMLI92eXmr5Fv6CIQPHcwlNpAMDGHa4N8qu1DlEasUdGvAZZAdaV5GdH8iJYpkaertTbgGz
        xtYFdWg7U+7n95Atifcay+cBNO00D
X-Received: by 2002:a37:9201:: with SMTP id u1mr30283970qkd.40.1595376125360;
        Tue, 21 Jul 2020 17:02:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTx9+X2r72KUsrt+KcqOPCaeg+hvIl2ciVggSWfJNZ6Vk8kfeVaBk5yIkcmx9pzasf3/SGgA==
X-Received: by 2002:a37:9201:: with SMTP id u1mr30283940qkd.40.1595376125041;
        Tue, 21 Jul 2020 17:02:05 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id s8sm23783233qtc.17.2020.07.21.17.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 17:02:04 -0700 (PDT)
References: <20200721155615.12625-1-James.Bottomley@HansenPartnership.com> <20200721155615.12625-2-James.Bottomley@HansenPartnership.com> <87a6zslar5.fsf@redhat.com> <1595374674.3575.28.camel@HansenPartnership.com>
User-agent: mu4e 1.4.10; emacs 26.3
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH v2 1/1] tpm: add sysfs exports for all banks of PCR registers
In-reply-to: <1595374674.3575.28.camel@HansenPartnership.com>
Date:   Tue, 21 Jul 2020 17:02:02 -0700
Message-ID: <877duwl8n9.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


James Bottomley @ 2020-07-21 16:37 MST:

> On Tue, 2020-07-21 at 16:16 -0700, Jerry Snitselaar wrote:
>> James Bottomley @ 2020-07-21 08:56 MST:
> [...]
>> > +	/*
>> > +	 * This will only trigger if someone has added an
>> > additional
>> > +	 * hash to the tpm_algorithms enum without incrementing
>> > +	 * TPM_MAX_HASHES.  This has to be a BUG_ON because under
>> > this
>> > +	 * condition, the chip->groups array will overflow
>> > corrupting
>> > +	 * the chips structure.
>> > +	 */
>> > +	BUG_ON(chip->groups_cnt > TPM_MAX_HASHES);
>> 
>> Should this check be 3 + TPM_MAX_HASHES like below?
>
> No, because at this point only a single additional group has been
> addedin addition to the hashes groups.  The first line of
> tpm_sysfs_add_device is
>
> 	WARN_ON(chip->groups_cnt != 0);
>
> And then we add the unnamed group.  This loop over the banks follows
> it, so chip->groups_cnt should be nr_banks_allocated by the end (it's
> the index, which is one fewer than the number of entries in chip-
>>groups[]).  We have a problem if nr_banks_allocated > TPM_MAX_HASHES
> which is what the BUG_ON checks.
>
> James

If the chip supported all 5 listed cases wouldn't groups_cnt be 6 at this
point?

