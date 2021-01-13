Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535C82F512F
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Jan 2021 18:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbhAMRc1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Jan 2021 12:32:27 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:39046 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725843AbhAMRc1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Jan 2021 12:32:27 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 769991280785;
        Wed, 13 Jan 2021 09:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1610559106;
        bh=H+01XCawg0hx89oCi/+Hu7DWUJLVmHNCk9z15Q1q+3E=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=nVVXR2Tb7lvmnDZNUlidZpngiqZR4CNLliJLDConvRYYoDqnadBCZPXLNf1805pNx
         RK6FPJtemauKLHLNuHXbYmxvt9OuX2Vd4jwG7gdj1sZ1d5rkwqbiIaZag1z1dbdeVq
         qmG2tZy0IvOYduFlol1QkAV1I+DqlgSg4wZRlOtE=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Hdzphnc8f5LB; Wed, 13 Jan 2021 09:31:46 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 13EB012806CB;
        Wed, 13 Jan 2021 09:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1610559106;
        bh=H+01XCawg0hx89oCi/+Hu7DWUJLVmHNCk9z15Q1q+3E=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=nVVXR2Tb7lvmnDZNUlidZpngiqZR4CNLliJLDConvRYYoDqnadBCZPXLNf1805pNx
         RK6FPJtemauKLHLNuHXbYmxvt9OuX2Vd4jwG7gdj1sZ1d5rkwqbiIaZag1z1dbdeVq
         qmG2tZy0IvOYduFlol1QkAV1I+DqlgSg4wZRlOtE=
Message-ID: <a6bdeef73f9271cca99585d3e855681cf6b6f589.camel@HansenPartnership.com>
Subject: Re: [PATCH v5 1/1] tpm: add sysfs exports for all banks of PCR
 registers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Greg KH <greg@kroah.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-api@vger.kernel.org
Date:   Wed, 13 Jan 2021 09:31:44 -0800
In-Reply-To: <X/6lyuhqQ8TSXOSa@kroah.com>
References: <20210113015958.6685-1-James.Bottomley@HansenPartnership.com>
         <20210113015958.6685-2-James.Bottomley@HansenPartnership.com>
         <X/6lyuhqQ8TSXOSa@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-01-13 at 08:48 +0100, Greg KH wrote:
> On Tue, Jan 12, 2021 at 05:59:58PM -0800, James Bottomley wrote:
> > Create sysfs per hash groups with 24 PCR files in them one group,
> > named pcr-<hash>, for each agile hash of the TPM.  The files are
> > plugged in to a PCR read function which is TPM version agnostic, so
> > this works also for TPM 1.2 but the hash is only sha1 in that case.
> > 
> > Note: the macros used to create the hashes emit spurious checkpatch
> > warnings.  Do not try to "fix" them as checkpatch recommends,
> > otherwise
> > they'll break.
> > 
> > Signed-off-by: James Bottomley <
> > James.Bottomley@HansenPartnership.com>
> > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > 
> > ---
> > 
> > v2: fix TPM 1.2 legacy links failure
> > v3: fix warn on and add note to tpm_algorithms
> > v4: reword commit and add tested-by
> > v5: algorithm spelling fix WARN->dev_err
> > ---
> >  drivers/char/tpm/tpm-sysfs.c | 179
> > +++++++++++++++++++++++++++++++++++
> >  include/linux/tpm.h          |   9 +-
> >  2 files changed, 187 insertions(+), 1 deletion(-)
> 
> You add new sysfs files, but do not add Documentation/ABI/ entries
> showing how they are used and what they contain :(
> 
> Please do that for the next version of this patch.

It's a bit of a chicken and egg problem since I've no idea when this
will go upstream and the entries require that information making the
ABI more of a post accept type thing.  I can make a guess about the
values if Jarkko is going to but this in for the next merge window.

James

---8>8>8><8<8<8---

From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [PATCH] ABI: add sysfs description for tpm exports of PCR registers

Adds the ABI entries for the new

/sys/class/tpm/tpm<n>/pcr-<hash>/<m>

files which are added to export the PCR hash values on a one value per
file basis.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 Documentation/ABI/stable/sysfs-class-tpm | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-class-tpm b/Documentation/ABI/stable/sysfs-class-tpm
index 91ca63ec7581..d897ecb9615f 100644
--- a/Documentation/ABI/stable/sysfs-class-tpm
+++ b/Documentation/ABI/stable/sysfs-class-tpm
@@ -194,3 +194,17 @@ Description:	The "tpm_version_major" property shows the TCG spec major version
 		Example output::
 
 		  2
+
+What:		/sys/class/tpm/tpmX/pcr-H/N
+Date:		March 2021
+KernelVersion:	5.12
+Contact:	linux-integrity@vger.kernel.org
+Description:	produces output in compact hex representation for PCR
+		number N from hash bank H.  N is the numeric value of
+		the PCR number and H is the crypto string
+		representation of the hash
+
+		Example output::
+
+		  cat /sys/class/tpm/tpm0/pcr-sha256/7
+		  2ED93F199692DC6788EFA6A1FE74514AB9760B2A6CEEAEF6C808C13E4ABB0D42



