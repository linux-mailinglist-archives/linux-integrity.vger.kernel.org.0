Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49C57FE573
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Nov 2019 20:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfKOTOz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Nov 2019 14:14:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58602 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726308AbfKOTOz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Nov 2019 14:14:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573845293;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6aeKPDmbhVFkPfpFZ83fbmccBa2OFHpCHF58FRCqPwY=;
        b=Cl288YrGYXPs+jIjxIrKUPuHDzpigmJplF0WaCjMyj5bacJXTeG3DkE2hJ1zHB4QBUGGpq
        69/GzXsWJVESOe52Ix8feYgC3AA904QHkb8tPh5tW+zZsc0sbFALT0W+kgfIQxqfAUWnht
        bKOoBNfqpf1/5uQR08VHF1L/UY82cXQ=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-tKpgKRE2PhWTVkafHEM04g-1; Fri, 15 Nov 2019 14:14:52 -0500
Received: by mail-pg1-f200.google.com with SMTP id u197so7947810pgc.17
        for <linux-integrity@vger.kernel.org>; Fri, 15 Nov 2019 11:14:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=FxBh+q2M0KKHt6TdqEdE1VpfsrS5eZh2oXrvCdz9BQo=;
        b=jOXpqJIShX3ji9Lkt1pT4jfTSCtHaLngYIzothgohKwgmvz9xLRlm2IwkO6MXIOX5+
         ta1bdU46iJxAKmgdVibpWWD5N3Lt3E2+QHlmOTu/EqiDvClB6RqnXL20327I/SF/wIT1
         uJPOFdAypsYGNW3iRGEeEEz99E0U5ZuBlADAoGRVHhUa06bkg35hDA3nOc1wVI9H83Hf
         ojWfGuqglEL0+EvTAkeNc4Ql1bP86QTrc+i3sjPW8wejZY9+WsOQsDCFoLedBWF5koz6
         /w6YcTuq4wY6ikb/lZS8/HJbkYx3uV4qxhI6mx00BPB9JLlg7DuOdCCR9IF/srpQtfdD
         PRGg==
X-Gm-Message-State: APjAAAVHV454ivhjQgGZajIa+FuyDBcUkHhcjsXZXX8+ARpOpHFQJ3SF
        3SXDQWkV5VcqLDsc7ubwnI3fu3+HuCR/E62bUC+tdziaoSwAJuTx3ExdFR6pHQ3/G8UBJIv3Vdq
        OCL3F5Bg2mERh3sfdnGLebkgBP8LB
X-Received: by 2002:a62:31c1:: with SMTP id x184mr19500526pfx.255.1573845291380;
        Fri, 15 Nov 2019 11:14:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqxv+9Zt2zsiWTpVh31clu5gBOi8WXECDEI8w7e37+mZ8dEznH2KmYFs+APiWtJMjzZwXiqG3w==
X-Received: by 2002:a62:31c1:: with SMTP id x184mr19500497pfx.255.1573845291027;
        Fri, 15 Nov 2019 11:14:51 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id q34sm10731806pjb.15.2019.11.15.11.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 11:14:50 -0800 (PST)
Date:   Fri, 15 Nov 2019 12:14:49 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: question about setting TPM_CHIP_FLAG_IRQ in tpm_tis_core_init
Message-ID: <20191115191449.qnqgos4nli3tjsdw@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191112033637.kxotlhm6mtr5irvd@cantor>
 <6d6f0899-8ba0-d6cf-ef3b-317ca698b687@linux.ibm.com>
 <20191112201716.GA12340@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191112201716.GA12340@linux.intel.com>
X-MC-Unique: tKpgKRE2PhWTVkafHEM04g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Nov 12 19, Jarkko Sakkinen wrote:
>On Tue, Nov 12, 2019 at 08:28:57AM -0500, Stefan Berger wrote:
>> I set this flag for the TIS because it wasn't set anywhere else.
>> tpm_tis_send() wouldn't set the flag but go via the path:
>>
>> if (!(chip->flags & TPM_CHIP_FLAG_IRQ) || priv->irq_tested)
>>
>> =A0=A0=A0=A0=A0=A0=A0 return tpm_tis_send_main(chip, buf, len);
>
>Wondering why this isn't just "if (priv->irq_tested)"? Isn't that the
>whole point. The tail is the test part e.g. should be executed when
>IRQ testing is done.
>
>/Jarkko
>

I wonder if it would make sense to rename tpm_tis_send_main to tpm_tis_send=
,
move the irq testing bits from the current tpm_tis_send to tpm_tis_gen_inte=
rrupt,
and have tpm_tis_gen_interrupt build its own tpmbufs to send via tpm_tis_se=
nd
for the testing. Have all the irq testing bits are off on their own and sep=
arated out
from sending commands.

