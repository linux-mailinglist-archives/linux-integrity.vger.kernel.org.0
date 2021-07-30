Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6273DB072
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jul 2021 02:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbhG3A5w (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Jul 2021 20:57:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229667AbhG3A5w (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Jul 2021 20:57:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55BCE60E09;
        Fri, 30 Jul 2021 00:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627606668;
        bh=ygv8iaOjYE4sDjSM91DEiqBnedl9PqHmgZEaYlbLeog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ozsxFXm9QrKRacuoDdrB4fgFL0cUOheW3UlGhp7oNGGKzln8MPnDj8iOhCULhEx+3
         FmKpOYPE+Gm98rKpiOXFUz2AwwWyjZtbCCiNSk/6M5MvrLk+NWnN/FwOVQiCIKFCq/
         C0lim1urBiVUiM4GGBDN4UxuMLpnVffkVXg3vn7ckh69uqOfMrNWP4DOtHrcE5lF7i
         tIH9APBqf62URyDOEoEKVh2BnjdnJiZRqLhAPaNnQO+ZUW8djGPDL+MjzMev0aIuPB
         fjbXAr4pF54Pu9qPEq0xbWsxLNVWMFS8UwyV1tG7RFoRJUPAOmSdFhBWsu0nltnFxX
         mcuKPfAxW7Eug==
Date:   Fri, 30 Jul 2021 03:57:44 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Nageswara R Sastry <rnsastry@linux.ibm.com>
Subject: Re: [PATCH] tpm: ibmvtpm: Avoid error message when process gets
 signal while waiting
Message-ID: <20210730005744.ph7x6nme5ngtpf43@kernel.org>
References: <20210712162505.205943-1-stefanb@linux.vnet.ibm.com>
 <20210727024225.swqy5ypcytsngpd6@kernel.org>
 <ad4011fb-fc1f-4019-9856-7d171db3255c@linux.ibm.com>
 <20210728215033.dhnekvksekalhcrn@kernel.org>
 <2add3eac-916e-5072-f62d-23c65e23fb17@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2add3eac-916e-5072-f62d-23c65e23fb17@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jul 29, 2021 at 09:39:18AM -0400, Stefan Berger wrote:
> 
> On 7/28/21 5:50 PM, Jarkko Sakkinen wrote:
> > On Mon, Jul 26, 2021 at 11:00:51PM -0400, Stefan Berger wrote:
> > > On 7/26/21 10:42 PM, Jarkko Sakkinen wrote:
> > > > On Mon, Jul 12, 2021 at 12:25:05PM -0400, Stefan Berger wrote:
> > > > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > > > 
> > > > > When rngd is run as root then lots of these types of message will appear
> > > > > in the kernel log if the TPM has been configure to provide random bytes:
> > > > > 
> > > > > [ 7406.275163] tpm tpm0: tpm_transmit: tpm_recv: error -4
> > > > > 
> > > > > The issue is caused by the following call that is interrupted while
> > > > > waiting for the TPM's response.
> > > > > 
> > > > > sig = wait_event_interruptible(ibmvtpm->wq,
> > > > >                                  !ibmvtpm->tpm_processing_cmd);
> > > > > 
> > > > > The solution is to use wait_event() instead.
> > > > Why?
> > > So it becomes uninterruptible and these error messages go away.
> > We do not want to make a process uninterruptible. That would prevent
> > killing it.
> 
> I guess we'll have to go back to this one then:
> https://www.spinics.net/lists/linux-integrity/msg16741.html

Makes a heck lot more sense.

There's a typo in the commit message: PM_STATUS_BUSY 

Also the commit message lacks explanation of this change completely:

@@ -690,8 +688,15 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
 		goto init_irq_cleanup;
 	}
 
-	if (!strcmp(id->compat, "IBM,vtpm20")) {
+
+	if (!strcmp(id->compat, "IBM,vtpm20"))
 		chip->flags |= TPM_CHIP_FLAG_TPM2;
+
+	rc = tpm_get_timeouts(chip);
+	if (rc)
+		goto init_irq_cleanup;
+
+	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
 		rc = tpm2_get_cc_attrs_tbl(chip);

The last paragraph should be rewritten in imperative form.

Finally, you could simplify the fix by simply changing the type of
tpm_processing_cmd to u8, and just set it to 'true' and 'false',
which will set the first bit.

/Jarkko
