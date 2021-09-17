Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C3940FB0A
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Sep 2021 17:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243945AbhIQPFK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Sep 2021 11:05:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31578 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243905AbhIQPFJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Sep 2021 11:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631891026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TAe+oG5EoB/xsW+VkI8C3GMgsAn6pZzYpitv5V4ZUo8=;
        b=FICIWQzIe7eXpMzFGpjrfT2EexRe4oPsEjR7yq3W75qiSHE1JSoKv4S2Y3wwdyDY3tkK87
        1LPJmZagazoDrNbiB8siZoRjSuNGy0eDupOaKk0J02cuYw5KrSyS86magTUDASwxzvrA+m
        3pbeKXtC6lO1npQcjlQItt8vpQOrCXs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-Ly23PJDXOHmtY211orh8zg-1; Fri, 17 Sep 2021 11:03:43 -0400
X-MC-Unique: Ly23PJDXOHmtY211orh8zg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77652101AFA9;
        Fri, 17 Sep 2021 15:03:38 +0000 (UTC)
Received: from redhat.com (ovpn-112-133.phx2.redhat.com [10.3.112.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3531760C25;
        Fri, 17 Sep 2021 15:03:35 +0000 (UTC)
Date:   Fri, 17 Sep 2021 11:03:33 -0400
From:   Peter Jones <pjones@redhat.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Subject: Re: [PATCH v6 12/13] integrity: Trust MOK keys if MokListTrustedRT
 found
Message-ID: <20210917150332.cakrhyxh655e73jo@redhat.com>
References: <20210914211416.34096-1-eric.snowberg@oracle.com>
 <20210914211416.34096-13-eric.snowberg@oracle.com>
 <20210916221922.xjplaobua2iss2bn@redhat.com>
 <9C5B2B68-5F03-472F-8B17-E0A716C85CF2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9C5B2B68-5F03-472F-8B17-E0A716C85CF2@oracle.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Sep 16, 2021 at 08:00:54PM -0600, Eric Snowberg wrote:
> 
> > On Sep 16, 2021, at 4:19 PM, Peter Jones <pjones@redhat.com> wrote:
> > 
> > On Tue, Sep 14, 2021 at 05:14:15PM -0400, Eric Snowberg wrote:
> >> +/*
> >> + * Try to load the MokListTrustedRT UEFI variable to see if we should trust
> >> + * the mok keys within the kernel. It is not an error if this variable
> >> + * does not exist.  If it does not exist, mok keys should not be trusted
> >> + * within the machine keyring.
> >> + */
> >> +static __init bool uefi_check_trust_mok_keys(void)
> >> +{
> >> +	efi_status_t status;
> >> +	unsigned int mtrust = 0;
> >> +	unsigned long size = sizeof(mtrust);
> >> +	efi_guid_t guid = EFI_SHIM_LOCK_GUID;
> >> +	u32 attr;
> >> +
> >> +	status = efi.get_variable(L"MokListTrustedRT", &guid, &attr, &size, &mtrust);
> > 
> > This should use efi_mokvar_entry_find("MokListTrustedRT") instead,
> > similar to how load_moklist_certs() does.  It's a *much* more reliable
> > mechanism.  We don't even need to fall back to checking for the
> > variable, as any version of shim that populates this supports the config
> > table method.
> 
> I’ll change this in v7, thanks.

We do also need to figure out a path forward for something like Dimitri
Ledkov's MokListX patch[0] from May, though it doesn't necessarily need
to hold up this patch set.  It looks like your patches will change the
structure of the keyrings it needs to apply to, but I don't see a reason
it wouldn't be conditional on the same MokListTrustedRT variable.  Any
thoughts?

[0] https://lore.kernel.org/lkml/20210512153100.285169-1-dimitri.ledkov@canonical.com/

-- 
        Peter

