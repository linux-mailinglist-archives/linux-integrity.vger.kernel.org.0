Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA821CFD99
	for <lists+linux-integrity@lfdr.de>; Tue, 12 May 2020 20:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbgELSqA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 May 2020 14:46:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39481 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725987AbgELSqA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 May 2020 14:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589309158;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gANTnHwUhR+9/dJggusZJfVpovpiqd+gOXYf4b9mYZ4=;
        b=UUq0fo0uXuhAYfcAyjSZLLUh62XFekw7X80EvH0NkvcSQV/k2LY16C2wKXM6uikCCqi37i
        5iOy2JqGttQUiexxbmf6/LGomq/1qJ/vYi8ZFyxVIzSOV4t78o26hZYRsPUcV7Gt9QghUt
        2MdYGCfiG81zC/YSB6gSL8fUAFC4xFE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-maFJAEaTNfKFoouq_k2Omg-1; Tue, 12 May 2020 14:45:56 -0400
X-MC-Unique: maFJAEaTNfKFoouq_k2Omg-1
Received: by mail-qt1-f199.google.com with SMTP id o16so12688592qto.12
        for <linux-integrity@vger.kernel.org>; Tue, 12 May 2020 11:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=gANTnHwUhR+9/dJggusZJfVpovpiqd+gOXYf4b9mYZ4=;
        b=bDka7+0l5faOdDZ4ZXMFmah415zpoqCWmJ4PjRUg/Y4IUQLU7ZJjPMKOhFz9KPa/Dq
         74W5hHauZ9T/XKi/8VS/ncVfz/mKG9o6CR3Vu5Nyn4e4kXV6nh+Luk6XpkRXsL4p0dor
         Ym+lcaVJoGgCTCg8ZmAisjSHVIWhqHmgQkPHmpUQiRplKsIIUM+imOFY+AcX7at/HeIo
         Piz7q0mSBESmcCqCJYQiWDnaJu8nsmb5imJ1kw3lp6aSaAgRDJnk+XDg07jWKXFYRcQc
         DFZbJsZempmtglI/XEzbTWomSDQjSWrzSJcwASsS7yLYl9NNvg6ISlz997bAecg+SqBr
         FVfw==
X-Gm-Message-State: AOAM530Jz4SvFO1NU98OzYf7GyFn63FNJk5Zvne+BiWn+/9ehUrersh7
        NXUcg3eaqS64WfCluuyYtVi0SrPezuhsQEAl4MaCI0bqRBReg0/9hLfd9J+cdX20RaMNSnVrCF8
        sRIxWoQJDpeZ+R2VEcSKaIs0xTzGA
X-Received: by 2002:ac8:1967:: with SMTP id g36mr4745262qtk.332.1589309156185;
        Tue, 12 May 2020 11:45:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIyqJerzBCIu92cdFK0jMTrRxyGeFRN87+rPmKDn8q2nfKDKbVxPfDoPFlCWNWwrGkefWteg==
X-Received: by 2002:ac8:1967:: with SMTP id g36mr4745233qtk.332.1589309155938;
        Tue, 12 May 2020 11:45:55 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id 66sm12410202qtg.84.2020.05.12.11.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 11:45:54 -0700 (PDT)
Date:   Tue, 12 May 2020 11:45:53 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     =?utf-8?B?TG/Dr2M=?= Yhuel <loic.yhuel@gmail.com>
Cc:     linux-integrity@vger.kernel.org, matthewgarrett@google.com,
        ardb@kernel.org, jarkko.sakkinen@linux.intel.com,
        javierm@redhat.com
Subject: Re: [PATCH] tpm: check event log version before reading final events
Message-ID: <20200512184553.to7zij2lhbqfnedp@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20200512040113.277768-1-loic.yhuel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200512040113.277768-1-loic.yhuel@gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue May 12 20, Loïc Yhuel wrote:
>This fixes the boot issues since 5.3 on several Dell models when the TPM
>is enabled. Depending on the exact grub binary, booting the kernel would
>freeze early, or just report an error parsing the final events log.
>
>We get an event log in the SHA-1 format, which doesn't have a
>tcg_efi_specid_event_head in the first event, and there is a final events
>table which doesn't match the crypto agile format.
>__calc_tpm2_event_size reads bad "count" and "efispecid->num_algs", and
>either fails, or loops long enough for the machine to be appear frozen.
>
>So we now only parse the final events table, which is per the spec always
>supposed to be in the crypto agile format, when we got a event log in this
>format.
>
>Fixes: c46f3405692de ("tpm: Reserve the TPM final events table")
>Fixes: 166a2809d65b2 ("tpm: Don't duplicate events from the final event log in the TCG2 log")
>Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1779611
>Signed-off-by: Loïc Yhuel <loic.yhuel@gmail.com>
>---

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

