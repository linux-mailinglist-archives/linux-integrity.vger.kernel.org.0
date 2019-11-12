Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D82B4F9A66
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2019 21:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfKLURl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Nov 2019 15:17:41 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36400 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726376AbfKLURl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Nov 2019 15:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573589860;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qm8sRANNmzEPm6nlw2BezXJvLm5FulYqmCTuQv0ocvM=;
        b=VyRbd50Ga4ZOL7lmh8eZqa5toCAbmNaV4TIiZ/AGoE0ymtIEt+SqlBqNJHnrmLZIwOYpB2
        7wEqbPCj6IOAaOb5P7zFb8zIxmrOeyutV6HY+FN3THPSRhfNnQTONmroHTazVGZh1CUPM/
        hlYC/vosIi1NTTGzmRFBsw5LpT4ckUY=
Received: from mail-yw1-f70.google.com (mail-yw1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-kNqgvqGuOzugUI95RyEnrQ-1; Tue, 12 Nov 2019 15:17:38 -0500
Received: by mail-yw1-f70.google.com with SMTP id w139so14993770ywa.21
        for <linux-integrity@vger.kernel.org>; Tue, 12 Nov 2019 12:17:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Ue+RmWRiIYpJZ808L9pilsgFcrEW5+LqZcaMFFe1nnY=;
        b=PMfmAf9BqpblX/yM0qa+zkX+lrponpEEvfg7FiqsxrrRO8X03Svc3I6syPNAjKdWN4
         02zdyaJ0tIv1XFSlBHBhc01Gff39ykR4WQ+JzHXdDc6aziSgOHPkLIYiCpultQibmF1p
         +BbZToxBND4Fo3a4jWUR9URCby/WZ/d87sGX65xMzGhg74X5UKIRXh87vlFBZ+sNC8M6
         7JW2Nc3I/WB47cFof//qVl9IPsXQsnd14wHnmJchfrrULE8mFPwpvjFNZ64+cVcuLyQY
         5Hsx/CSzMqDc8Lsj2/6tywKNBpcc66+rDynbpEuIkAXcnm9M4vucvb5t1J6CV5uvv4pz
         DHOQ==
X-Gm-Message-State: APjAAAUfWJSC8txUB/0tlrxh3NQPU9C6skJDq83oprwee4etpOaFCtWZ
        3lao2ZWXuX9QSETqDl+2Ugj8lr0RuYHFE38Knp2fTWF8n6EmB16ob6brC0XJ/jGoqvm2tdqcU68
        ONO7hz2ZXQPVYT41d6ceXLW9MVo33
X-Received: by 2002:a0d:ed03:: with SMTP id w3mr20747369ywe.359.1573589858337;
        Tue, 12 Nov 2019 12:17:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqxYp2kqGLoqObRY4Is6v+pkaruIb7c8mpH86ZaIHND5kbcPDCzu5Wor8G+hmiSRQuTmt3fZoQ==
X-Received: by 2002:a0d:ed03:: with SMTP id w3mr20747359ywe.359.1573589858076;
        Tue, 12 Nov 2019 12:17:38 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id q127sm13598290ywc.43.2019.11.12.12.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 12:17:37 -0800 (PST)
Date:   Tue, 12 Nov 2019 13:17:34 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: question about setting TPM_CHIP_FLAG_IRQ in tpm_tis_core_init
Message-ID: <20191112201734.sury5nd3cptkckgb@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191112033637.kxotlhm6mtr5irvd@cantor>
 <20191112200703.GB11213@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191112200703.GB11213@linux.intel.com>
X-MC-Unique: kNqgvqGuOzugUI95RyEnrQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Nov 12 19, Jarkko Sakkinen wrote:
>On Mon, Nov 11, 2019 at 08:36:37PM -0700, Jerry Snitselaar wrote:
>> Question about 1ea32c83c699 ("tpm_tis_core: Set TPM_CHIP_FLAG_IRQ
>> before probing for interrupts").  Doesn't tpm_tis_send set this flag,
>> and setting it here in tpm_tis_core_init short circuits what
>> tpm_tis_send was doing before? There is a bug report of an interrupt
>> storm from a tpm on a t490s laptop with the Fedora 31 kernel (5.3),
>> and I'm wondering if this change could cause that. Before they got the
>> warning about interrupts not working, and using polling instead.
>
>Looks like it. Stefan?
>
>/Jarkko
>

Stefan is right about the condition check at the beginning of tpm_tis_send.

=09if (!(chip->flags & TPM_CHIP_FLAG_IRQ) || priv->irq_tested)
=09=09return tpm_tis_send_main(chip, buf, len);

Before his change it would've gone straight to calling
tpm_tis_send_main instead of jumping down and doing the irq test, due
to the flag not being set. With his change it should now skip this
tpm_tis_send_main call when tpm_tis_gen_interrupt is called, and then
after that time through tpm_tis_send priv->irq_tested will be set, and
the flag should be set as to whether or not irqs were working.

I should hopefully have access to a t490s in a few days so I can look at it=
,
and try to figure out what is happening.

