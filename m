Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC1E18BD03
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Mar 2020 17:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbgCSQsK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Mar 2020 12:48:10 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:32839 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727302AbgCSQsK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Mar 2020 12:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584636489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l150OeJhLpvD5jxqDhbmIHDFW9C0fx5AN+vg9ZphShw=;
        b=gNU8GZWxY6KOOaGOR/I3jvywZdwzqUZ4+FuLtzML9k+kv+tlgCgZK9H4TWcv0a0oYCRf3n
        dcjT2L0ubw+I0w4oVg764Z+X7SeD5xH0GlGEbupWsfO68eIDqu3Yd47/8UTuKqcMGoXz71
        cQ4Go8E4LQ06OZntvhLxltySkfpCyvs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-A8BMc2IcNvKVA0hbP4oA2g-1; Thu, 19 Mar 2020 12:48:05 -0400
X-MC-Unique: A8BMc2IcNvKVA0hbP4oA2g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D549310CE785;
        Thu, 19 Mar 2020 16:48:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-126.rdu2.redhat.com [10.10.113.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A427D9129C;
        Thu, 19 Mar 2020 16:48:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200310051607.30334-3-James.Bottomley@HansenPartnership.com>
References: <20200310051607.30334-3-James.Bottomley@HansenPartnership.com> <20200310051607.30334-1-James.Bottomley@HansenPartnership.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     dhowells@redhat.com, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: Re: [PATCH v8 2/8] oid_registry: Add TCG defined OIDS for TPM keys
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3180321.1584636480.1@warthog.procyon.org.uk>
Date:   Thu, 19 Mar 2020 16:48:00 +0000
Message-ID: <3180322.1584636480@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> The TCG has defined an OID prefix "2.23.133.10.1" for the various TPM
> key uses.  We've defined three of the available numbers:
> 
> 2.23.133.10.1.3 TPM Loadable key.  This is an asymmetric key (Usually
> 		RSA2048 or Elliptic Curve) which can be imported by a
> 		TPM2_Load() operation.
> 
> 2.23.133.10.1.4 TPM Importable Key.  This is an asymmetric key (Usually
> 		RSA2048 or Elliptic Curve) which can be imported by a
> 		TPM2_Import() operation.
> 
> Both loadable and importable keys are specific to a given TPM, the
> difference is that a loadable key is wrapped with the symmetric
> secret, so must have been created by the TPM itself.  An importable
> key is wrapped with a DH shared secret, and may be created without
> access to the TPM provided you know the public part of the parent key.
> 
> 2.23.133.10.1.5 TPM Sealed Data.  This is a set of data (up to 128
> 		bytes) which is sealed by the TPM.  It usually
> 		represents a symmetric key and must be unsealed before
> 		use.
> 
> The ASN.1 binary key form starts of with this OID as the first element
> of a sequence, giving the binary form a unique recognizable identity
> marker regardless of encoding.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Reviewed-by: David Howells <dhowells@redhat.com>

