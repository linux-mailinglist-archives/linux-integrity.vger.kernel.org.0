Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFF740ED42
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Sep 2021 00:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240942AbhIPWVA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Sep 2021 18:21:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35489 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240939AbhIPWU7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Sep 2021 18:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631830778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LNQZtZk5ThEEV8nRic1GVZzg3YqPdgzLNMNUtC2mm6g=;
        b=EZ7BGca2Os3Ykfm2PZy2HGWclyHC+Ow0a0JChNDCF1mHUMbmg5xOgatVdVFUfilQXSbBWI
        MS9WxQUCWzd/rwMZg4pPy81PDAXi6W7nqN3QgGuzFDqXqVKRid8n5sNbHidXS9GEErl6fY
        V4taXPs3lvcfQiYp5GViO+2cry6+euA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-Dy_LADkBNmysRyRpTdB3yA-1; Thu, 16 Sep 2021 18:19:37 -0400
X-MC-Unique: Dy_LADkBNmysRyRpTdB3yA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 113EF824FA7;
        Thu, 16 Sep 2021 22:19:34 +0000 (UTC)
Received: from redhat.com (ovpn-112-133.phx2.redhat.com [10.3.112.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AADF319C79;
        Thu, 16 Sep 2021 22:19:24 +0000 (UTC)
Date:   Thu, 16 Sep 2021 18:19:22 -0400
From:   Peter Jones <pjones@redhat.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, jmorris@namei.org, serge@hallyn.com,
        keescook@chromium.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, scott.branden@broadcom.com,
        weiyongjun1@huawei.com, nayna@linux.ibm.com, ebiggers@google.com,
        ardb@kernel.org, nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v6 12/13] integrity: Trust MOK keys if MokListTrustedRT
 found
Message-ID: <20210916221922.xjplaobua2iss2bn@redhat.com>
References: <20210914211416.34096-1-eric.snowberg@oracle.com>
 <20210914211416.34096-13-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210914211416.34096-13-eric.snowberg@oracle.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 14, 2021 at 05:14:15PM -0400, Eric Snowberg wrote:
> +/*
> + * Try to load the MokListTrustedRT UEFI variable to see if we should trust
> + * the mok keys within the kernel. It is not an error if this variable
> + * does not exist.  If it does not exist, mok keys should not be trusted
> + * within the machine keyring.
> + */
> +static __init bool uefi_check_trust_mok_keys(void)
> +{
> +	efi_status_t status;
> +	unsigned int mtrust = 0;
> +	unsigned long size = sizeof(mtrust);
> +	efi_guid_t guid = EFI_SHIM_LOCK_GUID;
> +	u32 attr;
> +
> +	status = efi.get_variable(L"MokListTrustedRT", &guid, &attr, &size, &mtrust);

This should use efi_mokvar_entry_find("MokListTrustedRT") instead,
similar to how load_moklist_certs() does.  It's a *much* more reliable
mechanism.  We don't even need to fall back to checking for the
variable, as any version of shim that populates this supports the config
table method.

-- 
        Peter

