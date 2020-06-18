Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75BD1FFBF3
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 21:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgFRTpS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jun 2020 15:45:18 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:44752 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727024AbgFRTpS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 15:45:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A0D798EE25B;
        Thu, 18 Jun 2020 12:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1592509517;
        bh=vfw0OUluLG2BDlJRDQZkiymZ9eHiSMjRp2EjAJlVyS4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Gowfo1Ps7ncwt12Wb5orIRkteXDPOEb8CkSZz6lNNqKIwjYvgo3kKRqfpRT1DVLoL
         vdWh8rFxsxBpgwglumjn1s7SrgFrJgnLGNtzxg/7fW4Xczug29y3dNcQ06w8EDutDO
         qIRULrzTkQA/KcmEtS0w3HuQm1gqMDKqYY9esbq4=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dWQTeBML6tQm; Thu, 18 Jun 2020 12:45:17 -0700 (PDT)
Received: from jarvis (unknown [216.116.10.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A4AA88EE181;
        Thu, 18 Jun 2020 12:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1592509517;
        bh=vfw0OUluLG2BDlJRDQZkiymZ9eHiSMjRp2EjAJlVyS4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Gowfo1Ps7ncwt12Wb5orIRkteXDPOEb8CkSZz6lNNqKIwjYvgo3kKRqfpRT1DVLoL
         vdWh8rFxsxBpgwglumjn1s7SrgFrJgnLGNtzxg/7fW4Xczug29y3dNcQ06w8EDutDO
         qIRULrzTkQA/KcmEtS0w3HuQm1gqMDKqYY9esbq4=
Message-ID: <1592509514.15159.18.camel@HansenPartnership.com>
Subject: Re: [PATCH v10 7/8] security: keys: trusted: add ability to specify
 arbitrary policy
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Date:   Thu, 18 Jun 2020 12:45:14 -0700
In-Reply-To: <20200618071200.GB6560@linux.intel.com>
References: <20200616160229.8018-1-James.Bottomley@HansenPartnership.com>
         <20200616160229.8018-8-James.Bottomley@HansenPartnership.com>
         <20200617234250.GJ62794@linux.intel.com>
         <1592440063.3515.42.camel@HansenPartnership.com>
         <20200618071200.GB6560@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-06-18 at 10:12 +0300, Jarkko Sakkinen wrote:
> On Wed, Jun 17, 2020 at 05:27:43PM -0700, James Bottomley wrote:
> > On Thu, 2020-06-18 at 02:42 +0300, Jarkko Sakkinen wrote:
> > > On Tue, Jun 16, 2020 at 09:02:28AM -0700, James Bottomley wrote:
> > > > This patch adds a policy= argument to key creation.  The policy
> > > > is
> > > > the standard tss policymaker format and each separate policy
> > > > line
> > > > must have a newline after it.
> > > 
> > > Never heard of policymaker before and did not find TCG spec for
> > > it.
> > 
> > It's not part of the spec.  Both the IBM and Intel TSSs define a
> > policymaker tool to help you build policy hashes.  The format is
> > simply
> > a set of numbers that if hashed a line at a time produce the policy
> > hash.
> 
> OK, so they both use this 'policymaker' format? Where is it
> documented?

I don't think it is except in the source code of the tools.  It's
basically a sequence of TPM2_PolicyXX statements laid out in binary end
to end one per line as the TPM2 command value says they are hashed.  I
can just say that if you prefer.  The example given is

TPM2_PolicyPCR(policydigest, selection)
TPM2_PolicyAuthValue()

So if you look in the manual, TPM2_PolicyPCR says the hash is
calculated as

H_policyAlg (policyDigest_old || TPM_CC_PolicyPCR || pcrs || digestTPM)

So the policymaker statement is

TPM_CC_PolicyPCR || pcrs || digestTPM

Which in hex is

0000017F 00000001000B 03000001303095B49BE85E381E5B20E557E46363EF55B0F43B132C2D8E3DE9AC436656F2

And TPM2_PolicyAuthValue simply says

H_policyAlg (policyDigest_old || TPM_CC_PolicyAuthValue )

So the policymaker statement is

TPM_CC_PolicyAuthValue

or in hex

0000016b

James

