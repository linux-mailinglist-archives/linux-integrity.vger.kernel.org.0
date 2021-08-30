Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5B33FBD1D
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Aug 2021 21:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbhH3TrA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Aug 2021 15:47:00 -0400
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21184 "EHLO
        sender4-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbhH3Tq7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Aug 2021 15:46:59 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1630352726; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=SVHn6COC9v9vBFsLvcEs7dr3HVFNBJTVzni/EkloLN6O5viMtWWj6Tae7tY5LSqMayUip2OwmXpCPBeh8StLC0HSKfA9v4RBf402L+FXbCgqzb5ek2Un8zrhO+eAzSdMcdeXOPemJw94j/P5VzzmH5Uxa160b31YrttEytI+YkI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1630352726; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=yNOkI2F3ECfnM1Ds3LEUzcVyW9YJrCDLxnfkHPWP5Bw=; 
        b=Y4riUrabFYj0b6DV/fDwG8D+TJWGMsTa2KkKjietvIYTinnwsrV9GAJCRxqzHnrmQAfcRZ2FuLSkwDrCU/p37bvCCMZQ4oncVTMXIuTKzyxU8utaz2SI3v/9ouNKMtirvFnmwm6ENL21lsSYR9FooIsZmb4ozkS3rKyJVnLmB00=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1630352726;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=To:Cc:References:From:Subject:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=yNOkI2F3ECfnM1Ds3LEUzcVyW9YJrCDLxnfkHPWP5Bw=;
        b=mwtop516etIwYk691Qmw9i4ypq0dGhP3x9W2DH2WOOO16HN/YY4Zwhq7sMNSBvs4
        vnNIH2ifuPaAIHNh7/eGtqkGwtt9XfOnfk6d8PK8+GyyoihJP6oOV/oYS8uAh/GP0zK
        75uDRW9iUfKSH0ext6bgxXovU0LJOZdpXPaQsB6U=
Received: from [10.10.1.24] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
        with SMTPS id 1630352723773366.9884523607444; Mon, 30 Aug 2021 12:45:23 -0700 (PDT)
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
References: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
 <1630070917-9896-15-git-send-email-ross.philipson@oracle.com>
 <20210827133011.GJ1200268@ziepe.ca>
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
Subject: Re: [PATCH v4 14/14] tpm: Allow locality 2 to be set when
 initializing the TPM for Secure Launch
Message-ID: <e40a22d6-22f3-3374-01dc-75f14f310c7d@apertussolutions.com>
Date:   Mon, 30 Aug 2021 15:45:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210827133011.GJ1200268@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/27/21 9:30 AM, Jason Gunthorpe wrote:
> On Fri, Aug 27, 2021 at 09:28:37AM -0400, Ross Philipson wrote:
>> The Secure Launch MLE environment uses PCRs that are only accessible from
>> the DRTM locality 2. By default the TPM drivers always initialize the
>> locality to 0. When a Secure Launch is in progress, initialize the
>> locality to 2.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
>>  drivers/char/tpm/tpm-chip.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> Global state like this seems quite dangerous, shouldn't the locality
> be selected based on the PCR being accessed, or passed down from
> higher up in the call chain?
> 
> Jason
> 

Hey Jason,

While locality does control which PCRs are accessible, it is meant to
reflect what component that a TPM command is originating. To quote the
TCG Spec, "“Locality” is an assertion to the TPM that a command’s source
is associated with a particular component. Locality can be thought of as
a hardware-based authorization."

Thus when the SRTM chain, to include the Static OS, is in control, the
hardware is required to restrict access to only Locality 0. Once a
Dynamic Launch has occurred, the hardware grants access to Locality 1
and 2. Again to refer to the TCG spec, the definition of Locality 2 is,
the "Dynamically Launched OS (Dynamic OS) “runtime” environment".

When Linux is started from the SRTM, it is correct for the TPM driver to
set the locality to Locality 0 to denote that the source is the Static
OS. Now when Linux is started from the DRTM, the TPM driver should set
the locality to Locality 2 to denote that it is the "runtime" Dynamic
OS. As for the differences in access, with Locality 0 Linux (being the
Static OS) is restricted to the Static PCRs (0-15), the Debug PCR (16),
and the Application PCR (23). Whereas with Locality 2 Linux now being
the Dynamic OS will have access to all PCRs.

To summarize, TPM locality really is a global state that reflects the
component in control of the platform. Considering the definition of
locality, setting the locality to Locality 0 is saying that the Static
Environment is now in control. Doing so after the Dynamic Environment
has started would be an inaccurate setting of the platform state. The
correct time at which the locality should change back to Locality 0 is
after the Dynamic Environment has been exited. On Intel this can be done
by invoking the instruction GETSEC[SEXIT]. It should be noted that
Secure Launch adds the call to the GETSEC[SEXIT] instruction in the
kexec, reboot, and shutdown paths.

v/r,
dps
