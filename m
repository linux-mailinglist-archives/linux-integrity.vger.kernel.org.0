Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508B01FD7BD
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2020 23:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgFQVmr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jun 2020 17:42:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20555 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726987AbgFQVmq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jun 2020 17:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592430162;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=ziGeZkLSk9E0BTm8y7vUR/zQZg7qRoz5nH/H2o7ywpo=;
        b=BEQuIuMD41BM2FXdZod5ChcZxzfAeWbr3/ueB/1IGOun7FqeRNkrMMtyV4kznjnfeTk5F3
        TrS2MCVYxD63EQ0UlDivAJSGWldCOXH7ILCA7kHLsECaSGh6NmgoPwYKRiFUWmJmU7kDHR
        kat5HvFsaaVPappb0Hxu/4xA1i3Nycs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-8SwFwzexMySFugsJhM6PpQ-1; Wed, 17 Jun 2020 17:42:40 -0400
X-MC-Unique: 8SwFwzexMySFugsJhM6PpQ-1
Received: by mail-qt1-f200.google.com with SMTP id e8so2771652qtq.22
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jun 2020 14:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=ziGeZkLSk9E0BTm8y7vUR/zQZg7qRoz5nH/H2o7ywpo=;
        b=qE8VC31d3nc+7eCtt3U7e0K2JzhHrsaiAss+xEKULKYNDicT0lRDIqtSAZNypJjJsr
         HAuK6tR35iZ2uYNVgwIR2ASCXQo60Ucg0Sx0jUMJFDu4dazp+ojI8NQspDwU2aO68vGl
         7bSKi1Htir4ld2VcIRoYRxdWlWgf1ZQKnJ2Q3hlvkyKlwAApSKy9XWEqyt1RrMyVZJh5
         0/U2WoDwlANe2hjnrSjlU64lF1QzQQFMbRrnJ3KllYtriWmIjUvGLBsLRDyaS/APnEnr
         PWfU6ylupT/p31lxWINIBWGdBLeN3tQ9X5XfY75Px4ORkD1V7j9LVZ86yQnO63DsUM38
         NdlA==
X-Gm-Message-State: AOAM5308etZ0sEWT/jRoyRhzUD6z3In8gPm2DXDPhnHvo3bA9U2+ORgo
        +0ZtetZwuYKrJcdA+ZEQLbsc/XFqjhFFBxuqjSw1XGLajZJoDmiJHzfXGrJKlk7zHUq5Vrt8jB0
        L83u005tbKCAY0B6QVbOCDo7dUKD2
X-Received: by 2002:aed:2a67:: with SMTP id k36mr1274725qtf.359.1592430160519;
        Wed, 17 Jun 2020 14:42:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2bbP1YY8oRqBLRJKk1O2Q+kPjLjdrsw0NkCYdnMEgqf+vfB9Irncji1qGx0MVsMoR6psqtw==
X-Received: by 2002:aed:2a67:: with SMTP id k36mr1274697qtf.359.1592430160226;
        Wed, 17 Jun 2020 14:42:40 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id k17sm1225973qtb.5.2020.06.17.14.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 14:42:39 -0700 (PDT)
Date:   Wed, 17 Jun 2020 14:42:37 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v10 2/8] oid_registry: Add TCG defined OIDS for TPM keys
Message-ID: <20200617214237.dlvfnx2s7aw4sfng@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20200616160229.8018-1-James.Bottomley@HansenPartnership.com>
 <20200616160229.8018-3-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200616160229.8018-3-James.Bottomley@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Jun 16 20, James Bottomley wrote:
>The TCG has defined an OID prefix "2.23.133.10.1" for the various TPM
>key uses.  We've defined three of the available numbers:
>
>2.23.133.10.1.3 TPM Loadable key.  This is an asymmetric key (Usually
>		RSA2048 or Elliptic Curve) which can be imported by a
>		TPM2_Load() operation.
>
>2.23.133.10.1.4 TPM Importable Key.  This is an asymmetric key (Usually
>		RSA2048 or Elliptic Curve) which can be imported by a
>		TPM2_Import() operation.
>
>Both loadable and importable keys are specific to a given TPM, the
>difference is that a loadable key is wrapped with the symmetric
>secret, so must have been created by the TPM itself.  An importable
>key is wrapped with a DH shared secret, and may be created without
>access to the TPM provided you know the public part of the parent key.
>
>2.23.133.10.1.5 TPM Sealed Data.  This is a set of data (up to 128
>		bytes) which is sealed by the TPM.  It usually
>		represents a symmetric key and must be unsealed before
>		use.
>

James, which document are these defined in? I was searching last night,
and couldn't find it.

>The ASN.1 binary key form starts of with this OID as the first element
>of a sequence, giving the binary form a unique recognizable identity
>marker regardless of encoding.
>
>Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>Reviewed-by: David Howells <dhowells@redhat.com>
>
>---
>
>v3: correct OID_TPMImportableKey name
>v7: add ack
>v9: add review
>---
> include/linux/oid_registry.h | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
>index 657d6bf2c064..f6e2276e5f30 100644
>--- a/include/linux/oid_registry.h
>+++ b/include/linux/oid_registry.h
>@@ -107,6 +107,11 @@ enum OID {
> 	OID_gostTC26Sign512B,		/* 1.2.643.7.1.2.1.2.2 */
> 	OID_gostTC26Sign512C,		/* 1.2.643.7.1.2.1.2.3 */
>
>+	/* TCG defined OIDS for TPM based keys */
>+	OID_TPMLoadableKey,		/* 2.23.133.10.1.3 */
>+	OID_TPMImportableKey,		/* 2.23.133.10.1.4 */
>+	OID_TPMSealedData,		/* 2.23.133.10.1.5 */
>+
> 	OID__NR
> };
>
>-- 
>2.26.2
>

