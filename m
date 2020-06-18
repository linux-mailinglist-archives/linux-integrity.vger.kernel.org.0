Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5851A1FFBB2
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 21:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgFRTWF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jun 2020 15:22:05 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:44558 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726925AbgFRTWF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 15:22:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9A0C48EE181;
        Thu, 18 Jun 2020 12:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1592508124;
        bh=AeJEQ3gyXbW8kDVuPGPOzZJWinGu6lLAijASbDnhmv0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=s8f7Kwq83NZ4RdQpTqfQn4XAcRkniIeHQE/uXqUaQdAAHc4ld/1SQrHJIT1mR5Lxp
         mN+e7drR+8CfK0JE4haHjycv5ExXjS8GQAl+hyMcan1ObTQWlx2ckUWMuLpQmjffyT
         QcGvdo64gYEsIFOehfQyyf6RLVdfRbuzZP9Eqvx8=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id T5I8Huw3GqmW; Thu, 18 Jun 2020 12:22:04 -0700 (PDT)
Received: from jarvis (unknown [216.116.10.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id DDAD58EE0EA;
        Thu, 18 Jun 2020 12:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1592508124;
        bh=AeJEQ3gyXbW8kDVuPGPOzZJWinGu6lLAijASbDnhmv0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=s8f7Kwq83NZ4RdQpTqfQn4XAcRkniIeHQE/uXqUaQdAAHc4ld/1SQrHJIT1mR5Lxp
         mN+e7drR+8CfK0JE4haHjycv5ExXjS8GQAl+hyMcan1ObTQWlx2ckUWMuLpQmjffyT
         QcGvdo64gYEsIFOehfQyyf6RLVdfRbuzZP9Eqvx8=
Message-ID: <1592508122.15159.7.camel@HansenPartnership.com>
Subject: Re: [PATCH v10 2/8] oid_registry: Add TCG defined OIDS for TPM keys
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Date:   Thu, 18 Jun 2020 12:22:02 -0700
In-Reply-To: <20200618071451.GC6560@linux.intel.com>
References: <20200616160229.8018-1-James.Bottomley@HansenPartnership.com>
         <20200616160229.8018-3-James.Bottomley@HansenPartnership.com>
         <20200617214237.dlvfnx2s7aw4sfng@cantor>
         <1592439940.3515.40.camel@HansenPartnership.com>
         <20200618071451.GC6560@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-06-18 at 10:14 +0300, Jarkko Sakkinen wrote:
> On Wed, Jun 17, 2020 at 05:25:40PM -0700, James Bottomley wrote:
> > On Wed, 2020-06-17 at 14:42 -0700, Jerry Snitselaar wrote:
> > > On Tue Jun 16 20, James Bottomley wrote:
> > > > The TCG has defined an OID prefix "2.23.133.10.1" for the
> > > > various
> > > > TPM
> > > > key uses.  We've defined three of the available numbers:
> > > > 
> > > > 2.23.133.10.1.3 TPM Loadable key.  This is an asymmetric key
> > > > (Usually
> > > > 		RSA2048 or Elliptic Curve) which can be
> > > > imported by a
> > > > 		TPM2_Load() operation.
> > > > 
> > > > 2.23.133.10.1.4 TPM Importable Key.  This is an asymmetric key
> > > > (Usually
> > > > 		RSA2048 or Elliptic Curve) which can be
> > > > imported by a
> > > > 		TPM2_Import() operation.
> > > > 
> > > > Both loadable and importable keys are specific to a given TPM,
> > > > the
> > > > difference is that a loadable key is wrapped with the symmetric
> > > > secret, so must have been created by the TPM itself.  An
> > > > importable
> > > > key is wrapped with a DH shared secret, and may be created
> > > > without
> > > > access to the TPM provided you know the public part of the
> > > > parent
> > > > key.
> > > > 
> > > > 2.23.133.10.1.5 TPM Sealed Data.  This is a set of data (up to
> > > > 128
> > > > 		bytes) which is sealed by the TPM.  It usually
> > > > 		represents a symmetric key and must be unsealed
> > > > before
> > > > 		use.
> > > > 
> > > 
> > > James, which document are these defined in? I was searching last
> > > night, and couldn't find it.
> > 
> > It isn't.  It's defined in a TCG spreadsheet that Monty Wiseman
> > keeps, but that seems to be as "official" as it gets with the TCG
> > OID registry.
> > 
> > James
> 
> "The TCG has defined an OID prefix "2.23.133.10.1" for the various
> TPM key uses."
> 
> Should this sentence start just as "TCG ...", not sure if "the" is
> required?

I've always referred to it as The Trusted Computing Group (so the TCG)
partly to show they're not just any old trusted computing group.  But I
think they mostly do refer to themselves in literature as TCG.

James

