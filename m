Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018302FC629
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Jan 2021 01:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbhATAxz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 19 Jan 2021 19:53:55 -0500
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21123 "EHLO
        sender4-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730094AbhATAxx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Jan 2021 19:53:53 -0500
X-Greylist: delayed 1120 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jan 2021 19:53:52 EST
ARC-Seal: i=1; a=rsa-sha256; t=1611102836; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=bvfuEVpT4XhGIRZ7H3qUEKRtb4ThDEDdXfu0fGNznNoBq6hR3zJmUh1tILm8GWsl8Ncxbw2QP3QKCJ4GG3oQY1SWipvLA6G4ubbe6sep+36uX0KcX2vOvsF3CbK+ouvcFBMTujldMqYtnx8UNPsBWJ817z2Qnxaem7kN1GLaLIU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1611102836; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Gy6cxAGpQV06imIwuB7h3MwRSZjSFn29L4jucGrojIM=; 
        b=XQhTC1LH6c79yVxqK8zC2C5CgP2MuAgUhz6d0ZmZ+dBHrUTvn8RfVbISO2NGH+Oe9IP0kiK4OUmFf2nrsyPWpbJyM4+ZNncEB18ELEw6q2VPLXEGEwx5YPHb2OiK/TuG5+k6upE0999/PUUMxVFwNoCTO0xJb7Jwd+WgRK/n0TU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com> header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1611102836;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=Gy6cxAGpQV06imIwuB7h3MwRSZjSFn29L4jucGrojIM=;
        b=M18bUZgt44glWZutDwWxXMoUKnlHR3szHDABEv1f06QiOrszMJbrC5eSxYaGjY71
        N8wIIuJa243I9uWPqrYABy00MzADpYLPbVCBvfKdP9qfllPFibUM97Y3F9/ROsszVSX
        getsmT810S+BbVsH7VgnSy8+vUtsHKg1nbnvB2AE=
Received: from [10.10.1.24] (c-73-129-147-140.hsd1.md.comcast.net [73.129.147.140]) by mx.zohomail.com
        with SMTPS id 1611102834623926.0489869436618; Tue, 19 Jan 2021 16:33:54 -0800 (PST)
Subject: Re: [PATCH 05/13] x86: Add early TPM1.2/TPM2.0 interface support for
 Secure Launch
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        trenchboot-devel@googlegroups.com
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
 <1600959521-24158-6-git-send-email-ross.philipson@oracle.com>
 <20200925054313.GB165011@linux.intel.com>
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
Message-ID: <933d9f3e-a509-bff4-54fe-20af44dc3ed0@apertussolutions.com>
Date:   Tue, 19 Jan 2021 19:33:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20200925054313.GB165011@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 9/25/20 1:43 AM, Jarkko Sakkinen wrote:
> On Thu, Sep 24, 2020 at 10:58:33AM -0400, Ross Philipson wrote:
>> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>>
>> This commit introduces an abstraction for TPM1.2 and TPM2.0 devices
>> above the TPM hardware interface.
>>
>> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> 
> This is way, way too PoC. I wonder why there is no RFC tag.
> 
> Please also read section 2 of
> 
> https://www.kernel.org/doc/html/v5.8/process/submitting-patches.html
> 
> You should leverage existing TPM code in a way or another. Refine it so
> that it scales for your purpose and then compile it into your thing
> (just include the necesary C-files with relative paths).
> 
> How it is now is never going to fly.
> 
> /Jarkko
> 

After attempts to engage in finding alternative approaches, it appears
that the only welcomed approach for sending measurements from the
compressed kernel would be a major rewrite of the mainline TPM driver to:

1. Abstract out the mainline kernel infrastructure that is used by the
driver

2. Find ways to introduce a minimal amount of the equivalent
infrastructure into the compressed kernel, to make the driver code
reusable within the compressed kernel.

This approach would exceed the scope of changes we want to introduce to
non-SecureLaunch code to enable direct DRTM launch for the Linux kernel.

After careful consideration and discussions with colleagues from the
trusted computing community, an alternative has been crafted. We aim to
submit a version 2 with the following approach:

1. SecureLaunch will take measurements in the compressed kernel as we do
in version 1, but instead of immediately sending them to the TPM, they
will be stored in the DRTM TPM event log.

2. When the SecureLaunch module in the mainline kernel comes on line, it
can send measurements to the TPM using the mainline TPM driver.

While it would be ideal to record measurements at the time they are
taken, the mainline kernel is measured alongside the compressed kernel
as a single measurement. This means the same measured entity stays in
control, prior to execution by any other entity within the system.

At a later date, if the TPM maintainers refactor the TPM driver for
reuse within the compressed kernel, then the sending of measurements can
be revisited.

For individuals and distributions that may prefer to record DRTM
measurements earlier, the TrenchBoot project will do its best to
maintain an external patch to provide that capability to a mainline LTS
kernel.

V/r,
Daniel P. Smith
