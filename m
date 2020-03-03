Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB80217843B
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Mar 2020 21:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731951AbgCCUmY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Mar 2020 15:42:24 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:47096 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731929AbgCCUmX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Mar 2020 15:42:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 753738EE11D;
        Tue,  3 Mar 2020 12:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583268143;
        bh=NHjX9B0O1UXJAoE0Ybf2EOiH0M3GPT64QFbXhCXHYe4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=H5qUP+9SofN/5WoGmpdycVCA3+qchonzMPp5zlaVnvuP3q1pGatoO0Kgs0EnMNsbQ
         Q8xJ+YUDGbgAGj5hkZE9qpXVvVfOV86IOWV5+eIDQNDoeP6jzDRhcInG+9shaoVqvx
         1ETCYAWgrqwbJec29chAWTkl8PygpFQEFTCh7VWc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iKYFZwUuNdMw; Tue,  3 Mar 2020 12:42:23 -0800 (PST)
Received: from jarvis.ext.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A86078EE10C;
        Tue,  3 Mar 2020 12:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583268143;
        bh=NHjX9B0O1UXJAoE0Ybf2EOiH0M3GPT64QFbXhCXHYe4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=H5qUP+9SofN/5WoGmpdycVCA3+qchonzMPp5zlaVnvuP3q1pGatoO0Kgs0EnMNsbQ
         Q8xJ+YUDGbgAGj5hkZE9qpXVvVfOV86IOWV5+eIDQNDoeP6jzDRhcInG+9shaoVqvx
         1ETCYAWgrqwbJec29chAWTkl8PygpFQEFTCh7VWc=
Message-ID: <1583268141.3638.10.camel@HansenPartnership.com>
Subject: Re: [PATCH v6 4/6] security: keys: trusted: use ASN.1 TPM2 key
 format for the blobs
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Tue, 03 Mar 2020 15:42:21 -0500
In-Reply-To: <20200303200614.GD5775@linux.intel.com>
References: <20200302122759.5204-1-James.Bottomley@HansenPartnership.com>
         <20200302122759.5204-5-James.Bottomley@HansenPartnership.com>
         <20200303200614.GD5775@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-03-03 at 22:06 +0200, Jarkko Sakkinen wrote:
> On Mon, Mar 02, 2020 at 07:27:57AM -0500, James Bottomley wrote:
> > Modify the TPM2 key format blob output to export and import in the
> > ASN.1 form for TPM2 sealed object keys.  For compatibility with
> > prior
> > trusted keys, the importer will also accept two TPM2B quantities
> > representing the public and private parts of the key.  However, the
> > export via keyctl pipe will only output the ASN.1 format.
> > 
> > The benefit of the ASN.1 format is that it's a standard and thus
> > the
> > exported key can be used by userspace tools (openssl_tpm2_engine,
> > openconnect and tpm2-tss-engine).  The format includes policy
> > specifications, thus it gets us out of having to construct policy
> > handles in userspace and the format includes the parent meaning you
> > don't have to keep passing it in each time.
> > 
> > This patch only implements basic handling for the ASN.1 format, so
> > keys with passwords but no policy.
> > 
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.c
> > om>
> 
> tpm_key (like you have tpm2_key prefix).

OK, I should probably do tpm2_key as the prefix since TPM 1.2 cannot do
 policy, that's a TPM 2 only thing.

James

