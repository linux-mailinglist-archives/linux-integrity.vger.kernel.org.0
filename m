Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2E0AF91FF
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2019 15:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfKLOYY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Nov 2019 09:24:24 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46495 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727571AbfKLOYX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Nov 2019 09:24:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573568662;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M77sYtpSw/g9JRg/IfCLuexix7fcghmSQ3Jw6ATftUk=;
        b=jAvzKI3jaHur29od8JQ4iT2KYfC7zZYIGu4F8AR9X8SF7+thzCpkBTxjqmxe91PHLG/aZp
        ZV8GOQtI1E7rdk+u1HizlloLYdVgLMRM3Vsop457daCDBRCbMukH1WKfLhbSMpis+R/mnR
        VLvwQ8UR7kvpL8fJmDbqZBWp17odOFU=
Received: from mail-yw1-f71.google.com (mail-yw1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-iTXzKesYPNSt7XeiJfOrng-1; Tue, 12 Nov 2019 09:24:21 -0500
Received: by mail-yw1-f71.google.com with SMTP id k81so5162657ywc.16
        for <linux-integrity@vger.kernel.org>; Tue, 12 Nov 2019 06:24:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=ta39WYxBtJE/JXsxQ2/3SPPahK/8w69J/Szz/R4mdEE=;
        b=aGicIgveir13GsWZy9LStxraNvl9q0jnHs7gk9P+KrrQHBpwveFxari+T51bDq2HJt
         jsMpr8Nb6ZrQR4LizGgSHktUu4X/KOTWjwFD1rLfgQA7KSGQHpebbUy0NWsj9aSb3hqb
         ++TEislIqe7IIXREGw/m4E53D23IfgUJSyQdJhusCoLCsnAeSXbLLT8n65AnyXL5G5gY
         AmseJoPpEmtUtze+Imgbh3wFOX0M37iFlzmvT4kNXTmg8s40LRpM0PCGdWtQNfQaHlOv
         pO/Hlnc61IyeW8e5HyGs4cTnwqvcRisHlf30gebkmiQLRPN1PK75PL8nsA6A9M1ZQUY3
         jLPA==
X-Gm-Message-State: APjAAAUXXe2nHy4+2BMeiLSk8iGSf9FnpEiuwU0O3AfZ1KOgPMSmPNWK
        QytVJF25mPRA30DTgMYhN2Q2s3LB1VTJ/OWY9WnWKDdE8FK+i2hMJgf37ql3xnOQ8082gE7im/7
        cu2jJkQhfLGu9zFBASRPJBuHApXgA
X-Received: by 2002:a81:3b13:: with SMTP id i19mr17810126ywa.323.1573568660971;
        Tue, 12 Nov 2019 06:24:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqxUg78618D2fcXoQYSagmvyiQSiUMbyoovS8k3jxjqiMme2L6aGaCnicA9qmzOnKuupXAXXjg==
X-Received: by 2002:a81:3b13:: with SMTP id i19mr17810105ywa.323.1573568660693;
        Tue, 12 Nov 2019 06:24:20 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id n128sm1880219ywc.99.2019.11.12.06.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 06:24:19 -0800 (PST)
Date:   Tue, 12 Nov 2019 07:24:18 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: question about setting TPM_CHIP_FLAG_IRQ in tpm_tis_core_init
Message-ID: <20191112142418.3wwa4iukas4h2glp@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Stefan Berger <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191112033637.kxotlhm6mtr5irvd@cantor>
 <6d6f0899-8ba0-d6cf-ef3b-317ca698b687@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <6d6f0899-8ba0-d6cf-ef3b-317ca698b687@linux.ibm.com>
X-MC-Unique: iTXzKesYPNSt7XeiJfOrng-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Nov 12 19, Stefan Berger wrote:
>On 11/11/19 10:36 PM, Jerry Snitselaar wrote:
>>Question about 1ea32c83c699 ("tpm_tis_core: Set TPM_CHIP_FLAG_IRQ=20
>>before probing for interrupts").
>>Doesn't tpm_tis_send set this flag, and setting it here in=20
>>tpm_tis_core_init short circuits what
>>tpm_tis_send was doing before? There is a bug report of an interrupt=20
>>storm from a tpm on a t490s laptop
>>with the Fedora 31 kernel (5.3), and I'm wondering if this change=20
>>could cause that. Before they got
>>the warning about interrupts not working, and using polling instead.
>>
>I set this flag for the TIS because it wasn't set anywhere else.=20
>tpm_tis_send() wouldn't set the flag but go via the path:
>
>if (!(chip->flags & TPM_CHIP_FLAG_IRQ) || priv->irq_tested)
>
>=A0=A0=A0=A0=A0=A0=A0 return tpm_tis_send_main(chip, buf, len);
>
>the only other line for the TIS to set the IRQ flag was in the same=20
>function further below, though that wouldn't be reached due to the=20
>above:
>
>[...]
>
>priv->irq =3D irq;
>
>chip->flags |=3D TPM_CHIP_FLAG_IRQ;
>
>
>=A0=A0 Stefan
>
>

Ugh, you're right I was reading that as ! around both the flag and priv->ir=
q_tested.

Should the flag be cleared if tpm_tis_probe_irq_single fails prior to calli=
ng
tpm_tis_gen_interrupt?

